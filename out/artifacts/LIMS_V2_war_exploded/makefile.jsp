<%@ page language="java" 
	import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*,java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*"
	pageEncoding="gb2312"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//******************************׿��PageOffice�����ʹ��*******************************

	WordDocument doc = new WordDocument();
	doc.openDataRegion("PO_ReceiveDate").setValue("2012��10��15��");
	doc.openDataRegion("PO_Job").setValue("�����ܼ�");
	doc.openDataRegion("PO_Date").setValue("2013��2��25��");
	
	doc.openDataTag("����λ���ơ�").setValue("��������Ƽ����޹�˾");
	doc.openDataTag("{����}").setValue("��־��");
	
	
	FileMakerCtrl fmCtrl1 = new FileMakerCtrl(request);
	fmCtrl1.setServerPage("poserver.do"); //���б���
	fmCtrl1.setSaveFilePage("savefile.jsp");//��Ҫ�����ļ������б���
	fmCtrl1.setWriter(doc);
	//���ļ�
	fmCtrl1.setJsFunction_OnProgressComplete("OnProgressComplete()");
	fmCtrl1.fillDocument(request.getSession().getServletContext().getRealPath("doc/test.doc"), DocumentOpenType.Word);
	fmCtrl1.setTagId("FileMakerCtrl1"); //���б���	 
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
    This is my JSP page. 
    <script language="javascript" type="text/javascript">
            function OnProgressComplete() {
                window.parent.myFunc(); //���ø�ҳ���js����
                //�����Ҫ�ڵ���word�ļ��ɹ�֮�󵯳������ļ��Ի�����ȡ���������������ע��
                //document.getElementById("FileMakerCtrl1").ShowDialog(2);
            }
    </script>
    <po:FileMakerCtrl id="FileMakerCtrl1" />
  </body>
</html>
