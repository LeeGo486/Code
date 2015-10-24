<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_chkprice_BP_ChkPricelist, App_Web_bp_chkpricelist.aspx.68adc8a" %>

<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>采购发布申请审核</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
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
        <col  align="right"/>
        </colgroup>
        <tr>
        <td>
            &nbsp;报 价 率(%):</td>
        <td>
             <asp:TextBox ID="TxtRateBegin" runat="server" Width="100px" CssClass="tbox"></asp:TextBox>
             </td>
        <td >&nbsp; 到&nbsp;</td>
        <td><asp:TextBox ID="TxtRateEnd" runat="server" Width="100px"  CssClass="tbox"></asp:TextBox>&nbsp;
        </td>
      
        
        <td><asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查 询" CssClass="btn" OnClick="BtnSearch_Click" /></td>
      
        </tr>
        <tr>
        <td></td>
        <td><asp:RegularExpressionValidator ID="REVvs" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtRateBegin"></asp:RegularExpressionValidator></td>
        <td></td>
        <td>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*数字类型" ValidationExpression="(^-?\d\d*\.\d*$)|(^-?\d\d*$)|(^-?\.\d\d*$)" ControlToValidate="TxtRateEnd"></asp:RegularExpressionValidator></td>
        <td></td>
        </tr>
      </table>
    <div  class="BContent">
     <!----contant------------------>
    <table width="100%" >
      <tr>
      <td align="left" >

      </td>
    </tr>
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="left">
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"   PageSize="20"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="MaterSubid"   CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                   
                    <asp:BoundField DataField="PublishCode" HeaderText="PublishCode" ReadOnly="True" SortExpression="PublishCode" Visible="False" />
                     <asp:TemplateField HeaderText="物料编号" SortExpression="MaterID">
                        <ItemTemplate>
                            <a href="BP_MaterDetail.aspx?pid=<%#Eval("PublishCode") %>&mid=<%#Eval("MaterID") %>"  rel="gb_pageset[search_sites]"  >  <img src="../../../icon/go3.gif" border="0" /><%#Eval("MaterID")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="clname" HeaderText="物料名称" SortExpression="clname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                    <asp:BoundField DataField="BuyNum" HeaderText="采购量" SortExpression="BuyNum" />
                    <asp:BoundField DataField="unit" HeaderText="单位" SortExpression="unit" />
                    <asp:BoundField DataField="allgiveNum" HeaderText="已分量" SortExpression="allgiveNum" />
                      <asp:TemplateField HeaderText="新留言">
                        <ItemTemplate>
                            <a href="BP_ChkMsgNewlist.aspx?pid=<%#Eval("PublishCode") %>&mid=<%#Eval("MaterID") %>"   >  <img src="../../../icon/go3.gif" border="0" /><%#Eval("msgnewNum") %></a>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="BuyDate" HeaderText="采购日期" SortExpression="BuyDate" DataFormatString="{0:d}" HtmlEncode="False" />
                     <asp:BoundField DataField="PEndDate" HeaderText="发布结束" SortExpression="PEndDate" DataFormatString="{0:d}" HtmlEncode="False" />
                     <asp:TemplateField HeaderText="供应商数" SortExpression="Supernum">
                        <ItemTemplate>
                            <a href="BP_ChkGiveSupplyList.aspx?pid=<%#Eval("PublishCode") %>&mid=<%#Eval("MaterID") %>&tid=all"  rel="gb_pageset[search_sites2]"  >  <img src="../../../icon/go3.gif" border="0" /><%#Eval("Supernum")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="已报价数" SortExpression="Superhavenum">
                        <ItemTemplate>
                            <a href="BP_ChkGiveSupplyList.aspx?pid=<%#Eval("PublishCode") %>&mid=<%#Eval("MaterID") %>&tid=yes"  rel="gb_pageset[search_sites3]"  >  <img src="../../../icon/go3.gif" border="0" /><%#Eval("Superhavenum")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <a href="BP_ChkGiveMaterList.aspx?pid=<%#Eval("PublishCode") %>&mid=<%#Eval("MaterID") %>"  >  <img src="../../../icon/go3.gif" border="0" />进入分配</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                  
           
                   
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                    <tr  Class="dgHeader" >
                         <th scope="col">物料编号</th>
                         <th scope="col">物料名称</th>
                         <th scope="col">规格</th>
                         <th scope="col">颜色</th>
                         <th scope="col">采购数量</th>
                         <th scope="col">采购时间</th>
                         <th scope="col">到货时间</th>
                         <th scope="col">供应商数</th>
                         <th scope="col">已报价数</th>
                    </tr>
                    <tr  bgcolor="White">
                      <th scope="col"></th>
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
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetChkPriceList" TypeName="ddl_cgnew" OldValuesParameterFormatString="original_{0}" >
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="RateBegin" Type="Single" />
                <asp:Parameter DefaultValue="100" Name="RateEnd" Type="Single" />
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
