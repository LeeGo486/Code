<%@ page language="C#" autoeventwireup="true" inherits="Company_Jinzhenpingpa_JP_Pinpalist, App_Web_jp_pinpalist.aspx.7222f8d" title="Untitled Page" %>
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
					<span id="rm_MainPanel_lFunctionName">竟争品牌上市调查</span>&nbsp;&nbsp;&nbsp;
					
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
     <td align="left">
         <table width="100%">
         <tr>
            <td align="left" style="height: 16px">
                &nbsp; &nbsp;
            </td>
         </tr>
         </table>
        
      </td>
</tr>
<tr>
    <td>
      <table width="100%" class="tbborderB">
          <tr>
             <td>
                 <asp:GridView ID="GridViewJinpalist" runat="server" AllowPaging="True" AllowSorting="True"
                     AutoGenerateColumns="False" CellPadding="3" DataSourceID="ODSourceJinzhenPinpalist"
                     ForeColor="#333333" GridLines="None" Width="100%">
                     <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                     <Columns>
                         <asp:BoundField DataField="compete" HeaderText="品牌名称" ReadOnly="True" SortExpression="compete" />
                         <asp:BoundField DataField="d_name" HeaderText="店铺名称" ReadOnly="True" SortExpression="d_name" />
                         <asp:BoundField DataField="setdate" DataFormatString="{0:d}" HeaderText="上市时间" HtmlEncode="False"
                             ReadOnly="True" SortExpression="setdate" />
                      <asp:TemplateField HeaderText="操作">
                      <ItemTemplate>
                         <a href='JP_PinpaDetail.aspx?pid=<%# Server.UrlEncode(Eval("compete").ToString())  %>&did=<%# Eval("depotid") %>&sdate=<%# Eval("setdate") %>' >查看</a>
                         </ItemTemplate>
                  </asp:TemplateField>
                     </Columns>
                     <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
                     <EditRowStyle BackColor="#2461BF" />
                     <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                     <PagerStyle CssClass="header"　 HorizontalAlign="Center" />
                     <HeaderStyle CssClass="dgHeader" />
                     <AlternatingRowStyle BackColor="White" />
                 </asp:GridView>
             
                 <asp:ObjectDataSource ID="ODSourceJinzhenPinpalist" runat="server" SelectMethod="F22_GetJinzhenPinpa"
              TypeName="ddl_FindProduct" OldValuesParameterFormatString="original_{0}">
          </asp:ObjectDataSource>
             </td>
          </tr>
      </table>
    </td>
</tr>
</table>
    </div>
    </form>
</body>
</html>


