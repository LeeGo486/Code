<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>


<html:html>

<title>顾客招募分析表</title>

<head>
		<link rel="stylesheet" type="text/css" href="ecside/css/ecside_style.css" />
		<link rel="stylesheet" type="text/css" href="ecside/calendar/calendar-blue.css" />
		
		<script type="text/javascript" src="ecside/js/prototype_mini.js"></script>
		<script type="text/javascript" src="ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="ecside/js/ecside.js"></script>
		
		<script type="text/javascript" src="ecside/calendar/calendar.js"></script>
		<script type="text/javascript" src="ecside/calendar/calendar-cn-utf8.js"></script>
		<script type="text/javascript" src="ecside/calendar/calendar-setup.js"></script>
		
		<script language="javascript" src="myjs/myTime.js"></script>
		
</head>
<script type="text/javascript"><!--
	var xmlhttp;
	
	function showOrg(){
		 var loginDeptID = document.getElementById("loginDeptID").value;
		 window.open("orgmutilchecktree.jsp?loginDeptID="+loginDeptID, "选择单位", "scrollbars=yes,width=400px,height=400px;"); 
	}

	function setOrg(deptname,deptid){
		document.getElementById("deptName").value=deptname;
		document.getElementById("deptID").value=deptid;
		
	}
	
	function query(){
		if(document.getElementById('deptID').value==null||document.getElementById('deptID').value==''){
			alert("请选择单位");
			return;
		}
		if(document.getElementById('bgnDate').value==null||document.getElementById('bgnDate').value==''){
			alert("请起始时间");
			return;
		}
		if(document.getElementById('endDate').value==null||document.getElementById('bgnDate').value==''){
			alert("请截止时间");
			return;
		}
		
		
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    	 
    	document.forms[0].submit();
    	
    }
	
	};
	
	
	
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=executeProduce&produceName=sp_crm_report&loginDeptID="
		+document.getElementById('loginDeptID').value
		+"&deptID="+document.getElementById('deptID').value
		+"&bgnDate="+document.getElementById('bgnDate').value
		+"&endDate="+document.getElementById('endDate').value
		+"&deptName="+document.getElementById('deptName').value
		+"&userID="+document.getElementById('userID').value
		+"&reportID=1");
	
		document.getElementById("button").disabled=true;
		
		
		
		
		
		
	
	}
	
	function queryDetail(queryField){
		
		var ecsideObj=ECSideUtil.getGridObj('customerTable');
		var selectedRow = ecsideObj.selectedRow;
		var deptID = selectedRow.getAttribute("recordKey");
		window.open("customersInfo.do?dept_id="+deptID+"&userID="+document.getElementById('userID').value+"&queryField="+queryField,"用户信息","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
		
	}
	
	function allqueryDetail(queryField){
		var deptID = document.getElementById("deptID").value;
		if(deptID==null||deptID==''){
			alert('请选择单位!');
			return;
		}
		window.open("customersInfo.do?dept_id="+deptID+"&userID="+document.getElementById('userID').value+"&queryField="+queryField,"用户信息","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
	}
	
--></script>

	

<body>
	
	<html:form action="/customerAnalysis" styleId="customerAnalysisForm" method="post">
	<!-- <form id="customerAnalysisForm" name="customerAnalysisForm" action="customerAnalysis.do">  -->
	<html:hidden property="method" value="query"/>
			<html:hidden property="loginDeptID" />
			<html:hidden  property="userID" />
			<html:hidden  property="deptID"/>

			起始时间：
			<html:text property="bgnDate" 
				style="width:200px" onclick="setday(this)" readonly="readonly"/>
			截至时间：
			<html:text property="endDate" 
				style="width:200px" onclick="setday(this)" readonly="readonly"/>


			部门：
			<html:text property="deptName" 	onclick="showOrg()" readonly="readonly"/>
			<html:button property="button" onclick="query()" >查询</html:button>
	
	</html:form>	
	<ec:table  items="customerList" var="customer"  tableId="customerTable"
			useAjax="false" doPreload="false" width="105%"
			showHeader="true" toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			retrieveRowsCallback="process" action="customerAnalysis.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    xlsFileName="顾客招募分析表.xls"  classic="true" title="顾客招募分析表" 
			filterable="true">
			<ec:extendrow location="top">
				 
	<tr>
    <td class="tableHeader" colspan="1"> </td>
    <td class="tableHeader" colspan="1"> </td>
    <td class="tableHeader" colspan="1"> </td>
 	<td class="tableHeader" colspan="1"> </td>
     <td class="tableHeader" colspan="1"> </td>
    <td class="tableHeader"  colspan="2">VIP总数</td>
   

    <td class="tableHeader"  colspan="1"> </td>
	<td class="tableHeader"  colspan="1"> 散客消费单数</td>
    <td class="tableHeader"  colspan="1"> </td>
     <td class="tableHeader"  colspan="1"> </td>
     <td class="tableHeader"  colspan="1"> </td>
     <%--<td class="tableHeader"  colspan="1"> </td> --%>
    <%-- <td class="tableHeader"  colspan="1"> </td>
     --%>
    
    
    <td class="tableHeader"  colspan="2">发展1个月内再次购买的VIP数量</td>
    
    
     <td class="tableHeader"  colspan="2">发展3个月内再次购买的VIP数</td>
     
     <td class="tableHeader"  colspan="2">发展6个月内再次购买的VIP数</td>
     
     <td class="tableHeader"  colspan="2">发展1年内再次购买的VIP数</td>
     
     

	</tr>			
			
			</ec:extendrow>
			
			
			
			
			<ec:row recordKey="${customer.dept_id}">
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}" />
				
				<ec:column  title="店铺名称 " property="dept_name" sortable="true" />
				<ec:column  title="开店时间"  property="opentime" cell="date" format="yyyy-MM-dd" sortable="true" />
				<ec:column  title="分公司" property="region" sortable="true" />
				<ec:column  title="销售渠道" property="dept_channel" sortable="true" />
				<ec:column title="VIP" property="vip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP')" calc="total" calcTitle= "合计" />
				<ec:column title="准VIP" property="ZVIP" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('ZVIP')" calc="total" calcTitle= "合计" />
				
				
				
				<ec:column title="VIP合计数" property="vipsum" sortable="true" cell="number" format="0" style="text-align:right" calc="total" calcTitle= "合计" />
				<%--
				<ec:column title="（即：应建准V数）" property="skd" sortable="true" cell="number" format="0" style="text-align:right" calc="total" calcTitle= "合计" />
				 --%>
				<ec:column title="（即：应建新VIP数）" property="skd" sortable="true" cell="number" format="0" style="text-align:right" calc="total" calcTitle= "合计" />
				
				<%--
				<ec:column title="实建准V数" property="devzvip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('devzvip')" calc="total" calcTitle= "合计" />
				 --%>
				<ec:column title="实建新VIP数" property="devzvip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('devzvip')" calc="total" calcTitle= "合计" />
				
				<%--
				<ec:column title="准V建档率" property="zvjdl" sortable="true" cell="number" format="0.00%" style="text-align:right;"/>
				 --%>
				<ec:column title="新VIP发展率" property="zvjdl" sortable="true" cell="number" format="0.00%" style="text-align:right;"/>
				
				
				<%-- 
				<ec:column title="选定时间内转化数" property="turnvip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('turnvip')" calc="total" calcTitle= "合计" />
				--%>
				<ec:column title="销售线索转化VIP数" property="turnvip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('turnvip')" calc="total" calcTitle= "合计" />
			
				
				
				<%--
				<ec:column title="历史累计转化数" property="histrunvip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('histrunvip')" calc="total" calcTitle= "合计" />
				 --%>
				<%--
				<ec:column title="VIP转化率" property="vipturnratio" sortable="true" cell="number" format="0.00%" style="text-align:right;"/>
				 --%>
				
				<ec:column title="VIP" property="vipin30" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('vipIN30')" calc="total" calcTitle= "合计" />
				<ec:column title="占比" property="vipin30ratio" sortable="true" cell="number" format="0.00%" style="text-align:right;"/>
				
				<%--
				<ec:column title="准VIP" property="zvipin30" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('zvipIN30')" calc="total" calcTitle= "合计" />
				 --%>
				
				<ec:column title="VIP " property="vipin90" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('vipIN90')" calc="total" calcTitle= "合计" />
				<ec:column title="占比" property="vipin90ratio" sortable="true" cell="number" format="0.00%" style="text-align:right;"/>
				<%--
				<ec:column title="准VIP" property="zvipin90" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('zvipIN90')" calc="total" calcTitle= "合计" />
				 --%>
				 
				<ec:column title="VIP" property="vipin180" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('vipIN180')" calc="total" calcTitle= "合计" />
				<ec:column title="占比" property="vipin180ratio" sortable="true" cell="number" format="0.00%" style="text-align:right;"/>
				 
				<ec:column title="VIP" property="vipin365" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('vipIN365')" calc="total" calcTitle= "合计" />
				<ec:column title="占比" property="vipin365ratio" sortable="true" cell="number" format="0.00%" style="text-align:right;"/>
				<%--
				<ec:column title="准VIP"  property="zvipin365" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('zvipIN365')" calc="total" calcTitle= "合计" />
				 --%>
			</ec:row>
			
			
		</ec:table>
<%-- 
一、	名词解释：<br>
&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">VIP合计数：选定时间内转化数+历史累计转化数 </font><br>
&nbsp;&nbsp;&nbsp;&nbsp; <font color="red">实建准V数：指在选定的时间内建档的所有顾客（包括一次性满足条件的和累计满足条件的顾客）</font><br>
&nbsp;&nbsp;&nbsp;&nbsp; <font color="red">VIP转化数：1、选定时间内转化数：指选定的时间内建档并转化的顾客数量；</font><br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; <font color="red">2、历史累计转化数：指选定之间外建档，但在选定时间内转化的顾客数量（即：不管顾客在何时建档，只要在选定的时间内转化的都算）</font><br>
&nbsp;&nbsp;&nbsp;&nbsp; <font color="red">发展1个月、3个月、1年再次购买的VIP数 ：在选定的时间内发展的VIP合计数中的顾客第2次回头消费的</font><br>
二、	公式阐述：	<br>&nbsp;&nbsp;&nbsp;&nbsp; 准V建档率=实建准V数/ 散客消费单数<br>
&nbsp;&nbsp;&nbsp;&nbsp; <font color="red">VIP转化率=选定时间内转化数 / 散客消费单数</font>  <br>
&nbsp;&nbsp;&nbsp;&nbsp; 发展1个月内再次购买的VIP数量= VIP / VIP合计数<br>
&nbsp;&nbsp;&nbsp;&nbsp; 发展3个月内再次购买的VIP数量= VIP / VIP合计数<br>
&nbsp;&nbsp;&nbsp;&nbsp; 发展1年内再次购买的VIP数量= VIP / VIP合计数		
--%>																 
		 
<!-- </form> -->


</body>
</html:html>

