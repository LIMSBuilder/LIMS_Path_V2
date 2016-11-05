package com.contact.controller.common;

import com.contact.model.Sample;
import com.contact.model.Task;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 业务流程控制
 * 任务书:
 * 0-任务书起草,转入样品登记环节
 * 1-样品登记完成,转入
 */
public class FlowController extends Controller {


    public void taskFlow() {
        try {
            int id = getParaToInt("id");
            List<Sample> sampleList = Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE `db_sample`.`task_id`=" + id);
            if (sampleList.size() != 0) {
                Boolean result = flow(Integer.parseInt(ParaUtils.flows.get("create_sample").toString()), id);
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else renderJson(RenderUtils.CODE_NOTEMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public static Boolean flow(int state, int id) {
        try {
            Task task = Task.taskDao.findById(id);
            if (task != null) {
                Boolean result = task.set("state", state).update();
                return result;
            } else return false;
        } catch (Exception e) {
            return false;
        }
    }
}
