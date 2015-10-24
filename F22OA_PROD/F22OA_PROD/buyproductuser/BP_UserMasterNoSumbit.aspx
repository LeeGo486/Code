<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserWriteNoSumbit, App_Web_bp_usermasternosumbit.aspx.4969a439" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="css/project.css" type="text/css"  rel="stylesheet">
    		       <script type="text/javascript">
        var GB_ROOT_DIR = "greybox/";
    </script>

    <script type="text/javascript" src="greybox/AJS.js"></script>
    <script type="text/javascript" src="greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="greybox/gb_scripts.js"></script>
   <link href="greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />
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
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">未提交报价列表</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    
    <div  class="BContent">
        <asp:HiddenField ID="HFUserNo" runat="server" />
    <table width=100%>
    <tr>
        <td align=left>
            
        </td>
        
        <td align=right>            
           
        </td>
    </tr>
    <tr>
        <td colspan=2>
            <asp:GridView ID="GridViewMater" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="MaterSubid"   CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="98%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                   
                    <asp:BoundField DataField="PublishCode" HeaderText="PublishCode" ReadOnly="True" SortExpression="PublishCode" Visible="false" />
                    <asp:BoundField DataField="MaterID" HeaderText="货物编号" SortExpression="MaterID" Visible="false" />
                    <asp:BoundField DataField="uname" HeaderText="货物名称" SortExpression="uname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                    <asp:BoundField DataField="BuyNum" HeaderText="采购数量" SortExpression="BuyNum" />
                      <asp:BoundField DataField="PStartDate" HeaderText="开始日期" SortExpression="PStartDate" DataFormatString="{0:d}" HtmlEncode="false" />
                      <asp:BoundField DataField="PEndDate" HeaderText="结束日期" SortExpression="PEndDate" DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="BuyDate" HeaderText="采购日期" SortExpression="BuyDate" DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="Matergetdate" HeaderText="到货日期" SortExpression="Matergetdate" DataFormatString="{0:d}" HtmlEncode="false"  />

                  <asp:TemplateField HeaderText="图片">
                        <ItemTemplate>
                           <a href="BP_UserShowPicBig.aspx?pid=<%# Eval("PublishCode")%>&mid=<%# Eval("MaterID")%>"  rel="gb_pageset[search_sites]"  title="<%# Eval("uname")%>的采购样图"> <img  src="BP_UserShowPic.aspx?pid=<%# Eval("PublishCode")%>&mid=<%# Eval("MaterID")%>" width="50" height="50" border="0" /></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <a href="BP_UserWriteNoSureEidter.aspx?MaterSubid=<%#Eval("MaterSubid") %>"  title="<%#Eval("MaterID") %>的供应商管理" >进入提交</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                   
                   
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="0" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                     <tr  Class="dgHeader" >
                         <th scope="col">货物号</th>
                            <th scope="col">货物名称</th>
                            <th scope="col">规格</th>
                            <th scope="col">颜色</th>
                            <th scope="col">采购数量</th>
                            <th scope="col">采购时间</th>
                            <th scope="col">到货时间</th>
                            
                    </tr>
                         <tr  bgcolor="White">
              
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
            <HeaderStyle CssClass="dgHeader"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetPublishMaterByUserNoSumbitList" TypeName="ddl_cgnew"  >
           
            <SelectParameters>
                <asp:ControlParameter ControlID="HFUserNo" DefaultValue="0" Name="SupplyerID" PropertyName="Value"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
        </td>
    </tr>
</table>
    </div>
    </form>
</body>
</html>

