<%@ page language="C#" autoeventwireup="true" inherits="GoodsAllocation_Default, App_Web_fizkkrdw" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>跨公司调拨</title>
    <script type="text/javascript">
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        function OpenWebForm(url) {
            window.location.href = url + "?depotid=" + GetQueryString("depotid") + "&userid=" + GetQueryString("userid");
        }
    </script>
</head>
<body>
    <div style="margin-top:100px;text-align:center;font-size:14px;">
        <input type="button" value="新建跨公司调拨单" onclick="OpenWebForm('Create.aspx')" style="height: 50px; width: 180px" />
        <br /><br />
        <input type="button" value="查询跨公司调拨单" onclick="OpenWebForm('Search.aspx')" style="height: 50px; width: 180px" />
        <br /><br />
        <p style="color:#F00;">注：同一张单据，货品的品牌必须相同！</p>
    </div>
</body>
</html>
