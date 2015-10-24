<%@ page language="java" import="java.util.*"   pageEncoding="GBK"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://www.ecside.org" prefix="ec"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>��ѯʵ����ˮ</title>
    
	
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
  	<script src="<%=path%>/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>
  </head>
  <script type="text/javascript">
  $(function(){
  		$('#bgnDate').datebox();
  		$('#endDate').datebox();
  	
  	}); 
  	
  
  function query(){
  	document.forms[0].submit();
  }
  
  function openMR(){
  	var ecsideObj=ECSideUtil.getGridObj('ecTable');
  	var  selectedRow = ecsideObj.selectedRow;
  	var recordKey = selectedRow.getAttribute("recordKey");
  	if(recordKey==null || recordKey==""){
      	$.messager.alert("��ʾ","����ѡ��һ����¼��");
      	return;
    }   
  	var url= $('#path').attr('value')+'/web/rcved-relate-rcvbl!init?rcvedID='+recordKey;
  	window.open(url, "�������", "scrollbars=yes,width=1400px,height=600px,resizable=yes,menubar=no,status=no,location=no");	
  }
  
  function freshDataGrid(){
  	document.forms[0].submit();
  }
  </script>
  
  <body>
    <input type="hidden" id="path" value="<%=request.getContextPath()%>"> 
    <s:form action="/web/reveiced-flow-query!query" method="post" theme="simple">
    	<table>
    		<tr>
    			<td>
    				����
    			</td>
    			<td>
    				<s:textfield id="bgnDate" name="bgnDate"> </s:textfield>
    				
    			</td>
    			<td>
    				����
    			</td>
    			<td>
    				<s:textfield id="endDate" name="endDate"> </s:textfield>
    			</td>
    			<td>
    				<s:select id="distriStateQuery" name="distriStateQuery" list="#request.distriStateList" listKey="value" listValue="code"></s:select>
    			</td>
    			<td>
    				��ҵ���ƣ�
    			</td>
    			<td>
    				<s:textfield id="marketName" name="marketName"> </s:textfield>
    			</td>
    			
    			
    			<td>
    				<input type="button" onclick="query()" value="��ѯ">
    			  	<input type="button" onclick="openMR()" value="�������">
    			</td>
    			
    		</tr>
    	</table>
    </s:form>
    
     <ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/reveiced-flow-query!query"
			pageSizeList="10,20,30,50" rowsDisplayed="20" xlsFileName="ʵ����ˮ��¼.xls"
		    classic="true">
			<ec:row recordKey="${record.guid}">
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="������" property="recvedYMD" sortable="true" />
				<ec:column title="��������" property="depotName" sortable="true" />
				<ec:column title="��ҵ����" property="marketName" sortable="true" />
				<ec:column title="���루��" property="rcvedAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="�ѷ��䣨��" property="distriAmout" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="������" property="importer" sortable="true" />
				<ec:column title="����ʱ��" property="importTime" cell="date"  format="yyyy-MM-dd" sortable="true" />
				<ec:column title="����״̬" property="distriState" sortable="true" />
			</ec:row>
		</ec:table>
    
  </body>
</html>
