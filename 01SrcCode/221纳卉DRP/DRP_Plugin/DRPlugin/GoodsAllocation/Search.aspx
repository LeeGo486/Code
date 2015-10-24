<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="GoodsAllocation_Search" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>查询跨公司调拨</title>
    <script type="text/javascript">
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

        function SetWinData(index) {
            var record = d_Move_MainStore.getAt(index);
            if (record.get("setchk_sure") == "1") {
                alert("已审核单据不能再扫描录入！");
                return false;
            }
            window.location.href = "Detail.aspx?depotid=" + GetQueryString("depotid") + "&userid=" + GetQueryString("userid") + "&moveid=" + record.get("moveid") + "&get_depotid=" + record.get("get_depotid");
        }

        function CheckState(index) {
            var record = d_Move_MainStore.getAt(index);
            BtnState(record);
        }

        function BtnState(record) {
            //如果是未审核状态
            if (record.get("setchk_sure") == "0") {
                BtnDelete.setDisabled(false);
                BtnChk.setDisabled(false);
                BtnBkChk.setDisabled(true);
                BtnDZ.setDisabled(true);
                BtnFDZ.setDisabled(true);
            }
            else {
                if (record.get("set_sure") == "0") {
                    BtnDelete.setDisabled(true);
                    BtnChk.setDisabled(true);
                    BtnBkChk.setDisabled(false);
                    BtnDZ.setDisabled(false);
                    BtnFDZ.setDisabled(true);
                }
                else {
                    BtnDelete.setDisabled(true);
                    BtnChk.setDisabled(true);
                    BtnBkChk.setDisabled(true);
                    BtnDZ.setDisabled(true);
                    BtnFDZ.setDisabled(false);
                }
            }
        }

        function StateReSet() {
            BtnDelete.setDisabled(true);
            BtnChk.setDisabled(true);
            BtnBkChk.setDisabled(true);
            BtnDZ.setDisabled(true);
            BtnFDZ.setDisabled(true);
            if (d_Move_Grid.getSelectionModel().getCount() <= 0) {
                return false;
            }
            var Precords = d_Move_Grid.selModel.getSelections();
            var record = Precords[0];
            BtnState(record);
        }

        function BillAdd() {
            if (d_Move_Grid.getSelectionModel().getCount() <= 0) {
                alert('请选择要扫描的行！');
                return false;
            }
            var Precords = d_Move_Grid.selModel.getSelections();
            var record = Precords[0];
            if (record.get("setchk_sure") == "1") {
                alert("已审核单据不能再扫描录入！");
                return false;
            }
            window.location.href = "Detail.aspx?depotid=" + GetQueryString("depotid") + "&userid=" + GetQueryString("userid") + "&moveid=" + record.get("moveid") + "&get_depotid=" + record.get("get_depotid");
        }

        function WatchDetail() {
            if (d_Move_Grid.getSelectionModel().getCount() <= 0) {
                alert('请选择要查看明细的记录！');
                return false;
            }
            var Precords = d_Move_Grid.selModel.getSelections();
            var record = Precords[0];
            WinDetail.setTitle(record.get("moveid") + "单据明细");
            console.log(WinDetail);
            WinDetail.body.update("<iframe src='/pos/pos/f22/f22_mxnj.asp?id=" + record.get("moveid") + "&pksname=move&ext=' frameborder=0 scrolling='no' width=100% height=100% ></iframe>");
            WinDetail.show();
        }
    </script>
