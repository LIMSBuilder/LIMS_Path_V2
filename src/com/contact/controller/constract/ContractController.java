package com.contact.controller.constract;

import com.contact.model.*;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.render.Render;
import com.sun.org.apache.xpath.internal.operations.Bool;


import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 合同
 * state
 * 0-合同正常创建完成并进入项目流中,待审核
 * 1-合同审核通过,待进入任务书环节
 * 2-任务书创建完成
 * -1 -合同模板
 * -2中止合同
 * -3删除合同
 * -4合同审核拒绝
 */
public class ContractController extends Controller {
    //所有可以直接插入的元素
    final String[] direct = {"identify", "client_unit", "client_code", "client_address", "client_tel",
            "client", "client_fax", "trustee_unit", "trustee_code", "trustee_address", "trustee_tel",
            "trustee", "trustee_fax", "project_name", "monitor_aim", "monitor_type", "monitor_way",
            "monitor_way_desp", "subpackage", "subpackage_project", "in_room", "keep_secret",
            "payment_way", "payment_count", "other", "state"};
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    SimpleDateFormat format_date = new SimpleDateFormat("MM/dd/yyyy");
    SimpleDateFormat new_format_date = new SimpleDateFormat("yyyy-MM-dd");

    public void list() {
        try {
            int rowCount = getParaToInt("rowCount");
            int currentPage = getParaToInt("currentPage");
            String condition_temp = getPara("condition");
            Map condition = ParaUtils.getSplitCondition(condition_temp);
            if (rowCount == 0) {
                rowCount = ParaUtils.getRowCount();
            }
            String paras = " WHERE state != -3";
            Object[] keys = condition.keySet().toArray();
            for (int i = 0; i < keys.length; i++) {
                String key = (String) keys[i];
                Object value = condition.get(key);
                if (key.equals("identify") || key.equals("project_name") || key.equals("client_unit")) {
                    paras += (" AND " + key + " like \"%" + value + "%\"");
                }
                if (key.equals("state")) {
                    paras += (" AND state=" + value);
                }
                if (key.equals("monitor_type_selected")) {
                    paras += (" AND monitor_type in ('" + value.toString().replace(",", "','") + "')");
                }
                if (key.equals("show_template")) {//显示模板
                    if (!value.equals("true")) {
                        paras += " AND state != -1";
                    }
                }
                //合同起草开始时间
                if (key.equals("search_createTime_start")) {
                    try {
                        Date date = format_date.parse(value.toString());
                        value = new_format_date.format(date);
                    } catch (Exception e) {
                        renderError(500);
                    }
                    paras += (" AND create_time >= '" + value + "'");
                }
                //合同起草结束时间
                if (key.equals("search_createTime_end")) {
                    try {
                        Date date = format_date.parse(value.toString());
                        value = new_format_date.format(date);
                    } catch (Exception e) {
                        renderError(500);
                    }
                    paras += (" AND create_time <= '" + value + "'");
                }
            }
            Page<Contract> contractPage = Contract.contractDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_contract`" + paras);
            List<Contract> contractList = contractPage.getList();
            Map results = toJson(contractList);
            results.put("currentPage", currentPage);
            results.put("totalPage", contractPage.getTotalPage());
            results.put("rowCount", rowCount);
            results.put("condition", condition_temp);
            results.put("totalRowCount", contractPage.getTotalRow());
            renderJson(results);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 将查询结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toJson(List<Contract> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Contract contract : entityList) {
            results.add(contract);
        }
        json.put("results", results);
        return json;
    }

    public Map toJsonSingle(Contract contract) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        results.add(contract);
        json.put("results", results);
        json.put("trustee", contract.getTrustee());
        json.put("items", contract.getMonitorItems());
        return json;
    }


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
        String pre = identify_value.split("-")[0];
        String zero = identify_value.split("-")[1];

        int id_num = Identify.identifyDao.getContractId();
        DecimalFormat df = new DecimalFormat(zero);//格式化合同编号字符串
        String id = df.format(id_num);
        String identify = pre + "-" + id;
        while (Contract.contractDao.find("SELECT * FROM `db_contract` WHERE identify='" + identify + "'").size() != 0) {
            //进行编号校验,如果编号已经存在了,则继续下行
            id_num++;
            id = df.format(id_num);
            identify = pre + "-" + id;
        }
        Boolean result = Identify.identifyDao.setContractId(id_num);//新编号写入数据库
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
            int state = getParaToInt("state");
            if (state == 0 && Contract.contractDao.find("SELECT * FROM `db_contract` WHERE identify='" + identify + "'").size() != 0) {
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
                        } else {
                            if (key.equals("finish_date")) {
                                String value = ((String[]) result.get(key))[0];
                                try {
                                    Date date = format_date.parse(value);
                                    constract.set("finish_date", new_format_date.format(date));
                                } catch (Exception e) {
                                    constract.set("finish_date", value);
                                }
                            }
                        }
                    }
                    constract.set("create_time", sdf.format(new Date()));//创建时间
                    Boolean contract_result = constract.save();
                    Boolean item_result = true;
                    Boolean item_project_result = true;
                    String[] a = getParaValues("item_arr[]");
                    if (a != null && a.length != 0) {
                        List<Map> items = ContractController.parseItem(a);//所有合同检测项
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
     * 获取合同模板列表
     */
    public void getTemplateList() {
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        String condition_temp = getPara("condition");
        Map condition = ParaUtils.getSplitCondition(condition_temp);
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        String paras = "WHERE state = -1";
        Object[] keys = condition.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            String key = (String) keys[i];
            Object value = condition.get(key);
            paras += (" AND " + key + " like \"%" + value + "%\"");
        }
        Page<Contract> contractPage = Contract.contractDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_contract`" + paras);
        List<Contract> contractList = contractPage.getList();
        Map results = toTemplateJson(contractList);
        results.put("currentPage", currentPage);
        results.put("totalPage", contractPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("condition", condition_temp);
        renderJson(results);
    }


    public void getTemplate() {
        try {
            int id = getParaToInt("id");
            Contract template = Contract.contractDao.findById(id);
            renderJson(template);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 合同审核
     */
    public void review() {
        try {
            int id = getParaToInt("id");
            int state = getParaToInt("state");
            Contract contract = Contract.contractDao.findById(id);
            if (contract != null) {
                contract.set("state", state);
                if (state == 0) {//若是审核拒绝,则reject_count++;
                    contract.set("reject_count", contract.getInt("reject_count") + 1);
                }
                Boolean result = contract.update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 将查询合同模板结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toTemplateJson(List<Contract> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Contract contract : entityList) {
            Map<String, Object> contractList = new HashMap<>();
            contractList.put("id", contract.getInt("id"));
            contractList.put("project_name", contract.get("project_name"));
            contractList.put("create_time", contract.get("create_time"));
            results.add(contractList);
        }
        json.put("results", results);
        return json;
    }


    public void getById() {
        try {
            int id = getParaToInt("id");
            Contract contract = Contract.contractDao.findById(id);
            renderJson(toJsonSingle(contract));
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


    /**
     * 中止合同
     */
    public void stop() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int id = getParaToInt("id");
                    Contract contract = Contract.contractDao.findById(id);
                    Boolean result = true;
                    Boolean taskResult = true;
                    if (contract != null) {
                        result = contract.set("state", -2).update();
                        Task task = Task.taskDao.findFirst("SELECT * FROM `db_task` WHERE contract_id=" + contract.get("id"));
                        if (task != null) {
                            taskResult = task.set("state", -2).update();
                        }
                    }
                    return result && taskResult;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

}
