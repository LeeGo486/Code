<%@ page language="C#" autoeventwireup="true" inherits="isprit_Book_book_show, App_Web_book_show.aspx.b5839e7c" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>book_show</title>
    <LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="tmtable">
    <table cellSpacing="1" cellPadding="0" width="450" align="center" bgColor="#666666">
				<tr>
					<td class="header" colSpan="2"><asp:label id="lbbookname" runat="server"></asp:label>&nbsp;的详细资料</td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="whitesmoke">
						<table style="WIDTH: 450px; HEIGHT: 20px">
							<tr>
								<td class="tdright" style="WIDTH: 90px">编号:</td>
								<td class="tdwhite" style="WIDTH: 115px"><asp:label id="lbid" runat="server"></asp:label></td>
								<TD class="tdright" style="WIDTH: 68px">类别名称:</TD>
								<TD class="tdwhite"><asp:label id="lbsort" runat="server"></asp:label></TD>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<TD colspan="2" width="100%" bgcolor="whitesmoke">
						<table style="WIDTH: 450px; HEIGHT: 20px">
							<tr>
								<td class="tdHighlight" style="WIDTH: 90px">价格:</td>
								<td class="tdwhite" style="WIDTH: 115px">￥<asp:label id="lbprice" runat="server"></asp:label></td>
								<TD class="tdHighlight" style="WIDTH: 68px">馆藏数量:</TD>
								<TD class="tdwhite"><asp:label id="lbamount" runat="server"></asp:label></TD>
							</tr>
						</table>
					</TD>
				</tr>
				<tr>
					<td colspan="2" bgcolor="whitesmoke">
						<table style="WIDTH: 450px; HEIGHT: 20px">
							<tr>
								<td class="tdright" style="WIDTH: 90px">ISBN:</td>
								<td class="tdwhite" style="WIDTH: 115px"><asp:label id="lbisbn" runat="server"></asp:label></td>
								<TD class="tdright" style="WIDTH: 68px">条码:</TD>
								<TD class="tdwhite"><asp:label id="lbcode" runat="server"></asp:label></TD>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="whitesmoke">
						<table style="WIDTH: 450px; HEIGHT: 20px">
							<tr>
								<td class="tdright" style="WIDTH: 90px">总页数:</td>
								<td class="tdwhite" style="WIDTH: 115px"><asp:label id="lbpp" runat="server"></asp:label></td>
								<TD class="tdright" style="WIDTH: 68px">所在架位:</TD>
								<TD class="tdwhite"><asp:label id="lblocation" runat="server"></asp:label></TD>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<TD class="tdright" style="WIDTH: 90px">出版商|作者:</TD>
					<TD class="tdwhite"><asp:label id="lbbookman" runat="server"></asp:label></TD>
				</tr>
				<tr>
					<TD class="tdright" style="WIDTH: 90px">出版日期:</TD>
					<TD class="tdwhite"><asp:label id="lbdate" runat="server"></asp:label></TD>
				</tr>
				<tr height="40">
					<TD class="tdright" style="WIDTH: 90px">备注:</TD>
					<TD class="tdwhite"><asp:label id="lbremark" runat="server"></asp:label></TD>
				</tr>
        <tr>
								<td colSpan="2" align="center">
                        <INPUT accessKey="z" onclick="history.go(-1);" type="button" value="返回(Z)" class="btn">
	</td>
        </tr>
			</table>
      
      
      <table width="100%" cellpadding="0" cellspacing="1" id="tbapply" runat="server">
							<tr>
								<TD class="header" colSpan="2">预借图书:</TD>
							</tr>
							<tr>
								<TD class="tdright" style="WIDTH: 90px">预借日期:</TD>
								<TD class="tdwhite">
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
</igsch:webdatechooser>
                                </TD>
							</tr>
							<tr>
								<td class="tdright" style="WIDTH: 90px">备注:</td>
								<td class="tdwhite"><asp:textbox id="tbremark" runat="server" Width="194px" TextMode="MultiLine" Height="64px"></asp:textbox></td>
							</tr>
							<tr>
								<TD class="tdright" style="WIDTH: 90px">电子签名:</TD>
								<TD class="tdwhite"><INPUT class="tbox1" id="tbusername" style="WIDTH: 98px; HEIGHT: 22px" readOnly type="text"
										size="11" name="tbcompany" runat="server" cname="电子签名" nullable="n"><INPUT id="tbnickname" style="WIDTH: 13px; HEIGHT: 22px" type="hidden" size="1" name="Hidden2"
										runat="server"><A onclick="LoadWindow('../Module/signature.aspx',395,240,'电子签名',true);" href="#"><IMG title="点击签名" src="../../icon/Notes.gif" border="0"></A></TD>
							</tr>
							<tr class="footer" align="center">
								<td colSpan="2">
                <asp:button id="btapply" accessKey="a" runat="server" Text="借阅申请(A)" CssClass="btn" OnClick="btapply_Click"></asp:button>&nbsp;
                </td>
							</tr>
						</table>
    </div><br />
<br />

		<script type="text/javascript" defer="defer">
    	jsTable('tmtable','tm','75%','','center');
		</script>
    </form>
</body>
</html>
