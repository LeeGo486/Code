//  ����ά����Ϣ
/**
ά�޵Ǽ� save00
�����ܲ� save10
Ʒ���ж� save20
�����ж� save020
ά����� save07
�ܲ����� save08
�������� save18
��ݵ���ӡ printkd
�ܲ���ӡ  printzb
*/
     function saveMaintain(zt){
    	 /* form t�ύ
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
    	 //�Ǽ���Ϣ
    	 
    	 guid,wxdh,dpbm,dpmc,dplx,	dzxm,dzlxdh,	wxcbm,wxcmc	,sldg,dglxdh,isgkwx,		
    	 vipkh,gkxm,	gklxdh,scsj,	isffwx,jjcd,
    	 kh,thrq,wtms,
    	 ysgs,ydh,fhdz,shdz,shr,shrlxdh,bzxx,
    	 //Ʒ���ж�����
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
    		 $.messager.alert("��ʾ", "����������Ϊ��");return;
    	 }else if(""==dglxdh){
    		 $.messager.alert("��ʾ", "������ϵ�绰����Ϊ��");return;
    	 }
    	 else if(""==gkxm){
    		 $.messager.alert("��ʾ", "�˿���������Ϊ��");return;
    	 }
    	 else if(""==scsj){
    		 $.messager.alert("��ʾ", "�۳�ʱ�䲻��Ϊ��");return;
    	 }
    	 else if(""==kh){
    		 $.messager.alert("��ʾ", "��Ų���Ϊ��");return;
    	 }
    	 else if(""==wtms){
    		 $.messager.alert("��ʾ", "���� ��������Ϊ��");return;
    	 }
    	 else if(""==ysgs){
    		 $.messager.alert("��ʾ", "��ѡ�����乫˾");return;
    	 };
    	 
     
    	 dpbm = $('#dpbm').combogrid('getText');
    	 //lert(dpbm);
    	 dpmc = document.getElementById("dpmc").value;
    	 if("��Ӫ"==document.getElementById("dplx").value)
    		 {    	dplx=1; 	 }
    	 else{    	dplx=2    	 }
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
    	 //Ʒ���ж�
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
    	 //�����ֶ����ɴ洢����    exec GenerateCYWXDJBDH
    	 if(""==wxdh||"null"==wxdh){
    		 $.post(	'rest/getWxdh/'+dpbm,
            		 function(wxdh){
    			//var wxbh1 = eval("(" + wxbh + ")");
    			document.getElementById("wxdh").value=wxdh;
    		
    			//����
    			var params={'guid':guid,'wxdh':wxdh,'zt':zt,'dpbm':dpbm,'dpmc':dpmc,'dplx':dplx,	'dzxm':dzxm,'dzlxdh':dzlxdh,	'wxcbm':wxcbm,'wxcmc':wxcmc	,'sldg':sldg,'dglxdh':dglxdh,'isgkwx':isgkwx,		
    		    	    	 'vipkh':vipkh,'gkxm':gkxm,	'gklxdh':gklxdh,'scsj':scsj,	'isffwx':isffwx,'jjcd':jjcd,
    		    	    	 'kh':kh,'thrq':thrq,'wtms':wtms,
    		    	    	 'ysgs':ysgs,'ydh':ydh,'fhdz':fhdz,'shdz':shdz,'shr':shr,'shrlxdh':shrlxdh,'bzxx':bzxx};
    			
    		
    			
    			$.post(	'rest/saveRegister/wxinfo',
    		        		 params,
    		        		 function(uuid){	
    		    		 document.getElementById("guid").value = uuid;
    		    		 $.messager.alert("��ʾ", "����ɹ�");
    		    	 },
    		        		 'text'
    		        		 ).error(function() {
    							$.messager.alert("��ʾ", "�������");
    						});	
    		    	 
    		 },
            		 'text'
            		 );
  		 };

     };