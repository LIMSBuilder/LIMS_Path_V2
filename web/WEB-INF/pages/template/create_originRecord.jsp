<%@ page language="java"
         import="java.util.*,com.zhuozhengsoft.pageoffice.*"
         pageEncoding="gb2312"%>
<%@ page import="com.jfinal.core.JFinal" %>
<%@ page import="com.zhuozhengsoft.pageoffice.wordwriter.WordDocument" %>
<%@ page import="com.contact.model.Contract" %>
<%@ page import="com.zhuozhengsoft.pageoffice.wordwriter.Table" %>
<%@ page import="com.contact.model.Monitor_Category" %>
<%@ page import="com.contact.model.Monitor_Project" %>
<%@ page import="com.contact.utils.ParaUtils" %>
<%@ page import="com.contact.model.OriginRecordTemplate" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
    PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);


    //获取Request数据
    OriginRecordTemplate originRecordTemplate =  (OriginRecordTemplate) request.getAttribute("originRecord");
    String path ="";
    if(originRecordTemplate!=null){
        path=originRecordTemplate.getStr("path");
    }
//设置服务器页面
    poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
//添加自定义按钮
    poCtrl.addCustomToolButton("生成","Create",3);
    poCtrl.addCustomToolButton("保存","Save",1);
    poCtrl.addCustomToolButton("打印", "ShowPrintDlg()", 6);
    poCtrl.addCustomToolButton("-", "", 0);
    poCtrl.addCustomToolButton("全屏切换", "SwitchFullScreen()", 4);

    //设置保存页面
    poCtrl.setSaveFilePage("/export/save");
    //设置页面
    //打开Word文档
    poCtrl.webOpen(path,OpenModeType.docNormalEdit, ParaUtils.getCurrentUser(request)!=null?ParaUtils.getCurrentUser(request).getStr("name"):"佚名");
    poCtrl.setTagId("PageOfficeCtrl1");//此行必需
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
        document.getElementById("PageOfficeCtrl1").ShowDialog(4); //打印对话框
    }
    function SwitchFullScreen() {
        document.getElementById("PageOfficeCtrl1").FullScreen = !document.getElementById("PageOfficeCtrl1").FullScreen;
    }
</script>
</body>
</html>
