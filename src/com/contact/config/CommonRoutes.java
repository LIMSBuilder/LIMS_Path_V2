package com.contact.config;

import com.contact.controller.constract.MonitorCategoryController;
import com.contact.controller.common.SignController;
import com.contact.controller.constract.MonitorFrequencyController;
import com.contact.controller.constract.MonitorProjectController;
import com.contact.controller.system.CustomerController;
import com.contact.controller.system.DepartmentController;
import com.contact.controller.system.RoleController;
import com.contact.controller.system.UserController;
import com.jfinal.config.Routes;

/**
 * Created by qulongjun on 2016/10/17.
 */
public class CommonRoutes extends Routes {

    @Override
    public void config() {
        add("/", SignController.class, "/");
        add("/department", DepartmentController.class, "/");
        add("/role", RoleController.class, "/");
        add("/user", UserController.class, "/");
        add("/customer", CustomerController.class, "/");
        add("/frequency", MonitorFrequencyController.class, "/");
        add("/category", MonitorCategoryController.class, "/");
        add("/project", MonitorProjectController.class, "/");
    }
}
