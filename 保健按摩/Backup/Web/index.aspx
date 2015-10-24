<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EPReper.Web.index" %>

<%@ Import Namespace="System.Data" %>
<%@ Register Src="Controls/PageNavigator.ascx" TagName="PageNavigator" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
            <div style="display: none; text-align: center; color: #000; font-size: 14px;">
                <a href="../../RepairHealth.aspx"><strong style="height: 36px; line-height: 32px; float: left; text-decoration: underline;">用户自助首页</strong></a>
                <div style="height: 36px; font-size: xx-large; font-family: 微软雅黑;">
                    自助维修平台</div>
            </div>
            <div class="menu">
                <div class="nav">
                    <a href="index.aspx" title="个人首页" class="on">个人首页</a><a href="../manager/ReperInfo/ReperInfo.aspx" style="margin-left: 10px" title="我要报修">报&nbsp; 修</a><a href="../manager/ReperInfo/ReperInfo.aspx?type=select" style="margin-left: 10px" title="我要查询">查&nbsp; 询</a><span id="admins" runat="server" visible="false"><a href="../manager/ReperClass/ReperClass_List.aspx" style="margin-left: 10px" title="我是管理员">管理员</a><a href="manager/ReperInfo/SelectRI.aspx" style="margin-left: 10px" title="数据统计">数据统计</a></span>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="left" width="40%">
                                <font style="font-size: 20px; font-family: 微软雅黑;">我已报修的任务</font>
                            </td>
                            <td width="40%">
                                <%--             <asp:Button ID="Button1" runat="server" Text="未完成" OnClick="nofinishuser" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="未完成" />&nbsp;&nbsp;&nbsp;<asp:Button ID="Button2" runat="server" Text="已完成"
                                        OnClick="isfinishuser" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
                                        onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'"
                                        onmouseup="this.className='btn3_mouseup'" title="已完成" />&nbsp;&nbsp;&nbsp;<asp:Button
                                            ID="Button3" runat="server" Text="已取消" OnClick="escuser" class="btn3_mouseout"
                                            onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                            onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                            title="已取消" />--%>
                            </td>
                            <td width="20%" style="font-size: 18px; font-family: 微软雅黑;">
                                <%=Tools.CookieHelper.GetCookie("username") %>
                                <a href="logout.aspx">注销</a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%" bgcolor="#FFFFFF" style="background: #E4F3FC" class="table" border="0" cellpadding="1" cellspacing="1">
                        <tr class="TR_BG">
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 5%">
                                报修人
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 5%">
                                负责人
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 10%">
                                维修联系电话
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 10%">
                                维修所属类别排序
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 8%">
                                维修项目
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 22%">
                                原因
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 13%">
                                接受时间
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 13%">
                                要求完成时间
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 8%">
                                状态<asp:DropDownList ID="userdl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="userdl_SelectedIndexChanged">
                                    <%--<asp:ListItem>状 &nbsp; 态</asp:ListItem>--%>
                                    <asp:ListItem>未完成</asp:ListItem>
                                    <asp:ListItem>已完成</asp:ListItem>
                                    <asp:ListItem>已取消</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align='center' valign='middle' class='sysmain_navi' style="width: 6%">
                                任务操作<!--<input type="checkbox" value="-222" onclick="selectAll(this.form,this.checked);" />-->
                            </td>
                        </tr>
                        <asp:Repeater ID="show" runat="server">
                            <HeaderTemplate>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr class='TR_BG_list' onmouseover='overColor(this)' onmouseout='outColor(this)'>
                                    <td align='center' valign='middle' class='sysmain_navi' width='5%'>
                                        <%#((DataRowView)Container.DataItem)["ApplyName"] %>
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' width='5%'>
                                        <%#((DataRowView)Container.DataItem)["RepairName"] %>
                                    </td>
                                    <td align="left" valign="middle" class='sysmain_navi' width='10%'>
                                        <%#((DataRowView)Container.DataItem)["repairPhone"] %>
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' width='10%'>
                                        <%#((DataRowView)Container.DataItem)["ids"] %>
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' width='8%'>
                                        <%#((DataRowView)Container.DataItem)["ClassName"] %>
                                    </td>
                                    <td align='left' valign='middle' class='sysmain_navi' width='22%'>
                                        <%#((DataRowView)Container.DataItem)["StartComment"] %>
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' width='13%'>
                                        <%#((DataRowView)Container.DataItem)["DoTime"] %>
                                    </td>
                                    <td align="center" valign='middle' class='sysmain_navi' width='13%'>
                                        <%#((DataRowView)Container.DataItem)["Times"] %>
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' width='8%'>
                                        <%#((DataRowView)Container.DataItem)["state"] %>
                                    </td>
                                    <td align='center' valign='middle' class='sysmain_navi' width='6%'>
                                        <%#((DataRowView)Container.DataItem)["op"] %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                            </FooterTemplate>
                        </asp:Repeater>
                    </table>
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
                        <uc1:PageNavigator ID="PageNavigator1" runat="server" />
                    </span>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Button ID="Button1" runat="server" Text="我要报修" Font-Size="14px" OnClick="bx" Style="width: 100px; height: 40px; font-family: 微软雅黑;" class="btn5_mouseout" onmouseover="this.className='btn5_mouseover'" onmouseout="this.className='btn5_mouseout'" onmousedown="this.className='btn5_mousedown'" onmouseup="this.className='btn5_mouseup'" title="我要报修" />
                </td>
            </tr>
            <tr>
                <td>
                    <div id="repairInfo" runat="server" visible="false">
                        <table width="100%">
                            <tr>
                                <td align="left" width="40%">
                                    <font style="font-size: 20px; font-family: 微软雅黑;">我负责维修的任务</font>
                                </td>
                                <td width="50%">
                                    <%--<asp:Button ID="wjs" runat="server" Text="未接受" OnClick="nojs" class="btn3_mouseout"
                                        onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                        onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                        title="未接受" />&nbsp;&nbsp;&nbsp;<asp:Button ID="yjs" runat="server" Text="已接受" OnClick="yesjs"
                                            class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                            onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                            title="已接受" />&nbsp;&nbsp;&nbsp;<asp:Button ID="ywc" runat="server" Text="已完成" OnClick="isfinish"
                                                class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                                onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                                title="已完成" />&nbsp;&nbsp;&nbsp;<asp:Button ID="yqx" runat="server" Text="已取消" OnClick="esc"
                                                    class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                                    title="已取消" />--%>
                                </td>
                                <td width="10%">
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <table width="100%" bgcolor="#FFFFFF" style="background: #E4F3FC" class="table" border="0" cellpadding="1" cellspacing="1">
                                        <tr class="TR_BG">
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 5%">
                                                报修人
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 5%">
                                                负责人
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 10%">
                                                联系电话
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 10%">
                                                维修所属类别排序
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 8%">
                                                维修项目
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 22%">
                                                原因
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 13%">
                                                接受时间
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 13%">
                                                要求完成日期
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 8%">
                                                状态<asp:DropDownList ID="repairdl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="repairdl_SelectedIndexChanged">
                                                    <%--<asp:ListItem>状 &nbsp; 态</asp:ListItem>--%>
                                                    <asp:ListItem>未接受</asp:ListItem>
                                                    <asp:ListItem>已接受</asp:ListItem>
                                                    <asp:ListItem>已完成</asp:ListItem>
                                                    <asp:ListItem>已取消</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 6%">
                                                任务操作
                                            </td>
                                        </tr>
                                        <asp:Repeater ID="ReperList" runat="server">
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr class='TR_BG_list' onmouseover='overColor(this)' onmouseout='outColor(this)'>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='5%'>
                                                        <%#((DataRowView)Container.DataItem)["ApplyName"] %>
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='5%'>
                                                        <%#((DataRowView)Container.DataItem)["RepairName"] %>
                                                    </td>
                                                    <td align='left' valign='middle' class='sysmain_navi' width='10%'>
                                                        <%#((DataRowView)Container.DataItem)["applyPhone"] %>
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='10%'>
                                                        <%#((DataRowView)Container.DataItem)["ids"] %>
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='8%'>
                                                        <%#((DataRowView)Container.DataItem)["ClassName"] %>
                                                    </td>
                                                    <td align='left' valign='middle' class='sysmain_navi' width='22%'>
                                                        <%#((DataRowView)Container.DataItem)["StartComment"] %>
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='13%'>
                                                        <%#((DataRowView)Container.DataItem)["DoTime"] %>
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='13%'>
                                                        <%#((DataRowView)Container.DataItem)["Times"] %>
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='8%'>
                                                        <%#((DataRowView)Container.DataItem)["state"] %>
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='6%'>
                                                        <%#((DataRowView)Container.DataItem)["op"] %>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </table>
                                    <span style='margin-right: 5px'>每页显示条数
                                        <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
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
                                        <uc1:PageNavigator ID="PageNavigator2" runat="server" />
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="Div1" runat="server">
                        <table width="100%">
                            <tr>
                                <td align="left" width="40%">
                                    <font style="font-size: 20px; font-family: 微软雅黑;">任务统计</font>
                                </td>
                                <td width="50%">
                                    <%--<asp:Button ID="wjs" runat="server" Text="未接受" OnClick="nojs" class="btn3_mouseout"
                                        onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                        onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                        title="未接受" />&nbsp;&nbsp;&nbsp;<asp:Button ID="yjs" runat="server" Text="已接受" OnClick="yesjs"
                                            class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                            onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                            title="已接受" />&nbsp;&nbsp;&nbsp;<asp:Button ID="ywc" runat="server" Text="已完成" OnClick="isfinish"
                                                class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                                onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                                title="已完成" />&nbsp;&nbsp;&nbsp;<asp:Button ID="yqx" runat="server" Text="已取消" OnClick="esc"
                                                    class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                                    title="已取消" />--%>
                                </td>
                                <td width="10%">
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td>
                                    <table width="100%" bgcolor="#FFFFFF" style="background: #E4F3FC" class="table" border="0" cellpadding="1" cellspacing="1">
                                        <tr class="TR_BG">
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 14%">
                                                任务类型
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 14%">
                                                申报数
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 14%">
                                                完成数
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 14%">
                                                未完成数
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 14%">
                                                接受数
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 14%">
                                                未接受数
                                            </td>
                                            <td align='center' valign='middle' class='sysmain_navi' style="width: 14%">
                                                取消数
                                            </td>
                                        </tr>
                                        <asp:Repeater ID="CountList" runat="server">
                                            <HeaderTemplate>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <tr class='TR_BG_list' onmouseover='overColor(this)' onmouseout='outColor(this)'>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='14%'>
                                                        <%#((DataRowView)Container.DataItem)["ClassName"] %>
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='14%'>
                                                        <%#((DataRowView)Container.DataItem)["ALL"] %>件
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='14%'>
                                                        <%#((DataRowView)Container.DataItem)["Done"] %>件
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='14%'>
                                                        <%#((DataRowView)Container.DataItem)["NoDone"] %>件
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='14%'>
                                                        <%#((DataRowView)Container.DataItem)["Check"] %>件
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='14%'>
                                                        <%#((DataRowView)Container.DataItem)["NoCheck"] %>件
                                                    </td>
                                                    <td align='center' valign='middle' class='sysmain_navi' width='14%'>
                                                        <%#((DataRowView)Container.DataItem)["ESC"] %>件
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                            </FooterTemplate>
                                        </asp:Repeater>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        </form>
    </center>
</body>
</html>
