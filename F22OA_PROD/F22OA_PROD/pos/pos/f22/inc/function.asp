<%
'通用变量定行赋值执行
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
  response.Write "alert('对不起,会话已超时,请您重新登录!');"
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
		'取闭合的<> 
		objRegExp.Pattern = "<.+?>" 
		'进行匹配 
		Set Matches = objRegExp.Execute(strHTML) 
		' 遍历匹配集合，并替换掉匹配的项目 
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
case 2019 tmpid="6102038" '零售单
case 2060 tmpid="6100003" '订货
case 2061 tmpid="6100004" '补货
case 2062 tmpid="6100005" '收货
case 2063 tmpid="6100006" '退货申请
case 2064 tmpid="6100006" '退货申请
case 2065 tmpid="6100007" '退货发货
case 2066 tmpid="6100011" '盘点
case 2067 tmpid="6100008" '调拨发货
case 2068 tmpid="6100009" '调拨收货
case 2069 tmpid="6100010" '跨区收货
case 2070 tmpid="6100010" '跨区发货
case 2071 tmpid="6100010" '跨区发货

case 2163 tmpid="6100012" '退货申请（分配流程）
case 2164 tmpid="6100012" '退货申请(分配流程)
case 2165 tmpid="6100013" '退货发货(分配流程)
case 2166 tmpid="6100019" '盘点差异单

case 6100001 tmpid="6100001" '收银
case 6100002 tmpid="6100002" '维修
case else tmpid=formid
end select
GetFormid=tmpid
end function

'得到权限
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

'用户个人权限
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

'取得boxid****************************************************************************************************
function getboxid()
if session("boxid")="" then
  session("boxid")=1
end if
session("boxid")=cint(session("boxid"))+1
getboxid=session("boxid")
end function


'生成VIP卡ID
function getVipid(str)
	getVipid = str&r2(year(now())-2000)&r2(month(now()))&r2(day(now()))&replace(RndNumber(9,1)&r2(RndNumber(99,10)),"4","8")
end function

'新增单据时,生成流水号
'表名,单ID字段名,开头的两个字母,用户ID

function GetId(TableName,PkName,Fchar,UserId)
 dim rs10
 
 TableName=Trim(TableName)
 PkName=Trim(PkName)
 Fchar=Trim(Fchar)
 UserId=trim(UserId)
 
 if TableName=null or TableName="" then
   Err.Raise 50001,"function.GetId","表名不能为空!"
 end if
 if PkName=null or PkName="" then
   Err.Raise 50001,"function.GetId","字段名不能为空!"
 end if
 if Fchar=null or Fchar="" then
   Err.Raise 50001,"function.GetId","前两个字母不能为空!"
 end if
 if UserId=null or UserId="" then
   Err.Raise 50001,"function.GetId","用户ID不能为空!"
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

'生成销售类型lookupid默认为4001,s_lookupid为已有单据之销售类型,为0则显示所有
'值为ID
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

'生成销售类型lookupid默认为4001,s_lookupid为已有单据之销售类型,为0则显示所有
'值为name
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
'返回两边带单引号的字符号
function qts(s)
  qts="'"& s &"'"
end function

'页尾调用函数,用于例行清理动作
Function foot()
  on error resume next
  cn.close
  set cn=nothing
End Function

'格式化日期字符串
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

'时间准确到秒
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

'格式化时间字符串
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

'取得显示页面常规参数
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

'执行完后关闭窗口的函数
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



'随机数生成
Function RndNumber(Min,Max) 
Randomize 
RndNumber=Int((Max - Min + 1) * Rnd() + Min) 
End Function 




'权限控制
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
  '  if ds.eof then '如果查询结果为空
  '   for i=0 to max
  '     f22gant(i)=1 '默认全部有权限
  '   next
  '  else '不空
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
    response.Write("<script language='javascript'>alert('请您重新登录!');window.location.href='login.asp';</script>")
	response.end
  end if
  gg=gant(formid,userid)
  select case str
  case "search"
    i=13
	msg="查询"
  case "create"
    i=4
	msg="添加"
  case "edit"
    i=5
	msg="修改"
  case "del"
    i=6
	msg="删除"
  case "chksure"
    i=2
	msg="审核"
  case "unchksure"
    i=7
	msg="反审核"
  case "sure"
    i=3
	msg="登帐"
  case "unsure"
    i=8
	msg="反登帐"
  case "sprice"
    i=11
	msg="现价"
  case "price"
    i=10
	msg="原价"
  case "cost"
    i=9
	msg="成本价"
  case "print"
    i=1
	msg="打印"
  case "export"
    i=0
	msg="导出"
  end select
  
  if opt=0 then
    if gg(i)=0 then
      response.Write("<script language='javascript'>alert('对不起,您没有 "& msg &" 权限!');window.close();</script>")
	  response.end
    end if
  elseif opt=1 then
    if gg(i)=0 then
      response.Write("<script language='javascript'>alert('对不起,您没有 "& msg &" 权限!');window.history.back();</script>")
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

'格式化字符串
Function StrFormat(str,length)
  dim i,s
  str=trim(str)
  for i=0 to length-len(str)
    s=s&"&nbsp;"
  next
  StrFormat=str&s
End Function


