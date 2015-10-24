<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_Track_BP_TrackDetailHave, App_Web_bp_trackdetailhave.aspx.40cff5d2" %>

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
    </script>
     <style>
*{
font-size:12px;
}
#errTable{
border:solid 1px #999999;
background:#FFFFFF;
position:absolute; top:-4px;left:-4px;
}
#errShowDown{
background:#CCCCCC;
position:relative;
width:500px;
height:120px;
}
#errTitle{
background:#ff8a01;color:white;font-weight:bold;
text-align:center
}
#showDetail{
color:#666666;
padding:5px;
}
#showSpan{
font-family:Webdings;
}
#sdlink{
border:solid 1px #ffd099;
background:#fff7ee;
text-decoration:none;color:black;
display:block;width:99%;
margin-top:10px;
}
#sdlink:hover{
border:solid 1px #65bcff;
background:#e5f1ff;
}
</style>        
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

      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退  出" CssClass="btn" OnClientClick="bt_close_onclick" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

          <asp:HiddenField ID="HFSupmaterID" runat="server" />
    <div  class="BContent">
     <!----contant------------------>
    <table width="100%">
  
   
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td>
        超时为红色<span style="background-color:Red" ><font color="red"> 超时为红色</font></span>，不超时为绿色<span style="background-color:green" ><font color="green"> 超时为绿色</font></span>(选中其中行查看明细)</td>
    </tr>
    <tr>
    <td align="left">
      <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="TrackSubID"   CssClass="tbGrid" CellSpacing="1" 
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
<asp:BoundField DataField="EndDate" HeaderText="结束时间" SortExpression="EndDate" HtmlEncode="false" DataFormatString="{0:d}" ReadOnly="true"  />

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
    <asp:Panel ID="Panel1" runat="server" Visible="false">
   <table width="100%">
   <tr>
   <td align="center" colspan="5">
   
   </td>
   
   </tr>
   <tr>
   <td colspan="5">
       <a href="#" onfocus="this.blur()" id="sdlink" runat="server"  >
       &nbsp;<span id="showSpan">4</span><asp:Label ID="LblTitle" runat="server"   Text=""></asp:Label>详细内容<div id="showDetail" >备注:<asp:Label ID="LblDetail" runat="server" Text="" ></asp:Label></div></a>
   </td>
   </tr>
     
   </table>
        <asp:HiddenField ID="HFTrackBuySubID" runat="server" />
        <asp:HiddenField ID="HFFinishState" runat="server" />
    </asp:Panel>
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


