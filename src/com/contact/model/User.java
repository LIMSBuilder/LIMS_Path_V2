package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

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
}
