<%@ page language="C#" autoeventwireup="true" inherits="manager_user_duty_add, App_Web_duty_add.aspx.d341d34a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
        <title>新建职位</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<base target="_self">
</head>
<body style="margin:5px;">
    <form id="form1" runat="server">
    <div>
    <table width="300" border="0" cellpadding="1" cellspacing="1">
				<tr>
					<td colspan="2" class="header">新建职位:</td>
				</tr>
				<tr>
					<td width="440" bgcolor="#ffffff" class="tdright">职位编号(A):</td>
					<td width="287" bgcolor="#ffffff">
						<asp:TextBox id="tbcode" nullable="n" cname="职位编号" strnum="y" accessKey="a" runat="server" MaxLength="8"
							CssClass="tbox" ToolTip="不能和已有编号重复!"></asp:TextBox></td>
				</tr>
				<tr>
					<td bgcolor="#ffffff" class="tdright">名称(B):</td>
					<td bgcolor="#ffffff">
						<asp:TextBox id="tbname" nullable="n" cname="名称" accessKey="b" runat="server" CssClass="tbox"
							MaxLength="40"></asp:TextBox></td>
				</tr>
				<tr>
					<td bgcolor="#ffffff" class="tdright">排序(C):</td>
					<td bgcolor="#ffffff">
						<asp:TextBox id="tbseq" nullable="n" cname="排序" datatype="n" accessKey="c" runat="server" CssClass="tbox"
							MaxLength="8">1</asp:TextBox></td>
				</tr>
				<tr>
					<td colspan="2" class="tip">&nbsp;
						<asp:Button id="btsave" runat="server" CssClass="btn" Text="保 存(S)" accessKey="s" OnClick="btsave_Click"></asp:Button>
                      <input type="button" onclick="CloseWindow('新建职位')" value="关 闭(C)" class="btn" accessKey="c"  />
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
