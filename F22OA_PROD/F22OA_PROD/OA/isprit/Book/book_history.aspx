<%@ page language="C#" autoeventwireup="true" inherits="isprit_Book_book_history, App_Web_book_history.aspx.b5839e7c" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@   OutputCache   Duration="1"   VaryByParam="none"   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Book_history</title>
    <META HTTP-EQUIV="pragma" CONTENT="no-cache">
    <LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body topmargin="1" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server" method="get">
    <div>
    	    <div ><h2><strong>
                <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
                </strong></h2></div>
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%">
				<TBODY>
					<TR>
						<TD >
							<TABLE id="Table3" cellSpacing="0" cellPadding="0" border="0">
								<TR>
									<TD></TD>
									<TD><asp:textbox id="tbkey" runat="server" Width="105px" CssClass="book_tb"></asp:textbox></TD>
									<TD><asp:dropdownlist id="ddl" runat="server" Width="112px" CssClass="book_tb">
											<asp:ListItem Value="0" Selected="True">==所有状态==</asp:ListItem>
											<asp:ListItem Value="1">  曾借阅图书</asp:ListItem>
											<asp:ListItem Value="2">  申请中</asp:ListItem>
											<asp:ListItem Value="3">  在借图书</asp:ListItem>
										</asp:dropdownlist></TD>
									<TD>
                                        开始</TD>
									<TD>
                                        <igsch:WebDateChooser ID="wdc1" runat="server" Value="" Width="100px" AllowNull="False">
                                            <CalendarLayout NextMonthImageUrl="ig_cal_grayN.gif" PrevMonthImageUrl="ig_cal_grayP.gif"
                                                ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                                                <TodayDayStyle BackColor="#404040" />
                                                <FooterStyle ForeColor="#E0E0E0" BackColor="#404040" BorderColor="#606060" BorderStyle="Solid" BorderWidth="1px">
                                                </FooterStyle>
                                                <SelectedDayStyle ForeColor="Black" BackColor="Silver" />
                                                <OtherMonthDayStyle ForeColor="Gray" />
                                                <DayHeaderStyle BackColor="#404040" Font-Size="8pt" ForeColor="#E0E0E0"
                                                    Height="1pt">
                                                    <BorderDetails ColorBottom="Gray" StyleBottom="Solid" WidthBottom="1px" />
                                                </DayHeaderStyle>
                                                <TitleStyle BackColor="Black" Font-Bold="True" ForeColor="#E0E0E0" Height="18pt" />
                                                <CalendarStyle BackColor="Black"
                                                    Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                                    Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" ForeColor="White">
                                                </CalendarStyle>
                                            </CalendarLayout>
                                        </igsch:WebDateChooser>
                                    </TD>
									<TD>结束</TD>
									<TD>
                                        <igsch:WebDateChooser ID="wdc2" runat="server" Value="" Width="100px" AllowNull="False">
                                            <CalendarLayout NextMonthImageUrl="ig_cal_silverN0.gif" PrevMonthImageUrl="ig_cal_silverP0.gif"
                                                ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                                                <TodayDayStyle ForeColor="Black" BackColor="#D0D2D6" />
                                                <FooterStyle BackgroundImage="ig_cal_silver1.gif" Font-Size="8pt" ForeColor="#707377"
                                                    Height="16pt">
                                                </FooterStyle>
                                                <SelectedDayStyle ForeColor="White" BackColor="#888990" />
                                                <NextPrevStyle BackgroundImage="ig_cal_silver2.gif" />
                                                <OtherMonthDayStyle ForeColor="#888B90" />
                                                <DayHeaderStyle BackColor="#9A98AE" Font-Bold="True" Font-Size="8pt" ForeColor="White"
                                                    Height="1pt">
                                                </DayHeaderStyle>
                                                <TitleStyle BackColor="#D8E0E2" BackgroundImage="ig_cal_silver2.gif" Font-Bold="True"
                                                    Font-Size="10pt" ForeColor="#303040" Height="18pt" />
                                                <CalendarStyle BackColor="#EFF6F8" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px"
                                                    Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                                    Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" ForeColor="#404050">
                                                </CalendarStyle>
                                            </CalendarLayout>
                                        </igsch:WebDateChooser>
                                    </TD>
									<TD>
                                        <asp:Button ID="imbsearch" runat="server" CssClass="btn" Text="查    询" OnClick="imbsearch_Click" />
                                    </TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
					<TR>
						<TD>
						
								<asp:Repeater ID="dlbooks" Runat="server">
									<HeaderTemplate><table class="tbGrid" CellSpacing="1">
										<TR class="dgHeader" style="height:26px">
											<TD width="40">选择</TD>
											<TD width="200">书名</TD>
											<TD width="28">数量</TD>
											<TD width="88">申请日期</TD>
											<TD width="88">借书日期</TD>
											<TD width="88">应归还日期</TD>
											<td width="88">状态</td>
											<td width="40">删除</td>
										</TR>
									</HeaderTemplate>
									<FooterTemplate></table></FooterTemplate>
									<ItemTemplate>
										<tr  bgcolor="#ffffff" title='还书日期:<%# DataBinder.Eval(Container, "DataItem.truedate","{0:D}") %>'>
											<td width="40px" align="center">
												<asp:CheckBox Runat=server ID=ck1 tooltip='<%# DataBinder.Eval(Container, "DataItem.bookid") %>'>
												</asp:CheckBox></td>
											<td width="200px" nowrap><a href='book_show.aspx?action=show&bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>' target=_self ><%# DataBinder.Eval(Container, "DataItem.bookname") %></a></td>
											<!--<td nowrap width="70px"><%# DataBinder.Eval(Container, "DataItem.bookid") %></td>-->
											<td width="28px" align="center"><%# DataBinder.Eval(Container, "DataItem.amount") %></td>
											<td nowrap><%# DataBinder.Eval(Container, "DataItem.applydate","{0:D}") %></td>
											<td nowrap><%# DataBinder.Eval(Container, "DataItem.lenddate","{0:D}") %></td>
											<td nowrap><%# DataBinder.Eval(Container, "DataItem.willdate","{0:D}") %></td>
											<td>[<%# c2b(Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.outcheck")),Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.incheck"))) %>]
            <a href='#' onclick='LoadWindow("../book/book_renew.aspx?bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>",400,120,"续借",true)'>续借</a>
											</td>
											<td align="center">
                      
                      <a href='#' onclick='LoadWindow("../book/book_delete.aspx?lendid=<%# DataBinder.Eval(Container, "DataItem.lendid") %>",400,120,"删除借书记录",true)'><img border="0" src="../../icon/delete.gif" title='删除此借书记录' alt="删除"></a></td>
                      
										</tr>
									</ItemTemplate>
									<AlternatingItemTemplate>
										<tr  bgcolor="#eeeeee" title='还书日期:<%# DataBinder.Eval(Container, "DataItem.truedate","{0:D}") %>'>
											<td width="40px" align="center">
												<asp:CheckBox Runat=server ID="Checkbox1" tooptip='<%# DataBinder.Eval(Container, "DataItem.bookid") %>'>
												</asp:CheckBox></td>
											<td width="200px" nowrap><a href='book_show.aspx?action=show&bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>' target="_self" ><%# DataBinder.Eval(Container, "DataItem.bookname") %></a></td>
											<!--<td nowrap width="70px"><%# DataBinder.Eval(Container, "DataItem.bookid") %></td>-->
											<td width="28px" align="center"><%# DataBinder.Eval(Container, "DataItem.amount") %></td>
											<td nowrap width="88px"><%# DataBinder.Eval(Container, "DataItem.applydate","{0:D}") %></td>
											<td nowrap width="88px"><%# DataBinder.Eval(Container, "DataItem.lenddate","{0:D}") %></td>
											<td nowrap width="88px"><%# DataBinder.Eval(Container, "DataItem.willdate","{0:D}") %></td>
											<td>[<%# c2b(Convert.ToBoolean( DataBinder.Eval(Container, "DataItem.outcheck")),Convert.ToBoolean(DataBinder.Eval(Container, "DataItem.incheck"))) %>]
												<a href='#' onclick='LoadWindow("../book/book_renew.aspx?bookid=<%# DataBinder.Eval(Container, "DataItem.bookid") %>",400,120,"续借",true)'>
													续借</a></td>
											<td align="center"><a href=# onclick='LoadWindow("../book/book_delete.aspx?lendid=<%# DataBinder.Eval(Container, "DataItem.lendid") %>",400,120,"删除借书记录",true)'><img border="0" src="../../icon/delete.gif" title='删除此借书记录' alt="删除"></a></td>
										</tr>
									</AlternatingItemTemplate>
								</asp:Repeater>
					
		
			</TD>
					</TR>
				
			<tr>
				<td class="tip">
					<ol>
						<li>
						查询借阅记录，可以分在借中、曾借阅的、所有状态等
						<li>
						您也可以输出书名，查询是否借阅过该书
						<li>
							在查询时，请注意时间，时间范围是以申请借阅的时间为准.</li></ol>
				</td>
			</tr>
			</TBODY></TABLE>
    </div>
    </form>
</body>
</html>
