package com.contact.model;

import com.jfinal.plugin.activerecord.Model;

/**
 * 邮件系统
 */
public class Mail extends Model<Mail> {
    public static Mail mailDao = new Mail();
}
