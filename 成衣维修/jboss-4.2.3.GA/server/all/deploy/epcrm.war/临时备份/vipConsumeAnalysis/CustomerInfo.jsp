<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String role_id =  (String)session.getAttribute("role_id");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>客户信息完整度查询</title>
    
		<link rel="stylesheet" type="text/css" href="<%=path%>/ecside/css/ecside_style.css" />
		<link rel="stylesheet" type="text/css" href="<%=path%>/ecside/calendar/calendar-blue.css" />
		
		<script type="text/javascript" src="<%=path%>/ecside/js/prototype_mini.js"></script>
		<script type="text/javascript" src="<%=path%>/ecside/js/ecside_msg_utf8_cn.js"></script>
		<script type="text/javascript" src="<%=path%>/ecside/js/ecside.js"></script>
		
		<script type="text/javascript" src="<%=path%>/ecside/calendar/calendar.js"></script>
		<script type="text/javascript" src="<%=path%>/ecside/calendar/calendar-cn-utf8.js"></script>
		<script type="text/javascript" src="<%=path%>/ecside/calendar/calendar-setup.js"></script>
		
		
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
		
		<script language="javascript" src="<%=path%>/myjs/myTime1.js"></script>
		<script language="javascript" src="<%=path%>/myjs/myTime.js"></script>
		
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
		
		document.forms[0].submit();
    	document.getElementById("button").disabled=true; 
    		
	
	}
	
	
	function modifyExpenseNumber(obj){
  		var objValue = $(obj).attr('value');
  		if(isNaN(objValue)){
  			alert('只允许输入数值!');
  			$(obj).attr('value','');
  			return;
  		}else if(parseFloat(objValue)<0){
  			alert('输入金额不能小于零!');
  			$(obj).attr('value','');
  			return;
  		}
  	}
  </script>
  <body>
    <input type="hidden" id="path" value="<%=path%>">
    <html:form action="/vipConsumeAnalysis/customerFullyInfo" styleId="customerInfoForm" method="post">
			<html:hidden property="method" value="query"/>
			<html:hidden property="loginDeptID" />
			<html:hidden  property="deptID"/>
			<br />

			
					
			
			<table>
				<tr>
					
					<td width="120"> 渠道：</td>
			 		<td width="100" align="left">
			 			<html:select property="saleChannel" style="width:100">
						<html:optionsCollection name="saleChannelList" value="value" label="label"/>
						</html:select>
			 		</td>
			
					<td width="80">VIP等级：</td>
					<td width="100" align="left"> 
						<html:select property="vipLevelCode" style="width:100">
							<html:optionsCollection name="vipLevelList" value="value" label="label"/>
						</html:select>
					</td> 
					
					<td width="120">消费开始时间：</td>
					<td width="100" align="left"><html:text property="consumeBgnDate" 
						style="width:100px" onclick="setday(this)" readonly="true"/>
					</td>
					<td width="82">消费截止时间：</td>
					<td width="100" align="left"> <html:text property="consumeEndDate" 
						style="width:100px" onclick="setday(this)" readonly="true"/>
					</td>
					
					<td width="40">部门：</td>
				
					<td width="160" align="left"><html:text property="deptName" 	onclick="showOrg()" readonly="readonly" style="width:160"/></td>
			
				</tr>
				<tr>
					
					<td>生日起始日期：</td>
					<td align="left"><html:text property="bgnBirthMD" 
						style="width:100px" onclick="setdayYM(this)" readonly="true"/>
					</td>
					<td>生日截至时间：</td>
					<td align="left"><html:text property="endBirthMD" 
						style="width:100px" onclick="setdayYM(this)" readonly="true"/>
					</td>
					<td>起始发展日期：</td>
					<td align="left"><html:text property="bgnDevelopDate" onclick="setday(this)" style="width:100px"></html:text></td>
					<td>截至发展日期：</td>
					<td align="left"><html:text property="endDevelopDate" onclick="setday(this)" style="width:100px"></html:text></td>
					<td colspan="2" align="center"><html:button property="button" onclick="query()" >查询</html:button></td>
					
				</tr>
				<tr>
					
					
					<td>今年生日当月消费金额：</td>
					<td align="left"><html:text property="thisBirthMonthMinAmout" style="width:100px" onchange="modifyExpenseNumber(this)"></html:text></td>
					<td>--</td>
					<td align="left"><html:text property="thisBirthMonthMaxAmout" style="width:100px" onchange="modifyExpenseNumber(this)"></html:text></td>
					<td>去年生日当月消费金额：</td>
					<td align="left"><html:text property="lastBirthMonthMinAmout" style="width:100px" onchange="modifyExpenseNumber(this)"></html:text></td>
					<td>--</td>
					<td align="left"><html:text property="lastBirthMonthMaxAmout" style="width:100px" onchange="modifyExpenseNumber(this)"></html:text></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>今年购买金额：</td>
					<td align="left"><html:text property="thisYearMinAmout" style="width:100px" onchange="modifyExpenseNumber(this)"></html:text></td>
					<td>--</td>
					<td align="left"><html:text property="thisYearMaxAmout" style="width:100px" onchange="modifyExpenseNumber(this)"></html:text></td>
					
					<td>去年购买金额：</td>
					<td align="left"><html:text property="lastYearMinAmout"style="width:100px" onchange="modifyExpenseNumber(this)"></html:text></td>
					
					<td>--</td>
					<td align="left"><html:text property="lastYearMaxAmout"style="width:100px" onchange="modifyExpenseNumber(this)"></html:text></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			
			
			
			
	
	</html:form>
	<ec:table  items="customerList" var="vipcustomer" tableId="customerTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action="vipConsumeAnalysis/customerFullyInfo.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    xlsFileName="客户信息完整度查询.xls"  classic="true" title="客户信息完整度查询" 
			filterable="true">
			
			
			<ec:row>
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}" />
				
				<ec:column  title="分公司" property="parent_Name" editTemplate="" sortable="true" />
				
				<ec:column  title="店铺名称 " property="dept_name" sortable="true" calc="distinctcount" calcTitle= "总计"/>
				
				<ec:column  title="销售渠道" property="dept_channel" sortable="true"/>
				
				<ec:column title="VIP卡号" property="account_simple_code" sortable="true" calc="distinctcount" calcTitle= "总计"/>
				<ec:column  title="姓名" property="account_name" sortable="true" />
				<ec:column  title="客户等级" property="acct_int11" sortable="true"/>
				
				<%if(!"1031".equals(role_id)) {%>
				<ec:column title="手机" property="account_mobile_phone" sortable="true" />
				<%} %>
				<ec:column title="生日" property="acct_char03"  sortable="true" />
				
				<ec:column title="资料完整度 " property="acct_dec10" cell="number" format="0.00%" style="text-align:right;" sortable="true" calc="average" calcTitle= "总计"/>
				
				<ec:column  title="客户经理" property="USER_NAME" sortable="true" />
				
				
				
				
				<ec:column title="发展日期" property="acct_date01" cell="date"  format="yyyy-MM-dd" sortable="true" />
				
				
				
				<ec:column title="今年生日当月消费金额" property="acct_dec14" cell="number" format="0.00" style="text-align:right;" sortable="true" calc="total" calcTitle= "总计"/>
				<ec:column title="去年生日当月消费金额" property="acct_dec13" cell="number" format="0.00" style="text-align:right;" sortable="true" calc="total" calcTitle= "总计"/>
				<ec:column title="最近消费日期" property="acct_date04" cell="date"  format="yyyy-MM-dd" sortable="true" />
				<ec:column title="最近消费金额" property="acct_dec07" cell="number" format="0.00"  style="text-align:right;" sortable="true" calc="total" calcTitle= "总计" />
				
				<ec:column title="去年购买金额" property="acct_dec03" cell="number" format="0.00"  style="text-align:right;" sortable="true" calc="total" calcTitle= "总计"/>
				<ec:column title="今年购买金额" property="acct_dec04" cell="number" format="0.00"  style="text-align:right;" sortable="true" calc="total" calcTitle= "总计"/>
				
				
				
				<%-- 
				<ec:column title="今年购买次数" property="FourCount" cell="number" format="0"  style="text-align:right;" sortable="true" />
				
				<ec:column title="总消费金额" property="sum_cntrt_dec04" cell="number" format="0.00"style="text-align:right;" sortable="true" />
				<ec:column title="总消费次数" property="count_account_id" cell="number" format="0"  style="text-align:right;" sortable="true" />
				
				
			<%--   	<ec:column title="购买总金额" property="thisPeriodAmout" cell="number" format="0.00" style="text-align:right;" sortable="true" />
				<ec:column title="购买总次数" property="thisPeriodCount"  style="text-align:right;" sortable="true" />--%>
				
				
				
			
			</ec:row>
			
		</ec:table>
	
		
		
  </body>
</html>
