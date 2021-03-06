package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.*;

/**
 * 任务书
 */
public class Task extends Model<Task> {
    public static Task taskDao = new Task();

    /**
     * 获取检测项
     *
     * @return
     */
    public List getMonitorItems() {
        List result = new ArrayList();
        List<MonitorItem> monitorItemList = MonitorItem.monitorItemDao.find("SELECT * FROM `db_monitorItem` WHERE task_id=?", get("id"));
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

    public List getMonitorProjects(String type) {
        Set result = new HashSet();
        List<MonitorItem> monitorItemList = new ArrayList<>();
        if (type.equals("task")) {
            monitorItemList = MonitorItem.monitorItemDao.find("SELECT * FROM `db_monitorItem` WHERE task_id=?", get("id"));
        }
        if (type.equals("contract")) {
            monitorItemList = MonitorItem.monitorItemDao.find("SELECT * FROM `db_monitorItem` WHERE contract_id=?", get("contract_id"));
        }
        for (MonitorItem items : monitorItemList) {
            List<Monitor_Project> projects = Monitor_Project.monitor_projectDao.find("SELECT `db_monitorProject`.id,`db_monitorProject`.`name` FROM `db_monitorProject`,`db_monitorItem`,`db_item_project` WHERE `db_monitorProject`.`id`=`db_item_project`.`project_id` AND `db_item_project`.`item_id`=`db_monitorItem`.`id` AND `db_monitorItem`.`id`=" + items.getInt("id"));
            result.addAll(projects);
        }
        List temp = new ArrayList();
        temp.addAll(result);
        return temp;
    }

}
