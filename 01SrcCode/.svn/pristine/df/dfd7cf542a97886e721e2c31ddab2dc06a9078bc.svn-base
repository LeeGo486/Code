<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VIPSearch.aspx.cs" Inherits="VIPSearch" %>


<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>加盟商VIP管理</title>
    <script type="text/javascript">
        var cityname = -1;

        function CityChange() {
            cityname = Cboadd_province.getValue();
            city_Store.reload();
        }

        function SetWinData(index) {
            var record = VIPStore.getAt(index);
            VIP_MainForm.reset();
            VIP_MainForm.getForm().loadRecord(record);
            ReadOnlyAtt(true);
            VIP_Win.show();
        }
        function ReadOnlyAtt(type) {
            TextFBuyID.setReadOnly(type);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="MainResourceMgr" runat="server" />

        <ext:Store runat="server" ID="tz_name_Store">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="employeeid" />
                        <ext:RecordField Name="tz_name" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>

        <ext:Store runat="server" ID="vipoccupation_Store">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="vipoccupation" />
                        <ext:RecordField Name="vipoccupation" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>

        <ext:Store runat="server" ID="vipgrab_Store">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="vipgrab" />
                        <ext:RecordField Name="vipgrab" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>

        <ext:Store runat="server" ID="viplove_Store">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="viplove" />
                        <ext:RecordField Name="viplove" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>

        <ext:Store runat="server" ID="province_Store">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="provinceId" />
                        <ext:RecordField Name="Name" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>

        <ext:Store runat="server" ID="city_Store" OnRefreshData="CityChange">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="name" />
                        <ext:RecordField Name="name" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
            <BaseParams>
                <ext:Parameter Name="city" Value="cityname" Mode="Raw" />
            </BaseParams>
        </ext:Store>

        <ext:Viewport ID="Viewport1" runat="server">
            <Items>
                <ext:FitLayout>
                    <Items>
                        <ext:GridPanel ID="VIPInfoGrid" AutoScroll="true" Title="加盟商VIP管理" TrackMouseOver="true"
                            runat="server" Border="false">
                            <TopBar>
                                <ext:Toolbar>
                                    <Items>
                                        <ext:TextField ID="TxtVIPNo" runat="server" LabelWidth="40" FieldLabel="VIP卡号">
                                        </ext:TextField>
                                        <ext:TextField ID="TxtVIPPhone" runat="server" LabelWidth="40" FieldLabel="手机">
                                        </ext:TextField>
                                        <ext:TextField ID="TxtVIPName" runat="server" LabelWidth="40" FieldLabel="姓名">
                                        </ext:TextField>
                                        <ext:Button ID="BtnSearch" Text="查询" Icon="Zoom" runat="server">
                                            <Listeners>
                                                <Click Handler="#{VIPStore}.reload();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:ToolbarSeparator />
                                        <ext:Label ID="lbInfo" Margins="0 0 0 10px" runat="server"></ext:Label>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Store>
                                <ext:Store runat="server" ID="VIPStore" OnRefreshData="Report_DataBind" AutoLoad="true">
                                    <Reader>
                                        <ext:JsonReader>
                                            <Fields>
                                                <ext:RecordField Name="vipid" />
                                                <ext:RecordField Name="vipcode" />
                                                <ext:RecordField Name="vipname" />
                                                <ext:RecordField Name="vipsex" />
                                                <ext:RecordField Name="mobtel" />
                                                <ext:RecordField Name="vipbirth" />
                                                <ext:RecordField Name="tz_name" />
                                                <ext:RecordField Name="vipstate" />
                                                <ext:RecordField Name="centum" />
                                                <ext:RecordField Name="pcentum" />
                                                <ext:RecordField Name="FBuyID" />
                                                <ext:RecordField Name="vipoccupation" />
                                                <ext:RecordField Name="crdate" />
                                                <ext:RecordField Name="viplastdate" />
                                                <ext:RecordField Name="lastSums" />
                                                <ext:RecordField Name="add_province" />
                                                <ext:RecordField Name="vipadd" />
                                                <ext:RecordField Name="vipname" />
                                                <ext:RecordField Name="Employeeid" />
                                                <ext:RecordField Name="add_city" />
                                                <ext:RecordField Name="vip_communi" />
                                                <ext:RecordField Name="vipgrab" />
                                                <ext:RecordField Name="viplove" />
                                                <ext:RecordField Name="vipbrand1" />
                                                <ext:RecordField Name="vipbrand2" />
                                                <ext:RecordField Name="vipbrand3" />
                                                <ext:RecordField Name="stature" />
                                                <ext:RecordField Name="vip_body" />
                                                <ext:RecordField Name="vip_skin" />
                                                <ext:RecordField Name="vippaper" />
                                                <ext:RecordField Name="vip_cosmetic" />
                                                <ext:RecordField Name="vip_drink" />
                                                <ext:RecordField Name="vipcolor" />
                                                <ext:RecordField Name="vip_news" />
                                                <ext:RecordField Name="vip_gift" />
                                            </Fields>
                                        </ext:JsonReader>
                                    </Reader>
                                </ext:Store>
                            </Store>

                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn Width="30">
                                    </ext:RowNumbererColumn>
                                    <ext:Column Header="VIPID" Width="140" DataIndex="vipid" Hidden="true" />
                                    <ext:Column Header="VIP卡号" Width="80" DataIndex="vipcode" />
                                    <ext:Column Header="姓名" Width="50" DataIndex="vipname" />
                                    <ext:Column Header="性别" Width="40" DataIndex="vipsex" />
                                    <ext:Column Header="手机" Width="100" DataIndex="mobtel" />
                                    <ext:Column Header="生日" Width="100" DataIndex="vipbirth" />
                                    <ext:Column Header="拓展人" Width="80" DataIndex="tz_name" />
                                    <ext:Column Header="状态" Width="80" DataIndex="vipstate" />
                                    <ext:Column Header="积分" Width="80" DataIndex="centum" />
                                    <ext:Column Header="上季积分" Width="80" DataIndex="pcentum" />
                                    <ext:Column Header="首单" Width="140" DataIndex="FBuyID" />
                                    <ext:Column Header="职业" Width="80" DataIndex="vipoccupation" />
                                    <ext:Column Header="创建时间" Width="100" DataIndex="crdate">
                                        <Renderer Handler="return value.substring(0,10);" />
                                    </ext:Column>
                                    <ext:Column Header="最近消费日期" Width="100" DataIndex="viplastdate" />
                                    <ext:Column Header="消费金额" Width="80" DataIndex="lastSums" />

                                </Columns>
                            </ColumnModel>
                            <LoadMask ShowMask="true" Msg="正在加载..." />

                            <Listeners>
                                <RowDblClick Handler="SetWinData(rowIndex);" />
                            </Listeners>

                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolBar" StoreID="VIPStore" PageSize="20"
                                    runat="server">
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:FitLayout>
            </Items>
        </ext:Viewport>

        <ext:Window ID="VIP_Win" Hidden="true" Modal="true" runat="server" Border="false" Title="编辑记录" Icon="Pencil" Width="700" AutoHeight="true">
            <Items>
                <ext:FormPanel ID="VIP_MainForm" Padding="10" Border="false" AutoHeight="true" LabelWidth="65">
                    <Items>
                        <ext:TableLayout ColumnWidth="0.333" Columns="3">
                            <Cells>
                                <ext:Cell ColSpan="3">
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:Label ID="TextField1" Width="100" FieldLabel="必填项" />
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:Hidden ID="Hidvipid" runat="server" DataIndex="vipid" />
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <ext:Cell ColSpan="2">
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:Hidden ID="Hidvipcode" runat="server" DataIndex="vipcode" />
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>


                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:TextField ID="Textvipname" Width="150" FieldLabel="顾客姓名" runat="server" DataIndex="vipname" />
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <%--  <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:ComboBox ID="Cbovipsex" SelectedIndex="0" Editable="false" FieldLabel="性别" Width="150" runat="server" DataIndex="vipsex">
                                                <Items>
                                                    <ext:ListItem Text="男" Value="男" />
                                                    <ext:ListItem Text="女" Value="女" />
                                                </Items>
                                            </ext:ComboBox>
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>--%>

                                <ext:Cell>
                                    <Items>
                                        <ext:ComboBox ID="Cbovipsex" Editable="false" FieldLabel="性别" Width="210" runat="server" DataIndex="vipsex">
                                            <Items>
                                                <ext:ListItem Text="男" Value="男" />
                                                <ext:ListItem Text="女" Value="女" />
                                            </Items>
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Cell>

                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:ComboBox ID="Cbotz_name" Editable="false" FieldLabel="拓展人"
                                                StoreID="tz_name_Store" DisplayField="tz_name" TextField="tz_name" ValueField="employeeid" Width="100" runat="server" DataIndex="tz_name">
                                            </ext:ComboBox>
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:NumberField ID="Textmobtel" Width="150" FieldLabel="手机号" runat="server" DataIndex="mobtel" />
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <ext:Cell>
                                    <ext:DateField ID="Textvipbirth" runat="server" Width="210" FieldLabel="出生年月" Format="yyyy-MM-dd"
                                        DataIndex="vipbirth">
                                    </ext:DateField>
                                </ext:Cell>


                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:ComboBox ID="Cbotvipoccupation" Editable="false" FieldLabel="职业"
                                                StoreID="vipoccupation_Store" DisplayField="vipoccupation" ValueField="vipoccupation" Width="100" runat="server" DataIndex="vipoccupation">
                                            </ext:ComboBox>
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <ext:Cell ColSpan="3">
                                    <ext:Label ID="Label1" Width="150" FieldLabel="非必填项" />
                                </ext:Cell>

                                <ext:Cell ColSpan="3">
                                    <ext:TextField ID="TextFBuyID" Width="300" FieldLabel="首单" runat="server" DataIndex="FBuyID" />
                                </ext:Cell>

                                <%--    <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textadd_province" Width="200" FieldLabel="地址" runat="server" DataIndex="add_province" />
                                    </Items>
                                </ext:Cell>--%>

                                <ext:Cell>
                                    <Items>
                                        <ext:ComboBox ID="Cboadd_province" Editable="false" FieldLabel="地址" Width="200" StoreID="province_Store"
                                            DisplayField="Name" TextField="Name" ValueField="provinceId" runat="server" DataIndex="add_province">
                                            <Listeners>
                                                <Change Handler="CityChange()" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>

                                </ext:Cell>

                                <ext:Cell>
                                    <Items>
                                        <ext:ComboBox ID="Cboadd_city" Editable="false" FieldLabel="" Width="200" StoreID="city_Store"
                                            DisplayField="name" TextField="name" ValueField="name" runat="server" DataIndex="add_city">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Cell>


                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvipadd" Width="200" FieldLabel="" runat="server" DataIndex="vipadd" />
                                    </Items>
                                </ext:Cell>


                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvip_communi" Width="200" FieldLabel="沟通方式" runat="server" DataIndex="vip_communi" />
                                    </Items>
                                </ext:Cell>


                                <ext:Cell>
                                    <Items>
                                        <ext:ComboBox ID="Cbovipgrab" Editable="false" FieldLabel="着装风格"
                                            StoreID="vipgrab_Store" DisplayField="vipgrab" ValueField="vipgrab" Width="200" runat="server" DataIndex="vipgrab">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:ComboBox ID="Cboviplove" Editable="false" FieldLabel="个人爱好"
                                            StoreID="viplove_Store" DisplayField="viplove" ValueField="viplove" Width="200" runat="server" DataIndex="viplove">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Cell>

                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvipbrand1" Width="200" FieldLabel="喜欢品牌" runat="server" DataIndex="vipbrand1" />
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvipbrand2" Width="200" FieldLabel="" runat="server" DataIndex="vipbrand2" />
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvipbrand3" Width="200" FieldLabel="" runat="server" DataIndex="vipbrand3" />
                                    </Items>
                                </ext:Cell>


                                <ext:Cell>
                                    <Items>
                                        <ext:NumberField ID="Textstature" Width="200" FieldLabel="身高" runat="server" DataIndex="stature" />
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvip_body" Width="200" FieldLabel="体型" runat="server" DataIndex="vip_body" />
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvip_skin" Width="200" FieldLabel="肤色" runat="server" DataIndex="vip_skin" />
                                    </Items>
                                </ext:Cell>

                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvippaper" Width="200" FieldLabel="喜爱的杂志" runat="server" DataIndex="vippaper" />
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvip_cosmetic" Width="200" FieldLabel="喜爱的化妆品" runat="server" DataIndex="vip_cosmetic" />
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvip_drink" Width="200" FieldLabel="喜爱的饮料" runat="server" DataIndex="vip_drink" />
                                    </Items>
                                </ext:Cell>

                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvipcolor" Width="200" FieldLabel="经常穿的色系" runat="server" DataIndex="vipcolor" />
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvip_news" Width="200" FieldLabel="经常关注的信息" runat="server" DataIndex="vip_news" />
                                    </Items>
                                </ext:Cell>
                                <ext:Cell>
                                    <Items>
                                        <ext:TextField ID="Textvip_gift" Width="200" FieldLabel="希望收到的礼物" runat="server" DataIndex="vip_gift" />
                                    </Items>
                                </ext:Cell>
                            </Cells>
                        </ext:TableLayout>
                    </Items>
                </ext:FormPanel>
            </Items>



            <Buttons>
                <ext:Button ID="BtnSaveUpdate" Text="保存提交" runat="server" Icon="Disk">
                    <DirectEvents>
                        <Click OnEvent="SaveUpdate">
                            <EventMask ShowMask="true" Msg="正在提交，请等候 ..." />
                        </Click>
                    </DirectEvents>
                    <Listeners>
                        <Click Handler="if (#{VIP_MainForm}.getForm().isValid()) {;}else{alert('您填写的信息不正确，请您确认！');return false;}" />
                    </Listeners>
                </ext:Button>


                <ext:Button Text="取消" Icon="Decline">
                    <Listeners>
                        <Click Handler="#{VIP_Win}.hide();#{VIPStore}.reload();" />
                    </Listeners>
                </ext:Button>
            </Buttons>

            <Listeners>
                <BeforeHide Handler="#{VIPStore}.reload();" />
            </Listeners>

        </ext:Window>
    </form>
</body>
</html>
