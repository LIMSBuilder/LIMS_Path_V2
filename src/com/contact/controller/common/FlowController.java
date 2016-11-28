package com.contact.controller.common;

import com.contact.model.Delivery;
import com.contact.model.Delivery_Assess_Reject;
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
    SimpleDateFormat sdfMore = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

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
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int id = getParaToInt("id");
                    Task task = Task.taskDao.findById(id);
                    Boolean taskResult = true;
                    if (task != null) {
                        taskResult = task.set("sample_user", ParaUtils.getCurrentUser(getRequest()).get("id")).set("sample_time", sdf.format(new Date())).update();
                    }
                    Boolean result = flow(Integer.parseInt(ParaUtils.flows.get("create_sample").toString()), id);
                    return result && taskResult;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);

        } catch (Exception e) {
            renderError(500);
        }
    }

    public void connectionFlow() {
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

    /**
     * 任务下达流转
     */
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

    /**
     * 实验分析流转
     */
    public void experienceFlow() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int task_id = getParaToInt("id");
                    Task task = Task.taskDao.findById(task_id);
                    if (task != null) {
                        List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE state=1 AND task_id=" + task_id + " AND analyst=" + ParaUtils.getCurrentUser(getRequest()).get("id"));
                        Boolean result = true;
                        for (Delivery delivery : deliveryList) {
                            result = delivery.set("state", 2).update();
                            if (!result) break;
                        }
                        return result;
                    } else return false;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 实验分析审核流转
     * <p/>
     * 如果是-1,则变成-3表示审核拒绝,需要修改
     * 如果是3,则变成4,表示审核通过
     */
    public void assessorFlow() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int task_id = getParaToInt("id");
                    Task task = Task.taskDao.findById(task_id);
                    if (task != null) {
                        List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE state in (-1,3) AND task_id=" + task_id + " AND assessor=" + ParaUtils.getCurrentUser(getRequest()).get("id"));
                        Boolean result = true;
                        for (Delivery delivery : deliveryList) {
                            if (delivery.get("state") == -1) {
                                result = delivery.set("state", -3).set("assessor_time", sdf.format(new Date())).update();
                                Delivery_Assess_Reject reject = new Delivery_Assess_Reject();
                                result = result && reject.set("assessor", ParaUtils.getCurrentUser(getRequest()).get("id")).set("assessor_time", sdfMore.format(new Date())).set("delivery_id", delivery.get("id")).save();
                            } else {
                                if (delivery.get("state") == 3) {
                                    result = delivery.set("state", 4).set("assessor_time", sdf.format(new Date())).update();
                                }
                            }
                            if (!result) break;
                        }
                        return result;
                    } else return false;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
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
