	<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>录入结算单页面</title>
    
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/cmcommon.css" />
   
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/demo/demo.css">
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>

	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
  	<script src="<%=path%>/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>

  </head>
  <script type="text/javascript">
  	//function save(){
  		//document.forms[0].submit();
  	//}
  	function initForm(){
  		var rs = $('#result').attr('value');
  		//alert(rs);
  		if(rs=='1'){
  			window.opener.freshDataGrid();
  			//$.messager.
  			alert("保存成功！");
  			return;
  		}else if(rs=='0'){
  			//$.messager.
  			alert("保存失败！");
  		}
  	}
  	
  	function viewAttacth(){
  		var settleBillID = $('#settleID').attr('value');
  		var fileName = $('#settleAttachmentName').attr('value');
  		if(fileName==null || fileName==''){
  			alert('不存在结算单附件');
  			return;
  		}
  		var index = fileName.lastIndexOf('.');
  		var suffix = fileName.substring(index+1).toUpperCase();
  	//var suffix = fileName.split('.')[1];
  		if(suffix=='JPG' || suffix=='JPEG' || suffix=='GIF'||suffix=='PNG' || suffix=='BMP' || suffix=='TIFF' || suffix=='RAW'){
  			var url = $('#path').attr('value')+'/mr/main/viewSettleAttachment.jsp?settleBillID='+settleBillID;
  			window.open(url, "图片显示", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  		}else{
  			var url = $('#path').attr('value')+'/rest/settleBill/downAttachment/'+settleBillID;
  			window.open(url, "图片显示", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
  		}
  	}
  	
  	function checkAmoutBal(obj){
  		var noteAmout = $('#noteAmount').attr('value');
  		var loanAmout = $('#loanAmout').attr('value');
  		var innerDiscountAmout = $('#innerDiscountAmout').attr('value');
  		var objValue = $(obj).attr('value');
  		
  		if(objValue!=''&&noteAmout!=''&&parseFloat(objValue)>parseFloat(noteAmout)){
  			alert('内扣金额或者货款金额不能大于开票金额！');
  			/* $(obj).attr('value','');
  			return; */
  		}
  		
  		if(objValue!=''){
  		
  		
	  		if(isNaN(objValue)){
	  			alert('只允许输入数值!');
	  			$(obj).attr('value','');
	  			return;
	  		}
	  		if((noteAmout!=null&&noteAmout!='')&&(loanAmout!=null&&loanAmout!='')&&(innerDiscountAmout!=null&&innerDiscountAmout!='')){
	  			if(parseFloat(noteAmout)!=parseFloat(loanAmout)+parseFloat(innerDiscountAmout)){
	  				alert('金额没有填写正确，开票金额必须等于货款金额与内扣金额之和！');
	  				return;
	  			}
	  		}else if((noteAmout!=null&&noteAmout!='')&&(loanAmout!=null&&loanAmout!='')){
	  			$('#innerDiscountAmout').attr('value',(parseFloat(noteAmout)-parseFloat(loanAmout)).toFixed(2));
	  			
	  		}else if((noteAmout!=null&&noteAmout!='')&&(innerDiscountAmout!=null&&innerDiscountAmout!='')){
	  			$('#loanAmout').attr('value',(parseFloat(noteAmout)-parseFloat(innerDiscountAmout)).toFixed(2));
	  		}else if((loanAmout!=null&&loanAmout!='')&&(innerDiscountAmout!=null&&innerDiscountAmout!='')){
	  			$('#noteAmout').attr('value',(parseFloat(loanAmout)+parseFloat(innerDiscountAmout)).toFixed(2));
	  		}
  		}
  	}
  	
  	function changeSettleAmout(){
  		var settleAmount = parseFloat($('#EDR').attr('value'))*parseFloat($('#s_price').attr('value'));
  		$('#settleAmount').attr('value',parseFloat(settleAmount).toFixed(2));
  	}
  </script>
  <body onload="initForm()">
  	<input type="hidden" id="path" value="<%=request.getContextPath()%>"> 
  	<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
  	<s:form action="/web/settle-bill-input!saveSettleBill" method="post" theme="simple" enctype="multipart/form-data">
  		
  		<s:hidden name="settleBill.acctPeriodID"></s:hidden>
  		<s:hidden name="settleBill.settleYm"></s:hidden>
  		<s:hidden name="settleBill.depotName"></s:hidden>
  		<s:hidden name="settleBill.depotNo"></s:hidden>
  		<s:hidden name="settleBill.CDR"></s:hidden>
  		<s:hidden id="settleID" name="settleBill.guid"></s:hidden>
  		<s:hidden name="settleBill.settleAttachmentPath"></s:hidden>
  		<s:hidden id="settleAttachmentName" name="settleBill.settleAttachmentName"></s:hidden>
  		
  		<s:hidden name="settleBill.acctPeriodDate"></s:hidden>
  		<s:hidden name="settleBill.saleNum"></s:hidden>
  		<s:hidden name="settleBill.j_price"></s:hidden>
  		<s:hidden name="settleBill.EDR"></s:hidden>
  		<s:hidden name="settleBill.settleAmount"></s:hidden>

  		<s:hidden id="s_price" name="settleBill.s_price"></s:hidden>
  		<center>
  		<table   border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
  			<tr>
  				<td class="td_field">年月：<s:property value="settleBill.settleYm"/> </td>
  				<td class="td_field">店铺：<s:property value="settleBill.depotName"/></td>
  			</tr>
  			<tr>
  				<td class="td_field">结账期:</td>
  				<td class="td_text"><s:property value="settleBill.acctPeriodDate"/></td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">销售数量:</td>
  				<td class="td_text"><s:property value="settleBill.saleNum"/></td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">原价金额:</td>
  				<td class="td_text"><s:property value="settleBill.j_price"/></td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">POS实销:</td>
  				<td class="td_text"><s:property  value="settleBill.s_price"/></td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">合同扣率:</td>
  				<td class="td_text"><s:property value="settleBill.CDR"/></td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">预估扣率：</td>
  				<!-- <td class="td_text"><s:textfield  id="EDR" name="settleBill.EDR" onchange="changeSettleAmout()"> </s:textfield> -->
  				<td class="td_text"><s:property  value="settleBill.EDR" /></td>
  			</tr>
  			<tr>
  				<td class="td_field">预估结算：</td>
  			<!-- 	<td class="td_text"><s:textfield id="settleAmount" name="settleBill.settleAmount" > </s:textfield> -->
  				<td class="td_text"><s:property value="settleBill.settleAmount" /> </td>
  			</tr>
  			<tr>
  				<td class="td_field">商场实销：</td>
  				<td class="td_text"> <s:textfield type="text" name="settleBill.marketSaleAmount"> </s:textfield></td>
  			</tr>
  			<tr>
  				<td class="td_field">实际结算：</td>
  				<td class="td_text"><s:textfield type="text" id="noteAmount" name="settleBill.noteAmount" onchange ="checkAmoutBal(this)"></s:textfield></td>
  			</tr>
  			<tr>
  				<td class="td_field">货款金额：</td>
  				<td class="td_text"><s:textfield type="text" id="loanAmout" name="settleBill.loanAmout" onchange ="checkAmoutBal(this)"> </s:textfield></td>
  			</tr>
  			<tr>
  				<td class="td_field">内扣金额：</td>
  				<td class="td_text"><s:textfield type="text" id="innerDiscountAmout" name="settleBill.innerDiscountAmout" onchange ="checkAmoutBal(this)"> </s:textfield></td>
  			</tr>
  			<tr>
  				<td class="td_field">结算单附件：</td>
  				<td class="td_text"><s:file name="file"></s:file><br> <a onclick="viewAttacth()"><s:property value="settleBill.settleAttachmentName"/> </a> </td>
  				
  			</tr>
  			<tr>
  				<td class="td_field">备注</td>
  				<td class="td_text"><s:textarea name="settleBill.remark"  rows="5"></s:textarea> </td>
  			</tr>
  			<tr>
  				<td class="td_field">物业URL</td>
  				<td class="td_text">
  					<%List<Map> list = (List)request.getAttribute("marketMapList");
  					if(list!=null){
  					 for(Map map:list){
  					 	if(map.get("marketUrl")!=null && !"".equals(map.get("marketUrl"))&&!"null".equalsIgnoreCase((String)map.get("marketUrl"))){
  					 	
  					 	%>
  					 	<a href="<%=map.get("marketUrl")%>" target="_blank"><%=map.get("marketUrl")%></a><br>
  					 
  					 <% }
  					 }}
  					%>
  				</td>
  			</tr>
  			
  			<tr>
  				<td colspan="2" align="center" >
  					<s:submit name="submit" value="提交"></s:submit>
  				</td>
  			</tr>
  		
  		</table>
  		</center>
  	</s:form>
  </body>
</html>
