<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%String webContext = request.getContextPath(); %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<title>������Ϣ</title>
	</head>

<body>
	
	<s:form action="/web/appraise-view!getAppraiseInfo" method="post" theme="simple">
		
		
		<div align="center" style="height:200px;" id="shopAppraise" title="��������" >
		�������ۣ�
		<center>
	 		<s:radio name="maintainRegister.dppj" list="#request.appraiseList" 
	 		listKey="radioCode" listValue="radioName" disabled="true">
	 		</s:radio>
				
			<br>
		 	  <s:textarea name="maintainRegister.dppjyj" cssStyle="width:400px;height:100px;" disabled="true"></s:textarea> 
		</center>
		</div>
		
		<br />
	
	<div align="center" style="height:200px;" title="�˿�����">
		
		�˿����ۣ�
			<center>
				<s:radio name="maintainRegister.gkpj" list="#request.appraiseList" 
				listKey="radioCode" listValue="radioName" disabled="true"></s:radio>
			
			<br>
			
			<s:textarea name="maintainRegister.gkpjyj" cssStyle="width:400px;height:100px"
			 disabled="true"></s:textarea>
			</center>
	</div>
	
	</s:form>

</body>
</html>