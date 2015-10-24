<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StyleCareLabel.aspx.cs" Inherits="StyleCareLabel" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>洗唛打印</title>
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

        body {
            font-size: 12px;
        }

        .Mt {
            border-collapse: collapse;
        }

            .Mt tr {
                border: 1px solid #C0C0C0;
                border-collapse: collapse;
            }


            .Mt th {
                border: 1px solid #C0C0C0;
                background-color: #EEE;
                border-collapse: collapse;
                font-weight: normal;
                width: 60px;
            }

            .Mt td {
                padding: 8px;
                border: 1px solid #C0C0C0;
                border-collapse: collapse;
                height: 25px;
            }

        input {
            border: 1px solid #CCC;
            padding: 3px;
            width: 100px;
        }
        .auto-style1 {
            height: 51px;
        }
    </style>
    <script language="javascript" src="Scripts/LodopFuncs.js"></script>
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0" height="0">
        <embed id="LODOP_EM" type="application/x-print-lodop" width="0" height="0" pluginspage="install_lodop32.exe"></embed>
    </object>
    <script type="text/javascript">
        function SetWinData(index) {
            var record = CLStore.getAt(index);
            CL_MainForm.reset();
            CL_MainForm.getForm().loadRecord(record);
            CL_WinEdit.show();
        }

        function print() {
            if (Y_CareLabel_MainStore.getTotalCount() <= 0) {
                alert("没有记录，无法打印");
                return;
            }
            LODOP = getLodop(document.getElementById('LODOP_OB'), document.getElementById('LODOP_EM'));
           
            LODOP.SET_LICENSES("浙江雅莹服装有限公司", "853717765858688748719056235623", "", "");
            LODOP.PRINT_INITA("0mm", "0mm", "47.6mm", "74.1mm", "HZY");
            LODOP.ADD_PRINT_TEXT("2.1mm", "11.1mm", "17.2mm", "5.3mm", "洗涤说明");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);

            //LODOP.ADD_PRINT_TEXT("2.1mm", "59.1mm", "17.2mm", "5.3mm", "洗涤说明");
            //LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            //LODOP.SET_PRINT_STYLEA(0, "Bold", 1);

            LODOP.ADD_PRINT_TEXT("54.5mm", "0mm", "46mm", "15.9mm", "将不同色系的衣物分开轻柔洗涤\n请勿浸泡\n摩擦部位产生起球现象属于正常\n穿着时避免钩剐\n请使用专业洗涤剂洗\n建议送至专业洗涤店洗效果更佳");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);

            //LODOP.ADD_PRINT_TEXT("54.5mm", "48mm", "46mm", "15.9mm", "将不同色系的衣物分开轻柔洗涤\n请勿浸泡\n摩擦部位产生起球现象属于正常\n穿着时避免钩剐\n请使用专业洗涤剂洗\n建议送至专业洗涤店洗效果更佳");
            //LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            //LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);

            LODOP.ADD_PRINT_TEXT("49.7mm", "10.1mm", "18mm", "5.3mm", "友情提示");
            LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);
            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);

            //LODOP.ADD_PRINT_TEXT("49.7mm", "58.1mm", "18mm", "5.3mm", "友情提示");
            //LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
            //LODOP.SET_PRINT_STYLEA(0, "Alignment", 2);


            LODOP.SET_PRINT_STYLEA(0, "Bold", 1);
            var top = 2;
            var right = 48;
            Y_CareLabel_MainStore.each(function (record) {//Grid源Store ID:store2
                LODOP.ADD_PRINT_IMAGE((6.5+top) + "mm", "5.6mm", "5.3mm", "5.3mm", "<img border='0' src='"+window.location.href.replace("StyleCareLabel.aspx", "XMimg/") + record.get("LbUrl")+"' height='20px' />");
                LODOP.ADD_PRINT_TEXT((7.5+top) + "mm", "13.8mm", "26.5mm", "5.3mm", record.get("LbName"));
                LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
                LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);

                //LODOP.ADD_PRINT_IMAGE((6.5 + top) + "mm", (right+5.6)+"mm", "5.3mm", "5.3mm", "<img border='0' src='" + window.location.href.replace("StyleCareLabel.aspx", "XMimg/") + record.get("LbUrl") + "' height='20px' />");
                //LODOP.ADD_PRINT_TEXT((7.5 + top) + "mm", (right+13.8)+"mm", "26.5mm", "5.3mm", record.get("LbName"));
                //LODOP.SET_PRINT_STYLEA(0, "FontName", "黑体");
                //LODOP.SET_PRINT_STYLEA(0, "FontSize", 6);

                top = (6.5 + top);
            });

            LODOP.SET_PRINT_PAGESIZE(0, "45mm", "78mm", "");
            LODOP.PREVIEW();
        }
    </script>
