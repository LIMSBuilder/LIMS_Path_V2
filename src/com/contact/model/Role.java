package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

/**
 * Created by qulongjun on 2016/10/27.
 */
public class Role extends Model<Role> {
    public static final Role roleDao = new Role();

    /**
     * 获取外键Department
     *
     * @return
     */
    public Department getDepartment() {
        return Department.departmentDao.findById(get("department_id"));
    }
}
