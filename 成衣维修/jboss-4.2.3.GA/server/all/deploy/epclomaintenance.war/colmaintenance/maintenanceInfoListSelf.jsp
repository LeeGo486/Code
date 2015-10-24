<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://www.ecside.org" prefix="ec"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>

<html:html>

<head>
	<title></title>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/ecside/css/ecside_style.css" />
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/prototype_mini.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside_msg_utf8_cn.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ecside/js/ecside.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath()%>/myjs/myTime.js"></script>	
	
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>	
</head>
<script>
 var xmlhttp;
 function showShopSelect(){
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    	 	
    	 //	document.getElementById('dpbm').innerHtml="";
			
			
			document.getElementById("dpbm").options.length=0;
			var options = document.getElementById('dpbm').options;
    		var jsonObj = eval("(" + xmlhttp.responseText + ")");
			for(var item in jsonObj){
				
				if(jsonObj[item].dpbm!=null && jsonObj[item].dpbm != ''){
					
					var objOption = new Option(jsonObj[item].dpmc,jsonObj[item].dpbm); 
					options[item]=objOption;
				}
			}
			//document.getElementById("dpbm").selectedIndex=0;
		}
    }

 	var dpmc = document.getElementById("dpmc").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=getShopSelectData&dpmc="+dpmc);
	
  }
	
	

	
	function setShopName(){
		document.getElementById("dpmc").value= $("#dpbm").find("option:selected").text(); 

	}
	
	
	function advancedQueryList(){
		document.getElementById("advanceConditon1").style.display='block';
		document.getElementById('advancedCondition').value='1';
	}
	
	function queryList(){
		document.forms[0].submit();
	}
	
	
	function initOtherframes(){
		
		var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		
		var recordKey = selectedRow.getAttribute("recordKey");
		var keyArray = recordKey.split(',');
		var guid = keyArray[0];
		var parentWindow = window.parent;
		var userID = document.getElementById("userID").value;
		if(keyArray[1]=='20'){
			parentWindow.document.frames['maintenanceParticularInfo'].location.href=document.getElementById('webContext').value +'/eidtMaintenanceBillSelf.do?method=viewEditBill&guid='+guid+'&userID='+userID;
		}else if(keyArray[1]=='22'){
			parentWindow.document.frames['maintenanceParticularInfo'].location.href=document.getElementById('webContext').value +'/viewMaintenanceBillSelf.do?method=viewInfo&guid='+guid+'&userID='+userID;
		}else{
			parentWindow.document.frames['maintenanceParticularInfo'].location.href=document.getElementById('webContext').value +'/eidtMaintenanceBillSelf.do?method=viewCompleteBill&guid='+guid+'&userID='+userID;
		}
		
		parentWindow.changeDIV();
		setParentPara();
		
	}
		
	function initForm(){
		if(document.getElementById('advancedCondition').value=='1'){
			document.getElementById("advanceConditon1").style.display='block';
		}
	}	
		
    function setParentPara(){
    	
    	var ecsideObj=ECSideUtil.getGridObj('ecTable');
		var selectedRow = ecsideObj.selectedRow;
		
		var recordKey = selectedRow.getAttribute("recordKey");
		var keyArray = recordKey.split(',');
		var guid = keyArray[0];
    	var dh = keyArray[2];
    	var parentWindow = window.parent;
    	parentWindow.document.getElementById("guid").value=guid;
    	parentWindow.document.getElementById("dh").value=dh;
    	parentWindow.document.getElementById("gkPrint").disabled=false;
    	parentWindow.document.getElementById("finish").disabled=true;
    	if(keyArray[1]=='20'){
    		//parentWindow.document.getElementById("sendHQ").disabled=false;
    		parentWindow.document.getElementById("deleteBill").disabled=false;
    		
    	}else{
    		//parentWindow.document.getElementById("sendHQ").disabled=true;
    		if(keyArray[1]=='21'){
    			parentWindow.document.getElementById("finish").disabled=false;
    		}
    		parentWindow.document.getElementById("deleteBill").disabled=true;
    	}
    	
    }
	
	
	
</script>

