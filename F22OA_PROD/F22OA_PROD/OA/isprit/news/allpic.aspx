<%@ page language="C#" autoeventwireup="true" inherits="isprit_news_allpic, App_Web_allpic.aspx.9a188d08" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    		<title>图片选择、浏览</title>
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET"/>
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<base target="_self"/>
    <script type="text/javascript" defer="defer">
			window.returnValue =document.all.hdPath.value
    </script>
		<SCRIPT language="JavaScript" type="text/javascript">
		
		function r(){
			//window.alert(document.all.tb.value)
			//window.close();
		}
	function onSubmit()
    {
        document.Form1.target="_self";
    }
		</SCRIPT>
</head>
<body  topmargin="0">
    <form id="form1" runat="server">
    <div>
    <table align="center" width="100%" border="0" >
				<tr>
					<td align="center" class="header"><asp:label id="lb" Font-Size="Medium" BackColor="Transparent" BorderColor="#aaaaaa" ForeColor="DarkOliveGreen" Runat="server" Font-Bold="True"></asp:label>
					</td>
				</tr>
				<tr>
					<td style="HEIGHT: 16px"><FONT face="宋体">
							<webdiyer:AspNetpager id="ap" runat="server" OnPageChanged="ap_PageChanged"></webdiyer:AspNetpager><a href=uploadpic.aspx >上传新闻图片</a></FONT></td>
				</tr>
				<tr>
					<td align="center">
						<asp:datagrid id="dg" runat="server" GridLines="None"  CssClass="tbGrid"  CellSpacing="1" 
							Width="100%" AutoGenerateColumns="False" ShowFooter="True" CellPadding="4" ForeColor="#333333"  OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated" OnSelectedIndexChanged="dg_SelectedIndexChanged">
							<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
							<Columns>
								<asp:TemplateColumn HeaderText="ID">
									<ItemTemplate>
										<asp:Label ID="lbid" Runat=server text='<%# DataBinder.Eval(Container, "DataItem.picid") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="图像">
									<ItemTemplate>
										<IMG  src='newspic/<%# DataBinder.Eval(Container, "DataItem.picURL") %>' width=80 border="1" id=img>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="文件名">
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.picURL") %>'>
										</asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="自定义图片名">
									<ItemTemplate>
										<asp:Label runat="server" ID="lbpic" text='<%# DataBinder.Eval(Container, "DataItem.pname") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="tbpic" MaxLength=40 Text='<%# DataBinder.Eval(Container, "DataItem.pname") %>' CssClass=textbox runat="server">
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:EditCommandColumn UpdateText="更新" CancelText="取消" EditText="编辑名称"></asp:EditCommandColumn>
								<asp:TemplateColumn HeaderText="删除">
									<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:imagebutton ID="imgDel" Runat="server" CausesValidation="False" ImageUrl="../icon/delete.gif"
											CommandName="delete"></asp:imagebutton>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="选择">
									<ItemTemplate>
										<asp:imagebutton ID="imgSelect" Runat="server" CausesValidation="False" ImageUrl="icon/save.gif"
											CommandName="select"></asp:imagebutton>
									</ItemTemplate>
								</asp:TemplateColumn>
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
							</Columns>
							<pagerStyle HorizontalAlign="Left" ForeColor="#000066" BackColor="White" Mode="NumericPages"></pagerStyle>
						</asp:datagrid>
						<asp:Button id="btdel" runat="server" Text="删除选定行" CssClass="btn" OnClick="btdel_Click"></asp:Button></td>
				</tr>
			</table>
			<BR>
			<input id="hdPath" type="hidden" name="hdPath" runat="server">
    </div>
    </form>
</body>
</html>
