<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_publish_BP_PublishChkHaveList, App_Web_bp_publishpass.aspx.874e4ad9" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
    <%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>已审采购发布</title>
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

   
 
    <table   width="100%" class="tbsh">
        <colgroup>
        <col  width="100px"/>
        <col width="120px"/>
        <col width="50px"/>
        <col width="120px"/>
        <col  align="right"/>
        </colgroup>
        <tr>
        <td>
            &nbsp;建立时间:</td>
        <td>
           <igsch:webdatechooser id="WebDateChooserDateBegin" runat="server"
                   value="" width="100"> </igsch:webdatechooser>
             </td>
        <td >&nbsp; 到&nbsp;</td>
        <td><igsch:webdatechooser id="WebDateChooserDateEnd" runat="server" value="" width="100">
            </igsch:webdatechooser>
        </td>
      
        
        <td align="right"> <asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查   询" CssClass="btn" OnClick="BtnSearch_Click" />
      <asp:Button ID="BtnDel" Width="100px" runat="server" Text="删除所选" CssClass="btn" OnClick="btnDel_Click" /></td>
      
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
        <td></td>
        </tr>
      </table>
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
                AutoGenerateColumns="False" DataKeyNames="PublishID" DataSourceID="ObjectDataSource1" CssClass="tbGrid" CellSpacing="1"   
                HorizontalAlign="Center"   CellPadding="3" ForeColor="#333333" GridLines="None" Width="100%">
                <Columns>
                  
                    <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="" />
                        </HeaderTemplate>
                        <ItemTemplate ><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PublishID" HeaderText="PublishID" ReadOnly="True" SortExpression="PublishID" Visible="false" />
                     <asp:TemplateField HeaderText="发布编号">
                        <ItemTemplate>
                         <a href="BP_PublishChkDetailHave.aspx?pid=<%# Eval("PublishCode")%>"  ><img src="../../../icon/go3.gif" border="0" /><%# Eval("PublishCode")%></a>
                        </ItemTemplate>
                    </asp:TemplateField>            
                     <asp:BoundField DataField="maternum" HeaderText="物料种数" SortExpression="maternum" />
                    <asp:BoundField DataField="PStartDate" HeaderText="发布日期" SortExpression="PStartDate" DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="PEndDate" HeaderText="结束日期" SortExpression="PEndDate" DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="CrDate" HeaderText="建立日期" SortExpression="CrDate"  DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="CrUser" HeaderText="申请人" SortExpression="CrUser" />
                 <asp:TemplateField HeaderText="状态" SortExpression="ChkState">
                   
                        <ItemTemplate>
                            <asp:Label ID="LabelState" runat="server" Text='<%# Eval("ChkState").ToString()=="1"?"通过":"未通过"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                         <a href="BP_PublishChkDetailHave.aspx?pid=<%# Eval("PublishCode")%>" ><img src="../../../icon/go3.gif" border="0" />查看</a>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                 <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#EFF3FB" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle  CssClass="header"  HorizontalAlign="Center" />
                <HeaderStyle CssClass="dgHeader"   HorizontalAlign="Center" VerticalAlign="Middle" font-size=9pt  />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                     <table id="GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                    <tr  Class="dgHeader" >
                            <th scope="col">发布编号</th>
                            <th scope="col">物料种数</th>
                            <th scope="col">发布日期</th>
                            <th scope="col">结束日期</th>
                            <th scope="col">建立日期</th>
                            <th scope="col">申请人</th>
                         
                        </tr>
                          <tr  bgcolor="White">
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                        
                    </tr>
                      </table>
                </EmptyDataTemplate>
            </asp:GridView>
               <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"  SelectMethod="CG_GetPublishListHavechk" TypeName="ddl_cgnew" OldValuesParameterFormatString="original_{0}" >
            <SelectParameters>
                <asp:ControlParameter ControlID="HFStartDate" Name="DateBegin" PropertyName="Value"
                    Type="DateTime" />
                <asp:ControlParameter ControlID="HFEndDate" Name="DateEnd" PropertyName="Value" Type="DateTime" />
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
