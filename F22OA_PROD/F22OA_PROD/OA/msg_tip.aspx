<%@ page language="C#" autoeventwireup="true" inherits="msg_tip, App_Web_msg_tip.aspx.766205c1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>新短消息</title>
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

TimeStart=30;

function MyTimer()
{
   if(TimeStart==0)
      window.close();
  
   TimeShow.innerHTML=TimeStart;
   TimeStart--;

   var timer=setTimeout("MyTimer()",1000);
}
		</SCRIPT>
	</HEAD>
	<body bgcolor="#eeffee" topmargin="0" leftmargin="0" onload="MyLoad();">
		<form id="Form1" method="post" runat="server">
			<table width="100%">
				<thead>
					<tr>
						<td colspan="4" style="HEIGHT: 6px" align="left"><font color="blue">本窗口<span id="TimeShow" style="FONT-WEIGHT:bold;COLOR:#ff0000"></span>&nbsp;秒后关闭</font></td>
					</tr>
				</thead>
				<TBODY>
					<tr>
						<td width="37" align="right" class="main" style="WIDTH: 32px">来自:</td>
						<td width="32" class="main">
							<asp:Label id="lbfrom" runat="server" width="168px" ForeColor="Blue"></asp:Label></td>
						<td width="35" class="main"><INPUT id="hdtouserid" runat="server" style="WIDTH: 32px; HEIGHT: 22px" type="hidden"></td>
						<td width="4" class="main"></td>
					</tr>
					<tr>
						<td align="right" class="main" style="WIDTH: 32px">时间:</td>
						<td colspan="3" class="main">
							<asp:Label id="lbtime" runat="server" Width="160px" ForeColor="Blue"></asp:Label></td>
					</tr>
					<tr>
						<td align="right" vAlign="top" class="main" style="WIDTH: 32px">内容:</td>
						<td colspan="3">
							<asp:TextBox id="tbcontent" runat="server" TextMode="MultiLine" Width="240px" Height="88px" BackColor="WhiteSmoke"></asp:TextBox></td>
					</tr>
				</TBODY>
				<tfoot>
					<tr>
						<td colspan="4" align="center">
							<input type="submit" style="WIDTH: 70px; HEIGHT: 22px" name="btok" value="我知道了" class="bt"
								runat="server" id="btknow" onserverclick="btknow_ServerClick">&nbsp; <INPUT class="bt" id="btr" runat="server" style="WIDTH: 67px; HEIGHT: 22px" type="button"
								value="回复" onserverclick="btr_ServerClick" ><FONT face="宋体">&nbsp;</FONT><INPUT class="bt" id="btdel" type="submit" size="30" value="删除消息"  style="WIDTH: 60px" name="btReply"
								runat="server" onserverclick="btdel_ServerClick">
							
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</body>
</html>
