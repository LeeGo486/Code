<%@ Page Title="" Language="C#" MasterPageFile="~/View/Health.Master" AutoEventWireup="true" CodeBehind="UserOrder.aspx.cs" Inherits="Web.View.UserOrder" %>

<%@ Register Assembly="AjaxControlToolkit, Version=3.0.20820.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>雅莹保健预约</title>
        <link href="/Styles/Total.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .linkyuyue
            {
                color: Red;
            }
        </style>
    </head>
    <body>
        <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div style="height: 70px;">
            <div style="height: 60px; float: left; width: 160px; margin: auto; background-image: url(../Images/abouthealth.png);">
            </div>
            <div style="height: 60px; float: right; width: 780px; margin: auto; background-image: url(../Images/heathtitle.png);">
                <div style="padding-left: 20px; float: left; height: 60px; line-height: 60px; overflow: hidden;">
                    <span style="color: #3366CC"><strong style="color: #787CC8">预约保健服务</strong></span>
                </div>
            </div>
        </div>
        <div>
            <div style="width: 160px; float: left; text-align: center;">
                <ul class="ulclass1">
                    <li><a href="Default.aspx">我的预约</a></li>
                    <li><a href="OrderDoctor.aspx">保健医师</a></li>
                    <li class="liselect"><a style="color: White;" href="UserOrder.aspx">我要预约</a></li>
                    <li id="admins" runat="server" visible="false"><a href="SetSchedule.aspx">医师排班</a></li>
                    <li id="admins1" runat="server" visible="false"><a href="OrderHistory.aspx">历史记录</a></li>
                    <li id="admins2" runat="server" visible="false"><a href="PinHistory.aspx">评价记录</a></li>
                </ul>
            </div>
            <div style="width: 780px; float: right;">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div>
                            <div style="margin: atuo;">
                                <asp:Panel ID="Panel4" runat="server">
                                    <table class="Tmain2">
                                        <tr>
                                            <th style="width: 100px;">
                                                保健时间段
                                            </th>
                                            <th colspan="2" style="width: 200px;">
                                                周二<br />
                                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                            </th>
                                            <%--<th style="width: 100px;">
                                                周二<br />
                                                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                                            </th>--%>
                                            <th colspan="2" style="width: 200px;">
                                                周四<br />
                                                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                                            </th>
                                            <%--<th style="width: 100px;">
                                                周四<br />
                                                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                                            </th>--%>
                                            <th colspan="2" style="width: 200px;">
                                                周六<br />
                                                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
                                            </th>
                                            <%--<th style="width: 100px;">
                                                周六<br />
                                                <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
                                            </th>--%>
                                        </tr>
                                        <asp:Repeater ID="Repeater1" runat="server">
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <%# Eval("ORDERTIME")%>
                                                    </td>
                                                    <td>
                                                        医师：<%# Eval("ORDERDOCTOR1")%><br />
                                                        <asp:Label ID="Label1" Visible='<%# (Eval("ISORDER1").ToString())=="1"  %>' Text='<%# "预约人："+Eval("ORDERPERSON1")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER1").ToString())=="0" %>' runat="server" ID="LinkButton1" Text="我要预约" CommandName='<%# Eval("FID1")%>' OnCommand="btnOr_Clik1"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        医师：<%# Eval("ORDERDOCTOR2")%><br />
                                                        <asp:Label ID="Label2" Visible='<%#(Eval("ISORDER2").ToString())=="1"  %>' Text='<%# "预约人："+Eval("ORDERPERSON2")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER2").ToString())=="0" %>' runat="server" ID="LinkButton2" Text="我要预约" CommandName='<%# Eval("FID2")%>' OnCommand="btnOr_Clik2"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        医师：<%# Eval("ORDERDOCTOR3")%><br />
                                                        <asp:Label ID="Label3" Visible='<%# (Eval("ISORDER3").ToString())=="1"  %>' Text='<%# "预约人："+Eval("ORDERPERSON3")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER3").ToString())=="0" %>' runat="server" ID="LinkButton3" Text="我要预约" CommandName='<%# Eval("FID3")%>' OnCommand="btnOr_Clik3"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        医师：<%# Eval("ORDERDOCTOR4")%><br />
                                                        <asp:Label ID="Label4" Visible='<%# (Eval("ISORDER4").ToString())=="1"  %>' Text='<%# "预约人："+Eval("ORDERPERSON4")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER4").ToString())=="0" %>' runat="server" ID="LinkButton4" Text="我要预约" CommandName='<%# Eval("FID4")%>' OnCommand="btnOr_Clik4"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        医师：<%# Eval("ORDERDOCTOR5")%><br />
                                                        <asp:Label ID="Label5" Visible='<%# (Eval("ISORDER5").ToString())=="1"  %>' Text='<%# "预约人："+Eval("ORDERPERSON5")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER5").ToString())=="0" %>' runat="server" ID="LinkButton5" Text="我要预约" CommandName='<%# Eval("FID5")%>' OnCommand="btnOr_Clik5"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        医师：<%# Eval("ORDERDOCTOR6")%><br />
                                                        <asp:Label ID="Label6" Visible='<%# (Eval("ISORDER6").ToString())=="1"  %>' Text='<%# "预约人："+Eval("ORDERPERSON6")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER6").ToString())=="0" %>' runat="server" ID="LinkButton6" Text="我要预约" CommandName='<%# Eval("FID6")%>' OnCommand="btnOr_Clik6"></asp:LinkButton>
                                                    </td>
                                                    <%-- <td align="left">
                                            <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("ktitle").ToString()%>'
                                                NavigateUrl='<%# "/Details/"+Eval("kid").ToString() %>' Target="_blank"></asp:HyperLink>
                                        </td>
                                        <td>
                                            <%# DateTime.Parse( Eval("kdate").ToString()).ToShortDateString()%>
                                        </td>--%>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                </table>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                </asp:Panel>
                            </div>
                        </div>
                        <br />
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        </form>
    </body>
    </html>
</asp:Content>
