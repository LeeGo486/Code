<%@ page language="C#" autoeventwireup="true" inherits="EPIPTel, App_Web_n234bbfq" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>EP全国IP电话通讯录</title>
    <link href="Scripts/jquery.treeview.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery.treeview.js" type="text/javascript"></script>
    </script><script src="Scripts/jquery.copy.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $("#browser").treeview();
        })
        function CopayValue(callnum) {
            $.copy(callnum);
            // alert("成功复制到剪贴板");
        }
    </script>
    <style type="text/css">
        .Tmain1
        {
            border-collapse: collapse;
            border: 1px solid #E3E3E3;
        }
        .Tmain1 tr
        {
            border: 1px solid #E3E3E3;
            text-align: center;
            height: 20px;
            font-size: 13px;
        }
        .Tmain1 tr:hover
        {
            background-color: #F1F1F1;
        }
        .Tmain1 th
        {
            border: 1px solid #E3E3E3;
            background-color: #F1F1F1;
            text-align: center;
            font-weight: normal;
            height: 20px;
        }
        .Tmain1 td
        {
            border: 1px solid #E3E3E3;
            height: 20px;
            overflow: hidden;
            color: #666;
        }
        
        .style1
        {
            font-size: medium;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
<%--    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>--%>
    <div style="width: 900px; margin: 0px; padding-left: 200px; font-family: 微软雅黑;">
        <div style="padding-left: 300px; font-weight: 700; font-size: large;" class="style1">
            EP全国IP电话通讯录</div>
        <div style="text-align: left;">
            IP话机使用说明：<br />
            1、店铺之间相互拨打请直接拨打分机号码：如02401
            <br />
            2、拨打手机：#+手机号码 如 # 13957399229
            <br />
            3、拨打固话：#+区号+号码 如 #0573 82210863
        </div>
    </div>
    <div style="width: 920px; margin: 0px; padding-left: 200px; font-family: 微软雅黑;">
        <div style="float: left; width: 550px;">
            <div style="float: left; width: 550px;">
                <div style="background-color: #F1F1F1; font-weight: 700; font-size: large; text-align: center;">
                    总部呼叫中心电话
                </div>
              <%--  <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <contenttemplate>--%>
                        <div>
                            <asp:Repeater ID="Repeater2" runat="server">
                                <HeaderTemplate>
                                    <table class="Tmain1">
                                        <tr>
                                            <th style="width: 120px;">
                                                总部
                                            </th>
                                            <th style="width: 80px;">
                                                姓名
                                            </th>
                                            <th style="width: 180px;">
                                                职位
                                            </th>
                                            <th style="width: 80px;">
                                                分机号
                                            </th>
                                            <th style="width: 80px;">
                                                操作
                                            </th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            总部
                                        </td>
                                        <td>
                                            <%# Eval("Name")%>
                                        </td>
                                        <td>
                                            <%# Eval("Postion")%>
                                        </td>
                                        <td>
                                            <%# Eval("CALLCENTERNUM")%>
                                        </td>
                                        <td>
                                            <a href="javascript:;" onclick="CopayValue('<%# Eval("CALLCENTERNUM")%>')">复制</a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                    <asp:Label ID="lblEmpty2" Text="无记录..." runat="server" Visible='<%# Repeater2.Items.Count==0 %>'></asp:Label>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                   <%-- </contenttemplate>
                </asp:UpdatePanel>--%>
            </div>
            <br />
            <br />
            <br />
            <div style="float: left; width: 550px;">
                <div style="background-color: #F1F1F1; font-weight: 700; font-size: large; text-align: center;">
                    店铺自助输入查询
                </div>
              <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <contenttemplate>--%>
                        <table>
                            <tr>
                                <td>
                                    请输入店铺名称
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="server" AutoCompleteType="Disabled"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Button ID="Button1" runat="server" Text="查询" OnClick="Button1_Click" />
                                </td>
                            </tr>
                        </table>
                        <div>
                            <asp:Repeater ID="Repeater1" runat="server">
                                <HeaderTemplate>
                                    <table class="Tmain1">
                                        <tr>
                                            <th style="width: 120px;">
                                                分公司
                                            </th>
                                            <th style="width: 80px;">
                                                督导
                                            </th>
                                            <th style="width: 80px;">
                                                类型
                                            </th>
                                            <th style="width: 180px;">
                                                店铺名称
                                            </th>
                                            <th style="width: 80px;">
                                                分机号
                                            </th>
                                            <th style="width: 80px;">
                                                操作
                                            </th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <%# Eval("DQ")%>
                                        </td>
                                        <td>
                                            <%# Eval("SUPERVISOR")%>
                                        </td>
                                        <td>
                                            <%# Eval("CHANNEL")%>
                                        </td>
                                        <td>
                                            <%# Eval("SHOPNAME")%>
                                        </td>
                                        <td>
                                            <%# Eval("CALLCENTERNUM")%>
                                        </td>
                                        <td>
                                            <a href="javascript:;" onclick="CopayValue('<%# Eval("CALLCENTERNUM")%>')">复制</a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </table>
                                    <asp:Label ID="lblEmpty" Text="无记录..." runat="server" Visible='<%# Repeater1.Items.Count==0 %>'></asp:Label>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    <%--</contenttemplate>
                </asp:UpdatePanel>--%>
            </div>
        </div>
        <div style="float: left; width: 350px; border-left: 1px solid #E3E3E3;">
            <div id="Div1" runat="server" style="float: left; padding-left: 20px; width: 350px; font-weight: 700; font-size: large;">
                店铺树选择
                <br />
            </div>
            <div id="DivTree" runat="server" style="float: left; padding-left: 20px; width: 350px; font-family: 微软雅黑; font-size: small;">
            </div>
        </div>
    </div>
    </form>
</body>
</html>
