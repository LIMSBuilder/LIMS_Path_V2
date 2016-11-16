package com.contact.controller.system;

import com.contact.model.Department;
import com.contact.model.User;
import com.contact.utils.MD5Tools;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.sun.org.apache.xpath.internal.operations.Bool;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by qulongjun on 2016/10/27.
 */
public class UserController extends Controller {

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
            paras += ("AND " + key + " like \"%" + value + "%\"");
        }
        Page<User> userPage = User.userDao.paginate(currentPage, rowCount, "SELECT *", " FROM `db_user`" + paras);
        List<User> userList = userPage.getList();
        Map results = toJson(userList);
        results.put("currentPage", currentPage);
        results.put("totalPage", userPage.getTotalPage());
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
    public Map toJson(List<User> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (User user : entityList) {
            Map<String, Object> userMap = new HashMap<>();
            userMap.put("id", user.getInt("id"));
            userMap.put("name", user.get("name"));
            userMap.put("username", user.get("username"));
            userMap.put("gender", user.get("gender"));
            userMap.put("idCard", user.get("idCard"));
            userMap.put("tel", user.get("tel"));
            userMap.put("role", RoleController.toJsonSingle(user.getRole()));
            results.add(userMap);
        }
        json.put("results", results);
        return json;
    }
    @Clear
    public void add() {
        String username = getPara("username");
        String idCard = getPara("idCard");
        String password = getPara("password");
        if (password == null) password = "000000";
        if (User.userDao.find("SELECT * FROM `db_user` WHERE username='" + username + "'").size() != 0) {
            renderJson(RenderUtils.CODE_REPEAT);
            return;
        }
        if (User.userDao.find("SELECT * FROM `db_user` WHERE idCard='" + idCard + "'").size() != 0) {
            renderJson(RenderUtils.CODE_UNIQUE);
            return;
        }
        Boolean result = new User().set("username", getPara("username"))
                .set("name", getPara("name"))
                .set("gender", getParaToInt("gender"))
                .set("idCard", getPara("idCard"))
                .set("tel", getPara("tel"))
                .set("role_id", getParaToInt("role_id"))
                .set("state", 0)
                .set("password", MD5Tools.MD5(password))
                .save();
        renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
    }


    public void getList() {
        List<User> userList = User.userDao.find("SELECT * FROM `db_user`");
        renderJson(toJson(userList));
    }

    public void getListByRole() {
        try {
            int id = getParaToInt("id");
            List<User> userList = User.userDao.find("SELECT * FROM `db_user` WHERE role_id=" + id);
            renderJson(toJson(userList));
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void getById() {
        try {
            int id = getParaToInt("id");
            renderJson(User.userDao.findById(id));
        } catch (Exception e) {
            renderError(500);
        }
    }
}
