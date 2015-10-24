<%@ page language="C#" autoeventwireup="true" inherits="web_rolesaspxlistsel, App_Web_web_rolesaspxlistsel.aspx.9597e00c" %>
<%@   OutputCache   Duration="1"   VaryByParam="none"   %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>权力组模块列表</title>
    <base target="_self" />
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href="../css/default.css" rel="stylesheet" type="text/css" />
     <script type="text/javascript">
        <!--
        function UltraWebGrid1_XmlHTTPResponseHandler(gridName, rowId, gridResponse)
        {
            
            var oFeedBackLabel = igtbl_getElementById("lblFeedBack");
            
            var xmlResponceObject = gridResponse ; 
            
            if (xmlResponceObject.ReqType==igtbl_reqType.UpdateRow ||
                xmlResponceObject.ReqType==igtbl_reqType.AddNewRow 
            )
            {
                if (xmlResponceObject.Tag=="-1")
                {
                  igtbl_deleteRow(gridName,rowId);
                 }
                oFeedBackLabel.innerHTML = xmlResponceObject.StatusMessage;
            }
            
        }

 
        //选模块
        function select_aspx()
		{      
		        var oFeedBackLabel = igtbl_getElementById("lbl_rolesid");
		        if (oFeedBackLabel==null)
		        {
		           alert("系统内部错误，找不到lbl_rolesid!");
		           return 1;
		        }
                var url="web_aspxsel.aspx?rolesid=" +oFeedBackLabel.innerHTML;
                
			    LoadWindow(url,600,440);
			    return 0;
        }
		
						
        -->
 </script>

    

    <script id="Infragistics" type="text/javascript">
<!--

//删除当前记录
function UltraWebGrid1_BeforeRowDeletedHandler(gridName, rowId)
{
    if(confirm("真的要删除当前记录吗?"))
    {
	   return 0;
    }

    return 1;
}
function UltraWebGrid1_ColumnHeaderClickHandler(gridName, columnId, button)
{
	var cellList = columnId.split("_");
    if(cellList[1] == null||cellList[3] == null)
    {
        return;
    }
    var cellColIndex = cellList[3];
    if (cellColIndex<3)
    {
       return;
    }
    var all = igtbl_getElementById("CheckBox_all");
    var v=0;
    if (all.checked)
    {
       v=1;
    }
	var oGrid = oUltraWebGrid1;
    var oRows = oGrid.Rows;
    for(i=0; i<oRows.length; i++) 
    {
        if (cellColIndex==17)
        {
          for (j=3;j<17;j++)
          {
            oRows.getRow(i).getCell(j).setValue(v);
          }
        }
        else
        {
            oRows.getRow(i).getCell(cellColIndex).setValue(v);
        }
        
        
    }

}
   
