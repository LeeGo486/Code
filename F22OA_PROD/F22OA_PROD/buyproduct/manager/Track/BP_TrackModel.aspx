<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Track_BP_TrackModel, App_Web_bp_trackmodel.aspx.40cff5d2" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择款式</title>
          <link  href="../../../css/project.css" type="text/css"  rel="stylesheet">
		<base target="_self" />
		<script type="text/javascript">
     function bt_close_onclick()
 {
        
         window.close();
  
 }
 function bt_return()
     {
        
        window.returnValue="0";
         window.close();
     }
    </script>
         
</head>
<body>
    <form id="form1" runat="server">
        <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">跟进流程</span>&nbsp;&nbsp;&nbsp;
					
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
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="确  定" CssClass="btn" OnClick="BtnSubmit_Click" />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退  出" CssClass="btn" OnClientClick="bt_close_onclick()" />
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
     
      <table>

       <tr>
    
       <td valign="top">
       <!--the cantent-->
       
                
      <table width="100%">
      <tr>
      <td align="center">
          &nbsp;&nbsp;
          <asp:HiddenField ID="HFPublishCode" runat="server" />
          &nbsp;
          <asp:Label ID="LblShow" runat="server" Text=""></asp:Label>&nbsp;
      </td>
      </tr>
       <tr>
                             
                                  
                                    <td align="center">
                                    <asp:Panel ID="Panel1" runat="server" Height="500px" Width="700px" ScrollBars="auto">
                                           
                         
                                    <asp:Label ID="LblTitle" runat="server" Width="510px" ForeColor="Red"></asp:Label>&nbsp;
                                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" Width="100%"  CssClass="tbGrid" CellSpacing="1" 
                                            AutoGenerateColumns="False" DataKeyNames="TrackModelID"  CellPadding="4"  BorderWidth="1" GridLines="None" ForeColor="#333333"  HorizontalAlign="Center" AllowPaging="false">
                                            <Columns>
                                                 <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="选择" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField SortExpression="TxtTrackName" HeaderText="进阶名称">
                       <ItemTemplate>
                           <asp:Label ID="LblTrackName" runat="server" Text='<%# Bind("TrackName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField SortExpression="TrackTime" HeaderText="所需时间(天)">
                       <ItemTemplate>
                           <asp:Label ID="LblTrackTime" runat="server" Text='<%# Bind("TrackTime", "{0:#,##0.00}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField SortExpression="TrackIndex" HeaderText="顺序">
                       <ItemTemplate>
                         <asp:Label ID="LblTrackIndex" runat="server" Text='<%# Bind("TrackIndex") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

            
                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle CssClass="header" HorizontalAlign="Center" />
                                            <HeaderStyle CssClass="dgHeader"   HorizontalAlign="Center"  />
                                            <AlternatingRowStyle BackColor="White" />
                                            <EditRowStyle BackColor="#2461BF" />
                                              <EmptyDataTemplate>
                                                <table cellspacing="0" cellpadding="0" border="1"  id="GridView1" style="color:#333333;font-size:10pt;width:100%;border-collapse:collapse;">
			                                        <tr class="dgHeader" height="3px" >
		
				                                        <th scope="col">进阶名称</th>
                                                        <th scope="col">所需时间</th>
                                                        <th scope="col">顺序</th>
			                                        </tr>
			                                             <tr  bgcolor="White">
                                                      
                                                         <th scope="col"> &nbsp;</th>
                                                         <th scope="col"> &nbsp;</th>
                                                         <th scope="col"> &nbsp;</th>
                                                    </tr>
		                                            </table>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                        &nbsp;
                                        <asp:HiddenField ID="HFID" runat="server" />
                                        &nbsp;<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="CG_GetTrackModel" TypeName="ddl_cgnew" >
                                         
                                        </asp:ObjectDataSource>
                                        &nbsp; &nbsp;
                                 
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
    
    </div>
    </td>
    </tr>
    </table>
       
  
    </form>
</body>
</html>


