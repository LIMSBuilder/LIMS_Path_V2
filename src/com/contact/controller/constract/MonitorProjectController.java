package com.contact.controller.constract;

import com.contact.model.Monitor_Project;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

import java.util.*;

/**
 * Created by qulongjun on 2016/10/28.
 */
public class MonitorProjectController extends Controller {
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
        String paras = "WHERE state=0 ";
        Object[] keys = condition.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            String key = (String) keys[i];
            Object value = condition.get(key);
            paras += (" AND " + key + " like \"%" + value + "%\"");
        }
        Page<Monitor_Project> monitorProjectPage = Monitor_Project.monitor_projectDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_monitorProject`" + paras);
        List<Monitor_Project> monitorProjectList = monitorProjectPage.getList();
        Map results = toJson(monitorProjectList);
        results.put("currentPage", currentPage);
        results.put("totalPage", monitorProjectPage.getTotalPage());
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
    public Map toJson(List<Monitor_Project> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Monitor_Project monitor_project : entityList) {
            Map<String, Object> projectList = new HashMap<>();
            projectList.put("id", monitor_project.getInt("id"));
            projectList.put("name", monitor_project.get("name"));
            projectList.put("desp", monitor_project.get("desp"));
            projectList.put("category", monitor_project.getCategory());
            results.add(projectList);
        }
        json.put("results", results);
        return json;
    }


    public void add() {
        try {
            String name = getPara("name");
            int category_id = getParaToInt("category");
            if (name != null) {
                if (Monitor_Project.monitor_projectDao.find("SELECT * FROM `db_monitorProject` WHERE state=0 AND name='" + name + "' AND category_id = " + category_id).size() != 0) {
                    renderJson(RenderUtils.CODE_REPEAT);
                    return;
                }
                Boolean result = new Monitor_Project()
                        .set("name", name)
                        .set("desp", getPara("desp"))
                        .set("category_id", category_id)
                        .set("state", 0)
                        .save();
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
            int category_id = getParaToInt("category");
            if (id != 0 && name != null) {
                if (Monitor_Project.monitor_projectDao.find("SELECT * FROM `db_monitorProject` WHERE state=0 AND name='" + name + "' AND category_id = " + category_id + " AND desp ='" + getPara("desp") + "'").size() != 0) {
                    renderJson(RenderUtils.CODE_REPEAT);
                    return;
                }
                Boolean result = Monitor_Project.monitor_projectDao.findById(id).set("name", name).set("desp", getPara("desp")).set("category_id", category_id).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    public void changeState() {
        try {
            int id = getParaToInt("id");
            if (id != 0) {
                Boolean result = Monitor_Project.monitor_projectDao.findById(id).set("state", 1).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void changeStateAll() {
        Integer[] selected = getParaValuesToInt("selected[]");
        Boolean flag = true;
        List<Monitor_Project> errorRun = new LinkedList<>();
        for (int i = 0; i < selected.length; i++) {
            int id = selected[i];
            Boolean result = Monitor_Project.monitor_projectDao.findById(id).set("state", 1).update();
            if (!result) {
                flag = false;
                errorRun.add(Monitor_Project.monitor_projectDao.findById(id));
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
