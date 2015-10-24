<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>




<html>
	
	<head>
	<title>发送总部</title>
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=request.getContextPath()%>/mycss/common.css" />

		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
		<script type="text/javascript"
			src="../ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>

	

	</head>


	<body>

<html:form action="/viewHQSendGoods" styleId="HQSendGoodsForm" method="post">
<table width="100%" border="0">
<tbody><tr>
<td colspan="4" align="right" width="80%">发货单号</td>
<td align="left" width="20%"><html:text property="ZBFH_DH" styleClass="text_disabled"></html:text>
</td>
</tr>
</tbody>
</table >


			<table width="100%" class="table_thin">
				<tbody>
					<tr>
						<td width="20%" class="field_enabled">
							店铺信息
						</td>
						<td width="20%" class="field_enabled"> 
							店铺编码 
						</td>
						<td class="td_disabled" width="20%">
							
							<html:text property="dpbm" styleClass="text_disabled"></html:text>
						</td>
						<td width="20%" class="field_enabled">
							店铺名称
						</td>
						<td class="td_disabled" width="20%">
							
						<html:text property="dpmc" styleClass="text_disabled"></html:text></td>
					</tr>
					<tr>
						<td rowspan="4" class="field_enabled">物流信息<br></td>
						<td class="field_enabled">运输公司<br></td>
						<td class="td_disabled"><html:text property="ZBFH_YSGS" styleClass="text_disabled"></html:text><br></td>
						<td class="field_enabled"> 运单编号</td>
						<td class="td_disabled">
							
						<html:text property="ZBFH_YSDH" styleClass="text_disabled"></html:text></td>
					</tr>
					<tr>
						<td class="field_enabled">发货地址</td>
						<td colspan="3" class="td_disabled">
							
						<html:text property="ZBFH_FHDZ" styleClass="text_disabled"></html:text></td>
						
					</tr>
					<tr>
						<td class="field_enabled">收货地址<br></td>
						<td colspan="3" class="td_disabled">
							
						<html:text property="ZBFH_SHDZ" styleClass="text_disabled"></html:text></td>
					
					</tr>
					<tr>
						<td class="field_enabled">收货人<br></td>
						<td class="td_disabled">
							
						<html:text property="ZBFH_SHR" styleClass="text_disabled"></html:text></td>
						<td class="field_enabled"> 
							 
						联系电话</td>
						<td class="td_disabled">
							
						<html:text property="ZBFH_SHRDH" styleClass="text_disabled"></html:text></td>
						
					</tr>
					<tr>
						<td class="field_enabled">备注<br></td>
						<td colspan="4"  class="td_disabled">
							
						<html:textarea property="ZBFH_BZ" styleClass="text_disabled"></html:textarea></td>
						
					</tr>
				</tbody>
			</table>



		
<table width="100%" border="0">
<tbody>
<tr>
<td  colspan="2" width="60%" align="right">编制人</td>
<td width="10%" class="td_disabled"><html:text property="ZBFH_BZR" styleClass="text_disabled"></html:text></td>
<td width="10%" align="right">编制日期</td>
<td width="12%" class="td_disabled"><html:text property="ZBFH_BZSJ" styleClass="text_disabled"></html:text></td>

</tr>
</tbody></table>






</html:form>

	</body>










</html>