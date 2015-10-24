<%@ page language="C#" autoeventwireup="true" inherits="isprit_schedule_showcalendar, App_Web_showcalendar.aspx.4c52363" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>calendar</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" type="text/javascript">
		
			  //装窗口
/*function LoadWindow(url)
{
  //loc_x=document.body.scrollLeft+event.clientX-event.offsetX-100;
  //loc_y=document.body.scrollTop+event.clientY-event.offsetY+170;
  var rtw=window.showModalDialog(url,self,"edge:raised;scroll:2;status:0;help:0;resizable:1;dialogWidth:380px;dialogHeight:350px;dialogTop:"+200+"px;dialogLeft:"+200+"px");
}*/
		</script>
</head>
<body topmargin="1" leftmargin="1" rightmargin="2">
    <form id="form1" runat="server">
    <div>
     <div class=content>
		        <h2><strong>日程安排查询</strong></h2>
		    </div>
			<table cellpadding=1 cellspacing=1 width="100%">
				<tr>
					<td></td>
					<td align="center"><asp:dropdownlist id="slyear" runat="server" AutoPostBack="True" OnSelectedIndexChanged="slyear_SelectedIndexChanged">
							<asp:ListItem Value="2006" Selected="True">2006</asp:ListItem>
							<asp:ListItem Value="2007">2007</asp:ListItem>
							<asp:ListItem Value="2008">2008</asp:ListItem>
							<asp:ListItem Value="2009">2009</asp:ListItem>
							<asp:ListItem Value="2010">2010</asp:ListItem>
						</asp:dropdownlist><FONT face="宋体">年</FONT><asp:dropdownlist id="slmonth" runat="server" AutoPostBack="True" OnSelectedIndexChanged="slmonth_SelectedIndexChanged">
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
						</asp:dropdownlist><FONT face="宋体">月</FONT></td>
					<td></td>
				</tr>
				<tr>
					<td colSpan="2">
						<table cellPadding="1" border="0" width="100%">
							<tr class="header">
								<td>日</td>
								<td>一</td>
								<td>二</td>
								<td>三</td>
								<td>四</td>
								<td>五</td>
								<td style="width: 18px">六</td>
							</tr>
							<tr align="left" >
								<asp:label id="lbs" Runat="server"></asp:label></tr>
						</table>
					</td>
				</tr>
				
			</table>
			<div id="footer">用户编号:<asp:Label ID="lbuserid" runat="server"></asp:Label></div>
    </div>
    </form>
</body>
</html>
