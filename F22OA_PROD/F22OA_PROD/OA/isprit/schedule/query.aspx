<%@ page language="C#" autoeventwireup="true" inherits="isprit_schedule_query, App_Web_query.aspx.4c52363" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>query</title>

		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
    <div>
				<div class="content">
					<h2><strong>日程查询</strong></h2>
				</div>
    <div id="container">
				<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" border="0">
					<TR>
						<TD>
							<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="100%" border="0">
								<TR>
									<TD style="WIDTH: 120px">
										<asp:CheckBox id="cb" runat="server" Text="只查询未完成的"></asp:CheckBox></TD>
									<TD style="WIDTH: 134px">
                                        <calendarlayout footerformat="Today: {0:d}">
</calendarlayout>
                                        <igsch:WebDateChooser ID="wdc1" runat="server">
<CalendarLayout PrevMonthImageUrl="ig_cal_silverP0.gif" TitleFormat="Month" NextMonthImageUrl="ig_cal_silverN0.gif" ShowYearDropDown="False" ShowMonthDropDown="False">
<TodayDayStyle ForeColor="Black" BackColor="#D0D2D6"></TodayDayStyle>

<FooterStyle BackgroundImage="ig_cal_silver1.gif" ForeColor="#707377" Height="16pt" Font-Size="8pt"></FooterStyle>

<SelectedDayStyle ForeColor="White" BackColor="#888990"></SelectedDayStyle>

<NextPrevStyle BackgroundImage="ig_cal_silver2.gif"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="#888B90"></OtherMonthDayStyle>

<DayHeaderStyle ForeColor="White" BackColor="#9A98AE" Height="1pt" Font-Size="8pt" Font-Bold="True"></DayHeaderStyle>

<TitleStyle BackgroundImage="ig_cal_silver2.gif" ForeColor="#303040" BackColor="#D8E0E2" Height="18pt" Font-Size="10pt" Font-Bold="True"></TitleStyle>

<CalendarStyle BorderStyle="Solid" ForeColor="#404050" BorderWidth="1px" BorderColor="Gray" BackColor="#EFF6F8" Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout>
</igsch:WebDateChooser>
                                        <expandeffects shadowcolor="LightGray">
</expandeffects>
                                    </TD>
									<TD style="WIDTH: 129px">
                                        <calendarlayout footerformat="Today: {0:d}">
</calendarlayout>
                                        <igsch:WebDateChooser ID="wdc2" runat="server">
<CalendarLayout PrevMonthImageUrl="ig_cal_silverP0.gif" TitleFormat="Month" NextMonthImageUrl="ig_cal_silverN0.gif" ShowYearDropDown="False" ShowMonthDropDown="False">
<TodayDayStyle ForeColor="Black" BackColor="#D0D2D6"></TodayDayStyle>

<FooterStyle BackgroundImage="ig_cal_silver1.gif" ForeColor="#707377" Height="16pt" Font-Size="8pt"></FooterStyle>

<SelectedDayStyle ForeColor="White" BackColor="#888990"></SelectedDayStyle>

<NextPrevStyle BackgroundImage="ig_cal_silver2.gif"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="#888B90"></OtherMonthDayStyle>

<DayHeaderStyle ForeColor="White" BackColor="#9A98AE" Height="1pt" Font-Size="8pt" Font-Bold="True"></DayHeaderStyle>

<TitleStyle BackgroundImage="ig_cal_silver2.gif" ForeColor="#303040" BackColor="#D8E0E2" Height="18pt" Font-Size="10pt" Font-Bold="True"></TitleStyle>

<CalendarStyle BorderStyle="Solid" ForeColor="#404050" BorderWidth="1px" BorderColor="Gray" BackColor="#EFF6F8" Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout>
</igsch:WebDateChooser>
                                        <expandeffects shadowcolor="LightGray">
</expandeffects>
                                    </TD>
									<TD style="WIDTH: 164px">
										<asp:ImageButton id="imbSearch" runat="server" ToolTip="开始搜索" ImageUrl="../../icon/search.gif" OnClick="imbSearch_Click"></asp:ImageButton></TD>
									<TD><FONT face="宋体"></FONT></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR>
						<TD>
            <div id="tmtable">
								<asp:datagrid id="dgaffair" runat="server" AutoGenerateColumns="False" Width="758px" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<HeaderStyle HorizontalAlign="Center" CssClass="header"></HeaderStyle>
									<Columns>
										<asp:TemplateColumn HeaderText="日期">
											<ItemTemplate>
												<asp:Label ID="lbdate1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.dtDate", "{0:D}") %>'>
												</asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn HeaderText="星期">
											<ItemTemplate>
												<%# Convert.ToDateTime(DataBinder.Eval(Container, "DataItem.startdate")).DayOfWeek %>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn HeaderText="时间">
											<HeaderStyle Width="120px"></HeaderStyle>
											<ItemStyle Wrap="False"></ItemStyle>
											<ItemTemplate>
												<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.startdate","{0:HH:mm}") %>'>
												</asp:Label>-
												<asp:Label ID="Label2" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.enddate","{0:HH:mm}") %>'>
												</asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn HeaderText="日程内容">
											<ItemStyle HorizontalAlign="Left"></ItemStyle>
											<ItemTemplate>
												<img border=0 src='img\<%# DataBinder.Eval(Container, "DataItem.icon") %>'>
												<asp:Label ID="Label3" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.vcEvent") %>'>
												</asp:Label>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn HeaderText="完成状态">
											<HeaderStyle Width="60px"></HeaderStyle>
											<ItemTemplate>
												<%# c2s(Convert.ToBoolean( DataBinder.Eval(Container, "DataItem.done"))) %>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn HeaderText="更改状态">
											<HeaderStyle Width="60px"></HeaderStyle>
											<ItemTemplate>
												<asp:Button ID="btchange" Runat="server" CssClass="button" Text="更改" CommandName="update"></asp:Button>
											</ItemTemplate>
										</asp:TemplateColumn>
										<asp:TemplateColumn HeaderText="删除">
											<HeaderStyle Width="40px"></HeaderStyle>
											<ItemTemplate>
												<asp:ImageButton id="IbDel" runat="server" ToolTip='<%# DataBinder.Eval(Container, "DataItem.idSchedule") %>' ImageUrl="../icon/delete.gif" CommandName="delete">
												</asp:ImageButton>
											</ItemTemplate>
										</asp:TemplateColumn>
									</Columns>
								</asp:datagrid></div></TD>
					</TR>
					<TR>
						<TD class="tip"><ol>
								<li>
								第一个日期为开始日期，每二个日期为结束日期。
								<li>
									保留</li></ol>
						</TD>
					</TR>
				</TABLE>
			</div>
    </div>
   <script type="text/javascript" defer="defer">
			jsTable('tmtable','tm','95%','','center');

   </script>
    
    </form>
</body>
</html>
