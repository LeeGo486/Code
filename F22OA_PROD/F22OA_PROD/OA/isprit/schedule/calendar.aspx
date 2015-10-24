<%@ page language="C#" autoeventwireup="true" inherits="isprit_schedule_calendar, App_Web_calendar.aspx.4c52363" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>日程安排</title>
    <META http-equiv="Content-Type" content="text/html; charset=gb2312"/>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<style type="text/css">
		#tmTable table
		{
			table-layout:fixed;
			width:100%;
			}
		#tmTable td
		{
		    width:14%;
		    word-wrap:break-word; word-break:break-all;

			}
		</style>
</head>
<body topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
    <div>
       <div class=content>
		        <h2><strong>我的日程安排</strong></h2>
		    </div>
			<table width="100%" cellpadding="1" cellspacing="1" align="center">
				<tr>
					<td align="center"><asp:dropdownlist id="slyear" runat="server" AutoPostBack="True"
					 OnSelectedIndexChanged="slyear_SelectedIndexChanged">
							<asp:ListItem Value="2006" Selected="True">2006</asp:ListItem>
							<asp:ListItem Value="2007">2007</asp:ListItem>
							<asp:ListItem Value="2008">2008</asp:ListItem>
							<asp:ListItem Value="2009">2009</asp:ListItem>
							<asp:ListItem Value="2010">2010</asp:ListItem>
						</asp:dropdownlist>年<asp:dropdownlist id="slmonth" runat="server" AutoPostBack="True"
						 OnSelectedIndexChanged="slmonth_SelectedIndexChanged">
							<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
							<asp:ListItem Value="2">2</asp:ListItem>
							<asp:ListItem Value="3">3</asp:ListItem>
							<asp:ListItem Value="4">4</asp:ListItem>
							<asp:ListItem Value="5">5</asp:ListItem>
							<asp:ListItem Value="6">6</asp:ListItem>
							<asp:ListItem Value="7">7</asp:ListItem>
							<asp:ListItem Value="8">8</asp:ListItem>
							<asp:ListItem Value="9">9</asp:ListItem>
							<asp:ListItem Value="10">10</asp:ListItem>
							<asp:ListItem Value="11">11</asp:ListItem>
							<asp:ListItem Value="12">12</asp:ListItem>
						</asp:dropdownlist>月</td>
				</tr>
				<tr>
					<td>
                <div id="tmTable">
						<table cellPadding="1" cellspacing="1" bgColor="#999999" border="0" width="100%">
							<tr class="header" align="center">
								<td><b>日</b></td>
								<td><b>一</b></td>
								<td><b>二</b></td>
								<td><b>三</b></td>
								<td><b>四</b></td>
								<td><b>五</b></td>
								<td><b>六</b></td>
							</tr>
							<tr bgColor="#ffffee">
								<asp:label id="lbs" Runat="server"></asp:label></tr>
						</table>
					</div>
          </td>
				</tr>
				<tr>
					<td style="TEXT-ALIGN: justify"></td>
					<td></td>
					<td></td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