function UltraWebGrid1_BeforeCellUpdateHandler(gridName, cellId, value)
{
    var cellList = cellId.split("_");
    if(cellList[1] == null||cellList[2] == null)
    {
        return;
    }
    var cellColIndex = cellList[3];
    if (cellColIndex==17)
    {
        var row=igtbl_getActiveRow(gridName); 
        if (row==null) 
        {
            alert("你的IE发生意外.");
            return 1;
        }
        var v=value ;//row.getCellFromKey("sel").getValue();	
        row.getCellFromKey("p_add").setValue(v);
        row.getCellFromKey("p_edit").setValue(v);
        row.getCellFromKey("p_del").setValue(v);
        row.getCellFromKey("p_prn").setValue(v);
        row.getCellFromKey("p_export").setValue(v);
        row.getCellFromKey("p_chk").setValue(v);
        row.getCellFromKey("p_sure").setValue(v);
        row.getCellFromKey("p_unchk").setValue(v);
        row.getCellFromKey("p_unsure").setValue(v);
        row.getCellFromKey("p_reta").setValue(v);
        row.getCellFromKey("p_ereta").setValue(v);
        row.getCellFromKey("p_cost").setValue(v);
        row.getCellFromKey("p_price").setValue(v);
        row.getCellFromKey("p_sprice").setValue(v);
        
    }
}// -->
</script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div>
    <table>
    <tr>
       <td align="right">
           <table>
               <tr>
                   <td >
                       用户编号：</td>
                   <td >
                       <asp:Label ID="lbl_userid" runat="server" ForeColor="Red" ></asp:Label></td>
                   <td >
                       用户姓名：</td>
                   <td >
                       <asp:Label ID="lbl_username" runat="server" ForeColor="Red"></asp:Label></td>
                    <td>
                        <asp:Label ID="lbl_rolesid" runat="server" ForeColor="Red" Width="50px"></asp:Label>
                        <asp:Label ID="lblFeedBack" runat="server" ForeColor="Red" Width="89px"></asp:Label></td>
               </tr>
                 <tr>
                   <td >
                    </td>
                   <td >
                      </td>
                   <td >
                       </td>
                   <td >
                       </td>
                    <td align="right">
                  <asp:Label ID="lbl_type" runat="server" Text="点击列台头执行："></asp:Label><asp:CheckBox
               ID="CheckBox_all" runat="server" Text="全部打勾" />
                    </td>
               </tr>
           </table>
           </td>
    </tr>  
    <tr>
       <td>
        <igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server" DataSourceID="ds_aspx" Height="280px"
            OnInitializeLayout="UltraWebGrid1_InitializeLayout" Width="730px">
            <Bands>
                <igtbl:UltraGridBand Key="aspxid">
                    <AddNewRow View="NotSet" Visible="NotSet">
                    </AddNewRow>
                    <FilterOptions AllString="" EmptyString="" NonEmptyString="">
                        <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                            CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                            Font-Size="11px" Width="200px">
                            <Padding Left="2px" />
                        </FilterDropDownStyle>
                        <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
                        </FilterHighlightRowStyle>
                    </FilterOptions>
                    <Columns>
                             <igtbl:UltraGridColumn BaseColumnName="ctype" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="类型" Key="ctype" Width="30px">
                                         <Header Caption="类型" Title="">
                                         </Header>
                                         <CellStyle HorizontalAlign="Left">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="aspxid" EditorControlID=""
                                         FooterText="" Format="" FormulaErrorValue="" HeaderText="编号" Key="aspxid" Width="60px">
                                         <Header Caption="编号" Title="">
                                             <RowLayoutColumnInfo OriginX="1" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Left">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="1" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="readme" EditorControlID=""
                                         FooterText="" Format="" FormulaErrorValue="" HeaderText="模块名称" Key="readme" Width="120px">
                                         <Header Caption="模块名称" Title="">
                                             <RowLayoutColumnInfo OriginX="2" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Left">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="2" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_add" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="新增" Key="p_add" Type="CheckBox" Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="新增" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="3" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="3" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_del" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="删除" Key="p_del" Type="CheckBox" Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="删除" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="4" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="4" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_edit" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="编辑" Key="p_edit" Type="CheckBox" Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="编辑" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="5" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="5" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_chk" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="审核" Key="p_chk" Type="CheckBox" Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="审核" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="6" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="6" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_sure" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="登帐" Key="p_sure" Type="CheckBox" Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="登帐" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="7" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="7" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_prn" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="打印" Key="p_prn" Type="CheckBox" Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="打印" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="8" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="8" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_export" EditorControlID="" FooterText=""
                                         Format="" FormulaErrorValue="" HeaderText="导出" Key="p_export" Type="CheckBox"
                                         Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="导出" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="9" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="9" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_unchk" EditorControlID="" FooterText=""
                                         Format="" FormulaErrorValue="" HeaderText="反审核" Key="p_unchk" Type="CheckBox"
                                         Width="40px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="反审核" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="10" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="10" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_unsure" EditorControlID="" FooterText=""
                                         Format="" FormulaErrorValue="" HeaderText="反登帐" Key="p_unsure" Type="CheckBox"
                                         Width="40px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="反登帐" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="11" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="11" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_cost" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="看成本价" Key="p_cost" Type="CheckBox" Width="50px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="看成本价" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="12" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="12" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_price" EditorControlID="" FooterText="" Format="" 
                                        FormulaErrorValue="" HeaderText="看零售价" Key="p_price" Type="CheckBox" Width="50px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="看零售价" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="13" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="13" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_sprice" EditorControlID="" FooterText=""
                                         Format="" FormulaErrorValue="" HeaderText="看结算价" Key="p_sprice" Type="CheckBox"
                                         Width="50px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="看结算价" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="14" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="14" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_reta" EditorControlID="" FooterText="" Format=""
                                         FormulaErrorValue="" HeaderText="看折扣" Key="p_reta" Type="CheckBox" Width="40px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="看折扣" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="15" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="15" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn BaseColumnName="p_ereta" EditorControlID="" FooterText=""
                                         Format="" FormulaErrorValue="" HeaderText="改折扣" Key="p_ereta" Type="CheckBox"
                                         Width="40px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="改折扣" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="16" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Center">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="16" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn EditorControlID="" FooterText="" Format="" FormulaErrorValue=""
                                         HeaderText="全选" Key="all" Type="CheckBox" Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="全选" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="17" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Left">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="17" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                                     <igtbl:UltraGridColumn EditorControlID="" FooterText="" Format="" FormulaErrorValue=""
                                         HeaderText="操作" Key="sel" Type="CheckBox" Width="30px">
                                         <HeaderStyle Cursor="Hand" />
                                         <Header Caption="操作" Title="">
                                             <Style Cursor="Hand"></Style>
                                             <RowLayoutColumnInfo OriginX="18" />
                                         </Header>
                                         <CellStyle HorizontalAlign="Left">
                                         </CellStyle>
                                         <Footer Caption="" Title="">
                                             <RowLayoutColumnInfo OriginX="18" />
                                         </Footer>
                                     </igtbl:UltraGridColumn>
                    </Columns>
                </igtbl:UltraGridBand>
            </Bands>
            <DisplayLayout AutoGenerateColumns="False" Name="UltraWebGrid1"
                RowHeightDefault="20px" RowsRange="20" SelectTypeRowDefault="Extended" Version="3.00" ColWidthDefault="">
                <GroupByBox Hidden="True">
                </GroupByBox>
                <RowExpAreaStyleDefault TextOverflow="Ellipsis">
                </RowExpAreaStyleDefault>
                <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                </FooterStyleDefault>
                <RowStyleDefault BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px" TextOverflow="Ellipsis">
                    <BorderDetails WidthLeft="0px" WidthTop="0px" />
                    <Padding Left="3px" />
                </RowStyleDefault>
                <FilterOptionsDefault AllString="(All)" EmptyString="(Empty)" NonEmptyString="(NonEmpty)">
                    <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                        CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                        Font-Size="11px" Width="200px">
                        <Padding Left="2px" />
                    </FilterDropDownStyle>
                    <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
                    </FilterHighlightRowStyle>
                </FilterOptionsDefault>
                <RowSelectorStyleDefault TextOverflow="Ellipsis">
                </RowSelectorStyleDefault>
                <SelectedRowStyleDefault BackColor="#9FBEEB">
                </SelectedRowStyleDefault>
                <HeaderStyleDefault BackColor="Info" BorderStyle="Solid" HorizontalAlign="Center">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                </HeaderStyleDefault>
                <RowAlternateStyleDefault BackColor="#FFFFC0" TextOverflow="Ellipsis">
                </RowAlternateStyleDefault>
                <EditCellStyleDefault BorderStyle="None" BorderWidth="0px" Font-Names="Verdana" Font-Size="8pt">
                </EditCellStyleDefault>
                <FrameStyle BackColor="White" BorderColor="Blue" BorderStyle="Inset" BorderWidth="1px"
                    Font-Names="Verdana" Font-Size="8pt" Height="280px" Width="730px">
                </FrameStyle>
                <FixedCellStyleDefault TextOverflow="Ellipsis">
                </FixedCellStyleDefault>
                <Pager>
                    <Style BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
