<%@ control language="C#" autoeventwireup="true" inherits="userinfo, App_Web_userinfo.ascx.3cbfc921" %>
<table  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td style="height: 32px; width: 86px;">&nbsp;<asp:Label ID="Label2" runat="server" Font-Names="宋体" Text="姓名："></asp:Label></td>
    <td style="height: 32px; width: 303px; color: #ff3333;">&nbsp;<asp:TextBox ID="txtname" runat="server" MaxLength="50" ></asp:TextBox>(*必填)
        <asp:RequiredFieldValidator ID="RFVname" runat="server" ControlToValidate="txtname"
            ErrorMessage="请填写姓名" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        <asp:CustomValidator ID="csVduser" runat="server" ControlToValidate="txtidcard" ErrorMessage="用户名已经存在"
            OnServerValidate="csVduser_ServerValidate" Display="Dynamic"></asp:CustomValidator>
        <asp:Label ID="lblname" runat="server" ForeColor="Blue"></asp:Label></td>
  </tr>
  <tr>
    <td style="height: 30px; width: 86px;">&nbsp;<asp:Label ID="Label3" runat="server" Text="性别："></asp:Label></td>
    <td style="height: 30px; width: 303px;">&nbsp;&nbsp;
        <asp:RadioButton ID="rbsexm" runat="server" Checked="True" Text="男" GroupName="rbsex" />
        <asp:RadioButton ID="rbsexw" runat="server" Text="女" GroupName="rbsex" /></td>
  </tr>
  <tr>
    <td style="height: 28px; width: 86px;">&nbsp;<asp:Label ID="Label4" runat="server" Text="证件号："></asp:Label></td>
    <td style="height: 28px; width: 303px; color: #ff3333;">&nbsp;<asp:TextBox ID="txtidcard" runat="server" MaxLength="50"></asp:TextBox>(*必填)
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtidcard"
            ErrorMessage="请填写证件号" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        &nbsp;
        &nbsp;&nbsp;
    </td>
  </tr>
  <tr>
    <td style="height: 27px; width: 86px;">&nbsp;<asp:Label ID="Label5" runat="server" Text="固定电话："></asp:Label></td>
    <td style="height: 27px; width: 303px; color: #ff3333;">&nbsp;<asp:TextBox ID="txttel" runat="server" MaxLength="50"></asp:TextBox>(*必填)
        <asp:RequiredFieldValidator ID="RFVtel" runat="server" ControlToValidate="txttel"
            ErrorMessage="请填写固定电话" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
  </tr>
  <tr>
    <td style="width: 86px; height: 28px">&nbsp;<asp:Label ID="Label6" runat="server" Text="联系地址："></asp:Label></td>
    <td style="height: 28px; width: 303px; color: #ff3333;">&nbsp;<asp:TextBox ID="txtaddr" runat="server" MaxLength="50" Width="253px"></asp:TextBox>(*必填)
        <asp:RequiredFieldValidator ID="RFVaddr" runat="server" ControlToValidate="txtaddr"
            ErrorMessage="请填写联系地址" SetFocusOnError="True" Display="Dynamic">*</asp:RequiredFieldValidator></td>
  </tr>
  <tr>
    <td style="height: 28px; width: 86px;">&nbsp;<asp:Label ID="Label7" runat="server" Text="移动电话："></asp:Label></td>
    <td style="height: 28px; width: 303px; color: #ff3333;">&nbsp;<asp:TextBox ID="txtmtel" runat="server" OnTextChanged="txtmtel_TextChanged" MaxLength="50"></asp:TextBox>(*必填)
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtmtel"
            ErrorMessage="请填写移动电话" SetFocusOnError="True">*</asp:RequiredFieldValidator>
    </td>
  </tr>
  <tr>
    <td><asp:Label ID="Label8" runat="server" Text="密码电话：" Visible=false></asp:Label></td>
    <td>
        <asp:TextBox ID="txtpswtel" runat="server" MaxLength="50" Visible=false></asp:TextBox>
        
    </td>
  </tr>
  <tr>
    <td style="width: 86px; height: 27px">&nbsp;<asp:Label ID="Label10" runat="server" Text="备注："></asp:Label></td>
    <td style="height: 27px; width: 303px;">&nbsp;<asp:TextBox ID="txtcomment1" runat="server" MaxLength="50"></asp:TextBox>
        
    </td>
  </tr>
  <tr>
    <td style="height: 28px; width: 86px;">&nbsp;<asp:Label ID="Label11" runat="server" Text="推荐人："></asp:Label></td>
    <td style="height: 28px; width: 303px;">&nbsp;<asp:TextBox ID="txtpresenter" runat="server" MaxLength="50"></asp:TextBox></td>
  </tr>
</table>