<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String status  = request.getParameter("status");
	String closed  = request.getParameter("closed");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<title>成衣维修登记列表查询</title>

<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js" charset="GBK"></script>
<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js" charset="GBK"></script>
<script language="javascript" >
function formatpdclfs(val) {
	  var pdclfs_name;
	  if(val=='1'){
		  pdclfs_name='产品退仓';
	  }
	  else if(val=='2'){
		  pdclfs_name='不能维修，退回店铺';
	  }
	  else if(val=='3'){
		  pdclfs_name='退回店铺';
	  }
	  return pdclfs_name;
 }
 
function formatwxxz(val) {
	  var wxxz_name;
	  if(val=='1'){
		  wxxz_name='帮忙维修';
	  }
	  else if(val=='2'){
		  wxxz_name='质量维修';
	  }
	  return wxxz_name;
 }


function formatjjcd(val) {
	  var jjcd_name;
	  if(val=='01'){
		  jjcd_name='一般';
	  }else if(val=='02'){
		  jjcd_name='紧急';
	  }else if(val=='03'){
		  jjcd_name='非常急';
	  }
	  return jjcd_name;
 }


$(function(){
	 //进入页面初始化
	//下拉列表选择  店铺编码
	$('#filterdp').combogrid({
		panelWidth:260,
 		mode:'remote',
		idField:'depotid',
		textField:'dname',
		url:'rest/getFilterdp/S2',
		method:'post',
		columns:[[
			{field:'depotid',title:'店铺编号',width:90},
			{field:'dname',title:'店铺名称',width:160}
		]]
	});
	//普通下拉2   状态
	$('#filterzt').combobox({
		url:'rest/getFilterzt/S1',
		method:'post',
		valueField:'bh',
		textField:'mc'
	});
	
	//普通下拉2   状态
	$('#filterpl').combobox({
		url:'rest/getFilterpl/S1',
		method:'post',
		valueField:'plid',
		textField:'plmc'
	});
	
//列表显示
var dh,dp,vipkh,     ydh,kh,zt, closed,          dd1,dd2,lx;
    	dh=document.getElementById("dh").value;
    	dp=$('#filterdp').combobox('getText');
    	vipkh = document.getElementById("vipkh").value;
    	
    	ydh=document.getElementById("ydh").value;
    	kh=document.getElementById("kh").value;
    	zt=$('#filterzt').combobox('getValue');
    	closed = document.getElementById("closed").value;
    	dd1 = $('#dd1').datebox('getValue'); 
    	dd2=$('#dd2').datebox('getValue');
    	lx=$('#lx').combobox('getValue');
    	
    	pl=$('#filterpl').combobox('getValue');
        var query={dh:dh,dp:dp,vipkh:vipkh,    ydh:ydh,kh:kh,zt:zt,    closed:closed  ,     dd1:dd1,dd2:dd2,lx:lx,pl:pl}; //把查询条件拼接成JSON

	var para = getArgs("status");
	$('#operateRecordGrid').datagrid({
	//	title:'DataGrid - ContextMenu',
		iconCls:'icon-save',
		width:980,
	//	height:450,
	singleSelect:true,
		nowrap: true,
		autoRowHeight: false,
		striped: true,
		collapsible:true,
		loadMsg:'正在努力查找数据……',
		//url:'/gclm/web/maintainregister!execute',
		url:'rest/getQueryList/'+para,
		queryParams:query,
		method:'post',
		toolbar:[ {     
			text:'导出Excel',     
			iconCls:'icon-excel',     
			handler:function(){      
				$('#excelbtn').click();
				// $(this).click(function(){});
				 //$.post(
						  //'rest/getExcelList/'+para,
						// '/gclm/web/maintainregister!excel',
						// '/gclm/web/maintainregister!execute',
						// '/gclm/web/ExcelList!outPut',
						//'/gclm/web/maintainregister!outPut',
						// query						
						 //function(){$.messager.alert("提示","导出成功");}
					//	 );
			       } 
					    
		}],
		onDblClickRow: function() {
		    var selected = $('#operateRecordGrid').datagrid('getSelected');
		    if (selected){
		    	window.parent.frames.listDbOnclick(selected.guid,selected.zt);
		   }},
		columns:[[
			{field:'dh',title:'维修单号',width:'150',sortable:true},
			{field:'ydh',title:'运单号',width:100,sortable:true},
			{field:'dpbm',title:'店铺编码',width:90,sortable:true},
			{field:'dpmc',title:'店铺名称',width:120,sortable:true},
			{field:'kh',title:'款号',width:100,sortable:true},
			
			{field:'zt_name',title:'状态',width:120,sortable:true},
			{field:'djsj',title:'登记时间',width:120,sortable:true},
			{field:'thrq',title:'退回日期',width:120,sortable:true},
			{field:'gkxm',title:'顾客姓名',width:80,sortable:true},
			{field:'vipkh',title:'VIP卡号',width:90,sortable:true},
			{field:'jjcd',title:'紧急程度',width:80,sortable:true,
				formatter:function(val){
 				return formatjjcd(val);
			}},
			{field:'wxxz1',title:'维修性质1',width:100,sortable:true,
				formatter:function(val){
	 				return formatwxxz(val);
				}},
			//{field:'wtd1',title:'问题点1',width:100,sortable:true},
			{field:'wtd_name',title:'问题点1',width:100,sortable:true},
			{field:'qy_name',title:'起因1',width:100,sortable:true},
			{field:'xxd_name',title:'现象点1',width:100,sortable:true},
			{field:'bwms',title:'部位描述',width:120,sortable:true},
			{field:'pjpdsj',title:'品检判定时间',width:120,sortable:true},
			{field:'zbfhBzrq',title:'总部发货时间',width:120,sortable:true},
			{field:'pdclfs',title:'判定处理方式',width:120,sortable:true,formatter:function(val){
 				return formatpdclfs(val);
			}},
			{field:'wxsj',title:'维修时间',width:90,sortable:true},
			//{field:'dppj',title:'店铺满意度',width:80,sortable:true},
			{field:'thdh',title:'退货单号',width:100,sortable:true},
			{field:'posthfhddzbs',title:'POS退货发货单登帐标识',width:100,sortable:true}
		]],
		pagination:true,
		rownumbers:true
	});
		
	
	//设置分页控件  
	var p = $('#operateRecordGrid').datagrid('getPager');
	$(p).pagination( {
		pageSize : 10,//每页显示的记录条数，默认为10  
		pageList : [ 5, 10, 15 ],//可以设置每页记录条数的列表  
		beforePageText : '第',//页数文本框前显示的汉字  
		afterPageText : '页    共 {pages} 页',
		displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',
		onBeforeRefresh : function() {
			$('#operateRecordGrid').datagrid('reload');
		}
	});
	
	
	
	
	
	//日期控件
	$('#dd1').datebox({
        formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
        parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
        });    
   $('#dd2').datebox({
       formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
       parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
       });  
   
})



		 
function getArgs(para) {  
	  var query = location.search.substring(1);     // Get query string  
	    var pairs = query.split("&");                 // Break at ampersand  
	    for(var i = 0; i < pairs.length; i++) {  
	         var pos = pairs[i].indexOf('=');          // Look for "name=value"  
	         if (pos == -1) continue;                  // If not found, skip  
	         var argname = pairs[i].substring(0,pos);  // Extract the name  
	         var value = pairs[i].substring(pos+1);    // Extract the value  
	         value = decodeURIComponent(value);        // Decode it, if needed  
	         if (para == argname) {
	         	return value;
	         }											// Store as a property  
	     }  
	     return "";                                  // Return the object  
	 }  

	 
    function searchData(){  
     	var dh,dp,vipkh,     ydh,kh,zt, closed,          dd1,dd2,lx;
    	dh=document.getElementById("dh").value;
    	dp=$('#filterdp').combobox('getText');
    	vipkh = document.getElementById("vipkh").value;
    	
    	ydh=document.getElementById("ydh").value;
    	kh=document.getElementById("kh").value;
    	zt=$('#filterzt').combobox('getValue');
    	closed=document.getElementById("closed").value;
    	dd1 = $('#dd1').datebox('getValue'); 
    	dd2=$('#dd2').datebox('getValue');
    	lx=$('#lx').combobox('getValue');
    	
    	pl=$('#filterpl').combobox('getValue');
        var query={dh:dh,dp:dp,vipkh:vipkh,    ydh:ydh,kh:kh,zt:zt,  closed:closed,         dd1:dd1,dd2:dd2,lx:lx,pl:pl}; //把查询条件拼接成JSON
 
        $("#operateRecordGrid").datagrid('options').queryParams=query; //把查询条件赋值给datagrid内部变量
    	$("#operateRecordGrid").datagrid('reload'); //重新加载

    	$('#operateRecordGrid').datagrid({
        	pageNumber:1	
    	});

    	var p = $('#operateRecordGrid').datagrid('getPager');
    	$(p).pagination( {
    		pageSize : 10,//每页显示的记录条数，默认为10  
    		pageList : [ 5, 10, 15 ],//可以设置每页记录条数的列表  
    		beforePageText : '第',//页数文本框前显示的汉字  
    		afterPageText : '页    共 {pages} 页',
    		displayMsg : '当前显示 {from} - {to} 条记录   共 {total} 条记录',
    		onBeforeRefresh : function() {
    			$('#operateRecordGrid').datagrid('reload');
    		}
    	});
    	
} 
 

    </script>