</head>
<body>
    <form id="MainForm" runat="server">
        <ext:ResourceManager ID="Main_ResourceManager" runat="server" />
        <ext:Hidden ID="StyleIDHidden" runat="server"></ext:Hidden>
        <!--WMS_NOTICE表页面主数据元，自动生成-->
        <ext:Store runat="server" ID="Y_CareLabel_MainStore" OnRefreshData="Y_StyleCLBind">
            <Reader>
                <ext:JsonReader IDProperty="Id">
                    <Fields>
                        <ext:RecordField Name="Id" />
                        <ext:RecordField Name="StyleId" />
                        <ext:RecordField Name="LbUrl" />
                        <ext:RecordField Name="LbName" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <!--下拉列表数据源-->
        <br />
        <br />
        <br />
        <br />
        <!--WMS_NOTICE页面主表格-->
        <table align="center">
            <tr><td><asp:Label ID="lbinfo" ForeColor="Red" runat="server" /></td></tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>款式编号：</td>
                            <td>
                                <asp:TextBox ID="TxtStyleId" runat="server"></asp:TextBox></td>
                            <td>
                                <asp:Button ID="BtnSearch" runat="server" Text="查 询" OnClick="BtnSearch_Click" /></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height:40px;">
                                品牌：<asp:Label ID="lbbrand" runat="server"></asp:Label> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                产地：<asp:Label ID="lbproduction" runat="server"></asp:Label> 
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                品名：<asp:Label ID="lbpm" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <ext:GridPanel ID="Y_CareLabel_Grid" Width="500" Height="400" SelectionMemory="Disabled" TrackMouseOver="true"
                        runat="server" StoreID="Y_CareLabel_MainStore" StripeRows="true" Header="false"
                        Border="false" Frame="true">
                        <TopBar>
                            <ext:Toolbar ID="MainToolBar" runat="server">
                                <Items>
                                    <ext:Button Text="选择图标" Icon="Add">
                                        <Listeners>
                                            <Click Handler="#{CLStore}.reload();#{CL_Win}.show();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarSeparator />
                                    <ext:Button runat="server" Text="删除图标" Icon="Decline">
                                        <DirectEvents>
                                            <Click OnEvent="BtnDelMyXM_Click">
                                                <Confirmation ConfirmRequest="true" Title="确认" Message="您确定要删除吗?" />
                                                <EventMask ShowMask="true" Msg="正在删除数据，请等候 ..." />
                                            </Click>
                                        </DirectEvents>
                                        <Listeners>
                                            <Click Handler="if(#{Y_CareLabel_Grid}.getSelectionModel().getCount()<=0) {alert('请选择要删除的记录');return false;}" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarSeparator />
                                    <ext:Button Text="刷新" Icon="Reload">
                                        <Listeners>
                                            <Click Handler="#{Y_CareLabel_MainStore}.reload();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarFill />
                                    <ext:Button Text="打印洗唛" Icon="Printer">
                                        <Listeners>
                                            <Click Handler="print();" />
                                        </Listeners>
                                    </ext:Button>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>
                        <ColumnModel>
                            <Columns>
                                <ext:RowNumbererColumn Width="30" />
                                <ext:Column Header="自增" Hidden="true" DataIndex="Id" />
                                <ext:Column Header="款号" Sortable="true" DataIndex="StyleId" />
                                <ext:Column Header="图标" Sortable="true" DataIndex="LbUrl" >
                                    <Renderer Handler="return '<img src=XMimg/'+value+' height=50 />';" />
                                </ext:Column>
                                <ext:Column Header="图标名称" Sortable="true" DataIndex="LbName" />
                            </Columns>
                        </ColumnModel>
                        <LoadMask ShowMask="true" Msg="正在加载..." />
                        <SelectionModel>
                            <ext:CheckboxSelectionModel />
                        </SelectionModel>
                    </ext:GridPanel>
                </td>
            </tr>
        </table>

        <ext:Store runat="server" ID="CLStore" OnRefreshData="Y_CL_DataBind" AutoLoad="false">
            <Reader>
                <ext:JsonReader IDProperty="Id">
                    <Fields>
					    <ext:RecordField Name="Id" />
					    <ext:RecordField Name="LbUrl" />
					    <ext:RecordField Name="LbName" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>

        <ext:Window ID="CL_Win" Hidden="true" Modal="true" Maximizable="true"
            runat="server" Border="false" Title="洗唛图片库" Icon="Image" Width="320" Height="450"
            Resizable="true">
            <Items> 
                <ext:FitLayout>
                <Items>
                <ext:GridPanel ID="CL_Grid" Layout="fit" SelectionMemory="Disabled" TrackMouseOver="true"
                        runat="server" StoreID="CLStore" StripeRows="true" Header="false"
                        Border="false" Collapsible="true">
                        <TopBar>
                            <ext:Toolbar runat="server">
                                <Items>
                                    <ext:Button Text="添加图标" Icon="Add">
                                        <Listeners>
                                            <Click Handler="#{CL_MainForm}.getForm().reset();#{CL_WinEdit}.show();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarSeparator />
                                    <ext:Button Text="刷新" Icon="Reload">
                                        <Listeners>
                                            <Click Handler="#{CLStore}.reload();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:ToolbarFill />
                                    <ext:Button ID="Button1" runat="server" Text="删除图标" Icon="Decline">
                                        <DirectEvents>
                                            <Click OnEvent="BtnDel_Click">
                                                <Confirmation ConfirmRequest="true" Title="确认" Message="您确定要删除吗？" />
                                                <EventMask ShowMask="true" Msg="正在删除数据，请等候 ..." />
                                            </Click>
                                        </DirectEvents>
                                        <Listeners>
                                            <Click Handler="if(#{CL_Grid}.getSelectionModel().getCount()<=0) {alert('请选择要删除的记录');return false;}" />
                                        </Listeners>
                                    </ext:Button>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>
                        <ColumnModel>
                            <Columns>
                                <ext:RowNumbererColumn Width="30" />
								<ext:Column Header="自增" Hidden="true" DataIndex="Id" />
								<ext:Column Header="图标地址" Sortable="true" DataIndex="LbUrl" >
                                    <Renderer Handler="return '<img src=XMimg/'+value+' height=50 />';" />
                                </ext:Column>
								<ext:Column Header="图标名称" Sortable="true" DataIndex="LbName" />
                            </Columns>
                        </ColumnModel>
                        <Listeners>
                            <RowDblClick Handler="SetWinData(rowIndex);" />
                        </Listeners>
                        <LoadMask ShowMask="true" Msg="正在加载..." />
                        <SelectionModel>
                            <ext:CheckboxSelectionModel />
                        </SelectionModel>
                    </ext:GridPanel>
                     </Items>
            </ext:FitLayout>
            </Items>
            <Buttons>
                <ext:Button Text="提交选择" runat="server" Icon="Disk">
                    <DirectEvents>
                        <Click OnEvent="BtnSaveSelected_Click">
                            <EventMask ShowMask="true" Msg="正在提交，请等候 ..." />
                        </Click>
                    </DirectEvents>
                    <Listeners>
                        <Click Handler="if(#{CL_Grid}.getSelectionModel().getCount()<=0) {alert('您没有勾选任何记录！');return false;}" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:Window>
        <!--WMS_NOTICE表修改，添加主窗体-->
        <ext:Window ID="CL_WinEdit" Collapsible="true" Hidden="true" Modal="true" Maximizable="true"
            runat="server" Border="false" Title="编辑记录" Icon="Pencil" Width="288" AutoHeight="true"
            Resizable="true">
            <Items>
                <ext:FormPanel ID="CL_MainForm" Padding="10" Border="false" AutoHeight="true"
                    LabelWidth="65">
                    <Items>
                        <ext:TableLayout ColumnWidth="1" Columns="1">
                            <Cells>
                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:FileUploadField ID="UpFile" runat="server" Width="150" CtCls="button-fix" FieldLabel="图标文件"  ButtonText="浏览..."
                                        EmptyText="请选择文件" Icon="LinkAdd" />
                                        </Items>
                                    </ext:Container>
                                </ext:Cell>
                                <ext:Cell>
                                    <ext:Container Layout="Form">
                                        <Items>
                                            <ext:TextField ID="TxtLbName" Width="160" AllowBlank="false" FieldLabel="图标名称" runat="server" DataIndex="LbName" />
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
                        <Click Handler="if (#{CL_MainForm}.getForm().isValid()) {;}else{alert('您填写的信息不正确，请您确认！');return false;}" />
                    </Listeners>
                </ext:Button>
                <ext:Button Text="取消" Icon="Decline">
                    <Listeners>
                        <Click Handler="#{CL_WinEdit}.hide();" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>
