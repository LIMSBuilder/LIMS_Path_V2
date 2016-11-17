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
<%@ taglib uri="http://java.pageoffice.cn" prefix="po"%>
<%
    PageOfficeCtrl poCtrl=new PageOfficeCtrl(request);
//���÷�����ҳ��
    poCtrl.setServerPage(request.getContextPath()+"/poserver.zz");
//����Զ��尴ť
    poCtrl.addCustomToolButton("����","Save",1);
    poCtrl.addCustomToolButton("��ӡ", "ShowPrintDlg()", 6);
    poCtrl.addCustomToolButton("-", "", 0);
    poCtrl.addCustomToolButton("ȫ���л�", "SwitchFullScreen()", 4);

    //�������
    WordDocument doc = new WordDocument();
    Map<String,String> entry =(Map<String, String>) request.getAttribute("entry");
    for(String name:entry.keySet()){
        doc.openDataRegion("PO_"+name).setValue(entry.get(name));
    }
    List<Map> tableData = (List<Map>)request.getAttribute("table");
    Table table = doc.openDataRegion("PO_T001").openTable(1);
    int oldRowCount =7;
    int dataRowCount=tableData.size();
    for (int j = 0; j < dataRowCount - oldRowCount; j++)
    {
        table.insertRowAfter(table.openCellRC(14, 6));
    }
    for(int i=8;i<=7+dataRowCount;i++){
        Map temps = tableData.get(i-8);
        List<Monitor_Project> projects =  (List)temps.get("monitor_item_text");
        String tempProject="";
        for(int m=0;m<projects.size();m++){
            tempProject+=projects.get(m).getStr("name")+" ";
        }
        table.openCellRC(i,2).setValue(((Monitor_Category)temps.get("environment_text")).getStr("name"));
        table.openCellRC(i,3).setValue(temps.get("monitor_point").toString().split(";").length+"");
        table.openCellRC(i,4).setValue(tempProject);
        table.openCellRC(i,5).setValue(temps.get("frequency").toString());
        table.openCellRC(i,6).setValue(temps.get("other").toString());
    }
    poCtrl.setWriter(doc);
    //���ñ���ҳ��
    poCtrl.setSaveFilePage("/export/save");
    //����ҳ��
    poCtrl.setCaption(entry.get("project_name"));
    poCtrl.setFileTitle(entry.get("project_name"));
//��Word�ĵ�
    poCtrl.webOpen("/doc/contract.doc",OpenModeType.docNormalEdit, ParaUtils.getCurrentUser(request)!=null?ParaUtils.getCurrentUser(request).getStr("name"):"����");
    poCtrl.setTagId("PageOfficeCtrl1");//���б���
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>��ͬ����</title>
</head>
<body>
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
<form id="form1" >
    <div style=" width:auto; height:auto;">
        <po:PageOfficeCtrl id="PageOfficeCtrl1">
        </po:PageOfficeCtrl>
    </div>
</form>
</body>
</html>
