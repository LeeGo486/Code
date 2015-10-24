<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset= GBK  ">
    
    <title>维修登记详细</title>
    <link rel="stylesheet" type="text/css" href="/gclm/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/gclm/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="/gclm/jquery-easyui-1.3.1/demo/demo.css">
	<script type="text/javascript" src="/gclm/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="/gclm/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
     <script type="text/javascript">
     $(function(){
    		$('#dpbm').combogrid({
    			panelWidth:320,
    	 		mode:'remote',
    			idField:'depotid',
    			textField:'depotid',
    			url:'/gclm/rest/getFilterdp/S2',
    			method:'post',
    			onChange:function (idField){  
    				getdpvalue(idField); // 加载店铺相关信息
    			 },
    			columns:[[
    				{field:'depotid',title:'店铺编号',width:90},
    				{field:'dname',title:'店铺名称',width:160},
    				{field:'address',title:'地址',width:160},
    			]]
    		});
    	});
     /*
     $(function(){
 		$('#sldg').combogrid({
 			panelWidth:320,
 	 		mode:'remote',
 			idField:'telephone',
 			textField:'names',
 			
 			url:'/gclm/rest/getSldg/S2',
 			method:'post',
 			onChange:function (idField){  
 				//getdpvalue(idField); // 加载店铺相关信息
 				// var sldgs = eval("(" + sldgs + ")");
 				document.getElementById("dglxdh").value=idField;
 				
 			 },
 			columns:[[
 				{field:'employeeid',title:'导购编号',width:90},
 				{field:'names',title:'导购名称',width:90},
 				{field:'telephone',title:'联系电话',width:90},
 			]]
 		});
 	});
     
     */
     
     
     //获取店铺信息
     function getdpvalue(depotid)
     {
    	 var ldplx,pp;
		 
    	 $('#sldg').combogrid({
  			panelWidth:270,
  	 		mode:'remote',
  			idField:'telephone',
  			textField:'names',  	
  			
  			url:'/gclm/rest/getSldg/'+depotid,
  			method:'post',
  			onChange:function (idField){  
  				//getdpvalue(idField); // 加载店铺相关信息
  				// var sldgs = eval("(" + sldgs + ")");
  				document.getElementById("dglxdh").value=idField;
  				
  			 },
  			columns:[[
  				{field:'employeeid',title:'导购编号',width:90},
  				{field:'names',title:'导购名称',width:90},
  				{field:'telephone',title:'联系电话',width:90},
  			]]
  		});
    	 
		$.post(	'rest/getFilterdp/S2',
				{'depotid':depotid},function(queryfilter) {
					var shops = eval("(" + queryfilter + ")");
					if(null!=shops[0].dname){document.getElementById("dpmc").value=shops[0].dname;};
					if(null!=shops[0].address){document.getElementById("fhdz").value=shops[0].address;};
					if(null!=shops[0].r_name){document.getElementById("dzxm").value=shops[0].r_name;};
					
					if(null!=shops[0].Tel){document.getElementById("dzlxdh").value=shops[0].Tel;};
				      if (shops[0].m_type == "11")
				        {ldplx = "1";document.getElementById("dplx").value = "自营";}
				      else{ ldplx = "2";document.getElementById("dplx").value = "加盟";}
				     pp=shops[0].brandid;
				//     alert(pp+ldplx);
					
					 
								 	
				     $.post(	'rest/getWxcdp/S2',
								{'pp':pp,'ldplx':ldplx},function(wxc) {
									var wxcs = eval("(" + wxc + ")");
									if(null!=wxcs[0].wxcbm){document.getElementById("wxcbm").value=wxcs[0].wxcbm;};
									if(null!=wxcs[0].wxcmc){document.getElementById("wxcmc").value=wxcs[0].wxcmc;};
									
									$.post(	'rest/getFilterdp/S2',
											{'depotid':wxcs[0].wxcbm},function(queryfilter) {
												
												var shops = eval("(" + queryfilter + ")");
												if(null!=shops[0].address){document.getElementById("shdz").value=shops[0].address;};
												if(null!=shops[0].r_name){document.getElementById("shr").value=shops[0].r_name;};
												if(null!=shops[0].Tel){document.getElementById("shrlxdh").value=shops[0].Tel;};
												
												}, 'text').error(function() {
											$.messager.alert("提示", "选择店铺出错1");
										});	      
								}, 'text').error(function() {
							$.messager.alert("提示", "选择店铺出错2");
						});
					    
				}, 'text').error(function() {
			$.messager.alert("提示", "选择店铺出错3");
		});
	    
	}
     
     
     //  保存登记信息
     function saveMaintain(){
    	 var dpbm,dpmc,dplx,	dzxm,dzlxdh,	wxcbm,wxcmc	,sldg,dglxdh,isgkwx,		
    	 vipkh,gkxm,	gklxdh,scsj,	isffwx,jjcd,
    	 kh,thrq,wtms,
    	 ysgs,ydh,fhdz,shdz,shr,shrlxdh,bzxx;
    	 
    	 sldg = $('#sldg').combogrid('getText');
    	 dglxdh = document.getElementById("dglxdh").value;
    	 gkxm = document.getElementById("gkxm").value;
    	 scsj = document.getElementById("scsj").value;
    	 kh = document.getElementById("kh").value;
    	 wtms = document.getElementById("wtms").value;
    	 
    	/*
    	 if(""==sldg){
    		 
    		 $.messager.alert("提示", "受理导购不能为空");
    	 }else if(""==dglxdh){
    		 $.messager.alert("提示", "导购联系电话不能为空");
    	 }
    	 else if(""==gkxm){
    		 $.messager.alert("提示", "顾客姓名不能为空");
    	 }
    	 else if(""==scsj){
    		 $.messager.alert("提示", "售出时间不能为空");
    	 }
    	 else if(""==kh){
    		 $.messager.alert("提示", "款号不能为空");
    	 }
    	 else if(""==wtms){
    		 $.messager.alert("提示", "问题 描述不能为空");
    	 };
    	 */
     
    	 dpbm = $('#dpbm').combogrid('getText');;
    	 //lert(dpbm);
    	 dpmc = document.getElementById("dpmc").value;
    	 dplx = document.getElementById("dplx").value;
    	
    	 dzxm = document.getElementById("dzxm").value;
    	 dzlxdh = document.getElementById("dzlxdh").value;
    	
    	 wxcbm = document.getElementById("wxcbm").value;
    	 wxcmc = document.getElementById("wxcmc").value;
    	 
    	 //是否顾客维修
    	 if(document.getElementById("isgkwx").checked){
     		isgkwx = 1;
     	}else{isgkwx =0;};
     
    	 vipkh = document.getElementById("vipkh").value;
    	 gklxdh = document.getElementById("gklxdh").value;
    	 //是否付费维修
    	 if(document.getElementById("isffwx").checked){
     		isffwx = 1;
     	}else{isffwx =0;};
     	
    	 scsj =  $('#scsj').datebox('getValue'); 
    	 jjcd = document.getElementById("jjcd").value;
    	 thrq =  $('#thrq').datebox('getValue'); 
    	 ysgs = document.getElementById("ysgs").value;
    	 ydh = document.getElementById("ydh").value;
    	 //alert("ssss");
    	 fhdz = document.getElementById("fhdz").value;
    	 shdz = document.getElementById("shdz").value;
    	 shr = document.getElementById("shr").value;
    	 shrlxdh = document.getElementById("shrlxdh").value;
    	 bzxx = document.getElementById("bzxx").value;
    	 
    
    	 
    	var params={'dpbm':dpbm,'dpmc':dpmc,'dplx':dplx,	'dzxm':dzxm,'dzlxdh':dzlxdh,	'wxcbm':wxcbm,'wxcmc':wxcmc	,'sldg':sldg,'dglxdh':dglxdh,'isgkwx':isgkwx,		
    	    	 'vipkh':vipkh,'gkxm':gkxm,	'gklxdh':gklxdh,'scsj':scsj,	'isffwx':isffwx,'jjcd':jjcd,
    	    	 'kh':kh,'thrq':thrq,'wtms':wtms,
    	    	 'ysgs':ysgs,'ydh':ydh,'fhdz':fhdz,'shdz':shdz,'shr':shr,'shrlxdh':shrlxdh,'bzxx':bzxx};
    	 
    
    	 $.post(	'rest/saveRegister/S2',
        		 params,
        		 function(result){	},
        		 'text'
        		 ).error(function() {
					$.messager.alert("提示", "保存出错");
				});	
    	 
    	 
     };
     
     
     $(function(){
         $('#scsj').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });    
         })
     $(function(){
         $('#thrq').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });    
         })


 </script>
   
  <style type="text/css">
		label{
			width:120px;
			display:block;
		}
