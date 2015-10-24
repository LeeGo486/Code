<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="SafeResAdd.aspx.cs" Inherits="EPReper.Web.EPSafe.SafeResAdd" %>

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
                height: 420,
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

            $.getJSON("../GetSafeRes.ashx?Type=SafeRes&method=openMessageByAJAX&timestamp=" + (+new Date()) + "&fid=" + id, function (data) {

                $("#labelquyu").empty().append(data.Area);
                $("#labelperson").empty().append(data.Person);
                $("#labeltime").empty().append(data.Time);
                $("#TextArea1").empty().append(data.PitContents);
                $("#TextArea2").empty().append(data.PitSuggestion);
                $("#TextArea3").empty().append(data.PitResult);

            });


        }
		
    </script>
    <style type="text/css">
        #TextArea1
        {
            height: 140px;
            width: 450px;
        }
        #TextArea2
        {
            height: 60px;
            width: 450px;
        }
        #TextArea3
        {
            height: 60px;
            width: 450px;
        }
        .style1
        {
            width: 220px;
        }
        .style2
        {
            width: 141px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 30px; float: left; font-size: 15px; font-weight: 700; color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 735px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>
            </div>
            <div style="float: left; width: 225px; height: 40px; margin-top: 1px;">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="TextBoxSearch" runat="server" AutoCompleteType="Disabled" Height="20px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/search.png" OnClick="ImgBtnSearch_Click" Height="26px" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div style="float: left; width: 120px;">
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全新闻管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="SateUl" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeAdmin.aspx?Infotype=安全新闻&type=安全新闻">安全新闻</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全信息管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul1" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全公文">安全公文</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全公告">安全公告</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=规章制度">规章制度</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=会议纪要">会议纪要</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全法规">安全法规</a></li>
                    <li><a href="SafeAdmin.aspx?Infotype=安全信息&type=安全知识">安全知识</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全工作管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul3" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeAdmin.aspx?Infotype=安全工作&type=安全工作">安全工作</a></li>
                      <li><a href="SafeSugList.aspx">安全建议</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全责任管理</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul2" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeResAdd.aspx">安全隐患</a></li>
                    <li><a href="SafeDuAdd.aspx">安全责任</a></li>
                    <li><a href="SafeRewAdd.aspx">安全奖励</a></li>
                     <li><a href="SafeMoney.aspx">部门金额</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全书籍推荐</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul4" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeBookAdd.aspx">安全书籍</a></li>
                </ul>
            </div>
            <div class="NewsMapDuty">
                <span style="color: #0087ce;">安全热点专题</span>
            </div>
            <div class="NewsMapContent2" style="border: 1px solid #D4D4D4;">
                <ul id="Ul5" style="list-style: none; padding-left: 20px;">
                    <li><a href="SafeZhuan.aspx">安全热点专题</a></li>
                </ul>
            </div>
        </div>
        <div style="float: left; width: 840px;">
            <div style="width: 240px; padding-left: 5px;">
                <div class="NewsTabList" id="lableType" runat="server" >
                    <span runat="server" id="SpanType" style="color: #0087ce;">安全隐患</span>
                </div>
                <div id="Divlist" runat="server" style="margin: auto; width: 822px; float: left;">
                    <div style="border: 1px solid #C0C0C0; padding: 5px; width: 822px; margin: auto;">
                        <table>
                            <tr>
                                <td style="width: 790px;">
                                    <div id="newstype" runat="server" style="width: 810px; text-align: right; float: right;">
                                        <a href="ResAdd.aspx" title="添加安全隐患" style="font-size:larger"><strong>添加安全隐患</strong> </a>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
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
                                                        部门
                                                    </th>
                                                    <th>
                                                        时间
                                                    </th>
                                                    <th style="width: 200px;">
                                                        隐患
                                                    </th>
                                                    <th>
                                                        罚款（元）
                                                    </th>
                                                    <th>
                                                        处理意见
                                                    </th>
                                                    <th>
                                                        处理结果
                                                    </th>
                                                    <th style="width: 60px;">
                                                        操作
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr id="<%# Eval("fid").ToString() %>" ondblclick="openmessage('<%# Eval("fid").ToString()%>')">
                                               <%-- <td style="width: 50px;">
                                                    <%# Eval("fid").ToString() %>
                                                </td>--%>
                                                  <td style="text-align: center;">
                                                      <%# Container.ItemIndex+1 %>
                                                 </td>
                                                <td>
                                                    <%# Eval("Area").ToString() %>
                                                </td>
                                                <td style="width: 60px;">
                                                    <%# Eval("Person").ToString() %>
                                                </td>
                                                <td>
                                                    <%# Eval("Dept").ToString()%>
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
                                                    <asp:LinkButton runat="server" ID="btnCancel" Text="删除" CommandName='<%# Eval("FID")%>' OnCommand="btnDelete_Clik" OnClientClick="return confirm('确认要删除吗？');"></asp:LinkButton>
                                                    &nbsp;  <a href="ResAdd.aspx?fid=<%# Eval("fid").ToString() %>">修改 </a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                            <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# RepeaterPubGG.Items.Count==0 %>'></asp:Label>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                    <div style="text-align: center; width: 740px; float: left; margin: auto; padding-top: 5px;">
                                        <webdiyer:AspNetPager ID="Pager" CssClass="paginator" CurrentPageButtonClass="cpb" runat="server" ScrollBars="None" CurrentPageButtonPosition="Center" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" NextPageText="下一页" OnPageChanged="AspNetPager1_PageChanged" PagingButtonSpacing="3px" PrevPageText="上一页" ShowMoreButtons="False" ShowPageIndexBox="Never" PageSize="20">
                                        </webdiyer:AspNetPager>
                                    </div>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
