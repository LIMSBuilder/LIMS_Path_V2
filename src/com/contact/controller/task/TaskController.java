package com.contact.controller.task;


import com.contact.controller.common.FlowController;
import com.contact.controller.sample.SampleController;
import com.contact.model.*;
import com.contact.model.Properties;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Page;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 任务书
 * 0-任务书创建成功
 * <p/>
 * <p/>
 * <p/>
 * <p/>
 * 0-自送样
 * 1-现场采样
 */
public class TaskController extends Controller {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    SimpleDateFormat format_date = new SimpleDateFormat("MM/dd/yyyy");
    SimpleDateFormat new_format_date = new SimpleDateFormat("yyyy-MM-dd");

    public void list() {
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
                paras += (" AND state=" + ParaUtils.flows.get(value));
            }
            if (key.equals("search_createTime_start")) {
                try {
                    Date date = format_date.parse(value.toString());
                    value = new_format_date.format(date);
                } catch (Exception e) {
                    renderError(500);
                }
                paras += (" AND create_time >= '" + value + "'");
            }
            if (key.equals("sample_type")) {
                String[] ids = value.toString().split(",");
                String temp = "";
                for (int k = 0; k < ids.length; k++) {
                    int id = Integer.parseInt(ids[k]);
                    switch (id) {
                        case 0:
                            if (!temp.equals("")) temp = "0,1";
                            else temp = "0";
                            break;
                        case 1:
                            if (!temp.equals("")) temp = "0,1";
                            else temp = "1";
                            break;

                    }
                }
                paras += (" AND sample_type in (" + temp + ")");
            }
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
        Page<Task> taskPage = Task.taskDao.paginate(currentPage, rowCount, "SELECT * ", " FROM `db_task`" + paras);
        List<Task> taskList = taskPage.getList();
        Map results = toJson(taskList);
        results.put("currentPage", currentPage);
        results.put("totalPage", taskPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("condition", condition_temp);
        results.put("totalRowCount", taskPage.getTotalRow());
        renderJson(results);
    }


