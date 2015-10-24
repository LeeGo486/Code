<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_basic_BP_BSUserSelect, App_Web_bp_bsuserselect.aspx.11713791" %>
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
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">选择</span>&nbsp;&nbsp;&nbsp;
					
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
        &nbsp;
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
      
    <table width="100%">
    <tr>
    <td>
<table   width="98%" class="tbsh">
        <colgroup>
        <col  />
        <col  width="420px" align="right"/>
        </colgroup>
        <tr>
            <td >
                名 称:<asp:TextBox ID="TxtSupplyNo" runat="server" CssClass="tbox" Width="100px"></asp:TextBox>&nbsp;
                &nbsp;<asp:RadioButton ID="RBtnCode" runat="server" Text="用户编号" GroupName="aa" Checked="true" />
            <asp:RadioButton ID="RBtnName" runat="server" Text="用户名称" GroupName="aa" /></td>
      
        
        <td> <asp:Button ID="BtnSearch" Width="100" runat="server" Text="查   询" CssClass="btn" OnClick="BtnSearch_Click" />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="确  定" CssClass="btn" OnClick="BtnSubmit_Click" />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退  出" CssClass="btn" OnClientClick="bt_close_onclick()" />&nbsp;
        </td>
      
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;&nbsp;<asp:HiddenField ID="HFUserID" runat="server" />
            </td>
        </tr>
      </table>  
    </td>
    </tr>
    <tr>
    <td align="center">
      <div>
                 
      <table width="98%">
       <tr>
                                    <td align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                    <td align="center">
                                    <asp:Panel ID="Panel1" runat="server" Height="600px" Width="760px" ScrollBars="auto">
                                           
                         
                             
                                    <asp:Label ID="LblTitle" runat="server" Width="510px" ForeColor="Red"></asp:Label>&nbsp;
                                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" Width="100%"  CssClass="tbGrid" CellSpacing="1" 
                                            AutoGenerateColumns="False" DataKeyNames="userid"  CellPadding="4"  
                                            BorderWidth="1px" GridLines="None" ForeColor="#333333"  HorizontalAlign="Center"  OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataSourceID="ObjectDataSource1" AllowPaging="True" PageSize="15">
                                            <Columns>
                                  <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="选择" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                                      <ItemStyle Width="50px" />
                                      <HeaderStyle Width="50px" />
                    </asp:TemplateField>
                                  <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                            Text=""></asp:LinkButton>
                                                    </ItemTemplate>
                                     <HeaderStyle CssClass="hidden" />
                                                <ItemStyle CssClass="hidden" />
                                                <FooterStyle CssClass="hidden" />
                                                </asp:TemplateField>
                                             <asp:TemplateField SortExpression="userid" HeaderText="用户编号" >

                                            <ItemTemplate>
                                                                <asp:Label ID="Lbluserid" runat="server" Text='<%# Bind("userid") %>'></asp:Label>
                                                            
                                            </ItemTemplate>
                                               
                                            </asp:TemplateField>

                <asp:TemplateField SortExpression="username" HeaderText="用户名称">
                <ItemTemplate>
                 <asp:Label ID="Lblusername" runat="server" Text='<%# Bind("username") %>'></asp:Label>         
                </ItemTemplate>
                    <HeaderStyle Width="100px" />
                </asp:TemplateField>

                <asp:TemplateField SortExpression="usermain" HeaderText="管理员">
                <ItemTemplate>
                     <asp:Label ID="Lblusermain" runat="server" Text='<%# Bind("usermain") %>'></asp:Label>
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
                        <th scope="col">用户编号</th>
                        <th scope="col">用户名称</th>
                        <th scope="col">管理员</th>
                      
                        </tr>
                      <tr  bgcolor="White">
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>

                        </table>
                </EmptyDataTemplate>
            </asp:GridView>
              <asp:HiddenField ID="HFID" runat="server" />
            <asp:HiddenField ID="HFName" runat="server" />
           <asp:HiddenField ID="HFSupplyerID" runat="server" />
            
           <asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="ddl_cgnew" SelectMethod="CG_Getselectuser" >
               <SelectParameters>
                   <asp:Parameter DefaultValue="code" Name="type" Type="String" />
                   <asp:Parameter DefaultValue="" Name="userid" Type="String" />
               </SelectParameters>
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



