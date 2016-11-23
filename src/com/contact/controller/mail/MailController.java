package com.contact.controller.mail;

import com.contact.model.Mail;
import com.contact.model.MailReceiver;
import com.contact.model.User;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.jfinal.plugin.activerecord.Page;
import com.sun.org.apache.xpath.internal.operations.Bool;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 电子邮箱
 * 状态:
 * 0 未读
 * 1 已读
 * 2 星标邮件
 * -1 存为草稿
 * -2 已删除
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

    public void changeState() {
        try {
            Boolean result = Db.tx(new IAtom() {
                @Override
                public boolean run() throws SQLException {
                    Integer[] mailReceive_id = getParaValuesToInt("mailReceive_id[]");
                    int state = getParaToInt("state");
                    Boolean result = true;
                    for (int id : mailReceive_id) {
                        result = MailReceiver.mailReceiver.findById(id).set("state", state).update();
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
     * 统计各种状态的邮件共有多少封
     * 收件箱 未读:state=0
     * 草稿箱 未发 state=-1
     */
    public void mail_count() {
        try {
            int unread = Db.find("SELECT * FROM `db_mailReceiver` WHERE state=0 AND user_id=" + ParaUtils.getCurrentUser(getRequest()).get("id")).size();
            int unsend = Db.find("SELECT * FROM `db_mailReceiver` WHERE state=-1 AND user_id=" + ParaUtils.getCurrentUser(getRequest()).get("id")).size();
            Map result = new HashMap();
            result.put("unread", unread);
            result.put("unsend", unsend);
            renderJson(result);
        } catch (Exception e) {
            renderError(500);
        }
    }


    public void getList() {
        try {
            String state = getPara("state");
            int rowCount = getParaToInt("rowCount");
            int currentPage = getParaToInt("currentPage");
            if (rowCount == 0) {
                rowCount = ParaUtils.getRowCount();
            }
            Page<Mail> mailPage = Mail.mailDao.paginate(currentPage, rowCount, "SELECT `db_mail`.* ", "FROM `db_mail`,`db_mailReceiver` WHERE `db_mailReceiver`.`mail_id`=`db_mail`.`id` AND `db_mailReceiver`.`user_id`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " AND `db_mailReceiver`.`state` in (" + state + ")");
            List<Mail> mailList = mailPage.getList();
            //List<Mail> mailList = Mail.mailDao.find("SELECT `db_mail`.* FROM `db_mail`,`db_mailReceiver` WHERE `db_mailReceiver`.`mail_id`=`db_mail`.`id` AND `db_mailReceiver`.`user_id`=" + ParaUtils.getCurrentUser(getRequest()).get("id") + " AND `db_mailReceiver`.`state` in (" + state + ")");
            Map result = toListJson(mailList, ParaUtils.getCurrentUser(getRequest()));
            result.put("currentPage", currentPage);
            result.put("totalPage", mailPage.getTotalPage());
            renderJson(result);
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
                renderJson(toMailJSON(Mail.mailDao.findById(mail_id), ParaUtils.getCurrentUser(getRequest())));
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    private static Map toMailJSON(Mail mail, User user) {
        MailReceiver mailReceiver = MailReceiver.mailReceiver.findFirst("SELECT * FROM `db_mailReceiver` WHERE user_id=" + user.get("id") + " AND mail_id=" + mail.get("id"));
        Map result = new HashMap();
        result.put("title", mail.get("title"));
        result.put("content", mail.get("content"));
        result.put("send_time", mail.get("send_time"));
        result.put("sender", User.userDao.findById(mail.get("sender")).getUserInfo());
        result.put("state", mailReceiver.get("state"));
        result.put("mailReceive_id", mailReceiver.get("id"));
        return result;
    }

    private static Map toListJson(List<Mail> mailList, User user) {
        Map result = new HashMap();
        List<Map> maps = new ArrayList<>();
        for (Mail mail : mailList) {
            maps.add(toMailJSON(mail, user));
        }
        result.put("results", maps);
        return result;
    }


}
