<%@ page language="C#" autoeventwireup="true" inherits="Project_show_client_analysis, App_Web_client_analysis.aspx.8e3465e2" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebChart.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebChart" TagPrefix="igchart" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebChart.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Resources.Appearance" TagPrefix="igchartprop" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebChart.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.UltraChart.Data" TagPrefix="igchartdata" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>client_analysis</title>

		<META HTTP-EQUIV="pragma" CONTENT="no-cache">

		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
</head>
<body>
    <form id="form1" runat="server">
    <div>
    	    <div class=content>
		        <h2><strong>客户图表分析</strong></h2>
		    </div>
			<TABLE id="Table1" cellSpacing="1" cellPadding="1" width="100%" align="center" border="0">

				<TR>
					<TD>
						<table cellSpacing="1" cellPadding="1" width="100%" border="0">
							<tr>
								<td class="tdright" style="WIDTH: 106px">统计条件:</td>
								<td noWrap><asp:radiobuttonlist id="rb" runat="server" Width="254px" RepeatDirection="Horizontal">
										<asp:ListItem Value="1" Selected="True">级别</asp:ListItem>
										<asp:ListItem Value="2">行业</asp:ListItem>
										<asp:ListItem Value="3">来源</asp:ListItem>
										<asp:ListItem Value="4">状态</asp:ListItem>
										<asp:ListItem Value="5">类别</asp:ListItem>
									</asp:radiobuttonlist></td>
							</tr>
							<tr>
								<td style="WIDTH: 106px" class="tdright"><FONT face="宋体">请选择图表类型:</FONT>&nbsp;
								</td>
								<td>
									<asp:DropDownList id="ddl" runat="server" Width="96px">
										<asp:ListItem Value="1" Selected="True">柱状图</asp:ListItem>
										<asp:ListItem Value="2">饼图</asp:ListItem>
										<asp:ListItem Value="3">泡沫图</asp:ListItem>
										<asp:ListItem Value="4">立体图</asp:ListItem>
									</asp:DropDownList>&nbsp;<asp:button id="btanalysis" accessKey="S" runat="server" Text="图表分析" OnClick="btanalysis_Click"></asp:button></td>
							</tr>
						</table>
					</TD>
				</TR>
				<TR>
					<TD><FONT face="宋体">
                        <igchart:ultrachart id="uc" runat="server" backgroundimagefilename="" emptycharttext="Data Not Available. Please call UltraChart.Data.DataBind() after setting valid Data.DataSource"
                            imageurl="" version="6.2" width="679px">
<Axis>
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
</Axis>

<Tooltips Font-Italic="False" Font-Strikeout="False" Font-Underline="False" Font-Overline="False" Font-Bold="False"></Tooltips>

<Effects><Effects>
<igchartprop:GradientEffect></igchartprop:GradientEffect>
</Effects>
</Effects>

<ColorModel ModelStyle="CustomLinear" AlphaLevel="150"></ColorModel>
</igchart:ultrachart>
                    </FONT></TD>
				</TR>
				<tr>
					<td><FONT face="宋体"></FONT></td>
				</tr>
				<tr>
					<td>
					</td>
				</tr>
			</TABLE>
    </div>
    </form>
</body>
</html>