    public void taskDelvieryList() {
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
            if (key.equals("delivery_type")) {
                //查看实验分析相关的任务
                String temp = "";
                switch (Integer.parseInt(value.toString())) {
                    case 1:
                        //待我分析
                        temp = "EXISTS(SELECT `db_delivery`.* FROM `db_delivery`,`db_task` m  WHERE `db_delivery`.`task_id`=t.`id`  AND `db_delivery`.`analyst`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " )";
                        break;
                    case 2:
                        //待我审核
                        temp = "EXISTS(SELECT `db_delivery`.* FROM `db_delivery`,`db_task` m  WHERE `db_delivery`.`task_id`=t.`id`  AND `db_delivery`.`assessor`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " )";
                        break;
                    case 3:
                        //待我复核
                        temp = "EXISTS(SELECT `db_delivery`.* FROM `db_delivery`,`db_task` m  WHERE `db_delivery`.`task_id`=t.`id`  AND `db_delivery`.`checker`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " )";
                        break;
                    case 4:
                        //主任审核
                        temp = "EXISTS(SELECT `db_experience_first`.* FROM `db_experience_first`,`db_task` WHERE `db_experience_first`.`task_id`=t.`id` AND `db_experience_first`.`result_user`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + ")";
                        break;
                    case 5:
                        //质控审核
                        temp = "EXISTS(SELECT `db_experience_second`.* FROM `db_experience_second`,`db_task` WHERE `db_experience_second`.`task_id`=t.`id` AND `db_experience_second`.`result_user`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + ")";
                        break;
                }
                if (temp != "")
                    paras += (" AND " + temp);
            }
            if (key.equals("task_type")) {
                String temp = "";
                switch (Integer.parseInt(value.toString())) {
                    case 0:
                        //流程中
                        temp = "state >= " + Integer.parseInt(ParaUtils.flows.get("receive_delivery").toString());
                        break;
                    case 1:
                        //已结束
                        temp = "state = " + Integer.parseInt(ParaUtils.flows.get("finish_task").toString());
                        break;
                    case 2:
                        //已中止
                        temp = "state = " + Integer.parseInt(ParaUtils.flows.get("stop_task").toString());
                        break;
                }
                if (temp != "")
                    paras += (" AND " + temp);
            }
        }
        Page<Task> taskPage = Task.taskDao.paginate(currentPage, rowCount, "SELECT * ", " FROM `db_task` t" + paras);
        List<Task> taskList = taskPage.getList();
        Map results = toJson(taskList);
        results.put("currentPage", currentPage);
        results.put("totalPage", taskPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("condition", condition_temp);
        results.put("totalRowCount", taskPage.getTotalRow());
        renderJson(results);

    }

    /**
     * 获取在流程中的Task列表
     * role_type:角色类型:
     * distribute:任务下达者
     * analyst:分析者
     * assessor:审核者
     * checker:复核者
     */
    public void getProcessList() {
        String roleType = getPara("role_type");
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        String paras = "";
        if (roleType.equals("distribute")) {
            paras = "FROM `db_task` t WHERE state=" + ParaUtils.flows.get("task_dstribute");
        } else {
            paras = "FROM `db_task` t WHERE state=" + ParaUtils.flows.get("task_dstribute") + " AND  EXISTS(SELECT `db_delivery`.* FROM `db_delivery`,`db_task` m  WHERE `db_delivery`.`task_id`=t.`id` AND `db_delivery`.`" + roleType + "`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " )";
        }
        Page<Task> taskPage = Task.taskDao.paginate(currentPage, rowCount, "SELECT t.* ", paras);
        List<Task> taskList = taskPage.getList();
        Map results = toJson(taskList);
        results.put("currentPage", currentPage);
        results.put("totalPage", taskPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("totalRowCount", taskPage.getTotalRow());
        renderJson(results);
    }

    /**
     * 实验分析获取Task列表
     * 如果有需要当前用户进行实验分析的,则才显示当前用户
     */
    public void experienceList() {
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        String paras = "FROM `db_task` t WHERE state=" + ParaUtils.flows.get("task_dstribute") + " AND  EXISTS(SELECT `db_delivery`.* FROM `db_delivery`,`db_task` m  WHERE `db_delivery`.`task_id`=t.`id` AND `db_delivery`.state in (-3,0,1) AND `db_delivery`.`analyst`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " )";
        Page<Task> taskPage = Task.taskDao.paginate(currentPage, rowCount, "SELECT t.* ", paras);
        List<Task> taskList = taskPage.getList();
        Map results = toJson(taskList);
        results.put("currentPage", currentPage);
        results.put("totalPage", taskPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("totalRowCount", taskPage.getTotalRow());
        renderJson(results);
    }


    /**
     * 实验审核获取Task列表
     */
    public void assessList() {
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        String paras = "FROM `db_task` t WHERE state=" + ParaUtils.flows.get("task_dstribute") + " AND  EXISTS(SELECT `db_delivery`.* FROM `db_delivery`,`db_task` m  WHERE `db_delivery`.`task_id`=t.`id` AND `db_delivery`.state in (-1,2,3) AND `db_delivery`.`assessor`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " )";
        Page<Task> taskPage = Task.taskDao.paginate(currentPage, rowCount, "SELECT t.* ", paras);
        List<Task> taskList = taskPage.getList();
        Map results = toJson(taskList);
        results.put("currentPage", currentPage);
        results.put("totalPage", taskPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("totalRowCount", taskPage.getTotalRow());
        renderJson(results);
    }

    /**
     * 实验复核获取Task列表
     */
    public void reviewList() {
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        String paras = "FROM `db_task` t WHERE state=" + ParaUtils.flows.get("task_dstribute") + " AND  EXISTS(SELECT `db_delivery`.* FROM `db_delivery`,`db_task` m  WHERE `db_delivery`.`task_id`=t.`id` AND `db_delivery`.state in (-2,4,5) AND `db_delivery`.`checker`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " )";
        Page<Task> taskPage = Task.taskDao.paginate(currentPage, rowCount, "SELECT t.* ", paras);
        List<Task> taskList = taskPage.getList();
        Map results = toJson(taskList);
        results.put("currentPage", currentPage);
        results.put("totalPage", taskPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("totalRowCount", taskPage.getTotalRow());
        renderJson(results);
    }

    /**
     * 将查询结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toJson(List<Task> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Task task : entityList) {
            Map map = new HashMap();
            map.put("id", task.get("id"));
            map.put("identify", task.get("identify"));
            map.put("create_time", task.get("create_time"));
            map.put("project_name", task.get("project_name"));
            map.put("client_unit", task.get("client_unit"));
            map.put("state", task.get("state"));
            map.put("receive_deparment", Department.departmentDao.findById(task.get("receive_deparment")));
            results.add(map);
        }
        json.put("results", results);
        return json;
    }


    /**
     * 通过现有合同创建任务书
     */
    public void addByContract() {
        try {
            final Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int contract_id = getParaToInt("contract_id");
                    Boolean result = false;
                    Boolean update_result = false;
                    if (contract_id != 0) {
                        if (Task.taskDao.find("SELECT * FROM `db_task` WHERE state>=0 AND contract_id=" + contract_id).size() != 0) {
                            return false;
                        }
                        Task task = new Task();
                        Contract contract = Contract.contractDao.findById(contract_id);
                        task.set("contract_id", contract_id)
                                .set("receive_deparment", getParaToInt("receive_deparment"))
                                .set("other", getPara("other"))
                                .set("create_time", sdf.format(new Date()))
                                .set("create_user", ParaUtils.getCurrentUser(getRequest()).getInt("id"))
                                .set("state", 0)
                                .set("identify", contract.get("identify"))
                                .set("client_unit", contract.get("client_unit"))
                                .set("client_address", contract.get("client_address"))
                                .set("client_code", contract.get("client_code"))
                                .set("client_tel", contract.get("client_tel"))
                                .set("client", contract.get("client"))
                                .set("project_name", contract.get("project_name"))
                                .set("monitor_aim", contract.get("monitor_aim"))
                                .set("monitor_way", contract.get("monitor_way"))
                                .set("monitor_way_desp", contract.get("monitor_way_desp"))
                                .set("sample_type", getPara("sample_type"))
                                .set("monitor_type", contract.get("monitor_type"));
                        result = task.save();
                        update_result = contract.set("state", 2).update();//更新当前合同列表
                    }
                    return result && update_result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 自定义创建任务书
     */
    public void addBySelf() {
        String identify = getPara("identify");
        if (Task.taskDao.find("SELECT * FROM `db_task` WHERE identify='" + identify + "'").size() != 0) {
            renderJson(RenderUtils.CODE_REPEAT);
            return;
        }
        Boolean result = Db.tx(new IAtom() {
            @Override
            public boolean run() throws SQLException {
                Map paras = getParaMap();
                Task task = new Task();
                for (Object key : paras.keySet()) {
                    String value = ((String[]) paras.get(key))[0];
                    if (!key.equals("item_arr[]")) {
                        task.set(key.toString(), value);
                    }
                }
                task.set("create_time", sdf.format(new Date())).set("state", 0).set("create_user", ParaUtils.getCurrentUser(getRequest()).getInt("id")).set("sample_type", getPara("sample_type"));
                Boolean result = task.save();
                Boolean item_result = true;
                Boolean item_project_result = true;
                String[] a = getParaValues("item_arr[]");
                if (a != null && a.length != 0) {
                    List<Map> items = TaskController.parseItem(a);//所有合同检测项
                    for (int i = 0; i < items.size(); i++) {
                        Map temp = items.get(i);
                        MonitorItem monitorItem = new MonitorItem();
                        item_result = monitorItem
                                .set("task_id", task.get("id"))
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
                return result && item_result && item_project_result;
            }
        });
        renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
    }


    public void getById() {
        try {
            int id = getParaToInt("id");
            Task task = Task.taskDao.findById(id);
            if (task != null) {
                renderJson(toJsonSingle(task));
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    public Map toJsonSingle(Task task) {
        String[] keys = {"identify", "client_unit", "client_address", "client_code", "client_tel", "client", "project_name", "monitor_aim", "monitor_way", "monitor_way_desp", "sample_type"};
        Map result = new HashMap();
        if (task.get("contract_id") != null) {
            int id = task.getInt("contract_id");
            Contract contract = Contract.contractDao.findById(id);
            for (String key : keys) {
                result.put(key, contract.get(key));
                result.put("item_arr", contract.getMonitorItems());
            }
        } else {
            for (String key : keys) {
                result.put(key, task.get(key));
                result.put("item_arr", task.getMonitorItems());
            }
        }
        result.put("id", task.get("id"));
        result.put("receive_deparment", Department.departmentDao.findById(task.get("receive_deparment")));
        result.put("other", task.get("other"));
        result.put("state", task.get("state"));
        result.put("create_time", task.get("create_time"));
        result.put("create_user", User.userDao.findById(task.get("create_user")));
        result.put("create_time", task.get("create_time"));
        return result;
    }

    /**
     * 中止任务
     */
    public void stop() {
        try {
            int task_id = getParaToInt("id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                Boolean result = task.set("state", Integer.parseInt(ParaUtils.flows.get("stop_task").toString())).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {

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
     * 查看实验分析流程
     * 获取分配的各个人员 / 实验分析结果 / 实验审核/复核结果和次数 / 主任审核结果 / 质控审核结果
     */
    public void experienceView() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE task_id=" + task_id);
                renderJson(toDeliveryJson(deliveryList));
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    public static Map toDeliveryJson(List<Delivery> deliveryList) {
        Map result = new HashMap();
        List<Map> maps = new ArrayList();
        for (Delivery delivery : deliveryList) {
            Task task = Task.taskDao.findById(delivery.get("task_id"));
            Map temp = new HashMap();
            temp.put("id", delivery.get("id"));
            temp.put("project", Monitor_Project.monitor_projectDao.findById(delivery.get("project_id")));
            temp.put("character", delivery.get("character"));
            temp.put("storage", delivery.get("storage"));
            temp.put("analyst", User.userDao.findById(delivery.get("analyst")).getUserInfo());
            temp.put("assessor", User.userDao.findById(delivery.get("assessor")).getUserInfo());
            temp.put("checker", User.userDao.findById(delivery.get("checker")).getUserInfo());
            temp.put("analyst_time", delivery.get("analyst_time"));
            temp.put("assessor_time", delivery.get("assessor_time"));
            temp.put("checker_time", delivery.get("checker_time"));
            temp.put("state", delivery.get("state"));
            temp.put("inspection", delivery.get("inspection_path"));
            temp.put("originRecod", Delivery_OriginRecord.delivery_originRecordDao.find("SELECT * FROM `db_deliveryoriginrecord` WHERE `db_deliveryoriginrecord`.`delivery_id`=" + delivery.get("id")));

            temp.put("assessReject", SampleController.assessorRejectToJson(Delivery_Assess_Reject.deliveryAssessRejectDao.find("SELECT * FROM `db_deliveryAssessReject` WHERE `db_deliveryAssessReject`.`delivery_id`=" + delivery.get("id"))));
            temp.put("checkReject", SampleController.checkerRejectToJson(Delivery_Check_Reject.deliveryCheckRejectDao.find("SELECT * FROM `db_deliveryCheckReject` WHERE `db_deliveryCheckReject`.`delivery_id`=" + delivery.get("id"))));

            temp.put("currentMasterReview", Experience_FirstReview.experienceFirstReviewDao.findById(task.get("experience_firstReview_record")).getMoreInfo());
            temp.put("currentQualityReview", Experience_SecondReview.experienceSecondReviewDao.findById(task.get("experience_secondReview_record")).getMoreInfo());
            temp.put("masterReviewList", Experience_FirstReview.experienceFirstReviewDao.find("SELECT * FROM `db_experience_first` WHERE task_id=" + delivery.get("task_id")));
            temp.put("qualityReviewList", Experience_SecondReview.experienceSecondReviewDao.find("SELECT * FROM `db_experience_second` WHERE task_id=" + delivery.get("task_id")));
            maps.add(temp);
        }
        result.put("results", maps);
        return result;
    }
}
