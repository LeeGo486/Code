<%@ page language="C#" autoeventwireup="true" inherits="manager_system_loginlog, App_Web_loginlog.aspx.abfa359c" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>loginlog</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body leftMargin="1"  topMargin="1">
    <form id="form1" runat="server">
    <div> 
    <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
      <div class=content>
		        <h2><strong>
                   
                    </strong></h2>
		    </div>
	<table>
									<tr>
										<td style="height: 34px"> 关键字</td>
										<td style="height: 34px"><asp:TextBox ID="tbkey" Runat="server"></asp:TextBox></td>
										<td style="height: 34px">开始日期</td>
										<td style="height: 34px">
                                            <igsch:webdatechooser id="wdc1" runat="server" value="">
<CalendarLayout TitleFormat="Month" DayNameFormat="FirstLetter" ShowYearDropDown="False" CellPadding="1" ShowFooter="False" ShowMonthDropDown="False">
<TodayDayStyle ForeColor="White" BackColor="#99CCCC"></TodayDayStyle>

<WeekendDayStyle BackColor="#CCCCFF"></WeekendDayStyle>

<SelectedDayStyle ForeColor="#CCFF99" BackColor="#009999" Font-Bold="True"></SelectedDayStyle>

<NextPrevStyle ForeColor="#CCCCFF" Font-Size="8pt" Font-Bold="True"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>

<DayHeaderStyle ForeColor="#336666" BackColor="#99CCCC" Height="1pt"></DayHeaderStyle>

<TitleStyle ForeColor="#CCCCFF" BackColor="#003399" Height="25px" Font-Size="10pt" Font-Bold="True"></TitleStyle>

<CalendarStyle BorderStyle="Solid" ForeColor="#003399" BorderWidth="1px" BorderColor="#3366CC" BackColor="White" Font-Italic="False" Font-Size="8pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout>
</igsch:webdatechooser>
											</td>
										<td style="height: 34px">结束日期</td>
										<td style="WIDTH: 102px; height: 34px;">
                                            <igsch:webdatechooser id="wdc2" runat="server" value="">
<CalendarLayout TitleFormat="Month" DayNameFormat="FirstLetter" ShowYearDropDown="False" CellPadding="1" ShowFooter="False" ShowMonthDropDown="False">
<TodayDayStyle ForeColor="White" BackColor="#99CCCC"></TodayDayStyle>

<WeekendDayStyle BackColor="#CCCCFF"></WeekendDayStyle>

<SelectedDayStyle ForeColor="#CCFF99" BackColor="#009999" Font-Bold="True"></SelectedDayStyle>

<NextPrevStyle ForeColor="#CCCCFF" Font-Size="8pt" Font-Bold="True"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>

<DayHeaderStyle ForeColor="#336666" BackColor="#99CCCC" Height="1pt"></DayHeaderStyle>

<TitleStyle ForeColor="#CCCCFF" BackColor="#003399" Height="25px" Font-Size="10pt" Font-Bold="True"></TitleStyle>

<CalendarStyle BorderStyle="Solid" ForeColor="#003399" BorderWidth="1px" BorderColor="#3366CC" BackColor="White" Font-Italic="False" Font-Size="8pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout>
</igsch:webdatechooser>
											</td>
										<td style="height: 34px">
											<asp:ImageButton id="imbsearch" runat="server" ImageUrl="~/oa/icon/search.gif" OnClick="imbsearch_Click"></asp:ImageButton></td>
									</tr>
									<tr>
										<td colspan="7" style="height: 17px"><table width="500">
												<asp:Repeater id="rpt" runat="server">
													<HeaderTemplate>
														<tr>
															<td>用户姓名</td>
															<td>登录时间</td>
															<td>登录IP</td>
														</tr>
													</HeaderTemplate>
													<ItemTemplate>
														<tr>
															<td><%# DataBinder.Eval(Container, "DataItem.crname") %></td>
															<td><%# DataBinder.Eval(Container, "DataItem.crdate") %></td>
															<td><%# DataBinder.Eval(Container, "DataItem.ip") %></td>
														</tr>
													</ItemTemplate>
												</asp:Repeater>
											</table>
										</td>
									</tr>
								</table>
    </div>
    </form>
</body>
</html>
