<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"
	prefix="bean"%>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic"
	prefix="logic"%>

<html:html>
<title></title>
<head>

	<link rel="stylesheet" type="text/css" href=" <%=request.getContextPath()%>/tabbed_pages/tabbed_pages.css" />
		
	
	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />

	<link rel="stylesheet" type="text/css"
		href="<%=request.getContextPath()%>/mycss/common.css" />

	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>
	
		<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>

	<script language="javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>
</head>
<script>
var initChange=0;
var valNum=0;

  function getShopInfo(){
  	var xmlhttp;
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    		var shopInfos = eval("(" + xmlhttp.responseText + ")");
    		if(shopInfos[0]==null || shopInfos[0]==''){
    		    document.getElementById('dpbm').value='';
    		    alert("店铺信息不存在，请重新选择！");
    		    document.getElementById("dpmc").value='';
    		    document.getElementById("dpTypeCode").value='';
    		    document.getElementById("dpTypeName").value='';
    		    document.getElementById("DZXM").value='';
    		    document.getElementById("DZLXDH").value='';
    		    document.getElementById("WXCBM").value='';
    		    document.getElementById("WXCMC").value='';
    		    document.getElementById("FHDZ").value='';
    		    document.getElementById("SHDZ").value='';
    		    document.getElementById("SHR").value='';
    		    document.getElementById("SHRLXDH").value='';
    		    document.getElementById("DPDQ").value='';
    		    document.getElementById("PP").value='';
    		    
    			return;
    		}
    		if(shopInfos[0].d_name!=null){
    			document.getElementById("dpmc").value=shopInfos[0].d_name;
    		}
    		if(shopInfos[0].dpTypeCode!=null){
    			document.getElementById("dpTypeCode").value=shopInfos[0].dpTypeCode;
    		}
    		if(shopInfos[0].dpTypeName!=null){
    			document.getElementById("dpTypeName").value=shopInfos[0].dpTypeName;
    		}
    		if(shopInfos[0].r_name!=null){
    			document.getElementById("DZXM").value=shopInfos[0].r_name;
    		}
    		if(shopInfos[0].tel!=null){
    			document.getElementById("DZLXDH").value=shopInfos[0].tel;
    		}
    		if(shopInfos[0].wxcbm!=null){
    			document.getElementById("WXCBM").value=shopInfos[0].wxcbm;
    		}
    		if(shopInfos[0].wxcmc!=null){
    			document.getElementById("WXCMC").value=shopInfos[0].wxcmc;
    		}
    		if(shopInfos[0].address!=null){
    			document.getElementById("FHDZ").value=shopInfos[0].address;
    		}
    		if(shopInfos[0].receiveaddress!=null){
    			document.getElementById("SHDZ").value=shopInfos[0].receiveaddress;
    		}
    		if(shopInfos[0].receivename!=null){
    			document.getElementById("SHR").value=shopInfos[0].receivename;
    		}
    		if(shopInfos[0].receivetel!=null){
    			document.getElementById("SHRLXDH").value=shopInfos[0].receivetel;
    		}
    		if(shopInfos[0].d_dq!=null){
    			document.getElementById("DPDQ").value=shopInfos[0].d_dq;
    		}
    		if(shopInfos[0].PP!=null){
    			document.getElementById("PP").value=shopInfos[0].PP;
    		}
    		getEmployeeList();
    	}
 	}
 	var shopID = document.getElementById("dpbm").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=getShopInfo&shopID="+shopID);
	
  }

