<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="com.zhuozhengsoft.pageoffice.*"%>
<%
String newFileName = "123.doc";
FileSaver fs = new FileSaver(request, response);
//fs.saveToFile(request.getSession().getServletContext().getRealPath("doc/") + "/" +newFileName);
fs.saveToFile("G:/abc.doc");
fs.close();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title></title>
</head>
<body>
    <div>
    
    </div>
</body>
</html>