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

	<link rel="stylesheet" type="text/css" href=" <%=request.getContextPath()%>/tabbed_pages/tabbed_pages.css" />
		
	<script type="text/javascript" src=" <%=request.getContextPath()%>/tabbed_pages/tabbed_pages.js" ></script>
	
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
		
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/mycss/common.css" />


	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>

	
</head>
<script>
	function showPictrue(tableID){
		var ecsideObj=ECSideUtil.getGridObj(tableID);
		var selectedRow = ecsideObj.selectedRow;
		var guid = selectedRow.getAttribute("recordKey");
		window.open("viewPictrue.jsp?guid="+guid,"","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
	} 
	function actupdateydh(){  
	    var jydh = document.getElementById("YDH").value;
	    var cguid = document.getElementById("guid").value;
	    var nydh = document.getElementById("NYDH").value;
	    if(nydh==null || nydh==""){
	    	alert("请输入新运单号！");
	    	return;
	    }
	    if(!confirm("确认调整运单号吗？")){ 
	    	return;
	    }
	    
	    var xmlhttp; 
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
	  		xmlhttp=new XMLHttpRequest();
	  	}else{// code for IE6, IE5
	  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  	}
	  	xmlhttp.onreadystatechange=function() {
	  		if (xmlhttp.readyState==4 && xmlhttp.status==200){
	  		   if(xmlhttp.responseText == 'T'){
	  		   	  document.getElementById("YDH").value=nydh;
	  		   	  alert("调整成功！"); 
	  		   }else{
	  		      alert("调整失败！"); 
	  		   }
	  	    }
	  		
	  	}
	  	xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=updateydh&nydh="+nydh+"&guid="+cguid);
		
		
	}
	function conload(){  
	    if(document.getElementById("formNamespan").innerText!='发送总部'){ 
	    	document.getElementById("tzydhspan").innerText=''; 
	    }
	}
</script>

