<%@ page language="C#" autoeventwireup="true" inherits="Storage, App_Web_n234bbfq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>EP进销存报表</title>
    <script src="js/default.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            font-size: 12px;
            font-family: 微软雅黑,Arial;
            background-color: #dfe8f6;
        }
    </style>
    <script type="text/javascript">
        var currentcon = "";
        function Export2Excel() {
            var type = MainTab.activeTab.id;
            if (type == "GridMain") {
                ExcelGridData.setValue(Ext.encode(GridMain.getRowsValues(false)));
            }
            else if (type == "CJKPGrid") {
                ExcelGridData.setValue(Ext.encode(KPGrid.getRowsValues(false)));
            }
            else if (type == "NoDPDQGrid") {
                ExcelGridData.setValue(Ext.encode(NoDPDQGrid.getRowsValues(false)));
            }
            else if (type == "NoDPKPGrid") {
                ExcelGridData.setValue(Ext.encode(NoDPKPGrid.getRowsValues(false)));
            }
        }
        function ClearCon() {
            currentcon = "";
            TxtSelectedName.setValue("");
            TxtShops.setValue("");
            TreeDepart.root.reload();
        }
        function LoadReportData() {
            var index = MainTab.activeTab.id;
            if (currentcon.indexOf(index) > 0 || currentcon == "")
                return false;
            else {
                MainTab.body.mask('正在刷新数据...');
                Ext.net.DirectMethods.BtnSearch_Report(index, {
                    success: function () {
                        currentcon += "|" + index;
                        MainTab.body.unmask();
                    },
                    failure: function (errorMsg) {
                        Ext.Msg.alert('失败', "数据更新失败，请重试！");
                    }
                });
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" />
    <ext:Hidden ID="ExcelGridData" runat="server" />
    <ext:Viewport ID="Viewport1" runat="server">
        <Items>
            <ext:BorderLayout ID="BorderLayout1" runat="server">
                <West Split="true" Collapsible="true">
                    <ext:TreePanel ID="TreeDepart" runat="server" Title="虚拟结构" Width="250" AutoScroll="true"
                        Border="true">
                        <Loader>
                            <ext:PageTreeLoader RequestMethod="POST" OnNodeLoad="NodeLoad" PreloadChildren="false">
                                <EventMask ShowMask="true" Target="Parent" Msg="正在装载虚拟结构..." />
                            </ext:PageTreeLoader>
                        </Loader>
                        <Root>
                            <ext:AsyncTreeNode NodeID="0" Expanded="true" Expandable="True" Text="虚拟结构" />
                        </Root>
                        <Listeners>
                            <CheckChange Handler="nodeSeleted(node,checked);" />
                            <ContextMenu Handler="if(node.attributes.id=='0') return; else ExpandThis(node);" />
                        </Listeners>
                    </ext:TreePanel>
                </West>
                <Center>
                    <ext:Panel ID="MainPanel" AutoScroll="true" Layout="fit" LabelWidth="60" Title="报表区域">
                        <TopBar>
                            <ext:Toolbar Height="80">
                                <Items>
                                    <ext:TextArea ID="TxtSelectedName" ReadOnly="true" FieldLabel="虚拟结构" Width="300"
                                        Height="50" runat="server">
                                    </ext:TextArea>
                                    <ext:TextArea ID="TxtShops" ReadOnly="true" FieldLabel="店铺" LabelWidth="40" Width="300"
                                        Height="50" runat="server">
                                    </ext:TextArea>
                                    <ext:ButtonGroup Columns="2">
                                        <Items>
                                            <ext:Button ID="Button1" Text="选择店铺" Icon="Group">
                                                <Listeners>
                                                    <Click Handler="ShopsWin.show();" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="Btn2Excel" Text="导出数据" AutoPostBack="true" OnClick="BtnSaveToExcel"
                                                Icon="PageExcel">
                                                <Listeners>
                                                    <Click Handler="Export2Excel();" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="BtnSearch" Text="查询" Icon="Zoom">
                                                <Listeners>
                                                    <Click Handler="LoadReportData();" />
                                                </Listeners>
                                            </ext:Button>
                                            <ext:Button ID="BtnClear" Text="清空条件" Icon="Erase">
                                                <Listeners>
                                                    <Click Handler="ClearCon();" />
                                                </Listeners>
                                            </ext:Button>
                                        </Items>
                                    </ext:ButtonGroup>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>
                        <Items>
                            <ext:TabPanel Border="false" ID="MainTab" AutoScroll="true"  runat="server"  >
                                <Items>
                                    <ext:GridPanel ID="GridMain" AutoScroll="true" AutoHeight="true" Title="门店-当前库存" TrackMouseOver="true"
                                        runat="server" StripeRows="true" Header="false" Border="false" Collapsible="true">
                                        <Store>
                                            <ext:Store runat="server" ID="ReportStore">
                                                <Reader>
                                                    <ext:JsonReader>
                                                        <Fields>
                                                            <ext:RecordField Name="d_name" />
                                                            <ext:RecordField Name="name4" />
                                                            <ext:RecordField Name="name5" />
                                                            <ext:RecordField Name="styleid" />
                                                            <ext:RecordField Name="colorid" />
                                                            <ext:RecordField Name="F" />
                                                            <ext:RecordField Name="s2s" />
                                                            <ext:RecordField Name="s3s" />
                                                            <ext:RecordField Name="s4s" />
                                                            <ext:RecordField Name="s5s" />
                                                            <ext:RecordField Name="s6s" />
                                                            <ext:RecordField Name="total" />
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                        </Store>
                                        <ColumnModel runat="server">
                                            <Columns>
                                                <ext:RowNumbererColumn Width="30">
                                                </ext:RowNumbererColumn>
                                                <ext:Column Header="店铺名称" Width="150" DataIndex="d_name" />
                                                <ext:Column Header="虚拟结构" Width="70" DataIndex="name4" />
                                                <ext:Column Header="虚拟结构" Width="60" DataIndex="name5" />
                                                <ext:Column Header="款号" Width="90" DataIndex="styleid" />
                                                <ext:Column Header="颜色" Width="40" DataIndex="colorid" />
                                                <ext:Column Header="F" Width="30" DataIndex="F" />
                                                <ext:Column Header="2" Width="30" DataIndex="s2s" />
                                                <ext:Column Header="3" Width="30" DataIndex="s3s" />
                                                <ext:Column Header="4" Width="30" DataIndex="s4s" />
                                                <ext:Column Header="5" Width="30" DataIndex="s5s" />
                                                <ext:Column Header="6" Width="30" DataIndex="s6s" />
                                                <ext:Column Header="合计" Width="50" DataIndex="total" />
                                            </Columns>
                                        </ColumnModel>
                                        <LoadMask ShowMask="true" Msg="正在加载..." />
                                    </ext:GridPanel>

                                     <ext:GridPanel ID="CJKPGrid" AutoScroll="true" AutoHeight="true" Title="门店-可配库存" TrackMouseOver="true"
                                        runat="server" StripeRows="true" Header="false" Border="false" Collapsible="true">
                                        <Store>
                                            <ext:Store runat="server" ID="KPStore">
                                                <Reader>
                                                    <ext:JsonReader>
                                                        <Fields>
                                                            <ext:RecordField Name="d_name" />
                                                            <ext:RecordField Name="name4" />
                                                            <ext:RecordField Name="name5" />
                                                            <ext:RecordField Name="styleid" />
                                                            <ext:RecordField Name="colorid" />
                                                            <ext:RecordField Name="F" />
                                                            <ext:RecordField Name="s2s" />
                                                            <ext:RecordField Name="s3s" />
                                                            <ext:RecordField Name="s4s" />
                                                            <ext:RecordField Name="s5s" />
                                                            <ext:RecordField Name="s6s" />
                                                            <ext:RecordField Name="total" />
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                        </Store>
                                        <ColumnModel ID="ColumnModel2" runat="server">
                                            <Columns>
                                                <ext:RowNumbererColumn Width="30">
                                                </ext:RowNumbererColumn>
                                                <ext:Column Header="店铺名称" Width="150" DataIndex="d_name" />
                                                <ext:Column Header="虚拟结构" Width="70" DataIndex="name4" />
                                                <ext:Column Header="虚拟结构" Width="60" DataIndex="name5" />
                                                <ext:Column Header="款号" Width="90" DataIndex="styleid" />
                                                <ext:Column Header="颜色" Width="40" DataIndex="colorid" />
                                                <ext:Column Header="F" Width="30" DataIndex="F" />
                                                <ext:Column Header="2" Width="30" DataIndex="s2s" />
                                                <ext:Column Header="3" Width="30" DataIndex="s3s" />
                                                <ext:Column Header="4" Width="30" DataIndex="s4s" />
                                                <ext:Column Header="5" Width="30" DataIndex="s5s" />
                                                <ext:Column Header="6" Width="30" DataIndex="s6s" />
                                                <ext:Column Header="合计" Width="50" DataIndex="total" />
                                            </Columns>
                                        </ColumnModel>
                                        <LoadMask ShowMask="true" Msg="正在加载..." />
                                    </ext:GridPanel>

                                    <ext:GridPanel ID="NoDPDQGrid" AutoScroll="true" AutoHeight="true" Title="当前库存" TrackMouseOver="true"
                                        runat="server" StripeRows="true" Header="false" Border="false" Collapsible="true">
                                        <Store>
                                            <ext:Store runat="server" ID="NoDPDQStore">
                                                <Reader>
                                                    <ext:JsonReader>
                                                        <Fields>
                                                            <ext:RecordField Name="name4" />
                                                            <ext:RecordField Name="name5" />
                                                            <ext:RecordField Name="styleid" />
                                                            <ext:RecordField Name="colorid" />
                                                            <ext:RecordField Name="F" />
                                                            <ext:RecordField Name="s2s" />
                                                            <ext:RecordField Name="s3s" />
                                                            <ext:RecordField Name="s4s" />
                                                            <ext:RecordField Name="s5s" />
                                                            <ext:RecordField Name="s6s" />
                                                            <ext:RecordField Name="total" />
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                        </Store>
                                        <ColumnModel ID="ColumnModel3" runat="server">
                                            <Columns>
                                                <ext:RowNumbererColumn Width="30">
                                                </ext:RowNumbererColumn>
                                                <ext:Column Header="虚拟结构" Width="70" DataIndex="name4" />
                                                <ext:Column Header="虚拟结构" Width="60" DataIndex="name5" />
                                                <ext:Column Header="款号" Width="90" DataIndex="styleid" />
                                                <ext:Column Header="颜色" Width="40" DataIndex="colorid" />
                                                <ext:Column Header="F" Width="30" DataIndex="F" />
                                                <ext:Column Header="2" Width="30" DataIndex="s2s" />
                                                <ext:Column Header="3" Width="30" DataIndex="s3s" />
                                                <ext:Column Header="4" Width="30" DataIndex="s4s" />
                                                <ext:Column Header="5" Width="30" DataIndex="s5s" />
                                                <ext:Column Header="6" Width="30" DataIndex="s6s" />
                                                <ext:Column Header="合计" Width="50" DataIndex="total" />
                                            </Columns>
                                        </ColumnModel>
                                        <LoadMask ShowMask="true" Msg="正在加载..." />
                                    </ext:GridPanel>

                                    <ext:GridPanel ID="NoDPKPGrid" AutoScroll="true" AutoHeight="true" Title="可配库存" TrackMouseOver="true"
                                        runat="server" StripeRows="true" Header="false" Border="false" Collapsible="true">
                                        <Store>
                                            <ext:Store runat="server" ID="NoDPKPStore">
                                                <Reader>
                                                    <ext:JsonReader>
                                                        <Fields>
                                                            <ext:RecordField Name="name4" />
                                                            <ext:RecordField Name="name5" />
                                                            <ext:RecordField Name="styleid" />
                                                            <ext:RecordField Name="colorid" />
                                                            <ext:RecordField Name="F" />
                                                            <ext:RecordField Name="s2s" />
                                                            <ext:RecordField Name="s3s" />
                                                            <ext:RecordField Name="s4s" />
                                                            <ext:RecordField Name="s5s" />
                                                            <ext:RecordField Name="s6s" />
                                                            <ext:RecordField Name="total" />
                                                        </Fields>
                                                    </ext:JsonReader>
                                                </Reader>
                                            </ext:Store>
                                        </Store>
                                        <ColumnModel ID="ColumnModel4" runat="server">
                                            <Columns>
                                                <ext:RowNumbererColumn Width="30">
                                                </ext:RowNumbererColumn>
                                                <ext:Column Header="虚拟结构" Width="70" DataIndex="name4" />
                                                <ext:Column Header="虚拟结构" Width="60" DataIndex="name5" />
                                                <ext:Column Header="款号" Width="90" DataIndex="styleid" />
                                                <ext:Column Header="颜色" Width="40" DataIndex="colorid" />
                                                <ext:Column Header="F" Width="30" DataIndex="F" />
                                                <ext:Column Header="2" Width="30" DataIndex="s2s" />
                                                <ext:Column Header="3" Width="30" DataIndex="s3s" />
                                                <ext:Column Header="4" Width="30" DataIndex="s4s" />
                                                <ext:Column Header="5" Width="30" DataIndex="s5s" />
                                                <ext:Column Header="6" Width="30" DataIndex="s6s" />
                                                <ext:Column Header="合计" Width="50" DataIndex="total" />
                                            </Columns>
                                        </ColumnModel>
                                        <LoadMask ShowMask="true" Msg="正在加载..." />
                                    </ext:GridPanel>
                                </Items>
                                <Listeners>
                                    <TabChange Fn="LoadReportData" />
                                </Listeners>
                            </ext:TabPanel>
                        </Items>
                    </ext:Panel>
                </Center>
                <South Collapsible="false">
                    <ext:Panel ID="Panel2" Border="false" Height="25" runat="server">
                        <Items>
                            <ext:StatusBar runat="server" AutoHeight="true" ID="sbar">
                                <Items>
                                    <ext:ToolbarSeparator ID="ToolbarSeparator2" runat="server" />
                                    <ext:Label Html="CopyRight©2010 <a href='http://www.elegant-prosper.com' target='_blank'>浙江雅莹</a> 版权所有"
                                        Text="">
                                    </ext:Label>
                                    <ext:ToolbarSeparator ID="ToolbarSeparator1" runat="server" />
                                    <ext:Label Html="系统支持:<a href='http://192.168.0.34' target='_blank'>信息管理部</a>" Text="">
                                    </ext:Label>
                                </Items>
                            </ext:StatusBar>
                        </Items>
                    </ext:Panel>
                </South>
            </ext:BorderLayout>
        </Items>
    </ext:Viewport>
    <ext:Window runat="server" ID="ShopsWin" Collapsible="true" Title="请选择要查看的店铺" Hidden="true" Icon="User"
        Width="330" AutoHeight="true" Resizable="true">
        <TopBar>
            <ext:Toolbar>
                <Items>
                    <ext:TextField ID="TxtSearch" EmptyText="请输入搜索条件" runat="server">
                    </ext:TextField>
                    <ext:Button ID="BtnSearchShops" Text="搜索" Icon="Zoom">
                        <Listeners>
                            <Click Handler="PagingToolBar.doLoad();" />
                        </Listeners>
                    </ext:Button>
                </Items>
            </ext:Toolbar>
        </TopBar>
        <Items>
            <ext:GridPanel ID="Shops_Grid" Layout="fit" AnchorHorizontal="100%" AutoScroll="true"
                Height="450" runat="server" StripeRows="true" Header="false"
                Border="false">
                <Store>
                    <ext:Store runat="server" ID="Shops_MainStore" AutoLoad="true" OnRefreshData="Shops_DataBind">
                        <Proxy>
                            <ext:PageProxy />
                        </Proxy>
                        <Reader>
                            <ext:JsonReader>
                                <Fields>
                                    <ext:RecordField Name="depotid" />
                                    <ext:RecordField Name="d_name" />
                                </Fields>
                            </ext:JsonReader>
                        </Reader>
                        <BaseParams>
                            <ext:Parameter Name="start" Value="0" Mode="Raw">
                            </ext:Parameter>
                            <ext:Parameter Name="limit" Value="30" Mode="Raw">
                            </ext:Parameter>
                        </BaseParams>
                    </ext:Store>
                </Store>
                <ColumnModel runat="server">
                    <Columns>
                        <ext:RowNumbererColumn Width="30">
                        </ext:RowNumbererColumn>
                        <ext:Column Header="店铺编号" Width="70" Sortable="true" DataIndex="depotid" />
                        <ext:Column Header="店铺名称" Width="150" Sortable="true" DataIndex="d_name" />
                    </Columns>
                </ColumnModel>
                <LoadMask ShowMask="true" Msg="正在加载..." />
                <Listeners>
                    <RowClick Handler="SetWinData(rowIndex);" />
                </Listeners>
                <SelectionModel>
                    <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" />
                </SelectionModel>
                <BottomBar>
                    <ext:PagingToolbar ID="PagingToolBar" StoreID="Shops_MainStore" PageSize="30" runat="server" />
                </BottomBar>
            </ext:GridPanel>
        </Items>
    </ext:Window>
    </form>
</body>
</html>