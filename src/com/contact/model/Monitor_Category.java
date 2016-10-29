package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * 环境要素
 */
public class Monitor_Category extends Model<Monitor_Category> {
    public static final Monitor_Category monitorCategoryDao = new Monitor_Category();


    public List<Monitor_Project> getProjects() {
        return Monitor_Project.monitor_projectDao.find("SELECT * FROM `db_monitorProject` WHERE state=0 AND category_id =?", get("id"));
    }
}
