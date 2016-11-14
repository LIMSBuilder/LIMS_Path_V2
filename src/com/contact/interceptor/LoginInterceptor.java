package com.contact.interceptor;

import com.contact.controller.common.SignController;
import com.contact.model.User;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

/**
 * 登录验证拦截器,判断当前用户是否已经登录
 */
public class LoginInterceptor implements Interceptor {

    @Override
    public void intercept(Invocation inv) {
        User login = (User) inv.getController().getSession().getAttribute("user");
        System.out.println(login);
        if (login != null) {
            //服务器存在登录信息
            inv.invoke();
        } else {
            //服务器不存在登录信息
            inv.getController().redirect("/accessBrred");
        }
    }
}
