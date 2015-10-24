<%@ page language="C#" autoeventwireup="true" inherits="FindProduct_FP_FindPublishchkDetail, App_Web_fp_findpublishchkdetail.aspx.a918743" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics2.WebUI.WebSchedule.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="ig_sched" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>发布申请维护明细</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">

		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
	<script type="text/javascript">
        var GB_ROOT_DIR = "../greybox/";
    </script>

    <script type="text/javascript" src="../greybox/AJS.js"></script>
    <script type="text/javascript" src="../greybox/AJS_fx.js"></script>
    <script type="text/javascript" src="../greybox/gb_scripts.js"></script>
   <link href="../greybox/gb_styles.css" rel="stylesheet" type="text/css" media="all" />

</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">发布申请审核</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="查看待审调查" CssClass="btn" CausesValidation="false"   OnClientClick="window.location.href='FP_FindPublishchk.aspx'; return false;"   />
      <asp:Button ID="BtnSave" Width="100px" runat="server" Text="审   核" CssClass="btn" OnClick="Savedata" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->
   
    <div  class="BContent"  style="height:100%">
        <!----contant------------------>
       <!----contant------------------>
    <table width="100%">
    <tr>
    <td>
    <table width="100%">
        <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="150" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
    <tr>
    <td>
        审核人:</td>
     <td>
         <asp:TextBox ID="TxtChkUser" runat="server" Width="200px" CssClass="tbox" MaxLength="50"></asp:TextBox></td>
     <td>
    </td>
     <td>
         审核时间:</td>
     <td>
      <igsch:WebDateChooser ID="WebDateChooserChkDate" runat="server" Value="" Width="200px">
            </igsch:WebDateChooser>
    </td>
    </tr>
      <tr>
    <td>
        批文:</td>
          <td colspan="4">
              <asp:TextBox ID="TxtChkCommet" runat="server" Width="95%" CssClass="tbox" MaxLength="100"></asp:TextBox></td>
    </tr>
    </table>
    </td>
    </tr>
      <tr>
    <td align="center"><asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td>
    <!--detail--->
    <table border="0" width="100%" class="BContent"  style="height:100%">
       <tr>
            <td align="center" style="height: 14px"><span style="font-size:14px"><strong> 款式调查发布申请单</strong></span>
        </td>
    </tr>
    <tr>
    <td>
    <hr />
    </td>
    </tr>
     <tr>
    <td align="left">
        <table  width="100%" >
             <colgroup>
                <col  width="60" />
                <col  align="left"  width="150" />
                <col   width="100" />
                 <col  width="60"  />
                <col  align="left" width="150"  />
                </colgroup>
           <tr>
        <td >
            调查主题:</td>
              <td align="left" colspan="4">
              <asp:Label ID="LblTitle" runat="server" Text=""></asp:Label>
                 &nbsp;</td>
        </tr>
          <tr>
             <tr>
        <td >
            调查内容:</td>
              <td align="left" colspan="4">
              <asp:Label ID="LblModelName" runat="server" Text=""></asp:Label>&nbsp; (<a  href="FP_ModelShow.aspx?modelcode=<%=HFModelCode.Value.ToString() %>" onclick=" return GB_showPage('调查题目', this.href)">查看调查题目</a>)<asp:HiddenField
                ID="HFModelCode" runat="server" />
            
            </td>
        </tr>       
        <tr>
        <td >
        单据编号:
        </td>
        <td >
        <asp:Label ID="LblBillNo" runat="server" Text=""></asp:Label>
          
            </td>
     <td >
        
        </td>
        <td>
        建立人:
        </td>
      
          <td >
          <asp:Label ID="LblCrUser" runat="server" Text=""></asp:Label>
              
              </td>
        </tr>
  
        
          <tr>
        <td >
            调查开始日期:</td>
        <td >
        <asp:Label ID="LblDateBegin" runat="server" Text=""></asp:Label>
       
            </td>
     <td >
        
        </td>
        <td>
            调查结束日期:
        </td>
      
          <td >
          <asp:Label ID="LblDateEnd" runat="server" Text=""></asp:Label>
              </td>
        </tr>
         <tr>
        <tr>
        <td style="height: 28px" >
          建立时间:</td>
        <td style="height: 28px;" >
        <asp:Label ID="LblCrdate" runat="server" Text=""></asp:Label>
          
        </td>
     <td style="height: 28px" >
        
        </td>
        <td style="height: 28px">
        </td>
      
          <td style="height: 28px" >
