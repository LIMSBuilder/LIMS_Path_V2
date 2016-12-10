package com.contact.config;

import com.contact.interceptor.LoginInterceptor;
import com.contact.model.*;
import com.jfinal.config.*;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;

/**
 * Created by qulongjun on 2016/10/17.
 */
public class CommonConfig extends JFinalConfig {
    /**
     * 配置JFInal的常量
     *
     * @param me
     */
    @Override
    public void configConstant(Constants me) {
        //读取配置文件
        //loadPropertyFile("config.properties");
        //设置开发模式,如果设置为true,控制台会输出每次请求的Controller action和参数信息
        //me.setDevMode(getPropertyToBoolean("devMode", false));
        //设置视图模型
        me.setViewType(ViewType.JSP);
        me.setBaseViewPath("/WEB-INF/pages");
        //me.setError404View("404.html");
        //设置下载路径
        // me.setBaseDownloadPath("/WEB-INF/download");
        //设置上传路径
        //me.setBaseUploadPath(PathKit.getWebRootPath() + "/upload");
        //http://localhost:8080/blog/1-3
        me.setUrlParaSeparator("-");
        //me.setError403View("/WEB-INF/pages/common/404.html");
    }

    @Override
    public void configRoute(Routes me) {
        //前端页面路由
        me.add(new CommonRoutes());
        //管理页面路由
        //me.add(new AdminRoutes());
    }

    @Override
    public void configPlugin(Plugins me) {
        C3p0Plugin cp = new C3p0Plugin("jdbc:mysql://localhost/lims", "root", "jun920221");
        me.add(cp);
        ActiveRecordPlugin arp = new ActiveRecordPlugin(cp);
        me.add(arp);
        arp.addMapping("db_department", Department.class);
        arp.addMapping("db_role", Role.class);
        arp.addMapping("db_user", User.class);
        arp.addMapping("db_customer", Customer.class);
        arp.addMapping("db_monitorFrequency", Monitor_Frequency.class);
        arp.addMapping("db_monitorCategory", Monitor_Category.class);
        arp.addMapping("db_monitorProject", Monitor_Project.class);
        arp.addMapping("db_default", Default.class);
        arp.addMapping("db_contract", Contract.class);
        arp.addMapping("db_monitorItem", MonitorItem.class);
        arp.addMapping("db_item_project", Item_Project.class);
        arp.addMapping("db_identify", Identify.class);
        arp.addMapping("db_feedback", Feedback.class);
        arp.addMapping("db_task", Task.class);
        arp.addMapping("db_properties", Properties.class);
        arp.addMapping("db_sample", Sample.class);
        arp.addMapping("db_sampleProject", Sample_Project.class);
        arp.addMapping("db_inspectionTemplate", InspectionTemplate.class);
        arp.addMapping("db_qualityController", Quality.class);
        arp.addMapping("db_qualityScene", QualityScene.class);
        arp.addMapping("db_qualityLab", QualityLab.class);
        arp.addMapping("db_qualityMark", QualityMark.class);
        arp.addMapping("db_delivery", Delivery.class);
        arp.addMapping("db_taskDeliveryReceive", DeliveryReceiveInfo.class);
        arp.addMapping("db_deliveryOriginRecord", Delivery_OriginRecord.class);
        arp.addMapping("db_originRecordTemplate", OriginRecordTemplate.class);
        arp.addMapping("db_mail", Mail.class);
        arp.addMapping("db_mailReceiver", MailReceiver.class);
        arp.addMapping("db_deliveryAssessReject", Delivery_Assess_Reject.class);
        arp.addMapping("db_deliveryCheckReject", Delivery_Check_Reject.class);
        arp.addMapping("db_experience_first", Experience_FirstReview.class);
    }

    @Override
    public void configInterceptor(Interceptors me) {
        //me.addGlobalActionInterceptor(new LoginInterceptor());//全局的登录拦截器
    }

    @Override
    public void configHandler(Handlers me) {

    }
}
