<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%String path=request.getContextPath(); %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<title>总部发货单</title>
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/cmcommon.css">

	</head>
	
	<body>
	<s:form action="/web/head-office-send-bill!showHOSendBill" method="post">
		<table width="100%" border="0">
			
				<tr>
					<td colspan="4" align="right" width="80%">
						发货单号
					</td>
					<td align="left" width="20%">
						<s:property value="maintainRegister.zbfhDh"/>
					</td>
				</tr>
			
		</table>


		<table width="100%" class="table_thin">
			
				<tr>
					<td width="20%" class="td_field_thin">
						店铺信息
					</td>
					<td width="20%" class="td_field_thin">
						店铺编码
					</td>
					<td class="td_field_thin" width="20%">

						<s:property value="maintainRegister.dpbm"/>
					</td>
					<td width="20%" class="td_field_thin">
						店铺名称
					</td>
					<td class="td_field_thin" width="20%">

						<s:property value="maintainRegister.dpmc"/>
					</td>
				</tr>
				<tr>
					<td rowspan="4" class="td_field_thin">
						物流信息
						<br>
					</td>
					<td class="td_field_thin">
						运输公司
						<br>
					</td>
					<td class="td_field_thin">
						<s:property value="maintainRegister.ysgs"/>
					</td>
					<td class="td_field_thin">
						运单编号
					</td>
					<td class="td_field_thin">

						<s:property value="maintainRegister.ydh"/>
					</td>
				</tr>
				<tr>
					<td class="td_field_thin">
						发货地址
					</td>
					<td colspan="3" class="td_field_thin">

						<s:property value="maintainRegister.fhdz"/>
					</td>

				</tr>
				<tr>
					<td class="td_field_thin">
						收货地址
						<br>
					</td>
					<td colspan="3" class="td_field_thin">

						<s:property value="maintainRegister.shdz"/>
					</td>

				</tr>
				<tr>
					<td class="td_field_thin">
						收货人
						<br>
					</td>
					<td class="td_field_thin">

						<s:property value="maintainRegister.shr"/>
					</td>
					<td class="td_field_thin">

						联系电话
					</td>
					<td class="td_field_thin">

						<s:property value="maintainRegister.shrlxdh"/>
					</td>

				</tr>
				<tr>
					<td class="td_field_thin">
						备注
						<br>
					</td>
					<td colspan="4" class="td_field_thin">

						<s:property value="maintainRegister.bzxx"/>
					</td>

				</tr>
		</table>




		<table width="100%" border="0">
			
				<tr>
					<td colspan="2" width="70%" align="right">
						编制人
					</td>
					<td width="10%" class="td_disabled">
						<s:property value=""/>
					</td>
					<td width="10%" align="right">
						编制日期
					</td>
					<td width="10%" class="td_disabled">
						<s:property value="makeDate"/>
					</td>

				</tr>
			
		</table>




	</s:form>

	


	</body>
</html>