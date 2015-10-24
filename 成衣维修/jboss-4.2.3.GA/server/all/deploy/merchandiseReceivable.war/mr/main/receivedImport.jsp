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
    
    <title>实收新增</title>
    
	
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
  		//alert(rs);
  		if(rs=='1'){
  			$.messager.alert("提示","保存成功！");
  			return;
  		}else if(rs=='0'){
  			var unmathMarket = $('#unmathMarket').attr('value');
  			if(unmathMarket!=null&&unmathMarket!=''){
  				$.messager.alert("提示","保存失败！"+unmathMarket+'在系统中不存在，请核查！');
  			}else{$.messager.alert("提示","保存失败！");}
  			
  		}else if(rs=='-1'){
  			$.messager.alert("提示","Excel解析失败！");
  		}
  	}
  	function importRcved(){
  		var fileName = $('#file').attr('value');
  		if(fileName==null || fileName==''){
  			alert('请选择导入文件');
  			return;
  		}
  		
  		if(!checkFile()){
  			return;
  		};
  		document.forms[0].submit();
  	}
  	
  	function confirm(){
  		var arrayTr = $('#ecTable_table tr');
  		if(arrayTr.length<2){
  			alert('界面没有需要导入的记录');
  			return;
  		}
  		document.forms[1].submit();
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
    <input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
    <input type="hidden" id="unmathMarket" value="<%=request.getAttribute("unmathMarket")%>">
    <table width="100%"><tr>
    <td width="300px">
    <s:form  action="/web/received-import!importRecved" method="post" theme="simple" enctype="multipart/form-data">
    	
    	<s:file id="file" name="file"></s:file>
    	<input type="button" value="导入" onclick="importRcved()"/>
    </s:form>	
    </td>
    <td align="left">
    <s:form action="/web/received-import!confirm" method="post" theme="simple">
    	<input type="button" value="确认" onclick="confirm()"/>
   	</s:form>
   	</td> 	
   	</tr> 
   	</table>
   	  
   	  
   	  <ec:table  items="receivedList" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/received-import!queryList"
			pageSizeList="10,20,30,50" rowsDisplayed="20" 
		    classic="true">
			<ec:row >
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="年月日" property="receivedYMD" sortable="true" />
				<ec:column title="物业名称" property="marketName" sortable="true" />
				<ec:column title="收入（金额）" property="receivedAmount" sortable="true" />
			</ec:row>
			
		</ec:table>
   	 
  </body>
</html>
