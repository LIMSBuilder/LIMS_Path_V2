package com.contact.config;

import com.contact.controller.common.*;
import com.contact.controller.constract.*;
import com.contact.controller.distribute.DistributeController;
import com.contact.controller.mail.MailController;
import com.contact.controller.office.ExportController;
import com.contact.controller.quality.QualityController;
import com.contact.controller.sample.DeliveryController;
import com.contact.controller.sample.SampleController;
import com.contact.controller.system.*;
import com.contact.controller.task.ReviewController;
import com.contact.controller.task.TaskController;
import com.contact.controller.template.TemplateController;
import com.jfinal.config.Routes;

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
        add("/task", TaskController.class, "/");
        add("/properties", PropertiesController.class, "/");
        add("/sample", SampleController.class, "/");
        add("/flow", FlowController.class, "/");
        add("/template", TemplateController.class, "/");
        add("/quality", QualityController.class, "/");
        add("/delivery", DeliveryController.class, "/");
        add("/distribute", DistributeController.class, "/");
        add("/export", ExportController.class, "/");
        add("/review", ReviewController.class, "/");

        add("/mail", MailController.class, "/");
        add("/file", FileController.class, "/");
        add("/push", PushController.class, "/");
    }
}
