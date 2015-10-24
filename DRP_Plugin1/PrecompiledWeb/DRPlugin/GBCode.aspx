<%@ page language="C#" autoeventwireup="true" inherits="GBCode, App_Web_n234bbfq" %>


<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>国标码管理</title>
    <style type="text/css">
        .x-table-layout{width: 100%;}
        .x-table-layout-cell{padding: 0px 0px 0px 5px;}
        .ext-ie .button-fix table.x-btn,
        .ext-gecko .button-fix table.x-btn{
            top:0px;            
        }
        .ext-ie .button-fix .x-form-text,
        .ext-gecko .button-fix .x-form-text{
            margin-top:1px;
        }
    </style>
    <script type="text/javascript">
        function SetWinData(index) {
            var record = Y_GBCode_MainStore.getAt(index);
            Y_GBCode_MainForm.reset();
            Y_GBCode_MainForm.getForm().loadRecord(record);
            Y_GBCode_Win.show();
        }
    </script>
</head>
<body>
    <form id="MainForm" runat="server">
    <ext:ResourceManager ID="Main_ResourceManager" runat="server" />
    <!--WMS_NOTICE表页面主数据元，自动生成-->
    <ext:Store runat="server" ID="Y_GBCode_MainStore" OnRefreshData="Y_GBCode_DataBind"
        AutoLoad="true">
        <Proxy>
            <ext:PageProxy />
        </Proxy>
        <Reader>
            <ext:JsonReader IDProperty="Id">
                <Fields>
					<ext:RecordField Name="Id" />
					<ext:RecordField Name="Code" />
					<ext:RecordField Name="StyleId" />

                </Fields>
            </ext:JsonReader>
        </Reader>
        <BaseParams>
            <ext:Parameter Name="start" Value="0" Mode="Raw">
            </ext:Parameter>
            <ext:Parameter Name="limit" Value="100" Mode="Raw">
            </ext:Parameter>
        </BaseParams>
    </ext:Store>
	<!--下拉列表数据源-->
	
    <!--WMS_NOTICE页面主表格-->
    <ext:Viewport ID="MainViewPort" runat="server">
        <Items>
            <ext:FitLayout>
                <Items>
                    <ext:GridPanel ID="Y_GBCode_Grid" Layout="fit" SelectionMemory="Disabled" TrackMouseOver="true"
                        runat="server" StoreID="Y_GBCode_MainStore" StripeRows="true" Header="false"
                        Border="false" Collapsible="true">
                        <TopBar>
                            <ext:Toolbar ID="MainToolBar" runat="server">
                                <Items>
                                    <ext:FileUploadField ID="UpFile" runat="server" Width="200" CtCls="button-fix"  ButtonText="浏览..." AllowBlank="false"
                                        EmptyText="请选择文件" Icon="LinkAdd" />
                                    <ext:Button runat="server" ID="btnsave" Text="开始导入" Icon="ArrowIn">
                                        <DirectEvents>
                                            <Click OnEvent="Btnsave_Click">
                                                <EventMask ShowMask="true" Msg="正在导入，请稍后..." />
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:ToolbarSeparator />
                                    <ext:Button Text="添加" Icon="Add">
                                        <Listeners>
                                            <Click Handler="#{Y_GBCode_MainForm}.getForm().reset();#{Y_GBCode_Win}.show();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarSeparator />
                                    <ext:Button Text="刷新" Icon="Reload">
                                        <Listeners>
                                            <Click Handler="#{Y_GBCode_MainStore}.reload();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarFill />
                                    <ext:Button ID="Button1" runat="server" Text="删除" Icon="Decline">
                                        <DirectEvents>
                                            <Click OnEvent="BtnDel_Click">
                                                <Confirmation ConfirmRequest="true" Title="确认" Message="您确定要删除吗?" />
                                                <EventMask ShowMask="true" Msg="正在删除数据，请等候 ..." />
                                            </Click>
                                        </DirectEvents>
                                        <Listeners>
                                            <Click Handler="if(#{Y_GBCode_Grid}.getSelectionModel().getCount()<=0) {alert('请选择要删除的记录');return false;}" />
                                        </Listeners>
                                    </ext:Button>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>
                        <ColumnModel>
                            <Columns>
                                <ext:RowNumbererColumn Width="30" />
								<ext:Column Header="自增" Hidden="true" DataIndex="Id" />
								<ext:Column Header="国标码" Sortable="true" DataIndex="Code" />
								<ext:Column Header="新款式编号" Sortable="true" DataIndex="StyleId" />

                            </Columns>
                        </ColumnModel>
                        <Listeners>
                            <RowDblClick Handler="SetWinData(rowIndex);" />
                        </Listeners>
                        <Plugins>
                            <ext:GridFilters runat="server" FiltersText="查找" ID="Y_GBCode_Filter">
                                <Filters>
									<ext:StringFilter DataIndex="Code" />
									<ext:StringFilter DataIndex="StyleId" />

                                </Filters>
                            </ext:GridFilters>
                        </Plugins>
                        <LoadMask ShowMask="true" Msg="正在加载..." />
                        <SelectionModel>
                            <ext:CheckboxSelectionModel />
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar ID="PagingToolBar" StoreID="Y_GBCode_MainStore" PageSize="100"
                                runat="server">
                            </ext:PagingToolbar>
                        </BottomBar>
                    </ext:GridPanel>
                </Items>
            </ext:FitLayout>
        </Items>
    </ext:Viewport>
    <!--WMS_NOTICE表修改，添加主窗体-->
    <ext:Window ID="Y_GBCode_Win" Hidden="true" Modal="true" 
        runat="server" Border="false" Title="编辑记录" Icon="Pencil" Width="270" AutoHeight="true" >
        <Items>
            <ext:FormPanel ID="Y_GBCode_MainForm" Padding="10" Border="false" AutoHeight="true"
                LabelWidth="65">
                <Items>
                    <ext:TableLayout ColumnWidth="1" Columns="2">
                        <Cells>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtCode" Width="160" FieldLabel="国标码" runat="server" DataIndex="Code" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:Hidden ID="Hid" runat="server" DataIndex="Id" />
									</Items>
								</ext:Container>
							</ext:Cell>
                        </Cells>
                    </ext:TableLayout>
                </Items>
            </ext:FormPanel>
        </Items>
        <Buttons>
            <ext:Button ID="Button2" Text="提交" runat="server" Icon="Disk">
                <DirectEvents>
                    <Click OnEvent="BtnSave_Click">
                        <EventMask ShowMask="true" Msg="正在提交，请等候 ..." />
                    </Click>
                </DirectEvents>
                <Listeners>
                    <Click Handler="if (#{Y_GBCode_MainForm}.getForm().isValid()) {;}else{alert('您填写的信息不正确，请您确认！');return false;}" />
                </Listeners>
            </ext:Button>
            <ext:Button Text="取消" Icon="Decline">
                <Listeners>
                    <Click Handler="#{Y_GBCode_Win}.hide();" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Window>
    </form>
</body>
</html>