<body onload="initForm()">
	
	<html:form action="/maintenanceInfoListSelf" styleId="maintenanceInfoListSelfForm" method="post">
		<html:hidden property="loginDeptID"/>
		<html:hidden property="userID"/>
		<!--  html:hidden property="dpbm"/> -->
		<html:hidden property="method" value="queryList"/>
		<html:hidden property="webContext" value="<%=request.getContextPath()%>"/>
		<html:hidden property="advancedCondition"/>
		
		<table width="98%">
		<tr>
		 	<td width="5%">维修单号</td>
		 	<td width="14%">
		 		<html:text property="dh" style="width:100%;"></html:text>
		 	</td>
		 	
		 	<td width="5%">店铺</td>
			<td width="14%"><input type=text id="dpmc" name="dpmc" style="width:100%;height:21px;font-size:10pt;"><!-- <span style="width:18px;border:0px solid red;">
			 	<select id="dpbm" name="dpbm" style="margin-left:-182px;;background-color:#FFEEEE;" onclick="setShopName()"> 
              	</select> 
              </span> -->

			</td>
			
			
			<td width="7%">客户/VIP编号</td>
			<td width="14%"><html:text property="GKXM" style="width:100%;"></html:text>
			</td>
			
			<td width="18%"></td>
		</tr>
		<tr>
			
			 
			 
			 <td>款号</td>
			 <td>
			 	<html:text property="KH" style="width:100%;"></html:text>
			 </td>
		
			 <td>状态</td>
			 <td>
			 	<html:select property="ZT" style="width:100%;">
			 		<html:optionsCollection name="billStateList" label="stateName" value="stateCode"/>
			 	</html:select>
			 </td>
			 <td>
			 </td>
			 <td align="center"><html:button property="query" value="查询" onclick="queryList()" style="width:80px"></html:button> </td>
			
			 
			 
		</tr>
			
		
		
		<tr>
			<td>登记时间</td>
			<td><html:text property="bgnQueryDate" style="width:100%;" onclick="setday(this)" readonly="true"/></td>
			
			<td>--</td>
			<td><html:text property="endQueryDate" style="width:100%;" onclick="setday(this)" readonly="true"/></td>
			
			<td></td>
			
			
			 <td align="center"><html:button property="advancedQuery" value="高级查询" style="width:80px" onclick="advancedQueryList()"></html:button> </td>
		
		</tr>
	
		
		
	
	
	<!-- 	<div id="advanceConditon" style="display:none;width:100%">  -->
		
				<tr id="advanceConditon1" style="display:none;">
					<td width="5%">操作类型</td>
					<td width="15%"><html:select property="czlx" style="width:100%;">
							<html:optionsCollection name="operateList" label="stateName" value="stateCode"/>
						</html:select> 
					</td>
					
					<td width="5%">操作时间</td>
					<td width="15%"><html:text property="operateBgnDate" style="width:100%;" onclick="setday(this)" readonly="true"/></td>
					
					<td width="7%">--</td>
					<td width="15%"><html:text property="operateEndDate" style="width:100%;" onclick="setday(this)" readonly="true"/></td>
					<td width="18%"></td>
				</tr>
			
	
	<!--	</div> -->
		
		</table>
	
	</html:form>
	
	<ec:table  items="recordlist" var="record"  tableId="ecTable"
			useAjax="false" doPreload="false"  toolbarContent="navigation|pagejump|pagesize|export|extend|status"
			showHeader="true"   width="100%"  
			retrieveRowsCallback="process" action="maintenanceInfoList.do"
			pageSizeList="10,20,30,50" rowsDisplayed="20" editable="false"
		    classic="true"
			filterable="true">
				 
			<ec:row recordKey="${record.GUID},${record.ZTCODE},${record.DH}" ondblclick="initOtherframes()" onclick="setParentPara()">
				
				
				
				<ec:column  property="_0" title="序号"  value="${GLOBALROWCOUNT}"  />
				
				<ec:column title="维修单号" property="DH" sortable="true" />
				<ec:column title="店铺编码" property="DPBM" sortable="true" />
				<ec:column title="店铺名称" property="DPMC" sortable="true" />
				<ec:column title="款号" property="KH" sortable="true" />
				<ec:column title="状态" property="ZT"  sortable="true"/>
				<ec:column title="登记时间" property="DJSJ" sortable="true" cell="date" format="yyyy-MM-dd" />
				<ec:column title="退回日期" property="THRQ" sortable="true"  cell="date" format="yyyy-MM-dd"/>
				<ec:column title="顾客姓名" property="GKXM" sortable="true" />
				<ec:column title="VIP卡号" property="VIPKH" sortable="true" />
				
				<ec:column title="紧急程度" property="JJCD" sortable="true"/>
				
				
				
				<ec:column title="计划维修时间" property="YJWCSJ"  sortable="true"/>
				<ec:column title="实际维修时间" property="SJWCSJ"  sortable="true"/>
				<ec:column title="维修单位" property="WXDW"  sortable="true"/>
		</ec:row>
			
		</ec:table>
	
	
	
	

</body>
</html:html>