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
    Delivery_OriginRecord delivery_originRecord = (Delivery_OriginRecord)request.getAttribute("delivery_originRecord");
    String path =delivery_originRecord.getStr("originRecord_path");
//���÷�����ҳ��
    poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
    poCtrl.setFileTitle(delivery_originRecord.getStr("name"));
    poCtrl.setCaption(delivery_originRecord.getStr("name"));
//����Զ��尴ť
    poCtrl.addCustomToolButton("����","Save",1);
    poCtrl.addCustomToolButton("��ӡ", "ShowPrintDlg()", 6);
    poCtrl.addCustomToolButton("-", "", 0);
    poCtrl.addCustomToolButton("ȫ���л�", "SwitchFullScreen()", 4);

    //���ñ���ҳ��
    //poCtrl.setSaveFilePage("/export/save?type=originRecord&&template_id="+originRecordTemplate.get("id")+"&&delivery_id="+delivery_id);
    //poCtrl.setSaveFilePage("/export/save");
    //����ҳ��
    //��Word�ĵ�
    poCtrl.webOpen(path,OpenModeType.docReadOnly, ParaUtils.getCurrentUser(request)!=null?ParaUtils.getCurrentUser(request).getStr("name"):"����");
    poCtrl.setTagId("PageOfficeCtrl1");//���б���
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/assets/images/favicon.png" type="image/png">
    <!--������-->
    <link href="/assets/css/jquery.gritter.css" rel="stylesheet">
    <title>ʵ������Ϣ����ϵͳ</title>

    <link href="/assets/css/style.default.css" rel="stylesheet">

</head>
<body>
<div style=" width:auto; height:auto;">
    <po:PageOfficeCtrl id="PageOfficeCtrl1">
    </po:PageOfficeCtrl>
</div>


<script src="/assets/js/jquery-1.11.1.min.js"></script>
<!--������-->
<script src="/assets/js/jquery.gritter.min.js"></script>
<script type="text/javascript">
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
