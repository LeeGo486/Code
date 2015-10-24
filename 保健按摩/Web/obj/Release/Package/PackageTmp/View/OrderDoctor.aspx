<%@ Page Title="保健医师" Language="C#" MasterPageFile="~/View/Health.Master" AutoEventWireup="true" CodeBehind="OrderDoctor.aspx.cs" Inherits="EPReper.Web.View.OrderDoctor" %>

<%@ Register Assembly="AjaxControlToolkit, Version=3.0.20820.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <head>
        <link href="/Styles/Total.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style2
            {
                padding-left: 15px;
                color: #4b6035;
                font: 微软雅黑;
            }
            .style4
            {
                padding-left: 25px;
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
                    <span style="color: #3366CC"><strong style="color: #787CC8">保健医师</strong></span>
                </div>
            </div>
        </div>
        <div>
            <div style="width: 160px; float: left; text-align: center;">
                <ul class="ulclass1">
                    <li><a href="Default.aspx">我的预约</a></li>
                    <li class="liselect"><a style="color: White;" href="OrderDoctor.aspx">保健医师</a></li>
                    <li><a href="UserOrder.aspx">我要预约</a></li>
                    <li id="admins" runat="server" visible="false"><a href="SetSchedule.aspx">医师排班</a></li>
                  <li id="Li1" runat="server" visible="false"><a href="SetSchedule.aspx">医生排班</a></li>
                    <li id="admins1" runat="server" visible="false"><a href="OrderHistory.aspx">历史记录</a></li>
                    <li id="admins2" runat="server" visible="false"><a  href="PinHistory.aspx">评价记录</a></li>
             
                </ul>
            </div>
            <div style="width: 780px; float: right; margin: auto;">
                <table style="width: 760px; font-size: 12px;">
                    <tr>
                        <td rowspan="2">
                            <asp:Panel ID="Panel1" runat="server" Height="203px">
                                <div class="style4">
                                    <strong><span style="color: #FF0000; font-size: large;">总体评价满意度</span><br />
                                    </strong>
                                </div>
                                <table class="style1">
                                    <tr>
                                        <td class="style2" style="text-align: left; font-size: 12px">
                                            总体满意度
                                        </td>
                                        <td>
                                            &nbsp; &nbsp; <asp:Label ID="LabelTotal1" runat="server" Text="Label"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2" style="text-align: left; font-size: 12px">
                                            力度
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="Ratinglidaoall" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2" style="text-align: left; font-size: 12px;">
                                            舒适度
                                        </td>
                                        <td style="height: 24px">
                                            <ajaxToolkit:Rating ID="Ratingshushiall" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2" style="text-align: left; font-size: 12px">
                                            疗效
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="Ratingliaoxiaoall" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2" style="text-align: left; font-size: 12px">
                                            技法
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="Ratingjifaall" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2" style="text-align: left; font-size: 12px">
                                            服务态度
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="Ratingtaiduall" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2" style="text-align: left; font-size: 12px">
                                            总评价人数
                                        </td>
                                        <td>
                                            &nbsp;
                                            <asp:Label ID="Labelcountall" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td style="padding-left: 30px;">
                            <div style="width: 131px; height: 181px; border: 2px solid #E3E3E3;">
                                <asp:Image runat="server" ID="image1" Width="130px" Height="180px" Style="text-align: center" />
                            </div>
                        </td>
                        <td style="padding-left: 30px;">
                            <div style="width: 131px; height: 181px; border: 2px solid #E3E3E3;">
                                <asp:Image runat="server" ID="image2" Width="130px" Height="180px" />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Panel ID="Panel2" runat="server" Height="180px">
                                <div class="style4">
                                    医师：(<asp:Label ID="LabelD1" runat="server"></asp:Label>)评价满意度<br />
                                </div>
                                <table class="style1" style="border: 1px solid #C0C0C0">
                                    <tr>
                                        <td class="style2">
                                            总体满意度
                                        </td>
                                        <td>
                                             &nbsp; &nbsp;<asp:Label ID="LabelA" runat="server" Text="Label"></asp:Label>
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            力度
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatinglidaoA" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            舒适度
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatingshushiA" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            疗效
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatingliaoxiaoA" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            技法
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatingjifaA" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            服务态度
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatingtaiduA" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            总评价人数
                                        </td>
                                        <td>
                                            &nbsp;
                                            <asp:Label ID="LabelcountA" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                        <td>
                            <asp:Panel ID="Panel3" runat="server" Height="180px">
                                <div class="style4">
                                    医师：(<asp:Label ID="LabelD2" runat="server"></asp:Label>)评价满意度<br />
                                </div>
                                <table class="style1" style="border: 1px solid #C0C0C0">
                                    <tr>
                                        <td class="style2">
                                            总体满意度
                                        </td>
                                        <td>
                                             &nbsp; &nbsp;<asp:Label ID="LabelB" runat="server" Text="Label"></asp:Label>
                                           
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            力度
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatinglidaoB" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            舒适度
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatingshushiB" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            疗效
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatingliaoxiaoB" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            技法
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatingjifaB" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            服务态度
                                        </td>
                                        <td>
                                            <ajaxToolkit:Rating ID="RatingtaiduB" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" ReadOnly="True" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                            </ajaxToolkit:Rating>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            总评价人数
                                        </td>
                                        <td>
                                            &nbsp;
                                            <asp:Label ID="LabelcountB" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        </form>
    </body>
</asp:Content>
