<!--#include file="../../f22/inc/function.asp"-->
<%
depotid=trim(session("dm").system_depotid)
userid=trim(session("dm").system_userid)
username=trim(session("dm").system_username)
vipid=trim(request("vipid"))
chgid=trim(request("chgid"))
bs=cdbl(request("bs"))
msg=request("msg")
kg=Request("hid")

ty=2
if(kg<>"1")then
 ty=2
else
 ty=3
end if

set rs=server.CreateObject("adodb.recordset")
sql="select a.vipname,a.vipcode,isnull(a.mobtel,'') as mobtel,isnull(a.centum,0)+isnull(b.starcentum,0) as centum,"&_
    "convert(char(19),getdate()+0.001,120) as setdate,isnull(a.pcentum,0) as pcentum "&_
    "from vip_user a,vip_cardvip b where a.vipcode=b.vipcardid and a.vipid='"&vipid&"'"
rs.open sql,cn
vipname=rs("vipname")
vipcode=rs("vipcode")
centum=cdbl(rs("centum"))
mobtel=rs("mobtel")
setdate=rs("setdate")
pcentum=cdbl(rs("pcentum"))
rs.close
sql="select a.tictypeid,b.ticketpre,isnull(a.jf,0) as jf,isnull(a.sums,0) as sums,a.ttype,a.sureup,"&_
    "a.acttype,a.days,a.closedate,a.begdate,a.enddate from vip_ticketchange a,vip_tictype b "&_
	"where a.chgid="&chgid&" and a.tictypeid=b.tictypeid"
