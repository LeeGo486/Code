<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort() + request.getContextPath(); %>

<html:html>

<head>
<title>发送总部</title>
<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/mycss/common.css" />


</head>
<script>
var xmlhttp;
  function getShopInfo(){
  	
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    		var shopInfos = eval("(" + xmlhttp.responseText + ")");
    		
    		
    		document.getElementById("FHDZ").value=shopInfos[0].address;
    		document.getElementById("SHDZ").value=shopInfos[0].receiveaddress;
    		document.getElementById("SHR").value=shopInfos[0].receivename;
    		document.getElementById("SHRLXDH").value=shopInfos[0].receivetel;
    	}
 	}
 	var shopID = document.getElementById("dpbm").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=getShopInfo&shopID="+shopID);
	
  }
  
  function saveAndSendHQ(){
  	  var ysgs = document.getElementById('YSGS').value;
  	  var ydh = document.getElementById('YDH').value;
  	  var FHDZ = document.getElementById('FHDZ').value;
  	  var SHDZ = document.getElementById('SHDZ').value;
  	  var SHR = document.getElementById('SHR').value;
  	  var SHRLXDH = document.getElementById('SHRLXDH').value;
  	  var BZXX = document.getElementById('BZXX').value;
  	  var dh = document.getElementById('dh').value;
  	  var guid = document.getElementById('guid').value;
  	  if(ysgs==null || ysgs==''){
  	      alert('请正确选择运输公司！');
  	  	  return;
  	  }
  	  if(ydh==null || ydh==''){
  	      alert('请正确填写运单号！');
  	  	  return;
  	  }
  	  
  	 // opener.document.getElementById('YSGS').vaule=ysgs;
      //opener.document.getElementById('YDH').value=ydh;
      
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('YSGS').value=ysgs;
     
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('YDH').value=ydh;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('FHDZ').value=FHDZ;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('SHDZ').value=SHDZ;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('SHR').value=SHR;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('SHRLXDH').value=SHRLXDH;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('BZXX').value=BZXX;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('dh').value=dh;
     
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.forms[0].submit();
    
      window.opener.document.getElementById('guid').value=guid;
      //alert(window.opener.document.getElementById('guid').value);
      opener.document.getElementById('method').value="sendToHQ";
      //setTimeout("opener.document.forms[0].submit()",3000);
      //setTimeout("parentDpPrint()",3200);
      document.getElementById("send").disabled=true;
      document.getElementById("cancle").disabled=true;
     
      window.close();	
      
      }
  /**function parentDpPrint(){
  	var webContext = document.getElementById('webContext').value;
			//alert(document.getElementById('guid').value);
	var url=webContext+"/shopPrint.do?method=getShopPrintData&guid="+document.getElementById('guid').value;
	//window.open(url, "店铺打印", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  	//alert(document.getElementById('guid').value);
  	window.location.href=url;
  	//opener.dpPrint();
  }*/
  function cancalSendHQ(){
       var ysgs = document.getElementById('YSGS').value;
  	  var ydh = document.getElementById('YDH').value;
  	  var FHDZ = document.getElementById('FHDZ').value;
  	  var SHDZ = document.getElementById('SHDZ').value;
  	  var SHR = document.getElementById('SHR').value;
  	  var SHRLXDH = document.getElementById('SHRLXDH').value;
  	  var BZXX = document.getElementById('BZXX').value;
  	  var dh = document.getElementById('dh').value;
  	  var guid = document.getElementById('guid').value;
  	  
  	   opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('YSGS').value=ysgs;
     
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('YDH').value=ydh;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('FHDZ').value=FHDZ;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('SHDZ').value=SHDZ;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('SHR').value=SHR;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('SHRLXDH').value=SHRLXDH;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('BZXX').value=BZXX;
      opener.document.getElementById('maintenanceParticularInfo').contentWindow.document.getElementById('dh').value=dh;
     
      window.opener.document.getElementById('guid').value=guid;
      window.close();	
  }
</script>

<body onload="getShopInfo()">
	<html:form action="/shopLogisticsBill" styleId="shopLogisticsBillForm" method="post">
		<html:hidden property="webContext" value="<%=request.getContextPath()%>"/>
		<html:hidden property="dpbm"/>
		<html:hidden property="guid"/>
		<html:hidden property="dh"/>
		
		<p align="center"><font size="5" style= "font-weight:bold ">店铺物流单</font></p>
		
		 <p align="right"><font size="3"> 维修单号<bean:write name="shopLogisticsBillForm" property="dh"/></font></p>
		<DIV>
		<table class="table_thin" width="100%">
			<tr>
						<td rowspan="4" class="field_enabled" width="20%">
							物流信息
						</td>
						<td class="field_enabled" width="20%">
							运输公司
						</td>
						<td class="td_enabled" width="20%">
							
							<html:select property="YSGS" styleClass="text_enabled">
								<html:optionsCollection name="transCoList" label="transCoName" value="transCoCode"/>
							</html:select>
							
						</td>
						<td class="field_enabled" width="20%">
							运单号
						</td>
						<td colspan="2" class="td_enabled" width="20%">
							
							<html:text property="YDH" styleClass="text_enabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							发货地址
						</td>
						<td colspan="4" class="td_enabled">
							
							<html:text property="FHDZ" styleClass="text_enabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							收货地址
						</td>
						<td colspan="4" class="td_enabled">
							
							<html:text property="SHDZ" styleClass="text_enabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							收货人
						</td>
						<td class="td_enabled">
							
							<html:text property="SHR" styleClass="text_enabled"></html:text>
						</td>
						<td class="field_enabled">
							收货人联系电话
						</td>
						<td colspan="2" class="td_enabled">
							
							<html:text property="SHRLXDH" styleClass="text_enabled"></html:text>
						</td>

					</tr>



					<tr>
						<td class="field_enabled">
							备注
						</td>
						<td colspan="5" class="td_enabled">
							
							<html:textarea property="BZXX" styleClass="text_enabled"></html:textarea>
						</td>
					</tr>

				
			</table>
		    
		</DIV>
		
		<DIV align="right">
			<html:button property="send" onclick="saveAndSendHQ()">确定</html:button>
		    <html:button property="cancle" onclick="cancalSendHQ()">取消</html:button>
		</DIV>
	</html:form>


</body>
</html:html>