<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="HelpSelf.Web.login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <style type="text/css">
    body {
	font:12px Arial, Helvetica, sans-serif;
	color: #000;
	background-color: #EEF2FB;
	width:960px ;
	margin: 0px auto;
    }
    </style>
</head>
<body >
    <form id="form1" action="Login.aspx" runat="server"  method="post"   >
    <div  style="width:1024px;height:630px; margin-top:30px ;background:url(Images/login.jpg) no-repeat"  >
        <div style="height:330px;padding-top:255px;padding-left:420px">
         <table border="0" cellpadding="4" cellspacing="1" width="230px"  >
                 <tr>
                      <td colspan="2">
                       <span style="color:red" runat=server id="tooltip"> &nbsp; </span>
                      </td> 
                 </tr>
                 <tr>
                      <td style="" colspan="2"><input name="username"  type="text"  style="width:100px" /></td>
                  </tr>
                  <tr>
                        <td style="width:50%" ><input  type="password"  name="password"   style="width:100px"   /></td>
                        <td style="width:50%"> 
                            <input name="ImageButton1" id="Image1" style="border-right-width: 0px; border-top-width: 0px; border-bottom-width: 0px; border-left-width: 0px;" runat=server type="image" src="Images/signin.jpg" />
                    </td>
                  </tr>
           </table>
        </div>  
      </div>
    </form>
</body>
</html>
