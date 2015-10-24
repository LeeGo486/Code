<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>��ҵ��Ϣ�༭</title>
    
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/cmcommon.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script src="<%=path%>/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>

  </head>
  <script type="text/javascript">
  	$(function(){
  		$('#produceSettleBillDate').datebox();
  		$('#rcvTaxVoteEndDate').datebox();
  	
  	}); 
  	
  	function initForm(){
  		var result = $('#result').attr('value');
  		if(result=='1'){
  			alert('�����ɹ���');
  			window.opener.queryMarketArchives();
  			return;
  		}else if(result=='0'){
  			alert('����ʧ�ܣ�');
  			return;
  		}
  	}
  	
  
  </script>
  
  <body onload="initForm()">
    
    <input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
    <s:form action="/web/market-archives!save" method="post" theme="simple">
    	<s:hidden name="guid"></s:hidden>
    	<center>
  		<table  width="400" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
  		
  			<tr>
  				<td class="td_field">��ҵ���ƣ�</td>
  				<td class="td_text"><s:textfield name="marketName"></s:textfield> </td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">��ַ��</td>
  				<td class="td_text"><s:textfield name="marketUrl"></s:textfield> </td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">�û�����</td>
  				<td class="td_text"><s:textfield name="marketUsername"/></td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">���룺</td>
  				<td class="td_text"><s:textfield  name="marketPassword"/></td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">�����㵥���ڣ�</td>
  				<td class="td_text"><s:textfield id="produceSettleBillDate" name="produceSettleBillDate"/></td> 
  				
  			</tr>
  			<tr>
  				<td class="td_field">��˰Ʊ��ֹ���ڣ�</td>
  				<!-- <td class="td_text"><s:textfield  id="EDR" name="settleBill.EDR" onchange="changeSettleAmout()"> </s:textfield> -->
  				<td class="td_text"><s:textfield id="rcvTaxVoteEndDate" name="rcvTaxVoteEndDate" /></td>
  			</tr>
  			<tr>
  				<td class="td_field">��ע��</td>
  			<!-- 	<td class="td_text"><s:textfield id="settleAmount" name="settleBill.settleAmount" > </s:textfield> -->
  				<td class="td_text"><s:textfield name="comment" /> </td>
  			</tr>
  			
  			<tr>
  				<td colspan="2" align="center" >
  					<s:submit name="submit" value="�ύ"></s:submit>
  				</td>
  			</tr>
  		
  		</table>
  		</center>
    
    </s:form>
  </body>
</html>
