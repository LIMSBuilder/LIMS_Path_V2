package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.HashMap;
import java.util.Map;

/**
 * 预设信息
 */
public class Default extends Model<Default> {
    public static final Default defaultDao = new Default();


    /**
     * 获取乙方预设信息
     *
     * @return
     */
    public Map getTrusteeInfo() {
        Map trustee = new HashMap();
        trustee.put("trustee_unit", get("trustee_unit"));
        trustee.put("trustee_code", get("trustee_code"));
        trustee.put("trustee_address", get("trustee_address"));
        trustee.put("trustee_tel", get("trustee_tel"));
        trustee.put("trustee_fax", get("trustee_fax"));
        trustee.put("trustee", User.userDao.findById(getInt("trustee")));
        return trustee;
    }
}
