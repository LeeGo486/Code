<%@ control language="C#" autoeventwireup="true" inherits="Usercontrol_Web_styxtab, App_Web_web_styxtab.ascx.3f410aa0" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@   OutputCache   Duration="1"   VaryByParam="pricelist"   %>
    <script language="javascript" type="text/javascript" src="<%= Request.ApplicationPath %>/js/select.js" ></script>
    
    <script language="JavaScript" type="text/javascript">
    
    function begin_set()
    {
       var parent_window = parent.dialogArguments;
       if (parent_window==undefined)
       {
         var url=getroot()+"/nopower.aspx"; 
         //window.location=url; 
       }
    }
    
    function funexit()
    {
       if(confirm("真的要放弃保存数据退出吗? "))
       {
          window.returnValue="";
          close(); 
         
       }

    
    }
    
    </script>
    

<script id="Infragistics" type="text/javascript">
<!--
function txt_rate_ValueChange(oEdit, oldValue, oEvent)
{
   var oSprice=document.getElementById("igtxtctl03_txt_sprice");
   var oXprice=document.getElementById("ctl03_txt_xprice");
   var oRate=document.getElementById("ctl03_txt_rate");
   if (oSprice==null)
   {
      alert("客户端js出现错误，没有找到单价ID");  
   }
   else
   {
     oSprice.value=oXprice.value*oRate.value;
   }
}
function txt_sprice_ValueChange(oEdit, oldValue, oEvent)
{
   var oSprice=document.getElementById("ctl03_txt_sprice");
   var oXprice=document.getElementById("ctl03_txt_xprice");
   var oRate=document.getElementById("igtxtctl03_txt_rate");
   if (oSprice==null)
   {
      alert("客户端js出现错误，没有找到单价ID");  
   }
   else
   {
     if (oXprice.value!=0)
     {
       oRate.value=oSprice.value/oXprice.value;
     }
     
   }
}// -->
</script>
    
<body onload="javascript:begin_set();">
<div>
    <table style="width: 691px; border-right: gainsboro 1px solid; border-top: gainsboro 1px solid; border-left: gainsboro 1px solid; border-bottom: gainsboro 1px solid;">
        <caption style="border-right: gainsboro 1px solid; border-top: gainsboro 1px solid; border-left: gainsboro 1px solid; border-bottom: gainsboro 1px solid">
            录入款式数量</caption>
        <tr>
            <td style="width: 100px; text-align: right;">
                款式折扣：</td>
            <td style="width: 100px">
                <igtxt:webcurrencyedit id="txt_rate" runat="server" width="205px" DataMode="Float" MaxValue="1" MinValue="0">
                    <ClientSideEvents ValueChange="txt_rate_ValueChange" />
                </igtxt:webcurrencyedit>
            </td>
            <td style="width: 100px; text-align: right;">
                款式编号：</td>
            <td style="width: 100px">
                <asp:TextBox id="txt_styleid" runat="server" width="251px" Enabled="False"></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; text-align: right;">
                款式结算价：</td>
            <td style="width: 100px">
                <igtxt:webcurrencyedit id="txt_sprice" runat="server" width="205px" DataMode="Float" MinValue="0" >
                    <ClientSideEvents ValueChange="txt_sprice_ValueChange" />
                </igtxt:webcurrencyedit>
            </td>
            <td style="width: 100px; text-align: right;">
                &nbsp;款式名称：</td>
            <td style="width: 100px">
                <asp:TextBox ID="txt_styname" runat="server" Width="251px" Enabled="False" ></asp:TextBox></td>
        </tr>
        <tr>
            <td style="width: 100px; text-align: right;">
                款式备注：</td>
            <td style="width: 100px">
                <asp:TextBox ID="txt_comment" runat="server" Width="205px" ></asp:TextBox></td>
            <td style="width: 100px; text-align: right;">
                &nbsp;款式单价：</td>
            <td style="width: 100px">
                <igtxt:webcurrencyedit id="txt_xprice" runat="server" width="251px" Enabled="False" DataMode="Float" MinValue="0"></igtxt:webcurrencyedit>
            </td>
        </tr>
    </table>
</div>
<igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server" Browser="Xml" Height="292px"
    Width="693px">
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
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout AllowAddNewDefault="Yes" AllowColSizingDefault="Free"
        AllowSortingDefault="OnClient" AllowUpdateDefault="Yes" ColWidthDefault="" HeaderClickActionDefault="SortSingle"
        Name="ctl00xUltraWebGrid1" NoDataMessage="没有数据" RowHeightDefault="18px" RowsRange="-1" Version="3.00">
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
            Font-Names="宋体" Font-Size="9pt" Height="292px" Width="693px">
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
    <table style="width: 692px">
        <tr>
            <td style="width: 100px">
                <input id="txt_id" runat="server"  type="hidden" style="width: 238px" /></td>
            <td style="width: 100px">
                <asp:Button ID="btsave" runat="server" Text="保存" Width="65px" style=";border:solid 1px #6699ff; background-color:InfoBackground; color:InfoText;" OnClick="btsave_Click" UseSubmitBehavior="False"/></td>
            <td style="width: 100px">
                <input id="btexit" type="button" value="取消" style="border:solid 1px #6699ff;background-color:InfoBackground;color:InfoText; width: 63px;" onclick="funexit()"/></td>
            <td style="width: 100px">
                <input id="txt_jprice" runat="server" type="hidden" /></td>
        </tr>
    </table>
</body>