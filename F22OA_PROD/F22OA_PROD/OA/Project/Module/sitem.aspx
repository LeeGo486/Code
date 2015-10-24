<%@ page language="C#" autoeventwireup="true" inherits="Project_Module_sitem, App_Web_sitem.aspx.d7a0d114" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>选择内容</title>
		
		<LINK href="../../css/project.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../../js/project.js" type="text/javascript"></script>
		<base target="_self"/>
</head>
<body  leftMargin="1" topMargin="1" rightMargin="1">
    <form id="form1" runat="server">
    <div>
    <table width="100%">
				<tr class="header">
					<td><asp:label id="lbtitle" runat="server"></asp:label></td>
				</tr>
				<tr>
					<td><asp:datalist id="dlitem" runat="server" ShowFooter="False" RepeatColumns="3">
							<ItemTemplate>
								<asp:CheckBox ID=ckitem tooltip='<%# DataBinder.Eval(Container, "DataItem.itemid") %>' Runat=server Text='<%# DataBinder.Eval(Container, "DataItem.item") %>'>
								</asp:CheckBox>
							</ItemTemplate>
						</asp:datalist></td>
				</tr>
				<tr>
					<td align="center"><INPUT class="button" id="btsave" accessKey="s" type="button" value="保存(S)" runat="server"></td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
