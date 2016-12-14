<%@ page language="java"
         import="java.util.*,com.zhuozhengsoft.pageoffice.*"
         pageEncoding="gb2312"%>
<%@ page import="com.jfinal.core.JFinal" %>
<%@ page import="com.zhuozhengsoft.pageoffice.wordwriter.WordDocument" %>
<%@ page import="com.zhuozhengsoft.pageoffice.wordwriter.Table" %>
<%@ page import="com.contact.utils.ParaUtils" %>
<%@ page import="com.contact.model.*" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
    PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
    //��ȡRequest����
    Delivery delivery = (Delivery) request.getAttribute("delivery");
    String path =delivery.getStr("inspection_path");
    //���÷�����ҳ��
    poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
    //poCtrl.setFileTitle(path.substring(path.lastIndexOf("\\")+1));
    //poCtrl.setCaption(path.substring(path.lastIndexOf("\\")+1));
    //����Զ��尴ť
    poCtrl.addCustomToolButton("�޸�","Create",3);
    poCtrl.addCustomToolButton("����","Save",1);
    poCtrl.addCustomToolButton("��ӡ", "ShowPrintDlg()", 6);
    poCtrl.addCustomToolButton("-", "", 0);
    poCtrl.addCustomToolButton("ȫ���л�", "SwitchFullScreen()", 4);
    //��Word�ĵ�
    poCtrl.setSaveFilePage("/export/save?type=inspectionChange&&delivery_id="+delivery.get("id"));
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
        document.getElementById("PageOfficeCtrl1").WebSave();
        var result  = JSON.parse(document.getElementById("PageOfficeCtrl1").CustomSaveResult);
        if(result.code == 200){
            alert("��ǰ�ͼ쵥�޸ĳɹ���");
        }
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
