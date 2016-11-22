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


    //��ȡRequest����
    OriginRecordTemplate originRecordTemplate =  (OriginRecordTemplate) request.getAttribute("originRecord");
    String path ="";
    if(originRecordTemplate!=null){
        path=originRecordTemplate.getStr("path");
    }
//���÷�����ҳ��
    poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
//����Զ��尴ť
    poCtrl.addCustomToolButton("����","Create",3);
    poCtrl.addCustomToolButton("����","Save",1);
    poCtrl.addCustomToolButton("��ӡ", "ShowPrintDlg()", 6);
    poCtrl.addCustomToolButton("-", "", 0);
    poCtrl.addCustomToolButton("ȫ���л�", "SwitchFullScreen()", 4);

    //���ñ���ҳ��
    poCtrl.setSaveFilePage("/export/save");
    //����ҳ��
    //��Word�ĵ�
    poCtrl.webOpen(path,OpenModeType.docNormalEdit, ParaUtils.getCurrentUser(request)!=null?ParaUtils.getCurrentUser(request).getStr("name"):"����");
    poCtrl.setTagId("PageOfficeCtrl1");//���б���
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/assets/images/favicon.png" type="image/png">
    <title>ʵ������Ϣ����ϵͳ</title>

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
        document.getElementById("PageOfficeCtrl1").ShowDialog(4); //��ӡ�Ի���
    }
    function SwitchFullScreen() {
        document.getElementById("PageOfficeCtrl1").FullScreen = !document.getElementById("PageOfficeCtrl1").FullScreen;
    }
</script>
</body>
</html>
