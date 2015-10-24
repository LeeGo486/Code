<%@ Page Title="" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="ZhuanTiList.aspx.cs" Inherits="EPReper.Web.EPSafe.ZhuanTiList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 30px; float: left; font-size: 15px; font-weight: 700; color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 735px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>-><a href="ZhuanTiList.aspx">安全热点专题</a>
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
        <div style="float: left; width: 200px;">
            <div class="NewsMap1">
                <span style="color: #0087ce;">安全热点专题</span>
            </div>
            <div class="NewsMapZhuanTi" style="border: 1px solid #D4D4D4;">
                <asp:Repeater ID="RepeaterSafeZhuanTi" runat="server">
                    <ItemTemplate>
                        <div class="newtitle">
                            <a href="ZhuanTiList.aspx?ZhuanName=<%# Eval("fid").ToString() %>" title="<%# Eval("ZhuanName").ToString() %>" >
                                <%# Eval("ZhuanName").ToString().Length > 14 ? Eval("ZhuanName").ToString().Substring(0, 14) + "......" : Eval("ZhuanName")%>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
        <div style="float: left; width: 440px;">
            <div style="width: 440px; padding-left: 5px;">
                <div class="NewsTabList" id="lableType"  style="width:728px;" runat="server">
                    <span style="color: #0087ce;">安全热点专题</span>
                </div>
                <div style="margin: auto; width: 440px;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div style="border: 1px solid #C0C0C0; padding: 5px; width: 742px; margin: auto; float: left;">
                                <div id="NewsC">
                                    <asp:Repeater ID="RepeaterPubGG" runat="server">
                                        <HeaderTemplate>
                                            <table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td style="width: 600px;">
                                                    <div class="newtitle">
                                                        <a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>" target="_blank">
                                                            <%# Eval("newstitle").ToString().Length > 20 ? Eval("newstitle").ToString().Substring(0, 20) + "..." : Eval("newstitle")%>
                                                        </a>
                                                    </div>
                                                </td>
                                                <td>
                                                    <%# Convert.ToDateTime(Eval("createtime")).ToString("yyyy-MM-dd")%>
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
                                    <webdiyer:AspNetPager ID="Pager" CssClass="paginator" CurrentPageButtonClass="cpb" runat="server" ScrollBars="None" CurrentPageButtonPosition="Center" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" NextPageText="下一页" OnPageChanged="AspNetPager1_PageChanged" PagingButtonSpacing="3px" PrevPageText="上一页" ShowMoreButtons="False" ShowPageIndexBox="Never" PageSize="25">
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
