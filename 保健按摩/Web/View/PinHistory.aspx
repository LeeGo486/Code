<%@ Page Title="" Language="C#" MasterPageFile="~/View/Health.Master" AutoEventWireup="true" CodeBehind="PinHistory.aspx.cs" Inherits="EPReper.Web.View.PinHistory" %>

<%@ Register Assembly="AjaxControlToolkit, Version=3.0.20820.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <head>
        <title>雅莹保健预约</title>
        <link href="../Styles/jquery-ui-1.8.19.custom.css" rel="stylesheet" type="text/css" />
        <link href="/Styles/Total.css" rel="stylesheet" type="text/css" />
        <script src="../Scripts/jquery-1.4.1.js" type="text/javascript">
        </script>
        <script src="../Scripts/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
        <script src="../Scripts/JScriptZh-CN.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(EndRequestHandler);
                function EndRequestHandler(evt, args) {
                    $('#<%=TextBox3.ClientID %>').datepicker(
                {
                    showMonthAfterYear: true,
                    changeMonth: true,
                    changeYear: true,
                    buttonImageOnly: true,
                    minDate: '-1y', maxDate: '+2y',
                    dateFormat: 'yy-mm-dd'

                });
                    $('#<%=TextBox2.ClientID %>').datepicker(
                {
                    showMonthAfterYear: true,
                    changeMonth: true,
                    changeYear: true,
                    buttonImageOnly: true,
                    minDate: '-1y', maxDate: '+2y',
                    dateFormat: 'yy-mm-dd'

                });
                }
            });  
        </script>
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
                    <span style="color: #3366CC"><strong style="color: #787CC8">保健服务评价记录查询</strong></span>
                </div>
            </div>
        </div>
        <div>
            <div style="width: 160px; float: left; text-align: center;">
                <ul class="ulclass1">
                    <li><a href="Default.aspx">我的预约</a></li>
                    <li><a href="OrderDoctor.aspx">保健医师</a></li>
                    <li><a href="UserOrder.aspx">我要预约</a></li>
                    <li id="admins" runat="server" visible="false"><a href="SetSchedule.aspx">医生排班</a></li>
                    <li id="admins1" runat="server" visible="false"><a href="OrderHistory.aspx">历史记录</a></li>
                    <li id="admins2" runat="server" visible="false" class="liselect"><a style="color: White;" href="PinHistory.aspx">评价记录</a></li>
                </ul>
            </div>
            <%--   <div style="border: 1px solid #CCCCFF; width: 780px; float: right;">--%>
            <div style="float: right;">
                <div style="border: 1px solid #CCCCFF; width: 780px;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnExportExcel" />
                        </Triggers>
                        <ContentTemplate>
                            <div style="background-color: #BFCFFF; height: 60px;">
                                <table style="width: 100%;">
                                    <tr>
                                        <td style="width: 194px">
                                            保健人员
                                            <asp:TextBox ID="TextBox1" runat="server" AutoCompleteType="Disabled" Width="87px"></asp:TextBox>
                                        </td>
                                        <td style="width: 349px">
                                            &nbsp;&nbsp;&nbsp; 单项小于<asp:TextBox ID="TextBox4" runat="server" Width="45px" AutoCompleteType="Disabled" Style="ime-mode: disabled" onkeypress="if ((event.keyCode<48 || event.keyCode>57) && event.keyCode!=45 ) event.returnValue=false;"></asp:TextBox>
                                            &nbsp; 总分小于<asp:TextBox ID="TextBox5" runat="server" Width="60px" AutoCompleteType="Disabled" Style="ime-mode: disabled" onkeypress="if ((event.keyCode<48 || event.keyCode>57) && event.keyCode!=45 ) event.returnValue=false;"></asp:TextBox>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 194px">
                                            保健医师
                                            <asp:DropDownList ID="DropDownList2" runat="server" Width="100px" EnableViewState="true" AutoPostBack="true" OnSelectedIndexChanged="BtnSearch_Clik">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 349px">
                                            &nbsp; 保健日期
                                            <asp:TextBox ID="TextBox2" runat="server" Width="84px" AutoCompleteType="Disabled"></asp:TextBox>
                                            到<asp:TextBox ID="TextBox3" runat="server" Width="94px" AutoCompleteType="Disabled"></asp:TextBox>
                                            <%-- &nbsp; 状 &nbsp; 态&nbsp;
                                            <asp:DropDownList ID="DropDownList1" runat="server" Width="100" AutoPostBack="true" OnSelectedIndexChanged="BtnSearch_Clik">
                                                <asp:ListItem Value="" Selected="True" />
                                                <asp:ListItem Value="已生效" />
                                                <asp:ListItem Value="已取消" />
                                                <asp:ListItem Value="已评价" />
                                            </asp:DropDownList>--%>
                                        </td>
                                        <td>
                                            <asp:Button ID="Button1" runat="server" Text="查询" OnClick="BtnSearch_Clik" />
                                            &nbsp;<asp:Button ID="btnExportExcel" runat="server" Text="导出到Excel" OnClick="BtnSaveToExcel" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div>
                                <asp:Panel ID="Panel4" runat="server">
                                    <asp:Repeater ID="Repeater1" runat="server">
                                        <HeaderTemplate>
                                            <table class="Tmain1" style="width: 780px;">
                                                <tr>
                                                    <th style="width: 40px;">
                                                        序号
                                                    </th>
                                                    <th style="width: 80px;">
                                                        保健人
                                                    </th>
                                                    <th style="width: 80px;">
                                                        联系电话
                                                    </th>
                                                    <th style="width: 120px;">
                                                        所属部门
                                                    </th>
                                                    <th style="width: 80px;">
                                                        保健医师
                                                    </th>
                                                    <th style="width: 100px;">
                                                        预约日期
                                                    </th>
                                                    <th style="width: 100px;">
                                                        预约时间段
                                                    </th>
                                                    <th style="width: 60px;">
                                                        状态
                                                    </th>
                                                    <th style="width: 40px;">
                                                        力道
                                                    </th>
                                                    <th style="width: 40px;">
                                                        舒适
                                                    </th>
                                                    <th style="width: 40px;">
                                                        疗效
                                                    </th>
                                                    <th style="width: 40px;">
                                                        技法
                                                    </th>
                                                    <th style="width: 40px;">
                                                        态度
                                                    </th>
                                                    <th style="width: 40px;">
                                                        总体
                                                    </th>
                                                </tr>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <%# Container.ItemIndex+1 %>
                                                </td>
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
                                                    <%# DateTime.Parse(Eval("STARTTIME").ToString()).ToShortDateString()%>
                                                </td>
                                                <td>
                                                    <%# Eval("USERTIME")%>
                                                </td>
                                                <td>
                                                    <%# Eval("USERSTATE")%>
                                                </td>
                                                <td>
                                                    <%# Eval("LIDAO")%>
                                                </td>
                                                <td>
                                                    <%# Eval("SHUSHIDU")%>
                                                </td>
                                                <td>
                                                    <%# Eval("LIAOXIAO")%>
                                                </td>
                                                <td>
                                                    <%# Eval("JIFA")%>
                                                </td>
                                                <td>
                                                    <%# Eval("FUWUTAIDU")%>
                                                </td>
                                                <td>
                                                    <%# Eval("TOTALSUM")%>
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
                                                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" CurrentPageButtonPosition="Center" UrlPaging="false" AlwaysShow="True" FirstPageText="首页" LastPageText="末页" NextPageText="下一页" OnPageChanged="AspNetPager1_PageChanged" PagingButtonSpacing="3px" PrevPageText="上一页" ShowMoreButtons="False" ShowPageIndexBox="Never" PageSize="60" CenterCurrentPageButton="True">
                                                </webdiyer:AspNetPager>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        </form>
    </body>
    </html>
</asp:Content>
