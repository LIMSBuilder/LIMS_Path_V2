package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

/**
 * 合同检测项
 */
public class MonitorItem extends Model<MonitorItem> {
    public static final MonitorItem monitorItemDao = new MonitorItem();


    public Monitor_Category getCategory() {
        Monitor_Category category = Monitor_Category.monitorCategoryDao.findById(getInt("category_id"));
        return category;
    }
}
