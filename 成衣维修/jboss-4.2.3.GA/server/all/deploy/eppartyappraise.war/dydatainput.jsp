<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>党员资料录入</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript"
			src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>
		<script language="javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>

	</head>

	<body>
		<html:form action="" styleId="" method="post">
			<table>
				<tr>
					<td>
						姓名：
					</td>
					<html:text property="dyname"></html:text>
					<td>

					</td>

					<td>
						岗位：
					</td>

					<td>
						<html:text property="gzgw"></html:text>
					</td>
				</tr>

				<tr>


					<td>
						出生年月：
					</td>

					<td>

					</td>

					<td>
						入党日期：
					</td>

					<td>

					</td>
				</tr>





				<tr>


					<td>
						上传照片：
					</td>

					<td colspan="3">

					</td>
				</tr>
				<tr>
					<td>
						先锋承诺：
					</td>
					<td colspan="3">

					</td>

				</tr>
				<tr>
					<td>
						岗位承诺：
					</td>
					<td colspan="3">

					</td>

				</tr>

				<tr>
					<td>
						实事承诺：
					</td>
					<td colspan="3">

					</td>

				</tr>

				<tr>
					<td colspan="3">
						承诺日期：
					</td>
					<td colspan="1" align="right">
					</td>
				</tr>

			</table>

			<html:text property=""></html:text>
		</html:form>
	</body>
</html>
