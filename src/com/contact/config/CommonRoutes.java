package com.contact.config;

import com.contact.controller.constract.*;
import com.contact.controller.common.SignController;
import com.contact.controller.system.*;
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
        add("/default", DefaultsController.class, "/");
        add("/constarct", ContractController.class, "/");
        add("/feedback", FeedbackController.class, "/");
    }
}
