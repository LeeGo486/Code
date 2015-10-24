<%@ page language="C#" autoeventwireup="true" inherits="cmenu, App_Web_menu.aspx.b10cd3ef" %>

<%@ Register Assembly="Infragistics2.WebUI.UltraWebNavigator.v6.2, Version=6.2.20062.34, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebNavigator" TagPrefix="ignav" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>menu</title>
    <link href="css/default.css" rel="stylesheet" type="text/css" />
</head>
<body style="margin:2px;">
    <form id="form1" runat="server">
    <div>
        &nbsp;&nbsp;
        <ignav:UltraWebTree ID="UltraWebTree1" runat="server" WebTreeTarget="ClassicTree" Height="470px" Width="157px">
        </ignav:UltraWebTree>
    </div>
    </form>
</body>
</html>
