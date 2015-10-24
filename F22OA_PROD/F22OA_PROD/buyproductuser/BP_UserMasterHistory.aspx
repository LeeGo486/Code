<%@ page language="C#" autoeventwireup="true" inherits="buyproductuser_BP_UserMasterHistory, App_Web_bp_usermasterhistory.aspx.4969a439" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
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
					<span id="rm_MainPanel_lFunctionName">历史报价列表</span>&nbsp;&nbsp;&nbsp;
					
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
      <td colspan="2">
      <table  align="left">
      <tr>
           <td align="left" style="height: 25px" colspan="2">
               &nbsp;采购时间: &nbsp;
               </td>
               <td>
               <igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"
                   value="" width="100"> </igsch:webdatechooser>
                   </td>
                   <td>
               &nbsp;&nbsp; 到 &nbsp;</td>
               <td>
               <igsch:webdatechooser id="WebDateChooserDateEnd" runat="server" value="" width="100">
            </igsch:webdatechooser>
           
           </td>
           <td>
               &nbsp;所属类型：
               <asp:DropDownList ID="ddlType" runat="server" Width="100px">
               <asp:ListItem Text="全部" Value="all"></asp:ListItem>
               <asp:ListItem Text="审批之中" Value="chking"></asp:ListItem>
               <asp:ListItem Text="审批成功" Value="pass"></asp:ListItem>
               <asp:ListItem Text="审批未成功" Value="nopass"></asp:ListItem>
               </asp:DropDownList></td>
           <td> &nbsp;<asp:Button ID="BtnSearch" Width="100" runat="server" Text="查   询"  CssClass="btn"  OnClick="BtnSearch_Click" /></td>
        </tr>
     
      </table>
      </td>
    </tr>
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
                           <a href="BP_UserShowPicBig.aspx?pid=<%# Eval("PublishCode")%>&mid=<%# Eval("MaterID")%>"  rel="gb_pageset[search_sites2]"  title="<%# Eval("uname")%>的采购样图"> <img  src="BP_UserShowPic.aspx?pid=<%# Eval("PublishCode")%>&mid=<%# Eval("MaterID")%>" width="50" height="50" border="0" /></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="查看">
                        <ItemTemplate>
                            <a href="BP_UserMasterMoneyDetail.aspx?MaterSubid=<%#Eval("MaterSubid") %>" rel="gb_pageset[search_sites]"  title="<%#Eval("MaterID") %>的供应商管理" >查看</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="合同编号">
                        <ItemTemplate>
                            <a href="BP_UserSignDetail.aspx?hid=<%#Eval("SignCode") %>" rel="gb_pageset[search_sites3]"  title="<%#Eval("MaterID") %>的供应商管理" ><%# Eval("SignCode")%></a>
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
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetPublishMaterByUserHistory" TypeName="ddl_cgnew" OldValuesParameterFormatString="original_{0}"  >
           
            <SelectParameters>
                <asp:Parameter DefaultValue="1989-01-01" Name="BeginDate" Type="DateTime" />
                <asp:Parameter DefaultValue="1989-01-01" Name="EndDate" Type="DateTime" />
                <asp:Parameter DefaultValue="default" Name="Type" Type="String" />
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
