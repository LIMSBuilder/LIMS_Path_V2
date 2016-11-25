<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@ page import="com.zhuozhengsoft.pageoffice.*"%>
<%@ page import="com.jfinal.kit.JsonKit" %>
<%
    String fileName = request.getAttribute("fileName").toString();
    String realPath = request.getSession().getServletContext().getRealPath("attachment/") + "\\" +fileName;
    System.out.println(realPath);
    FileSaver fs = new FileSaver(request, response);
    fs.saveToFile(realPath);
    Map result = new HashMap();
    result.put("code",200);
    result.put("path",realPath);
    result.put("fileName",request.getAttribute("name").toString());
    result.put("delivery_id",request.getAttribute("delivery_id"));
    fs.setCustomSaveResult(JsonKit.toJson(result));
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