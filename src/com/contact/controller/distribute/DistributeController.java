package com.contact.controller.distribute;

import com.contact.model.Delivery;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;

/**
 * Created by qulongjun on 2016/11/13.
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
}
