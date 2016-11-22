<%@ page language="java"
         import="java.util.*,com.zhuozhengsoft.pageoffice.*"
         pageEncoding="utf-8" %>
<%@ page import="com.jfinal.core.JFinal" %>
<%@ page import="com.zhuozhengsoft.pageoffice.wordwriter.WordDocument" %>
<%@ page import="com.zhuozhengsoft.pageoffice.wordwriter.Table" %>
<%@ page import="com.contact.utils.ParaUtils" %>
<%@ page import="com.contact.model.*" %>
<%@ page import="javax.management.monitor.Monitor" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%
    PageOfficeCtrl poCtrl = new PageOfficeCtrl(request);

    //读取数据
    Delivery delivery = (Delivery) request.getAttribute("delivery");
    String path = "";
    if (delivery != null) {
        Monitor_Category category = Monitor_Category.monitorCategoryDao.findById(Monitor_Project.monitor_projectDao.findById(delivery.getInt("project_id")).getInt("category_id"));
        InspectionTemplate inspectionTemplate = InspectionTemplate.inspectionTemplateDao.findById(category.get("inspection_template"));
        if (inspectionTemplate != null) {
            path = inspectionTemplate.get("path");
        }
    }
    //设置PageOffice服务器
    poCtrl.setServerPage(request.getContextPath() + "/poserver.zz");
    //设置导航条
    poCtrl.addCustomToolButton("生成", "Create", 3);
    poCtrl.addCustomToolButton("保存", "Save", 1);
    poCtrl.addCustomToolButton("打印", "ShowPrintDlg()", 6);
    poCtrl.addCustomToolButton("-", "", 0);
    poCtrl.addCustomToolButton("全屏切换", "SwitchFullScreen()", 4);

    //设置保存页
    poCtrl.setSaveFilePage("/export/save");

    //配置页面信息
    poCtrl.webOpen(path, OpenModeType.docNormalEdit, ParaUtils.getCurrentUser(request) != null ? ParaUtils.getCurrentUser(request).getStr("name") : "佚名");
    poCtrl.setTagId("PageOfficeCtrl1");
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/assets/images/favicon.png" type="image/png">
    <title>实验室信息管理系统</title>
    <link href="/assets/css/style.default.css" rel="stylesheet">
</head>
<body>
<div style=" width:auto; height:auto;">
    <po:PageOfficeCtrl id="PageOfficeCtrl1">
    </po:PageOfficeCtrl>
</div>

<script type="text/javascript">
    function Create() {
        var result = document.getElementById("PageOfficeCtrl1").WebSave();
        debugger
    }
    function Save() {
        var result = document.getElementById("PageOfficeCtrl1").ShowDialog(3);
        console.log(result);
        //document.getElementById("PageOfficeCtrl1").WebSave();
    }
    function ShowPrintDlg() {
        document.getElementById("PageOfficeCtrl1").ShowDialog(4);
    }
    function SwitchFullScreen() {
        document.getElementById("PageOfficeCtrl1").FullScreen = !document.getElementById("PageOfficeCtrl1").FullScreen;
    }
</script>
</body>
</html>
