<%@ Page Title="" Language="C#" MasterPageFile="~/View/Health.Master" AutoEventWireup="true" CodeBehind="SetOrderScore.aspx.cs" Inherits="Web.View.SetOrderScore" %>

<%@ Register Assembly="AjaxControlToolkit, Version=3.0.20820.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>雅莹保健预约--评价</title>
        <link href="/Styles/Total.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
            .style1
            {
                width: 100%;
                border: 1px solid #F0F0F0;
            }
            .style3
            {
                width: 250px;
                height: 170px;
            }
            .style4
            {
                width: 115px;
                height: 25px;
            }
            .style5
            {
                width: 280px;
                height: 170px;
            }
            .style6
            {
                width: 142px;
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
                    <span style="color: #3366CC"><strong style="color:#787CC8">我预约的保健服务</strong></span>
                </div>
            </div>
        </div>
        <div>
            <div style="width: 160px; float: left; text-align: center;">
                <ul class="ulclass1">
                    <li class="liselect"><a  style="color: White;" href="Default.aspx">我的预约</a></li>
                    <li><a href="OrderDoctor.aspx">保健医师</a></li>
                    <li><a href="UserOrder.aspx">我要预约</a></li>
                    <li id="admins" runat="server" visible="false"><a href="SetSchedule.aspx">医生排班</a></li>
                </ul>
            </div>
            <div style="  width: 780px; float: right;">
                <div style="border: 1px solid #CCCCFF; margin: auto; padding: 5px 10px 10px 20px;">
                    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>--%>
                    <div>
                        <div style="padding: 10px 0px 10px 0px; font-weight: 700; text-align: center; font-size: large">
                            保健服务评价</div>
                        <table class="Tmain3">
                            <tr>
                                <td>
                                    &nbsp; 保健医师：<asp:Label ID="Labeldoctor" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp; 保健时间段：<asp:Label ID="Labeldatetime" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp; 保健人：<asp:Label ID="Labeluser" runat="server" Text="Label" Width="150px"></asp:Label>
                                    所属部门：<asp:Label ID="Labeldept" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp; 联系电话：<asp:Label ID="LabelTel" runat="server" Text="Label"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="background-color: #BFCFFF">
                                    &nbsp; 保健需求描述：
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <textarea id="TextAreaDescription" cols="20" style="width: 98%;" rows="10" readonly="readonly" runat="server"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <br />
                    <div>
                        <table style="height: 160px; width: 700px;">
                            <tr>
                                <td class="style5">
                                    <asp:Panel ID="Panel1" runat="server" Height="160px">
                                        <div>
                                            评价满意度<br />
                                        </div>
                                        <table class="style1">
                                            <%--<tr>
                                                <td class="style6">
                                                    &nbsp;&nbsp; 总体满意度
                                                </td>
                                                <td>
                                                    <ajaxToolkit:Rating ID="RatingTotal" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar">
                                                    </ajaxToolkit:Rating>
                                                </td>
                                            </tr>--%>
                                            <tr>
                                                <td class="style6">
                                                    &nbsp;&nbsp; 力度
                                                </td>
                                                <td>
                                                    <ajaxToolkit:Rating ID="Ratinglidu" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar" CurrentRating="5">
                                                    </ajaxToolkit:Rating>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    &nbsp;&nbsp; 舒适度
                                                </td>
                                                <td>
                                                    <ajaxToolkit:Rating ID="Ratingshushidu" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar" CurrentRating="5">
                                                    </ajaxToolkit:Rating>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    &nbsp;&nbsp; 疗效
                                                </td>
                                                <td>
                                                    <ajaxToolkit:Rating ID="Ratingliaoxiao" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar" CurrentRating="5">
                                                    </ajaxToolkit:Rating>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    &nbsp;&nbsp; 技法
                                                </td>
                                                <td>
                                                    <ajaxToolkit:Rating ID="Ratingjifa" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar" CurrentRating="5">
                                                    </ajaxToolkit:Rating>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style6">
                                                    &nbsp;&nbsp; 服务态度
                                                </td>
                                                <td>
                                                    <ajaxToolkit:Rating ID="Ratingfuwu" runat="server" EmptyStarCssClass="emptyRatingStar" FilledStarCssClass="filledRatingStar" Height="20" StarCssClass="RatingStar" WaitingStarCssClass="waitingRatingStar" CurrentRating="5">
                                                    </ajaxToolkit:Rating>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </td>
                                <td class="style5">
                                    <asp:Panel ID="Panel2" runat="server" Height="160px" Width="262px">
                                        <div>
                                            评价描述
                                        </div>
                                        <textarea id="TextAreaScore" cols="20" rows="2" runat="server" style="height: 142px; width: 254px;"></textarea>
                                    </asp:Panel>
                                </td>
                                <td style="padding: 150px 0px 5px 0px;">
                                    <asp:Button ID="Button1" runat="server" Text="评价提交" Width="100px" Font-Size="Larger" OnClientClick="return confirm('确认要评价吗？');" OnClick="Btn_OK" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%-- </ContentTemplate>
            </asp:UpdatePanel>--%>
                </div>
                
            </div>
        </div>
        </form>
    </body>
    </html>
   </asp:Content>
