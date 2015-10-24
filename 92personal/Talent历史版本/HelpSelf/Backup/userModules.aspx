<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="userModules.aspx.cs" Inherits="HelpSelf.Web.userModules" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            font: Arial, Helvetica, sans-serif normal 10px;
            margin: 0;
            padding: 0;
            background:url(Images/bg.jpg) repeat;
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
            min-height:600px;
            margin: auto;
            background: url("Images/Allbg.png") no-repeat ;
            overflow:auto;
            zoom:1;
            padding-bottom:100px;
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
    <script type="text/javascript" src="js/jquery-1.6.4.min.js"></script>
        <script src="js/Zoomer.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('ul.thumb li').Zoomer({ speedView: 200, speedRemove: 400, altAnim: true, speedTitle: 400, debug: false });
            });
        </script>
</head>
<body>
    <form id="form1" runat="server">
    
    <div id="content">
        <div style="width: 660px; padding: 10px 0 0 240px;">
            <%=HelpSelf.Common.Constants.isAdmin(Tools.SessionHelper.Get("userid")) ? "<div style='text-align:center'><a href='Module.aspx' target='_self'>后台管理</a></div>" : ""%>
            <div class="container">
                <ul class="thumb">
                    <%=listr%>
                </ul>
            </div>
        </div>
    </div>
    </form>
</body>
</html>

