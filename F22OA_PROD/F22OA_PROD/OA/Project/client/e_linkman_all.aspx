<%@ page language="C#" autoeventwireup="true" inherits="Project_client_e_linkman_all, App_Web_e_linkman_all.aspx.fc906236" %>
<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>所有联系人</title>
		<META http-equiv="Content-Type" content="text/html; charset=gb2312">
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body  topmargin="1" leftmargin="1" rightmargin="1">
    <form id="form1" runat="server">
    <div>
    <table width="100%" border="0" cellpadding="0" cellspacing="1">
				<tr>
					<td>
          <asp:Label ID="lbtip" Runat="server" Width="100%" CssClass="tip"></asp:Label>
						</td>
				</tr>
				<tr>
					<td>
					</td>
				</tr>
				<tr>
					<td>
        <div id="lrtable">
						<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="96%" >
							<TR>
								<TD style="text-align:left">
									<asp:button id="btdel" accessKey="d" runat="server" CssClass="btn" Text="删除(D)" OnClick="btdel_Click"></asp:button>
                <INPUT class="btn" id="btadd" accessKey="n" onclick="LoadClass('Project/client/e_linkman_add.aspx','新增联系人');" type="button" value="新建(N)" name="btadd">
									</TD>
							</TR>
						</TABLE>
        </div>
        <div id="jstable">
        
						<asp:datagrid id="dgmng" runat="server" AutoGenerateColumns="False" Width="100%" ForeColor="DimGray" OnItemDataBound="dgmain_ItemBound">
							<AlternatingItemStyle BackColor="#EDF3F3"></AlternatingItemStyle>
							<ItemStyle Wrap="False" HorizontalAlign="Center"></ItemStyle>
							<HeaderStyle Wrap="False" HorizontalAlign="Center" CssClass="HEADER"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderStyle Width="70px"></HeaderStyle>
									<HeaderTemplate><label for="chkAll1"><INPUT id="chkAll1" accesskey="a" onclick="javascript:return SelectAll(this.checked,this.id)"
                 type="checkbox" name="chkAll1">全选(A)</label></HeaderTemplate>
									<ItemStyle HorizontalAlign="Center"></ItemStyle>
									<ItemTemplate>
										<asp:CheckBox ID="ckbox" Runat="server" tooltip='<%# DataBinder.Eval(Container, "DataItem.contactid") %>'>
										</asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:BoundColumn DataField="username" HeaderText="姓名"></asp:BoundColumn>
								<asp:BoundColumn DataField="phone" HeaderText="电话"></asp:BoundColumn>
								<asp:BoundColumn DataField="mobile" HeaderText="手机"></asp:BoundColumn>
								<asp:BoundColumn DataField="email" HeaderText="电子邮件"></asp:BoundColumn>
								<asp:BoundColumn DataField="clientid" HeaderText="所属公司ID"></asp:BoundColumn>
								<asp:TemplateColumn HeaderImageUrl="../../icon/menu/address.gif">
									<ItemTemplate>
										<a href='e_linkman_add.aspx?contactid=<%# DataBinder.Eval(Container, "DataItem.contactid") %>' target=_self>
											编辑</a>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></div></td>
				</tr>
				<tr>
					<td bgcolor="#ffffff">
						<webdiyer:aspnetpager id="ap" runat="server" SubmitButtonText="转到" SubmitButtonClass="button" ShowInputBox="Always" OnPageChanged="ap_PageChanged"></webdiyer:aspnetpager>
            </td>
				</tr>
			</table>
    </div>
        <script type="text/javascript">
        
				jsTable('jstable','tm','96%','','center')
        </script>
    </form>
</body>
</html>
