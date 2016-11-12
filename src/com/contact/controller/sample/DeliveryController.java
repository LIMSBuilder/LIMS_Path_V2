package com.contact.controller.sample;

import com.contact.model.Delivery;
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

}
