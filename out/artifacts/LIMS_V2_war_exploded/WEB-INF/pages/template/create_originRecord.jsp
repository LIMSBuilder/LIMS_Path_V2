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
    String delivery_id = request.getAttribute("delivery_id").toString();
    if(originRecordTemplate!=null){
        String path=originRecordTemplate.getStr("path");
        //���÷�����ҳ��
        poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
        poCtrl.setCaption(originRecordTemplate.getStr("name"));
        //����Զ��尴ť
        poCtrl.addCustomToolButton("����","Create",3);
        poCtrl.addCustomToolButton("����","Save",1);
        poCtrl.addCustomToolButton("��ӡ", "ShowPrintDlg()", 6);
        poCtrl.addCustomToolButton("-", "", 0);
        poCtrl.addCustomToolButton("ȫ���л�", "SwitchFullScreen()", 4);

        //���ñ���ҳ��
        poCtrl.setFileTitle(originRecordTemplate.getStr("name"));
        poCtrl.setSaveFilePage("/export/save?type=originRecord&&template_id="+originRecordTemplate.get("id")+"&&delivery_id="+delivery_id);
        //����ҳ��
        //��Word�ĵ�
        poCtrl.webOpen(path,OpenModeType.docNormalEdit, ParaUtils.getCurrentUser(request)!=null?ParaUtils.getCurrentUser(request).getStr("name"):"����");
        poCtrl.setTagId("PageOfficeCtrl1");//���б���
    }
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
                        alert("��ǰԭʼ��¼����ɹ���");
                    }
                    if(data.code == 504){
                        alert("δ�ܶ�λ��ǰ�����Ŀ����ˢ�º����³��ԣ�");
                    }
                    if(data.code == 502){
                        alert("�������쳣���޷����浱ǰԭʼ��¼����ˢ�º����³��ԣ�");
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
        document.getElementById("PageOfficeCtrl1").ShowDialog(4); //��ӡ�Ի���
    }
    function SwitchFullScreen() {
        document.getElementById("PageOfficeCtrl1").FullScreen = !document.getElementById("PageOfficeCtrl1").FullScreen;
    }
</script>
</body>
</html>
