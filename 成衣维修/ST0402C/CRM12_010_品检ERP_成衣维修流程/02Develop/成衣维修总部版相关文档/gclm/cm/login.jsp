<%@ page language="java" contentType="text/html; charset=GBK" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>�ܲ�����ά�޵�¼</title>
    
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cmcommon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/src/jquery.parser.js"></script>

  </head>
  <script type="text/javascript">
  
  	function login(){
  		var com = $('#com').attr('value');
  		if(com==null || com==''){
  			$.messager.alert("��ʾ","����ѡ��˾");
  			return;
  		}
  		
  		var userid = $('#userid').attr('value');
  		if(userid==null || userid==''){
  			$.messager.alert("��ʾ","�û�������Ϊ��");
  			return;
  		}
  		
  		var password = $('#password').attr('value');
  		if(password==null || password==''){
  			$.messager.alert("��ʾ","���벻��Ϊ��");
  			return;
  		}
  		document.forms[0].submit();
  	}
  	
  	function getHistoryCom(){
  		var object = new Object();
  		var userid = $('#userid').attr('value');
  		if(userid=='' || userid==null){
  			userid='-1';
  		}
  		$.post(	$('#webContext').attr('value')+ '/rest/User/getHistoryCom/'+userid,object,function(rsp) {
							var stringArray = rsp.split(',');
							$('#com').attr('value',stringArray[0]);
							$('#logid').attr('value',stringArray[1]);
							//}
						},'text').error(function() {
											$.messager.alert("��ʾ","�����쳣������ϵIT��ά��");
						});
						
  	}
  
   function initFrom(){
       
	   document.getElementById("userid").focus();
       var rs = $('#result').attr('value');
       if(rs=='0'){
           alert('�û��������벻��ȷ��');
       }
       setTimeout('getHistoryCom()', 500);
       
   }
   
   function enterSumbit(){  
	      var event=arguments.callee.caller.arguments[0]||window.event;//�������������  
	     if (event.keyCode == 13){  
	        login();  
	     }  
	 }  
   


  </script>
  <body onload="initFrom()">
 	<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
 	<input type="hidden" id="webContext" value="<%=path%>">
 	<s:form  id="loginForm" action="/web/login!login" method="post">
    	<s:hidden id="logid" name="logid" ></s:hidden>
   
    <div style="position:absolute;  width: 100%;top: 0px; " align="center">
    	 
    	 <center>
    	<div style="position: relative;width:1024; " >
    	
   		<img alt="" src="<%=path %>/img/loginmain.jpg">
   		<div style="position:relative; top: -355;left: 330" >
   			<s:textfield label="�û���" id="userid" name="userInfo.userid" width="100" onchange="getHistoryCom()" theme="simple"   onkeydown="enterSumbit()"/>
   		</div> 
    	
    	<div style="position:relative; top: -333;left: 330">
   			<s:password label="����" id="password" name="userInfo.password" width="100" theme="simple" onkeydown="enterSumbit()"></s:password>
   		</div > 
   		<div style="position:relative; top: -310;left: 330">
   			<select id="com" name="userInfo.com"  style="width:130">
   				<option value=""></option>
   				<option value="��Ө">��Ө</option>
   				<option value="����">����</option>
   				<option value="�ɻ�">�ɻ�</option>
   			</select>
   		</div>
   		<div style="position:relative; top: -295;left: 290;">
   			<img alt="" src="<%=path %>/img/loginbutton.jpg" onclick="login();" onkeydown="enterSumbit()">
   		</div>
   		
    	</div>
    	</center>
    </div>
   
    
	</s:form>
  </body>
</html>
