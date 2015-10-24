<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Sign_BP_SignHistoryh, App_Web_bp_signhistoryh.aspx.9fbedc62" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
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
           <script language="javascript" type="text/javascript">
           function GoUrlShowAddTrack(pid) 
           {
		      var url="BP_TrackAdd.aspx?SupmaterID="+pid
	          LoadWindow(url,860,653);
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
        <td>
            &nbsp;签定时间:</td>
        <td>
           <igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"
                   value="" width="100"> </igsch:webdatechooser>
             </td>
        <td >&nbsp; 到&nbsp;</td>
        <td><igsch:webdatechooser id="WebDateChooserDateEnd" runat="server" value="" width="100">
            </igsch:webdatechooser>
        </td>
      <td>
          <asp:DropDownList ID="DDLType" runat="server" AutoPostBack="true">
          <asp:ListItem Value="1" Text="已审"></asp:ListItem>
          <asp:ListItem Value="0" Text="未审"></asp:ListItem>
          </asp:DropDownList>
            </td>
        
        <td> <asp:Button ID="BtnSearch" Width="100" runat="server" Text="查   询" CssClass="btn" OnClick="BtnSearch_Click" />
       <asp:Button ID="BtnDel" Width="100px" runat="server" Text="删除所选" CssClass="btn" OnClick="btnDel_Click" />
       </td>
        </tr>
        <tr>
        <td></td>
        <td>
            <asp:HiddenField ID="HFStartDate" runat="server" />
        </td>
        <td></td>
        <td>
            <asp:HiddenField ID="HFEndDate" runat="server" />
        </td>
        <td>
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
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SignCode"    CssClass="tbGrid"
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%" CellSpacing="1" OnRowDataBound="GridView1_RowDataBound" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
             <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="" />
                        </HeaderTemplate>
                        <ItemTemplate ><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                       <asp:TemplateField HeaderText="合同编号" SortExpression="SignCode">
                        <ItemTemplate>
                            <a href="BP_SignDetail.aspx?hid=<%# Eval("SignCode") %>"  rel="gb_pageset[search_sites3]" >  <img src="../../../icon/go3.gif" border="0" /><%# Eval("SignCode")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                      <asp:TemplateField HeaderText="供应商编号" SortExpression="SupplyNo">
                        <ItemTemplate>
                            <a href="../basic/BP_BSSupplyerDetail.aspx?LoginID=<%# Eval("SupplyerID") %>&SupplyNo=" rel="gb_pageset[search_sites2]" title='供应商明细' >  <img src="../../../icon/go3.gif" border="0" /><%# Eval("SupplyNo")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                  
                    <asp:BoundField DataField="MaterNum" HeaderText="物料种量" SortExpression="MaterNum" />
                    <asp:BoundField DataField="CrUser" HeaderText="建立人" SortExpression="CrUser" />
                   <asp:BoundField DataField="CrDate" HeaderText="建立日期" SortExpression="CrDate" DataFormatString="{0:d}" HtmlEncode="False" /> 
                   <asp:BoundField DataField="SignDate" HeaderText="签定日期" SortExpression="SignDate" DataFormatString="{0:d}" HtmlEncode="False" />  
                     <asp:BoundField DataField="ChkState" HeaderText="ChkState" SortExpression="ChkState"  HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" FooterStyle-CssClass="hidden"/>
                     <asp:TemplateField HeaderText="状态" SortExpression="ChkState" >
                        <ItemTemplate>
                            <asp:Label ID="LabelState" runat="server" Text='<%# Eval("ChkState").ToString()=="0"?"未审":"通过"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                   
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="1" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                    <tr  Class="dgHeader" >
                         <th scope="col">合同编号</th>
                         <th scope="col">供应商编号</th>
                         <th scope="col">物料种量</th>
                         <th scope="col">建立人</th>
                         <th scope="col">建立日期</th>
                         <th scope="col">签定日期</th>
                         <th scope="col">状态</th>
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
            <HeaderStyle CssClass="dgHeader"  HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
           <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetSignUnchkList" TypeName="ddl_cgnew"   >
            <SelectParameters>
                <asp:ControlParameter ControlID="HFStartDate" Name="DateBegin" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="HFEndDate" Name="DateEnd" PropertyName="Value" Type="DateTime" />
                
                <asp:Parameter DefaultValue="1" Name="Type" Type="Int32" />
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
        <asp:HiddenField ID="HFState" runat="server" />
        <asp:HiddenField ID="HFCrUser" runat="server" />
    
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


