package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

/**
 * Created by qulongjun on 2016/10/31.
 */
public class Identify extends Model<Identify> {
    public static Identify identifyDao = new Identify();


    /**
     * 获取下一个合同编号
     * 返回值的id就可以直接使用了
     *
     * @return
     */
    public int getContractId() {
        return this.findById(1).getInt("contract_id") + 1;
    }

    public Boolean setContractId(int id) {
        Boolean result = this.findById(1).set("contract_id", id).save();
        return result;
    }
}
