//登记信息初始化
   $(function(){
    		
    		$('#dpbm').combogrid({
    			panelWidth:430,
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
     //运输公司
     $(function(){
 		$('#ysgs').combogrid({
 			panelWidth:320,
 	 		mode:'remote',
 			idField:'mc',
 			textField:'mc',
 			url:'/gclm/rest/getYsgs/S2',
 			method:'post',
 			
 			columns:[[
 				{field:'bm',title:'编码',width:50},
 				{field:'mc',title:'名称',width:70},
 				{field:'lxdh',title:'联系电话',width:90},
 				{field:'lxr',title:'联系人',width:90},
 		
 			]]
 		});
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
     
     
     
     
     
     //日期控件格式化
     $(function(){
         $('#scsj').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });    
 
    	 var d,myDate;
    	  d = new Date();
    	  myDate = d.getFullYear() + "-";             //取年份
    	  myDate = myDate + (d.getMonth() + 1) + "-";//取月份
    	  myDate += d.getDate() + " ";         //取日期

         $('#thrq').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });   
         $('#thrq').datebox("setValue", myDate);
         })
 
       //款号校验   
      function checkKh(value){
    	  if(""==value){
    		  $.messager.alert("提示", "请输入款号");
    	  }else{ 
    		  $.post(	'rest/checkKh/'+value,
        		 {'params':value},
        		 function(newkh){	
        			 if("wu"==newkh){
        				 //$.messager.alert("提示", "款号不正确",icon:warning); 
        				 $.messager.alert("提示","款号错误","warning",function(){ 
	        				// var oInput = document.getElementById("kh");
			          	    //	oInput.focus();
        				 });  
        				//  $.messager.show(1, '款号错误，请重新输入', 2000);
        				 
			              	
        			 }else{
        			 document.getElementById("kh").value=newkh;
        			 }
        		 },
        		 'text'
        		 );	
    	  }
    	
       };

						//选择顾客维修 顾客维修信息可选
						function isGkwx() {
							if (document.getElementById("isgkwx").checked == true) {

								document.getElementById("vipkh").disabled = false;
								document.getElementById("gkxm").disabled = false;
								document.getElementById("gklxdh").disabled = false;
								$("#scsj").combogrid('enable');
								document.getElementById("isffwx").disabled = false;
							} else {
								document.getElementById("vipkh").disabled = true;
								document.getElementById("gkxm").disabled = true;
								document.getElementById("gklxdh").disabled = true;
								$("#scsj").combogrid('disable');
								document.getElementById("isffwx").disabled = true;
							}

						}