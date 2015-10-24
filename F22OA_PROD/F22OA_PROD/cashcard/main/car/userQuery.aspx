<%@ page language="C#" autoeventwireup="true" inherits="userQuery, App_Web_userquery.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>无标题页</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
      <table width="780" height="142" align="center" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td style="width: 780px; height: 15px;">
        &nbsp;</td>
  </tr>
  <tr>
    <td height="116" style="width: 780px" align="center" bgcolor="#cccc99">
   

        &nbsp;<asp:Panel ID="pnlseach" runat="server" Height="78px" Width="409px">
        <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="border-left-color: #339999; border-bottom-color: #339999; border-top-style: solid; border-top-color: #339999; border-right-style: solid; border-left-style: solid; border-right-color: #339999; border-bottom-style: solid">
      <tr>
        <td colspan="2" style="height: 26px; text-align: left" bgcolor="#99cccc">
            <span style="color: #ff0000; font-size: 12pt;">客户个人信息修改 <span style="font-size: 9pt;
                color: #ffff33">步骤一</span>&nbsp;</span></td>
        </tr>
      <tr>
        <td style="height: 34px; width: 65px;" bgcolor="#ccffcc">
            姓名：&nbsp;</td>
        <td style="height: 34px; text-align: left; width: 271px;" bgcolor="#ccffcc">
            <asp:TextBox ID="txtid" runat="server" Width="139px"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator
                ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtid" ErrorMessage="卡号不能为空"
                SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
      </tr>
      <tr>
        <td colspan="2" style="height: 17px; text-align: center;" bgcolor="#ccffcc">
            <asp:Button ID="btnNext" runat="server" Height="29px" Text="下一步" Width="84px" OnClick="btnNext_Click" />&nbsp;</td>
        </tr>
    </table>
        </asp:Panel>
        <asp:Panel ID="pnlgrid" runat="server" Height="200px" Width="780px">
       <table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="border-left-color: #339999; border-bottom-color: #339999; border-top-style: solid; border-top-color: #339999; border-right-style: solid; border-left-style: solid; border-right-color: #339999; border-bottom-style: solid">
      <tr>
        <td colspan="1"  bgcolor="#99cccc" style="height: 1px; width: 602px; text-align: left;">
            <span style="color: #ff0000; font-size: 12pt;">客户个人信息修改 <span style="font-size: 9pt;
                color: #ffff33">步骤二</span></span></td>
        </tr>
      <tr>
        <td  bgcolor="#ccffcc" style="width: 602px; height: 129px">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                ForeColor="#333333" GridLines="None" Height="219px" Width="780px">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <Columns>
                    <asp:TemplateField HeaderText="*">
                        <ItemTemplate>
                            *
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="proposerid" HeaderText="编号" />
                    <asp:BoundField DataField="names" HeaderText="姓名" />
                    <asp:BoundField DataField="sex" HeaderText="性别" />
                    <asp:BoundField DataField="identity" HeaderText="证件号" />
                    <asp:BoundField DataField="tel" HeaderText="固定电话" />
                    <asp:BoundField DataField="add" HeaderText="联系地址" />
                    <asp:BoundField DataField="mtel" HeaderText="移动电话" />
                    <asp:BoundField DataField="passwordtel" HeaderText="密码电话" />
                    <asp:BoundField DataField="comment" HeaderText="备注" />
                    <asp:BoundField DataField="presenter" HeaderText="推荐人" />
                    <asp:BoundField DataField="depotid" HeaderText="建立店铺" />
                </Columns>
                <RowStyle BackColor="#EFF3FB" />
                <EditRowStyle BackColor="#2461BF" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            </td>
     </tr>
      <tr>
        <td colspan="1"  bgcolor="#ccffcc" style="width: 602px">
            &nbsp;</td>
        </tr>
    </table>
</asp:Panel>
        <br />
        
        <br />

</td>
  </tr>
  <tr>
    <td style="width: 780px">
        &nbsp;</td>
  </tr>
</table>
    
    </div>
    </form>
</body>
</html>
