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

	<script type="text/javascript" src="<%=path%>/js/maintainInit.js"></script>
	
<link rel="stylesheet" type="text/css" href="<%=path%>/css/maintain.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
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
    				getdpvalue(idField); // ���ص��������Ϣ
    			 },
    			columns:[[
    				{field:'depotid',title:'���̱��',width:90},
    				{field:'dname',title:'��������',width:160},
    				{field:'address',title:'��ַ',width:160}
    			]]
    		});
    	});
     //���乫˾
     $(function(){
 		$('#ysgs').combogrid({
 			panelWidth:320,
 	 		mode:'remote',
 			idField:'mc',
 			textField:'mc',
 			url:'<%=path%>/rest/getYsgs/S2',
 			method:'post',
 			
 			columns:[[
 				{field:'bm',title:'����',width:50},
 				{field:'mc',title:'����',width:70},
 				{field:'lxdh',title:'��ϵ�绰',width:90},
 				{field:'lxr',title:'��ϵ��',width:90}
 		
 			]]
 		});
 	});
     //��ȡ������Ϣ
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
  				//getdpvalue(idField); // ���ص��������Ϣ
  				// var sldgs = eval("(" + sldgs + ")");
  				document.getElementById("dglxdh").value=idField;
  				
  			 },
  			columns:[[
  				{field:'employeeid',title:'�������',width:90},
  				{field:'names',title:'��������',width:90},
  				{field:'telephone',title:'��ϵ�绰',width:90}
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
				        {ldplx = "1";document.getElementById("dplx").value = "��Ӫ";}
				      else{ ldplx = "2";document.getElementById("dplx").value = "����";}
				     pp=shops[0].brandid;
				//     alert(pp+ldplx);
					
					 
								 
				//���̶�Ӧά�޲���Ϣ
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
											$.messager.alert("��ʾ", "ѡ����̳���");
										});	      
								}, 'text').error(function() {
							$.messager.alert("��ʾ", "ѡ����̳���");
						});
					    
				}, 'text').error(function() {
			$.messager.alert("��ʾ", "ѡ����̳���");
		});
	    
	}
     
     
     
     //���ڿؼ���ʽ��
     $(function(){
         $('#scsj').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });    
 
    	 var d,myDate;
    	  d = new Date();
    	  myDate = d.getFullYear() + "-";             //ȡ���
    	  myDate = myDate + (d.getMonth() + 1) + "-";//ȡ�·�
    	  myDate += d.getDate() + " ";         //ȡ����

         $('#thrq').datebox({
             formatter: function(date){ return date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate(); },
             parser: function(date){ return new Date(Date.parse(date.replace(/-/g,"/"))); }
             });   
         $('#thrq').datebox("setValue", myDate);
         })
 
      </script>
   
  <style type="text/css">
  
