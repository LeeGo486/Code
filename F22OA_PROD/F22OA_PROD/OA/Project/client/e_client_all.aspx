<%@ page language="C#" autoeventwireup="true" inherits="Project_client_e_client_all, App_Web_e_client_all.aspx.fc906236" %>

<%@ Register TagPrefix="webdiyer" Namespace="Wuqi.Webdiyer" Assembly="AspNetpager" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <title>�ͻ�����</title>
		<META http-equiv="Content-Type" content="text/html; charset=gb2312">
		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table width="100%" border="0" cellpadding="0" cellspacing="1">
				<TBODY>
					<tr>
						<td>
            <asp:label id="lbtip" Width="100%" runat="server" cssclass="tip"></asp:label>
							<TABLE id="Table2" cellSpacing="1" cellPadding="1" width="99%">
								<TR>
									<TD>
                    <TABLE id="Table1" cellSpacing="1" cellPadding="1" border="0">
                      <TR>
                        <TD><INPUT id="chkAll1" accessKey="z" onclick="javascript:return SelectAll(this.checked,this.id)"
                            type="checkbox" name="chkAll1">ȫѡ(Z)
                        </TD>
                        <TD>
                          <asp:button id="btdel" accessKey="d" runat="server" CssClass="btn" Text="ɾ��(D)" OnClick="btdel_Click"></asp:button></TD>
                        <TD><INPUT class="btn" id="btadd" accessKey="a" onclick="LoadClass('Project/client/e_client_add.aspx','�����ͻ�');" type="button" value="�½�(A)" name="btadd"></TD>
                      </TR>
                    </TABLE>                  
                  
										<!--<FONT face="����">��������:
											<asp:textbox id="tbvalue" runat="server" CssClass="pjt_bt" cname="��������" ToolTip="�����Ǳ�Ż����ƣ��������ѯ���м�¼"
												Width="144px"></asp:textbox>
											<asp:button id="btsearch" accessKey="s" runat="server" CssClass="pjt_bt" Text="����(S)" OnClick="btsearch_Click"></asp:button></FONT>
											-->
											</TD>
								</TR>
							</TABLE>
						</td>
					</tr>
					<tr>
						<td bgcolor="#ffffff">
							<asp:datagrid id="dgmng" runat="server" GridLines="None"  CssClass="tbGrid"  CellSpacing="1" 
							Width="100%" AutoGenerateColumns="False" ShowFooter="True" CellPadding="4" ForeColor="#333333" OnItemDataBound="dgmain_ItemBound">
								<SelectedItemStyle Font-Bold="True" ForeColor="#333333" BackColor="#D1DDF1"></SelectedItemStyle>
							<AlternatingItemStyle BackColor="White"></AlternatingItemStyle>
							<ItemStyle BackColor="#EFF3FB" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
							<HeaderStyle Font-Bold="True" Wrap="False" HorizontalAlign="Center"  CssClass="dgHeader"></HeaderStyle>
							<FooterStyle  Font-Bold="True" CssClass="dgHeader"></FooterStyle>
								<Columns>
									<asp:TemplateColumn HeaderText="ѡ��">
										<HeaderStyle Width="30px"></HeaderStyle>
										<ItemStyle HorizontalAlign="Center"></ItemStyle>
										<ItemTemplate>
											<asp:CheckBox ID="ckbox" Runat="server" tooltip='<%# DataBinder.Eval(Container, "DataItem.forshort") %>'>
											</asp:CheckBox>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:TemplateColumn HeaderText="��˾����">
										<ItemTemplate>
											<a href='../show/client_one.aspx?forshort=<%# DataBinder.Eval(Container, "DataItem.forshort") %>' >
												<%# DataBinder.Eval(Container, "DataItem.company") %>
											</a>
										</ItemTemplate>
									</asp:TemplateColumn>
									<asp:BoundColumn DataField="phone" HeaderText="�绰"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="fax" HeaderText="fax" ReadOnly="True"></asp:BoundColumn>
                                    <asp:BoundColumn DataField="email" HeaderText="����"></asp:BoundColumn>
									<asp:TemplateColumn HeaderImageUrl="../../icon/menu/address.gif">
										<ItemTemplate>
											<a href='e_client_add.aspx?forshort=<%# DataBinder.Eval(Container, "DataItem.forshort") %>' target=_self>
												�༭</a>
										</ItemTemplate>
									</asp:TemplateColumn>
								</Columns>
							</asp:datagrid></td>
					</tr>
					<tr>
						<td bgcolor="#ffffff">
							<webdiyer:aspnetpager id="ap" runat="server" SubmitButtonText="ת��" SubmitButtonClass="btn" ShowInputBox="Always"
                            PageSize="15" OnPageChanged="ap_PageChanged"></webdiyer:aspnetpager>
           </td>
					</tr>
				</TBODY>
			</table>
    </div>
    </form>
</body>
</html>
