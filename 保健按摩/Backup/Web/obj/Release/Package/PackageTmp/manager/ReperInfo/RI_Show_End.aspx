<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RI_Show_End.aspx.cs" Inherits="EPReper.Web.manager.ReperInfo.RI_Show_End" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../Styles/css.css" rel="Stylesheet" type="text/css" />
    <link href="../../Styles/style.css" rel="stylesheet" type="text/css" />
    <title>自助维修平台</title>
    <style type="text/css">
        a
        {
            text-decoration: none;
            color: Maroon;
        }
    </style>
</head>
<body>
    <center>
        <form id="form1" runat="server" method="post">
        <div class="header">
            <div class="menu">
                <div class="nav">
                    <a href="../../index.aspx" title="首页">首 页</a><a href="ReperInfo.aspx" style="margin-left:10px" title="我要报修">报
                        修</a><a href="ReperInfo.aspx?type=select" style="margin-left:10px" title="我要查询">查 询</a><a title="我是管理员" style="margin-left:10px" class="on">详细</a>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="left" width="80%">
                                <font style="font-size: 18px; font-weight: bolder; font-family: 黑体;">维修任务详细</font>
                            </td>
                            <td width="20%" style="font-size: 18px; font-family: 黑体;">
                                <%=Tools.CookieHelper.GetCookie("username") %>
                                <a href="../../logout.aspx">注销</a>
                            </td>
                        </tr>
                    </table>
                    <table width="100%" bgcolor="#FFFFFF" style="background: #E6F9F9" class="table" border="0"
                        cellpadding="1" cellspacing="1">
                        <tr class="TR_BG">
                            <td align="right" width="15%" class="TR_BG" style="font-family: 黑体; font-size: 14px;
                                font-weight: bolder;">
                                维修类别：
                            </td>
                            <td align="left" width="85%" class="TR_BG">
                                <label id="cn" runat="server">
                                </label>
                            </td>
                        </tr>
                        <tr class="TR_BG">
                            <td align="right" width="15%" class="TR_BG_list" style="font-family: 黑体; font-size: 14px;
                                font-weight: bolder;">
                                申&nbsp;请&nbsp;人：
                            </td>
                            <td align="left" width="85%" class="TR_BG_list">
                                <asp:Label ID="userName" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr class="TR_BG">
                            <td align="right" width="15%" class="TR_BG_list" style="font-family: 黑体; font-size: 14px;
                                font-weight: bolder;">
                                联系电话：
                            </td>
                            <td align="left" width="85%" class="TR_BG_list">
                                <asp:Label ID="phone" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr class="TR_BG">
                            <td align="right" width="15%" class="TR_BG_list" style="font-family: 黑体; font-size: 14px;
                                font-weight: bolder;">
                                问题描述：
                            </td>
                            <td align="left" width="85%" class="TR_BG_list">
                                <asp:TextBox ID="startComment" runat="server" TextMode="MultiLine" Height="170px"
                                    ReadOnly="true" Width="860px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="TR_BG">
                            <td align="right" width="15%" class="TR_BG_list" style="font-family: 黑体; font-size: 14px;
                                font-weight: bolder;">
                                完成时限：
                            </td>
                            <td align="left" width="85%" class="TR_BG_list">
                                <asp:Label ID="times" runat="server" Text="Label" Style="text-align: left"></asp:Label>
                            </td>
                        </tr>
                        <tr class="TR_BG">
                            <td align="right" width="15%" class="TR_BG_list" style="font-weight: bolder; font-family: 黑体;
                                font-size: 14px; font-weight: bolder;">
                                维修描述：
                            </td>
                            <td align="left" width="85%" class="TR_BG_list">
                                <asp:TextBox ID="overComment" runat="server" TextMode="MultiLine" Height="170px"
                                    Width="860px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="TR_BG">
                            <td align="right" width="15%" class="TR_BG_list">
                            </td>
                            <td align="left" width="85%" class="TR_BG_list">
                                <asp:Button ID="Save" Width="100px" Height="40px" Font-Size="14px" runat="server"
                                    Text="完成任务" Visible="false" OnClick="Save_Click" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
                                    onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'"
                                    onmouseup="this.className='btn3_mouseup'" title="完成任务" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </form>
    </center>
</body>
</html>
