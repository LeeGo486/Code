<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_ShowModel, App_Web_fp_showmodel.aspx.a918743" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>选择</title>
          <link  href="../css/project.css" type="text/css"  rel="stylesheet">
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
        &nbsp;<asp:Button ID="BtnSave" Width="100px" runat="server" Text="确  定" CssClass="btn" OnClick="BtnSubmit_Click" OnClientClick="return bt_return()" />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退  出" CssClass="btn"   OnClientClick="bt_close_onclick()" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
       
    <table width="100%">
    <tr>
    <td>

    </td>
    </tr>
    <tr>
    <td align="center">
      <div>
                 <asp:UpdatePanel ID="UpdatePanel1" runat="server" >
                             <ContentTemplate>
      <table width="98%">
       <tr>
                                    <td align="left">
                                        &nbsp;  
                                        双击可选中</td>
                                    </tr>
                                    <tr>
                                    <td align="center">
                                    <asp:Panel ID="Panel1" runat="server" Height="600px" Width="760px" ScrollBars="auto">
                                           
                         
                             
                                    <asp:Label ID="LblTitle" runat="server" ForeColor="Red"></asp:Label><br /><asp:Label ID="LblAlart" runat="server" ForeColor="Red"></asp:Label>
                                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" Width="100%"  CssClass="tbGrid" CellSpacing="1" 
                                            AutoGenerateColumns="False" DataKeyNames="modelid"  CellPadding="4"  BorderWidth="1px" GridLines="None" ForeColor="#333333"  HorizontalAlign="Center" PageSize="5" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataSourceID="ObjectDataSource1" AllowPaging="True">
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
                                              <asp:TemplateField HeaderText="方案编号">

<ItemTemplate>
                    <asp:Label ID="Lblmodelid" runat="server" Text='<%# Bind("modelid") %>'></asp:Label>
                
</ItemTemplate>

</asp:TemplateField>

<asp:TemplateField SortExpression="modelcode" HeaderText="方案代码">
<ItemTemplate>
   <asp:Label ID="Lblmodelcode" runat="server" Text='<%# Bind("modelcode") %>'></asp:Label>            
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="modelname" HeaderText="方案名称">
<ItemTemplate>
                    <asp:Label ID="Lblmodelname" runat="server" Text='<%# Bind("modelname") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="Commet" HeaderText="备注">
<ItemTemplate>
    <asp:Label ID="Label10" runat="server" Text='<%# Bind("Commet") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField  HeaderText="查看" >
                   <ItemTemplate>
                      <asp:LinkButton id="LinkBtnChange" CommandArgument='<%# Bind("modelcode") %>' runat="server" Text="查看题目" CausesValidation="false" CommandName="" OnClick="LinkBtnChange_Click" ></asp:LinkButton>
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
			                                        <tr class="header">
				                                        <th scope="col">&nbsp;</th>
				                                        <th scope="col"><a href="#" >方案编号</a></th>
				                                        <th scope="col"><a href="#" >方案代码</a></th>
				                                         <th scope="col"><a href="#" >备注</a></th>
			                                        </tr>
			                                        <tr >
				                                        <td></td>
				                                        <td></td>
				                                        <td></td>
				                                        <td></td>
			                                        </tr>
			
		                                            </table>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                          <asp:HiddenField ID="HFID" runat="server" />
                                        <asp:HiddenField ID="HFName" runat="server" />
        
                                        
                                       <asp:ObjectDataSource id="ObjectDataSource1" runat="server" TypeName="ddl_FindProduct" SelectMethod="DC_GetModelMain" >
                                            </asp:ObjectDataSource>
                                        
                                 <asp:Panel ID="Panel2" runat="server" Height="400px" Width="760px" ScrollBars="auto">
                                <table width="100%">
                                <tr>
                                <td align="left">
                                <!--cont-->
                                 <asp:DataList ID="DataListTitle" ShowHeader="true" runat="server" OnItemDataBound="DataListTitle_ItemDataBound" Width="700px" CssClass="BContent" Height="100%">
      <HeaderTemplate>
      调查内容:
      </HeaderTemplate>
      <ItemTemplate>
      <table>
      <tr>
      <td style="height: 64px">
      <!--title----->
      <table  Width="700px">
          
      <tr>
      <td align="left"><asp:HiddenField ID="HFmodelsubid" runat="server" Value='<%# Eval("ModelSubid")%>' /><strong> <%# (Container.ItemIndex+1)%>.<%# Eval("ModelSubname")%> (分值系数:<%# Eval("ModelNum")%> )</strong></td>
       <td  align="right"></td>
      </tr>
      </table>
      <!--title end-->
      </td>
      </tr>
      <tr>
          <td align="left">
           <table>
          <tr> <td align="left">
            <asp:DataList ID="DataListAnwser" runat="server" RepeatDirection="horizontal" CellPadding="5">
             <ItemTemplate>
         
         
          <%# Eval("AnswerNo")%>. <%# Eval("AnswerName")%>&nbsp;&nbsp;&nbsp;(分数:<%# Eval("AnswerScore")%>)
          
          
           </ItemTemplate>
           
            </asp:DataList></td></tr>
          </table>
          </td>
      </tr>
      </table>
      </ItemTemplate>
        </asp:DataList>
                                <!--coneend-->
                                </td>
                                </tr>
                                </table>
                                 </asp:Panel>
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
                                    </ContentTemplate>
                                    
                                </asp:UpdatePanel>
       
    </div>
    </td>
    </tr>
    </table>
       
  
    </form>
</body>
</html>

