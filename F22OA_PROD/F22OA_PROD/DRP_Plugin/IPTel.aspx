<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IPTel.aspx.cs" Inherits="IPTel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>EP全国IP电话通讯录</title>
    <style type="text/css">
        body
        {
            font-size: 13px;
            font-family: Arial, "Helvetica Neue" , Helvetica, Sans-Serif;
            color: #1a3e66;
            background-color: #fff;
            text-align: center;
            margin:5px auto;
        }
        table
        {
            border-collapse: collapse;
            border: 1px solid #999;
        }
        tr
        {
            border: 1px solid #999;
            text-align: center;
            height: 30px;
        }
        tr:hover
        {
            background-color: #d7e5f5;
        }
        th
        {
            border: 1px solid #999;
            background-color: #d7e5f5;
            text-align: center;
            font-weight: bold;
            height: 30px;
        }
        td
        {
            border: 1px solid #999;
            text-align: left;
            height: 30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>EP全国IP电话通讯录</h3>
                <div style="width:800px;margin:auto;text-align:left;">
                    IP话机使用说明:<br />
                    1、店铺之间相互拨打请直接拨打分机号码: 如02401<br />
                    2、拨打手机:#+手机号 如 # 13957399229<br />
                    3、拨打固话: #+区号+号码 如 # 0573 82210863
                    <br />
                </div>
                <table align="center" width="800px">
                    <tr>
                        <th colspan="8">
                        查询
                            <asp:TextBox ID="TxtKeys" runat="server"></asp:TextBox> | 
                            <asp:Button ID="BtnSearch" runat="server" BorderWidth="1" Text="查 询" 
                                onclick="BtnSearch_Click" />
                        </th>
                    </tr>
                    <tr><th colspan="8">总部呼叫中心电话</th></tr>
                    <tr>
                        <th>
                            ID
                        </th>
                        <th>
                            总部
                        </th>
                        <th>
                            姓名
                        </th>
                        <th>
                            职位
                        </th>
                        <th colspan="4">
                            呼叫中心号码
                        </th>
                    </tr>
                    <asp:Repeater ID="RPZBData" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%# Container.ItemIndex+1 %>
                                </td>
                                <td>
                                    <%# Eval("PartCom").ToString() %>
                                </td>
                                <td>
                                    <%# Eval("PartLeader").ToString() %>
                                </td>
                                <td>
                                    <%# Eval("PType").ToString() %>
                                </td>
                                <td colspan="4">
                                    <%# Eval("TelCode").ToString() %>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr><th colspan="9">店铺呼叫中心电话</th></tr>
                    <tr>
                        <th>
                            ID
                        </th>
                        <th>
                            分公司
                        </th>
                        <th>
                            督导
                        </th>
                        <th>
                            类型
                        </th>
                        <th>
                            城市
                        </th>
                        <th>
                            店铺编号
                        </th>
                        <th>
                            店铺名称
                        </th>
                        <th>
                            呼叫中心号码
                        </th>
                    </tr>
                    <asp:Repeater ID="RPData" runat="server">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <%# Container.ItemIndex+1 %>
                                </td>
                                <td>
                                    <%# Eval("PartCom").ToString() %>
                                </td>
                                <td>
                                    <%# Eval("PartLeader").ToString() %>
                                </td>
                                <td>
                                    <%# Eval("PType").ToString() %>
                                </td>
                                <td>
                                    <%# Eval("City").ToString() %>
                                </td>
                                <td>
                                    <%# Eval("ShopNo").ToString() %>
                                </td>
                                <td>
                                    <%# Eval("ShopName").ToString() %>
                                </td>
                                <td>
                                    <%# Eval("TelCode").ToString() %>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
             
    </div>
    </form>
</body>
</html>
