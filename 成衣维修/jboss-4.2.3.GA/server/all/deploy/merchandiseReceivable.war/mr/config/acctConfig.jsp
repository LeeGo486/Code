<%@page import="org.hy.mr.mode.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="/tags/ecside" prefix="ec" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>店铺账期档案维护</title>
    
		
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/cmcommon.css" />
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/demo/demo.css">
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
  	<script src="<%=path%>/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=path%>/myjs/authority.js"></script>
	
  </head>
  <script type="text/javascript">
  	$(function(){
			
  			$('#shopInfo').combogrid({
				panelWidth:300,
				idField:'depotNo',
				textField:'depotName',
				url:$('#path').attr('value')+'/rest/queryDepot/all',
				
				columns:[[
					{field:'depotNo',title:'depotNo',width:60},
					{field:'depotName',title:'depotName',width:120},
					{field:'depotAddr',title:'depotAddr',width:120}
				]],
				onSelect:function(record){
					  getThisPeriodInfo();
				}
			});
			
			$('#marketComboBox').combobox({
				url: $('#path').attr('value')+'/rest/depot/getMarketOption',
				valueField:'id',
				textField:'text',
				multiple:false,
				panelHeight:'auto'//,
				//onLoadSuccess: function(){
					//alert($('#marketID').attr('value'));
				//}
			});
			
			
	  		$('#bgnContractDate').datebox();
	  		$('#endContractDate').datebox();
  			var deptoNo=$('#afterDepotNo').attr('value');
  			if(deptoNo!=null && deptoNo!=''){
  				getThisPeriodInfoByDepotNo(deptoNo);
  			}
  			
  			
		});
	
	function setComboBoxSelect(){
		var marketIDs = $('#marketID').attr('value');
  		if(marketIDs!=null&&marketIDs!=''){
  			$('#marketComboBox').combobox('setValues',marketIDs.split(','));
  		}else{
  			$('#marketComboBox').combobox('setValue','');
  		}
	}
		
	function initForm(){
  		setComboBoxSelect();
  		var rs = $('#result').attr('value');
  		showEndPeriodDay();
  		if(rs>=1){
  			setSelectValue();
  			//setTimeout('setSelectValue()',500) ;
  			window.opener.do_submit();
  			$.messager.alert("提示","操作成功！");
  			
  			return;
  		}else if('0'==rs){
  			setSelectValue();
  			//setTimeout('setSelectValue()',500) ;
  			$.messager.alert("提示","操作失败！");
  			return;
  		}else if('modify'==rs){
  			setSelectValue();
  			
  		}
  		
  	}
  	
  	function setSelectValue(){
  		//alert($('#depotName').attr('value')+$('#afterDepotNo').attr('value'));
  		$('#shopInfo').combogrid('setText',$('#depotName').attr('value'));
  		$('#shopInfo').combogrid('setValue',$('#afterDepotNo').attr('value'));
  	}
  	
  	function setSelectValueByIframe(depotNo,depotName){
  		$('#shopInfo').combogrid('setText',depotName);
  		$('#shopInfo').combogrid('setValue',depotNo);
  		
  	}
  	
  	function getThisPeriodInfo(){
			var	val = $('#shopInfo').combogrid('getValue');
			var para = new Object();
			$.post(	$('#path').attr('value')+ '/rest/depot/getAcctPeriodConfig/'+val,para,function(rsp) {
				var datas = eval("(" + rsp + ")");
				if(datas.contractDeductrate==undefined){
					$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));
					return;
				}else{
					$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));
					//$('#marketName').attr('value',datas.marketName);
					$('#deductrate').attr('value',datas.contractDeductrate);
					//$('#acctPeriodFlag').attr('value',datas.acctPeriodFlag);
					$("#acctPeriodFlag option[value="+datas.acctPeriodFlag+"]").attr("selected", true);
					$('#endPeriodDay').attr('value',datas.endPeriodDay);
					
					if(datas.marketID!=undefined){
						$('#marketID').attr('value',datas.marketID);
						
					}else{
						$('#marketID').attr('value','');
						setComboBoxSelect();
					}
					
					if(datas.costCenter!=undefined){
						$('#costCenter').attr('value',datas.costCenter);
					}else{
						$('#costCenter').attr('value','');
					}
					
					if(datas.LADR!=undefined){
						$('#LADR').attr('value',datas.LADR);
					}else{
						$('#LADR').attr('value','');
					}					
					
					if(datas.contractMinSales!=undefined){
						$('#contractMinSales').attr('value',datas.contractMinSales);
					}else{
						$('#contractMinSales').attr('value','');
					}	
					
					
					if(datas.contractPromotionInfo!=undefined){
						$('#contractPromotionInfo').attr('value',datas.contractPromotionInfo);
					}else{
						$('#contractPromotionInfo').attr('value','');
					}	
					
					$('#bgnContractDate').datebox('setValue',datas.bgnContractDate);	
					$('#endContractDate').datebox('setValue',datas.endContractDate);	
					showEndPeriodDay();
					
				}	
			}, "text").error(
							function() {
									$.messager.alert("提示","提交错误了！");
						});
		}
		
		function getThisPeriodInfoByDepotNo(depotNo){
			var	val = depotNo;
			var para = new Object();
			$.post(	$('#path').attr('value')+ '/rest/depot/getAcctPeriodConfig/'+val,para,function(rsp) {
				var datas = eval("(" + rsp + ")");
				if(datas.contractDeductrate==undefined){
					$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));
					return;
				}else{
					$('#shopInfo').combogrid('setText',datas.depotName);
  					$('#shopInfo').combogrid('setValue',datas.depotNo);
					//$('#marketName').attr('value',datas.marketName);
					$('#deductrate').attr('value',datas.contractDeductrate);
					//$('#acctPeriodFlag').attr('value',datas.acctPeriodFlag);
					$("#acctPeriodFlag option[value="+datas.acctPeriodFlag+"]").attr("selected", true);
					$('#endPeriodDay').attr('value',datas.endPeriodDay);
					$('#marketID').attr('value',datas.marketID);
					
					$('#costCenter').attr('value',datas.costCenter);
					$('#LADR').attr('value',datas.LADR);
					$('#contractMinSales').attr('value',datas.contractMinSales);
					$('#contractPromotionInfo').attr('value',datas.contractPromotionInfo);
					
					$('#bgnContractDate').datebox('setValue',datas.bgnContractDate);	
					$('#endContractDate').datebox('setValue',datas.endContractDate);	
					
  					$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));
					showEndPeriodDay();
					setComboBoxSelect();
				}	
			}, "text").error(
							function() {
									$.messager.alert("提示","提交错误了！");
						});
		}
		
		
		function save(){
			//var ssoSessionID = $('#ssoSessionID').attr('value');
		//var authorityFlag = validateMenuAccessAuthority(menuid,ssoSessionID);
			//var menuid = $('#menuID').attr('value');
			//if(validateMenuAccessAuthority(menuid,ssoSessionID)==false){
			//	return;
			//}
			//if(validateMenuAccessAuthority()==false){
			//	return;
			//}
			
			var shopNo = $('#shopInfo').combogrid('getValue');
			if(shopNo==null || shopNo==''){
				alert('店铺必须选择正确');
				return;
			}
			if($('#deductrate').attr('value')==null || $('#deductrate').attr('value')==''){
				alert('合同扣率必须填写');
				return;
			}
			if($('#contractMinSales').attr('value')==null || $('#contractMinSales').attr('value')==''){
				alert('合同月保底');
				return;
			}
			
			$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));
			var marketIDarray = $('#marketComboBox').combobox('getValues');
			var marketNames = $('#marketComboBox').combobox('getText');
			var marketIDs="";
			if(marketIDarray.length>0){
				
				for(var i=0;i<marketIDarray.length;i++){
					
					marketIDs = marketIDs+","+marketIDarray[i];
				}
				marketIDs = marketIDs.substring(1,marketIDs.length);
				
			}
			$('#marketID').attr('value',marketIDs);
			$('#marketName').attr('value',marketNames);
			document.forms[0].submit();
		}
		function showEndPeriodDay(){
			var acctPeriodFlagValue = $('#acctPeriodFlag').attr('value');
			if(acctPeriodFlagValue=='0'){
				$('#endPeriodDay').css("display","none");
			}else if(acctPeriodFlagValue=='1'){
				$('#endPeriodDay').css("display","block");
			}
		}
		
  
  </script>
  
  <body onload="initForm()">
  	<input type="hidden" id="ssoSessionID" value="<%=userInfo.getSsoSessionID()%>">
  	<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
  	<input type="hidden" id="path" value="<%=path %>">
     <s:form action="/web/acct-config!save" method="post" theme="simple">
     	<s:hidden id="menuID" name="menuID"></s:hidden>
     	<s:hidden id="depotName" name="acctConfig.depotName"></s:hidden>
  		<s:hidden id="afterDepotNo" name="afterDepotNo"></s:hidden>
  		<s:hidden id="marketID" name="acctConfig.marketID"></s:hidden>
     	<s:hidden id="marketName" name="acctConfig.marketName"></s:hidden>
     	<center>
     	<table width="100%" height="15%"  border="0" cellpadding="2" cellspacing="1"
				bgcolor="#AFC7D6">
     		<tr >
     			<td class="td_field">
     				店铺名称：
     			</td>
     			<td class="td_text">
     				<s:select id="shopInfo" name="acctConfig.depotNo"  list="#request.selectList" listKey="depotName" listValue="depotNo" ></s:select> 
     			</td>	
     			
     			
     			<td colspan="2" class="td_text" align="center">
     				<input type="button" value="保存" onclick="save()">
     				
     			</td>
     		</tr>
     		<tr>
     			
     			<td class="td_field">
     				成本中心：
     			</td>
     			<td class="td_text">
     				<s:textfield id="costCenter" name="acctConfig.costCenter"></s:textfield>
     			</td>
     		
     			<td class="td_field">
     			   往来单位：
     			</td>
     			
     			
     			<td class="td_text">
     				<input id="marketComboBox" type="text" readonly="readonly">
     			</td>
     			
     		</tr>
     		<tr>
     		
     			<td class="td_field">
     			  合同 开始日期：
     			</td>
     			<td class="td_text">
     			 	<s:textfield id="bgnContractDate" name="acctConfig.bgnContractDate"></s:textfield>
     			</td>
     			<td class="td_field">
     			  合同结束日期：
     			</td>
     			<td class="td_text">
     				<s:textfield id="endContractDate" name="acctConfig.endContractDate"></s:textfield>
     			</td>
     		</tr>
     		
     		<tr>
     		
     			<td class="td_field">
     			<font color="red">*</font>  合同 扣率：
     			</td>
     			<td class="td_field">
     			 	<s:textfield id="deductrate" name="acctConfig.contractDeductrate"></s:textfield>
     			</td>
     			<td class="td_field">
     			  最后一次实际扣率：
     			</td>
     			<td class="td_field">
     				<s:textfield id="LADR" name="acctConfig.LADR" readonly="true"></s:textfield>
     			</td>
     		</tr>
     		
     		<tr>
     		
     			<td class="td_field">
     			  <font color="red">*</font> 合同月保底：
     			</td>
     			<td class="td_text">
     			 	<s:textfield id="contractMinSales" name="acctConfig.contractMinSales"></s:textfield>
     			</td>
     			<td class="td_field">
     			  合促消费情况：
     			</td>
     			<td class="td_text">
     				<s:textfield id="contractPromotionInfo" name="acctConfig.contractPromotionInfo"></s:textfield>
     			</td>
     		</tr>
     		
     		<tr>
     			<td class="td_field">
     			   账期类型：
     			</td>
     			<td class="td_text">
     			 	<s:select id="acctPeriodFlag" name="acctConfig.acctPeriodFlag"  list="#request.acctPeriodFlagList"  listKey="code" listValue="name" onchange="showEndPeriodDay()">
  					</s:select> 
     			 
     			</td>
     		
     		
     			<td class="td_field">
     			   截止日期：
     			</td>
     			<td class="td_text">
     			 	<s:textfield id="endPeriodDay" name="acctConfig.endPeriodDay"></s:textfield>
     			</td>
     		
     			
     		</tr>
     	
     	</table>
     	</center>
     </s:form>
     
    <%--  <iframe width="100%" height="70%"  id="acctConfigList" name="acctConfigList" src="<%=path%>/web/acct-config!queryConfigList"> </iframe> --%>
     
  </body>
</html>
