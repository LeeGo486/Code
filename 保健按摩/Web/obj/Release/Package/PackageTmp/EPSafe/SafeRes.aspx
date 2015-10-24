<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true"
    CodeBehind="SafeRes.aspx.cs" Inherits="EPReper.Web.EPSafe.SafeRes" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
     <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
     <script type="text/javascript" language="javascript" src="/EpSafe/calendar/js/calendar.min.js"></script>
    <script type="text/javascript" language="javascript" src="/EpSafe/calendar/js/config.js"></script>
    <script type="text/javascript" language="javascript" src="/EpSafe/calendar/js/resources.js"></script>
    <link rel="stylesheet" type="text/css" media="screen,projection,print" href="/EpSafe/calendar/css/calendar.css" />

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
        //日期下拉
        createPopCalendar = function (id) {

            var ca15 = new JSCalender.PopCalender('<%= TextBoxtime.ClientID %>', '<%= TextBoxtime.ClientID %>');

            ca15.config.dates = "";
            ca15.setPrintFarmat("yyyy-MM-dd");
            ca15.show();
        }
        function checkdate() {
            var start = document.getElementById('<%= TextBoxtime.ClientID %>').value;

            var r = /\d{4}(?:-\d{1,2}){0,2}/;
            flag = true;
            //正则表达式，判断是否为yyyy-mm-dd,yyyy-mm,yyyy格式
            if (start.length > 0) {
                if (start.match(r) != start) {
                    alert("报表日期格式应为 2012-01-01 ");
                    flag = false;
                }
            }

            return flag;
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
        .style2
        {
        }
        #TextArea4
        {
            height: 80px;
            width: 530px;
        }
        #demo
        {
            height: 800px;
            width: 700px;
        }
        
        .style3
        {
            width: 267px;
        }
        
        .style5
        {
            width: 215px;
        }
        .sstd
        {
            font-size:9pt;
            text-align:right;
          width: 130px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 70px; float: left; font-size: 15px; font-weight: 700;
            color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 960px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>-><a href="SafeRes.aspx">安全责任</a>
            </div>
            <div style="float: left; width: 960px; height: 40px; ">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td class="sstd">
                                    责任人
                                </td>
                                <td >
                                    <asp:TextBox ID="TextBoxperson" runat="server" AutoCompleteType="Disabled" Width="80px" Height="18px"></asp:TextBox>
                                </td>
                                <td class="sstd">
                                    部门
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxdept" runat="server" AutoCompleteType="Disabled"  Width="110px" Height="18px"></asp:TextBox>
                                </td>
                                <td class="sstd">
                                    隐患
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxyh" runat="server" AutoCompleteType="Disabled" Height="18px"></asp:TextBox>
                                </td>
                                <td class="sstd">
                                    区域
                                </td>
                                <td>
                                    <asp:TextBox  ID="TextBoxqy" runat="server" AutoCompleteType="Disabled" Height="18px"></asp:TextBox>
                                </td>
                                <td class="sstd">
                                    日期
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBoxtime" runat="server"  onfocus="createPopCalendar('1');" Width="100px" Height="18px"></asp:TextBox>
                                </td>





                                <td>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/search.png" OnClick="ImgBtnSearch_Click"
                                        Height="26px" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
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
            <div style="width: 240px; padding-left: 5px;">
                <div class="NewsTab3" style="width: 808px;" id="lableType" runat="server">
                    <span style="color: #0087ce;">安全隐患</span>
                </div>
                <div style="margin: auto; width: 240px;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div style="border: 1px solid #C0C0C0; padding: 5px; width: 822px; margin: auto;
                                float: left;">
                                <div id="NewsC">
                                    <asp:Repeater ID="RepeaterPubGG" runat="server">
                                        <HeaderTemplate>
                                            <table class="Tmain1">
                                                <tr>
                                                    <th style="width: 50px;">
                                                        序号
                                                    </th>
                                                    <th>
                                                        区域
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
                                                        罚款
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
                                            <tr id="<%# Eval("fid").ToString() %>" ondblclick="openmessage('<%# Eval("fid").ToString()%>')">
                                                <%--   <td style="width: 50px;">
                                                    <%# Eval("fid").ToString() %>
                                                </td>--%>
                                                <td style="text-align: center;">
                                                    <%# Container.ItemIndex+1 %>
                                                </td>
                                                <td>
                                                    <%# Eval("Area").ToString().Length > 12 ? Eval("Area").ToString().Substring(0, 12) + "..." : Eval("Area")%>
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
                                                <td>
                                                    <%# Eval("Fine").ToString() %>
                                                </td>
                                                <td id="<%# Eval("fid").ToString() %>PitSuggestion">
                                                    <%# Eval("PitSuggestion").ToString() %>
                                                </td>
                                                <td id="<%# Eval("fid").ToString() %>PitResult">
                                                    <%# Eval("PitResult").ToString() %>
                                                </td>
                                                <td>
                                                    <a id="<%# Eval("fid").ToString() %>" href="javascript:;" onclick="openmessage('<%# Eval("fid").ToString()%>')">
                                                        读取</a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                            <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# RepeaterPubGG.Items.Count==0 %>'></asp:Label>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                                <div style="text-align: center; width: 740px; float: left; margin: auto; padding-top: 5px;">
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
                </div>
            </div>
        </div>
    </div>
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
</asp:Content>
