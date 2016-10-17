package com.contact.controller.common;

import com.jfinal.core.Controller;

/**
 * Created by qulongjun on 2016/10/17.
 */
public class SignController extends Controller {
    public void index() {
        render("signin.html");
    }

    public void dashboard(){
        render("index.html");
    }
}
