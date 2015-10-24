<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="SafeChart1.aspx.cs" Inherits="EPReper.Web.EPSafe.SafeChart1" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 40px; float: left; font-size: 15px; font-weight: 700; color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 760px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>
            </div>
            <div id="admins" visible="false" runat="server" style="float: left; width: 180px; margin-top: 5px; margin-bottom: 5px; text-align: right;">
                <a href="SafeAdmin.aspx">管理员</a>
            </div>
        </div>
    </div>
    <div style="float: left; width: 960px;">
        <%--    <div class="NewsTab1">
                    <span style="color: #0087ce;"><a href="#"></a>雅莹安全隐患每日情况(列表、事件) </span>
                </div>--%>
        <div style="margin: auto; float: left; width: 960px; padding-left: 5px;">
            <asp:Chart ID="Chart1" runat="server" Height="320px" Width="950px" BorderlineColor="#C0C0C0" BorderlineDashStyle="Solid">
                <Titles>
                    <asp:Title ShadowColor="White" Font="Trebuchet MS, 14.25pt, style=Bold" Text="雅莹安全隐患每日情况(列表、事件)" Name="Title1" ForeColor="26, 59, 105">
                    </asp:Title>
                </Titles>
                <Legends>
                    <%--    <asp:Legend TitleFont="Microsoft Sans Serif, 8pt, style=Bold" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold" IsTextAutoFit="False" Enabled="False" Name="Default">
                            </asp:Legend>--%>
                    <asp:Legend LegendStyle="Row" IsTextAutoFit="False" BorderWidth="0" BorderColor="Black" Docking="Top" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold">
                    </asp:Legend>
                </Legends>
                <Series>
                    <asp:Series XValueType="String" LegendText="全部" IsValueShownAsLabel="true" Name="Series1" BorderColor="180, 26, 59, 105">
                    </asp:Series>
                    <asp:Series XValueType="String" LegendText="已处理" IsValueShownAsLabel="true" Name="Series2" BorderColor="180, 26, 59, 105">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White" BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                        <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False" WallWidth="0" IsClustered="False" />
                        <AxisY LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                            <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                            <MajorGrid LineColor="64, 64, 64, 64" />
                        </AxisY>
                        <AxisX LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                            <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsEndLabelVisible="False" />
                            <MajorGrid LineColor="64, 64, 64, 64" />
                        </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
        </div>
    </div>
    <div style="float: left; width: 960px;">
        <br />
    </div>
    <div style="width: 960px; float: left; padding-left: 5px;">
        <asp:Chart ID="Chart2" runat="server" Height="320px" Width="950px" BorderlineColor="#C0C0C0" BorderlineDashStyle="Solid">
            <Titles>
                <asp:Title ShadowColor="White" Font="Trebuchet MS, 14.25pt, style=Bold" Text="雅莹安全隐患处理" Name="Title1" ForeColor="26, 59, 105">
                </asp:Title>
            </Titles>
            <Legends>
                <asp:Legend LegendStyle="Row" IsTextAutoFit="False" BorderWidth="0" BorderColor="Black" Docking="Top" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold">
                </asp:Legend>
            </Legends>
            <Series>
                <asp:Series IsValueShownAsLabel="True" LegendText="全部" BorderWidth="3" ChartArea="ChartArea1" Name="Default1" ChartType="Line" MarkerStyle="Circle" BorderColor="180, 26, 59, 105" ShadowOffset="1" Font="Trebuchet MS, 8.25pt, style=Bold">
                </asp:Series>
                <asp:Series IsValueShownAsLabel="True" LegendText="已处理" BorderWidth="3" ChartArea="ChartArea1" Name="Default2" ChartType="Line" MarkerStyle="Circle" BorderColor="180, 26, 59, 105" ShadowOffset="1" Font="Trebuchet MS, 8.25pt, style=Bold">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White" BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                    <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False" WallWidth="0" IsClustered="False" />
                    <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
                        <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisY>
                    <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
                        <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                        <MajorGrid LineColor="64, 64, 64, 64" />
                    </AxisX>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
    </div>
</asp:Content>
