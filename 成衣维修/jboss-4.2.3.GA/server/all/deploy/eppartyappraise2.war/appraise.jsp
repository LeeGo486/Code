<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ep.org.eppartyappraise.bean.PersonalInfo"%>
<%@page import="ep.org.eppartyappraise.bean.UserInfo"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"
	prefix="bean"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="logic" uri="http://struts.apache.org/tags-logic"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserInfo userInfo = (UserInfo) request.getSession().getAttribute("user_info");
ArrayList dyinfoList = (ArrayList) request.getAttribute("dyinfoList");
if(dyinfoList==null){
	dyinfoList = new ArrayList();
}
int listSize = dyinfoList.size();
//int cycleValue = Math.ceil(listSize/3);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>星级党员评选</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery-1.4.2.js"></script>
 </head>
  <script type="text/javascript">
  var xmlhttp;
  var appraiseState = 0;
  var fullPointCount = 0; 
  function updateAppraiseInfo(dyid,field,appraise,tpoint){
  	var webcontent = $("#webcontent").attr("value");
	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    		var rs = xmlhttp.responseText;
    		if(rs != '1'){
    			
    			if(field!="commnet"){
    				for(var i=1;i<=parseInt(appraise);i++){
    					document.getElementById(field+'-'+i+'-'+dyid).src=webcontent+'/img/badstar.JPG';
    				}
    				alert('刚操作的评分失败，请重新评!');
    			}else{
    				$("#"+field+"-"+dyid).attr("value","");
    				alert('刚操作的评分失败，请重新评!');
    			}
    		
    		}
    		
    	}
 	}
 	var userID = document.getElementById("userID").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=updateAppraiseInfo&dyid="+dyid+"&field="+field+"&appraise="+appraise+"&tpoint="+tpoint+"&userID="+userID);
  }
  
  function changeStar(obj){
  	if(appraiseState==1){
  		alert('你已经 评价过 1次，无法再评价 !');
  		return;
  	}
  	
  	//var point;
  	var webcontent = $("#webcontent").attr("value");
  	var idValue = $(obj).attr("id");
  	
  	//var tPoint = $(obj).attr(id);
  	var idArray= idValue.split('-');
  	var tPointSelector =  "#total-"+idArray[2];
	var tPoint =   parseInt($(tPointSelector).attr("value"));
	//if(tPoint==null || tPoint=''){
		//point = 0;
	//}
	var thisPiont =  parseInt($("#hd"+idArray[0]+idArray[2]).attr("value"));
	var basePoint =  tPoint-thisPiont;
	var newPoint = basePoint+parseInt(idArray[1]);
	
	//------------------------------------以下处理是判定满分评价次数，次数不能超过5次-----------------
	if(parseInt(tPoint)!= 25 && parseInt(newPoint)==25){
		if(fullPointCount>=10){
			alert('满分评价不能超过10次!');
			return;
		}
		fullPointCount = fullPointCount+1;
	}
	
	if(parseInt(tPoint)==25 && parseInt(newPoint)!=25){
		
		if(fullPointCount>0){
			fullPointCount = fullPointCount - 1;
		}
	}
	
	
	//----------------------------------------------------------------------------------------------
	
	$(tPointSelector).attr("value",newPoint);
	$("#hd"+idArray[0]+idArray[2]).attr("value",idArray[1]);
  	
  	//13456332652
  	for(var i=1;i<=parseInt(idArray[1]);i++){
  		
  		document.getElementById(idArray[0]+'-'+i+'-'+idArray[2]).src=webcontent+'/img/goodstar.JPG';
  	}
  	for(var i=parseInt(idArray[1])+1;i<=5;i++){
  		
  		document.getElementById(idArray[0]+'-'+i+'-'+idArray[2]).src=webcontent+'/img/badstar.JPG';
  		
  	}
  	updateAppraiseInfo(idArray[2],idArray[0],idArray[1],newPoint);
  }
  
  function updateComment(obj){
      if(appraiseState==1){
  		alert('你已经 评价过 1次，无法再评价 !');
  		return;
  	  }
      var comment = $(obj).attr("id");
      var commentValue = $(obj).attr("value");
      var commentArray = comment.split('-');
      updateAppraiseInfo(commentArray[1],commentArray[0],commentValue,'');
  }
  
  function saveAppraise(){
  	if(appraiseState==1){
  		alert('你已经 评价过 1次，无法再评价 !');
  		return;
  	
  	}
        //var objs = document.getElementsByName("total");
  	//for(var i=0;i<objs.length;i++){
  	//	if(objs(i).value==0){
  	//		alert('您还有未评分的党员,请全部评分完后提交 !');
  	//		return;
        //	}
        //	}
  	
  	
  	if (window.XMLHttpRequest){ // code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}else{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xmlhttp.onreadystatechange=function() {
		if (xmlhttp.readyState==4 && xmlhttp.status==200){
    		var rs = xmlhttp.responseText;
    		if(rs=='1'){
    			appraiseState = 1;
    			alert('评价成功');
    		}else if(rs=='2'){
    			appraiseState = 1;
    			alert('您已经评价过，无法再进行评价！');
    		}else{
    			alert('评价提交失败，请重新提交!');
    		}
    	}
 	}
 	var userid = document.getElementById("userID").value;
	xmlhttp.open("post","ajax.ajaxServlet",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("action=saveAppraise&userID="+userid);
  }
  
  function initForm(){
  	if(document.getElementById("appraiseState").value=='1'){
  		appraiseState=1;
  		alert('你已经 评价过 1次，无法再评价! ');
  		return;
  	}
  }
  
  
  function viewAppraise(){
  	var url = document.getElementById("webcontent").value+'/viewAppraise.do?method=queryPersonalInfos';
  	window.open(url, "查看评选结果", "scrollbars=yes,width=1024px,height=768px;"); 
  }
  
  function viewVote(){
  	var url = document.getElementById("webcontent").value+'/viewAppraise.do?method=viewVote';
  	window.open(url, "查看评选结果", "scrollbars=yes,width=1024px,height=768px;"); 
  }
  
  
  function showTip(obj){
  	 var idValue = $(obj).attr("id");
  	 document.getElementById('div-'+idValue).style.display='block';
  }
  
  
   function hiddenTip(obj){
  	 var idValue = $(obj).attr("id");
  	 document.getElementById('div-'+idValue).style.display='none';
  }
  </script>
  
  <body onload="initForm()" bgcolor="#F32110">
 	
 	<p align="center" style="font-size:50px;"><b>星级党员评选系统</b></p>
  	
		<table bordercolor="#F1E737" border="1">
		<%
		  for(int i=0 ; i<listSize/3+1; i++){
			
		%>	
			
			<tr height="100%">
		
		<%for(int k=0;k<3;k++){
			
			if(i*3+k < dyinfoList.size()){
			
			PersonalInfo personalInfo = (PersonalInfo)dyinfoList.get(i*3+k);
			
		%>	
			
			<td width="33%" valign="top">
				<input type="hidden" id="hdxxxcstar<%=personalInfo.getDyid()%>" value="0">
				<input type="hidden" id="hdlzjystar<%=personalInfo.getDyid()%>" value="0">
				<input type="hidden" id="hdtjxzstar<%=personalInfo.getDyid()%>" value="0">
				<input type="hidden" id="hdgygxstar<%=personalInfo.getDyid()%>" value="0">
				<input type="hidden" id="hdzjsfstar<%=personalInfo.getDyid()%>" value="0">
			    
			    
			    
			   <table height="100%">
			    
			    <tr valign="top" height="100%">
			   		<td valign="top">
			    
			    
			    <div>
			    
			   		
			    
			    <img alt="<%=personalInfo.getDyname()%>"   src="<%=request.getContextPath()%>/img/<%=new String(personalInfo.getImgsrc().getBytes("ISO-8859-1"),"UTF-8") %>" width="180" height="250" align="left">
			
				
					<ul style="list-style-type:none">
 						<li><b>姓名：</b> <font style="font-family:微软雅黑;line-height:2" size="2"> <%=personalInfo.getDyname()%> </font> </li>
 						<li><b>岗位：</b> <font style="font-family:微软雅黑;line-height:2" size="2"> <%=personalInfo.getGzgw() %> </font> </li>
 						<li><b>出生年月：</b> <font style="font-family:微软雅黑;line-height:2" size="2"> <%=personalInfo.getBirthday()%></font> </li>
						<li><b>入党日期：</b> <font style="font-family:微软雅黑;line-height:2" size="2"> <%=personalInfo.getRddate()%></font> </li>
						<li><b>党员承诺：</b><font style="font-family:微软雅黑;line-height:2" size="2"> <%=personalInfo.getXfcn()%></font> </li>
						
					</ul>
				</div>
						
					</td>		
			   		
			   	</tr>
			   	
			   	<tr valign="bottom" height="100%">
			   		<td valign="bottom">
					
					
					<ul style="list-style-type: none;vertical-align: bottom">
						
						<li>
						<div id="div-xxxcstar<%=personalInfo.getDyid()%>" style="display: none;position:absolute;z-index:3;background-color: yellow;border:1px solid #000;border-color: black;"><font style="font-family:微软雅黑;" size="2"> <%=personalInfo.getXxxcstardesc()%></font> </div>
						<br />
					
						<b id="xxxcstar<%=personalInfo.getDyid()%>" onmouseover="showTip(this)" onmouseout="hiddenTip(this)">学习宣传星：</b>
						
										
										<img id="xxxcstar-1-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="xxxcstar-2-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="xxxcstar-3-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="xxxcstar-4-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="xxxcstar-5-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)"> 
									
						
						</li>
						<li>
								<div id="div-lzjystar<%=personalInfo.getDyid()%>" style="display: none;position:absolute;z-index:3;background-color: yellow;border:1px solid #000;border-color: black;"><font style="font-family:微软雅黑;" size="2"><%=personalInfo.getLzjystardesc()%></font> </div>
								<br />
								<b id="lzjystar<%=personalInfo.getDyid()%>" onmouseover="showTip(this)" onmouseout="hiddenTip(this)">履职敬业星： </b> 
										<img id="lzjystar-1-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)" >
										<img id="lzjystar-2-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="lzjystar-3-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="lzjystar-4-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="lzjystar-5-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)"> 
									
						</li>
						<li>
						<div id="div-tjxzstar<%=personalInfo.getDyid()%>" style="display: none;position:absolute;z-index:3;background-color: yellow;border:1px solid #000;border-color: black;"><font style="font-family:微软雅黑;" size="2"><%=personalInfo.getTjxzstardesc()%></font> </div>
						<br />
						<b id="tjxzstar<%=personalInfo.getDyid()%>" onmouseover="showTip(this)" onmouseout="hiddenTip(this)">团结协作星： </b>
										<img id="tjxzstar-1-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="tjxzstar-2-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="tjxzstar-3-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="tjxzstar-4-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="tjxzstar-5-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)"> 
										
						</li>
						<li >
						<div id="div-gygxstar<%=personalInfo.getDyid()%>" style="display: none;position:absolute;z-index:3;background-color: yellow;border:1px solid #000;border-color: black;"><font style="font-family:微软雅黑;" size="2"><%=personalInfo.getGygxstardesc()%></font> </div>
						 <br />
						 <b id="gygxstar<%=personalInfo.getDyid()%>" onmouseover="showTip(this)" onmouseout="hiddenTip(this)">公益贡献星：</b>
						 				<img id="gygxstar-1-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="gygxstar-2-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="gygxstar-3-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="gygxstar-4-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="gygxstar-5-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)"> 
										
						</li>
						<li>
						<div id="div-zjsfstar<%=personalInfo.getDyid()%>" style="display: none;position:absolute;z-index:3;background-color: yellow;border:1px solid #000;border-color: black;"><font style="font-family:微软雅黑;" size="2"><%=personalInfo.getZjsfstardesc()%></font> </div>
						<br />
						<b id="zjsfstar<%=personalInfo.getDyid()%>" onmouseover="showTip(this)" onmouseout="hiddenTip(this)">遵纪守法星：</b> 
										<img id="zjsfstar-1-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="zjsfstar-2-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="zjsfstar-3-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="zjsfstar-4-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)">
										<img id="zjsfstar-5-<%=personalInfo.getDyid()%>" alt="" src="<%=request.getContextPath()%>/img/badstar.JPG" width="26" height="26" onclick="changeStar(this)"> 
							
						</li>
						<li><br/> <b>评论：</b></li>
						<li><textarea id="comment-<%=personalInfo.getDyid()%>" rows="3" cols="32" onchange="updateComment(this)"></textarea>  </li>
						
						<li>
							<br/><b>总分：</b><input id="total-<%=personalInfo.getDyid()%>" name="total" type="text" value="0" style="border-style: none;background-color: #F32110" readonly="readonly">  
						</li>
						
					</ul> 
				
				</td>
			   	</tr>
			</table>
			
			</td>
		
		<% 
			
			}else{
				
			%>
				<td></td>
			
			
			<% 
			}
			
		
		}
		%>
		
		</tr>
		
	<%
			
		}  	
  	%>
	</table>
	
  	 
  	 <html:form action="/appraise" styleId="appraiseForm" method="post">
     	<input type="hidden" id="webcontent" name="webcontent" value="<%=request.getContextPath()%>"/>
     	<!--   html:hidden property="webcontent" value="<%=request.getContextPath()%>"/>-->
      	<html:hidden property="appraiseState"/>
     	<html:hidden property="userID" value="<%=userInfo.getUserid()%>"/>
  	  <div align="center">
  	  	<html:button  property="button" onclick="saveAppraise()" value="提交党员评价"></html:button>
  	  		<html:button  property="button" onclick="viewVote()" value="自己评分查看"></html:button>
  	  	<html:button  property="button" onclick="viewAppraise()" value="查看党员排名"></html:button>
  	  </div>
  	
  	 </html:form>
  	
  	</body>
</html>
