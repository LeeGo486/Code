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
    
	<script type="text/javascript" src="<%=path%>/js/maintainInit.js"></script>
	<script type="text/javascript" src="/gclm/jquery-easyui-1.3.1/locale/easyui-lang-zh_CN.js"></script>
	
	
    <script type="text/javascript">
    $(function(){
           	  $('#wxsj2').datebox({
               formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
               parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
       	  }); 
 	      	 var d,date;
 	     	  d = new Date();
 	     	  date = d.getFullYear() + "-";            
 	     	  date = date + (d.getMonth() + 1) + "-";
 	     	  date += d.getDate() + " ";     
 	     	$('#wxsj2').datebox('setValue',date);
 	     	
 	     	
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
			  
			  initZzwxd();
			     
 	     	
      });
    </script>
  </head>
  <body>
		<!-- 维修完成 弹出窗 -->
				   <div id="wxwc" class="easyui-window" title="维修完成确认" style="width:380px;height:250px;padding-top: 10px"   
				        data-options="iconCls:'icon-save',modal:true,closed:true">
				   <table style="text-align: center;">
				   <tr height="20"></tr>
				   <tr>
				   <td >是否完成：</td>
				   <td>
				   	<select id="iswc" style="width: 200px">
					<option value="7">完成</option>
					<option value="14">未完成</option>
					</select>
					</td>
					</tr>
					 <tr><td>维修人：</td><td><input id="wxr2" class="easyui-combogrid" style="width: 200px"/></td></tr>
				   <tr><td >维修时间：</td><td><input id="wxsj2" class="easyui-datebox"  style="width: 200px" /></td></tr>
				  <tr><td>最终维修点：</td><td><input id="zzwxd"   class="easyui-combogrid" style="width:200px;"></td> </tr>
					<tr><td>收费金额：</td><td><input id="nxsfje" type="text"  style="border:1px solid #A4BED4;width: 200px;height: 22px" /></td></tr>
				  
				   </table>
				 

				   <table>
				    <tr>
				    <td width="80"></td>
				   <td ><a style="text-align: right;" id="save07" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveMaintain(id,$('#iswc').combobox('getValue'))">确认</a></td>
				  <td width="40"></td>
				   <td><a id="save07" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#wxwc').window('close');">取消</a></td>
				   </tr>
				   </table>
				   </div>
  </body>
</html>
