<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>星级党员测评</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
	</head>
	<script type="text/javascript" >
	function initForm() {
		if (document.getElementById("loginFlag").value == '0') {
			alert('用户名或密码错误，登录失败！');
		}
	}

	</script>

	<body
		style="background-color: #F32110;height:100%;width:100%;margin:0 ">
		<div style="margin:0 auto;position: relative;height:768px;width:1024px;background-image: url(<%=request.getContextPath()%>/img/partybg.jpg);background-repeat: no-repeat;background-position:center;;">
		<html:form action="/login" method="post" styleId="loginForm">
			<html:hidden property="loginFlag" />

			<div align="center" >
				<table style="position: relative; left: 50px;top:395px">
					<tr style="height:48px;">
						<td align="left">
							<html:text property="username" style="background:transparent;line-height:35px;height:35px;width:180;border:0px;"></html:text>
						</td>

					</tr>
					<tr style="height:48px;">
						<td align="left">
							<html:password property="password" style="background:transparent;line-height:35px;height:35px;width:180;border:0px;"></html:password>
						</td>

					</tr>
					<tr>
						
						<td colspan="2" align="center">
							<html:button property="login"
								onclick="document.forms[0].submit()" style="border:0px;background:transparent;width:200px;height:43px;">&nbsp;</html:button>
						</td>
					</tr>

				</table>

			</div>
		</html:form>
		</div>
	</body>
</html>
