<%@ page language="C#" autoeventwireup="true" inherits="web_userrolescradd, App_Web_web_userrolescradd.aspx.9597e00c" %>
<%@   OutputCache   Duration="1"   VaryByParam="none"   %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>添加权力组</title>
    <base target="_self" />
    <link href="../css/default.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/check.js" ></script>
    <script type="text/javascript">
        <!--

 
        //查看模块
        function user_seeaspx()
		{
  		        var row=igtbl_getActiveRow("UltraWebGrid1"); 
  		        var userid = igtbl_getElementById("lbl_userid").innerHTML;
  		          if (userid==null)
		        {
		           alert("系统内部错误，找不到将要分配权限的用户!");
		           return 1;
		        }
  		        var username = igtbl_getElementById("lbl_username").innerHTML;
			    var rolesid=row.getCellFromKey("rolesid").getValue();	
                var url="web_rolesaspxlist.aspx?rolesid=" +rolesid+"&userid=" +userid+"&username="+escape(username);
                
			    LoadWindow(url,600,440);
        }
		
						
        -->
 </script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td style="width: 100px">
                    用户编号：</td>
                <td style="width: 100px">
                    <asp:Label ID="lbl_userid" runat="server" Text="" Width="92px"></asp:Label></td>
                <td style="width: 100px">
                    用户姓名：</td>
                <td style="width: 100px">
                    <asp:Label ID="lbl_username" runat="server" Text="" Width="93px"></asp:Label></td>
            </tr>
        </table>
        <igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server"
            Height="280px" OnInitializeLayout="UltraWebGrid1_InitializeLayout" Width="94%" DataSourceID="ds_roles">
            <Bands>
                <igtbl:UltraGridBand Key="roles">
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
                        <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="rolesid" HeaderText="编号"
                            Key="rolesid" Width="30px">
                            <Header Caption="编号">
                            </Header>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="rolesname" HeaderText="权力组名称"
                            Key="rolesname" Width="140px">
                            <Header Caption="权力组名称">
                                <RowLayoutColumnInfo OriginX="1" />
                            </Header>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="1" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="comment" HeaderText="备注"
                            Key="comment" Width="120px">
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
                                <RowLayoutColumnInfo OriginX="4" />
                            </Header>
                            <CellStyle HorizontalAlign="Center">
                            </CellStyle>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="4" />
                            </Footer>
                        </igtbl:TemplatedColumn>
                    </Columns>
                </igtbl:UltraGridBand>
            </Bands>
            <DisplayLayout
                AutoGenerateColumns="False" Name="UltraWebGrid1"
                RowHeightDefault="20px" RowsRange="20" SelectTypeRowDefault="Extended" Version="3.00" AllowUpdateDefault="Yes">
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
                    Font-Names="Verdana" Font-Size="8pt" Height="280px" Width="94%">
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
        </igtbl:UltraWebGrid><br />
        <table>
            <tr>
                <td style="width: 100px">
                    &nbsp;<input id="Button2" style="width: 52px" class="btSubmit" type="button" value="返回" onclick="window.close();" /></td>
                <td style="width: 100px">
                    &nbsp;<asp:Button ID="Button1" runat="server" Text="保存" Width="57px" CssClass="btSubmit" Visible="false" OnClick="Button1_Click" /></td>
            </tr>
        </table>
    </div>
        &nbsp;&nbsp;
        <asp:ObjectDataSource ID="ds_roles" runat="server" OnSelecting="ds_roles_Selecting" SelectMethod="selectnosel" TypeName="app_userroles">
            <SelectParameters>
                <asp:Parameter DefaultValue="" Name="userid" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        &nbsp;
    </form>
</body>
</html>
