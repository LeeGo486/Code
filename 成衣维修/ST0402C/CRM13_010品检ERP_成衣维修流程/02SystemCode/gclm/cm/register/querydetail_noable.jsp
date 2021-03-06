<%@ page language="java" contentType="text/html; charset=GBK" import="java.util.*" pageEncoding="GBK"%>
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
  <script language="javascript" src="LodopFuncs.js"></script>
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset= GBK  ">
    
    <title>维修登记详细</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/maintain.js" charset="gbk"></script>
	<script type="text/javascript" src="<%=path%>/js/maintainInit.js"></script>

<link rel="stylesheet" type="text/css" href="<%=path%>/css/maintain.css">

 <script type="text/javascript">
 $(function(){
		var guid='<%out.print(request.getParameter("guid"));%>';
		 var zt = '<%out.print(request.getParameter("zt"));%>';
		getDetail(guid,zt);
		
		getGysInfo('gys',$('#kh').attr('value'));
		//详细界面功能按钮权限
		var btn = '<%out.print(request.getParameter("btn"));%>';
		var btns = btn.split(',');
		
		
		for(i==0;i<btns.length;i++){
			$('#'+btns[i].toString()).linkbutton('enable');    
		}
		
		
		
		
})    ;  
   
      
  
 function checkzt(ztnew){
	var ztold='<%out.print(request.getParameter("zt"));%>';
	
	if(ztnew==7){
		 //维修确认 旧状态为 5
		 if(ztold==5)
			 {
			 if($('#nx').combobox('getValue')==1){$('#wxwc_gys').window('open');}else{$('#wxwc').window('open');}
			 }else{
				 $.messager.alert("提示", "当前状态不允许维修确认");return;
			 }
	 }
	else 
	if(ztnew=8){
		 //总部发货 旧状态为4 或 7 的时候允许发货
		 if(ztold==4||ztold==7)
			 {
			 $('#win').window('open');
			 }else{
				 $.messager.alert("提示", "当前状态不允许发货");return;
			 }
	 }
 }
   
        
      
 </script>
   
