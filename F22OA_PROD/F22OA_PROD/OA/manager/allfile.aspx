<%@ page language="C#" autoeventwireup="true" inherits="manager_allfile, App_Web_allfile.aspx.3665c05a" %>

<%@ Register Src="../../inc/uc_pagehead.ascx" TagName="uc_pagehead" TagPrefix="uc1" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>文件选择、浏览</title>
		<LINK href="../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../js/project.js" type="text/javascript"></script>
		<base target="_self" />
</head>
<body  topMargin="1" leftmargin="1" rightmargin="0">
    <form id="form1" runat="server">
    <div><uc1:uc_pagehead id="Uc_pagehead1" runat="server" />
     <div class=content>
		        <h2><strong>
                    
                   </strong></h2>
		    </div>
		  <div >
		        						关键字:
						<asp:TextBox id="tbsearch" runat="server" nullable="n" cname="关键字:" tooltip="可以输入文件名，上传者姓名等"></asp:TextBox>
						<asp:ImageButton id="imbSearch" runat="server" ImageUrl="../icon/search.gif"></asp:ImageButton>&nbsp;
		    </div>
			<table align="center" width="100%">
			
				<tr>
					<td>
						<asp:datagrid id="dg" runat="server" GridLines="None" Width="100%" BorderStyle="None"
							CssClass="tbGrid"  CellSpacing="1"  CellPadding="3" AutoGenerateColumns="False" ShowFooter="True" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
						<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle HorizontalAlign="Left" Width="50px"></HeaderStyle>
									<HeaderTemplate>
										<asp:CheckBox id="chkAll1" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选"></asp:CheckBox>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="cb" runat="server" BorderColor="Silver" BorderWidth="0px"></asp:CheckBox>
									</ItemTemplate>
									<FooterTemplate>
										<asp:CheckBox id="chkAll" runat="server" BorderColor="Silver" BorderWidth="0px" Text="全选"></asp:CheckBox>
									</FooterTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="ID">
									<ItemTemplate>
										<asp:Label ID="lbid" Runat=server text='<%# DataBinder.Eval(Container, "DataItem.fileid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="文件名">
									<ItemTemplate>
										<a  href='../isprit/Module/openfile.aspx?url=../../file/<%# Server.UrlEncode((String)DataBinder.Eval(Container, "DataItem.filename")) %>' target=_blank>
											<asp:label ID=lbtext Runat=server text='<%# DataBinder.Eval(Container, "DataItem.filename") %>'>
											</asp:label>
										</a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="文件注释">
									<ItemTemplate>
										<asp:Label runat="server" ID="lbpic" text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="tbpic" MaxLength=40 Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' CssClass=textbox runat="server">
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="username" ReadOnly="True" HeaderText="上传者"></asp:BoundColumn>
								<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="更新" CancelText="取消" EditText="编辑名称"></asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:imagebutton ID="imgDel" Runat="server" CausesValidation="False" ImageUrl="icon/delete.gif" CommandName="delete"></asp:imagebutton>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Left" ForeColor="#000066" BackColor="White" Mode="NumericPages"></pagerStyle>
						</asp:datagrid>
							<webdiyer:AspNetpager id="ap" runat="server" ShowInputBox="Always" SubmitButtonText="转到" SubmitButtonStyle="bt"
								SubmitButtonClass="bt" PageSize="15" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager>
		    </td>
				</tr>
				<tr>
					<td align="left"><A href="javascript:history.go(-1)">返回</A>
                        &nbsp;<asp:Button id="btdel" runat="server" Text="删除所选的文件(D)" CssClass="btr" OnClick="btdel_Click"></asp:Button></td>
				</tr>
			</table>
			<BR>
			<input id="hdPath" type="hidden" name="hdPath" runat="server">
    </div>
    </form>
</body>
</html>
