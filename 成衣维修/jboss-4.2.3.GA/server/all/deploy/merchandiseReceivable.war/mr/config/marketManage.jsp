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
    
    <title>��ҵ����</title>
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
  			alert('��������ҵ����');
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
  			alert('��ѡ��Ҫɾ���ļ�¼��');
  			return
  		}
  		if(confirm("ȷ��Ҫɾ������ҵ��")){
  			$('#deleteID').attr('value',recordKey);
  			$('#marketForm').attr('action',$('#path').attr('value')+'/web/market-archives!delete');
  			document.forms[0].submit();
  		}
  		
  		
  	}
  	function initForm(){
  		var result = $('#result').attr('value');
  		if(result=='1'){
  			alert('�����ɹ���');
  			return;
  		}else if(result=='0'){
  			alert('����ʧ�ܣ�');
  			return;
  		}
  		
  	}
  	
  	function addMarketArchives(){
  		var url  = $('#path').attr('value')+'/web/market-archives!init';
  		window.open(url, "��ҵ��Ϣ�༭", "scrollbars=yes,width=800px,height=600px;");
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
      		$.messager.alert("��ʾ","����ѡ��һ����¼��");
      		return;
      	}
      	
  		var url  = $('#path').attr('value')+'/web/market-archives!modifyInit?guid='+recordKey;
  		window.open(url, "��ҵ��Ϣ�༭", "scrollbars=yes,width=800px,height=600px;");
  	}
  
  </script>
  <body onload="initForm()">
    <input type="hidden" id="path" value="<%=path%>">
    <input type="hidden" id="result" value="<%=request.getAttribute("result")%>">
    
    <s:form id="marketForm" action="/web/market-archives!queryMarketList" theme="simple" method="post" >
    	<input type="hidden" id="deleteID" name="deleteID">
    	<s:textfield name="marketArchives.marketName"></s:textfield>
    	<input type="button" value="��ѯ" onclick="queryMarketArchives()">
    	<input type="button" value="����" onclick="addMarketArchives()">
    	<input type="button" value="�޸�" onclick="modifyMarketArchives()">
    	<input type="button" value="ɾ��" onclick="deleteMarketArchives()">
    	
    	<!-- <div id="inputHidden" class="easyui-window" data-options="closed:true,modal:true,title:'��ҵ����¼��'" style="width:650px;height:300px;">
			
			<table>
				<tr>
					<td>��&nbsp;ҵ&nbsp;��&nbsp;�ƣ�<input type="text" id="marketName" name="marketName"></td>
					<td width="400px">��&nbsp;ҵ&nbsp;url&nbsp;��<input type="text" id="marketUrl" name="marketUrl" style="width: 300px"></td>
				</tr>
				<tr>
					<td>��ҵ�û�����<input type="text" id="marketUsername" name="marketUsername"></td>
					<td>��ҵ���룺<input type="text" id="marketPassword" name="marketPassword"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="����" onclick="addMarketArchives()">
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
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				<ec:column title="��ҵ����" property="marketName" sortable="true" />
				<ec:column title="��ַ" property="marketUrl" ondblclick="openUrl('${record.marketUrl}')" sortable="true" />
				<ec:column title="�û���" property="marketUsername" sortable="true" />
				<ec:column title="����" property="marketPassword" sortable="true" />
				<ec:column title="�����㵥����" property="produceSettleBillDate" sortable="true" />
				<ec:column title="��˰Ʊ��ֹ����" property="rcvTaxVoteEndDate" sortable="true" />
				<ec:column title="��ע" property="comment" sortable="true" />
			</ec:row>
			
		</ec:table>
    
  </body>
</html>
