<%@ page language="C#" autoeventwireup="true" enableviewstate="false" inherits="Rank, App_Web_n234bbfq" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>F22店铺销售排名</title>
    <%-- <link href="Styles/Site.css" rel="stylesheet" type="text/css" />--%>
</head>
<body style="margin: 0 auto;">
    <form id="form1" runat="server">
    <ext:ResourceManager ID="MainResourceMgr" EnableViewState="false" runat="server" />
    <!--Report表页面主数据元，自动生成-->
    <ext:Hidden ID="ExcelGridData" runat="server" />
    <ext:Store runat="server" ID="Report_MainStore" OnRefreshData="Report_DataBind" AutoLoad="true">
        <Proxy>
            <ext:PageProxy />
        </Proxy>
        <Reader>
            <ext:JsonReader>
                <Fields>
                    <ext:RecordField Name="系列" />
                    <ext:RecordField Name="款式" />
                    <ext:RecordField Name="上货日期" />
                    <ext:RecordField Name="销售" />
                    <ext:RecordField Name="库存" />
                </Fields>
            </ext:JsonReader>
        </Reader>
    </ext:Store>
    <!--Report页面主表格-->
    <ext:Menu ID="M1" runat="server">
        <Items>
            <ext:MenuItem ID="ToExcel" runat="server" AutoPostBack="true" Icon="Report" OnClick="ToExcel_Click"
                Text="导出Excel">
                <Listeners>
                    <Click Handler="#{ExcelGridData}.setValue(Ext.encode(Report_Grid.getRowsValues(false)));" />
                </Listeners>
            </ext:MenuItem>
        </Items>
    </ext:Menu>
    <ext:GridPanel ID="Report_Grid" ContextMenuID="M1" StoreID="Report_MainStore" TrackMouseOver="true"
        runat="server" StripeRows="true" Header="false" Border="false" AutoScroll="true"
        Height="300" Collapsible="true">
        <ColumnModel ID="Report_ColumnMode" runat="server">
            <Columns>
                <ext:Column Header="波段系列" Width="96" Sortable="true" DataIndex="系列" />
                <ext:Column Header="款式编号" Width="90" Sortable="true" DataIndex="款式" />
                <ext:Column Header="上货日期" Width="70" Sortable="true" DataIndex="上货日期" />
                <ext:Column Header="销售" Width="40" Sortable="true" DataIndex="销售" />
                <ext:Column Header="库存" Width="40" Sortable="true" DataIndex="库存" />
            </Columns>
        </ColumnModel>
        <SelectionModel>
            <ext:RowSelectionModel>
            </ext:RowSelectionModel>
        </SelectionModel>
        <LoadMask ShowMask="true" Msg="正在加载..." />
    </ext:GridPanel>
    <%-- <table width="100%">
        <tr>
            <th>
                波段系列
            </th>
            <th>
                款式编号
            </th>
            <th>
                上货日期
            </th>
            <th>
                销售
            </th>
            <th>
                库存
            </th>
        </tr>
        <asp:Repeater ID="RPData" runat="server">
            <ItemTemplate>
                <tr>
                    <td>
                        <%# Eval("xl").ToString() %>
                    </td>
                    <td>
                        <%# Eval("stycolorid").ToString() %>
                    </td>
                    <td>
                        <%# Eval("get_date").ToString() %>
                    </td>
                    <td>
                        <%# Eval("nums").ToString() %>
                    </td>
                    <td>
                        <%# Eval("k_num").ToString() %>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>--%>
    </form>
</body>
</html>
