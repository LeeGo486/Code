<%
'ͨ�ñ������и�ִֵ��
Response.cachecontrol = "no-cache"
response.Charset = "gb2312"
dim cn
dim adCmdSPStoredProc,adParamReturnValue,adParaminput,adParamOutput,adInteger,adVarChar,adBoolean,fixval
if session("cn")="" or isnull(session("cn")) then
  if request.Cookies("cn")<>"" then
     session("cn")=request.Cookies("cn")
  else
  session.Abandon()
  response.Write "<script language='javascript'>"
  response.Write "alert('�Բ���,�Ự�ѳ�ʱ,�������µ�¼!');"
  response.Write "window.top.location.href='../../../';"
  response.Write "</script>"
  response.End()
  end if
end if


set cn=server.CreateObject("adodb.connection")
cn.open session("cn")
cn.commandtimeout=999
'cn=session("cn")
adCmdSPStoredProc = 4 
adParamReturnValue = 4 
adParaminput = 1 
adParamOutput = 2 
adInteger = 3 
adVarChar = 200
adBoolean = 11
%>
<!--#include file="../config.asp"-->
<%
Function RemoveHTML(strHTML)
	if not(isnull(strHTML)) then
		Dim objRegExp, Match, Matches 
		Set objRegExp = New Regexp 
		objRegExp.IgnoreCase = True 
		objRegExp.Global = True 
		'ȡ�պϵ�<> 
		objRegExp.Pattern = "<.+?>" 
		'����ƥ�� 
		Set Matches = objRegExp.Execute(strHTML) 
		' ����ƥ�伯�ϣ����滻��ƥ�����Ŀ 
		For Each Match in Matches 
		strHtml=Replace(strHTML,Match.Value,"") 
		Next 
		RemoveHTML=strHTML 
		Set objRegExp = Nothing 
	end if
End Function 

function GetFormid(formid)
dim tmpid
select case formid
case 2019 tmpid="6102038" '���۵�
case 2060 tmpid="6100003" '����
case 2061 tmpid="6100004" '����
case 2062 tmpid="6100005" '�ջ�
case 2063 tmpid="6100006" '�˻�����
case 2064 tmpid="6100006" '�˻�����
case 2065 tmpid="6100007" '�˻�����
case 2066 tmpid="6100011" '�̵�
case 2067 tmpid="6100008" '��������
case 2068 tmpid="6100009" '�����ջ�
case 2069 tmpid="6100010" '�����ջ�
case 2070 tmpid="6100010" '��������
case 2071 tmpid="6100010" '��������

case 2163 tmpid="6100012" '�˻����루�������̣�
case 2164 tmpid="6100012" '�˻�����(��������)
case 2165 tmpid="6100013" '�˻�����(��������)
case 2166 tmpid="6100019" '�̵���쵥

case 6100001 tmpid="6100001" '����
case 6100002 tmpid="6100002" 'ά��
case else tmpid=formid
end select
GetFormid=tmpid
end function

'�õ�Ȩ��
dim pwrin,pexport,pprint,pchk,psure,padd,pedit,pdel,punchk,punsure,pcost,pxprice,psprice,power
if session("formid")<>"" then
set power=server.createobject("adodb.recordset")
power.open "f18master.dbo.f22_getUserForm18 '"&session("dm").system_userid&"','"&GetFormid(session("formid"))&"'",cn
if not power.eof then
if not isNull(power("pwrin")) then pwrin=cdbl(power("pwrin")) else pwrin=false end if
if not isNull(power("pexport")) then pexport=cdbl(power("pexport")) else pexport=false end if
if not isNull(power("pprint")) then pprint=cdbl(power("pprint")) else pprint=false end if
if not isNull(power("pchk")) then pchk=cdbl(power("pchk")) else pchk=false end if
if not isNull(power("psure")) then psure=cdbl(power("psure")) else psure=false end if
if not isNull(power("padd")) then padd=cdbl(power("padd")) else padd=false end if
if not isNull(power("pedit")) then pedit=cdbl(power("pedit")) else pedit=false end if
if not isNull(power("pdel")) then pdel=cdbl(power("pdel")) else pdel=false end if
if not isNull(power("punchk")) then punchk=cdbl(power("punchk")) else punchk=false end if
if not isNull(power("punsure")) then punsure=cdbl(power("punsure")) else punsure=false end if
if not isNull(power("pwr_cost")) then pcost=cdbl(power("pwr_cost")) else pcost=false end if
if not isNull(power("pwr_price")) then pxprice=cdbl(power("pwr_price")) else pxprice=false end if
if not isNull(power("pwr_sprice")) then psprice=cdbl(power("pwr_sprice")) else psprice=false end if
end if
power.close
set power=nothing
end if

