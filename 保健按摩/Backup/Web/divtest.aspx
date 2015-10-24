<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="divtest.aspx.cs" Inherits="EPReper.Web.divtest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        *
        {
            font-size: 12px;
            font-family: Verdana;
            margin: 0;
            padding: 0;
        }
        #play img
        {
            border: 0px;
        }
        #play
        {
            width: 346px;
            height: 191px;
            overflow: hidden;
            margin: 50px 0 0 50px;
        }
        #play_info
        {
            position: absolute;
            margin-top: 141px;
            padding: 8px 0 0 20px;
            height: 42px;
            width: 270px;
            color: #fff;
            z-index: 1001;
            cursor: pointer;
        }
        #play_info b
        {
            font-size: 14px;
            display: block;
        }
        #play_bg
        {
            position: absolute;
            background-color: #000;
            margin-top: 141px;
            height: 50px;
            width: 346px;
            
            z-index: 1000;
        }
        #play_text
        {
            position: absolute;
            margin: 141px 0 0 296px;
            height: 50px;
            width: 60px;
            z-index: 1002;
        }
      
       
       
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="play">
        <div id="play_bg">
        </div>
        <div id="play_info">
        </div>
     
    </div>
    </form>
</body>
</html>