<style type="text/css">
  input[disabled=disabled]{color:#191970}
</style>

  </head>
  
  <body>
  
   
 <input type="hidden" id="branch" name="branch" value="">
 <input type="hidden" id="pp" name="pp" value="">
 
   <div id="header" class="toolbar">
   <%--
 <a id="save20" class="easyui-linkbutton" data-options="iconCls:'icon-redo',disabled:true" onclick="saveMaintain(id,$('#pdclfs').combobox('getValue'))">品检判定</a>
 <a id="save07" class="easyui-linkbutton" data-options="iconCls:'icon-redo',disabled:true" onclick="$('#wxwc').window('open');">维修确认</a>
  <a id="save015" class="easyui-linkbutton" data-options="iconCls:'icon-redo',disabled:true" onclick="saveMaintain(id,15)">关闭</a>
  <a id="save08" class="easyui-linkbutton" data-options="iconCls:'icon-redo',disabled:true" onclick="$('#win').window('open');">总部发货</a>
 <a id="save020" class="easyui-linkbutton" data-options="iconCls:'icon-redo',disabled:true" onclick="saveMaintain(id,1)">重新判定</a>
 --%>
 <a id="printdp" class="easyui-linkbutton" data-options="iconCls:'icon-print',disabled:true" onclick="dpPrint()">店铺打印</a>
 <a id="printzb" class="easyui-linkbutton" data-options="iconCls:'icon-print',disabled:true" onclick="zbPrint()">总部打印</a>
 <a id="printkd" class="easyui-linkbutton" data-options="iconCls:'icon-print',disabled:true" onclick="kddPrint()">快递单打印</a>  
   <input type="text" readonly="readonly" style="text-align:right;font-size: 17pt;font-family:'微软雅黑';" id="zt" width="100%" height="100%"/>
   </div>
	<div style="padding-top:40px;">
	    <form id="ff" method="post" >
	    <table class="gridtable">
		    <tr></tr>
		    <tr class="head" ><td colspan="3"><input id="guid" type="hidden" value="<%out.print(request.getParameter("guid"));%>"></input></td><th><label >维修单号:</label></th><td colspan="2"><input id="wxdh" disabled="disabled"></input></td></tr>
		     
		     <tr><th rowspan="3">店铺信息</th>	<th>店铺编码</th><td><select id="dpbm"  style="width: 200px;border:1px solid #fffffb;" disabled="disabled"></select> </td><th>店铺名称</th><td><input id="dpmc" disabled="disabled" class="easyui-validatebox" type="text"  style="width: 170px" ></input></td><td><input ID="dplx" disabled="disabled" style="width: 30px"></input> </td></tr>
		     <tr >							<th>店长姓名</th><td><input id="dzxm" disabled="disabled"></input></td><th>店长联系电话</th><td colspan="2"><input id="dzlxdh" disabled="disabled"></input</td></tr>
		     <tr>							<th>维修仓编号</th><td><input id="wxcbm" disabled="disabled"></input></td><th>维修仓名称</th><td colspan="2"><input id="wxcmc" disabled="disabled"></input></td></tr>
		     
		     <tr><th rowspan="2">维修接单信息</th><th>受理导购</th><td><input id="sldg" disabled="disabled" style="width: 200px;"></input></td><th>导购联系电话</th><td colspan="2"><input id="dglxdh" disabled="disabled"></input></td></tr>
		     <tr>		<th>顾客维修</th><td colspan="4"><input type="checkbox" disabled="disabled" id="isgkwx" value="1" style="width: 20px;" /> </td></tr>
		     
		    <tr><th rowspan="3">顾客信息</th>	<th>VIP卡号</th><td><input id="vipkh" disabled="disabled"></input></td><th>顾客姓名*</th><td colspan="2"><input id="gkxm" disabled="disabled" data-options="required:true"></input></td></tr>
		    <tr>							<th>顾客联系电话</th><td><input id="gklxdh" disabled="disabled"></input></td><th>售出时间*</th><td colspan="2"><input id="scsj" class="easyui-datebox" disabled="disabled" style="width: 200px;"></input></td></tr>
		    <tr>							<th>同意付费维修</th><td><input  type="checkbox"  disabled="disabled" id="isffwx" value="1" style="width: 20px;" /> </td><th>紧急程度</th><td colspan="2"><input id="jjcd" disabled="disabled"></input></td></tr>
		    
		    <tr><th rowspan="3">待修产品信息</th>	<th>款号*</th><td><input id="kh"  disabled="disabled" onBlur="checkKh(value)"></input></td><th>退回日期</th><td colspan="2" ><input id="thrq" disabled="disabled" class="easyui-datebox" style="width: 200px;"></input></td></tr>
		    <tr>								<th>供应商</th><td colspan="4"><input id="gys"  style="width: 200px;"></td></tr>
		  	<tr>							<th>问题描述*</th><td colspan="4"><textarea id="wtms" disabled="disabled" style="height:60px;width: 100%"></textarea></td></tr>
		    
		    <tr><th rowspan="4">物流信息</th>	<th>运输公司</th><td><input id="ysgs" disabled="disabled" class="easyui-combogrid" style="width: 200px;"></input></td><th>运单号</th><td colspan="2"><input id="ydh" disabled="disabled"></input></td></tr>
		    <tr>							<th>发货地址</th><td colspan="4"><input id="fhdz" disabled="disabled"></input></td></tr>
		    <tr>							<th>收货地址</th><td colspan="4"><input id="shdz" disabled="disabled"></input></td></tr>
		    <tr>							<th>收货人</th><td><input id="shr" disabled="disabled"></input></td><th>收货人联系电话</th><td  colspan="2"><input id="shrlxdh" disabled="disabled"></input></td></tr>
		    
		    <tr><th>备注信息</th> <td colspan="5"><textarea id="bzxx" disabled="disabled" style="height:100%;width:100%"></textarea></td> </tr>


		    <tr><th rowspan="14">品检判定</th>	<th colspan="5">问题主因(必填)</th></tr>
		    
		    
		    <tr>							<th>维修性质</th><td><select id="wxxz1" style="width:200px;"   disabled="disabled">
												<option value="0">  </option><option value="1">帮忙维修</option><option value="2">质量维修</option></select>
												</td><th>问题点</th><td colspan="2"><input id="wtd1"  disabled="disabled" class="easyui-combogrid" style="width:200px;"></input></td></tr>
		    <tr>							<th>起因</th><td><input id="qy1"  disabled="disabled" class="easyui-combogrid" style="width:200px;"></input></td><th>现象点</th><td colspan="2"><input id="xxd1"  disabled="disabled" class="easyui-combogrid" style="width:200px;"></input></td></tr>
		     <tr><th>部位描述</th><td colspan="4"><textarea id="wxbw" style="height:50px;width: 600px"></textarea></td></tr>
		    <tr>							<th colspan="5">问题次因(选填)</th></tr>
		    <tr>							<th>维修性质</th><td><select id="wxxz2" style="width:200px;"  disabled="disabled">
												<option value="0">  </option><option value="1">帮忙维修</option><option value="2">质量维修</option></select></td><th>问题点</th><td colspan="2"><input id="wtd2"  disabled="disabled" class="easyui-combogrid" style="width:200px;"></input></td></tr>
		    <tr>							<th>起因</th><td><input id="qy2" class="easyui-combogrid" style="width:200px;"  disabled="disabled"></input></td><th>现象点</th><td colspan="2"><input id="xxd2" class="easyui-combogrid"  disabled="disabled" style="width:200px;"></input></td></tr>
		    <tr>							<th colspan="5">判定结果</th></tr>
		    <tr>							<th>判定处理方式*</th><td><select id="pdclfs"  disabled="disabled" class="easyui-combobox" name="state" style="width:200px;" data-options="required:true" >
												<option value="0">  </option><option value="1">产品退仓</option><option value="2">不能维修，退回店铺</option><option value="3">可以维修</option></select></td><th>退仓处理结果</th><td colspan="2"><input id="tccljg" disabled="disabled" style="width:200px;"></input></td></tr>
		    <tr>							<th>责任部门</th><td><input id="zrbm"  disabled="disabled" style="width:200px;"></input></td><th>退货单号</th><td colspan="2"><input  type="text"   id="thdh" disabled="disabled"></input></td></tr>
		    <tr>							<th>检测异议</th><td colspan="4"><input id="jcyy" disabled="disabled"></input></td></tr>
		    <tr>							<th>维修方式</th><td><select id="nx" disabled="disabled" class="easyui-combobox" style="width:200px;"><option value="0" selected="selected">内修</option><option value="1">外修</option></select></td><th>计划维修天数</th><td colspan="2"><input id="jhwxts" disabled="disabled" style="width:200px;"></input></td></tr>
		    <tr>							<th>是否收费</th><td><select id="sfsf" disabled="disabled" class="easyui-combobox" style="width:200px;"><option value="0" selected="selected">否</option><option value="1">是</option></select></td><th>收费金额(元)</th><td colspan="2"><input id="wxjefw" disabled="disabled" style="width:200px;"></input></td></tr>
		    <tr>							<th>收费内容</th><td><input id="sfnr" disabled="disabled"></input></td><th>最终收费金额</th><td colspan="2"><input id="zzsfje" disabled="disabled"></input></td></tr>
		    <tr>							<th>品检判定备注</th><td colspan="5"><input id="pjpdbz" disabled="disabled"></input></td></tr>
		    <tr><th>维修信息</th><th>维修人</th><td><input id="wxr" disabled="disabled"></input></td> <th>维修时间</th> <td colspan="2"><input id="wxsj" disabled="disabled"></input></td> </tr>
		
		 
	    </table>
	        
	        <br></br>
		  <div>
			    <table class="intable">
				<tr><td width="auto">登记人</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="djr"/></td><td>登记时间</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="djsj"/></td><td>品检判定人</td><td><input id="pjpdr" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td><td>判定时间</td><td><input id="pjpdsj"  style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td></tr>
				<tr><td>维修确认人</td><td><input id="wxqrr" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td><td>确认时间</td><td><input id="qrsj" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td></tr> 
				<!-- <td>特退审批人</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="ttspr"/></td><td>审批时间</td><td><input readonly="readonly" style="background-color: #C1CDC1;width: 120" id="spsj"/></td> -->
				</table>
	        </div>
	     
	        
	        
	    </form>
	</div>
	<div >
	<jsp:include page="zbfh.jsp"></jsp:include>
    <jsp:include page="zbdy.jsp"></jsp:include>
   <jsp:include page="dpdy.jsp"></jsp:include>
   <jsp:include page="kdddy.jsp"></jsp:include>
   <jsp:include page="wxwc.jsp"></jsp:include>
 <jsp:include page="wxwc_gys.jsp"></jsp:include>
	           </div>
  </body>
 
</html>

