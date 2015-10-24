<%@ page language="C#" autoeventwireup="true" inherits="isprit_other_loginhistory, App_Web_loginhistory.aspx.bf068bd5" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>loginHistory</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body topmargin="1" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
    <div>
    <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
        <br />
        <br />
        <br />
    <table id="table3"  width="100%">
				<tr>
					<td bgColor="#f1f1f1">
						<FIELDSET align="center"><LEGEND  style="WIDTH: 131px; HEIGHT: 16px" align="left">《用户登录日志分析》</LEGEND>提示:登录日志数据量较大，开始结束日期不要超过一个月<BR>
							<table id="table1">
								<tr>
									<td style="HEIGHT: 32px"></td>
									<td style="HEIGHT: 32px"></td>
									<td style="HEIGHT: 32px">开始日期</td>
									<td style="WIDTH: 57px; HEIGHT: 32px"><FONT face="宋体">
                                        <igsch:WebDateChooser ID="wdc1" runat="server">
                                            <CalendarLayout NextMonthImageUrl="ig_cal_silverN0.gif" PrevMonthImageUrl="ig_cal_silverP0.gif"
                                                ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                                                <TodayDayStyle BackColor="#D0D2D6" ForeColor="Black" />
                                                <FooterStyle BackgroundImage="ig_cal_silver1.gif" Font-Size="8pt" ForeColor="#707377"
                                                    Height="16pt" />
                                                <SelectedDayStyle BackColor="#888990" ForeColor="White" />
                                                <NextPrevStyle BackgroundImage="ig_cal_silver2.gif" />
                                                <OtherMonthDayStyle ForeColor="#888B90" />
                                                <DayHeaderStyle BackColor="#9A98AE" Font-Bold="true" Font-Size="8pt" ForeColor="White"
                                                    Height="1pt" />
                                                <TitleStyle BackColor="#D8E0E2" BackgroundImage="ig_cal_silver2.gif" Font-Bold="true"
                                                    Font-Size="10pt" ForeColor="#303040" Height="18pt" />
                                                <CalendarStyle BackColor="#EFF6F8" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px"
                                                    Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                                    Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" ForeColor="#404050">
                                                </CalendarStyle>
                                            </CalendarLayout>
                                        </igsch:WebDateChooser>
                                    </FONT></td>
									<td style="HEIGHT: 32px">结束日期</td>
									<td style="WIDTH: 102px; HEIGHT: 32px"><FONT face="宋体">
                                        <igsch:WebDateChooser ID="wdc2" runat="server">
                                            <CalendarLayout NextMonthImageUrl="ig_cal_silverN0.gif" PrevMonthImageUrl="ig_cal_silverP0.gif"
                                                ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                                                <TodayDayStyle BackColor="#D0D2D6" ForeColor="Black" />
                                                <FooterStyle BackgroundImage="ig_cal_silver1.gif" Font-Size="8pt" ForeColor="#707377"
                                                    Height="16pt" />
                                                <SelectedDayStyle BackColor="#888990" ForeColor="White" />
                                                <NextPrevStyle BackgroundImage="ig_cal_silver2.gif" />
                                                <OtherMonthDayStyle ForeColor="#888B90" />
                                                <DayHeaderStyle BackColor="#9A98AE" Font-Bold="true" Font-Size="8pt" ForeColor="White"
                                                    Height="1pt" />
                                                <TitleStyle BackColor="#D8E0E2" BackgroundImage="ig_cal_silver2.gif" Font-Bold="true"
                                                    Font-Size="10pt" ForeColor="#303040" Height="18pt" />
                                                <CalendarStyle BackColor="#EFF6F8" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px"
                                                    Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                                    Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" ForeColor="#404050">
                                                </CalendarStyle>
                                            </CalendarLayout>
                                        </igsch:WebDateChooser>
                                    </FONT></td>
									<td style="HEIGHT: 32px">
										<asp:ImageButton id="imbsearch" runat="server" ImageUrl="../../icon/search.gif" OnClick="imbsearch_Click"></asp:ImageButton></td>
								</tr>
								<tr>
									<td colSpan="7">
										<table id="table2" width="500">
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
											</asp:Repeater></table>
									</td>
								</tr>
							</table>
						</FIELDSET>
					</td>
				</tr>
			</table>
        
    </div>
    </form>
</body>
</html>
