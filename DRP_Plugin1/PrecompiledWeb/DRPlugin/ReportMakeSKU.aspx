<%@ page language="C#" autoeventwireup="true" inherits="ReportMakeSKU, App_Web_n234bbfq" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>款式可定制查询</title>
    <style type="text/css">
        body
        {
            font-size:12px;
        }
        .Tmain
        {
            border-collapse: collapse;
            border: 1px solid #E3E3E3;
        }
        .Tmain tr
        {
            font-family: Arial;
            border: 1px solid #E3E3E3;
            text-align: center;
            height: 20px;
            font-size: 13px;
        }
        .Tmain tr:hover
        {
            font-family: Arial;
            background-color: #F1F1F1;
        }
        .Tmain th
        {
            border: 1px solid #E3E3E3;
            background-color: #F1F1F1;
            text-align: center;
            font-weight: normal;
            vertical-align: middle;
            height: 20px;
        }
        .Tmain td
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
                document.all["<%= ButtonClick.ClientID %>"].click();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="font-family: 楷体">
                    <tr>
                        <td>
                            款式颜色编号:<asp:TextBox ID="TextBox_skc" runat="server" Width="120px" >
                            
                             </asp:TextBox>
                        </td>
                        <td>
                            尺码:<asp:TextBox ID="TextBox_Size" runat="server" Width="120px"> </asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="ButtonClick" runat="server" Text="查询" OnClick="Detail_InfoBind" />
                        </td>
                    </tr>
                   
                </table>
                <table class="Tmain">
                    <tr>
                        <th width="100px">
                            skc
                        </th>
                        <th width="110px">
                            物料编号
                        </th>
                        <th width="170px">
                            物料名称
                        </th>
                        <th width="70px">
                            物料类型
                        </th>
                        <th width="100px">
                            产品群组名称
                        </th>
                        <th width="80px">
                            单件用量
                        </th>
                        <th width="80px">
                            在库库存
                        </th>
                        <th width="80px">
                            可造件数
                        </th>
                        <th width="80px">
                            单位
                        </th>
                    </tr>
                    <asp:Repeater ID="RpInfos" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                        <ItemTemplate>
                            <tr runat="server" id="tr1">
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem,"skc").ToString()%>
                                </td>
                                <td>
                                    <%# Eval("物料编号").ToString()%>
                                </td>
                                <td>
                                    <%# Eval("物料名称").ToString()%>
                                </td>
                                <td>
                                    <%# Eval("物料类型").ToString()%>
                                </td>
                                <td>
                                    <%# Eval("产品群组名称").ToString()%>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "单耗", "{0:0.00}").ToString()%>
                                </td>
                                <td>
                                    <%# DataBinder.Eval(Container.DataItem, "在库库存", "{0:0.00}").ToString()%>
                                </td>
                                <td id="td1">
                                    <%# Eval("可造件数").ToString()%>
                                </td>
                                <td>
                                    <%# Eval("单位").ToString()%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
                 <p style=" color: Red; font-size: small; font-family: 楷体;">
                            说明：若出现某行数据背景为红色、可造件数为0时,需要款式客定,请与公司相关人员联系。</p>
              
    </div>
    </form>
</body>
</html>
