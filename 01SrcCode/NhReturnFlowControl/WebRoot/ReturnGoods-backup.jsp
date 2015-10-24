<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>退货发货界面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
	/*间隔行的颜色*/
		table.t1 {
			background-color:#add9c0;
		}
		tr.a1{
		    background-color:#f0f8ff;
		}
		tr.a2{
			background-color:#fffaf0;
		}
	</style>
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
	</script>
	
	<!--table 单机选中改变背景色 -->
	<script type="text/javascript">	
   	var currentActiveRow; 
 	function changeActiveRow(obj){  
	 	if(currentActiveRow)   
			currentActiveRow.style.backgroundColor="";   
			currentActiveRow=obj; 
		 	currentActiveRow.style.backgroundColor="#87ADF1";    
	 }
	</script>
	
  </head>
  
  <body>

  	店铺名称： <s:property value="jDepot.dname"/><br>
  	制单日期： <s:property value="dOutindentSet.crdate"/><br>
  	
  	<table id="TableNew"  class="t1" style=" border-collapse:collapse; border:solid  0px; border-color: white; width: 800px" border="0">
  		<tr>
  			<td>款式编号</td> <td>颜色编号</td> <td>尺码</td>
  			<td>成本价</td> <td>结算价</td> <td>退货数量</td>
  			<td>折扣</td> <td>原价</td> <td>现价</td>
  			<td>审核入库数量</td> <td>创建时间</td> <td>备注</td> <td>更新时间</td>
  		</tr>
  	<s:iterator id="dOutindentSetsub" value="dOutindentSetsub" status="list">   	
  		<tr class="EvenOrOddRow"   onclick="changeActiveRow(this);" >
  			<td><s:property value="styleid"/></td>
  			<td><s:property value="colorid"/></td>
  			<td><s:property value="sizeid"/></td>
  			<td><s:property value="cost"/></td>
  			<td><s:property value="SPrice"/></td>
  			<td><s:property value="nums"/></td>
  			<td><s:property value="discount"/></td>
  			<td><s:property value="JPrice"/></td>
  			<td><s:property value="XPrice"/></td>
  			<td><s:property value="chknums"/></td>
  			<td><s:property value="crdate"/></td>
  			<td><s:property value="comment"/></td>
  			<td><s:property value="updatetime"/></td>
  		
  		</tr>
  		
  	</s:iterator>

  	</table>
  	
  	<br>
  	
    <div style="height: 100px;">
    	<s:form>
    		<table>
    			<tr>
    				<td><s:textfield name="loginName" label="单据号"></s:textfield></td>
    				<td><s:textfield name="loginName" label="收货地"></s:textfield></td>
    				<td><s:textfield name="loginName" label="制单日期"></s:textfield></td>
    			</tr>
    			<tr>
    				<td></td>
    				<td></td>
    				<td></td>
    				
    			</tr>  		
    		</table>	
    	</s:form>
    	
    </div>
    
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
    		<%--<tr><th field="description" width="15em" colspan="8"> 货权</th></tr>--%>
    	</thead>
    </table>
  </body>
  
  <!-- table 颜色间隔行 -->
	<script type="text/javascript" language="javascript">
    for (i=1;i<TableNew.rows.length;i++) 
    {
　　    //(i%2==0)?(TableNew.rows(i).className = "a1"):(TableNew.rows(i).className = "");与下边方法相同
        if(i%2==0)
        {
            TableNew.rows(i).className = "a1";
        }
        else
        {
            TableNew.rows(i).className = "a2";
        }
　　}
    </script>
</html>