'�û�����Ȩ��
if pexport and session("dm").Get_UserPower(1)="True" then pexport=true else pexport=false end if 
if pprint and session("dm").Get_UserPower(2)="True" then pprint=true else pprint=false end if 
if pchk and session("dm").Get_UserPower(3)="True" then pchk=true else pchk=false end if 
if psure and session("dm").Get_UserPower(4)="True" then psure=true else psure=false end if 
if padd and session("dm").Get_UserPower(5)="True" then padd=true else padd=false end if 
if pdel and session("dm").Get_UserPower(6)="True" then pdel=true else pdel=false end if 
if punchk and session("dm").Get_UserPower(7)="True" then punchk=true else punchk=false end if 
if punsure and session("dm").Get_UserPower(8)="True" then punsure=true else punsure=false end if 
if pxprice and session("dm").Get_UserPower(9)="True" then pxprice=true else pxprice=false end if 
if psprice and session("dm").Get_UserPower(10)="True" then psprice=true else psprice=false end if 
if pcost and session("dm").Get_UserPower(11)="True" then pcost=true else pcost=false end if 

'ȡ��boxid****************************************************************************************************
function getboxid()
if session("boxid")="" then
  session("boxid")=1
end if
session("boxid")=cint(session("boxid"))+1
getboxid=session("boxid")
end function


'����VIP��ID
function getVipid(str)
	getVipid = str&r2(year(now())-2000)&r2(month(now()))&r2(day(now()))&replace(RndNumber(9,1)&r2(RndNumber(99,10)),"4","8")
end function

'��������ʱ,������ˮ��
'����,��ID�ֶ���,��ͷ��������ĸ,�û�ID

function GetId(TableName,PkName,Fchar,UserId)
 dim rs10
 
 TableName=Trim(TableName)
 PkName=Trim(PkName)
 Fchar=Trim(Fchar)
 UserId=trim(UserId)
 
 if TableName=null or TableName="" then
   Err.Raise 50001,"function.GetId","��������Ϊ��!"
 end if
 if PkName=null or PkName="" then
   Err.Raise 50001,"function.GetId","�ֶ�������Ϊ��!"
 end if
 if Fchar=null or Fchar="" then
   Err.Raise 50001,"function.GetId","ǰ������ĸ����Ϊ��!"
 end if
 if UserId=null or UserId="" then
   Err.Raise 50001,"function.GetId","�û�ID����Ϊ��!"
 end if
   
 set rs10=server.createobject("adodb.recordset")
 rs10.open "f18_getid '"&TableName&"','"&PkName&"','"&Fchar&"','"&UserId&"'",cn
 if isnull(rs10(0)) then
   getid=rs10(1)&"-0001"
 else
   getid=rs10(1)&"-"&right("0000"+trim(cstr(cint(right(rs10(0),4))+1)),4)
 end if
 
 rs10.close
 set rs10=nothing
end function

'������������lookupidĬ��Ϊ4001,s_lookupidΪ���е���֮��������,Ϊ0����ʾ����
'ֵΪID
function getLookup(lookupid,s_lookupid)
 dim sql,rs
 s_lookupid=cint(s_lookupid)
 set rs=server.createobject("adodb.recordset")
 sql="select * from j18_lookupsub where lookupid="&lookupid&" order by lookcode"
 rs.open sql,cn
  response.write "<select name='selltype'>"
 while not rs.eof
  if rs("lookupid")=s_lookupid then
    response.write "<option value='"&rs("lookupid")&"' selected>"&rs("lookname")&"</option>"
  else
    response.write "<option value='"&rs("lookupid")&"'>"&rs("lookname")&"</option>"
  end if	
  rs.movenext
 wend
 response.write "</select>"
 rs.close
 set rs=nothing
end function

'������������lookupidĬ��Ϊ4001,s_lookupidΪ���е���֮��������,Ϊ0����ʾ����
'ֵΪname
function getLookupByName(lookupid,lookname)
 dim sql,rs
 set rs=server.createobject("adodb.recordset")
 sql="select * from j18_lookupsub where lookupid="&lookupid&" order by lookcode"
 rs.open sql,cn
  response.write "<select name='selltype'>"
 while not rs.eof
  if trim(rs("lookname"))=trim(lookname) then
    response.write "<option value='"&rs("lookname")&"' selected>"&rs("lookname")&"</option>"
  else
    response.write "<option value='"&rs("lookname")&"'>"&rs("lookname")&"</option>"
  end if	
  rs.movenext
 wend
 response.write "</select>"
 rs.close
 set rs=nothing
end function

