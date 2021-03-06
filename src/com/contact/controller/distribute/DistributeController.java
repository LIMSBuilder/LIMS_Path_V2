package com.contact.controller.distribute;

import com.contact.model.Delivery;
import com.contact.model.Delivery_OriginRecord;
import com.contact.model.OriginRecordTemplate;
import com.contact.model.Task;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.render.Render;
import com.sun.org.apache.xpath.internal.operations.Bool;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 任务分配下达
 * <p/>
 * <p/>
 * <p/>
 * Delivery的state类型:
 * 0-待实验分析
 * 1-实验分析已经完成,待实验分析人员业务流转
 * 2-实验分析人员已经业务流转,被实验审核人员监测到。
 */
public class DistributeController extends Controller {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    SimpleDateFormat sdfMore = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    /**
     * 任务分配下达
     */
    public void task_distribute() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int task_id = getParaToInt("task_id");//需要设置的task编号
                    Integer[] projectList = getParaValuesToInt("projectList[]");//选中的项目列表
                    int user_id = getParaToInt("user_id");//需要设置的用户编号
                    String type = getPara("type");
                    Boolean result = true;
                    for (int i = 0; i < projectList.length; i++) {
                        int project_id = projectList[i];
                        Delivery delivery = Delivery.deliveryDao.findFirst("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND project_id=" + project_id);
                        if (delivery != null) {
                            result = delivery.set(type, user_id).update();
                        } else {
                            return false;
                        }
                        if (!result) break;
                    }
                    return result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);


        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 清除任务分配下单
     */
    public void clear_distribute() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int task_id = getParaToInt("task_id");//需要设置的task编号
                    Integer[] projectList = getParaValuesToInt("projectList[]");//选中的项目列表
                    Boolean result = true;
                    for (int i = 0; i < projectList.length; i++) {
                        int project_id = projectList[i];
                        Delivery delivery = Delivery.deliveryDao.findFirst("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND project_id=" + project_id);
                        if (delivery != null) {
                            result = delivery.set("analyst", null).set("assessor", null).set("checker", null).update();
                        } else {
                            return false;
                        }
                        if (!result) break;
                    }
                    return result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 清除任务分配的人员
     */
    public void delUser() {
        try {
            int task_id = getParaToInt("task_id");
            int project_id = getParaToInt("project_id");
            String type = getPara("type");
            Delivery delivery = Delivery.deliveryDao.findFirst("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND project_id=" + project_id);
            if (delivery != null) {
                Boolean result = delivery.set(type, null).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 检查当前是否有未设置的分配用户
     */
    public void checkUser() {
        try {
            int task_id = getParaToInt("task_id");
            List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND (analyst IS NULL OR assessor IS NULL OR checker IS NULL)");
            renderJson(deliveryList.size() != 0 ? RenderUtils.CODE_EMPTY : RenderUtils.CODE_SUCCESS);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 检查当前实验分析人员是否已经完成了全部的实验分析
     */
    public void checkAnalyst() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE state in (0,-3) AND task_id=" + task_id + " AND analyst=" + ParaUtils.getCurrentUser(getRequest()).get("id"));
                renderJson(deliveryList.size() == 0 ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_EMPTY);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 检查当前实验审核人员是否已经完成了全部的实验审核
     */
    public void checkAssessor() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE state=2 AND task_id=" + task_id + " AND assessor=" + ParaUtils.getCurrentUser(getRequest()).get("id"));
                renderJson(deliveryList.size() == 0 ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_EMPTY);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 获取送检单列表
     */
    public void getInspectionList() {
        try {
            int task_id = getParaToInt("task_id");
            int project_id = getParaToInt("project_id");
            Delivery delivery = Delivery.deliveryDao.findFirst("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND project_id=" + project_id);
            if (delivery != null) {
                List<Delivery_OriginRecord> originRecordList = Delivery_OriginRecord.delivery_originRecordDao.find("SELECT * FROM `db_deliveryOriginRecord` WHERE delivery_id=" + delivery.get("id"));
                Map result = new HashMap();
                result.put("results", originRecordList);
                renderJson(result);
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 获取原始记录列表
     */
    public void getOriginRecordList() {
        try {
            //int task_id = getParaToInt("task_id");
            //int project_id = getParaToInt("project_id");
            //Delivery delivery = Delivery.deliveryDao.findFirst("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND project_id=" + project_id);
            int delivery_id = getParaToInt("delivery_id");
            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            if (delivery != null) {
                List<Delivery_OriginRecord> delivery_originRecordList = Delivery_OriginRecord.delivery_originRecordDao.find("SELECT * FROM `db_deliveryOriginRecord` WHERE delivery_id=" + delivery.get("id"));
                Map result = new HashMap();
                result.put("results", delivery_originRecordList);
                result.put("delivery", delivery);
                renderJson(result);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 保存实验分析结果
     */
    public void analystSave() {
        try {
            //int project_id = getParaToInt("project_id");
            //int task_id = getParaToInt("task_id");

            int delivery_id = getParaToInt("delivery_id");
            //Delivery delivery = Delivery.deliveryDao.findFirst("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND project_id=" + project_id);

            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            if (delivery != null) {
                if (delivery.get("inspection_path") != null) {
                    Boolean result = delivery.set("analyst_time", sdfMore.format(new Date())).set("state", 1).update();
                    renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
                } else {
                    renderJson(RenderUtils.CODE_UNIQUE);
                }
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 批量删除选中原始记录
     */
    public void deleteOrignRecord() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    Integer[] ids = getParaValuesToInt("ids[]");
                    Boolean result = true;
                    for (int id : ids) {
                        result = Delivery_OriginRecord.delivery_originRecordDao.deleteById(id);
                        if (!result) break;
                    }
                    return result;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 创建原始记录
     */
    public void createOriginRecord() {
        try {
            int delivery_id = getParaToInt("delivery_id");
            int template_id = getParaToInt("template_id");
            OriginRecordTemplate originRecordTemplate = OriginRecordTemplate.originRecordTemplateDao.findById(template_id);
            getRequest().setAttribute("originRecord", originRecordTemplate);
            getRequest().setAttribute("delivery_id", delivery_id);


            render("template/create_originRecord.jsp");
        } catch (Exception e) {
            renderError(500);
        }

    }


    /**
     * 查看填写完成的原始记录表格
     */
    public void viewOriginRecord() {
        try {
            int id = getParaToInt("record_id");
            Delivery_OriginRecord delivery_originRecord = Delivery_OriginRecord.delivery_originRecordDao.findById(id);
            if (delivery_originRecord != null) {
                getRequest().setAttribute("delivery_originRecord", delivery_originRecord);
                render("template/view_originRecord.jsp");
            } else renderNull();
        } catch (Exception e) {
            renderError(500);
        }
    }


    public void uploadOriginRecord() {
        try {
            String name = getPara("name");
            String path = getPara("path");
            int delivery_id = getParaToInt("delivery_id");
            System.out.println(delivery_id);
            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            if (delivery != null) {
                Delivery_OriginRecord delivery_originRecord = new Delivery_OriginRecord();
                Boolean result = delivery_originRecord.set("name", name).set("originRecord_path", path).set("delivery_id", delivery_id).save();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }


    public void changeOriginRecord() {
        try {
            int id = getParaToInt("record_id");
            Delivery_OriginRecord delivery_originRecord = Delivery_OriginRecord.delivery_originRecordDao.findById(id);
            if (delivery_originRecord != null) {
                getRequest().setAttribute("delivery_originRecord", delivery_originRecord);
                render("template/change_originRecord.jsp");
            } else renderNull();
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 创建当前任务的监测项目的送检单
     */
    public void createInspection() {
        try {
            int delivery_id = getParaToInt("delivery_id");
            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            getRequest().setAttribute("delivery", delivery);
            render("template/create_inspection.jsp");
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 保存原始记录表
     */
    public void saveOriginRecord() {
        try {
            int delivery_id = getParaToInt("delivery_id");
            String name = getPara("name");
            String path = getPara("path");
            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            if (delivery != null) {
                Delivery_OriginRecord delivery_originRecord = new Delivery_OriginRecord();
                Boolean result = delivery_originRecord.set("delivery_id", delivery_id).set("originRecord_path", path).set("name", name).save();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 通过Task_id找到Delivery的list并返回
     */
    public void getDeliveryByTaskId() {
        try {
            int task_id = getParaToInt("task_id");
            Task task = Task.taskDao.findById(task_id);
            if (task != null) {
                List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE task_id=" + task_id);
                Map result = new HashMap();
                result.put("results", deliveryList);
                renderJson(result);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /*
     * 保存送检单
     */
    public void saveInspection() {
        int delivery_id = getParaToInt("delivery_id");
        String name = getPara("name");
        String path = getPara("path");
        Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
        if (delivery != null) {
            Boolean result = delivery.set("inspection_path", path).update();
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } else renderJson(RenderUtils.CODE_EMPTY);
    }

    /**
     * 删除送检单
     */
    public void deleteInspection() {
        try {
            int delivery_id = getParaToInt("delivery_id");
            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            if (delivery != null) {
                Boolean result = delivery.set("inspection_path", null).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 查看送检单
     */
    public void viewInspection() {
        try {
            int delivery_id = getParaToInt("delivery_id");
            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            if (delivery != null) {
                getRequest().setAttribute("delivery", delivery);
                render("template/view_inspection.jsp");
            } else renderNull();
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 修改送检单
     */
    public void changeInspection() {
        try {
            int delivery_id = getParaToInt("delivery_id");
            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            if (delivery != null) {
                getRequest().setAttribute("delivery", delivery);
                render("template/change_inspection.jsp");
            } else renderNull();
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 上传送检单
     */
    public void uploadInspection() {
        try {
            int delivery_id = getParaToInt("delivery_id");
            String path = getPara("path");
            Delivery delivery = Delivery.deliveryDao.findById(delivery_id);
            if (delivery != null) {
                Boolean result = delivery.set("inspection_path", path).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 实验分析结果进行审核和复核
     * -2-复核拒绝,返回修改
     * -1-审核拒绝,返回修改
     * 3-审核通过
     * 4-待复核
     * 5-复核通过
     */
    public void reviewState() {
        try {
            int state = getParaToInt("state");
            int delovery_id = getParaToInt("delivery_id");
            Delivery delivery = Delivery.deliveryDao.findById(delovery_id);
            if (delivery != null) {
                Boolean result = delivery.set("state", state).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else
                renderJson(RenderUtils.CODE_EMPTY);

        } catch (Exception e) {
            renderError(500);
        }
    }

    public void reviewStateAll() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int state = getParaToInt("state");
                    int task_id = getParaToInt("task_id");
                    Task task = Task.taskDao.findById(task_id);
                    if (task != null) {
                        List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE state in (-1,2,3) AND task_id=" + task_id);
                        Boolean result = true;
                        for (Delivery delivery : deliveryList) {
                            result = delivery.set("state", state).update();
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
    public void reviewCheckStateAll() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    int state = getParaToInt("state");
                    int task_id = getParaToInt("task_id");
                    Task task = Task.taskDao.findById(task_id);
                    if (task != null) {
                        List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE state in (-2,4,5) AND task_id=" + task_id);
                        Boolean result = true;
                        for (Delivery delivery : deliveryList) {
                            result = delivery.set("state", state).update();
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
}
