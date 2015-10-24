<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset= GBK  ">
    <script language="javascript" src="cm/register/LodopFuncs.js"></script>
<object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0> 
       <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
    <title>维修登记详细</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/jquery-easyui-1.3.1/demo/demo.css">
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=path%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/maintain.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/maintain.css">
<script type="text/javascript">
     $(function(){
    		$('#dpbm').combogrid({
    			panelWidth:430,
    	 		mode:'remote',
    			idField:'depotid',
    			textField:'depotid',
    			url:'<%=path%>/rest/getFilterdp/S2',
    			method:'post',
    			onChange:function (idField){  
    				getdpvalue(idField); // 加载店铺相关信息
    			 },
    			columns:[[
    				{field:'depotid',title:'店铺编号',width:90},
    				{field:'dname',title:'店铺名称',width:160},
    				{field:'address',title:'地址',width:160}
    			]]
    		});

    		$('#ysgs').combogrid({
      			panelWidth:320,
      	 		mode:'remote',
      			idField:'mc',
      			textField:'mc',
      			url:'rest/getYsgs/S2',
      			method:'post',
      			
      			columns:[[
      				{field:'bm',title:'编码',width:50},
      				{field:'mc',title:'名称',width:70},
      				{field:'lxdh',title:'联系电话',width:90},
      				{field:'lxr',title:'联系人',width:90}
      		
      			]]
      		});
      		
      		
      		//总部发货 运输公司
      		$('#zbfh_ysgs').combogrid({
      			panelWidth:310,
      	 		mode:'remote',
      			idField:'mc',
      			textField:'mc',
      			url:'rest/getYsgs/S2',
      			method:'post',
      			columns:[[
      				{field:'bm',title:'编码',width:50},
      				{field:'mc',title:'名称',width:70},
      				{field:'lxdh',title:'联系电话',width:90},
      				{field:'lxr',title:'联系人',width:90}
      			]]
      		});
      		
      		//维修时间2
         	 var d,myDate;
         	  d = new Date();
         	  myDate = d.getFullYear() + "-";            
         	  myDate = myDate + (d.getMonth() + 1) + "-";
         	  myDate += d.getDate() + " ";     
         	  
      	  $('#wxsj2').datebox({
              formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
              parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
              });  
      	//售出时间
       	 $('#scsj').datebox({
              formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
              parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); },
              onSelect: function(date){
             	 if(compareDate($('#scsj').datebox('getValue'),$('#thrq').datebox('getValue'))){
             		 $.messager.alert("提示", "请检查售出时间必在退回日期之前");return;
             	 }
              }

              });    
       	 //退回日期
       	  $('#thrq').datebox({
               formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
               parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
       	  }); 
 	      	 var d,date;
 	     	  d = new Date();
 	     	  date = d.getFullYear() + "-";            
 	     	  date = date + (d.getMonth() + 1) + "-";
 	     	  date += d.getDate() + " ";     
 	     	$('#thrq').datebox('setValue',date)
      	
      	  

      	//品检判定   
          //问题主因  级联
        		$('#wxxz1').combobox({
        			onChange:function (id){  
        				 $('#wtd1').combogrid({
        			  			panelWidth:200,
        			  	 		mode:'remote',
        			  			idField:'fcode',
        			  			textField:'fcontent',  	
        			  			url:'rest/getWtd/'+id,
        			  			method:'post',
        			  			onChange:function (idField){  
        			  				$('#qy1').combogrid({
        		    			  			panelWidth:200,
        		    			  	 		mode:'remote',
        		    			  			idField:'fcode',
        		    			  			textField:'fcontent',  	
        		    			  			url:'rest/getQy/'+idField,
        		    			  			method:'post',
        		    			  			onChange:function (idField){  
        		    			  				$('#xxd1').combogrid({
        	    		    			  			panelWidth:200,
        	    		    			  	 		mode:'remote',
        	    		    			  			idField:'fcode',
        	    		    			  			textField:'fcontent',  	
        	    		    			  			url:'rest/getXxd/'+idField,
        	    		    			  			method:'post',
        	    		    			  			columns:[[
        	    		    			  				{field:'fcode',title:'',width:90},
        	    		    			  				{field:'fcontent',title:'',width:90}
        	    		    			  			]]
        	    		    			  		});
        		    			  				
        		    			  			 },
        		    			  			columns:[[
        		    			  				{field:'fcode',title:'',width:90},
        		    			  				{field:'fcontent',title:'',width:90}
        		    			  			]]
        		    			  		});
        		    				
        			  				
        			  			 },
        			  			columns:[[
        			  				{field:'fcode',title:'',width:90},
        			  				{field:'fcontent',title:'',width:90}
        			  			]]
        			  		});
        			 }
        		});

         //问题次因  级联
            		$('#wxxz2').combobox({
            			onChange:function (id){  
            				 $('#wtd2').combogrid({
            			  			panelWidth:200,
            			  	 		mode:'remote',
            			  			idField:'fcode',
            			  			textField:'fcontent',  	
            			  			url:'rest/getWtd/'+id,
            			  			method:'post',
            			  			onChange:function (idField){  
            			  				$('#qy2').combogrid({
            		    			  			panelWidth:200,
            		    			  	 		mode:'remote',
            		    			  			idField:'fcode',
            		    			  			textField:'fcontent',  	
            		    			  			url:'rest/getQy/'+idField,
            		    			  			method:'post',
            		    			  			onChange:function (idField){  
            		    			  				$('#xxd2').combogrid({
            	    		    			  			panelWidth:200,
            	    		    			  	 		mode:'remote',
            	    		    			  			idField:'fcode',
            	    		    			  			textField:'fcontent',  	
            	    		    			  			url:'rest/getXxd/'+idField,
            	    		    			  			method:'post',
            	    		    			  			columns:[[
            	    		    			  				{field:'fcode',title:'',width:90},
            	    		    			  				{field:'fcontent',title:'',width:90}
            	    		    			  			]]
            	    		    			  		});
            		    			  				
            		    			  			 },
            		    			  			columns:[[
            		    			  				{field:'fcode',title:'',width:90},
            		    			  				{field:'fcontent',title:'',width:90}
            		    			  			]]
            		    			  		});
            		    				
            			  				
            			  			 },
            			  			columns:[[
            			  				{field:'fcode',title:'',width:90},
            			  				{field:'fcontent',title:'',width:90}
            			  			]]
            			  		});
            				
            				
            				
            			 }
            			
            		});

                	
			           
			     //维修人 
                	$('#wxr2').combogrid({
          				panelWidth:200,
          	  	 		mode:'remote',
          	  			idField:'fcode',
          	  			textField:'fcontent',  
          	  			url:'rest/getTybmb/wxry',
          	  			method:'post',
          	  			columns:[[
          	  				{field:'fcode',title:'',width:90},
          	  				{field:'fcontent',title:'',width:90}
          	  			]]
          			});
                	
                	//退仓处理结果
              			$('#tccljg').combogrid({
              				panelWidth:200,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'rest/getTybmb/tccljg',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});
              		//责任部门
              			$('#zrbm').combogrid({
              				panelWidth:200,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'rest/getTybmb/zrbm',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});
              	 //计划维修天数
              			$('#jhwxts').combogrid({
              				panelWidth:200,
              	  	 		mode:'remote',
              	  			idField:'fcode',
              	  			textField:'fcontent',  
              	  			url:'rest/getTybmb/jhwxts',
              	  			method:'post',
              	  			columns:[[
              	  				{field:'fcode',title:'',width:90},
              	  				{field:'fcontent',title:'',width:90}
              	  			]]
              			});

              	//判定处理方式
                   		$('#pdclfs').combobox({
                   			onChange:function (id){
                   				document.getElementById("pjpdbz").disabled=false;
                   				if(id==1){
                   					$("#tccljg").combogrid('enable');
                   					//$("#thdh").combogrid('enable');
                   					document.getElementById("thdh").disabled=true;
                   					$("#nx").combobox('disable');
                   					$("#sfsf").combobox('disable');
                   					$("#jhwxts").combobox('disable');
                   					//document.getElementById("sfje").disabled=true;
                   					//document.getElementById("sfnr").disabled=true;
                   				};
                   				if(id==2){
                   					$("#tccljg").combogrid('disable');
                   					document.getElementById("thdh").disabled=true;
                   					$("#nx").combobox('disable');
                   					$("#sfsf").combobox('disable');
                   					$("#jhwxts").combobox('disable');
                   					//document.getElementById("sfje").disabled=true;
                   					//document.getElementById("sfnr").disabled=true;
                   				};
                   				if(id==3){//可以维修
                   					$("#tccljg").combogrid('disable');
                   					document.getElementById("thdh").disabled=true;
                   					$("#nx").combobox('enable');
                   					$("#sfsf").combobox('enable');
                   					$("#jhwxts").combobox('enable');
                   					//document.getElementById("sfje").disabled=false;
                   					//document.getElementById("sfnr").disabled=false;
                   				}
                   			}
                   		});
              
               //是否收费
                   		$('#sfsf').combobox({
                   			onChange:function (id){  
                   				if(id==1){
                   					document.getElementById("sfje").disabled=false;
                   					document.getElementById("sfnr").disabled=false;
                   				}
                   				if(id==0){
                   					document.getElementById("sfje").disabled=true;
                   					document.getElementById("sfnr").disabled=true;
                   				}
                   			}
                   		})   	
 	
         
 	});
     

     
     //获取店铺信息
     function getdpvalue(depotid)
     {
    	 var ldplx,pp;
		 
    	 $('#sldg').combogrid({
  			panelWidth:290,
  	 		mode:'remote',
  			idField:'telephone',
  			textField:'names',  	
  			
  			url:'<%=path%>/rest/getSldg/'+depotid,
  			method:'post',
  			onChange:function (idField){  
  				//getdpvalue(idField); // 加载店铺相关信息
  				// var sldgs = eval("(" + sldgs + ")");
  				document.getElementById("dglxdh").value=idField;
  				
  			 },
  			columns:[[
  				{field:'employeeid',title:'导购编号',width:90},
  				{field:'names',title:'导购名称',width:90},
  				{field:'telephone',title:'联系电话',width:90}
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
					
					 
								 
				//店铺对应维修仓信息
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
											$.messager.alert("提示", "选择店铺出错");
										});	      
								}, 'text').error(function() {
							$.messager.alert("提示", "选择店铺出错");
						});
					    
				}, 'text').error(function() {
			$.messager.alert("提示", "选择店铺出错");
		});
	    
	}
     
     
     
 
      </script>
   
  <style type="text/css">
  
