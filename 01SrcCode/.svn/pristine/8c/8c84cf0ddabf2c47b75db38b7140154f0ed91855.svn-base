<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>供应商维护界面</title>
	
	<style type="text/css">
		table{font-size: 12px;
		}
	</style>
	<SCRIPT type="text/javascript">
		function refcfm(){
			
			document.form1.submit();
		}

	</SCRIPT>

  </head>

  <body>
  
  <div style="text-align: center;">
  <div style="text-align: center;">
  <table ><tr><td > <b> <font style="font-size: 13px;" >配置供应商界面(EP)</font></b></td></tr></table>
</div>
<hr color="#DEDEBE" size="1"/>

		
		<table>
		<tr>
		<s:form action="supplierSave">
	  			<font style="font-size: 12px;">添加供应商编号:</font><s:textfield label="供应商编号" name="suppliesId" theme="simple" cssStyle="width: 100px;"></s:textfield>
	  			<input type="submit" value="提交"/>
	  		</s:form>
	  		<table style="color: red;"><tr><td><s:fielderror fieldName="msg"></s:fielderror></td></tr></table>
		
		</tr>
		</table>
	  	<table border="1" cellspacing="0" cellpadding="0" height="30" style="border: 1px solid ; width: 300px">
	    	<tr style="font-size: 13px;background-color: #D2E9FF; height: 22px;"><%--
	    		<td>选择</td>
	    		--%><td style="width: 40px;">序号</td>
	    		<td style="width: 80px;">供应商编号</td>
	    		<td style="width: 40px;">操作</td>
	    	</tr>
	<s:iterator id="suppliers" value="#request.list" status="list">
	    	<tr class="EvenOrOddRow"   onclick="changeActiveRow(this);" style="height: 20px;">	
	    		<%--<td>
	    <input type="checkbox" name="suppliesId" id="suppliesId" value="<s:property value="suppliesId"/>" /> 
	    		</td>
	    		--%><td style="background-color: #D2E9FF"><s:property value="#list.count" /></td>
	    		<td><s:property value="suppliesId" /></td>
	    		<td>
	   <a href="deleteSupplier.action?suppliesId=<s:property value="suppliesId"/>">删除</a>
	    		 </td>
	    	</tr>
	</s:iterator>
	    	</table>
	  		<br>
	
	  	
	  		
	
  	</div>
<s:form action="listSupplier" name="form1"></s:form>
 
  </body>
<script type="text/javascript">

//document.getElementsByName('radio')[0].checked=true;//默认选中正
//单机改变table颜色
var currentActiveRow; 
	function changeActiveRow(obj){  
 	if(currentActiveRow)   
		currentActiveRow.style.backgroundColor="";   
		currentActiveRow=obj; 
	 	currentActiveRow.style.backgroundColor="#cecece"; 
 }

</script>


</html>


