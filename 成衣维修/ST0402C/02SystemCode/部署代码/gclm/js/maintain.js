

 
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
            LODOP.SET_LICENSES("�㽭��Ө��װ���޹�˾", "853717765858688748719056235623", "", "");
            LODOP.PRINT_INIT("����ά�޵�");
            LODOP.PRINT_INITA(3,0,400,700,"����ά�޵�");
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

        //��ݵ�
        function kddPrint() {
        	
            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.SET_LICENSES("�㽭��Ө��װ���޹�˾", "853717765858688748719056235623", "", "");
            LODOP.PRINT_INIT("���");
            LODOP.PRINT_INITA(3,0,400,700,"��ݵ�");
            LODOP.PRINT_INIT("��ݵ�");
            LODOP.ADD_PRINT_TEXT(64,87,130,20,document.getElementById("zbfh_bzr").value);
            LODOP.ADD_PRINT_TEXT(90,427,100,20,document.getElementById("zbfh_shr").value);
            LODOP.ADD_PRINT_TEXT(92,598,100,20,document.getElementById("zbfh_shrdh").value);
            LODOP.ADD_PRINT_TEXT(135,133,100,20,"�㽭��Ө��װ���޹�˾");
            LODOP.ADD_PRINT_TEXT(137,427,100,20,document.getElementById("dpmc").value);
            LODOP.ADD_PRINT_TEXT(213,120,178,20,document.getElementById("zbfh_shdz").value);
            LODOP.ADD_PRINT_TEXT(212,426,100,20,document.getElementById("zbfh_fhdz").value);
            LODOP.ADD_PRINT_TEXT(241,120,179,20,document.getElementById("shrlxdh").value);
       
            LODOP.PREVIEW();
        };
        
         //�ܲ���ӡ
        

        function zbPrint() {
        	
        	var jg = $('#pdclfs').combobox('getValue');
        	
        	var jg1 ='<table width="700px" border="0" rules="all" style= "text-align: left; font-family: verdana,arial,sans-serif;  font-size:10pt; color:#000000; border-width: 1px;border-color: #666666; border-collapse: collapse; width: 100%; "><tr><td colspan="2"><input id="cptc" type="checkbox"  checked="checked">��Ʒ�˲�</input></td><td colspan="2"><input id="wfwx" type="checkbox">�Ѿ�ά�����</input></td></tr>'+
		        '<tr><td colspan="2"><input id="cptct" type="checkbox">��Ʒ�˲�(��)</input></td><td colspan="2"><input type="checkbox">�Ѿ�ά�����(��)</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox">�޷�ά�ޣ��Ļص���</input></td><td colspan="2"></td></tr></table>';

        	var jg2 ='<table width="700px" border="0" rules="all" style= "text-align: left; font-family: verdana,arial,sans-serif;  font-size:10pt; color:#000000; border-width: 1px;border-color: #666666; border-collapse: collapse; width: 100%; "><tr><td colspan="2"><input type="checkbox" >��Ʒ�˲�</input></td><td colspan="2"><input type="checkbox">�Ѿ�ά�����</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox">��Ʒ�˲�(��)</input></td><td colspan="2"><input type="checkbox">�Ѿ�ά�����(��)</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox">�޷�ά�ޣ��Ļص���</input></td><td colspan="2"></td></tr></table>';

        	var jg3 ='<table width="700px" border="0" rules="all" style= "text-align: left; font-family: verdana,arial,sans-serif;  font-size:10pt; color:#000000; border-width: 1px;border-color: #666666; border-collapse: collapse; width: 100%; "><tr><td colspan="2"><input  type="checkbox" >��Ʒ�˲�</input></td><td colspan="2"><input type="checkbox"  checked="checked">�Ѿ�ά�����</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox">��Ʒ�˲�(��)</input></td><td colspan="2"><input type="checkbox">�Ѿ�ά�����(��)</input></td></tr>'+
		        '<tr><td colspan="2"><input type="checkbox"  checked="checked">�޷�ά�ޣ��Ļص���</input></td><td colspan="2"></td></tr></table>';
			
			if(jg=='1'){
					document.getElementById('cljg').innerHTML = jg1;
				}else if(jg=='2'){
					document.getElementById('cljg').innerHTML = jg2;
				}else if(jg=='3'){
					document.getElementById('cljg').innerHTML = jg3;
				};  
				
            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
            LODOP.SET_LICENSES("�㽭��Ө��װ���޹�˾", "853717765858688748719056235623", "", "");
            LODOP.PRINT_INIT("��Ʒ�ۺ󷢻���");
            LODOP.PRINT_INITA(3,0,400,700,"��Ʒ�ۺ󷢻���");
          
            $("#thrq2").text($('#thrq').datebox('getValue'));
       
            LODOP.ADD_PRINT_HTM(0, 0, "95%", "95%", document.getElementById("zbprint").innerHTML);
            LODOP.PREVIEW();
        };
     //-------------------------------------------
      //��ϸҳ�� ����url���� ��ʼ��ҳ�� 
      function getDetail(guid,zt){
      	//var guid='<%out.print(request.getParameter("guid"));%>';
      	 $.post(	'rest/getDetail/S2',
      			{'guid':guid},function(detail) {
      					var e = eval("(" + detail + ")");
      					if(""==e){
      					}else{
      				//����ά�޵� ��ӡ����
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
          					
          					//�ܲ������� ��ӡ����
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
          					
          					
          					//�Ƿ�ͬ�⸶��ά��
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
          					
          			//��Ʒ�ۺ󷢻��� ��ӡ����
          					//document.getElementById("pp2").value=e[0].pp;
          					$("#pp2").text(e[0].pp);//jquery  ��ֵ����
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
          					
          		// �ܲ�����   ��ݵ�����
          					if(null!=e[0].zbfh_bzr){document.getElementById("zbfh_bzr").value=e[0].zbfh_bzr;};
          					if(null!=e[0].zbfh_shr){document.getElementById("zbfh_shr").value=e[0].zbfh_shr;};
          					if(null!=e[0].zbfh_shrdh){document.getElementById("zbfh_shrdh").value=e[0].zbfh_shrdh;};
          					if(null!=e[0].zbfh_fhdz){document.getElementById("zbfh_fhdz").value=e[0].zbfh_fhdz;};
          					if(null!=e[0].zbfh_shdz){document.getElementById("zbfh_shdz").value=e[0].zbfh_shdz;};
          					if(null!=e[0].shrlxdh){document.getElementById("shrlxdh").value=e[0].shrlxdh;};
          					
          		//�ܲ�����    ����������
          					if(null!=e[0].dpbm){document.getElementById("dpbmz").value=e[0].dpbm;};
          					if(null!=e[0].dpmc){document.getElementById("dpmcz").value=e[0].dpmc;};
          					if(null!=e[0].fhdz){document.getElementById("zbfh_shdz2").value=e[0].fhdz;};
          					if(null!=e[0].shdz){document.getElementById("zbfh_fhdz2").value=e[0].shdz;};
          					if(null!=e[0].dzxm){document.getElementById("zbfh_shr2").value=e[0].dzxm;};
          					if(null!=e[0].dzlxdh){document.getElementById("zbfh_shrdh2").value=e[0].dzlxdh;};
          		//��ϸ������
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
          					if(null!=e[0].scsj){$('#scsj').datebox('setValue',e[0].scsj)};
          					if(null!=e[0].isffwx){document.getElementById("isffwx").value=e[0].sftyffwx;};
          					
          					if(null!=e[0].jjcd){document.getElementById("jjcd").value=e[0].jjcd;};
          					if(null!=e[0].kh){document.getElementById("kh").value=e[0].kh;}; 
          					if(null!=e[0].thrq){$('#thrq').datebox('setValue',e[0].thrq)};
          					if(null!=e[0].wtms){document.getElementById("wtms").value=e[0].wtms;}; 
          					if(null!=e[0].ysgs){$('#ysgs').combogrid('setValue',e[0].ysgs);};
          					//if(null!=e[0].ysgs){document.getElementById("ysgs").value=e[0].ysgs;};
          					if(null!=e[0].ydh){document.getElementById("ydh").value=e[0].ydh;}; 
          					if(null!=e[0].fhdz){document.getElementById("fhdz").value=e[0].fhdz;};
          					if(null!=e[0].shdz){document.getElementById("shdz").value=e[0].shdz;}; 
          					if(null!=e[0].shr){document.getElementById("shr").value=e[0].shr;};
          					if(null!=e[0].shrlxdh){document.getElementById("shrlxdh").value=e[0].shrlxdh;};
          					if(null!=e[0].bzxx){document.getElementById("bzxx").value=e[0].bzxx;};
          					//��������
          					if(null!=e[0].wxxz1){$('#wxxz1').combobox('setValue',e[0].wxxz1)};
          				//	if(null!=e[0].wxxz1){document.getElementById("wxxz1").value=e[0].wxxz1;};
          					if(null!=e[0].wtd1){$('#wtd1').combogrid('setValue',e[0].wtd1)};
          					if(null!=e[0].qy1){$('#qy1').combogrid('setValue',e[0].qy1)};
          					if(null!=e[0].xxd1){$('#xxd1').combogrid('setValue',e[0].xxd1)};
          					
          					if(null!=e[0].wxxz2){$('#wxxz2').combobox('setValue',e[0].wxxz2)};
          					if(null!=e[0].wtd2){$('#wtd2').combogrid('setValue',e[0].wtd2)};
          					if(null!=e[0].qy2){$('#qy2').combogrid('setValue',e[0].qy2)};
          					if(null!=e[0].xxd2){$('#xxd2').combogrid('setValue',e[0].xxd2)};
          					
          					//if(null!=e[0].pdclfs){document.getElementById("pdclfs").value=e[0].pdclfs;};
          					if(null!=e[0].pdclfs){$('#pdclfs').combobox('setValue',e[0].pdclfs)};
          					
          					//if(null!=e[0].tccljg){document.getElementById("tccljg").value=e[0].tccljg;};
          					if(null!=e[0].tccljg){$('#tccljg').combogrid('setValue',e[0].tccljg)};
          					
          					//if(null!=e[0].zrbm){document.getElementById("zrbm").value=e[0].zrbm;};
          					if(null!=e[0].zrbm){$('#zrbm').combogrid('setValue',e[0].zrbm)};
          					
          					if(null!=e[0].thdh){document.getElementById("thdh").value=e[0].thdh;}; 
          					if(null!=e[0].jcyy){document.getElementById("jcyy").value=e[0].jcyy;};
          					
          					if(null!=e[0].nx){$('#nx').combobox('setValue',e[0].nx)};
          					//if(null!=e[0].jhwxts){document.getElementById("jhwxts").value=e[0].jhwxts;};
          					if(null!=e[0].jhwxts){$('#jhwxts').combogrid('setValue',e[0].jhwxts)};
          					
          					if(null!=e[0].sfsf){$('#sfsf').combobox('setValue',e[0].sfsf)};
          					if(null!=e[0].sfje){document.getElementById("sfje").value=e[0].sfje;};
          					if(null!=e[0].sfnr){document.getElementById("sfnr").value=e[0].sfnr;};
          					if(null!=e[0].pjpdbz){document.getElementById("pjpdbz").value=e[0].pjpdbz;};
          					if(null!=e[0].wxr){document.getElementById("wxr").value=e[0].wxr;};
          					if(null!=e[0].wxsj){document.getElementById("wxsj").value=e[0].wxsj;};
          					
          					
          					if(null!=e[0].djr){document.getElementById("djr").value=e[0].djr;};
          					if(null!=e[0].djsj){document.getElementById("djsj").value=e[0].djsj;};
          					if(null!=e[0].pjpdr){document.getElementById("pjpdr").value=e[0].pjpdr;};
          					if(null!=e[0].pjpdsj){document.getElementById("pjpdsj").value=e[0].pjpdsj;};
          					
          					if(null!=e[0].ttspr){document.getElementById("ttspr").value=e[0].ttspr;};
          					if(null!=e[0].txspsj){document.getElementById("spsj").value=e[0].txspsj;};
          					if(null!=e[0].wxqrr){document.getElementById("wxqrr").value=e[0].wxqrr;};
          					if(null!=e[0].wxqrsj){document.getElementById("qrsj").value=e[0].wxqrsj;};
          					
      					}
      					
      					
      					}, 'text').error(function() {
      				$.messager.alert("��ʾ", "��Ϣ��ȡʧ��");
      			});	

      	
      	 $.post(	'rest/getFilterzt/'+zt,
      	 {'zt':zt},function(zt) {
      			var e = eval("(" + zt + ")");
      			if(null!=e[0].mc){document.getElementById("zt").value=e[0].mc;};
      		})
      	 
      		$('#dpbm').combogrid({
      			panelWidth:430,
      	 		mode:'remote',
      			idField:'depotid',
      			textField:'depotid',
      			url:'rest/getFilterdp/S2',
      			method:'post',
      			onChange:function (idField){  
      				getdpvalue(idField); // ������Ϣ
      			 },
      			columns:[[
      				{field:'depotid',title:'���̱��',width:90},
      				{field:'dname',title:'��������',width:160},
      				{field:'address',title:'��ַ',width:160}
      			]]
      		});
      	} 

      	
      //����ά����Ϣ
      function saveMaintain(id,zt){
    	 //alert(zt);return;
      	 var 
      	 //ά�޵ǼǮ�
      	 ztold,
      	 guid,wxdh,dpbm,dpmc,dplx,	dzxm,dzlxdh,	wxcbm,wxcmc	,sldg,dglxdh,isgkwx,		
      	 vipkh,gkxm,	gklxdh,scsj,	isffwx,jjcd,
      	 kh,thrq,wtms,
      	 ysgs,ydh,fhdz,shdz,shr,shrlxdh,bzxx,
      	 //Ʒ��  �ж�
      	 wxxz1,wtd1,qy1,xxd1,   wxxz2,wtd2,qy2,xxd2,   
      	 pdclfs,tccljg,zrbm,thdh,jcyy,
      	 nx,jhwxts,sfsf,sfje,sfnr,pjpdbz,
      	 wxr,wxsj,
      	 zbfh_ysgs ,zbfh_ysdh ,zbfh_shdz ,
     	zbfh_fhdz ,zbfh_shr ,zbfh_shrdh ,zbfh_bz ;
      	 
      	 
      	 guid=document.getElementById("guid").value;
      	 ztold=document.getElementById("zt").value;
      	 //alert(ztold);
      	 sldg = $('#sldg').combogrid('getText');
      	 dglxdh = document.getElementById("dglxdh").value;
      	 gkxm = document.getElementById("gkxm").value;
      	 scsj =  $('#scsj').datebox('getValue');
      	 kh = document.getElementById("kh").value;
      	 wtms = document.getElementById("wtms").value;	
      	 ysgs = $('#ysgs').combogrid('getText');	
      	
      	 dpbm = $('#dpbm').combogrid('getText');
      	 dpmc = document.getElementById("dpmc").value;
      	if("��Ӫ"==document.getElementById("dplx").value)
      		 {    	dplx=1; 	 }    	 else{    	dplx=2    	 }

      	// dplx = document.getElementById("dplx").value;
      	 dzxm = document.getElementById("dzxm").value;
      	 dzlxdh = document.getElementById("dzlxdh").value;
      	 wxcbm = document.getElementById("wxcbm").value;
      	 wxcmc = document.getElementById("wxcmc").value;
      	 wxdh=document.getElementById("wxdh").value;
      	 //�Ƿ�˿�ά��
      	 if(document.getElementById("isgkwx").checked)
      	 	{   isgkwx = 1;     }
      	 else{	isgkwx = 0;		};

      	 vipkh = document.getElementById("vipkh").value;
      	 gklxdh = document.getElementById("gklxdh").value;
      	 //�Ƿ񸶷�ά��
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
      	 //��������
      	 wxxz1 = $('#wxxz1').combobox('getValue');
      	 wtd1 = $('#wtd1').combogrid('getValue');//document.getElementById("wtd1").value;
      	 qy1 = $('#qy1').combogrid('getValue');
      	 xxd1 = $('#xxd1').combogrid('getValue');
      	 
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
      	 sfje = document.getElementById("sfje").value;
      	 sfnr = document.getElementById("sfnr").value;
      	 pjpdbz = document.getElementById("pjpdbz").value;
      	// alert(ztold+"ssss"+zt);return;
      	
      	//�Ǽ�     Ʒ��    ά�����    ����     ����  ���ݱ����������ʾ
       	 if(id=="save0123456")
       		{
       	//Ʒ���ж�
				if(zt==1){
					zt=3;//��Ʒ�˲�
				}else if(zt==2){
					zt=4;//������ά��
				}else if(zt==3){
					zt=5;//����ά��
				}
       		 
       		 //�Ǽ�
       		 if(""==dpbm){
       			 $.messager.alert("��ʾ", "���̱����ѡ");return;
       		 }else	 if(""==sldg){
       			 $.messager.alert("��ʾ", "����������");return;
       		 }else if(""==dglxdh){
       			 $.messager.alert("��ʾ", "������ϵ�绰����");return;
       		 }
       		 else if(document.getElementById("isgkwx").checked == true)
  			 { 
		       	  if(""==gkxm){
		       			 $.messager.alert("��ʾ", "�˿���������");return;
		       		 }
		       		 else if(""==scsj){
		       			 $.messager.alert("��ʾ", "�۳�ʱ�����");return;
		       		 } 
  			 }
       		 else if(""==thrq){
       			 $.messager.alert("��ʾ", "�˻�ʱ�����");return;
       		 } else if(compareDate($('#scsj').datebox('getValue'),$('#thrq').datebox('getValue'))){
        		 $.messager.alert("��ʾ", "�����۳�ʱ������˻�����֮ǰ");return;
        	 }else if(""==kh){
       			 $.messager.alert("��ʾ", "��ű���");return;
       		 }else if(kh.length<5){
       			 $.messager.alert("��ʾ", "���̫��");return;
       		 }
       		 else if(""==wtms){
       			 $.messager.alert("��ʾ", "������������");return;
       		 }
       		/* else if(""==ysgs){
       			 $.messager.alert("��ʾ", "���乫˾����");return;
       		 }*/
       		 else if((""==wxxz1&&wxxz1!=0)||(""==wtd1&&wtd1==0)||(""==qy1&&qy1==0)||(""==xxd1&&xxd1==0)){
       			$.messager.alert("��ʾ", "���������������");return;
       		}else if(zt==0||zt==""){
      			$.messager.alert("��ʾ", "��ѡ���ж�����ʽ");return;
      		}
       			
       		}else   if(id=="save00") //�Ǽ�     Ʒ��    ά�����    ����     ����  ���ݱ����������ʾ
      		{//�Ǽ�
	      		 if(""==dpbm){
	      			 $.messager.alert("��ʾ", "���̱����ѡ");return;
	      		 }else	 if(""==sldg){
	      			 $.messager.alert("��ʾ", "����������");return;
	      		 }else if(""==dglxdh){
	      			 $.messager.alert("��ʾ", "������ϵ�绰����");return;
	      		 }
	      		 else if(document.getElementById("isgkwx").checked == true)
	      			 {
		      			if(""==gkxm){
			      			 $.messager.alert("��ʾ", "�˿���������");return;
			      		 }
			      		 else if(""==scsj){
			      			 $.messager.alert("��ʾ", "�۳�ʱ�����");return;
			      		 }
	      			 }
	      		else if(""==thrq){
	       			 $.messager.alert("��ʾ", "�˻�ʱ�����");return;
	       		 } else if(compareDate($('#scsj').datebox('getValue'),$('#thrq').datebox('getValue'))){
	        		 $.messager.alert("��ʾ", "�����۳�ʱ������˻�����֮ǰ");return;
	        	 }else if(""==kh){
	      			 $.messager.alert("��ʾ", "��ű���");return;
	      		 }
	      		 else if(""==wtms){
	      			 $.messager.alert("��ʾ", "������������");return;
	      		 }
	      		 else if(""==ysgs){
	      			 $.messager.alert("��ʾ", "���乫˾����");return;
	      		 }
      		
      		}else if(id=="save10"){
      			//�����ܲ�
      			if(ztold!="�Ǽ�"){
      				$.messager.alert("��ʾ", "��ǰ״̬���ܷ����ܲ�");return;
      			}
      			
      		}else if(id=="save20"){
      			//Ʒ���ж�
      			if(ztold!="�ѷ��ܲ�"){
      				$.messager.alert("��ʾ", "��ǰ״̬����Ʒ���ж�");return;
      			}
      			
      			if(zt==0||zt==""){
      				$.messager.alert("��ʾ", "��ѡ���ж�����ʽ");return;
      			}else{
      				if(zt==1){
      					zt=3;//��Ʒ�˲�
      				}else if(zt==2){
      					zt=4;//������ά��
      				}else if(zt==3){
      					zt=5;//����ά��
      				}
      			}
      			
      			if((""!=wxxz1&&wxxz1!=0)&&(""!=wtd1&&wtd1!=0)&&(""!=qy1&&qy1!=0)&&(""!=xxd1&&xxd1!=0)){
      				
      			}else{
      				$.messager.alert("��ʾ", "���������������");return;
      			}
      			
      		}else if(id=="save020"){
      			//�����ж�
      			if(ztold=="��Ʒ�˲�"||ztold=="����ά�޴��˵���"||ztold=="ά����"){
      			}else{
      				$.messager.alert("��ʾ", "��ǰ״̬���������ж�");return;
      			}
      			
      		}else if(id=="save07"){
      			//ά�����
      			if(ztold!="ά����"){
      				$.messager.alert("��ʾ", "��ǰ״̬����ȷ��");return;
      			}
      			
      			if($('#gys').combogrid('getText')!=""){
      				wxr = $('#gys').combogrid('getText');
      			}else if($('#wxr2').combogrid('getText')!=""){
      				wxr = $('#wxr2').combogrid('getText');
      			}else{wxr="";}
      			 
      			if($('#wxsj2').datebox('getValue')!=""){
      				wxsj = $('#wxsj2').datebox('getValue');
      			}else if($('#wxsj_gys').datebox('getValue')!=""){
      				wxsj = $('#wxsj_gys').datebox('getValue');
      			}else{wxsj="";}
      			
      			if(""==wxr){
      			$.messager.alert("��ʾ", "ά���˱���");return;
      			}
      			if(""==wxsj){
          			$.messager.alert("��ʾ", "ά��ʱ�����");return;
          			}
      			$('#wxwc').window('close');
      			
      		}else if(id=="save08"){
      			//�ܲ�����
      			if(ztold=="ά�����"||ztold=="����ά�޴��˵���"||ztold=="ά��δ���"){
      				
      			}else{
      				$.messager.alert("��ʾ", "��ǰ״̬���ܷ�������");return;
      			}
      	     	//�ܲ���������
      	     	zbfh_ysgs = $('#zbfh_ysgs').combogrid('getText');
      	     	zbfh_ysdh = document.getElementById("zbfh_ysdh").value;
      	     	zbfh_shdz = document.getElementById("zbfh_shdz2").value;
      	     	zbfh_fhdz = document.getElementById("zbfh_fhdz2").value;
      	     	zbfh_shr = document.getElementById("zbfh_shr2").value;
      	     	zbfh_shrdh = document.getElementById("zbfh_shrdh2").value;
      	     	zbfh_bz = document.getElementById("zbfh_bz").value;
      			if(""==zbfh_ysgs){
         			 $.messager.alert("��ʾ", "���乫˾����");return;
         		 }else if(""==zbfh_ysdh){
         			 $.messager.alert("��ʾ", "���䵥�ű���");return;
         		 }
      			$('#win').window('close');
      		}
      	 
      	 //����ά�޵���  exec GenerateCYWXDJBDH
      	
      	 if((""==wxdh||"null"==wxdh)){
      		 $.post(	'rest/getWxdh/'+dpbm,
             function(wxdh1){
			     wxdh = wxdh1;
			     document.getElementById("wxdh").value=wxdh;
      		 	},'text'
             );
      	};
      		 
      			var params={'id':id,'guid':guid,'wxdh':wxdh,'zt':zt,'dpbm':dpbm,'dpmc':dpmc,'dplx':dplx,	'dzxm':dzxm,'dzlxdh':dzlxdh,	'wxcbm':wxcbm,'wxcmc':wxcmc	,'sldg':sldg,'dglxdh':dglxdh,'isgkwx':isgkwx,		
         	    	 'vipkh':vipkh,'gkxm':gkxm,	'gklxdh':gklxdh,'scsj':scsj,	'isffwx':isffwx,'jjcd':jjcd,
         	    	 'kh':kh,'thrq':thrq,'wtms':wtms,
         	    	 'ysgs':ysgs,'ydh':ydh,'fhdz':fhdz,'shdz':shdz,'shr':shr,'shrlxdh':shrlxdh,'bzxx':bzxx,
      			'wxxz1':wxxz1,'wtd1':wtd1,'qy1':qy1,'xxd1':xxd1,   'wxxz2':wxxz2,'wtd2':wtd2,'qy2':qy2,'xxd2':xxd2,   
      			'pdclfs':pdclfs,'tccljg':tccljg,'zrbm':zrbm,'thdh':thdh,'jcyy':jcyy,
      			'nx':nx,'jhwxts':jhwxts,'sfsf':sfsf,'sfje':sfje,'sfnr':sfnr,'pjpdbz':pjpdbz,
      			'wxr':wxr,'wxsj':wxsj,'zbfh_ysgs':zbfh_ysgs ,'zbfh_ysdh':zbfh_ysdh ,'zbfh_shdz':zbfh_shdz ,
      	     	'zbfh_fhdz':zbfh_fhdz ,'zbfh_shr':zbfh_shr ,'zbfh_shrdh':zbfh_shrdh ,'zbfh_bz':zbfh_bz
      	     	};
      			
      			$.post(	'rest/saveRegister/save',
             		params,
             		function(reinfo){
      				var e = eval("(" + reinfo + ")");
      				if(e[0].uuid!="uuid"){document.getElementById("guid").value=e[0].uuid;}
      				$.messager.alert("��ʾ", e[0].tcjginfo);
      				
      				
      				if("save0123456"==id||"save00"==id){
      				}else{
      					if("save07"==id||"save08"==id){
          					$('#wxwc').window('close');
          					$('#wxwc_gys').window('close');
          					$('#zbfh').window('close');
          				}
      					//����ɹ�    �б� �����Ƿ�ˢ�£�  
      					//window.parent.frames.getLib();
      					getDetail(guid,zt)
      					
      				}
      				//$('#mian').tabs('select','�б�');
         	 },
             		 'text'
             		 ).error(function() {
      					$.messager.alert("��ʾ", "����ʧ��");
      		});	

      }
    
      
          //��ȡ������Ϣ
          function getdpvalue(depotid)
          {
         	 var ldplx,pp;
         	 $('#sldg').combogrid({
       			panelWidth:290,
       	 		mode:'remote',
       			idField:'telephone',
       			textField:'names',  	
       			
       			url:'rest/getSldg/'+depotid,
       			method:'post',
       			onChange:function (idField){  
       				//alert(idField);
       				//getdpvalue(idField); // 
       				// var sldgs = eval("(" + sldgs + ")");
       				document.getElementById("dglxdh").value=idField;
       				
       			 },
       			columns:[[
       				{field:'employeeid',title:'Ա������',width:90},
       				{field:'names',title:'����',width:90},
       				{field:'telephone',title:'�绰',width:90}
       			]]
       		});
         	 
      		$.post(	'rest/getFilterdp/S2',
      				{'depotid':depotid},function(queryfilter) {
      					var shops = eval("(" + queryfilter + ")");
      					alert(shops[0].address);
      					if(null!=shops[0].dname){document.getElementById("dpmc").value=shops[0].dname;};
      					if(null!=shops[0].address){document.getElementById("fhdz").value=shops[0].address;};
      					if(null!=shops[0].r_name){document.getElementById("dzxm").value=shops[0].r_name;};
      					
      					if(null!=shops[0].Tel){document.getElementById("dzlxdh").value=shops[0].Tel;};
      				    
      					if(null!=shops[0].m_type){document.getElementById("dplx").value=shops[0].m_type;};
      				    if (shops[0].m_type == "11")    
      				    {ldplx = "1";document.getElementById("dplx").value = "��Ӫ";}  
      				    else{ ldplx = "2";document.getElementById("dplx").value = "����";}
      				     pp=shops[0].brandid;
      					
      					 
      								 
      				//ά�޲� ��Ӧ ����
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
      											$.messager.alert("��ʾ", "��Ϣ��ȡʧ��");
      										});	      
      								}, 'text').error(function() {
      							$.messager.alert("��ʾ", "��Ϣ��ȡʧ��");
      						});
      					    
      				}, 'text').error(function() {
      			$.messager.alert("��ʾ", "��Ϣ��ȡʧ��");
      		});
      	    
      	}    
     

  
     //---------------------------------------------

        function checkKh(value){
      	  if(""==value){
      		  $.messager.alert("��ʾ", "��ű���");
      	  }else 
      	  if(value.length<5){
      		$.messager.alert("��ʾ", "���̫��");
      	  }else { 
      		  $.post(	'rest/checkKh/'+value,
          		 {'params':value},
          		 function(newkh){	
          			 
          			 if("wu"==newkh){
          				 $.messager.alert("��ʾ","ϵͳû�м�⵽������","warning",function(){
          					
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
      	
         }
        
        
      //�˿�ά�޸ı��ӿ��Ȩ������
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
		
		
        
        //��ȡ������Ϣ
        function getdpvalue(depotid)
        {
       	 var ldplx,pp;
       	 $('#sldg').combogrid({
     			panelWidth:290,
     	 		mode:'remote',
     			idField:'telephone',
     			textField:'names',  	
     			
     			url:'rest/getSldg/'+depotid,
     			method:'post',
     			onChange:function (idField){  
     				//alert(idField);
     				//getdpvalue(idField); // 
     				// var sldgs = eval("(" + sldgs + ")");
     				document.getElementById("dglxdh").value=idField;
     				
     			 },
     			columns:[[
     				{field:'employeeid',title:'Ա������',width:90},
     				{field:'names',title:'����',width:90},
     				{field:'telephone',title:'�绰',width:90}
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
    				    {ldplx = "1";document.getElementById("dplx").value = "��Ӫ";}  
    				    else{ ldplx = "2";document.getElementById("dplx").value = "����";}
    				     pp=shops[0].brandid;
    				//     alert(pp+ldplx);
    					
    					 
    								 
    				//ά�޲� ��Ӧ ����
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
    											$.messager.alert("��ʾ", "��Ϣ��ȡʧ��");
    										});	      
    								}, 'text').error(function() {
    							$.messager.alert("��ʾ", "��Ϣ��ȡʧ��");
    						});
    					    
    				}, 'text').error(function() {
    			$.messager.alert("��ʾ", "��Ϣ��ȡʧ��");
    		});
    	    
    	}    