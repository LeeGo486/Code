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
    <title>ά�޵Ǽ���ϸ</title>
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
    			idField:'DEPOTID',
    			textField:'DEPOTID',
    			url:'<%=path%>/rest/getFilterdp/S1',
    			method:'post',
    			onChange:function (idField){  
    				getdpvalue(idField); // ���ص��������Ϣ
    			 },
    			columns:[[
    				{field:'DEPOTID',title:'���̱��',width:90},
    				{field:'D_NAME',title:'��������',width:160},
    				{field:'address',title:'��ַ',width:160}
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
      				{field:'bm',title:'����',width:50},
      				{field:'mc',title:'����',width:70},
      				{field:'lxdh',title:'��ϵ�绰',width:90},
      				{field:'lxr',title:'��ϵ��',width:90}
      		
      			]]
      		});
      		
      		
      		//�ܲ����� ���乫˾
      		$('#zbfh_ysgs').combogrid({
      			panelWidth:310,
      	 		mode:'remote',
      			idField:'mc',
      			textField:'mc',
      			url:'rest/getYsgs/S2',
      			method:'post',
      			columns:[[
      				{field:'bm',title:'����',width:50},
      				{field:'mc',title:'����',width:70},
      				{field:'lxdh',title:'��ϵ�绰',width:90},
      				{field:'lxr',title:'��ϵ��',width:90}
      			]]
      		});
      		
      		//ά��ʱ��2
         	 var d,myDate;
         	  d = new Date();
         	  myDate = d.getFullYear() + "-";            
         	  myDate = myDate + (d.getMonth() + 1) + "-";
         	  myDate += d.getDate() + " ";     
         	  
      	  $('#wxsj2').datebox({
              formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
              parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
              });  
      	//�۳�ʱ��
       	 $('#scsj').datebox({
              formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
              parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); },
              onSelect: function(date){
             	 if(compareDate($('#scsj').datebox('getValue'),$('#thrq').datebox('getValue'))){
             		 $.messager.alert("��ʾ", "�����۳�ʱ������˻�����֮ǰ");return;
             	 }
              }

              });    
       	 //�˻�����
       	  $('#thrq').datebox({
               formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
               parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
       	  }); 
 	      	 var d,date;
 	     	  d = new Date();
 	     	  date = d.getFullYear() + "-";            
 	     	  date = date + (d.getMonth() + 1) + "-";
 	     	  date += d.getDate() + " ";     
 	     	$('#thrq').datebox('setValue',date);
      	
      	  
      	  	//��ʼ����Ӧ���б�
      	  	getGysInfo('gys',$('#kh').attr('value'));
      	   /* 	$('#gys').combogrid({
	       			panelWidth:290,
	       	 		mode:'remote',
	       			idField:'SupplierId',
	       			textField:'shutname',  	
	       			url:'rest/getGys/0',
	       			method:'post',
	       			columns:[[
	       				{field:'SupplierId',title:'��Ӧ�̱��',width:90},
			  			{field:'shutname',title:'��Ӧ�̼��',width:190}
	       			]]
	       		}); */

      	//Ʒ���ж�   
          //��������  ����
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

         //�������  ����
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

                	
			           
			     //ά���� 
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
                	
                	//�˲ִ�����
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
              		//���β���
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
              	 //�ƻ�ά������
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

              	//�ж�����ʽ
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
                   				if(id==3){//����ά��
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
              
               //�Ƿ��շ�
                   		$('#sfsf').combobox({
                   			onChange:function (id){  
                   				if(id==1){
                   					getWxjefw();
                   					document.getElementById("wxjefw").disabled=false;
                   					document.getElementById("sfnr").disabled=false;
                   				}
                   				if(id==0){
                   					$('#wxjefw').attr('value','');
                   					document.getElementById("wxjefw").disabled=true;
                   					document.getElementById("sfnr").disabled=true;
                   				}
                   			}
                   		});   	
 	
         
 	});
     

     
     //��ȡ������Ϣ
     function getdpvalue(depotid)
     {
    	 var ldplx,pp,com;
		// if(!isNaN(depotid)){
				 	$('#sldg').combogrid({
		  			panelWidth:290,
		  	 		mode:'remote',
		  			idField:'TELEPHONE',
		  			textField:'NAMES',  	
		  			url:'<%=path%>/rest/getSldg/'+depotid,
		  			method:'post',
		  			onChange:function (idField){  
		  				document.getElementById("dglxdh").value=idField;
		  			 },
		  			columns:[[
		  				{field:'EMPLOYEEID',title:'�������',width:90},
		  				{field:'NAMES',title:'��������',width:90},
		  				{field:'TELEPHONE',title:'��ϵ�绰',width:90}
		  			]]
		  		});
			//}
		//else{alert('���Ĳ������ﵼ��')}
    	
    	 
		$.post(	'rest/getFilterdp/withCom',
				{'depotid':depotid},function(queryfilter) {
					var shops = eval("(" + queryfilter + ")");
					if(null!=shops[0].D_NAME){document.getElementById("dpmc").value=shops[0].D_NAME;};
					if(null!=shops[0].address){document.getElementById("fhdz").value=shops[0].address;};
					if(null!=shops[0].R_NAME){document.getElementById("dzxm").value=shops[0].R_NAME;};
					
					if(null!=shops[0].TEL){document.getElementById("dzlxdh").value=shops[0].TEL;};
				      if (shops[0].M_TYPE == "11")
				        {ldplx = "1";document.getElementById("dplx").value = "��Ӫ";}
				      else{ ldplx = "2";document.getElementById("dplx").value = "����";}
				     pp=shops[0].BRANDID;
				     com = shops[0].COM;
				//     alert(pp+ldplx);
								 
					$('#branch').attr('value',com);
					$('#pp').attr('value',pp);
				
				//���̶�Ӧά�޲���Ϣ
				     $.post(	'rest/getWxcdp/S2',
								{'depotid':depotid},function(wxc) {
									
									var wxcs = eval("(" + wxc + ")");
									if(wxcs.length>0){
											
										if(null!=wxcs[0].wxcbm){document.getElementById("wxcbm").value=wxcs[0].wxcbm;};
										if(null!=wxcs[0].wxcmc){document.getElementById("wxcmc").value=wxcs[0].wxcmc;};
									}
									
									$.post(	'rest/getFilterdp/S2',
											{'depotid':wxcs[0].wxcbm},function(queryfilter) {
												var shops = eval("(" + queryfilter + ")");
												if(null!=shops[0].address){document.getElementById("shdz").value=shops[0].address;};
												if(null!=shops[0].R_NAME){document.getElementById("shr").value=shops[0].R_NAME;};
												if(null!=shops[0].TEL){document.getElementById("shrlxdh").value=shops[0].TEL;};
												
												}, 'text').error(function() {
											$.messager.alert("��ʾ", "ѡ����̳���");
										});	      
								}, 'text').error(function() {
							$.messager.alert("��ʾ", "ѡ����̳���");
						});
					    
				}, 'text').error(function() {
			$.messager.alert("��ʾ", "ѡ����̳���");
		});
	    
	}
     
     
     
 
      </script>
   
  <style type="text/css">
  
