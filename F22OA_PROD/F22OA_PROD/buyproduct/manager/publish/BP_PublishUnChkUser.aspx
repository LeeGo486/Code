<%@ page language="C#" autoeventwireup="true" inherits="buyproduct_manager_publish_BP_PublishUnChkUser, App_Web_bp_publishunchkuser.aspx.874e4ad9" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>公司联系方式</title>
    <link  href="../../../css/project.css"type="text/css"  rel="stylesheet">
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
     <!--head-->
         <TABLE class="tbTitle" cellSpacing="0" cellPadding="0" border="0">
			<TR>
				<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
					<span id="rm_MainPanel_lFunctionName">采购发布申请</span>&nbsp;&nbsp;&nbsp;
					
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

      <asp:Button ID="BtnGo" Width="100px" runat="server" Text="新增发布" CssClass="btn"   OnClientClick="window.location.href='BP_PublishAdd.aspx'; return false;"   />
      <asp:Button ID="BtnDel" Width="100px" runat="server" Text="删除所选" CssClass="btn" OnClick="btnDel_Click" />
     </div>  
        </td> 
    </tr>
    </table>
    <!--menu----->

        
    <div  class="BContent">
     <!----contant------------------>
    <table width="100%">
    <tr>
    <td align="center">
        <asp:Label ID="LblAlart" runat="server" ForeColor="Red" Text=""></asp:Label></td>
    </tr>
    <tr>
    <td align="left">
                  <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" DataKeyNames="PublishID" DataSourceID="ObjectDataSource1"    CssClass="tbGrid" CellSpacing="1" 
                HorizontalAlign="Center"   CellPadding="3" ForeColor="#333333" GridLines="None" Width="100%">
                <Columns>
                  
                    <asp:TemplateField HeaderText="选择" >
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="ckbSelectall" OnCheckedChanged="ckbSelectall_CheckedChanged" AutoPostBack="true" Text="" />
                        </HeaderTemplate>
                        <ItemTemplate ><asp:CheckBox runat="server" ID="ckbDel"  /></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PublishID" HeaderText="PublishID" ReadOnly="True" SortExpression="PublishID" Visible="false" />
                    <asp:BoundField DataField="PublishCode" HeaderText="发布编号" SortExpression="PublishCode" />
                     <asp:BoundField DataField="maternum" HeaderText="物料种数" SortExpression="maternum" />
                    <asp:BoundField DataField="PStartDate" HeaderText="发布日期" SortExpression="PStartDate" DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="PEndDate" HeaderText="结束日期" SortExpression="PEndDate" DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="CrDate" HeaderText="建立日期" SortExpression="CrDate"  DataFormatString="{0:d}" HtmlEncode="false" />
                    <asp:BoundField DataField="CrUser" HeaderText="申请人" SortExpression="CrUser" />
                     <asp:TemplateField HeaderText="状态" SortExpression="ChkState">
                   
                        <ItemTemplate>
                            <asp:Label ID="LabelState" runat="server" Text='<%# Eval("ChkState").ToString()=="0"?"未审":"未通过"%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="操作">
                        <ItemTemplate>
                            <a href="BP_PublishEdit.aspx?pid=<%#Eval("PublishCode") %>"><img src="../../../icon/go3.gif" border="0" />修改</a>
              
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
                 <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#EFF3FB" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <PagerStyle  CssClass="header"  HorizontalAlign="Center" />
                <HeaderStyle  CssClass="dgHeader"   HorizontalAlign="Center" VerticalAlign="Middle" font-size=9pt  />
                <AlternatingRowStyle BackColor="White" />
                <EmptyDataTemplate>
                      <table id="GridViewf"  cellpadding="3" cellspacing="1" rules="cols"
                     class="tbGrid" width="100%">
                    <tr  Class="dgHeader" >
                            <th scope="col">发布编号</th>
                            <th scope="col">物料种数</th>
                            <th scope="col">发布日期</th>
                            <th scope="col">结束日期</th>
                            <th scope="col">建立日期</th>
                            <th scope="col">申请人</th>
 
                        </tr>
                        <tr  bgcolor="White">
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                         <th scope="col"> &nbsp;</th>
                    </tr>
                      </table>
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="ddl_cgnew" SelectMethod="CG_GetPublishListUnchkNoPass">
              
            </asp:ObjectDataSource>
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
