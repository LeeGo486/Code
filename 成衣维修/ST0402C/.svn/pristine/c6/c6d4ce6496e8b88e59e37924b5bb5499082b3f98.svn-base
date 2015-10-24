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
    
    <title>总部发货打印</title>
  </head>
  
  <body>
	 <!-- 总部维修单打印 -->
	        <div id="zbprint" style="display: none">
	        <table style="font-size: 10pt">
	        <tr><td rowspan="3"><img alt="" src="<%=path %>/img/logo.jpg" ></td><td width="390px" rowspan="3" align="center" style="font-size: 16pt">产品售后发货单</td><td>  &nbsp; </td><td> &nbsp;  </td></tr>
	        <tr>		<td>    </td></tr>
	        <tr>		<td>维修单号:</td><td id="wxdh2" ></td></tr>
	        </table>
	        <table id="printdpwxdp" width="700px" border="1" rules="all" 
	        style= "  
	        font-family: verdana,arial,sans-serif;
		    font-size:10pt;text-align: center;
		    color:#000000;
		    border-width: 1px;
		    border-color: #666666; 
		    border-collapse: collapse;
		    width: 100%; ">
	        <tr><td style="background:#9FB6CD">品牌</td><td id = "pp2"></td><td style="background:#9FB6CD" >店铺名称</td><td id="dpmc2"></td><td style="background:#9FB6CD">款号</td><td id="kh2"></td><td style="background:#9FB6CD">退货日期</td><td id="thrq2"></td> </tr>
	        <tr><td style="background:#9FB6CD">店长</td><td id = "dz2"></td><td style="background:#9FB6CD">店铺电话</td><td id="dpdh2"></td><td style="background:#9FB6CD">回寄地址</td><td id="hjdz2" colspan="3"></td>  </tr>
	        <tr><td style="background:#9FB6CD; text-align: center;" colspan="8">检测异议</td></tr>
	        <tr><td id="jcyy" height="40px" colspan="8"></td></tr>
	        </table>
	        <table width="700px" border="1" rules="all" 
	        style= "text-align: center;
	        font-family: verdana,arial,sans-serif;
		    font-size:10pt;
		    color:#000000;
		    border-width: 1px;
		    border-color: #666666; 
		    border-collapse: collapse;
		    width: 100%; ">
	       	<tr><td style="background:#9FB6CD">判定人</td><td id="pdr2" width="200"></td><td style="background:#9FB6CD">判定日期</td><td id="pdrq2"  width="200"></td></tr>
	        <tr style="background:#9FB6CD;text-align: center;"><td colspan="4">处理结果</td></tr>
	        <tr><td colspan="4"><div id="cljg"></div>
	        </td></tr>
	        
	        <tr><td>鉴定人</td><td id="jdr"></td><td>鉴定日期</td><td id="jdrq"></td></tr>
	        <tr style="background:#9FB6CD ;text-align: center;"><td colspan="4">备注</td></tr>
	        <tr ><td id="jcyy" height="40px" colspan="4"></td></tr>
	        </table>
	        </div>
  </body>
</html>
