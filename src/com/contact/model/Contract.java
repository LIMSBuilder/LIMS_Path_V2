package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 合同
 */
public class Contract extends Model<Contract> {
    public static final Contract contractDao = new Contract();

    /**
     * 获取检测项
     *
     * @return
     */
    public List getMonitorItems() {
        List result = new ArrayList();
        List<MonitorItem> monitorItemList = MonitorItem.monitorItemDao.find("SELECT * FROM `db_monitorItem` WHERE contract_id=?", get("id"));
        for (MonitorItem items : monitorItemList) {
            Map map = new HashMap();
            map.put("environment_text", items.getCategory());
            map.put("monitor_point", items.get("monitor_point"));
            map.put("frequency", items.get("frequency"));
            map.put("other", items.get("other"));
            List<Monitor_Project> projects = Monitor_Project.monitor_projectDao.find("SELECT `db_monitorProject`.id,`db_monitorProject`.`name` FROM `db_monitorProject`,`db_monitorItem`,`db_item_project` WHERE `db_monitorProject`.`id`=`db_item_project`.`project_id` AND `db_item_project`.`item_id`=`db_monitorItem`.`id` AND `db_monitorItem`.`id`=" + items.getInt("id"));
            map.put("monitor_item_text", projects);
            result.add(map);
        }
        return result;
    }

    public Boolean setMonitorItems(List<Map> items) {
        for (int i = 0; i < items.size(); i++) {
            Boolean result = true;
            Map item = items.get(i);
            MonitorItem monitorItem = new MonitorItem();
            result = monitorItem
                    .set("contract_id", this.get("id"))
                    .set("category_id", item.get("category_id"))
                    .set("frequency", item.get("frequency"))
                    .set("monitor_point", item.get("monitor_point"))
                    .set("other", item.get("other"))
                    .save();
//            int item_id = monitorItem.getInt("id");
//            String[] ids = item.get("project_id").toString().split(";");
            if (!result) return false;
//            for (String idStr : ids) {
//                Boolean result2 = true;
//                int id = Integer.parseInt(idStr);
//                result2 = new Item_Project()
//                        .set("item_id", item_id)
//                        .set("project_id", id)
//                        .save();
//                if (!result2) return false;
//            }
        }
        return true;
    }


    public User getTrustee() {
        User trustee = User.userDao.findFirst("SELECT `db_user`.`id`,`db_user`.`name`,`db_user`.`username` FROM `db_user` WHERE id=?", getInt("trustee"));
        return trustee;
    }

}
