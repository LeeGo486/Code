<%@ page language="C#" autoeventwireup="true" inherits="Modal_input_bankcard, App_Web_input_bankcard.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>请刷卡</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
        	background:#eee;
        	overflow:hidden;
        	width:400px;
        	height:150px;
        	}
    </style>
    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    window.returnValue="";
    document.onkeydown = KeyDown;
    function KeyDown(){
        with (event){ 
            //开始刷卡
            if(keyCode==186){
                $("#cardcode").removeAttr('readonly');
                $("#cardcode").focus();
            }
            //取消
            if(keyCode==27){
                window.returnValue="";
                window.close();
            }
            //确定
            if(keyCode==13){
                var rt = document.getElementById("cardcode").value;
                window.returnValue=rt;
                window.close();
            }
        }
    }

    </script>
</head>
<body>
<object id="Trans1" classid="CLSID:E2EEEA3B-34C4-43B7-B7AC-CB12DCA6FBBE" style="display:none;">
    <param name="_version" value="1.0" />
    <param name="_extentx" value="13229" />
    <param name="_extenty" value="13229" />
    <param name="_stockprops" value="0" />
</object>
    <form id="form1" runat="server">
        <center>
        <br />    
        <br />    
        <br />    
        <b><h2>请刷卡...<input type="password" name="cardcode" id="cardcode" readonly="readonly" style="width:0px;height:0px;background:#eee;border:none;"/></h2></b>
        </center>
    </form>
</body>
</html>
