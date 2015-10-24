<%@ page language="C#" autoeventwireup="true" inherits="Modal_retail_selCx, App_Web_retail_selcx.aspx.a056ca89" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>选择促销</title>
    <base target="_self" />
    <meta http-equiv="pragma" content="no-cache" />
    <meta http-equiv="Cache-Control" content="no-cache,must-revalidate" />
    <link href="../Utility/main.css" rel="stylesheet" type="text/css" />
    <script src="../Utility/jquery-1.2.6.min.js" type="text/javascript"></script>
    <script src="../Utility/jquery.hotkeys-0.7.9.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    var focusElement;
    
    $(function(){
    
        focusElement = $(".btn2").eq(0);
        
	    $(document).bind('keydown', 'up', function(){
		    if($(focusElement).prev($(".btn2")).length>0)
		    {
		        $(focusElement).prev($(".btn2")).focus();
		        focusElement=focusElement.prev();
		    }
		    return false;
	    });
	    $(document).bind('keydown', 'down', function(){
		    if($(focusElement).next($(".btn2")).length>0)
		    {
		        $(focusElement).next($(".btn2")).focus();
		        focusElement=focusElement.next();
		    }
		    
		    return false;
	    });
    })
    
    function KeyDown(){
        with (event){ 
            if(keyCode==27){//ESC返回输入状态
                document.getElementById('Button2').click();
                event.keyCode = 0; 
                event.cancelBubble = true; 
                return false;
            }
        }
    }
    document.onkeydown = KeyDown;
    </script>
    <style type="text/css">
        input
        {
        	margin:5px auto;
        	font-weight:bold;
        	font-family:Arial;
        	}

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align:center;">
    <div style="width:300px; margin:30px auto;">
    <center><h3 runat="server" id="title"></h3></center>
        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        <input type="button" class="btn2" id="Button2" value="取　消 [Esc]"  style="height:30px;width:250px;"
            onclick="window.returnValue='';window.close();"/>
    </div>
    </div>
    </form>
</body>
</html>