function getLookupByName2(lookupid,lookname,selectname)
 dim sql,rs
 set rs=server.createobject("adodb.recordset")
 sql="select * from j18_lookupsub where lookupid="&lookupid&" order by lookcode"
 rs.open sql,cn
  response.write "<select name='"&selectname&"'><option value=''></option>"
 while not rs.eof
  if trim(rs("lookname"))=trim(lookname) then
    response.write "<option value='"&rs("lookname")&"' selected>"&rs("lookname")&"</option>"
  else
    response.write "<option value='"&rs("lookname")&"'>"&rs("lookname")&"</option>"
  end if	
  rs.movenext
 wend
 response.write "</select>"
 rs.close
 set rs=nothing
end function

'getLookupByName 4001,1 
'�������ߴ������ŵ��ַ���
function qts(s)
  qts="'"& s &"'"
end function

'ҳβ���ú���,��������������
Function foot()
  on error resume next
  cn.close
  set cn=nothing
End Function

'��ʽ�������ַ���
function get_date(tdate)
  dim y,m,d
  y=year(tdate)
  m=month(tdate)
  d=day(tdate)
  m=cint(m)
  d=cint(d)
  if m<10 then m="0"&m
  if d<10 then d="0"&d
  d=y & "-" & m & "-" & d
  get_date=d
end function

'
function get_datetime(tdate, t)
  dim y,m,d
  y=year(tdate)
  m=month(tdate)
  d=day(tdate)
  m=cint(m)
  d=cint(d)
  if m<10 then m="0"&m
  if d<10 then d="0"&d
  d=y & "-" & m & "-" & d

	
	if t=2 then
		get_datetime=d&" 23:59:59"
	else
		get_datetime=d&" 00:00:00"
	end if
End function

'ʱ��׼ȷ����
function get_datetimesecond(tdate)
  dim y,m,d,h,m2,s
  y=year(tdate)
  m=month(tdate)
  d=day(tdate)
  m=cint(m)
  d=cint(d)
  if m<10 then m="0"&m
  if d<10 then d="0"&d
  d=y & "-" & m & "-" & d
  
  get_datetimesecond=d&" "&time()

End function

'��ʽ��ʱ���ַ���
function get_time(ttime)
  dim h,m,s
  h=hour(ttime)
  m=minute(ttime)
  s=second(ttime)
  h=cint(h)
  m=cint(m)
  s=cint(s)
  s=h & ":" & m & ":" & s
  get_time=s
end function

'ȡ����ʾҳ�泣�����
Sub getParam()
  dim e
  rq1=trim(request.QueryString("rq1"))
  rq2=trim(request.QueryString("rq2"))
  stype=trim(request.QueryString("stype"))
  Userid=session("dm").System_UserId
  ext=trim(request.QueryString("ext"))
  if rq1="" then
    rq1=date-30
  end if
  if rq2="" then
    rq2=date
  end if
  if stype="" then
    stype=0
  end if
  if ext<>"" then
    e=split(ext,",")
    if stype="2" then
      ext=trim(e(0))
	else
	  ext=trim(e(ubound(e)))
	end if
  end if
  ext=replace(ext,",","")
End Sub

'ִ�����رմ��ڵĺ���
Sub close(str)
  response.Write("<script type='text/javascript'>")
  response.Write("alert('"& str &"');window.close();")
  response.Write("</script>")
  response.End()
End Sub

Sub zclose()
  response.Write("<script language='javascript'>")
  response.Write("window.close();")
  response.Write("</script>")
  response.End()
End Sub

