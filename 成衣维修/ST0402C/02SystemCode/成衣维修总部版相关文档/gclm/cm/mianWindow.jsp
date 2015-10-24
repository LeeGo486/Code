<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String viewFlag = request.getParameter("viewFlag");
String status = request.getParameter("status");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>成衣维修主界面</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/cmcommon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/src/jquery.parser.js"></script>
	

  </head>
  <script type="text/javascript">
  function initForm(){
  	document.frames['listInfo'].location.href=$('path').attr('value')+'/cm/register/QueryList.jsp'+'?status='+status;
  	document.frames['detailInfo'].location.href=$('path').attr('value')+'/cm/register/querydetail_noalble.jsp?guid=-1&zt=0';
  	document.frames['hosendbill'].location.href=$('path').attr('value')+'/cm/headOfficeSendBill.jsp';
  	document.frames['appraise'].location.href=$('path').attr('value')+'/cm/cmAppraiseView.jsp';
  	document.frames['operateRecord'].location.href=$('path').attr('value')+'/cm/cmOperateRecord.jsp';
  }
  
  function listOnclick(guid,zt){
  		
  }
  
  function listDbOnclick(guid,zt){
  	var viewFlag = $('viewFlag').attr('value');
  	if(viewFlag=="1"){
  		document.frames['detailInfo'].location.href=$('path').attr('value')+'/cm/register/querydetail_noalble.jsp?guid='+guid;
  	}else{
  		if(zt==0){
			document.frames['detailInfo'].location.href=$('path').attr('value')+'/cm/register/querydetail_register.jsp?guid='+guid+'&zt='+zt;
		}else if(zt==1){
			document.frames['detailInfo'].location.href=$('path').attr('value')+'/cm/register/querydetail_pjpd.jsp?guid='+guid+'&zt='+zt;
		}else if('2,3,4,5,6'.indexOf(zt)){
			document.frames['detailInfo'].location.href=$('path').attr('value')+'/cm/register/querydetail_pjpd2.jsp?guid='+guid+'&zt='+zt;
		}else {
			document.frames['detailInfo'].location.href=$('path').attr('value')+'/cm/register/querydetail_noalble.jsp?guid='+guid+'&zt='+zt;
		}
  		$('#main').tabs('select','Tab2');
  		document.frames['hosendbill'].location.href=$('path').attr('value')+'/web/head-office-send-bill!showHOSendBill?id='+guid;
  		document.frames['appraise'].location.href=$('path').attr('value')+'/web/c-m-appraise-view!getAppraiseInfo?id='+guid;
  		document.frames['operateRecord'].location.href=$('path').attr('value')+'/web/c-m-operate-record!queryCMOperateRecord?zbguid='+guid;
  	}		
  }
  
  function openRegister(){
  	document.frames['detailInfo'].location.href=$('path').attr('value')+'/cm/register/querydetail_register.jsp';
  }
  
  function pjConfirm(){
  
  }
  
  function maintanceComplete(){
  
  }
  
  function HOSend(){
  
  }
  function pichSend(){
  }
  function shopPrint(){
  
  }
  function HOPrint(){
  
  }
  
  function expressPrint(){
  }
  </script>
  
  <body onload="initForm()">
    	<input type="hidden" id="path" value="<%=path%>">
    	<input type="hidden" id="status" value="<%=status%>">
    	<input type="hidden" id="viewFlag" value="<%=viewFlag%>">
    	<div style="height:32;overflow:hidden;" >
				&nbsp;
		  <button class=btn_common onmouseover="this.className='btn_common_on'" onmouseout="this.className='btn_common'" onclick="openRegister()">维修登记</button>&nbsp;	 
		  <button class=btn_common onmouseover="this.className='btn_common_on'" onmouseout="this.className='btn_common'" onclick="pjConfirm()">品检判定</button>	&nbsp; 
		  <button class=btn_common onmouseover="this.className='btn_common_on'" onmouseout="this.className='btn_common'" onclick="maintanceComplete()">维修完成</button>	&nbsp; 
		  <button class=btn_common onmouseover="this.className='btn_common_on'" onmouseout="this.className='btn_common'" onclick="HOSend()">总部发货</button>&nbsp; 
		  <button class=btn_common onmouseover="this.className='btn_common_on'" onmouseout="this.className='btn_common'" onclick="pichSend()">批量发货</button>&nbsp; 
		  <button class=btn_common onmouseover="this.className='btn_common_on'" onmouseout="this.className='btn_common'" onclick="shopPrint()">店铺打印</button> &nbsp;
		  <button class=btn_common onmouseover="this.className='btn_common_on'" onmouseout="this.className='btn_common'" onclick="HOPrint()">总部打印</button> &nbsp;
		  <button class=btn_common onmouseover="this.className='btn_common_on'" onmouseout="this.className='btn_common'" onclick="expressPrint()">快递单打印</button>
		</div>
		
		<div id="mian" class="easyui-tabs" data-options="fit:true,border:false" >
			<div id="tab1" title="列表" style="padding:20px;overflow:hidden;"> 
				
				<iframe id="listInfo" src="" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
			
			
			<div id="tab2" title="详细" data-options="iconCls:'icon-reload',closable:true" style="overflow:hidden;padding:5px;">
				<iframe id="detailInfo" src="<%=path%>/cm/headOfficeSendBill.jsp" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
			<div id="tab3" title="总部发货单"  data-options="iconCls:'icon-reload',closable:true" style="overflow:hidden;padding:5px;">
				<iframe id="hosendbill" src="<%=path%>/cm/headOfficeSendBill.jsp" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
			<div id="tab4" title="评价信息" data-options="iconCls:'icon-reload',closable:true" style="overflow:hidden;padding:5px;">
				<iframe id="appraise" src="<%=path%>/cm/headOfficeSendBill.jsp" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
			<div id="tab5" title="操作记录" data-options="iconCls:'icon-reload',closable:true" style="overflow:hidden;padding:5px;">
				<iframe id="operateRecord" src="<%=path%>/cm/headOfficeSendBill.jsp" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
			
		</div>
		
  </body>
</html>
