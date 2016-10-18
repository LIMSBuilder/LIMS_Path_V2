package com.contact.config;

import com.contact.controller.common.SignController;
import com.jfinal.config.Routes;

/**
 * Created by qulongjun on 2016/10/17.
 */
public class CommonRoutes extends Routes {

    @Override
    public void config() {
        add("/", SignController.class, "/common/");
    }
}