<%@ page language="C#" autoeventwireup="true" inherits="Retail, App_Web_n234bbfq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>DRP零售报表分析</title>
    <script type="text/javascript">
        var retailno = -1;
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="MainResourceMgr" EnableViewState="false" GZip="true" runat="server" />
        <ext:Hidden ID="ExcelGridData" runat="server" />
        <ext:Viewport runat="server">
            <Items>
                <ext:RowLayout ID="RowLayout1" runat="server" Split="true">
                    <Rows>
                        <ext:LayoutRow RowHeight="0.4">
                            <ext:GridPanel ID="RetailGrid" AutoScroll="true" Height="350" Title="销售订单数据" TrackMouseOver="true"
                                runat="server" Border="false">
                                <TopBar>
                                    <ext:Toolbar>
                                        <Items>
                                            <ext:TextField ID="TxtRetailNo" runat="server" LabelWidth="40" FieldLabel="单据号"></ext:TextField>
                                            <ext:DateField ID="DTStart" LabelWidth="40" Width="110" LabelAlign="Right" FieldLabel="开始"
                                                runat="server" AllowBlank="true" Format="yyyy-MM-dd">
                                            </ext:DateField>
                                            <ext:DateField ID="DTEnd" LabelWidth="40" Width="110" LabelAlign="Right" FieldLabel="结束"
                                                runat="server" AllowBlank="true" Format="yyyy-MM-dd">
                                            </ext:DateField>
                                            <ext:ComboBox ID="CboState" SelectedIndex="0" Editable="false" LabelWidth="40" LabelAlign="Right" FieldLabel="状态" Width="120" runat="server" AllowBlank="false">
                                                <Items>
                                                    <ext:ListItem Text="所有" Value="" />
                                                    <ext:ListItem Text="未审核" Value=" and chk_sure=0 " />
                                                    <ext:ListItem Text="已审未登帐" Value=" and chk_sure=1 and sure=0 " />
                                                    <ext:ListItem Text="未登帐" Value=" and sure=0 " />
                                                    <ext:ListItem Text="已登账" Value=" and sure=1 " />
                                                </Items>
                                            </ext:ComboBox>
                                            <ext:ToolbarSeparator />
                                            <ext:Button Text=" 查询 " Icon="Zoom">
                                                <Listeners>
                                                    <Click Handler="#{RetailStore}.reload();" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:ToolbarSeparator />
                                            <ext:Button Text="导出数据" AutoPostBack="true" OnClick="BtnSaveToExcel"
                                                Icon="PageExcel">
                                                <Listeners>
                                                    <Click Handler="ExcelGridData.setValue(Ext.encode(RetailGrid.getRowsValues(false)));" />
                                                </Listeners>
                                            </ext:Button>
                                        </Items>
                                    </ext:Toolbar>
                                </TopBar>
                                <Store>
                                    <ext:Store runat="server" ID="RetailStore" OnRefreshData="Report_DataBind" AutoLoad="false">
                                        <Reader>
                                            <ext:JsonReader IDProperty="retailid">
                                                <Fields>
                                                    <ext:RecordField Name="retailid" />
                                                    <ext:RecordField Name="setdate" />
                                                    <ext:RecordField Name="znums" />
                                                    <ext:RecordField Name="zxsums" />
                                                    <ext:RecordField Name="zssums" />
                                                    <ext:RecordField Name="FCalcSums" />
                                                    <ext:RecordField Name="yhsum" />
                                                    <ext:RecordField Name="s_sums" />
                                                    <ext:RecordField Name="vipcode" />
                                                    <ext:RecordField Name="s_name" />
                                                    <ext:RecordField Name="x_name" />
                                                    <ext:RecordField Name="crdate" />
                                                    <ext:RecordField Name="cr_name" />
                                                    <ext:RecordField Name="comment" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                    </ext:Store>
                                </Store>
                                <ColumnModel runat="server">
                                    <Columns>
                                        <ext:RowNumbererColumn Width="30">
                                        </ext:RowNumbererColumn>
                                        <ext:Column Header="单据号" Width="160" DataIndex="retailid" />
                                        <ext:Column Header="销售日期" Width="80" DataIndex="setdate">
                                            <Renderer Handler="return value.substring(0,10);" />
                                        </ext:Column>
                                        <ext:Column Header="数量" Align="Right" Width="50" DataIndex="znums" />
                                        <ext:Column Header="现价金额" Align="Right" Width="70" DataIndex="zxsums" />
                                        <ext:Column Header="结算金额" Align="Right" Width="70" DataIndex="zssums" />
                                        <ext:Column Header="实销金额" Align="Right" Width="70" DataIndex="FCalcSums" />
                                        <ext:Column Header="优惠金额" Align="Right" Width="70" DataIndex="yhsum" />
                                        <ext:Column Header="实收金额" Align="Right" Width="70" DataIndex="s_sums" />
                                        <ext:Column Header="VIP卡号" Width="70" DataIndex="vipcode" />
                                        <ext:Column Header="营业员" Width="50" DataIndex="s_name" />
                                        <ext:Column Header="班组" Width="50" DataIndex="x_name" />
                                        <ext:Column Header="制单日期" Width="80" DataIndex="crdate" >
                                            <Renderer Handler="return value.substring(0,10);" />
                                        </ext:Column>
                                        <ext:Column Header="制单人" Width="50" DataIndex="cr_name" />
                                        <ext:Column Header="备注" DataIndex="comment" />
                                    </Columns>
                                </ColumnModel>
                                <Listeners>
                                    <RowDblClick Handler="retailno=(Ext.getCmp('#{RetailGrid}') && #{RetailGrid}.getSelectionModel().hasSelection() ? #{RetailGrid}.getSelectionModel().getSelected().id:-1);#{RetailSubStore}.reload();" />
                                </Listeners>
                                <SelectionModel>
                                    <ext:CheckboxSelectionModel KeepSelectionOnClick="Always" AllowDeselect="false" SingleSelect="true"></ext:CheckboxSelectionModel>

                                </SelectionModel>
                                <LoadMask ShowMask="true" Msg="正在加载..." />
                            </ext:GridPanel>
                        </ext:LayoutRow>
                        <ext:LayoutRow RowHeight="0.6">
                            <ext:GridPanel ID="RetailSubGrid" AutoScroll="true" Title="销售单据详细信息" TrackMouseOver="true"
                                runat="server" Border="false">
                                <Store>
                                    <ext:Store runat="server" ID="RetailSubStore" OnRefreshData="RetailSub_DataBind" AutoLoad="false">
                                        <Reader>
                                            <ext:JsonReader>
                                                <Fields>
                                                    <ext:RecordField Name="retailid" />
                                                    <ext:RecordField Name="clothingid" />
                                                    <ext:RecordField Name="s_name" />
                                                    <ext:RecordField Name="c_name" />
                                                    <ext:RecordField Name="sizename" />
                                                    <ext:RecordField Name="sizeid" />
                                                    <ext:RecordField Name="nums" />
                                                    <ext:RecordField Name="s_price" />
                                                    <ext:RecordField Name="FSSums" />
                                                    <ext:RecordField Name="x_price" />
                                                    <ext:RecordField Name="xjprice" />
                                                </Fields>
                                            </ext:JsonReader>
                                        </Reader>
                                        <BaseParams>
                                            <ext:Parameter Mode="Raw" Name="rid" Value="retailno"></ext:Parameter>
                                        </BaseParams>
                                    </ext:Store>
                                </Store>
                                <ColumnModel ID="ColumnModel1" runat="server">
                                    <Columns>
                                        <ext:RowNumbererColumn Width="30">
                                        </ext:RowNumbererColumn>
                                        <ext:Column Header="单据号" Width="160" DataIndex="retailid" />
                                        <ext:Column Header="款号" Width="120" DataIndex="clothingid" />
                                        <ext:Column Header="款式名称" Width="90" DataIndex="s_name" />
                                        <ext:Column Header="颜色" Width="70" DataIndex="c_name" />
                                        <ext:Column Header="尺码" Width="70" DataIndex="sizename" />
                                        <ext:Column Header="数量" Align="Right" Width="50" DataIndex="nums" />
                                        <ext:Column Header="结算价" Align="Right" Width="70" DataIndex="s_price" />
                                        <ext:Column Header="结算金额" Align="Right" Width="70" DataIndex="FSSums" />
                                        <ext:Column Header="现价" Align="Right" Width="70" DataIndex="x_price" />
                                        <ext:Column Header="现价金额" Align="Right" Width="70" DataIndex="xjprice" />
                                    </Columns>
                                </ColumnModel>
                                <LoadMask ShowMask="true" Msg="正在加载..." />
                            </ext:GridPanel>
                        </ext:LayoutRow>
                    </Rows>
                </ext:RowLayout>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
