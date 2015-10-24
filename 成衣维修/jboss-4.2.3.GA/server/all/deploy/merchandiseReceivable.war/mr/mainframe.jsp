<%@page import="org.hy.SSO.mode.Menu"%>
<%@page import="java.util.List"%>
<%@page import="org.hy.mr.mode.UserInfo"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%String webContext = request.getContextPath(); 
  UserInfo userInfo = (UserInfo)request.getSession().getAttribute("userInfo");
%>
<head>
	<title>�ٻ�Ӧ��ϵͳ</title>
	<meta http-equiv="Access-Control-Allow-Origin" content="*">

	
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/css/cmcommon.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/demo/demo.css">
	<link rel="stylesheet" type="text/css" href="<%=webContext%>/jquery-easyui-1.3.1/themes/icon.css">
	<script src="http://192.168.0.89:8001/MenuClick.aspx" type="text/javascript" defer="defer"></script>
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=webContext%>/jquery-easyui-1.3.1/src/jquery.parser.js"></script>
	<script type="text/javascript" src="<%=webContext%>/myjs/authority.js"></script>
	<script>
	var isExistsTab1 = 1;
	function openTab(url,title,menuid){
		
		var ssoSessionID = $('#ssoSessionID').attr('value');
		//var authorityFlag = validateMenuAccessAuthority(menuid,ssoSessionID);
		//if(validateMenuAccessAuthority(menuid,ssoSessionID)==false){
			//return;
		//}
		
		if(isExistsTab1==1){
			$('#tt').tabs('close','��ӭ');
			isExistsTab1 = isExistsTab1-1;
		}
		var tab = $('#tt').tabs('getTab',title);
		if(tab==null || tab=='null'){
			addTab(url,title);
		}else{
			//$('#tt').tabs('select',title);
			//tab.panel('options').content='<iframe width="100%" height="100%" frameborder="0" src="'+url+'"></iframe>';
			$('#tt').tabs('close',title);
			addTab(url,title);
		}
	}
	
	function addTab(url,title){
			$('#tt').tabs('add',{
				title:title,
				//content:'Tab Body ' + index,
				//iconCls:'icon-save',
				closable:true,
				content:'<iframe width="100%" height="100%" frameborder="0" src="'+url+'"></iframe>'
				//tools:[{
					//iconCls:'icon-mini-refresh',
					//handler:function(){
						//var tabpanel = $('#tt').tabs('getTab',title);//���title��ȡtab
						//alert(tabpanel.document.getElementByID('test1').value);
						//alert($('#tt').tabs('getTab','title').panel('options').content);
					//}
				//}]
			});
		}
	
	function openMainWindow(url){
		$("#mainWindow").attr('src',$('#webContext').attr('value')+url);
	}	
	
 	function logout(){
 		window.location.href=$('#webContext').attr('value')+'/web/logout!logout';
 	}
		
	function freshSubWindow(){
		document.getElementById('mainWindow').contentWindow.document.forms[0].submit();
	}	
	</script>
