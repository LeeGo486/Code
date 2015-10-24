<%@ page language="C#" autoeventwireup="true" inherits="usermodify, App_Web_usermodify.aspx.f3086b61" %>

<%@ Register Src="usercontrol/header.ascx" TagName="header" TagPrefix="uc2" %>
<%@ Register Src="usercontrol/bottom.ascx" TagName="bottom" TagPrefix="uc3" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<%@ Register Src="usercontrol/userinfo.ascx" TagName="userinfo" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>用户信息修改</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript">
<!--


// -->
</script>

    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
      <table width="780" height="142" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td style="width: 780px; height: 15px;">
        <uc2:header ID="Header1" runat="server" />
        &nbsp;</td>
  </tr>
  <tr>
    <td height="116" style="width: 780px" align="center" bgcolor="#cccc99">
   

        &nbsp;<asp:Panel ID="Panel1" runat="server" Height="78px" Width="409px">
        <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="border-left-color: #339999; border-bottom-color: #339999; border-top-style: solid; border-top-color: #339999; border-right-style: solid; border-left-style: solid; border-right-color: #339999; border-bottom-style: solid">
      <tr>
        <td colspan="2" style="height: 26px; text-align: left" bgcolor="#99cccc">
            <span style="color: #ff0000; font-size: 12pt;">客户个人信息修改 <span style="font-size: 9pt;
                color: #ffff33">步骤一</span>&nbsp;</span></td>
        </tr>
      <tr>
        <td style="height: 34px; width: 59px;" bgcolor="#ccffcc">
            卡号：&nbsp;</td>
        <td style="height: 34px; text-align: left; width: 271px;" bgcolor="#ccffcc">
            <asp:TextBox ID="txtcardid" runat="server"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtcardid" ErrorMessage="卡号不能为空"
                SetFocusOnError="True">*</asp:RequiredFieldValidator>
            <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtcardid"
                ErrorMessage="卡号不存在" OnServerValidate="CustomValidator1_ServerValidate" SetFocusOnError="True"></asp:CustomValidator></td>
      </tr>
      <tr>
        <td colspan="2" style="height: 17px; text-align: center;" bgcolor="#ccffcc">
            <asp:Button ID="btnNext" runat="server" Height="29px" Text="下一步" Width="84px" OnClick="btnNext_Click" />&nbsp;</td>
        </tr>
    </table>
        </asp:Panel>
        <asp:Panel ID="Panel2" runat="server" Height="50px" Width="407px" Visible="False">
            <table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" id="TABLE1" language="javascript" onclick="return TABLE1_onclick()" style="border-left-color: #339999; border-bottom-color: #339999; border-top-style: solid; border-top-color: #339999; border-right-style: solid; border-left-style: solid; border-right-color: #339999; border-bottom-style: solid">
            <tr>
                <td align="left" style="width: 509px; height: 30px;" bgcolor="#99cccc">
                    <span style="color: #ff3366">&nbsp;<span style="font-size: 12pt">客户个人信息修改 <span style="font-size: 9pt;
                        color: #ffff33">步骤二</span></span></span></td>
            </tr>
            <tr>
                <td align="left" style="width: 509px; height: 164px" bgcolor="#ccffcc">
                    &nbsp;<table align="center" border="0" cellpadding="0" cellspacing="0"
                        style="width: 350px; height: 256px;">
                        <tr>
                            <td style="width: 98px; height: 16px">
                                流水号：</td>
                            <td style="width: 288px; font-family: Times New Roman; height: 16px">
                                <asp:Label ID="lbproposerid" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="height: 16px; width: 98px;">
                                &nbsp;<asp:Label ID="Label2" runat="server" Font-Names="宋体" Text="姓名："></asp:Label></td>
                            <td style="font-family: Times New Roman; height: 16px; width: 288px;">
                                &nbsp;<asp:TextBox ID="txtname" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVname" runat="server" ControlToValidate="txtname"
                                    ErrorMessage="请填写姓名" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr style="color: #000000; font-family: Times New Roman">
                            <td style="height: 26px; width: 98px;">
                                &nbsp;<asp:Label ID="Label3" runat="server" Text="性别："></asp:Label></td>
                            <td style="height: 26px; width: 288px;">
                                &nbsp;<asp:TextBox ID="txtsex" runat="server" ReadOnly="True"></asp:TextBox></td>
                        </tr>
                        <tr style="font-family: Times New Roman">
                            <td style="height: 28px; width: 98px;">
                                &nbsp;<asp:Label ID="Label4" runat="server" Text="证件号："></asp:Label></td>
                            <td style="height: 28px; width: 288px;">
                                &nbsp;<asp:TextBox ID="txtidcard" runat="server" Enabled="False" ReadOnly="True"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="REVidcare" runat="server" ControlToValidate="txtidcard"
                                    ErrorMessage="证件号填写错误，请填写正确的证件号" SetFocusOnError="True" ValidationExpression="\d{17}[\d|X]|\d{15}">*</asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtidcard"
                                    ErrorMessage="请填写证件号" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr style="color: #000000; font-family: Times New Roman">
                            <td style="height: 29px; width: 98px;" bgcolor="#ccffcc">
                                &nbsp;<asp:Label ID="Label5" runat="server" Text="固定电话："></asp:Label></td>
                            <td style="height: 29px; width: 288px;" bgcolor="#ccffcc">
                                &nbsp;<asp:TextBox ID="txttel" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVtel" runat="server" ControlToValidate="txttel"
                                    ErrorMessage="请填写固定电话" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr style="font-family: Times New Roman">
                            <td height="13" style="width: 98px">
                                &nbsp;<asp:Label ID="Label6" runat="server" Text="联系地址："></asp:Label></td>
                            <td style="width: 288px">
                                &nbsp;<asp:TextBox ID="txtaddr" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVaddr" runat="server" ControlToValidate="txtaddr"
                                    ErrorMessage="请填写联系地址" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr style="font-family: Times New Roman">
                            <td style="height: 30px; width: 98px;">
                                &nbsp;<asp:Label ID="Label7" runat="server" Text="移动电话："></asp:Label></td>
                            <td style="height: 30px; width: 288px;">
                                &nbsp;<asp:TextBox ID="txtmtel" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr style="font-family: Times New Roman">
                            <td style="height: 14px; width: 98px;">
                                &nbsp;<asp:Label ID="Label8" runat="server" Text="密码电话："></asp:Label></td>
                            <td style="height: 14px; width: 288px;">
                                &nbsp;<asp:TextBox ID="txtpswtel" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr style="font-family: Times New Roman">
                            <td style="width: 98px; height: 14px">
                                <asp:Label ID="Label1" runat="server" Text="说明："></asp:Label></td>
                            <td style="width: 288px; height: 14px">
                                <asp:TextBox ID="txtcomment" runat="server"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr style="font-family: Times New Roman">
                <td align="left" style="width: 509px; height: 19px; text-align: center;">
                    <asp:Button ID="btnpre" runat="server"
                            Text="上一步" Width="77px" Height="28px" OnClick="btnpre_Click" OnClientClick="~/cashcard/main/usermodify.aspx" PostBackUrl="~/cashcard/main/usermodify.aspx" />
                    &nbsp; &nbsp;<asp:Button ID="btnupdate" runat="server"  Text="完成" Width="94px" OnClick="btnupdate_Click" Height="27px" />
                    &nbsp; &nbsp;&nbsp;
                </td>
            </tr>
        </table></asp:Panel>
        <CR:CrystalReportViewer ID="cryReportView" runat="server" AutoDataBind="true" />
        <br />

</td>
  </tr>
  <tr>
    <td style="width: 780px">
        <uc3:bottom ID="Bottom1" runat="server" />
        &nbsp;</td>
  </tr>
</table>
        
    
    </div>
    </form>
</body>
</html>
