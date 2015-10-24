<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSSupplyerChk, App_Web_bp_bssupplyerchk.aspx.11713791" %>
 <%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">



<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>审核供应商</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
     <script language="javascript" type="text/javascript" src="../../../js/select.js"></script>
    <script language="javascript" type="text/javascript" src="../../../js/check.js"></script>
   <script type="text/javascript">
        var GB_ROOT_DIR = "../../../greybox/";
    </script>

    <script type="text/javascript" src="../../../greybox/AJS.js"></script>
    <script type="text/javascript" src="../../..//greybox/AJS_fx.js"></script>
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
<script type="text/javascript">
  function GoUrlShowChkSupter(pid,mid) 
        { 
        
        		
		             var url="BP_BSSupplyerChkDetail.aspx?SupplyID="+pid+"&LoginID="+mid
	                  LoadWindow(url,860,653);
	            
	        
       }
 </script>      
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
       <!--head-->
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
    <!--head end-->
     <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >
      <asp:Button ID="BtnDel" Width="100px" runat="server" Text="删除所选" CssClass="btn" OnClick="btnDel_Click" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

        
    <div  class="BContent">
    <!--contact---->
    <table width="100%">
   
    <tr>
        <td colspan="2">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="SupplyID" Width=100% Height=100% 
                 HorizontalAlign="Center"    CellPadding="3"  CssClass="tbGrid" CellSpacing="1"  ForeColor="#333333"  GridLines="None" PageSize="15">
                <Columns>
                 
                    <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>

                   <asp:TemplateField HeaderText="供应商账号" SortExpression="LoginID">
                     
                        <ItemTemplate>
                            <a href="BP_BSSupplyerDetail.aspx?LoginID=<%# Eval("LoginID") %>&SupplyNo=" rel="gb_pageset[search_sites]" title='供应商明细' ><img src="../../../icon/go3.gif" border="0" /><%# Eval("LoginID")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:BoundField DataField="Type" HeaderText="类型" SortExpression="Type" />
                    <asp:TemplateField HeaderText="公司名称" SortExpression="CompayName">
                    
                        <ItemTemplate>
                            <a href="#" title='<%# Eval("CompayName")%>' ><%# ZH.Public.ZHFuntion.GetLength(Eval("CompayName").ToString(),10).ToString()%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ContaUser" HeaderText="联系人" SortExpression="ContaUser" />
  
                        <asp:TemplateField HeaderText="状态" SortExpression="State">
                   
                        <ItemTemplate>
                            <asp:Label ID="LabelState" runat="server" Text='<%# Eval("State").ToString()=="0"?"未审":"未通过"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                
                     <asp:TemplateField HeaderText="操作" SortExpression="State">
                        <ItemTemplate>
                          <img src="../../../icon/go3.gif" border="0" /> <asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="false" 
                                  OnClientClick='<%# ChkSupter(Eval("SupplyID").ToString(),Eval("LoginID").ToString()) %>'
                        CommandName="Check" Text='进入审核' >
                         </asp:LinkButton>
                           
                        </ItemTemplate>
                    </asp:TemplateField>

         
                    
                </Columns>
                <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#EFF3FB" />
                <FooterStyle CssClass="header"  />
                <EditRowStyle BackColor="#2461BF" />
                <PagerStyle CssClass="header"  HorizontalAlign="Center" />
                <HeaderStyle CssClass="dgHeader"  HorizontalAlign="Center" VerticalAlign="Middle"  />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                     <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
                         <tr  Class="dgHeader" >
                            <th scope="col">供应商类型</th>
                            <th scope="col">供应商编号</th>
                            <th scope="col">公司名称</th>
                            <th scope="col">联系人</th>
                            <th scope="col">状态</th>
                        </tr>
                         <tr  bgcolor="White">
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>                         
                    </tr>
                      </table>
                </EmptyDataTemplate>
            </asp:GridView>
            
            <asp:ObjectDataSource ID="ObjectDataSource1" runat=server TypeName="ddl_cgnew" SelectMethod="CG_SupplyerUnchklist">
            </asp:ObjectDataSource>
            
        </td>
    </tr>
</table>
    <!---contact end-->
    </div>
    </form>
</body>
</html>
