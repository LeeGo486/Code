<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Detail.aspx.cs" Inherits="GoodsAllocation_Detail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>跨公司调拨单</title>
    <style type="text/css">
        body {
            margin-top: 100px;
            font-family: Arial;
            font-size: 12px;
        }

        table {
            border-collapse: collapse;
        }

        tr {
            border: 1px solid #C0C0C0;
            text-align: center; /*height: 25px;*/
            border-collapse: collapse;
        }
        th {
            border: 1px solid #C0C0C0;
            background-color: #eee;
            border-collapse: collapse;
            text-align: right;
            font-weight: normal;
            padding:0px 10px;
            height:30px;
        }

        td {
            text-align: left;
            border: 1px solid #C0C0C0;
            border-collapse: collapse;
            height:30px;
        }
    </style>
    <script type="text/javascript">
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        function Back2Search() {
            window.open("Search.aspx?depotid=" + GetQueryString("depotid") + "&userid=" + GetQueryString("userid"));
        }
        function EnterTextBox(event, obj) {
            if (event.keyCode == 13 && !isNull(obj.value)) {
                if (!isNull(obj.value)) {
                    document.getElementById("<%= btnSure.ClientID %>").click();
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table align="center" width="650px">
                    <tr>
                        <th colspan="5" style="text-align: left;">跨公司调拨单操作：<asp:Label ID="lbinfo" runat="server"></asp:Label>
                        </th>
                        <th>
                            <input type="button" onclick="Back2Search();" value="返回查询界面" /></th>
                    </tr>
                    <tr>
                        <th>条码：</th>
                        <td>
                            <asp:TextBox ID="TxtSkc" runat="server" onkeydown="EnterTextBox(event, this);"></asp:TextBox>
                            <asp:Button ID="btnSure" runat="server" Text="录入" OnClick="btnSure_Click" />
                        </td>
                        <td>
                            <asp:RadioButton ID="RbtnZ" runat="server" Checked="True" GroupName="ZF" Text="正（+）" />
                            <asp:RadioButton ID="RbtnF" runat="server" GroupName="ZF" Text="负（-）" />
                        </td>
                        <th>数量：</th>
                        <td>
                            <asp:TextBox ID="TxtNum" onkeyup="value=value.replace(/[^0-9]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^0-9]/g,''))" runat="server" Width="36px" Text="1"></asp:TextBox>
                        </td>
                        <td>品牌：<asp:Label ID="lbbrand" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="text-align:center">
                            <asp:Label ID="lbResult" runat="server" Font-Size="10pt" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <table style="width:100%;height:100%;" align="center">
                                <tr>
                                        <th style="text-align:center;">款号</th>
                                        <th style="text-align:center;">款式名称</th>
                                        <th style="text-align:center;">颜色</th>
                                        <th style="text-align:center;">尺码</th>
                                        <th style="text-align:center;">数量</th>
                                        <th style="text-align:center;">单价</th>
                                    </tr>
                            <asp:Repeater ID="RP" runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td style="text-align:center;height:25px;"><%# Eval("clothingid").ToString() %></tdstyle="text-align:center;">
                                        <td style="text-align:center;height:25px;"><%# Eval("s_name").ToString() %></tdstyle="text-align:center;">
                                        <td style="text-align:center;height:25px;"><%# Eval("c_name").ToString() %></tdstyle="text-align:center;">
                                        <td style="text-align:center;height:25px;"><%# Eval("sizeid").ToString() %></tdstyle="text-align:center;">
                                        <td style="text-align:center;height:25px;"><%# Eval("set_nums").ToString() %></tdstyle="text-align:center;">
                                        <td style="text-align:center;height:25px;"><%# Eval("x_price").ToString() %></tdstyle="text-align:center;">
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                                <tr><th colspan="6">数量合计：<asp:Label ID="lbtotal" runat="server" Font-Bold="True"></asp:Label>
                                    </th></tr>
                                </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

    </form>
</body>
</html>
