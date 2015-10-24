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
var dgxxlist=[];

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
    		    document.getElementById("FHDZ").value='';
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
    		if(shopInfos[0].address!=null){
    			document.getElementById("FHDZ").value=shopInfos[0].address;
    		}
    		if(shopInfos[0].d_dq!=null){
    			document.getElementById("DPDQ").value=shopInfos[0].d_dq;
    		}
    		if(shopInfos[0].PP!=null){
    			document.getElementById("PP").value=shopInfos[0].PP;
    		}
    		getEmployeeList();
    	}
 	};
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
    		dgxxlist = jsonObj; //导购信息数组
			if(jsonObj==null || jsonObj==''){
				document.getElementById('SLDGTD').innerHTML='<input type="text" id="SLDG" name="SLDG"  class="text_enabled" />';
				document.getElementById('SLDG').value=sldgCode;
			}else{
				for(var item in jsonObj){ 
					if(jsonObj[item].EMPLOYEEID!=null && jsonObj[item].EMPLOYEEID != ''){
						var objOption = new Option(jsonObj[item].NAMES,jsonObj[item].EMPLOYEEID); 
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
    /*dly 140214  直接从导购信息数组dgxxlist里获取导购电话*/
    document.getElementById("DGLXDH").value='';
    
    for(var i=0; i<dgxxlist.length; i++){ 
       if(document.getElementById('SLDG').value == dgxxlist[i].EMPLOYEEID){
       	   document.getElementById("DGLXDH").value = dgxxlist[i].TELEPHONE;
       	   document.getElementById("SLDGXM").value= dgxxlist[i].NAMES;
       }
    }
  	/* var xmlhttp;
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
	xmlhttp.send("action=getEmployeeTel&employeeID="+employeeID); */
	
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
 	};
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
    		//document.getElementById('KH').value=isExistsArray[2];
    		valNum--;
    	
    	}else if(xmlhttp.readyState==4 && xmlhttp.status!=200){
    			
    			alert('网络错误，请重新输入款号！');
    			document.getElementById("KH").value='';
    			document.getElementById('YS').value='';
    			document.getElementById('MS').value='';
    			valNum--;
    			return;
    	}
 	};
 	var KH = document.getElementById("KH").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=isExsitClothingKH&KH="+KH);
	
  }



	function validateNumber(obj){
  		var objValue = $(obj).attr('value');
  		if(isNaN(objValue)){
  			$(obj).attr('value','');
  			alert('只允许输入数值!');
  			return;
  		}
  		
  		if(parseFloat(objValue)<0){
  			alert('输入金额不能小于零!');
  			$(obj).attr('value','');
  			return;
  		}
  		//objValue = parseFloat(objValue).toFixed(4);
  		//$(obj).attr('value',objValue);
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
	if(document.getElementById('DZLXDH').value==null||document.getElementById('DZLXDH').value==''){
		alert('联系电话不能为空');
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
	

	if(document.getElementById('GKXM').value==null||document.getElementById('GKXM').value==''){
		alert('顾客姓名不能为空！');
		return;
	}
	
	if(document.getElementById('GKXM').value==null||document.getElementById('GKXM').value==''){
		alert('顾客姓名不能为空！');
		return;
	}
	
	if(document.getElementById('SCSJ').value==null||document.getElementById('SCSJ').value==''){
		alert('售出时间不能为空！');
		return;
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
	
	if(document.getElementById('WXDW').value==null||document.getElementById('WXDW').value==''){
		alert('维修单位不能为空！');
		return;
	}
	
	
	if(confirm('确认是否保存这张维修登记单？')){
		document.forms[0].submit();
	}
}

function confirm_submit(){
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
	if(document.getElementById('DZLXDH').value==null||document.getElementById('DZLXDH').value==''){
		alert('联系电话不能为空');
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
	

	if(document.getElementById('GKXM').value==null||document.getElementById('GKXM').value==''){
		alert('顾客姓名不能为空！');
		return;
	}
	
	if(document.getElementById('GKLXDH').value==null||document.getElementById('GKLXDH').value==''){
		alert('顾客联系电话不能为空！');
		return;
	}
	
	if(document.getElementById('SCSJ').value==null||document.getElementById('SCSJ').value==''){
		alert('售出时间不能为空！');
		return;
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
	
	if(document.getElementById('WXDW').value==null||document.getElementById('WXDW').value==''){
		alert('维修单位不能为空！');
		return;
	}
	
	//if(document.getElementById('YJWCSJ').value==null||document.getElementById('YJWCSJ').value==''){
	//	alert('预计完成时间不能为空！');
		//return;
	//}
	
	if(document.forms[0].YJWCSJ[0].checked==false && document.forms[0].YJWCSJ[1].checked==false){
		alert('必须选择预计完成时间！');
		return;
	}
	
	
	
	
	if(confirm('确认接受此单的维修任务？')){
		document.getElementById('method').value='sendBill';
		document.forms[0].submit();
	}
}



function initForm(){
	
	
	if(document.getElementById("dh").value==''){
		window.parent.document.getElementById("gkPrint").disabled=true;
	}
	
	if(document.getElementById("dh").value!=''){
		window.parent.document.getElementById("gkPrint").disabled=false;
		window.parent.document.getElementById("deleteBill").disabled=false;
	}
	window.parent.document.getElementById("guid").value=document.getElementById('guid').value;
	//alert(window.parent.document.getElementById("method").value);
	if(document.getElementById("isSaveFlag").value!="true"){
		if(document.getElementById('dpbm').value != null && document.getElementById('dpbm').value != ''){
			getShopInfo();
		}
	}else{
		
		getEmployeeList();
	}
	
	if(document.getElementById("saveState").value=='2'){
		
			if(confirm('是否打印顾客维修单凭证！')){
				window.parent.gkPrint();
			}
			window.parent.document.getElementById('method').value='init';
			window.parent.document.forms[0].submit();
	}else if(document.getElementById("saveState").value=='1'){
		alert('保存成功！');	
	}else if(document.getElementById("saveState").value=='0'){
		alert('保存失败，请重试！');
	}
}



</script>


<body onload="initForm()">

	
	
	
	<html:form action="/eidtMaintenanceBillSelf" styleId="eidtMaintenanceBillSelfForm" method="post" enctype= "multipart/form-data" >
		<html:hidden property="guid"/>
		<html:hidden property="loginDeptID"/>
		<html:hidden property="userID"/>
		<html:hidden property="method" value="saveBill"/>
		<html:hidden property="dpTypeCode"/>
		<html:hidden property="DPDQ"/>
		<html:hidden property="PP"/>
		<html:hidden property="webContext" value="<%=request.getContextPath() %>"/>
		<html:hidden property="isSaveFlag" />
		<html:hidden property="YS"/>
		<html:hidden property="MS"/>
		<html:hidden property="sldgCode"/>
		<html:hidden property="saveState"/>
		<html:hidden property="FHDZ"/>
		<html:hidden property="djsj"/>
		<html:hidden property="THRQ"/>
		<html:hidden property="SLDGXM"/>
		
		<div style="width: 90%" align="center"><font size="5" style="font-weight:bold">维修登记表</font></div>
		
				
		
		
		<div style="height: 70%; width: 90%; OVERFLOW-Y: auto">
			
			<font size="6" color="red"> <bean:write name="eidtMaintenanceBillSelfForm" property="ztTypeName"/></font>
			
			
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
						<td rowspan="2" width="20%" class="field_enabled">
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
							联系电话
						</td>
						<td class="td_enabled" colspan="2">
							<html:text property="DZLXDH" styleClass="text_enabled"></html:text>
						</td>

					</tr>
					
					
					
					
				

					
					
					<tr>
						<td rowspan="1" class="field_enabled">
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
						<td rowspan="3" class="field_enabled">
							顾客信息
						</td>
						<td class="field_enabled">
							VIP卡号
						</td>
						<td class="td_enabled">
							
							<html:text property="VIPKH" styleClass="text_enabled" onchange="getVIPCustomerInfo()"></html:text>
						</td>
						<td class="field_enabled">
							顾客姓名（*）
						</td>
						<td colspan="2" class="td_enabled">
							
							<html:text property="GKXM" styleClass="text_enabled"></html:text>
						</td>
					</tr>
					<tr>
						<td class="field_enabled">
							顾客联系电话（*）
						</td>
						<td class="td_enabled">
							
							<html:text property="GKLXDH" styleClass="text_enabled"></html:text>
						</td>
						<td class="field_enabled">
							售出时间（*）
						</td>
						<td colspan="2" class="td_enabled">
							
							<html:text property="SCSJ" onclick="setday(this)" styleClass="text_enabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							同意付费维修
						</td>
						<td id="SFTYFFWXTD" class="td_enabled">
							
							<html:checkbox property="SFTYFFWX" value="1" ></html:checkbox>
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
						<td rowspan="3" class="field_enabled">
							维修信息
						</td>
						<td class="field_enabled">
							维修单位（*）
						</td>
						<td class="td_enabled">
							
							<html:text property="WXDW" styleClass="text_enabled"></html:text>
							
						</td>
						<td class="field_enabled">
							预计完成时间（*）
						</td>
						<td id="YJWCSJ_TD" colspan="2" class="td_enabled">
							
						<html:radio property="YJWCSJ" value="3">3天</html:radio>
						<html:radio property="YJWCSJ" value="7">7天</html:radio>	
							
						<%-- 	<html:text property="YJWCSJ"  onclick="setday(this)" styleClass="text_enabled"></html:text>--%>
						</td>
						
						
						
					</tr>
					
					<tr>
						
						
						<td class="field_enabled">
							目前状态
						</td>
						<td colspan="1" class="td_disabled">
							
							<html:text property="ztTypeName" styleClass="text_disabled"></html:text>
		
						</td>
						
						<td class="field_enabled">
							实际完成时间
						</td>
						<td colspan="2" class="td_disabled">
							
							<html:text property="SJWCSJ"  onclick="setday(this)" disabled="true" styleClass="text_disabled"></html:text>
						</td>

					</tr>
					<tr>
						<td class="field_enabled">
							付款金额
						</td>
						<td colspan="4" class="td_enabled">
							
							<html:text property="FFJE" styleClass="text_enabled" onchange="validateNumber(this)"></html:text>
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
			
			
				 说明：1、加*字段为必填字段  2、点击"保存并接受任务"按钮说明已经报修了 
			
			<div align="right">
		<%--	<html:button property="save_sumit" onclick="save_submit();" style="width:100">保存维修登记表</html:button> --%>	
			 <html:button property="confirm_sumit" onclick="confirm_submit();" style="width:100">保存并接受任务</html:button></div>
		</div>
		
	</html:form>

		
	
</body>
</html:html>