 
alert("sjhg");
     //回调店铺相关信息
     function getdpvalue(depotid)
     {
    	 var ldplx,pp;
    	 alert("sssss");
    	 $('#sldg').combogrid({
  			panelWidth:290,
  	 		mode:'remote',
  			idField:'telephone',
  			textField:'names',  	
  			
  			url:'/gclm/rest/getSldg/'+depotid,
  			method:'post',
  			onChange:function (idField){  
  				//getdpvalue(idField); // 閸旂姾娴囨惔妤呮懙閻╃鍙ф穱鈩冧紖
  				// var sldgs = eval("(" + sldgs + ")");
  				document.getElementById("dglxdh").value=idField;
  				
  			 },
  			columns:[[
  				{field:'employeeid',title:'编号',width:90},
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
				    
					if(null!=shops[0].m_type){document.getElementById("dplx").value=shops[0].m_type;};
				    if (shops[0].m_type == "11")    
				    {ldplx = "1";document.getElementById("dplx").value = "自营";}  
				    else{ ldplx = "2";document.getElementById("dplx").value = "加盟";}
				     pp=shops[0].brandid;
				//     alert(pp+ldplx);
					
					 
								 
				//获取对应维修仓信息
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
											$.messager.alert("提示", "维修仓信息获取失败");
										});	      
								}, 'text').error(function() {
							$.messager.alert("提示", "维修仓信息获取失败");
						});
					    
				}, 'text').error(function() {
			$.messager.alert("提示", "店铺信息获取失败");
		});
	    
	}
     
     
 
     $(function(){
         $('#scsj').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });    
         })
     $(function(){
    	 var d,myDate;
    	  d = new Date();
    	  myDate = d.getFullYear() + "-";            

    	  //格式化日期 	  myDate = myDate + (d.getMonth() + 1) + "-";
    	  //閸欐牗婀�禒锟�    	  myDate += d.getDate() + " ";         
    	  //閸欐牗妫╅張锟�
         })
		    

 //品检判定内容初始化
 
 
 //维修性质级联下拉
  $(function(){
    		$('#wxxz1').combobox({
    			onChange:function (id){  
    				 $('#wtd1').combogrid({
    			  			panelWidth:200,
    			  	 		mode:'remote',
    			  			idField:'fcode',
    			  			textField:'fcontent',  	
    			  			url:'/gclm/rest/getWtd/'+id,
    			  			method:'post',
    			  			onChange:function (idField){  
    			  				$('#qy1').combogrid({
    		    			  			panelWidth:200,
    		    			  	 		mode:'remote',
    		    			  			idField:'fcode',
    		    			  			textField:'fcontent',  	
    		    			  			url:'/gclm/rest/getQy/'+idField,
    		    			  			method:'post',
    		    			  			onChange:function (idField){  
    		    			  				$('#xxd1').combogrid({
    	    		    			  			panelWidth:200,
    	    		    			  	 		mode:'remote',
    	    		    			  			idField:'fcode',
    	    		    			  			textField:'fcontent',  	
    	    		    			  			url:'/gclm/rest/getXxd/'+idField,
    	    		    			  			method:'post',
    	    		    			  			columns:[[
    	    		    			  				{field:'fcode',title:'',width:90},
    	    		    			  				{field:'fcontent',title:'',width:90},
    	    		    			  			]]
    	    		    			  		});
    		    			  				
    		    			  			 },
    		    			  			columns:[[
    		    			  				{field:'fcode',title:'',width:90},
    		    			  				{field:'fcontent',title:'',width:90},
    		    			  			]]
    		    			  		});
    		    				
    			  				
    			  			 },
    			  			columns:[[
    			  				{field:'fcode',title:'',width:90},
    			  				{field:'fcontent',title:'',width:90},
    			  			]]
    			  		});
    				
    				
    				
    			 },
    			
    		});
    	});
     
     

     //级联下拉  维修性质2
      $(function(){
        		$('#wxxz2').combobox({
        			onChange:function (id){  
        				 $('#wtd2').combogrid({
        			  			panelWidth:200,
        			  	 		mode:'remote',
        			  			idField:'fcode',
        			  			textField:'fcontent',  	
        			  			url:'/gclm/rest/getWtd/'+id,
        			  			method:'post',
        			  			onChange:function (idField){  
        			  				$('#qy2').combogrid({
        		    			  			panelWidth:200,
        		    			  	 		mode:'remote',
        		    			  			idField:'fcode',
        		    			  			textField:'fcontent',  	
        		    			  			url:'/gclm/rest/getQy/'+idField,
        		    			  			method:'post',
        		    			  			onChange:function (idField){  
        		    			  				$('#xxd2').combogrid({
        	    		    			  			panelWidth:200,
        	    		    			  	 		mode:'remote',
        	    		    			  			idField:'fcode',
        	    		    			  			textField:'fcontent',  	
        	    		    			  			url:'/gclm/rest/getXxd/'+idField,
        	    		    			  			method:'post',
        	    		    			  			columns:[[
        	    		    			  				{field:'fcode',title:'',width:90},
        	    		    			  				{field:'fcontent',title:'',width:90},
        	    		    			  			]]
        	    		    			  		});
        		    			  				
        		    			  			 },
        		    			  			columns:[[
        		    			  				{field:'fcode',title:'',width:90},
        		    			  				{field:'fcontent',title:'',width:90},
        		    			  			]]
        		    			  		});
        		    				
        			  				
        			  			 },
        			  			columns:[[
        			  				{field:'fcode',title:'',width:90},
        			  				{field:'fcontent',title:'',width:90},
        			  			]]
        			  		});
        				
        				
        				
        			 },
        			
        		});
      });
         
     
     //  退仓粗粒结果 选择内容初始化
     $(function(){
			$('#tccljg').combogrid({
				panelWidth:200,
	  	 		mode:'remote',
	  			idField:'fcode',
	  			textField:'fcontent',  
	  			url:'/gclm/rest/getTybmb/tccljg',
	  			method:'post',
	  			columns:[[
	  				{field:'fcode',title:'',width:90},
	  				{field:'fcontent',title:'',width:90},
	  			]]
			});
			$('#zrbm').combogrid({
				panelWidth:200,
	  	 		mode:'remote',
	  			idField:'fcode',
	  			textField:'fcontent',  
	  			url:'/gclm/rest/getTybmb/zrbm',
	  			method:'post',
	  			columns:[[
	  				{field:'fcode',title:'',width:90},
	  				{field:'fcontent',title:'',width:90},
	  			]]
			});
			$('#jhwxts').combogrid({
				panelWidth:200,
	  	 		mode:'remote',
	  			idField:'fcode',
	  			textField:'fcontent',  
	  			url:'/gclm/rest/getTybmb/jhwxts',
	  			method:'post',
	  			columns:[[
	  				{field:'fcode',title:'',width:90},
	  				{field:'fcontent',title:'',width:90},
	  			]]
			});
		});
		
		 
     
     //判定处理方式选择 控制  只读操作反应
       $(function(){
        		$('#pdclfs').combobox({
        			onChange:function (id){  
        				if(id==1){
        				
        					$("#tccljg").combogrid('enable');
        					//$("#thdh").combogrid('enable');
        					document.getElementById("thdh").readOnly=true;
        					$("#tx").combogrid('disable');
        					$("#sfsf").combogrid('disable');
        					document.getElementById("sfje").readOnly=true;
        					document.getElementById("sfnr").readOnly=true;
        				};
        				if(id==2){
        					$("#tccljg").combogrid('disable');
        					document.getElementById("thdh").readOnly=true;
        					$("#tx").combogrid('disable');
        					$("#sfsf").combogrid('disable');
        					document.getElementById("sfje").readOnly=true;
        					document.getElementById("sfnr").readOnly=true;
        				};
        				if(id==3){
        					$("#tccljg").combogrid('disable');
        					//document.getElementById("thdh").className="output-body";
        					document.getElementById("thdh").readOnly=true;
        					$("#tx").combogrid('enable');
        					$("#sfsf").combogrid('enable');
        					document.getElementById("sfje").readOnly=true;
        					document.getElementById("sfnr").readOnly=true;
        				}
        				
        			
        			}
        		})
       });
       
       
       $(function(){
        		$('#sfsf').combobox({
        			onChange:function (id){  
        				if(id==1){
        					document.getElementById("sfje").readOnly=false;
        					document.getElementById("sfnr").readOnly=false;
        				}
        			}
        		})
       });
       
      function checkKh(value){
    	  if(""==value){
    		  $.messager.alert("閹绘劗銇�, "鐠囩柉绶崗銉︻儥閸欙拷);
    	  }else{ 
    		  $.post(	'rest/checkKh/'+value,
        		 {'params':value},
        		 function(newkh){	
        			 if("wu"==newkh){
        				 $.messager.alert("提示","","warning",function(){ 
	        				// var oInput = document.getElementById("kh");
			          	    //	oInput.focus();
        				 });  
			              	
        			 }else{
        			 document.getElementById("kh").value=newkh;
        			 }
        		 },
        		 'text'
        		 );	
    	  }
    	
       };
       
       
       

   //  保存维修信息
        function saveMaintain(zt){
        	alert(zt);
       	 /* form t閹绘劒姘�
       	 $('#ff').form('submit', {
   		        url:'rest/saveRegister/wxinfo',
   		        onSubmit: function(){
   		                // do some check
   		                alert("dddddd");
   		                // return false to prevent submit;
   		        },
   		        success:function(data){
   		              alert("sddd");
   		        }
   		       });
       	 */
       	 var 
       	 //保存登记
       	 
       	 guid,wxdh,dpbm,dpmc,dplx,	dzxm,dzlxdh,	wxcbm,wxcmc	,sldg,dglxdh,isgkwx,		
       	 vipkh,gkxm,	gklxdh,scsj,	isffwx,jjcd,
       	 kh,thrq,wtms,
       	 ysgs,ydh,fhdz,shdz,shr,shrlxdh,bzxx,
       	 //品检判定
       	 wxxz1,wtd1,qy1,xxd1,   wxxz2,wtd2,qy2,xxd2,   
       	 pdclfs,tccljg,zrbm,thdh,jcyy,
       	 tx,jhwxts,sfsf,sfje,sfnr,pjpdbz,
       	 wxr,wxsj;
     		
       	 guid=document.getElementById("guid").value;
       	 sldg = $('#sldg').combogrid('getText');
       	 dglxdh = document.getElementById("dglxdh").value;
       	 gkxm = document.getElementById("gkxm").value;
       	 scsj =  $('#scsj').datebox('getValue');
       	 kh = document.getElementById("kh").value;
       	 wtms = document.getElementById("wtms").value;
       	 ysgs = $('#ysgs').combogrid('getText');
       	 alert("1");
       	 if(""==sldg){
       		 $.messager.alert("提醒", "受理导购不能为空");return;
       	 }else if(""==dglxdh){
       		 $.messager.alert("提醒", "导购联系电话不能为空");return;
       	 }
       	 else if(""==gkxm){
       		 $.messager.alert("提醒", "顾客姓名不能为空");return;
       	 }
       	 else if(""==scsj){
       		 $.messager.alert("提醒", "售出时间");return;
       	 }
       	 else if(""==kh){
       		 $.messager.alert("提醒", "款号");return;
       	 }
       	 else if(""==wtms){
       		 $.messager.alert("提醒", "问题描述不能为空");return;
       	 }
       	 else if(""==ysgs){
       		 $.messager.alert("提醒", "运输公司不能为空");return;
       	 };
       	 alert("2");

       	 alert(zt);
       	 dpbm = $('#dpbm').combogrid('getText');
       	 //lert(dpbm);
       	 dpmc = document.getElementById("dpmc").value;
       	if("自营"==document.getElementById("dplx").value)
       		 {    	dplx=1; 	 }    	 else{    	dplx=2    	 }
      
       	// dplx = document.getElementById("dplx").value;
       	 dzxm = document.getElementById("dzxm").value;
       	 dzlxdh = document.getElementById("dzlxdh").value;
       	
       	 wxcbm = document.getElementById("wxcbm").value;
       	 wxcmc = document.getElementById("wxcmc").value;
       	 wxdh=document.getElementById("wxdh").value;
       	 
       	 //是否顾客维修
       	 if(document.getElementById("isgkwx").checked)
       	 	{   isgkwx = 1;     }
       	 else{	isgkwx = 0;		};
        
       	 vipkh = document.getElementById("vipkh").value;
       	 gklxdh = document.getElementById("gklxdh").value;
       	 //是否付费维修
       	 if(document.getElementById("isffwx").checked)
       	 	{		isffwx = 1;		}
       	 else{		isffwx =0;		};
        	
       	 scsj =  $('#scsj').datebox('getValue'); 
       	 jjcd = document.getElementById("jjcd").value;
       	 thrq =  $('#thrq').datebox('getValue'); 
       	 
       	 ydh = document.getElementById("ydh").value;
       	 fhdz = document.getElementById("fhdz").value;
       	 shdz = document.getElementById("shdz").value;
       	 shr = document.getElementById("shr").value;
       	 shrlxdh = document.getElementById("shrlxdh").value;
       	 bzxx = document.getElementById("bzxx").value;
       	 //閸濅線澹岄崚銈呯暰
       	 //wxxz1 = $('#wxxz1').combogrid('getText');
       	 wxxz1 = document.getElementById("wxxz1").value;
       	 wtd1 = document.getElementById("wtd1").value;
       	 qy1 = document.getElementById("qy1").value;
       	 xxd1 = document.getElementById("xxd1").value;
       	 
       	 wxxz2 = document.getElementById("wxxz2").value;
       	 wtd2 = document.getElementById("wtd2").value;
       	 qy2 = document.getElementById("qy2").value;
       	 xxd2 = document.getElementById("xxd2").value;
       	 pdclfs = document.getElementById("pdclfs").value;
       	 tccljg = document.getElementById("tccljg").value;
       	 zrbm = document.getElementById("zrbm").value;
       	 thdh = document.getElementById("thdh").value; 
       	 jcyy = document.getElementById("jcyy").value;
       	 tx = document.getElementById("tx").value;
       	 jhwxts = document.getElementById("jhwxts").value;
       	 sfsf = document.getElementById("sfsf").value;
       	 sfje = document.getElementById("sfje").value;
       	 sfnr = document.getElementById("sfnr").value;
       	 pjpdbz = document.getElementById("pjpdbz").value;
       	 wxr = document.getElementById("wxr").value;
       	 wxsj = document.getElementById("wxsj").value;
       	 //调用生成维修单号的存储过程   exec GenerateCYWXDJBDH
       	 
       	 if((""==wxdh||"null"==wxdh)&&(zt==0)){
       		 alert("ssss");
       		 $.post(	'rest/getWxdh/'+dpbm,
               		 function(wxdh1){
       			
       			wxdh = wxdh1;
       
       			document.getElementById("wxdh").value=wxdh;
       		
       		
       		 },
               		 'text'
               		 );
     		 };
    			alert(wxdh);
     			var params={'guid':guid,'wxdh':wxdh,'zt':zt,'dpbm':dpbm,'dpmc':dpmc,'dplx':dplx,	'dzxm':dzxm,'dzlxdh':dzlxdh,	'wxcbm':wxcbm,'wxcmc':wxcmc	,'sldg':sldg,'dglxdh':dglxdh,'isgkwx':isgkwx,		
   	    	    	 'vipkh':vipkh,'gkxm':gkxm,	'gklxdh':gklxdh,'scsj':scsj,	'isffwx':isffwx,'jjcd':jjcd,
   	    	    	 'kh':kh,'thrq':thrq,'wtms':wtms,
   	    	    	 'ysgs':ysgs,'ydh':ydh,'fhdz':fhdz,'shdz':shdz,'shr':shr,'shrlxdh':shrlxdh,'bzxx':bzxx,
     			'wxxz1':wxxz1,'wtd1':wtd1,'qy1':qy1,'xxd1':xxd1,   'wxxz2':wxxz2,'wtd2':wtd2,'qy2':qy2,'xxd2':xxd2,   
     			'pdclfs':pdclfs,'tccljg':tccljg,'zrbm':zrbm,'thdh':thdh,'jcyy':jcyy,
     			'tx':tx,'jhwxts':jhwxts,'sfsf':sfsf,'sfje':sfje,'sfnr':sfnr,'pjpdbz':pjpdbz,
     			'wxr':wxr,'wxsj':wxsj};
     			
     			$.post(	'rest/saveRegister/save',
   	        		 params,
   	        		 function(uuid){	
   	    		 document.getElementById("guid").value = uuid;
   	    		 $.messager.alert("提示", "保存成功");
   	    	 },
   	        		 'text'
   	        		 ).error(function() {
   						$.messager.alert("提示", "保存失败");
   					});	
   	    	 
     		 
     	


        };


   // 获取详细
        $(function(){
   		var guid='<%out.print(request.getParameter("guid"));%>';
   		 $.post(	'rest/getDetail/S2',
   				{'guid':guid},function(detail) {
   						var e = eval("(" + detail + ")");
   						if(null!=e[0].dh){document.getElementById("wxdh").value=e[0].dh;};
   						if(null!=e[0].dpbm){$('#dpbm').combogrid('setValue',e[0].dpbm);};
   						if(null!=e[0].dpmc){document.getElementById("dpmc").value=e[0].dpmc;};
   						
   						if(null!=e[0].dplx){document.getElementById("dplx").value=e[0].dplx;};
   						if(null!=e[0].dzxm){document.getElementById("dzxm").value=e[0].dzxm;};
   						if(null!=e[0].dzlxdh){document.getElementById("dzlxdh").value=e[0].dzlxdh;};
   						
   						if(null!=e[0].wxcbm){document.getElementById("wxcbm").value=e[0].wxcbm;};
   						if(null!=e[0].wxcmc){document.getElementById("wxcmc").value=e[0].wxcmc;};
   						if(null!=e[0].sldg){$('#sldg').combogrid('setValue',e[0].sldg); };
   						if(null!=e[0].dglxdh){document.getElementById("dglxdh").value=e[0].dglxdh;};
   						
   						if(null!=e[0].isgkwx){document.getElementById("isgkwx").value=e[0].isgkwx;};
   						if(null!=e[0].gkxm){document.getElementById("gkxm").value=e[0].gkxm;};
   						if(null!=e[0].gklxdh){document.getElementById("gklxdh").value=e[0].gklxdh;};
   						if(null!=e[0].scsj){$('#scsj').datebox('setValue',e[0].scsj)};

   						if(null!=e[0].isffwx){document.getElementById("isffwx").value=e[0].isffwx;};
   						if(null!=e[0].jjcd){document.getElementById("jjcd").value=e[0].jjcd;};
   						if(null!=e[0].kh){document.getElementById("kh").value=e[0].kh;};
   						if(null!=e[0].thrq){$('#thrq').datebox('setValue',e[0].thrq)};

   						if(null!=e[0].wtms){document.getElementById("wtms").value=e[0].wtms;};
   						if(null!=e[0].ysgs){$('#ysgs').combogrid('setValue',e[0].ysgs);};
   						if(null!=e[0].ydh){document.getElementById("ydh").value=e[0].ydh;};
   						if(null!=e[0].fhdz){document.getElementById("fhdz").value=e[0].fhdz;};
   						if(null!=e[0].shdz){document.getElementById("shdz").value=e[0].shdz;};
   						
   						if(null!=e[0].shr){document.getElementById("shr").value=e[0].shr;};
   						if(null!=e[0].shrlxdh){document.getElementById("shrlxdh").value=e[0].shrlxdh;};
   						if(null!=e[0].bzxx){document.getElementById("bzxx").value=e[0].bzxx;};
   						
   						if(null!=e[0].djr){document.getElementById("djr").value=e[0].djr;};
   						if(null!=e[0].djsj){document.getElementById("djsj").value=e[0].djsj;};
   						if(null!=e[0].pjpdr){document.getElementById("pjpdr").value=e[0].pjpdr;};
   						if(null!=e[0].pdsj){document.getElementById("pdsj").value=e[0].pdsj;};
   						
   						if(null!=e[0].ttspr){document.getElementById("ttspr").value=e[0].ttspr;};
   						if(null!=e[0].txspsj){document.getElementById("spsj").value=e[0].txspsj;};
   						if(null!=e[0].wxqrr){document.getElementById("wxqrr").value=e[0].wxqrr;};
   						if(null!=e[0].wxqrsj){document.getElementById("qrsj").value=e[0].wxqrsj;};
   						
   						
   						}, 'text');	
       
   		    
       		$('#dpbm').combogrid({
       			panelWidth:430,
       	 		mode:'remote',
       			idField:'depotid',
       			textField:'depotid',
       			url:'/gclm/rest/getFilterdp/S2',
       			method:'post',
       			onChange:function (idField){  
       				getdpvalue(idField); // 
       			 },
       			columns:[[
       				{field:'depotid',title:'店铺编码',width:90},
       				{field:'dname',title:'店铺名称',width:160},
       				{field:'address',title:'地址',width:160},
       			]]
       		});
   		    
       		
       	});
        //运输公司选择内容初始化
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