</style>

  </head>
  
  <body>
  
  
 
 
  <div  id="header">
    <a id="save0123456" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveMaintain(id,$('#pdclfs').combobox('getValue'))">登记判定</a>
 <%--<a id="printdp" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="dpPrint()">店铺打印</a>
 <a id="printzb" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="zbPrint()">总部打印</a>
 <a id="printkdd" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="kddPrint()">快递单打印</a>  
	  --%>
	  <input type="text" readonly="readonly" value="登记判定" style="text-align:right;font-size: 17pt;font-family:'微软雅黑';" id="zt" width="100%" height="100%"/>
	  
	  </div>    
	<div style="background:#fafafa;padding-top:40px">
	    <form id="ff" method="post" >
	    <table class="gridtable">
		    <tr class="head" ><td colspan="3"><input id="guid" type="hidden" value="<%out.print(request.getParameter("guid"));%>"></input></td><td><label >维修单号:</label></td><td colspan="2"><input id="wxdh" disabled="disabled"></input></td></tr>
		     
		     <tr><th rowspan="3" >店铺信息</th>	<th>店铺编码</th><td width="200"><select id="dpbm" style="width: 200px;border:1px solid #fffffb;" class="easyui-combogrid"></select> </td><th width="170">店铺名称</th><td><input width="170px" id="dpmc" type="text"></input></td><td width="30"><input ID="dplx" width="30" disabled="disabled"></input> </td></tr>
		     <tr>							<th>店长姓名</th><td><input id="dzxm"></input></td><th>店长联系电话</th><td colspan="2"><input id="dzlxdh" ></input</td></tr>
		     <tr>							<th>维修仓编号</th><td><input id="wxcbm" disabled="disabled"></input></td><th>维修仓名称</th><td colspan="2"><input id="wxcmc" disabled="disabled"></input></td></tr>
		     
		     <tr><th rowspan="2">维修接单信息</th><th>受理导购*</th><td><input id="sldg" style="width: 200px;" class="easyui-combogrid"></input></td><th>导购联系电话*</th><td colspan="2"><input id="dglxdh"></input></td></tr>
		     <tr>		<th>顾客维修</th><td colspan="4"><input type="checkbox" id="isgkwx" value="1" style="width: 20px;" checked="checked" onchange="isGkwx()" />  </td></tr>
		     
		    <tr><th rowspan="3">顾客信息</th>	<th>VIP卡号</th><td><input id="vipkh" ></input></td><th>顾客姓名*</th><td colspan="2"><input id="gkxm"  ></input></td></tr>
		    <tr>							<th>顾客联系电话</th><td><input id="gklxdh"></input></td><th>售出时间*</th><td colspan="2"><input id="scsj" class="easyui-datebox"  style="width: 200px;"></input></td></tr>
		    <tr>							<th>同意付费维修</th><td><input type="checkbox" id="isffwx" value="1" style="width: 20px;"  /> </td><th>紧急程度</th><td colspan="2"><select id="jjcd" class="easyui-combobox" style="width:200px;" >
												<option value="00"> </option><option value="01">一般</option><option value="02">紧急</option><option value="03">非常急</option></select></td></tr>
		    
		    <tr><th rowspan="2">待修产品信息</th>	<th>款号*</th><td><input id="kh" onBlur="checkKh(value)"></input></td><th>退回日期</th><td colspan="2" ><input id="thrq" class="easyui-datebox" style="width: 200px;"></input></td></tr>
		    <tr>							<th>问题描述*</th><td colspan="4"><textarea id="wtms" style="height:60px;width: 600px"></textarea></td></tr>
		    
		    <tr><th rowspan="4">物流信息</th>	<th>运输公司</th><td><input id="ysgs"  style="width: 200px;" class="easyui-combogrid"></input></td><th>运单号</th><td colspan="2"><input id="ydh"></input></td></tr>
		    <tr>							<th>发货地址</th><td colspan="4"><input id="fhdz"></input></td></tr>
		    <tr>							<th>收货地址</th><td colspan="4"><input id="shdz"></input></td></tr>
		    <tr>							<th>收货人</th><td><input id="shr"></input></td><th>收货人联系电话</th><td  colspan="2"><input id="shrlxdh"></input></td></tr>
		    
		    <tr><th>备注信息</th> <td colspan="5"><textarea id="bzxx" style="height:100%;width:100%"></textarea></td> </tr>


		    <tr><th rowspan="14">品检判定</th>	<th colspan="5">问题主因(必填)</th></tr>
		    
		    
		    <tr>							<th>维修性质</th><td><select id="wxxz1" class="easyui-combobox"   name="state" style="width:200px;" >
												<option value="0">  </option><option value="1">帮忙维修</option><option value="2">质量维修</option></select>
												</td><th>问题点</th><td colspan="2"><input id="wtd1" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr >							<th>起因</th><td><input id="qy1"   class="easyui-combogrid" style="width:200px;"></input></td><th>现象点</th><td colspan="2"><input id="xxd1" class="easyui-combogrid" style="width:200px;"  ></input></td></tr>
		    <tr>							<th colspan="5">问题次因(选填)</th></tr>
		    <tr>							<th>维修性质</th><td><select id="wxxz2"  class="easyui-combobox"  style="width:200px;"  >
												<option value="0">  </option><option value="1">帮忙维修</option><option value="2">质量维修</option></select></td><th>问题点</th><td colspan="2"><input id="wtd2" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr>							<th>起因</th><td><input id="qy2"   class="easyui-combogrid" style="width:200px;"></input></td><th>现象点</th><td colspan="2"><input id="xxd2" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr>							<th colspan="5">判定结果</th></tr>
		    <tr>							<th>判定处理方式*</th><td><select id="pdclfs" class="easyui-combobox" name="state" style="width:200px;">
												<option value="0">  </option><option value="1">产品退仓</option><option value="2">不能维修，退回店铺</option><option value="3">可以维修</option></select></td><th>退仓处理结果</th><td colspan="2"><input id="tccljg" class="easyui-combogrid" style="width:200px;" ></input></td></tr>
		    <tr>							<th>责任部门</th><td><input id="zrbm" style="width:200px;"  class="easyui-combogrid"></input></td><th>退货单号</th><td colspan="2"><input  type="text" style="width:200px;"  id="thdh" disabled="disabled"></input></td></tr>
		    <tr>							<th>检测异议</th><td colspan="4"><input id="jcyy" ></input></td></tr>
		    <tr>							<th>维修方式</th><td><select id="nx" class="easyui-combobox" disabled="disabled" style="width:200px;" ><option value="0" >内修</option><option value="1"  selected="selected">外修</option></select></td><th>计划维修天数</th><td colspan="2"><input id="jhwxts" disabled="disabled" style="width:200px;" class="easyui-combogrid"></input></td></tr>
		    <tr>							<th>是否收费</th><td><select id="sfsf" class="easyui-combobox" disabled="disabled" style="width:200px;" ><option value="0" selected="selected">否</option><option value="1">是</option></select></td><th>收费金额(元)</th><td colspan="2"><input id="sfje" type="text" disabled="disabled"></input></td></tr>
		    <tr>							<th>收费内容</th><td colspan="4"><input id="sfnr" type="text" disabled="disabled" width="100%"></input></td></tr>
		    <tr>							<th>品检判定备注</th><td colspan="4"><input id="pjpdbz" disabled="disabled" width="100%"></input></td></tr>
		    <tr><th>维修信息</th><th>维修人</th><td><input id="wxr" disabled="disabled"></input></td> <th>维修时间</th> <td colspan="2"><input id="wxsj" disabled="disabled"></input></td> </tr>
	    
	    </table>
	        
	        <br/><br/>
	        <div>
			    <table class="intable">
				<tr><td width="auto">登记人</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="djr"/></td><td>登记时间</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="djsj"/></td><td>品检判定人</td><td><input id="pjpdr" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td><td>判定时间</td><td><input id="pjpdsj"  style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td></tr>
				<tr><td>维修确认人</td><td><input id="wxqrr" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td><td>确认时间</td><td><input id="qrsj" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td></tr> 
				<!-- <td>特退审批人</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="ttspr"/></td><td>审批时间</td><td><input readonly="readonly" style="background-color: #C1CDC1;width: 120" id="spsj"/></td> -->
				
				</table>
	        </div>
	        
	    </form>
	    
	</div>
	
<div>
<jsp:include page="zbfh.jsp"></jsp:include>
   <jsp:include page="zbdy.jsp"></jsp:include>
   <jsp:include page="dpdy.jsp"></jsp:include>
   <jsp:include page="kdddy.jsp"></jsp:include>
   <jsp:include page="wxwc.jsp"></jsp:include>
 </div>
 
  </body>
 
</html>