</Style>
                </Pager>
                <AddNewBox>
                    <Style BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
<BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
</Style>
                </AddNewBox>
                    <ClientSideEvents XmlHTTPResponseHandler="UltraWebGrid1_XmlHTTPResponseHandler" BeforeRowDeletedHandler="UltraWebGrid1_BeforeRowDeletedHandler" ColumnHeaderClickHandler="UltraWebGrid1_ColumnHeaderClickHandler" BeforeCellUpdateHandler="UltraWebGrid1_BeforeCellUpdateHandler" />
            </DisplayLayout>
        </igtbl:UltraWebGrid><br />
          <table>
            <tr>
            <td>
            <asp:Button ID="ButtonDel" runat="server" CssClass="btSubmit" OnClick="ButtonDel_Click"
                        Text="删除操作栏打勾的权力组" Width="155px"  OnClientClick="return confirm('确认要删除操作栏选中的数据吗？')" />
            </td>
                <td style="width: 100px">
                
        <asp:Button ID="Button1" runat="server" Text="保存" Width="57px" CssClass="btSubmit" OnClick="Button1_Click" /></td>
                <td style="width: 100px">
        <input id="Button2" style="width: 52px" class="btSubmit" type="button" value="取消" onclick="window.close();" /></td>
            </tr>
        </table>
        <asp:ObjectDataSource ID="ds_aspx" runat="server" OnSelecting="ds_aspx_Selecting" SelectMethod="selectUserSel" TypeName="app_userroles" OldValuesParameterFormatString="original_{0}">
            <SelectParameters>
                <asp:ControlParameter ControlID="HFrolseid" Name="rolesid" PropertyName="Value" Type="Int32" />
                <asp:ControlParameter ControlID="lbl_userid" Name="userid" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
           <asp:HiddenField ID="HFrolseid" runat="server" />
    </td>
    </tr>
    </table>
    </div>
    </form>
</body>
</html>
