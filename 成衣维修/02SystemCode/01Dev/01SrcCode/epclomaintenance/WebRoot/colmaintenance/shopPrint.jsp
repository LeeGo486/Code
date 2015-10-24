<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + request.getContextPath(); 
%>

<html:html>

<head>
<title>店铺打印</title>
<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/mycss/common.css" media="PRINT"/>

<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/mycss/common.css" />

<STYLE  MEDIA="PRINT">    
     .button {display:none;}
</STYLE>
<STYLE MEDIA="SCREEN">    
    .button {display:block;}
</STYLE>

</head>
<script>  
/**function previewPrint(){
	document.getElementById("printTool").style.display='none';
	wb.execwb(7,1);
	document.getElementById("printTool").style.display='block';
}

function doPrint(){
	document.getElementById("printTool").style.display='none';
	wb.execwb(6,6);
	document.getElementById("printTool").style.display='block';
	
}

function initForm(){
	opener.window.close();
}*/
 
 
function Preview() 
{
	
	try{
	
		if (document.all.eprint.defaultPrinterName.length==0){
			alert("请先安装打印机，再执行此功能！");
			return;
		}

  		eprint.InitPrint();
 		eprint.header = "";
  		eprint.footer = "";
  		eprint.Preview();
	}catch(e){
		var url=document.getElementById("webContext").value+'/colmaintenance/webprintDownload.jsp';
		window.open(url,'webprint打印控件下载','scrollbars=yes,width=400px,height=200px,resizable=yes,menubar=no,status=no,location=no');
	
	}
}

function Print() {  
	
	
	try{
			if (document.all.eprint.defaultPrinterName.length==0){
			alert("请先安装打印机，再执行此功能！");
			return;
	}

  	eprint.InitPrint();
  		eprint.header = "";
  		eprint.footer = "";
  		eprint.Print();
	//document.all.eprint.Print(true);//不弹出打印对话框直接打印
	}catch(e){
		initForm();
	
	}
}

function initForm(){
	try{
		if (document.all.eprint.defaultPrinterName.length==0){
		alert("请先安装打印机，再执行此功能！");
		
		}
	}
	catch(e){
	
		var url=document.getElementById("webContext").value+'/colmaintenance/webprintDownload.jsp';
		window.open(url,'webprint打印控件下载','scrollbars=yes,width=400px,height=200px,resizable=yes,menubar=no,status=no,location=no');
	}	
	 
	var dh = document.getElementById("dhspan").innerText; 
	var srcstr = 'http://192.168.0.43/barcode.bracodeServlet?image=1&type=21&data='+dh+'&height=50';  
	document.getElementById("dhtxmimg").src=srcstr;
}

 

 


 </script>

