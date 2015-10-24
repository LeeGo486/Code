<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
<script>
window.location.href="http://172.16.200.121/DiffComExcGoods/Default.aspx?depotid=<%= SqlDbHelper.GetDataTable("SELECT depotid FROM "+app_user.dbname+".dbo.j_user WHERE userid='"+app_user.userid+"'","jackchen").Rows[0][0].ToString() %>&userid=<%= app_user.userid %>&type=2";
</script>
</head>
<body>

</body>
</html>