sub mbox(str)
  response.write "<script language=""javascript"">"
  response.write "alert("""&str&""");"
  response.write "window.history.back();"
  response.write "</script>"
  response.end
end sub

sub jbox(str)
  response.write "<script language=""javascript"">"
  response.write "alert("""&str&""");"
  response.write "location.href=document.referrer;"
  response.write "</script>"
  response.end
end sub

sub ebox(str)
  response.write "<script language=""javascript"">alert("""&str&""");</script>"
  response.end
end sub

sub confirmbox(str)
  response.write "<script language=""javascript"">alert("""&str&""");</script>"
  response.end
end sub



'���������
Function RndNumber(Min,Max) 
Randomize 
RndNumber=Int((Max - Min + 1) * Rnd() + Min) 
End Function 




'Ȩ�޿���
Function gant(fid,userid)
  Dim ds,cd,f22gant(15),i,tmp,max
  'userid=Session("dm").System_userid
  'userid="1002"
  max=13
  'if session("dm").System_UserAdmin=1 then
    for i=0 to max
	  f22gant(i)=1
	next
  'else
  '  set cd=server.CreateObject("ADODB.Command")
  '  cd.ActiveConnection=cn
  '  cd.CommandType=4
  '  cd.CommandText="aspnetdb.dbo.A380_getuserform18"
  '  cd.Parameters.Append cd.CreateParameter("@userid", adVarchar, adParamInput, 10, userid)
  '  cd.Parameters.Append cd.CreateParameter("@billid", adInteger, adParamInput, 4, fid)
  '  set ds=cd.Execute
  '  if ds.eof then '�����ѯ���Ϊ��
  '   for i=0 to max
  '     f22gant(i)=1 'Ĭ��ȫ����Ȩ��
  '   next
  '  else '����
'	  for i=0 to max
'	    tmp=ds(i)
'        if isnull(tmp) then
'		  tmp=0
'		elseif tmp=true then
'		  tmp=1
'		else
'		  tmp=0
'		end if
'		f22gant(i)=tmp
'	  next
'    end if
'    set ds=nothing
'    set cd=nothing
'  end if
  gant=f22gant
End Function 

Function getGant(str,opt,formid)
  dim userid,gg,i,msg
  userid=Session("dm").System_userid
  'formid=session("formid")
  if userid="" or isnull(userid) then
    response.Write("<script language='javascript'>alert('�������µ�¼!');window.location.href='login.asp';</script>")
	response.end
  end if
  gg=gant(formid,userid)
  select case str
  case "search"
    i=13
	msg="��ѯ"
  case "create"
    i=4
	msg="���"
  case "edit"
    i=5
	msg="�޸�"
  case "del"
    i=6
	msg="ɾ��"
  case "chksure"
    i=2
	msg="���"
  case "unchksure"
    i=7
	msg="�����"
  case "sure"
    i=3
	msg="����"
  case "unsure"
    i=8
	msg="������"
  case "sprice"
    i=11
	msg="�ּ�"
  case "price"
    i=10
	msg="ԭ��"
  case "cost"
    i=9
	msg="�ɱ���"
  case "print"
    i=1
	msg="��ӡ"
  case "export"
    i=0
	msg="����"
  end select
  
  if opt=0 then
    if gg(i)=0 then
      response.Write("<script language='javascript'>alert('�Բ���,��û�� "& msg &" Ȩ��!');window.close();</script>")
	  response.end
    end if
  elseif opt=1 then
    if gg(i)=0 then
      response.Write("<script language='javascript'>alert('�Բ���,��û�� "& msg &" Ȩ��!');window.history.back();</script>")
	  response.end
    end if
  else
    if gg(i)=0 then
      getGant=false
	else
	  getGant=true
    end if
  end if
End Function

'��ʽ���ַ���
Function StrFormat(str,length)
  dim i,s
  str=trim(str)
  for i=0 to length-len(str)
    s=s&"&nbsp;"
  next
  StrFormat=str&s
End Function


'�����������
 '����Ŀ�����ø����ͻ���ͬ����������λ����(ϵͳĬ����������λ��ΪС�������λ)
   
	  '��дֵ   ϵͳ��������λ��
      '1000     �������뵽ʮλ
      '100      �������뵽��λ
      '10       �������뵽С����1λ
      '1����   �������뵽С�����2λ
      '����Ŀ��������[Ԥ������]->[ȫ�ֿ���]�����У�ѡ��Ӧ��[��������]����Ч��

	  '0:�������� 1:ֻ�벻�� 2:ֻ�᲻�� 3:����
	  '��������
function getFormatNumber(val)
  val=cdbl(val)
  if  session("roundtype")=0 and  session("roundcnt")>0 then
	select case session("roundcnt")
	 'ʮλ
	  case 1000 
	    val=val/100 
	    val=FormatNumber(val,1)
		val=val*100
	 '��λ
	  case 100  
		val=val/10
    	val=FormatNumber(val,1)
		val=val*10
	  case 10   
	    val=FormatNumber(val,1)
	  end select   
  end if
   
  if  session("roundtype")=1  then
	select case session("roundcnt")
	 'ʮλ
	  case 1000 
	    val=val/10 
		fixval=fix(val)
		if val-fixval>0 then 
		  val=fixval+1
		  val=val*10
		else
		  val=val*10
		end if   
	  		
	 '��λ
	  case 100  
	  	fixval=fix(val)
	   	if val-fixval>0 then 
		  val=fixval+1
		else
		  val=fixval  
		end if
	 
	  'ֻ�벻�ᵽС����1λ 	
	  case 10
	    val=val*10   
	    fixval=fix(val)
		if val-fixval>0 then 
		  val=fixval+1
		  val=val/10
		else
		  val=val/10  
		end if
		
	  case else
	    val=val*100   
	    fixval=fix(val)
		if val-fixval>0 then 
		  val=fixval+1
		  val=val/100
		else
		  val=val/100
		end if
	  end select   
  end if
  
  'ֻ�᲻��
  if  session("roundtype")=2  then
	select case session("roundcnt")
	 'ʮλ
	  case 1000 
	    val=val/10 
		fixval=fix(val)
		val=fixval*10
	  		
	 '��λ
	  case 100  
	  	val=fix(val)
	  case 10
	    val=val*10   
	    fixval=fix(val)
		val=fixval/10
				
	  case else
	    val=val*100   
	    fixval=fix(val)
		val=fixval/100
	  end select   
  end if
  
  getFormatNumber=val
  
end function


'�Ƶ�ѡ���ջ��غͷ�����,���������ʱ����
Sub SelectSF()
  with response 
    .write "function selectMD(str){"
    .write "var m=showModalDialog('SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;center: yes;help:no;resizable:yes;status:no');"
    .write "var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;"
    .write "  if(str=='sd' || str=='out_sd'){"
    .write "   try{"
    .write "	arr=m.split(',');"
    .write "	id=arr[0];"
    .write "	sdptname=arr[1];"
    .write "	document.form1.set_depotid.value=id;"
    .write "	document.form1.sdptname.value=sdptname;"
    .write "	}catch(ex){}"
    .write "  }else"
    .write "   if(str=='sm'){"
    .write "	try{"
    .write "	arr=m.split(',');"
    .write "	get_depotid=arr[0];"'//�ֿ�ID
    .write "	edptname=arr[1];"'//�ֿ���
    .write "	get_mchid=arr[2];"'//����ID,�������
    .write "	parentid=arr[3];"'//һ�����
    .write "	set_sums=arr[4];"'//һ�����
    .write "	get_sums=arr[5];"'//һ�����
    .write "	document.form1.get_depotid.value=get_depotid;"
    .write "	document.form1.edptname.value=edptname;"
    .write "	document.form1.get_mchid.value=get_mchid;"
    .write "	document.form1.parentid.value=parentid;"
    .write "	document.form1.set_sums.value=set_sums;"
    .write "	document.form1.get_sums.value=get_sums;"
    .write "	}catch(ex){}"
    .write "  }"
    .write "}"
  end with
End Sub

'�Ƶ�ѡ���ջ��غͷ�����,���ƶ���ʱ����
Sub SelectSFdh()
  with response 
    .write "function selectMD(str){"
    .write "var m=showModalDialog('SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;center: yes;help:no;resizable:yes;status:no');"
    .write "var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid,set_sums,get_sums;"
    .write "  if(str=='sd' || str=='sd&zb=1'  || str=='out_sd'){"
    .write "   try{"
    .write "	arr=m.split(',');"
    .write "	id=arr[0];"
    .write "	sdptname=arr[1];"
    .write "	document.form1.depotid.value=id;"
    .write "	document.form1.sdptname.value=sdptname;"
    .write "	}catch(ex){}"
    .write "  }else"
    .write "   if(str=='sm'){"
    .write "	try{"
    .write "	arr=m.split(',');"
    .write "	get_depotid=arr[0];"'//�ֿ�ID
    .write "	edptname=arr[1];"'//�ֿ���
    .write "	get_mchid=arr[2];"'//����ID,�������
    .write "	parentid=arr[3];"'//һ�����
    .write "	set_sums=arr[4];"'//һ�����
    .write "	get_sums=arr[5];"'//һ�����
    .write "	document.form1.get_depotid.value=get_depotid;"
    .write "	document.form1.edptname.value=edptname;"
    '.write "	document.form1.get_mchid.value=get_mchid;"
    .write "	document.form1.merchantid.value=get_mchid;"
    .write "	document.form1.parentid.value=parentid;"
    .write "	document.form1.set_sums.value=set_sums;"
    .write "	document.form1.get_sums.value=get_sums;"
    .write "	}catch(ex){}"
    .write "  }"
    .write "}"
  end with
End Sub

'ȡ����Ա
Function s_name1(depotid)
  dim ds
  set ds=server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.Source="Select userid,username from j_user where depotid="&qts(depotid)
  ds.open
  response.Write "<select name='s_name' id='s_name' style='width:160px; '>"
  response.Write "<option value='' selected></option>"
  while not ds.eof
    response.Write "<option value='"&ds("username")&"'>"&ds("username")&"</option>"
    ds.movenext
  wend
  response.Write "</select>"
  ds.close
  set ds=nothing
End Function

'ȡ����Ա
Function x_name1(depotid)
  dim ds
  set ds=server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.Source="Select distinct names,employeeid,a.groupid,groupname from j_employee a,jk_group b where a.groupid=b.groupid and a.depotid='"&depotid&"'"
  ds.open
  response.Write "<select name='x_name' id='x_name' style='width:160px; '>"
  response.Write "<option value='' selected></option>"
  while not ds.eof
    response.Write "<option value='"&ds("groupname")&"'>"&ds("names")&"</option>"
    ds.movenext
  wend
  response.Write "</select>"
  ds.close
  set ds=nothing
End Function

'���������¼
Function savetmlist(djid,tmid,clothingid,typeid)
 
  if cdbl(typ)=1 then
    dim ds
    set ds=server.createobject("adodb.recordset")
    ds.ActiveConnection=cn
    ds.source = "select 1 from t18_tmlist where tmlistId='"&djid&"' and tmid='"&tmid&"' and isnull(typeid,0)="&typeid
    ds.open
    if ds.eof then
      cn.execute "insert into t18_tmlist (tmlistId, tmid, clothingid, CrName,typeid) values ('"&djid&"','"&tmid&"','"&clothingid&"','"&session("dm").System_UserName&"',"&typeid&")"
    end if
    ds.close
    set ds=nothing
  else
    cn.execute "delete from t18_tmlist where tmlistId='"&djid&"' and tmid='"&tmid&"' and isnull(typeid,0)="&typeid
  end if  
End Function

function cbanner(str)
  response.Write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"" bordercolor=""#EDD8D3"" bgcolor=""#EDD8D3"" class=""bar"">"
  response.Write "<tr>"
  response.Write "  <td height=""19"" valign=""bottom"" class=""f12"">ҵ������ &gt;&gt; "
  dim ds
  set ds=server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.Source = "select distinct a.menuname,a.menuid,b.menusubname,b.menusubid from web_menu a ,web_menusub b where a.menuid=b.menuid and formid="&session("com")
  ds.open
  if not ds.eof then
    response.Write ds("menuname") 
	response.Write "&gt;&gt; <a href=""f22_index.asp?com="&session("com")&"&msid="&session("menusubid")&""">"
	response.Write "<span class=""au"">"&ds("menusubname")&"</span></a>"
  end if
  ds.close
  set ds=nothing
  response.Write server.HTMLEncode(str)
  response.Write "</td>"
  response.Write "</tr>"
  response.Write "</table>"
