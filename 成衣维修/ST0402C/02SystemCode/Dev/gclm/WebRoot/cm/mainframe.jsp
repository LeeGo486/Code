<%@page import="org.hy.model.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%String webContext = request.getContextPath(); 
  UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
%>
<head>
	<title>成衣维修</title>
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/css/cmcommon.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/demo/demo.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/themes/icon.css">
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/src/jquery.parser.js"></script>
	<script>
	 function addTab(title, url){
			if ($('#tabs').tabs('exists', title)){
				$('#tabs').tabs('select', title);
			} else {
				var height = $('.panel-body').height() - $('.tabs-header').height();
				var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:'+height+'px"></iframe>';
				$('#tabs').tabs('add',{
					title:title,
					content:content,
					closable:true
				});
			}
		} 	 
     
     
	 
	 
	$(function(){   
		$("#btn").click(function(e){                
			$('#menu').menu('show', {            
				left: e.pageX,            
				top: e.pageY        
				});    
			});
		
	    //刷新  
	    $("#m-refresh").click(function(){    
	    	var currTab = $('#tabs').tabs('getSelected');    
	    	//获取选中的标签项       
	    	var url = $(currTab.panel('options').content).attr('src'); 
	    	//获取该选项卡中内容标签（iframe）的 src 属性        
	    	/* 重新设置该标签 */       
	    	$('#tabs').tabs('update',{            
	    		tab:currTab,            
	    		options:{                
	    					content: url,
	  		          		closable:false  
	    				}        
	    			})  ;  
	    		});       
	    //关闭所有   
		$("#m-closeall").click(function(){        
			$(".tabs li").each(function(i, n){            
				var title = $(n).text();            
				$('#tabs').tabs('close',title);            
					});    
				});        
	    //除当前之外关闭所有    
	    $("#m-closeother").click(function(){        
	    	var currTab = $('#tabs').tabs('getSelected');        
	    	currTitle = currTab.panel('options').title;                    
	    	$(".tabs li").each(function(i, n){            
	    		var title = $(n).text();                        
	    		if(currTitle != title){                
	    			$('#tabs').tabs('close',title);                        
	    				}        
	    			});    
	    		});        
	    //关闭当前   
	    	$("#m-close").click(function(){       
	    		var currTab = $('#tabs').tabs('getSelected');        
	    		currTitle = currTab.panel('options').title;            
	    		$('#tabs').tabs('close', currTitle);    
	    	});
	    
	    
	    /*为选项卡绑定右键*/    
	    	$(".tabs li").live('contextmenu',function(e){                
	    		/* 选中当前触发事件的选项卡 */        
	    		var subtitle =$(this).text();        
	    		$('#tabs').tabs('select',subtitle);               
	    //显示快捷菜单        
	    $('#menu').menu('show', {            
	    	left: e.pageX,            
	    	top: e.pageY        });               
				return false;    
			});
	    
		});
	
	
	
	function openMainWindow(name,url){
		
		 addTab(name,$('#webContext').attr('value')+url);
		
		//$("#mainWindow").attr('src',$('#webContext').attr('value')+url);
	}	
	
	function gotoRoleManage(){
		//document.frames['mainWindow'].location.href=$('#webContext').attr('value')+'/authority/rolemanage.jsp';
		$("#mainWindow").attr('src',$('#webContext').attr('value')+'/authority/rolemanage.jsp'); 
	}
 	function gotoRoleGrant(){
 		$("#mainWindow").attr('src',$('#webContext').attr('value')+'/authority/grant.jsp');
 	}
 	
 	function logout(){
 		window.location.href=$('#webContext').attr('value')+'/web/logout!logout';
 	}
		
		
	</script>
	<style type="text/css">
		body{font-family:"微软雅黑"}
		
 .d_over{background-color:#ffffff; }
.d_out{background-color:#EFEFEF;}

	</style>
</head>
<body class="easyui-layout"><br>
	<input type="hidden" id="webContext" value="<%=webContext%>">
	
	<s:form action="/web/cm-main-frame!initFrame" theme="simple">
	
	<div style="position: absolute; left:85%;top:5px;z-index: 10"><font><%=userInfo.getUsername() %>，欢迎你！</font><a onclick="logout()"><font style="color:#15428B;cursor: pointer;font-weight: bold; ">注销</font></a></div>
	<div data-options="region:'west',split:true" title="成衣维修菜单" style="width:160px;padding1:1px;overflow:hidden;">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			
			<%if("cmadmin".equals(userInfo.getUserid())){ %>
			<div title="系统维护" style="padding:10px;overflow:auto;">
				<p onclick="gotoRoleManage()" style="cursor: pointer;color: #15428B;">角色管理</p>
				<p onclick="gotoRoleGrant()"  style="cursor: pointer;color: #15428B;">角色授权</p>
				
			</div>
			<%}else{ %>
			
			<div title="成衣维修"  style="padding:10px;overflow:auto;height:20;width: 90">
				<s:iterator  value="#request.menuList" id="menu" >
					 <p   onclick="openMainWindow( '<s:property value="menu_Name"/>','<s:property value="actionURL"/> ');"  class="d_over"
						onmouseover="this.className='d_out'"  onmouseout="this.className='d_over'"
						style="cursor: pointer;color: #15428B;font-size:9.5pt;text-align: left; " >
						<%--<img  src="<%=webContext %>/img/btnbg.jpg"  > --%> 
						<s:property value="menu_Name"/>
					</p>
					</s:iterator>
			</div>
			<%} %>
		
		</div>
	</div>
	
	<div data-options="region:'center'" title="成衣维修" style="overflow:hidden;width: 100%;height: 100%;" >
	 	<div id="tabs" class="easyui-tabs" > 
		 	<div title="成衣维修" class="easyui-tabs"  data-options="closable:true,border:false">
				     <iframe scrolling="auto" id="mainWindow" name="mainWindow" frameborder="0" width="100%" height="800px" frameborder="0" src="<%=webContext%>/cm/mainBlank.jsp" ></iframe>
		 	</div>  
	    </div>
 	</div>
 	<div style="display: none">
	 	<div id="menu" class="easyui-menu" 
	 	style="width:150px;">    
	 	<%--<div id="m-refresh">刷新</div>    
	 	--%><div class="menu-sep"></div>    
	 	<div id="m-closeall">全部关闭</div>    
	 	<div id="m-closeother">除此之外全部关闭</div>    
	 	<div class="menu-sep"></div>  
	    <div id="m-close">关闭</div></div>
    </div>
</s:form>
</body>
</html>