<body onload="initForm();">
	<!--   <OBJECT classid="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2" height=0 id="wb" name="wb" width=0></OBJECT> -->
	
	<!--  <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441" codebase="<%=request.getContextPath()%>/plug_tools/webprint.CAB#Version=3,0,0,13"  viewasext> </object>-->
	
	 <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441"  viewasext> </object>
	
	<html:form action="/shopPrint"
		styleId="shopPrintForm" method="post">
		
		<html:hidden property="webContext" value="<%=request.getContextPath()%>"/>
				
		<div id="printTool">
			<input type=button name=button_print class="button" value="打印" onclick="Print()" style="position:absolute;left:10px;top:10px;width:80px"> 
			<input type=button name=button_show  class="button" value="打印预览" onclick="Preview()" style="position:absolute;left:100px;top:10px;width:80px">
		</div>
		 
		
		<table width="90%"  align="center">
		
		
		<tr>
			<td width="40%">
				<%-- <img border="0" src="<%=path %>/mypicture/logo1.JPG"> --%>
			</td>
			
			<td align="center">
				<font size="5" style= "font-weight:bold ">店铺维修单</font>
				
			</td>
			<td align="right" width="40%">
				<!-- <font size="2px"> 维修单号&nbsp;<bean:write name="shopPrintForm" property="dh" /></font>   -->
				<span id="dhspan" style="display: none;"><bean:write name="shopPrintForm" property="dh"/></span> 
				<div>
					<img id='dhtxmimg'  alt="" src="" >
				</div> 
			</td>
		</tr>
		</table>
		
		<DIV align="center">
		<!-- <table width="100%" border="0" bgcolor=#000000 cellpadding="0" cellspacing="1"> -->  
			<table width="90%" class="table_thin" align="center">
			
				<!-- <tr>
					<td colspan="8" class="td_enabled">
						
						<html:checkbox styleClass="checkBox_1" value="E" property="PP" onclick="this.checked=!this.checked">EP</html:checkbox>
						
						<html:checkbox styleClass="checkBox_1" value="M" property="PP" onclick="this.checked=!this.checked">EM</html:checkbox>
						
						<html:checkbox styleClass="checkBox_1" value="T" property="PP" onclick="this.checked=!this.checked">TBF</html:checkbox>
						
						<html:checkbox styleClass="checkBox_1" value="F" property="PP" onclick="this.checked=!this.checked">Outlet</html:checkbox>
					</td>
				</tr> -->
				<tr>
					<td  width="10.5%" class="field_enabled">
						所属公司
					</td>
					<td colspan="7" width="18.5%" class="td_enabled">
						<bean:write name="shopPrintForm" property="PP"/>
					</td>
				</tr>

				<tr>
					<td rowspan="4" width="10.5%" class="field_enabled">
						店铺信息
					</td>
					<td width="12.5%" class="field_enabled">
						店铺名称
					</td>
					<td width="18.5%" class="td_enabled">
						<bean:write name="shopPrintForm" property="dpmc"/>
					</td>
					<td rowspan="4" width="10.5%" class="field_enabled">
						顾客信息
					</td>
					<td width="11.5%" class="td_enabled">
						
						<html:checkbox value="1" property="GKWX" onclick="this.checked=!this.checked" styleClass="checkBox_1"></html:checkbox>
					</td>
					<td width="12.5%" class="td_enabled">
						顾客维修
					</td>
					<td width="11.5%" class="td_enabled">
						
						<html:checkbox value="0" property="GKWX" onclick="this.checked=!this.checked" styleClass="checkBox_1"></html:checkbox>
					</td>
					<td width="12.5%" class="td_enabled">
						店铺维修
					</td>
				</tr>
				<tr>
					<td class="field_enabled">
						店长姓名
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="DZXM"/>
					
					</td>
					<td class="field_enabled">
						顾客名称
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="GKXM"/>
					</td>
					<td class="field_enabled">
						顾客电话
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="GKLXDH"/>
					</td>

				</tr>
				<tr>
					<td class="field_enabled">
						店铺电话
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="DZLXDH"/>
					</td>
					<td class="field_enabled">
						VIP卡号
					</td>
					<td colspan="3" class="td_enabled">
						<bean:write name="shopPrintForm" property="VIPKH"/>
					</td>


				</tr>
				<tr>
					<td class="field_enabled">
						受理导购
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="SLDG"/>
					</td>
					<td class="field_enabled">
						付费维修
					</td>
					<td class="td_enabled">
						
						<html:checkbox value="1" property="SFTYFFWX" onclick="this.checked=!this.checked" styleClass="checkBox_1">是</html:checkbox>
					</td>
					<td colspan="2" class="td_enabled">
						
						<html:checkbox value="0" property="SFTYFFWX" onclick="this.checked=!this.checked" styleClass="checkBox_1">否</html:checkbox>
					</td>
					

				</tr>
			
		</table>
		
		</DIV>
		<br />
		
		<DIV>
		<table width="90%" class="table_thin" align="center">
			<tbody>
				<tr>
					<td class="field_enabled" width="20%">
						款号
					</td>
					<td class="field_enabled" width="20%">
						颜色
					</td>
					<td class="field_enabled" width="20%">
						码数
					</td >
					<td class="field_enabled" width="20%">
						售出时间
					</td>
					<td class="field_enabled" width="20%">
						问题描述
					</td>
				</tr>
				<tr>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="KH"/>
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="YS"/>
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="MS"/>
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="SCSJ"/>
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="WTMS"/>
					</td>
				</tr>
				<tr>
					<td rowspan="2" class="field_enabled">
						物流信息
					</td>
					<td class="field_enabled">
						物流公司
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="YSGS"/>
					</td>
					<td class="field_enabled">
						物流单号
					</td>
					<td class="td_enabled">
						<bean:write name="shopPrintForm" property="YDH"/>
					</td>
				</tr>
				<tr>
					<td class="field_enabled">
						店铺地址
					</td>
					<td colspan="3" class="td_enabled">
						<bean:write name="shopPrintForm" property="FHDZ"/>
					
					</td>
				</tr>
			</tbody>
		</table>
		
		</DIV>
		
		<table width="90%" align="center">
		 <tr>
		 	<td align="left" colspan="2">
		 		<font color="red" size="2">备注：将此单与衣物一起寄出</font>
		 	</td>
		 </tr>		
		 <tr>
		  	<td width="80%" align="right">
		  		<font size="2"> 店长签字：</font>
		  	</td>
		 	 <td width="20%">
		 	</td>
		 </tr>
		 
		  <tr>
		  	<td width="80%" align="right">
		 	 	<font size="2"> 退回日期：</font>
		 	 </td>
		 	 <td align="left"><br>
		 	 	<font size="2">
		 	 	 
		 	 	</font>
		  	<br></td>
		 </tr>
		</table>
		
		</html:form>


</body>
</html:html>