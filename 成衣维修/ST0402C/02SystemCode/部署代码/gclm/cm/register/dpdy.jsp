<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.hy.model.*" %>
<%@ page language="java" import="java.sql.Timestamp" %>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>店铺维修单打印</title>
  </head>
  
  <body>
  <!-- 店铺维修单打印 -->
	        <div id="print" style="display: none">
	        <table style="font-size: 10pt">
	        <tr><td rowspan="3"><img alt="" src="<%=path %>/img/logo.jpg" ></td><td width="390px" rowspan="3" align="center" style="font-size: 16pt">店铺维修单</td><td>  &nbsp; </td><td> &nbsp;  </td></tr>
	        <tr>		<td>    </td></tr>
	        <tr>		<td>维修单号:</td><td id="wxdh1" ></td></tr>
	        </table>
	        <table id="printdpwxdp" width="760px" border="1" rules="all" 
	        style= "  
	        font-family: verdana,arial,sans-serif;
		    font-size:10pt;
		    color:#000000;
		    border-width: 1px;
		    border-color: #666666; 
		    border-collapse: collapse;
		    width: 100%; ">
	        <tr ><td colspan="8">
	         <div id="pp"></div>
	        </td></tr>
	        <tr><td rowspan="4" style="background:#9FB6CD">店铺信息</td><td  style="background:#9FB6CD">店铺名称</td><td id="pdpmc"></td><td rowspan="4" style="background:#9FB6CD">顾客信息</td><td><div id="gkwxp"></div></td><td>顾客维修</td><td><div id="dpwxp"></div></td><td>店铺维修</td> </tr>
	        <tr>						  <td style="background:#9FB6CD">店长姓名</td><td id="pdzxm"></td> 						<td style="background:#9FB6CD">顾客姓名</td><td></td><td  style="background:#9FB6CD">顾客电话</td><td></td>  </tr>
	        <tr>						  <td style="background:#9FB6CD">维修仓编码</td><td id="pwxcbm"></td> 						<td style="background:#9FB6CD">VIP卡号</td><td colspan="3"></td>  </tr>
	        <tr>						  <td style="background:#9FB6CD">受理导购</td><td id="psldg"></td> 						<td style="background:#9FB6CD">付费维修</td><td><div id="s"></div></td> <td colspan="2"><div id="f"></div></td>  </tr>
	        </table>
	        <br/> 
	        <table width="650px" border="1" rules="all" 
	        style= "  
	        font-family: verdana,arial,sans-serif;
		    font-size:10pt;
		    color:#000000;
		    border-width: 1px;
		    border-color: #666666; 
		    border-collapse: collapse;
		    width: 100%; ">
	        <tr style="background:#9FB6CD">	<td  style="background:#9FB6CD" width="100px">款号</td><td style="background:#9FB6CD" width="80px">颜色</td><td width="80px">码数</td><td width="80px">售出时间</td><td width="400px">问题描述</td>   </tr>
	        <tr>	<td id="khp"></td><td id="ysp"></td><td id="msp"></td><td id="scsjp"></td><td id="wtmsp"></td></tr>
	        <tr>	<td rowspan="2" style="background:#9FB6CD" width="100px">物流信息</td><td style="background:#9FB6CD"  width="80px">物流公司</td><td id="wlgsp" ></td><td style="background:#9FB6CD" >物流单号</td><td id="wldhp"></td></tr>
	        <tr>						<td style="background:#9FB6CD">店铺地址</td><td id="dpdzp" colspan="3"></td></tr>
	        </table>
	        <table >
	        <tr><td><b style="color: red">备注：请将此单与衣物一起寄出</b></td><td width="200px"></td><td></td><td></td></tr>
	        <tr style="font-size: 10pt"><td></td><td></td><td>店长签字：</td><td></td></tr>
	        <tr style="font-size: 10pt"><td></td><td></td><td>退回日期：</td><td id="thrqp"></td></tr>
	        </table>
	        </div>
	 
	 
  </body>
</html>
