<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%String role_id =  (String)session.getAttribute("role_id"); %>

<html:html>

<title>VIP消费折扣分析表</title>

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
		
		document.forms[0].submit();
    	document.getElementById("button").disabled=true; 
    		
	
	}
	
	
	
</script>

	

<body>
	<!-- <form id="customerAnalysisForm" name="customerAnalysisForm" action="customerAnalysis.do">  -->
	<html:form action="/vipConsumeAnalysis/vipConsumeDiscountAnalysis" styleId="baseActionForm" method="post">
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
	
	
		
		<ec:table  items="vipCustomers" var="vipcustomer"  tableId="customerTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="vipConsumeDiscountAnalysis.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    xlsFileName="VIP消费折扣分析表.xls"  classic="true" title="VIP消费折扣分析表" 
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
					<%if(!"1031".equals(role_id)) {%>
					<td class="tableHeader" colspan="1"> </td>
					<%} %>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"> </td>
					<td class="tableHeader" colspan="1"></td>
					<td class="tableHeader" colspan="1"></td>
   					<td class="tableHeader"  colspan="2">7折以下</td>
   					<td class="tableHeader"  colspan="2">7-7.9折</td>
   					<td class="tableHeader"  colspan="2">8-8.9折</td>
   					<td class="tableHeader"  colspan="2">9折</td>
   					<td class="tableHeader"  colspan="2">9折以上</td>

    				
     

				</tr>			
			
			</ec:extendrow>
			
			
			
			
			
			<ec:row>
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				<ec:column  title="店铺名称 " property="dept_name" sortable="true"/>
				<ec:column  title="开店时间"  property="opentime" sortable="true" />
				<ec:column  title="分公司" property="region" sortable="true" />
				<ec:column  title="销售渠道" property="dept_channel" sortable="true" />
				<ec:column title="客户经理" property="manager" sortable="true" />
				<ec:column title="VIP卡" property="vipcode" sortable="true" />
				<ec:column title="顾客姓名" property="account_name" sortable="true" />
				<%if(!"1031".equals(role_id)) {%>
				<ec:column title="移动电话" property="account_mobile_phone" sortable="true" />
				<%} %>
				<ec:column title="发展日期" property="devdate" sortable="true" />
				<ec:column title="首单实销金额" property="sdje" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="最近购买日期" property="lastdate" sortable="true" />
				<ec:column title="本段时间消费金额 " property="fcalscsums" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				
				<ec:column title="消费金额" property="fcals7low" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费比率" property="rate7low" sortable="true" cell="number" format="0.00%" style="text-align:right"/>
				
				<ec:column title="消费金额" property="fcals8low" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费比率" property="rate8low" sortable="true" cell="number" format="0.00%"  style="text-align:right"/>
				
				<ec:column title="消费金额" property="fcals9low" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费比率" property="rate9low" sortable="true" cell="number" format="0.00%" style="text-align:right"/>
				
				<ec:column title="消费金额" property="fcals9" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费比率" property="rate9" sortable="true" cell="number" format="0.00%" style="text-align:right"/>
				
				<ec:column title="消费金额" property="fcals9up" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="消费比率" property="rate9up" sortable="true" cell="number" format="0.00%" style="text-align:right"/>
				
		
			
			</ec:row>
			
		</ec:table>

		

		
<!-- </form> -->


</body>
</html:html>

