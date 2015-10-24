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
  </head>
  <body>
		<!-- 维修完成 弹出窗 -->
				   <div id="wxwc" class="easyui-window" title="维修完成确认" style="width:380px;height:200px;"   
				        data-options="iconCls:'icon-save',modal:true,closed:true">
				   <table style="text-align: center;">
				   <tr height="20"></tr>
				   <tr>
				   <td >是否完成：</td>
				   <td>
				   	<select id="iswc" >
					<option value="7">完成</option>
					<option value="14">未完成</option>
					</select>
					</td>
					</tr>
					
				   <tr><td width="110">维修人：</td><td width="120"><input id="wxr2" class="easyui-combogrid" /></td></tr>
				   <tr><td >维修时间：</td><td><input id="wxsj2" class="easyui-datebox"  /></td></tr>
				  
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
