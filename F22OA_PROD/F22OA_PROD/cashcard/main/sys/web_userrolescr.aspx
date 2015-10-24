<%@ page language="C#" autoeventwireup="true" inherits="web_userrolescr, App_Web_web_userrolescr.aspx.9597e00c" %>
<%@ OutputCache   Duration="1"  VaryByParam="merchantid;dptid;dptype"   %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>分配权力</title>
    
    <!--grid 的 Height="298px" Width="100%"-->
    <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../js/check.js" ></script>
    
       <script type="text/javascript">
        <!--
         
        //添加权力组
        function user_addroles()
		{
  		        var row=igtbl_getActiveRow("UltraWebGrid1"); 
			    var userid=row.getCellFromKey("userid").getValue();	
			    var username=row.getCellFromKey("username").getValue();
                var url="web_userrolescradd.aspx?userid=" +userid+"&username="+escape(username);
                var oFeedBackLabel = igtbl_getElementById("lbl_userid");
                oFeedBackLabel.innerHTML = "已选用权力组:["+userid+"]"+username;
                
			    LoadWindow(url,600,440);
        }
        
		function user_see(itemName)
		{
  		        var cell  =igtbl_getActiveCell("UltraWebGrid1",0);
  		        if (cell !=null && cell.getValue()=="查看")
  		        {
    		        var row=igtbl_getActiveRow("UltraWebGrid1"); 
			        var userid=row.getCellFromKey("userid").getValue();	
			        var username=row.getCellFromKey("username").getValue();
                    var oFeedBackLabel = igtbl_getElementById("lbl_userid");
                    oFeedBackLabel.innerHTML = "已选用权力组:["+userid+"]"+username;
  		        }
              
 
		}				
        -->
        </script>
</head>
<body style="text-align: left; width: 90%;">
    <form id="from1" runat="server">
        用户列表：<br />
        <igtbl:UltraWebGrid id="UltraWebGrid1" runat="server" Browser="Xml" Height="197px" Width="82%" EnableViewState="False" OnInitializeLayout="UltraWebGrid1_InitializeLayout" OnInitializeRow="UltraWebGrid1_InitializeRow"><Bands>
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
                <Columns>
                    <igtbl:UltraGridColumn BaseColumnName="userid" HeaderText="编号" Key="userid">
                        <Header Caption="编号">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="username" HeaderText="姓名" Key="username">
                        <Header Caption="姓名">
                            <RowLayoutColumnInfo OriginX="1" />
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="usermain" DataType="System.Boolean" HeaderText="系统员"
                        Key="usermain" Type="CheckBox" Width="50px">
                        <Header Caption="系统员">
                            <RowLayoutColumnInfo OriginX="2" />
                        </Header>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn BaseColumnName="notuse" DataType="System.Boolean" HeaderText="禁用"
                        Key="notuse" Type="CheckBox" Width="40px">
                        <Header Caption="禁用">
                            <RowLayoutColumnInfo OriginX="3" />
                        </Header>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3" />
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:TemplatedColumn AllowUpdate="No" HeaderText="添加权力组" HTMLEncodeContent="True"
                        Key="save" Width="70px">
                        <CellTemplate>
                            <a href="#" onclick="javascript:return user_addroles()">添加权力组</a>
                        </CellTemplate>
                        <Header Caption="添加权力组">
                            <RowLayoutColumnInfo OriginX="4" />
                        </Header>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="4" />
                        </Footer>
                    </igtbl:TemplatedColumn>
                    <igtbl:UltraGridColumn AllowUpdate="No" HeaderText="查看权力组" HTMLEncodeContent="True"
                        Key="seeroles" Width="70px">
                        <Header Caption="查看权力组">
                            <RowLayoutColumnInfo OriginX="5" />
                        </Header>
                        <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="5" />
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
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                </FooterStyleDefault>
                <RowStyleDefault TextOverflow="Ellipsis" BorderWidth="1px" BorderColor="Gray" BorderStyle="Solid">
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
                <HeaderStyleDefault BorderStyle="Solid" HorizontalAlign="Center" BackColor="Info">
                    <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
                </HeaderStyleDefault>
                <RowAlternateStyleDefault TextOverflow="Ellipsis" BackColor="#FFFFC0">
                </RowAlternateStyleDefault>
                <EditCellStyleDefault BorderWidth="0px" Font-Size="8pt" Font-Names="Verdana" BorderStyle="None">
                </EditCellStyleDefault>
                <FrameStyle Width="82%" BorderWidth="1px" Font-Size="8pt" Font-Names="Verdana" BorderStyle="Inset" BackColor="White" Height="197px" BorderColor="Blue">
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
                <ClientSideEvents CellClickHandler="user_see" />
            </DisplayLayout>
        </igtbl:UltraWebGrid><br />
        <asp:Label ID="lbl_userid" runat="server" Text="已选用权力组:"></asp:Label><br />
        <iframe id="Iframe1" frameborder="0" name="userroles" style="width: 99%; height: 86%"></iframe>
        &nbsp;&nbsp;
        <br />
        <asp:ObjectDataSource ID="ds_user" runat="server">
        </asp:ObjectDataSource>
    </form>
</body>
</html>