</head>
<body>
    <form id="MainForm" runat="server">
        <ext:ResourceManager ID="Main_ResourceManager" runat="server" />
        <!--WMS_NOTICE表页面主数据元，自动生成-->
        <ext:Store runat="server" ID="d_Move_MainStore" OnRefreshData="d_Move_DataBind"
            AutoLoad="true">
            <Proxy>
                <ext:PageProxy />
            </Proxy>
            <Reader>
                <ext:JsonReader IDProperty="moveid">
                    <Fields>
                        <ext:RecordField Name="moveid" />
                        <ext:RecordField Name="move" />
                        <ext:RecordField Name="indentid" />
                        <ext:RecordField Name="set_depotid" />
                        <ext:RecordField Name="get_depotid" />
                        <ext:RecordField Name="set_sure" />
                        <ext:RecordField Name="get_sure" />
                        <ext:RecordField Name="setchk_sure" />
                        <ext:RecordField Name="getchk_sure" />
                        <ext:RecordField Name="setdate" />
                        <ext:RecordField Name="getcr_name" />
                        <ext:RecordField Name="getcr_date" />
                        <ext:RecordField Name="setchk_name" />
                        <ext:RecordField Name="setcr_date" />
                        <ext:RecordField Name="setsure_name" />
                        <ext:RecordField Name="getdate" />
                        <ext:RecordField Name="getchk_name" />
                        <ext:RecordField Name="setcr_name" />
                        <ext:RecordField Name="getchk_date" />
                        <ext:RecordField Name="getsure_name" />
                        <ext:RecordField Name="setsure_date" />
                        <ext:RecordField Name="getsure_date" />
                        <ext:RecordField Name="setchk_date" />
                        <ext:RecordField Name="set_comment" />
                        <ext:RecordField Name="get_comment" />
                        <ext:RecordField Name="crdate" />
                        <ext:RecordField Name="updatetime" />
                        <ext:RecordField Name="cwchk" />
                        <ext:RecordField Name="cwgetchk" />
                        <ext:RecordField Name="cwpz" />
                        <ext:RecordField Name="cwgetpz" />
                        <ext:RecordField Name="backdate" />
                        <ext:RecordField Name="backrate" />
                        <ext:RecordField Name="selltype" />
                        <ext:RecordField Name="AutoCrId" />
                        <ext:RecordField Name="znums" />
                        <ext:RecordField Name="zjsums" />
                        <ext:RecordField Name="zxsums" />
                        <ext:RecordField Name="zssums" />
                        <ext:RecordField Name="loadplanid" />
                        <ext:RecordField Name="loadbox" />
                        <ext:RecordField Name="ifcancelbox" />
                        <ext:RecordField Name="ifquota" />
                        <ext:RecordField Name="shjjquotaid" />
                        <ext:RecordField Name="cancelbox" />
                        <ext:RecordField Name="sel_sure" />
                        <ext:RecordField Name="loadplanjhid" />
                        <ext:RecordField Name="shjjdepotid" />
                        <ext:RecordField Name="loaddate" />
                        <ext:RecordField Name="ifjhsure" />
                        <ext:RecordField Name="ESB_ID" />
                        <ext:RecordField Name="Only_Update_sub" />
                        <ext:RecordField Name="ESB_src_App" />

                    </Fields>
                </ext:JsonReader>
            </Reader>
            <Listeners>
                <Load Handler="StateReSet();" />
            </Listeners>
        </ext:Store>
        <!--下拉列表数据源-->

        <!--WMS_NOTICE页面主表格-->
        <ext:Viewport ID="MainViewPort" runat="server">
            <Items>
                <ext:FitLayout>
                    <Items>
                        <ext:GridPanel ID="d_Move_Grid" Layout="fit" SelectionMemory="Disabled" TrackMouseOver="true"
                            runat="server" StoreID="d_Move_MainStore" StripeRows="true" Header="false"
                            Border="false" Collapsible="true">
                            <TopBar>
                                <ext:Toolbar ID="MainToolBar"  Layout="Container" runat="server">
                                    <Items>
<ext:Toolbar ID="Toolbar3" runat="server" Flat="false">
                                        <Items>
                                        <ext:TextField ID="TxtMoveId" runat="server" LabelAlign="Right" LabelWidth="40" FieldLabel="单据号">
                                        </ext:TextField>
                                        <ext:DateField ID="DateFrom" Editable="false" LabelAlign="Right" LabelWidth="60" Width="160" runat="server" FieldLabel="开始日期"
                                            Format="yyyy-MM-dd">
                                        </ext:DateField>
                                        <ext:DateField ID="DateEnd" Editable="false" LabelAlign="Right" LabelWidth="60" Width="160" runat="server" FieldLabel="结束日期"
                                            Format="yyyy-MM-dd">
                                        </ext:DateField>
                                        <ext:Button Text="查询" Icon="Reload">
                                            <Listeners>
                                                <Click Handler="#{d_Move_MainStore}.reload();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:ToolbarSeparator></ext:ToolbarSeparator>
                                        <ext:Button Text="查看明细">
                                            <Listeners>
                                                <Click Handler="WatchDetail();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button Text="条码扫描" Icon="BasketAdd">
                                            <Listeners>
                                                <Click Handler="BillAdd();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:ToolbarSeparator></ext:ToolbarSeparator>

</Items>
                                    </ext:Toolbar>
                                    <ext:Toolbar ID="Toolbar4" runat="server" Flat="false">
                                        <Items>