end function

function de(s)
 response.Write("<textarea cols=50 rows=12>"&s&"</textarea>")
 response.End()
end function

function r2(str)
	if len(str)=1 then str="0"&str
	r2 = str
end function

'����һ������
function reNull(str)
	str=trim(str)
	if isNull(str) or isEmpty(str) or str="" then
		str=0
	elseif not isNumeric(str) then
		str=0
	else
		str=cdbl(str)
	end if
	reNull = str
end function

function getvip(vipid)
dim str,i,j
if request.cookies("vipflash")("cut")=1 then 
   i=cdbl(request.cookies("vipflash")("beg"))-1
   for j=1 to i
     str=str&"*"
   next
   getvip=str&vipid
else 
   getvip=vipid end if
end function

'ȡVIP������
sub get_viptype(typeid,zcentum)
dim sqlstr

	if zcentum="" and typeid<>"" then
		sql="select viptypeid,viptypename,levelsums from vip_typevip where viptypeid="&qts(typeid)
	elseif zcentum="" then
		'ǰ̨����ʱֻ��ʾ��ʱ��
		sql="select viptypeid,viptypename,levelsums from vip_typevip where isnull(dummycard,0)=1 order by levelsums"
	else
		sql=" select a.viptypeid,a.viptypename,(isnull(a.levelsums,0)-isnull(b.levelsums,0)) as levelsums from vip_typevip a,vip_typevip b "&_
				" where isnull(a.levelsums,0)>=isnull(b.levelsums,0) "&_
				" and (isnull(a.levelsums,0)-isnull(b.levelsums,0))<="&zcentum&" "&_
				" and b.viptypeid="&qts(typeid)&" order by a.levelsums"
	end if
	rs.open sql,cn,1,1
		do while not rs.eof
		response.write"<option value="&rs(0)
		if rs(0)=typeid then response.Write" selected " end if
		response.write">"
		response.write rs(1)
		if zcentum<>"" then response.write"����Ҫ���֣�"&rs(2)&"��"
		response.write"</option>"
		rs.movenext
		loop
	rs.close
