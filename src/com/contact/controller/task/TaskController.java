package com.contact.controller.task;

import com.contact.model.Task;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * 任务书
 * 0-任务书创建成功
 */
public class TaskController extends Controller {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

    /**
     * 通过现有合同创建任务书
     */
    public void addByContract() {
        try {
            int contract_id = getParaToInt("contract_id");
            if (contract_id != 0) {
                if (Task.taskDao.find("SELECT * FROM `db_task` WHERE state>=0 AND contract_id=" + contract_id).size() != 0) {
                    renderJson(RenderUtils.CODE_REPEAT);
                    return;
                }
                Task task = new Task();
                Boolean result = task
                        .set("contract_id", contract_id)
                        .set("receive_deparment", getParaToInt("receive_deparment"))
                        .set("other", getPara("other"))
                        .set("create_time", sdf.format(new Date()))
                        .set("state", 0)
                        .save();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 自定义创建任务书
     */
    public void addBySelf() {
        Map paras = getParaMap();
        for (Object key : paras.keySet()) {
            String value = ((String[]) paras.get(key))[0];
            System.out.println(key);
            System.out.println(value);
        }
    }
}
