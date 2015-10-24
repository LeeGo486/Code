<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_depotSale, App_Web_depotsale.aspx.9ee944ed" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>销售情况</title>
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
    #Table1
    {
    	background:#5D7B9D;
    	}
    #Table1 th
    {
    	color:White;
    	}
    #Table1 td
    {
    	background:#FFF;
    	
    	border-bottom:solid 1px #efefef;
    	}
    
    </style>
</head>
<body>
    <form id="form2" runat="server">
    <div>
<table width="100%" border="0" cellpadding="0" cellspacing="5">

  <tr>
    <td>
    <div id="depotinfomenu">
    <ul>
    <li><a href="depotInfo.aspx?depotid=<%=depotid %>">店铺信息</a></li>
    <li><a href="depotFile.aspx?depotid=<%=depotid %>">店铺文档</a></li>
    <li><a href="depotUser.aspx?depotid=<%=depotid %>">人员档案</a></li>
    <li><a href="depotSale.aspx?depotid=<%=depotid %>" class="mthis">销售情况</a></li>
    </ul>
    </div>    </td>
  </tr>
<%--    
  <tr>
    <td valign="top">　<a href="#cc">类型分析报表</a> | <a href="#bb">店铺销售排行</a> | <a href="#aa">款式销售排行</a></td>
  </tr>--%>
    
  <tr>
    <td valign="top">
                    <table><tr>
                    <td>&nbsp;&nbsp;
                    选择日期：</td>
                    <td style="width:80px;">
        <igsch:WebDateChooser
                    ID="WebDateChooser1" runat="server" Value="" Width="80px">
                    <CalendarLayout CellPadding="0" NextMonthImageUrl="ig_tab_scrollXP3.gif" PrevMonthImageUrl="ig_tab_scrollXP2.gif"
                        ShowFooter="False" ShowMonthDropDown="False" ShowYearDropDown="False" ChangeMonthToDateClicked="True">
                        <CalendarStyle BackColor="White" BorderColor="LightSlateGray" BorderStyle="Solid"
                            Font-Bold="False" Font-Italic="False" Font-Names="Tahoma,Verdana" Font-Overline="False"
                            Font-Size="8pt" Font-Strikeout="False" Font-Underline="False" Width="180px">
                        </CalendarStyle>
                        <DayHeaderStyle BackColor="SteelBlue" Font-Bold="False" ForeColor="White">
                            <BorderDetails ColorBottom="172, 168, 153" StyleBottom="Solid" WidthBottom="1px" />
                        </DayHeaderStyle>
                        <OtherMonthDayStyle ForeColor="#ACA899" />
                        <SelectedDayStyle BackColor="Gold" ForeColor="Black" />
                        <TitleStyle BackColor="PowderBlue" Font-Bold="True" Font-Size="12px" />
                        <TodayDayStyle BackColor="#FBE694" />
                    </CalendarLayout>
                </igsch:WebDateChooser>
                    </td>
                    <td style="width:300px;">
　      <asp:RadioButton ID="RadioButton2" runat="server" Text="年度" GroupName="rType" Checked="true" />
        <asp:RadioButton ID="RadioButton3" runat="server" Text="半年度" GroupName="rType" />
        <asp:RadioButton ID="RadioButton4" runat="server" Text="季度" GroupName="rType" />
        <asp:RadioButton ID="RadioButton5" runat="server" Text="按月" GroupName="rType" />
        <asp:RadioButton ID="RadioButton6" runat="server" Text="按周" GroupName="rType" />
                    </td>
                    <td>
                    <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:Button ID="Button1" runat="server" Text="查　询" onclick="Button1_Click" />                    
                    </td>
                    </tr></table>
                    
                    </td>
  </tr>
  <tr>
    <td valign="top" >
    <asp:Label runat="server" ID="label2"></asp:Label>
        <asp:Table ID="Table1" runat="server" HorizontalAlign="Center" CellPadding="3" CellSpacing="0" Width="98%">
        </asp:Table>
       
	</td>
  </tr>
</table>

    </div>
    </form>
</body>
</html>

