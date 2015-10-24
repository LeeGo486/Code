<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="org.hy.model.*" %>
<%@ page language="java" import="java.sql.Timestamp" %>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";


UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
String user = userInfo.getUsername().toString();


Timestamp d = new Timestamp(System.currentTimeMillis());
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>总部发货单</title>
    
    <script type="text/javascript">
     $(function(){
   
 	     	 	var $win = $('#win').window({
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
			     
 	     	
 	     	
 	    });
 	    
    </script>
  </head>
  
  <body>
	   <!-- 总部发货界面  -->
				<div id="win" class="easyui-window" title="总部发货单"    
				        data-options="iconCls:'icon-save',modal:true,closed:true">
				   <table ><tr><td style="text-align: center;"></td></tr></table>
				   <table border="1" rules="all" 
					        style= "text-align: center;
					        font-family: verdana,arial,sans-serif;
						    font-size:10pt;
						    color:#000000;
						    border-width: 1px;
						    border-color: #666666; 
						    border-collapse: collapse;"    >
				   <tr><td style="background:#9FB6CD" width="120">店铺信息</td><td  style="background:#9FB6CD" width="100">店铺编码</td><td><input id="dpbmz" ></input></td><td style="background:#9FB6CD" width="120">店铺名称</td><td style="width:120"><input id="dpmcz"></input></td></tr>
				   <tr><td style="background:#9FB6CD" rowspan="4">物流信息</td><td  style="background:#9FB6CD">运输公司</td><td><input id="zbfh_ysgs" style="width: 130"></input> </td><td style="background:#9FB6CD">运输单号</td><td><input id="zbfh_ysdh" ></input></td></tr>
				   <tr>						<td style="background:#9FB6CD">发货地址</td><td colspan="3"><input id="zbfh_fhdz2" type="text" ></input></td></tr>
				   <tr>						<td style="background:#9FB6CD">收货地址</td><td colspan="3"><input id="zbfh_shdz2" ></input></td></tr>
				   <tr>						<td style="background:#9FB6CD">收货人</td><td><input id="zbfh_shr2" ></input></td><td  style="background:#9FB6CD">联系电话</td><td><input id="zbfh_shrdh2" ></input></td></tr>
				   <tr><td height="40" style="background:#9FB6CD">备注</td><td colspan="4"><input id="zbfh_bz" ></input></td> </tr>
				   </table>
				   <table><tr><td width="200"></td><td>编制人</td><td width="90"><input id="zbfh_bzr" value="<%=user %>"></input></td><td>编制日期</td><td width="100"><input id="zbfh_bzrq" value="<%=d%>"></input></td></tr>
				   <tr height="23"></tr>
				   <tr><td></td>
				   <td><a id="save08" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="saveMaintain(id,8);">确定</a></td>
				   <td></td>
				   <td><a id="save08" class="easyui-linkbutton" data-options="iconCls:'icon-no'" onclick="$('#win').window('close');">取消</a></td></tr>
				   </table>
				   
				   </div>
	
  </body>
</html>
