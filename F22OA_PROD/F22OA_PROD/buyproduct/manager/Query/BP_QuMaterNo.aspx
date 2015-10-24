<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Query_BP_QuMaterNo, App_Web_bp_qumaterno.aspx.40adaeda" %>
 <%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>物料分配审核</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
    <script language="javascript" type="text/javascript" src="../../../js/check.js"></script>
         <script type="text/javascript">
        var GB_ROOT_DIR = "../../../greybox/";
    </script>

    <script type="text/javascript" src="../../../greybox/AJS.js"></script>
    <script type="text/javascript" src="../../../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../../../greybox/gb_scripts.js"></script>
   <link href="../../../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
   	<script type="text/javascript">
GB_myShow = function(caption, url, /* optional */ height, width, callback_fn) {
    var options = {
        caption: caption,
        height: height || 550,
        width: width || 700,
        fullscreen: false,
        show_loading: false,
        callback_fn: callback_fn
    }
    var win = new GB_Window(options);
    return win.show(url);
}

</script>
        
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <!--head-->
    <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    	<!--head end-->
            <table   width="98%" class="tbsh">
        <colgroup>
        <col  width="100px"/>
        <col width="120px"/>
        <col width="50px"/>
        <col width="120px"/>
         <col />
        <col  align="right"/>
        </colgroup>
        <tr>
            <td colspan="5">
                名 称:<asp:TextBox ID="TxtSupplyNo" runat="server" CssClass="tbox" Width="100px"></asp:TextBox>&nbsp;
                &nbsp;<asp:RadioButton ID="RBtnCode" runat="server" Text="物料编号" GroupName="aa" Checked="true" />
            <asp:RadioButton ID="RBtnName" runat="server" Text="物料名称" GroupName="aa" /></td>
      
        
        <td> <asp:Button ID="BtnSearch" Width="100" runat="server" Text="查   询" CssClass="btn" OnClick="BtnSearch_Click" /></td>
      
        </tr>
        <tr>
            <td colspan="5">
                &nbsp;&nbsp;<asp:HiddenField ID="HFUserID" runat="server" />
            </td>
        <td></td>
        </tr>
      </table>  

    <div  class="BContent">
     <!----contant------------------>
    <table width="100%">
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="left">
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupmaterID"    CssClass="tbGrid"
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%" CellSpacing="1" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                    <asp:BoundField DataField="PublishID" HeaderText="PublishID" ReadOnly="True" SortExpression="PublishID" Visible="False" />

                     <asp:TemplateField HeaderText="合同编号" SortExpression="SignCode">
                        <ItemTemplate>
                            <a href="../sign/BP_SignPrint.aspx?hid=<%#Eval("SignCode") %>"  rel="gb_pageset[search_sites3]"  >  <img src="../../../icon/go3.gif" border="0" /><%#Eval("SignCode")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                        <asp:TemplateField HeaderText="物料编号" SortExpression="MaterID">
                        <ItemTemplate>
                            <a href="../sign/BP_SignMaterDetail.aspx?spid=<%#Eval("SupmaterID") %>"  rel="gb_pageset[search_sites]"  >  <img src="../../../icon/go3.gif" border="0" /><%#Eval("MaterID")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="clname" HeaderText="物料名称" SortExpression="clname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                     <asp:BoundField DataField="unit" HeaderText="单位" SortExpression="unit" />
                     <asp:TemplateField HeaderText="供应商编号" SortExpression="SupplyNo">
                        <ItemTemplate>
                            <a href="../basic/BP_BSSupplyerDetail.aspx?LoginID=<%# Eval("PublishID") %>&SupplyNo=" rel="gb_pageset[search_sites2]" title='供应商明细' >  <img src="../../../icon/go3.gif" border="0" /><%# Eval("SupplyNo")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Maternum" HeaderText="供货量" SortExpression="Maternum" />
                   <asp:BoundField DataField="MaterBuyDate" HeaderText="采购日期" SortExpression="MaterBuyDate" DataFormatString="{0:d}" HtmlEncode="False" /> 
                   <asp:BoundField DataField="MaterGetDate" HeaderText="到货日期" SortExpression="MaterGetDate" DataFormatString="{0:d}" HtmlEncode="False" />  
               
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="1" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                    <tr  Class="dgHeader" >
                         <th scope="col">物料编号</th>
                            <th scope="col">物料名称</th>
                            <th scope="col">规格</th>
                            <th scope="col">颜色</th>
                            <th scope="col">采购数量</th>
                             <th scope="col">供应商编号</th>
                              <th scope="col">供应商供应量</th>
                            <th scope="col">采购时间</th>
                            <th scope="col">到货日期</th>
                    </tr>
                         <tr  bgcolor="White">
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader"  HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetQurSignMaterByNo" TypeName="ddl_cgnew" >
           <SelectParameters>

                <asp:Parameter DefaultValue="-" Name="Type" Type="string" />
                <asp:Parameter DefaultValue="-" Name="SupplyNo" Type="string" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </td>
    </tr>
        <tr>
    <td>
    <table width="100%">

        <tr>
    <td valign="top">
        &nbsp;
    
    </td>
   
    </tr>
    </table>
    </td>
    </tr>
    </table>
    <!----contant end------------->
    </div>
    </form>
</body>
</html>

