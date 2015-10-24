<%@ page language="C#" autoeventwireup="true" inherits="depotMgr_depotUser, App_Web_depotuser.aspx.9ee944ed" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>人员档案</title>
    <link href="../depotMgr/scripts/common.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form2" runat="server">
    <div>
<table width="100%" border="0" cellpadding="0" cellspacing="5">
  <tr>
    <td>
    <div id="depotinfomenu">
    <ul>
    <li><a href="depotInfo.aspx?depotid=<%=depotid %>">店铺信息</a></li>
    <li><a href="depotFile.aspx?depotid=<%=depotid %>">店铺文档</a></li>
    <li><a href="depotUser.aspx?depotid=<%=depotid %>" class="mthis">人员档案</a></li>
    <li><a href="depotSale.aspx?depotid=<%=depotid %>">销售情况</a></li>
    </ul>
    </div></td>
  </tr>
    
  <tr>
    <td valign="top">&nbsp;</td>
  </tr>
  <tr>
    <td valign="top" >
        <asp:Table ID="Table1" runat="server" HorizontalAlign="Center" Width="98% " 
            BackColor="#5D7B9D" BorderWidth="0px" CellPadding="3" CellSpacing="0">
        </asp:Table>
       
	</td>
  </tr>
</table>

    </div>
    </form>
</body>
</html>

