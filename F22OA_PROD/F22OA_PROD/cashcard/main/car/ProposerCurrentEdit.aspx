<%@ page language="C#" autoeventwireup="true" inherits="car_ProposerCurrentEdit, App_Web_proposercurrentedit.aspx.f3086b61" %>

<%@ Register Src="usercontrol/userinfo.ascx" TagName="userinfo" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>编辑卡当前使用人资料</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href=".././css/default.css" rel="stylesheet" type="text/css" />
    <base target="_self" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <br />
 <table  border="1" cellpadding="0" cellspacing="0" align=center bordercolordark="#ffffff" bordercolor="#cccccc" width=95%>
    <tr height=40px><td colspan=2  align=center><asp:Label ID="Label1" runat="server" Text="维护充值卡使用人档案"  Font-Size="14pt" ForeColor=red></asp:Label></td></tr>
  <tr height=30px>
    <td align=right  width=20%>客户编号：</td>
    <td>
        <asp:TextBox ID="txtClientID" runat="server" Enabled=false Width="400px"></asp:TextBox></td>
  </tr>
  <tr>
    <td style="height: 30px;" align=right>姓名：</td>
    <td style="height: 30px;  color: #ff3333;"><asp:TextBox ID="txtname" runat="server" MaxLength="50" Width="400px" ></asp:TextBox>*
        <asp:RequiredFieldValidator ID="RFVname" runat="server" ControlToValidate="txtname"
            ErrorMessage="请填写姓名" SetFocusOnError="True">*</asp:RequiredFieldValidator>
            </td>
  </tr>
  <tr>
    <td style="height: 30px;" align=right>性别：</td>
    <td style="height: 30px;">&nbsp;&nbsp;
        <asp:RadioButton ID="rbsexm" runat="server" Checked="True" Text="男" GroupName="rbsex" />
        <asp:RadioButton ID="rbsexw" runat="server" Text="女" GroupName="rbsex" /></td>
  </tr>
  <tr>
    <td style="height: 30px; " align=right>证件号：</td>
    <td style="height: 30px;  color: #ff3333;"><asp:TextBox ID="txtidcard" runat="server" MaxLength="50" Width="400px"></asp:TextBox>*
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtidcard"
            ErrorMessage="请填写证件号" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        &nbsp;
        &nbsp;&nbsp;
    </td>
  </tr>
  <tr>
    <td style="height: 30px; " align=right>固定电话：</td>
    <td style="height: 30px;  color: #ff3333;"><asp:TextBox ID="txttel" runat="server" MaxLength="50" Width="400px"></asp:TextBox>*
        <asp:RequiredFieldValidator ID="RFVtel" runat="server" ControlToValidate="txttel"
            ErrorMessage="请填写固定电话" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txttel"
            ErrorMessage="*只能输入数字" ValidationExpression="^([0-9]|-)*$"></asp:RegularExpressionValidator></td>
  </tr>
    <tr>
    <td style="height: 30px;" align=right>移动电话：</td>
    <td style="height: 30px; color: #ff3333;"><asp:TextBox ID="txtmtel" runat="server" MaxLength="50" Width="400px"></asp:TextBox>*
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtmtel"
            ErrorMessage="请填写移动电话" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtmtel"
            ErrorMessage="*只能输入数字" ValidationExpression="^[0-9]*$"></asp:RegularExpressionValidator></td>
  </tr>
  <tr>
    <td style=" height: 30px" align=right>联系地址：</td>
    <td style="height: 30px;color: #ff3333;"><asp:TextBox ID="txtaddr" runat="server" MaxLength="50" Width="400px"></asp:TextBox>*
        <asp:RequiredFieldValidator ID="RFVaddr" runat="server" ControlToValidate="txtaddr"
            ErrorMessage="请填写联系地址" SetFocusOnError="True">*</asp:RequiredFieldValidator></td>
  </tr>

  <tr>
    <td><asp:Label ID="Label8" runat="server" Text="密码电话：" Visible=false></asp:Label></td>
    <td>
        <asp:TextBox ID="txtpswtel" runat="server" MaxLength="50" Visible=false Width="400px"></asp:TextBox>
        
    </td>
  </tr>
  <tr>
    <td style="height: 30px" align=right>备注：</td>
    <td style="height: 30px; "><asp:TextBox ID="txtcomment1" runat="server" MaxLength="50" Width="400px"></asp:TextBox>
        
    </td>
  </tr>
  <tr>
    <td style="height: 30px; " align=right>推荐人：</td>
    <td style="height: 30px;"><asp:TextBox ID="txtpresenter" runat="server" MaxLength="50" Width="400px"></asp:TextBox></td>
  </tr>
  <tr>
    <td align=right>卡号：</td>
    <td>
       <asp:TextBox ID="txtcardid" runat="server" Width="400px" Enabled="False"></asp:TextBox><font color=red>*</font>
       <asp:RequiredFieldValidator  ID="RequiredFieldValidator7" runat="server" ErrorMessage="请输入卡号!" ControlToValidate="txtcardid" Enabled="False" ></asp:RequiredFieldValidator><asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtcardid"
            ErrorMessage="卡号无效" OnServerValidate="CustomValidator1_ServerValidate" Enabled="False"></asp:CustomValidator> 
    </td>
</tr>
  <tr>
    <td colspan=2 align=center style="height: 30px">
        <asp:Button ID="btnUpddate" runat="server" Text="更新" Width=70px OnClick="btnUpddate_Click" />&nbsp;&nbsp;
        &nbsp;&nbsp;
        <asp:HyperLink ID=hylReturn runat=server NavigateUrl='cardedit1.aspx?aspxid=CA1030&aspxname=维护充值卡档案' Text="返回"></asp:HyperLink>
        <%--<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='javascript:window.history.go(-1);' >返回上一页</asp:HyperLink>--%>
        </td>
    </tr>
    <tr>
        <td colspan=2 align=center>
            <asp:Label ID="lblSavemessage" runat="server" Text="" Font-Size=10pt ForeColor=red Visible=false></asp:Label>
            <asp:Button  ID="btnClose" runat="server" Text="关闭" OnClick="btnClose_Click" Visible=false /></td>
    </tr>
    <tr>
</table>
    </div>
    </form>
</body>
</html>
