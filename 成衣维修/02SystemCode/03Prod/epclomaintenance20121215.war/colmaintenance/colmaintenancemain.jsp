<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<% String userID = (String) request.getAttribute("userID");
   String loginDeptID =(String) request.getAttribute("loginDeptID");
   String pwd = (String) request.getAttribute("pwd");
   System.out.println(userID);
   System.out.println(loginDeptID);
   String webContext = request.getContextPath();
%>


<html:html>

	
	
<head>
		<title>成衣维修</title>
		
		<link rel="stylesheet" type="text/css" href=" <%=request.getContextPath()%>/tabbed_pages/tabbed_pages.css" />
		
		<script type="text/javascript" src=" <%=request.getContextPath()%>/tabbed_pages/tabbed_pages.js" ></script>
	
	
</head>

<script type="text/javascript">
		
		function creatBill(){
			var webContext = document.getElementById('webContext').value;
			//var url=webContext+"/eidtMaintenanceBill.do?method=init&userID="+document.getElementById('userID').value+"&loginDeptID="+document.getElementById('loginDeptID').value;
			document.frames['maintenanceParticularInfo'].location.href=webContext+"/eidtMaintenanceBill.do?method=init&userID="+document.getElementById('userID').value+"&loginDeptID="+document.getElementById('loginDeptID').value;
			

			//window.open(url, "登记维修单", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
			changeDIV();
			document.getElementById('sendHQ').disabled=false;
			document.getElementById('deleteBill').disabled=true;
		}
	
		//function dpReceive(){
			
		//}
	
		function dpReceive(){
			var webContext = document.getElementById('webContext').value;
			var userID = document.getElementById('userID').value;
			var url=webContext+"/appraiseinfo.do?method=viewAppraiseinfo&guid="+document.getElementById('guid').value+"&userID="+userID;
			window.open(url, "店铺收货", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");	
		}
		
		function gkReceive(){
			var webContext = document.getElementById('webContext').value;
			var userID = document.getElementById('userID').value;
			var url=webContext+"/appraiseinfo.do?method=viewAppraiseinfo&guid="+document.getElementById('guid').value+"&userID="+userID;;
			window.open(url, "顾客收货", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");	
		}
		
	
	
	function sendHQ(){
			
			
		var subIframe = document.getElementById('maintenanceParticularInfo');
		var guid = subIframe.contentWindow.document.getElementById('guid').value;
		//var parentGuid = document.getElementById('guid').value;
		//if(parentGuid == guid){
			
			if(subIframe.contentWindow.valNum!=0){
				alert('后台还有数据在处理，请稍后！');
				return;
			}
			
			if(subIframe.contentWindow.document.getElementById('YS').value==null||subIframe.contentWindow.document.getElementById('YS').value==''){
				alert('后台正在获取服装颜色信息，请稍后提交！');
			return;
		
			}
	
			if(subIframe.contentWindow.document.getElementById('MS').value==null||subIframe.contentWindow.document.getElementById('MS').value==''){
				alert('后台正在获取服装尺码信息，请稍后提交！');
				return;
		
			}
			
			if(subIframe.contentWindow.document.getElementById('dpbm').value==null||subIframe.contentWindow.document.getElementById('dpbm').value==''){
				alert('店铺不能为空！');
				return;
			}
			if(subIframe.contentWindow.document.getElementById('DZXM').value==null||subIframe.contentWindow.document.getElementById('DZXM').value==''){
				alert('店长不能为空');
				return;
			}
			if(subIframe.contentWindow.document.getElementById('SLDG').value==null||subIframe.contentWindow.document.getElementById('SLDG').value==''){
				alert('受理导购不能为空！');
				return;
			}
			if(subIframe.contentWindow.document.getElementById('DGLXDH').value==null||subIframe.contentWindow.document.getElementById('DGLXDH').value==''){
				alert('导购联系电话不能为空！');
				return;
		
			}
			
			
			
			if(subIframe.contentWindow.document.getElementById("GKWX").checked){
				if(subIframe.contentWindow.document.getElementById('GKXM').value==null||subIframe.contentWindow.document.getElementById('GKXM').value==''){
					alert('顾客姓名不能为空！');
					return;
				}
				if(subIframe.contentWindow.document.getElementById('SCSJ').value==null||subIframe.contentWindow.document.getElementById('SCSJ').value==''){
					alert('售出时间不能为空！');
					return;
				}
			}
	
			if(subIframe.contentWindow.document.getElementById('KH').value==null||subIframe.contentWindow.document.getElementById('KH').value==''){
				alert('款号不能为空！');
				return;
			}
			if(subIframe.contentWindow.document.getElementById('WTMS').value==null||subIframe.contentWindow.document.getElementById('WTMS').value==''){
				alert('问题描述不能为空！');
				return;
			}
			
			
			var YSGS = subIframe.contentWindow.document.getElementById('YSGS').value;
			var YDH = subIframe.contentWindow.document.getElementById('YDH').value;
			var dpbm = subIframe.contentWindow.document.getElementById('dpbm').value;
			var dh = subIframe.contentWindow.document.getElementById('dh').value; 
			var webContext = document.getElementById('webContext').value;
			if( (YSGS !=null && YSGS!='') && (YDH !=null && YDH!='') ){
				document.getElementById('method').value="sendToHQ";
				subIframe.contentWindow.document.forms[0].submit();
				//dpPrint();
				//
			    //document.forms[0].submit();
				
			}else{
			
				var url=webContext+"/shopLogisticsBill.do?method=getShopPrintData&guid="+document.getElementById('guid').value+"&dpbm="+dpbm+"&dh="+dh;
				if(YSGS != null && YSGS != ''){
					url=url+"&YSGS="+YSGS;
				}
				if(YDH != null && YDH != ''){
					url=url+"&YDH="+YDH;
				}
				
				window.open(url, "发到总部", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");		
			}
		//}else{
			
		//}
	}
		
		
	
		
		
		function dpPrint(){
			var webContext = document.getElementById('webContext').value;
			//alert(document.getElementById('guid').value);
			var url=webContext+"/shopPrint.do?method=getShopPrintData&guid="+document.getElementById('guid').value;
			window.open(url, "店铺打印", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
			
		}
		
		function gkPrint(){
			var webContext = document.getElementById('webContext').value;
			//alert(document.getElementById('guid').value);
			var url=webContext+"/customerPrint.do?method=getShopPrintData&guid="+document.getElementById('guid').value;
			window.open(url, "顾客打印", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
			
		}
		
		function expressPrint(){
			var webContext = document.getElementById('webContext').value;
			var url=webContext+"/expressWayBill.do?method=getExpressData&guid="+document.getElementById('guid').value;
			window.open(url, "快递单打印", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
		}
	
	function changeDIV(){
			var getEls = document.getElementsByTagName('DIV');
			for (var z=0; z<getEls.length; z++) {
				getEls[z].className=getEls[z].className.replace('show', 'hide');
				getEls[z].className=getEls[z].className.replace('on', 'off');
			}
			document.getElementById('particular').className = 'on';
			var max = document.getElementById('particular').getAttribute('title');
			document.getElementById(max).className = "show";
			
			//var subIframe = document.getElementById('maintenanceParticularInfo');
			
			//if(subIframe.contentWindow.document.getElementById('method')!=null){
				//document.getElementById("sendHQ").disabled=false;
				
			//}else{
				//document.getElementById("sendHQ").disabled=true;
			//}
			
			
	}
	
	function dpPrintAfter(guid){
		var xmlhttp;
		if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  			xmlhttp=new XMLHttpRequest();
  		}else{// code for IE6, IE5
  			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  		}
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState==4 && xmlhttp.status==200){
    			
    		}
 		}
 		var employeeID = document.getElementById("SLDG").value;
		xmlhttp.open("post","ajax.ajaxServlet",true);
		xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlhttp.send("action=isExist&employeeID="+employeeID);
	
	}
	
	function deleteBill(){
		var dh = document.getElementById("dh").value;
		if(confirm('确认删除单号为'+dh+'的维修单？')){
			document.getElementById('method').value="deleteBill";
			document.forms[0].submit();
		}
	}
	
	</script>



<body> 
	<html:form action="/cloMaintenanceMain" styleId="cloMaintenanceForm" method="post">
		<html:hidden property="userID"/>
		<html:hidden property="loginDeptID"/>
		<html:hidden property="webContext" value="<%=request.getContextPath()%>"/>
		<html:hidden property="guid"/>
		<html:hidden property="dh"/>
		<html:hidden property="method" value="query"/>
		<html:hidden property="sendHQFlag"/>
		
	</html:form>
	
	
	<input type="button"  id="creatBill"  name="creatBill" value="登记维修单" onclick="creatBill()"/>
	<input type="button"  id="deleteBill"  name="deleteBill" disabled="disabled" value="删除维修单" onclick="deleteBill()"/> 
	<input type="button"  id="dpAppraiseInfo" disabled="disabled" name="dpAppraiseInfo" value="店铺收货" onclick="dpReceive();"/>
	<input type="button"  id="gkAppraiseInfo" disabled="disabled" name="gkAppraiseInfo" value="顾客收货" onclick="gkReceive();"/>
	<input type="button"  id="sendHQ" disabled="disabled" name="sendHQ" value="发送总部" onclick="sendHQ();"/>
	<input type="button"  id="dpPrint" disabled="disabled" name="dpPrint" value="店铺打印" onclick="dpPrint();"/>
	<input type="button"  id="gkPrint" disabled="disabled" name="gkPrint" value="顾客打印" onclick="gkPrint();"/>
	<input type="button"  id="expressPrint" disabled="disabled" name="expressPrint" value="快递单打印" onclick="expressPrint();"/>
	
	<div align="right">
		<a href="<%=webContext%>/cloMaintenanceSelf.do?method=init&userID=<%=userID%>&pwd=<%=pwd%>" target="_blank"><font>非总部维修管理 </font></a>
	</div>
	<div id="gallery">
		<div class="on" title="infolist"><span>列表</span></div>
		<div id="particular" class="off" title="particularInfo"><span>详细</span></div>
		<div class="off" title="HQsendgoods"><span>总部发货</span></div>
		<div class="off" title=appraiseinfo><span>评价信息</span></div>
		<div class="off" title="operaterecord"><span>操作记录</span></div>
		
		
	</div>
	
	
	<div id="infolist" class="show">
		<iframe name="maintenanceInfoList"  width="98%" height="95%" src="<%=webContext%>/maintenanceInfoList.do?method=queryList&userID=<%=userID%>&loginDeptID=<%=loginDeptID%>" ></iframe>
		
	
	</div>

	<div id="particularInfo" class="hide">
		<iframe id="maintenanceParticularInfo" name="maintenanceParticularInfo" width="100%" height="100%" src="<%=webContext%>/viewMaintenanceBill.do?method=init"></iframe>
	
	</div>

	<div id="HQsendgoods" class="hide">
		<iframe name="maintenanceHQSendGoods" width="100%" height="100%" src="<%=webContext%>/viewHQSendGoods.do?method=init" ></iframe>
		
	</div>

	<div id="appraiseinfo" class="hide">
		<iframe name="maintenanceAppraiseInfo" width="100%" height="100%" src="<%=webContext%>/appraiseinfo.do?method=init"></iframe>
	
	</div>

	<div id="operaterecord" class="hide">	
		<iframe name="maintenanceOperaterecord" width="100%" height="100%" src="<%=webContext%>/operaterecord.do?method=query"></iframe>
		
	</div>
	
	

	


	</body>
</html:html>

