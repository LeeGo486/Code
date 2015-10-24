<%@ page language="C#" autoeventwireup="true" inherits="isprit_schedule_arrange, App_Web_arrange.aspx.4c52363" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"  Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>新建日程</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="../../css/project.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="../../js/project.js"></script>
    <script language="javascript" type="text/javascript">
        function ddchg(img)//选择图片的
        {
            document.getElementById("imgicon").src="img/" + img;
            //document.all.item("imgicon").src="img/" + document.all.item("ddicon").value;
        }
        //检测内容是否为空
        function CheckForm(){
			var tbmatter = document.getElementById("tbmatter");
			if (tbmatter.value.length<=0){
				alert("请填写事务内容！");
				tbmatter.focus();
				//document.all.tbmatter.focus();
				return false;
			}
		return true;
		}
  
		</script>
</head>
<body style="margin:5px;">
    <form id="form1" runat="server">
    <div id="lrtable">
    
    <table cellspacing="1" cellpadding="0" align="center" bgcolor="#2a5faa" border="0">
				<tr>
					<td class="header" colspan="3"><img alt="" src="../../icon/menu/calendar.gif" /> 新建日程安排
							<asp:label id="lbdate" runat="server" forecolor="blue"></asp:label></td>
				</tr>
				<tr>
					<td class="tdright" style="width: 63px"><font face="宋体">开始时间:</font></td>
					<td >
						<table cellspacing="0" cellpadding="0">
							<tr>
								<td style="width: 130px;">
                                    <igsch:webdatechooser id="wdt1" runat="server" Value="">
                                        <CalendarLayout DayNameFormat="FirstLetter" ShowFooter="False" ShowMonthDropDown="False"
                                            ShowYearDropDown="False" NextMonthImageUrl="ig_cal_silverN0.gif" PrevMonthImageUrl="ig_cal_silverP0.gif" TitleFormat="Month">
                                            <TodayDayStyle BackColor="#D0D2D6" ForeColor="Black" />
                                            <SelectedDayStyle BackColor="#888990" ForeColor="White" />
                                            <NextPrevStyle BackgroundImage="ig_cal_silver2.gif" />
                                            <OtherMonthDayStyle ForeColor="#888B90" />
                                            <DayHeaderStyle BackColor="#9A98AE" Font-Bold="True" Font-Size="8pt" ForeColor="White" Height="1pt" />
                                            <TitleStyle BackColor="#D8E0E2" Font-Bold="True" Height="18pt" BackgroundImage="ig_cal_silver2.gif" Font-Size="10pt" ForeColor="#303040" />
                                            <CalendarStyle BackColor="#EFF6F8" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                                Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" ForeColor="#404050">
                                            </CalendarStyle>
                                            <FooterStyle BackgroundImage="ig_cal_silver1.gif" Font-Size="8pt" ForeColor="#707377"
                                                Height="16pt" />
                                        </CalendarLayout>
                                    </igsch:webdatechooser>
                                    <selecteddaystyle backcolor="#CC3333" forecolor="White" />
                                    <othermonthdaystyle forecolor="#999999" />
                                    <nextprevstyle font-bold="True" font-size="8pt" forecolor="White" />
                                    <calendarstyle backcolor="White" bordercolor="Black" borderstyle="Solid" borderwidth="1px"
                                        font-names="tahoma" font-size="10pt" forecolor="Black">
</calendarstyle>

                                    <todaydaystyle backcolor="#CCCC99" />
                                    <dayheaderstyle backcolor="#CCCCCC" font-bold="True" font-names="Verdana" font-size="7pt"
                                        forecolor="#333333" height="10px" />
                                    <titlestyle backcolor="Black" font-bold="True" font-size="13pt" forecolor="White"
                                        height="14px" />
                                    <expandeffects shadowcolor="LightGray">
</expandeffects>
                                </td>
								<td ><asp:dropdownlist id="dd1" runat="server" CssClass="tb">
										<asp:ListItem Value="08">08</asp:ListItem>
										<asp:ListItem Value="09" Selected="True">09</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="11">11</asp:ListItem>
										<asp:ListItem Value="12">12</asp:ListItem>
										<asp:ListItem Value="13">13</asp:ListItem>
										<asp:ListItem Value="14">14</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="16">16</asp:ListItem>
										<asp:ListItem Value="17">17</asp:ListItem>
										<asp:ListItem Value="18">18</asp:ListItem>
										<asp:ListItem Value="19">19</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist>：
									<asp:dropdownlist id="dd2" runat="server" CssClass="tb">
										<asp:ListItem Value="00" Selected="True">00</asp:ListItem>
										<asp:ListItem Value="05">05</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="35">35</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="45">45</asp:ListItem>
										<asp:ListItem Value="50">50</asp:ListItem>
										<asp:ListItem Value="55">55</asp:ListItem>
									</asp:dropdownlist></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="tdright" style="WIDTH: 63px;">结束时间:</td>
					<td>
						<table cellSpacing="0" cellPadding="0" >
							<tr>
								<td style="width: 130px;">
                                    <igsch:webdatechooser id="wdt2" runat="server">
                                        <CalendarLayout NextMonthImageUrl="ig_cal_silverN0.gif" PrevMonthImageUrl="ig_cal_silverP0.gif"
                                            ShowMonthDropDown="False" ShowYearDropDown="False" TitleFormat="Month">
                                            <TodayDayStyle BackColor="#D0D2D6" ForeColor="Black" />
                                            <FooterStyle BackgroundImage="ig_cal_silver1.gif" Font-Size="8pt" ForeColor="#707377"
                                                Height="16pt" />
                                            <SelectedDayStyle BackColor="#888990" ForeColor="White" />
                                            <NextPrevStyle BackgroundImage="ig_cal_silver2.gif" />
                                            <OtherMonthDayStyle ForeColor="#888B90" />
                                            <DayHeaderStyle BackColor="#9A98AE" Font-Bold="True" Font-Size="8pt" ForeColor="White"
                                                Height="1pt" />
                                            <TitleStyle BackColor="#D8E0E2" BackgroundImage="ig_cal_silver2.gif" Font-Bold="True"
                                                Font-Size="10pt" ForeColor="#303040" Height="18pt" />
                                            <CalendarStyle BackColor="#EFF6F8" BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False"
                                                Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" ForeColor="#404050">
                                            </CalendarStyle>
                                        </CalendarLayout>
                                    </igsch:webdatechooser>
                                    <selecteddaystyle backcolor="#666666" forecolor="White" />
                                    <othermonthdaystyle forecolor="Gray" />
                                    <calendarstyle backcolor="White" bordercolor="#999999" borderstyle="Solid" borderwidth="1px"
                                        font-names="tahoma" font-size="8pt" forecolor="Black">
