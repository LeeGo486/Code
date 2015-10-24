<%@ Page Title="安全新闻" Language="C#" MasterPageFile="~/EPSafe/EPSafe.Master" AutoEventWireup="true" CodeBehind="SafeNew.aspx.cs" Inherits="EPReper.Web.EPSafe.SafeNew" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <style type="text/css">
        #TextArea1
        {
            text-align: left;
            height: 87px;
            width: 241px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SafeContentPlace" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div style="width: 960px; float: left;">
        <div style="width: 960px; height: 40px; float: left; font-size: 15px; font-weight: 700; color: #0087ce;">
            <div id="MainDiv" style="float: left; width: 735px; margin-top: 5px; margin-bottom: 5px;">
                <a href="Default.aspx">安全管理主页</a>-><a href="SafeNew.aspx">安全新闻</a>
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
               <span style="color: #0087ce; ">本月文章排行 </span>
            </div>
            <div class="NewsMapContent1" style="border: 1px solid #D4D4D4;">
                <div>
                    <asp:Repeater ID="RepeaterBenYue" runat="server">
                        <ItemTemplate>
                            <div class="newtitle">
                                ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>" target="_blank">
                                    <%# Eval("newstitle").ToString().Length > 12? Eval("newstitle").ToString().Substring(0, 12) + "..." : Eval("newstitle")%>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
            <div>
                <br />
            </div>
            <div class="NewsMap1">
                <span style="color: #0087ce;">点击排行 </span>
            </div>
            <div class="NewsMapContent1" style="border: 1px solid #D4D4D4;">
                <div id="Div2">
                    <asp:Repeater ID="RepeaterDianJi" runat="server">
                        <ItemTemplate>
                            <div class="newtitle">
                                ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>" target="_blank">
                                    <%# Eval("newstitle").ToString().Length > 12? Eval("newstitle").ToString().Substring(0, 12) + "..." : Eval("newstitle")%>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div style="float: left; width: 440px;">
            <div style="width: 440px; padding-left: 5px;">
                <div class="NewsTab3" style=" width:406px;">
                    <span style="color: #0087ce;"><a href="#"></a>安全新闻 </span>
                </div>
                <div style="margin: auto; width: 440px;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div style="border: 1px solid #C0C0C0; padding: 5px; height: 608px; width: 420px; margin: auto; float: left;">
                                <div id="NewsC">
                                    <asp:Repeater ID="RpNewReplay" runat="server">
                                        <HeaderTemplate>
                                            <table>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td style="width: 330px;">
                                                    <div class="newtitle">
                                                        ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>" target="_blank">
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
                                            <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# RpNewReplay.Items.Count==0 %>'></asp:Label>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </div>
                                <div style="text-align: center; width: 420px; float: left; margin: auto; padding-top: 5px;">
                                    <webdiyer:AspNetPager ID="Pager" CssClass="paginator" CurrentPageButtonClass="cpb" runat="server" ScrollBars="None" CurrentPageButtonPosition="Center" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" NextPageText="下一页" OnPageChanged="AspNetPager1_PageChanged" PagingButtonSpacing="3px" PrevPageText="上一页" ShowMoreButtons="False" ShowPageIndexBox="Never" PageSize="20">
                                    </webdiyer:AspNetPager>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <div style="float: left; width: 307px;">
            <div class="NewsTabnews">
                <span>图片新闻</span>
            </div>
            <div class="NewsContentNews">
                <div class="imgdiv">
                    <script type="text/javascript">
                var focus_width=267
                var focus_height=230
                var text_height=20
                var swf_height = focus_height+text_height
                var pics=<%= pics %>;
                var links=<%= links %>;
                var texts=<%= texts %>;
                document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ focus_width +'" height="'+ swf_height +'">');
                document.write('<param name="allowScriptaccess" value="sameDomain"><param name="wmode" value="transparent"><param name="movie" value="Flash/pixviewer.swf"><param name="quality" value="high"><param name="bgcolor" value=#000000>');
                document.write('<param name="menu" value="false"><param name=wmode value="opaque">');
                document.write('<param name="FlashVars" value="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'">');
                document.write('<embed src="Flash/pixviewer.swf" wmode="opaque" FlashVars="pics='+pics+'&links='+links+'&texts='+texts+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'" menu="false" bgcolor=#000000 quality="high" width="'+ focus_width +'" height="'+ swf_height +'" allowScriptaccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
                document.write('</object>');
                    </script>
                </div>
                <div style="float: left; width: 291px; height: 340px; margin-top: 10px;">
                    <div>
                        <asp:Repeater ID="RepeaterPicNews" runat="server">
                            <ItemTemplate>
                                <div class="newtitle">
                                    ·<a href="Details.aspx?fid=<%# Eval("fid").ToString() %>" title="<%# Eval("newstitle").ToString() %>" target="_blank">
                                        <%# Eval("newstitle").ToString().Length > 16? Eval("newstitle").ToString().Substring(0, 16) + "..." : Eval("newstitle")%>
                                    </a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
            <br />
        </div>
    </div>
</asp:Content>
