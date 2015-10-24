<%@ page language="C#" autoeventwireup="true" inherits="f22_vip_setDoucment_SDBuildVipShop, App_Web_sdbuildvipshop.aspx.f3086b61" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<head id="Head1" runat="server">
     <title>选择店铺</title>
       <link href="../css/webSample_style.css" rel="stylesheet" type="text/css" />
    <link href="../css/default.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" type="text/css" rel="stylesheet"/>
    <base target="_self" />
    
 <script type="text/javascript">
     function bt_close_onclick()
 {
  
       
       window.close();
  
 }
 function bt_return()
     {
        var values=window.document.getElementById("HFID").value+','+window.document.getElementById("HFName").value;
        //debugger;
        window.returnValue=values;
         window.close();
     }
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="mframe">
   

			
					<table cellSpacing="0" cellPadding="0" width="98%" align="center" >
						<tr>
							<td ></td>
							<td >
                                      
                                
       
                                    <table width="98%">
                                    <tr>
                                    <td align="left">
                                        <asp:Label ID="Label1" runat="server" Text="编号名称:"></asp:Label>
                                        <asp:TextBox ID="TxtNum" runat="server"></asp:TextBox>
                                        <asp:RadioButton ID="RBtnNum" runat="server" GroupName="search" Text="店铺编号" Checked="True" />
                                        <asp:RadioButton ID="RBtnCode" runat="server" GroupName="search" Text="助记码" />
                                        <asp:RadioButton ID="RBtnName" runat="server" GroupName="search" Text="店铺名称" />
                                        <asp:Button ID="BtnSearch" runat="server" Text="查询" Width="86px" OnClick="BtnSearch_Click" /></td>
                                    </tr>
                                    <tr>
                                    <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                             <ContentTemplate>
                                    <asp:Label ID="LblTitle" runat="server" Width="510px" ForeColor="Red"></asp:Label>&nbsp;
                                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" Width="100%" Font-Size="10pt" 
                                            AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" DataKeyNames="depotid" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" CellPadding="4" GridLines="None" ForeColor="#333333" OnRowDataBound="GridView1_RowDataBound">
                                            <Columns>
                                            <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                            Text=""></asp:LinkButton>
                                                    </ItemTemplate>
                                     <HeaderStyle CssClass="hidden" />
                                                <ItemStyle CssClass="hidden" />
                                                <FooterStyle CssClass="hidden" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="dpthelp" HeaderText="助记码" SortExpression="dpthelp" />
                                                <asp:BoundField DataField="depotid" HeaderText="店铺编号" ReadOnly="True" SortExpression="depotid" />
                                                <asp:TemplateField HeaderText="仓库/柜台名称" SortExpression="d_name">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("d_name") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Labeld_name" runat="server" Text='<%# Bind("d_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="areaid" HeaderText="地区编号" SortExpression="areaid" />
                                                <asp:BoundField DataField="r_name" HeaderText="仓店管理员" SortExpression="r_name" />
                                                <asp:BoundField DataField="Tel" HeaderText="电话" SortExpression="Tel">
                                                    <ItemStyle CssClass="hidden" />
                                                    <HeaderStyle CssClass="hidden" />
                                                    <FooterStyle CssClass="hidden" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Fax" HeaderText="传真" SortExpression="Fax" >
                                                    <ItemStyle CssClass="hidden" />
                                                    <HeaderStyle CssClass="hidden" />
                                                    <FooterStyle CssClass="hidden" />
                                                </asp:BoundField>
                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True"  />
                                            <RowStyle BackColor="#EFF3FB" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center"  />
                                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Font-Size="10pt" />
                                            <AlternatingRowStyle BackColor="White" />
                                            <EditRowStyle BackColor="#2461BF" />
                                            <PagerSettings Mode=nextPreviousFirstLast FirstPageText="首页" LastPageText="末页" NextPageText="下一页" PreviousPageText="上一页"  />
                                            <EmptyDataTemplate>
                                                <table cellspacing="0" cellpadding="4" border="0" id="GridView1" style="color:#333333;font-size:10pt;width:100%;border-collapse:collapse;">
			                                        <tr style="color:White;background-color:#507CD1;font-size:10pt;font-weight:bold;">
				                                        <th scope="col">&nbsp;</th>
				                                        <th scope="col"><a href="#" style="color:White;">助记码</a></th>
				                                        <th scope="col"><a href="#" style="color:White;">店铺编号</a></th>
				                                        <th scope="col"><a href="#" style="color:White;">仓库/柜台名称</a></th>
				                                        <th scope="col"><a href="#" style="color:White;">地区编号</a></th>
				                                        <th scope="col"><a href="#" style="color:White;">仓店管理员</a></th>
				                                        <th class="hidden" scope="col">
				                                        <a href="#" style="color:White;">电话</a></th>
				                                        <th class="hidden" scope="col"><a href="#" style="color:White;">传真</a></th>
				                                        
			                                        </tr>
			                                        <tr >
				                                        <td></td>
				                                        <td></td>
				                                        <td></td>
				                                        <td></td>
				                                        <td></td><td>&nbsp;</td>
				                                        <td class="hidden">&nbsp;</td>
				                                        <td class="hidden">&nbsp;</td>
			                                        </tr>
			
		                                            </table>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                        <asp:HiddenField ID="HFID" runat="server" />
                                        <asp:HiddenField ID="HFName" runat="server" />
                                        
                                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetDepotList"
                                            TypeName="jcard">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="dpipi" Name="shopnum" Type="String" />
                                                <asp:Parameter DefaultValue="code" Name="type" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                              </ContentTemplate>
                                </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr>
                                    <td>
                                        <asp:Button ID="BtnSubmit" runat="server" Text="确定"  OnClientClick="return bt_return()" Width="108px" OnClick="BtnSubmit_Click1"  />
                                        <asp:Button ID="BtnClane" runat="server" Text="退出" OnClientClick="bt_close_onclick()" Width="108px" /></td>
                                    </tr>
                                    </table>
       
    
    </td>
				<td ></td>
						</tr>
					</table>
	            

    </div>
    </form>
</body>
</html>