</td>
        </tr>
             <tr>
        <td style="height: 28px" >
          目的:</td>
        <td style="height: 28px;" colspan="4" >
        <asp:Label ID="LblCommet" runat="server" Text=""></asp:Label>
          
        </td>
        </tr>
        </table>
    </td>
    </tr>
    
        <tr>
    <td>
    <table width="100%">

        <tr>
    <td valign="top">
        <asp:GridView ID="GridViewShop" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SP_ID"  CssClass="tbGrid" CellSpacing="1"  
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="98%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="SP_ID" HeaderText="编号" InsertVisible="False" ReadOnly="True"  SortExpression="SP_ID"  >
                    <ItemStyle CssClass="hidden" />
                    <HeaderStyle CssClass="hidden" />
                    <FooterStyle CssClass="hidden" />
                </asp:BoundField>
                <asp:BoundField DataField="SP_ShopID" HeaderText="店铺编号" SortExpression="SP_ShopID" />
                <asp:BoundField DataField="SP_ShopName" HeaderText="店铺名称" SortExpression="SP_ShopName" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                            OnClientClick="return confirm('确认要删除此数据吗？')" Text="删除"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                     <tr  Class="dgHeader" >
                        <th scope="col">
                            店铺编号</th>
                        <th scope="col">
                            店铺名称</th>
                    </tr>
                      <tr style="color: White; font-weight: bold;" bgcolor="White" height="100">
                        <th scope="col">
                          &nbsp;  </th>
                        <th scope="col">
                            &nbsp;  </th>
 
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle   CssClass="header" />
            <HeaderStyle CssClass="dgHeader"  />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="DC_DelPublishShop" SelectMethod="DC_GetPublishShop" TypeName="ddl_FindProduct">
            <DeleteParameters>
                <asp:Parameter Name="SP_ID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="LblBillNo" Name="SY_BillCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
    </td>
    <td valign="top">
        <asp:GridView ID="GridViewStyle" runat="server" AllowPaging="True" AllowSorting="True" CssClass="tbGrid" CellSpacing="1"  
            AutoGenerateColumns="False" CellPadding="3" DataKeyNames="SY_ID" DataSourceID="ObjectDataSource2"
            ForeColor="#333333" GridLines="None" RowStyle-HorizontalAlign="Center" Width="98%">
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="SY_ID" HeaderText="编号" InsertVisible="False" ReadOnly="True"
                   ItemStyle-CssClass="hidden"  HeaderStyle-CssClass="hidden"  FooterStyle-CssClass="hidden" SortExpression="SY_ID" />
            
                <asp:BoundField DataField="SY_StyleNo" HeaderText="款式编号" SortExpression="SY_StyleNo" />
                <asp:BoundField DataField="SY_StyleName" HeaderText="款式名称" SortExpression="SY_StyleName" />
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                            OnClientClick="return confirm('确认要删除此数据吗？')" Text="删除"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
            <EmptyDataTemplate>
                <table id="ctl00_ctplhder_GridViewf" cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                    <tr Class="dgHeader" >
                        <th scope="col">
                            款式编号</th>
                        <th scope="col">
                            款式名称</th>
 
                    </tr>
                    <tr style="color: White; font-weight: bold;" bgcolor="White" height="100">
                        <th scope="col">
                          &nbsp;  </th>
                        <th scope="col">
                            &nbsp;  </th>
 
                    </tr>
                </table>
            </EmptyDataTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <PagerStyle   CssClass="header" />
            <HeaderStyle   CssClass="dgHeader" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView><asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="DC_DelPublishStyle"  SelectMethod="DC_GetPublishStyle" TypeName="ddl_FindProduct">
            <DeleteParameters>
                <asp:Parameter Name="SY_ID" Type="Int32" />
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="LblBillNo" Name="SY_BillCode" PropertyName="Text"
                    Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    
    </td>
    </tr>
    </table>
    </td>
    </tr>
    </table>
     <!--detail--->
    </td>
    </tr>
 
   
    </table>
    <!----contant end------------->
    </div>
    </form>
</body>
</html>
