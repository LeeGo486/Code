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
   response.write("<script>alert('�ܻ��ֲ����һ���');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
   response.End()
end if

if sureup and ty=2 then
  if jf*bs>centum then
     response.write("<script>alert('�ܻ��ֲ����һ���');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
     response.End()
  else
     kjf=jf*bs
	 ksums=sums*bs
  end if
end if

if ty=3 then
  if jf*bs>pcentum then
    Response.Write("<script>alert('�ϼ����ֲ����һ���');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
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
    response.write("<script>alert('����ģ��Ϊ�գ������Է��ͣ�');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
    response.End()
  end if
  rs.close
end if

select case acttype
case 0 suretj=days&"������Ч"
case 1 suretj="��ֹ"&closedate&"��Ч"
case 2 suretj=begdate&"��"&enddate&"��Ч"
end select

jfid=GetId("vip_jfchange","jfid","CH",userid)
viptypeid=GetVipTypeId(depotid)
tmpticketid=trim(ticketpre)&GetTmpTicketId
'�ۻ���
sql="insert into vip_jfchange (jfid,setdate,sure,chk_sure,chk_name,sure_name,chk_date,sure_date,cr_date,cr_name,comment,d_type,mb) "&_
    "values ('"&jfid&"',getdate(),0,0,'"&username&"','"&username&"',getdate(),getdate(),getdate(),'"&username&"','���ֶһ�',"&ty&",'"&viptypeid&"')"
cn.execute sql
sql="insert into vip_jfchangesub (jfid,vipid,vipcode,centum,sums,comment,crdate) values "&_
    "('"&jfid&"','"&vipid&"','"&vipcode&"',"&-1*kjf&",0,'ȯ��"&tmpticketid&"',getdate())"
cn.execute sql

'����ȯ
verifycode=GetRndCode(6)'������֤��
sql="insert into vip_ticket (ticketid,ticket,tckname,tictypeid,dtype,ttype,sums,fbegdate,fenddate,acttype,days,closedate,begdate,enddate,"&_
    "setsure,setdepotid,setdate,signsure,sellsure,selldate,sellname,getsure,freeze,crdate,crname,vipid,comment,verifycode) values "&_
    "('"&tmpticketid&"','"&tmpticketid&"','"&ksums&"Ԫȯ','"&tictypeid&"',2,"&ttype&","&ksums&",'"&begdate&"','"&enddate&"',"&acttype&","&days&","&_
	"'"&closedate&"','"&begdate&"','"&enddate&"',1,NULL,getdate(),1,1,getdate(),'"&username&"',0,0,getdate(),'"&username&"',"&_
	"'"&vipid&"','�һ�����','"&verifycode&"')"
cn.execute sql

if (ty=3) then
   cn.execute "update vip_user set pcentum=pcentum+("&-1*kjf&") where vipid='"&vipid&"'"
end if

cn.execute "update vip_jfchange set chk_sure=1 where jfid='"&jfid&"'"
cn.execute "update vip_jfchange set sure=1 where jfid='"&jfid&"'"
 
'������
if msg and mobtel<>"" then
   tmpcontent=Replace(tmpcontent,"$Username",vipname)
   tmpcontent=Replace(tmpcontent,"$Vipcode",vipcode)
   tmpcontent=Replace(tmpcontent,"$Vipcentum",centum)
   tmpcontent=Replace(tmpcontent,"$Chgcentum",kjf)
   tmpcontent=Replace(tmpcontent,"$Chgsums",ksums)
   tmpcontent=Replace(tmpcontent,"$Ticketid",tmpticketid&",��֤��Ϊ"&verifycode)
   tmpcontent=Replace(tmpcontent,"$Ticeff",suretj)
   'sql="insert into vip_message (msg,setdate,sure,tel,crdate,crname) values "&_
   '    "('"&tmpcontent&"','"&setdate&"',0,'"&mobtel&"',getdate(),'"&username&"')"
   'cn.execute sql

   response.Write("<script>showModalDialog('sendmsg.aspx?tmpcontent="&VbsEscape(tmpcontent)&"&mobtel="&mobtel&"&verifycode="&verifycode&"', window, 'dialogWidth:350px;dialogHeight:200px;center:yes;help:no;resizable:yes;status:no');alert('�һ���ɣ�');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")

else
    response.Write("<script>alert('�һ���ɣ�');window.location.href='changeticketsub.asp?vipcode="&vipcode&"'</script>")
end if


'ȡ���е�ǰ����Ȩ�޵��û���VIP������Ȩ��
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

'�Զ�����ȯ��
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
    '��javascript�е�()��Ч
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