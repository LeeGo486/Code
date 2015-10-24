<%@ page language="C#" autoeventwireup="true" inherits="StylePicture, App_Web_n234bbfq" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>款式档案图片</title>
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
                text-align:center;
            }

            .Mt td {
                padding: 8px;
                border: 1px solid #C0C0C0;
                border-collapse: collapse;
                height: 25px;
                min-width:50px;
            }

        input {
            border: 1px solid #CCC;
            padding: 3px;
            width: 100px;
        }
    </style>
    <script type="text/javascript">
        function CommandDeal(name, rec) {
            CL_WinEdit.setTitle(rec.StyleId + rec.ColorId);
            CL_MainForm.getForm().reset();
            Hid.setValue(rec.StyleId + rec.ColorId);
            CL_WinEdit.show();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="Main_ResourceManager" runat="server" />
        <ext:Store runat="server" ID="Y_MainStore" OnRefreshData="Y_PictureBind">
            <Reader>
                <ext:JsonReader>
                    <Fields>
                        <ext:RecordField Name="StyleId" />
                        <ext:RecordField Name="ColorId" />
                        <ext:RecordField Name="Picture" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>
        <table align="center">
            <tr><td><asp:Label ID="lbinfo" ForeColor="Red" runat="server" /></td></tr>
            <tr>
                <td>
                    <table class="Mt" Width="500" >
                        <tr>
                            <td colspan="8">款号：
                                <asp:TextBox ID="TxtStyleId" runat="server"></asp:TextBox>
                                <asp:Button ID="BtnSearch" runat="server" Text="查 询" OnClick="BtnSearch_Click" /></td>
                        </tr>
                        <tr>
                            <th>品牌：</th>
                            <td>
                                <asp:Label ID="lbBrand" runat="server"></asp:Label>
                            </td>
                            <th>品名：</th>
                            <td>
                                <asp:Label ID="lbPinM" runat="server"></asp:Label>
                            </td>
                            <th>年份：</th>
                            <td colspan="3">
                                <asp:Label ID="lbYear" runat="server"></asp:Label>
                            </td>                            
                            
                        </tr>
                        <tr>
                            <th>季节：</th>
                            <td>
                                <asp:Label ID="lbSeason" runat="server"></asp:Label>
                            </td>
                            <th>种类：</th>
                            <td>
                                <asp:Label ID="lbxl" runat="server"></asp:Label>
                            </td>
                            <th>大类：</th>
                            <td class="auto-style1">
                                <asp:Label ID="lbDl" runat="server"></asp:Label>
                            </td>
                            <th>小类：</th>
                            <td>
                                <asp:Label ID="lbxz" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    <ext:GridPanel ID="Y_Grid" Width="500" Height="400" SelectionMemory="Disabled" TrackMouseOver="true"
                        runat="server" StoreID="Y_MainStore" StripeRows="true" Header="false"
                        Border="false" Frame="true">
                        <ColumnModel>
                            <Columns>
                                <ext:RowNumbererColumn Width="30" />
                                <ext:Column Header="款号" Sortable="true" DataIndex="StyleId" />
                                <ext:Column Header="颜色" Sortable="true" DataIndex="ColorId" />
                                <ext:Column Header="图标" Sortable="true" DataIndex="Picture" >
                                    <Renderer Handler="if(value==null || value=='') return '无'; else return '<img src=StylePicture/'+value+' height=50 />';" />
                                </ext:Column>
                                <ext:CommandColumn Width="60" Header="操作">
                                    <Commands>
                                        <ext:GridCommand Icon="ImageAdd" CommandName="Add">
                                            <ToolTip Text="上传，变更款式图片" />
                                        </ext:GridCommand>
                                    </Commands>
                                </ext:CommandColumn>
                            </Columns>
                        </ColumnModel>
                        <LoadMask ShowMask="true" Msg="正在加载..." />
                        <SelectionModel>
                            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" />
                        </SelectionModel>
                        <Listeners>
                            <Command Handler="return CommandDeal(command,record.data)" />
                        </Listeners>
                    </ext:GridPanel>
                </td>
            </tr>
        </table>
        <!--WMS_NOTICE表修改，添加主窗体-->
        <ext:Window ID="CL_WinEdit" Hidden="true" Modal="true"
            runat="server" Border="false" Title="编辑记录" Icon="Pencil" Width="288" AutoHeight="true">
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
                <ext:Button ID="Button1" Text="清除图片" runat="server" Icon="Delete">
                    <DirectEvents>
                        <Click OnEvent="BtnClearImg_Click">
                            <EventMask ShowMask="true" Msg="正在清除，请等候 ..." />
                        </Click>
                    </DirectEvents>
                </ext:Button>
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