</style>

  </head>
  
  <body>
  
  
 
 
  <div  id="header">
  <label style="width='100%';height='100%';">�Ǽ�</label>
    <a id="save00" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="saveMaintain(id,0)">�Ǽ�</a>
    
    <a id="save10" class="easyui-linkbutton" data-options="iconCls:'icon-redo'" onclick="saveMaintain(id,1)">�����ܲ�</a>
    
 <a id="printdp" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="dpPrint()">���̴�ӡ</a>
 <a id="printzb" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="zbPrint()">�ܲ���ӡ</a>
 <a id="printkdd" class="easyui-linkbutton" data-options="iconCls:'icon-print'" onclick="kddPrint()">��ݵ���ӡ</a>  
 
	  </div>    
	<div style="background:#fafafa;padding-top:30px">
	    <form id="ff" method="post" >
	    <table class="gridtable">
		    <tr></tr>
		    <tr class="head" ><td colspan="3" width="500"><input id="guid" type="hidden" value="<%out.print(request.getParameter("guid"));%>"></input></td><td><label >ά�޵���:</label></td><td colspan="2"><input id="wxdh" disabled="disabled"></input></td></tr>
		     
		     <tr><th rowspan="3" width="180">������Ϣ</th>	<th width="180">���̱���</th><td><select id="dpbm" style="width: 200px;border:1px solid #fffffb;" class="easyui-combogrid"></select> </td><th>��������</th><td><input id="dpmc" type="text"></input></td><td><input ID="dplx" disabled="disabled" style="width: 30px"></input> </td></tr>
		     <tr>							<th>�곤����</th><td><input id="dzxm"></input></td><th>�곤��ϵ�绰</th><td colspan="2"><input id="dzlxdh" ></input</td></tr>
		     <tr>							<th>ά�޲ֱ��</th><td><input id="wxcbm" disabled="disabled"></input></td><th>ά�޲�����</th><td colspan="2"><input id="wxcmc" disabled="disabled"></input></td></tr>
		     
		     <tr><th rowspan="2">ά�޽ӵ���Ϣ</th><th>������*</th><td><input id="sldg" style="width: 200px;" class="easyui-combogrid"></input></td><th>������ϵ�绰*</th><td colspan="2"><input id="dglxdh"></input></td></tr>
		     <tr>		<th>�˿�ά��</th><td colspan="4"><input type="checkbox" id="isgkwx" value="1" style="width: 20px;" checked="checked" onchange="isGkwx()" />  </td></tr>
		     
		    <tr><th rowspan="3">�˿���Ϣ</th>	<th>VIP����</th><td><input id="vipkh" ></input></td><th>�˿�����*</th><td colspan="2"><input id="gkxm"  ></input></td></tr>
		    <tr>							<th>�˿���ϵ�绰</th><td><input id="gklxdh"></input></td><th>�۳�ʱ��*</th><td colspan="2"><input id="scsj" class="easyui-datebox"  style="width: 200px;"></input></td></tr>
		    <tr>							<th>ͬ�⸶��ά��</th><td><input type="checkbox" id="isffwx" value="1" style="width: 20px;"  /> </td><th>�����̶�</th><td colspan="2"><input id="jjcd" ></input></td></tr>
		    
		    <tr><th rowspan="2">���޲�Ʒ��Ϣ</th>	<th>���*</th><td><input id="kh" onBlur="checkKh(value)"></input></td><th>�˻�����</th><td colspan="2" ><input id="thrq" class="easyui-datebox" style="width: 200px;"></input></td></tr>
		    <tr>							<th>��������*</th><td colspan="4"><textarea id="wtms" style="height:60px;width: 600px"></textarea></td></tr>
		    
		    <tr><th rowspan="4">������Ϣ</th>	<th>���乫˾*</th><td><input id="ysgs"  style="width: 200px;" class="easyui-combogrid"></input></td><th>�˵���</th><td colspan="2"><input id="ydh"></input></td></tr>
		    <tr>							<th>������ַ</th><td colspan="4"><input id="fhdz"></input></td></tr>
		    <tr>							<th>�ջ���ַ</th><td colspan="4"><input id="shdz"></input></td></tr>
		    <tr>							<th>�ջ���</th><td><input id="shr"></input></td><th>�ջ�����ϵ�绰</th><td  colspan="2"><input id="shrlxdh"></input></td></tr>
		    
		    <tr><th>��ע��Ϣ</th> <td colspan="5"><textarea id="bzxx" style="height:100%;width:750"></textarea></td> </tr>
		    <tr style="display: none;"><th rowspan="14">Ʒ���ж�</th>	<th colspan="5">��������(����)</th></tr>
		    <tr style="display: none;">							<th>ά������</th><td><select id="wxxz1" class="easyui-combobox"   name="state" style="width:200px;" data-options="required:true" >
												<option value="0">  </option><option value="1">��æά��</option><option value="2">����ά��</option></select>
												</td><th>�����</th><td colspan="2"><input id="wtd1" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr style="display: none;">							<th>����</th><td><input id="qy1"   class="easyui-combogrid" style="width:200px;"></input></td><th>�����</th><td colspan="2"><input id="xxd1" class="easyui-combogrid" style="width:200px;"  ></input></td></tr>
		    <tr style="display: none;">							<th colspan="5">�������(ѡ��)</th></tr>
		    <tr style="display: none;">							<th>ά������</th><td><select id="wxxz2"  class="easyui-combobox"  style="width:200px;"  >
												<option value="0">  </option><option value="1">��æά��</option><option value="2">����ά��</option></select></td><th>�����</th><td colspan="2"><input id="wtd2" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr style="display: none;">							<th>����</th><td><input id="qy2"   class="easyui-combogrid" style="width:200px;"></input></td><th>�����</th><td colspan="2"><input id="xxd2" style="width:200px;"  class="easyui-combogrid"></input></td></tr>
		    <tr style="display: none;">							<th colspan="5">�ж����</th></tr>
		    <tr style="display: none;">							<th>�ж�����ʽ*</th><td><select id="pdclfs" class="easyui-combobox" name="state" style="width:200px;"   data-options="required:true" >
												<option value="0">  </option><option value="1">��Ʒ�˲�</option><option value="2">����ά�ޣ��˻ص���</option><option value="3">����ά��</option></select></td><th>�˲ִ�����</th><td colspan="2"><input id="tccljg" class="easyui-combogrid" style="width:200px;" ></input></td></tr>
		    <tr style="display: none;">							<th>���β���</th><td><input id="zrbm" style="width:200px;"  class="easyui-combogrid"></input></td><th>�˻�����</th><td colspan="2"><input  type="text" style="width:200px;"  id="thdh" disabled="disabled"></input></td></tr>
		    <tr style="display: none;" >							<th>�������</th><td colspan="4"><input id="jcyy" ></input></td></tr>
		    <tr style="display: none;">							<th>����</th><td><select id="tx" class="easyui-combobox" disabled="disabled" style="width:200px;" ><option value="0" selected="selected" >��</option><option value="1">��</option></select></td><th>�ƻ�ά������</th><td colspan="2"><input id="jhwxts" disabled="disabled" style="width:200px;" class="easyui-combogrid"></input></td></tr>
		    <tr style="display: none;">							<th>�Ƿ��շ�</th><td><select id="sfsf" class="easyui-combobox" disabled="disabled" style="width:200px;" ><option value="0" selected="selected">��</option><option value="1">��</option></select></td><th>�շѽ��(Ԫ)</th><td colspan="2"><input id="sfje" disabled="disabled"></input></td></tr>
		    <tr style="display: none;">							<th>�շ�����</th><td colspan="4"><input id="sfnr" disabled="disabled" width="100%"></input></td></tr>
		    <tr style="display: none;">							<th>Ʒ���ж���ע</th><td colspan="4"><input id="pjpdbz" disabled="disabled" width="100%"></input></td></tr>
		    <tr style="display: none;"><th>ά����Ϣ</th><th>ά����</th><td><input id="wxr" disabled="disabled"></input></td> <th>ά��ʱ��</th> <td colspan="2"><input id="wxsj" disabled="disabled"></input></td> </tr>
	    </table>
	        <br/><br/>
	       <div>
	        	<table class="gridtable">
		<tr><td>�Ǽ���</td><td><input readonly="readonly" id="djr"/></td><td>�Ǽ�ʱ��</td><td><input readonly="readonly" id="djsj"/></td><td>Ʒ���ж���</td><td><input id="pjpdr" readonly="readonly"/></td><td>�ж�ʱ��</td><td><input id="pjpdsj" readonly="readonly"/></td></tr>
		<tr><td>����������</td><td><input readonly="readonly" id="ttspr"/></td><td>����ʱ��</td><td><input readonly="readonly" id="spsj"/></td><td>ά��ȷ����</td><td><input id="wxqrr" readonly="readonly"/></td><td>ȷ��ʱ��</td><td><input id="qrsj" readonly="readonly"/></td></tr> 
		</table>
	            </div> 
	       
	    </form>
	    
	</div>
	 
	
	   <jsp:include page="zbfh.jsp"></jsp:include>
    <jsp:include page="zbdy.jsp"></jsp:include>
   <jsp:include page="dpdy.jsp"></jsp:include>
   <jsp:include page="kdddy.jsp"></jsp:include>
   <jsp:include page="wxwc.jsp"></jsp:include>
 
 
  </body>
 
</html>
