<%--
  Created by IntelliJ IDEA.
  User: ������
  Date: 2016/11/14
  Time: 22:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java"
         import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*,java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*"
         pageEncoding="gb2312"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//******************************׿��PageOffice�����ʹ��*******************************

    String id = request.getAttribute("id").toString();
    System.out.println("��������idΪ"+id);
    WordDocument doc = new WordDocument();
    doc.openDataRegion("PO_ReceiveDate").setValue("2012��10��15��");
    doc.openDataRegion("PO_Job").setValue("�����ܼ�");
    doc.openDataRegion("PO_Date").setValue("2013��2��25��");

    doc.openDataTag("����λ���ơ�").setValue("��������Ƽ����޹�˾");
    doc.openDataTag("{����}").setValue("��־��");


    FileMakerCtrl fmCtrl1 = new FileMakerCtrl(request);
    fmCtrl1.setServerPage("/poserver.do"); //���б���
    fmCtrl1.setSaveFilePage("/savefile.jsp");//��Ҫ�����ļ������б���
    fmCtrl1.setWriter(doc);
    //���ļ�
    fmCtrl1.setJsFunction_OnProgressComplete("OnProgressComplete()");
    fmCtrl1.fillDocument(request.getSession().getServletContext().getRealPath("doc/test.doc"), DocumentOpenType.Word);
    fmCtrl1.setTagId("FileMakerCtrl1"); //���б���
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<script language="javascript" type="text/javascript">
    function OnProgressComplete() {
        debugger
        window.location.href="/export/save?id="+id;
        //�����Ҫ�ڵ���word�ļ��ɹ�֮�󵯳������ļ��Ի�����ȡ���������������ע��
        //document.getElementById("FileMakerCtrl1").ShowDialog(2);
    }
</script>
<po:FileMakerCtrl id="FileMakerCtrl1" />
</body>
</html>
