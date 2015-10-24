<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.WagePaymentInfo"%>
<%@page import="ep.org.branch.expense.dojo.WagePaymentPurposeCost"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>工资付款申请</title>
    
	

  
  	<link rel="stylesheet" type="text/css" href="<%= path%>/css/mycommon.css" />
		<script type="text/javascript" src="<%= path%>/myjs/myTime.js"></script>
		<script type="text/javascript" src="<%= path%>/js/jquery-1.5.2.min.js"></script>
	</head>
<script type="text/javascript">
 function Print() {  
	
	
	try{
			if (document.all.eprint.defaultPrinterName.length==0){
			alert("请先安装打印机，再执行此功能！");
			return;
	}

  	    eprint.InitPrint();
  	    eprint.marginTop=1;
  		eprint.marginLeft=10;
 		eprint.marginRight=10;
  		eprint.marginBottom=1;
  		eprint.header = "";
  		eprint.footer = "";
  		eprint.Print();
		window.close();
	//document.all.eprint.Print(true);//不弹出打印对话框直接打印
	}catch(e){
		initForm();
	
	}
}

function initForm(){
	try{
		if (document.all.eprint.defaultPrinterName.length==0){
		alert("请先安装打印机，再执行此功能！");
		
		}
	}
	catch(e){
	
		var url=document.getElementById("webContext").value+'/expense/webprintDownload.jsp';
		window.open(url,'webprint打印控件下载','scrollbars=yes,width=400px,height=200px,resizable=yes,menubar=no,status=no,location=no');
	}	
}

  
 </script>
	<body  onload="Print()">
		<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441"  viewasext> </object>
   		<%WagePaymentInfo wagePaymentInfo = (WagePaymentInfo)request.getAttribute("expenseInfo");%>
   		
   		
   <div style="position:relative;width: 95%;height: 100%; left: 30 ">
   <div align="center" style="height: 20"><img alt="" src="<%=path %>/img/image2.png"></div>
    
    <div style="position:absolute;top: 50;z-index: 1">
    <div align="center" style="height: 50">
    	
    <font style="font-weight: 600;font-size: 18">Wage Payment Application</font> <br> <font  style="font-weight: 600;font-size: 18">工 资 付 款 申 请</font>  </div>
    
    <div align="right" style="position: absolute;top: 2;right: 0%">
   	 <img alt="" src="<%=path%>/barcode.bracodeServlet?image=1&type=21&data=<%=wagePaymentInfo.getExpenseNo() %>&height=50" >
  	</div>
    	<br />
    
   
   
    <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black>		
   		<tr>
    		<td height="25" class="td_field_thin" colspan="8">
    			Payment Type/付款方式： <input type="checkbox" value="" />Cash/现金
    			<input type="checkbox" value="" />    T/T 电汇
    			<input type="checkbox" value=""/> Draft 汇票
    			<input type="checkbox" value ="" />	Cheque 转帐支票												
    			
    		</td>
    	</tr>
    	
    	
    	<tr>
    		<td height="45" class="td_field_thin" width="25%">Name/申请人：<br />
    			<%=wagePaymentInfo.getEmployeeName() %>		
    		</td>
    		<td class="td_field_thin" width="25%">Department/部门<br />
    			<%=wagePaymentInfo.getBranchName() %>				
			
			 </td>
    		<td class="td_field_thin" width="25%">Department Cost Centre/部门成本中心<br />
    			<%=wagePaymentInfo.getBranchCostCenter() %>								
					
    		</td>
    		<td class="td_field_thin" width="25%">Employee Code/职员编码	<br />
    			<%=wagePaymentInfo.getEmployeeID() %>						
    		
    		</td>
    	</tr>
    	<tr>
    		<td height="45" class="td_field_thin">Telephone/电话号码	<br />
    			<%=wagePaymentInfo.getTelephone() %>											
    		</td>
    		<td class="td_field_thin" colspan="2">Mobile Phone/移动电话号码<br />
    			<%=wagePaymentInfo.getTelephone() %>							
 			</td>
    		<td class="td_field_thin">Date/日期<br />
    			<%=wagePaymentInfo.getApplyDate() %>	
    		</td>
    	</tr>
    	
    	
    	<tr>
    		<td  colspan="4" class="td_field_thin" height="45">Charged to/and Reasons付款说明：<br />
    		<%=wagePaymentInfo.getRemark() %>		
    		</td>
    		
    	</tr>
    
    </table>
    
   
     <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black>		
   		<tr>
    		<td align="center" class="td_field_thin" width="4%" height="40">No<br />序号</td>    
    		<td align="center" class="td_field_thin" width="10%">Date<br/>日期</td>  
    		<td align="center" class="td_field_thin" width="25%">Justification Detailed<br />费用明细</td>
    		<td align="center" class="td_field_thin" width="12%">AMT<br/> 金额 </td>
    		<td align="center" class="td_field_thin"  width="1%" rowspan="1"></td>
    		<td align="center" class="td_field_thin" colspan="2" align="center">Type ticked by Applicant<br/>票据分类（财务部填）	</td>
    		
    		<td align="center" class="td_field_thin" width="10%">AMT<br/> 金额</td>
    	</tr>
    	<% WagePaymentPurposeCost wagePaymentPurposeCost = null;
    	   List purposeCostList = (List)request.getAttribute("WPPurposeCostList"); 
    	   wagePaymentPurposeCost = (WagePaymentPurposeCost)purposeCostList.get(0);
    	%>
    	<tr>
    		<td height="40" class="td_field_thin"  >1</td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin"><%=wagePaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" rowspan="9" width="1%"></td>
    		<td class="td_field_thin" >The General Staff Wage</td>
    		<td class="td_field_thin" >总部工资	</td>
    		<td class="td_field_thin" ></td>
    	</tr>
    	
    	
    		
    	
    	<% wagePaymentPurposeCost = (WagePaymentPurposeCost)purposeCostList.get(1); %>
    	<tr>
    		<td height="40" class="td_field_thin" >2</td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseAmout()%></td>
    		
    		<td class="td_field_thin" >The Shop Assistant Wage	</td>
    		<td class="td_field_thin">导购工资</td>
    		<td class="td_field_thin"></td>
    	
    	</tr>
    	
    		
    	
    	
    	<% wagePaymentPurposeCost = (WagePaymentPurposeCost)purposeCostList.get(2); %>
    	<tr>
    		<td height="40" class="td_field_thin" >3</td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseAmout()%></td>
    		
    		
    		<td class="td_field_thin" >The First Factory Wage</td>
    		<td class="td_field_thin">生产一厂工资	</td>
    		<td class="td_field_thin"></td>
    		
    		
    	</tr>
    
    	
    	<% wagePaymentPurposeCost = (WagePaymentPurposeCost)purposeCostList.get(3); %>
    	<tr>
    		<td height="40" class="td_field_thin" >4</td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseAmout()%></td>
    		
    		<td class="td_field_thin" >The Second Factory Wage</td>
    		<td class="td_field_thin">生产二厂工资</td>
    		<td class="td_field_thin"></td>
    		
    		
    	</tr>
    	
    	<%  wagePaymentPurposeCost = (WagePaymentPurposeCost)purposeCostList.get(4); %>
    	<tr>
    		<td height="40" class="td_field_thin" >5</td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" >Social Benefit	</td>
    		<td class="td_field_thin">社保费用</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% wagePaymentPurposeCost = (WagePaymentPurposeCost)purposeCostList.get(5); %>
    	<tr>
    		<td height="40" class="td_field_thin" >6</td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" > Bonus</td>
    		<td class="td_field_thin">奖金和奖励费用	</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% wagePaymentPurposeCost = (WagePaymentPurposeCost)purposeCostList.get(6); %>
    	<tr>
    		<td height="40" class="td_field_thin" >7</td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" > </td>
    		<td class="td_field_thin"></td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% wagePaymentPurposeCost = (WagePaymentPurposeCost)purposeCostList.get(7); %>
    	<tr>
    		<td height="40" class="td_field_thin" >8</td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" ><%=wagePaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" > </td>
    		<td class="td_field_thin"></td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    
    	<tr>
    		<td height="40" class="td_field_thin" ></td>
    		<td class="td_field_thin" ></td>
    		
    		<td class="td_field_thin"  colspan="1" >Total/合计：</td>
    		<td class="td_field_thin"><%=wagePaymentInfo.getTotalMoney() %></td>
    		<td class="td_field_thin" align="center">Total </td>
    		<td class="td_field_thin" align="center">合计	</td>
    		<td class="td_field_thin"></td>
    		
    		
    	</tr>
    	
    	<tr>
    		<td height="40" class="td_field_thin" colspan="9" height="20">TOTAL In Words/大写总金额：		
    			<%=request.getAttribute("totalMoneyCN") %>
    		</td>
    	</tr>
    	
    	
    </table>
    	<br />									
     <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black>		
   		<tr> 
    		<td class="td_field_thin" height="30" width="14.28%" align="center">部门经理批准<br /> Approved by DM</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">部门总监(部长)批准<br />Approved by BU </td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">事业部总经理 <br />Approved by BMD</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">财务审核 <br />Audited by FIN</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">财务总监 <br />Approved by FM</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">总经理 <br />Approved by MD</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">签 收 <br />Received by</td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="35" width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin" width="14.28%"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="35" >日期/Date:	</td>
    		<td class="td_field_thin" >日期/Date:</td>
    		<td class="td_field_thin" >日期/Date:</td>
    		<td class="td_field_thin"  >日期/Date:</td>
    		<td class="td_field_thin"  >日期/Date:</td>
    		<td class="td_field_thin"  >日期/Date:</td>
    		<td class="td_field_thin" >日期/Date:</td>
    	</tr>
    	
    	<tr>
    		<td class="td_field_thin" height="35" width="14.28%"></td>
    		<td class="td_field_thin" width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin"  width="14.28%"></td>
    		<td class="td_field_thin" width="14.28%"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="35" >日期/Date:	</td>
    		<td class="td_field_thin"  >日期/Date:</td>
    		<td class="td_field_thin"  >日期/Date:</td>
    		<td class="td_field_thin" >日期/Date:</td>
    		<td class="td_field_thin"  >日期/Date:</td>
    		<td class="td_field_thin"  >日期/Date:</td>
    		<td class="td_field_thin" >日期/Date:</td>
    	</tr>
    	
    	
    </table>
    </div>
    
    <br />
    <div style="position: absolute;top: 1000;z-index:2;left: 28%" >
    	<img alt="" src="<%=path %>/img/image1.jpeg" height="9">
    </div>
    
    </div>
	</body>
</html>
