<%@ page language="C#" autoeventwireup="true" enableeventvalidation="false" inherits="FindProduct_FP_ShowStyle, App_Web_fp_showstyle.aspx.a918743" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择款式</title>
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
					<span id="rm_MainPanel_lFunctionName">选择款式</span>&nbsp;&nbsp;&nbsp;
					
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
    <td align="center">
     
		
    </td>
    </tr>
    <tr>
    <td align="center">
      <div>
       <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
                             <ContentTemplate>
      <table>
      <tr>
      <td >
       
          </td>
                 <td align="left">
                                        <asp:Label ID="Label1" runat="server" Text="编号名称:"></asp:Label>
                                        <asp:TextBox ID="TxtNum" runat="server"></asp:TextBox>
                                        <asp:RadioButton ID="RBtnNum" runat="server" GroupName="search" Text="款式编号" Checked="True" />
                                      　<asp:RadioButton ID="RBtnName" runat="server" GroupName="search" Text="款式名称" />
                                       </td>
      </tr>
       <tr>
        <td style="WIDTH: 120px" align="left" valign="top">
         <asp:Panel ID="Panel2" runat="server" Height="650px" Width="120px" ScrollBars="auto">
          <asp:TreeView ID="TreeViewLeft" runat="server"  ShowLines="True" ToolTip="" OnSelectedNodeChanged="TreeViewLeft_SelectedNodeChanged">
          </asp:TreeView>
          </asp:Panel>
       </td>
       <td valign="top">
       <!--the cantent-->
       
                
      <table width="98%">
      <tr>
      <td align="center">
          <asp:HiddenField ID="HFType" runat="server" /> 
          <asp:HiddenField ID="HFFirst" runat="server" />
           <asp:HiddenField ID="HFSecond" runat="server" />
          <asp:Label ID="LblShow" runat="server" Text=""></asp:Label>
          <asp:UpdateProgress ID="UpdateProgress1" runat="server">
			<ProgressTemplate>
				<div id="modalBackground"></div>
				<div id="animationDialog">
					<img  src="../icon/loading.gif" alt="Loading" />
					查询中，请稍等...
				</div>
			</ProgressTemplate>
		</asp:UpdateProgress>
      </td>
      </tr>
       <tr>
                             
                                  
                                    <td align="center">
                                    <asp:Panel ID="Panel1" runat="server" Height="500px" Width="700px" ScrollBars="auto">
                                           
                         
                                    <asp:Label ID="LblTitle" runat="server" Width="510px" ForeColor="Red"></asp:Label>&nbsp;
                                        <asp:GridView ID="GridView1"  CssClass="tbGrid" CellSpacing="1" runat="server" AllowSorting="True" Width="100%" 
                                            AutoGenerateColumns="False" DataKeyNames="styleid"  CellPadding="4"  BorderWidth="1" GridLines="None" ForeColor="#333333"  HorizontalAlign="Center" PageSize="500" AllowPaging="True">
                                            <Columns>
                                                 <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="选择" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                     <asp:BoundField DataField="styleid" HeaderText="款式编号" ReadOnly="True" SortExpression="styleid" />
                             
                                                <asp:TemplateField HeaderText="款式名称" SortExpression="s_name">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("s_name") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Labeld_name" runat="server" Text='<%# Bind("s_name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                              <asp:BoundField DataField="J_cost" HeaderText="成本价" ReadOnly="True" SortExpression="J_cost" />
                                               <asp:BoundField DataField="J_price" HeaderText="结算价" ReadOnly="True" SortExpression="J_price" />
                                               <asp:BoundField DataField="comment" HeaderText="备注" ReadOnly="True" SortExpression="comment" />
                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle CssClass="header" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dgHeader"   HorizontalAlign="Center"  />
                                            <AlternatingRowStyle BackColor="White" />
                                            <EditRowStyle BackColor="#2461BF" />
                                              <EmptyDataTemplate>
                                               
		                                            
		                               <table id="GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                                                      class="tbGrid" width="100%">
                    <tr  Class="dgHeader" >
                     <th scope="col">&nbsp;</th>
                         <th scope="col">款式编号</th>
                            <th scope="col">款式名称</th>
                           
                           
                    </tr>
                     <tr  bgcolor="White">
                      <th scope="col"></th>
                    
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                      
                    </tr>
                </table>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                        &nbsp;
                                        <asp:HiddenField ID="HFID" runat="server" />
        
                                        
                                             <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="DC_GetStyleList"
                                            TypeName="ddl_FindProduct">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="dpipi" Name="shopnum" Type="String" />
                                                <asp:Parameter DefaultValue="code" Name="type" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                        &nbsp;
                                         <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="DC_GetStyleConectByYearType"
                                            TypeName="dll_FindProductShow">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="dpnum" Type="int16" />
                                                <asp:Parameter DefaultValue="0" Name="st_year" Type="int16" />
                                                <asp:Parameter DefaultValue="" Name="type" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                 
                                        </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                    <td align="center">
                                        </td>
                                    </tr>
                                    </table>
                                 <!--the cantent end-->
       </td>
      </tr>
      </table>
        </ContentTemplate>
                                </asp:UpdatePanel>
    </div>
    </td>
    </tr>
    </table>
       
  
    </form>
</body>
</html>

