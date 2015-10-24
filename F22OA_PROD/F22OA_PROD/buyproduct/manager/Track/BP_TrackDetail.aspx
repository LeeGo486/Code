<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Track_BP_TrackDetail, App_Web_bp_trackdetail.aspx.40cff5d2" %>
<%@   OutputCache   Duration="1"   VaryByParam="none"   %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>物料分配审核</title>
    <base target="_self" />
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
    <script language="javascript" type="text/javascript" src="../../../js/check.js"></script>
           <script language="javascript" type="text/javascript">
           function GoUrlShowAddTrack(pid) 
           {
		      var url="BP_PublishSuperList.aspx?SupmaterID="+pid
	          LoadWindow(url,860,653);
	       }
            </script>
            <script type="text/javascript">
     function bt_close_onclick()
 {
        window.dialogArguments.location = window.dialogArguments.location;
         window.close();
  
 }
 function bt_return()
     {
        
        window.returnValue="0";
         window.close();
     }
          function showDiv(z){
var z;
var s=document.getElementById("input_"+z)
	if(s.style.display=="none"){
		s.style.display="block"
	}else{
		s.style.display="none"
	}
}
    </script>
         
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
      <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">跟进的采购物料流程</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退  出" CssClass="btn" OnClientClick="bt_close_onclick()" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
   
          <asp:HiddenField ID="HFSupmaterID" runat="server" /><asp:HiddenField ID="HFSupplyerID" runat="server" />
    <div  class="BContent">
     <!----contant------------------>
    <table width="100%">
     <tr>
               <td align="right" colspan="5">
                   &nbsp;
                   &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                   &nbsp;&nbsp;&nbsp;
               </td>
        </tr>
    <tr>
<td>
    <asp:Panel ID="Panel1" runat="server" Visible="false">
   <table>
   <tr>
   <td align="center" colspan="5">
   <asp:Label ID="LblTitle" runat="server"   Text=""></asp:Label>
   </td>
   </tr>
     <tr>
            <td align="left">
                备注:</td>
            <td align="left" colspan="4">
                <asp:TextBox ID="TxtComment" runat="server" Width="646px" Height="50px" TextMode="MultiLine"></asp:TextBox></td>
        </tr>
          <tr>
            <td align="left">
                该阶段已完成:</td>
            <td align="left" colspan="4">
                <asp:CheckBox ID="ChkBoxState" runat="server" Enabled="False" /></td>
        </tr>
         <tr>
             <td align="center" colspan="5">
                <asp:Button ID="BtnSubmit" runat="server" Text="更新追踪单" Width="116px" OnClick="BtnSubmit_Click" /></td>
        </tr>
   </table>
        <asp:HiddenField ID="HFTrackBuySubID" runat="server" />
        <asp:HiddenField ID="HFFinishState" runat="server" />
    </asp:Panel>
</td>
</tr>
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td>
        超时为红色<span style="background-color:Red" ><font color="red"> 超时为红色</font></span>，不超时为绿色<span style="background-color:green" ><font color="green"> 超时为绿色</font></span>(选中其中行可以编辑)</td>
    </tr>
    <tr>
    <td align="left">
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="TrackSubID"  CssClass="tbGrid" CellSpacing="1"  
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="100%" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
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
<asp:BoundField DataField="TrackSubID" HeaderText="TrackSubID" SortExpression="TrackSubID"  HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden" FooterStyle-CssClass="hidden" />
<asp:BoundField DataField="TrackIndex" HeaderText="顺序" SortExpression="TrackIndex" ReadOnly="true"  />
<asp:BoundField DataField="TrackName" HeaderText="进阶名称" SortExpression="TrackName" ReadOnly="true"  />
<asp:BoundField DataField="TrackTime" HeaderText="所需时间/天" SortExpression="TrackTime"  ReadOnly="true"  />
<asp:BoundField DataField="StartDate" HeaderText="开始时间" SortExpression="StartDate" HtmlEncode="false" DataFormatString="{0:d}" ReadOnly="true"  />
<asp:BoundField DataField="EndDate" HeaderText="结束时间" SortExpression="EndDate" ReadOnly="true"  />

<asp:TemplateField SortExpression="ChkState" HeaderText="是否完成">
                        <ItemTemplate>
                     <asp:CheckBox ID="CheckBoxChkState" runat="server" Checked='<%# DataBinder.Eval(Container.DataItem,"ChkState").ToString().ToLower()=="true"?true:false %>' Enabled="false" />                     
                        </ItemTemplate>
                     </asp:TemplateField>
                     
<asp:TemplateField SortExpression="TrackComment" HeaderText="备注">

<ItemTemplate>
                    <asp:Label ID="LblTrackComment" runat="server" Text='<%# GetLength(Eval("TrackComment").ToString(),10).ToString()%>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TrackComment" HeaderText="备注">

<ItemTemplate>
                    <asp:Label ID="LblTrackComment2" runat="server" Text='<%# Eval("TrackComment").ToString()%>'></asp:Label>
                
</ItemTemplate>
  <HeaderStyle CssClass="hidden" />
                      <ItemStyle CssClass="hidden" />
                      <FooterStyle CssClass="hidden" />
