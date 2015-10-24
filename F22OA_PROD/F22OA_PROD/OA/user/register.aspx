<%@ page language="C#" autoeventwireup="true" inherits="user_register, App_Web_register.aspx.7fdd8e9f" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    	<title>新用户注册</title>
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
			function ddchg()
			{
				document.all.item("imgicon").src="../icon/portrait/" + document.all.item("ddicon").value;
			}
		</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div id="container">
				<div class="content">
					<h2><strong>OA帐号注册申请</strong></h2>
				</div>
				<asp:Panel id="pl" runat="server">
					<table id="tbd" borderColor="#eeeeee" cellSpacing="0" cellPadding="0" width="405" align="center"
						border="1">
						<tr>
							<td class="tdright">用户&nbsp;ID:
							</td>
							<td>
								<asp:TextBox id="tbID" runat="server" CssClass="tbox" Width="120px"></asp:TextBox><FONT face="宋体">请用字母(A-Z)例:Andy</FONT>
								<asp:RequiredFieldValidator id="rv" runat="server" ControlToValidate="tbID" ErrorMessage="*"></asp:RequiredFieldValidator></td>
						</tr>
						<tr>
							<td class="tdright">密码:</td>
							<td>
								<asp:TextBox id="tbPwd" runat="server" CssClass="tbox" Width="120px" TextMode="Password"></asp:TextBox><FONT face="宋体"></FONT>
								<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ControlToValidate="tbPwd" ErrorMessage="*"></asp:RequiredFieldValidator></td>
						</tr>
						<tr>
							<td class="tdright">密码（重复）:
							</td>
							<td style="HEIGHT: 24px">
								<asp:TextBox id="tbPwd1" runat="server" CssClass="tbox" Width="120px" TextMode="Password"></asp:TextBox>
								<asp:CompareValidator id="cvv" runat="server" ControlToValidate="tbPwd" ErrorMessage="密码不一致" ControlToCompare="tbPwd1"></asp:CompareValidator></td>
						</tr>
						<tr>
							<td class="tdright">真实姓名:
							</td>
							<td>
								<asp:TextBox id="tbName" runat="server" CssClass="tbox" Width="120px"></asp:TextBox><FONT face="宋体">请填写你的真实姓名</FONT>
								<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ControlToValidate="tbName" ErrorMessage="*"></asp:RequiredFieldValidator></td>
						</tr>
						<tr>
							<td class="tdright">座机:</td>
							<td>
								<asp:TextBox id="tbPhone" runat="server" CssClass="tbox" Width="120px"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="tdright">手机:</td>
							<td>
								<asp:TextBox id="tbMobile" runat="server" CssClass="tbox" Width="120px"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="tdright">Email:</td>
							<td>
								<asp:TextBox id="tbEmail" runat="server" CssClass="tbox" Width="120px"></asp:TextBox>
								<asp:RegularExpressionValidator id="rve" runat="server" ControlToValidate="tbEmail" ErrorMessage="i.e:hello@annil.com"
									ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
						</tr>
						<tr>
							<td class="tdright" vAlign="middle">部门|地区:</td>
							<td style="HEIGHT: 31px">
								<asp:DropDownList id="ddarea" runat="server" Width="141px"></asp:DropDownList></td>
						</tr>
						<tr>
							<td class="tdright" vAlign="middle">职务:</td>
							<td style="HEIGHT: 31px">
								<asp:DropDownList id="ddduty" runat="server" Width="141px"></asp:DropDownList></td>
						</tr>
						<tr>
							<td class="tdright" style="HEIGHT: 30px" vAlign="middle"><FONT face="宋体"><IMG id="imgicon" height="96" alt="图标" src="../icon/portrait/default.jpg" width="96"
										border="1"></FONT></td>
							<td style="HEIGHT: 30px" vAlign="top"><FONT face="宋体"><SELECT class="tb" id="ddicon" style="WIDTH: 140px" onchange="ddchg();" name="ddicon" runat="server">
										<OPTION value="default.jpg" selected>不选择头像</OPTION>
										<OPTION value="a01.jpg">a01</OPTION>
										<OPTION value="a02.jpg">a02</OPTION>
										<OPTION value="a03.jpg">a03</OPTION>
										<OPTION value="a04.jpg">a04</OPTION>
										<OPTION value="a05.jpg">a05</OPTION>
										<OPTION value="a06.jpg">a06</OPTION>
										<OPTION value="a07.jpg">a07</OPTION>
										<OPTION value="a08.jpg">a08</OPTION>
										<OPTION value="a09.jpg">a09</OPTION>
										<OPTION value="a10.jpg">a10</OPTION>
										<OPTION value="a11.jpg">a11</OPTION>
										<OPTION value="a12.jpg">a12</OPTION>
										<OPTION value="a13.jpg">a13</OPTION>
									</SELECT><BR>
									<BR>
                                上传自定义的图片，注意大小(96x96)<BR>
									<INPUT class="bt" id="File1" style="WIDTH: 276px; HEIGHT: 22px" type="file" size="26" name="File"
										runat="server"></FONT></td>
						</tr>
						<tr>
							<td class="tdright" vAlign="top">备注:</td>
							<td style="HEIGHT: 1px"><FONT face="宋体">
									<asp:TextBox id="tbremark" runat="server" CssClass="tbox" Width="209px" TextMode="MultiLine"
										Height="56px"></asp:TextBox></FONT></td>
						</tr>
						<tr>
							<td vAlign="top"></td>
							<td>
								<asp:Button id="btOK" runat="server" Width="112px" Text="点击申请" OnClick="btOK_Click"></asp:Button><FONT face="宋体"><BR>
								</FONT>
								<asp:Label id="lberror" runat="server" ForeColor="Red"></asp:Label></td>
						</tr>
					</table>
				</asp:Panel>
			</div>
    </div>
    </form>
</body>
</html>
