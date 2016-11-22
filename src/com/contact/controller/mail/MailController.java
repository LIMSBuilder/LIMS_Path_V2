package com.contact.controller.mail;

import com.contact.model.Mail;
import com.contact.model.MailReceiver;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 电子邮箱
 */
public class MailController extends Controller {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");


    /**
     * 发送邮件
     *
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
}
