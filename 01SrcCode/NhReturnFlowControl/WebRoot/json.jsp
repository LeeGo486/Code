<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>   
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'json.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		@import "http://localhost:8080/DOJO/dojoroot/dijit/themes/tundra/tundra.css";
		@import "http://localhost:8080/DOJO/dojoroot/dojo/resources/dojo.css";
		@import "http://localhost:8080/DOJO/dojoroot/dojox/grid/resources/tundraGrid.css";
	</style>
	<script type="text/javascript" src="http://localhost:8080/DOJO/dojoroot/dojo/dojo.js" djConfig="parseOnLoad:true,isDebug:true"></script>
	<script>
		dojo.require("dojo.parser");
		dojo.require("dojo.data.ItemFileReadStore");
		dojo.require("dojox.grid.DataGrid");
		dojo.require("dijit.form.Form");
		dojo.require("dijit.form.TextBox");
		dojo.require("dijit.form.Button");
		dojo.require("dijit.form.ComboBox");
	</script>
	<script type="text/javascript">
	 var storeData2 = {identifier: 'abbr',
			    label: 'name',
			    items: [
			        {abbr:'ec', name:'Ecuador',           capital:'Quito'},
			        {abbr:'eg', name:'Egypt',             capital:'Cairo'},
			        {abbr:'sv', name:'El Salvador',       capital:'San Salvador'},
			        {abbr:'gq', name:'Equatorial Guinea', capital:'Malabo'},
			        {abbr:'er', name:'Eritrea',           capital:'Asmara'},
			        {abbr:'ee', name:'Estonia',           capital:'Tallinn'},
			        {abbr:'et', name:'Ethiopia',          capital:'Addis Ababa'}
			]};

	var storeData1 =  <%= (String)request.getAttribute("data")  %>;
	
	
	</script>

  </head>
  
  <body>
    <form action="testByJSP"> <input type="submit"> </form>
    

      
      <%String value = (String)request.getAttribute("data");  
  out.print(value);
%>
<br>
	<s:property value="#request.data"/>
	<br>
	<div data-dojo-type="dojo.data.ItemFileReadStore"
    	 data-dojo-props="data:<s:property value="#request.data"/>" 
    	 data-dojo-id="countryStore">
    </div>
	<div data-dojo-type="dijit.form.ComboBox" 
		 data-dojo-props="store:countryStore, searchAttr:'id'">
	</div>
	<br>

	 <div dojoType="dojo.data.ItemFileReadStore" 
	 		jsId="wishStore"  url="service/wish_list.json">
	 </div>
    <table id="grid" 
    	dojoType="dojox.grid.DataGrid" 
    	store="wishStore" 
    	ClientSort="true" 
    	style="width: 100%;height: 100%;">
    	
 
    	<thead>
    		<tr>
    			<th field="description"> 货权</th>
    			<th field="size"> 款号</th>
    			<th field="origin">款式名称</th>
    			<th field="wrapper">颜色</th>
    			<th field="shape">尺码</th>
    			<th field="amount">数量</th>
    			<th field="price">单价</th>
    			<th field="totalprice">总额</th>
    		</tr>
    		<%--<tr><th field="description" width="15em" colspan="8"> 货权</th></tr>--%>
    	</thead>
    </table>
    
    
    


  <div dojoType="dojo.data.ItemFileReadStore" jsId="wishStore"  url="service/wish_list.json">
    </div>
    <table id="grid" dojoType="dojox.grid.DataGrid" store="wishStore" ClientSort="true" style="width: 100%;height: 100%;">
    	<script type="dojo/connect" event="onRowClick" args="evt">
    		var searchTerms = this.model.getItem(evt.rowIndex).description;
    		console.debug(searchTerms);
    	</script>

    	<thead>
    		<tr>
    			<th field="description"> 货权</th>
    			<th field="size"> 款号</th>
    			<th field="origin">款式名称</th>
    			<th field="wrapper">颜色</th>
    			<th field="shape">尺码</th>
    			<th field="amount">数量</th>
    			<th field="price">单价</th>
    			<th field="totalprice">总额</th>
    		</tr>
    		<tr><th field="description" width="15em" colspan="8"> 货权</th></tr>
    	</thead>
    </table>
      
  </body>
</html>
