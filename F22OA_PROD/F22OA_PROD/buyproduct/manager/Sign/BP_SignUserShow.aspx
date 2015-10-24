<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Sign_BP_SignUserShow, App_Web_bp_signusershow.aspx.9fbedc62" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择</title>
          <link  href="../../../css/project.css" type="text/css"  rel="stylesheet">
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
     
          <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：人员<span id="rm_MainPanel_lFunctionName">选择</span>&nbsp;&nbsp;&nbsp;
					
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
      
    <table width="98%">
    <tr>
    <td>

    </td>
    </tr>
    <tr>
    <td align="center">
      <div>
                 
      <table width="98%">
       <tr>
                                    <td align="left">
                                        &nbsp;  
                                        双击可选中</td>
                                    </tr>
                                    <tr>
                                    <td align="center">
                                    <asp:Panel ID="Panel1" runat="server" Height="600px" Width="760px" ScrollBars="auto">
                                           
                         
                             
                                    <asp:Label ID="LblTitle" runat="server" Width="510px" ForeColor="Red"></asp:Label>&nbsp;
                                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" Width="100%"  CssClass="tbGrid" CellSpacing="1" 
                                            AutoGenerateColumns="False" DataKeyNames="UserNo"  CellPadding="4"  BorderWidth="1px" GridLines="None" ForeColor="#333333"  HorizontalAlign="Center"  OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataSourceID="ObjectDataSource1">
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
                                            

                <asp:TemplateField SortExpression="TyperNo" HeaderText="编号" >
                <ItemTemplate>
                 <asp:Label ID="LblTyperNo" runat="server" Text='<%# Bind("userid") %>'></asp:Label>         
                </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField SortExpression="TyperName" HeaderText="名称">
                <ItemTemplate>
                     <asp:Label ID="LblTyperName" runat="server" Text='<%# Bind("username") %>'></asp:Label>
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
                    <table cellspacing="0" cellpadding="1" border="1" id="GridView1" style="color:#333333;font-size:10pt;width:100%;border-collapse:collapse;">
                        <tr class="dgHeader">                    
                        <th scope="col">编号</th>
                        <th scope="col">名称</th>
                     
                        </tr>
                           <tr  bgcolor="White">
                     
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                     
                    </tr>

                        </table>
                </EmptyDataTemplate>
            </asp:GridView>
              <asp:HiddenField ID="HFID" runat="server" />
            <asp:HiddenField ID="HFName" runat="server" />
           <asp:HiddenField ID="HFSupplyerID" runat="server" />
            
           <asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="ddl_cgnew" SelectMethod="CG_GetUser"  >
                </asp:ObjectDataSource>
            
     
            </asp:Panel>
            </td>
        </tr>
        <tr>
        <td align="center">

        </tr>
        <tr>
        <td>
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


