<%@ page language="C#" autoeventwireup="true" inherits="manager_manage_flow, App_Web_manage_flow.aspx.3665c05a" %>

<%@ Register Src="../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
     <title>管理页</title>
    		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
    <script type="text/javascript">
    function lc(th){
			if(th){
			 LoadClass(th.href,th.innerHTML)
			 return false
			}
		}
    </script>
</head>
<body topMargin="1" leftmargin="1" rightmargin="0">
    <form id="form1" runat="server">
    <div><uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <div >
    <div class="content"><h2><strong>
        常用控制面板
       </strong></h2></div>
       <div style="clear:both;padding:0 40px; line-height:24px;">
        <div style="text-align:left; width:50%; clear:right;float:left;" >
        <ul><li><a href="area.aspx" onclick="javascript:return lc(this);">部门管理</a> 
         <!--   <li><a href="user/role.aspx" onclick="javascript:return lc(this);">角色管理</a> </li> -->
            </li>
            <li><a href="user/duty.aspx" onclick="javascript:return lc(this);">职位管理</a> </li>
            <!--  <li><a href="userlist.aspx" onclick="javascript:return lc(this);">用户管理</a> </li>-->
            <li><a href="system/mng_company.aspx" onclick="javascript:return lc(this);">系统设置</a> 
          <!--   <li><a href="menus.aspx" onclick="javascript:return lc(this);">菜单管理</a></li>  -->
            </li>
            <li><a href="user/userpowerset.aspx" onclick="javascript:return lc(this);">邮件短信权限管理</a></li>
            <li><a href="../isprit/news/d_newsadd.aspx?action=add" onclick="javascript:return lc(this);">发布新闻 </a></li>
        </ul>

            
        </div>
        <div style="text-align:left; width:50%; clear:right;float:left;" >
         <ul>
            <li><a href="publicfolder/uploadfile.aspx" onclick="javascript:return lc(this);">公共文件上传</a> </li>
            <li><a href="publicfolder/publicfile.aspx" onclick="javascript:return lc(this);">公共文件管理</a> </li>
            <li><a href="publicFolder/folder_mng.aspx" onclick="javascript:return lc(this);">设置公共文件类型</a> </li>
            <li><a href="../isprit/news/allpic.aspx" onclick="javascript:return lc(this);">新闻图片管理</a> </li>
            <li><a href="../isprit/news/D_DELNEWS.ASPX" onclick="javascript:return lc(this);">新闻管理 </a></li>
            
        </ul>       
        </div>
        </div>
        </div>
    </div>
    </form>
</body>
</html>
