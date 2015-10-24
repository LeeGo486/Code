<%@ page language="C#" masterpagefile="~/cashcard/main/sys/SysMaster.master" autoeventwireup="true" inherits="web_aspxeditsub, App_Web_web_aspxeditsub.aspx.9597e00c" title="模块维护" %>
<%@ OutputCache   Duration="10"  VaryByParam="aspxid"   %>
<%@ Register Src="../Usercontrol/Toolsbase.ascx" TagName="Toolsbase" TagPrefix="uc1" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ctplhder" Runat="Server">

    <script id="Infragistics" type="text/javascript">
<!--
var cnt="0";
function save_readyState()
{
   if (request.readyState<4) 
   {
       showmsg("正在处理...");
   }
   else
   if (request.readyState==4) 
   {
      showmsg("操作成功！");
   }
   else
   {
     showmsg("操作失败！");
     alert(request.responseText);
   }
   
}
//删除当前记录
function UltraWebGrid1_BeforeRowDeletedHandler(gridName, rowId)
{
    var row=igtbl_getActiveRow(gridName); 
    if (row==null) 
    {
      alert("请选择一条要删除的记录！然后再进行删除.");
      return 1;
    }
    
    var aspxid=row.getCellFromKey("aspxid").getValue();	
   if (aspxid.substring(0,2).toUpperCase()=="MY")
    {
       var readme=row.getCellFromKey("readme").getValue();	
       var loadid=row.getCellFromKey("loadid").getValue();	
      if(confirm("真的要删除当前记录吗? ->"+aspxid))
      {
       var url="web_aspxeditsubxml.aspx?SaveType=3&aspxid="+aspxid+"&readme="+readme+"&loadid="+loadid;
	   return update_srv(url);
      }
    }
    else
    {
       alert("系统项目，不可以删除！");
       return 1;
    }

    return 1;
}

        
//保存修改
function user_editsave(oRow)
{
    var aspxid=oRow.getCellFromKey("aspxid").getValue();	
    var readme=oRow.getCellFromKey("readme").getValue();	
    var loadid=oRow.getCellFromKey("loadid").getValue();	
     
    var url="web_aspxeditsubxml.aspx?SaveType=2&aspxid="+aspxid+"&readme="+readme+"&loadid="+loadid;

    return update_srv(url);
                  
}

//提交服务器
function update_srv(url)
{
    if (window.XMLHttpRequest)
    {
        request = new XMLHttpRequest();
    }
    else if (window.ActiveXObject)
    {
        request = new ActiveXObject("Microsoft.XMLHTTP");
    }
    if (request)
    {
        if (request.readyState!=0)
        {
          alert("服务器正忙,请稍后提交...");
          return false;
        } 

        showmsg("正在处理...");
        request.onreadystatechange = save_readyState;
        request.open("GET", url,false);
        request.send(null);
        
        var strReturn=request.ResponseText;
        if (strReturn.substring(0,3)=="add" || strReturn.substring(0,3)=="del" || strReturn.substring(0,3)=="upd")
        {
           showmsg("处理成功！.");
           if (strReturn.substring(0,3)=="add")
           {
             cnt=strReturn.substring(3,strReturn.length);
           }

           return 0;
        }
        else
        {
          showmsg("处理失败！");
          alert(strReturn);
          return 1;
        }          
     }
}        

function UltraWebGrid1_BeforeRowUpdateHandler(gridName, rowId)
{
    igtbl_EndEditMode(gridName);
    var row= igtbl_getActiveRow(gridName);
    if (row!=null)
    {
         showmsg("正在处理...");　   
  	     if (user_editsave(row)==0)
  	     {
  	       return 0;
  	     }
    }
}
function showmsg(msg)
{
         var oFeedBackLabel = igtbl_getElementById("ctl00_ctplhder_lblFeedBack");
         if (oFeedBackLabel!=null)
         {
             oFeedBackLabel.innerHTML = msg;
         }
}
// -->
</script>
    <uc1:Toolsbase ID="Toolsbase1" runat="server" />
    <div> 
    <igtbl:UltraWebGrid ID="UltraWebGrid1" runat="server" Browser="Xml" Height="387px" Width="90%">
        <Bands>
            <igtbl:UltraGridBand>
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
                <FilterOptions AllString="" EmptyString="" NonEmptyString="">
                    <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                        CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                        Font-Size="11px" Width="100px">
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
        <DisplayLayout AllowAddNewDefault="Yes" AllowColSizingDefault="Free" AllowDeleteDefault="Yes" ColWidthDefault="" LoadOnDemand="Xml" Name="UltraWebGrid1"
            NoDataMessage="没有数据" RowHeightDefault="12px" RowsRange="-1" SelectTypeRowDefault="Extended"
            Version="3.00">
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
                    Font-Size="11px" Width="100px">
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
                Font-Names="宋体" Font-Size="9pt" Height="387px" >
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
            <ClientSideEvents BeforeRowDeletedHandler="UltraWebGrid1_BeforeRowDeletedHandler"
                BeforeRowUpdateHandler="UltraWebGrid1_BeforeRowUpdateHandler" />
        </DisplayLayout>
    </igtbl:UltraWebGrid>&nbsp;</div>
    <table style=" border-collapse: collapse">
        <tr>
            <td style="width: 100px">
                <asp:Label ID="lblrow" runat="server" Width="106px"></asp:Label></td>
            <td style="width: 100px">
                <asp:Label ID="lblFeedBack" runat="server" ForeColor="Red" Width="100%"></asp:Label></td>
        </tr>
    </table>
</asp:Content>

