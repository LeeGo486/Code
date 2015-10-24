<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_filetypemgr, App_Web_filetypemgr.aspx.9ee944ed" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>无标题页</title>
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
    <link href="../inquire/scripts/project.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server" method="post">
    <div>

    <div style="text-align:center;line-height:30px; color:Red;"> 
         <asp:ScriptManager ID="ScriptManager1" runat="server">
         </asp:ScriptManager>
         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
             <ContentTemplate>
                 <asp:Label ID="Label1" runat="server" Width="100%"></asp:Label>
                 <asp:DataList ID="DataList1" runat="server" CellPadding="4" CssClass="datalist" 
                     ForeColor="#333333" HorizontalAlign="Center" OnCancelCommand="cancel" 
                     OnDeleteCommand="delete" OnEditCommand="edit" OnUpdateCommand="update" 
                     Width="90%">
                     <HeaderTemplate>
                         <div style="width:5%;">编号</div>
                         <div style="width:20%;">类型名称</div>
                         <div style="width:30%;">格式范围</div>
                         <div style="width:5%;">排序</div>
                         <div style="width:5%;">可用</div>
                         <div style="width:10%;">最后更新</div>
                         <div style="width:15%;">更新日期</div>
                         <div style="width:10%;">操作 </div>
                     </HeaderTemplate>
                     <ItemTemplate>
                         <div style="width:5%;"><%# Eval("typeid") %></div>
                         <div style="width:20%;"><%# Eval("tname")%></div>
                         <div style="width:30%;"><span title='<%# Eval("tformat")%>'><%# Eval("tformat")%></span></div>
                         <div style="width:5%;"><%# Eval("torder")%></div>
                         <div style="width:5%;"><asp:CheckBox ID="CheckBox1" runat="server" 
                                 Checked='<%# DataBinder.Eval(Container, "DataItem.disabled").ToString()=="1"?false:true %>' 
                                 Enabled="false" /></div>
                         <div style="width:10%;">
                             <%# Eval("crname")%></div>
                         <div style="width:15%;">
                             <%# Eval("crdate")%></div>
                         <div style="width:10%;">
                             <asp:LinkButton ID="LinkButton3" runat="server" CommandName="edit">编辑</asp:LinkButton>
                             <asp:LinkButton ID="LinkButton4" runat="server" CommandName="delete" 
                             Enabled='<%# s2b(Int16.Parse(Eval("typenum").ToString()),0)%>' ToolTip="如果该类型被使用，将不能被删除!">删除</asp:LinkButton>
                         </div>
                     </ItemTemplate>
                     <EditItemTemplate>
                         <div style="width:5%;">
                             <%# Eval("typeid") %></div>
                         <div style="width:20%;">
                             <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("tname") %>' Width="90%"></asp:TextBox>
                         </div>
                         <div style="width:30%;">
                            <asp:TextBox ID="TextBox6" runat="server" Text='<%# Eval("tformat")%>' Width="90%"></asp:TextBox>
                         </div>
                         <div style="width:5%;">
                             <asp:TextBox ID="TextBox2" runat="server" MaxLength="4" 
                                 Text='<%# Eval("torder") %>' Width="90%"></asp:TextBox>
                         </div>
                         <div style="width:5%;">
                             <asp:CheckBox ID="CheckBox1" runat="server" 
                                 Checked='<%# DataBinder.Eval(Container, "DataItem.disabled").ToString()=="1"?false:true %>' />
                         </div>
                         <div style="width:10%;">
                             <%# Eval("crname")%></div>
                         <div style="width:15%;">
                             <%# Eval("crdate")%></div>
                         <div style="width:10%;">
                             <asp:LinkButton ID="LinkButton1" runat="server" CommandName="update">更新</asp:LinkButton>
                             <asp:LinkButton ID="LinkButton2" runat="server" CommandName="cancel">取消</asp:LinkButton>
                         </div>
                     </EditItemTemplate>
                     <FooterTemplate>
                     </FooterTemplate>
                     <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" 
                         HorizontalAlign="center" />
                     <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                     <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                     <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="center" />
                     <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" 
                         HorizontalAlign="center" />
                 </asp:DataList>
             </ContentTemplate>
         </asp:UpdatePanel>
            </div>
<br /><br />

        <table border="0" cellpadding="5" cellspacing="0" width="90%" align="center">
            <tr>
                <td colspan="2">
                <h4>添加类别</h4>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; font-weight: bold; text-align: right;"><asp:Label ID="Label2" runat="server" Text="类型名称："></asp:Label></td>
                <td>
                    <asp:TextBox ID="TextBox4" runat="server" MaxLength="10"></asp:TextBox>
                    <asp:Label ID="Label5" runat="server" ForeColor="Red" Text="类型名称不能为空" Visible="False"></asp:Label></td>
            </tr>
            <tr>
                <td style="font-weight: bold; width: 150px; text-align: right">
                    <asp:Label ID="Label6" runat="server" Text="格式范围："></asp:Label></td>
                <td>
                    <asp:TextBox ID="TextBox5" runat="server" Width="260px"></asp:TextBox>
                    <asp:Label ID="Label7" runat="server" ForeColor="Red">用“.”符号隔开，例：.jpg.doc.xls</asp:Label></td>
            </tr>
            <tr>
                <td style="width: 150px; font-weight: bold; text-align: right;"><asp:Label ID="Label3" runat="server" Text="排　　序："></asp:Label></td>
                <td>
                    <asp:TextBox ID="TextBox3" runat="server" Width="60px" Text="0" EnableTheming="True"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox3"
                        ErrorMessage="RangeValidator" MaximumValue="999" MinimumValue="0" Type="Integer">请输入0-999任意整数</asp:RangeValidator></td>
            </tr>
            <tr>
                <td style="width: 150px; font-weight: bold; text-align: right;"><asp:Label ID="Label4" runat="server" Text="是否可用："></asp:Label></td>
                <td><asp:CheckBox ID="CheckBox2" Text="是" runat="server" Checked="true" /></td>
            </tr>

            <tr>
                <td colspan="2" align="center">
                 <asp:Button ID="Button1" runat="server" Text="添加类别" OnClick="Button1_Click" />
                </td>
            </tr>
        </table>

        </div>

    </form>
</body>
</html>