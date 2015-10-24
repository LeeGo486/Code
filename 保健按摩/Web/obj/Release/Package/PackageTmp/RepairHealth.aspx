<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RepairHealth.aspx.cs" Inherits="EPReper.Web.RepairHealth" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            font: Arial, Helvetica, sans-serif normal 10px;
            margin: 0;
            padding: 0;
        }
        *
        {
            margin: 0;
            padding: 0;
        }
        #page
        {
            margin: 0 auto;
            position: relative;
            width: 850px;
            font-family: verdana;
            font-size: 12px;
        }
        #content
        {
            width: 960px;
            height:600px;
            margin: auto;
            background-image: url("Images/Allbg.png") ;
           
        }
        pre
        {
            border: 3px solid #ccc;
            padding: 5px;
            font-size: 12px;
            font-family: arial;
        }
        .bold
        {
            font-weight: bold;
        }
        .blue
        {
            color: blue;
        }
        .red
        {
            color: red;
        }
        
        
        ul.thumb
        {
            float: left;
            list-style: none;
            margin: 0;
            padding: 10px;
            width: 800px;
           
        }
        ul.thumb li
        {
            margin: 0;
            padding: 5px;
            float: left;
            position: relative;
            width: 300px;
            height: 150px;
        }
        ul.thumb li img
        {
            width: 300px;
            height: 150px;
            border: 1px solid #ddd;
            padding: 5px;
            background: #f0f0f0;
            position: absolute;
            left: 0;
            top: 0;
            -ms-interpolation-mode: bicubic;
        }
        ul.thumb li img.hover
        {
            margin-top: 0px;
            background: url(thumb_bg.png) no-repeat center center;
            border: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="content">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                
                <div style="float: right; width: 760px; padding-top: 10px;">
                    <div class="container">
                        <ul class="thumb">
                            <li id="li1">
                                <asp:LinkButton runat="server" ID="LinkButton1" OnCommand="btn1_Clik">
                        <img src="Images/repair.png" alt="" /></asp:LinkButton></li>
                            <li id="li2">
                                <asp:LinkButton runat="server" ID="LinkButton2" OnCommand="btn2_Clik">
                        <img src="Images/health.png" alt="" /></asp:LinkButton></li>
                       <li id="li3">
                                <asp:LinkButton runat="server" ID="LinkButton3" OnCommand="btn3_Clik">
                        <img src="Images/Safe_360.jpg" alt="" /></asp:LinkButton></li>
                            <%--<li id="li1"><a href="index.aspx" >
                        <img src="Images/repair.png" alt="" /></a></li>--%>
                            <%-- <li id="li3"><a href="View/Default.aspx">
                        <img src="Images/health.png" alt="" /></a></li>
                    <li id="li4"><a href="View/Default.aspx">
                        <img src="Images/health.png" alt="" /></a></li>
                    <li id="li5"><a href="View/Default.aspx">
                        <img src="Images/health.png" alt="" /></a></li>--%>
                        </ul>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <script src="Scripts/jquery-1.4.1.js" type="text/javascript">
        </script>
        <script src="Scripts/Zoomer.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('ul.thumb li').Zoomer({ speedView: 200, speedRemove: 400, altAnim: true, speedTitle: 400, debug: false });
            });
        </script>
    </div>
    </form>
</body>
</html>
