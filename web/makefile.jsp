<%@ page language="java" 
	import="com.zhuozhengsoft.pageoffice.*,com.zhuozhengsoft.pageoffice.wordwriter.*,java.util.*,java.io.*,javax.servlet.*,javax.servlet.http.*"
	pageEncoding="gb2312"%>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

//******************************卓正PageOffice组件的使用*******************************

	WordDocument doc = new WordDocument();
	doc.openDataRegion("PO_ReceiveDate").setValue("2012年10月15日");
	doc.openDataRegion("PO_Job").setValue("技术总监");
	doc.openDataRegion("PO_Date").setValue("2013年2月25日");
	
	doc.openDataTag("【单位名称】").setValue("北京幻想科技有限公司");
	doc.openDataTag("{姓名}").setValue("张志成");
	
	
	FileMakerCtrl fmCtrl1 = new FileMakerCtrl(request);
	fmCtrl1.setServerPage("poserver.do"); //此行必须
	fmCtrl1.setSaveFilePage("savefile.jsp");//如要保存文件，此行必须
	fmCtrl1.setWriter(doc);
	//打开文件
	fmCtrl1.setJsFunction_OnProgressComplete("OnProgressComplete()");
	fmCtrl1.fillDocument(request.getSession().getServletContext().getRealPath("doc/test.doc"), DocumentOpenType.Word);
	fmCtrl1.setTagId("FileMakerCtrl1"); //此行必须	 
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
                window.parent.myFunc(); //调用父页面的js函数
                //如果需要在导出word文件成功之后弹出保存文件对话框，请取消对下面这句代码的注释
                //document.getElementById("FileMakerCtrl1").ShowDialog(2);
            }
    </script>
    <po:FileMakerCtrl id="FileMakerCtrl1" />
  </body>
</html>