</calendarstyle>
                                    <weekenddaystyle backcolor="#FFFFCC" />
                                    <todaydaystyle backcolor="#CCCCCC" />
                                    <dayheaderstyle backcolor="#CCCCCC" font-bold="True" font-size="7pt" />
                                    <titlestyle backcolor="#999999" font-bold="True" height="24px" />
                                </td>
                                <td>
                                <asp:dropdownlist id="dd3" runat="server" CssClass="tb">
										<asp:ListItem Value="08">08</asp:ListItem>
										<asp:ListItem Value="09">09</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="11">11</asp:ListItem>
										<asp:ListItem Value="12">12</asp:ListItem>
										<asp:ListItem Value="13">13</asp:ListItem>
										<asp:ListItem Value="14">14</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="16">16</asp:ListItem>
										<asp:ListItem Value="17">17</asp:ListItem>
										<asp:ListItem Value="18">18</asp:ListItem>
										<asp:ListItem Value="19">19</asp:ListItem>
										<asp:ListItem Value="20" Selected="True">20</asp:ListItem>
									</asp:dropdownlist>：
									<asp:dropdownlist id="dd4" runat="server" CssClass="tb">
										<asp:ListItem Value="00" Selected="True">00</asp:ListItem>
										<asp:ListItem Value="05">05</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="35">35</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="45">45</asp:ListItem>
										<asp:ListItem Value="50">50</asp:ListItem>
										<asp:ListItem Value="55">55</asp:ListItem>
									</asp:dropdownlist></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<TD class="tdright" style="WIDTH: 63px">日程内容:</TD>
					<td ><asp:radiobuttonlist id="rbcolor" runat="server" RepeatDirection="Horizontal">
							<asp:ListItem Value="#000000" Selected="True">黑</asp:ListItem>
							<asp:ListItem Value="#0060ff">蓝</asp:ListItem>
							<asp:ListItem Value="#8020c0">紫</asp:ListItem>
							<asp:ListItem Value="#ff2000">红</asp:ListItem>
							<asp:ListItem Value="#80a0c0">灰</asp:ListItem>
							<asp:ListItem Value="#ff6600">橙</asp:ListItem>
							<asp:ListItem Value="#00cc00">绿</asp:ListItem>
						</asp:radiobuttonlist><asp:textbox id="tbmatter" runat="server" Height="70px" Width="257px" TextMode="MultiLine"></asp:textbox></td>
				</tr>
				<tr>
					<td class="tdright" style="WIDTH: 63px"><FONT face="宋体"><asp:checkbox id="cbremind" runat="server" ForeColor="Red" Text="提醒" TextAlign="Left" Checked="True"></asp:checkbox></FONT></td>
					<td bgColor="#ffffff" style="width: 254px"><FONT face="宋体">图标：</FONT>
						<SELECT class="tb" id="ddicon" onchange="ddchg(this.value);" runat="server">
							<OPTION value="null.gif">不选择图标</OPTION>
							<OPTION value="bell.gif" selected>闹钟</OPTION>
							<OPTION value="dollar.gif">金钱</OPTION>
							<OPTION value="ap.gif">安排</OPTION>
							<OPTION value="soccer.gif">足球</OPTION>
							<OPTION value="tel.gif">电话</OPTION>
							<OPTION value="reoccur.gif">其它</OPTION>
						</SELECT><IMG id="imgicon" height="16" alt="图标" src="img/bell.gif" width="16"></td>
				</tr>
				<tr>
					<td vAlign="middle" align="center" colSpan="2" class="footer"><asp:button id="btsave" accessKey="s" runat="server" Text="保存(S)" CssClass="btn" OnClick="btsave_Click"></asp:button>
          &nbsp;<input type="button" onclick="javascript:CloseWindow('新建日程安排');" value="关 闭(C)" accesskey="c" class="btn" />
          </td>
				</tr>
			</table>
    </div>
    <script type="text/javascript" defer="defer">
    	jsTable('lrtable','lr','95%','','center')
    </script>
    </form>
    
</body>
</html>
