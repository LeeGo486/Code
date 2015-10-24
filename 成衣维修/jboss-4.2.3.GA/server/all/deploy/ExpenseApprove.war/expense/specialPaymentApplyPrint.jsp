<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@page import="ep.org.branch.expense.constant.ExpenseConstant"%>
<%@page import="ep.org.branch.expense.dojo.SelectOptionObj"%>
<%@page import="ep.org.branch.expense.dojo.SpecialPaymentPurposeCost"%>
<%@page import="ep.org.branch.expense.dojo.SpecialPaymentSubjectCost"%>
<%@page import="ep.org.branch.expense.dojo.SpecialPaymentInfo"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>特殊付款申请</title>
    
	

  
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
   		<%SpecialPaymentInfo specialPaymentInfo = (SpecialPaymentInfo)request.getAttribute("expenseInfo");%>
   		
   		
   <div style="position:relative;width: 95%;height: 100%; left: 30 ">
   <div align="center" style="height: 20"><img alt="" src="<%=path %>/img/image2.png"></div>
    
    <div style="position:absolute;top: 50;z-index: 1">
    <div align="center" style="height: 50">
    	
    <font style="font-weight: 600;font-size: 18">Special Payment Application</font> <br> <font  style="font-weight: 600;font-size: 18">特殊付款申请 </font>  </div>
    
    <div align="right" style="position: absolute;top: 2;right: 0%">
   	 <img alt="" src="<%=path%>/barcode.bracodeServlet?image=1&type=21&data=<%=specialPaymentInfo.getExpenseNo() %>&height=50" >
  	</div>
    	<br />
    
   
   
     <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black>		
    	<tr>
    		<td  class="td_field_thin" colspan="8">
    			Payment Type/付款方式： <input type="checkbox" value="" > Cash/现金
    			<input type="checkbox" value="" />    T/T 电汇
    			<input type="checkbox" value=""/> Draft 汇票
    			<input type="checkbox" value ="" />	Cheque 转帐支票												
    			
    		</td>
    	</tr>
    	
    	
    	<tr>
    		<td height="35" class="td_field_thin" width="25%">Name/申请人：<br />
    			<%=specialPaymentInfo.getEmployeeName() %>		
    		</td>
    		<td class="td_field_thin" width="25%">Department/部门全称<br />
    			<%=specialPaymentInfo.getBranchName() %>				
			
			 </td>
    		<td class="td_field_thin" width="25%">Cost Center.No/部门成本中心代码<br />
    			<%=specialPaymentInfo.getBranchCostCenter() %>								
					
    		</td>
    		<td class="td_field_thin" width="25%">Employee Code/职员编码	<br />
    			<%=specialPaymentInfo.getEmployeeID() %>						
    		
    		</td>
    	</tr>
    	<tr>
    		<td height="35"  class="td_field_thin">Telephone/电话号码	<br />
    			<%=specialPaymentInfo.getTelephone() %>											
    		</td>
    		<td class="td_field_thin" colspan="2">Mobile phone/移动电话<br />
    			<%=specialPaymentInfo.getTelephone() %>							
 			</td>
    		<td class="td_field_thin">Date/日期<br />
    			<%=specialPaymentInfo.getApplyDate() %>	
    		</td>
    	</tr>
    	
    	<tr>
    		<td height="35"  class="td_field_thin" colspan="2">Pay to/收款人全称：<br />
    			<%=specialPaymentInfo.getBankAccoutName() %>								
			
    		</td>
    		<td class="td_field_thin" colspan="2">City/Probince/省/市：<br />
    			<%=specialPaymentInfo.getProvince_city() %>										
    		</td>
    	</tr>
    	
    	<tr>
    		<td height="35"  class="td_field_thin" colspan="2">Bank Account/开户银行：<br />
    			<%=specialPaymentInfo.getBankName() %>								
			
    		</td>
    		<td class="td_field_thin" colspan="2">Bank Code/银行帐号：<br />
    			<%=specialPaymentInfo.getBankAccout() %>										
    		</td>
    	</tr>
    	<tr>
    		<td height="35"  colspan="4" class="td_field_thin" >Charged to/and Reasons其他付款说明：<br />
    		<%=specialPaymentInfo.getRemark() %>		
    		</td>
    		
    	</tr>
    
    </table>
    
   
      <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
     <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE:collapse; " bgColor=white borderColor=black>		
    	<tr>
    		<td align="center" class="td_field_thin" width="4%" height="30">No<br />序号</td>    
    		<td align="center" class="td_field_thin" width="10%">Date<br/>日期</td>  
    		<td align="center" class="td_field_thin" width="25%">Justification Detailed<br />费用明细</td>
    		<td align="center" class="td_field_thin" width="12%">AMT<br/> 金额 </td>
    		<td align="center" class="td_field_thin" colspan="3" align="center">Type ticked by Applicant(filled by FIN)<br/>票据分类（财务部填）	</td>
    		
    		<td align="center" class="td_field_thin" width="10%">AMT<br/> 金额</td>
    	</tr>
    	<% SpecialPaymentPurposeCost specialPaymentPurposeCost = null;
    	   List purposeCostList = (List)request.getAttribute("SPPurposeCostList"); 
    	   specialPaymentPurposeCost = (SpecialPaymentPurposeCost)purposeCostList.get(0);
    	%>
    	<tr>
    		<td class="td_field_thin" rowspan="2" >1</td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" rowspan="13" width="1%"></td>
    		<td class="td_field_thin" height="18">Shop transfer fee	</td>
    		<td class="td_field_thin" >店铺转让费</td>
    		<td class="td_field_thin" ></td>
    	</tr>
    	<tr>
    	
    		<td class="td_field_thin" height="18">Shop entrance fee	</td>
    		<td class="td_field_thin">店铺进场费</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% specialPaymentPurposeCost = (SpecialPaymentPurposeCost)purposeCostList.get(1); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">2</td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="18">Dept store connection fee	</td>
    		<td class="td_field_thin">百货公司关系费</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="18">Business entertainment</td>
    		<td class="td_field_thin">业务招待费用</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% specialPaymentPurposeCost = (SpecialPaymentPurposeCost)purposeCostList.get(2); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">3</td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseDate() %> </td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="18">Franchising premium	</td>
    		<td class="td_field_thin">加盟商奖励</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="18">Deposit	</td>
    		<td class="td_field_thin">保证金/押金</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% specialPaymentPurposeCost = (SpecialPaymentPurposeCost)purposeCostList.get(3); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">4</td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="18">Shops rental 	</td>
    		<td class="td_field_thin">店铺租金</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="18">Refundment </td>
    		<td class="td_field_thin">加盟商退款</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<%  specialPaymentPurposeCost = (SpecialPaymentPurposeCost)purposeCostList.get(4); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">5</td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="18"></td>
    		<td class="td_field_thin"></td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="18"></td>
    		<td class="td_field_thin"></td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    	<% specialPaymentPurposeCost = (SpecialPaymentPurposeCost)purposeCostList.get(5); %>
    	<tr>
    		<td class="td_field_thin" rowspan="2">6</td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseDate() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpensePurpose() %></td>
    		<td class="td_field_thin" rowspan="2"><%=specialPaymentPurposeCost.getExpenseAmout()%></td>
    		<td class="td_field_thin" height="18"> </td>
    		<td class="td_field_thin">	</td>
    		<td class="td_field_thin"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="18"></td>
    		<td class="td_field_thin"></td>
    		<td class="td_field_thin"></td>
    	</tr>
    	
    
    	<tr>
    		<td height="30" class="td_field_thin" ></td>
    		<td class="td_field_thin" ></td>
    		
    		<td class="td_field_thin"  colspan="1" >Total/合计：</td>
    		<td class="td_field_thin"><%=specialPaymentInfo.getTotalMoney() %></td>
    		<td class="td_field_thin" align="center">Total </td>
    		<td class="td_field_thin" align="center">合计	</td>
    		<td class="td_field_thin"></td>
    		
    		
    	</tr>
    	
    	<tr>
    		<td class="td_field_thin" colspan="9" height="30">TOTAL In Words/大写总金额：		
    			<%=request.getAttribute("totalMoneyCN") %>
    		</td>
    	</tr>
    	
    	</table>
    	 <br />
      <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black>		
    	
    	
    	<tr>
    		<td  height="20" class="td_field_thin" width="39%">The temporary Cash Advance remainder/临时借款余额
    		</td>
    		<td height="20" class="td_field_thin" width="12%"></td>
    		
    		<td height="20"  class="td_field_thin"  rowspan="3" align="center" width="49%">The actual payment 实际支付金额：<font style="text-decoration: underline; "> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; </font>                     元（出纳填写<br/> Filled by Cashier ）						
			</td>
    	</tr>
    	
    	
    	<tr>
    		<td height="20" class="td_field_thin" colspan="2" align="left">Offset Cash Advance 抵冲借款    <br />     						
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="checkbox">  Yes是&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;      <input type="checkbox">No否						
				
    		</td>
    		
    		
    	</tr>
    	
    	<tr>
    		<td height="20" class="td_field_thin" colspan="2">The amount to offset Cash Advance/抵冲借款金额

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
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="30" >日期/Date:	</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    	</tr>
    	
    	<tr>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    		<td class="td_field_thin" height="30" width="14.28%"></td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="30" >日期/Date:	</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    		<td class="td_field_thin" height="30" >日期/Date:</td>
    	</tr>
    	<tr>
    		<td class="td_field_thin" height="30" colspan="8">
    			注：若是业务招待费，请注明受款待人员姓名、单位名称、职衔以及参与款待之员工和出席总人数。														
														
    			
    		</td>
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
