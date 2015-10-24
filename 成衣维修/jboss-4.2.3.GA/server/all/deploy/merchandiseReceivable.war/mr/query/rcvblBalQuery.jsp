<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
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
    
    <title>�ٻ�Ӧ���˿���ϸ��ѯ</title>
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
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cmcommon.css">
	

  </head>
   <script type="text/javascript">
   $(function(){
  		$('#bgnYM').datebox({
  			onSelect:function(date){
  				var year = date.getFullYear();
  				var month = '0'+(date.getMonth()+1);
  				month = month.substring(month.length-2,month.length);
  				var ym =  year+'-'+month;
  				$('#bgnYM').datebox('setValue',ym);
  			}
  		});
  		$('#endYM').datebox({
  			onSelect:function(date){
  				var year = date.getFullYear();
  				var month = '0'+(date.getMonth()+1);
  				month = month.substring(month.length-2,month.length);
  				var ym =  year+'-'+month;
  				$('#endYM').datebox('setValue',ym);
  			}
  		});
  		
  	
  	}); 
  	
  	
  	function query(){
  		var bgnYM = $('#bgnYM').datebox('getValue');
  		var endYM = $('#endYM').datebox('getValue');
  		if(bgnYM ==null || bgnYM==''){
  			alert('��ʼ���ڲ���Ϊ��');
  			return;
  		}
  		if(endYM ==null || endYM==''){
  			alert('��ֹ���ڲ���Ϊ��');
  			return;
  		}
  		document.forms[0].submit();
  	}
 </script> 
  
  <body>
    <s:form action="/web/rcvbl-bal-query!query" method="post" theme="simple" >
    	<table>
    		<tr>
    			<td>
    				���̣�			
    			</td>
    			<td>
    				<s:textfield name="condition.depotName"></s:textfield>
    			</td>
    			
    			<td>
    				���ڣ���			
    			</td>
    			<td>
    				<s:textfield id="bgnYM" name="condition.bgnYm"></s:textfield>
    			</td>
    			
    			<td>
    				����			
    			</td>
    			<td>
    				<s:textfield id="endYM" name="condition.endYm"></s:textfield>
    			</td>
    			<td>		
    				<s:select  name="condition.queryType" list="#request.queryTypeList" listKey="code" listValue="value"></s:select>
      			</td>
    			
    			
    			<td>
    				<input type="button" value="��ѯ" onclick="query()">
    			</td>
    		</tr>
    	</table>
    	
    	
    	
    
    </s:form>
    
    
    <ec:table  items="list" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="web/rcvbl-bal-query!query"
			pageSizeList="10,15,20,30,50" rowsDisplayed="15"  xlsFileName="�ٻ�Ӧ���˿����.xls"
		    classic="true">
			<ec:row >
				<ec:column  property="_0" title="���"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="��������" property="depotName" sortable="true" />
				<ec:column title="Ӧ���ʿ����" property="allbal" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				<ec:column title="δ���ڿ�" property="unexpiredBal" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				<ec:column title="���ڿ�" property="expiredBal" cell="number" format="0.00"style="text-align:right;"  sortable="true" />
				
				
				<%List<String> list =  (List<String>)request.getAttribute("array_ym") ;
					String prex = "y";
					for(int i=0;i<list.size();i++){
				%>
				 <ec:column title="<%=list.get(i)%>" property="<%=prex+list.get(i)%>"  sortable="true" cell="number" format="0.00" style="text-align:right"></ec:column>
				 <%} %>
				
				
			
				
			</ec:row>
    </ec:table>
    
  </body>
</html>