end sub

'ȡ�¾�VIP
function chkvip(vipcode,t)
	if session("cf_VipSet_syjm") then
		chkvip = "select distinct a.vipid,a.vipname,a.vipsex,a.vipbirth,b.vipcardid,isnull(b.vipcentum,0) as vipcentum,"&_
				" b.vipsums,isnull(a.centum,0)+isnull(b.starcentum,0) as centum,isnull(tempcard,0) as tempcard,"&_
				" isnull(a.sums,0)+isnull(b.starsums,0) as sums,b.begdate,b.enddate,isnull(a.pcentum,0) as pcentum "&_
				" from vip_user a,vip_cardvip b, vip_rate c ,vip_ratesub d,vip_typevip e "&_
				" where a.vipcode="&qts(vipcode)&" and a.vipcode=b.vipcardid "&_
				" and b.viptypeid=e.viptypeid and c.viptypename=e.viptypename "&_ 
				" and convert(char(10),b.vipemit+isnull(b.limitday,0),126)>=convert(char(10),getdate(),126) "&_
				" and convert(char(10),isnull(b.viplastdate,getdate())+isnull(b.maxday,0),126)>=convert(char(10),getdate(),126)"
	else
		chkvip = " select a.vipid,a.vipname,a.vipsex,a.vipbirth,b.vipcardid,isnull(b.vipcentum,0) as vipcentum,"&_
				" b.vipsums,isnull(a.centum,0)+isnull(b.starcentum,0) as centum,isnull(tempcard,0) as tempcard,"&_
				" isnull(a.sums,0)+isnull(b.starsums,0) as sums,b.begdate,b.enddate,isnull(a.pcentum,0) as pcentum "&_
				" from vip_user a,vip_cardvip b,vip_rate c ,vip_ratesub d,vip_typevip e "&_
				" where a.vipcode=b.vipcardid and b.vipcardid="&qts(vipcode)&_
				" and b.viptypeid=e.viptypeid and c.viptypename=e.viptypename "&_
				" and convert(char(10),b.vipemit+isnull(b.limitday,0),126)>=convert(char(10),getdate(),126)"&_
				" and convert(char(10),isnull(b.viplastdate,getdate())+isnull(b.maxday,0),126)>=convert(char(10),getdate(),126)"
				
	end if
	
