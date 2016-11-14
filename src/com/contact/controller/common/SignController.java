package com.contact.controller.common;

import com.contact.interceptor.LoginInterceptor;
import com.contact.model.User;
import com.contact.utils.MD5Tools;
import com.contact.utils.ParaUtils;
import com.contact.utils.RenderUtils;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 处理与登录有关的内容
 * Clear:取消登录拦截器控制
 */
@Clear
public class SignController extends Controller {
    //格式化时间
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//24小时制

    /**
     * 登录页面
     */
    public void index() {
        render("signin.html");
    }

    /**
     * 登录页面
     */
    public void login() {
        render("signin.html");
    }

    /**
     * 跳到首页
     */
    public void dashboard() {
        render("index.html");
    }

    /**
     * 注册页面
     */
    public void signup() {

        render("signup.html");
    }


    public void accessBrred() {
        render("skip/401.html");
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
                        if (result) {
                            //将登录信息放入Session
                            getSession().setAttribute("user", user);
                        }
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

    /**
     * 检查用户名是否存在
     */
    public void checkUsername() {
        try {
            String username = getPara("username");
            User user = User.userDao.findFirst("SELECT * FROM `db_user` WHERE username='" + username + "'");
            renderJson(user != null ? RenderUtils.CODE_UNIQUE : RenderUtils.CODE_SUCCESS);
        } catch (Exception e) {
            renderError(500);
        }
    }

    /**
     * 子页面跳转之前进行验证是否已经登录
     */
    public void checkState() {
        User user = (User) getSession().getAttribute("user");
        if (user != null) {
            renderJson(RenderUtils.CODE_SUCCESS);
        } else {
            renderJson(RenderUtils.CODE_EMPTY);
        }

    }
}
