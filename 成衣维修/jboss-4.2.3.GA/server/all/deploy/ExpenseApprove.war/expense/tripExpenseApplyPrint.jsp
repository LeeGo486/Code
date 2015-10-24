<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.branch.expense.dojo.TripExpenseInfo"%>
<%@page import="ep.org.branch.expense.dojo.TripExpenseDetail"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>差旅费申请单打印</title>
    
	

  
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
   		<%TripExpenseInfo tripExpenseInfo = (TripExpenseInfo)request.getAttribute("tripExpenseInfo");%>
   		
   		
   <div style="position:relative;width: 95%;height: 100%; left: 30 ">
   <div align="center" style="height: 20"><img alt="" src="<%=path %>/img/image2.png"></div>
    
    <div style="position:absolute;top: 50;z-index: 1">
    <div align="center" style="height: 50">
    	
    <font style="font-weight: 600;font-size: 18">Business Trip Expenses Note</font> <br> <font  style="font-weight: 600;font-size: 18">差 旅 费 报 销 单														
     </font>  </div>
    
    <div align="right" style="position: absolute;top: 2;right: 0%">
   	 <img alt="" src="<%=path%>/barcode.bracodeServlet?image=1&type=21&data=<%=tripExpenseInfo.getExpenseNo() %>&height=50" >
  	</div>
    	<br />
    
   
   
     <%-- 	<table width="100%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="black">--%>
    <table width="100%" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black>		
    <tr>
    		<td height="30" class="td_field_thin" colspan="3">Name/出差人姓名	<br />
    			<%=tripExpenseInfo.getTripName() %>		
    		</td>
    		<td class="td_field_thin" colspan="3">Code/职员编码<br />
    			<%=tripExpenseInfo.getEmployeeID() %>				
			
			 </td>
    		<td class="td_field_thin" colspan="3">Dept/部门	<br />
    			<%=tripExpenseInfo.getBranchName() %>								
					
    		</td>
    		
    		<td class="td_field_thin" colspan="3">Cost center/成本中心代码<br />
    			<%=tripExpenseInfo.getCostCenter() %>								
					
    		</td>
    		<td class="td_field_thin" colspan="2">Telephone/电话		<br />
    			<%=tripExpenseInfo.getTelephone()%>						
    		
    		</td>
    	</tr>
    	<tr>
    		<td height="30" class="td_field_thin" colspan="5">Places for trip/出差地点	<br />
    			<%=tripExpenseInfo.getTripAddress() %>											
    		</td>
    		
    		<td class="td_field_thin" colspan="5">Purposes for trip/出差事由	<br />
    			<%=tripExpenseInfo.getTripPurposes() %>											
    		</td>
    		<td class="td_field_thin" colspan="3">Accompanied by/随同人员<br />
    			<%=tripExpenseInfo.getTripMenber()%>							
 			</td>
    		<td class="td_field_thin">Date/日期<br />
    			<%=tripExpenseInfo.getApplyDate() %>	
    		</td>
    	</tr>
    	
    	
    	<tr>
    		<td  colspan="14" class="td_field_thin" height="30">Charged to/and Reasons其他付款说明：<br />
    		<%=tripExpenseInfo.getPayComment() %>		
    		</td>
    		
    	</tr>
    	<tr>
    		<td align="center" colspan="3"  class="td_field_thin">DEPARTURE<br />出      发		
    		</td>
    		<td align="center" colspan="3"  class="td_field_thin">ARRIVAL<br />到    达		
    		</td>
    		<td align="center" colspan="2"  class="td_field_thin">MILEAGE  <br />    里 程	
    		</td>
    		<td align="center" colspan="6"  class="td_field_thin">TRANSPORTATION&HOTEL&ALLOWANCES <br /> 交通和住宿费和补贴费
    		</td>
    		
    	</tr>
    	<tr>
    		<td align="center" class="td_field_thin" width="7.6%">From<br/> 起点</td>
   			<td align="center" class="td_field_thin" width="5.6%">M<br/>月</td>
   			<td align="center" class="td_field_thin" width="5.6%">D<br/>日</td>
   			<td align="center" class="td_field_thin" width="7.6%">To<br/>终点</td>
   			<td align="center" class="td_field_thin" width="5.6%">M<br/>月</td>
   			<td align="center" class="td_field_thin" width="5.6%">D<br/>日</td>
   			<td align="center" class="td_field_thin" width="8.6%">Km<br/>公里</td>
   			<td align="center" class="td_field_thin" width="8.6%">Gasoline<br/>汽油费</td>
   			<td align="center" class="td_field_thin" width="7.6%">rain<br/>火车票</td>
   			<td align="center" class="td_field_thin" width="7.6%">Taxi<br/>出租车</td>
   			<td align="center" class="td_field_thin" width="8.6%">Airplane<br/>飞机票</td>
   			<td align="center" class="td_field_thin" width="8.6%">Others<br/>其他交通</td>
   			<td align="center" class="td_field_thin" width="8.6%">Hotel<br/>住宿费（    定额）
   			</td>
   			<td align="center" class="td_field_thin" >Meal&Allowance<br/>餐费和补贴（   定额）</td>
    	</tr>
		<%List  detailList =(List)request.getAttribute("detailList"); 
		   for(int i=0;i<detailList.size();i++){
    			   	 TripExpenseDetail detail = (TripExpenseDetail) detailList.get(i);
					 String bgnDate = detail.getFromDate();
					 String endDate = detail.getToDate();
		 			 
		 			 String bgnMonth = "";
		 			 String bgnDay = "";
		 			 String endMonth = "";
		 			 String endDay = "";
		 			 String[] bgn = new String[1];
		 			 String[] end = new String[1];
		 			 
		 			 if(bgnDate!=null){
		 			 	bgn = bgnDate.split("-");
		 			  }
		 			 if(endDate!=null){
		 			 	end = endDate.split("-");
		 			  } 
		 			  if(bgn.length>=2){
		 			  	bgnMonth = bgn[1];
		 			  }
		 			  if(bgn.length==3){
		 			  	bgnDay =bgn[2];
		 			  }
		 			  if(end.length>=2){
		 			  	endMonth = bgn[1];
		 			  }
		 			  if(end.length==3){
		 			  	endDay =bgn[2];
		 			  } 
		 
		 %>    
   		<tr>
   			<td align="center" class="td_field_thin" height="25"><%=detail.getFromAdress() %> </td>
   			<td align="center" class="td_field_thin" height="25"><%=bgnMonth %></td>
   			<td align="center" class="td_field_thin" height="25"><%=bgnDay  %></td>
   			<td align="center" class="td_field_thin" height="25"><%= detail.getToAdress()%> </td>
   			<td align="center" class="td_field_thin" height="25"><%=endMonth %></td>
   			<td align="center" class="td_field_thin" height="25"><%=endDay %></td>
   			<td align="right" class="td_field_thin" height="25"><%=detail.getKM()==null?"": detail.getKM()%></td>
   			<td align="right" class="td_field_thin" height="25"><%=detail.getGasolineCost()==null?"": detail.getGasolineCost()%> </td>
   			<td align="right" class="td_field_thin" height="25"><%=detail.getTrainCost()==null?"": detail.getTrainCost() %> </td>
   			<td align="right" class="td_field_thin" height="25"><%=detail.getTaxiCost()==null?"": detail.getTaxiCost() %> </td>
   			<td align="right" class="td_field_thin" height="25"><%=detail.getAirplaneCost()==null?"": detail.getAirplaneCost() %></td>
   			<td align="right" class="td_field_thin" height="25"><%=detail.getOthers()==null?"": detail.getOthers() %></td>
   			<td align="right" class="td_field_thin" height="25"><%=detail.getHotelCost()==null?"": detail.getHotelCost() %></td>
   			<td align="right" class="td_field_thin" height="25"><%=detail.getMeal_allowance_cost()==null?"": detail.getMeal_allowance_cost() %> </td>
   		</tr>
		

    	
    	<%} %>
    	<tr>
    		<td class="td_field_thin" colspan="3" height="35">Attachments<br/> 附件： <%=tripExpenseInfo.getAttachments() %>  P/张</td>
    		
    		<td class="td_field_thin"  colspan="4" >Subtotal/费用小计</td>
    		<td class="td_field_thin"><%=request.getAttribute("gasolineCost") %></td>
    		<td class="td_field_thin"><%=request.getAttribute("trainCost") %></td>
    		<td class="td_field_thin"><%=request.getAttribute("taxiCost") %></td>
    		<td class="td_field_thin"><%=request.getAttribute("airplaneCost") %></td>
    		<td class="td_field_thin"><%=request.getAttribute("others") %></td>
    		<td class="td_field_thin"><%=request.getAttribute("hotelCost") %></td>
    		<td class="td_field_thin"><%=request.getAttribute("meal_allowance_cost") %></td>
    		
    	</tr>
    	
    	<tr>
    		<td height="35" class="td_field_thin" align="center" colspan="2">Total<br/> 费用总计	
				
			</td>
    		
    		
    		
    		<td class="td_field_thin"  colspan="4">In Figure/小写:
    					<%=tripExpenseInfo.getTotalMoney() %>
    		</td>
    		<td class="td_field_thin" colspan="8"> In Captial/大写：								
    			<%=request.getAttribute("totalMoneyCN") %>
    		</td>
    		
    		
    	</tr>
    	
    	<tr>
    		<td  height="30" class="td_field_thin" colspan="7">The temporary Cash Advance remainder/临时借款余额
    		</td>
    		<td  height="30" class="td_field_thin" colspan="2">		</td>
    		
    		<td height="30"  class="td_field_thin" colspan="5" rowspan="3" align="center">The actual payment 实际支付金额：<font style="text-decoration: underline; "> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; </font>                     元（出纳填写<br/> Filled by Cashier ）						
			</td>
    	</tr>
    	
    	
    	<tr>
    		<td height="30" class="td_field_thin" colspan="9" align="left">Offset Cash Advance 抵冲借款：    <br />     						
				 &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
				&nbsp;&nbsp;<input type="checkbox">  Yes是 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;      <input type="checkbox">No否						
				
    		</td>
    		
    		
    	</tr>
    	
    	<tr>
    		<td height="30" class="td_field_thin" colspan="7">The amount to offset Cash Advance/抵冲借款金额

    		</td>
    		<td  height="30" class="td_field_thin" colspan="2">		</td>
    		
    	</tr>
    </table>
   
  
    <table width="100%" height="3" cellPadding=0 cellSpacing=0  frame=box style="BORDER-COLLAPSE: collapse;" bgColor=white borderColor=black >
    	<tr >
    		<td height="1">
    		</td>
    	</tr>
    	
    </table>	
    
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
    		<td class="td_field_thin" colspan="8" height="30">
    		<b>	Instruction: </b> <br />                                                                        
1.The expenses claim must be supported by original inoices. 费用报销必须附有原始发票。    <br /> 
 2.The daily allowances shall be claim based on the departure and arrival time and the participation in the dinner or luncheon. <br /> 
每日补贴必须依据出差时间和是否参加宴请申领。 <br /> 
3.Other expenses claim shall be referred to the guidelines and principles covered in Company's related regulation. <br /> 
其他报销标准和原则请参阅公司相关规定。														
														
														
										
    			
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
