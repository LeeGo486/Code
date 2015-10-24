<%@ page language="C#" autoeventwireup="true" inherits="b28web_Retail_Transfer, App_Web_transfer.aspx.832efc68" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>

    <script type="text/javascript">    		
        function Init()
        {		
			if (screen.height<=600)  
			{ 
			    window.location="small.aspx"; 
            }
            else 
            {
                window.location="default.aspx";
            }
   
		}

    </script>

</head>
<body onload="Init();">
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
</body>
</html>
