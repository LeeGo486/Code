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
  		//var com = $('#com').attr('value');
  		/* if(com==null || com==''){
  			$.messager.alert("��ʾ","����ѡ��˾");
  			return;
  		} */
  		
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
  	
  	/* function getHistoryCom(){
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
						
  	} */
  
   function initFrom(){
       
	   document.getElementById("userid").focus();
       var rs = $('#result').attr('value');
       if(rs=='0'){
           alert('�û��������벻��ȷ��');
       }
      
       
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
   
   	<table width="98%" height="98%" style="position:absolute;top:0px">
   		<tr>
   			<td align="center" valign="middle">
	   		<div style="position:relative ;width:877px;text-align: center; ">
	   			 <img alt="" src="<%=path %>/img/loginmain3.jpg" width="877px" >
	   			<div style="position:absolute; top: 295;left: 610px;width:200px;" >
	   			<s:textfield label="�û���" id="userid" name="userInfo.userid" width="100" theme="simple"   onkeydown="enterSumbit()"/>
		   		</div> 
		    	
		    	<div style="position:absolute; top: 345px;left: 610px;width:200px">
		   			<s:password label="����" id="password" name="userInfo.password" width="100" theme="simple" onkeydown="enterSumbit()"></s:password>
		   		</div > 
		   		
		   		<div style="position:absolute; top: 400px;left: 585px; width:200px" >
		   			<img alt="" src="<%=path %>/img/loginbutton2.jpg" onclick="login();" onkeydown="enterSumbit()">
		   		</div>
	   			
	   			
	   			
	   			
	   		</div>
   		
   		</td>
   		</tr>
   	
   	</table>	
    
	</s:form>
  </body>
</html>
