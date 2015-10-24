<%@ page language="C#" autoeventwireup="true" inherits="VipRetail, App_Web_n234bbfq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>VIP销售记录</title>

</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="MainResourceMgr" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server">
            <Items>
                <ext:FitLayout>
                    <Items>
                        <ext:GridPanel ID="RetailGrid" AutoScroll="true" Title="VIP消费记录" TrackMouseOver="true"
                            runat="server" Border="false">
                            <TopBar>
                                <ext:Toolbar>
                                    <Items>
                                        <ext:TextField ID="TxtVIPNo" runat="server" LabelWidth="40" FieldLabel="卡号">
                                        </ext:TextField>
                                        <ext:Button ID="BtnSearch" Text="查询" Icon="Zoom" runat="server">
                                            <Listeners>
                                                <Click Handler="#{RetailStore}.reload();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:ToolbarSeparator />
                                        <ext:Label ID="lbInfo" Margins="0 0 0 10px" runat="server"></ext:Label>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Store>
                                <ext:Store runat="server" ID="RetailStore" OnRefreshData="Report_DataBind" AutoLoad="false">
                                    <Reader>
                                        <ext:JsonReader>
                                            <Fields>
                                                <ext:RecordField Name="vipcode" />
                                                <ext:RecordField Name="depotid" />
                                                <ext:RecordField Name="d_name" />
                                                <ext:RecordField Name="setdate" />
                                                <ext:RecordField Name="clothingid" />
                                                <ext:RecordField Name="x_price" />
                                                <ext:RecordField Name="discount" />
                                                <ext:RecordField Name="s_price" />
                                                <ext:RecordField Name="FSSums" />
                                                <ext:RecordField Name="znums" />
                                                <ext:RecordField Name="vipcentum" />
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn Width="30">
                                    </ext:RowNumbererColumn>
                                    <ext:Column Header="VIP卡号" Width="160" DataIndex="vipcode" />
                                    <ext:Column Header="店铺ID" Width="80" DataIndex="depotid" />
                                    <ext:Column Header="店铺名称" Width="150" DataIndex="d_name" />
                                    <ext:Column Header="销售时间" Width="80" DataIndex="setdate" >
                                            <Renderer Handler="return value.substring(0,10);" />
                                        </ext:Column>
                                    <ext:Column Header="款号" Width="120" DataIndex="clothingid" />
                                    <ext:Column Header="现价" Align="Right" Width="70" DataIndex="x_price" />
                                    <ext:Column Header="折扣" Align="Right" Width="70" DataIndex="discount" />
                                    <ext:Column Header="结算价" Align="Right" Width="70" DataIndex="s_price" />
                                    <ext:Column Header="数量" Align="Right" Width="50" DataIndex="znums" />
                                    <ext:Column Header="金额" Align="Right" Width="70" DataIndex="FSSums" />
                                    <ext:Column Header="积分" Align="Right" Width="50" DataIndex="vipcentum" />
                                </Columns>
                            </ColumnModel>
                            <LoadMask ShowMask="true" Msg="正在加载..." />
                        </ext:GridPanel>
                    </Items>
                </ext:FitLayout>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
