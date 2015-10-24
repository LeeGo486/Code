<%@ page language="C#" autoeventwireup="true" inherits="web_userrrolesuserlist, App_Web_web_userrrolesuserlist.aspx.9597e00c" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>用户权力列表</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href="../css/default.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/check.js" ></script>
       <script type="text/javascript">
        <!--

 
        //查看模块
        function user_seeaspx()
		{
  		        var row=igtbl_getActiveRow("UltraWebGrid1"); 
			    var rolesid=row.getCellFromKey("rolesid").getValue();	
			     var userid = igtbl_getElementById("HFtouserid").value;
			     var username = igtbl_getElementById("HFtousername").value;
  		        if (userid==null)
		        {
		           alert("系统内部错误，找不到将要分配权限的用户!");
		           return 1;
		        }
  		       
                var url="web_rolesaspxlistsel.aspx?rolesid=" +rolesid+"&userid=" +userid+"&username="+escape(username);
               
			    LoadWindow(url,600,440);
        }
		
						
        -->
        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <igtbl:ultrawebgrid id="UltraWebGrid1" runat="server" browser="Xml" enableviewstate="False"
            height="197px" oninitializelayout="UltraWebGrid1_InitializeLayout" width="77%" DataSourceID="ds_roles">
            <Bands>
                <igtbl:UltraGridBand>
                    <AddNewRow View="NotSet" Visible="NotSet">
                    </AddNewRow>
                    <FilterOptions AllString="" EmptyString="" NonEmptyString="">
                        <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                            CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                                                            Font-Size="11px" Width="200px">
                            <Padding Left="2px"  />
                        </FilterDropDownStyle>
                        <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
                        </FilterHighlightRowStyle>
                    </FilterOptions>
                    <Columns>
                        <igtbl:UltraGridColumn BaseColumnName="rolesid" HeaderText="编号" Key="rolesid" Width="50px">
                            <Header Caption="编号">
                            </Header>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn BaseColumnName="rolesname" HeaderText="权力组名称" Key="rolesname"
                            Width="140px">
                            <Header Caption="权力组名称">
                                <RowLayoutColumnInfo OriginX="1" />
                            </Header>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="1" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn BaseColumnName="comment" HeaderText="备注" Key="comment" Width="120px">
                            <Header Caption="备注">
                                <RowLayoutColumnInfo OriginX="2" />
                            </Header>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="2" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                        <igtbl:TemplatedColumn AllowUpdate="No" HeaderText="查看模块" HTMLEncodeContent="True"
                            Key="save" Width="60px">
                            <CellTemplate>
                                <a href="#" onclick="javascript:return user_seeaspx()">查看</a>
                            </CellTemplate>
                            <Header Caption="查看模块">
                                <RowLayoutColumnInfo OriginX="3" />
                            </Header>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="3" />
                            </Footer>
                        </igtbl:TemplatedColumn>
                        <igtbl:UltraGridColumn AllowUpdate="Yes" FooterText="" HeaderText="删除" HTMLEncodeContent="True"
                            Key="del" Type="CheckBox" Width="50px">
                            <Header Caption="删除">
                                <RowLayoutColumnInfo OriginX="4" />
                            </Header>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                            <Footer Caption="">
                                <RowLayoutColumnInfo OriginX="4" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                    </Columns>
                    <RowEditTemplate>
                        <br />
                        <p align="center">
                            <input id="igtbl_reOkBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                                type="button" value="OK" />&nbsp;
                            <input id="igtbl_reCancelBtn" onclick="igtbl_gRowEditButtonClick(event);" style="width: 50px"
                                type="button" value="Cancel" /></p>
                    </RowEditTemplate>
                    <RowTemplateStyle BackColor="White" BorderColor="White" BorderStyle="Ridge">
                        <BorderDetails WidthBottom="3px" WidthLeft="3px" WidthRight="3px" WidthTop="3px" />
                    </RowTemplateStyle>
                </igtbl:UltraGridBand>
            </Bands>
            <DisplayLayout AllowDeleteDefault="Yes" AllowAddNewDefault="Yes" RowHeightDefault="20px" Version="3.00" SelectTypeRowDefault="Extended" RowsRange="20" BorderCollapseDefault="Separate"  Name="UltraWebGrid1" AllowUpdateDefault="Yes" AutoGenerateColumns="False">
                <GroupByBox Hidden="True">
                </GroupByBox>
                <RowExpAreaStyleDefault TextOverflow="Ellipsis">
                </RowExpAreaStyleDefault>
                <FooterStyleDefault BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"  />
                </FooterStyleDefault>
                <RowStyleDefault TextOverflow="Ellipsis" BorderWidth="1px" BorderColor="Gray" BorderStyle="Solid">
                    <BorderDetails WidthLeft="0px" WidthTop="0px"  />
                    <Padding Left="3px"  />
                </RowStyleDefault>
                <FilterOptionsDefault AllString="(All)" EmptyString="(Empty)" NonEmptyString="(NonEmpty)">
                    <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                        CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                                                        Font-Size="11px" Width="200px">
                        <Padding Left="2px"  />
                    </FilterDropDownStyle>
                    <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
                    </FilterHighlightRowStyle>
                </FilterOptionsDefault>
                <RowSelectorStyleDefault TextOverflow="Ellipsis">
                </RowSelectorStyleDefault>
                <SelectedRowStyleDefault BackColor="#9FBEEB">
                </SelectedRowStyleDefault>
                <HeaderStyleDefault BorderStyle="Solid" HorizontalAlign="Center" BackColor="Info">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px"  />
                </HeaderStyleDefault>
                <RowAlternateStyleDefault TextOverflow="Ellipsis" BackColor="#FFFFC0">
                </RowAlternateStyleDefault>
                <EditCellStyleDefault BorderWidth="0px" Font-Size="8pt" Font-Names="Verdana" BorderStyle="None">
                </EditCellStyleDefault>
                <FrameStyle Width="77%" BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana" BorderStyle="Inset" BackColor="White" Height="197px" BorderColor="Blue">
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
            </DisplayLayout>
        </igtbl:ultrawebgrid><table style="width: 485px; text-align: center">
            <tr>
                <td style="width: 100px" align="center" valign="middle">
                    <asp:Button ID="Button1" runat="server" CssClass="btSubmit" OnClick="Button1_Click"
                        Text="删除所有打勾的权力组" Width="155px" /></td>
            </tr>
        </table>
        <asp:HiddenField ID="HFtouserid" runat="server" />
        <asp:HiddenField ID="HFtousername" runat="server" />
    
    </div>
        <asp:ObjectDataSource ID="ds_roles" runat="server" OnSelecting="ds_roles_Selecting" SelectMethod="select" TypeName="app_userroles">
            <SelectParameters>
                <asp:Parameter Name="userid" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </form>
</body>
</html>
