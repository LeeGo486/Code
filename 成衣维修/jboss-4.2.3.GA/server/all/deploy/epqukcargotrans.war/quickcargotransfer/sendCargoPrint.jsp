<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.quickcargotransfer.javabean.SendCargoInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
SendCargoInfo sendCargoInfo = (SendCargoInfo)request.getAttribute("sendCargoInfo");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>调货单打印</title>
    

  </head>
  <script type="text/javascript">
  function autoPrint(){
  	try{
			if (document.all.eprint.defaultPrinterName.length==0){
			alert("请先安装打印机，再刷新本页面进行打印！");
			return;
	}

  		eprint.InitPrint();
  		eprint.header = "";
  		eprint.footer = "";
  		eprint.Preview();
  		window.close();
	//document.all.eprint.Print(true);//不弹出打印对话框直接打印
	}catch(e){
		var url=document.getElementById("webContext").value+'/quickcargotransfer/webprintDownload.jsp';
		window.open(url,'webprint打印控件下载','scrollbars=yes,width=400px,height=200px,resizable=yes,menubar=no,status=no,location=no');
	
	}
  }
  
  </script>
  <body onload="autoPrint()">
     <object id="eprint" classid="clsid:CA03A5A8-9890-49BE-BA4A-8C524EB06441"  viewasext> </object>
          
     <br />
     <br />  
      <br />  
      <br />     
             客订单快速调货<br />
     <div align="center"><font size="4"><b> 浙江雅莹服装有限公司发货单</b></font></div>
   	<table width="100%" border="0">
   		<tr>
   			<td  valign="top" width="11%"></td>
   			<td valign="top" width="20%"></td>
   			<td valign="top" width="11%"></td>
   			<td valign="top" width="27%"></td>
   			<td  align="right" valign="top" width="11%">制表日期：</td>
   			<td valign="top" width="20%"><%=sendCargoInfo.getPrintDate()%></td>
   		</tr>
   		
   		<tr>
   			<td  align="right" valign="top">发货单号：</td>
   			<td valign="top"><%=sendCargoInfo.getFhdh()%> </td>
   			<td  align="right" valign="top">发货仓店：</td>
   			<td valign="top">[<%=sendCargoInfo.getSendDepotID() %>]<%=sendCargoInfo.getSendDepotName() %> </td>
   			<td align="right" valign="top">总数：</td>
   			<td valign="top"><%=sendCargoInfo.getSendNum() %> </td>
   		</tr>
   		
   		<tr>
   			<td  align="right" valign="top">发货日期：</td>
   			<td valign="top"><%=sendCargoInfo.getSendDate() %> </td>
   			<td  align="right" valign="top">收货仓店：</td>
   			<td valign="top">[<%=sendCargoInfo.getReceiveDepotID() %>]<%=sendCargoInfo.getReceiveDepotName() %></td>
   			<td align="right" valign="top">总额：</td>
   			<td valign="top"><%=sendCargoInfo.getCargoPrice()%></td>
   		</tr>
   		
   		<tr>
   			<td  align="right" valign="top">店铺地址：</td>
   			<td valign="top"><%=sendCargoInfo.getReceiveAddress()%></td>
   			<td align="right" valign="top">店长：</td>
   			<td valign="top"><%=sendCargoInfo.getReceiveDZ() %></td>
   			<td align="right" valign="top">电话：</td>
   			<td valign="top"><%=sendCargoInfo.getReceiveDH() %></td>
   		</tr>
   		
   		
   	</table>  
  
  	<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#000000">
  		<tr>
  			<td bgcolor="#FFFFFF" width="10%">款式</td>
  			<td bgcolor="#FFFFFF" width="10%">款式名称</td>
  			<td bgcolor="#FFFFFF" width="10%">包装方式</td>
  			<td bgcolor="#FFFFFF" width="10%">颜色</td>
  			<td bgcolor="#FFFFFF" width="30%" colspan="8">F</td>
  			<td bgcolor="#FFFFFF" width="10%">数量</td>
  			<td bgcolor="#FFFFFF" width="10%">结算价</td>
  			<td bgcolor="#FFFFFF" width="10%">金额</td>
  		</tr>
  		
  		<tr>
  			<td bgcolor="#FFFFFF" width="10%"><%=sendCargoInfo.getStytleKH()%></td>
  			<td bgcolor="#FFFFFF" width="10%"><%=sendCargoInfo.getStytleMC()%></td>
  			<td bgcolor="#FFFFFF" width="10%"></td>
  			<td bgcolor="#FFFFFF" width="10%"><%=sendCargoInfo.getColor()%></td>
  			<td bgcolor="#FFFFFF" width="4%"><%=sendCargoInfo.getSize()%></td>
  			<td bgcolor="#FFFFFF" width="4%"></td>
  			<td bgcolor="#FFFFFF" width="4%"></td>
  			<td bgcolor="#FFFFFF" width="4%"></td>
  			<td bgcolor="#FFFFFF" width="4%"></td>
  			<td bgcolor="#FFFFFF" width="4%"></td>
  			<td bgcolor="#FFFFFF" width="4%"></td>
  			<td bgcolor="#FFFFFF" width="4%"></td>
  			<td bgcolor="#FFFFFF"  width="10%"><%=sendCargoInfo.getSendNum() %></td>
  			<td bgcolor="#FFFFFF"  width="10%"><%=sendCargoInfo.getJsj()%></td>
  			<td bgcolor="#FFFFFF"  width="10%"><%=sendCargoInfo.getCargoPrice()%></td>
  		
  		</tr>
  	
  	</table>
  
  	
  	 <br />
     <br />  
      <br />  
      <br />     
       <br />
     <br />  
      <br />  
      <br />     
       <br />
     <br />  
      <br />  
      <br />     
  	 <br />
     <br />  
      <br />  
      <br />     
  	
  	<table width="100%">
  		<tr>
  			<td>合计金额：</td>
  			<td><%=sendCargoInfo.getCargoPrice()%></td>
  			<td><%=sendCargoInfo.getChinaRMB() %> </td>
  			<td>本页小计数量：</td>
  			<td><%=sendCargoInfo.getSendNum() %> </td>
  		</tr>
  		
  	</table>
  	<hr width="100%" color="#000000" size="1"/>
  	<table width="100%">
  		<tr>
  			<td>审 核 人：</td>
  			<td></td>
  			<td>登 帐 人：</td>
  			<td></td>
  			<td>制 单 人：</td>
  			<td><%=sendCargoInfo.getTxr() %></td>
  			<td>交 货 人：</td>
  			<td></td>
  			<td>收 货 人：</td>
  			<td></td>
  		</tr>
  		<tr>
  			<td>审核日期：</td>
  			<td></td>
  			<td>登帐日期：</td>
  			<td></td>
  			<td>制单日期：</td>
  			<td><%=sendCargoInfo.getTxrq() %></td>
  			<td>交货日期：</td>
  			<td></td>
  			<td>收货日期：</td>
  			<td></td>
  		</tr>
  	</table>
 
  </body>
</html>
