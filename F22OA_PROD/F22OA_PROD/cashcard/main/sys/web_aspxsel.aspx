<%@ page language="C#" autoeventwireup="true" inherits="web_aspxsel, App_Web_web_aspxsel.aspx.9597e00c" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>模块组列表</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href="../css/default.css" rel="stylesheet" type="text/css" />
    <base target="_self" />
    <script id="Infragistics" type="text/javascript">
<!--
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
                var v=false;
                if (all.checked)
                {
                   v=true;
                }
	            var oGrid = oUltraWebGrid1;
                var oRows = oGrid.Rows;
                for(i=0; i<oRows.length; i++) 
                {
                    if (cellColIndex==13)
                    {
                      for (j=3;j<13;j++)
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
        function SelectAll(tempControl, columnId)
            {
              
	           /* var cellList = columnId.split("_");
               // if(cellList[1] == null||cellList[3] == null)
                {
                    return;
                }
                var cellColIndex = cellList[3];
                if (cellColIndex<3)
                {
                   return;
                }*/
                //var all = igtbl_getElementById("CheckBox_all");
                 var theBox=tempControl;
               xState=theBox.checked;  
                var v=false;
                //if (all.checked)
                if (xState)
                {
                   v=true;
                }
	            var oGrid =oUltraWebGrid1;//oUltraWebGrid1;//oUltraWebGrid1;
                var oRows = oGrid.Rows;
                //var oCells = oGrid.Cells;
                if(oRows.length>0)
                {
                    for(i=0; i<oRows.length; i++) 
                    {
                      

                            oRows.getRow(i).getCell(columnId).setValue(v);
                          

                    }
                }

        }// -->
        // -->
</script>   
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div>
        <table style="width: 530px">
            <tr>
                <td style="width: 100px" align="right" valign="middle">
                    <asp:Label ID="Label1" runat="server" Text="模块分类：" Width="100px"></asp:Label></td>
                <td style="width: 100px" align="left">
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="132px" DataTextField="ctype" DataValueField="ctype" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" DataSourceID="ds_group" AppendDataBoundItems="True">
                        <asp:ListItem>请选择一种类型</asp:ListItem>
                    </asp:DropDownList></td>
                    <td align="right" style="width: 100px" valign="middle">
                    <asp:Label ID="lbl_type" runat="server" Text="点击列台头执行：" Width="118px"></asp:Label></td>
                <td style="width: 100px" align="left" valign="middle">
                    <asp:CheckBox ID="CheckBox_all" runat="server" Text="全部打勾" Width="130px"  onclick="javascript:SelectAll(this,4);" /></td>
         
            </tr>
        </table>
    
    </div>
        <table style="width: 547px; height: 323px">
            <tr>
                <td style="width: 656px" align="left" valign="top">
                    <igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server" Browser="Xml"
                        EnableViewState="False" Height="285px" OnInitializeLayout="UltraWebGrid1_InitializeLayout"
                        Width="536px" DataSourceID="ds_aspx">
                        <Bands>
                            <igtbl:UltraGridBand>
                                <RowEditTemplate>
                                    <br />
                                    <p align="center">
                                        <input id="igtbl_reOkBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                                            type="button" value="OK" />&nbsp;
                                        <input id="igtbl_reCancelBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                                            type="button" value="Cancel" /></p>
                                </RowEditTemplate>
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
                                <RowTemplateStyle BackColor="White" BorderColor="White" BorderStyle="Ridge">
                                    <BorderDetails WidthBottom="3px" WidthLeft="3px" WidthRight="3px" WidthTop="3px" />
                                </RowTemplateStyle>
                            </igtbl:UltraGridBand>
                        </Bands>
                        <DisplayLayout AllowAddNewDefault="Yes" AllowDeleteDefault="Yes" AllowUpdateDefault="Yes" BorderCollapseDefault="Separate" Name="UltraWebGrid1"
                            RowHeightDefault="20px" RowsRange="20" SelectTypeRowDefault="Extended" Version="3.00" AllowColSizingDefault="Free" CellClickActionDefault="NotSet" NoDataMessage="请选择模块类别">
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
                                Font-Names="Verdana" Font-Size="8pt" Height="285px" Width="536px">
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
                                <ClientSideEvents  ColumnHeaderClickHandler="UltraWebGrid1_ColumnHeaderClickHandler"  />
                        </DisplayLayout>
                    </igtbl:UltraWebGrid></td>
            </tr>
        </table>
        <table style="width: 543px; text-align: right;">
            <tr>
                <td style="width: 100px" align="right">
                    </td>
                <td style="width: 100px" align="left">
                    &nbsp;<asp:Button ID="Button1" runat="server" CssClass="btSubmit" OnClick="Button1_Click"
                        Text="保存" Width="67px" /></td>
                <td align="left" style="width: 100px">
                    &nbsp;<input id="Button2" class="btSubmit" onclick="window.close();" style="width: 67px"
                        type="button" value="取消" /></td>
            </tr>
        </table>
        <asp:ObjectDataSource ID="ds_group" runat="server" SelectMethod="selectgroup" TypeName="app_aspx"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="ds_aspx" runat="server" OnSelecting="ds_aspx_Selecting" SelectMethod="select_NoSelList" TypeName="app_rolesaspx">
            <SelectParameters>
                <asp:Parameter Name="ctype" Type="String" />
                <asp:Parameter Name="rolesid" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
        &nbsp;&nbsp;
    </form>
</body>
</html>
