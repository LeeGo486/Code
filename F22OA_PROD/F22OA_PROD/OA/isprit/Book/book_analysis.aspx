<%@ page language="C#" autoeventwireup="true" inherits="isprit_Book_book_analysis, App_Web_book_analysis.aspx.b5839e7c" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebChart.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebChart" TagPrefix="igchart" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebChart.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Resources.Appearance" TagPrefix="igchartprop" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebChart.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Data" TagPrefix="igchartdata" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Book Analysis</title>
    <link href="../../css/project.css" type="text/css" rel="STYLESHEET" />
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<script language="JavaScript" type="text/javascript">
			window.attachEvent("onload", fixPNG);
		</script>
</head>
<body style="margin:0;">
    <form id="form1" runat="server">
    <div>
    <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    		<div style="padding:10px;">
			<TABLE id="Table1" cellSpacing="0" cellPadding="0" width="100%" align="center" border="0">

				<TR>
					<TD>
						<table cellSpacing="1" cellPadding="1" width="100%" border="0">
							<tr>
								<td class="tdright" style="WIDTH: 106px">统计条件:</td>
								<td noWrap class="tdwhite"><asp:radiobuttonlist id="rb" runat="server" Width="496px" RepeatDirection="Horizontal">
										<asp:ListItem Value="1" Selected="True">最热门的图书</asp:ListItem>
										<asp:ListItem Value="2">借阅最跃的人</asp:ListItem>
										<asp:ListItem Value="3">图书分类统计</asp:ListItem>
										<asp:ListItem Value="4">借阅类别统计</asp:ListItem>
									</asp:radiobuttonlist></td>
							</tr>
							<tr>
								<td style="WIDTH: 106px" class="tdright"><FONT face="宋体">请选择图表类型:</FONT>&nbsp;
								</td>
								<td class="tdwhite">
									<asp:DropDownList id="ddl" runat="server" Width="96px">
										<asp:ListItem Value="1" Selected="True">柱状图</asp:ListItem>
										<asp:ListItem Value="2">饼图</asp:ListItem>
										<asp:ListItem Value="3">泡沫图</asp:ListItem>
										<asp:ListItem Value="4">立体图</asp:ListItem>
									</asp:DropDownList>&nbsp;<asp:button id="btanalysis" accessKey="S" runat="server" Text="图表分析" CssClass="btn" OnClick="btanalysis_Click"></asp:button></td>
							</tr>
						</table>
					</TD>
				</TR>
				<TR>
					<TD ><div id="tmtable">
							<asp:DataGrid id="dgdetail" runat="server" BorderStyle="None"   CellPadding="3">
								<SelectedItemStyle Font-Bold="True" ForeColor="White"></SelectedItemStyle>
								<HeaderStyle Font-Bold="True" CssClass="dgHeader"></HeaderStyle>
								<FooterStyle CssClass="dgHeader"></FooterStyle>
								<pagerStyle HorizontalAlign="Left" ForeColor="#000066"  Mode="NumericPages"></pagerStyle>
							</asp:DataGrid></div></TD>
				</TR>
				<tr>
					<td><FONT face="宋体"></FONT></td>
				</tr>
				<tr>
					<td>
                        <igchart:ultrachart id="UC" runat="server" backgroundimagefilename="" emptycharttext="Data Not Available. Please call UltraChart.Data.DataBind() after setting valid Data.DataSource"
                            height="322px" imageurl="" version="6.2" width="590px">
                            <axis>
<Z LineThickness="1" TickmarkInterval="0" Visible="False" TickmarkStyle="Smart">
<MinorGridLines Color="LightGray" DrawStyle="Dot" Visible="False" Thickness="1" AlphaLevel="255"></MinorGridLines>

<MajorGridLines Color="Gainsboro" DrawStyle="Dot" Visible="True" Thickness="1" AlphaLevel="255"></MajorGridLines>

<Labels Orientation="Horizontal" ItemFormatString="" FontColor="DimGray" HorizontalAlign="Near" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>

<SeriesLabels Orientation="Horizontal" FontColor="DimGray" HorizontalAlign="Center" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>
</SeriesLabels>
</Labels>
</Z>

<Y2 LineThickness="1" TickmarkInterval="20" Visible="False" TickmarkStyle="Smart">
<MinorGridLines Color="LightGray" DrawStyle="Dot" Visible="False" Thickness="1" AlphaLevel="255"></MinorGridLines>