<body onload="conload();">

	<html:form action="/viewMaintenanceBill" styleId="viewMaintenanceBillForm" method="post">
		<html:hidden property="guid"/>
		<html:hidden property="ZT"/>
		
		<div align="center"><font size="5" style="font-weight:bold">维修登记表</font></div> 
		 
		<div style="height: 70%; width: 90%; OVERFLOW-Y: auto">  
			<font size="6" color="red"><span id="formNamespan"><bean:write name="viewMaintenanceBillForm" property="ztTypeName"/></span></font>
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
						<td rowspan="3" width="20%" class="field_enabled">
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
							店长联系电话
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="DZLXDH" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							维修仓编码
						</td>
						<td class="td_disabled">
							
							<html:text property="WXCBM" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							维修仓名称
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="WXCMC" styleClass="text_disabled"></html:text>
						</td>
					</tr>


					<tr>
						<td rowspan="2" class="field_enabled">
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
						<td class="field_enabled">
							顾客维修
						</td>
						<td colspan="4" class="td_disabled">
							
							<html:checkbox property="GKWX" value="1" disabled="true"></html:checkbox>
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
						<td rowspan="4" class="field_enabled">
							物流信息
						</td>
						<td class="field_enabled">
							运输公司
						</td>
						<td class="td_disabled">
							
							<html:text property="YSGS" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							运单号
						</td>
						<td colspan="2" class="td_disabled"> 
							<html:text property="YDH" styleClass="text_disabled"></html:text> 
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							发货地址
						</td>
						<td colspan="2" class="td_disabled"> 
							<html:text property="FHDZ" styleClass="text_disabled"></html:text>
						</td>
						<td id="tzydhtd" rowspan="2" colspan="2" class="td_disabled" style="background-color: white;" > 
						  		<span id="tzydhspan"><font  color="Crimson"> 新运单号：</font>
						  		<input type="text" id="NYDH" />   
								<input type="button" value="调整" onclick="actupdateydh();"/>  </span>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							收货地址
						</td>
						<td colspan="2" class="td_disabled"> 
							<html:text property="SHDZ" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							收货人
						</td>
						<td class="td_disabled">
							
							<html:text property="SHR" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							收货人联系电话
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="SHRLXDH" styleClass="text_disabled"></html:text>
						</td>

					</tr>



					<tr >
						<td class="field_enabled">
							备注
						</td>
						<td colspan="5" class="td_disabled" style="height: 35px"> 
							<html:textarea property="BZXX" styleClass="text_disabled" ></html:textarea>
						</td>
					</tr>
					<tr>

						<td rowspan="15" class="field_enabled">
							品检判定
						</td>
						<td colspan="5" class="field_enabled">
							问题主因（必填）
						</td>
					</tr>

					<tr>
						<td class="field_enabled">
							维修性质
						</td>
						<td class="td_disabled">
							
							<html:text property="WXXZ1" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							问题点
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="WTD1" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							起因
						</td>
						<td class="td_disabled">
							
							<html:text property="QY1" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							现象点
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="XXD1" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							部位描述
						</td>
						<td colspan="4" class="td_disabled">
							<html:text property="WXBW" styleClass="text_disabled"></html:text>
							<br>
						</td>

					</tr>
					<tr>
						<td colspan="5" class="field_enabled">
							问题次因（必填）
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							 维修性质
						</td>
						<td class="td_disabled">
							
							<html:text property="WXXZ2" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							 问题点
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="WTD2" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							 起因
						</td>
						<td class="td_disabled">
							
							<html:text property="QY1" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							 现象点
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="XXD2" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td colspan="5" class="field_enabled">
							判定结果
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							判定处理方式（*）
						</td>
						<td class="td_disabled">
							
							<html:text property="PDCLFS" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							退仓处理结果
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="TCCLJG" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							责任部门
						</td>
						<td class="td_disabled">
							
							<html:text property="ZRBM" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							退货单号
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="THDH" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							检测异议
						</td>
						<td colspan="4" class="td_disabled">
							
							<html:text property="JCYY" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							特修
						</td>
						<td class="td_disabled">
							
							<html:text property="TX" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							计划维修天数（*）
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="JHWXTS" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							是否收费
						</td>
						<td class="td_disabled">
							
							<html:text property="SFSF" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							收费金额（元）
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="SFJE" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							收费内容
						</td >
						<td colspan="4" class="td_disabled">
							
							<html:text property="SFNR" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							品检判定备注
						</td>
						<td colspan="4" class="td_disabled">
							
							<html:text property="PJPDBZ" styleClass="text_disabled"></html:text>
						</td>
					</tr>

					<tr>
						<td class="field_enabled">
							维修信息
						</td>
						<td class="field_enabled">
							维修人
						</td>
						<td class="td_disabled">
							
							<html:text property="WXR" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							维修时间
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="WXSJ" styleClass="text_disabled"></html:text>
						</td>


					</tr>

				</tbody>
			</table>

			<table style="width: 90%;" border="0" height="67">
				<tbody>
					<tr>
						<td width="10%" >
							登记人
						</td>
						<td width="15%">
							
							<html:text property="djr" styleClass="text_disabled"></html:text>
						</td>
						<td width="10%">
							登记时间
						</td>
						<td width="15%">
							
							<html:text property="djsj" styleClass="text_disabled"></html:text>
						</td>
						<td width="10%">
							品鉴判定人
						</td>
						<td width="15%">
							
							<html:text property="PJPDR" styleClass="text_disabled"></html:text>
						</td>
						<td width="10%">
							判定时间
						</td>
						<td width="15%">
							
							<html:text property="PJPDSJ" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td>
							特退审批人
						</td>
						<td>
							
							<html:text property="TTSPR" styleClass="text_disabled"></html:text>
						</td>
						<td>
							审批时间
						</td>
						<td>
							
							<html:text property="TTSPSJ" styleClass="text_disabled"></html:text>
						</td>
						<td>
							维修确认人
						</td>
						<td>
							
							<html:text property="WXQRR" styleClass="text_disabled"></html:text>
						</td>
						<td>
							确认时间
						</td>
						<td>
							
							<html:text property="WXQRSJ" styleClass="text_disabled"></html:text>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		</html:form>
		
		<div id="gallery">
			<div class="on" title="repairImage">
				<span>待修图片</span>
			</div>
			<div class="off" title="checkImage">
				<span>待检图片</span>
			</div>
		</div>
		<div id="repairImage" class="show">
			<ec:table  items="repairImageRecordList" var="repairrecord"  tableId="repairTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action=""
			rowsDisplayed="50" editable="false"
		    classic="true"
			filterable="false">
			<ec:row recordKey="${repairrecord.GUID}">
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="文件名" property="WJM" sortable="false" />
				<ec:column title="描述" property="MS" sortable="false" />
				<ec:column title="查看操作" cellValue="查看" sortable="false" onclick="showPictrue('repairTable')" />
			</ec:row>
			
			</ec:table>
				
		
		</div>

		<div id="checkImage" class="hide">
   			<ec:table  items="checkImageRecordList" var="checkrecord"  tableId="checkTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action=""
			rowsDisplayed="50" editable="false"
		    classic="true"
			filterable="false">
			<ec:row recordKey="${checkrecord.GUID}">
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="文件名" property="WJM" sortable="false" />
				<ec:column title="描述" property="MS" sortable="false" />
				<ec:column title="查看操作" cellValue="查看" sortable="false" onclick="showPictrue('checkTable')" />
			
				
			</ec:row>
			
			</ec:table>
   		
   		</div>
	

	


</body>
</html:html>