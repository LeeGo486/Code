<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_publish_BP_PublishMaterModle, App_Web_bp_publishmatermodle.aspx.874e4ad9" %>

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
        
       
        //var values=window.document.getElementById("HFID").value;
        //debugger;
        //window.returnValue=values;
        //window.dialogArguments.location=window.dialogArguments.location;
        window.returnValue="0";
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
					<span id="rm_MainPanel_lFunctionName">选择物料</span>&nbsp;&nbsp;&nbsp;
					
				</TD>
				<TD class="tdTitle2"></TD>
				<TD class="tdTitle3">
                    <span id="rm_MainPanel_lPageNO"></span></TD>
			</TR>
	</TABLE>
    <!--head end-->
    <!--menu----->
   <table  width="98%">
    <tr>
    <td align="right">
    <div class="menu">

      <asp:Button ID="BtnSearch" Width="100px" runat="server" Text="查  询" CssClass="btn"  OnClick="BtnSearch_Click"     />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="确  定" CssClass="btn" OnClick="BtnSubmit_Click" />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退  出" CssClass="btn" OnClientClick="bt_close_onclick()" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

    <div>
    
<table cellspacing="0" cellpadding="0" width="100%" align="center">
						<tr>
							<td ></td>
							<td >

    <table id="table2" cellspacing="1" cellpadding="1" width="98%" border="1"  borderColor="#cccccc"  borderColorDark="#ffffff">
     <tr>
         <td colspan="2"  align="center">
             <asp:Label ID="LblAlart" runat="server" Text="" ForeColor="red"></asp:Label></td>
     </tr>
     <tr>
     <td>
         &nbsp;&nbsp;
     </td>
     <td >
      <asp:Label ID="Label1" runat="server" Text="编号名称:"></asp:Label>
                                        <asp:TextBox ID="TxtNum" runat="server"></asp:TextBox>
                                        <asp:RadioButton ID="RBtnNum" runat="server" GroupName="search" Text="物料编号" Checked="True" />
                                        <asp:RadioButton ID="RBtnCode" runat="server" GroupName="search" Text="物料名称" />&nbsp;
     </td>
     </tr>
     <tr>
      <td style="WIDTH: 168px" align="left" valign="top">
          &nbsp;
          <asp:TreeView ID="TreeView1" runat="server" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged" ShowLines="True" ToolTip="物料列表">
          </asp:TreeView>
       </td>
      <td>
       <table id="table3" cellspacing="1" cellpadding="1" width="100%" border="0">
        <tr>
         <td align="left">
         <!--midel-->
          <table width="100%">
                                   
                                    <tr>
                                    <td>
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                             <ContentTemplate>
                                    <asp:Label ID="LblTitle" runat="server" Width="600px" ForeColor="Red"></asp:Label>
                                    <asp:Panel ID="Panel1" runat="server"  Height="500px" Width="700px" ScrollBars="auto">
                                    
                                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" Width="100%" font-Size="10pt" 
                                            AutoGenerateColumns="False"  DataSourceID="ObjectDataSource1" DataKeyNames="flid" cellpadding="3" CssClass="tbGrid" CellSpacing="1" 
                                             GridLines="None" ForeColor="#333333"  HorizontalAlign="Center">
                                            <Columns>
                                           <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="选择" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                                                <asp:BoundField DataField="flid" HeaderText="物料编号" SortExpression="flid" />
                                                <asp:BoundField DataField="clname" HeaderText="物料名称" ReadOnly="True" SortExpression="clname" />
                                                <asp:BoundField DataField="modelid" HeaderText="规格编号" SortExpression="modelid" />
                                                <asp:BoundField DataField="colorid" HeaderText="颜色编号" SortExpression="colorid" />
                                                <asp:BoundField DataField="model" HeaderText="规格" SortExpression="model" />
                                                <asp:BoundField DataField="color" HeaderText="颜色" SortExpression="color"/>
                                                <asp:BoundField DataField="unit" HeaderText="单位" SortExpression="unit" />
                                                    <asp:BoundField DataField="cltype" HeaderText="物料类型" SortExpression="cltype" />
                                                    <asp:BoundField DataField="dl" HeaderText="大类" SortExpression="dl" />
                                                    <asp:BoundField DataField="xl" HeaderText="中类" SortExpression="xl"  >
                                                        <ItemStyle CssClass="hidden" />
                                                        <HeaderStyle CssClass="hidden" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="bz" HeaderText="小类" SortExpression="bz" >
                                                        <ItemStyle CssClass="hidden" />
                                                        <HeaderStyle CssClass="hidden" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="fl_picture" HeaderText="图片" SortExpression="fl_picture"  >
                                                        <ItemStyle CssClass="hidden" />
                                                        <HeaderStyle CssClass="hidden" />
                                                    </asp:BoundField>
                                                 
                                            </Columns>
                                            <FooterStyle  CssClass="header"  />
                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                                            <SelectedRowStyle BackColor="#D1DDF1" font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle  CssClass="header"  HorizontalAlign="Center" VerticalAlign="Middle"  />
                                            <HeaderStyle  CssClass="dgHeader"  HorizontalAlign="Center" VerticalAlign="Middle"  />
                                            <AlternatingRowStyle BackColor="White" />
                                            <EditRowStyle BackColor="#2461BF" />

                                            <EmptyDataTemplate>
                                                <table id="GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                                                     class="tbGrid" width="100%">
                                                    <tr  Class="dgHeader" >
				                                        
				                                        <th scope="col">物料编号</th>
				                                        <th scope="col">物料名称</th>
				                                        <th scope="col">规格编号</th>
				                                        <th scope="col">地区编号</th>
				                                        <th scope="col">颜色编号</th>
				                                        <th scope="col">规格</th>
				                                        <th scope="col">颜色</th>
			                                        </tr>
			                                          <tr  bgcolor="White">
				                                       
				                                        <td></td>
				                                        <td></td>
				                                        <td></td>
				                                        <td></td>
				                                        <td>&nbsp;</td>
				                                        <td >&nbsp;</td>
				                                        <td >&nbsp;</td>
			                                        </tr>
			
		                                            </table>
                                            </EmptyDataTemplate>
                                        </asp:GridView>
                                 </asp:Panel>
                                 &nbsp;
                                        <asp:HiddenField ID="HFPublishCode" runat="server" />
                                 &nbsp; &nbsp; &nbsp;
                                        
                                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="CG_GetMaterByTypeAll"
                                            TypeName="ddl_cgnew">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="intType"  Type="int16" />
                                                <asp:Parameter DefaultValue="-" Name="cltype" Type="String" />
                                                <asp:Parameter DefaultValue="-" Name="dl" Type="String" />
                                                <asp:Parameter DefaultValue="-" Name="xl" Type="String" />
                                                 <asp:Parameter DefaultValue="-" Name="bz" Type="String" />
                                                 <asp:Parameter DefaultValue="-" Name="strType" Type="String" />
                                                 <asp:Parameter DefaultValue="-" Name="Name" Type="String" />
                                            </SelectParameters>
                                        </asp:ObjectDataSource>
                                              </ContentTemplate>
                                </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr>
                                    <td align="center">
                                        &nbsp;</td>
                                    </tr>
                                    </table>
         <!--end midel-->
         
             </td>
        </tr>
       
       </table>
      </td>
     </tr>
     <tr>
      <td style="WIDTH: 168px"></td>
      <td></td>
     </tr>
    </table>
  


 
    </td>
				<td ></td>
						</tr>
					</table>
	            <table cellspacing="0" cellpadding="0" width="98%" align="center">
						<tr>
							<td ></td>
							<td ><font face="宋体"> </font></td>
							<td ></td>
						</tr>
					</table>

    </div>
    </form>
</body>
</html>
