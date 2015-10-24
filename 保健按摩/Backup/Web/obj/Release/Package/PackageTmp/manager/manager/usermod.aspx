<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="usermod.aspx.cs" Inherits="EPReper.Web.manager.manager.usermod" %>

<%@ Register TagPrefix="hw" Namespace="UNLV.IAP.WebControls" Assembly="DropDownCheckList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>自助维修平台</title>
    <link href="../../Styles/css.css" rel="Stylesheet" type="text/css" />
    <link href="../../Styles/style.css" rel="stylesheet" type="text/css" />
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
                    <a href="../../index.aspx" title="首页">首 页</a><a href="../ReperInfo/ReperInfo.aspx"
                        style="margin-left: 10px" title="我要报修">报 修</a><a href="../ReperInfo/ReperInfo.aspx?type=select"
                            style="margin-left: 10px" title="我要查询">查 询</a><a href="../ReperClass/ReperClass_List.aspx"
                                title="我是管理员" style="margin-left: 10px" class="on">管理员</a>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF" style="background: #E4F3FC"
                        width="1200px">
                        <tr>
                            <td align="left" width="80%">
                                <%--<asp:Button id="baoxiu" runat="server" onclick="bx" Text="报    修" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="报修"/>--%>
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
                    <table border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF" style="background: #F8FDFF"
                        width="1200px">
                        <tr class="TR_BG_list">
                            <td width="45%" align="right">
                                人员：
                            </td>
                            <td width="10%" align="left">
                                <input type="text" id="username" readonly="readonly" runat="server" />
                            </td>
                            <td align="left" width="45%">
                                <asp:CheckBox ID="admin" runat="server" /><font color="Red" style="font-size: 20px;
                                    font-family: 黑体;">管理员</font>
                            </td>
                            <%--<asp:DropDownList ID="username" runat="server" ClientCodeLocation="../../Scripts/DropDownCheckList.js">
            </asp:DropDownList>--%>
                        </tr>
                        <tr style="height: 10px" class="TR_BG_list">
                            <td width="45%" align="right">
                                电话：
                            </td>
                            <td width="55%" align="left" colspan="2">
                                <input type="text" id="phonenum" runat="server" />
                            </td>
                        </tr>
                        <tr class="TR_BG_list">
                            <td width="45%" align="right">
                                维修类别：
                            </td>
                            <td width="55%" align="left" colspan="2">
                                <asp:CheckBoxList ID="URole" runat="server" DataSourceID="SqlDataSource2" DataTextField="classname"
                                    DataValueField="id">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:EPErperString %>"
                                    SelectCommand="SELECT [id], [classname] FROM [ReperClass] WHERE (([parentID] = @parentID) AND ([isDel] = @isDel))">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="0" Name="parentID" Type="Int32" />
                                        <asp:Parameter DefaultValue="0" Name="isDel" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr class="TR_BG_list">
                            <td colspan="3">
                                <asp:Button ID="Save" runat="server" Width="100px" Height="40px" Font-Size="14px"
                                    Text="保   存" OnClick="Save_Click" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
                                    onmouseout="this.className='btn3_mouseout'" onmousedown="this.className='btn3_mousedown'"
                                    onmouseup="this.className='btn3_mouseup'" title="保存" />
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
