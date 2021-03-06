<%@ page language="java"
         import="java.util.*,com.zhuozhengsoft.pageoffice.*"
         pageEncoding="gb2312" %>
<%@ page import="com.jfinal.core.JFinal" %>
<%@ page import="com.zhuozhengsoft.pageoffice.wordwriter.WordDocument" %>
<%@ page import="com.zhuozhengsoft.pageoffice.wordwriter.Table" %>
<%@ page import="com.contact.utils.ParaUtils" %>
<%@ page import="com.contact.model.*" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%
    PageOfficeCtrl poCtrl = new PageOfficeCtrl(request);
    //获取Request数据
    Delivery_OriginRecord delivery_originRecord = (Delivery_OriginRecord) request.getAttribute("delivery_originRecord");
    if(delivery_originRecord!=null){
        String path = delivery_originRecord.getStr("originRecord_path");
        //设置服务器页面
        poCtrl.setServerPage(request.getContextPath() + "/poserver.zz");
        poCtrl.setFileTitle(delivery_originRecord.getStr("name"));
        poCtrl.setCaption(delivery_originRecord.getStr("name"));
        poCtrl.setSaveFilePage("/export/save?type=originRecordChange?record_id=" + delivery_originRecord.get("id"));
        //添加自定义按钮
        poCtrl.addCustomToolButton("修改","Create",3);
        poCtrl.addCustomToolButton("保存", "Save", 1);
        poCtrl.addCustomToolButton("打印", "ShowPrintDlg()", 6);
        poCtrl.addCustomToolButton("-", "", 0);
        poCtrl.addCustomToolButton("全屏切换", "SwitchFullScreen()", 4);
        //打开Word文档
        poCtrl.setSaveFilePage("/export/save?type=originRecordChange&&record_id="+delivery_originRecord.get("id"));
        poCtrl.webOpen(path, OpenModeType.docNormalEdit, ParaUtils.getCurrentUser(request) != null ? ParaUtils.getCurrentUser(request).getStr("name") : "佚名");
        poCtrl.setTagId("PageOfficeCtrl1");//此行必需
    }
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
        document.getElementById("PageOfficeCtrl1").WebSave();
        var result  = JSON.parse(document.getElementById("PageOfficeCtrl1").CustomSaveResult);
        if(result.code == 200){
            alert("当前原始记录修改成功！");
        }
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
