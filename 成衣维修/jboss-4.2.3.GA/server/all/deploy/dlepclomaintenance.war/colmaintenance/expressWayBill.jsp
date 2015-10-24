<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>

<html:html>

<head>
	<title>快递单打印</title>
	
<STYLE  MEDIA="PRINT">    
     .button {display:none;}
</STYLE>
<STYLE MEDIA="SCREEN">    
    .button {display:block;}
</STYLE>
</head>
<script>
function Preview() 
{
	if (document.all.eprint.defaultPrinterName.length==0){
		alert("请先安装打印机，再执行此功能！");
		return;
	}
  eprint.InitPrint();
 
 eprint.orientation=2;
  eprint.header = "";
  eprint.footer = "";
  eprint.Preview();
}

function Print() {  
	if (document.all.eprint.defaultPrinterName.length==0){
		alert("请先安装打印机，再执行此功能！");
		return;
	}
  eprint.InitPrint();
 // eprint.orientation=2;
  eprint.header = "";
  eprint.footer = "";
  eprint.Print();
	//document.all.eprint.Print(true);//不弹出打印对话框直接打印
}

</script>
<body>
	<!--  <OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0 id="wb" name="wb" width=0></OBJECT>  -->
	<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" viewasext> </object>
	
	<html:form action="/expressWayBill" method="post" styleId="expressWayBillForm">
		
     
		
		<div id="printTool">
			<input type=button name=button_print class="button" value="打印" onclick="Print()" style="position:absolute;left:10px;top:10px;width:80px"> 
			<input type=button name=button_show  class="button" value="打印预览" onclick="Preview()" style="position:absolute;left:100px;top:10px;width:80px">
		</div>
		
		<br />
		<table width="786" align="center" style="position:absolute;left:100px;">
			<tr height="60">
			<td align="left"  width="300"><font size="2"> <bean:write name="expressWayBillForm" property="SHR"/> </font> </td>
			<td align="left"  width="300"><font size="2"> <bean:write name="expressWayBillForm" property="DZXM"/>  </font></td>
			<td align="left" width="186"> <font size="2"> <bean:write name="expressWayBillForm" property="DZLXDH" /> </font></td>
			</tr>
		
		
		<tr height="60">
			<td align="center"><font size="2">浙江雅莹服装有限公司</font> </td>
			<td align="left"> <font size="2"><bean:write name="expressWayBillForm" property="dpmc"/></font>  </td>
			<td></td>
		
		</tr>
		
		
		<tr height="20">
			<td align="left"> <font size="2"><bean:write name="expressWayBillForm" property="SHDZ" /></font>  </td>
			<td align="left">  <font size="2"><bean:write name="expressWayBillForm" property="FHDZ" /> </font> </td>
			<td></td>
		</tr>
		
		<tr height="30">
			<td align="center"><font size="2"> <bean:write name="expressWayBillForm" property="SHRLXDH"/></font> </td>
			<td align="center"></td>
			<td></td>
		</tr>
		
		</table>
	</html:form>
</body>
</html:html>