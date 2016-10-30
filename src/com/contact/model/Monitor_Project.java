package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

/**
 * 监测项目
 */
public class Monitor_Project extends Model<Monitor_Project> {
    public static final Monitor_Project monitor_projectDao = new Monitor_Project();

    /**
     * 获取外键Category
     *
     * @return
     */
    public Monitor_Category getCategory() {
        return Monitor_Category.monitorCategoryDao.findById(get("category_id"));
    }
}
