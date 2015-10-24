<%@ page language="C#" autoeventwireup="true" inherits="Project_Module_spjt, App_Web_spjt.aspx.d7a0d114" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>sPjt</title>
		
		
		<LINK href="../../css/project.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table cellSpacing="0" cellPadding="0" width="100%">
				<tr>
					<td><FONT face="宋体">
							</FONT></td>
				</tr>
				<tr>
					<td style="HEIGHT: 29px">
						<table>
							<tr>
								<td>
                                    <calendarlayout footerformat="Today: {0:d}">
</calendarlayout>
                                    <igsch:webdatechooser id="wdc1" runat="server">
                                        <CalendarLayout NextMonthImageUrl="ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif"
                                            ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                                            <TodayDayStyle BackColor="#E0EEFF" />
                                            <FooterStyle BackgroundImage="ig_cal_blue1.gif" Font-Size="8pt" ForeColor="#505080"
                                                Height="16pt">
                                                <BorderDetails ColorTop="LightSteelBlue" StyleTop="Solid" WidthTop="1px" />
                                            </FooterStyle>
                                            <SelectedDayStyle BackColor="SteelBlue" />
                                            <NextPrevStyle BackgroundImage="ig_cal_blue2.gif" />
                                            <OtherMonthDayStyle ForeColor="SlateGray" />
                                            <DayHeaderStyle BackColor="#E0EEFF" Font-Bold="True" Font-Size="8pt" ForeColor="#8080A0"
                                                Height="1pt">
                                                <BorderDetails ColorBottom="LightSteelBlue" StyleBottom="Solid" WidthBottom="1px" />
                                            </DayHeaderStyle>
                                            <TitleStyle BackColor="#CCDDFF" BackgroundImage="ig_cal_blue2.gif" Font-Bold="True"
                                                Font-Size="10pt" ForeColor="#505080" Height="18pt" />
                                            <CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                                Font-Size="9pt" Font-Strikeout="False" Font-Underline="False">
                                            </CalendarStyle>
                                        </CalendarLayout>
                                    </igsch:webdatechooser>
                                    <expandeffects shadowcolor="LightGray">
</expandeffects>
                                </td>
								<td style="WIDTH: 106px">
                                    <igsch:webdatechooser id="wdc2" runat="server">
                                        <CalendarLayout NextMonthImageUrl="ig_cal_blueN0.gif" PrevMonthImageUrl="ig_cal_blueP0.gif"
                                            ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                                            <TodayDayStyle BackColor="#E0EEFF" />
                                            <FooterStyle BackgroundImage="ig_cal_blue1.gif" Font-Size="8pt" ForeColor="#505080"
                                                Height="16pt">
                                                <BorderDetails ColorTop="LightSteelBlue" StyleTop="Solid" WidthTop="1px" />
                                            </FooterStyle>
                                            <SelectedDayStyle BackColor="SteelBlue" />
                                            <NextPrevStyle BackgroundImage="ig_cal_blue2.gif" />
                                            <OtherMonthDayStyle ForeColor="SlateGray" />
                                            <DayHeaderStyle BackColor="#E0EEFF" Font-Bold="True" Font-Size="8pt" ForeColor="#8080A0"
                                                Height="1pt">
                                                <BorderDetails ColorBottom="LightSteelBlue" StyleBottom="Solid" WidthBottom="1px" />
                                            </DayHeaderStyle>
                                            <TitleStyle BackColor="#CCDDFF" BackgroundImage="ig_cal_blue2.gif" Font-Bold="True"
                                                Font-Size="10pt" ForeColor="#505080" Height="18pt" />
                                            <CalendarStyle BackColor="#CCDDFF" BorderColor="SteelBlue" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                                Font-Size="9pt" Font-Strikeout="False" Font-Underline="False">
                                            </CalendarStyle>
                                        </CalendarLayout>
                                    </igsch:webdatechooser>
                                </td>
								<td><asp:textbox id="tbs" runat="server" CssClass="book_tb" Width="112px"></asp:textbox></td>
								<td>
									<asp:DropDownList id="ddlsort" runat="server" Width="128px"></asp:DropDownList></td>
								<td><asp:imagebutton id="imbSearch" runat="server" ImageUrl="../../icon/search.gif" OnClick="imbSearch_Click"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<asp:DataGrid id="dgpjt" runat="server" AutoGenerateColumns="False" Width="100%" BorderColor="#DEDFDE"
							BorderStyle="None" BorderWidth="1px" BackColor="White" CellPadding="4" GridLines="Vertical"
							ForeColor="Black" OnItemCommand="dg_ItemCommand">
							<FooterStyle BackColor="#CCCC99"></FooterStyle>
							<SelectedItemStyle Font-Bold="True" ForeColor="White" BackColor="#CE5D5A"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#F7F7DE"></ItemStyle>
							<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#6B696B"></HeaderStyle>
							<Columns>
								<asp:BoundColumn DataField="pjtnumber" ReadOnly="True" HeaderText="编号"></asp:BoundColumn>
								<asp:BoundColumn DataField="pjtname" HeaderText="名称"></asp:BoundColumn>
								<asp:BoundColumn DataField="dcompany" HeaderText="所属公司"></asp:BoundColumn>
								<asp:BoundColumn DataField="crdate" HeaderText="登记日期" DataFormatString="{0:D}"></asp:BoundColumn>
								<asp:BoundColumn DataField="levelname" HeaderText="项目状态"></asp:BoundColumn>
								<asp:ButtonColumn Text="选择" CommandName="Select"></asp:ButtonColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Right" ForeColor="Black" BackColor="#F7F7DE" Mode="NumericPages"></pagerStyle>
						</asp:DataGrid>
					</td>
				</tr>
				<tr>
					<td><webdiyer:aspnetpager id="ap" runat="server" PageSize="15" OnPageChanged="ap_PageChanged"></webdiyer:aspnetpager></td>
				</tr>
				<tr>
					<td align="center"></td>
				</tr>
				<tr>
					<td class="tip" align="center">
						<asp:Label id="lbpjt" runat="server"></asp:Label></td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
