<%@ page language="C#" autoeventwireup="true" inherits="isprit_member_updatedetail, App_Web_updatedetail.aspx.be6dd291" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>updateDetail</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<script language="javascript" type="text/javascript">
			function ddchg()
			{
				document.all.item("imgicon").src="../../icon/portrait/" + document.all.item("ddicon").value;
			}
		</script>
</head>
<body topmargin="1" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
        <asp:panel id="Pl" runat="server" Width="100%"><BR>
    <div id="jstable">
					<table id="tbd" borderColor="#eeeeee" cellSpacing="0" cellPadding="0" width="408" align="center" border="1">
						<tr>
							<td class="header" style="HEIGHT: 27px" align="center" colSpan="2">用户资料更改
							</td>
						</tr>
						<tr>
							<td class="tdright">用户&nbsp;ID:
							</td>
							<td width="237"><FONT face="宋体">
									<asp:Label id="lbuserid" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp; ID:
									<asp:Label id="lbid" runat="server"></asp:Label></FONT></td>
						</tr>
						<tr>
							<td class="tdright">真实姓名:
							</td>
							<td>
								<asp:TextBox id="tbName" runat="server" Width="120px" CssClass="tb"></asp:TextBox>
								<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" ControlToValidate="tbName" ErrorMessage="*"></asp:RequiredFieldValidator></td>
						</tr>
						<tr>
							<td class="tdright">座机:</td>
							<td>
								<asp:TextBox id="tbPhone" runat="server" Width="120px" CssClass="tb"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="tdright">手机:</td>
							<td>
								<asp:TextBox id="tbMobile" runat="server" Width="120px" CssClass="tb"></asp:TextBox></td>
						</tr>
						<tr>
							<td class="tdright">Email:</td>
							<td>
								<asp:TextBox id="tbEmail" runat="server" Width="120px" CssClass="tb"></asp:TextBox>
								<asp:RegularExpressionValidator id="rve" runat="server" ControlToValidate="tbEmail" ErrorMessage="Exp:u@domain.com"
									ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
						</tr>
						<tr>
							<td class="tdright">部门:</td>
							<td style="HEIGHT: 31px">
								<asp:DropDownList id="ddarea" runat="server" Width="141px" CssClass="bt" Enabled="False"></asp:DropDownList></td>
						</tr>
						<tr>
							<td class="tdright" style="height: 31px">职务:</td>
							<td style="HEIGHT: 31px">
								<asp:DropDownList id="ddduty" runat="server" Width="141px" Enabled="False"></asp:DropDownList></td>
						</tr>
						<tr>
							<td style="HEIGHT: 30px" vAlign="middle" align="center"><FONT face="宋体"><IMG id="imgicon" height="72" alt="图标" src="../../icon/portrait/default.jpg" width="96"
										border="1" runat="server"></FONT></td>
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
										<OPTION value="a14.jpg">a14</OPTION>
										<OPTION value="a15.jpg">a15</OPTION>
										<OPTION value="a16.jpg">a16</OPTION>
										<OPTION value="a17.jpg">a17</OPTION>
										<OPTION value="a18.jpg">a18</OPTION>
										<OPTION value="a19.jpg">a19</OPTION>
										<OPTION value="a20.jpg">a20</OPTION>
									</SELECT><BR>
									<BR>
									上传自定义的图片，注意大小(<%=imgwidth%>x<%=imgheight%>)<BR>
									<INPUT class="bt" id="File1" style="WIDTH: 276px; HEIGHT: 22px" type="file" size="26" name="File"
										runat="server"></FONT></td>
						</tr>
						<tr>
							<td class="tdright">备注:</td>
							<td style="HEIGHT: 1px"><FONT face="宋体">
									<asp:TextBox id="tbremark" runat="server" Height="96px" Width="299px" CssClass="tb" TextMode="MultiLine"></asp:TextBox></FONT></td>
						</tr>
						<tr>
							<td class="footer" align="center" colSpan="2">
								<asp:Button id="btOK" runat="server" CssClass="btn" Text="更改资料" OnClick="btOK_Click"></asp:Button>
                <span id="btnspan"></span>
                </td>
						</tr>
					</table>
					<asp:Label id="lberror" runat="server" ForeColor="Red"></asp:Label>
				</asp:panel>
    </div>
    <script type="text/javascript" defer="defer">
    	jsTable('jstable','lr','58%','120','center');
			goBack("","btnspan");
    </script>
    </form>
</body>
</html>
