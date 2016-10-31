package com.contact.controller.constract;

import com.contact.model.Contract;
import com.contact.model.Identify;
import com.contact.model.Item_Project;
import com.contact.model.MonitorItem;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;


import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 合同
 * state
 * 0-合同正常创建完成并进入项目流中
 */
public class ContractController extends Controller {
    //所有可以直接插入的元素
    final String[] direct = {"identify", "client_unit", "client_code", "client_address", "client_tel",
            "client", "client_fax", "trustee_unit", "trustee_code", "trustee_address", "trustee_tel",
            "trustee", "trustee_fax", "project_name", "monitor_aim", "monitor_type", "monitor_way",
            "monitor_way_desp", "subpackage", "subpackage_project", "in_room", "keep_secret",
            "payment_way", "finish_date", "payment_count", "other"};

    /**
     * 获取所有监测类别
     */
    public void monitorType() {
        Prop p = PropKit.use("monitorPlan.properties");
        Map prop = p.getProperties();
        renderJson(prop);
    }

    /**
     * 获取合同编号
     * 1.先从已释放库中查找是否存在
     * 2.如果已释放库中已经空了,则使用全新的编号
     */
    public void identify() {
        Prop p = PropKit.use("identify.properties");
        String identify_model = p.get("contact_identify");//获取编号规则
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat(identify_model);
        String identify_value = sdf.format(now);
        String zero = identify_value.split("-")[1];
        int id_num = Identify.identifyDao.getContractId();
        Boolean result = Identify.identifyDao.setContractId(id_num);//新编号写入数据库
        DecimalFormat df = new DecimalFormat(zero);//格式化合同编号字符串
        String id = df.format(id_num);
        String identify = identify_value + "-" + id;
        Map idMap = new HashMap();
        idMap.put("identify", identify);
        renderJson(result ? idMap : RenderUtils.CODE_ERROR);
    }

    /**
     * 释放合同编号
     */
    public void freeIdentify() {
        String identify = getPara("identify");
        System.out.println(identify);
        renderJson(RenderUtils.CODE_SUCCESS);
    }

    /**
     * 新增合同
     */
    public void add() {
        try {
            //首先,进行合同编号存在性验证
            String identify = getPara("identify");
            if (Contract.contractDao.find("SELECT * FROM `db_contract` WHERE state=0 AND identify='" + identify + "'").size() != 0) {
                renderJson(RenderUtils.CODE_REPEAT);
                return;
            }
            Boolean saveResult = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    Map result = getParaMap();
                    Contract constract = new Contract();
                    List<String> directList = new ArrayList<String>();
                    Collections.addAll(directList, direct);
                    for (Object key : result.keySet()) {
                        if (directList.indexOf(key) != -1) {
                            String value = ((String[]) result.get(key))[0];
                            constract.set(key.toString(), value);
                        }
                    }
                    constract.set("state", 0);
                    String[] a = getParaValues("item_arr[]");
                    List<Map> items = ContractController.parseItem(a);//所有合同检测项
                    Boolean contract_result = constract.save();
                    Boolean item_result = true;
                    Boolean item_project_result = true;
                    for (int i = 0; i < items.size(); i++) {
                        Map temp = items.get(i);
                        MonitorItem monitorItem = new MonitorItem();
                        item_result = monitorItem
                                .set("contract_id", constract.get("id"))
                                .set("category_id", temp.get("category_id"))
                                .set("frequency", temp.get("frequency"))
                                .set("monitor_point", temp.get("monitor_point"))
                                .set("other", temp.get("other"))
                                .save();
                        if (!item_result) break;
                        int item_id = monitorItem.getInt("id");
                        String[] ids = temp.get("project_id").toString().split(";");
                        for (String idStr : ids) {
                            int id = Integer.parseInt(idStr);
                            item_project_result = new Item_Project()
                                    .set("item_id", item_id)
                                    .set("project_id", id)
                                    .save();
                            if (!item_project_result) break;
                        }
                        if (!item_project_result) break;
                    }
                    return item_result && contract_result && item_project_result;
                }
            });
            renderJson(saveResult ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 解析item字符串
     *
     * @param array
     * @return
     */
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
            results.add(temp);
        }
        return results;
    }
}
