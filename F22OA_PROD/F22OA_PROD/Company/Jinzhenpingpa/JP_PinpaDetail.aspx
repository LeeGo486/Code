<%@ page language="C#" autoeventwireup="true" inherits="Company_Jinzhenpingpa_JP_PinpaDetail, App_Web_jp_pinpadetail.aspx.7222f8d" title="Untitled Page" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>款式调查结果</title>
  <link   href="../../css/project.css" type="text/css"  rel="stylesheet">
	
</head>
<body> 
    <form id="form1" runat="server">
     <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">竟争调查</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    <div class="BContent">
<table width="100%">
<tr>
<td>

    <asp:GridView ID="GridViewPinpaDetail" runat="server" Visible="false" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"  CssClass="tbGrid" CellSpacing="1" DataSourceID="ODSourceJinzhenPinpaDetail" ForeColor="#333333" GridLines="None" Width="100%">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"  />
        <Columns>
            <asp:TemplateField HeaderText="品牌名称" SortExpression="compete">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("compete") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("compete") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="店铺名称" SortExpression="d_name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("d_name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("d_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="上市时间" SortExpression="setdate">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("setdate") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("setdate", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="新产品型号" SortExpression="styleid">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("styleid") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("styleid") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="颜色" SortExpression="c_name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("c_name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("c_name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="单价" SortExpression="x_price">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("x_price") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("x_price") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="风格" SortExpression="styletype">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("styletype") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("styletype") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="原材料类别" SortExpression="st_lb">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("st_lb") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("st_lb") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="评论" SortExpression="comment">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("comment") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("comment") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                
                <ItemTemplate>
                
                   <a href="<%# Getpic(Eval("imagesurl").ToString())%>" target="_blank"> 
                   <asp:Image ID="Image1" runat="server" ImageUrl='<%# Getpic(Eval("imagesurl").ToString())%>' />
                   </a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle BackColor="#EFF3FB" />
        <EditRowStyle BackColor="#2461BF" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
       <PagerStyle  CssClass="header" HorizontalAlign="Center" />
                <HeaderStyle CssClass="dgHeader"  HorizontalAlign="Center" VerticalAlign="Middle"  />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    &nbsp;
    <asp:DataList ID="DataListPinpaDetail" runat="server" DataSourceID="ODSourceJinzhenPinpaDetail" Width="100%">
        <ItemTemplate>
        <table width="100%"  class="tbborder" >
        <tr>
        <td align="left" valign="top">
         <table >
            <tr>
                <td align="left" width="100px"><asp:Label ID="Label1" runat="server" Text="品牌名称:"></asp:Label></td>
                 <td align="left"> <asp:Label ID="Label11" runat="server" Text='<%# Bind("compete") %>'></asp:Label></td>
            </tr>
              <tr>
                <td  align="left"><asp:Label ID="Label10" runat="server" Text="店铺名称:"></asp:Label></td>
                 <td  align="left">   <asp:Label ID="Label2" runat="server" Text='<%# Bind("d_name") %>'></asp:Label></td>
            </tr>
              <tr>
                <td  align="left"><asp:Label ID="Label12" runat="server" Text="上市时间:"></asp:Label></td>
                 <td  align="left">    <asp:Label ID="Label3" runat="server" Text='<%# Bind("setdate", "{0:d}") %>'></asp:Label></td>
            </tr>
             <tr>
                <td  align="left"><asp:Label ID="Label13" runat="server" Text="款式型号:"></asp:Label></td>
                 <td  align="left"> <asp:Label ID="Label4" runat="server" Text='<%# Bind("styleid") %>'></asp:Label></td>
            </tr>
              <tr>
                <td  align="left"><asp:Label ID="Label14" runat="server" Text="款式颜色:"></asp:Label></td>
                 <td  align="left">  <asp:Label ID="Label5" runat="server" Text='<%# Bind("c_name") %>'></asp:Label></td>
            </tr>
           <tr>
                <td  align="left"><asp:Label ID="Label15" runat="server" Text="款式单价:"></asp:Label></td>
                 <td  align="left"><asp:Label ID="Label6" runat="server" Text='<%# Bind("x_price") %>'></asp:Label></td>
            </tr>
             <tr>
                <td  align="left"><asp:Label ID="Label16" runat="server" Text="款式风格:"></asp:Label></td>
                 <td  align="left"> <asp:Label ID="Label7" runat="server" Text='<%# Bind("styletype") %>'></asp:Label></td>
            </tr>
             
           
            </table>
        </td>
        <td align="left">
            <table width="100%">
             <tr>
                    
                     <td  align="left">款式样图:<br /><a href="<%# Getpic(Eval("imagesurl").ToString())%>" target="_blank"> 
                       <asp:Image ID="Image1" runat="server" ImageUrl='<%# Getpic(Eval("imagesurl").ToString())%>' />
                       </a></td>
                </tr>
            </table>
        </td>
        </tr>
         <tr>
        <td colspan="2" align="left">
        <table>
        <tr>
                <td  align="left"><asp:Label ID="Label17" runat="server" Text="评论:"></asp:Label></td>
                 <td  align="left"> <asp:Label ID="Label9" runat="server" Text='<%# Bind("comment") %>'></asp:Label></td>
            </tr>
        </table>
        </td>
         
        </tr>
        </table>
           
        </ItemTemplate>
    </asp:DataList>
    <asp:ObjectDataSource ID="ODSourceJinzhenPinpaDetail" runat="server" SelectMethod="F22_GetJinzhenPinpaDetail"
        TypeName="ddl_FindProduct">
        <SelectParameters>
            <asp:Parameter DefaultValue="-" Name="compete" Type="String" />
            <asp:Parameter DefaultValue="-" Name="depotid" Type="String" />
            <asp:Parameter DefaultValue="1980-02-01" Name="setdate" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</td>
</tr>
</table>
   </div>
    </form>

