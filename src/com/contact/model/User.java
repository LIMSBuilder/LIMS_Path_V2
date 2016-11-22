package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by qulongjun on 2016/10/27.
 */
public class User extends Model<User> {
    public static final User userDao = new User();

    /**
     * 获取外键Department
     *
     * @return
     */
    public Role getRole() {
        return Role.roleDao.findById(get("role_id"));
    }

    public Map getUserInfo() {
        Map result = new HashMap();
        if (this != null) {
            result.put("id", this.get("id"));
            result.put("name", this.get("name"));
            result.put("role", this.getRole());
            result.put("department", Department.departmentDao.findById(this.getRole().get("id")));
        }
        return result;
    }
}