<MajorGridLines Color="Gainsboro" DrawStyle="Dot" Visible="True" Thickness="1" AlphaLevel="255"></MajorGridLines>

<Labels Orientation="Horizontal" ItemFormatString="&lt;DATA_VALUE:00.##&gt;" FontColor="Gray" HorizontalAlign="Near" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>

<SeriesLabels Orientation="VerticalLeftFacing" FontColor="Gray" HorizontalAlign="Center" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>
</SeriesLabels>
</Labels>
</Y2>

<X LineThickness="1" TickmarkInterval="0" Visible="True" TickmarkStyle="Smart">
<MinorGridLines Color="LightGray" DrawStyle="Dot" Visible="False" Thickness="1" AlphaLevel="255"></MinorGridLines>

<MajorGridLines Color="Gainsboro" DrawStyle="Dot" Visible="True" Thickness="1" AlphaLevel="255"></MajorGridLines>

<Labels Orientation="VerticalLeftFacing" ItemFormatString="&lt;ITEM_LABEL&gt;" FontColor="DimGray" HorizontalAlign="Near" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>

<SeriesLabels Orientation="Horizontal" FontColor="DimGray" HorizontalAlign="Center" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>
</SeriesLabels>
</Labels>
</X>

<Y LineThickness="1" TickmarkInterval="20" Visible="True" TickmarkStyle="Smart">
<MinorGridLines Color="LightGray" DrawStyle="Dot" Visible="False" Thickness="1" AlphaLevel="255"></MinorGridLines>

<MajorGridLines Color="Gainsboro" DrawStyle="Dot" Visible="True" Thickness="1" AlphaLevel="255"></MajorGridLines>

<Labels Orientation="Horizontal" ItemFormatString="&lt;DATA_VALUE:00.##&gt;" FontColor="DimGray" HorizontalAlign="Far" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>

<SeriesLabels Orientation="VerticalLeftFacing" FontColor="DimGray" HorizontalAlign="Center" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>
</SeriesLabels>
</Labels>
</Y>

<X2 LineThickness="1" TickmarkInterval="0" Visible="False" TickmarkStyle="Smart">
<MinorGridLines Color="LightGray" DrawStyle="Dot" Visible="False" Thickness="1" AlphaLevel="255"></MinorGridLines>

<MajorGridLines Color="Gainsboro" DrawStyle="Dot" Visible="True" Thickness="1" AlphaLevel="255"></MajorGridLines>

<Labels Orientation="VerticalLeftFacing" ItemFormatString="&lt;ITEM_LABEL&gt;" FontColor="Gray" HorizontalAlign="Far" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>

<SeriesLabels Orientation="Horizontal" FontColor="Gray" HorizontalAlign="Center" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>
</SeriesLabels>
</Labels>
</X2>

<Z2 LineThickness="1" TickmarkInterval="0" Visible="False" TickmarkStyle="Smart">
<MinorGridLines Color="LightGray" DrawStyle="Dot" Visible="False" Thickness="1" AlphaLevel="255"></MinorGridLines>

<MajorGridLines Color="Gainsboro" DrawStyle="Dot" Visible="True" Thickness="1" AlphaLevel="255"></MajorGridLines>

<Labels Orientation="Horizontal" ItemFormatString="" FontColor="Gray" HorizontalAlign="Near" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>

<SeriesLabels Orientation="Horizontal" FontColor="Gray" HorizontalAlign="Center" Font="Verdana, 7pt" VerticalAlign="Center">
<Layout Behavior="Auto"></Layout>
</SeriesLabels>
</Labels>
</Z2>
</axis>
                            <tooltips font-bold="False" font-italic="False" font-overline="False" font-strikeout="False"
                                font-underline="False"></tooltips>
                            <effects><Effects>
<igchartprop:GradientEffect></igchartprop:GradientEffect>
</Effects>
</effects>
                            <colormodel alphalevel="150" modelstyle="CustomLinear"></colormodel>
                        </igchart:ultrachart></td>
				</tr>
			</TABLE>
		</div>
    </div>
    <script type="text/javascript" defer="defer">
				jsTable('tmtable','tm','590','','');
    </script>
    </form>
</body>
</html>