</style>

  </head>
  
  <body>
  
  	<input type="hidden" id="branch" name="branch" value="">
  	<input type="hidden" id="pp" name="pp" value="">
 
 
  <div  id="header">
    <a id="save0123456" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveMaintain(id,$('#pdclfs').combobox('getValue'))">�Ǽ��ж�</a>
    <!--  <a id="save00" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveMaintain(id,0)">�ǼǱ���</a> -->
 <%--<a id="printdp" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="dpPrint()">���̴�ӡ</a>
 <a id="printzb" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="zbPrint()">�ܲ���ӡ</a>
 <a id="printkdd" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="kddPrint()">��ݵ���ӡ</a>  
	  --%>
	  <input type="text" readonly="readonly" value="�Ǽ��ж�" style="text-align:right;font-size: 17pt;font-family:'΢���ź�';" id="zt" width="100%" height="100%"/>
	  
	  </div>    
	<div style="background:#fafafa;padding-top:40px">
	    <form id="ff" method="post" >
	    <table class="gridtable">
		    <tr class="head" ><td colspan="3"><input id="guid" type="hidden" value="<%out.print(request.getParameter("guid"));%>"></input></td><td><label >ά�޵���:</label></td><td colspan="2"><input id="wxdh" disabled="disabled"></input></td></tr>
		     
		     <tr><th rowspan="3" >������Ϣ</th>	<th>���̱���</th><td width="200"><select id="dpbm" style="width: 200px;border:1px solid #fffffb;" class="easyui-combogrid"></select> </td><th width="170">��������</th><td><input width="170px" id="dpmc" type="text"></input></td><td width="30"><input ID="dplx" width="30" disabled="disabled"></input> </td></tr>
		     <tr>							<th>�곤����</th><td><input id="dzxm"></input></td><th>�곤��ϵ�绰</th><td colspan="2"><input id="dzlxdh" ></input</td></tr>
		     <tr>							<th>ά�޲ֱ��</th><td><input id="wxcbm" disabled="disabled"></input></td><th>ά�޲�����</th><td colspan="2"><input id="wxcmc" disabled="disabled"></input></td></tr>
		     
		     <tr><th rowspan="2">ά�޽ӵ���Ϣ</th><th>������</th><td><input id="sldg" style="width: 200px;" class="easyui-combogrid"></input></td><th>������ϵ�绰</th><td colspan="2"><input id="dglxdh"></input></td></tr>
		     <tr>		<th>�˿�ά��</th><td colspan="4"><input type="checkbox" id="isgkwx" value="1" style="width: 20px;" checked="checked" onchange="isGkwx()" />  </td></tr>
		     
		    <tr><th rowspan="3">�˿���Ϣ</th>	<th>VIP����</th><td><input id="vipkh" ></input></td><th>�˿�����*</th><td colspan="2"><input id="gkxm"  ></input></td></tr>
		    <tr>							<th>�˿���ϵ�绰</th><td><input id="gklxdh"></input></td><th>�۳�ʱ��*</th><td colspan="2"><input id="scsj" class="easyui-datebox"  style="width: 200px;"></input></td></tr>
		    <tr>							<th>ͬ�⸶��ά��</th><td><input type="checkbox" id="isffwx" value="1" style="width: 20px;"  /> </td><th>�����̶�</th><td colspan="2"><select id="jjcd" class="easyui-combobox" style="width:200px;" >
												<option value="00"> </option><option value="01">һ��</option><option value="02">����</option><option value="03">�ǳ���</option></select></td></tr>
		    
		    <tr><th rowspan="3">���޲�Ʒ��Ϣ</th>	<th>���*</th><td><input id="kh" onBlur="checkKh(value)"></input></td><th>�˻�����</th><td colspan="2" ><input id="thrq" class="easyui-datebox" style="width: 200px;"></input></td></tr>
		    <tr>								<th>��Ӧ��</th><td colspan="4"><select id="gys" name="gys" style="width: 200px;"></select> </td></tr>
		    <tr>								<th>��������*</th><td colspan="4"><textarea id="wtms" style="height:60px;width: 600px"></textarea></td></tr>
		    
		    <tr><th rowspan="4">������Ϣ</th>	<th>���乫˾</th><td><input id="ysgs"  style="width: 200px;" class="easyui-combogrid"></input></td><th>�˵���</th><td colspan="2"><input id="ydh"></input></td></tr>
		    <tr>							<th>������ַ</th><td colspan="4"><input id="fhdz"></input></td></tr>
		    <tr>							<th>�ջ���ַ</th><td colspan="4"><input id="shdz"></input></td></tr>
		    <tr>							<th>�ջ���</th><td><input id="shr"></input></td><th>�ջ�����ϵ�绰</th><td  colspan="2"><input id="shrlxdh"></input></td></tr>
		    
		    <tr><th>��ע��Ϣ</th> <td colspan="5"><textarea id="bzxx" style="height:100%;width:100%"></textarea></td> </tr>


		    <tr><th rowspan="14">Ʒ���ж�</th>	<th colspan="5">��������(����)</th></tr>
		    
		    
		    <tr>							<th>ά������</th><td><select id="wxxz1" class="easyui-combobox"   name="state" style="width:200px;" >
												<option value="0">  </option><option value="1">��æά��</option><option value="2">����ά��</option></select>
												</td><th>�����</th><td colspan="2"><input id="wtd1" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr >							<th>����</th><td><input id="qy1"   class="easyui-combogrid" style="width:200px;"></input></td><th>�����</th><td colspan="2"><input id="xxd1" class="easyui-combogrid" style="width:200px;"  ></input></td></tr>
		   <tr>								<th>��λ����</th><td colspan="4"><textarea id="wxbw" style="height:50px;width: 600px"></textarea></td></tr>
		    <tr>							<th colspan="5">�������(ѡ��)</th></tr>
		    <tr>							<th>ά������</th><td><select id="wxxz2"  class="easyui-combobox"  style="width:200px;"  >
												<option value="0">  </option><option value="1">��æά��</option><option value="2">����ά��</option></select></td><th>�����</th><td colspan="2"><input id="wtd2" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr>							<th>����</th><td><input id="qy2"   class="easyui-combogrid" style="width:200px;"></input></td><th>�����</th><td colspan="2"><input id="xxd2" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr>							<th colspan="5">�ж����</th></tr>
		    <tr>							<th>�ж�����ʽ*</th><td><select id="pdclfs" class="easyui-combobox" name="state" style="width:200px;">
												<option value="0">  </option><option value="1">��Ʒ�˲�</option><option value="2">����ά�ޣ��˻ص���</option><option value="3">����ά��</option></select></td><th>�˲ִ�����</th><td colspan="2"><input id="tccljg" class="easyui-combogrid" style="width:200px;" ></input></td></tr>
		    <tr>							<th>���β���</th><td><input id="zrbm" style="width:200px;"  class="easyui-combogrid"></input></td><th>�˻�����</th><td colspan="2"><input  type="text" style="width:200px;"  id="thdh" disabled="disabled"></input></td></tr>
		    <tr>							<th>�������</th><td colspan="4"><input id="jcyy" ></input></td></tr>
		    <tr>							<th>ά�޷�ʽ</th><td><select id="nx" class="easyui-combobox" disabled="disabled" style="width:200px;" ><option value="0" >����</option><option value="1" >����</option></select></td><th>�ƻ�ά������</th><td colspan="2"><input id="jhwxts" disabled="disabled" style="width:200px;" class="easyui-combogrid"></input></td></tr>
		    <tr>							<th>�Ƿ��շ�</th><td><select id="sfsf" class="easyui-combobox" disabled="disabled" style="width:200px;"><option value="0"  >��</option><option value="1">��</option></select></td><th>�շѽ��(Ԫ)</th><td colspan="2"><input id="wxjefw" type="text" disabled="disabled"></input></td></tr>
		    <tr>							<th>�շ�����</th><td colspan="4"><input id="sfnr" type="text" disabled="disabled" width="100%"></input></td></tr>
		    <tr>							<th>Ʒ���ж���ע</th><td colspan="5"><input id="pjpdbz" disabled="disabled" width="100%"></input></td></tr>
		    <tr><th>ά����Ϣ</th><th>ά����</th><td><input id="wxr" disabled="disabled"></input></td> <th>ά��ʱ��</th> <td colspan="2"><input id="wxsj" disabled="disabled"></input></td> </tr>
	    
	    </table>
	        
	        <br/><br/>
	        <div>
			    <table class="intable">
				<tr><td width="auto">�Ǽ���</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="djr"/></td><td>�Ǽ�ʱ��</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="djsj"/></td><td>Ʒ���ж���</td><td><input id="pjpdr" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td><td>�ж�ʱ��</td><td><input id="pjpdsj"  style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td></tr>
				<tr><td>ά��ȷ����</td><td><input id="wxqrr" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td><td>ȷ��ʱ��</td><td><input id="qrsj" style="background-color: #C1CDC1;width: 120" readonly="readonly"/></td></tr> 
				<!-- <td>����������</td><td><input style="background-color: #C1CDC1;width: 120" readonly="readonly" id="ttspr"/></td><td>����ʱ��</td><td><input readonly="readonly" style="background-color: #C1CDC1;width: 120" id="spsj"/></td> -->
				
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
   <jsp:include page="wxwc_gys.jsp"></jsp:include>
 </div>
 
  </body>
 
</html>
