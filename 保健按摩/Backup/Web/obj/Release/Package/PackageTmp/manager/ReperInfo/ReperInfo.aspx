<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReperInfo.aspx.cs" Inherits="EPReper.Web.manager.ReperInfo.ReperInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>自助维修平台</title>
    <link rel="stylesheet" type="text/css" href="../../Styles/style.css" />
    <link rel="stylesheet" type="text/css" href="../../Styles/css.css" />
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
                    <a href="../../index.aspx" title="首页">首 页</a> <span id="baoxiu" runat="server"><a
                        href="ReperInfo.aspx" title="我要报修" style="margin-left:10px" class="on">报 修</a><a href="ReperInfo.aspx?type=select"
                            title="我要查询" style="margin-left:10px">查 询</a></span> <span id="chaxun" runat="server" visible="false"><a href="ReperInfo.aspx"
                                title="我要报修" style="margin-left:10px">报 修</a><a href="ReperInfo.aspx?type=select" title="我要查询" class="on" style="margin-left:10px">查 询</a></span><span
                                    id="admins" runat="server" visible="false"><a href="../ReperClass/ReperClass_List.aspx"
                                        title="我是管理员" style="margin-left:10px">管理员</a></span>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td align="left" width="40%" id="da" runat="server">
                                <font style="font-size: 20px;font-family:黑体;color="Black;">维修任务申请 </font>
                            </td>
                            <td width="20%" style="font-size: 18px;font-family:黑体;">
                                <%=Tools.CookieHelper.GetCookie("username") %>
                                <a href="../../logout.aspx">注销</a>
                            </td>
                        </tr>
                    </table>
                    <table width="100%" bgcolor="#FFFFFF" style="background: #E4F3FC" class="table" border="0"
                        cellpadding="1" cellspacing="1">
                        <tr class="TR_BG">
                            <td width="8%" align="left" style="font-size: 20px; font-weight: bolder;font-family:黑体;">
                                维修项目
                            </td>
                            <td style="padding-left: 30px; font-size: 20px; font-weight: bolder;font-family:黑体;" align="left"
                                width="92%">
                                维修类别
                            </td>
                        </tr>
                    </table>
                    <table width="100%" bgcolor="#FFFFFF" style="background: #E4F3FC" class="table" border="0"
                        cellpadding="1" cellspacing="1">
                        <tr class="TR_BG_list">
                            <td>
                                <div class="ucts">
                                    <div class="repair" id="ClassView" runat="server">
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <%--<label id="ClassView" runat="server"></label>--%>
                </td>
            </tr>
        </table>
        </form>
    </center>
</body>
</html>
