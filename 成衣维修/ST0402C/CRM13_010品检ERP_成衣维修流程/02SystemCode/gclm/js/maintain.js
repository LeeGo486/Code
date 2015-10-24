
var kh;
var ztCode;
 
function compareDate(DateOne,DateTwo)
{ 
var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ("-"));
var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ("-")+1);
var OneYear = DateOne.substring(0,DateOne.indexOf ("-"));

var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ("-"));
var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ("-")+1);
var TwoYear = DateTwo.substring(0,DateTwo.indexOf ("-"));

if (Date.parse(OneMonth+"/"+OneDay+"/"+OneYear) >
Date.parse(TwoMonth+"/"+TwoDay+"/"+TwoYear))
{
return true;
}
else
{
return false;
}

}

 var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
     function dpPrint() {
            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");
            LODOP.PRINT_INIT("店铺维修单");
            LODOP.PRINT_INITA(3,0,400,700,"店铺维修单");
            //$("#pp").value("OUTLET");
            $("#wxdh1").text(document.getElementById("wxdh").value);
            $("#pdpmc").text(document.getElementById("dpmc").value);
		    $("#pdzxm").text(document.getElementById("dzxm").value);
            $("#pgkxm").text(document.getElementById("gkxm").value);
            $("#pgkdh").text(document.getElementById("gklxdh").value);
            $("#pwxcbm").text(document.getElementById("wxcbm").value);
            $("#pVIPKH").text(document.getElementById("vipkh").value);
            $("#psldg").text(document.getElementById("sldg").value);
           // $("#psftyffwx").value(document.getElementById("isffwx").value);
            var kh = document.getElementById("kh").value;
	       $("#khp").text(kh);
	       $("#ysp").text(kh.substr(kh.length-2,1));
	       $("#msp").text(kh.substr(kh.length-1,1));
	       $("#scsjp").text(document.getElementById("scsj").value);
	       $("#wtmsp").text(document.getElementById("wtms").value);
	       $("#wlgsp").text($('#ysgs').combogrid('getValue'));
	       $("#wldhp").text(document.getElementById("ydh").value);
	       $("#dpdzp").text(document.getElementById("fhdz").value);

	       $("#thrqp").text($('#thrq').datebox('getValue'));
       
            LODOP.ADD_PRINT_HTM(0, 0, "95%", "95%", document.getElementById("print").innerHTML);
            LODOP.PREVIEW();
        }; 

        //快递单
        function kddPrint() {
        	
        	if(ztCode=='7'){
        		alert("请先进行总部发货操作");
        		return ;
        	}
        	//alert($("#zbfh_ysgs").combogrid("getText"));
        	LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");
        	if($("#zbfh_ysgs").combogrid("getText")!='顺丰'){
        		LODOP.PRINT_INIT("快递单");
                LODOP.PRINT_INITA(45,1,800,600,"快递单");
                LODOP.ADD_PRINT_TEXT(47,63,162,27,$('#zbfh_bzr').attr('value'));
                LODOP.ADD_PRINT_TEXT(47,284,129,27,"嘉兴");
                LODOP.ADD_PRINT_TEXT(47,477,277,27,$('#zbfh_shr2').attr('value'));
                LODOP.ADD_PRINT_TEXT(87,64,349,27,"浙江雅莹服装有限公司售后部");
                LODOP.ADD_PRINT_TEXT(130,63,353,42,$('#zbfh_fhdz2').attr('value'));
                LODOP.ADD_PRINT_TEXT(185,287,129,27,"314001");
                LODOP.ADD_PRINT_TEXT(87,477,279,27,$('#dpmcz').attr('value'));
                LODOP.ADD_PRINT_TEXT(185,66,179,27,$('#shrlxdh').attr('value'));
                LODOP.ADD_PRINT_TEXT(130,475,285,42,$('#zbfh_shdz2').attr('value'));
                LODOP.ADD_PRINT_TEXT(185,475,123,27,$('#zbfh_shrdh2').attr('value'));
        	}else{
        		LODOP.PRINT_INITA(45,1,800,600,"快递单");
                LODOP.ADD_PRINT_TEXT(52,62,167,25,"浙江雅莹服装有限公司售后部");
                LODOP.ADD_PRINT_TEXT(50,274,129,27,$('#zbfh_bzr').attr('value'));
                LODOP.ADD_PRINT_TEXT(229,276,139,25,$('#zbfh_shr2').attr('value'));
                LODOP.ADD_PRINT_TEXT(94,63,353,41,$('#zbfh_fhdz2').attr('value'));
                LODOP.ADD_PRINT_TEXT(161,155,129,25,$('#shrlxdh').attr('value'));
                LODOP.ADD_PRINT_TEXT(231,59,179,25,$('#dpmcz').attr('value'));
                LODOP.ADD_PRINT_TEXT(159,63,89,25,"0573");
                LODOP.ADD_PRINT_TEXT(271,56,358,42,$('#zbfh_shdz2').attr('value'));
                LODOP.ADD_PRINT_TEXT(318,155,123,25,$('#zbfh_shrdh2').attr('value'));
                
        	}
        	
           
           
            
            //LODOP.PRINT_DESIGN();
            
            
            LODOP.PREVIEW();
            
        };
        
         //总部打印
        

        function zbPrint() {
        	
        	var jg = $('#pdclfs').combobox('getValue');
        	
        	var jg1 ='<table width="700px" border="0" rules="all" style= "text-align: left; font-family: verdana,arial,sans-serif;  font-size:10pt; color:#000000; border-width: 1px;border-color: #666666; border-collapse: collapse; width: 100%; "><tr><td colspan="2"><input id="cptc" type="checkbox"  checked="checked">产品退仓</input></td><td colspan="2"><input id="wfwx" type="checkbox">已经维修完成</input></td></tr>'+
		        '<tr><td colspan="2"><input id="cptct" type="checkbox">产品退仓(特)</input></td><td colspan="2"><input type="checkbox">已经维修完成(特)</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox">无法维修，寄回店铺</input></td><td colspan="2"></td></tr></table>';

        	var jg2 ='<table width="700px" border="0" rules="all" style= "text-align: left; font-family: verdana,arial,sans-serif;  font-size:10pt; color:#000000; border-width: 1px;border-color: #666666; border-collapse: collapse; width: 100%; "><tr><td colspan="2"><input type="checkbox" >产品退仓</input></td><td colspan="2"><input type="checkbox">已经维修完成</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox">产品退仓(特)</input></td><td colspan="2"><input type="checkbox">已经维修完成(特)</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox">无法维修，寄回店铺</input></td><td colspan="2"></td></tr></table>';

        	var jg3 ='<table width="700px" border="0" rules="all" style= "text-align: left; font-family: verdana,arial,sans-serif;  font-size:10pt; color:#000000; border-width: 1px;border-color: #666666; border-collapse: collapse; width: 100%; "><tr><td colspan="2"><input  type="checkbox" >产品退仓</input></td><td colspan="2"><input type="checkbox"  checked="checked">已经维修完成</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox">产品退仓(特)</input></td><td colspan="2"><input type="checkbox">已经维修完成(特)</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox"  checked="checked">无法维修，寄回店铺</input></td><td colspan="2"></td></tr></table>';
			
			if(jg=='1'){
					document.getElementById('cljg').innerHTML = jg1;
				}else if(jg=='2'){
					document.getElementById('cljg').innerHTML = jg2;
				}else if(jg=='3'){
					document.getElementById('cljg').innerHTML = jg3;
				};  
				
            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");
            LODOP.PRINT_INIT("产品售后发货单");
            LODOP.PRINT_INITA(3,0,400,700,"产品售后发货单");
          
            $("#thrq2").text($('#thrq').datebox('getValue'));
       
            LODOP.ADD_PRINT_HTM(0, 0, "95%", "95%", document.getElementById("zbprint").innerHTML);
            LODOP.PREVIEW();
        };
     //-------------------------------------------
      //详细页面 根据url参数 初始化页面 
      function getDetail(guid,zt){
      	//var guid='<%out.print(request.getParameter("guid"));%>';
      	 $.post(	'rest/getDetail/S2',
      			{'guid':guid},function(detail) {
      					var e = eval("(" + detail + ")");
      					if(""==e){
      					}else{
      						ztCode = e[0].zt;
      				//店铺维修单 打印数据
          					var ep = '<input id="EP" type="checkbox" checked="checked" />EP '+	
          				        		'<input id="EM" type="checkbox" /> EM'+		
          				        		'<input id="TBF" type="checkbox" /> TBF'+		
          				        		'<input id="OUTLET" type="checkbox" /> OUTLET';
          					var em = '<input id="EP" type="checkbox" />EP '+	
				        		'<input id="EM" type="checkbox"  checked="checked"/> EM'+		
				        		'<input id="TBF" type="checkbox" /> TBF'+		
				        		'<input id="OUTLET" type="checkbox" /> OUTLET';
          					var tbf = '<input id="EP" type="checkbox" />EP '+	
				        		'<input id="EM" type="checkbox" /> EM'+		
				        		'<input id="TBF" type="checkbox"  checked="checked"/> TBF'+		
				        		'<input id="OUTLET" type="checkbox" /> OUTLET';
          					var outlet = '<input id="EP" type="checkbox"/>EP '+	
				        		'<input id="EM" type="checkbox" /> EM'+		
				        		'<input id="TBF" type="checkbox" /> TBF'+		
				        		'<input id="OUTLET" type="checkbox"  checked="checked"/> OUTLET';
          					if(e[0].pp=="E"){
          						document.getElementById('pp').innerHTML = ep;
          					}else if(e[0].pp=="M"){
          						document.getElementById('pp').innerHTML = em;
          					}else if(e[0].pp=="T"){
          						document.getElementById('pp').innerHTML = tbf;
          					}else if(e[0].pp=="B"){
          						document.getElementById('pp').innerHTML = outlet;
          					}
          					
          					//总部发货单 打印数据
          					var shtml0 ='<input id="SFFGKWX" type="checkbox" value="1" />',
          						shtml1 ='<input id="SFFGKWX" type="checkbox" value="1" checked="checked"/>';
          					if(e[0].sffgkwx==1){
          						document.getElementById("isgkwx").checked=true;
          						document.getElementById('gkwxp').innerHTML = shtml1;
          						document.getElementById('dpwxp').innerHTML = shtml0;
          					}else{
          						document.getElementById('gkwxp').innerHTML = shtml0;
          						document.getElementById('dpwxp').innerHTML = shtml1;
          						document.getElementById("isgkwx").checked=false;
          					}          					
          					
          					
          					//是否同意付费维修
          					var shtml0 ='<input  type="checkbox" />',
          						shtml1 ='<input  type="checkbox" checked="checked"/>';
          					if(e[0].sftyffwx=='1'){
          						document.getElementById('s').innerHTML = shtml1;
          						document.getElementById('f').innerHTML = shtml0;
          						document.getElementById("isffwx").checked=true;
          					}else{
          						document.getElementById('s').innerHTML = shtml0;
          						document.getElementById('f').innerHTML = shtml1;
          						document.getElementById("isffwx").checked=false;
          					};    
          					$('#branch').attr('value',e[0].branch);
          					$('#pp').attr('value',e[0].pp);
          			//产品售后发货单 打印数据
          					//document.getElementById("pp2").value=e[0].pp;
          					$("#pp2").text(e[0].pp);//jquery  赋值方法
          					$("#wxdh2").text(e[0].dh);
          					$("#dpmc2").text(e[0].dpmc);
          					$("#kh2").text(e[0].kh);
          					$("#thrq2").text(e[0].thrq);
          					$("#dz2").text(e[0].dzxm);
          					$("#dpdh2").text(e[0].dzlxdh);
          					$("#hjdz2").text(e[0].shdz);
          					$("#jcyy2").text(e[0].jcyy);
          					
          					$("#pdr2").text(e[0].pjpdr);
          					$("#pdrq2").text(e[0].pjpdsj);
          					
          					$("#bz2").text(e[0].bzxx);
          					
          		// 总部发货   快递单数据
          					if(null!=e[0].zbfh_bzr){document.getElementById("zbfh_bzr").value=e[0].zbfh_bzr;};
          					if(null!=e[0].zbfh_shr){document.getElementById("zbfh_shr").value=e[0].zbfh_shr;};
          					if(null!=e[0].zbfh_shrdh){document.getElementById("zbfh_shrdh").value=e[0].zbfh_shrdh;};
          					if(null!=e[0].zbfh_fhdz){document.getElementById("zbfh_fhdz").value=e[0].zbfh_fhdz;};
          					if(null!=e[0].zbfh_shdz){document.getElementById("zbfh_shdz").value=e[0].zbfh_shdz;};
          					if(null!=e[0].shrlxdh){document.getElementById("shrlxdh").value=e[0].shrlxdh;};
          					
          		//总部发货    弹出框数据
          					if(null!=e[0].dpbm){document.getElementById("dpbmz").value=e[0].dpbm;};
          					if(null!=e[0].dpmc){document.getElementById("dpmcz").value=e[0].dpmc;};
          					if(null!=e[0].fhdz){document.getElementById("zbfh_shdz2").value=e[0].fhdz;};
          					if(null!=e[0].shdz){document.getElementById("zbfh_fhdz2").value=e[0].shdz;};
          					if(null!=e[0].dzxm){document.getElementById("zbfh_shr2").value=e[0].dzxm;};
          					if(null!=e[0].dzlxdh){document.getElementById("zbfh_shrdh2").value=e[0].dzlxdh;};
          		//详细表单数据
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
          					
          					
          					if(null!=e[0].gkxm){document.getElementById("gkxm").value=e[0].gkxm;};
          					if(null!=e[0].gklxdh){document.getElementById("gklxdh").value=e[0].gklxdh;};
          					if(null!=e[0].scsj){$('#scsj').datebox('setValue',e[0].scsj);};
          					if(null!=e[0].isffwx){document.getElementById("isffwx").value=e[0].sftyffwx;};
          					
          					if(null!=e[0].jjcd){document.getElementById("jjcd").value=e[0].jjcd;};
          					if(null!=e[0].kh){document.getElementById("kh").value=e[0].kh;}; 
          					if(null!=e[0].thrq){$('#thrq').datebox('setValue',e[0].thrq);};
          					if(null!=e[0].wtms){document.getElementById("wtms").value=e[0].wtms;}; 
          					if(null!=e[0].ysgs){$('#ysgs').combogrid('setValue',e[0].ysgs);};
          					//if(null!=e[0].ysgs){document.getElementById("ysgs").value=e[0].ysgs;};
          					if(null!=e[0].ydh){document.getElementById("ydh").value=e[0].ydh;}; 
          					if(null!=e[0].fhdz){document.getElementById("fhdz").value=e[0].fhdz;};
          					if(null!=e[0].shdz){document.getElementById("shdz").value=e[0].shdz;}; 
          					if(null!=e[0].shr){document.getElementById("shr").value=e[0].shr;};
          					if(null!=e[0].shrlxdh){document.getElementById("shrlxdh").value=e[0].shrlxdh;};
          					if(null!=e[0].bzxx){document.getElementById("bzxx").value=e[0].bzxx;};
          					//问题主因
          					if(null!=e[0].wxxz1){$('#wxxz1').combobox('setValue',e[0].wxxz1);};
          				//	if(null!=e[0].wxxz1){document.getElementById("wxxz1").value=e[0].wxxz1;};
          					if(null!=e[0].wtd1){$('#wtd1').combogrid('setValue',e[0].wtd1);};
          					if(null!=e[0].qy1){$('#qy1').combogrid('setValue',e[0].qy1);};
          					if(null!=e[0].xxd1){$('#xxd1').combogrid('setValue',e[0].xxd1);};
          					if(null!=e[0].wxbw){document.getElementById("wxbw").value=e[0].wxbw;}; // 部位描述
          					if(null!=e[0].wxxz2){$('#wxxz2').combobox('setValue',e[0].wxxz2);};
          					if(null!=e[0].wtd2){$('#wtd2').combogrid('setValue',e[0].wtd2);};
          					if(null!=e[0].qy2){$('#qy2').combogrid('setValue',e[0].qy2);};
          					if(null!=e[0].xxd2){$('#xxd2').combogrid('setValue',e[0].xxd2);};
          					
          					//if(null!=e[0].pdclfs){document.getElementById("pdclfs").value=e[0].pdclfs;};
          					if(null!=e[0].pdclfs){$('#pdclfs').combobox('setValue',e[0].pdclfs);};
          					
          					//if(null!=e[0].tccljg){document.getElementById("tccljg").value=e[0].tccljg;};
          					if(null!=e[0].tccljg){$('#tccljg').combogrid('setValue',e[0].tccljg);};
          					
          					//if(null!=e[0].zrbm){document.getElementById("zrbm").value=e[0].zrbm;};
          					if(null!=e[0].zrbm){$('#zrbm').combogrid('setValue',e[0].zrbm);};
          					
          					if(null!=e[0].thdh){document.getElementById("thdh").value=e[0].thdh;}; 
          					if(null!=e[0].jcyy){document.getElementById("jcyy").value=e[0].jcyy;};
          					
          					if(null!=e[0].nx){
          						$('#nx').combobox('setValue',e[0].nx);
          						if(null!=e[0].sfje){
          							if(e[0].nx=='0'){
          								document.getElementById("nxsfje").value=e[0].sfje;
              						}else{
              							document.getElementById("wxsfje").value=e[0].sfje;
              						}
          						}
          						
          					}
          					
          					if(null!=e[0].sfje){
          						document.getElementById("zzsfje").value=e[0].sfje;
          					}
          					
          					
          					if(null!=e[0].jhwxts){$('#jhwxts').combogrid('setValue',e[0].jhwxts);};
          					
          					
          					//如果是维修登记与判定界面，那么收费收费默认为是。
          					if(e[0].sfsf==undefined){
          						if(e[0].zt=='0' || e[0].zt=='1'){
	          						$('#sfsf').combobox('setValue','1');
	          						getWxjefw();
	          						document.getElementById("wxjefw").disabled=false;
          						}
          					}else{
          						if(null!=e[0].sfsf){$('#sfsf').combobox('setValue',e[0].sfsf);};
          					}
          					
          					//if(null!=e[0].wxjefw){document.getElementById("wxjefw").value=e[0].wxjefw;};
          					
          					if(null!=e[0].sfnr){document.getElementById("sfnr").value=e[0].sfnr;};
          					if(null!=e[0].pjpdbz){document.getElementById("pjpdbz").value=e[0].pjpdbz;};
          					if(null!=e[0].wxr){document.getElementById("wxr").value=e[0].wxr;};
          					if(null!=e[0].wxsj){document.getElementById("wxsj").value=e[0].wxsj;};
          					
          					
          					if(null!=e[0].djrName){document.getElementById("djr").value=e[0].djrName;};
          					if(null!=e[0].djsj){document.getElementById("djsj").value=e[0].djsj;};
          					if(null!=e[0].pjpdrName){document.getElementById("pjpdr").value=e[0].pjpdrName;};
          					if(null!=e[0].pjpdsj){document.getElementById("pjpdsj").value=e[0].pjpdsj;};
          					
          					if(null!=e[0].ttspr){document.getElementById("ttspr").value=e[0].ttspr;};
          					if(null!=e[0].txspsj){document.getElementById("spsj").value=e[0].txspsj;};
          					if(null!=e[0].wxqrr){document.getElementById("wxqrr").value=e[0].wxqrr;};
          					if(null!=e[0].wxqrsj){document.getElementById("qrsj").value=e[0].wxqrsj;};
          					
          					if(null!=e[0].wxjefw){$("#wxjefw").attr('value',e[0].wxjefw);};
      					}
      					
      					if(zt==0 || zt==1){
      						loadDataForGys('gys',$('#kh').attr('value'),e[0].gysbh,true);
      					}else{
      						loadDataForGys('gys',$('#kh').attr('value'),e[0].gysbh,true);
      						loadDataForGys('wxgys',$('#kh').attr('value'),e[0].gysbh,true);
      					}
      					
      				}, 'text').error(function() {
      				$.messager.alert("提示", "信息读取失败");
      			});	

      	
      	 $.post(	'rest/getFilterzt/'+zt,
      	 {'zt':zt},function(zt) {
      			var e = eval("(" + zt + ")");
      			if(null!=e[0].mc){document.getElementById("zt").value=e[0].mc;};
      		});
      	 
      		$('#dpbm').combogrid({
      			panelWidth:430,
      	 		mode:'remote',
      			idField:'DEPOTID',
      			textField:'DEPOTID',
      			url:'rest/getFilterdp/S2',
      			method:'post',
      			onChange:function (idField){  
      				getdpvalue(idField); // 店铺信息
      			 },
      			columns:[[
      				{field:'DEPOTID',title:'店铺编号',width:90},
      				{field:'D_NAME',title:'店铺名称',width:160},
      				{field:'address',title:'地址',width:160}
      			]]
      		});
      	} 

      	
      //保存维修信息
      function saveMaintain(id,zt){
    	  $('#'+id).linkbutton('disable');  
      	 var 
      	 //维修登记
      	 ztold,branch,pp,
      	 guid,wxdh,dpbm,dpmc,dplx,	dzxm,dzlxdh,	wxcbm,wxcmc	,sldg,dglxdh,isgkwx,		
      	 vipkh,gkxm,	gklxdh,scsj,	isffwx,jjcd,
      	 kh,thrq,wtms,
      	 ysgs,ydh,fhdz,shdz,shr,shrlxdh,bzxx,
      	 //品检  判定
      	 wxxz1,wtd1,qy1,xxd1, wxbw,  wxxz2,wtd2,qy2,xxd2,   
      	 pdclfs,tccljg,zrbm,thdh,jcyy,
      	 nx,jhwxts,sfsf,sfje,
      	 sfnr,pjpdbz,
      	 wxr,wxsj,zzwxd,
      	 zbfh_ysgs ,zbfh_ysdh ,zbfh_shdz ,
      	 zbfh_fhdz ,zbfh_shr ,zbfh_shrdh ,zbfh_bz;
      	 var gysbh,gysmc,wxjefw ;
      	 
      	 
      	 guid=document.getElementById("guid").value;
      	 ztold=document.getElementById("zt").value;
      	 //alert(ztold);
      	 branch = $('#branch').attr('value');
      	 pp = $('#pp').attr('value');
      	 sldg = $('#sldg').combogrid('getText');
      	 dglxdh = document.getElementById("dglxdh").value;
      	 gkxm = document.getElementById("gkxm").value;
      	 scsj =  $('#scsj').datebox('getValue');
      	 kh = document.getElementById("kh").value;
      	 wtms = document.getElementById("wtms").value;	
      	 ysgs = $('#ysgs').combogrid('getText');	
      	
      	 dpbm = $('#dpbm').combogrid('getText');
      	 dpmc = document.getElementById("dpmc").value;
      	if("自营"==document.getElementById("dplx").value)
      		 {    	dplx=1; 	 }    	 else{    	dplx=2 ;   	 }

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
      	 //问题描述
      	 wxxz1 = $('#wxxz1').combobox('getValue');
      	 wtd1 = $('#wtd1').combogrid('getValue');//document.getElementById("wtd1").value;
      	 qy1 = $('#qy1').combogrid('getValue');
      	 xxd1 = $('#xxd1').combogrid('getValue');
      	wxbw = document.getElementById("wxbw").value;
      	 wxxz2 = $('#wxxz2').combobox('getValue');
      	 wtd2 = $('#wtd2').combogrid('getValue');
      	 qy2 = $('#qy2').combogrid('getValue');
      	 xxd2 = $('#xxd2').combogrid('getValue');
      	 pdclfs = $('#pdclfs').combobox('getValue');
      	 tccljg = $('#tccljg').combogrid('getValue');
      	 zrbm = $('#zrbm').combogrid('getValue');
      	 thdh = document.getElementById("thdh").value; 
      	 jcyy = document.getElementById("jcyy").value;
      	 nx = $('#nx').combobox('getValue');
      	 jhwxts = $('#jhwxts').combogrid('getValue');
      	 sfsf = $('#sfsf').combobox('getValue');
      	
      	 	if(nx=='0'){
      	 		sfje = document.getElementById("nxsfje").value;
      	 	}else{
      	 		sfje = document.getElementById("wxsfje").value;
      	 	}      	 
      	
      	 sfnr = document.getElementById("sfnr").value;
      	 pjpdbz = document.getElementById("pjpdbz").value;
      	// alert(ztold+"ssss"+zt);return;
      	 gysbh = $("#gys").combogrid("getValue");
      	 gysmc = $("#gys").combogrid("getText");
      	 wxjefw= $("#wxjefw").attr('value');
      	
      	 //登记     品检    维修完成    重判     发货  数据保存必填项提示
       	 if(id=="save0123456")
       		{
       	//品鉴判断
				if(zt==1){
					zt=3;//产品退仓
				}else if(zt==2){
					zt=4;//不可以维修
				}else if(zt==3){
					zt=5;//可以维修
				}
       		 
       		 //登记
       		 if(""==dpbm){
       			 $.messager.alert("提示", "店铺编码必选");
       			 $('#'+id).linkbutton('enable');  
       			 return;
       		 }else	 if(""==sldg){
       			 $.messager.alert("提示", "受理导购必填");
       			 $('#'+id).linkbutton('enable');  
       			 return;
       		 }else if(""==dglxdh){
       			 $.messager.alert("提示", "导购联系电话必填");
       			 $('#'+id).linkbutton('enable');  
       			 return;
       		 }
       		 else if(document.getElementById("isgkwx").checked == true)
  			 { 
		       	  if(""==gkxm){
		       			 $.messager.alert("提示", "顾客姓名必填");
		       			 $('#'+id).linkbutton('enable');  
		       			 return;
		       		 }
		       		 else if(""==scsj){
		       			 $.messager.alert("提示", "售出时间必填");
		       			 $('#'+id).linkbutton('enable');  
		       			 return;
		       		 } 
  			 }
       		 else if(""==thrq){
       			 $.messager.alert("提示", "退回时间必填");
       			 $('#'+id).linkbutton('enable');  
       			 return;
       		 } else if(compareDate($('#scsj').datebox('getValue'),$('#thrq').datebox('getValue'))){
        		 $.messager.alert("提示", "请检查售出时间必在退回日期之前");
        		 $('#'+id).linkbutton('enable');  
        		 return;
        	 }else if(""==kh){
       			 $.messager.alert("提示", "款号必填");
       			 $('#'+id).linkbutton('enable');  
       			 return;
       		 }else if(kh.length<5){
       			 $.messager.alert("提示", "款号太短");
       			 $('#'+id).linkbutton('enable');  
       			 return;
       		 }
       		 else if(""==wtms){
       			 $.messager.alert("提示", "问题描述必填");
       			 $('#'+id).linkbutton('enable');  
       			 return;
       		 }
       		/* else if(""==ysgs){
       			 $.messager.alert("提示", "运输公司必填");return;
       		 }*/
       		 else if((""==wxxz1&&wxxz1!=0)||(""==wtd1&&wtd1==0)||(""==qy1&&qy1==0)||(""==xxd1&&xxd1==0)){
       			$.messager.alert("提示", "问题描述主因必填");
       			$('#'+id).linkbutton('enable');  
       			return;
       		}else if(zt==0||zt==""){
      			$.messager.alert("提示", "请选择判定处理方式");
      			$('#'+id).linkbutton('enable');  
      			return;
      		}
       			
       		}else   if(id=="save00") //登记     品检    维修完成    重判     发货  数据保存必填项提示
      		{//登记
	      		 if(""==dpbm){
	      			 $.messager.alert("提示", "店铺编码必选");
	      			 $('#'+id).linkbutton('enable');  
	      			 return;
	      		 }
	      		/* else	 if(""==sldg){
	      			 $.messager.alert("提示", "受理导购必填");return;
	      		 }else if(""==dglxdh){
	      			 $.messager.alert("提示", "导购联系电话必填");return;
	      		 }
	      		 */
	      		 else if(document.getElementById("isgkwx").checked == true)
	      			 {
		      			if(""==gkxm){
			      			 $.messager.alert("提示", "顾客姓名必填");
			      			 $('#'+id).linkbutton('enable');  
			      			 return;
			      		 }
			      		 else if(""==scsj){
			      			 $.messager.alert("提示", "售出时间必填");
			      			 $('#'+id).linkbutton('enable');  
			      			 return;
			      		 }
	      			 }
	      		else if(""==thrq){
	       			 $.messager.alert("提示", "退回时间必填");
	       			 $('#'+id).linkbutton('enable');  
	       			 return;
	       		 } else if(compareDate($('#scsj').datebox('getValue'),$('#thrq').datebox('getValue'))){
	        		 $.messager.alert("提示", "请检查售出时间必在退回日期之前");
	        		 $('#'+id).linkbutton('enable');  
	        		 return;
	        	 }else if(""==kh){
	      			 $.messager.alert("提示", "款号必填");
	      			 $('#'+id).linkbutton('enable');  
	      			 return;
	      		 }
	      		 else if(""==wtms){
	      			 $.messager.alert("提示", "问题描述必填");
	      			 $('#'+id).linkbutton('enable');  
	      			 return;
	      		 }
	      		 else if(""==ysgs){
	      			 $.messager.alert("提示", "运输公司必填");
	      			 $('#'+id).linkbutton('enable');  
	      			 return;
	      		 }
      		
      		}else if(id=="save10"){
      			//发到总部
      			if(ztold!="已发总部"){
      				$.messager.alert("提示", "当前状态不能临时保存");
      				 $('#'+id).linkbutton('enable');  
      				return;
      			}
      			
      		}else if(id=="save50"){
      			//发到总部
      			if(ztold!="维修中"){
      				$.messager.alert("提示", "当前状态不能临时保存");
      				 $('#'+id).linkbutton('enable');  
      				return;
      			}
      			
      		}else if(id=="save20"){
      			//品鉴判断
      			if(ztold!="已发总部"){
      				$.messager.alert("提示", "当前状态不能品鉴判定");
      				 $('#'+id).linkbutton('enable');  
      				return;
      			}
      			
      			if(zt==0||zt==""){
      				$.messager.alert("提示", "请选择判定处理方式");
      				 $('#'+id).linkbutton('enable');  
      				return;
      			}else{
      				if(zt==1){
      					zt=3;//产品退仓
      				}else if(zt==2){
      					zt=4;//不可以维修
      				}else if(zt==3){
      					zt=5;//可以维修
      				}
      			}
      			
      			if((""!=wxxz1&&wxxz1!=0)&&(""!=wtd1&&wtd1!=0)&&(""!=qy1&&qy1!=0)&&(""!=xxd1&&xxd1!=0)){
      				
      			}else{
      				$.messager.alert("提示", "问题描述主因必填");
      				 $('#'+id).linkbutton('enable');  
      				return;
      			}
      			
      		}else if(id=="save020"){
      			//从新判定
      			if(ztold=="产品退仓"||ztold=="不可维修待退店铺"||ztold=="维修中"){
      			}else{
      				$.messager.alert("提示", "当前状态不能重新判定");
      				 $('#'+id).linkbutton('enable');  
      				return;
      			}
      			
      		}else if(id=="save07"){
      			//维修完成
      			if(ztold!="维修中"){
      				$.messager.alert("提示", "当前状态不能确认");
      				 $('#'+id).linkbutton('enable');  
      				return;
      			}
      			if($('#zzwxd')!=undefined){
      				zzwxd = $("#zzwxd").combogrid("getText");;
      			}
      			
      			if($('#wxgys')!=undefined){
      				gysbh = $("#wxgys").combogrid("getValue");
      		      	gysmc = $("#wxgys").combogrid("getText");
      			}
      			
      			
      			
      			if($('#wxgys').combogrid('getText')!=""){
      				wxr = $('#wxgys').combogrid('getText');
      			}else if($('#wxr2').combogrid('getText')!=""){
      				wxr = $('#wxr2').combogrid('getText');
      			}else{wxr="";}
      			 
      			if($('#wxsj2').datebox('getValue')!=""){
      				wxsj = $('#wxsj2').datebox('getValue');
      			}else if($('#wxsj_gys').datebox('getValue')!=""){
      				wxsj = $('#wxsj_gys').datebox('getValue');
      			}else{wxsj="";}
      			
      			if(""==wxr){
      			$.messager.alert("提示", "维修人必填");
      			 $('#'+id).linkbutton('enable');  
      			return;
      			}
      			if(""==wxsj){
          			$.messager.alert("提示", "维修时间必填");
          			 $('#'+id).linkbutton('enable');  
          			return;
          			}
      			$('#wxwc').window('close');
      			
      		}else if(id=="save08"){
      			//总部发货
      			if(ztold=="维修完成"||ztold=="不可维修待退店铺"||ztold=="维修未完成"){
      				
      			}else{
      				$.messager.alert("提示", "当前状态不能发到店铺");
      				 $('#'+id).linkbutton('enable');  
      				return;
      			}
      	     	//总部发货数据
      	     	zbfh_ysgs = $('#zbfh_ysgs').combogrid('getText');
      	     	zbfh_ysdh = document.getElementById("zbfh_ysdh").value;
      	     	zbfh_shdz = document.getElementById("zbfh_shdz2").value;
      	     	zbfh_fhdz = document.getElementById("zbfh_fhdz2").value;
      	     	zbfh_shr = document.getElementById("zbfh_shr2").value;
      	     	zbfh_shrdh = document.getElementById("zbfh_shrdh2").value;
      	     	zbfh_bz = document.getElementById("zbfh_bz").value;
      			if(""==zbfh_ysgs){
         			 $.messager.alert("提示", "运输公司必填");
         			 $('#'+id).linkbutton('enable');  
         			 return;
         		 }else if(""==zbfh_ysdh){
         			 $.messager.alert("提示", "运输单号必填");
         			 $('#'+id).linkbutton('enable');  
         			 return;
         		 }
      			$('#win').window('close');
      		}
      	 
      	 //生成维修单号  exec GenerateCYWXDJBDH //俞晓东 改为保存的时候获取
      	
      	/* if((""==wxdh||"null"==wxdh)){
      		 $.post(	'rest/getWxdh/'+dpbm,
             function(wxdh1){
			     wxdh = wxdh1;
			     document.getElementById("wxdh").value=wxdh;
      		 	},'text'
             );
      	};*/
      		 
      			var params={'id':id,'guid':guid,'wxdh':wxdh,'zt':zt,'dpbm':dpbm,'dpmc':dpmc,'dplx':dplx,	'dzxm':dzxm,'dzlxdh':dzlxdh,	'wxcbm':wxcbm,'wxcmc':wxcmc	,'sldg':sldg,'dglxdh':dglxdh,'isgkwx':isgkwx,		
         	    	 'vipkh':vipkh,'gkxm':gkxm,	'gklxdh':gklxdh,'scsj':scsj,	'isffwx':isffwx,'jjcd':jjcd,
         	    	 'kh':kh,'thrq':thrq,'wtms':wtms,'branch':branch,'pp':pp,
         	    	 'ysgs':ysgs,'ydh':ydh,'fhdz':fhdz,'shdz':shdz,'shr':shr,'shrlxdh':shrlxdh,'bzxx':bzxx,
      			'wxxz1':wxxz1,'wtd1':wtd1,'qy1':qy1,'xxd1':xxd1,'wxbw':wxbw,  'wxxz2':wxxz2,'wtd2':wtd2,'qy2':qy2,'xxd2':xxd2,   
      			'pdclfs':pdclfs,'tccljg':tccljg,'zrbm':zrbm,'thdh':thdh,'jcyy':jcyy,
      			'nx':nx,'jhwxts':jhwxts,'sfsf':sfsf,'sfnr':sfnr,'pjpdbz':pjpdbz,'sfje':sfje,'zzwxd':zzwxd,
      			'wxr':wxr,'wxsj':wxsj,'zbfh_ysgs':zbfh_ysgs ,'zbfh_ysdh':zbfh_ysdh ,'zbfh_shdz':zbfh_shdz ,
      	     	'zbfh_fhdz':zbfh_fhdz ,'zbfh_shr':zbfh_shr ,'zbfh_shrdh':zbfh_shrdh ,'zbfh_bz':zbfh_bz,'gysbh':gysbh,'gysmc':gysmc,'wxjefw':wxjefw
      	     	};
      			
      			$.post(	'rest/saveRegister/save',
             		params,
             		function(reinfo){
      				var e = eval("(" + reinfo + ")");
	      				//
	      				//if(e[0].uuid!="uuid"){document.getElementById("guid").value=e[0].uuid;}
	      				 $('#'+id).linkbutton('enable');      				
	      				$.messager.alert("提示", e[0].tcjginfo);
	      				//alert(e[0].tcjginfo);
	      				if("save0123456"==id||"save00"==id){
	      				}else{
	      					if("save07"==id||"save08"==id){
	          					$('#wxwc').window('close');
	          					$('#wxwc_gys').window('close');
	          					$('#zbfh').window('close');
	          				}
	      					//保存成功    列表 数据是否刷新？  
	      					//window.parent.frames.getLib();
	      					//保存完毕 当前页详细数据刷新
	      					getDetail(guid,zt);
	      					
	      				}
      				//$('#mian').tabs('select','列表');
         	 },
             		 'text'
             		 ).error(function() {
             			$('#'+id).linkbutton('enable');
      					$.messager.alert("提示", "保存失败");
      		});	

      }
    
      
          //获取店铺信息
          function getdpvalue(depotid)
          {
         	 var ldplx,pp,com;
         	 $('#sldg').combogrid({
       			panelWidth:290,
       	 		mode:'remote',
       			idField:'TELEPHONE',
       			textField:'NAMES',  	
       			
       			url:'rest/getSldg/'+depotid,
       			method:'post',
       			onChange:function (idField){  
       				//alert(idField);
       				//getdpvalue(idField); // 
       				// var sldgs = eval("(" + sldgs + ")");
       				document.getElementById("dglxdh").value=idField;
       				
       			 },
       			columns:[[
       				{field:'EMPLOYEEID',title:'导购编号',width:90},
		  			{field:'NAMES',title:'导购名称',width:90},
		  			{field:'TELEPHONE',title:'联系电话',width:90}
       			]]
       		});
         	 
      		$.post(	'rest/getFilterdp/withCom',
      				{'depotid':depotid},function(queryfilter) {
      					var shops = eval("(" + queryfilter + ")");
      					//alert(shops[0].address);
      					if(null!=shops[0].D_NAME){document.getElementById("dpmc").value=shops[0].D_NAME;};
      					if(null!=shops[0].address){document.getElementById("fhdz").value=shops[0].address;};
      					if(null!=shops[0].R_NAME){document.getElementById("dzxm").value=shops[0].R_NAME;};
      					
      					if(null!=shops[0].TEL){document.getElementById("dzlxdh").value=shops[0].TEL;};
      				    
      					//if(null!=shops[0].m_type){document.getElementById("dplx").value=shops[0].M_TYPE;};
      				    if (shops[0].M_TYPE == "11")    
      				    {ldplx = "1";document.getElementById("dplx").value = "自营";}  
      				    else{ ldplx = "2";document.getElementById("dplx").value = "加盟";}
      				    pp=shops[0].BRANDID;
      				    com = shops[0].COM;
      				    $('#branch').attr('value',com);
      				    $('#pp').attr('value',pp); 
      								 
      				//维修仓 对应 店铺
      				     $.post(	'rest/getWxcdp/S2',
      								{'depotid':depotid},function(wxc) {
      									var wxcs = eval("(" + wxc + ")");
      									if(null!=wxcs[0].wxcbm){document.getElementById("wxcbm").value=wxcs[0].wxcbm;};
      									if(null!=wxcs[0].wxcmc){document.getElementById("wxcmc").value=wxcs[0].wxcmc;};
      									
      									$.post(	'rest/getFilterdp/S2',
      											{'depotid':wxcs[0].wxcbm},function(queryfilter) {
      											
      												var shops = eval("(" + queryfilter + ")");
      											
      												if(null!=shops[0].address){document.getElementById("shdz").value=shops[0].address;};
      												if(null!=shops[0].R_NAME){document.getElementById("shr").value=shops[0].R_NAME;};
      												if(null!=shops[0].TEL){document.getElementById("shrlxdh").value=shops[0].TEL;};
      												
      												}, 'text').error(function() {
      											$.messager.alert("提示", "信息获取失败");
      										});	      
      								}, 'text').error(function() {
      							$.messager.alert("提示", "信息获取失败");
      						});
      					    
      				}, 'text').error(function() {
      			$.messager.alert("提示", "信息获取失败");
      		});
      	    
      	}    
     

  
     //---------------------------------------------

        function checkKh(value){
      	  if(""==value){
      		  $.messager.alert("提示", "款号必填");
      	  }else 
      	  if(value.length<5){
      		$.messager.alert("提示", "款号太短");
      	  }else { 
      		  $.post(	'rest/checkKh/'+value,
          		 {'params':value},
          		 function(styleInfoString){	
          			 var styleInfo = eval("(" + styleInfoString + ")");
          			 if(styleInfo.length<1 || styleInfo[0].COLORID==''){
          				 $.messager.alert("提示","系统没有检测到这个款号","warning",function(){
          					document.getElementById("kh").value='';
  	        				// var oInput = document.getElementById("kh");
  			          	    //	oInput.focus();
          				 });  
  			              	
          			 }else{
          				loadDataForGys('gys',value,'',true);
          			 };
          			 /*else{
          			 document.getElementById("kh").value=styleInfo[0].;
          			 }*/
          		 },
          		 'text').error(function() {
           			$.messager.alert("提示", "信息获取失败");	
      	  });
      	
      	  }
        }
        
      //顾客维修改变子框的权限输入
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
		
		//初始化供应商信息
		function getGysInfo(combogridID,kh){
			if(kh==null || kh==''){
				$('#'+combogridID).combogrid({
	       			panelWidth:290,
	       			idField:'SupplierId',
	       			textField:'shutname', 
	       			columns:[[
	       				{field:'SupplierId',title:'供应商编号',width:90},
			  			{field:'shutname',title:'供应商简称',width:190}
	       			]]
	       		});
			} else{
				/*if(kh==null || kh==''){
					kh='0';
				}*/
				$('#'+combogridID).combogrid({
	       			panelWidth:290,
	       	 		mode:'remote',
	       			idField:'SupplierId',
	       			textField:'shutname',  	
	       			url:'rest/getGys/'+kh,
	       			method:'post',
	       			columns:[[
	       				{field:'SupplierId',title:'供应商编号',width:90},
			  			{field:'shutname',title:'供应商简称',width:190}
	       			]]
	       		});
			}
			
		}
		
		//加载供应商数据,combogridID控件ID；kh，款号，到尺码颜色；initValue，初始化值。,isInit是否需要初始化,如果true,那么如果initValue为空，那么默认选中第一行
		function loadDataForGys(combogridID,kh,initValue,isInit){
			$.post(	'rest/getGys/'+kh,
		          		 {'params':kh},
		          		 function(gysInfo){
		          			var gysListData = eval("(" + gysInfo + ")");
		          			
		          				if(gysListData.length==0 || gysListData[0].SupplierId==''){
			          				//$.messager.alert("提示","无法找到该款号的供应商信息");
			          			}else{
			          				$("#"+combogridID).combogrid("grid").datagrid("loadData", gysListData);
			          				if(initValue!=undefined && initValue!=null && initValue!='' && isInit){
			          					$("#"+combogridID).combogrid("setValue",initValue);
				          			}else{
				          				$("#"+combogridID).combogrid("setValue",gysListData[0].SupplierId);
				          			};
			          				
			          			};
		          			
		          			
		          			
		          		 },'text').error(function() {
		           			$.messager.alert("提示", "信息获取失败");
		          		 });
		}
		
		
		//设计主界面的维修金额
		function getWxjefw(){
			//var nx = $('#nx').attr('value');
			//var sfsf = $('#sfsf').attr('value');
			var nx = $('#nx').combobox('getValue');
			var sfsf = $('#sfsf').combobox('getValue');
			
			var xxd1 = $("#xxd1").combogrid("getValue");
			if(nx=='0' && sfsf=='1'){
				//$('#wxjefw').attr('disabled','disabled');
				$('#wxjefwtd').html('<input id="wxjefw" disabled="disabled" style="width:200px;"></input>');
				getNxwxje(xxd1);
				
				/*}else if(nx=='1' && sfsf=='1'){
				$('#wxjefw').attr('disabled','');
				$('#wxjefw').attr('value','0');*/
			}else if(nx=='1' && sfsf=='1'){
				if($('#kh').attr('value')!=null && $('#kh').attr('value')!=''){
					$('#wxjefw').attr('value','');
					getWxwxje($('#kh').attr('value'));
				}
			}else{
				$('#wxjefwtd').html('<input id="wxjefw" disabled="disabled" style="width:200px;"></input>');
				$('#wxjefw').validatebox({});
				$('#wxjefw').attr('value','');
				$('#wxjefw').validatebox('validate','false');
				
			};
		
			
		};
		
		
		//根据现象点获取内修维修金额
		function getNxwxje(xxd){
			$('#wxjefw').validatebox({});
			$.post('rest/getTybmb/wxjefw',
					{'parentCode':xxd},function(queryfilter){
						var wxjefw = eval("(" + queryfilter + ")");
						if(wxjefw.length>0){
							if(null!=wxjefw[0].fcontent){$('#wxjefw').attr('value',wxjefw[0].fcontent);};
						}else{
							$('#wxjefw').attr('value','');
						}
					}, 'text').error(function() {
					$.messager.alert("提示", "信息获取失败");});	      
		}
		 
		
		//获取外修维修金额
	      function getWxwxje(kh){
	    	 
	    	  $('#wxjefw').combobox({
	  			width:'200',
			    valueField:'fcontent',
			    textField:'fcontent',
			    url:'/gclm/rest/getTybmb/wxwxje?kh='+kh,
			    //data:{'kh':kh},
	    	  	method:'post'
			});
	    	  
	    	  $('#wxjefw').combobox('enable');
	      };
		