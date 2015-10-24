<%@ page language="C#" autoeventwireup="true" inherits="manager_book_book_amount, App_Web_book_amount.aspx.c640126d" %>
<%@ Register Assembly="Infragistics2.WebUI.WebDataInput.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>更改数量</title>

		<link href="../../css/project.css" type="text/css" rel="stylesheet" />
		<script language="javascript" type="text/javascript" src="../../js/project.js"></script>
		<base target="_self">
</head>
<body topmargin="1" leftmargin="1">
    <form id="form1" runat="server">
    <div>
    <table width="100%" cellspacing="1">
				<tr class="header">
					<td colspan=2> &#183;更改《<asp:Label id="lbname" runat="server"></asp:Label>》的在馆数量:</td>
				</tr>
				<tr>
					<td align="center">
                        <igtxt:webnumericedit id="wne" runat="server" maxvalue="10000" minvalue="0" valuetext="0"></igtxt:webnumericedit>
                    </td>
                    <td><asp:Button id="btx" runat="server" Text="更改(S)" OnClick="btx_Click" CssClass="btn"></asp:Button></td>
				</tr>
			</table>
    </div>
    </form>
</body>
</html>
