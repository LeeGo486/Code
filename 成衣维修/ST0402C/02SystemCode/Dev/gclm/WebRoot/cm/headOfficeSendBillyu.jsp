<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%String path=request.getContextPath(); %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<title>�ܲ�������</title>
		<link rel="stylesheet" type="text/css" href="<%=path%>/css/cmcommon.css">

	</head>
	
	<body>
	<s:form action="/web/head-office-send-bill!showHOSendBill" method="post">
		<table width="100%" border="0">
			
				<tr>
					<td colspan="4" align="right" width="80%">
						��������
					</td>
					<td align="left" width="20%">
						<s:property value="maintainRegister.zbfhDh"/>
					</td>
				</tr>
			
		</table>


		<table width="100%" class="table_thin">
			
				<tr>
					<td width="20%" class="td_field_thin">
						������Ϣ
					</td>
					<td width="20%" class="td_field_thin">
						���̱���
					</td>
					<td class="td_field_thin" width="20%">

						<s:property value="maintainRegister.dpbm"/>
					</td>
					<td width="20%" class="td_field_thin">
						��������
					</td>
					<td class="td_field_thin" width="20%">

						<s:property value="maintainRegister.dpmc"/>
					</td>
				</tr>
				<tr>
					<td rowspan="4" class="td_field_thin">
						������Ϣ
						<br>
					</td>
					<td class="td_field_thin">
						���乫˾
						<br>
					</td>
					<td class="td_field_thin">
						<s:property value="maintainRegister.ysgs"/>
					</td>
					<td class="td_field_thin">
						�˵����
					</td>
					<td class="td_field_thin">

						<s:property value="maintainRegister.ydh"/>
					</td>
				</tr>
				<tr>
					<td class="td_field_thin">
						������ַ
					</td>
					<td colspan="3" class="td_field_thin">

						<s:property value="maintainRegister.fhdz"/>
					</td>

				</tr>
				<tr>
					<td class="td_field_thin">
						�ջ���ַ
						<br>
					</td>
					<td colspan="3" class="td_field_thin">

						<s:property value="maintainRegister.shdz"/>
					</td>

				</tr>
				<tr>
					<td class="td_field_thin">
						�ջ���
						<br>
					</td>
					<td class="td_field_thin">

						<s:property value="maintainRegister.shr"/>
					</td>
					<td class="td_field_thin">

						��ϵ�绰
					</td>
					<td class="td_field_thin">

						<s:property value="maintainRegister.shrlxdh"/>
					</td>

				</tr>
				<tr>
					<td class="td_field_thin">
						��ע
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
						������
					</td>
					<td width="10%" class="td_disabled">
						<s:property value=""/>
					</td>
					<td width="10%" align="right">
						��������
					</td>
					<td width="10%" class="td_disabled">
						<s:property value="makeDate"/>
					</td>

				</tr>
			
		</table>




	</s:form>

	


	</body>
</html>