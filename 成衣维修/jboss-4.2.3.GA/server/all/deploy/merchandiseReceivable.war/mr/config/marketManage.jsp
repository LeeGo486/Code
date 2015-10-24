<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/tags/ecside"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>物业管理</title>
     <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>

  </head>
  <script type="text/javascript">
  	function queryMarketArchives(){
  		document.forms[0].submit();
  	}
  	
  	function addMarketArchives(){
  		if($('#marketName').attr('value')==''){
  			alert('请输入物业名称');
  			return;
  		}
  		
  		$('#marketForm').attr('action',$('#path').attr('value')+'/web/market-archives!save?marketName='+$('#marketName').attr('value')
  			+'&marketUrl='+$('#marketUrl').attr('value')
  			+'&marketUsername='+$('#marketUsername').attr('value')
  			+'&marketPassword='+$('#marketPassword').attr('value')
  		);
  		document.forms[0].submit();
  	
  	
  	}
  	
  	function deleteMarketArchives(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==''){
  			alert('请选择要删除的记录！');
  			return
  		}
  		if(confirm("确定要删除该物业？")){
  			$('#deleteID').attr('value',recordKey);
  			$('#marketForm').attr('action',$('#path').attr('value')+'/web/market-archives!delete');
  			document.forms[0].submit();
  		}
  		
  		
  	}
  	function initForm(){
  		var result = $('#result').attr('value');
  		if(result=='1'){
  			alert('操作成功！');
  			return;
  		}else if(result=='0'){
  			alert('操作失败！');
  			return;
  		}
  		
  	}
  	
  	function addMarketArchives(){
  		var url  = $('#path').attr('value')+'/web/market-archives!init';
  		window.open(url, "物业信息编辑", "scrollbars=yes,width=800px,height=600px;");
  	}
  
  	function openUrl(url){
  		if(url!=''){
  			window.open(url, "", "scrollbars=yes,width=1024px,height=600px;");
  		}
  	}
  	
  	function modifyMarketArchives(){
  		var ecsideObj=ECSideUtil.getGridObj('ecTable');
  		var selectedRow = ecsideObj.selectedRow;
  		var recordKey = selectedRow.getAttribute("recordKey");
  		if(recordKey==null || recordKey==""){
      		$.messager.alert("提示","必须选择一条记录！");
      		return;
      	}
      	
  		var url  = $('#path').attr('value')+'/web/market-archives!modifyInit?guid='+recordKey;
  		window.open(url, "物业信息编辑", "scrollbars=yes,width=800px,height=600px;");
  	}
  
  </script>
  <body onload="initForm()">
    <input type="hidden" id="path" value="<%=path%>">
    <input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
    
    <s:form id="marketForm" action="/web/market-archives!queryMarketList" theme="simple" method="post" >
    	<input type="hidden" id="deleteID" name="deleteID">
    	<s:textfield name="marketArchives.marketName"></s:textfield>
    	<input type="button" value="查询" onclick="queryMarketArchives()">
    	<input type="button" value="新增" onclick="addMarketArchives()">
    	<input type="button" value="修改" onclick="modifyMarketArchives()">
    	<input type="button" value="删除" onclick="deleteMarketArchives()">
    	
    	<!-- <div id="inputHidden" class="easyui-window" data-options="closed:true,modal:true,title:'物业名称录入'" style="width:650px;height:300px;">
			
			<table>
				<tr>
					<td>物&nbsp;业&nbsp;名&nbsp;称：<input type="text" id="marketName" name="marketName"></td>
					<td width="400px">物&nbsp;业&nbsp;url&nbsp;：<input type="text" id="marketUrl" name="marketUrl" style="width: 300px"></td>
				</tr>
				<tr>
					<td>物业用户名：<input type="text" id="marketUsername" name="marketUsername"></td>
					<td>物业密码：<input type="text" id="marketPassword" name="marketPassword"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="保存" onclick="addMarketArchives()">
					</td>
				</tr>
			</table>
			
			
		</div> -->
    </s:form>
     <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/market-archives!queryMarketList"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="true"
		    classic="true"
			filterable="true">
			<ec:row recordKey="${record.guid}">
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="物业名称" property="marketName" sortable="true" />
				<ec:column title="网址" property="marketUrl" ondblclick="openUrl('${record.marketUrl}')" sortable="true" />
				<ec:column title="用户名" property="marketUsername" sortable="true" />
				<ec:column title="密码" property="marketPassword" sortable="true" />
				<ec:column title="出结算单日期" property="produceSettleBillDate" sortable="true" />
				<ec:column title="收税票截止日期" property="rcvTaxVoteEndDate" sortable="true" />
				<ec:column title="备注" property="comment" sortable="true" />
			</ec:row>
			
		</ec:table>
    
  </body>
</html>
