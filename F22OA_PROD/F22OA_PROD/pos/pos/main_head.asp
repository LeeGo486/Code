<!-- #include file="inc/const.asp" -->
<%Dim cn
set cn=server.CreateObject("adodb.connection")
cn.open session("cn")%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta http-equiv="refresh" content="60">
<link href='skin/<%=session("skindir")%>/default.css' rel='stylesheet' type='text/css'>
<title>ZHX_OAMAIN</title>
<script language="javascript">
function openurl(url){
  top.mainFrame.main.location.href=url;
}
function tframe(){
  window.parent.topFrame.oa_tool();
}
function qq(){
  window.open("qq/qq.asp","","width=165,height=600,status=no,menubar=no,toolbar=no,scrollbars=yes,resizable=yes");
}
function jumpsend()
{if(confirm('确定发送当日销售吗？'))
  {showModalDialog('main_head.asp?action=send','e','dialogWidth:0px;dialogHeight:0px;center: yes;help:no;resizable:no;status:no')}
}
function showmsg(t)
{var mytop=screen.height-190;
 var myleft=0;
 window.open("../../oa/msg_tip.aspx?msgid="+t,"短信息提示","height=190px,width=350px,status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,top="+mytop+"px,left="+myleft+"px,resizable=yes")
 //showModalDialog("../../oa/msg_tip.aspx?msgid="+t,"e","dialogWidth:"+mytop+"px;dialogHeight:"+myleft+"px;center: yes;help:no;resizable:no;status:no")
 }
</script>
</head>
<body background="skin/<%=session("skindir")%>/image/index_15.gif" topmargin="0" leftmargin="0">
<%sub main()
Dim mailcnt,msgcnt
mailcnt=GetMail()
msgcnt=GetMsg()
if (cdbl(msgcnt)>0) and (cdbl(request.Cookies("MsgAutoShow"))=1) then
   response.write("<script>showmsg("&GetFristMsg()&")</script>")
end if%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="index_head" height="24" style="line-height:24px; border-bottom:solid 1px #3a3a3a;">
  <tr>
  <td>&nbsp;</td>
	<td width=20 valign=middle><img src="skin/<%=session("skindir")%>/image/user1.gif" align="absmiddle"></td>
	<td width=120><%=session("dm").System_username%>(<%=session("dm").System_userid%>)</td>
  
    <td align="right" width=120><div style="padding-right:50px;">
<!--    <a href="f22/index_main.asp"  target="mainFrame" onFocus=this.blur()>POS首页</a> -->
	|&nbsp;&nbsp;<a href="help/F22POS操作使用说明.htm" target="_black">帮助说明</a>
<!--	| <a href="javascript:void(null)" onClick="jumpsend()" onFocus="this.blur()">当日报数</a>
  -->
  </div></td>
    <td width=200 valign=middle style="display:none;">未阅: <a href="../../oa/isprit/mail/mail_inbox.aspx" target="main" onFocus="this.blur()">邮件</a> <font color=red><%=mailcnt%></font> 封 
	| <a href="../../oa/isprit/msg/msg_inbox.aspx" target="main" onFocus="this.blur()">短信</a> <font color=red><%=msgcnt%></font> 封
	<%if cdbl(mailcnt)>0 or cdbl(msgcnt)>0 then%><img src="img/sms1.gif" border="0"><%end if%></td>
  </tr>
</table>
</body>
</html>
<%
'更新在线时间
cn.execute "update voa.dbo.j_user set onlinetime=getdate() where userid='"&session("dm").system_userid&"'"
end sub

sub sendmsg()
dim title,rs,i,mobtellist,s1,dname,tdate,ndate,sdate,nums,sums,msg,t
set rs=server.createobject("adodb.recordset")
rs.open "select isnull(mobtel,'') as mobtel from j_depot where depotid='"&session("dm").system_depotid&"'",cn
mobtellist=rs("mobtel")
rs.close
if mobtellist="" then
   response.write("<script>alert('手机列表为空，不能发送，请联系总公司！')</script>")
else
   s1="select a.depotid,max(c.d_name) as d_name,sum(b.nums) as nums,sum(b.nums*b.s_price) as sums,"&_
      "convert(char(8),getdate(),114) as sdate,convert(char(10),getdate(),126) as ndate,"&_
      "convert(char(19),getdate()+0.02,120) as tdate "&_
      "from d_retail a,d_retailsub b,j_depot c "&_
      "where a.retailid=b.retailid and isnull(a.sure,0)>0 and convert(char(10),getdate(),126)=convert(char(10),a.sure_date,126) "&_
	  "and a.depotid=c.depotid and a.depotid='"&session("dm").system_depotid&"' group by a.depotid"
   rs.open s1,cn
   if not rs.eof then
      dname=rs("d_name")
	  tdate=rs("tdate")
	  ndate=rs("ndate")
	  sdate=rs("sdate")
	  nums=rs("nums")
	  sums=rs("sums")
   else
      rs.close
      s1="select d_name,convert(char(8),getdate(),114) as sdate,convert(char(10),getdate(),126) as ndate,"&_
         "convert(char(19),getdate()+0.02,120) as tdate from j_depot where depotid='"&session("dm").system_depotid&"'"
	  rs.open s1,cn
	  dname=rs("d_name")
	  tdate=rs("tdate")
	  ndate=rs("ndate")
	  sdate=rs("sdate")
	  nums=0
	  sums=0
   end if
   rs.close
   msg=trim(dname)&ndate&"日,总共销售 "&nums&" 件,销售额 ￥ "&sums&" ,以上数据截止时间为"&sdate
   t=split(mobtellist,",")
   for i=0 to ubound(t)
       s1="insert into vip_message (msg,setdate,sure,tel,crdate,crname) values "&_
	      "('"&msg&"','"&tdate&"',0,'"&t(i)&"',getdate(),'"&session("dm").System_UserName&"')"
       cn.execute s1
   next
   response.write("<script>alert('发送完成！');window.close();</script>")
end if
set rs=nothing
end sub

Function GetMail()
set tmp=server.createobject("adodb.recordset")
tmp.open "select count(*) as cnt from voa.dbo.a_mail a,voa.dbo.j_user b where a.touserid=b.id and b.userid='"&session("dm").system_userid&"' and a.readit=1 and touse=1",cn
GetMail=tmp("cnt")
tmp.close
set tmp=nothing
End Function

Function GetMsg()
set tmp=server.createobject("adodb.recordset")
tmp.open "select count(*) as cnt from voa.dbo.a_msg a,voa.dbo.j_user b where a.touserid=b.id and b.userid='"&session("dm").system_userid&"' and a.remind=1 and touse=1",cn
GetMsg=tmp("cnt")
tmp.close
set tmp=nothing
End Function

Function GetFristMsg()
set tmp=server.createobject("adodb.recordset")
tmp.open "select top 1 msgid from voa.dbo.a_msg a,voa.dbo.j_user b where a.touserid=b.id and b.userid='"&session("dm").system_userid&"' and a.remind=1 and touse=1",cn
if not tmp.eof then
   GetFristMsg=tmp("msgid")
end if
tmp.close
set tmp=nothing
End Function

if request("action")="" then
   call main()
else
   call sendmsg()
end if

cn.close
set cn=nothing%>
