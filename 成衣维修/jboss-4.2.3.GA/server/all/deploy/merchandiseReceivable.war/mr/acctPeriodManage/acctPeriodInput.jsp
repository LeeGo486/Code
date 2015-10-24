<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   
    <title>����¼��</title>
    <link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path %>/jquery-easyui-1.3.1/demo/demo.css">
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path %>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
  	<script src="<%=path%>/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
  </head>
  <script type="text/javascript">
  	$(function(){
			
  		$('#thisPeriodEndDate').datebox();
  		$('#thisPeriodBgnDate').datebox();
  	
  	
			
			$('#shopInfo').combogrid({
				panelWidth:300,
				idField:'depotNo',
				textField:'depotName',
				url:$('#path').attr('value')+'/rest/queryDepot/acctPeriod/all',
				
				columns:[[
					{field:'depotNo',title:'depotNo',width:60},
					{field:'depotName',title:'depotName',width:120},
					{field:'depotAddr',title:'depotAddr',width:120}
				]],
				onSelect:function(record){
					var guid = $('#guid').attr('value');
					if(guid==null || guid==''){
						getThisPeriodInfo();
					}
					
				}
			});
			
			//setTimeout('setSelectValue()',2000);
			//setSelectValue();
			
		});
		function reload(){
			$('#shopInfo').combogrid('grid').datagrid('reload');
		}
		
		
		function newInfo(){
			$('#guid').attr('value','');
			$('#acctYear').attr('value','');
			$('#acctMonth').attr('value','');
			$('#depotName').attr('value','');
			//$('#depotName').attr('value','');
			$('#shopInfo').combogrid('setText',$('#depotName').attr(''));
  			$('#shopInfo').combogrid('setValue',$('#afterDepotNo').attr(''));
			$('#CDR').attr('value','');
			$('#EDR').attr('value','');
			$('#lastPeriodEndDate').attr('value','');
			$('#thisPeriodBgnDate').datebox('setValue','');	
			//$('#thisPeriodEndDate').attr('value','');
			$('#thisPeriodEndDate').datebox('setValue','');
			
		}
		function save(){
			//alert($('#shopInfo').combogrid('getValue'));
			//return;
			var shopNo = $('#shopInfo').combogrid('getValue');
			if(shopNo==null || shopNo==''){
				alert('���̱���ѡ����ȷ');
				return;
			}
			if($('#EDR').attr('value')==null || $('#EDR').attr('value')==''){
				alert('Ԥ�����ʲ���Ϊ��');
				return;
			}
			document.forms[0].submit();
		}
		
		function getThisPeriodInfo(){
			var val = $('#shopInfo').combogrid('getValue');
			var para = new Object();
			$.post(	$('#path').attr('value')+ '/rest/depot/getAcctPeriodInfo/'+val,para,function(rsp) {
				var datas = eval("(" + rsp + ")");
				
				if(datas.acctMonth==undefined){
					//$.messager.alert("��ʾ","��ȡ�����õ������µ�������Ϣ��");
					$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));
					$('#acctYear').attr('readonly',false);
					$('#acctMonth').attr('readonly',false);
					$('#acctYear').attr('value','');
					$('#acctMonth').attr('value','');
					$('#thisPeriodBgnDate').datebox('enable');
					$('#thisPeriodBgnDate').datebox('setValue','');	
					$('#lastPeriodEndDate').attr('value','');
					
					$('#thisPeriodEndDate').datebox('setValue','');
					
					$('#CDR').attr('value','');
					//$('#acctMonth').attr('readonly',false);
					//$('#acctMonth').attr('readonly',false);
					//$('#lastPeriodEndDate').attr('readonly',true);
					//$('#thisPeriodBgnDate').attr('readonly',false);
					
					return;
				
				}else{
					$('#depotName').attr('value',$('#shopInfo').combogrid('getText'));
					$('#acctYear').attr('value',datas.acctYear);
					$('#acctMonth').attr('value',datas.acctMonth);
					$('#lastPeriodEndDate').attr('value',datas.lastPeriodEndDate);
					if(datas.thisPeriodBgnDate!=null &&datas.thisPeriodBgnDate!=''){
						//alert(datas.thisPeriodBgnDate);
						//$('#thisPeriodBgnDate').datebox(options).disabled=true;
						$('#thisPeriodBgnDate').datebox('disable');
						$('#thisPeriodBgnDate').datebox('setValue',datas.thisPeriodBgnDate);
						
					}else{
						//$('#thisPeriodBgnDate').datebox();
						$('#thisPeriodBgnDate').datebox('setValue',datas.thisPeriodBgnDate);
						$('#thisPeriodBgnDate').datebox('enable');
					}
					getAcctPeriodEndDate();
				}	
			}, "text").error(
							function() {
									$.messager.alert("��ʾ","�ύ�����ˣ�");
						});
		}
 	
 	function initForm(){
  		
  		var rs = $('#result').attr('value');
  		
  		if(rs>='1'){
  			setSelectValue();
  			//setTimeout('setSelectValue()',500) ;
  			$.messager.alert("��ʾ","�����ɹ���");
  			return;
  		}else if('0'==rs){
  			setSelectValue();
  			//setTimeout('setSelectValue()',500) ;
  			$.messager.alert("��ʾ","����ʧ�ܣ�");
  			return;
  		}
  	}
  	
  	function setSelectValue(){
  		//alert($('#depotName').attr('value')+$('#afterDepotNo').attr('value'));
  		$('#shopInfo').combogrid('setText',$('#depotName').attr('value'));
  		$('#shopInfo').combogrid('setValue',$('#afterDepotNo').attr('value'));
  	}
  
  	function getAcctPeriodEndDate(){
  		var year = $('#acctYear').attr('value');
  		if(year==null||year==""){
  			$.messager.alert("��ʾ","����ȷ��д���£�");
  			$('#acctMonth').attr('value','');
  			return
  		}
		var month = $('#acctMonth').attr('value');
		if(year==null||year==""){
  			$.messager.alert("��ʾ","����ȷ��д���£�");
  			$('#acctMonth').attr('value','');
  			return
  		}
		var bgndate = $('#thisPeriodBgnDate').attr('value');
		if(bgndate==''){
			bgndate = '-1';
		}
		var val = $('#shopInfo').combogrid('getValue');
	    var para = new Object();
		$.post(	$('#path').attr('value')+ '/rest/depot/getAcctPeriodEndDate/'+val+'/'+month+'/'+year+'/'+bgndate,para,function(rsp) {
			$('#thisPeriodEndDate').datebox('setValue',rsp.split(',')[0]);
			$('#CDR').attr('value',rsp.split(',')[1]);		
			$('#EDR').attr('value',rsp.split(',')[1]);		
			}, "text").error(
							function() {
									$.messager.alert("��ʾ","�ύ�����ˣ�");
						});
  	}
  
  </script>
  
  <body onload="initForm()">
  	<input type="hidden" id="result" value="<%=request.getAttribute("result") %>">
  	<input type="hidden" id="path" value="<%=path %>">
  	<s:form action="/web/acct-period-input!saveInput" method="post" theme="simple">
  		<s:hidden id="guid" name="acctPeriod.acctPeriodID"></s:hidden>
  		<s:hidden id="depotName" name="acctPeriod.depotName"></s:hidden>
  		<s:hidden id="afterDepotNo" name="afterDepotNo"></s:hidden>
  		<center>
  		<div>
  			<input type="button" value="�½�" onclick="newInfo()">
  			<input type="button" value="�ύ" onclick="save()">
  			<br>
  			<table >
  				<tr>
  					<td align="left" width="100px">��ݣ�</td>
  					<td align="left" width="100px"><s:textfield id="acctYear" name="acctPeriod.acctYear" readonly="true"></s:textfield></td>
  					<td align="left" width="30px"></td>
  					<td align="left" width="100px"></td>
  				</tr>
  				<tr>
  					<td align="left">�·ݣ�</td>
  					<td align="left"><s:textfield id="acctMonth" name="acctPeriod.acctMonth" readonly="true" onchange="getAcctPeriodEndDate()"></s:textfield></td>
  					<td align="left"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
  					<td align="left">�������ƣ�</td>
  					<td align="left"> <s:select id="shopInfo" name="acctPeriod.depotNo"  list="#request.selectList" listKey="depotName" listValue="depotNo"  >
  						
  					</s:select> <!--   <select id="shopInfo" name="dept" style="width:250px;"></select> -->  </td>
  					<td align="left"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
  					<td align="left">��ͬ���ʣ�</td>
  					<td align="left"><s:textfield id="CDR" name="acctPeriod.CDR" readonly="true"></s:textfield></td>
  					<td align="left"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
  					<td align="left">Ԥ�����ʣ�</td>
  					<td align="left"><s:textfield id="EDR" name="acctPeriod.EDR"></s:textfield></td>
  					<td align="left"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
  					<td align="left">���ڽ��˽�ֹ�գ�</td>
  					<td align="left"><s:textfield id="lastPeriodEndDate" name="acctPeriod.lastPeriodEndDate"></s:textfield>  </td>
  					<td align="left"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
  					<td align="left">���ڽ�����ֹ��</td>
  					<td align="left"><s:textfield id="thisPeriodBgnDate" name="acctPeriod.thisPeriodBgnDate" readonly="true" cssStyle="width:140"></s:textfield> </td>
  					<td align="left">��</td>
  					<td align="left"><s:textfield id="thisPeriodEndDate" name="acctPeriod.thisPeriodEndDate" cssStyle="width:140"></s:textfield> </td>
  				</tr>
  			</table>
  			
  		</div>
  		</center>
  	</s:form>
    
  </body>
</html>