/*border:1px solid #fffffb; textarea {border:1px solid #fffffb;}
input {width: 100%;height: 100%;}
select {width: 100%;height: 100%;}
*/

table.gridtable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#000000;
    border-width: 1px;
    border-color: #666666; 
    border-collapse: collapse;
    width: 100%;
}
table.gridtable th {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #666666;
    background-color: #dedede;
    width: 130px;
}
table.gridtable td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #666666;
    background-color: #ffffff;
}


table.intable {
    font-family: verdana,arial,sans-serif;
    font-size:11px;
    color:#000000;
    border-width: 1px;
    border-color: #fffffb;
    border-collapse: collapse;
    width: 100%;
}
table.intable td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #fffffb;
    background-color: #fffffb;
}

tr.head {
border-color: red;
}
</style>

  </head>
  
  <body>
  
	<div style="background:#fafafa;padding:10px;width:800px;height:800px;">
	    <form id="baoxiu" method="post" novalidate>
	    <table class="gridtable">
		    <div id="dj">
		    <tr></tr>
		    <tr class="head" ><td colspan="3"></td><td><label for="wxdh">维修单号:</label></td><td colspan="2"></td></tr>
		     
		     <tr><th rowspan="3">店铺信息</th>	<th>店铺编码</th><td><select id="dpbm"></select> </td><th>店铺名称</th><td><input id="dpmc" class="easyui-validatebox" type="text"  "></input></td><td><input ID="dplx" style="width: 30px"></input> </td></tr>
		     <tr>							<th>店长姓名</th><td><input id="dzxm"></input></td><th>店长联系电话</th><td colspan="2"><input id="dzlxdh" ></input</td></tr>
		     <tr>							<th>维修仓编号</th><td><input id="wxcbm"></input></td><th>维修仓名称</th><td colspan="2"><input id="wxcmc"></input></td></tr>
		     
		     <tr><th rowspan="2">维修接单信息</th><th>受理导购*</th><td><input id="sldg"></input></td><th>导购联系电话*</th><td colspan="2"><input id="dglxdh"></input></td></tr>
		     <tr>		<th>顾客维修</th><td colspan="4"><input type="checkbox" id="isgkwx" value="1"> </input> </td></tr>
		     
		    <tr><th rowspan="3">顾客信息</th>	<th>VIP卡号</th><td><input id="vipkh"></input></td><th>顾客姓名*</th><td colspan="2"><input id="gkxm"></input></td></tr>
		    <tr>							<th>顾客联系电话</th><td><input id="gklxdh"></input></td><th>售出时间*</th><td colspan="2"><input id="scsj" class="easyui-datebox"></input></td></tr>
		    <tr>							<th>同意付费维修</th><td><input type="checkbox" id="isffwx" value="1"> </input> </td><th>紧急程度</th><td colspan="2"><input id="jjcd"></input></td></tr>
		    
		    <tr><th rowspan="2">待修产品信息</th>	<th>款号*</th><td><input id="kh"></input></td><th>退回日期</th><td colspan="2"><input id="thrq" class="easyui-datebox" style="width:100%;hight:100%;"></input></td></tr>
		    <tr>							<th>问题描述*</th><td colspan="4"><textarea id="wtms" style="height:60px;width: 580px"></textarea></td></tr>
		    
		    <tr><th rowspan="4">物流信息</th>	<th>运输公司</th><td><input id="ysgs"></input></td><th>运单号</th><td colspan="2"><input id="ydh"></input></td></tr>
		    <tr>							<th>发货地址</th><td colspan="4"><input id="fhdz"></input></td></tr>
		    <tr>							<th>收货地址</th><td colspan="4"><input id="shdz"></input></td></tr>
		    <tr>							<th>收货人</th><td><input id="shr"></input></td><th>收货人联系电话</th><td  colspan="2"><input id="shrlxdh"></input></td></tr>
		    
		    <tr><th>备注信息</th> <td colspan="5"><textarea id="bzxx" style="height:100%;width:100%"></textarea></td> </tr>
		</div>
		<div id="pd">
		    <tr><th rowspan="14">品检判定</th>	<th colspan="5">问题主因(必填)</th></tr>
		    <tr>							<th>维修性质</th><td></td><th>问题点</th><td colspan="2"></td></tr>
		    <tr>							<th>起因</th><td></td><th>现象点</th><td colspan="2"></td></tr>
		    <tr>							<th colspan="5">问题次因(选填)</th></tr>
		    <tr>							<th>维修性质</th><td></td><th>问题点</th><td colspan="2"></td></tr>
		    <tr>							<th>起因</th><td></td><th>现象点</th><td colspan="2"></td></tr>
		    <tr>							<th colspan="5">判定结果</th></tr>
		    <tr>							<th>判定处理方式*</th><td></td><th>退仓处理结果</th><td colspan="2"></td></tr>
		    <tr>							<th>责任部门</th><td></td><th>退货单号</th><td colspan="2"></td></tr>
		    <tr>							<th>检测异议</th><td colspan="4"></td></tr>
		    <tr>							<th>特修</th><td></td><th>计划维修天数</th><td colspan="2"></td></tr>
		    <tr>							<th>是否收费</th><td></td><th>收费金额(元)</th><td colspan="2"></td></tr>
		    <tr>							<th>收费内容</th><td colspan="4"></td></tr>
		    <tr>							<th>品检判定备注</th><td colspan="4"></td></tr>
		    <tr><th>维修信息</th><th>维修人</th><td></td> <th>维修时间</th> <td colspan="2"></td> </tr>
		</div>      
	    </table>
	        
	        
	        <div></div>
	        
	        <div>
	            <a id="button" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveMaintain()">登记</a>
	            
	            
	            <%--<input type="submit" value="Submit" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveMaintain()">
	        
	        
	        --%></div>
	    </form>
	</div>
  </body>
 
</html>
