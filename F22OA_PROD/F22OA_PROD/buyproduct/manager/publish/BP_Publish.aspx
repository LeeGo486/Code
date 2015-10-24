<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_publish_BP_Publish, App_Web_bp_publish.aspx.874e4ad9" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>公司联系方式</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <!--head-->
    <table class="themenu">
    <tr>
    <td>
    
    <div class="content" style="font-size:18px">
		        <strong>
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/icon/page_tools_bar.gif" />采购发布申请</strong>
		    </div>
		    </td>
    <td align="right">
    <table>
    <tr>
    <td>
      <!--menu----->
      	<table width="100%" height="23" border="0" cellpadding="1" cellspacing="1" ID="Table1">
			<tr valign="middle">
				<td >
				        <div id="tabs4">
                              <ul>
                              <li><a href="#" title=""><span style="width:100px; text-align:center"> <img border="0" width="4" height="6" src="../../../icon/btn_arrow.gif">新增发布</span></a></li>
                              <li><a id="A1" href="#"  runat="server" onserverclick="btnDel_Click"   title=""><span style="width:100px; text-align:center"> <img border="0" width="4" height="6" src="../../../icon/btn_arrow.gif">删除所选 </span></a></li>
                               </ul>
                        </div>
                 </td>
			</tr>
		</table>
		  <!--menu----->
		
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
    	<!--head end-->
        
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
                AutoGenerateColumns="False" DataKeyNames="PublishID" DataSourceID="ObjectDataSource1"  
                HorizontalAlign="Center"    CellPadding="3"  ForeColor="#333333"  GridLines="None" Width="100%">
                <Columns>
                  
                    <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="" />
                        </HeaderTemplate>
                        <ItemTemplate ><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PublishID" HeaderText="PublishID" ReadOnly="True" SortExpression="PublishID" Visible="false" />
                    <asp:BoundField DataField="MaterID" HeaderText="货物编号" SortExpression="clname" />
                    <asp:BoundField DataField="MaterName" HeaderText="货物名称" SortExpression="clname" />
                    <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                    <asp:BoundField DataField="Color" HeaderText="颜色" SortExpression="Color" />
                    <asp:BoundField DataField="Number" HeaderText="采购数量" SortExpression="Number" />
                    <asp:BoundField DataField="BuyDate" HeaderText="采购日期" SortExpression="BuyDate" DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:TemplateField HeaderText="样图">
                
                <ItemTemplate>
                
                   <a href="#" target="_blank"> 
                   <asp:Image ID="Image1" runat="server" ImageUrl='' />
                   </a>
                </ItemTemplate>
            </asp:TemplateField>
                  
                   
                    <asp:BoundField DataField="Crdate" HeaderText="建单日期" SortExpression="Crdate"  DataFormatString="{0:d}" HtmlEncode="false"  />
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <asp:HyperLink  runat="server" Text='修改' NavigateUrl='<%# "PublishCgContentEdit.aspx?publishID=" + DataBinder.Eval(Container, "DataItem.PublishID")  %>' ID="Hyperlink2">
                        </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="State" HeaderText="状态" SortExpression="State" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" FooterStyle-CssClass="hidden" />
                </Columns>
                 <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#EFF3FB" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle  CssClass="header"  HorizontalAlign="Center" />
                <HeaderStyle CssClass="dgHeader"   HorizontalAlign="Center" VerticalAlign="Middle" font-size=9pt  />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                     <table cellspacing="0" cellpadding="5" border="0" id="ctl00_ctplhder_GridView1" style="color:#333333;width:100%;border-collapse:collapse;">
                        <tr Class="header" >
                            <th scope="col">货物号</th>
                            <th scope="col">货物名称</th>
                            <th scope="col">规格</th>
                            <th scope="col">颜色</th>
                            <th scope="col">样图名</th>
                            <th scope="col">采购数量</th>
                            <th scope="col">采购时间</th>
                            <th scope="col">到货时间</th>
                            <th scope="col">描述</th>
                            <th scope="col">指定的供应商</th>
                        </tr>
                      </table>
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="ddl_cg" SelectMethod="GetPublishCgContentList">
                <SelectParameters>
                    <asp:Parameter Name="buydatebeg" Type="string" DefaultValue="1900-01-01" />
                    <asp:Parameter Name="buydateend" Type="string" DefaultValue="1900-01-01" />
                    <asp:Parameter Name="sfsh" Type="string" DefaultValue="-" />
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
