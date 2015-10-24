<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ page language="java" import="org.hy.model.*" %>
<%@ page language="java" import="java.sql.Timestamp" %>
<%String path=request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
String user = userInfo.getUsername().toString();

Timestamp d = new Timestamp(System.currentTimeMillis());
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<title>总部发货单</title>
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/cmcommon.css">

	</head>
	
	<body>
	<s:form action="/web/head-office-send-bill!showHOSendBill" method="post">
		<div id="win" class="easyui-window" title="总部发货单"    
				        data-options="iconCls:'icon-save',modal:true,closed:true">
				   <table border="1" rules="all" 
					        style= "text-align: center;
					        font-family: verdana,arial,sans-serif;
						    font-size:10pt;
						    color:#000000;
						    border-width: 1px;
						    border-color: #666666; 
						    border-collapse: collapse;"    >
				 <tr>
					<td colspan="4" align="right" width="80%">发货单号</td>
					<td align="left" width="20%"><s:property value="maintainRegister.zbfhDh"/></td>
				</tr>
				   <tr><td style="background:#9FB6CD" width="120">店铺信息</td><td  style="background:#9FB6CD" width="100">店铺编码</td><td><s:property value="maintainRegister.dpbm"/></td><td style="background:#9FB6CD" width="120">店铺名称</td><td style="width:120"><s:property value="maintainRegister.dpmc"/></td></tr>
				   <tr><td style="background:#9FB6CD" rowspan="4">物流信息</td><td  style="background:#9FB6CD">运输公司</td><td><s:property value="maintainRegister.zbfhYsgs"/></td><td style="background:#9FB6CD">运输单号</td><td><s:property value="maintainRegister.zbfhYsdh"/></td></tr>
				   <tr>						<td style="background:#9FB6CD">发货地址</td><td colspan="3"><s:property value="maintainRegister.zbfhFhdz"/></td></tr>
				   <tr>						<td style="background:#9FB6CD">收货地址</td><td colspan="3"><s:property value="maintainRegister.zbfhShdz"/></td></tr>
				   <tr>						<td style="background:#9FB6CD">收货人</td><td>	<s:property value="maintainRegister.shr"/></td><td  style="background:#9FB6CD">联系电话</td><td>	<s:property value="maintainRegister.shrlxdh"/></td></tr>
				   <tr><td height="40" style="background:#9FB6CD">备注</td><td colspan="4"><s:property value="maintainRegister.zbfhBz"/></td> </tr>
				 <tr><td width="200"></td><td>编制人</td><td width="90"><s:property value="maintainRegister.zbfhBzr"/></td><td>编制日期</td><td width="100"><s:property value="maintainRegister.zbfhBzrq"/></td></tr>
				   <tr height="23"></tr>
				</table>
				   
		</div>
				   
				   

	</s:form>
	</body>
</html>