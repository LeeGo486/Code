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
                    <li class="liselect"><a style="color: White;" href="UserOrder.aspx">预约</a></li>
                    <li id="admins" runat="server" visible="false"><a href="SetSchedule.aspx">医师排班</a></li>
                    <li id="admins1" runat="server" visible="false"><a href="OrderHistory.aspx">历史记录</a></li>
                    <li id="admins2" runat="server" visible="false"><a href="PinHistory.aspx">评价记录</a></li>
                </ul>
            </div>
            <div style="width: 780px; float: right;">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div>
                            <div style="margin: auto;">
                                <asp:Panel ID="Panel4" runat="server">
                                    <table class="Tmain2">
                                        <tr>
                                            <th style="width: 85px;">
                                                保健时间段
                                            </th>
                                            <th colspan="3" style="width: 160px;">
                                                周一<br />
                                                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                            </th>
                                            <th colspan="3" style="width: 160px;">
                                                周二<br />
                                                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                                            </th>
                                            <th colspan="3" style="width: 160px;">
                                                周三<br />
                                                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                                            </th>
                                           <th colspan="3"  style="width: 160px;">
                                                周四<br />
                                                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                                            </th>
                                            <th colspan="3" style="width: 160px;">
                                                周五<br />
                                                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
                                            </th>
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
                                                       <%# Eval("ORDERDOCTOR1")%><br />
                                                        <asp:Label ID="Label1" Visible='<%# (Eval("ISORDER1").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON1")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER1").ToString())=="0" %>' runat="server" ID="LinkButton1" Text="预约" CommandName='<%# Eval("FID1")%>' OnCommand="btnOr_Clik1"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR2")%><br />
                                                        <asp:Label ID="Label2" Visible='<%#(Eval("ISORDER2").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON2")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER2").ToString())=="0" %>' runat="server" ID="LinkButton2" Text="预约" CommandName='<%# Eval("FID2")%>' OnCommand="btnOr_Clik2"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR3")%><br />
                                                        <asp:Label ID="Label3" Visible='<%# (Eval("ISORDER3").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON3")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER3").ToString())=="0" %>' runat="server" ID="LinkButton3" Text="预约" CommandName='<%# Eval("FID3")%>' OnCommand="btnOr_Clik3"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR4")%><br />
                                                        <asp:Label ID="Label4" Visible='<%# (Eval("ISORDER4").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON4")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER4").ToString())=="0" %>' runat="server" ID="LinkButton4" Text="预约" CommandName='<%# Eval("FID4")%>' OnCommand="btnOr_Clik4"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR5")%><br />
                                                        <asp:Label ID="Label5" Visible='<%# (Eval("ISORDER5").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON5")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER5").ToString())=="0" %>' runat="server" ID="LinkButton5" Text="预约" CommandName='<%# Eval("FID5")%>' OnCommand="btnOr_Clik5"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR6")%><br />
                                                        <asp:Label ID="Label6" Visible='<%# (Eval("ISORDER6").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON6")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER6").ToString())=="0" %>' runat="server" ID="LinkButton6" Text="预约" CommandName='<%# Eval("FID6")%>' OnCommand="btnOr_Clik6"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR7")%><br />
                                                        <asp:Label ID="Label7" Visible='<%# (Eval("ISORDER7").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON7")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER7").ToString())=="0" %>' runat="server" ID="LinkButton7" Text="预约" CommandName='<%# Eval("FID7")%>' OnCommand="btnOr_Clik7"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR8")%><br />
                                                        <asp:Label ID="Label8" Visible='<%# (Eval("ISORDER8").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON8")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER8").ToString())=="0" %>' runat="server" ID="LinkButton8" Text="预约" CommandName='<%# Eval("FID8")%>' OnCommand="btnOr_Clik8"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR9")%><br />
                                                        <asp:Label ID="Label9" Visible='<%# (Eval("ISORDER9").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON9")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER9").ToString())=="0" %>' runat="server" ID="LinkButton9" Text="预约" CommandName='<%# Eval("FID9")%>' OnCommand="btnOr_Clik9"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR10")%><br />
                                                        <asp:Label ID="Label10" Visible='<%# (Eval("ISORDER10").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON10")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER10").ToString())=="0" %>' runat="server" ID="LinkButton10" Text="预约" CommandName='<%# Eval("FID10")%>' OnCommand="btnOr_Clik10"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR11")%><br />
                                                        <asp:Label ID="Label11" Visible='<%# (Eval("ISORDER11").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON11")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER6").ToString())=="0" %>' runat="server" ID="LinkButton11" Text="预约" CommandName='<%# Eval("FID11")%>' OnCommand="btnOr_Clik11"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR12")%><br />
                                                        <asp:Label ID="Label12" Visible='<%# (Eval("ISORDER12").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON12")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER12").ToString())=="0" %>' runat="server" ID="LinkButton12" Text="预约" CommandName='<%# Eval("FID12")%>' OnCommand="btnOr_Clik12"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR13")%><br />
                                                        <asp:Label ID="Label13" Visible='<%# (Eval("ISORDER13").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON13")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER13").ToString())=="0" %>' runat="server" ID="LinkButton13" Text="预约" CommandName='<%# Eval("FID13")%>' OnCommand="btnOr_Clik13"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR14")%><br />
                                                        <asp:Label ID="Label14" Visible='<%# (Eval("ISORDER14").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON14")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER14").ToString())=="0" %>' runat="server" ID="LinkButton14" Text="预约" CommandName='<%# Eval("FID14")%>' OnCommand="btnOr_Clik14"></asp:LinkButton>
                                                    </td>
                                                    <td>
                                                       <%# Eval("ORDERDOCTOR15")%><br />
                                                        <asp:Label ID="Label15" Visible='<%# (Eval("ISORDER15").ToString())=="1"  %>' Text='<%# Eval("ORDERPERSON15")%>' runat="server"></asp:Label>
                                                        <asp:LinkButton Visible='<%# (Eval("ISORDER15").ToString())=="0" %>' runat="server" ID="LinkButton15" Text="预约" CommandName='<%# Eval("FID15")%>' OnCommand="btnOr_Clik15"></asp:LinkButton>
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
