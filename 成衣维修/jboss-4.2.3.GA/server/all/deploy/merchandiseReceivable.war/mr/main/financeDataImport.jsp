<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://www.ecside.org" prefix="ec"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>财务数据导入</title>
    
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	

  </head>
  <script type="text/javascript">
  	
  	
  	
  	function initForm(){
  		var rs = $('#result').attr('value');
  		//alert($('#periodDate').attr('value'));
  		//alert(rs);
  		if(rs=='1'){
  			$.messager.alert("提示","保存成功！");
  			query();
  		}else if(rs=='0'){
  			$.messager.alert("提示","保存失败！");
  			return;
  		}else if(rs=='-1'){
  			$.messager.alert("提示","Excel解析失败！");
  			return;
  		}else if(rs=='-2'){
  			$.messager.alert("提示","Excel没有数据或者存在不同账期！");
  			return;
  		}else if(rs=='-3'){
  			$.messager.alert("提示","无法导入，原因一个账期的 数据只允许导一次，本账期数据已经导入过！！");
  			return;
  		}
  	}
  	function importFinanceData(){
  		var fileName = $('#file').attr('value');
  		if(fileName==null || fileName==''){
  			alert('请选择导入文件');
  			return;
  		}
  		
  	/* 	if(!checkFile()){
  			return;
  		}; */
  		document.forms[0].submit();
  	}
  	/* function save(){
  		var arrayTr = $('#ecTable_table tr');
  		if(arrayTr.length<2){
  			alert('界面没有需要导入的记录');
  			return;
  		}
  		$('#periodDate1').attr('value',$('#periodDate').attr('value'));
  		$('#confirm').attr('action',$('#path').attr('value')+'/web/finance-data-import!confirm?periodDate1='+$('#periodDate').attr('value'));
  		document.forms[1].submit();
  	} */
  	
  	function query(){
  		//$('#confirm').attr('action',$('#path').attr('value')+'/web/finance-data-import!confirm?periodDate1='+$('#periodDate').attr('value'));
  		$('#import').attr('action',$('#path').attr('value')+'/web/finance-data-import!queryList?periodDate='+$('#periodDate').attr('value'));
  		//alert($('#import').attr('action'));
  		document.forms[0].submit();
  	}
  	
  	function checkFile(){
  		var filename = $('#file').attr('value');
  		var index = filename.lastIndexOf('.');
  		var fileExtendName = filename.substring(index+1);
  		if(fileExtendName!='xls'){
  			alert("导入文件的后缀名必须为xls");
  			return false;
  		}
  		return true;
  	}
  </script>
  
  <body onload="initForm()" >
    <input type="hidden" id="path" value="<%=path%>">
    <input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
    <table width="100%"><tr>
    <td width="300px">
    <s:form id="import" action="/web/finance-data-import!importFinanceData" method="post" theme="simple" enctype="multipart/form-data">
    	<s:hidden id="periodDate" name="periodDate"></s:hidden>
    	<s:file id="file" name="file"></s:file>
    	<input type="button" value="导入" onclick="importFinanceData()"/>
    </s:form>	
    </td>
    <td align="left">
    
   	</td> 	
   	</tr> 
   	</table>
   	  
   	  
   	  <ec:table  items="FinanceDataList" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/finance-data-import!queryList"
			pageSizeList="10,20,30,50" rowsDisplayed="20" xlsFileName="导出差异.xls" 
		    classic="true">
			<ec:row >
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="店铺编号" property="depotNo" sortable="true" />
				<ec:column title="店铺名称" property="depotName" sortable="true" />
				<ec:column title="pos导出金额" property="posExprotAmount" sortable="true" />
				<ec:column title="pos实销" property="posActualSales" sortable="true" />
				<ec:column title="差异金额" property="difAmout" sortable="true" />
				<ec:column title="预估结算" property="expectSettleAmount" sortable="true" />
				<ec:column title="账期" property="periodDate" sortable="true" />
			</ec:row>
			
		</ec:table>
   	 	
  </body>
</html>
