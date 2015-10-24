<%@ page language="C#" autoeventwireup="true" inherits="web_rolesuserlist, App_Web_web_rolesuserlist.aspx.9597e00c" %>
<%@   OutputCache   Duration="1"   VaryByParam="none"   %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>查看拥有此权力组的用户</title>
    <base target="_self" />
    <link href="../css/default.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/check.js" ></script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <table style="width: 260px; height: 151px; border-collapse: collapse;">
            <tr>
                <td align="left" valign="top" style="width: 403px">
                <div>权力组编号：<asp:Label ID="lbl_userid" runat="server" Width="104px"></asp:Label> 权利组名称：
        <asp:Label ID="lbl_username" runat="server" Width="109px"></asp:Label></div>
        <igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server"
            Height="280px" OnInitializeLayout="UltraWebGrid1_InitializeLayout" Width="378px">
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
                        <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="userid" HeaderText="编号" Key="userid"
                            Width="100px">
                            <Header Caption="编号">
                            </Header>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn AllowUpdate="No" BaseColumnName="username" HeaderText="姓名"
                            Key="username">
                            <Header Caption="姓名">
                                <RowLayoutColumnInfo OriginX="1" />
                            </Header>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="1" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                    </Columns>
                </igtbl:UltraGridBand>
            </Bands>
            <DisplayLayout
                AutoGenerateColumns="False" Name="UltraWebGrid1"
                RowHeightDefault="20px" RowsRange="20" SelectTypeRowDefault="Extended" Version="3.00" AllowUpdateDefault="Yes" ColWidthDefault="">
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
                    Font-Names="Verdana" Font-Size="8pt" Height="280px" Width="378px">
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
        </igtbl:UltraWebGrid>
        <p></p>
        <div style="text-align:right"><input id="Button2" style="width: 52px" class="btSubmit" type="button" value="关闭" onclick="window.close();" /></div>
        </td>
            </tr>
        </table>
    </form>
</body>
</html>
