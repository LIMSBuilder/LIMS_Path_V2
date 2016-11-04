package com.contact.controller.system;

import com.contact.model.Department;
import com.contact.model.Role;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.kit.Prop;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Page;

import java.util.*;

/**
 * 部门管理COntroller
 */
public class DepartmentController extends Controller {

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
        String paras = "WHERE state in (0,1) ";
        Object[] keys = condition.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            String key = (String) keys[i];
            Object value = condition.get(key);
            paras += ("AND " + key + " like \"%" + value + "%\"");
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

    /**
     * 为单独的Department实体生成JSON
     *
     * @param department
     * @return
     */
    public static Map toJsonSingle(Department department) {
        Map<String, Object> depart = new HashMap<>();
        depart.put("id", department.getInt("id"));
        depart.put("name", department.get("name"));
        depart.put("state", department.getInt("state"));
        return depart;
    }

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
    }

    /**
     * 改变部门的状态信息
     * 0-正常
     * 1-禁用
     * 2-删除
     */
    public void changeStateAll() {
        Integer[] selected = getParaValuesToInt("selected[]");
        int type = getParaToInt("type");
        Boolean flag = true;
        List<Department> errorRun = new LinkedList<>();
        for (int i = 0; i < selected.length; i++) {
            int id = selected[i];
            Boolean result = Department.departmentDao.findById(id).set("state", type).update();
            //System.out.println(result);
            if (!result) {
                flag = false;
                //部门启用失败
                errorRun.add(Department.departmentDao.findById(id));
            }
        }
        if (!flag) {
            //启用失败返回错误信息
            Map results = toJson(errorRun);
            results.put("code", "502");
            renderJson(results);
        } else {
            //启用成功
            renderJson(RenderUtils.CODE_SUCCESS);
        }
    }

    /**
     * 改变部门的状态信息
     * 0-正常
     * 1-禁用
     * 2-删除
     */
    public void chagneState() {
        int id = getParaToInt("id");
        int type = getParaToInt("type");
        if (id != 0) {
            Department department = Department.departmentDao.findById(id);
            if (department != null) {
                Boolean result = department.set("state", type).update();
                if (result)
                    renderJson(RenderUtils.CODE_SUCCESS);
                else
                    renderJson(RenderUtils.CODE_ERROR);
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } else {
            renderError(500);
        }
    }

    /**
     * 改变部门信息
     */
    public void change() {
        int id = getParaToInt("id");
        String name = getPara("name");
        if (id != 0 && name != null) {
            if (Department.departmentDao.find("SELECT * FROM `db_department` WHERE name='" + name + "'").size() != 0) {
                renderJson(RenderUtils.CODE_REPEAT);
                return;
            }
            Department department = Department.departmentDao.findById(id);
            if (department == null) {
                //根据id找不到对象
                renderJson(RenderUtils.CODE_EMPTY);
            } else {
                //找到对象
                Boolean result = department.set("name", name).update();
                if (result)
                    renderJson(RenderUtils.CODE_SUCCESS);
                else
                    renderJson(RenderUtils.CODE_ERROR);
            }
        } else {
            renderError(500);
        }

    }


    /**
     * 分页
     *
     * @param pageCount
     * @param rowCount
     * @param statement
     * @return
     */
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


    public void getList() {
        List<Department> departmentList = Department.departmentDao.find("SELECT * FROM `db_department` WHERE state=0");
        renderJson(toJson(departmentList));
    }
}
