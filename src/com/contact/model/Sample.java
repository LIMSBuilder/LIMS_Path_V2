package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by qulongjun on 2016/11/4.
 */
public class Sample extends Model<Sample> {
    public static Sample sampleDao = new Sample();


    public List<Monitor_Project> getProject() {
        List result = new ArrayList();
        List<Sample_Project> sample_projects = Sample_Project.sample_projectDao.find("SELECT * FROM `db_sampleProject` WHERE sample_id=" + get("id"));
        for (Sample_Project sample_project : sample_projects) {
            result.add(Monitor_Project.monitor_projectDao.findById(sample_project.get("project_id")));
        }
        return result;
    }
}
