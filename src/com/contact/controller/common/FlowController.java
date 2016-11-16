package com.contact.controller.common;

import com.contact.model.Sample;
import com.contact.model.Task;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public void taskFlow() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int id = getParaToInt("id");
                    List<Sample> sampleList = Sample.sampleDao.find("SELECT * FROM `db_sample` WHERE `db_sample`.`task_id`=" + id);
                    if (sampleList.size() != 0) {
                        Boolean result = flow(Integer.parseInt(ParaUtils.flows.get("create_sample").toString()), id);
                        renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
                        Task task = Task.taskDao.findById(id);
                        task.set("sample_time", sdf.format(new Date()));
                        task.set("sample_user", ParaUtils.getCurrentUser(getRequest()).get("id"));
                        return result && task.update();
                    } else {
                        renderJson(RenderUtils.CODE_NOTEMPTY);
                        return false;
                    }
                }
            });
            if (result) renderJson(RenderUtils.CODE_SUCCESS);

        } catch (Exception e) {
            renderError(500);
        }
    }


    public void sampleFlow() {
        try {
            int id = getParaToInt("id");
            Boolean result = flow(Integer.parseInt(ParaUtils.flows.get("connect_sample").toString()), id);
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void qualityFlow() {
        try {
            int id = getParaToInt("id");
            Task task = Task.taskDao.findById(id);
            Boolean update = task.set("quality_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("quality_time", sdf.format(new Date())).update();
            Boolean result = flow(Integer.parseInt(ParaUtils.flows.get("create_quality").toString()), id);
            renderJson(result && update ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void deliveryFlow() {
        try {
            int id = getParaToInt("id");
            Task task = Task.taskDao.findById(id);
            Boolean update = task.set("receive_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("receive_time", sdf.format(new Date())).update();
            Boolean result = flow(Integer.parseInt(ParaUtils.flows.get("receive_delivery").toString()), id);
            renderJson(result && update ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void distributeFlow() {
        try {
            int id = getParaToInt("id");
            Task task = Task.taskDao.findById(id);
            Boolean update = task.set("charge_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("distribute_time", sdf.format(new Date())).update();
            Boolean result = flow(Integer.parseInt(ParaUtils.flows.get("task_dstribute").toString()), id);
            renderJson(result && update ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
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
