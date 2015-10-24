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
    
    <title>维修完成</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
    
    <script type="text/javascript">
     $(function(){
      	$('#wxsj_gys').datebox({
               formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
               parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
       	  }); 
 	      	 var d,date;
 	     	  d = new Date();
 	     	  date = d.getFullYear() + "-";            
 	     	  date = date + (d.getMonth() + 1) + "-";
 	     	  date += d.getDate() + " ";     
 	     	$('#wxsj_gys').datebox('setValue',date);
 	     	
 	     	 	var $win = $('#wxwc').window({
			            top:($(window).height()-600) * 0.5,   
			            left:($(window).width() - 450) * 0.5,
			            shadow: true,
			            modal:true,
			            iconCls:'icon-add',
			      closed:true,
			      minimizable:false,
			      maximizable:false,
			      collapsible:false
			         });
			     
 	     	getGysInfo('wxgys',$('#kh').attr('value'));
 	     	
 	    });
 	    
 	    
    </script>
  </head>
  <body>
		<!-- 维修完成 弹出窗 -->
				   <div id="wxwc_gys" class="easyui-window" title="维修完成确认" style="width:380px;height:200px;" 
				        data-options="iconCls:'icon-save',modal:true,closed:true">
				   <table style="text-align: center;">
				   <tr height="20"></tr>
				   <tr>
				   <td >是否完成：</td>
				   <td>
				   	<select id="iswc_gys" class="easyui-combobox" style="width:220">
					<option value="7">完成</option>
					<option value="14">未完成</option>
					</select>
					</td>
					</tr>
					
				   <tr><td>供应商：</td><td><input id="wxgys" class="easyui-combogrid" style="width: 200"/></td></tr>
				   <tr><td>收费金额：</td><td><input id="wxsfje" type="text"  style="border:1px solid #A4BED4;width: 200px;height: 22px" /></td></tr>
				  
				   <tr><td >维修时间：</td><td><input id="wxsj_gys" class="easyui-datebox" style="width: 200" /></td></tr>
				   </table>
				   <table>
				    <tr>
				    <td width="80"></td>
				    <td ><a style="text-align: right;" id="save07" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveMaintain(id,$('#iswc_gys').combobox('getValue'))">确认</a></td>
				  	<td width="40"></td>
				   <td><a id="save07" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#wxwc_gys').window('close');">取消</a></td>
				   </tr>
				   </table>
				   </div>
  </body>
</html>
