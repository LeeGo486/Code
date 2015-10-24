<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.math.BigDecimal"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
ArrayList appraiseList = (ArrayList)request.getAttribute("appraiseList");
int listLen = 0;
if(appraiseList != null){
	listLen = appraiseList.size();
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>查看评分</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body bgcolor="#F32110">
    <table>
    	<tr>
    		<td colspan="4" align="center">
    			<b> 星级党员评选总分排名</b>
    		</td>
    	</tr>	
    	<tr>
    		<td><b>排名</b></td>
    		<td><b>党员姓名</b></td>
    		<td></td>
    		<td><b>总分</b></td>
    	</tr>
    	
    	
    	
    	<%
    	String dyname=null;
    	int totalpoint=0;
    	float ratio = 0;
    	if(listLen!=0){
    		
    		ratio = (float) 600/((BigDecimal)((Map)appraiseList.get(0)).get("totalpoint")).intValue();
    	}
    	for(int i=0;i<listLen;i++){ 
    		Map appraise = (Map)appraiseList.get(i);
    		dyname =(String) appraise.get("dyname");
    		totalpoint=((BigDecimal)((Map)appraiseList.get(i)).get("totalpoint")).intValue();
    		System.out.println(totalpoint*ratio);
    	%>
    	
    	<tr>
    		<td width="40">
    			<%=i+1%>
    		</td>
    		
    		<td width="80">
    			<%=dyname%>
    		</td>
    		
    		<td width="600">
    			<hr size="10" width="<%=totalpoint*ratio%>" color="blue" align="left">
    		</td>
    			
    		<td width="80">
    			<%=totalpoint%>分
    		</td>
    	</tr>
    	
    	<%}%>
    	
    </table>
  </body>
</html>
