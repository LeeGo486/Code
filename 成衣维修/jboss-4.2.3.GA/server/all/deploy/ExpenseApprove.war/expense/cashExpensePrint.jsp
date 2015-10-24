<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.CashExpenseInfo"%>
<%@page import="ep.org.branch.expense.dojo.CashExpensePurposeCost"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>现金付款单打印</title>
    
	<link rel="stylesheet" type="text/css" href="<%= path%>/css/mycommon.css" />
	<style type="text/css">
		body {font-family:Sans-serif;}
		
	</style>
	
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

function Preview() 
{
	
	try{
	
		if (document.all.eprint.defaultPrinterName.length==0){
			alert("请先安装打印机，再执行此功能！");
			return;
		}

  		eprint.InitPrint();
 		//document.all.webprint.SetMarginMeasure(2);//1mm是default, 2 inch
  		eprint.marginTop=1;
  		eprint.marginLeft=1;
 		eprint.marginRight=1;
  		eprint.marginBottom=1;
 		eprint.header = "";
  		eprint.footer = "";
  		eprint.Preview();
  		window.close();
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
   <%CashExpenseInfo cashExpenseInfo = (CashExpenseInfo)request.getAttribute("cashExpenseInfo");%>
   
   <div style="position:relative;width: 95%;height: 100%; left: 30 ">
   <div align="center" style="height: 20"><img alt="" src="<%=path %>/img/image2.png"></div>
    
    <div style="position:absolute;top: 50;z-index: 1">
    <div align="center" style="height: 50">
    	
    <font style="font-weight: 600;font-size: 18">Petty Cash Request</font> <br> <font  style="font-weight: 600;font-size: 18">现金付款申请 </font>  </div>
    
    <div align="right" style="position: absolute;top: 2;right: 0%">
   	 <img alt="" src="<%=path%>/barcode.bracodeServlet?image=1&type=21&data=<%=cashExpenseInfo.getCashExpenseNo() %>&height=50" >
  	</div>
    	<br />
    <div style="width: 100%;border: 1;border-color: red;" >
    	
    	
    <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
    	  <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE:collapse; " bgColor=white borderColor=black>		
    	
    		<tr>
    			<td class="td_field_thin" >
    	Instruction:The invoice must be affixed separately.<br/>
    	         &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;  &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;       The expense is just to be paied for personal's cash request.<br />
    	费用说明：发票必须要每张分开贴，可以看清楚。费用是付给个人的现金费用。
    			</td>
    		</tr>
    	</table>
    	
    </div>
    <table height="5">
    	<tr  height="4">
    	<td  height="2">
    	</td>
    	</tr>
    	
    </table>
    
    
 <%--   <table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%> 
    	
     <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse; " bgColor=white borderColor=black>		
    
    	<tr>
    		<td class="td_field_thin" width="35%">Name/申请人：			
    		</td>
    		<td class="td_field_thin" width="17%"><%=cashExpenseInfo.getEmployeeName()%> </td>
    		<td class="td_field_thin" width="31%">Report to/上司：		
    		</td>
    		<td class="td_field_thin" width="17%"><%=cashExpenseInfo.getLeadername()%></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin">Department/部门（店铺）全称：						
    		</td>
    		<td class="td_field_thin"><%=cashExpenseInfo.getBranchName() %> </td>
    		<td class="td_field_thin">Date/日期：		
    		</td>
    		<td class="td_field_thin"><%=cashExpenseInfo.getApplyDate() %> </td>
    	</tr>
    	<tr>
    		<td class="td_field_thin">Department Cost Centre/部门成本中心代码：			
			
    		</td>
    		<td class="td_field_thin"><%=cashExpenseInfo.getBranchCostCenter() %> </td>
    		<td class="td_field_thin">Telephone/电话号码：</td>
    		<td class="td_field_thin"><%=cashExpenseInfo.getTelephone() %> </td>
    	</tr>
    	
    	<tr>
    		<td class="td_field_thin" >Employee Code/职员编码：			
		
    		</td>
    		<td class="td_field_thin" ><%=cashExpenseInfo.getEmployeeID() %> </td>
    		<td class="td_field_thin" >Mobile phone/移动电话：			
    		</td>
    		<td class="td_field_thin"><%=cashExpenseInfo.getMobilephone() %> </td>
    	</tr>
    	<tr>
    		<td colspan="4" class="td_field_thin" height="27">Charged to/and Reasons付款说明：<%=cashExpenseInfo.getBankAccout() %>		
    		</td>
    		
    	</tr>
    
    </table>
    
   <%--<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black"> --%> 
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse; " bgColor=white borderColor=black>		
    	
    	<tr>
    		<td class="td_field_thin" width="4%" height="30">No<br />序号</td>    
    		<td class="td_field_thin" width="10%">Date<br/>日期</td>  
    		<td class="td_field_thin" width="25%">Justification Detailed<br />费用明细</td>
    		<td class="td_field_thin" width="12%">AMT<br/> 金额 </td>
    		<td class="td_field_thin" colspan="3" align="center">Type ticked by Applicant(filled by FIN)<br/>票据分类（财务部填）	</td>
    		
    		<td class="td_field_thin" width="10%">AMT<br/> 金额</td>
    	</tr>
    	<% CashExpensePurposeCost cashExpensePurposeCost = null;
    	   List purposeCostList = (List)request.getAttribute("purposeCostList"); 
    	   cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(0);
    	%>
    	<tr>
    		<td class="td_field_thin" rowspan="2" >1</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" rowspan="24" width="1%"></td>
    		<td class="td_field_thin" height="15" >office expense</td>
    		<td class="td_field_thin" width="130">办公费用</td>
    		<td class="td_field_thin" ></td>
    	</tr>
    	<tr>
    	
    		<td class="td_field_thin" height="15">Salary social benefits</td>
    		<td class="td_field_thin">工资社会保险  		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(1); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">2</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Image and display	</td>
    		<td class="td_field_thin">陈列费用    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Office Supplies	</td>
    		<td class="td_field_thin">统一福利费			</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(2); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">3</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Network&Phone expense</td>
    		<td class="td_field_thin">电话宽带费用			</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Local traffic allowance</td>
    		<td class="td_field_thin">市内交通费</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(3); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">4</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Meetting	  		</td>
    		<td class="td_field_thin">会务费 		 		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Training			</td>
    		<td class="td_field_thin">培训费   		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(4); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">5</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Maintenance	
    		</td>
    		<td class="td_field_thin">维护费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Administration expense	
    		</td>
    		<td class="td_field_thin">行政管理费 
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(5); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">6</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Customs\inspection\testing	
    		</td>
    		<td class="td_field_thin">报关\商检费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Export commissions	
    		</td>
    		<td class="td_field_thin">外销费用
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(6); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">7</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Insurance	
    		</td>
    		<td class="td_field_thin">保险费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Consultancy	
    		</td>
    		<td class="td_field_thin">中介服务费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(7); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">8</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Rental	
    		</td>
    		<td class="td_field_thin">租金
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Water and electricity	
    		</td>
    		<td class="td_field_thin">水电能源费 
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(8); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">9</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Recruitment	
    		</td>
    		<td class="td_field_thin">招聘费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Desgin fee	
    		</td>
    		<td class="td_field_thin">设计费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(9); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">10</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Advertisement media	
    		</td>
    		<td class="td_field_thin">广告费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Advertisement printed material	
    		</td>
    		<td class="td_field_thin">宣传费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(10); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">11</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Material expense	
    		</td>
    		<td class="td_field_thin">物料消耗
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Decoration	
    		</td>
    		<td class="td_field_thin">零星装修费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    		<% cashExpensePurposeCost = (CashExpensePurposeCost)purposeCostList.get(11); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">12</td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=cashExpensePurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="15">Shop manage expense	
    		</td>
    		<td class="td_field_thin">店铺管理费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="15">Shop other expense	
    		</td>
    		<td class="td_field_thin">店铺其他杂费
    		</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin"  colspan="3" height="20" align="center">Total/合计：				
    		</td>
    		<td class="td_field_thin"><%=cashExpenseInfo.getTotalMoney() %></td>
    		<td class="td_field_thin"></td>
    		<td class="td_field_thin" align="center">Total </td>
    		<td class="td_field_thin">合计	</td>
    		<td class="td_field_thin"></td>
    		
    	</tr>
    	
    	<tr>
    		<td class="td_field_thin" colspan="9" height="20">TOTAL In Words/大写总金额：		
    			<%=request.getAttribute("totalMoneyCN") %>
    		</td>
    	</tr>
    	
    	<tr>
    		<td  height="20" class="td_field_thin" colspan="4">The temporary Cash Advance remainder/临时借款余额
    		</td>
    		<td height="20"  class="td_field_thin" colspan="4" rowspan="3" align="center">The actual payment 实际支付金额：<font style="text-decoration: underline; "> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; </font>                     元（出纳填写<br/> Filled by Cashier ）						
			</td>
    	</tr>
    	
    	
    	<tr>
    		<td height="20" class="td_field_thin" colspan="4" align="center">Offset Cash Advance 抵冲借款：    <br />     						
				&nbsp;&nbsp;<input type="checkbox">  Yes是 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;      <input type="checkbox">No否						
				
    		</td>
    		
    		
    	</tr>
    	
    	<tr>
    		<td height="20" class="td_field_thin" colspan="4">The amount to offset Cash Advance/抵冲借款金额

    		</td>
    		
    		
    	</tr>
    </table>
    <font size="1">Approved by RD/需求部门审批（如有需求部门，“需求部门”则由申请人负责填写，并交由需求部门长签字确认）</font>
    
  <%--  <table  width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%> 
    	
     <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse; " bgColor=white borderColor=black>		
    	<tr>
    		<td class="td_field_thin" height="27" width="14.20%" align="center">
    			需求部门<br/><span style="font-size:12px">RD</span></td>
    		<td class="td_field_thin" height="27" width="16.20%"></td>
    		<td class="td_field_thin" height="27" width="14.20%"></td>
    		<td class="td_field_thin" height="27" width="14.20%"></td>
    		<td class="td_field_thin" height="27" width="14.20%"></td>
    		<td class="td_field_thin" height="27" width="14.20%"></td>
    		<td class="td_field_thin" height="27" width="12.20%"></td>
    	</tr>
    	
    	<tr>
    		<td class="td_field_thin" height="27" align="center">
    			需求部门长<br/><span style="font-size:12px">Approved by DM</span></td>
    		<td class="td_field_thin" height="27" ></td>
    		<td class="td_field_thin" height="27" ></td>
    		<td class="td_field_thin" height="27" ></td>
    		<td class="td_field_thin" height="27" ></td>
    		<td class="td_field_thin" height="27" ></td>
    		<td class="td_field_thin" height="27" ></td>
    	</tr>
    	
    </table>
 
    <font size="1"> Approved/审批</font>											
   <%--   <table  width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black"> --%>
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse; " bgColor=white borderColor=black>	
    	<tr> 
    		<td class="td_field_thin" height="27" width="14.28%" align="center">
    			部门经理批准<br /><span style="font-size:12px">Approved by DM</span></td>
    		<td class="td_field_thin" height="27" width="16.28%" align="center">
    			部门总监(部长)批准<br /><span style="font-size:12px">Approved by BU</span></td>
    		<td class="td_field_thin" height="27" width="14.28%" align="center">
    			事业部总经理 <br /><span style="font-size:12px">Approved by BMD</span></td>
    		<td class="td_field_thin" height="27" width="14.28%" align="center">
    			财务审核 <br /><span style="font-size:12px">Audited by FIN</span></td>
    		<td class="td_field_thin" height="27" width="14.28%" align="center">
    			财务总监 <br /><span style="font-size:12px">Approved by FM</span></td>
    		<td class="td_field_thin" height="27" width="14.28%" align="center">
    			总经理 <br /><span style="font-size:12px">Approved by MD</span></td>
    		<td class="td_field_thin" height="27" width="12.28%" align="center">
    			签 收 <br /><span style="font-size:12px">Received by</span></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="27" width="14.28%"></td>
    		<td class="td_field_thin" height="27" width="16.28%"></td>
    		<td class="td_field_thin" height="27" width="14.28%"></td>
    		<td class="td_field_thin" height="27" width="14.28%"></td>
    		<td class="td_field_thin" height="27" width="14.28%"></td>
    		<td class="td_field_thin" height="27" width="14.28%"></td>
    		<td class="td_field_thin" height="27" width="12.28%"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="27" >日期/Date:	</td>
    		<td class="td_field_thin" height="27" >日期/Date:</td>
    		<td class="td_field_thin" height="27" >日期/Date:</td>
    		<td class="td_field_thin" height="27" >日期/Date:</td>
    		<td class="td_field_thin" height="27" >日期/Date:</td>
    		<td class="td_field_thin" height="27" >日期/Date:</td>
    		<td class="td_field_thin" height="27" >日期/Date:</td>
    	</tr>
    	
    </table>
    </div>
    
    <br />
    <div style="position: absolute;top: 1030;z-index:2;left: 28%" >
    	<img alt="" src="<%=path %>/img/image1.jpeg" height="9">
    </div>
    
    </div>
  </body>
</html>
