package com.contact.controller.distribute;

import com.contact.model.Delivery;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.util.List;

/**
 * 任务分配下达
 */
public class DistributeController extends Controller {
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

    public void checkUser() {
        try {
            int task_id = getParaToInt("task_id");
            List<Delivery> deliveryList = Delivery.deliveryDao.find("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND (analyst IS NULL OR assessor IS NULL OR checker IS NULL)");
            renderJson(deliveryList.size() != 0 ? RenderUtils.CODE_EMPTY : RenderUtils.CODE_SUCCESS);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
