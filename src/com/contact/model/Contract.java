package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

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
        List monitorItemList = MonitorItem.monitorItemDao.find("SELECT * FROM `db_monitorItem` WHERE contract_id=?", get("id"));
        return monitorItemList;
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
}
