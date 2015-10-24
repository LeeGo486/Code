<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>客户短信批量发送</title>

	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		/*td {font-size: 12}*/
		input {font-size: 12}
		select {font-size: 12}
		.td_field{background-color:white;
		  font-size: 12;
		  font-weight: 700;
		 }
		 .td_text{background-color:white;
			  text-align: left;
			   font-size: 12;
		}
	</style>
	
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script language="javascript" src="<%=path%>/myjs/myTime2.js"></script>
	<script language="javascript" src="<%=path%>/myjs/insertText.js"></script>
  	
  </head>
  <script type="text/javascript">
 // var insertPos = 0;
  function preViewContent(){
  		var batchNo = $('#batchNO').attr('value');
  		var type = $('#msgType').attr('value');
  		var preContent = $('#content').attr('value');
  		var para = new Object();
  		para["smsContent"] = preContent;
  		para["type"] = type;
  		para["batchNo"] = batchNo;
		$.post(
				$('#path').attr('value') + '/customerSMSBatchSend.do?method=preViewSMSContent',para,
				function(rsp) {
					$('#viewContent').attr("value",rsp);
					$('#preViewSMSContent').show();	
					
				}, "text").error(function() {
			alert("获取详细信息失败！");
		});
  }
  
  function sendMsg(){
  	$('#sendButton').attr('disabled','disabled');
  	$('#waitDiv').show();
  	document.forms[0].submit();
  	
  }
  
  function insertContentCode(){
  		var insertText ='@'+ $('#insertCode').val()+'@';
  		$('#content').insert({'text':insertText});
  }
  
  //function checkInsertPos(){
  
  //}
  
  function hiddenDetail(){
		$('#preViewSMSContent').hide();	
  }
  
  function initForm(){
  		var result = $('#result').attr('value');
		if(result=='0'||result=='-1'||result=='-2'||result=='-3'){
			alert('操作失败');
			return;
		}
		if(result=='1'){
			alert('操作成功');
			return;
		}
		if(result=='2'){
			alert('部分操作成功');
			return;
		}
  }
  </script>
  <body onload="initForm()">
      <input type="hidden" id="path" value="<%=path%>">
      <input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
      <div >
      <html:form styleId="customSMSBatchForm" action="/customerSMSBatchSend.do" method="post">
          <html:hidden styleId="method" property="method" value="batchSend"/>
          <html:hidden styleId="batchNO" property="batchNO"/>
          <html:hidden styleId="msgType" property="msgType"/>
          
          <center>
          <table width="680"  border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
          	<tr>
          		<td colspan="2" align="center">
          		<font size="4"><b>	客户短信批量发送</b></font>
          		</td>
          	</tr>
          	
          	<tr>
          		<td width="80" class="td_field">短信主题：</td>
          		<td width="600" class="td_text"><html:text styleId="subject" property="subject" style="width: 200"></html:text> </td>
          	</tr>
          	<tr>
          		<td class="td_field">插入变量：</td>
          		<td class="td_text"> <html:select styleId="insertCode" property="insertCode"> <html:optionsCollection name="selectList" value="code" label="lable"/> </html:select>
          			<input type="button" value="插入" onclick="insertContentCode()">
          		</td>
          	</tr>
          	<tr>
          		<td class="td_field">短信内容：</td>
          		<td class="td_text"><html:textarea styleId="content" property="content" cols="55" rows="13"></html:textarea> </td>
          	</tr>
          	<tr>
          		<td class="td_field">发送时间：</td>
          		<td class="td_text"><html:text property="sendDate" onclick="setday(this)" style="width: 200" readonly="true"></html:text> </td>
          	</tr>
          	<tr>
          		
          		<td align="center" colspan="2">
          			<input type="button" value="随机预览" onclick="preViewContent()" >
          			<input id="sendButton" type="button" value="确定发送" onclick="sendMsg()">
          		</td>
          	</tr>
          </table>
      		</center>
      </html:form>
      
      
      <div id="preViewSMSContent" style="position:absolute; display: none;background-color: #F3F4F3;height: 300;width:500;overflow: auto;border-color: gray;border-style: solid;border: 2;top:30;left:350;z-index: 2; text-align: center;">
      	<table width="480">
      		<tr>
      			<td align="left"><font size="4"><b>短信内容预览</b></font> </td>
      			<td align="right">
      				<input type="button" value="关闭" onclick="hiddenDetail()">
      			
      		</tr>
      		
      		<tr align="left">
      			<td colspan="2">
      				<textarea id="viewContent" rows="13" cols="55" readonly="readonly"></textarea>
      			</td>
      		</tr>
      	
      	</table>
      </div>
      
      </div>
      
      <div id="waitDiv" style="position:absolute; display: none;overflow: auto;border-color: gray;border-style: solid;border: 2;top:200;left:500;z-index: 3; text-align: center;vertical-align: middle;" >
      	 <font size="2">正在发送，请稍等<br></font> 
      	<img  src="../img/13221810.gif">
      </div>
  </body>
</html>
