package com.contact.controller.common;

import com.contact.model.User;
import com.contact.utils.MD5Tools;
import com.contact.utils.RenderUtils;
import com.jfinal.core.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by qulongjun on 2016/10/17.
 */
public class SignController extends Controller {
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//24小时制

    public void index() {
        render("signin.html");
    }

    public void login() {
        render("signin.html");
    }

    public void dashboard() {
        render("index.html");
    }

    public void signup() {
        render("signup.html");
    }


    /**
     * 登录验证
     */
    public void loginCheck() {
        try {
            String username = getPara("username");//用户名
            String password = MD5Tools.MD5(getPara("password"));//加密后的MD5密码
            if (username != null && password != null) {
                User user = User.userDao.findFirst("SELECT * FROM `db_user` WHERE username='" + username + "'");
                if (user != null) {
                    if (user.get("password").equals(password)) {
                        //登录成功
                        Boolean result = user.set("last_login", sdf.format(new Date())).set("line", 1).update();//更新当前用户的登录状态和登录时间
                        renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_EMPTY);
                    } else {
                        //密码错误
                        renderJson(RenderUtils.CODE_ERROR);
                    }
                } else renderJson(RenderUtils.CODE_ERROR);//用户名不存在
            } else {
                renderJson(RenderUtils.CODE_NOTEMPTY);
            }
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 找回密码
     */
    public void forget() {
        try {
            String username = getPara("username");
            User user = User.userDao.findFirst("SELECT * FROM `db_user` WHERE username='" + username + "'");
            if (user != null) {
                if (user.get("idCard").equals(getPara("idCard"))) {
                    //证件号一致
                    Boolean result = user.set("password", MD5Tools.MD5(getPara("password"))).update();
                    renderJson(result ? RenderUtils.CODE_SUCCESS : RenderUtils.CODE_ERROR);
                } else {
                    renderJson(RenderUtils.CODE_REPEAT);
                }
            } else renderJson(RenderUtils.CODE_EMPTY);
        } catch (Exception e) {
            renderError(500);
        }
    }

    public void checkUsername() {
        try {
            String username = getPara("username");
            User user = User.userDao.findFirst("SELECT * FROM `db_user` WHERE username='" + username + "'");
            renderJson(user != null ? RenderUtils.CODE_UNIQUE : RenderUtils.CODE_SUCCESS);
        } catch (Exception e) {
            renderError(500);
        }
    }
}