'四舍五入计算
 '本项目可设置各个客户不同的四舍五入位数．(系统默认四舍五入位数为小数点后两位)
   
	  '填写值   系统四舍五入位数
      '1000     四舍五入到十位
      '100      四舍五入到个位
      '10       四舍五入到小数点1位
      '1或不填   四舍五入到小数点后2位
      '本项目设置须在[预警控制]->[全局控制]界面中，选择并应用[四舍五入]方生效．

	  '0:四舍五入 1:只入不舍 2:只舍不入 3:不变
	  '四舍五入
function getFormatNumber(val)
  val=cdbl(val)
  if  session("roundtype")=0 and  session("roundcnt")>0 then
	select case session("roundcnt")
	 '十位
	  case 1000 
	    val=val/100 
	    val=FormatNumber(val,1)
		val=val*100
	 '个位
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
	 '十位
	  case 1000 
	    val=val/10 
		fixval=fix(val)
		if val-fixval>0 then 
		  val=fixval+1
		  val=val*10
		else
		  val=val*10
		end if   
	  		
	 '个位
	  case 100  
	  	fixval=fix(val)
	   	if val-fixval>0 then 
		  val=fixval+1
		else
		  val=fixval  
		end if
	 
	  '只入不舍到小数点1位 	
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
  
  '只舍不入
  if  session("roundtype")=2  then
	select case session("roundcnt")
	 '十位
	  case 1000 
	    val=val/10 
		fixval=fix(val)
		val=fixval*10
	  		
	 '个位
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


'制单选择收货地和发货地,这里是配货时调用
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
    .write "	get_depotid=arr[0];"'//仓库ID
    .write "	edptname=arr[1];"'//仓库名
    .write "	get_mchid=arr[2];"'//店铺ID,二级编号
    .write "	parentid=arr[3];"'//一级编号
    .write "	set_sums=arr[4];"'//一级编号
    .write "	get_sums=arr[5];"'//一级编号
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

'制单选择收货地和发货地,供制订单时调用
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
    .write "	get_depotid=arr[0];"'//仓库ID
    .write "	edptname=arr[1];"'//仓库名
    .write "	get_mchid=arr[2];"'//店铺ID,二级编号
    .write "	parentid=arr[3];"'//一级编号
    .write "	set_sums=arr[4];"'//一级编号
    .write "	get_sums=arr[5];"'//一级编号
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

'取收银员
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

'取销售员
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

'插入条码记录
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
  response.Write "  <td height=""19"" valign=""bottom"" class=""f12"">业务中心 &gt;&gt; "
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

'返回一个数据
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

'取VIP卡类型
sub get_viptype(typeid,zcentum)
dim sqlstr

	if zcentum="" and typeid<>"" then
		sql="select viptypeid,viptypename,levelsums from vip_typevip where viptypeid="&qts(typeid)
	elseif zcentum="" then
		'前台建卡时只显示临时卡
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
		if zcentum<>"" then response.write"（需要积分："&rs(2)&"）"
		response.write"</option>"
		rs.movenext
		loop
	rs.close
end sub

'取新旧VIP
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
  SS="select a.m_type,1 as d_type from j_depot a,d_sell b where a.depotid=b.get_depotid and b.sellid='"&(djid)&"'" '收货取get_depotid
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
  SS="select 1 as m_type,2 as d_type from j_depot a,d_msell b where a.depotid=b.get_depotid and b.msellid='"&(djid)&"'" '跨区都按机构取
case "outindentpro"
  SS="select a.m_type,2 as d_type from j_depot a,d_outindentpro b where a.depotid=b.depotid and b.outindentid='"&(djid)&"'"
case else
  call close("opt= "&op&" 参数错误!")
end select
if SS<>"" then
   RR.open SS,cn,1,1
   '原先总仓可以调拨到店铺，现已限制，改为发货
   'if cdbl(RR("m_type"))=0 or cdbl(RR("m_type"))=1 or op="move" then 
   if cdbl(RR("m_type"))=0 or cdbl(RR("m_type"))=1 then 
      response.cookies("GetPriceType")("T1")=2   '如果发货地是总仓，取机构的设置
   else
      response.cookies("GetPriceType")("T1")=1   '否则就取店铺本身的设置
   end if
   if cdbl(RR("d_type"))=1 then
      response.Cookies("GetPriceType")("T2")=0   '判断单据类型（主要是订补货单），为1的取订货折扣
   else
      response.Cookies("GetPriceType")("T2")=1   '否则取补货折扣
   end if
   RR.close
else
   response.cookies("GetPriceType")("T1")=2
   response.Cookies("GetPriceType")("T2")=0
end if

set RR=nothing
End Sub

sub CheckBrand()
'是否控制品牌销售BEGIN
dim ds,sql
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn

'是否控制品牌销售
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
     'call close(clothingid&" 收货方没有此款式的经营权限!")
	 response.Write("StylePower")
	 response.End()
  else
    ds.close
	set ds=nothing
  end if

end if
end sub
'款式经营品牌END

sub CheckBrandForSytle()
'是否控制品牌销售BEGIN
dim ds,sql
set ds=Server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn

'是否控制品牌销售
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
     call close(clothingid&" 收货方没有此款式的经营权1限!")
	
	 response.End()
  else
    ds.close
	set ds=nothing
  end if

end if
end sub
'款式经营品牌END

'条码流水码检查BEGIN
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
'条码流水码检查END
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