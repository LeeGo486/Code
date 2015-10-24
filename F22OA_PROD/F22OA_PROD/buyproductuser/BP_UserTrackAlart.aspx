﻿<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserTrackAlart, App_Web_bp_usertrackalart.aspx.4969a439" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>物料分配审核</title>
    <link  href="css/project.css"type="text/css"  rel="stylesheet">
  
           <script language="javascript" type="text/javascript">
              
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
           function GoUrlShowAddTrack(pid) 
           {
		      var url="BP_TrackDetail.aspx?SupmaterID="+pid
	          LoadWindow(url,860,653);
	          document.forms[0].submit();
	       }
	      
            </script>
           
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
					<span id="rm_MainPanel_lFunctionName">物料历史跟进列表</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->

    <div  class="BContent">
     <!----contant------------------>
    <table width="100%">
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
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupmaterID"   CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%" OnRowDataBound="GridView1_RowDataBound">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                    <asp:TemplateField HeaderText="合同编号" SortExpression="SignCode">
                        <ItemTemplate>
                            <a href="BP_UserSignDetail.aspx?hid=<%#Eval("SignCode") %>"  rel="gb_pageset[search_sites3]"  >  <img src="icon/go3.gif" border="0" /><%#Eval("SignCode")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                        <asp:TemplateField HeaderText="物料编号" SortExpression="MaterID">
                        <ItemTemplate>
                            <a href="BP_UserSignMaterDeatil.aspx?spid=<%#Eval("SupmaterID") %>"  rel="gb_pageset[search_sites]"  >  <img src="icon/go3.gif" border="0" /><%#Eval("MaterID")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="clname" HeaderText="物料名称" SortExpression="clname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                    <asp:BoundField DataField="Maternum" HeaderText="供应量" SortExpression="Maternum" />
                    <asp:BoundField DataField="unit" HeaderText="单位" SortExpression="unit" />
                   <asp:BoundField DataField="MaterBuyDate" HeaderText="采购日期" SortExpression="MaterBuyDate" DataFormatString="{0:d}" HtmlEncode="False" /> 
                   <asp:BoundField DataField="MaterGetDate" HeaderText="到货日期" SortExpression="MaterGetDate" DataFormatString="{0:d}" HtmlEncode="False" />  
                    <asp:TemplateField HeaderText="查看跟进" SortExpression="SupplyNo">
                        <ItemTemplate>
                            <a href="BP_UserTrackDetailHave.aspx?SupmaterID=<%# Eval("SupmaterID") %>&state=<%# Eval("OverSate") %>" rel="gb_pageset[search_sites2]" title='<%# Eval("clname") %>采购跟进明细' >  <img src="icon/go3.gif" border="0" />查看跟进</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                      
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="0" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                     <tr  Class="dgHeader" >
                         <th scope="col">合同编号</th>
                            <th scope="col">物料编号</th>
                            <th scope="col">物料名称</th>
                            <th scope="col">规格</th>
                            <th scope="col">颜色</th>
                            <th scope="col">供应量</th>
                             <th scope="col">单位</th>
  
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
            <HeaderStyle CssClass="dgHeader" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
           <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetMaterAlartSupplyer" TypeName="ddl_cgnew" >
            <SelectParameters>
                <asp:ControlParameter ControlID="HFSupplyerID" Name="SupplyerID" PropertyName="Value" Type="String" />
               
            </SelectParameters>
           
        </asp:ObjectDataSource><asp:HiddenField ID="HFSupplyerID" runat="server" />
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
