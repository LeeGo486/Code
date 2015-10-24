<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VIPInsert.aspx.cs" Inherits="VIPInsert" %>


<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>加盟商VIP新增</title>
    <script type="text/javascript">
        var cityname = -1;

        function CityChange() {
            cityname = Cboadd_province.getValue();
            city_Store.reload();
        }

        function ReadOnlyAtt(type) {
            TextFBuyID.setReadOnly(type);
        }

        function fnSuccess(response, result) {
            VIP_MainForm.getForm().reset();
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

        <ext:Window ID="VIP_Win" Hidden="false" Modal="true" runat="server" Border="false" Closable="false" Title="新增" Icon="Pencil" Width="700" AutoHeight="true">
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
                                            <ext:TextField ID="Textvipname" Width="150" FieldLabel="顾客姓名" AllowBlank="false" runat="server" DataIndex="vipname" />
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <ext:Cell>
                                    <Items>
                                        <ext:ComboBox ID="Cbovipsex" Editable="false" FieldLabel="性别" AllowBlank="false" Width="210" runat="server" DataIndex="vipsex">
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
                                                StoreID="tz_name_Store" DisplayField="tz_name" TextField="tz_name" AllowBlank="false" ValueField="employeeid" Width="100" runat="server" DataIndex="tz_name">
                                            </ext:ComboBox>
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:NumberField ID="Textmobtel" Width="150" FieldLabel="手机号" AllowBlank="false" runat="server" DataIndex="mobtel" />
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>

                                <ext:Cell>
                                    <ext:DateField ID="Textvipbirth" runat="server" Width="210" FieldLabel="出生年月" AllowBlank="false" Format="yyyy-MM-dd"
                                        DataIndex="vipbirth">
                                    </ext:DateField>
                                </ext:Cell>


                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:ComboBox ID="Cbotvipoccupation" Editable="false" FieldLabel="职业"
                                                StoreID="vipoccupation_Store" DisplayField="vipoccupation" ValueField="vipoccupation" AllowBlank="false" Width="100" runat="server" DataIndex="vipoccupation">
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
                <ext:Button ID="BtnSaveInsert" Text="保存提交" runat="server" Icon="Disk">
                    <DirectEvents>
                        <Click OnEvent="SaveInsert" Success="fnSuccess">
                            <EventMask ShowMask="true" Msg="正在提交，请等候 ..." />
                        </Click>
                    </DirectEvents>
                    <Listeners>
                        <Click Handler="if (#{VIP_MainForm}.getForm().isValid()) {;}else{alert('必填项必须填写，请您确认！');return false;}" />

                    </Listeners>
                </ext:Button>
            </Buttons>

        </ext:Window>

    </form>
</body>
</html>
