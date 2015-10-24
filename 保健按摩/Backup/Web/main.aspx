<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="EPReper.Web.main" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>自助维修平台</title>
    <link href="Styles/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        a
        {
            display: block;
            width: 300px;
            height: 60px;
            line-height: 65px;
            text-align: center;
            color: #000;
            background: url(../images/menu2.gif) no-repeat center bottom;
            font-size: 40px;
            float: none;
            text-decoration: none;
            font-family:微软雅黑;
            color: Maroon;
        }
        a:hover
        {
            text-align: center;
            color: #3f3f3f;
            font-family:微软雅黑;
            background: url(../images/menu3.gif) no-repeat center bottom;
        }
    </style>
</head>
<body>
    <center>
        <form id="form1" runat="server" method="post">
        <div>
            <center>
                <table border="0" cellpadding="0" cellspacing="1" bgcolor="#FFFFFF" width="100%">
                    <tr style="height: 100px;">
                    </tr>
                    <tr style="height: 60px;">
                        <td>
                            <table width="100%">
                                <label id="listtable" runat="server">
                                </label>
                                <%--                                <tr align="center" >
                                    <td valign="middle" width="30%">
                                    </td>
                                    <td valign="middle" width="30%" >
                                                <a href="http://localhost:28019/index.aspx">维修服务平台</a>
                                    </td>
                                    <td valign="middle" width="30%">
                                    </td>
                                </tr>--%>
                            </table>
                        </td>
                    </tr>
                </table>
            </center>
        </div>
        </form>
    </center>
</body>
</html>
