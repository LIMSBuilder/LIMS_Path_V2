package com.contact.controller.task;

import com.contact.model.Contract;
import com.contact.model.Item_Project;
import com.contact.model.MonitorItem;
import com.contact.model.Task;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.sun.org.apache.xpath.internal.operations.Bool;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 任务书
 * 0-任务书创建成功
 */
public class TaskController extends Controller {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

    /**
     * 通过现有合同创建任务书
     */
    public void addByContract() {
        try {
            int contract_id = getParaToInt("contract_id");
            if (contract_id != 0) {
                if (Task.taskDao.find("SELECT * FROM `db_task` WHERE state>=0 AND contract_id=" + contract_id).size() != 0) {
                    renderJson(RenderUtils.CODE_REPEAT);
                    return;
                }
                Task task = new Task();
                Boolean result = task
                        .set("contract_id", contract_id)
                        .set("receive_deparment", getParaToInt("receive_deparment"))
                        .set("other", getPara("other"))
                        .set("create_time", sdf.format(new Date()))
                        .set("state", 0)
                        .save();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            }
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
                task.set("create_time", sdf.format(new Date())).set("state", 0);
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
