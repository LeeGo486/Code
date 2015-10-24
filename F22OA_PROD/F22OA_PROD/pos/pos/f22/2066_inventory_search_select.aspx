<%@ page language="C#" autoeventwireup="true" inherits="pos_pos_f22_2066_inventory_search_select, App_Web_2066_inventory_search_select.aspx.57d9cd0c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <link href="css/WebGrid.css" rel="stylesheet" type="text/css" />
    <link href="css/f22.css" rel="stylesheet" type="text/css" />
    <base target="_self" />

    <script type="text/javascript" language="JavaScript">   
        //GridView选择一条或多条记录进行操作前的确认
        function GVSelectOneOrMoreConfirm(){
            var selectCount = 0;
          //  var selectMan =0;
            var id="";
            for(i=0; i<document.forms[0].elements.length;i++)
            {
                if(document.forms[0].elements[i].type=="checkbox" && document.forms[0].elements[i].name.indexOf("GridViewID")>-1 && document.forms[0].elements[i].checked) 
                {
                    if (id=="")
                        id = document.forms[0].elements[i].name;
                    else
                    {
//                        if (id!=document.forms[0].elements[i].name)
//                        {
//                           selectMan++;
//                        }
                    }
                    selectCount++;
                }
            }
//            if (selectMan>0)
//            {
//               alert("只能选择一个表数据进行删除！");
//               return false;
//            }
            if(selectCount<1){
                alert("请至少勾选一条数据，然后再点击按钮进行操作！");
                return false;
            }else{
                return confirm("删除后数据将不能恢复，确定要删除数据吗？");
            }
            return false;
        }    
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div class="queryList">
        <asp:GridView ID="GridView1" runat="server" Height="100%" Width="100%" AutoGenerateColumns="false"
            DataKeyNames="inventoryid" CssClass="gridviewStyle">
            <Columns>
                <asp:TemplateField HeaderText="选择" ItemStyle-Width="5%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false">
                    <ItemTemplate>
                        <asp:CheckBox ID="GridViewID" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="inventoryid" HeaderText="流水号 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="d_type" HeaderText="盘点类型 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="depotid" HeaderText="店铺编号 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="dptname" HeaderText="店铺名称 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="nums" HeaderText="盘点数量 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="Sums" HeaderText="盘点金额 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="cynums" HeaderText="差异数量 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="cysums" HeaderText="差异金额 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="setdate" HeaderText="盘点日期 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="cr_date" HeaderText="制单日期 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
                <asp:BoundField DataField="cr_name" HeaderText="制单人 " ItemStyle-Width="10%" HeaderStyle-Wrap="false"
                    ItemStyle-Wrap="false"></asp:BoundField>
            </Columns>
            <RowStyle CssClass="gridview_rowStyle" />
            <AlternatingRowStyle CssClass="gridview_alternatingRowStyle" />
            <EmptyDataTemplate>
                <table class="itemtable" cellspacing="1" cellpadding="2" border="0">
                    <tbody>
                        <tr class="toplinebg">
                            <td width="5%" height="20">
                                <nobr>选择</nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_inventoryid">
                                <nobr>流水号 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_d_type">
                                <nobr>盘点类型 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_depotid">
                                <nobr>店铺编号 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_dptname">
                                <nobr>店铺名称 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_nums">
                                <nobr>盘点数量 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_sums">
                                <nobr>盘点金额 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_cynums">
                                <nobr>差异数量 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_cysums">
                                <nobr>差异金额 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_setdate">
                                <nobr>盘点日期 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_cr_date">
                                <nobr>制单日期 </nobr>
                            </td>
                            <td width="10%" height="20" id="WebGridLas1_cr_name">
                                <nobr>制单人 </nobr>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>
    <br />
    <div>
        <table>
            <tr align="center">
                <td align="center">
                    <input title="批量删除" value="批量删除" id="btndel" type="button" runat="server" onserverclick="delinvertory"
                      onclick="if (!GVSelectOneOrMoreConfirm()) return; "   />
                    <input title="返回" value="返回" id="btnclose" type="button"  
                      onclick="window.close();"   />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
