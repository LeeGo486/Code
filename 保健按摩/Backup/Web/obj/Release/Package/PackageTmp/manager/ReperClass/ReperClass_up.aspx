﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReperClass_up.aspx.cs"
    Inherits="EPReper.Web.manager.ReperClass.ReperClass_up" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="stylesheet" type="text/css" href="../../Styles/css.css" />
    <script src="../../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <link href="../../Styles/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        a
        {
            text-decoration: none;
            color: Maroon;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function picadds() {
            var pic = $("input[@type=radio][name=pic2][checked]").val();
            $("#<%=pic1.ClientID %>").val(pic);
        }
    </script>
    <title>自助维修平台</title>
</head>
<body>
    <center>
        <form id="form1" runat="server" method="post">
        <div class="header">
            <div class="menu">
                <div class="nav">
                    <a href="../../index.aspx" title="首页">首 页</a><a href="ReperInfo.aspx" title="我要报修"
                        style="margin-left: 10px" class="on">报 修</a><a href="ReperInfo.aspx?type=select"
                            style="margin-left: 10px" title="我要查询">查 询</a><span id="admins" runat="server" visible="false"><a
                                href="../ReperClass/ReperClass_List.aspx" title="我是管理员" style="margin-left: 10px">管理员</a></span>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table width="100%" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF"
                        style="background: #E4F3FC;">
                        <tr>
                            <td align="left" width="80%">
                                <%--<asp:Button id="baoxiu" runat="server" onclick="bx" Text="报    修" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="报修" />--%>
                                <asp:Button ID="gz" runat="server" Text="首    页" OnClick="work" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="首页" />&nbsp;&nbsp;
                                <asp:Button ID="mulu" runat="server" Text="目录管理" OnClick="ml" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="目录管理" />&nbsp;&nbsp;
                                <asp:Button ID="renyuan" runat="server" Text="人员管理" OnClick="ry" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="人员管理" />
                            </td>
                            <td width="20%" style="font-size: 18px; font-family: 黑体;">
                                <%=Tools.CookieHelper.GetCookie("username") %>
                                <a href="../../logout.aspx">注销</a>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF" style="background: #F8FDFF;"
                        width="100%">
                        <tr class="TR_BG_list">
                            <td>
                                <asp:DataList ID="DataList1" runat="server" RepeatColumns="15" HorizontalAlign="Center"
                                    ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                                    <ItemTemplate>
                                        <input type="radio" name="pic2" value="<%#Eval("Name") %>" style="bottom: 19px; height: 40px;" />
                                        <img id="Image1" runat="server" style="height: 40px;" src='<%#"../../Images/ico/" +Eval("Name")%>' />
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF" style="background: #F8FDFF"
                        width="100%">
                        <tr class="TR_BG_list">
                            <td>
                                类的名称：
                                <asp:TextBox ID="txtname" runat="server" Width="294px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr class="TR_BG_list">
                            <td colspan="2">
                                <asp:Button ID="Save" runat="server" Width="100px" Height="40px" Text="保   存" Font-Size="14px"
                                    OnClick="Save_Click" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
                                    onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'"
                                    onmouseup="this.className='btn3_mouseup'" title="保存" OnClientClick="picadds()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <input type="hidden" value="" id="pic1" name="pic1" runat="server" />
        </form>
    </center>
</body>
</html>
