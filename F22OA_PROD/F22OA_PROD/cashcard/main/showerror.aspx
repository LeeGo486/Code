<%@ page language="C#" autoeventwireup="true" inherits="f22_jms_work_showerror, App_Web_showerror.aspx.b10cd3ef" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>出错了！</title>
<style>
*{
font-size:12px;
}
#errTable{
border:solid 1px #999999;
background:#FFFFFF;
position:absolute; top:-4px;left:-4px;
}
#errShowDown{
background:#CCCCCC;
position:relative;
width:500px;
height:120px;
}
#errTitle{
background:#ff8a01;color:white;font-weight:bold;
text-align:center
}
#showDetail{
color:#666666;
padding:5px;
}
#showSpan{
font-family:Webdings;
}
#sdlink{
border:solid 1px #ffd099;
background:#fff7ee;
text-decoration:none;color:black;
display:block;width:99%;
margin-top:10px;
}
#sdlink:hover{
border:solid 1px #65bcff;
background:#e5f1ff;
}
</style>
<script>
function showDetail(){
	if(document.getElementById('showDetail').style.display=='none'){
		document.getElementById('showDetail').style.display='block';
		document.getElementById('showSpan').innerHTML='6'
	}else{
		document.getElementById('showDetail').style.display='none';
		document.getElementById('showSpan').innerHTML='4'
	}
		document.getElementById('errShowDown').style.height=document.getElementById('errTable').offsetHeight-2;
}
</script>	
</head>

<body>
    <form id="form1" runat="server">
    <div>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><div id="errShowDown" ><table width="500" border="0" cellspacing="0" cellpadding="0" id="errTable">
      <tr>
        <td height="100" valign="top"><table width="500" border="0" cellspacing="1" cellpadding="0" id="errTabBody">
          <tr>
            <td height="20" id="errTitle">出错了！</td>
          </tr>
          <tr>
            <td valign="top" ><table width="100%" border="0" cellspacing="12" cellpadding="0">
            <tr>
              <td width="60" align="center" valign="top"><img src="images/pageError_icon.jpg" width="44" height="44" /></td>
              <td valign="top" align="left" style="line-height:20px;">
			  您访问的页面已经出错，请与管理员联系！<br />
			  <a href="#" onclick="showDetail()" onfocus="this.blur()" id="sdlink">&nbsp;<span id="showSpan">4</span> 查看详细<div id="showDetail" style="display:none"><asp:Label ID="lbl_error" runat="server" Text="Label"></asp:Label></div></a>
			  
			</td>
            </tr>
          </table></td>
          </tr>
        </table>
          </td>
      </tr>
      <tr>
        <td height="20" bgcolor="#fafafa">&nbsp;</td>
      </tr>
    </table></div></td>
  </tr>
</table>
	</div>
    </form>
</body>
</html>
