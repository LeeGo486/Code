<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<% String userID = (String) request.getAttribute("userID");
   String loginDeptID =(String) request.getAttribute("loginDeptID");
   System.out.println(userID);
   System.out.println(loginDeptID);
   String webContext = request.getContextPath();
%>


<html:html>

	
	
<head>
		<title>非总部维修管理 </title>
		
		<link rel="stylesheet" type="text/css" href=" <%=request.getContextPath()%>/tabbed_pages/tabbed_pages_self.css" />
		
	<style type="text/css">
    .alpha{filter:alpha(opacity=30);}
	</style>
	
</head>

<script type="text/javascript">
		
		function creatBill(){
			var webContext = document.getElementById('webContext').value;
			//var url=webContext+"/eidtMaintenanceBill.do?method=init&userID="+document.getElementById('userID').value+"&loginDeptID="+document.getElementById('loginDeptID').value;
			document.frames['maintenanceParticularInfo'].location.href=webContext+"/eidtMaintenanceBillSelf.do?method=init&userID="+document.getElementById('userID').value+"&loginDeptID="+document.getElementById('loginDeptID').value;
			

			//window.open(url, "登记维修单", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
			changeDIV();
			document.getElementById('deleteBill').disabled=true;
		}
	
		
		
		
	
		
		function gkPrint(){
			var webContext = document.getElementById('webContext').value;
			//alert(document.getElementById('guid').value);
			var url=webContext+"/customerPrintSelf.do?method=getShopPrintData&guid="+document.getElementById('guid').value;
			window.open(url, "顾客单打印", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
			
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
			
			
	}
	

	
	function deleteBill(){
		var dh = document.getElementById("dh").value;
		if(confirm('确认删除单号为'+dh+'的维修单？')){
			document.getElementById('method').value="deleteBill";
			document.forms[0].submit();
		}
	}
	
	function finish(){
		var webContext = document.getElementById('webContext').value;
			//var url=webContext+"/eidtMaintenanceBill.do?method=init&userID="+document.getElementById('userID').value+"&loginDeptID="+document.getElementById('loginDeptID').value;
			var guid = document.getElementById('guid').value;
			document.frames['maintenanceParticularInfo'].location.href=webContext+"/eidtMaintenanceBillSelf.do?method=viewCompleteBill&userID="+document.getElementById('userID').value+"&guid="+document.getElementById('guid').value;
			

			//window.open(url, "登记维修单", "scrollbars=yes,width=1024px,height=600px,resizable=yes,menubar=no,status=no,location=no");
		changeDIV();
		document.getElementById('deleteBill').disabled=true;
	}
	

onload = function() {
	var e, i = 0;
		while (e = document.getElementById('gallery').getElementsByTagName('DIV')[i++]) {
		
		if (e.className == 'on' || e.className == 'off') {
		
			e.onclick = function() {
				var getEls = document.getElementsByTagName('DIV');
				for ( var z = 0; z < getEls.length; z++) {
					getEls[z].className = getEls[z].className.replace('show',
							'hide');
					getEls[z].className = getEls[z].className.replace('on',
							'off');
				}
				
				this.className = 'on';
				var max = this.getAttribute('title');
				document.getElementById(max).className = "show";
				var subIframe = document.getElementById('maintenanceParticularInfo');
				if (max == 'particularInfo') {
					
					if (subIframe != null) {
						
						if (subIframe.contentWindow.document
								.getElementById('isSaveFlag') != null) {
							
							//document.getElementById("guid").value=subIframe.contentWindow.document.getElementById('guid');
							
							document.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;
							document.getElementById('dh').value = subIframe.contentWindow.document.getElementById('dh').value;
							//document.getElementById('deleteBill').disabled=true;
							if(subIframe.contentWindow.document.getElementById('dh').value==''){
								document.getElementById('deleteBill').disabled=true;
								document.getElementById('gkPrint').disabled=true;
								document.getElementById('finish').disabled=true;
							}else{
								document.getElementById('deleteBill').disabled=false;
								document.getElementById('gkPrint').disabled=false;
							}
							
						} else {
							//alert(subIframe.contentWindow.document.getElementById('guid').value);
							document.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;
							document.getElementById('deleteBill').disabled=true;
							var zt = subIframe.contentWindow.document.getElementById('ZT').value;
							if(zt=='21'){
								document.getElementById('gkPrint').disabled=false;
								document.getElementById('finish').disabled=false;
								
							}
							if(zt=='22'){
								document.getElementById('gkPrint').disabled=false;
								document.getElementById('finish').disabled=true;
								//document.getElementById('guid').value = subIframe.contentWindow.document.getElementById('guid').value;
							}
						}
						
					}
				}
			
				else if(max=='infolist'){
					document.getElementById('deleteBill').disabled=true;
					document.getElementById('gkPrint').disabled=true;
					document.getElementById('finish').disabled=true;
				}
				else{
					document.getElementById('deleteBill').disabled=true;
					document.getElementById('gkPrint').disabled=true;
					document.getElementById('finish').disabled=true;
				}
				
				
			}

		}
	}

	
}

</script>



<body > 
	
	<img alt="" src="<%=webContext%>/mypicture/bg3.jpg" width="100%" height="130%" style="position:absolute;top0;left0;z-index: 0;filter:alpha(opacity=100);">
	<div style="position:absolute;top0;left0;width: 100%;height: 100%;z-index: 0;filter:alpha(opacity=70);">
	
	<html:form action="/cloMaintenanceSelf" styleId="cloMaintenanceSelForm" method="post">
		<html:hidden property="userID"/>
		<html:hidden property="loginDeptID"/>
		<html:hidden property="webContext" value="<%=request.getContextPath()%>"/>
		<html:hidden property="guid"/>
		<html:hidden property="dh"/>
		<html:hidden property="method" value="query"/>
		
	</html:form>
	
	
	<input type="button"  id="creatBill"  name="creatBill" value="登记维修单" onclick="creatBill()"/>
	<input type="button"  id="deleteBill"  name="deleteBill" disabled="disabled" value="删除维修单" onclick="deleteBill()"/> 
	<input type="button"  id="gkPrint" disabled="disabled" name="gkPrint" value="顾客单打印" onclick="gkPrint();"/>
	<input type="button"  id="finish" disabled="disabled" name="finish" value="维修完成" onclick="finish();"/>
	 <br>
	 <div align="center" >
	 	<font style="font-size:28;font-weight: 700;color: white;font-family:Microsoft YaHei,微软雅黑,Microsoft JhengHei,华文细黑,STHeiti,MingLiu">非总部维修管理</font>
	 </div>	
	 <br>
	<font style="font-size:15;font-weight: 500;color: white;font-family:Microsoft YaHei,微软雅黑,Microsoft JhengHei,华文细黑,STHeiti,MingLiu">注：非总部维修管理模块，适用于记录店铺自主维修的情况（即无需寄回给总部维修）</font>
	<div id="gallery">
		<div class="on" title="infolist"><span>列表</span></div>
		<div id="particular" class="off" title="particularInfo"><span>详细</span></div>
		
		
	</div>
	
	
	<div id="infolist" class="show">
		<iframe name="maintenanceInfoList"  width="98%"  height="100%" src="<%=webContext%>/maintenanceInfoListSelf.do?method=queryList&userID=<%=userID%>&loginDeptID=<%=loginDeptID%>" ></iframe>
		
	
	</div>

	<div id="particularInfo" class="hide">
		<iframe id="maintenanceParticularInfo" name="maintenanceParticularInfo" width="90%" height="100%" src="<%=webContext%>/viewMaintenanceBillSelf.do?method=init"></iframe>
	
	</div>

	 

	</div>
	</body>
</html:html>

