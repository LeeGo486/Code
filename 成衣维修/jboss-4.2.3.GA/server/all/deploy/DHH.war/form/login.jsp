<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<html> 
	<head>
		<title>订货会系统-【用户登录】</title>
		<link rel="stylesheet" href="./css/common.css" type="text/css"></link>
		<script type="text/javascript" src="./js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript">
	        $(function () {
	            var ischanged = "";
	            function getRfidData() {
	                //不能用Jquery的方法获取 $("#RFIDReader")
	                var rfid = (document.getElementById("RFIDReader").CardNum);
	                if (ischanged == rfid) return;
	                ischanged = rfid;
	
					$('input').eq(0).val(ischanged);
	            }
	            setInterval(getRfidData, 500);
	        });
	    </script>
	</head>
	<body>
		<div class="page">
		<html:form action="/login">
			<div class="login">
				<div class="input">
					<%if (session.getAttribute("rfidType").toString().equalsIgnoreCase("greyRFID")) {%>
						<object id="RFIDReader" classid="clsid:0CBD6597-3953-4B88-8C9F-F58B1B023413" 
					        codebase="RFID/RFIDREADER.cab">
					    </object>
					<%} else {%>
						<object id="RFIDReader" classid="clsid:E6A15262-D581-4AA3-98D3-5B9F83920EFE" 
					        codebase="RFID/RFIDREADER.cab">
					    </object>
					<%} %>
					<html:text property="username" readonly="false"/><br/>
					<html:password property="password" readonly="true"/><br/>
					<input type="button" class="button" id="login" value="登录" onclick="document.forms[0].submit();">
					<input type="button" class="button" id="close" value="退出" onclick="window.close();">
				</div>
				<% if (request.getAttribute("error") != null) { %>	
					<script type="text/javascript">
						alert('<%=request.getAttribute("error")%>');
					</script>
				<%}%>
			</div>
		</html:form>
		</div>
	</body>
</html>

