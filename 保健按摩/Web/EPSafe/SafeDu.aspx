<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true"
    CodeBehind="SafeDu.aspx.cs" Inherits="EPReper.Web.EPSafe.SafeDu" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 30px; float: left; font-size: 15px; font-weight: 700;
            color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 735px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>-><a href="SafeRes.aspx">安全责任</a>
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
        <div style="float: left; width: 700px;">
            <div style="width: 240px; padding-left: 5px;">
                <div class="NewsTab3" style="width: 808px;" id="lableType" runat="server">
                    <span style="color: #0087ce;">安全责任</span>
                </div>
                <div style="margin: auto; width: 640px;">
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
                                                        部门
                                                    </th>
                                                    <th style="width: 100px;">
                                                        安全员
                                                    </th>
                                                    <th style="width: 100px;">
                                                        部门长
                                                    </th>
                                                    <th style="width: 120px;">
                                                        区域
                                                    </th>
                                                    <th style="width: 120px;">
                                                        时间
                                                    </th>
                                                    <th style="width: 100px;">
                                                        区域分类
                                                    </th>
                                                    <th>
                                                        是否重点区域
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <%--<td style="width: 50px;">
                                                    <%# Eval("fid").ToString() %>
                                                </td>--%>
                                                <td style="text-align: center;">
                                                    <%# Container.ItemIndex+1 %>
                                                </td>
                                                <td>
                                                    <%# Eval("Dept").ToString() %>
                                                </td>
                                                <td style="width: 60px;">
                                                    <%# Eval("Person").ToString() %>
                                                </td>
                                                <td>
                                                    <%# Eval("DeptLeader").ToString() %>
                                                </td>
                                                <td>
                                                    <%# Eval("Area").ToString() %>
                                                </td>
                                                <td>
                                                    <%# Eval("Time").ToString() %>
                                                </td>
                                                <td>
                                                    <%# Eval("Areatype").ToString() %>
                                                </td>
                                                <td>
                                                    <%# Eval("IsImportant").ToString() %>
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
</asp:Content>
