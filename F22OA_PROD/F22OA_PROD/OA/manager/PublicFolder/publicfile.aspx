<%@ page language="C#" autoeventwireup="true" inherits="manager_PublicFolder_publicfile, App_Web_publicfile.aspx.f55e7b9c" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>图片选择、浏览</title>

		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<base target="_self">
		<script>
		//清除用户 
		function clear_user() { document.all.TO_NAME.value=""; 
		document.all.TO_ID.value=""; } //选择用户 
		</script>
</head>
<body  leftMargin="1" topMargin="1" >
    <form id="form1" runat="server">

    <div class=content><h2><strong>公共文件管理</strong></h2></div>
    <div>
    <table align="center" width="100%">
			
				<tr>
					<td style="HEIGHT: 16px">
						<asp:DropDownList id="ddlsort" runat="server" Width="128px" CssClass="btn"></asp:DropDownList>
						<asp:Button id="btsearch" runat="server" CssClass="btn" Text="查询" OnClick="btsearch_Click"></asp:Button>
						<asp:Button id="btseto" runat="server" Text="文件归类(S)" CssClass="btn" OnClick="btseto_Click"></asp:Button>
						<INPUT class="btn" type="button" value="上传" onclick="LoadClass('MANAGER/publicfolder/uploadfile.aspx','公共文件上传');">
						<asp:Button id="btdel" accessKey="d" runat="server" CssClass="btn" Text="删除(D)" OnClick="btdel_Click"></asp:Button>
						<a href="folder_mng.aspx" target="_self" class="ddl">设置文件类别</a></td>
				</tr>
				<tr>
					<td>
					<div id="jstable">
					<asp:datagrid id="dg" runat="server" AutoGenerateColumns="False" CellPadding="3" BorderWidth="1px"
							BorderStyle="None" Width="100%" BackColor="White" BorderColor="#CCCCCC" OnItemCommand="dg_ItemCommand" OnItemCreated="dg_ItemCreated">
							<FooterStyle ForeColor="#000066" BackColor="White"></FooterStyle>
							<SelectedItemStyle Font-Bold="True" ></SelectedItemStyle>
							<ItemStyle HorizontalAlign="Center" ForeColor="#000066"></ItemStyle>
							<HeaderStyle Font-Bold="True" HorizontalAlign="Center" ForeColor="White" BackColor="#006699"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
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
										<a  href='../../file/PublicFile/<%# DataBinder.Eval(Container, "DataItem.filename") %>'>
											<asp:Label ID=lbfilename runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.filename") %>'>
											</asp:Label>
										</a>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderText="注释">
									<ItemTemplate>
										<asp:Label runat="server" ID="lbpic" text='<%# DataBinder.Eval(Container, "DataItem.remark") %>'>
										</asp:Label>
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="tbpic" MaxLength=40 Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' CssClass=textbox runat="server">
										</asp:TextBox>
									</EditItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="foldername" ReadOnly="True" HeaderText="类别"></asp:BoundColumn>
								<asp:EditCommandColumn ButtonType="LinkButton" UpdateText="更新" CancelText="取消" EditText="编辑注释"></asp:EditCommandColumn>
								<asp:ButtonColumn Text="访问权限" CommandName="Select"></asp:ButtonColumn>
							</Columns>
							<pagerStyle HorizontalAlign="Left" ForeColor="#000066" BackColor="White" Mode="NumericPages"></pagerStyle>
						</asp:datagrid>
					</div>
					</td>
				</tr>
				<tr>
					<td class="tip" align="center">
					<ol>
					<li>设置下载权限，请先点击右边的“访问权限”</li>
					<li>如果你不选择任何用户，则所有用户都不能访问此文件（管理员除外）</li>
					</ol>
					
					</td>
				</tr>
				<tr>
					<td style="HEIGHT: 54px" align="center">
						<table>
							<tr>
								<td class="tip" style="WIDTH: 98px" rowSpan="3">设定可以下载的用户</td>
								<td style="WIDTH: 306px" rowSpan="3">
								<INPUT id="TO_ID" type="hidden" name="TO_ID" runat="server">
								<TEXTAREA class="BigStatic" id="TO_NAME" style="WIDTH: 360px; HEIGHT: 96px; BACKGROUND-COLOR: lightgrey" name="TO_NAME" rows="6" readOnly wrap="soft" cols="42" runat="server"></TEXTAREA></td>
								<td>
								<INPUT class="btn" onclick="LoadWindow('../../isprit/module/selectpeople.aspx',405,480,this.value,true,'50%')"
								 type="button" value="选择用户"></td>
							</tr>
							<tr>
								<td style="HEIGHT: 5px"><INPUT class="btn" title="清空收件人" onclick="clear_user()"
										type="button" value="清空" name="button"></td>
							</tr>
							<tr>
								<td><asp:button id="btset" runat="server" BackColor="#FFFFC0" CssClass="btn" Text="设定" OnClick="btset_Click"></asp:button></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td align="center"><webdiyer:aspnetpager id="ap" runat="server" AlwaysShow="True" SubmitButtonClass="bt" SubmitButtonStyle="bt"
							SubmitButtonText="转到" ShowInputBox="Always" OnPageChanged="ap_PageChanged"></webdiyer:aspnetpager>
						<asp:label id="lbmemo" runat="server" ForeColor="Red"></asp:label><A  href="javascript:history.go(-1)">返回</A></td>
				</tr>
			</table>
			<BR>
			<input id="hdPath" type="hidden" name="hdPath" runat="server">
    </div>
    <script type="text/javascript" defer="defer">
    
    	jsTable('jstable','tm','96%','60|40','center');
    </script>
    </form>
</body>
</html>
