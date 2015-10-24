<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="SafeChartEP1.aspx.cs" Inherits="EPReper.Web.EPSafe.SafeChartEP1" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        $.fx.speeds._default = 500;
        $(function () {
            $("#dialog").dialog({
                autoOpen: false,
                show: "blind",
                hide: "blind",
                height: 450,
                width: 600,
                resizable: false
            });


        });

        $(document).ready(function () {
            $(".usualtb tbody tr:odd").addClass("odd");
            $(".usualtb tbody tr:even").addClass("even");
        });

        function openmessage(id) {
            $("#dialog").dialog("open");

            $.getJSON("GetSafeRes.ashx?Type=SafeRes&method=openMessageByAJAX&timestamp=" + (+new Date()) + "&fid=" + id, function (data) {


                $("#labelperson").empty().append(data.Person);
                var date = data.Time.substring(0, 11);
                $("#labeltime").empty().append(date);
                $("#labeldept").empty().append(data.Dept);
                $("#TextAreaArea").empty().append(data.Area);
                $("#TextAreaContents").empty().append(data.PitContents);
                $("#TextAreaSuggestion").empty().append(data.PitSuggestion);
                $("#TextAreaResult").empty().append(data.PitResult);

            });
        }

    </script>
    <style type="text/css">
        #TextArea1
        {
            text-align: left;
            height: 87px;
            width: 241px;
        }
        .style1
        {
            font-size: 16px;
        }
        #TextAreaArea
        {
            height: 87px;
            width: 411px;
        }
        #TextAreaContents
        {
            height: 75px;
            width: 411px;
        }
        #TextAreaSuggestion
        {
            height: 63px;
            width: 411px;
        }
        
        #TextAreaResult
        {
            height: 97px;
            width: 411px;
        }
        .style2
        {
            width: 202px;
        }
        .style3
        {
            width: 160px;
        }
        .style4
        {
            width: 174px;
        }
        
        
        #div1:hover
        {
            border: 1px solid #0087ce;
            background-color: #F1F1F1;
        }
    </style>
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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="float: left; width: 960px;">
                <%--    <div class="NewsTab1">
                    <span style="color: #0087ce;"><a href="#"></a>雅莹安全隐患每日情况(列表、事件) </span>
                </div>--%>
                <div style="margin: auto; float: left; width: 960px;">
                    <asp:Chart ID="Chart1" runat="server" Height="320px" Width="960px" BorderlineColor="#C0C0C0" BorderlineDashStyle="Solid" >
                        <Titles>
                            <asp:Title ShadowColor="White" Font="Trebuchet MS, 14.25pt, style=Bold" Text="雅莹安全隐患情况(列表、事件)" Name="Title1" ForeColor="26, 59, 105">
                            </asp:Title>
                        </Titles>
                        <Legends>
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
                                <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="false">
                                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
                                    <MajorGrid LineColor="64, 64, 64, 64" />
                                </AxisY>
                                <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="false">
                                    <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" IsEndLabelVisible="False" />
                                    <MajorGrid LineColor="64, 64, 64, 64" />
                                </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </div>


               <div style="width: 960px; float: left; padding-left: 5px;">
                <asp:Chart ID="Chart2" runat="server" Height="320px" Width="950px" BorderlineColor="#C0C0C0" BorderlineDashStyle="Solid"  OnClick="ImgeMap_Click">
                    <Titles>
                        <asp:Title ShadowColor="White" Font="Trebuchet MS, 14.25pt, style=Bold" Text="雅莹安全隐患处理" Name="Title1" ForeColor="26, 59, 105">
                        </asp:Title>
                    </Titles>
                    <Legends>
                        <asp:Legend LegendStyle="Row" IsTextAutoFit="False" BorderWidth="0" BorderColor="Black" Docking="Top" Name="Default" BackColor="Transparent" Font="Trebuchet MS, 8.25pt, style=Bold">
                        </asp:Legend>
                    </Legends>
                    <Series>
                        <asp:Series IsValueShownAsLabel="True" LegendText="全部" BorderWidth="3" ChartArea="ChartArea1" Name="Default1" ChartType="Line" MarkerStyle="Circle" BorderColor="180, 26, 59, 105" ShadowOffset="1" Font="Trebuchet MS, 13pt, style=Bold">
                        </asp:Series>
                        <asp:Series IsValueShownAsLabel="True" LegendText="已处理" BorderWidth="3" ChartArea="ChartArea1" Name="Default2" ChartType="Line" MarkerStyle="Circle" BorderColor="180, 26, 59, 105" ShadowOffset="1" Font="Trebuchet MS, 13pt, style=Bold">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White" BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False" WallWidth="0" IsClustered="False" />
                            <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
                                <LabelStyle Font="Trebuchet MS, 10.25pt, style=Bold" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisY>
                            <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
                                <LabelStyle Font="Trebuchet MS, 10.25pt, style=Bold" />
                                <MajorGrid LineColor="64, 64, 64, 64" />
                            </AxisX>
                        </asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
            </div>
            </div>
            <br />
            <br />
            <br />
            <b>
                <asp:Label ID="lbusername" runat="server" Text="请单击部门，查看部门安全隐患纪录"></asp:Label></b>
            <asp:Repeater ID="RepeaterPubGG" runat="server">
                <HeaderTemplate>
                    <table class="Tmain1" style="width: 960px;">
                        <tr>
                            <th style="width: 50px;">
                                序号
                            </th>
                            <th>
                                区域
                            </th>
                            <th>
                                部门
                            </th>
                            <th style="width: 60px;">
                                责任人
                            </th>
                            <th>
                                时间
                            </th>
                            <th style="width: 200px;">
                                隐患
                            </th>
                            <th>
                                处理意见
                            </th>
                            <th>
                                处理结果
                            </th>
                            <th>
                                操作
                            </th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td style="width: 50px;">
                            <%# Eval("fid").ToString() %>
                        </td>
                        <td>
                            <%# Eval("Area").ToString().Length > 12 ? Eval("Area").ToString().Substring(0, 12) + "..." : Eval("Area")%>
                        </td>
                        <td>
                            <%# Eval("Dept").ToString()%>
                        </td>
                        <td style="width: 60px;">
                            <%# Eval("Person").ToString() %>
                        </td>
                        <td>
                            <%# Convert.ToDateTime(Eval("Time")).ToString("yyyy-MM-dd")%>
                        </td>
                        <td id="<%# Eval("fid").ToString() %>PitContents" style="width: 200px;">
                            <%# Eval("PitContents").ToString().Length > 12 ? Eval("PitContents").ToString().Substring(0, 12) + "..." : Eval("PitContents")%>
                        </td>
                        <td id="<%# Eval("fid").ToString() %>PitSuggestion">
                            <%# Eval("PitSuggestion").ToString().Length > 12 ? Eval("PitSuggestion").ToString().Substring(0, 12) + "..." : Eval("PitSuggestion")%>
                        </td>
                        <td id="<%# Eval("fid").ToString() %>PitResult">
                            <%# Eval("PitResult").ToString().Length > 12 ? Eval("PitResult").ToString().Substring(0, 12) + "..." : Eval("PitResult")%>
                        </td>
                        <td>
                            <a id="<%# Eval("fid").ToString() %>" href="javascript:;" onclick="openmessage('<%# Eval("fid").ToString()%>')">读取</a>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                    <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# RepeaterPubGG.Items.Count==0 %>'></asp:Label>
                </FooterTemplate>
            </asp:Repeater>
            <br />
            <div style="text-align: right;">
                <webdiyer:AspNetPager ID="Pager" CssClass="paginator" CurrentPageButtonClass="cpb" runat="server" ScrollBars="None" CurrentPageButtonPosition="Center" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" NextPageText="下一页" OnPageChanged="AspNetPager1_PageChanged" PagingButtonSpacing="3px" PrevPageText="上一页" ShowMoreButtons="False" ShowPageIndexBox="Never" PageSize="20">
                </webdiyer:AspNetPager>
            </div>
          
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="demo">
        <div id="dialog" title="安全隐患">
            <table style="width: 547px;">
                <tr>
                    <td class="style4">
                        部门：<label style="background-color: White;" id="labeldept"></label>
                    </td>
                    <td class="style3">
                        负责人：<label style="background-color: White;" id="labelperson"></label>
                    </td>
                    <td class="style1">
                        时间：<label style="background-color: White;" id="labeltime"></label>
                    </td>
                </tr>
            </table>
            <table style="width: 547px;">
                <tr>
                    <td>
                        区域
                    </td>
                    <td class="style2" colspan="2">
                        <textarea id="TextAreaArea" readonly="readonly" name="S1"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        安全隐患：
                    </td>
                    <td colspan="2">
                        <textarea id="TextAreaContents" readonly="readonly"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        处理建议：
                    </td>
                    <td colspan="2">
                        <textarea id="TextAreaSuggestion" readonly="readonly"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        处理结果：
                    </td>
                    <td colspan="2">
                        <textarea id="TextAreaResult" readonly="readonly"></textarea>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
