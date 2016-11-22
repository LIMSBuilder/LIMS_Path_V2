package com.contact.controller.mail;

import com.contact.model.Mail;
import com.contact.model.MailReceiver;
import com.contact.model.User;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 电子邮箱
 * 状态:
 * 0-未读
 * 1-已读
 */
public class MailController extends Controller {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");


    /**
     * 发送邮件
     */
    public void send() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    Integer[] receiver = getParaValuesToInt("receiver[]");
                    String title = getPara("title");
                    String content = getPara("content");

                    Mail mail = new Mail();
                    Boolean result = mail.set("title", title).set("content", content).set("sender", ParaUtils.getCurrentUser(getRequest()).get("id")).set("send_time", sdf.format(new Date())).set("state", 0).save();
                    if (result) {
                        Boolean receiverResult = true;
                        for (int id : receiver) {
                            MailReceiver mailReceiver = new MailReceiver();
                            receiverResult = mailReceiver.set("mail_id", mail.get("id")).set("user_id", id).set("state", 0).save();
                            if (!receiverResult) break;
                        }
                        return receiverResult;
                    } else return false;
                }
            });
            renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
        } catch (Exception e) {
            renderError(500);
        }
    }


    /**
     * 读取全部邮件
     */
    public void all_read() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    List<MailReceiver> mailReceivers = MailReceiver.mailReceiver.find("SELECT * FROM `db_mailReceiver` WHERE state=0 AND user_id=" + ParaUtils.getCurrentUser(getRequest()).get("id"));
                    Boolean result = true;
                    for (MailReceiver mailReceiver : mailReceivers) {
                        result = mailReceiver.set("state", 1).update();
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
     * 根据邮件id获取邮件信息
     */
    public void getById() {
        try {
            int mail_id = getParaToInt("id");
            MailReceiver mailReceiver = MailReceiver.mailReceiver.findFirst("SELECT * FROM `db_mailReceiver` WHERE mail_id=" + mail_id + " AND user_id=" + ParaUtils.getCurrentUser(getRequest()).get("id"));
            if (mailReceiver != null) {
                mailReceiver.set("state", 1).update();//标记为已读
                renderJson(toMailJSON(Mail.mailDao.findById(mail_id)));
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    private static Map toMailJSON(Mail mail) {
        Map result = new HashMap();
        result.put("title", mail.get("title"));
        result.put("content", mail.get("content"));
        result.put("send_time", mail.get("send_time"));
        result.put("sender", User.userDao.findById(mail.get("sender")).getUserInfo());
        return result;
    }
}
