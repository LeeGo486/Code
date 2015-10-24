<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReperClass_add.aspx.cs"
    Inherits="EPReper.Web.manager.ReperClass.ReperClass_add" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="../../Styles/css.css" />
    <link rel="Stylesheet" type="text/css" href="../../Styles/style.css" />
    <script src="../../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
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
         <div style="display: none; text-align: center; color: #000; font-size: 14px;">
                <a href="../../RepairHealth.aspx"><strong style="height: 36px; line-height: 32px; float: left; text-decoration: underline;">用户自助首页</strong></a>
                <div style="height: 36px; font-size: xx-large;font-family: 微软雅黑;" >
                    自助维修平台</div>
            </div>
            <div class="menu">
                <div class="nav">
                    <a href="../../index.aspx" title="首页">首 页</a><a href="../ReperInfo/ReperInfo.aspx"
                        style="margin-left: 10px" title="我要报修">报 修</a><a href="../ReperInfo/ReperInfo.aspx?type=select"
                            style="margin-left: 10px" title="我要查询">查 询</a><a href="../ReperClass/ReperClass_List.aspx"
                                title="我是管理员" style="margin-left: 10px" class="on">管理员</a><a href="../ReperInfo/SelectRI.aspx"
                                    style="margin-left: 10px" title="数据统计">数据统计</a>
                </div>
            </div>
        </div>
        <table class="table" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF">
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" bgcolor="#FFFFFF" style="background: #E4F3FC;"
                        width="100%">
                        <tr>
                            <td align="left" width="80%">
                                <%--<asp:Button id="baoxiu" runat="server" onclick="bx" Text="报    修" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
onmouseout="this.className='btn3_mouseout'"
onmousedown="this.className='btn3_mousedown'"
  onmouseup="this.className='btn3_mouseup'"
  title="报修" />--%>
                                <asp:Button ID="mulu" runat="server" Text="目录管理" OnClick="ml" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="目录管理" />&nbsp;&nbsp;
                                <asp:Button ID="renyuan" runat="server" Text="人员管理" OnClick="ry" class="btn3_mouseout"
                                    onmouseover="this.className='btn3_mouseover'" onmouseout="this.className='btn3_mouseout'"
                                    onmousedown="this.className='btn3_mousedown'" onmouseup="this.className='btn3_mouseup'"
                                    title="人员管理" />
                            </td>
                            <td width="20%" style="font-size: 18px; font-family: 微软雅黑;">
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
                                <asp:Button ID="Save" runat="server" Width="100px" Height="40px" Font-Size="14px"
                                    Text="保   存" OnClick="Save_Click" class="btn3_mouseout" onmouseover="this.className='btn3_mouseover'"
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