end function


Sub GetPriceType(djid,op)
Dim RR,SS
set RR=server.createobject("adodb.recordset")
select case op
case "indent"
  SS="select a.m_type,b.d_type from j_depot a,d_indent b where a.depotid=b.depotid and b.indentid='"&(djid)&"'"
case "quota"
  SS="select a.m_type,1 as d_type from j_depot a,d_quota b where a.depotid=b.set_depotid and b.quotaid='"&(djid)&"'"
case "sell"
  SS="select a.m_type,1 as d_type from j_depot a,d_sell b where a.depotid=b.get_depotid and b.sellid='"&(djid)&"'" '�ջ�ȡget_depotid
case "move"
  SS="select a.m_type,1 as d_type from j_depot a,d_move b where a.depotid=b.get_depotid and b.moveid='"&(djid)&"'" 
case "retail"
  SS="select 2 as m_type,1 as d_type from j_depot a,d_retail b where a.depotid=b.depotid and b.retailid='"&(djid)&"'"
case "outindent"
  SS="select a.m_type,2 as d_type from j_depot a,d_outindent b where a.depotid=b.depotid and b.outindentid='"&(djid)&"'"
case "outindentPRO"
  SS="select a.m_type,2 as d_type from j_depot a,d_outindentpro b where a.depotid=b.depotid and b.outindentid='"&(djid)&"'"
case "outindentsq"
  SS="select a.m_type,2 as d_type from j_depot a,d_outindentsq b where a.depotid=b.depotid and b.outindentsqid='"&(djid)&"'"
case "outindentCHK"
  SS="select a.m_type,2 as d_type from j_depot a,d_outindentchk b where a.depotid=b.depotid and b.outindentid='"&(djid)&"'"
case "outindentset"
  SS="select a.m_type,2 as d_type from j_depot a,d_outindentset b where a.depotid=b.depotid and b.outindentid='"&(djid)&"'"
case "inventory"
  SS="select 2 as m_type,1 as d_type from j_depot a,d_inventory b where a.depotid=b.depotid and b.inventoryid='"&(djid)&"'"
case "msell"
  SS="select 1 as m_type,2 as d_type from j_depot a,d_msell b where a.depotid=b.get_depotid and b.msellid='"&(djid)&"'" '������������ȡ
case "outindentpro"
  SS="select a.m_type,2 as d_type from j_depot a,d_outindentpro b where a.depotid=b.depotid and b.outindentid='"&(djid)&"'"
case else
  call close("opt= "&op&" ��������!")
