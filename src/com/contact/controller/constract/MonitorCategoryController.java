package com.contact.controller.constract;

import com.contact.model.Monitor_Category;
import com.contact.model.Monitor_Project;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

import java.util.*;

/**
 * Created by qulongjun on 2016/10/28.
 */
public class MonitorCategoryController extends Controller {
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
        String paras = " WHERE state = 0 ";
        Object[] keys = condition.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            String key = (String) keys[i];
            Object value = condition.get(key);
            paras += (" AND " + key + " like \"%" + value + "%\"");
        }
        Page<Monitor_Category> monitorCategoryPage = Monitor_Category.monitorCategoryDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_monitorCategory`" + paras);
        List<Monitor_Category> monitorCategoryList = monitorCategoryPage.getList();
        Map results = toJson(monitorCategoryList);
        results.put("currentPage", currentPage);
        results.put("totalPage", monitorCategoryPage.getTotalPage());
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
    public Map toJson(List<Monitor_Category> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Monitor_Category monitor_category : entityList) {
            Map<String, Object> categoryList = new HashMap<>();
            categoryList.put("id", monitor_category.getInt("id"));
            categoryList.put("name", monitor_category.get("name"));
            results.add(categoryList);
        }
        json.put("results", results);
        return json;
    }


    public void add() {
        try {
            String name = getPara("name");
            if (name != null) {
                if (Monitor_Category.monitorCategoryDao.find("SELECT * FROM `db_monitorCategory` WHERE state = 0 AND name='" + name + "'").size() != 0) {
                    renderJson(RenderUtils.CODE_REPEAT);
                    return;
                }
                Boolean result = new Monitor_Category().set("name", name).set("state", 0).save();
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
                if (Monitor_Category.monitorCategoryDao.find("SELECT * FROM `db_monitorCategory` WHERE state=0 AND name='" + name + "'").size() != 0) {
                    renderJson(RenderUtils.CODE_REPEAT);
                    return;
                }
                Boolean result = Monitor_Category.monitorCategoryDao.findById(id).set("name", name).update();
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
                Monitor_Category category = Monitor_Category.monitorCategoryDao.findById(id);
                Boolean result = category.set("state", 1).update();
                List<Monitor_Project> projectList = category.getProjects();
                for (Monitor_Project project : projectList) {
                    project.set("state", 1).update();
                }
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void deleteAll() {
        Integer[] selected = getParaValuesToInt("selected[]");
        Boolean flag = true;
        List<Monitor_Category> errorRun = new LinkedList<>();
        for (int i = 0; i < selected.length; i++) {
            int id = selected[i];
            Monitor_Category category = Monitor_Category.monitorCategoryDao.findById(id);
            Boolean result = category.set("state", 1).update();
            List<Monitor_Project> projectList = category.getProjects();
            for (Monitor_Project project : projectList) {
                project.set("state", 1).update();
            }
            if (!result) {
                flag = false;
                errorRun.add(Monitor_Category.monitorCategoryDao.findById(id));
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


    public void getList() {
        try {
            List<Monitor_Category> categories = Monitor_Category.monitorCategoryDao.find("SELECT * FROM `db_monitorCategory` WHERE state=0");
            renderJson(toJson(categories));
        } catch (Exception e) {
            renderError(500);
        }
    }
}
