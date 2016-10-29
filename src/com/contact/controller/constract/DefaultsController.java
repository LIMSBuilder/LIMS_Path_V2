package com.contact.controller.constract;

import com.contact.model.Default;
import com.contact.utils.PropertiesUtlis;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;

import java.util.Hashtable;
import java.util.Map;

/**
 * 预设信息
 */
public class DefaultsController extends Controller {
    public void setDefault() {
        try {
//            Map props = getParaMap();
//            Hashtable tables = new Hashtable();
//            for (Object key : props.keySet()) {
//                String value = ((String[]) props.get(key))[0];
//                tables.put(key, value);
//            }
//            PropertiesUtlis.setValueAndStore("/defaults.properties", tables);




            renderJson(RenderUtils.CODE_SUCCESS);
        } catch (Exception e) {
            System.out.println(e);
            renderError(500);
        }
    }

    public void getDefault() {
        //Prop setting = PropKit.use("defaults.properties");
        //renderJson(setting);
        renderJson(Default.defaultDao.findFirst("SELECT * FROM `db_default`").getTrusteeInfo());
    }
}
