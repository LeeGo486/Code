<%'ͨ�ñ������и�ִֵ��
Response.cachecontrol = "no-cache"
dim cn
'dim adCmdSPStoredProc,adParamReturnValue,adParaminput,adParamOutput,adInteger,adVarChar,adBoolean
set cn=server.createobject("ADODB.Connection")
cn.open session("cn")
cn.commandtimeout=999
Const adStateClosed = 0
Const adOpenForwardOnly = 0, adOpenKeyset = 1, adOpenDynamic = 2, adOpenStatic = 3
Const adLockReadOnly = 1, adLockPessimistic = 2, adLockOptimistic = 3, adLockBatchOptimistic = 4
Const adCmdText = 1, adCmdTable = 2, adCmdSPStoredProc = 4, adExecuteNoRecords = 128
Const adBigInt = 20, adBoolean = 11, adChar = 129, adDate = 7, adInteger = 3, adSmallInt = 2, adTinyInt = 16, adVarChar = 200,adNumeric = 131
const adParamInput = 1, adParamOutput = 2, adParamInputOutput = 3, adParamReturnValue = 4

dim msid
msid=trim(request.QueryString("msid"))

'�õ�Ȩ��
dim pwrin,pexport,pprint,pchk,psure,padd,pedit,pdel,punchk,punsure,pcost,pxprice,psprice,power
if session("formid")<>"" then
set power=server.createobject("adodb.recordset")
power.open "f18master.dbo.f22_getUserForm18 '"&session("dm").system_userid&"','"&session("formid")&"'",cn
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

'ȡ����ʾҳ�泣�����
Sub getParam()
  rq1=trim(request.QueryString("rq1"))
  rq2=trim(request.QueryString("rq2"))
  stype=trim(request.QueryString("stype"))
  Userid=session("dm").System_UserId
  ext=trim(request.QueryString("ext"))
End Sub

'ִ�����رմ��ڵĺ���
Sub close(str)
  response.Write("<script language='javascript'>")
  response.Write("alert('"& str &"');window.close();")
  response.Write("</script>")
End Sub

'Ȩ�޿���
Function gant(fid,userid)
  Dim ds,cd,f22gant(15),i,tmp,max
  'userid=Session("dm").System_userid
  'userid="1002"
  max=13
  if userid="" or isnull(userid) then
    response.Write("<script language='javascript'>alert('�������µ�¼!');window.location.href='login.asp';</script>")
	response.end
  end if
  if session("dm").System_UserAdmin=1 then
    for i=0 to max
	  f22gant(i)=1
	next
  else
    set cd=server.CreateObject("ADODB.Command")
    cd.ActiveConnection=cn
    cd.CommandType=4
    cd.CommandText="f22_getuserform18"
    cd.Parameters.Append cd.CreateParameter("@userid", adVarchar, adParamInput, 10, userid)
    cd.Parameters.Append cd.CreateParameter("@billid", adInteger, adParamInput, 4, session("formid"))
    set ds=cd.Execute
    if ds.eof then '�����ѯ���Ϊ��
     for i=0 to max
       f22gant(i)=0
     next
    else '����
	  for i=0 to max
	    tmp=ds(i)
        if isnull(tmp) then
		  tmp=0
		elseif tmp=true then
		  tmp=1
		else
		  tmp=0
		end if
		f22gant(i)=tmp
	  next
    end if
    set ds=nothing
    set cd=nothing
  end if
  gant=f22gant
End Function 

Function getGant(str,opt)
  dim userid,formid,gg,i,msg
  userid=Session("dm").System_userid
  formid=session("formid")
  gg=gant(formid,userid)
  select case str
  case "search"
    i=13
	msg="��ѯ"
  case "add"
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

'�Ƶ�ѡ���ջ��غͷ�����,���������ʱ����
Sub SelectSF()
  with response 
    .write "function selectMD(str){"
    .write "var m=showModalDialog('SelectMD.asp?action='+str,'SelectDepot','dialogWidth:780px;dialogHeight:'+(screen.height-350)+'px;center: yes;help:no;resizable:yes;status:no');"
    .write "var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;"
    .write "  if(str=='sd'){"
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
    .write "	document.form1.get_depotid.value=get_depotid;"
    .write "	document.form1.edptname.value=edptname;"
    .write "	document.form1.get_mchid.value=get_mchid;"
    .write "	document.form1.parentid.value=parentid;"
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
    .write "var arr,id,set_depotid,get_depotid,sdptname,edptname,get_mchid,parentid;"
    .write "  if(str=='sd'){"
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
    .write "	document.form1.get_depotid.value=get_depotid;"
    .write "	document.form1.edptname.value=edptname;"
    '.write "	document.form1.get_mchid.value=get_mchid;"
    .write "	document.form1.merchantid.value=get_mchid;"
    .write "	document.form1.parentid.value=parentid;"
    .write "	}catch(ex){}"
    .write "  }"
    .write "}"
  end with
End Sub

'ȡ����Ա
Function s_name(depotid)
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
Function x_name(depotid)
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

function cbanner(str)
  response.Write "<table width=""100%"" border=""0"" cellpadding=""0"" cellspacing=""0"" bordercolor=""#EDD8D3"" bgcolor=""#EDD8D3"" class=""bar"">"
  response.Write "<tr>"
  response.Write "  <td height=""19"" valign=""bottom"" class=""f12"">ҵ������ &gt;&gt; "
  dim ds
  set ds=server.CreateObject("ADODB.Recordset")
  ds.ActiveConnection = cn
  ds.Source = "select distinct a.menuname,a.menuid,b.menusubname,b.menusubid from web_menu a ,web_menusub b where a.menuid=b.menuid and menusubid="&msid
  ds.open
  if not ds.eof then
    response.Write ds("menuname") 
	response.Write "&gt;&gt; <a href=""#?com="&session("com")&"&msid="&session("menusubid")&""">"
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
%>
<!--#include file="../../config.asp"-->