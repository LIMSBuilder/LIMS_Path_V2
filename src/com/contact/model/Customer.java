package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

/**
 * Created by qulongjun on 2016/10/28.
 */
public class Customer extends Model<Customer> {
    public static final Customer customerDao = new Customer();
}
