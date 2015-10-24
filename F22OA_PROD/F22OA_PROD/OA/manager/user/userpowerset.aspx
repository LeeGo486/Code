<%@ page language="C#" autoeventwireup="true" inherits="OA_isprit_member_userpowerset, App_Web_userpowerset.aspx.d341d34a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>邮件短信息权力设置</title>
    <LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <div class=content><h2><strong>用户邮件短信息权力设置</strong></h2></div>
      <table width="100%">
      <tr>
      <td   width="100%" >
      <!-- the conact-->
      		<TABLE id="Table1" cellSpacing="1" cellPadding="1"  width="100%"  border="0">
      		<tr>
      		<TD style="WIDTH: 175px; HEIGHT: 21px">
                  被设置人:<asp:Label ID="LblUserchk" runat="server" Text=""></asp:Label></td>
      		<td width="100px"></td>
      		<td style="width: 179px">
                  用户列表</td>
      		<td></td>
      		<td>
                  已选用户</td>
      		<td></td>
      		<td></td>
      		</tr>
				<TR>
				
					<TD style="WIDTH: 175px; HEIGHT: 21px">
						<asp:DropDownList id="ddldepart" runat="server" Width="176px" AutoPostBack="True" OnSelectedIndexChanged="ddldepart_SelectedIndexChanged"></asp:DropDownList></TD>
				
					<td>
                        </td>
                        <td style="width: 179px"><asp:DropDownList id="ddldepartwill" runat="server" Width="176px" AutoPostBack="True" OnSelectedIndexChanged="ddldepartwill_SelectedIndexChanged">
                        </asp:DropDownList></td>
                        <td></td>
                        	<td></td>
      		<td></td>
      		<td></td>
				</TR>
				
				<TR>
					<TD style="WIDTH: 175px" vAlign="top"><FONT face="宋体">
							<asp:ListBox id="lbuser" runat="server" Width="176px" Height="384px" OnSelectedIndexChanged="lbuser_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox></FONT></TD>
					<td></td>
					<td style="width: 179px"><asp:ListBox id="lbuserwill" runat="server" Width="176px" Height="384px" SelectionMode="Multiple">
                    </asp:ListBox></td>
					<td align="center" valign="middle">
                        <asp:Button ID="BtnAddAll" runat="server" Text="添加整部门>>" Width="120px" OnClick="BtnAddAll_Click" /><br />
                        <br />
                        <asp:Button ID="BtnAddOne" runat="server" Text="添加>>" Width="120px" OnClick="BtnAddOne_Click" /><br />
                        <br />
                        <asp:Button ID="BtnDelOne" runat="server" Text="删除<<" Width="120px" OnClick="BtnDelOne_Click" /><br />
                        <br />
                        <asp:Button ID="BtnDelAll" runat="server" Text="删除所有<<" Width="120px" OnClick="BtnDelAll_Click" /></td>
						<td><asp:ListBox id="lbuserhave" runat="server" Width="176px" Height="384px" SelectionMode="Multiple">
                        </asp:ListBox></td>
      		<td></td>
      		<td></td>
				</TR>
				
			</TABLE>
      <!-- the conact end-->
      </td>
      <td valign="top">
       
      </td>
      </tr>
      </table>
      <br />
      <TD align="center" colSpan="3"><A  href="../manage_flow.aspx">返回</A></TD>
    </div>
        <asp:HiddenField ID="HFUserchkid" runat="server" />
    </form>
</body>
</html>
