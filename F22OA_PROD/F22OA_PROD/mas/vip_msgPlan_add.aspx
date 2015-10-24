<%@ page language="C#" autoeventwireup="true" inherits="vip_msgPlan_add, App_Web_vip_msgplan_add.aspx.e229d74e" %>

<%@ Register Src="../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>

<%@ Register Assembly="Infragistics2.WebUI.WebDateChooser.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>短信调查方案添加</title>
    <link  href="../css/project.css" type="text/css"  rel="stylesheet">
	<style type="text/css"> .ltd{ background:#D9E5F4; text-align:center;}</style>
		<script language="javascript" type="text/javascript" src="../js/select.js"></script>
		
</head>
<body  style="margin-left:5px; margin-right:5px;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <!--head-->
        <uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
                    
    <!--head end-->
    <!--menu----->
  
   <table  width="98%">
    <tr>   
        <td align="right">
        <asp:UpdatePanel ID="up2" runat="server"><ContentTemplate>
        <asp:Button ID="BtnSave" Width="100px" runat="server" Text="保 存" CssClass="btn" OnClick="BtnSave_onclick" />
        &nbsp; &nbsp;
        </ContentTemplate></asp:UpdatePanel>
        </td>
    </tr>
    </table>
    <!--menu----->
 
  
    <!----contant------------------>
    <table width="98%" >   
    <tr>
    <td align="left">
        <table  width="100%" >
         <colgroup>
            <col  width="60" />
            <col  align="left"  width="200" />           
        </colgroup>
        <tr>
        <td class="ltd"> 主      题:</td>
        <td align="left" colspan="4">
              <asp:TextBox ID="TxtTitle" runat="server" MaxLength="100" Width="95%" CssClass="tbox"></asp:TextBox>&nbsp;
              <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TxtTitle" ErrorMessage="*"></asp:RequiredFieldValidator>
        </td>
        </tr>
        <tr>
        <td class="ltd" style="height: 60px" > 内     容:</td>
        <td >
            <asp:TextBox ID="TxtContent" runat="server"   MaxLength="300" TextMode="MultiLine" Width="95%"  CssClass="tbox" Height="40px"></asp:TextBox>
        </td>
        </tr>    
        <tr>
        <td class="ltd" style="height: 20px" > 方案类别:</td>
        <td >
        
          <asp:DropDownList ID="drpType" Width="120"  runat="server"></asp:DropDownList></td>
        </tr>  
         <tr>
        <td class="ltd" style="height: 20px" > 自动运行:</td>
        <td >        
          <asp:DropDownList ID="drpAuto" Width="120"  runat="server"><asp:ListItem Text="否" Value="0"></asp:ListItem><asp:ListItem Text="是" Value="1"></asp:ListItem></asp:DropDownList>
          </td>
        </tr>                  
       <tr>
        <td class="ltd" style="height: 60px" > 回复选项:</td>
        <td >         
            <asp:UpdatePanel ID="UpdatePanel1" runat="server"><ContentTemplate>
             <div id="divItem" visible="false"  runat="server">
          <div>
           <asp:datagrid id="gv" runat="server" CssClass="tbGrid"  CellSpacing="1"  CellPadding="4" Width="100%" AllowCustomPaging="true"  AutoGenerateColumns="False"
							  GridLines="None" ForeColor="#333333" OnItemCommand="gv_ItemCommand" OnItemCreated="gv_ItemCreated" HorizontalAlign="Center">
						<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  ></HeaderStyle>
							<FooterStyle  Font-Bold="True" ></FooterStyle>
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
         <div>   编号：<asp:TextBox ID="txtNo" runat="server"  Width="20px" Text="1" ReadOnly="true" ></asp:TextBox>
                              
             &nbsp; 名称：<asp:TextBox ID="txtItem" runat="server"  Width="80px"  MaxLength="40" ></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="BtnAddItem" runat="Server" OnClick="BtnAddItem_Click" Text="添加回复选项"  CssClass="btn" CausesValidation="true" OnClientClick="javascript:var vitem=document.getElementById('txtItem').value.replace(/^\s+|\s+$/g,'');if(vitem.length==0){alert('请输入正确的选项名称') ;return false;}else{ return true;};" />
          </div>
         </div>
          <% if (!divItem.Visible)
            { %>
            <table width="100%"><tr style="font-weight:bold; background-color:#EFF3FB; text-align:center; height:20px;"><td>编号</td><td>名称</td><td>修改</td><td>删除</td></tr></table>
            <%} %>
             </ContentTemplate>
              <Triggers><asp:AsyncPostBackTrigger ControlID="BtnSave" /></Triggers>
             </asp:UpdatePanel>           
        </td>      
       </tr>
      </table>
     </td>
     </tr>
       
    </table>
    
    <!----contant end------------->
   
    </form>
</body>
</html>
