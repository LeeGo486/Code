<%@ Page Title="" Language="C#" MasterPageFile="~/View/Health.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web.View.Default" %>

<%@ Register Assembly="AjaxControlToolkit, Version=3.0.20820.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <script src="../Scripts/jquery-1.4.1.js" type="text/javascript">
        </script>
        <title>雅莹保健预约</title>
        <link href="/Styles/Total.css" rel="stylesheet" type="text/css" />
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
                    <span style="color: #3366CC"><strong style="color: #787CC8">我预约的保健服务</strong></span>
                </div>
            </div>
        </div>
        <div>
            <div style="width: 160px; float: left; text-align: center;">
                <ul class="ulclass1">
                    <li class="liselect "><a style="color: White;" href="Default.aspx">我的预约</a></li>
                    <li><a href="OrderDoctor.aspx">保健医师</a></li>
                    <li><a href="UserOrder.aspx">我要预约</a></li>
                     <li id="admins" runat="server" visible="false"><a href="SetSchedule.aspx">医生排班</a></li>
                    <li id="admins1" runat="server" visible="false"><a href="OrderHistory.aspx">历史记录</a></li>
                    <li id="admins2" runat="server" visible="false"><a  href="PinHistory.aspx">评价记录</a></li>
             
                </ul>
            </div>
            <%--   <div style="border: 1px solid #CCCCFF; width: 780px; float: right;">--%>
            <div style="float: right;">
                <div style="border: 1px solid #CCCCFF; width: 780px;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div style="background-color: #BFCFFF; height: 20px;">
                                <div style="float: right;">
                                    状态：
                                    <asp:DropDownList ID="DropDownList1" runat="server" Width="100" AutoPostBack="true" OnSelectedIndexChanged="BtnSearch_Clik">
                                        <asp:ListItem Value="" />
                                        <asp:ListItem Value="已生效" Selected="True" />
                                        <asp:ListItem Value="已取消" />
                                        <asp:ListItem Value="已评价" />
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div>
                                <asp:Panel ID="Panel4" runat="server">
                                    <%--<asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">--%>
                                    <asp:Repeater ID="Repeater1" runat="server">
                                        <HeaderTemplate>
                                            <table class="Tmain1" style=" width:780px;">
                                                <tr>
                                                    <th>
                                                        保健人
                                                    </th>
                                                    <th>
                                                        联系电话
                                                    </th>
                                                    <th>
                                                        所属部门
                                                    </th>
                                                    <th>
                                                        保健医师
                                                    </th>
                                                    <th>
                                                        预约日期
                                                    </th>
                                                    <th>
                                                        预约时间段
                                                    </th>
                                                    <th>
                                                        状态
                                                    </th>
                                                    <th>
                                                        预约操作
                                                    </th>
                                                    <th>
                                                        评价
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%# Eval("USERNAME")%>
                                                </td>
                                                <td>
                                                    <%# Eval("USERTEL")%>
                                                </td>
                                                <td>
                                                    <%# Eval("USERDEPT")%>
                                                </td>
                                                <td>
                                                    <%# Eval("USERDOCTOR")%>
                                                </td>
                                                <td>
                                                    <%# Eval("USERDATE")%>
                                                </td>
                                                <td>
                                                    <%# Eval("USERTIME")%>
                                                </td>
                                                <td>
                                                    <%# Eval("USERSTATE")%>
                                                </td>
                                                <td>
                                                    <asp:LinkButton Visible='<%# (Eval("USERSTATE").ToString())=="已生效" %>' runat="server" ID="btnCancel" Text="取消" CommandName='<%# Eval("FID")%>' OnCommand="btnCancel_Clik" OnClientClick="return confirm('确认要取消吗？');"></asp:LinkButton>
                                                    <asp:Label ID="LabelCancel" Text="已取消" runat="server" Visible='<%# (Eval("USERSTATE").ToString())=="已取消" %>'></asp:Label>
                                                </td>
                                                <%-- <td>
                                                <asp:HyperLink ID="HyperLink1" Visible='<%# (Eval("USERSTATE").ToString())=="已生效" %>' runat="server" Text='进行评价' NavigateUrl='<%# "/View/SetOrderScore.aspx?OrderID="+Eval("FID").ToString() %>' Target="_blank"></asp:HyperLink>
                                                <asp:Label ID="LabelPinjia" Text="已评价" runat="server" Visible='<%# (Eval("USERSTATE").ToString())=="已评价" %>'></asp:Label>
                                            </td>--%>
                                                <td>
                                                    <asp:LinkButton Visible='<%# (Eval("USERSTATE").ToString())=="已生效" %>' runat="server" ID="LinkButton1" Text="进行评价" CommandName='<%# Eval("FID")%>' OnCommand="btnSetScore_Clik" OnClientClick="return confirm('确认要评价吗？');"></asp:LinkButton>
                                                    <asp:Label ID="Label1" Text="已评价" runat="server" Visible='<%# (Eval("USERSTATE").ToString())=="已评价" %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            </table>
                                            <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# Repeater1.Items.Count==0 %>'></asp:Label>
                                        </FooterTemplate>
                                    </asp:Repeater>
                                </asp:Panel>
                            </div>
                            <div style="text-align: left;">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                                <ProgressTemplate>
                                                    <font color="red">
                                                        <img alt="" src="/Images/reflash.gif" />数据加载中，请稍后......</font>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                            <div style="text-align: left; font-size: 12px;">
                                                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CurrentPageButtonPosition="Center" UrlPaging="false" AlwaysShow="True" FirstPageText="首页" LastPageText="末页" NextPageText="下一页" OnPageChanged="AspNetPager1_PageChanged" PagingButtonSpacing="3px" PrevPageText="上一页" ShowMoreButtons="False" ShowPageIndexBox="Never" PageSize="10" CenterCurrentPageButton="True">
                                                </webdiyer:AspNetPager>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <br />
                <br />
                <div>
                    <a href="UserOrder.aspx">我要预约</a>
                </div>
            </div>
        </div>
        </form>
    </body>
    </html>
</asp:Content>
