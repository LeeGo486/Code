<%@page import="ep.org.util.NumberUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.UserInfo"%>
<%@page import="ep.org.branch.expense.constant.ExpenseConstant"%>
<%@page import="ep.org.branch.expense.dojo.SelectOptionObj"%>
<%@page import="ep.org.branch.expense.dojo.PaymentInfo"%>
<%@page import="ep.org.branch.expense.dojo.PaymentPurposeCost"%>
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
    
    <title>付款申请</title>
    
	

  
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
		 <input type="hidden" id="webContext" value="<%=request.getContextPath() %>">
		<object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441"  viewasext> </object>
   		<%PaymentInfo paymentInfo = (PaymentInfo)request.getAttribute("expenseInfo");%>
   		
   		
   <div style="position:relative;width: 95%;height: 100%; left: 30 ">
   <div align="center" style="height: 20"><img alt="" src="<%=path %>/img/image2.png"></div>
    
    <div style="position:absolute;top: 50;z-index: 1">
    <div align="center" style="height: 50">
    	
    <font style="font-weight: 600;font-size: 18">Payment Application Form</font> <br> <font  style="font-weight: 600;font-size: 18">付款申请表 </font>  </div>
    
    <div align="right" style="position: absolute;top: 2;right: 0%">
   	 <img alt="" src="<%=path%>/barcode.bracodeServlet?image=1&type=21&data=<%=paymentInfo.getExpenseNo() %>&height=50" >
  	</div>
    	<br />
    
   
   
     <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black>		
    	
    	
    	<tr>
    		<td height="40" class="td_field_thin" width="25%" align="center">  Requested By/申请人<br />
    			<%=paymentInfo.getEmployeeName() %>		
    		</td>
    		<td class="td_field_thin" width="25%" align="center">Department/部门全称<br />
    			<%=paymentInfo.getBranchName() %>				
			
			 </td>
    		<td class="td_field_thin" width="25%" align="center">Cost Center.No/部门成本中心代码<br />
    			<%=paymentInfo.getBranchCostCenter() %>								
					
    		</td>
    		<td class="td_field_thin" width="25%" align="center">Date/日期	<br />
    			<%=paymentInfo.getApplyDate() %>					
    		
    		</td>
    	</tr>
    	
    	<tr>
    		<td height="40"  class="td_field_thin" colspan="2">Pay to/收款人全称：<br />
    			<%=paymentInfo.getBankAccoutName() %>								
			
    		</td>
    		<td class="td_field_thin" colspan="2">City/Probince/省/市：<br />
    			<%=paymentInfo.getProvince_city() %>										
    		</td>
    	</tr>
    	
    	<tr>
    		<td height="40"  class="td_field_thin" colspan="2">Bank Account/开户银行：<br />
    			<%=paymentInfo.getBankName() %>								
			
    		</td>
    		<td class="td_field_thin" colspan="2">Bank Code/银行帐号：<br />
    			<%=paymentInfo.getBankAccout() %>										
    		</td>
    	</tr>
    	<tr>
    		<td height="40"  colspan="2" class="td_field_thin" >  Bank Instruction/其它要求说明：<br />
    		<%=paymentInfo.getRemark() %>		
    		</td>
    		
    		<td colspan="2" class="td_field_thin" >Vendor No./供应商号:<br />
    		<%=paymentInfo.getVendorNo() %>		
    		</td>
    		
    	</tr>
    
    </table>
    
   	<font style="font-size: 11;font-weight: 500;">	Payment Type/付款方式</font>
     
     <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE:collapse; " bgColor=white borderColor=black>		
    	<tr valign="top">
    		
    		<td align="center" class="td_field_thin" width="14.28%"><input type="checkbox">电汇/<br/> TT</td>  
    		<td align="center" class="td_field_thin" width="14.28%"><input type="checkbox">汇票 /<br/>Draft</td>
    		<td align="center" class="td_field_thin" width="14.28%"><input type="checkbox">承兑汇票/<br/>Acceptance<br/> Bill	</td>
    		<td align="center" class="td_field_thin" width="14.28%"><input type="checkbox">转帐支票/<br/>Transfer<br/>Cheque	</td>
    		<td align="center" class="td_field_thin" width="14.28%"><input type="checkbox">现金/<br/>    Cash</td>
    		<td align="center" class="td_field_thin" width="14.28%"><input type="checkbox">信用证/<br/>    Letter of <br/>     Credit	</td>
    		<td align="left" class="td_field_thin" width="14.28%" >货币Cureency<br/>
    		<input type="checkbox"> 人民币 <br/><input type="checkbox">美元<input type="checkbox">	欧元</td>
    		
    	</tr>
    	<tr height="25">
    		<td colspan="3" align="center" class="td_field_thin">Description/付款明细说明</td>
    		<td align="center" class="td_field_thin">Invoice Code<br/>发票号		
    		</td>
    		<td align="center" class="td_field_thin">Cost Center<br/>成本中心	
    		</td>
    		<td align="center" class="td_field_thin">Acctode<br/>会计科目</td>
    		<td align="center" class="td_field_thin">Amount<br/>金额</td>
    		
    	</tr>
    	
    	
    	<% PaymentPurposeCost paymentPurposeCost = null;
    	   List purposeCostList = (List)request.getAttribute("purposeCostList"); 
    	   int listSize = purposeCostList.size();
    	   for(int i=0;i<listSize;i++){
    	  	 paymentPurposeCost = (PaymentPurposeCost)purposeCostList.get(i);
    		 
    	%>
    	<tr height="20">
    		<td class="td_field_thin" colspan="3" ><%=paymentPurposeCost.getExpensePurpose()%> </td>
    		<td class="td_field_thin"><%=paymentPurposeCost.getInvoiceCode()%></td>
    		<td class="td_field_thin"><%=paymentPurposeCost.getCostCenterCode()%><%=paymentPurposeCost.getCostCenterName()%></td>
    		<td class="td_field_thin"></td>
    		<td class="td_field_thin" align="right"><%=NumberUtil.formatFloatDecimal(2,(String)(paymentPurposeCost.getExpenseAmout().equals("")?"":paymentPurposeCost.getExpenseAmout().substring(0,paymentPurposeCost.getExpenseAmout().length()-2)))%></td>
    		
    	</tr>
    	<% }
    	
    	 
    	%>
    	
    	
    	
    	<tr  height="25">
    		<td class="td_field_thin" colspan="3">  Supporting Documents/附件_____张 </td>
    		<td class="td_field_thin" colspan="2">       Total/合计金额：</td>
    		<td class="td_field_thin" colspan="2"> <%=paymentInfo.getTotalMoney() %>  </td>
    	</tr>	
    
    
    	<tr  height="25">
    		
    		<td class="td_field_thin"  colspan="2">TOTAL In Words/大写总金额：</td>
    		<td class="td_field_thin"  colspan="5"><%=request.getAttribute("totalMoneyCN") %> </td>
    	
    		
    		
    	</tr>
    	
    	<tr  height="30">
    		<td colspan="2" class="td_field_thin">  P.O./Contract No.定单号/合同号：<br />
    		</td>
    		<td colspan="3" class="td_field_thin">  GRN # / 收货单：<br />						
    		</td>
    		<td colspan="2" class="td_field_thin">  Others/其它：<br />			
    		</td>
    		
    	</tr>
    	
    		<tr height="30">
    		<td colspan="3" class="td_field_thin">    Urgent Payment/紧急付款：<br />
    		</td>
    		<td colspan="4" class="td_field_thin">   Reason/理由：<br />						
    		</td>
    		
    		
    	</tr>
    	
    	<tr>
    		<td  colspan="7" class="td_field_thin">
    			  <table border="0" width="100%">
    			  	<tr>
    			  		<td align="left" class="td_field_thin" colspan="2">
    			  			Payment type/付款类型：
    			  		</td>
    			  		
    			  		<td >
    			  		</td>
    			  		<td align="left" class="td_field_thin">
    			  			<input type="checkbox">  Equipment Payment/设备款
    			  		</td>
    			  	</tr>
    			  	<tr>
    			  		<td width="15%"></td>
    			  		<td width="35%" align="left"  class="td_field_thin"><input type="checkbox"> Material Payment/材料费</td>
    			  		<td width="10%"></td>
    			  		<td width="40%" align="left" class="td_field_thin"><input type="checkbox"> PrePayment/预付款</td>
    			  	</tr>
    			  	<tr>
    			  		<td ></td>
    			  		<td align="left" class="td_field_thin"><input type="checkbox"> Project Payment/工程费  </td>
    			  		<td></td>
    			  		<td align="left" class="td_field_thin"><input type="checkbox"> Other Payment/其他付款</td>
    			  	</tr>
    			  	
    			  </table>
    			
    		</td>
    	</tr>
    	
    <%-- 
    	</table>
    	
    	
    	<br />								
     
   
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black>		
    --%>
    	<tr>
    		<td class="td_field_thin" height="30" width="14.28%" align="center"> 复核     <br />  Checked by	</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">分公司财务审核 <br />    Approved by FIN </td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">部门经理(总监)批准<br />  Approved by DM	</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center"> 财务经理      <br /> Approved by FM		</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">品牌总经理      <br />Approved by BMD</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">总经理       <br />    Approved by MD</td>
    		<td class="td_field_thin" height="30" width="14.28%" align="center">签 收                 <br />     Received by</td>
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
    				Instruction:  <br/>1.The applicants take charge of the application's conte													
    																	
														
    			
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