</head>
<body class="easyui-layout">en<br>
	<input type="hidden" id="webContext" value="<%=webContext%>">
	<input type="hidden" id="ssoSessionID" value="<%=userInfo.getSsoSessionID()%>">
	<s:form action="/web/cm-main-frame!initFrame" theme="simple">
	
	<div style="position: absolute; left:95%;top:5px;z-index: 10"><a onclick="logout()"><font style="color:#15428B;cursor: pointer;font-weight: bold; ">ע��</font></a></div>
	<div data-options="region:'west',split:true" title="�ٻ�Ӧ��ϵͳ" style="width:160px;padding1:1px;overflow:hidden;">
		<div class="easyui-accordion" data-options="fit:true,border:false">
			
		
			
			<div title="�ٻ�Ӧ��ϵͳ�˵�" style="padding:10px;overflow:auto;">
				
				<%--
				<s:iterator  value="#request.menuList" id="menu">
					<p onclick="openMainWindow( '<s:property value="actionUrl"/> ');" style="cursor: pointer;color: #15428B;" > <s:property value="menuname"/> </p>
				</s:iterator>
				 --%>
				<% 
				if(userInfo.getUserid().equals("������")){
				%>
				<%-- 
				<a target="mainWindow" href="<%=webContext%>/web/acct-period-input!initInput"   style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%>/web/acct-period-input!initInput','����¼��');">����¼�� </a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/acct-period-input!initImport"  style="cursor: pointer;color: #15428B;;text-decoration:none" >������������</a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/daily-business!init"  style="cursor: pointer;color: #15428B;;text-decoration:none" >����������</a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/received-import!init"  style="cursor: pointer;color: #15428B;;text-decoration:none" >ʵ�յ���</a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/reveiced-flow-query!init"  style="cursor: pointer;color: #15428B;;text-decoration:none" >ʵ����ˮ��ѯ</a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/merchan-receivable-query!init"  style="cursor: pointer;color: #15428B;;text-decoration:none" >�ֹ�˾�ٻ�Ӧ�ղ�ѯ</a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/exclude-style!init"  style="cursor: pointer;color: #15428B;;text-decoration:none" >��ʽ�ų�����</a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/acct-config!init"  style="cursor: pointer;color: #15428B;text-decoration:none" >���ڵ���ά��</a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/acct-config!queryConfigList"  style="cursor: pointer;color: #15428B;text-decoration:none" >���ڵ�����ѯ</a><br><br>
				<a target="mainWindow" href="<%=webContext%>/web/market-archives!init"  style="cursor: pointer;color: #15428B;text-decoration:none" >��ҵά��</a><br><br>
				--%>
				<a style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%>/web/acct-period-input!initInput','����¼��');">����¼�� </a><br><br>
				<a style="cursor: pointer;color: #15428B;;text-decoration:none" onclick="openTab('<%=webContext%>/web/acct-period-input!initImport','������������');">������������</a><br><br>
				<a style="cursor: pointer;color: #15428B;;text-decoration:none" onclick="openTab('<%=webContext%>/web/daily-business!init','����������');">����������</a><br><br>
				<a style="cursor: pointer;color: #15428B;;text-decoration:none" onclick="openTab('<%=webContext%>/web/received-import!init','������ˮ����');">������ˮ����</a><br><br>
				<a style="cursor: pointer;color: #15428B;;text-decoration:none" onclick="openTab('<%=webContext%>/web/reveiced-flow-query!init','������ˮ��ѯ');">������ˮ��ѯ</a><br><br>
				<a style="cursor: pointer;color: #15428B;;text-decoration:none" onclick="openTab('<%=webContext%>/web/merchan-receivable-query!init','�ֹ�˾�ٻ�Ӧ�ղ�ѯ');">�ֹ�˾�ٻ�Ӧ�ղ�ѯ</a><br><br>
				<a style="cursor: pointer;color: #15428B;;text-decoration:none" onclick="openTab('<%=webContext%>/web/exclude-style!init','��ʽ�ų�����');">��ʽ�ų�����</a><br><br>
				<a style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%>/web/acct-config!queryConfigList','���ڵ���ά��');">���ڵ���ά��</a><br><br>
				<%-- <a style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%>/web/acct-config!queryConfigList','���ڵ�����ѯ');">���ڵ�����ѯ</a><br><br> --%>
				<a style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%>/web/note-import!init','��Ʊ����');">��Ʊ����</a><br><br>
				<a style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%>/web/finance-data-import','�������ݵ���');">�������ݵ���</a><br><br>
				<a style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%>/web/market-archives!queryMarketList','��ҵά��');">��ҵά��</a><br><br>
				
				<%}else{ 
					List<Menu> list = (List<Menu>)request.getAttribute("menuList");
					
					for(Menu menu:list){%>
						<font size="6" color="#15428B"> <b><%=menu.getMenu_Name()%></b></font> <br><br>
						
					
					<%
						List<Menu> subList = menu.getSubMenuList();
						for(Menu subMenu:subList){ %>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%><%=subMenu.getActionURL()%>'+'?menuID='+<%=subMenu.getMenu_Id()%>,'<%=subMenu.getMenu_Name()%>','<%=subMenu.getMenu_Id()%>')"    ><%=subMenu.getMenu_Name()%></a><br><br>
						<%}
					
					}
				%>
				<!--  	<p onclick="openMainWindow( '<s:property value="actionURL"/> ');" style="cursor: pointer;color: #15428B;" > <s:property value="menu_Name"/> </p>-->
				<!--	<a style="cursor: pointer;color: #15428B;text-decoration:none" onclick="openTab('<%=webContext%><s:property value="actionURL"/>'+'?menuID='+<s:property value="menu_Id"/>,'<s:property value="menu_Name"/>','<s:property value="menu_Id"/>')"   style="cursor: pointer;color: #15428B;text-decoration:none" ><s:property value="menu_Name"/> </a><br><br><!-->
				
				<%} %>
			
			</div>
			
			<!--  
			<div title="Title2" data-options="selected:true" style="padding:10px;">
				content2
			</div>
			<div title="Title3" style="padding:10px">
				content3
			</div>
			-->
		</div>
	</div>
	
	
	
	<div data-options="region:'center'" title="�ٻ�Ӧ��" >
			
		<div id="tt" class="easyui-tabs" data-options="tools:'#tab-tools'" style="overflow:hidden;height: 580px" >
			<div title="��ӭ" data-options="closable:true,cache:false,href:'<%=webContext%>/mr/mainBlank.jsp'" style="padding:20px;">
			</div>
		</div>	
		
	<!-- 	<iframe id="mainWindow" name="mainWindow" width="100%" height="100%" frameborder="0" src="<%=webContext%>/mr/mainBlank.jsp"></iframe> -->
			
			
 	</div>
</s:form>
</body>
</html>