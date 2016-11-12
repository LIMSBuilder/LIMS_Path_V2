package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

/**
 * 交联单接收的三个属性:
 * 1.样品包装情况
 * 2.样品标识
 * 3.固体添加剂情况
 */
public class DeliveryReceiveInfo extends Model<DeliveryReceiveInfo> {

    public static DeliveryReceiveInfo deliveryReceiveInfoDao = new DeliveryReceiveInfo();
}
