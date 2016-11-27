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
    String delivery_id = request.getAttribute("delivery_id").toString();
    if(originRecordTemplate!=null){
        String path=originRecordTemplate.getStr("path");
        //设置服务器页面
        poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
        poCtrl.setCaption(originRecordTemplate.getStr("name"));
        //添加自定义按钮
        poCtrl.addCustomToolButton("生成","Create",3);
        poCtrl.addCustomToolButton("保存","Save",1);
        poCtrl.addCustomToolButton("打印", "ShowPrintDlg()", 6);
        poCtrl.addCustomToolButton("-", "", 0);
        poCtrl.addCustomToolButton("全屏切换", "SwitchFullScreen()", 4);

        //设置保存页面
        poCtrl.setFileTitle(originRecordTemplate.getStr("name"));
        poCtrl.setSaveFilePage("/export/save?type=originRecord&&template_id="+originRecordTemplate.get("id")+"&&delivery_id="+delivery_id);
        //设置页面
        //打开Word文档
        poCtrl.webOpen(path,OpenModeType.docNormalEdit, ParaUtils.getCurrentUser(request)!=null?ParaUtils.getCurrentUser(request).getStr("name"):"佚名");
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
    <!--弹出层-->
    <link href="/assets/css/jquery.gritter.css" rel="stylesheet">
    <title>实验室信息管理系统</title>

    <link href="/assets/css/style.default.css" rel="stylesheet">

</head>
<body>
<div style=" width:auto; height:auto;">
    <po:PageOfficeCtrl id="PageOfficeCtrl1">
    </po:PageOfficeCtrl>
</div>


<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--弹出层-->
<script src="/assets/js/jquery.gritter.min.js"></script>
<script type="text/javascript">
    function Create() {
        document.getElementById("PageOfficeCtrl1").WebSave();
        var result  = JSON.parse(document.getElementById("PageOfficeCtrl1").CustomSaveResult);
        if(result.code == 200){
            var data={
                delivery_id:result.delivery_id,
                name:result.fileName,
                path:result.path
            };
            jQuery.ajax({
                type: "POST",
                url: "/distribute/saveOriginRecord",
                data: data,
                success:function (data) {
                    if(data.code == 200){
                        alert("当前原始记录保存成功！");
                    }
                    if(data.code == 504){
                        alert("未能定位当前检查项目，请刷新后重新尝试！");
                    }
                    if(data.code == 502){
                        alert("服务器异常，无法保存当前原始记录，请刷新后重新尝试！");
                    }
                }
            });
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
