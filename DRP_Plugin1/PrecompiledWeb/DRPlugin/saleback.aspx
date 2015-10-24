<%@ page language="C#" autoeventwireup="true" enableviewstate="false" inherits="saleback, App_Web_n234bbfq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>退货申请</title>
    <style type="text/css">
        .ext-ie .button-fix table.x-btn,
        .ext-gecko .button-fix table.x-btn{
            top:0px;            
        }
        .ext-ie .button-fix .x-form-text,
        .ext-gecko .button-fix .x-form-text{
            margin-top:1px;
        }
    </style>
</head>
<body style="margin: 0 auto;">
    <form id="form1" runat="server">
    <ext:ResourceManager ID="MainResourceMgr" EnableViewState="false" GZip="true" runat="server" />
    <ext:Hidden ID="ExcelGridData" runat="server" />
    <ext:GridPanel ID="checknum_Grid" Layout="fit" AnchorHorizontal="100%" AutoScroll="true"
        Height="420" TrackMouseOver="true" runat="server" StripeRows="true" Header="false"
        Border="false" Collapsible="true">
        <TopBar>
            <ext:Toolbar ID="MainToolBar" runat="server">
                <Content>
                    <ext:Label runat="server" ID="lblistno">
                    </ext:Label>
                </Content>
                <Items>
                    <ext:FileUploadField ID="UpFile" runat="server" Width="200" CtCls="button-fix"  ButtonText="浏览..." AllowBlank="false"
                        EmptyText="请选择文件" Icon="LinkAdd" />
                    <ext:Button runat="server" ID="btnsave" Text="导入" Icon="ArrowIn">
                        <DirectEvents>
                            <Click OnEvent="Btnsave_Click">
                                <EventMask ShowMask="true" Msg="正在导入，请稍后..." />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:ToolbarSeparator />
                    <ext:Button runat="server" ID="BtnInsert" Icon="DiskUpload" Text="保存数据">
                        <DirectEvents>
                            <Click OnEvent="BtnInsert_Click">
                                <EventMask ShowMask="true" Msg="正在保存，请稍后..." />
                            </Click>
                        </DirectEvents>
                        <Listeners>
                            <Click Handler="#{ExcelGridData}.setValue(Ext.encode(checknum_Grid.getRowsValues(false)));" />
                        </Listeners>
                    </ext:Button>
                </Items>
            </ext:Toolbar>
        </TopBar>
        <Store>
            <ext:Store runat="server" ID="checknum_MainStore" OnRefreshData="checknum_DataBind"
                ShowWarningOnFailure="false">
                <Reader>
                    <ext:JsonReader>
                        <Fields>
                            <ext:RecordField Name="sku" />
                            <ext:RecordField Name="color" />
                            <ext:RecordField Name="F" />
                            <ext:RecordField Name="F4" />
                            <ext:RecordField Name="F5" />
                            <ext:RecordField Name="F6" />
                            <ext:RecordField Name="F7" />
                            <ext:RecordField Name="F8" />
                            <ext:RecordField Name="F9" />
                        </Fields>
                    </ext:JsonReader>
                </Reader>
            </ext:Store>
        </Store>
        <ColumnModel ID="checknum_ColumnMode" runat="server">
            <Columns>
                <ext:RowNumbererColumn Width="30" />
                <ext:Column Header="款式编号" Sortable="true" DataIndex="sku" />
                <ext:Column Header="色号" Width="40" Sortable="true" DataIndex="color" />
                <ext:Column Header="F" Width="30" Sortable="true" DataIndex="F" />
                <ext:Column Header="2" Width="30" Sortable="true" DataIndex="F4" />
                <ext:Column Header="3" Width="30" Sortable="true" DataIndex="F5" />
                <ext:Column Header="4" Width="30" Sortable="true" DataIndex="F6" />
                <ext:Column Header="5" Width="30" Sortable="true" DataIndex="F7" />
                <ext:Column Header="6" Width="30" Sortable="true" DataIndex="F8" />
                <ext:Column Header="7" Width="30" Sortable="true" DataIndex="F9" />
            </Columns>
        </ColumnModel>
        <LoadMask ShowMask="true" Msg="正在加载..." />
    </ext:GridPanel>
    </form>
</body>
</html>

