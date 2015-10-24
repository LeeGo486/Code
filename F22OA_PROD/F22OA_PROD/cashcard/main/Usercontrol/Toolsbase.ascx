<%@ control language="C#" autoeventwireup="true" inherits="UToolsbase, App_Web_toolsbase.ascx.3f410aa0" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebToolbar.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebToolbar" TagPrefix="igtbar" %>
    <script type="text/javascript">
     <!--

function getgridCnt(gridName) 
 {
        var oGrid = octl00xctplhderxUltraWebGrid1;
        var oBands = oGrid.Bands;
        var oBand = oBands[0];
        var oColumns = oBand.Columns;
        var count = oColumns.length;
        var oRows = oGrid.Rows;
        var total = oRows.length;
        for(i=0; i<oRows.length; i++) {
            oRow = oRows.getRow(i);
            var childRows = oRow.getChildRows();
            if (childRows != null)
            {    
                total += childRows.length;
            }
        }
        return total;
}
function MyGrid_AfterRowActivateHandler(gridName, rowId)
{
	var cnt=getgridCnt(gridName);
	var row=igtbl_getActiveRow(gridName); 
    var cnt1=row.getIndex();
    var lblrow=igtbl_getElementById("ctl00_ctplhder_lblrow");
    if(lblrow == null) return;
       lblrow.innerHTML=cnt1+1+"/"+cnt;
}
//tooles
function OnClick (oToolBar, oItem, oEvent) 
{
    switch(oItem.getText())
    {
        case "添加":
         {
                  var row=igtbl_addNew("ctl00xctplhderxUltraWebGrid1",0);
                  var cell = row.getCell(0);
                  cell.focus();
                  break;
          }
          case "删除":
          {
               igtbl_deleteSelRows("ctl00xctplhderxUltraWebGrid1");
               break;
          }
          case "编辑":
          {
              igtbl_EnterEditMode("ctl00xctplhderxUltraWebGrid1")
              break;
          }      
          case "保存":
          {
              igtbl_EndEditMode("ctl00xctplhderxUltraWebGrid1")
              break;
          
          }
      }
}

//文本框回车触发的事件
function EditKeyDown(tableName, itemName, keyStroke) 
{
    /*
    if (keyStroke==13)
       //{
       // }
        /*
        var column = igtbl_getColumnById(itemName);
        if(column.Key == "comment") {
            if(keyStroke < 48 || keyStroke > 57) 
            {
                if(keyStroke <96 || keyStroke > 105)//needed for numeric keypad
                {
                  if(keyStroke != 13 && keyStroke != 27 && keyStroke != 46 && keyStroke != 8)
                    //alert("Only Numeric Values can be entered in this column.");
                }
            }
        }
        */
        return 0;
    }
						
    -->
 </script>

<igtbar:UltraWebToolbar ID="tb"  runat="server" Width="100%" Height="22px" BackColor="White" BorderStyle="None" ForeColor="Black" ImageDirectory="" ItemSpacing="0" ItemWidthDefault="50px" Font-Names="宋体" Font-Size="9pt" TextAlign="Center">
    <Items>
        <igtbar:TBSeparator Key="spgrdname" />
        <igtbar:TBarButton AutoPostBack="False" Key="add" Text="添加" ImageAlign="Middle">
        </igtbar:TBarButton>
        <igtbar:TBSeparator />
        <igtbar:TBarButton Key="save" Text="保存" AutoPostBack="False">
        </igtbar:TBarButton>
        <igtbar:TBSeparator />
        <igtbar:TBarButton Key="del" Text="删除" AutoPostBack="False">
        </igtbar:TBarButton>
        <igtbar:TBSeparator />
        <igtbar:TBarButton Key="edit" Text="编辑" AutoPostBack="False">
        </igtbar:TBarButton>
        <igtbar:TBSeparator />
        <igtbar:TBarButton Key="print" Text="打印" AutoPostBack="False">
        </igtbar:TBarButton>
        <igtbar:TBSeparator />
        <igtbar:TBarButton Key="query" Text="刷新" AutoPostBack="False">
        </igtbar:TBarButton>
        <igtbar:TBSeparator />
        <igtbar:TBarButton Key="close" Text="关闭" AutoPostBack="False" ToggleButton="True">
        </igtbar:TBarButton>
    </Items>
    <ClientSideEvents Click="OnClick" />
    <HoverStyle BackColor="#FFE0A8" BorderColor="#4B4B6F" BorderStyle="Solid"
        BorderWidth="1px" Cursor="Default" Font-Bold="False" Font-Names="宋体" Font-Size="9pt"
        ForeColor="Black">
    </HoverStyle>
    <DefaultStyle BorderStyle="None"
        BorderWidth="0px" Font-Bold="False" Font-Names="Arial" Font-Size="8pt" ForeColor="Black">
    </DefaultStyle>
    <SelectedStyle BackColor="#FFB860" BorderColor="#4B4B6F" BorderStyle="Solid"
        BorderWidth="1px" Cursor="Default" Font-Bold="False" Font-Names="宋体" Font-Size="9pt"
        ForeColor="Black">
    </SelectedStyle>
</igtbar:UltraWebToolbar>
