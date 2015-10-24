<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>供应商维护界面</title>

	<style type="text/css">
		@import "http://localhost:8080/DOJO/dojoroot/dijit/themes/tundra/tundra.css";
		@import "http://localhost:8080/DOJO/dojoroot/dojo/resources/dojo.css";
	</style>
	<script type="text/javascript" src="http://localhost:8080/DOJO/dojoroot/dojo/dojo.js" djConfig="parseOnLoad:true,isDebug:true"></script>
	
	<script type="text/javascript">
		dojo.require("dojo.parser");//
		dojo.require("dijit.layout.ContentPane");//在内容的周围创建边界，以便纳入其它框里
		dojo.require("dijit.layout.TabContainer");//将ContentPane一个个层叠，用户可以通过顶部的选项卡加以选择
		dojo.require("dijit.form.ValidationTextBox");//控件验证信息
		dojo.require("dijit.form.DateTextBox");//日期选择器
		
	</script>
	<style type="text/css">
		.formContainer{width: 600px;height: 300px;}
		label{width: 150px;float: left;}
	</style>
	<SCRIPT type="text/javascript">
		function refcfm(){
			
			document.form1.submit();
		}

	</SCRIPT>

  </head>

  <body class="tundra">
  <br><br><br>
  <h2>供应商维护界面</h2>
  
  <div dojoType="dijit.layout.TabContainer" class="formContainer"> 
  
	 <div dojoType="dijit.layout.ContentPane" title="供应商编号列表">
		<s:form action="listSupplier" name="form1"></s:form>
	  	<input type="button" value="刷新" onclick="refcfm();">
	  	<input type="button" value="删除" onclick="delcfm();">
	  	
		  	<table style="border: 1px solid;">
	    	<tr>
	    		<td>选择</td>
	    		<td>序号</td>
	    		<td>供应商编号</td>
	    		<td>操作</td>
	    	</tr>
	<s:iterator id="suppliers" value="#request.list" status="list">
	    	<tr>	
	    		<td>
	    <input type="checkbox" name="suppliesId" id="suppliesId" value="<s:property value="suppliesId"/>" /> 
	    		</td>
	    		<td><s:property value="#list.count" /></td>
	    		<td><s:property value="suppliesId" /></td>
	    		<td>
	   <a href="deleteSupplier.action?suppliesId=<s:property value="suppliesId"/>">删除</a>
	    		 </td>
	    	</tr>
	</s:iterator>
	    	</table>
	  		<br>
	
	  	</div>
	  	
	  	<div dojoType="dijit.layout.ContentPane" title="新增" >
	  	
	  		<s:form action="supplierSave">
	  			供应商编号:<s:textfield label="供应商编号" name="suppliesId" theme="simple"></s:textfield>
	  			<input type="submit" value="提交"/>
	  		</s:form>
	  		<table style="color: red;"><tr><td><s:fielderror fieldName="msg"></s:fielderror></td></tr></table>
	  	</div>
	  	
  	</div>
  	

 
  </body>



</html>


