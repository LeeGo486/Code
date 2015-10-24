<%@ page language="C#" autoeventwireup="true" inherits="StyleFoundation, App_Web_n234bbfq" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>雅澜款式档案</title>
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
            var record = Y_StyleFoundation_MainStore.getAt(index);
            Y_StyleFoundation_MainForm.reset();
            Y_StyleFoundation_MainForm.getForm().loadRecord(record);
            ReadOnlyAtt(true);
            Y_StyleFoundation_Win.show();
        }
        function ReadOnlyAtt(type) {
            TxtClothingId.setReadOnly(type);
            TxtSizeId.setReadOnly(type);
            TxtColorId.setReadOnly(type);
            TxtStyleId.setReadOnly(type);
        }
    </script>
</head>
<body>
    <form id="MainForm" runat="server">
    <ext:ResourceManager ID="Main_ResourceManager" runat="server" />
    <!--WMS_NOTICE表页面主数据元，自动生成-->
    <ext:Store runat="server" ID="Y_StyleFoundation_MainStore" OnRefreshData="Y_StyleFoundation_DataBind"
        AutoLoad="true">
        <Proxy>
            <ext:PageProxy />
        </Proxy>
        <Reader>
            <ext:JsonReader IDProperty="Id">
                <Fields>
					<ext:RecordField Name="Id" />
					<ext:RecordField Name="BrName" />
					<ext:RecordField Name="BrId" />
					<ext:RecordField Name="Production" />
					<ext:RecordField Name="ClothingId" />
					<ext:RecordField Name="StyleId" />
					<ext:RecordField Name="ColorId" />
					<ext:RecordField Name="SizeId" />
					<ext:RecordField Name="J_Price" />
					<ext:RecordField Name="J_Cost" />
					<ext:RecordField Name="S_Name" />
					<ext:RecordField Name="Fabric" />
					<ext:RecordField Name="PrintState" />
					<ext:RecordField Name="St_Year" />
					<ext:RecordField Name="St_Month" />
					<ext:RecordField Name="St_Xl" />
					<ext:RecordField Name="St_Dl" />
					<ext:RecordField Name="St_Xz" />
					<ext:RecordField Name="OldClothingId" />
					<ext:RecordField Name="OldStyleId" />
					<ext:RecordField Name="OldColorId" />
					<ext:RecordField Name="OldSizeId" />
					<ext:RecordField Name="Remark" />

                </Fields>
            </ext:JsonReader>
        </Reader>
        <BaseParams>
            <ext:Parameter Name="start" Value="0" Mode="Raw">
            </ext:Parameter>
            <ext:Parameter Name="limit" Value="50" Mode="Raw">
            </ext:Parameter>
        </BaseParams>
    </ext:Store>
	<!--下拉列表数据源-->
	
    <!--WMS_NOTICE页面主表格-->
    <ext:Viewport ID="MainViewPort" runat="server">
        <Items>
            <ext:FitLayout>
                <Items>
                    <ext:GridPanel ID="Y_StyleFoundation_Grid" Layout="fit" SelectionMemory="Disabled" TrackMouseOver="true"
                        runat="server" StoreID="Y_StyleFoundation_MainStore" StripeRows="true" Header="false"
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
                                            <Click Handler="#{Y_StyleFoundation_MainForm}.getForm().reset();ReadOnlyAtt(false);#{Y_StyleFoundation_Win}.show();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarSeparator />
                                    <ext:Button Text="刷新" Icon="Reload">
                                        <Listeners>
                                            <Click Handler="#{Y_StyleFoundation_MainStore}.reload();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarFill />
                                    <ext:Button runat="server" Text="导出数据" Icon="PageExcel">
                                        <DirectEvents>
                                            <Click OnEvent="BtnExcel_Click">
                                                <EventMask ShowMask="true" Msg="正在导出数据，请等候 ..." />
                                            </Click>
                                        </DirectEvents>
                                        <Listeners>
                                            <Click Handler="if(#{Y_StyleFoundation_MainStore}.getTotalCount() <= 0) {alert('没有记录，无法执行导出功能');return false;}" />
                                        </Listeners>
                                    </ext:Button>

                                    <ext:Button ID="Button1" runat="server" Text="删除" Icon="Decline">
                                        <DirectEvents>
                                            <Click OnEvent="BtnDel_Click">
                                                <Confirmation ConfirmRequest="true" Title="确认" Message="您确定要删除吗?" />
                                                <EventMask ShowMask="true" Msg="正在删除数据，请等候 ..." />
                                            </Click>
                                        </DirectEvents>
                                        <Listeners>
                                            <Click Handler="if(#{Y_StyleFoundation_Grid}.getSelectionModel().getCount()<=0) {alert('请选择要删除的记录');return false;}" />
                                        </Listeners>
                                    </ext:Button>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>
                        <ColumnModel>
                            <Columns>
                                <ext:RowNumbererColumn Width="30" />
								<ext:Column Header="自增" Hidden="true" DataIndex="Id" />
								<ext:Column Header="品牌名称" Width="75" Sortable="true" DataIndex="BrName" />
								<ext:Column Header="品牌编码" Width="60" Sortable="true" DataIndex="BrId" />
								<ext:Column Header="产地" Width="60" Sortable="true" DataIndex="Production" />
								<ext:Column Header="新条形码" Sortable="true" DataIndex="ClothingId" />
								<ext:Column Header="新款式编码" Sortable="true" DataIndex="StyleId" />
								<ext:Column Header="新颜色" Width="45" Sortable="true" DataIndex="ColorId" />
								<ext:Column Header="新尺码" Width="45" Sortable="true" DataIndex="SizeId" />
								<ext:Column Header="吊牌价" Width="55" Sortable="true" DataIndex="J_Price" />
								<ext:Column Header="成本价" Width="55" Sortable="true" DataIndex="J_Cost" />
								<ext:Column Header="品名" Width="45" Sortable="true" DataIndex="S_Name" />
								<ext:Column Header="成分" Sortable="true" DataIndex="Fabric" />
								<ext:Column Header="打印" Width="45" Sortable="true" DataIndex="PrintState" />
								<ext:Column Header="年份" Width="45" Sortable="true" DataIndex="St_Year" />
								<ext:Column Header="季节" Width="45" Sortable="true" DataIndex="St_Month" />
								<ext:Column Header="款式种类" Width="65" Sortable="true" DataIndex="St_Xl" />
								<ext:Column Header="款式大类" Width="65" Sortable="true" DataIndex="St_Dl" />
								<ext:Column Header="款式小类" Width="65" Sortable="true" DataIndex="St_Xz" />
								<ext:Column Header="旧条形码" Width="65" Sortable="true" DataIndex="OldClothingId" />
								<ext:Column Header="旧款式编码" Sortable="true" DataIndex="OldStyleId" />
								<ext:Column Header="旧颜色" Width="45" Sortable="true" DataIndex="OldColorId" />
								<ext:Column Header="旧尺码" Width="45" Sortable="true" DataIndex="OldSizeId" />
								<ext:Column Header="备注" Sortable="true" DataIndex="Remark" />

                            </Columns>
                        </ColumnModel>
                        <Listeners>
                            <RowDblClick Handler="SetWinData(rowIndex);" />
                        </Listeners>
                        <Plugins>
                            <ext:GridFilters runat="server" FiltersText="查找" ID="Y_StyleFoundation_Filter">
                                <Filters>
									<ext:StringFilter DataIndex="BrName" />
									<ext:StringFilter DataIndex="BrId" />
									<ext:StringFilter DataIndex="Production" />
									<ext:StringFilter DataIndex="ClothingId" />
									<ext:StringFilter DataIndex="StyleId" />
									<ext:StringFilter DataIndex="ColorId" />
									<ext:StringFilter DataIndex="SizeId" />
									<ext:StringFilter DataIndex="S_Name" />
									<ext:StringFilter DataIndex="Fabric" />
									<ext:StringFilter DataIndex="St_Month" />
									<ext:StringFilter DataIndex="St_Xl" />
									<ext:StringFilter DataIndex="St_Dl" />
									<ext:StringFilter DataIndex="St_Xz" />
									<ext:StringFilter DataIndex="OldClothingId" />
									<ext:StringFilter DataIndex="OldStyleId" />
									<ext:StringFilter DataIndex="OldColorId" />
									<ext:StringFilter DataIndex="OldSizeId" />
									<ext:StringFilter DataIndex="Remark" />

                                </Filters>
                            </ext:GridFilters>
                        </Plugins>
                        <LoadMask ShowMask="true" Msg="正在加载..." />
                        <SelectionModel>
                            <ext:CheckboxSelectionModel />
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar ID="PagingToolBar" StoreID="Y_StyleFoundation_MainStore" PageSize="50"
                                runat="server">
                            </ext:PagingToolbar>
                        </BottomBar>
                    </ext:GridPanel>
                </Items>
            </ext:FitLayout>
        </Items>
    </ext:Viewport>
    <!--WMS_NOTICE表修改，添加主窗体-->
    <ext:Window ID="Y_StyleFoundation_Win" Collapsible="true" Hidden="true" Modal="true" Maximizable="true"
        runat="server" Border="false" Title="编辑记录" Icon="Pencil" Width="520" AutoHeight="true"
        Resizable="true">
        <Items>
            <ext:FormPanel ID="Y_StyleFoundation_MainForm" Padding="10" Border="false" AutoHeight="true"
                LabelWidth="65">
                <Items>
                    <ext:TableLayout ColumnWidth="0.5" Columns="2">
                        <Cells>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtBrName" Width="160" FieldLabel="品牌名称" runat="server" DataIndex="BrName" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtBrId" Width="160" FieldLabel="品牌编码" runat="server" DataIndex="BrId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtProduction" Width="160" FieldLabel="产地" runat="server" DataIndex="Production" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtClothingId" Width="160" FieldLabel="新条形码" runat="server" DataIndex="ClothingId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtStyleId" Width="160" FieldLabel="新款式编码" runat="server" DataIndex="StyleId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtColorId" Width="160" FieldLabel="新颜色" runat="server" DataIndex="ColorId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtSizeId" Width="160" FieldLabel="新尺码" runat="server" DataIndex="SizeId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:NumberField ID="NFJ_Price" Width="160" FieldLabel="吊牌价" runat="server" DataIndex="J_Price" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:NumberField ID="NFJ_Cost" Width="160" FieldLabel="成本价" runat="server" DataIndex="J_Cost" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtS_Name" Width="160" FieldLabel="品名" runat="server" DataIndex="S_Name" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtFabric" Width="160" FieldLabel="成分" runat="server" DataIndex="Fabric" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:NumberField ID="NFPrintState" Width="160" FieldLabel="打印" runat="server" DataIndex="PrintState" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:NumberField ID="NFSt_Year" Width="160" FieldLabel="年份" runat="server" DataIndex="St_Year" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtSt_Month" Width="160" FieldLabel="季节" runat="server" DataIndex="St_Month" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtSt_Xl" Width="160" FieldLabel="款式种类" runat="server" DataIndex="St_Xl" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtSt_Dl" Width="160" FieldLabel="款式大类" runat="server" DataIndex="St_Dl" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtSt_Xz" Width="160" FieldLabel="款式小类" runat="server" DataIndex="St_Xz" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtOldClothingId" Width="160" FieldLabel="旧条形码" runat="server" DataIndex="OldClothingId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtOldStyleId" Width="160" FieldLabel="旧款式编码" runat="server" DataIndex="OldStyleId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtOldColorId" Width="160" FieldLabel="旧颜色" runat="server" DataIndex="OldColorId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtOldSizeId" Width="160" FieldLabel="旧尺码" runat="server" DataIndex="OldSizeId" />
									</Items>
								</ext:Container>
							</ext:Cell>
							<ext:Cell>
								<ext:Container Layout="Form">
									<Items>
									<ext:TextField ID="TxtRemark" Width="160" FieldLabel="备注" runat="server" DataIndex="Remark" />
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
                    <Click Handler="if (#{Y_StyleFoundation_MainForm}.getForm().isValid()) {;}else{alert('您填写的信息不正确，请您确认！');return false;}" />
                </Listeners>
            </ext:Button>
            <ext:Button Text="取消" Icon="Decline">
                <Listeners>
                    <Click Handler="#{Y_StyleFoundation_Win}.hide();" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Window>
    </form>
</body>
</html>
