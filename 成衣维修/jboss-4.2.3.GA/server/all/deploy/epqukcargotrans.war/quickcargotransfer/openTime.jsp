<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>时间范围</title>
    
	<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>	

  </head>
  <script type="text/javascript">
  function confirmTime(){
  	opener.document.getElementById('bgnDate').value=document.getElementById('bgnDate').value;
  	opener.document.getElementById('endDate').value=document.getElementById('endDate').value;
  	opener.queryZBinfo();
  	window.close();
  }
  
  </script>
  <body>
	
	<html:form action="/viewCargoApplyRes" styleId="viewCargoApplyResForm">
		<div align="center">
			开始<html:text property="bgnDate" onclick="setday(this)" readonly="true" /> <br />
			 结束<html:text property="endDate" onclick="setday(this)" readonly="true" /><br />
		
			<div align="center">
			<html:button property="button1" onclick="confirmTime()">确定</html:button>
			<html:button property="button2" onclick="window.close()">取消</html:button>
			</div>
	
		</div>
	</html:form>
  </body>
</html>
