package com.contact.controller.sample;

import com.contact.model.Sample;
import com.contact.model.Task;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by qulongjun on 2016/11/4.
 */
public class SampleController extends Controller {
    public void getSignleSample() {
        try {
            int id = getParaToInt("id");
            Task task = Task.taskDao.findById(id);
            if (task != null) {
                List<Sample> sampleList = Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE state=0 AND task_id=" + id);
                Map result = toJson(sampleList);
                result.put("projects", task.getMonitorProjects());
                renderJson(result);
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 保存样品
     */
    public void addItem() {
        try {
            Integer[] projects = getParaValuesToInt("projects[]");
            Sample sample = new Sample();
            sample.set("identify", "");
            sample.set("name", getPara("name"));
            sample.set("feature", getPara("feature"));
            sample.set("condition", getPara("condition"));
            sample.set("color", getPara("color"));
            sample.set("state", 0);
            Boolean result = sample.save();

        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 将查询结果生成JSON
     *
     * @param entityList
     * @return
     */
    public Map toJson(List<Sample> entityList) {
        Map<String, Object> json = new HashMap<>();
        List results = new ArrayList();
        for (Sample sample : entityList) {
            Map map = new HashMap();
            map.put("id", sample.get("id"));
            map.put("identify", sample.get("identify"));
            map.put("feature", sample.get("feature"));
            map.put("condition", sample.get("condition"));
            map.put("name", sample.get("name"));
            map.put("color", sample.get("color"));
            map.put("project", sample.getProject());
            results.add(map);
        }
        json.put("results", results);
        return json;
    }


}
