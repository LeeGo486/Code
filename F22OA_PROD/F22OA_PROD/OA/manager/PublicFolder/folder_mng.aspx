<%@ page language="C#" autoeventwireup="true" inherits="manager_PublicFolder_folder_mng, App_Web_folder_mng.aspx.f55e7b9c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>�ļ��й���</title>
		<META http-equiv="Content-Type" content="text/html; charset=gb2312">

		<LINK href="../../css/project.css" type="text/css" rel="STYLESHEET">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
</head>
<body  leftMargin="1" topMargin="1">
    <form id="form1" runat="server">
    <div>
    <table width="100%">
				<tr>
					<td><INPUT type="button" value="�½�(A)" onclick='LoadWindow("../../manager/publicFolder/folder_add.aspx?action=add",350,210,"�½��ļ���",true)'
							class="pjt_bt">
						<asp:Button id="btdel" runat="server" Text="ɾ��(D)" CssClass="pjt_bt" OnClick="btdel_Click"></asp:Button></td>
				</tr>
				<tr>
					<td><table width="100%">
							<asp:datalist id="dlfolder" runat="server">
								<HeaderTemplate>
									<tr align="center" class="header">
										<td>ѡ��</td>
										<td width="30px">ID</td>
										<td width="160px">�ļ�������</td>
										<td>˵��</td>
										<td nowrap>����</td>
										<td width="100px">����ʱ��</td>
										<td width="40px">����</td>
									</tr>
								</HeaderTemplate>
								<ItemTemplate>
									<tr>
										<td>
											<asp:CheckBox ID="chk" Runat="server"></asp:CheckBox></td>
										<td>
											<asp:Label ID="lbid" Runat="server" text='<%# DataBinder.Eval(Container, "DataItem.folderid") %>'>
											</asp:Label></td>
										<td><%# DataBinder.Eval(Container, "DataItem.foldername") %></td>
										<td><%# DataBinder.Eval(Container, "DataItem.remark") %></td>
										<td><%# DataBinder.Eval(Container, "DataItem.seq") %></td>
										<td><%# DataBinder.Eval(Container, "DataItem.crdate","{0:D}") %></td>
										<td><a href="#"  onclick='LoadWindow("../../manager/publicFolder/folder_add.aspx?action=edit&folderid=<%# DataBinder.Eval(Container, "DataItem.folderid") %>",350,210,"�����ļ�����Ϣ",true);'>����</a></td>
									</tr>
								</ItemTemplate>
							</asp:datalist></table>
					</td>
				</tr>
				<tr>
					<td class="tip"><ol>
							<li>
							ɾ���ļ���ʱ������ѡ�����
							<li>
							���ļ����л����ļ�ʱ���ǲ��ܱ�ɾ���ģ��������޸�
							<li>
								<asp:Label ID="lbtip" Runat="server" ForeColor="Red"></asp:Label></li>
						</ol>
					</td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