<style type="text/css">

html,body{
  _height:100%; _overflow:auto;
}
#header,#footer{
 position:fixed;
_position:absolute;
 z-index:1000;
 width:100%;
 height:40px;
 background:window;
 left:20px;
}
#content{background:#ccc;_height:100%;_overflow:auto; position:relative; padding:20px; }
#header{top:0;}
#footer{bottom:0; width:500px; float:right;}


</style>
</head>

<body>
<div  id="header">
    <a id="button" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick=" searchData()">查询</a>
 <%--<td><a id="btngjsearch" href="<%=path%>/cm/register/QueryList.jsp" class="easyui-linkbutton" onclick=" getValuelx()" data-options="iconCls:'icon-tip'">高级查询</a> </td>--%>
 </div> 
 
 
        
<table>
  
 <tr>
	<td>
	</td>
	<td>
	
	<form name="form1" action="<%=path %>/web/maintainregister!outPut" method="post">  
 
	<div align="center" style="padding-top: 30">
	
	<table>
	
	<tr><td>店铺</td><td><select id="filterdp" name="dp" style="width:135px;"></select></td><td>运输单号</td><td><input id="ydh" name="ydh" type="text"></input></td>
	<td>款号</td><td><input id="kh" type="text" name="kh"></input></td><td>状态</td><td>
	<select id="filterzt" class="easyui-combobox" name="zt" style="width:135px;"></select>
	</td><td>品类</td><td><select id="filterpl" class="easyui-combobox" name="pl" style="width:135px;"></select>
	</td></tr>
	<%-- required="required" --%>
	
	<tr><td>维修单号</td><td><input id="dh" name="dh" class="easyui-validatebox" /></td>
	
	<td>店铺类型</td>
	<td>
	<select id="lx" class="easyui-combobox" name="lx" style="width:135px;height: 50px;" data-options="required:true,panelHeight:'auto'" >
		<option value="0" selected>全部</option>
		<option value="1">自营</option>
		<option value="2">加盟</option>
	</select>
	</td>
	
	<td>客户/VIP号</td><td><input id="vipkh" name="vipkh" type="text"></input></td>
	
	<td>登记时间</td><td><input id="dd1" name="dd1" class="easyui-datebox" style="width:135px;" ></input></td><td>- -</td><td><input id="dd2" name="dd2" class="easyui-datebox" style="width:135px;"></input></td>
	</tr>
	
	</table>
	
	
	</div>
	<br/>
 
  <div style="display: none">
  <input id="status" name="zturl" type="hidden"  value="<%out.print(request.getParameter("status"));%>">
 <input type="text" id="closed" name="closed" value="<%=closed%>"></input>
    <input type="submit" id="excelbtn" value="导出excel"></input>  
</div>

	 </form>
	
	<div>
	 
	<table id="operateRecordGrid"></table>
	</div>
	</td>
	<td>
	<div align="right"></div>
	</td>
	</tr>
	</table>
	
	
	<input id="path" type="hidden" value="<%=path%>" />
	
</body>
</html>