</asp:TemplateField>
<asp:BoundField DataField="Writename" HeaderText="跟进人" SortExpression="Writename" ReadOnly="true"  />
<asp:BoundField DataField="Writedate" HeaderText="完成时间" SortExpression="Writedate" HtmlEncode="false" DataFormatString="{0:d}" ReadOnly="true"  />

            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="0" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                     <tr  Class="dgHeader" >
                       <th scope="col">进阶编号</th>
			           <th scope="col">进阶名称</th>
			           <th scope="col">完成所需时间/天</th>
			           <th scope="col">备注</th>
                    </tr>
                         <tr  bgcolor="White">
                      
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>
                  
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        &nbsp;<asp:ObjectDataSource ID="ObjectDataSource1" runat="server" 
             SelectMethod="CG_GetTrackSub" TypeName="ddl_cgnew">
            
            <SelectParameters>
                <asp:ControlParameter ControlID="HFSupmaterID" DefaultValue="0" Name="SupmaterID"
                    PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </td>
    </tr>
        <tr>
    <td>
    <table width="100%">
        <tr>
         <td valign="top">
          </td>
   
    </tr>
    </table>
    </td>
    </tr>
    <tr>
    <td><a href="#" title="查看合同上部内容"  onClick='showDiv(1)' id="ShowDivLink"><img src="../../../icon/go3.gif" border="0" />查看历史留言内容</a></td>
    </tr>
     <tr>
   <td>
  <table width="100%">
  <tr>
  <td><div id="input_1" style="display:none;">
   <table width="100%"  class="tbBluebd"   style="height:100%">
   <tr>
   <td>
   <!----contant histrory------------------>
    
   <table width="100%">
   <tr>
   <td style="width:100%"> 
     <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" ToolTip="跟进交谈记录"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SupMsgID"   CssClass="tbGrid" CellSpacing="1" 
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="98%" CaptionAlign="Left" >
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                    <asp:TemplateField HeaderText="内容" SortExpression="Content">
                        <ItemTemplate>
                          <asp:Image ID="imgnew" runat="server" ImageUrl="../../../icon/new.gif" Visible="false"  />
                              <asp:Label ID="Lblmsgnum" runat="server" Text='<%# Eval("Content").ToString()%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="发送者" SortExpression="msgnum">
                        <ItemTemplate>
                              <asp:Label ID="LblUser" runat="server" Text='<%# Eval("fromuserid").ToString()=="采购方"?"(采购方)"+Eval("aduser").ToString():Eval("fromuserid").ToString()%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                  <asp:BoundField DataField="Crdate" HeaderText="发送时间" SortExpression="Crdate" /> 
                  <asp:BoundField DataField="fromuserid" HeaderText="发送者" SortExpression="fromuserid">
                      <ItemStyle CssClass="hidden" />
                      <HeaderStyle CssClass="hidden" />
                  </asp:BoundField>
                  <asp:TemplateField HeaderText="是否已阅" SortExpression="toread">
                        <ItemTemplate>
                            <asp:Label ID="Lblmsgnew" runat="server" Text='<%# Eval("toread").ToString()%>'></asp:Label>
                        </ItemTemplate>
                      <ItemStyle CssClass="hidden" />
                      <HeaderStyle CssClass="hidden" />
                    </asp:TemplateField>
                    
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" border="1" cellpadding="3" cellspacing="0" rules="cols"
                    style="background-color: White; border-color: #999999; border-width: 1px; border-style: None;
                    width: 100%; border-collapse: collapse;">
                     <tr  Class="dgHeader" >
                         <th scope="col">内容</th>
                            <th scope="col">发送者</th>
                            <th scope="col">发送时间</th>
                           
                    </tr>
                 
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle CssClass="header" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <HeaderStyle CssClass="dgHeader" HorizontalAlign="Center" VerticalAlign="Middle"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server"  SelectMethod="CG_GetTrackMsg" TypeName="ddl_cgnew"  >
            <SelectParameters>
                <asp:ControlParameter ControlID="HFSupmaterID" Name="SupmaterID" PropertyName="Value"
                    Type="Int32" />
            </SelectParameters>
           
        </asp:ObjectDataSource>
         &nbsp;
         </td>
         </tr>
         </table>
          
         </td>
        
         <!----contant histrory------------------>
   </tr>
   <tr>
   <td align="left">发送跟进留言</td>
   </tr>
    <tr>
   <td style="width: 100%">
   <!----contant submit------------------>
     <table width="100%">
     <tr>
     <td align="center">
         <asp:Label ID="LblAlart2" runat="server" ForeColor="Red"></asp:Label></td>
     </tr>
     <tr>
     <td style="height: 68px">
         <asp:TextBox ID="TxtContent" runat="server" CssClass="tbox" Width="98%" MaxLength="5000" TextMode="MultiLine" Height="120px"></asp:TextBox>
         </td>
     </tr>
     <tr>
     <td align="center"><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TxtContent"
        ErrorMessage="*信息内容不能为空" ValidationGroup="add"></asp:RequiredFieldValidator><asp:Label ID="Label2" runat="server" ForeColor="Red"></asp:Label>&nbsp;
       </td>
     </tr>
    <tr>
    <td align="center">    <asp:Button ID="Button1" runat="Server"  Text="提交"   CssClass="btn"  Width="100px" OnClick="BtnSubmit2_Click" /> </td>
    </tr>
    <tr>
    <td align="center">
    <asp:Label ID="Label3" runat="server" ForeColor="Red" Text=""></asp:Label>
    
    </td>
    </tr>
    </table>
    
    <!----contant submit end------------------>
    </td>
   </tr>
   </table>
  </div>
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


