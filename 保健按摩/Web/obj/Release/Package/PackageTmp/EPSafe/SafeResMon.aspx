<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true"
    CodeBehind="SafeResMon.aspx.cs" Inherits="EPReper.Web.EPSafe.SafeResMon"  EnableEventValidation="false" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $.fx.speeds._default = 500;
        $(function () {
            $("#dialog").dialog({
                autoOpen: false,
                show: "blind",
                hide: "blind",
                height: 630,
                width: 700,
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

                $("#TextArea4").empty().append(data.Area);
                $("#labelperson").empty().append(data.Person);
                $("#labeltime").empty().append(data.Time);
                $("#TextAreayh").empty().append(data.PitContents);
                //  $("#labelpic").empty().append("<img alt='' src='" + data.picurl+ "' />" );
                $("#TextArea2").empty().append(data.PitSuggestion);
                $("#TextArea3").empty().append(data.PitResult);

            });
        }
		
    </script>
    <style type="text/css">
        #TextAreayh
        {
            height: 270px;
            width: 530px;
        }
        #TextArea2
        {
            height: 75px;
            width: 530px;
        }
        #TextArea3
        {
            height: 63px;
            width: 530px;
        }
        .style1
        {
            width: 220px;
        }
        .style2
        {
        }
        #TextArea4
        {
            height: 97px;
            width: 530px;
        }
        #demo
        {
             height: 800px;
            width: 700px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 30px; float: left; font-size: 15px; font-weight: 700;
            color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 735px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>->安全责任
            </div>
        </div>
        <div style="float: left; width: 120px;">
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全责任</span>
            </div>
            <div class="NewsMapContent1" style="border: 1px solid #D4D4D4;">
                <ul id="SateUl" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeResMon.aspx">月度隐患数排名</a></li>
                    <li><a href="SafeRes.aspx">安全隐患</a></li>
                    <li><a href="SafeDu.aspx">安全责任</a></li>
                    <li><a href="SafeRew.aspx">安全奖励</a></li>
                    <li><a href="SafeRewRes.aspx">安全奖惩</a></li>
                </ul>
            </div>
        </div>
        <div style="float: left; width: 840px;">
            <div class="NewsTab3" style="width: auto;" id="lableType" runat="server">
                <span style="color: #0087ce;">月度安全隐患排名</span>
            </div>
            <div style="margin: auto; width: auto;">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div style="border: 1px solid #C0C0C0; padding: 5px; width: 822px; margin: 2px; float: left;">
                            <div id="NewsC">
                                <asp:Repeater ID="RepeaterResMon" runat="server">
                                    <HeaderTemplate>
                                        <table class="Tmain1">
                                            <tr>
                                                <th style="width: 50px;">
                                                    排名
                                                </th>
                                                <th>
                                                    部门名称
                                                </th>
                                                <th style="width: 60px;">
                                                    隐患数量
                                                </th>
                                                <th style="width: 50px;">
                                                    操作
                                                </th>
                                            </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr>
                                            <td style="text-align: center;">
                                                <%# Container.ItemIndex+1 %>
                                            </td>
                                            <td style="width: 250px;">
                                                <%# Eval("Dept").ToString()%>
                                            </td>
                                            <td style="width: 60px;">
                                                <%# Eval("counters").ToString()%>
                                            </td>
                                            <td>
                                                <asp:ImageButton ID="ImageButton1" CommandName='<%# Eval("Dept").ToString()%>' ImageUrl="/EPSafe/Images/详细.png"
                                                    OnCommand="Res_Click" runat="server" CausesValidation="false"/>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                        <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# RepeaterResMon.Items.Count==0 %>'></asp:Label>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                        </div>
                        <div style="border: 1px solid #C0C0C0; padding: 5px; width:822px; margin: 2px; float: left;">
                            <div id="Div1">
                                部门月度隐患详细
                                <asp:Repeater ID="Repeateryhxx" runat="server">
                                    <HeaderTemplate>
                                        <table class="Tmain1" style="width: 800px;">
                                            <tr>
                                                <th style="width: 40px;">
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
                                                <th style="width: 120px;">
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
                                                <a id="<%# Eval("fid").ToString() %>" href="javascript:;" onclick="openmessage('<%# Eval("fid").ToString()%>')">
                                                    读取</a>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </table>
                                        <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# Repeateryhxx.Items.Count==0 %>'></asp:Label>
                                    </FooterTemplate>
                                </asp:Repeater>
                            </div>
                            <div style="text-align: center; width:auto; float: left; margin: auto; padding-top: 5px;">
                                <webdiyer:AspNetPager ID="Pager" CssClass="paginator" CurrentPageButtonClass="cpb"
                                    runat="server" ScrollBars="None" CurrentPageButtonPosition="Center" AlwaysShow="true"
                                    FirstPageText="首页" LastPageText="末页" NextPageText="下一页" OnPageChanged="AspNetPager1_PageChanged"
                                    PagingButtonSpacing="3px" PrevPageText="上一页" ShowMoreButtons="False" ShowPageIndexBox="Never"
                                    PageSize="20">
                                </webdiyer:AspNetPager>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <div class="demo">
        <div id="dialog" title="安全隐患">
            <table style="width: auto; height: auto">
                <tr>
                    <td style="width: 90px">
                        &nbsp;
                    </td>
                    <td class="style2">
                        负责人：<label id="labelperson"></label>
                    </td>
                    <td>
                        时间：<label id="labeltime"></label>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        区域:
                    </td>
                    <td colspan="2">
                        <textarea id="TextArea4" readonly="readonly" name="S1"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        安全隐患：
                    </td>
                    <td colspan="2">
                        <textarea id="TextAreayh" readonly="readonly"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        处理建议：
                    </td>
                    <td colspan="2">
                        <textarea id="TextArea2" readonly="readonly"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        处理结果：
                    </td>
                    <td colspan="2">
                        <textarea id="TextArea3" readonly="readonly"></textarea>
                    </td>
                </tr>
            </table>
        </div>
    </div>
            </div>
        </div>
    </div>
</asp:Content>
