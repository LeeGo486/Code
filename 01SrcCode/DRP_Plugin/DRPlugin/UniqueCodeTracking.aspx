<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UniqueCodeTracking.aspx.cs" Inherits="UniqueCodeTracking_" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>唯一码查询</title>
    <style type="text/css">
        body
        {
            font-size:12px;
        }
        .DataList
        {
            border-collapse: collapse;
            border: 1px solid #E3E3E3;
        }
        .DataList tr
        {
            font-family: Arial;
            border: 1px solid #E3E3E3;
            text-align: center;
            height: 20px;
            font-size: 13px;
        }
        .DataList tr:hover
        {
            font-family: Arial;
            background-color: #F1F1F1;
        }
        .DataList th
        {
            border: 1px solid #E3E3E3;
            background-color: #F1F1F1;
            text-align: center;
            font-weight: normal;
            vertical-align: middle;
            height: 20px;
        }
        .DataList td
        {
            vertical-align: middle;
            border: 1px solid #E3E3E3;
            height: 20px;
            overflow: hidden;
            white-space: nowrap;
            color: #666;
        }
    </style>
    <script language="javascript" type="text/javascript">
        function EnterTextBox() {
            if (event.keyCode == 13) {
                event.returnValue = false;
                document.all["<%= Search.ClientID %>"].click();
                }
            }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td>唯一码：
                    <asp:TextBox ID="txtUniqueCode" runat="server" Width="120px"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="Search" runat="server" Text="查询" OnClick="UniqCodeSearch" />
                </td>
            </tr>
        </table>
        <table class="DataList">
            <tr>
                <th width="100px">
                    唯一码
                </th>
                <th width="110px">
                    SKU
                </th>
                <th width="170px">
                    发货单号
                </th>
                <th width="70px">
                    发货人
                </th>
                <th width="100px">
                    收货加盟商编号
                </th>
                <th width="80px">
                    收货加盟商
                </th>
                <th width="110px">
                    收货店铺编号
                </th>
                <th width="150px">
                    收货店铺
                </th>
                <th width="100px">
                    发货日期
                </th>
                <th width="100px">
                    发货日期
                </th>
            </tr>
            <asp:Repeater ID="RpInfos" runat="server">
                    <ItemTemplate>
                        <tr runat="server" id="tr1">
                            <td>
                                <%# Eval("唯一码").ToString()%>
                            </td>
                            <td>
                                <%# Eval("SKU").ToString()%>
                            </td>
                            <td>
                                <%# Eval("发货单号").ToString()%>
                            </td>
                            <td>
                                <%# Eval("发货人").ToString()%>
                            </td>
                            <td>
                                <%# Eval("收货加盟商编号").ToString()%>
                            </td>
                            <td>
                                <%# Eval("收货加盟商").ToString()%>
                            </td>
                            <td>
                                <%# Eval("收货店铺编号").ToString()%>
                            </td>
                            <td>
                                <%# Eval("收货店铺").ToString()%>
                            </td>
                            <td>
                                <%# Eval("发货日期").ToString()%>
                            </td>
                            <td>
                                <%# Eval("收货日期").ToString()%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
        </table>
    </div>
    </form>
</body>
</html>
