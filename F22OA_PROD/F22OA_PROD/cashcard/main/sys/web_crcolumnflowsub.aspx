<%@ page language="C#" autoeventwireup="true" inherits="sys_web_crcolumnflowsub, App_Web_web_crcolumnflowsub.aspx.9597e00c" %>

<%@ OutputCache   Duration="1"  VaryByParam="aspxid"   %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>审批流程</title>
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href="../css/default.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../js/check.js" ></script>

    <script type="text/javascript">
        <!--

        //添加审批流程
        function addroles()
		{
		    var rn=parseInt(Math.random()*100+1); 
		    var aspxid=document.getElementById("lbl_aspxid").innerHTML;
		    var aspxname=document.getElementById("lbl_aspxname").innerHTML;
            var url="web_crcolumnflowadd.aspx?aspxid=" +aspxid+"&aspxname="+aspxname+"&rn="+rn;
		    LoadWindow(url,600,440);
		    return true;
        }
        
		
        -->
 </script>    

    <script id="Infragistics" type="text/javascript">
<!--
function UltraWebGrid1_BeforeRowDeletedHandler(gridName, rowId)
{
			if(confirm('真的要删除当前记录吗?'))
		  	{
		  	  return false;
		  	}  
		  	else
		  	{
		  	  return true;
		  	}

}
// -->
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div>模块编号:<asp:Label ID="lbl_aspxid" runat="server" Text="" Width="93px"></asp:Label>模块名称:<asp:Label ID="lbl_aspxname" runat="server" Text="" Width="173px"></asp:Label></div>
    <div>
        <igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server" Browser="Xml" Height="403px" OnDeleteRow="UltraWebGrid1_DeleteRow">
            <Bands>
                <igtbl:UltraGridBand>
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
                    <Columns>
                        <igtbl:UltraGridColumn BaseColumnName="flowid" HeaderText="编号" Key="flowid">
                            <Header Caption="编号">
                            </Header>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn BaseColumnName="xh" HeaderText="次序" Key="xh">
                            <Header Caption="次序">
                                <RowLayoutColumnInfo OriginX="1" />
                            </Header>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="1" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn BaseColumnName="readme" HeaderText="说明" Key="readme">
                            <Header Caption="说明">
                                <RowLayoutColumnInfo OriginX="2" />
                            </Header>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="2" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn BaseColumnName="rolesid" HeaderText="权力组" Key="rolesid">
                            <Header Caption="权力组">
                                <RowLayoutColumnInfo OriginX="3" />
                            </Header>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="3" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                        <igtbl:UltraGridColumn BaseColumnName="rolesname" HeaderText="权力组名称" Key="rolesname">
                            <Header Caption="权力组名称">
                                <RowLayoutColumnInfo OriginX="4" />
                            </Header>
                            <Footer>
                                <RowLayoutColumnInfo OriginX="4" />
                            </Footer>
                        </igtbl:UltraGridColumn>
                    </Columns>
                </igtbl:UltraGridBand>
            </Bands>
            <DisplayLayout AllowColSizingDefault="Free" AllowDeleteDefault="Yes" ColWidthDefault="" LoadOnDemand="Xml" Name="UltraWebGrid1"
                NoDataMessage="没有数据" RowHeightDefault="12px" RowsRange="-1" SelectTypeRowDefault="Extended"
                Version="3.00" AutoGenerateColumns="False">
                <GroupByBox Hidden="True">
                </GroupByBox>
                <RowExpAreaStyleDefault TextOverflow="Ellipsis">
                </RowExpAreaStyleDefault>
                <FooterStyleDefault BackColor="LightGray" BorderStyle="Double" BorderWidth="1px"
                    TextOverflow="Ellipsis">
                    <BorderDetails ColorLeft="White" ColorTop="White" StyleBottom="Dashed" StyleLeft="Dotted"
                        StyleRight="Dotted" StyleTop="Dotted" WidthLeft="3px" WidthTop="1px" />
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
                <RowSelectorStyleDefault Font-Names="宋体" Font-Size="9pt" TextOverflow="Ellipsis">
                </RowSelectorStyleDefault>
                <SelectedRowStyleDefault BackColor="#9FBEEB">
                </SelectedRowStyleDefault>
                <HeaderStyleDefault BackColor="Info" HorizontalAlign="Center">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="0px" WidthTop="1px" />
                </HeaderStyleDefault>
                <RowAlternateStyleDefault BackColor="#FFFFC0" TextOverflow="Ellipsis">
                </RowAlternateStyleDefault>
                <EditCellStyleDefault BackColor="Blue" BorderStyle="None" BorderWidth="0px" Font-Names="宋体-18030"
                    Font-Size="9pt" ForeColor="White" Height="16px">
                </EditCellStyleDefault>
                <FrameStyle BackColor="White" BorderColor="Blue" BorderStyle="Inset" BorderWidth="1px"
                    Font-Names="宋体" Font-Size="9pt" Height="403px">
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
                <ClientSideEvents BeforeRowDeletedHandler="UltraWebGrid1_BeforeRowDeletedHandler" />
            </DisplayLayout>
        </igtbl:UltraWebGrid>
        </div>   　 
        <div style="text-align:right" > <asp:Button ID="Button1" runat="server" CssClass="btSubmit" OnClick="Button1_Click"
                        Text="添加审批流程" Width="101px" OnClientClick="addroles()" /></div>
    </form>
</body>
</html>
