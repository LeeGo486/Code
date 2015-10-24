<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Create.aspx.cs" Inherits="GoodsAllocation_Create" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新建调拨单</title>
    <style type="text/css">
        body
        {
            margin-top:100px;
            font-family: Arial;
            font-size: 12px;
        }
        table
        {
            border-collapse: collapse;
            height: 226px;
            width: 370px;
        }
        tr
        {
            border: 1px solid #C0C0C0;
            text-align: center; /*height: 25px;*/
            border-collapse: collapse;
        }
        tr:hover
        {
            background-color:#eee;
        }
        th
        {
            border: 1px solid #C0C0C0;
            background-color:#eee;
            border-collapse: collapse;
            text-align:right;
            font-weight:normal;
        }
        td
        {
            text-align:left;
            border: 1px solid #C0C0C0;
            border-collapse: collapse;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table align="center">
            <tr>
                <td colspan="2"><p style="color:#F00;">注：打印此调拨单请到退货单查询页面</p></td>
            </tr>
            <tr>
                <th>流水号：</th>
                <td>
                    <asp:TextBox ID="TxtId" runat="server" ReadOnly="True" Width="200px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>发货单号：</th>
                <td>
                    <asp:TextBox ID="TxtBillNo" runat="server" ReadOnly="True" Width="200px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>发货仓店：</th>
                <td>
                    <asp:TextBox ID="TxtSendShop" runat="server"  Width="200px" ReadOnly="True"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>收货仓店：</th>
                <td>
                    <asp:DropDownList ID="DdlReceive" runat="server" AutoPostBack="true"  Width="200px" DataTextField="d_name" DataValueField="depotid" OnSelectedIndexChanged="DdlReceive_SelectedIndexChanged">
                    </asp:DropDownList><br />
                    <asp:Label runat="server" ID="lbRecShopName"></asp:Label>
                </td>
            </tr>
            <tr>
                <th>销售类型：</th>
                <td>
                    <asp:TextBox ID="TxtSellType"  runat="server" ReadOnly="true">订货</asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>换货率：</th>
                <td>
                    <asp:TextBox ID="TxtChangeRange" Text="0" onkeyup="value=value.replace(/[^0-9]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^0-9]/g,''))" runat="server" Width="49px"></asp:TextBox>
                    %</td>
            </tr>
            <tr>
                <th>备注：</th>
                <td>
                    <asp:TextBox ID="TxtRemark" runat="server" Width="210px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:center;">
                    <p>
                        <asp:Label ID="lbresult" ForeColor="Red" runat="server" Text=""></asp:Label>
                    </p>
                    <asp:Button ID="BtnSave" runat="server" Width="80px" Height="30px" Text="保 存" OnClick="BtnSave_Click" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="button" onclick="history.go(-1);" style="width:80px;height:30px;" value="取消" />
                </td>
            </tr>
            
        </table>
    </form>
</body>
</html>
