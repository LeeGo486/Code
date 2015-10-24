<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_publish_BP_PublishAddSuper, App_Web_bp_publishaddsuper.aspx.874e4ad9" %>

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
					<span id="rm_MainPanel_lFunctionName">新增报价供应商</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="确  定" CssClass="btn" OnClick="BtnSubmit_Click" />
      <asp:Button ID="BtnClose" Width="100px" runat="server" Text="退 出" CssClass="btn"  OnClientClick="bt_close_onclick()" />
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
                 <asp:Label ID="LblT2" runat="server" Text="应用类型:" ></asp:Label>
                 <asp:RadioButton ID="RBtnone" runat="server" GroupName="Type" Text="仅应用该物料" Checked="True"  />
                 <asp:RadioButton ID="RBtnpart" runat="server" GroupName="Type" Text="应用所有尚分配的物料" />
                 <asp:RadioButton ID="RBtnall" runat="server" GroupName="Type" Text="应用所有物料"   /></td>
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
       
                
      <table width="100%">
      <tr>
      <td align="center">
          <asp:HiddenField ID="HFType" runat="server" /> 
          <asp:HiddenField ID="HFFirst" runat="server" />
           <asp:HiddenField ID="HFSecond" runat="server" />
          <asp:HiddenField ID="HFPublishCode" runat="server" />
          <asp:HiddenField ID="HFMaterID" runat="server" />
          <asp:Label ID="LblShow" runat="server" ForeColor="Red"></asp:Label>
          <asp:UpdateProgress ID="UpdateProgress1" runat="server">
			<ProgressTemplate>
				<div id="modalBackground"></div>
				<div id="animationDialog">
					<img  src="../../../icon/loading.gif" alt="Loading" />
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
                                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" Width="100%" 
                                            AutoGenerateColumns="False" DataKeyNames="LoginID"  CellPadding="3"   CssClass="tbGrid" CellSpacing="1" 
                                             BorderWidth="1" GridLines="None" ForeColor="#333333"  HorizontalAlign="Center" PageSize="500" AllowPaging="True">
                                            <Columns>
                                                 <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall"  OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="选择" />
                        </HeaderTemplate>
                        <ItemTemplate><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                             <asp:BoundField DataField="SupplyNo" HeaderText="供应商编号" SortExpression="SupplyNo" />

                               <asp:BoundField DataField="CompayName" HeaderText="公司名称" SortExpression="CompayName" />
                               <asp:BoundField DataField="Type" HeaderText="类型" SortExpression="Type" />
                               <asp:BoundField DataField="Calss" HeaderText="级别" SortExpression="Calss" />
                               <asp:BoundField DataField="Givenum" HeaderText="已供次数" SortExpression="Givenum" />
                                             
                                            </Columns>
                                            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                            <PagerStyle CssClass="header" HorizontalAlign="Center" />
                                            <HeaderStyle  CssClass="dgHeader"   HorizontalAlign="Center"  />
                                            <AlternatingRowStyle BackColor="White" />
                                            <EditRowStyle BackColor="#2461BF" />
                                              <EmptyDataTemplate>
                                               <table id="GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                                                        class="tbGrid" width="100%">
			                                        <tr  Class="dgHeader" >
				                                        <th scope="col">供应商编号</th>
                                                        <th scope="col">公司名称</th>
                                                        <th scope="col">类型</th>
                                                        <th scope="col">级别</th>
                                                        <th scope="col">已供次数</th>
			                                        </tr>
			                                        <tr  bgcolor="White">
                                                         <th scope="col">&nbsp;</th>
                                                         <th scope="col"> &nbsp;</th>
                                                         <th scope="col"> &nbsp;</th>
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
                                         <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="CG_GetSuperModel"
                                            TypeName="ddl_cgnew">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="0" Name="Type" Type="String" />
                                                <asp:Parameter DefaultValue="0" Name="DL" Type="String" />
                                                <asp:Parameter DefaultValue="" Name="Depth" Type="int16" />
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