rs.open sql,cn
tictypeid=rs("tictypeid")
ticketpre=rs("ticketpre")
jf=cdbl(rs("jf"))
sums=cdbl(rs("sums"))
ttype=rs("ttype")
sureup=rs("sureup")
acttype=rs("acttype")
days=rs("days")
closedate=rs("closedate")
begdate=rs("begdate")
enddate=rs("enddate")
rs.close
kjf=jf
ksums=sums
if not sureup and jf>centum and ty=2 then
   response.write("<script>alert('总积分不够兑换！');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
   response.End()
end if

if sureup and ty=2 then
  if jf*bs>centum then
     response.write("<script>alert('总积分不够兑换！');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
     response.End()
  else
     kjf=jf*bs
	 ksums=sums*bs
  end if
end if

if ty=3 then
  if jf*bs>pcentum then
    Response.Write("<script>alert('上季积分不够兑换！');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
    Response.End()
  else
     kjf=jf*bs
	 ksums=sums*bs
  end if    
end if

if msg then
  sql="select isnull(tmpcontent,'') as tmpcontent from vip_msgtemplate where tmpid=3801021"
  rs.open sql,cn
	if not rs.eof and  not rs.bof then
		tmpcontent=rs("tmpcontent")
	end if
	
  if tmpcontent="" then
    response.write("<script>alert('短信模板为空，不可以发送！');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
    response.End()
  end if
  rs.close
end if

select case acttype
case 0 suretj=days&"天内有效"
case 1 suretj="截止"&closedate&"有效"
case 2 suretj=begdate&"至"&enddate&"有效"
end select

jfid=GetId("vip_jfchange","jfid","CH",userid)
viptypeid=GetVipTypeId(depotid)
tmpticketid=trim(ticketpre)&GetTmpTicketId
'扣积分
sql="insert into vip_jfchange (jfid,setdate,sure,chk_sure,chk_name,sure_name,chk_date,sure_date,cr_date,cr_name,comment,d_type,mb) "&_
    "values ('"&jfid&"',getdate(),0,0,'"&username&"','"&username&"',getdate(),getdate(),getdate(),'"&username&"','积分兑换',"&ty&",'"&viptypeid&"')"
cn.execute sql
sql="insert into vip_jfchangesub (jfid,vipid,vipcode,centum,sums,comment,crdate) values "&_
    "('"&jfid&"','"&vipid&"','"&vipcode&"',"&-1*kjf&",0,'券号"&tmpticketid&"',getdate())"
cn.execute sql

'生成券
verifycode=GetRndCode(6)'生成验证码
sql="insert into vip_ticket (ticketid,ticket,tckname,tictypeid,dtype,ttype,sums,fbegdate,fenddate,acttype,days,closedate,begdate,enddate,"&_
    "setsure,setdepotid,setdate,signsure,sellsure,selldate,sellname,getsure,freeze,crdate,crname,vipid,comment,verifycode) values "&_
    "('"&tmpticketid&"','"&tmpticketid&"','"&ksums&"元券','"&tictypeid&"',2,"&ttype&","&ksums&",'"&begdate&"','"&enddate&"',"&acttype&","&days&","&_
	"'"&closedate&"','"&begdate&"','"&enddate&"',1,NULL,getdate(),1,1,getdate(),'"&username&"',0,0,getdate(),'"&username&"',"&_
	"'"&vipid&"','兑换生成','"&verifycode&"')"
cn.execute sql

if (ty=3) then
   cn.execute "update vip_user set pcentum=pcentum+("&-1*kjf&") where vipid='"&vipid&"'"
end if

cn.execute "update vip_jfchange set chk_sure=1 where jfid='"&jfid&"'"
cn.execute "update vip_jfchange set sure=1 where jfid='"&jfid&"'"
 
'发短信
if msg and mobtel<>"" then
   tmpcontent=Replace(tmpcontent,"$Username",vipname)
   tmpcontent=Replace(tmpcontent,"$Vipcode",vipcode)
   tmpcontent=Replace(tmpcontent,"$Vipcentum",centum)
   tmpcontent=Replace(tmpcontent,"$Chgcentum",kjf)
   tmpcontent=Replace(tmpcontent,"$Chgsums",ksums)
   tmpcontent=Replace(tmpcontent,"$Ticketid",tmpticketid&",验证码为"&verifycode)
   tmpcontent=Replace(tmpcontent,"$Ticeff",suretj)
   'sql="insert into vip_message (msg,setdate,sure,tel,crdate,crname) values "&_
   '    "('"&tmpcontent&"','"&setdate&"',0,'"&mobtel&"',getdate(),'"&username&"')"
   'cn.execute sql

   response.Write("<script>showModalDialog('sendmsg.aspx?tmpcontent="&VbsEscape(tmpcontent)&"&mobtel="&mobtel&"&verifycode="&verifycode&"', window, 'dialogWidth:350px;dialogHeight:200px;center:yes;help:no;resizable:yes;status:no');alert('兑换完成！');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")

else
    response.Write("<script>alert('兑换完成！');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
end if


'取到有当前店铺权限的用户的VIP卡类型权限
function GetVipTypeId(dptid)
set rs10=server.CreateObject("adodb.recordset")
sql="select top 1 b.viptypeid from sys_vipdepotpower18ql a,sys_viptypepower18ql b "&_
    "where a.depotid='"&dptid&"' and a.userid=b.userid group by b.viptypeid"
rs10.open sql,cn
if not rs10.eof then
   GetVipTypeId=rs10("viptypeid")
end if
rs10.close
set rs10=nothing
end function

'自动生成券号
function GetTmpTicketId()
tmpid=replace(get_date(date),"-","")&replace(timer,".","")
GetTmpTicketId=tmpid
end function


 Function VbsEscape(str)
        dim i,s,c,a 
        s="" 
        For i=1 to Len(str) 
            c=Mid(str,i,1)
            a=ASCW(c)
            If (a>=48 and a<=57) or (a>=65 and a<=90) or (a>=97 and a<=122) Then
                s = s & c
            ElseIf InStr("@*_+-./",c)>0 Then
                s = s & c
            ElseIf a>0 and a<16 Then
                s = s & "%0" & Hex(a)
            ElseIf a>=16 and a<256 Then
                s = s & "%" & Hex(a)
            Else
                s = s & "%u" & Hex(a)
            End If
        Next
        VbsEscape=s
    End Function
    '与javascript中的()等效
    Function Vbs(str)
                    Dim x
        x=InStr(str,"%") 
        Do While x>0
            Vbs=Vbs&Mid(str,1,x-1)
            If LCase(Mid(str,x+1,1))="u" Then
                Vbs=Vbs&ChrW(CLng("&H"&Mid(str,x+2,4)))
                str=Mid(str,x+6)
            Else
                Vbs=Vbs&Chr(CLng("&H"&Mid(str,x+1,2)))
                str=Mid(str,x+3)
            End If
            x=InStr(str,"%")
        Loop
        Vbs=Vbs&str
    End Function
%>