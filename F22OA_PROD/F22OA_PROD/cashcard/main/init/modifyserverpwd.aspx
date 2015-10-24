<%@ page language="C#" autoeventwireup="true" inherits="init_modifyserverpwd, App_Web_modifyserverpwd.aspx.becd6e10" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>更改配制服务器密码</title>
<style type="text/css">
body{
margin:0px;
padding:0px;
background:#ebf3f6;
}
*{
font-size:12px;
}
#globTable{
margin-top:200px;
background:url(../images/login_05.gif) repeat-x;
table-layout:fixed;
}
.Login_Ipt{
border:solid 1px #1c4779;
}
#TipsFontIcon{
font-family:Webdings;
color:#ff3300;
font-size:16px;
}
#TipsFont{
color:#ff3300
}
.btSubmit{
width:94px;height:30px;}
</style>
</head>
<body>
<form id="form1" runat="server">
<div>
	<asp:ScriptManager ID="ScriptManager1" runat="server">
	</asp:ScriptManager>
	        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
<table width="370" border="0" align="center" cellpadding="0" cellspacing="0" id="globTable">
  <tr>
    <td width="16"><img src="../images/login_08.gif" width="15" height="260" /></td>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td><img src="../images/link_07.gif" width="118" height="54" /></td>
      </tr>
      <tr>
        <td height="125"><table border="0" align="center" cellpadding="0" cellspacing="8">
		<colgroup>
		<col style="text-align:right;font-weight:bold;color:white;" />
		<col />
		<col style="color:white;" />
		</colgroup>
        
           <tr>
            <td>
                原密码:</td>
            <td style="width: 134px"><asp:TextBox ID="txtoldpwd" runat="server" cname="用户编号" TextMode="Password"></asp:TextBox></td>
            <td style="width: 80px"><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtoldpwd"
                                ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtoldpwd"
                    Display="Dynamic" ErrorMessage="原密码不正确!" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator></td>
          </tr>
          <tr>
            <td>
                新密码:</td>
            <td style="width: 134px"><asp:TextBox ID="txtnewpwd"  runat="server" cname="密码" TextMode="Password"></asp:TextBox></td>
            <td style="width: 17px"><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnewpwd"
                                ErrorMessage="*"></asp:RequiredFieldValidator></td>
          </tr>
          <tr>
            <td >
                确认新密码:</td>
            <td style="width: 134px"><asp:TextBox ID="txtrenewpwd"  runat="server" cname="密码" TextMode="Password"></asp:TextBox></td>
            <td style="width: 80px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtrenewpwd"
                    Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtnewpwd"
                    ControlToValidate="txtrenewpwd" ErrorMessage="密码不一致!" Display=dynamic></asp:CompareValidator></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="45" valign="top">
		<div style="margin-right:30px;text-align:center;"> 
                            
							<asp:ImageButton ImageUrl="../images/link_14.gif" ID="BtnChange" runat="server" CssClass="btSubmit"  Text="修改连接"  OnClick="BtnChange_Click" />
            </div>
            
           
		</td>
      </tr>
      <tr>
        <td><div id="TipsFont"><asp:Label ID="lbtip" runat="server"></asp:Label></div></td>
      </tr>
    </table></td>
    <td width="10"><img src="../images/login_03.gif" width="17" height="260" alt="" /></td>
  </tr>
</table>

    <asp:HiddenField ID="HFserver" runat="server" />
    <asp:HiddenField ID="HFuid" runat="server" />
    <asp:HiddenField ID="HFpwd" runat="server" />
    
               </ContentTemplate>
        </asp:UpdatePanel>
          
    </div>
        
    </form>
</body>
</html>
