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
    
    <title>�������ݵ���</title>
    
	
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
  			$.messager.alert("��ʾ","����ɹ���");
  			query();
  		}else if(rs=='0'){
  			$.messager.alert("��ʾ","����ʧ�ܣ�");
  			return;
  		}else if(rs=='-1'){
  			$.messager.alert("��ʾ","Excel����ʧ�ܣ�");
  			return;
  		}else if(rs=='-2'){
  			$.messager.alert("��ʾ","Excelû�����ݻ��ߴ��ڲ�ͬ���ڣ�");
  			return;
  		}else if(rs=='-3'){
  			$.messager.alert("��ʾ","�޷����룬ԭ��һ�����ڵ� ����ֻ����һ�Σ������������Ѿ����������");
  			return;
  		}
  	}
  	function importFinanceData(){
  		var fileName = $('#file').attr('value');
  		if(fileName==null || fileName==''){
  			alert('��ѡ�����ļ�');
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
  			alert('����û����Ҫ����ļ�¼');
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
  			alert("�����ļ��ĺ�׺������Ϊxls");
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
    	<input type="button" value="����" onclick="importFinanceData()"/>
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
			pageSizeList="10,20,30,50" rowsDisplayed="20" xlsFileName="��������.xls" 
		    classic="true">
			<ec:row >
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="���̱��" property="depotNo" sortable="true" />
				<ec:column title="��������" property="depotName" sortable="true" />
				<ec:column title="pos�������" property="posExprotAmount" sortable="true" />
				<ec:column title="posʵ��" property="posActualSales" sortable="true" />
				<ec:column title="������" property="difAmout" sortable="true" />
				<ec:column title="Ԥ������" property="expectSettleAmount" sortable="true" />
				<ec:column title="����" property="periodDate" sortable="true" />
			</ec:row>
			
		</ec:table>
   	 	
  </body>
</html>