function getEmployeeList(){
	var xmlhttp;
	var sldgCode = document.getElementById("sldgCode").value;
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    		//document.getElementById('SLDG').innerHtml="";
			document.getElementById("SLDG").options.length=0;
			var options = document.getElementById('SLDG').options;
    		var jsonObj = eval("(" + xmlhttp.responseText + ")"); 
			if(jsonObj==null || jsonObj==''){
				document.getElementById('SLDGTD').innerHTML='<input type="text" id="SLDG" name="SLDG"  class="text_enabled" />';
				document.getElementById('SLDG').value=sldgCode;
			}else{
				for(var item in jsonObj){
				//optionstring += "<option value=\""+ jsonObj[item] +"\" >"+ item +"</option>";
				
				
					if(jsonObj[item].dgid!=null && jsonObj[item].dgid != ''){
					//optionstring += "<option value=\""+ jsonObj[item].dgid +"\" >"+ jsonObj[item].dgname+"</option>";
						var objOption = new Option(jsonObj[item].dgname,jsonObj[item].dgid); 
						options[item]=objOption;
					}
				}
				document.getElementById('SLDG').value=sldgCode;
				if(initChange!=0){
					getEmployeeTel();
				}else{
					initChange=1;
				}
			}
			//alert(optionstring);
			//alert(document.getElementById('SLDG'));
			//document.getElementById('SLDG').innerHtml=optionstring;
			//jQuery("#SLDG").html(optionstring);
			//document.document.getElementById("dpbm").selectedIndex=0;	
    		
    		
    	}
 	};
 	var shopID = document.getElementById("dpbm").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=getEmployeeList&shopID="+shopID);
	
  }
  
  function getEmployeeTel(){
  	var xmlhttp;
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    		var tel = xmlhttp.responseText;
    		if(tel != 'null' && tel != ''){
    			document.getElementById("DGLXDH").value=tel ; 
    		}else{
    			document.getElementById("DGLXDH").value='';
    		}
    	}
 	}
 	var employeeID = document.getElementById("SLDG").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=getEmployeeTel&employeeID="+employeeID);
	
  }
  

function getVIPCustomerInfo(){
  	valNum++; 
  	var xmlhttp;
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    		var VIPCustomerInfo = xmlhttp.responseText; 
    		
    		if(VIPCustomerInfo=='null' || VIPCustomerInfo==null || VIPCustomerInfo==''){
    			alert("顾客信息不存在！");
    			document.getElementById("VIPKH").value='';
    			document.getElementById("GKXM").value='';
    			document.getElementById("GKLXDH").value='';
    			valNum--;
    			return;
    		}
    		
    		var infoArray = VIPCustomerInfo.split(",");
    		document.getElementById("GKXM").value=infoArray[0];
    		document.getElementById("GKLXDH").value=infoArray[1];
    		valNum--;
    	}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新输入VIP卡号！');
    			document.getElementById("VIPKH").value='';
    			document.getElementById("GKXM").value='';
    			document.getElementById("GKLXDH").value='';
    			valNum--;
    			return;
    	}
 	}
 	var vipCode = document.getElementById("VIPKH").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=getVIPCustomerInfo&vipCode="+vipCode);
	
  }
  
  function isExistKH(){
  	valNum++;
  	var xmlhttp;
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    		var isExists = xmlhttp.responseText; 
    		if(isExists=='0'){
    		    alert('款号不存在,请输入正确款号！');
    			document.getElementById("KH").value='';
    			document.getElementById('YS').value='';
    			document.getElementById('MS').value='';
    			valNum--;
    			return;
    		
    		}
    		var isExistsArray = isExists.split(",");
    		document.getElementById('YS').value=isExistsArray[0];
    		document.getElementById('MS').value=isExistsArray[1];
    		document.getElementById('KH').value=isExistsArray[2];
    		valNum--;
    	
    	}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新输入款号！');
    			document.getElementById("KH").value='';
    			document.getElementById('YS').value='';
    			document.getElementById('MS').value='';
    			return;
    	}
 	}
 	var KH = document.getElementById("KH").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=isExsitClothingKH&KH="+KH);
	
  }
  
