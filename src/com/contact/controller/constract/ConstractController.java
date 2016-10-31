package com.contact.controller.constract;

import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import net.sf.json.JSON;
import net.sf.json.JSONObject;


import java.util.*;

/**
 * 合同
 */
public class ConstractController extends Controller {


    public void monitorType() {
        Prop p = PropKit.use("monitorPlan.properties");
        Map prop = p.getProperties();
        renderJson(prop);
    }

    public void identify() {
        Map idMap = new HashMap();
        idMap.put("identify", "2016-0001");
        renderJson(idMap);
    }

    public void freeIdentify() {
        String identify = getPara("identify");
        System.out.println(identify);
        renderJson(RenderUtils.CODE_SUCCESS);
    }

    public void add() {
        Map result = getParaMap();
        String[] direct = {
                "identify",
                "client_unit",
                "client_code",
                "client_address",
                "client_tel",
                "client",
                "client_fax",
                "trustee_unit",
                "trustee_code",
                "trustee_address",
                "trustee_tel",
                "trustee",
                "trustee_fax",
                "project_name",
                "monitor_aim",
                "monitor_type",
                "monitor_way",
                "monitor_way_desp",
                "subpackage",
                "subpackage_project",
                "in_room",
                "keep_secret",
                "payment_way",
                "finish_date",
                "payment_count",
                "other"
        };
        List<String> directList = new ArrayList<String>();
        String[] a = getParaValues("item_arr[]");
        List items = ConstractController.parseItem(a);
        Object ab = getPara("item_arr");
        Collections.addAll(directList, direct);
        for (Object key : result.keySet()) {
            if (directList.indexOf(key) != -1) {
                String value = ((String[]) result.get(key))[0];
            }
        }
        renderJson(RenderUtils.CODE_SUCCESS);
    }


    private static List parseItem(String[] array) {
        List results = new ArrayList();
        for (int i = 0; i < array.length; i++) {
            Map temp = new HashMap();
            String json = array[i];
            json = json.replace("{", "").replace("}", "");
            String[] params = json.split(",");
            for (int m = 0; m < params.length; m++) {
                String[] kv = params[m].split(":");
                String key = kv[0].replaceAll("\"", "");
                String value = kv[1].replaceAll("\"", "");
                temp.put(key, value);
            }
        }
        return results;
    }
}
