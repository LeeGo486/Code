<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://www.ecside.org" prefix="ec"%>
<%String path = request.getContextPath(); 
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//List list = (List)request.getAttribute("list");
//System.out.println(list);
//request.setAttribute("list", list);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
     <base href="<%=basePath%>">
    <title>账期导入</title>
    
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
  function importAccPeriod(){
  	var importFileName = $('#importFile').attr('value');
  	if(importFileName==null || importFileName==''){
  		alert('请先选择导入文件');
  		return;
  	}
  	document.forms[0].submit();
  }
  function save(){
  	var arrayTr = $('#ecTable_table tr');
  	if(arrayTr.length<2){
  		alert('界面没有需要导入的记录');
  		return;
  	}
  	document.forms[1].submit();
  }
  function initForm(){
  		var rs = document.getElementById('rs').value;
  		if(rs=='1'){
  			//$.messager.
  			alert("操作成功！");
  			return;
  		}else if(rs == '0'){
  			//$.messager.
  			alert("操作失败！");
  			return;
  		}
  }
  
  </script>
  
  <body onload="initForm()">
  	<input type="hidden" id="rs" value="<%=request.getAttribute("rs")%>">
   	<table width="100%" ><tr>
   	<td width="300px">
   	<s:form  action="/web/acct-period-input!acctPeriodImport" method="post" theme="simple" enctype="multipart/form-data">
      <s:file  id="importFile" name="importFile"></s:file>	
   
    	
    	<input type="button" value="导入" onclick="importAccPeriod()"/>
     </s:form>
    </td>
   <td align="left">
    <s:form  action="/web/acct-period-input!saveImport" method="post" theme="simple">
    	<input type="button" value="提交" onclick="save()"/>
    </s:form>
    </td>
   </tr> </table> 
    <ec:table  items="list" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/acct-period-input!queryList"
			pageSizeList="10,20,30,50" rowsDisplayed="20"
		    classic="true">
			<ec:row recordKey="${record.acctPeriodID}">
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="年份" property="acctYear" sortable="true" />
				<ec:column title="月份" property="acctMonth" sortable="true" />
				<ec:column title="店铺编号" property="depotNo" sortable="true" />
				<ec:column title="店铺名称" property="depotName" sortable="true" />
				<ec:column title="预估扣率" property="EDR" sortable="true" />
				<ec:column title="本期账期开始" property="thisPeriodBgnDate" sortable="true" />
				<ec:column title="本期账期结束" property="thisPeriodEndDate" sortable="true" />
			</ec:row>
			
		</ec:table>
  </body>
</html>