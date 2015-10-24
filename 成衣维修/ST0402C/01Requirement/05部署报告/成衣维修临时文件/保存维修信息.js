//  保存维修信息
/**
维修登记 save00
发到总部 save10
品检判定 save20
重新判定 save020
维修完成 save07
总部发货 save08
批量发货 save18
快递单打印 printkd
总部打印  printzb
*/
     function saveMaintain(zt){
    	 /* form t提交
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
    	 //登记信息
    	 
    	 guid,wxdh,dpbm,dpmc,dplx,	dzxm,dzlxdh,	wxcbm,wxcmc	,sldg,dglxdh,isgkwx,		
    	 vipkh,gkxm,	gklxdh,scsj,	isffwx,jjcd,
    	 kh,thrq,wtms,
    	 ysgs,ydh,fhdz,shdz,shr,shrlxdh,bzxx,
    	 //品鉴判定内容
    	 wxxz1,wtd1,qy1,xxd1,   wxxz2,wtd2,qy2,xxd2,   
    	 pdclfs,tccljg,zrbm,thdh,jcyy,
    	 tx,jhwxtx,sfsf,sfje,sfnr,pjpdbz,
    	 wxr,wxsj;
  		
    	 guid=document.getElementById("guid").value;
    	 sldg = $('#sldg').combogrid('getText');
    	 dglxdh = document.getElementById("dglxdh").value;
    	 gkxm = document.getElementById("gkxm").value;
    	 scsj =  $('#scsj').datebox('getValue');
    	 kh = document.getElementById("kh").value;
    	 wtms = document.getElementById("wtms").value;
    	 ysgs = $('#ysgs').combogrid('getText');
    	
    	 if(""==sldg){
    		 $.messager.alert("提示", "受理导购不能为空");return;
    	 }else if(""==dglxdh){
    		 $.messager.alert("提示", "导购联系电话不能为空");return;
    	 }
    	 else if(""==gkxm){
    		 $.messager.alert("提示", "顾客姓名不能为空");return;
    	 }
    	 else if(""==scsj){
    		 $.messager.alert("提示", "售出时间不能为空");return;
    	 }
    	 else if(""==kh){
    		 $.messager.alert("提示", "款号不能为空");return;
    	 }
    	 else if(""==wtms){
    		 $.messager.alert("提示", "问题 描述不能为空");return;
    	 }
    	 else if(""==ysgs){
    		 $.messager.alert("提示", "请选择运输公司");return;
    	 };
    	 
     
    	 dpbm = $('#dpbm').combogrid('getText');
    	 //lert(dpbm);
    	 dpmc = document.getElementById("dpmc").value;
    	 if("自营"==document.getElementById("dplx").value)
    		 {    	dplx=1; 	 }
    	 else{    	dplx=2    	 }
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
    	 //品鉴判定
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
    	 //调用字段生成存储过程    exec GenerateCYWXDJBDH
    	 if(""==wxdh||"null"==wxdh){
    		 $.post(	'rest/getWxdh/'+dpbm,
            		 function(wxdh){
    			//var wxbh1 = eval("(" + wxbh + ")");
    			document.getElementById("wxdh").value=wxdh;
    		
    			//保存
    			var params={'guid':guid,'wxdh':wxdh,'zt':zt,'dpbm':dpbm,'dpmc':dpmc,'dplx':dplx,	'dzxm':dzxm,'dzlxdh':dzlxdh,	'wxcbm':wxcbm,'wxcmc':wxcmc	,'sldg':sldg,'dglxdh':dglxdh,'isgkwx':isgkwx,		
    		    	    	 'vipkh':vipkh,'gkxm':gkxm,	'gklxdh':gklxdh,'scsj':scsj,	'isffwx':isffwx,'jjcd':jjcd,
    		    	    	 'kh':kh,'thrq':thrq,'wtms':wtms,
    		    	    	 'ysgs':ysgs,'ydh':ydh,'fhdz':fhdz,'shdz':shdz,'shr':shr,'shrlxdh':shrlxdh,'bzxx':bzxx};
    			
    		
    			
    			$.post(	'rest/saveRegister/wxinfo',
    		        		 params,
    		        		 function(uuid){	
    		    		 document.getElementById("guid").value = uuid;
    		    		 $.messager.alert("提示", "保存成功");
    		    	 },
    		        		 'text'
    		        		 ).error(function() {
    							$.messager.alert("提示", "保存出错");
    						});	
    		    	 
    		 },
            		 'text'
            		 );
  		 };

     };