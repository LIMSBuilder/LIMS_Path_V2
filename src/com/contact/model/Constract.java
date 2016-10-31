package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

import java.util.List;

/**
 * 合同
 */
public class Constract extends Model<Constract> {
    public static final Constract constractDao = new Constract();

    /**
     * 获取检测项
     *
     * @return
     */
    public List getMonitorItems() {
        List monitorItemList = MonitorItem.monitorItemDao.find("SELECT * FROM `db_monitorItem` WHERE contract_id=?", get("id"));
        return monitorItemList;
    }

    public Boolean setMonitorItems() {
        return true;
    }
}