end select
if SS<>"" then
   RR.open SS,cn,1,1
   'ԭ���ֿܲ��Ե��������̣��������ƣ���Ϊ����
   'if cdbl(RR("m_type"))=0 or cdbl(RR("m_type"))=1 or op="move" then 
   if cdbl(RR("m_type"))=0 or cdbl(RR("m_type"))=1 then 
      response.cookies("GetPriceType")("T1")=2   '������������֣ܲ�ȡ����������
   else
      response.cookies("GetPriceType")("T1")=1   '�����ȡ���̱��������
   end if
   if cdbl(RR("d_type"))=1 then
      response.Cookies("GetPriceType")("T2")=0   '�жϵ������ͣ���Ҫ�Ƕ�����������Ϊ1��ȡ�����ۿ�
   else
      response.Cookies("GetPriceType")("T2")=1   '����ȡ�����ۿ�
   end if
   RR.close
else
   response.cookies("GetPriceType")("T1")=2
   response.Cookies("GetPriceType")("T2")=0
end if

set RR=nothing
End Sub

sub CheckBrand()
'�Ƿ����Ʒ������BEGIN
dim ds,sql
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn

'�Ƿ����Ʒ������
if session("stylepower")=1 then

     sql = " select b.styleid from J_clothing a inner join j_style b on a.styleid=b.styleid "&_
  		" inner join j_branddepot c on b.brandid=c.drandid "&_
		" inner join j_branddepot d on b.brandid=d.drandid "&_
		" where (clothingid='"&trim(clothingid)&"' or "&_
		" oldclothingid='"&trim(clothingid)&"')"&_
		" and c.depotid='"&session("get_depotid")&"'"&_
    	" and d.depotid='"&session("set_depotid")&"'"

  'sql = "select a.styleid from j_style a inner join j_branddepot b on a.brandid=b.drandid "&_
	'			"where (a.styleid='"&trim(styleid)&"' or a.helpid='"&trim(styleid)&"') and b.depotid='"&trim(depotid)&"'"
  ds.source =sql
  ds.open
  if ds.eof then
     ds.close
     set ds=nothing
     'call close(clothingid&" �ջ���û�д˿�ʽ�ľ�ӪȨ��!")
	 response.Write("StylePower")
	 response.End()
  else
    ds.close
	set ds=nothing
  end if

end if
end sub
'��ʽ��ӪƷ��END

sub CheckBrandForSytle()
'�Ƿ����Ʒ������BEGIN
dim ds,sql
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn

'�Ƿ����Ʒ������
if session("stylepower")=1 then

     sql = " select b.styleid from  j_style b  "&_
  		" inner join j_branddepot c on b.brandid=c.drandid "&_
		" inner join j_branddepot d on b.brandid=d.drandid "&_
		" where styleid='"&trim(styleid)&"' "&_
		" and c.depotid='"&session("get_depotid")&"'"&_
    	" and d.depotid='"&session("set_depotid")&"'"

  'sql = "select a.styleid from j_style a inner join j_branddepot b on a.brandid=b.drandid "&_
	'			"where (a.styleid='"&trim(styleid)&"' or a.helpid='"&trim(styleid)&"') and b.depotid='"&trim(depotid)&"'"
  ds.source =sql
  ds.open
  if ds.eof then
     ds.close
     set ds=nothing
     call close(clothingid&" �ջ���û�д˿�ʽ�ľ�ӪȨ1��!")
	
	 response.End()
  else
    ds.close
	set ds=nothing
  end if

end if
end sub
'��ʽ��ӪƷ��END

'������ˮ����BEGIN
sub CheckFlow(typeid)
if session("iftmlist")=1 and round(tmln)>0 and cdbl(typ)=1 then
  dim ds,sql
  set ds=Server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn

  sql = "select  top 1 tmid from t18_tmlist where tmlistId='"&id&"' and tmid='"&oldclothingid&"' and isnull(typeid,0)="&typeid
  ds.source =sql
  ds.open
  if not ds.eof or not ds.Eof then
     ds.close
     set ds=nothing
	 response.Write("flow")
	 response.End()
  else
    ds.close
	set ds=nothing
  end if
end if
'������ˮ����END
end sub

Function GetRndCode(maxLen)
   Dim strNewPass,whatsNext,upper,lower,intCounter
   Randomize
   For intCounter = 1 To maxLen
    whatsNext = Int((1 - 0 + 1) * Rnd + 0)
    If whatsNext = 0 Then
     upper = 90
     lower = 65
    Else
     upper = 57
     lower = 48
    End If
    strNewPass = strNewPass & Chr(Int((upper - lower + 1) * Rnd + lower))
   Next
   GetRndCode = strNewPass
  End Function
%>