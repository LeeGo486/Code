<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%	String loginDeptID =request.getParameter("loginDeptID"); 
  	String userID =request.getParameter("userID"); 
  	String bgnDate = request.getParameter("bgnDate")==null?"":request.getParameter("bgnDate");
    String endDate = request.getParameter("endDate")==null?"":request.getParameter("endDate");
	List arrayMonths = new ArrayList();
	String role_id =  (String)session.getAttribute("role_id");
	int months;
	int year=0;
	int month=0;
	if(endDate==null||"".equals(endDate)){
		months=1;
	
	}else{
		String[] bgnDateComponts = bgnDate.split("-");
		int bgnYear = Integer.parseInt(bgnDateComponts[0]);
		int bgnMonth = Integer.parseInt(bgnDateComponts[1]);
		String[] endDateComponts = endDate.split("-");
		int endYear = Integer.parseInt(endDateComponts[0]);
		int endMonth = Integer.parseInt(endDateComponts[1]);
	    months = (endYear-bgnYear)*12+(endMonth-bgnMonth+1);
	    year=bgnYear;
	    month=bgnMonth;
	    arrayMonths.add(bgnDateComponts[0]+"-"+bgnDateComponts[1]);
	    }
	for(int i=0;i<months-1;i++){
					String ym="";
					if(bgnDate != null && !"".equals(bgnDate)){
				    	month=month+1;
				    	if(month>12){
				    		year=year+1;
				    		month=1;
				    	}		
						if(month<10){
						  ym=ym+year+"-0"+month;
						}else{
						  ym=ym+year+"-"+month;
						}
	
		arrayMonths.add(ym);
		
		}
						
   }


%>

<html:html>

<title>VIP消费时期分析表(不包含准VIP)</title>

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
		
		var bgnDate = document.getElementById('bgnDate').value;
		var endDate = document.getElementById('endDate').value;
		if(bgnDate==null||bgnDate==''){
			alert("请起始时间");
			return;
		}
		if(endDate==null||endDate==''){
			alert("请截止时间");
			return;
		}
		
		var bgnYear = bgnDate.substr(0,4);
		var endYear = endDate.substr(0,4);
		var bgnMonth = bgnDate.substr(5,2);
		var endMonth = endDate.substr(5,2);
		if(endYear<bgnYear || (endYear==bgnYear && endMonth<bgnMonth)){
			alert("截至时间一定要大于等于起始时间 ");
			return;
		
		}
    	 
    	document.forms[0].submit();
    	document.getElementById("button").disabled=true;
	}
	
	
	
</script>

	

<body>
	<!-- <form id="customerAnalysisForm" name="customerAnalysisForm" action="customerAnalysis.do">  -->
	<html:form action="/vipConsumeAnalysis/vipConsumePeriodAnalysis" styleId="baseActionForm" method="post">
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
			retrieveRowsCallback="process" action="vipConsumePeriodAnalysis.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    xlsFileName="VIP消费时期分析表.xls"  classic="true" title="VIP消费时期分析表" 
			filterable="true">
				 
			
			
			
			
			<ec:row>
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="店铺名称" property="dept_name" sortable="true" />
				<ec:column  title="开店时间"  property="opentime" sortable="true" />
				<ec:column  title="分公司" property="region" sortable="true" />
				<ec:column  title="销售渠道" property="dept_channel" sortable="true" />
				<ec:column title="拓展人" property="manager" sortable="true" />
				<ec:column title="VIP卡" property="vipcode" sortable="true" />
				<ec:column title="顾客姓名" property="account_name" sortable="true" />
				<ec:column title="发展日期" property="devdate" sortable="true" />
				<ec:column title="首单实销金额" property="sdje" calc="total" calcTitle= "合计" calcSpan="1" sortable="true" cell="number" format="0.00" style="text-align:right"/>
				<ec:column title="年龄" property="age" sortable="true" cell="number" format="0" style="text-align:right"/>
				<ec:column title="消费类型" property="xflx" sortable="true" />
				<%if(!"1031".equals(role_id)) {%>
				<ec:column title="移动电话" property="account_mobile_phone" sortable="true" />
				<%} %>
				<ec:column title="Email" property="account_email" sortable="true" />
				
				<c:forEach items="<%=arrayMonths %>" var="ym">
				
				 <ec:column title="${ym}" property="${ym}" calc="total" calcTitle= "合计" calcSpan="1" sortable="true" cell="number" format="0.00" style="text-align:right"></ec:column>
				 
				 </c:forEach>	
				
				<ec:column title="购买总次数" property="contracts" calc="total" calcTitle= "合计" calcSpan="1" sortable="true" cell="number" format="0" style="text-align:right"/>
				<ec:column title="购买总件数" property="quantity"  calc="total" calcTitle= "合计" calcSpan="1" sortable="true" cell="number" format="0" style="text-align:right"/>
				<ec:column title="购买总金额" property="fcalscsums" calc="total" calcTitle= "合计" calcSpan="1" sortable="true" cell="number" format="0.00" style="text-align:right"/>
				<ec:column title="平均单笔件数" property="dbjs"  sortable="true"  cell="number" format="0.00" style="text-align:right"/>
				<ec:column title="平均单笔金额" property="dbje" sortable="true" cell="number" format="0.00" style="text-align:right"/>
				
				
				
				 
				 

				
				
				
			
				
				
		
			
			</ec:row>
			
		</ec:table>

		

		
<!-- </form> -->


</body>
</html:html>

