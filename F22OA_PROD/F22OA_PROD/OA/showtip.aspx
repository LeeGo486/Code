<%@ page language="C#" autoeventwireup="true" inherits="Uisprit_schedule_show_one, App_Web_showtip.aspx.766205c1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>日程提醒</title>
   <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1"/>
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1"/>
		<meta name="vs_defaultClientScript" content="JavaScript"/>
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5"/>
		<LINK href="css/project.css" type="text/css" rel="stylesheet">
				<SCRIPT LANGUAGE="JavaScript" type="text/javascript" >
var intervalHdl;
var mytop=screen.availHeight;

function clearmsg()
{
window.showModalDialog
window.close();

}
function reply()
{
window.open("isprit/msg/msg_send.aspx?touserid=" + userid + "&tousername=" + username,"回复")
window.close();

}
function fnEffect()
{
  window.focus();
  if ( mytop<(screen.availHeight-240))
  {
    clearTimeout(intervalHdl);
    return;
  }
  else
  { mytop=mytop-10;
    window.moveTo(0, mytop);
  }

  intervalHdl = setTimeout('fnEffect()', 10);
}

function MyLoad()
{
   MyTimer();
   intervalHdl = setTimeout('fnEffect()', 300);
}

TimeStart=20;

function MyTimer()
{
   if(TimeStart==0)
      window.close();
  
   TimeShow.innerHTML=TimeStart;
   TimeStart--;

   var timer=setTimeout("MyTimer()",1000);
}
		</SCRIPT>
</head>
<body bgcolor="#eeffee" topmargin="0" leftmargin="0" onload="MyLoad();">
    <form id="form1" runat="server">
    	<thead>
					<tr>
						<td colspan="4" style="HEIGHT: 6px" align="left"><font color="blue">本窗口<span id="TimeShow" style="FONT-WEIGHT:bold;COLOR:#ff0000"></span>&nbsp;秒后关闭</font></td>
					</tr>
		</thead>
    <div>
        日程提醒:<asp:Image ID="img" runat="server" /><br />
        开始时间:<asp:Label ID="lbdate" runat="server"></asp:Label>结束日间:
        <asp:Label ID="lbdate2" runat="server"></asp:Label><br />
        日程内容:<asp:Label ID="lbcontent" runat="server"></asp:Label>
        <br />
        <asp:Button ID="btOK" runat="server" Text="知道了" OnClick="Button1_Click" CssClass="btn" /></div>
    </form>
</body>
</html>
