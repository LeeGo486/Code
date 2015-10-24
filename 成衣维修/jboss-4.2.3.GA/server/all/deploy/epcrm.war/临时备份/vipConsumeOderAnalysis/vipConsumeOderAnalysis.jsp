<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>


<%String role_id =  (String)session.getAttribute("role_id"); %>

<html:html>

	<title>VIP客户消费排名分析表(不包含准VIP)</title>

	<head>
		<link rel="stylesheet" type="text/css"
			href="../ecside/css/ecside_style.css" />
		<link rel="stylesheet" type="text/css"
			href="../ecside/calendar/calendar-blue.css" />

		<script type="text/javascript" src="../ecside/js/prototype_mini.js"></script>
		<script type="text/javascript"
			src="../ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="../ecside/js/ecside.js"></script>

		<script type="text/javascript" src="../ecside/calendar/calendar.js"></script>
		<script type="text/javascript"
			src="../ecside/calendar/calendar-cn-utf8.js"></script>
		<script type="text/javascript"
			src="../ecside/calendar/calendar-setup.js"></script>

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
		<html:form  action="/vipConsumeOderAnalysis/vipConsumeOderAnalysis" styleId="baseActionForm" method="post">
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
		<ec:table items="vipCustomers" var="vipcustomer"
			tableId="customerTable" useAjax="false" doPreload="false"
			toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true" width="115%" retrieveRowsCallback="process"
			action="vipConsumeOderAnalysis.do" pageSizeList="10,20,30,50"
			rowsDisplayed="20" editable="false" xlsFileName="VIP客户消费排名分析表.xls"
			classic="true" title="VIP客户消费排名分析表" filterable="true">





			<ec:row>



				<ec:column property="_0" title="序号" value="${GLOBALROWCOUNT}" />


				<ec:column title="拓展店铺 " property="shopName" sortable="true" />
				<ec:column title="开店时间" property="opentime" sortable="true" />
				<ec:column title="分公司" property="region" sortable="true" />
				<ec:column title="店铺渠道" property="dept_channel" sortable="true" />
				<ec:column title="顾客姓名" property="customerName" sortable="true" />
				<ec:column title="VIP卡" property="cardID" sortable="true" />
				<ec:column title="行业" property="industry" sortable="true" />
				<ec:column title="岗位" property="job" sortable="true" />
				<ec:column title="拓展人" property="manager" sortable="true" />
				<ec:column title="发展日期" property="devDate" sortable="true" />
				<ec:column title="年龄" property="age" sortable="true" cell="number" format="0" style="text-align:right" />
				<ec:column title="生日 " property="birthday" sortable="true" />
				<ec:column title="消费类型" property="cumsumerType" sortable="true" />
				<ec:column title="VIP等级" property="VIPLevel" sortable="true" />
				<ec:column title="本段时间消费金额" property="thisPeriodValue" sortable="true" cell="number" format="0.00" style="text-align:right"  calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="首单实销金额" property="firstComsumValue" sortable="true" cell="number" format="0.00"	style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="最近消费金额" property="lastComsumValue" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="最近消费日期" property="lastComsumDate" sortable="true" />
				<ec:column title="总消费次数" property="totalComsumNum" sortable="true" cell="number" format="0" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="总消费金额" property="totalComsumValue" sortable="true" cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="今年购买金额" property="thisYearValue" sortable="true"	cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="去年购买金额" property="lastYearValue" sortable="true"	cell="number" format="0.00" style="text-align:right" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="POS积分" property="posPoints" sortable="true"	cell="number" format="0" style="text-align:right" />
				<ec:column title="性别" property="sex" sortable="true" />
				<ec:column title="接受的沟通方式" property="communicationType" sortable="true" />
				<%if(!"1031".equals(role_id)) {%>
				<ec:column title="移动电话" property="mobilePhone" sortable="true" />
				<%} %>
				<ec:column title="Email" property="eMail" sortable="true" />
				<%if(!"1031".equals(role_id)) {%>
				<ec:column title="通讯地址" property="address" sortable="true" />
				<%} %>

			</ec:row>

		</ec:table>




		<!-- </form> -->


	</body>
</html:html>

