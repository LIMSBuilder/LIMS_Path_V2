package com.contact.controller.sample;

import com.contact.model.Delivery;
import com.contact.model.DeliveryReceiveInfo;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;

/**
 * 交接联单相关
 */
public class DeliveryController extends Controller {

    public void save() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    Integer[] ids = getParaValuesToInt("projects[]");
                    int task_id = getParaToInt("id");
                    Boolean result = true;
                    for (int i = 0; i < ids.length; i++) {
                        int id = ids[i];
                        if (Delivery.deliveryDao.find("SELECT * FROM db_delivery WHERE task_id=" + task_id + " AND project_id=" + id).size() != 0) {
                            continue;
                        }
                        Delivery delivery = new Delivery();
                        result = delivery.set("task_id", task_id).set("project_id", id).save();
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
     * 交联单完成每个样品性状和保存条件
     */
    public void receiveItem() {
        try {
            int task_id = getParaToInt("task_id");
            int project_id = getParaToInt("id");
            Delivery delivery = Delivery.deliveryDao.findFirst("SELECT * FROM `db_delivery` WHERE task_id=" + task_id + " AND project_id=" + project_id);
            if (delivery != null) {
                Boolean result = delivery.set("character", getPara("character")).set("storage", getPara("storage")).update();
                renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
            } else {
                renderJson(RenderUtils.CODE_EMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 保存交联单的其他属性:
     * 1.样品状态
     * 2.样品标识
     * 3.固体添加剂情况
     */
    public void receiveInfo() {
        try {
            int task_id = getParaToInt("task_id");
            DeliveryReceiveInfo history = DeliveryReceiveInfo.deliveryReceiveInfoDao.findFirst("SELECT * FROM `db_taskDeliveryReceive` WHERE task_id=" + task_id);
            Boolean result = false;
            if (history != null) {
                result = history.set("package", getPara("package")).set("sampleFlag", getPara("sampleFlag")).set("additive", getPara("additive")).update();
            } else {
                DeliveryReceiveInfo info = new DeliveryReceiveInfo();
                result = info.set("task_id", task_id).set("package", getPara("package")).set("sampleFlag", getPara("sampleFlag")).set("additive", getPara("additive")).save();
            }
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }

}
