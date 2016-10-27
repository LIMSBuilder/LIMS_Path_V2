package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

/**
 * Created by qulongjun on 2016/10/27.
 */
public class User extends Model<User> {
    public static final User userDao = new User();
}
