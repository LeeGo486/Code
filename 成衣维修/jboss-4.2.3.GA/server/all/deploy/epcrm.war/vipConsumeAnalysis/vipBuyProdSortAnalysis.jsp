<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<html:html>

<title>VIP购买产品品类分析</title>

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
		+"&reportID=7");
	document.getElementById("button").disabled=true;
	
 }
	
	function queryDetail(queryField){
		
		var ecsideObj=ECSideUtil.getGridObj('customerTable');
		var selectedRow = ecsideObj.selectedRow;
		var deptID = selectedRow.getAttribute("recordKey");
		window.open("vipBuyProdSortDetail.do?dept_id="+deptID+"&userID="+document.getElementById('userID').value+"&queryField="+queryField,"用户信息","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
		
	}
	
	function allqueryDetail(queryField){
		var deptID = document.getElementById("deptID").value;
		if(deptID==null||deptID==''){
			alert('请选择单位!');
			return;
		}
		window.open("vipBuyProdSortDetail.do?dept_id="+deptID+"&userID="+document.getElementById('userID').value+"&queryField="+queryField,"用户信息","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
	}
	
</script>

	

<body>
	<!-- <form id="customerAnalysisForm" name="customerAnalysisForm" action="customerAnalysis.do">  -->
	<html:form action="/vipConsumeAnalysis/vipBuyProdSortAnalysis" styleId="baseActionForm" method="post">
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
			retrieveRowsCallback="process" action="vipBuyProdSortAnalysis.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    xlsFileName="VIP购买产品品类分析.xls"  classic="true" title="VIP购买产品品类分析" 
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
					
   					<td class="tableHeader"  colspan="2">购买针织衫/毛衣</td>
   					<td class="tableHeader"  colspan="2">购买连衣裙</td>
					<td class="tableHeader"  colspan="2">购买裘皮</td>
    				<td class="tableHeader"  colspan="2">购买皮衣</td>
    				<td class="tableHeader"  colspan="2">购买裤子</td>
    				<td class="tableHeader"  colspan="2">购买针织衫</td>
    				<td class="tableHeader"  colspan="2">购买外套</td>
    				<td class="tableHeader"  colspan="2">购买大衣</td>
    				<td class="tableHeader"  colspan="2">购买高级系列</td>
     

				</tr>			
			
			</ec:extendrow>
			
			
			
			
			
			<ec:row recordKey="${vipcustomer.dept_id}">
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
			
				<ec:column title="店铺名称" property="dept_name" sortable="true" />				
				<ec:column  title="开店时间"  property="opentime" sortable="true" />
				<ec:column  title="分公司" property="region" sortable="true" />
				<ec:column  title="销售渠道" property="dept_channel" sortable="true" />
				<ec:column title="VIP总数" property="VIP" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline"  ondblclick="queryDetail('VIP')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<%-- 
				<ec:column title="准V数量" property="ZVIP" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('ZVIP')" calc="total" calcTitle= "合计" calcSpan="1"/>
				--%>
				<ec:column title="销售线索" property="ZVIP" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('ZVIP')" calc="total" calcTitle= "合计" calcSpan="1"/>
			
				
				<ec:column title="选择时间段内的VIP人数" property="devvip" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('devvip')" calc="total" calcTitle= "合计" calcSpan="1"/>
				
				
				<ec:column title="数量" property="my" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('my')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="myratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<ec:column title="数量" property="lyq" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('lyq')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="lyqratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<ec:column title="数量" property="qp" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('qp')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="qpratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<ec:column title="数量" property="py" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('py')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="pyratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<ec:column title="数量" property="kz" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('kz')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="kzratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<ec:column title="数量" property="zzs" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('zzs')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="zzsratio" sortable="true" cell="number" format="0.00%" style="text-align:right" />
				
				<ec:column title="数量" property="wt" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('wt')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="wtratio" sortable="true" cell="number" format="0.00%" style="text-align:right" />
				
				<ec:column title="数量" property="dy" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('dy')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="dyratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				<ec:column title="数量" property="gj" sortable="true" cell="number" format="0" style="text-align:right;text-decoration:underline" ondblclick="queryDetail('gj')" calc="total" calcTitle= "合计" calcSpan="1"/>
				<ec:column title="占比" property="gjratio" sortable="true" cell="number" format="0.00%" style="text-align:right"  />
				
				
				
			
			</ec:row>
			
		</ec:table>

		

		
<!-- </form> -->


</body>
</html:html>

