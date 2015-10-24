<%@ page language="C#" autoeventwireup="true" inherits="reloginZT, App_Web_reloginzt.aspx.cdcab7d2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title id="Title1" runat="server">登录</title>
<style type="text/css">
a,p,div,body{ font-size:12px;}
body{ background:#75a9b7 url(images/login_c02.gif) repeat-x; margin:0; padding:0;}
#login{ margin:88px auto 0 auto; text-align:left; width:596px; background:#FFF;}
#login_banner{ background:url(images/login_c05.gif) center no-repeat; height:208px; padding:8px; clear:both;}
#login_form{ height:50px; margin:0; padding:5px 5px 5px 10px; background:url(images/login_c08.gif) repeat-x bottom;}
#login_form ul{ margin:0;padding:0;clear:both; list-style:none;}
#login_form ul li{ clear:right;float:left; padding:0; margin:0;}
#login_form ul img{ margin:5px;}
#login_form .Login_Ipt{width:100px;ime-mode:disabled;}
#login_form .Login_btn{ margin-left:10px;}
#login_form #login_title li{ width:23%; text-align:left}
#login_shadow{background:url(images/login_c05-05.gif) repeat-x; height:60px; overflow:hidden; clear:both;
	text-align:center; line-height:60px; color:red;}
#login_shadow #lbtip{line-height:30px; margin-top:10px; padding:0 20px;}
#login_shadow #TipsFontIcon{ font-family:webdings; font-size:16px;}
</style>
</head>
<body>
<script type="text/javascript" defer="defer">
var t = top.location.href;
var s = self.location.href;
if(t!=s){top.location.href = s;}
</script>

<form id="frmMain" runat="server">
<div style="text-align:center;">
    <div id="login">
        <div id="login_banner"></div>
        <div id="login_form">
        <ul id="login_title">
        <li>　帐套名称&darr;</li>
        <li>授权代码&darr;</li>
        <li>操作员代码&darr;</li>
        <li>口令&darr;</li>
        </ul>
        <ul>
        <li><asp:DropDownList ID="DDList" runat="server" CssClass="Login_Ipt"
             nullable="n" strnum="y" AccessKey="d" /></li>
        <li><img src="images/key.gif" alt="帐套密码" /></li>
        <li><asp:TextBox ID="TxtChangepwd" runat="server" CssClass="Login_Ipt"
             cname="密码" nullable="n"  TextMode="Password" /></li>
        <li><img src="images/user.gif" alt="操作员代码" /></li>
        <li><asp:TextBox ID="tbuser" runat="server" CssClass="Login_Ipt"
             cname="用户编号" nullable="n" strnum="y" AccessKey="a"  style="ime-mode:disabled"  /></li>
        <li><img src="images/lock.gif" alt="密码" /></li>
        <li><asp:TextBox ID="tbpwd" runat="server" CssClass="Login_Ipt"
             cname="密码" nullable="n" TextMode="Password" /></li>
        <li><asp:ImageButton ImageUrl="images/login_c07.gif" CssClass="Login_btn"
         ID="btok" OnClick="btok_Click" runat="server" AccessKey="d" /></li>
        </ul>
		</div>
        <div id="login_shadow"><asp:Label ID="lbtip" runat="server"></asp:Label></div>
    </div>
		<colgroup>
		<col style="text-align:right;font-weight:bold;color:White;" />
		<col />
		<col style="color:White;" />
		</colgroup>
    </div>
<asp:HiddenField ID="ServerDate" runat="server" />
<script type="text/javascript">
var sdstr = document.getElementById("ServerDate").value; //server date
var ld = (new Date());
var ldstr = ld.getFullYear()+"-"+((ld.getMonth()+1)<10?"0"+(ld.getMonth()+1):(ld.getMonth()+1))+"-"+((ld.getDate())<10?"0"+(ld.getDate()):(ld.getDate()));

if(sdstr!=ldstr)
{
    alert('服务器日期与客户端日期不一致！\n请修改本地日期后再登录！\n\n参考信息：\n服务器日期：'+sdstr+'\n客户端日期：'+ldstr+'');
}

</script>

    </form>
</body>
</html>
