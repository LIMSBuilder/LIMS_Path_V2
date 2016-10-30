package com.contact.controller.constract;

import com.contact.model.Monitor_Frequency;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

import java.util.*;

/**
 * Created by qulongjun on 2016/10/28.
 */
public class MonitorFrequencyController extends Controller {

    /**
     * 列表展示
     */
    public void list() {
        int rowCount = getParaToInt("rowCount");
        int currentPage = getParaToInt("currentPage");
        String condition_temp = getPara("condition");
        Map condition = ParaUtils.getSplitCondition(condition_temp);
        if (rowCount == 0) {
            rowCount = ParaUtils.getRowCount();
        }
        String paras = "";
        Object[] keys = condition.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            if (i == 0) {
                paras += " WHERE ";
            }
            String key = (String) keys[i];
            Object value = condition.get(key);
            if (i != keys.length - 1) {
                paras += (key + " like \"%" + value + "%\" AND ");
            } else {
                paras += (key + " like \"%" + value + "%\"");
            }

        }
        Page<Monitor_Frequency> monitor_frequencyPage = Monitor_Frequency.monitor_frequencyDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_monitorFrequency`" + paras);
        List<Monitor_Frequency> monitor_frequencyList = monitor_frequencyPage.getList();
        Map results = toJson(monitor_frequencyList);
        results.put("currentPage", currentPage);
        results.put("totalPage", monitor_frequencyPage.getTotalPage());
        results.put("rowCount", rowCount);
        results.put("condition", condition_temp);
        renderJson(results);
    }


    /**
     * 将查询结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toJson(List<Monitor_Frequency> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Monitor_Frequency monitor_frequency : entityList) {
            Map<String, Object> frequencyList = new HashMap<>();
            frequencyList.put("id", monitor_frequency.getInt("id"));
            frequencyList.put("name", monitor_frequency.get("name"));
            results.add(frequencyList);
        }
        json.put("results", results);
        return json;
    }


    public void add() {
        try {
            String name = getPara("name");
            if (name != null) {
                if (Monitor_Frequency.monitor_frequencyDao.find("SELECT * FROM `db_monitorFrequency` WHERE name='" + name + "'").size() != 0) {
                    renderJson(RenderUtils.CODE_REPEAT);
                    return;
                }
                Boolean result = new Monitor_Frequency().set("name", name).save();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    public void change() {
        try {
            int id = getParaToInt("id");
            String name = getPara("name");
            if (id != 0 && name != null) {
                if (Monitor_Frequency.monitor_frequencyDao.find("SELECT * FROM `db_monitorFrequency` WHERE name='" + name + "'").size() != 0) {
                    renderJson(RenderUtils.CODE_REPEAT);
                    return;
                }
                Boolean result = Monitor_Frequency.monitor_frequencyDao.findById(id).set("name", name).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    public void delete() {
        try {
            int id = getParaToInt("id");
            if (id != 0) {
                Boolean result = Monitor_Frequency.monitor_frequencyDao.deleteById(id);
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void deleteAll() {
        Integer[] selected = getParaValuesToInt("selected[]");
        Boolean flag = true;
        List<Monitor_Frequency> errorRun = new LinkedList<>();
        for (int i = 0; i < selected.length; i++) {
            int id = selected[i];
            Boolean result = Monitor_Frequency.monitor_frequencyDao.deleteById(id);
            if (!result) {
                flag = false;
                //客户删除失败
                errorRun.add(Monitor_Frequency.monitor_frequencyDao.findById(id));
            }
        }
        if (!flag) {
            Map results = toJson(errorRun);
            results.put("code", "502");
            renderJson(results);
        } else {
            //删除成功
            renderJson(RenderUtils.CODE_SUCCESS);
        }
    }
}
