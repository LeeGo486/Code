<%@ page language="C#" autoeventwireup="true" inherits="vip_msgPlan_bw, App_Web_vip_msgplan_bw.aspx.e229d74e" %>

<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>调查项目模板管理</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
	<style type="text/css"> .ltd{ background:#D9E5F4;}</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
		
</head>
<body  topmargin="10" leftmargin="10">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <!--head-->
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
                    
    <!--head end-->
    <!--menu----->
    
  
    <!--menu----->
 
    <div  class="BContent"  style="height:100%">
    <!----contant------------------>
    <table width="100%" >   
    <tr>
    <td align="left">
        <table  width="100%"  >
         <colgroup>
            <col  width="60" />
            <col  align="left"  width="200" />           
        </colgroup>
        <tr>
        <td class="ltd"> 主题:</td>
        <td align="left" colspan="4">
              <asp:TextBox ID="TxtTitle" runat="server" MaxLength="100" Width="90%" CssClass="tbox"></asp:TextBox>&nbsp;
        </td>
        </tr>
        <tr>
        <td class="ltd" style="height: 60px" > 内容:</td>
        <td >
            <asp:TextBox ID="TxtContent" runat="server"   MaxLength="300" TextMode="MultiLine" Width="90%"  CssClass="tbox" Height="40px"></asp:TextBox>
        </td>
        </tr>             
       <tr>
        <td class="ltd" style="height: 60px" > 回复选项:</td>
        <td >
          <div id="divItem" >
            <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
          <div>
           <asp:datagrid id="gv" runat="server" CssClass="tbGrid"  CellSpacing="1"  CellPadding="4" Width="100%" AllowCustomPaging="true"  AutoGenerateColumns="False"
							  GridLines="None" ForeColor="#333333"  HorizontalAlign="Center">
						<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="gvHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="gvHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="编号">
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.itemid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="名称">
									<ItemTemplate>
										<asp:label ID=lb runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.item") %>'>
										</asp:label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:textbox ID="tb" CssClass="textbox" Width=120 runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.item") %>'>
										</asp:textbox>
										<asp:RequiredFieldValidator id="RFVmodelname" runat="server" ControlToValidate="tb" ErrorMessage="*" Display="Dynamic"></asp:RequiredFieldValidator>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn UpdateText="更新" HeaderText="修改" CancelText="取消" EditText="修改">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
								</asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
									<asp:ImageButton id="imbdel" runat="server" ImageUrl="../icon/delete.gif" CommandName="DELETE"></asp:ImageButton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Center" ForeColor="White" BackColor="#2461BF"></pagerStyle>
                            <EditItemStyle BackColor="#EFF3FB" />
						</asp:datagrid>           
         </div>         
             </ContentTemplate>             
             </asp:UpdatePanel>    

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
