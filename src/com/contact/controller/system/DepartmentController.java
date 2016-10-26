package com.contact.controller.system;

import com.contact.controller.interfaces.BaseController;
import com.contact.model.Department;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.JsonKit;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Page;

import java.util.*;

/**
 * Created by qulongjun on 2016/10/18.
 */
public class DepartmentController extends Controller implements BaseController {

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
                paras = " WHERE ";
            }
            String key = (String) keys[i];
            Object value = condition.get(key);
            if (i != keys.length - 1) {
                paras += (key + " like \"%" + value + "%\" AND ");
            } else {
                paras += (key + " like \"%" + value + "%\"");
            }
        }
        Page<Department> departmentPage = Department.departmentDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_department`" + paras);
        List<Department> departmentList = departmentPage.getList();
        Map results = toJson(departmentList);
        results.put("currentPage", currentPage);
        results.put("totalPage", departmentPage.getTotalPage());
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
    public Map toJson(List<Department> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Department department : entityList) {
            Map<String, Object> depart = new HashMap<>();
            depart.put("id", department.getInt("id"));
            depart.put("name", department.get("name"));
            depart.put("state", department.getInt("state"));
            results.add(depart);
        }
        json.put("results", results);
        return json;
    }

    @Override
    public void add() {
        String name = getPara("name");
        if (name != null) {
            if (Department.departmentDao.find("SELECT * FROM `db_department` WHERE name='" + name + "'").size() != 0) {
                renderJson(RenderUtils.CODE_REPEAT);
                return;
            }
            Boolean result = new Department().set("name", name).set("state", 1).save();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } else {
            renderError(500);
        }

//        if (name == null || name.equals("")) {
//            renderJson(RenderUtils.CODE_NOTEMPTY);
//            return;
//        }

    }

    @Override
    public void delete() {

    }

    @Override
    public void search() {

    }


    public static Page page(int pageCount, int rowCount, String statement) {
        if (pageCount == 0) pageCount = 1;
        if (rowCount == 0) {
            Prop setting = PropKit.use("setting.properties");
            rowCount = setting.getInt("rowCount");
        }
        if (statement.equals(""))
            statement = " FROM `db_department` ";
        Page<Department> departmentPage = Department.departmentDao.paginate(pageCount, rowCount, "SELECT *", " FROM `db_department`");
        return departmentPage;
    }
}
