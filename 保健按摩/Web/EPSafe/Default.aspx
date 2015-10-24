<%@ Page Title="安全管理平台" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" ValidateRequest="false"
    AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EPReper.Web.EPSafe.Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="style/Css/base.min.css">
    <link id="templateFrame" rel="stylesheet" type="text/css" href="style/Css/332.min.css">
    <script type="text/javascript" src="style/Script/jquery-1.6.4.min.js"></script>
    <script type="text/javascript" src="style/Script/fai.min.js"></script>
    <script type="text/javascript" src="style/Script/jquery.imageSwitch.js"></script>
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            $("#tagContent0").show();
        });
        function selectTag(showContent, selfObj) {
            // 标签
            var tag = document.getElementById("tags").getElementsByTagName("li");
            var taglength = tag.length;
            for (i = 0; i < taglength; i++) {
                tag[i].className = "";
            }
            selfObj.parentNode.className = "selectTag";
            // 标签内容
            for (i = 0; j = document.getElementById("tagContent" + i); i++) {
                j.style.display = "none";
            }
            document.getElementById(showContent).style.display = "block";
        }


        function Trim(str) { return str.replace(/(^\s*)|(\s*$)/g, ""); }
        function CheckNull() {
            var v_ctitle = document.getElementById("<%= TextArea1.ClientID%>").value;
            if (Trim(v_ctitle).length <= 0) {
                alert('建议内容不能为空！');
                return false;
            }
        }



        $(".newsList .line").mouseover(function () {
            $(this).addClass("g_hover");
        }).mouseout(function () {
            $(this).removeClass("g_hover");
        });

        $(".productFilterValue ").mouseover(function () {
            $(this).addClass("g_selected");
        }).mouseout(function () {
            $(this).removeClass("g_selected");
        });

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
        
        
        
        .hover
        {
            background-color: #97B4E0;
            border: 1px solid #0087ce;
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
    <%--<div style="width: 960px; float: left;">--%>
    <div style="width: 960px; height: 30px; float: left; font-size: 15px; font-weight: 700;
        color: #0087ce;">
        <div id="MainDiv" style="float: left; width: 760px; margin-top: 5px; margin-bottom: 5px;">
            <a href="Default.aspx">安全管理主页</a>
        </div>
        <div id="admins" visible="false" runat="server" style="float: left; width: 180px;
            margin-top: 5px; margin-bottom: 5px; text-align: right;">
            <a href="SafeAdmin.aspx">管理员</a>
        </div>
    </div>
    <table cellspacing="0" cellpadding="0" class="webContainerTable">
        <%-- class="webContainerTable" --%>
        <tr>
            <td align="middle">
                <div id="webContainer" class="webContainer">
                    <div id="container" class="container">
                        <table cellspacing="0" cellpadding="0" class="containerFormsMiddle">
                            <%-- class="containerFormsMiddle"--%>
                            <tbody>
                                <tr>
                                    <td valign="top" id="containerFormsLeft" class="containerFormsLeft">
                                        <%-- id="containerFormsLeft" class="containerFormsLeft"--%>
                                        <div id="leftForms" class="column sideForms leftForms">
                                            <div class="form">
                                                <table class="formBanner" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="center" valign="top">
                                                                <table class="formBannerTitle" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="titleLeft" valign="top">
                                                                            </td>
                                                                            <td class="titleCenter" valign="top">
                                                                                <div class="titleText">
                                                                                    频道首页
                                                                                </div>
                                                                            </td>
                                                                            <td class="titleRight titleRight304" valign="top">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="formMiddle" cellspacing="0" cellpadding="0" style="height: 150px">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleLeft">
                                                            </td>
                                                            <td class="formMiddleCenter" valign="top" style="font-size: 10.75pt">
                                                                <div class="formMiddleContent">
                                                                    <div class="productFilter productFilterVert">
                                                                        <table class="productFilterContent" cellspacing="0" cellpadding="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td class="productFilterContentLeft">
                                                                                    </td>
                                                                                    <td class="productFilterContentCenter">
                                                                                        <table class="productFilterValue" cellspacing="0" cellpadding="0">
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td class="productFilterValueLeft">
                                                                                                    </td>
                                                                                                    <ul style="text-align: center">
                                                                                                        <div onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''"
                                                                                                            style='width: 100%;' bgcolor=''>
                                                                                                            <a style="text-decoration: none;" href="SafeNew.aspx">安全新闻</a></div>
                                                                                                        <div onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''"
                                                                                                            style='width: 100%;' bgcolor=''>
                                                                                                            <a href="SafeWork.aspx">安全工作</a></div>
                                                                                                        <div onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''"
                                                                                                            style='width: 100%;' bgcolor=''>
                                                                                                            <a style="text-decoration: none;" href="SafePublic.aspx">安全信息</a></div>
                                                                                                        <div onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''"
                                                                                                            style='width: 100%;' bgcolor=''>
                                                                                                            <a style="text-decoration: none;" href="SafeDu.aspx">安全责任</a></div>
                                                                                                    </ul>
                                                                                                    <td class="productFilterValueRight">
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </td>
                                                                                    <td class="productFilterContentRight">
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="formMiddleRight formMiddleRight304">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat">
                                                </div>
                                            </div>
                                            <div class="form">
                                                <table class="formBanner" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="center" valign="top">
                                                                <table class="formBannerTitle" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="titleLeft" valign="top">
                                                                            </td>
                                                                            <td class="titleCenter" valign="top">
                                                                                <div class="titleText">
                                                                                    安全热点专题</div>
                                                                            </td>
                                                                            <td class="titleRight titleRight304" valign="top">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="formMiddle" cellspacing="0" cellpadding="0" style="height: 170px">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleLeft">
                                                            </td>
                                                            <td class="formMiddleCenter" valign="top" style="font-size: 9.75pt">
                                                                <div class="formMiddleContent">
                                                                    <div class="productFilter productFilterVert">
                                                                        <table class="productFilterContent" cellspacing="0" cellpadding="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td class="productFilterContentLeft">
                                                                                    </td>
                                                                                    <td class="productFilterContentCenter">
                                                                                        
                                                                                                    <asp:Repeater ID="RepeaterSafeZhuanTi" runat="server">
                                                                                                        <ItemTemplate>
                                                                                                            <div onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''">
                                                                                                              <%# Container.ItemIndex+1 %>.  <a href="ZhuanTiList.aspx?ZhuanName=<%# Eval("Fid").ToString() %>" title="<%# Eval("ZhuanName").ToString() %>"
                                                                                                                    target="_blank">
                                                                                                                    <%# Eval("ZhuanName").ToString().Length > 14 ? Eval("ZhuanName").ToString().Substring(0, 14) + "......" : Eval("ZhuanName")%>
                                                                                                                </a>
                                                                                                            </div>
                                                                                                        </ItemTemplate>
                                                                                                    </asp:Repeater>
                                                                                                    
                                                                                    </td>
                                                                                    <td class="productFilterContentRight">
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="formMiddleRight formMiddleRight304">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat">
                                                </div>
                                            </div>
                                            <div class="form">
                                                <table class="formBanner" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="center" valign="top">
                                                                <table class="formBannerTitle" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="titleLeft" valign="top">
                                                                            </td>
                                                                            <td class="titleCenter" valign="top">
                                                                                <div class="titleText">
                                                                                    安全书籍推荐</div>
                                                                            </td>
                                                                            <td class="titleRight titleRight304" valign="top">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="formMiddle" cellspacing="0" cellpadding="0" style="height: 150px">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleCenter" valign="top" style="font-size: 9.75pt">
                                                                <div class="formMiddleContent">
                                                                    <div class="productFilter productFilterVert">
                                                                        <table class="productFilterContent" cellspacing="0" cellpadding="0">
                                                                            <tbody>
                                                                                <tr>
                                                                                    <td class="productFilterContentCenter">
                                                                                        
                                                                                                        <asp:Repeater ID="RepeaterBook" runat="server">
                                                                                                            <ItemTemplate>
                                                                                                                <div onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''">
                                                                                                                   <%# Container.ItemIndex+1 %> . 
                                                                                                                    <a href="BookDetails.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("booktitle").ToString() %>"
                                                                                                                        target="_blank">
                                                                                                                        <%# Eval("booktitle").ToString().Length > 14 ? Eval("booktitle").ToString().Substring(0, 14) + "......" : Eval("booktitle")%>
                                                                                                                    </a>
                                                                                                                </div>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:Repeater>
                                                                                                    
                                                                                    </td>
                                                                                    <td class="productFilterContentRight">
                                                                                    </td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="formMiddleRight formMiddleRight304">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat">
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="containerFormsCenter" class="containerFormsCenter" valign="top">
                                        <div id="centerTopForms" class="column mainForms centerTopForms">
                                            <div class="form">
                                                <table class="formBanner" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="center" valign="top">
                                                                <table class="formBannerTitle" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="titleLeft" valign="top">
                                                                            </td>
                                                                            <td class="titleCenter" valign="top">
                                                                                <div class="titleText">
                                                                                    安全新闻</div>
                                                                            </td>
                                                                            <td class="titleRight" valign="top">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="formMiddle" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleLeft">
                                                            </td>
                                                            <td class="formMiddleCenter" valign="top">
                                                                <div class="imgdiv">
                                                                    <script type="text/javascript">
                                        var focus_width=250;
                                        var focus_height=230;
                                        var text_height=40;
                                        var swf_height = focus_height+text_height;
                                        var pics = <%= pics %>;
                                        var links = <%= links %>;
                                        var texts = <%= texts %>;
                                        document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ focus_width +'" height="'+ swf_height +'">');
                                        document.write('<param name="allowScriptaccess" value="sameDomain"><param name="wmode" value="transparent"><param name="movie" value="Flash/pixviewer.swf"><param name="quality" value="high"><param name="bgcolor" value=#000000>');
                                        document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
                                        document.write('<param name="FlashVars" value="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'">');
                                        document.write('<embed src="Flash/pixviewer.swf" wmode="opaque" FlashVars="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'" menu="false" bgcolor=#000000 quality="high" width="'+ focus_width +'" height="'+ swf_height +'" allowScriptaccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
                                        document.write('</object>');
                                                                    </script>
                                                                </div>
                                                                <div class="formMiddleContent">
                                                                    <div>
                                                                        <div class="newsList">
                                                                            <asp:Repeater ID="RpNewReplay" runat="server">
                                                                                <ItemTemplate>
                                                                                    <div onmouseover="this.style.backgroundColor='#CBD9EF'" onmouseout="this.style.backgroundColor=''"
                                                                                        class="newtitle">
                                                                                        ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>"
                                                                                            target="_blank">
                                                                                            <%# Eval("newstitle").ToString().Length > 14 ? Eval("newstitle").ToString().Substring(0, 14) + "......" : Eval("newstitle")%>
                                                                                        </a>
                                                                                    </div>
                                                                                    <div class="g_border separatorLine">
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                            <div class="clearfloat">
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="formMiddleRight formMiddleRight3">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat">
                                                </div>
                                            </div>
                                            <div class="form">
                                                <table class="formBanner" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="center" valign="top">
                                                                <table class="formBannerTitle" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="titleLeft" valign="top">
                                                                            </td>
                                                                            <td class="titleCenter" valign="top">
                                                                                <div class="titleText">
                                                                                    安全报表</div>
                                                                            </td>
                                                                            <td class="titleRight" valign="top">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="formMiddle" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleLeft">
                                                                &nbsp;
                                                            </td>
                                                            <td class="formMiddleCenter" valign="top">
                                                                <div style="width: 250px; float: left;" onmouseover="this.style.cursor='pointer'"
                                                                    onclick="window.open('SafeChartEP1.aspx');">
                                                                    <div class="formMiddleContent">
                                                                        <asp:Chart ID="Chart2" runat="server" Height="268px" Width="250px" BorderlineColor="#C0C0C0"
                                                                            OnClick="Chart2Click">
                                                                            <%--BorderlineDashStyle="Solid"--%>
                                                                            <Titles>
                                                                                <asp:Title ShadowColor="White" Font=" 9.25pt" Text="公司安全隐患处理情况" Name="Title1" ForeColor="26, 59, 105"
                                                                                    PostBackValue="#INDEX">
                                                                                </asp:Title>
                                                                            </Titles>
                                                                            <Legends>
                                                                                <asp:Legend LegendStyle="Row" IsTextAutoFit="False" BorderWidth="0" BorderColor="Black"
                                                                                    Docking="Top" Name="Default" BackColor="Transparent" Font="9.25pt">
                                                                                </asp:Legend>
                                                                            </Legends>
                                                                            <Series>
                                                                                <asp:Series IsValueShownAsLabel="True" LegendText="全部" BorderWidth="3" ChartArea="ChartArea1"
                                                                                    Name="Default1" ChartType="Line" MarkerStyle="Circle" BorderColor="180, 26, 59, 105"
                                                                                    ShadowOffset="1" Font="9.25pt">
                                                                                </asp:Series>
                                                                                <asp:Series IsValueShownAsLabel="True" LegendText="已处理" BorderWidth="3" ChartArea="ChartArea1"
                                                                                    Name="Default2" ChartType="Line" MarkerStyle="Circle" BorderColor="180, 26, 59, 105"
                                                                                    ShadowOffset="1" Font="9.25pt">
                                                                                </asp:Series>
                                                                            </Series>
                                                                            <ChartAreas>
                                                                                <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White"
                                                                                    BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                                                                    <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                                                        WallWidth="0" IsClustered="False" />
                                                                                    <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
                                                                                        <LabelStyle Font="9.25pt" />
                                                                                        <%--Trebuchet MS, 8--%>
                                                                                        <MajorGrid LineColor="64, 64, 64, 64" />
                                                                                    </AxisY>
                                                                                    <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
                                                                                        <LabelStyle Font="9.25pt" />
                                                                                        <MajorGrid LineColor="64, 64, 64, 64" />
                                                                                    </AxisX>
                                                                                </asp:ChartArea>
                                                                            </ChartAreas>
                                                                        </asp:Chart>
                                                                    </div>
                                                                </div>
                                                                <div style="float: left; width: 255px;">
                                                                    <div onmouseover="this.style.cursor='pointer'" onclick="window.open('SafeChartEP.aspx');"
                                                                        style="margin: auto; float: left; width: 250px; padding-left: 5px;">
                                                                        <div class="formMiddleContent">
                                                                            <div>
                                                                                <asp:Chart ID="Chart1" runat="server" Height="268px" Width="250px" BorderlineColor="#C0C0C0"
                                                                                    OnClick="Chart1Click">
                                                                                    <%-- BorderlineDashStyle="Solid" --%>
                                                                                    <Titles>
                                                                                        <asp:Title ShadowColor="White" Font="8.25pt " Text="部门安全隐患处理情况" Name="Title1" ForeColor="26, 59, 105"
                                                                                            PostBackValue="#INDEX">
                                                                                        </asp:Title>
                                                                                    </Titles>
                                                                                    <Legends>
                                                                                        <asp:Legend LegendStyle="Row" IsTextAutoFit="False" BorderWidth="0" BorderColor="Black"
                                                                                            Docking="Top" Name="Default" BackColor="Transparent" Font="9.25pt">
                                                                                        </asp:Legend>
                                                                                    </Legends>
                                                                                    <Series>
                                                                                        <asp:Series XValueType="String" LegendText="全部" IsValueShownAsLabel="true" Name="Series1"
                                                                                            BorderColor="180, 26, 59, 105">
                                                                                        </asp:Series>
                                                                                        <asp:Series XValueType="String" LegendText="已处理" IsValueShownAsLabel="true" Name="Series2"
                                                                                            BorderColor="180, 26, 59, 105">
                                                                                        </asp:Series>
                                                                                    </Series>
                                                                                    <ChartAreas>
                                                                                        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BackSecondaryColor="White"
                                                                                            BackColor="OldLace" ShadowColor="Transparent" BackGradientStyle="TopBottom">
                                                                                            <Area3DStyle Rotation="10" Perspective="10" Inclination="15" IsRightAngleAxes="False"
                                                                                                WallWidth="0" IsClustered="False" />
                                                                                            <AxisY LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                                                                                                <LabelStyle Font="Trebuchet MS, 8.25pt" />
                                                                                                <MajorGrid LineColor="64, 64, 64, 64" />
                                                                                            </AxisY>
                                                                                            <AxisX LineColor="64, 64, 64, 64" LabelAutoFitMaxFontSize="8">
                                                                                                <LabelStyle Font="Trebuchet MS, 8.25pt" IsEndLabelVisible="False" />
                                                                                                <MajorGrid LineColor="64, 64, 64, 64" />
                                                                                            </AxisX>
                                                                                        </asp:ChartArea>
                                                                                    </ChartAreas>
                                                                                </asp:Chart>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="form">
                                                <table class="formMiddle" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleLeft">
                                                            </td>
                                                            <td class="formMiddleCenter" valign="top">
                                                                <div class="formMiddleContent">
                                                                    <div class="productMarqueeForms">
                                                                        <div class="demo0">
                                                                            <div class="productMarqueeForm">
                                                                                <div class="imgDiv" onmouseover="this.style.cursor='pointer'" onclick="window.open('SafeRewRes.aspx');">
                                                                                    <%-- <div style="text-align: left; border: 1px solid #C0C0C0; width: 250px; height: 250px;"></div>--%>
                                                                                    <div onmouseover="this.style.backgroundColor='#CBD9EF'" onmouseout="this.style.backgroundColor=''"
                                                                                        style="text-align: center; font-weight: bold; padding-top: 5px;">
                                                                                        年度安全工作排名
                                                                                    </div>
                                                                                    <table style="width: 250px;">
                                                                                        <tr style="text-align: left;">
                                                                                            <th width="60px" style="text-align: center;">
                                                                                                排名
                                                                                            </th>
                                                                                            <th width="100px" style="text-align: center;">
                                                                                                部门
                                                                                            </th>
                                                                                            <th width="90px" style="text-align: center;">
                                                                                                奖惩总额
                                                                                            </th>
                                                                                        </tr>
                                                                                        <asp:Repeater ID="Repeater1" runat="server">
                                                                                            <ItemTemplate>
                                                                                                <tr>
                                                                                                    <td style="text-align: center;">
                                                                                                        <%# Container.ItemIndex+1 %>
                                                                                                    </td>
                                                                                                    <td style="text-align: center;">
                                                                                                        <%# Eval("Dept").ToString()%>
                                                                                                    </td>
                                                                                                    <td style="text-align: center;">
                                                                                                        <%# Eval("sumreward").ToString()%>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </ItemTemplate>
                                                                                        </asp:Repeater>
                                                                                    </table>
                                                                                </div>
                                                                            </div>
                                                                            <div class="productMarqueeForm">
                                                                                <div id="m303marqueeProduct19" class="imgDiv" onmouseover="this.style.cursor='pointer'"
                                                                                    onclick="window.open('SafeResMon.aspx');">
                                                                                    <div onmouseover="this.style.backgroundColor='#CBD9EF'" onmouseout="this.style.backgroundColor=''"
                                                                                        style="text-align: center; font-weight: bold; padding-top: 5px;">
                                                                                        月度安全隐患排名
                                                                                    </div>
                                                                                    <table style="width: 250px;">
                                                                                        <tr style="text-align: left;">
                                                                                            <th width="60px" style="text-align: center;">
                                                                                                排名
                                                                                            </th>
                                                                                            <th width="100px" style="text-align: center;">
                                                                                                部门
                                                                                            </th>
                                                                                            <th width="90px" style="text-align: center;">
                                                                                                隐患数量
                                                                                            </th>
                                                                                        </tr>
                                                                                        <asp:Repeater ID="Repeater2" runat="server">
                                                                                            <ItemTemplate>
                                                                                                <tr onmouseover="this.style.backgroundColor='#CBD9EF'" onmouseout="this.style.backgroundColor=''">
                                                                                                    <td style="text-align: center;">
                                                                                                        <%# Container.ItemIndex+1 %>
                                                                                                    </td>
                                                                                                    <td style="text-align: center;">
                                                                                                        <%# Eval("Dept").ToString()%>
                                                                                                    </td>
                                                                                                    <td style="text-align: center;">
                                                                                                        <%# Eval("counters").ToString()%>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </ItemTemplate>
                                                                                        </asp:Repeater>
                                                                                    </table>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="formMiddleRight formMiddleRight303">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat">
                                                </div>
                                            </div>
                                            <div class="form">
                                                <table class="formBanner" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="left">
                                                            </td>
                                                            <td class="center" valign="top">
                                                                <table class="formBannerTitle" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="titleLeft" valign="top">
                                                                            </td>
                                                                            <td class="titleCenter" valign="top">
                                                                                <div class="titleText">
                                                                                    每日安全隐患处理情况</div>
                                                                            </td>
                                                                            <td class="titleRight" valign="top">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                            <td class="right">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="formMiddle" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleLeft">
                                                            </td>
                                                            <td class="formMiddleCenter" valign="top">
                                                                <div class="formMiddleContent">
                                                                    <div class="productMarqueeForms">
                                                                        <div class="demo0">
                                                                            <div class="productMarqueeForm">
                                                                                <asp:Repeater ID="RepeaterPubGG" runat="server">
                                                                                    <HeaderTemplate>
                                                                                        <table class="Tmain2">
                                                                                            <tr onmouseover="this.style.backgroundColor='#CBD9EF'" onmouseout="this.style.backgroundColor=''">
                                                                                                <th style="width: 30px;">
                                                                                                    序号
                                                                                                </th>
                                                                                                <th style="width: 120px;">
                                                                                                    部门
                                                                                                </th>
                                                                                                <th style="width: 120px;">
                                                                                                    隐患
                                                                                                </th>
                                                                                                <th style="width: 120px;">
                                                                                                    责任人
                                                                                                </th>
                                                                                                <th style="width: 120px;">
                                                                                                    时间
                                                                                                </th>
                                                                                            </tr>
                                                                                    </HeaderTemplate>
                                                                                    <ItemTemplate>
                                                                                        <tr>
                                                                                            <td style="width: 50px;">
                                                                                                <%# Container.ItemIndex+1 %>
                                                                                            </td>
                                                                                            <td style="width: 60px;">
                                                                                                <%# Eval("Dept").ToString()%>
                                                                                            </td>
                                                                                            <td style="width: 80px;">
                                                                                                <%# Eval("PitContents").ToString().Length > 12 ? Eval("PitContents").ToString().Substring(0, 12) + "..." : Eval("PitContents")%>
                                                                                            </td>
                                                                                            <td style="width: 60px;">
                                                                                                <%# Eval("Person").ToString() %>
                                                                                            </td>
                                                                                            <td>
                                                                                                <%# Convert.ToDateTime(Eval("Time")).ToString("yyyy-MM-dd")%>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </ItemTemplate>
                                                                                    <FooterTemplate>
                                                                                        </table>
                                                                                        <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# RepeaterPubGG.Items.Count==0 %>'></asp:Label>
                                                                                    </FooterTemplate>
                                                                                </asp:Repeater>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="formMiddleRight formMiddleRight303">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat">
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td id="containerFormsRight" class="containerFormsRight" valign="top">
                                        <div id="rightForms" class="column sideForms rightForms">
                                            <div class="form">
                                                <table class="formBanner" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="center" valign="top">
                                                                <table class="formBannerTitle" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="titleLeft " valign="top">
                                                                            </td>
                                                                            <td class="titleCenter " valign="top">
                                                                                <div class="titleText ">
                                                                                    安全重点工作</div>
                                                                            </td>
                                                                            <td class="titleRight " valign="top">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                                <div class="formBannerOther ">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="formMiddle" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleCenter" valign="top">
                                                                <table class="webBannerTable" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="formMiddleCenter" valign="top" style="font-size: 9.75pt">
                                                                                <div class="formMiddleContent">
                                                                                    <div class="productFilter productFilterVert">
                                                                                        <table class="productFilterContent" cellspacing="0" cellpadding="0">
                                                                                            <tbody>
                                                                                                <tr>
                                                                                                    <td class="productFilterContentCenter">
                                                                                                        
                                                                                                                       <asp:Repeater ID="RepeaterSafeWork" runat="server">
                                                                                        <ItemTemplate>
                                                                                            <div class="formMiddleContent">
                                                                                                <div style="text-align: center; width: 180px;">
                                                                                                    <div style="text-align: left;" onmouseover="this.style.backgroundColor='#97B4E0'"
                                                                                                        onmouseout="this.style.backgroundColor=''">
                                                                                                        <%# Container.ItemIndex+1 %>. <a href="Details.aspx?fid=<%# Eval("fid").ToString() %>"
                                                                                                            title="<%# Eval("newstitle").ToString() %>" target="_blank">
                                                                                                            <%# Eval("newstitle").ToString().Length > 16 ? Eval("newstitle").ToString().Substring(0, 16) + "......" : Eval("newstitle")%>
                                                                                                        </a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:Repeater>
                                                                                                             
                                                                                                    </td>
                                                                                                    <td class="productFilterContentRight">
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </tbody>
                                                                                        </table>
                                                                                    </div>
                                                                                </div>
                                                                            </td>
                                                                         <%--   <td align="middle">
                                                                                <div class="NewsContent1" style="font-size: 9.25pt; height: 150px; border: 0">
                                                                                    <asp:Repeater ID="RepeaterSafeWork" runat="server">
                                                                                        <ItemTemplate>
                                                                                            <div class="formMiddleContent">
                                                                                                <div style="text-align: center; width: 180px;">
                                                                                                    <div style="text-align: left;" onmouseover="this.style.backgroundColor='#97B4E0'"
                                                                                                        onmouseout="this.style.backgroundColor=''">
                                                                                                        <%# Container.ItemIndex+1 %>. <a href="Details.aspx?fid=<%# Eval("fid").ToString() %>"
                                                                                                            title="<%# Eval("newstitle").ToString() %>" target="_blank">
                                                                                                            <%# Eval("newstitle").ToString().Length > 16 ? Eval("newstitle").ToString().Substring(0, 16) + "......" : Eval("newstitle")%>
                                                                                                        </a>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </ItemTemplate>
                                                                                    </asp:Repeater>
                                                                                </div>
                                                                                <div class="tpdesc">
                                                                                </div>
                                                                            </td>--%>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat clearfloat2">
                                                </div>
                                            </div>
                                            <div class="form" style="height: 180px">
                                                <table class="formMiddle" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleCenter" valign="top">
                                                                <table class="webBannerTable" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td align="middle">
                                                                                <div id="con">
                                                                                    <ul id="tags">
                                                                                        <li class="selectTag"><a onmouseover="selectTag('tagContent0',this)" href="javascript:void(0)">
                                                                                            <b>公告</b></a> </li>
                                                                                        <li><a onmouseover="selectTag('tagContent1',this)" href="javascript:void(0)"><b>规章制度</b></a>
                                                                                        </li>
                                                                                        <li><a onmouseover="selectTag('tagContent2',this)" href="javascript:void(0)"><b>会议纪要</b></a>
                                                                                        </li>
                                                                                        <li><a onmouseover="selectTag('tagContent3',this)" href="javascript:void(0)"><b>安全知识</b></a>
                                                                                        </li>
                                                                                    </ul>
                                                                                    <div id="tagContent">
                                                                                        <div class="tagContent" id="tagContent0">
                                                                                            <asp:Repeater ID="RepeaterSafeGG" runat="server">
                                                                                                <ItemTemplate>
                                                                                                    <div class="newtitle" onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''">
                                                                                                        ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>"
                                                                                                            target="_blank">
                                                                                                            <%# Eval("newstitle").ToString().Length > 16 ? Eval("newstitle").ToString().Substring(0, 16) + "......" : Eval("newstitle")%>
                                                                                                        </a>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:Repeater>
                                                                                        </div>
                                                                                        <div class="tagContent" id="tagContent1">
                                                                                            <asp:Repeater ID="RepeaterSafeZD" runat="server">
                                                                                                <ItemTemplate>
                                                                                                    <div class="newtitle" onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''">
                                                                                                        ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>"
                                                                                                            target="_blank">
                                                                                                            <%# Eval("newstitle").ToString().Length > 16 ? Eval("newstitle").ToString().Substring(0, 16) + "......" : Eval("newstitle")%>
                                                                                                        </a>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:Repeater>
                                                                                        </div>
                                                                                        <div class="tagContent" id="tagContent2">
                                                                                            <asp:Repeater ID="RepeaterSafeJY" runat="server">
                                                                                                <ItemTemplate>
                                                                                                    <div class="newtitle" onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''">
                                                                                                        ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>"
                                                                                                            target="_blank">
                                                                                                            <%# Eval("newstitle").ToString().Length > 16 ? Eval("newstitle").ToString().Substring(0, 16) + "......" : Eval("newstitle")%>
                                                                                                        </a>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:Repeater>
                                                                                        </div>
                                                                                        <div class="tagContent" id="tagContent3">
                                                                                            <asp:Repeater ID="RepeaterSafeZS" runat="server">
                                                                                                <ItemTemplate>
                                                                                                    <div class="newtitle" onmouseover="this.style.backgroundColor='#97B4E0'" onmouseout="this.style.backgroundColor=''">
                                                                                                        ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>"
                                                                                                            target="_blank">
                                                                                                            <%# Eval("newstitle").ToString().Length > 16 ? Eval("newstitle").ToString().Substring(0, 16) + "......" : Eval("newstitle")%>
                                                                                                        </a>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </asp:Repeater>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="tpdesc">
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat clearfloat2">
                                                </div>
                                            </div>
                                            <div class="form">
                                                <table class="formBanner" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="center" valign="top">
                                                                <table class="formBannerTitle" cellspacing="0" cellpadding="0">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="titleLeft " valign="top">
                                                                            </td>
                                                                            <td class="titleCenter " valign="top">
                                                                                <div class="titleText ">
                                                                                    安全投诉、建议采纳</div>
                                                                            </td>
                                                                            <td class="titleRight " valign="top">
                                                                            </td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <table class="formMiddle" cellspacing="0" cellpadding="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="formMiddleLeft">
                                                            </td>
                                                            <td class="formMiddleCenter" valign="top">
                                                                <div class="formMiddleContent">
                                                                    <div class="productMarqueeForms">
                                                                        <div class="demo" style="height: 260px">
                                                                            <div class="productMarqueeForm" faiheight="100" faiwidth="160" style="height: 125px;">
                                                                                <div id="m2marqueeProduct22">
                                                                                    <table>
                                                                                        <tbody>
                                                                                            <tr style="font-weight: bold" onmouseover="this.style.backgroundColor='#97B4E0'"
                                                                                                onmouseout="this.style.backgroundColor=''">
                                                                                                <td width="80px" style="text-align: center;">
                                                                                                    建议
                                                                                                </td>
                                                                                                <td width="70px">
                                                                                                    建议人
                                                                                                </td>
                                                                                                <td width="70px" style="text-align: center;">
                                                                                                    时间
                                                                                                </td>
                                                                                            </tr>
                                                                                            <div class="imgDiv">
                                                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                                                    <ContentTemplate>
                                                                                                        <asp:Repeater ID="RepeaterSafeSug" runat="server">
                                                                                                            <ItemTemplate>
                                                                                                                <tr>
                                                                                                                    <td width="80px" style="text-align: center;">
                                                                                                                        <a title="<%# Eval("sugcontent").ToString() %>">
                                                                                                                            <%# Eval("sugcontent").ToString().Length > 10 ? Eval("sugcontent").ToString().Substring(0, 9) + "......" : Eval("sugcontent")%>
                                                                                                                        </a>
                                                                                                                    </td>
                                                                                                                    <td style="text-align: center;">
                                                                                                                        <%# Eval("createperson").ToString()%>
                                                                                                                    </td>
                                                                                                                    <td width="70px" style="text-align: center;">
                                                                                                                        <%# DateTime.Parse(Eval("createtime").ToString()).ToShortDateString()%>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </ItemTemplate>
                                                                                                        </asp:Repeater>
                                                                                                    </ContentTemplate>
                                                                                                </asp:UpdatePanel>
                                                                                            </div>
                                                                                        </tbody>
                                                                                    </table>
                                                                                </div>
                                                                                <br />
                                                                                <br />
                                                                                <%-- <div class="propDiv productName">
                                                                                    我要建议
                                                                                </div>--%>
                                                                            </div>
                                                                            <div style="height: 120px;">
                                                                                <div style="margin: 0px auto; text-align: center;">
                                                                                    <textarea id="TextArea1" rows="4" cols="20" runat="server" style="width: auto; height: 102px;"></textarea>
                                                                                </div>
                                                                                <div style="margin: 0px auto; margin-bottom: 1px; text-align: center;">
                                                                                    <asp:Button ID="Button1" runat="server" Text="提交建议" OnClientClick="return CheckNull();"
                                                                                        OnClick="AddSug" />
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="formMiddleRight formMiddleRight2">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                                <div class="clearfloat clearfloat2">
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tbody>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>
