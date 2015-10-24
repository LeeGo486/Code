<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"
	prefix="bean"%>


<html:html>
<title></title>
<head>

	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
		
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/mycss/common.css" />


	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>

	
</head>
<script>
	
var index0State ;
var index1State ;
function initForm(){
		index0State = document.forms[0].YJWCSJ[0].checked;
		index1State = document.forms[0].YJWCSJ[1].checked;
	
}
	
function changeRadio(){
		document.forms[0].YJWCSJ[0].checked = index0State;
		document.forms[0].YJWCSJ[1].checked = index1State;
}	
</script>

<body onload="initForm()">

	<html:form action="/viewMaintenanceBillSelf" styleId="viewMaintenanceBillSelfForm" method="post">
		<html:hidden property="guid"/>
		<html:hidden property="ZT"/>
		
		<div align="center"><font size="5" style="font-weight:bold">维修登记表</font></div>
		<div style="height: 70%; width: 90%; OVERFLOW-Y: auto">
			<font size="6" color="red"> <bean:write name="viewMaintenanceBillSelfForm" property="ztTypeName"/></font>
			
			<table class="table_thin">
				<tbody>
					<tr>
						<td width="20%" class="field_enabled">
							维修单号
						</td>
						<td colspan="5" class="td_disabled">
							
							<html:text property="dh" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td rowspan="2" width="20%" class="field_enabled">
							店铺信息
						</td>
						<td width="20%" class="field_enabled">
							店铺编码
						</td>
						<td class="td_disabled" width="20%">
							
							<html:text property="dpbm" styleClass="text_disabled"></html:text>
						</td >
						<td width="20%" class="field_enabled">
							店铺名称
						</td>
						<td width="20%"  class="td_disabled">
							
							<html:text property="dpmc" styleClass="text_disabled"></html:text>
						</td>
						<td width="20%"  class="td_disabled">
							<html:text property="dplx" styleClass="text_disabled"></html:text>
							<br>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							店长姓名
						</td>
						<td class="td_disabled">
							
							<html:text property="DZXM" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							联系电话
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="DZLXDH" styleClass="text_disabled"></html:text>
						</td>

					</tr>
				

					<tr>
						<td rowspan="1" class="field_enabled">
							维修接单信息
						</td>
						<td class="field_enabled">
							受理导购（*）
						</td>
						<td class="td_disabled">
							
							<html:text property="SLDG" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							导购联系电话（*）
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="DGLXDH" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					

					<tr>
						<td rowspan="3" class="field_enabled">
							顾客信息
						</td>
						<td class="field_enabled">
							VIP卡号
						</td>
						<td class="td_disabled">
							
							<html:text property="VIPKH" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							顾客姓名（*）
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="GKXM" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							顾客联系电话
						</td>
						<td class="td_disabled">
							
							<html:text property="GKLXDH" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							售出时间（*）
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="SCSJ" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							同意付费维修
						</td>
						<td class="td_disabled">
							
							<html:checkbox property="SFTYFFWX" value="1" disabled="true"></html:checkbox>
						</td>
						<td class="field_enabled">
							紧急程度
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="JJCD" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td rowspan="2" class="field_enabled">
							待修产品信息
							<br>
						</td>
						<td class="field_enabled">
							款号（*）
						</td>
						<td class="td_disabled">
							
							<html:text property="KH" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							退回日期
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="THRQ" styleClass="text_disabled"></html:text>
						</td>
					</tr>

					<tr>
						<td class="field_enabled">
							问题描述（*）
						</td>
						<td colspan="4" class="td_disabled">
							
							<html:text property="WTMS" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					
					<tr>
						<td rowspan="3" class="field_enabled">
							维修信息
						</td>
						<td class="field_enabled">
							维修单位
						</td>
						<td class="td_disabled">
							
							<html:text property="WXDW" styleClass="text_disabled"></html:text>
							
						</td>
						<td class="field_enabled">
							预计完成时间(*)
						</td>
						<td class="td_disabled" colspan="2" >
							
							<html:radio  property="YJWCSJ"  value="3" onclick="changeRadio()">3天</html:radio>
							<html:radio property="YJWCSJ"  value="7" onclick="changeRadio()">7天</html:radio>
						</td>
						
					</tr>
					
					<tr>
						<td class="field_enabled">
							目前状态
						</td>
						<td colspan="1" class="td_disabled">
							
							<html:text property="ztTypeName" styleClass="text_disabled"></html:text>
		
						</td>
						
						<td class="field_enabled">
							实际完成时间
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="SJWCSJ"  onclick="setday(this)" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							付款金额
						</td>
						<td colspan="4" class="td_disabled">
							
							<html:text property="FFJE" styleClass="text_disabled"></html:text>
						</td>
						
					</tr>
				



					<tr>
						<td class="field_enabled">
							备注
						</td>
						<td colspan="5" class="td_disabled">
							
							<html:textarea property="BZXX" styleClass="text_disabled"></html:textarea>
						</td>
					</tr>
					

				</tbody>
			</table>

		
		</div>

		</html:form>
		
		

	


</body>
</html:html>