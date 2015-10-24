<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowRI.aspx.cs" Inherits="EPReper.Web.manager.ReperInfo.ShowRI" %>

<%@ Import Namespace="System.Data" %>
<%@ Register Src="../../Controls/PageNavigator.ascx" TagName="PageNavigator" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>自助维修平台</title>
    <link href="../../Styles/css.css" rel="Stylesheet" type="text/css" />
    <link href="../../Styles/style.css" rel="Stylesheet" type="text/css" />
    <style type="text/css">
        a
        {
            text-decoration: none;
            color: Maroon;
        }
    </style>
    <script src="../../Scripts/public.js" type="text/javascript"></script>
</head>
<body>
    <center>
        <form id="form1" runat="server">
        <div class="header">
            <div class="menu">
                <div class="nav">
                    <a href="../../index.aspx" title="首页">首 页</a><a href="ReperInfo.aspx" style="margin-left:10px" title="我要报修">报
                        修</a><a href="ReperInfo.aspx?type=select" style="margin-left:10px" title="我要查询" class="on">查 询</a><span id="admins"
                            runat="server" visible="false"><a href="../ReperClass/ReperClass_List.aspx" style="margin-left:10px" title="我是管理员">管理员</a></span>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="left" width="80%" colspan="2">
                                <font style="font-size: 20px;font-weight:bolder; font-family:黑体;">维修排名</font>
                            </td>
                            <td width="20%" style="font-size: 18px;font-family:黑体;">
                                <%=Tools.CookieHelper.GetCookie("username") %>
                                <a href="../../logout.aspx">注销</a>
                            </td>
                        </tr>
                    </table>
                    <asp:Repeater ID="show" runat="server">
                        <HeaderTemplate>
                            <table width="100%" bgcolor="#FFFFFF" style="background: #E4F3FC" class="table" border="0"
                                cellpadding="1" cellspacing="1">
                                <tr class="TR_BG">
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 5%">
                                        报修人
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 9%">
                                        报修人联系电话
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 5%">
                                        负责人
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 9%">
                                        负责人联系电话
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 13%">
                                        维修所属类别排序
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 5%">
                                        状态
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 8%">
                                        维修项目
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 22%">
                                        原因
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 12%">
                                        接受时间
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 12%">
                                        要求完成时间
                                    </td>
                                    <%--                                    <td align='center' valign='middle' class='sysmain_navi' style="width: 60px">
                                        任务操作<!--<input type="checkbox" value="-222" onclick="selectAll(this.form,this.checked);" />-->
                                    </td>--%>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class='TR_BG_list' onmouseover='overColor(this)' onmouseout='outColor(this)'>
                                <td align='center' valign='middle' class='sysmain_navi' width='5%'>
                                    <%#((DataRowView)Container.DataItem)["ApplyName"] %>
                                </td>
                                <td align='left' valign='middle' class='sysmain_navi' width='9%'>
                                    <%#((DataRowView)Container.DataItem)["applyPhone"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='5%'>
                                    <%#((DataRowView)Container.DataItem)["RepairName"] %>
                                </td>
                                <td align='left' valign='middle' class='sysmain_navi' width='9%'>
                                    <%#((DataRowView)Container.DataItem)["repairPhone"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='13%'>
                                    <%#((DataRowView)Container.DataItem)["ids"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='5%'>
                                    <%#((DataRowView)Container.DataItem)["state"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='8%'>
                                    <%#((DataRowView)Container.DataItem)["ClassName"] %>
                                </td>
                                <td align='left' valign='middle' class='sysmain_navi' width='22%'>
                                    <%#((DataRowView)Container.DataItem)["StartComment"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='12%'>
                                    <%#((DataRowView)Container.DataItem)["DoTime"] %>
                                </td>
                                <td align='center' valign='middle' class='sysmain_navi' width='12%'>
                                    <%#((DataRowView)Container.DataItem)["Times"] %>
                                </td>
                                <%--                                <td align='center' valign='middle' class='sysmain_navi' width='60px'>
                                    <%#((DataRowView)Container.DataItem)["op"] %>
                                </td>--%>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                    <span style='margin-right: 5px'>每页显示条数
                        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                            <asp:ListItem>5</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem>15</asp:ListItem>
                            <asp:ListItem>20</asp:ListItem>
                            <asp:ListItem>25</asp:ListItem>
                            <asp:ListItem>30</asp:ListItem>
                            <asp:ListItem>50</asp:ListItem>
                            <asp:ListItem>100</asp:ListItem>
                            <asp:ListItem>200</asp:ListItem>
                        </asp:DropDownList>
                        <uc2:PageNavigator ID="PageNavigator1" runat="server" />
                    </span>&nbsp;
                </td>
            </tr>
        </table>
        </form>
    </center>
</body>
</html>
