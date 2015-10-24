<%@ Page Title="雅莹保健预约医生排班" Language="C#" MasterPageFile="~/View/Health.Master" AutoEventWireup="true" CodeBehind="SetSchedule.aspx.cs" Inherits="Web.View.SetSchedule" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <link href="/Styles/Total.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style1
            {
                text-align: center;
                font-size: xx-large;
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
                    <span style="color: #3366CC"><strong style="color: #787CC8">保健医师排班</strong></span>
                </div>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div style="padding: 10px 20px 0px 0px; float: right; height: 60px; line-height: 60px; overflow: hidden;">
                            <asp:Button ID="Button1" runat="server" Text="完成医师排班以后请点击这里" OnClick="DoneClick" />
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
        <div>
            <div style="width: 160px; float: left; text-align: center;">
                <ul class="ulclass1">
                    <li><a href="Default.aspx">我的预约</a></li>
                    <li><a href="OrderDoctor.aspx">保健医师</a></li>
                    <li><a href="UserOrder.aspx">我要预约</a></li>
                    <li class="liselect"><a style="color: White;" href="SetSchedule.aspx">医师排班</a></li>
                    <li id="admins1" runat="server"><a href="OrderHistory.aspx">历史记录</a></li>
                    <li id="admins2" runat="server"><a href="PinHistory.aspx">评价记录</a></li>
                    
                </ul>
            </div>
            <div>
                <div style="width: 780px; float: right;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div>
                                <div>
                                    <asp:Panel ID="Panel4" runat="server">
                                        <table class="Tmain4">
                                            <tr>
                                                <th style="width: 100px;">
                                                    保健时间段
                                                </th>
                                                <th colspan="2" style="width: 200px;">
                                                    周二<br />
                                                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                                                </th>
                                                <th colspan="2" style="width: 200px;">
                                                    周四<br />
                                                    <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                                                </th>
                                                <th colspan="2" style="width: 200px;">
                                                    周六<br />
                                                    <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
                                                </th>
                                            </tr>
                                            <asp:Repeater ID="Repeater1" runat="server">
                                                <HeaderTemplate>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr align="left">
                                                        <td>
                                                            <%# Eval("ORDERTIME")%>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox Width="60px" ID="TextBox1" runat="server" Text='<%# Eval("ORDERDOCTOR1")%>'> </asp:TextBox>
                                                            <asp:LinkButton runat="server" ID="LinkButton1" Text="保存" CommandName='<%# Eval("FID1")+","+(Container as RepeaterItem).ItemIndex%>' OnCommand="btnOr_Clik1"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox Width="60px" ID="TextBox2" runat="server" Text='<%# Eval("ORDERDOCTOR2")%>'> </asp:TextBox>
                                                            <asp:LinkButton runat="server" ID="LinkButton2" Text="保存" CommandName='<%# Eval("FID2")+","+(Container as RepeaterItem).ItemIndex %>' OnCommand="btnOr_Clik2"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox Width="60px" ID="TextBox3" runat="server" Text='<%# Eval("ORDERDOCTOR3")%>'> </asp:TextBox>
                                                            <asp:LinkButton runat="server" ID="LinkButton3" Text="保存" CommandName='<%# Eval("FID3")+","+(Container as RepeaterItem).ItemIndex %>' OnCommand="btnOr_Clik3"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox Width="60px" ID="TextBox4" runat="server" Text='<%# Eval("ORDERDOCTOR4")%>'> </asp:TextBox>
                                                            <asp:LinkButton runat="server" ID="LinkButton4" Text="保存" CommandName='<%# Eval("FID4")+","+(Container as RepeaterItem).ItemIndex %>' OnCommand="btnOr_Clik4"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox Width="60px" ID="TextBox5" runat="server" Text='<%# Eval("ORDERDOCTOR5")%>'> </asp:TextBox>
                                                            <asp:LinkButton runat="server" ID="LinkButton5" Text="保存" CommandName='<%# Eval("FID5")+","+(Container as RepeaterItem).ItemIndex %>' OnCommand="btnOr_Clik5"></asp:LinkButton>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox Width="60px" ID="TextBox6" runat="server" Text='<%# Eval("ORDERDOCTOR6")%>'> </asp:TextBox>
                                                            <asp:LinkButton runat="server" ID="LinkButton6" Text="保存" CommandName='<%# Eval("FID6")+","+(Container as RepeaterItem).ItemIndex %>' OnCommand="btnOr_Clik6"></asp:LinkButton>
                                                        </td>
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
        </div>
        </form>
    </body>
    </html>
</asp:Content>
