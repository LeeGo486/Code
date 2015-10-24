<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserEditPwd, App_Web_bp_usereditpwd.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="css/project.css" type="text/css"  rel="stylesheet">
    		       
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
          <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">密码修改</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
   <!--head end-->
    
    <div  class="BContent"  >
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
       
    
    <table borderColor="#cccccc"  cellSpacing="0" cellPadding="0" borderColorDark="#ffffff"  width="800" align="center" border="1" style="vertical-align:middle; margin-top:50px">
   <colgroup>
   <col  align="right" width="300px"/>
   <col  align="left"/>
   </colgroup>
    <tr>
    <td colspan="2" align="center"><asp:Label id="LblAlart" runat="server" ForeColor="Red"></asp:Label></td>
    </tr>
    <tr>
    </tr>
    <tr>
    <td>旧密码：</td>
    <td><asp:TextBox id="txtoldpsw" runat="server" Width="216px" TextMode="Password" CssClass="tbox"></asp:TextBox><asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ErrorMessage="卡号不能为空" ControlToValidate="txtoldpsw">*</asp:RequiredFieldValidator></td>
    </tr>
      <tr>
    <td>新密码：</td>
    <td><asp:TextBox id="txtnewpsw" runat="server" Width="216px" TextMode="Password"  CssClass="tbox"></asp:TextBox>
    <asp:RequiredFieldValidator id="RFVpsw" runat="server" ErrorMessage="请输入新密码" ControlToValidate="txtnewpsw" SetFocusOnError="True">*</asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" ErrorMessage="*密码只能是数字或者字母" ControlToValidate="txtnewpsw" ForeColor="Blue" ValidationExpression="^[A-Za-z0-9]*$"></asp:RegularExpressionValidator></td>
    </tr>
    <tr>
    <td>确认密码：</td>
    <td>
    <asp:TextBox id="txtnewpsw2" runat="server" Width="216px" TextMode="Password"  CssClass="tbox"></asp:TextBox>
    <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" ErrorMessage="新密码不能为空" ControlToValidate="txtnewpsw2">*</asp:RequiredFieldValidator>
    <asp:CompareValidator id="CVpsw" runat="server" ErrorMessage="两次密码输入不一致" ControlToValidate="txtnewpsw2" SetFocusOnError="True" ControlToCompare="txtnewpsw"></asp:CompareValidator>
    </td>
    </tr>

    <td colspan="2" align="center"><asp:Button id="btnmd" onclick="btnmd_Click" runat="server" Width="100px" Text="修改密码"  CssClass="btn" ></asp:Button></td>
    </table>
    </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
