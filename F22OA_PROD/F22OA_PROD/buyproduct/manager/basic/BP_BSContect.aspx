<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSContect, App_Web_bp_bscontect.aspx.11713791" %>
<%@ Register Src="../../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>公司联系方式</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="新增联系" CssClass="btn"   OnClientClick="window.location.href='BP_BSContectadd.aspx?ContactID='; return false;"   />
      <asp:Button ID="BtnDel" Width="100px" runat="server" Text="删除所选" CssClass="btn" OnClick="btnDel_Click" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
    
        
    <div  class="BContent">
    <table width="100%">
    <tr>
        <td align="left">
        </td>
        <td align="right"> </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="ContactID" DataSourceID="ObjectDataSource1" Width="100%" Height="100%" 
                 HorizontalAlign="Center"    CellPadding="3"  ForeColor="#333333"  GridLines="None"  CssClass="tbGrid" CellSpacing="1" >
                <Columns>
                    <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ContactID" HeaderText="ContactID"
                        ReadOnly="True" SortExpression="ContactID"  ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" FooterStyle-CssClass="hidde"/>
                    <asp:BoundField DataField="ContactUser" HeaderText="联系人" SortExpression="ContactUser" />
                      <asp:BoundField DataField="Tel" HeaderText="联系电话" SortExpression="Tel" />
                    <asp:BoundField DataField="Fax" HeaderText="传真" SortExpression="Fax"  />
                    <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"  />

                     <asp:TemplateField HeaderText="公司名称" SortExpression="Address">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CompanyName") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <a href="#" title='<%# Eval("CompanyName") %>'><%# ZH.Public.ZHFuntion.GetLength(Eval("CompanyName").ToString(),5).ToString()%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="地址" SortExpression="Address">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Address") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>

                            <a href="#" title='<%# Eval("Address") %>'><%# ZH.Public.ZHFuntion.GetLength(Eval("Address").ToString(), 10).ToString()%></a>
                        </ItemTemplate>
                    </asp:TemplateField>
                       <asp:TemplateField HeaderText="默认选" SortExpression="ContactIndex">
                        <ItemTemplate>
                           <label id="lblstore" runat="server"  ><%# Eval("ContactIndex").ToString()=="True"?"是":"否" %></label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <img src="../../../icon/go3.gif" border="0" /><asp:HyperLink  runat="server" Text="查看" NavigateUrl='<%# "BP_BSContectadd.aspx?ContactID=" + DataBinder.Eval(Container, "DataItem.ContactID")  %>' ID="Hyperlink2">
                        </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
                <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#EFF3FB" />
                <FooterStyle  CssClass="header" />
                <EditRowStyle BackColor="#2461BF" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle  CssClass="header" HorizontalAlign="Center" />
                <HeaderStyle CssClass="dgHeader"  HorizontalAlign="Center" VerticalAlign="Middle"  />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                     <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
                        <tr   class="header" >
                            <th scope="col">联系人</th>
                            <th scope="col">联系电话</th>
                            <th scope="col">传真</th>
                            <th scope="col">Email</th>
                            <th scope="col">公司名称</th>
                            <th scope="col">地址</th>
                            <th scope="col">顺序</th>

                        </tr>
                      <tr  bgcolor="White">
                      <th scope="col"></th>
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
            
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="ddl_cgnew" SelectMethod="CG_GetCompanyContect">

            </asp:ObjectDataSource>
            
        </td>
    </tr>
</table>
    </div>
    </form>
</body>
</html>
