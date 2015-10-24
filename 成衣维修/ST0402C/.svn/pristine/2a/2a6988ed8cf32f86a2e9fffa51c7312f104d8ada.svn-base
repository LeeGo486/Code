<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String viewFlag = request.getParameter("viewFlag");
String status = request.getParameter("status");
String closed = request.getParameter("closed");
String btn = request.getParameter("btn");
String QueryListurl = path+"/cm/register/QueryList.jsp?status="+status+"&closed="+closed;
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
 
  /*function initForm(){
  	var status = $('#status').attr('value');
  	
  	alert($('#path').attr('value')+'/cm/register/QueryList.jsp?status='+$('#status').attr('value'));
  	$("#listInfo").attr('src',$('#path').attr('value')+'/cm/register/QueryList.jsp?status='+$('#status').attr('value'));
  }*/
  


	 function getLib(){
		var url =  '<%=QueryListurl%>';
		 
		$('#mian').tabs('select','列表');
		//$("#"+tabPanel).tabs('select',"首页");  
		      var tab = $('#mian').tabs('getSelected');       
		        $('#mian').tabs('update',{  
		        tab:tab,  
		        options:{  
		           title:'列表',  
		           style:{padding:'1px'},  
		       //href:URL, // 使用href会导致页面加载两次，所以使用content代替  
		           content:'<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%"></iframe>',  
		           closable:false,  
		       fit:true,  
		       selected:true  
		        }  
		   });  

		}
  function listDbOnclick(guid,zt){
  	var viewFlag = $('viewFlag').attr('value');
  	if(viewFlag=="1"){
  		$("#detailInfo").attr('src',$('#path').attr('value')+'/cm/register/querydetail_noable.jsp?guid='+guid);
  	}else{
  		if(zt==0){
			$("#detailInfo").attr('src',$('#path').attr('value')+'/cm/register/querydetail_register.jsp?guid='+guid+'&zt='+zt+'&btn='+'<%=btn%>');
		}else if(zt==1){
			$("#detailInfo").attr('src',$('#path').attr('value')+'/cm/register/querydetail_pjpd.jsp?guid='+guid+'&zt='+zt+'&btn='+'<%=btn%>');
		}else if(zt==3||zt==4||zt==5||zt==7||zt==14){
			$("#detailInfo").attr('src',$('#path').attr('value')+'/cm/register/querydetail_pjpd2.jsp?guid='+guid+'&zt='+zt+'&btn='+'<%=btn%>');
		}else {
			$("#detailInfo").attr('src',$('#path').attr('value')+'/cm/register/querydetail_noable.jsp?guid='+guid+'&zt='+zt+'&btn='+'<%=btn%>');
		}
  		
  	}	

  	$('#mian').tabs('select','详细');
  	$("#hosendbill").attr('src',$('#path').attr('value')+'/web/head-office-send-bill!showHOSendBill?id='+guid);
  	$("#appraise").attr('src',$('#path').attr('value')+'/web/appraise-view!getAppraiseInfo?id='+guid);
  	$("#operateRecord").attr('src',$('#path').attr('value')+'/cm/cmOperateRecord.jsp?zbguid='+guid);
  }
  
  function openRegister(){
  	$("#detailInfo").attr('src',$('#path').attr('value')+'/cm/register/querydetail_register.jsp');
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
  
  <body>
    	<input type="hidden" id="path" value="<%=path%>">
    	<input type="hidden" id="status" value="<%=status%>">
    	<input type="hidden" id="closed" value="<%=closed%>">
    	<input type="hidden" id="viewFlag" value="<%=viewFlag%>">
  		<input type="hidden" id="btn" value="<%=btn%>">
		<div id="mian" class="easyui-tabs" data-options="fit:true,border:false" >
			<div id="tab1" title="列表" style="padding:20px;overflow:hidden;"> 
				<iframe id="listInfo" src="<%=path%>/cm/register/QueryList.jsp?status=<%=status%>&closed=<%=closed%>" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
			<div id="tab2" title="详细" data-options="closable:false" style="overflow:hidden;padding:5px;">
				<iframe id="detailInfo" src="" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
		<%-- 	<div id="tab3" title="总部发货单"  data-options="closable:false" style="overflow:hidden;padding:5px;">
				<iframe id="hosendbill" src="<%=path%>/cm/headOfficeSendBill.jsp" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div> --%>
			<div id="tab4" title="评价信息" data-options="closable:false" style="overflow:hidden;padding:5px;">
				<iframe id="appraise" src="<%=path%>/web/appraise-view!getAppraiseInfo?id=-1" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
		<%--<div id="tab5" title="操作记录" data-options="closable:false" style="overflow:hidden;padding:5px;">
				<iframe id="operateRecord" src="<%=path%>/cm/cmOperateRecord.jsp" scrolling="auto" width="100%" height="100%" frameborder="0"></iframe>
			</div>
		--%>
		</div>
		
  </body>
</html>
