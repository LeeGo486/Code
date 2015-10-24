<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VipticktMotelRecord.aspx.cs" Inherits="VipticktMotelRecord" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>申请9折券情况查询</title>
    <style type="text/css">
        body
        {
            font-size: 13px;
            font-family: Arial, "Helvetica Neue", Helvetica, Sans-Serif;
            color: #1a3e66;
            background-color: #fff;
            text-align: center;
            margin: 5px auto;
        }

      
        p
        {
            text-align: left;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
            <h3>申请9折券情况查询</h3>
            <div>
                手机号：<asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                <asp:Button ID="btnExec" runat="server" click="form1.submit();" Text="查询" />
            </div>
            <p>&nbsp;</p>

            <div style="width: 400px; height: 300px; margin-left: auto;margin-right: auto;">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </div>

       


    </form>
</body>
</html>
