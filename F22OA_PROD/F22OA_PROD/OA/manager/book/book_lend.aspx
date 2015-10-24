<%@ page language="C#" autoeventwireup="true" inherits="manager_book_book_lend, App_Web_book_lend.aspx.c640126d" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>book_lend</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body leftMargin="1"  topMargin="1">
    <form id="form1" runat="server">
     <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
       <div class=content>
		        <h2><strong>
                   
                </strong>
                </h2>
		    </div>
    <div>
    <TABLE id="Table1" cellSpacing="1" cellPadding="1" width="760">
				
				<TR>
					<TD >
						<TABLE id="Table3" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD>关键字:</TD>
								<TD style="WIDTH: 73px"><asp:textbox id="tbkey" ToolTip="支持模糊查询" CssClass="book_td" Runat="server" Width="96px"></asp:textbox></TD>
								<TD><asp:dropdownlist id="ddl" runat="server" CssClass="select" Width="112px">
										<asp:ListItem Value="0" Selected="True">==所有状态==</asp:ListItem>
										<asp:ListItem Value="1">  曾借阅图书</asp:ListItem>
										<asp:ListItem Value="2">  申请中</asp:ListItem>
										<asp:ListItem Value="3">  在借图书</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD>申请日期:开始
								</TD>
								<TD>
                                    <igsch:webdatechooser id="wdc1" runat="server">
<CalendarLayout PrevMonthImageUrl="ig_cal_blueP0.gif" TitleFormat="Month" NextMonthImageUrl="ig_cal_blueN0.gif" ShowYearDropDown="False" ShowMonthDropDown="False">
<TodayDayStyle BackColor="#E0EEFF"></TodayDayStyle>

<FooterStyle BackgroundImage="ig_cal_blue1.gif" ForeColor="#505080" Height="16pt" Font-Size="8pt">
<BorderDetails ColorTop="LightSteelBlue" WidthTop="1px" StyleTop="Solid"></BorderDetails>
</FooterStyle>

<SelectedDayStyle BackColor="SteelBlue"></SelectedDayStyle>

<NextPrevStyle BackgroundImage="ig_cal_blue2.gif"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="SlateGray"></OtherMonthDayStyle>

<DayHeaderStyle ForeColor="#8080A0" BackColor="#E0EEFF" Height="1pt" Font-Size="8pt" Font-Bold="True">
<BorderDetails StyleBottom="Solid" WidthBottom="1px" ColorBottom="LightSteelBlue"></BorderDetails>
</DayHeaderStyle>

<TitleStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="#505080" BackColor="#CCDDFF" Height="18pt" Font-Size="10pt" Font-Bold="True"></TitleStyle>

<CalendarStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="SteelBlue" BackColor="#CCDDFF" Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout>
</igsch:webdatechooser></TD>
								<TD>结束</TD>
								<TD>
                                    <igsch:webdatechooser id="wdc2" runat="server">
<CalendarLayout PrevMonthImageUrl="ig_cal_blueP0.gif" TitleFormat="Month" NextMonthImageUrl="ig_cal_blueN0.gif" ShowYearDropDown="False" ShowMonthDropDown="False">
<TodayDayStyle BackColor="#E0EEFF"></TodayDayStyle>

<FooterStyle BackgroundImage="ig_cal_blue1.gif" ForeColor="#505080" Height="16pt" Font-Size="8pt">
<BorderDetails ColorTop="LightSteelBlue" WidthTop="1px" StyleTop="Solid"></BorderDetails>
</FooterStyle>

<SelectedDayStyle BackColor="SteelBlue"></SelectedDayStyle>

<NextPrevStyle BackgroundImage="ig_cal_blue2.gif"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="SlateGray"></OtherMonthDayStyle>

<DayHeaderStyle ForeColor="#8080A0" BackColor="#E0EEFF" Height="1pt" Font-Size="8pt" Font-Bold="True">
<BorderDetails StyleBottom="Solid" WidthBottom="1px" ColorBottom="LightSteelBlue"></BorderDetails>
</DayHeaderStyle>

<TitleStyle BackgroundImage="ig_cal_blue2.gif" ForeColor="#505080" BackColor="#CCDDFF" Height="18pt" Font-Size="10pt" Font-Bold="True"></TitleStyle>

<CalendarStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="SteelBlue" BackColor="#CCDDFF" Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout>
</igsch:webdatechooser>
                 </TD>
								<TD>
                                    <asp:Button ID="imbsearch" runat="server" Text="查  询" CssClass="btn" OnClick="imbsearch_Click" />
  </TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD >
						<table cellSpacing="1" cellPadding="1" border="0" class="tbGrid">
							<asp:repeater id="dlbooks" Runat="server">
								<HeaderTemplate>
									<TR class="dgHeader" style="height:26px">
										<TD>选择</TD>
										<TD width="200">书名</TD>
										<td width="50">借阅人</td>
										<TD width="28">数量</TD>
										<TD width="80">申请日期</TD>
										<TD width="80">借书日期</TD>
										<TD width="80">需还日期</TD>
										<TD width="80">归还日期</TD>
										<td width="60">状态</td>
									</TR>
								</HeaderTemplate>
								<ItemTemplate>
									<tr bgcolor="#eeeeee" align="center" onmousemove="this.bgColor='Beige'" onmouseout="this.bgColor='#eeeeee'">
										<td width="40px" align="center" nowrap>
											<asp:CheckBox Runat=server ID=ck1 tooltip='<%# DataBinder.Eval(Container, "DataItem.lendid") %>' Text='<%# DataBinder.Eval(Container, "DataItem.bookid") %>'>
											</asp:CheckBox></td>
										<td nowrap><a href='../../isprit/book/book_show.aspx?bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>' target=_self ><%# DataBinder.Eval(Container, "DataItem.bookname") %></a></td>
										<td nowrap>
											<asp:Label ID="lbuserid" Runat="server" tooltip='<%# DataBinder.Eval(Container, "DataItem.crname") %>'>
												<%# DataBinder.Eval(Container, "DataItem.username") %>
											</asp:Label></td>
										<td><%# DataBinder.Eval(Container, "DataItem.amount") %></td>
										<td nowrap><%# DataBinder.Eval(Container, "DataItem.applydate","{0:D}") %></td>
										<td nowrap><%# DataBinder.Eval(Container, "DataItem.lenddate","{0:D}") %></td>
										<td nowrap><font color="red"><%# DataBinder.Eval(Container, "DataItem.willdate","{0:D}") %></font></td>
										<td nowrap><%# DataBinder.Eval(Container, "DataItem.truedate","{0:D}") %></td>
										<td><%# c2b( Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.outcheck")),Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.incheck"))) %></td>
									</tr>
								</ItemTemplate>
								<FooterTemplate>
									<tr>
										<td colspan="10" class="tip">
											<ol type="1">
												<li>
													当查询不到数据时，注意日期的问题;</li>
												<li>
													当还书时，还书日期不能小于借书日期</li>
												<li>
													查询某个人的借阅记录时，请输入借书人姓名、书的编号、书名，支持模糊查询。(只需要输入其中一个字既可)
												</li>
											</ol>
										</td>
									</tr>
								</FooterTemplate>
							</asp:repeater></table>
					</TD>
				</TR>
				<tr  align="center">
					<td>
						<asp:Label ID="lbtip" Runat="server" BorderWidth="1px" Font-Bold="True" Font-Size="14px"></asp:Label>
					</td>
				</tr>
				<TR>
					<TD class="footer" align="center">
						<table>
							<tr>
								<td class="tdhighlight" style="WIDTH: 77px">还书日期:</td>
								<td style="width: 3px">
                                    <igsch:webdatechooser id="wdc3" runat="server">
<CalendarLayout PrevMonthImageUrl="ig_cal_grayP0.gif" TitleFormat="Month" NextMonthImageUrl="ig_cal_grayN0.gif" ShowYearDropDown="False" ShowMonthDropDown="False">
<TodayDayStyle BackgroundImage="ig_cal_light1.gif" ForeColor="Black"></TodayDayStyle>

<FooterStyle BackgroundImage="ig_cal_light2.gif" ForeColor="#707070" Height="16pt" Font-Size="8pt"></FooterStyle>

<SelectedDayStyle BackgroundImage="ig_cal_light2.gif" ForeColor="Black"></SelectedDayStyle>

<DayStyle BackgroundImage="ig_cal_light3.gif" BorderStyle="Solid" BorderWidth="1px" BorderColor="#909090"></DayStyle>

<NextPrevStyle BackgroundImage="ig_cal_light1.gif"></NextPrevStyle>

<OtherMonthDayStyle ForeColor="#909090"></OtherMonthDayStyle>

<DayHeaderStyle BackgroundImage="ig_cal_light2.gif" ForeColor="#606060" BackColor="Silver" Height="1pt" Font-Size="8pt" Font-Bold="True"></DayHeaderStyle>

<TitleStyle BackgroundImage="ig_cal_light1.gif" ForeColor="#606060" BackColor="#E0E0E0" Height="18pt" Font-Size="10pt" Font-Bold="True"></TitleStyle>

<CalendarStyle BorderStyle="Solid" ForeColor="#505050" BorderWidth="1px" BorderColor="Gray" BackColor="Silver" Font-Italic="False" Font-Size="9pt" Font-Names="Verdana" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></CalendarStyle>
</CalendarLayout>
</igsch:webdatechooser>
                </td>
								<td><asp:button id="btapply" runat="server" Text="审核申请" OnClick="btapply_Click" CssClass="btn"></asp:button></td>
								<td><asp:button id="btreturn" runat="server" Text="归还图书" OnClick="btreturn_Click" CssClass="btn"></asp:button></td>
							</tr>
						</table>
					</TD>
				</TR>
			</TABLE>
    </div>
    </form>
</body>
</html>
