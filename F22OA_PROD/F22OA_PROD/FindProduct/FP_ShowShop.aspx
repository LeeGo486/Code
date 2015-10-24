<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_ShowShop, App_Web_fp_showshop.aspx.a918743" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>选择店铺</title>
      <link  href="../css/project.css" type="text/css"  rel="stylesheet">
		<base target="_self" />
		<script type="text/javascript">
     function bt_close_onclick()
 {
  
       
       window.close();
  
 }
 function bt_return()
     {
        
       
        //var values=window.document.getElementById("HFID").value;
        //debugger;
        //window.returnValue=values;
        //window.dialogArguments.location.reload();
        window.dialogArguments.location=window.dialogArguments.location;
         window.close();
     }
    </script>
</head>
<body>
    <form id="form1" runat="server">
      <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">调查方案选择</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
         <!--menu----->
   <table  width="98%" class="menu">
    <tr>
    <td align="right">
    <div >
    <asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查  询" CssClass="btn" OnClick="BtnSearch_Click"  />
       <asp:Button ID="BtnSave" Width="100px" runat="server" Text="确  定" CssClass="btn" OnClick="BtnSubmit_Click"  />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退  出" CssClass="btn"   OnClientClick="bt_close_onclick()" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

    <table width="100%">
    <tr>
    <td  height="25px">
    </td>
    </tr>
    <tr>
    <td align="center" >
      <div>
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
                             <ContentTemplate>
      <table width="98%">
       <tr>
                                    <td align="left">
                                        &nbsp;
                                     &nbsp;
                                        <asp:Label ID="Label1" runat="server" Text="编号名称:"></asp:Label>
                                        <asp:TextBox ID="TxtNum" runat="server"></asp:TextBox>
                                        <asp:RadioButton ID="RBtnNum" runat="server" GroupName="search" Text="店铺编号" Checked="True" />
                                        <asp:RadioButton ID="RBtnCode" runat="server" GroupName="search" Text="助记码" />
                                        <asp:RadioButton ID="RBtnName" runat="server" GroupName="search" Text="店铺名称" />
                                        </td>
                                    </tr>
                                    <tr>
                                    <td align="center">
                                    <asp:Panel ID="Panel1" runat="server" Height="500px" Width="800px" ScrollBars="Auto" >
                                           
                         
                             
                                    <asp:Label ID="LblTitle" runat="server" Width="510px" ForeColor="Red"></asp:Label>&nbsp;
                                        <asp:GridView ID="GridView1" runat="server"  CssClass="tbGrid" CellSpacing="1" AllowSorting="True" Width="95%" 
                                            AutoGenerateColumns="False" DataKeyNames="depotid"  CellPadding="4"  BorderWidth="1" GridLines="None" ForeColor="#333333"  HorizontalAlign="Center">
                                            <Columns>
                                                 <asp:TemplateField HeaderText="选择" HeaderStyle-Width="50px">
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="选择" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                                                     <ItemStyle Width="50px" />
                    </asp:TemplateField>
                                                <asp:BoundField DataField="dpthelp" HeaderText="助记码" SortExpression="dpthelp"   HeaderStyle-Width="100px">
                                                    <ItemStyle Width="100px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="depotid" HeaderText="编号" ReadOnly="True" SortExpression="depotid"  HeaderStyle-Width="100px" >
                                                    <ItemStyle Width="100px" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="店铺名称" SortExpression="d_name"  HeaderStyle-Width="100px">
                                                  
                                                    <ItemTemplate>
                                                        <asp:Label ID="Labeld_name" runat="server" Text='<%# Bind("d_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="100px" />
                                                </asp:TemplateField>

                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle  CssClass="header" HorizontalAlign="Center" />
                                            <HeaderStyle   CssClass="header"  HorizontalAlign="Center" VerticalAlign="Middle"  />
                                            <AlternatingRowStyle BackColor="White" />
                                            <EditRowStyle BackColor="#2461BF" />
                                              <EmptyDataTemplate>
                          
		                               <table id="GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                                                      class="tbGrid" width="100%">
                    <tr  Class="dgHeader" >
                     <th scope="col">&nbsp;</th>
                         <th scope="col">助记码</th>
                            <th scope="col">店铺编号</th>
                            <th scope="col">店铺名称</th>
                           
                    </tr>
                     <tr  bgcolor="White">
                      <th scope="col"></th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                      
                    </tr>
                </table>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                        <asp:HiddenField ID="HFID" runat="server" />
        
                                        
                                             <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="DC_GetDepotList"
                                            TypeName="ddl_FindProduct">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="dpipi" Name="shopnum" Type="String" />
                                                <asp:Parameter DefaultValue="code" Name="type" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                             
                                        
                                 
                                        </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                    <td align="center">
                                       </td>
                                    </tr>
                                    </table> </ContentTemplate>
                                </asp:UpdatePanel>
       
    </div>
    </td>
    </tr>
    </table>
       
  
    </form>
</body>
</html>
