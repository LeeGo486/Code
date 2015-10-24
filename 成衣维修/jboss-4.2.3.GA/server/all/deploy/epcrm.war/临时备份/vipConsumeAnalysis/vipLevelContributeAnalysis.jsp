<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>


<html:html>

<title>VIP等级贡献分析表</title>

<head>
		<link rel="stylesheet" type="text/css" href="../ecside/css/ecside_style.css" />
		<link rel="stylesheet" type="text/css" href="../ecside/calendar/calendar-blue.css" />
		
		<script type="text/javascript" src="../ecside/js/prototype_mini.js"></script>
		<script type="text/javascript" src="../ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="../ecside/js/ecside.js"></script>
		
		<script type="text/javascript" src="../ecside/calendar/calendar.js"></script>
		<script type="text/javascript" src="../ecside/calendar/calendar-cn-utf8.js"></script>
		<script type="text/javascript" src="../ecside/calendar/calendar-setup.js"></script>
		
		<script language="javascript" src="../myjs/myTime.js"></script>
		
</head>
<script type="text/javascript">
	var xmlhttp;
	
	function showOrg(){
		 var loginDeptID = document.getElementById("loginDeptID").value;
		 window.open("../orgmutilchecktree.jsp?loginDeptID="+loginDeptID, "选择单位", "scrollbars=yes,width=400px,height=400px;"); 
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
		+"&reportID=6");
	document.getElementById("button").disabled=true;	
 
 }
	
	function queryDetail(queryField){
		
		var ecsideObj=ECSideUtil.getGridObj('customerTable');
		var selectedRow = ecsideObj.selectedRow;
		var deptID = selectedRow.getAttribute("recordKey");
		window.open("vipLevelContributionDetail.do?dept_id="+deptID+"&userID="+document.getElementById('userID').value+"&queryField="+queryField,"用户信息","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
		
	}
	
	function allqueryDetail(queryField){
		var deptID = document.getElementById("deptID").value;
		if(deptID==null||deptID==''){
			alert('请选择单位!');
			return;
		}
		window.open("vipLevelContributionDetail.do?dept_id="+deptID+"&userID="+document.getElementById('userID').value+"&queryField="+queryField,"用户信息","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
		
	}
	
	
</script>

	

<body>
	<!-- <form id="customerAnalysisForm" name="customerAnalysisForm" action="customerAnalysis.do">  -->
	<html:form action="/vipConsumeAnalysis/vipLevelContributionAnaysis" styleId="baseActionForm" method="post">
			<html:hidden property="method" value="query"/>
			<html:hidden property="loginDeptID" value="<%=request.getParameter("loginDeptID")%>"/>
			<html:hidden  property="userID"  value="<%=request.getParameter("userID")%>" />
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
	
		<ec:table  items="vipCustomers" var="vipcustomer"  tableId="customerTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="150%" 
			retrieveRowsCallback="process" action="vipLevelContributionAnaysis.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    xlsFileName="VIP等级贡献分析表.xls"  classic="true" title="VIP等级贡献分析表" 
			filterable="true">
				 
			<ec:extendrow location="top">
				 
				<tr>
    				
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					
   					<td class="tableHeader"  colspan="4">消费低于3000</td>
   					<td class="tableHeader"  colspan="4">消费3000-4999</td>
   					<td class="tableHeader"  colspan="4">消费5000-7999</td>
   					<td class="tableHeader"  colspan="4">消费8000-9999</td>
   					<td class="tableHeader"  colspan="4">消费10000-29999</td>
   					<td class="tableHeader"  colspan="4">消费30000-49999</td>
   					<td class="tableHeader"  colspan="4">消费50000-79999</td>
   					<td class="tableHeader"  colspan="4">消费80000-99999</td>
   					<td class="tableHeader"  colspan="4">100000以上</td>

    				
     

				</tr>			
			
			</ec:extendrow>
			
			
			
			
			
			<ec:row recordKey="${vipcustomer.dept_id}">
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
			
				<ec:column title="店铺名称" property="dept_name" sortable="true" />				
				<ec:column  title="开店时间"  property="opentime" sortable="true" />
				<ec:column  title="分公司" property="region" sortable="true" />
				<ec:column  title="销售渠道" property="dept_channel" sortable="true" />
				<ec:column title="VIP总数" property="VIP" sortable="true" cell="number" format="0" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				
				<%-- 
				<ec:column title="准V数量" property="ZVIP" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('ZVIP')" calc="total" calcTitle= "合计" calcSpan="1"/>
				--%>
				<ec:column title="销售线索" property="ZVIP" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('ZVIP')" calc="total" calcTitle= "合计" calcSpan="1"/>
				
				<%--
				<ec:column title="选择时间段内的VIP发展人数"  property="devvip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('devvip')" calc="total" calcTitle= "合计" calcSpan="1"/>
				 --%>
				<ec:column title="选择时间段内的VIP人数"  property="devvip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('devvip')" calc="total" calcTitle= "合计" calcSpan="1"/>
				 
				 
				<ec:column title="销售总额" property="sumsalse" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				
				<ec:column title="VIP消费金额" property="VIPfcalcsums" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="fcalcsumsratio" sortable="true" cell="number" format="0.00%" style="text-align:right" />
				<!-- 消费低于3000  -->
				<ec:column title="人数" property="VIP1" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP1')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip1ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				<ec:column title="消费金额" property="VIPfcalcsums1" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums1ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<!-- 消费3000-4999  -->
				<ec:column title="人数" property="VIP2" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP2')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip2ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				<ec:column title="消费金额" property="VIPfcalcsums2" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums2ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<!-- 消费5000-7999  -->
				<ec:column title="人数" property="VIP3" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP3')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip3ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				<ec:column title="消费金额" property="VIPfcalcsums3" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums3ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<!-- 消费8000-9999  -->
				<ec:column title="人数" property="VIP4" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP4')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip4ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				<ec:column title="消费金额" property="VIPfcalcsums4" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums4ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<!-- 消费10000-29999  -->
				<ec:column title="人数" property="VIP5" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP5')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip5ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				<ec:column title="消费金额" property="VIPfcalcsums5" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums5ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<!-- 消费30000-49999 -->
				<ec:column title="人数" property="VIP6" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP6')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip6ratio" sortable="true" cell="number" format="0.00%" style="text-align:right" />
				<ec:column title="消费金额" property="VIPfcalcsums6" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums6ratio" sortable="true" cell="number" format="0.00%" style="text-align:right" />
				
				<!-- 消费50000-79999-->
				<ec:column title="人数" property="VIP7" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP7')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip7ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				<ec:column title="消费金额" property="VIPfcalcsums7" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums7ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<!-- 消费80000-99999-->
				<ec:column title="人数" property="VIP8" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP8')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip8ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				<ec:column title="消费金额" property="VIPfcalcsums8" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums8ratio" sortable="true" cell="number" format="0.00%" style="text-align:right" />
				
				<!-- 100000以上-->
				<ec:column title="人数" property="VIP9" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('VIP9')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="人数占比" property="vip9ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				<ec:column title="消费金额" property="VIPfcalcsums9" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费占比" property="VIPfcalcsums9ratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				
				
			</ec:row>
			
		</ec:table>

		

		
<!-- </form> -->


</body>
</html:html>

