<%@ page language="C#" autoeventwireup="true" inherits="consumeQuery, App_Web_consumequery.aspx.f3086b61" %>

<%@ Register Src="usercontrol/header.ascx" TagName="header" TagPrefix="uc1" %>
<%@ Register Src="usercontrol/bottom.ascx" TagName="bottom" TagPrefix="uc2" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>客户历史消费查询</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="style.css" rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/style.css" rel="stylesheet" type="text/css" />
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <link href="/style.css" rel="stylesheet" type="text/css" />
    <link href="../style.css" rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
        rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
  <table width="780" height="142"  align="center" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td style="height: 15px">&nbsp;<uc1:header ID="Header1" runat="server" />
    </td>
  </tr>
  <tr>
    <td style="text-align: center; height: 116px;">
    <asp:Panel ID="pnlseach" runat="server" Height="100px" Width="430px">
        </asp:Panel>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <table border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td style="width: 69px">
            卡号：&nbsp;</td>
        <td style="text-align: left; width: 271px;">
            <asp:TextBox ID="txtstar" runat="server" Width="149px"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtstar" ErrorMessage="卡号不能为空"
                SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
      </tr>
      <tr>
        <td colspan="2" style="text-align: center; ">
            <asp:Button ID="btnNext" runat="server" Height="29px" Text="下一步" Width="84px" OnClick="btnNext_Click" />&nbsp;</td>
        </tr>
    </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="height: 124px">
                <tr>
                    <td colspan="6" style="height: 37px; text-align: left" bgcolor="#99cccc">
                        &nbsp;<span style="color: #ff0033; font-size: 14pt;">充值卡消费查询 </span><span style="font-size: 9pt; color: #ffff33"></span></td>
                </tr>
                <tr>
                    <td style="width: 454px; height: 35px; text-align: left" bgcolor="#ccffcc">
                        &nbsp;卡号：</td>
                    <td style="width: 1368px; height: 35px; text-align: left" bgcolor="#ccffcc">
                        &nbsp;<asp:Label ID="lbcardid" runat="server" ForeColor="#FF6633"></asp:Label></td>        
              
                    <td style="width: 640px; height: 30px; text-align: left; color: #000000;" bgcolor="#ccffcc">&nbsp;用户名：</td>
                   <td style="width: 1003px; height: 30px; text-align: left;" bgcolor="#ccffcc">&nbsp;<asp:Label ID="lbname" runat="server" ForeColor="#FF6633"></asp:Label></td>
                    <td style="width: 983px; height: 30px; text-align: left;" bgcolor="#ccffcc">&nbsp;当前金额：</td>
                   <td style="width: 448px; height: 30px; text-align: left;" bgcolor="#ccffcc">&nbsp;<asp:Label ID="lbsum" runat="server" ForeColor="#FF6633"></asp:Label></td>

               </tr>
      <tr>
        <td colspan="6" style="height: 36px">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                ForeColor="#333333" GridLines="None" Height="100%" Width="100%">
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="*" AccessibleHeaderText="*">
                        <ItemTemplate>
                            *
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField AccessibleHeaderText="流水号" DataField="consumseid" HeaderText="流水号"
                        ReadOnly="True" />
                    <asp:BoundField AccessibleHeaderText="零售单号" DataField="retailid" HeaderText="零售单号"
                        ReadOnly="True" />
                    <asp:BoundField AccessibleHeaderText="金额(元)" DataField="cardsums" HeaderText="金额(元)"
                        ReadOnly="True" />
                    <asp:BoundField AccessibleHeaderText="消费总金额(元)" DataField="sums" HeaderText="消费总金额(元)"
                        ReadOnly="True" />
                    <asp:BoundField AccessibleHeaderText="消费日期" DataField="sure_date" HeaderText="消费日期"
                        ReadOnly="True" />
                    <asp:BoundField AccessibleHeaderText="消费店铺" DataField="depotid" HeaderText="消费店铺"
                        ReadOnly="True" />
                </Columns>
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <EmptyDataTemplate>
                    *
                </EmptyDataTemplate>
                <EditRowStyle BackColor="#999999" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            </asp:GridView>
            &nbsp;</td>
        </tr>
    </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <asp:Panel ID="pnlgrid" runat="server" Height="300px" Width="430px">
            <br />
            <asp:Button ID="btnPrint" runat="server" Height="36px" Text="打印" Width="109px" OnClick="btnPrint_Click" /></asp:Panel>
        
        
        <CR:CrystalReportViewer ID="cryReportView" runat="server" AutoDataBind="true" />
    </td>
  </tr>
  <tr>
    <td>&nbsp;<uc2:bottom ID="Bottom1" runat="server" />
    </td>
  </tr>
</table>
   </div>
    </form>
</body>
</html>