function showShop(){
	
	var url= document.getElementById('webContext').value+"/eidtMaintenanceBill.do?method=showShopAll";
	window.open(url,"店铺信息","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
}

function changeMaintenanceInfo(){
	if(document.getElementById("GKWX").checked){
		document.getElementById("GKXM").className='text_enabled';
		document.getElementById("GKLXDH").className='text_enabled';
		document.getElementById("SCSJ").className='text_enabled';
		document.getElementById("SFTYFFWX").disabled=false;
		document.getElementById("SFTYFFWXTD").className='td_enabled';
		document.getElementById("VIPKH").className='text_enabled';
		
	}else{
		
		document.getElementById("GKXM").className='text_disabled';
		document.getElementById("GKLXDH").className='text_disabled';
		document.getElementById("SCSJ").className='text_disabled';
		document.getElementById("SFTYFFWX").disabled=true;
		document.getElementById("SFTYFFWXTD").className='td_disabled';
		document.getElementById("VIPKH").className='text_disabled';
		document.getElementById("GKXM").value='';
		document.getElementById("GKLXDH").value='';
		document.getElementById("SCSJ").value='';
		document.getElementById("SFTYFFWX").checked=false;
		document.getElementById("VIPKH").value='';
	
	}
}

function uploadImageFile(){
	if(document.getElementById("guid").value==null || document.getElementById("guid").value==''){
		alert("必须先保存维修登记表！");
		return;
	}
	
	document.getElementById("method").value="upload";
	document.forms[0].submit();
}


function save_submit(){
	if(valNum!=0){
		alert('后台还有数据在处理，请稍后！');
		return;
	}
	
	if(document.getElementById('dpbm').value==null||document.getElementById('dpbm').value==''){
		alert('店铺不能为空！');
		return;
	}
	if(document.getElementById('DZXM').value==null||document.getElementById('DZXM').value==''){
		alert('店长不能为空');
		return;
	}
	if(document.getElementById('SLDG').value==null||document.getElementById('SLDG').value==''){
		alert('受理导购不能为空！');
		return;
	}
	if(document.getElementById('DGLXDH').value==null||document.getElementById('DGLXDH').value==''){
		alert('导购联系电话不能为空！');
		return;
		
	}
	
	if(document.getElementById('YS').value==null||document.getElementById('YS').value==''){
		alert('后台正在获取服装颜色信息，请稍后提交！');
		return;
		
	}
	
	if(document.getElementById('MS').value==null||document.getElementById('MS').value==''){
		alert('后台正在获取服装尺码信息，请稍后提交！');
		return;
		
	}
	
	if(document.getElementById("GKWX").checked){
		if(document.getElementById('GKXM').value==null||document.getElementById('GKXM').value==''){
			alert('顾客姓名不能为空！');
			return;
		}
		if(document.getElementById('SCSJ').value==null||document.getElementById('SCSJ').value==''){
			alert('售出时间不能为空！');
			return;
		}
	}
	
	if(document.getElementById('KH').value==null||document.getElementById('KH').value==''){
		alert('款号不能为空！');
		return;
	}
	
	if(document.getElementById('YS').value==null||document.getElementById('YS').value==''){
		alert('款号验证失败，请重新输入进行验证！');
		return;
	}
	
	if(document.getElementById('WTMS').value==null||document.getElementById('WTMS').value==''){
		alert('问题描述不能为空！');
		return;
	}
	if(confirm('确认是否保存这张维修登记单？')){
		document.forms[0].submit();
	}
}

function showPictrue(tableID){
		
		var ecsideObj=ECSideUtil.getGridObj(tableID);
		var selectedRow = ecsideObj.selectedRow;
		var guid = selectedRow.getAttribute("recordKey");
		var url= document.getElementById('webContext').value+"/colmaintenance/viewPictrue.jsp?guid="+guid;
		window.open(url,"图片查看","scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
}

function deletePictrue(tableID){
	
	var ecsideObj=ECSideUtil.getGridObj(tableID);
	var selectedRow = ecsideObj.selectedRow;
	var guid = selectedRow.getAttribute("recordKey");
	document.getElementById('picGuid').value=guid;
	document.getElementById('method').value='deletePicture';
	document.forms[0].submit();
}

function initForm(){
		
	if(document.getElementById("dh").value==''){
		window.parent.document.getElementById("dpPrint").disabled=true;
		window.parent.document.getElementById("gkPrint").disabled=true;
		window.parent.document.getElementById("expressPrint").disabled=true;
	}
	
	if(document.getElementById("dh").value!=''){
		window.parent.document.getElementById("dpPrint").disabled=false;
		window.parent.document.getElementById("gkPrint").disabled=false;
		window.parent.document.getElementById("expressPrint").disabled=false;
	}
	window.parent.document.getElementById("sendHQ").disabled=false;
	window.parent.document.getElementById("guid").value=document.getElementById('guid').value;
	//alert(window.parent.document.getElementById("method").value);
	if(document.getElementById("isSaveFlag").value!="true"){
		
		
		if(document.getElementById('dpbm').value != null && document.getElementById('dpbm').value != ''){
			getShopInfo();
		}
	}else{
		
		if(window.parent.document.getElementById("method").value=='sendToHQ'){
			//window.parent.dpPrint();
			window.parent.document.forms[0].submit();
			
			return;
		}
		
		getEmployeeList();
	}
	
	changeMaintenanceInfo();
	if(document.getElementById("saveState").value=='1'){
		if(document.getElementById('GKWX').checked==true ){
			if(confirm('是否打印顾客维修单凭证！')){
				window.parent.gkPrint();
			}
		}	
	}else if(document.getElementById("saveState").value=='0'){
		alert('保存失败，请重试！');
	}
}


onload = function() {
	initForm();
	var e, i = 0;
	while (e = document.getElementById('gallery').getElementsByTagName ('DIV') [i++]) {
		if (e.className == 'on' || e.className == 'off') {
		e.onclick = function () {
			var getEls = document.getElementsByTagName('DIV');
				for (var z=0; z<getEls.length; z++) {
				getEls[z].className=getEls[z].className.replace('show', 'hide');
				getEls[z].className=getEls[z].className.replace('on', 'off');
				}
			this.className = 'on';
			var max = this.getAttribute('title');
			document.getElementById(max).className = "show";
			}
		}
	}
}
</script>


<body>

	
	
	
	<html:form action="/eidtMaintenanceBill" styleId="eidtMaintenanceBillForm" method="post" enctype= "multipart/form-data" >
		<html:hidden property="guid"/>
		<html:hidden property="loginDeptID"/>
		<html:hidden property="userID"/>
		<html:hidden property="method" value="saveBill"/>
		<html:hidden property="dpTypeCode"/>
		<html:hidden property="DPDQ"/>
		<html:hidden property="PP"/>
		<html:hidden property="picGuid"/>
		<html:hidden property="webContext" value="<%=request.getContextPath() %>"/>
		<html:hidden property="isSaveFlag" />
		<html:hidden property="YS"/>
		<html:hidden property="MS"/>
		<html:hidden property="sldgCode"/>
		<html:hidden property="saveState"/>
		
		<div style="width: 90%" align="center"><font size="5" style="font-weight:bold">维修登记表</font></div>
		
				
		
		
		<div style="height: 70%; width: 90%; OVERFLOW-Y: auto">
			
			<font size="6" color="red"> <bean:write name="eidtMaintenanceBillForm" property="ztTypeName"/></font>
			
			
			<table class="table_thin">
					
					<tr>
						<td width="20%" class="field_enabled">
							维修单号
						</td>
						<td width="80%" colspan="5" class="td_disabled">
							
							<html:text property="dh" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td rowspan="3" width="20%" class="field_enabled">
							店铺信息
						</td>
						
						<td width="20%" class="field_enabled">
							店铺编码
						</td>
						
						<td class="td_enabled" width="20%">
							<html:text  property="dpbm" readonly="true" style="text-align: left;background-color:white;border-style: none;width:100%;height: 100%;"></html:text>
						</td>
						
						<td width="20%" class="field_enabled">
							店铺名称
						</td>
						
						<td  class="td_disabled" width="20%">
							<html:text property="dpmc" styleClass="text_disabled"></html:text>
						</td>
						
						<td class="td_disabled" width="20%">
							<html:text property="dpTypeName" styleClass="text_disabled"></html:text>
						</td>
						
					</tr>
					
					
					<tr>
						<td class="field_enabled">
							店长姓名
						</td>
						
						<td class="td_enabled">
							<html:text property="DZXM" styleClass="text_enabled"/>
						</td>
						
						<td class="field_enabled">
							店长联系电话
						</td>
						<td class="td_enabled" colspan="2">
							<html:text property="DZLXDH" styleClass="text_enabled"></html:text>
						</td>

					</tr>
					
					
					
					
					<tr>
						<td class="field_enabled">
							维修仓编码
						</td>
						<td class="td_disabled">
							
							<html:text property="WXCBM" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							维修仓名称
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="WXCMC" styleClass="text_disabled"></html:text>
						</td>
					</tr>

					
					
					<tr>
						<td rowspan="2" class="field_enabled">
							维修接单信息
						</td>
						<td class="field_enabled">
							受理导购（*）
						</td>
						
						
						<td id="SLDGTD" class="td_enabled">
						
					 	<select  id="SLDG" name="SLDG" onchange="getEmployeeTel()" class="text_enabled">
							</select>
								
							
							
						
						</td>
						
						
						<td class="field_enabled">
							导购联系电话（*）
						</td>
						<td colspan="2" class="td_enabled">
							
							<html:text property="DGLXDH" styleClass="text_enabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							顾客维修
						</td>
						<td colspan="4" class="td_enabled">
							
							<html:checkbox property="GKWX" value="1" onclick="changeMaintenanceInfo();" ></html:checkbox>
						</td>
					</tr>

					<tr>
						<td rowspan="3" class="field_enabled">
							顾客信息
						</td>
						<td class="field_enabled">
							VIP卡号
						</td>
						<td class="td_disabled">
							
							<html:text property="VIPKH" styleClass="text_disabled" onchange="getVIPCustomerInfo()"></html:text>
						</td>
						<td class="field_enabled">
							顾客姓名（*）
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="GKXM" styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							顾客联系电话
						</td>
						<td class="td_disabled">
							
							<html:text property="GKLXDH" styleClass="text_disabled"></html:text>
						</td>
						<td class="field_enabled">
							售出时间（*）
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="SCSJ" onclick="setday(this)" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							同意付费维修
						</td>
						<td id="SFTYFFWXTD" class="td_enabled">
							
							<html:checkbox property="SFTYFFWX" value="1" disabled="true"></html:checkbox>
						</td>
						<td class="field_enabled">
							紧急程度
						</td>
						<td colspan="2" class="td_enabled">
							
							<html:select property="JJCD" styleClass="text_enabled">
								<html:optionsCollection name="urgencyList" label="stateName" value="stateCode"/>
							</html:select>
						</td>

					</tr>
					<tr>
						<td  rowspan="2" class="field_enabled">
							待修产品信息
							<br>
						</td>
						<td class="field_enabled">
							款号（*）
						</td>
						<td class="td_enabled">
							
							<html:text property="KH"  styleClass="text_enabled" onchange="isExistKH()"></html:text>
						</td>
						<td class="field_enabled">
							退回日期
						</td>
						<td colspan="2"  class="td_enabled">
							
							<html:text property="THRQ"  onclick="setday(this)" styleClass="text_enabled"></html:text>
						</td>
					</tr>

					<tr>
						<td class="field_enabled">
							问题描述（*）
						</td>
						<td colspan="4" class="td_enabled">
							
							<html:text property="WTMS" styleClass="text_enabled"></html:text>
						</td>
					</tr>

					<tr>
						<td rowspan="4" class="field_enabled">
							物流信息
						</td>
						<td class="field_enabled">
							运输公司
						</td>
						<td class="td_enabled">
							
							<html:select property="YSGS" styleClass="text_enabled">
								<html:optionsCollection name="transCoList" label="transCoName" value="transCoCode"/>
							</html:select>
							
						</td>
						<td class="field_enabled">
							运单号
						</td>
						<td colspan="2" class="td_enabled">
							
							<html:text property="YDH" styleClass="text_enabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							发货地址
						</td>
						<td colspan="4" class="td_enabled">
							
							<html:text property="FHDZ" styleClass="text_enabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							收货地址
						</td>
						<td colspan="4" class="td_enabled">
							
							<html:text property="SHDZ" styleClass="text_enabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							收货人
						</td>
						<td class="td_enabled">
							
							<html:text property="SHR" styleClass="text_enabled"></html:text>
						</td>
						<td class="field_enabled">
							收货人联系电话
						</td>
						<td colspan="2" class="td_enabled">
							
							<html:text property="SHRLXDH" styleClass="text_enabled"></html:text>
						</td>

					</tr>



					<tr>
						<td class="field_enabled">
							备注
						</td>
						<td colspan="5" class="td_enabled">
							
							<html:textarea property="BZXX" styleClass="text_enabled"></html:textarea>
						</td>
					</tr>

				
			</table>
			
			<table style="width: 90%" border="0" height="67">
				<tbody>
					<tr>
						<td width="12.5%">
							登记人
						</td>
						<td width="12.5%">
							
							<html:text property="djr"  styleClass="text_disabled"></html:text>
						</td>
						<td width="12.5%">
							登记时间
						</td>
						<td width="12.5%">
							
							<html:text property="djsj"  styleClass="text_disabled"></html:text>
						</td>
						<td width="12.5%">
							品鉴判定人
						</td>
						<td width="12.5%">
							
							<html:text property="PJPDR"  styleClass="text_disabled"></html:text>
						</td>
						<td width="12.5%">
							判定时间
						</td>
						<td width="12.5%">
							
							<html:text property="PJPDSJ"   styleClass="text_disabled"></html:text>
						</td>
					</tr>
					<tr>
						<td>
							特退审批人
						</td>
						<td>
							
							<html:text property="TTSPR"   styleClass="text_disabled"></html:text>
						</td>
						<td>
							审批时间
						</td>
						<td>
							
							<html:text property="TTSPSJ"   styleClass="text_disabled"></html:text>
						</td>
						<td>
							维修确认人
						</td>
						<td>
							
							<html:text property="WXQRR"  styleClass="text_disabled"></html:text>
						</td>
						<td>
							确认时间
						</td>
						<td>
							
							<html:text property="WXQRSJ"  styleClass="text_disabled"></html:text>
						</td>
					</tr>
				</tbody>
			</table>
			<div align="right"> <html:button property="save_sumit" onclick="save_submit();" >保存维修登记表</html:button></div>
		</div>
		
		

		 添加待修图片：<html:file property="uploadFile" ></html:file>
		 描述：<html:text property="picms" style="width:300"></html:text>
		 <html:button property="upload" onclick="uploadImageFile();" style="width:70;height:22">添加</html:button>
	</html:form>
	
	<div id="gallery">
			<div class="on" title="repairImage">
				<span>待修图片</span>
			</div>
			<div class="off" title="checkImage">
				<span>待检图片</span>
			</div>
	</div>
		<div id="repairImage" class="show">
			
			<ec:table  items="repairImageRecordList" var="repairrecord"  tableId="repairTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action=""
			rowsDisplayed="50" editable="false"
		    classic="true"
			filterable="false">
			<ec:row recordKey="${repairrecord.GUID}">
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="文件名" property="WJM" sortable="false" />
				<ec:column title="描述" property="MS" sortable="false" />
				<ec:column title="查看操作" property="VIEWOP" sortable="false" onclick="showPictrue('repairTable')" />
				<ec:column title="删除操作" property="DELETEOP" sortable="false" onclick="deletePictrue('repairTable')" />
				
			</ec:row>
			
			</ec:table>
				
		
		</div>  

		<div id="checkImage" class="hide">
   			<ec:table  items="checkImageRecordList" var="checkrecord"  tableId="checkTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%" 
			retrieveRowsCallback="process" action=""
			rowsDisplayed="50" editable="false"
		    classic="true"
			filterable="false">
			<ec:row recordKey="${checkrecord.GUID}" >
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="文件名" property="WJM" sortable="false" />
				<ec:column title="描述" property="MS" sortable="false" />
				<ec:column title="查看操作" property="VIEWOP" sortable="false" onclick="showPictrue('checkTable')" />
			</ec:row>
			
			</ec:table>
   		
   		</div> 
	
	
</body>
</html:html>