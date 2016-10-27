package com.contact.controller.system;

import com.contact.model.Department;
import com.contact.model.Role;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;

import java.util.*;

/**
 * 角色
 */
public class RoleController extends Controller {
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
        String paras = "WHERE state = 0";
        Object[] keys = condition.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            String key = (String) keys[i];
            Object value = condition.get(key);
            paras += (" AND " + key + " like \"%" + value + "%\"");
        }
        Page<Role> rolePage = Role.roleDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_role`" + paras);
        List<Role> roleList = rolePage.getList();
        Map results = toJson(roleList);
        results.put("currentPage", currentPage);
        results.put("totalPage", rolePage.getTotalPage());
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
    public Map toJson(List<Role> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Role role : entityList) {
            Map<String, Object> roleList = new HashMap<>();
            roleList.put("id", role.getInt("id"));
            roleList.put("name", role.get("name"));
            roleList.put("department", DepartmentController.toJsonSingle(role.getDepartment()));
            results.add(roleList);
        }
        json.put("results", results);
        return json;
    }

    public void add() {
        int department_id = getParaToInt("department_id");
        String name = getPara("name");
        if (name != null && department_id != 0) {
            if (Role.roleDao.find("SELECT * FROM `db_role` WHERE name='" + name + "' AND department_id =" + department_id).size() != 0) {
                renderJson(RenderUtils.CODE_REPEAT);
                return;
            }
            Boolean result = new Role().set("name", name).set("department_id", department_id).save();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } else {
            renderError(500);
        }
    }

    /**
     * 改变岗位的状态信息
     * 0-正常
     * 1-删除
     */
    public void changeStateAll() {
        Integer[] selected = getParaValuesToInt("selected[]");
        int type = getParaToInt("type");
        Boolean flag = true;
        List<Role> errorRun = new LinkedList<>();
        for (int i = 0; i < selected.length; i++) {
            int id = selected[i];
            Boolean result = Role.roleDao.findById(id).set("state", type).update();
            if (!result) {
                flag = false;
                //部门启用失败
                errorRun.add(Role.roleDao.findById(id));
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
     * 1-删除
     */
    public void chagneState() {
        int id = getParaToInt("id");
        int type = getParaToInt("type");
        if (id != 0) {
            Role role = Role.roleDao.findById(id);
            if (role != null) {
                Boolean result = role.set("state", type).update();
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
     * 改变岗位信息
     */
    public void change() {
        int id = getParaToInt("id");
        String name = getPara("name");
        int department_id = getParaToInt("department_id");
        if (id != 0 && name != null && department_id != 0) {
            if (Role.roleDao.find("SELECT * FROM `db_role` WHERE name='" + name + "' AND department_id =" + department_id).size() != 0) {
                renderJson(RenderUtils.CODE_REPEAT);
                return;
            }
            Role role = Role.roleDao.findById(id);
            if (role == null) {
                //根据id找不到对象
                renderJson(RenderUtils.CODE_EMPTY);
            } else {
                //找到对象
                Boolean result = role.set("name", name).set("department_id", department_id).update();
                if (result)
                    renderJson(RenderUtils.CODE_SUCCESS);
                else
                    renderJson(RenderUtils.CODE_ERROR);
            }
        } else {
            renderError(500);
        }
    }

}
