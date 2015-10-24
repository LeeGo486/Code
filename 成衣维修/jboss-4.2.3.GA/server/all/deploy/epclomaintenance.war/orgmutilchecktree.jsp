<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String loginDeptID = request.getParameter("loginDeptID");
	
%>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	
	<title>单位树</title>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'orgmutilchecktree.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	
  <link rel="stylesheet" href="ztree/zTreeStyle/zTreeStyle.css" type="text/css">
  <script type="text/javascript" src="ztree/jquery-1.4.2.js"></script>
  <script type="text/javascript" src="ztree/jquery.ztree-2.6.js"></script>
  <script type="text/javascript" src="ztree/demoTools.js"></script>
	
	</head>
	<script type="text/javascript">
  var selectOrgString="";
  var selectOrgName="";
  var zTree1;
  var lastCheckLevel;
  var setting = {
  	callback : {
      click: zTreeOnClick,
      //expand:zTreeOnClick
      change: zTreeOnChange
  	},
    showLine: true,
    checkable: true,
    showIcon: true,
    checkStyle : "radio",
    checkType : { "Y": "", "N": "" }

	};
	
	


 var xmlhttp;
 var myNodeTreeData; 
  function ajaxMain(){
  	
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    	 
    	myNodeTreeData = eval("(" + xmlhttp.responseText + ")");
    	 zTree1=$("#tree").zTree(setting, [myNodeTreeData]);
    }
	};
 	
 	var loginDeptID = document.getElementById("deptID").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=getRootNodeTreeData&loginDeptID="+loginDeptID);
	
  }


//function getTreeData(){
	//alert(xmlhttp.readyState);
	//if (xmlhttp.readyState==4 && xmlhttp.status==200){
    	
    	//myNodeTreeData = eval("(" + response.responseText + ")");;
    	
    //}
	
//}


function zTreeOnClick(event, treeId, treeNode) {
	if(treeNode.isOpenFlag==0){
	
		if(treeNode.loadDataFlag==0){
			addmynode(treeNode);
			treeNode.loadDataFlag=1;
			treeNode.isOpenFlag=1;
		}else{
			zTree1.expandNode(treeNode, true, false);
			treeNode.isOpenFlag=1;
		}
	}else{
		zTree1.expandNode(treeNode, false, false);
		treeNode.isOpenFlag=0;
		
	}

}
 
function addmynode(parentNode){
	//var newNodes = [ {"name":"IT部门","enname":"IT","deptid":"00011","hasunFlag":"0","loadDataFlag":"0","isOpenFlag":"0"}, 
	//				 {"name":"商品部门","enname":"PDC","deptid":"00012","hasunFlag":"0","loadDataFlag":"0","isOpenFlag":"0"}];
	if(parentNode.hasunFlag=='0'){
		return;
	}
	parentNode.isParent=true
	//var parentDeptID = parentNode.deptid;
	getSunNodes(parentNode);
	
}



function selectOrg(){
	
	var checkedNodes = zTree1.getCheckedNodes(true);
	
	if(checkedNodes.length>0){
		for(var i=0;i<checkedNodes.length;i++){
			selectOrgString=selectOrgString+checkedNodes[i].deptid+",";
			
			selectOrgName=selectOrgName+checkedNodes[i].name+",";
		}
	
		selectOrgString = selectOrgString.substr(0,selectOrgString.length-1);
		selectOrgName=selectOrgName.substr(0,selectOrgName.length-1);
	
	}
	
	opener.setOrg(selectOrgName,selectOrgString);
	window.close();		

}

function getSunNodes(parentNode){
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    	 
    		
    		var newNodes = eval("(" + xmlhttp.responseText + ")");
    		zTree1.addNodes(parentNode, newNodes,false);
    	}
	};
 	
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=getSunNodeTreeData&parentDeptID="+parentNode.deptid);

}

</script>

	<body onload="ajaxMain()" >
	
		<input type="button" onclick="selectOrg()" value="确定">
		<input type="hidden" id="deptID" name="deptID" value="<%=loginDeptID%>" >
		
		<div style="height: 80px">
		<ul id="tree" class="tree" style="width:300px; overflow:auto;"></ul>
		
		</div>
		<input type="button" onclick="selectOrg()" value="确定">
	</body>
</html>