<ext:Button ID="BtnDelete" runat="server" Disabled="true" Text="删除" Icon="Decline">
                                            <DirectEvents>
                                                <Click OnEvent="BtnDel_Click">
                                                    <Confirmation ConfirmRequest="true" Title="确认" Message="您确定要删除吗?" />
                                                    <EventMask ShowMask="true" Msg="正在删除数据，请等候 ..." />
                                                </Click>
                                            </DirectEvents>
                                            <Listeners>
                                                <Click Handler="if(#{d_Move_Grid}.getSelectionModel().getCount()<=0) {alert('请选择要删除的记录！');return false;}" />
                                            </Listeners>
                                        </ext:Button>

                                        <ext:Button ID="BtnChk" runat="server" Text="审核" Disabled="true" Icon="RecordGreen">
                                            <DirectEvents>
                                                <Click OnEvent="BtnChk_Click">
                                                    <EventMask ShowMask="true" Msg="正在操作，请等候 ..." />
                                                    <ExtraParams>
                                                        <ext:Parameter Name="Flag" Mode="Raw" Value="1"></ext:Parameter>
                                                    </ExtraParams>
                                                </Click>
                                            </DirectEvents>
                                            <Listeners>
                                                <Click Handler="if(#{d_Move_Grid}.getSelectionModel().getCount()<=0) {Alert('请选择要操作的记录！');return false;}" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="BtnBkChk" runat="server" Text="反审核" Disabled="true" Icon="RecordRed">
                                            <DirectEvents>
                                                <Click OnEvent="BtnChk_Click">
                                                    <EventMask ShowMask="true" Msg="正在操作，请等候 ..." />
                                                    <ExtraParams>
                                                        <ext:Parameter Name="Flag" Mode="Raw" Value="0"></ext:Parameter>
                                                    </ExtraParams>
                                                </Click>
                                            </DirectEvents>
                                            <Listeners>
                                                <Click Handler="if(#{d_Move_Grid}.getSelectionModel().getCount()<=0) {Alert('请选择要操作的记录！');return false;}" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:ToolbarSeparator></ext:ToolbarSeparator>
                                        <ext:Button ID="BtnDZ" runat="server" Text="登帐" Disabled="true" Icon="ReportEdit">
                                            <DirectEvents>
                                                <Click OnEvent="BtnDZ_Click">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="Flag" Mode="Raw" Value="1"></ext:Parameter>
                                                    </ExtraParams>
                                                    <EventMask ShowMask="true" Msg="正在操作，请等候 ..." />
                                                </Click>
                                            </DirectEvents>
                                            <Listeners>
                                                <Click Handler="if(#{d_Move_Grid}.getSelectionModel().getCount()<=0) {alert('请选择要操作的记录');return false;}" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="BtnFDZ" runat="server" Text="反登帐" Disabled="true" Icon="ReportDelete">
                                            <DirectEvents>
                                                <Click OnEvent="BtnDZ_Click">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="Flag" Mode="Raw" Value="0"></ext:Parameter>
                                                    </ExtraParams>
                                                    <EventMask ShowMask="true" Msg="正在操作，请等候 ..." />
                                                </Click>
                                            </DirectEvents>
                                            <Listeners>
                                                <Click Handler="if(#{d_Move_Grid}.getSelectionModel().getCount()<=0) {alert('请选择要操作的记录');return false;}" />
                                            </Listeners>
                                        </ext:Button></Items>
                                </ext:Toolbar>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <ColumnModel>
                                <Columns>
                                    <ext:RowNumbererColumn Width="30" />
                                    <ext:Column Header="自增" Hidden="true" DataIndex="moveid" />
                                    <ext:Column Header="发货单号" Width="160px" Sortable="true" DataIndex="move" />
                                    <ext:Column Header="销售类型" Width="60px" Sortable="true" DataIndex="selltype" />
                                    <ext:Column Header="品牌" Width="60px" Sortable="true" DataIndex="shjjdepotid" />
                                    <ext:Column Header="发货仓编号" Sortable="true" DataIndex="set_depotid" />
                                    <ext:Column Header="收货仓编号" Sortable="true" DataIndex="get_depotid" />
                                    <ext:Column Header="发货数量" Width="60px" Sortable="true" DataIndex="znums" />
                                    <ext:Column Header="发货金额" Width="60px" Sortable="true" DataIndex="zssums" />
                                    <ext:Column Header="发货日期" Width="120px" Sortable="true" DataIndex="setdate" />
                                    <ext:Column Header="审核" Width="40px" Sortable="true" DataIndex="setchk_sure" />
                                    <ext:Column Header="审核日期" Width="120px" Sortable="true" DataIndex="setchk_date" />
                                    <ext:Column Header="审核人" Width="110px" Sortable="true" DataIndex="setchk_name" />
                                    <ext:Column Header="登帐" Width="40px" Sortable="true" DataIndex="set_sure" />
                                    <ext:Column Header="登帐日期" Width="120px" Sortable="true" DataIndex="setsure_date" />
                                    <ext:Column Header="登帐人" Sortable="true" DataIndex="setsure_name" />
                                    <ext:Column Header="制单人" Width="110px" Sortable="true" DataIndex="setcr_name" />
                                    <ext:Column Header="制单日期" Width="120px" Sortable="true" DataIndex="setcr_date" />
                                    <ext:Column Header="发货备注" Sortable="true" DataIndex="set_comment" />
                                </Columns>
                            </ColumnModel>
                            <Listeners>
                                <RowDblClick Handler="SetWinData(rowIndex);" />
                                <RowClick Handler="CheckState(rowIndex);" />
                            </Listeners>
                            <LoadMask ShowMask="true" Msg="正在加载..." />
                            <SelectionModel>
                                <ext:CheckboxSelectionModel SingleSelect="true" />
                            </SelectionModel>
                        </ext:GridPanel>
                    </Items>
                </ext:FitLayout>
            </Items>
        </ext:Viewport>
        <ext:Window ID="WinDetail" runat="server" Hidden="true" Title="明细" Width="550" Height="450">
            <AutoLoad Mode="IFrame" ShowMask="True" MaskMsg="明细加载中，请稍后..."></AutoLoad>
        </ext:Window>
    </form>
</body>
</html>