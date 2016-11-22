package com.contact.controller.common;

import com.contact.model.Mail;
import com.contact.model.User;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 消息推送
 */
public class PushController extends Controller {

    /**
     * 定期轮循,消息推送
     */
    public void push() {
        try {
            /**
             * 获取当前用户
             */
            User user = ParaUtils.getCurrentUser(getRequest());
            if (user != null) {
                renderJson(getMSG(user));
            } else {
                renderNull();
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 执行轮训的SQL语句集合
     */
    private static Map<String, List> getMSG(User user) {
        Map<String, List> SQL_MSG = new HashMap<String, List>();
        List<Mail> mails = Mail.mailDao.find("SELECT `db_mail`.* FROM `db_mail`,`db_mailReceiver` WHERE `db_mail`.`id`=`db_mailReceiver`.`mail_id` AND `db_mailReceiver`.`user_id`=" + user.get("id") + " AND `db_mailReceiver`.`state`=0");
        SQL_MSG.put("receive_mail", toMailJson(mails));
        return SQL_MSG;
    }


    /**
     * 将Mail序列号成前端需要的JSON
     *
     * @return
     */
    private static List toMailJson(List<Mail> mailList) {
        List<Map> mails = new ArrayList<>();
        for (Mail mail : mailList) {
            Map temp = new HashMap();
            temp.put("id", mail.get("id"));
            temp.put("title", mail.get("title"));
            temp.put("sender", User.userDao.findById(mail.get("sender")));
            mails.add(temp);
        }
        return mails;
    }


}
