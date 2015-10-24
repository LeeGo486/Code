<%@ page language="C#" autoeventwireup="true" inherits="BP_Relogin, App_Web_bp_relogin.aspx.cdcab7d2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>登录</title>
<style type="text/css">
body{ margin:0;padding:0; font-size:9pt;}
#global{ text-align:center; margin:20% 0; background:#f4f4f4; padding:20px 0;}
#globalcontent{ border:solid 1px #007d94; width:640px; overflow:hidden; margin:0 auto;}
#login{ background:#007d94; height:40px; color:white; padding:0;}
#login ul,#login ul{list-style:none; margin:0;padding:0;}
#login ul li{ clear:right;float:left; padding:10px 0; margin:0;line-height:20px;}
#login ul li input{ line-height:18px;margin:0 0 0 4px;padding:0 5px;}
#login ul li .Login_Ipt{border:solid 1px #00353e; width:140px; height:18px; font-size:12px; font-family:tahoma;}
#copyright{text-align:center; font-size:7pt; font-family:tahoma; padding:20px 0 0 0;}
#copyright a{ color:black; text-decoration:underline;}
#copyright a:hover{ color:black; text-decoration:none;}
#TipsFont{
color:#ff3300
}
</style>
<script type="text/javascript">
document.onkeydown=function()
{
   if(event.keyCode==13 && event.srcElement.type!="image")
   {
       //window.alert(event.srcElement.type);
       event.keyCode=9;  
   }
}
</script>
</head>
<body style="vertical-align: middle; text-align: center">
    <form id="frmMain" runat="server">
    <div id="global">
  <div id="globalcontent">
    <div><img src="images/banner.jpg" /></div>
    <div id="login">
      <ul>
      <li>　　用户名：</li>
      <li><asp:TextBox ID="tbuser" runat="server" cname="用户编号" CssClass="Login_Ipt" nullable="n"
                                strnum="y" AccessKey="a" ForeColor="Black"></asp:TextBox></li>
      <li>　　密　码：</li>
      <li><asp:TextBox ID="tbpwd" runat="server" cname="密码" CssClass="Login_Ipt" nullable="n"
			 TextMode="Password" ForeColor="Black"></asp:TextBox></li>
      <li>
      <asp:ImageButton ImageUrl="images/cg_login_0.jpg" onmouseover="this.src='images/cg_login.jpg'"   ID="btok"  CssClass="btSubmit" ToolTip="登录(D)" OnClick="btok_Click" runat="server" AccessKey="d" />
      </li>
      <li>
       <asp:ImageButton ImageUrl="images/cg_reg_0.jpg" onmouseover="this.src='images/cg_reg_0.jpg'"   ID="btregister"  CssClass="btSubmit" ToolTip="注册"  runat="server" AccessKey="d" OnClick="btregister_Click" />
      </li>
      </ul>
     
    </div>
    <div id="TipsFont" ><asp:Label ID="lbtip" runat="server"></asp:Label></div>
  </div>
 	<div id="copyright">Powered by <a href="http://www.zhxit.com/" target="_blank" tabindex="4">ZHX software</a> &copy; 2007-2008 </div>
   </div>
    </form>
</body>
</html>
