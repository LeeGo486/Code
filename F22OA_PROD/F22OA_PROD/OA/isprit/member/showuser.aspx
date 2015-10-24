<%@ page language="C#" autoeventwireup="true" inherits="isprit_member_showuser, App_Web_showuser.aspx.be6dd291" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>showuser</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script type="text/javascript" src="../../js/project.js"></script>
</head>
<body style="margin:10px;">
    <form id="form1" runat="server">
    <div id="lr">
				<table align="center" id="table1" cellspacing="1" cellpadding="1" width="425" border="0">
					<tr>
						<td colspan="2" align="center" style="height:30px;">
							<asp:Label id="lbname" runat="server" ForeColor="Blue" Font-Bold="true"></asp:Label> 的个人资料</td>
					</tr>
					<tr>
						<td class="tdright">电话:</td>
            <td class="tdwhite">
							<asp:Label id="lbphone" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td  class="tdright">手机:</td>
						<td style="HEIGHT: 21px" class="tdwhite">
							<asp:Label id="lbmobile" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td style="WIDTH: 78px; " class="tdright">Email:</td>
						<td style="HEIGHT: 28px" class="tdwhite">
							<asp:Label id="lbemail" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td style="WIDTH: 78px;" class="tdright">部门:</td>
						<td style="HEIGHT: 25px" class="tdwhite">
							<asp:Label id="lbdepartment" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td class="tdright">职务:</td>
						<td style="HEIGHT: 27px" class="tdwhite">
							<asp:Label id="lbduty" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td class="tdright" style="WIDTH: 78px">
                            图像:</td>
						<td class="tdwhite">
							<asp:Image id="img" runat="server" Height="96px" Width="96px" BorderWidth="1px" BorderColor="#00C000"></asp:Image>
						</td>
					</tr>
					<tr>
						<td class="tdright" style="WIDTH: 78px">备注:</td>
						<td class="tdwhite">
							<asp:TextBox id="tbremark" runat="server" Width="315px" ReadOnly="true" TextMode="MultiLine" Height="112px"></asp:TextBox></td>
					</tr>
					<tr>
						<td class="tdright" style="WIDTH: 78px">最后IP:</td>
						<td class="tdwhite">
							<a href="#" onclick="copy('hdip');">
								<asp:Label id="lbIP" runat="server" ForeColor="Red"></asp:Label></a><INPUT id="hdip" type="hidden" runat="server"></td>
					</tr>
					<tr>
						<td class="tdright" style="WIDTH: 78px">&nbsp;</td>
						<td class="tdwhite"><span id="btnspan"></span></tr>
				</table><br />
<br />

    </div>
    <script defer="defer" type="text/javascript">
    	jsTable('lr','lr','60%','120','center');
			goBack("公告栏","btnspan")
    </script>
    </form>
</body>
</html>
