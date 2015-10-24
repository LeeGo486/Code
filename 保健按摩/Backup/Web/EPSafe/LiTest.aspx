<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LiTest.aspx.cs" Inherits="EPReper.Web.EPSafe.LiTest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="style/abc.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="../Scripts/newsimge.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div class="main">
            <div class="warp" id="area" tabindex="1">
                <div class="screen">
                    <div class="info" runat="server" id="info">
                    </div>
                    <div class="btn">
                        <span title="Previous" class="prev" id="prev">Previous</span> <span title="Next" class="next" id="next">Next</span>
                    </div>
                </div>
                <div class="list" runat="server" id="Newslist">
                </div>
            </div>
            <%--<div class="intro">
                <ul id="MyUL" runat="server">
                </ul>
            </div>--%>
        </div>
    </div>
    </form>
</body>
</html>
