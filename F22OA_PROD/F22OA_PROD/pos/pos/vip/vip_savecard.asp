<%option explicit%>
<!--#include file="../f22/inc/function.asp"-->
<%
dim vipname,vipsex,vipbirth,stature,waistline,vippaper,vippassport,people,vipid,viplove,vipmin,vipmax,vipplace,vipid2'用得修改时的
dim vipoccupation,vippay,viptel,mobtel,vipemail,country,vippostalcode,vipadd,comment
dim vipgrab,vipstyle,vipsize,vipsize1,city,vipapply
dim byear,bmonth,bday,fbuyid,fbuydate,fbuysums,fremark,viptypeid
dim depotid,userid,rs
dim act,tzname,tjname,vip_pnum,i,vip_str,vip_p,vip_p1,schools,parents,relation,add_city,add_region,age,confirm

depotid=trim(session("dm").System_depotid)
userid=trim(session("dm").System_UserId)

act=trim(request("act"))
confirm=trim(request("confirm"))

'vipcode,vipname,vipsex,mobtel,vippaper,vippassport,vipbirth,
'vipemail,vipadd,vippostalcode,vipoccupation,comment


dim vipcode,typeid

'-------------------/ vip_cardvip /--------------------------
typeid=trim(request.Form("typeid"))
vipcode=trim(request.Form("vipcode"))

sub req()

'-------------------/ vip_user /--------------------------
vipid2=trim(request.Form("vipid"))
vipname=trim(request.Form("vipname"))
vipsex=trim(request.Form("vipsex"))

byear=trim(request.Form("byear"))
bmonth=trim(request.Form("bmonth"))
bday=trim(request.Form("bday"))

vippaper=trim(request.Form("vippaper"))
vippassport=trim(request.Form("vippassport"))
vipoccupation=trim(request.Form("vipoccupation"))
mobtel=trim(request.Form("mobtel"))
vipemail=trim(request.Form("vipemail"))
vipadd=trim(request.Form("vipadd"))
comment=trim(request.Form("comment"))


vipbirth=byear&"-"&bmonth&"-"&bday
vipbirth=get_date(vipbirth)
end sub

dim ds,sql
dim levelsums,limitday,MaxDay,dummycard
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 3
vipid=getid("vip_user","vipid","VP",userid)

	sql="select isnull(levelsums,0),isnull(limitday,"&session("cf_Vip_limitday") &"),isnull(MaxDay,"&session("cf_Vip_MaxDay")&"),isnull(dummycard,0)"&_
			"from vip_typevip where viptypeid="&qts(typeid)
  ds.Source = sql
	ds.open
		if not(ds.eof and ds.bof) then
			levelsums=reNull(ds(0))
			limitday=reNull(ds(1))
			MaxDay=reNull(ds(2))
			dummycard=reNull(ds(3))
		end if
	ds.close

select case act
case "add"
  call req
  'call getsums
  call chkValue
Dim isaddcard

'添加或更新卡资料表
if isaddcard then									'没有卡的情况下新建一条卡记录
	sql="select * from vip_cardvip"
	ds.open sql,cn,1,3
	ds.AddNew
	ds("vipid")=vipid
	ds("viptypeid")=typeid
	ds("vipcardid")=vipcode
	ds("vipemitadd")=depotid
	ds("MaxDay")=MaxDay
	ds("limitday")=limitday
	ds("vipemit")=Now()					'开卡时间
	if levelsums>0 then ds("tempcard")=1	'临时卡
	ds.Update
	ds.Close
else					'已有卡的情况下更新卡资料
	sql="select * from vip_cardvip where vipcardid="&qts(vipcode)
	ds.open sql,cn,1,3
	ds("vipid")=vipid	
	ds("vipemitadd")=depotid
	ds("vipemit")=Now()					'开卡时间
	if levelsums>0 then ds("tempcard")=1	'临时卡
	ds.Update
	ds.Close
end if

'添加顾客资料
  sql="select top 1 * from vip_user order by vipid"
  ds.open sql,cn,1,3
  ds.AddNew
	
	'参数
  ds("vipid")=vipid
  ds("vipuse")=1
  ds("vipup")=1
  ds("validate")=1
	
	'顾客资料在这里
  call Assign	
  ds.Update
  ds.Close

	'call fszl(vipid,"add")
	
	response.write "<script>window.returnValue='"&vipname&"||"&mobtel&"'</script>"
	call close("添加成功!")
case "edit"
  call req
  'call getsums
  call chkValue
	
  sql="select top 1 * from vip_user where vipcode="&qts(vipcode)&" order by vipid"
  ds.open sql,cn,1,3
  call Assign
	
	if ds("updatecheck")>1 then ds("updatecheck")=1 			'提交审核
	
  ds.Update
  ds.Close
	
  'call fszl(vipid2,"edit")
	
	response.write "<script>window.returnValue='"&vipname&"||"&mobtel&"'</script>"
  call close("修改成功!")
case "del"
  dim id
  id=trim(request.QueryString("id"))
  ds.Source = "select 1 from vip_user where vipid="&qts(id)&" and isnull(vipcode,'')<>''"
  ds.open
  if not ds.eof then
    response.Write("<script>alert('此客户已发卡，不能删除！');history.go(-1);</script>")
	response.end
	ds.close
  else
  ds.close
  sql="delete from vip_user where vipid="&qts(id)
  ds.Source = sql
  ds.open
  end if
  set ds=nothing
  response.redirect "vip_search.asp"
end select

set ds=Nothing


sub chkValue()

  if typeid="" then jbox "VIP卡类型不能为空！"
  if vipname="" then jbox "姓名不能为空！"
  if mobtel="" then jbox "移动电话不能为空！"

'检查输入的卡号是否重复
	isaddcard=false

	set rs=server.CreateObject("adodb.recordset")
	
	sql="select top 1 vipcode from vip_user where mobtel="&qts(mobtel)&" and vipname="&qts(vipname)
	rs.open sql,cn,1,1
	if not(rs.eof and rs.bof) then 
		if act="add" then	'添加的时候如果手机与会员名相匹配，不可以重复添加
			jbox "该用户名与手机号码已存在，不可以重复注册使用！"
		elseif act="edit" then	'编辑时如果VIP卡号不相等并且会员名跟手机重复不予修改
			if rs(0)<>vipcode then jbox "该用户名与手机号码已存在，不可以重复注册使用！"
		end if
	end if
	rs.close
	
		if vipcode<>"" and act="add" then									'不为空的情况下
			sql="select vipcardid,vipid,viptypeid from vip_cardvip where vipcardid="&qts(vipcode)
			rs.open sql,cn,1,1
				if not(rs.eof and rs.bof) then
					if rs("viptypeid")<>typeid then
						ebox "选择的卡类型不一致！"
					elseif act="add" and isnull(rs("vipid")) and confirm<>"true" then
					  response.write "<script language=""javascript"">"
					  response.write "if(confirm('卡号："&vipcode&"可以使用，确定关联此VIP卡吗？')){"&_
					  				"parent.document.getElementById('confirm').value='true';"&_
					  				"parent.document.forms[0].target='_self';"&_
					  				"parent.document.forms[0].submit();"&_
									"}; </script>"
					  response.end()
					elseif confirm<>"true" then
						ebox "卡号："&vipcode&"已被其它顾客使用！"
					end if
				elseif confirm<>"true" then
					  response.write "<script language=""javascript"">"
					  response.write "if(confirm('卡号："&vipcode&"不存在，是否创建？')){"&_
										"parent.document.getElementById('confirm').value='true';"&_
					  				"parent.document.forms[0].target='_self';"&_
					  				"parent.document.forms[0].submit();"&_
									"}; </script>"
					  response.end()
				else
					isaddcard=true
				end if
			rs.close
		elseif act="add" then
			vipcode=getVipid("JC"&depotid)
			isaddcard=true
		end if

	set rs=nothing	
	
end sub

sub Assign()

  ds("vipname")=vipname
  ds("vipcode")=vipcode
  ds("vipsex")=vipsex
  if byear<>"1950" then ds("vipbirth")=vipbirth	'过滤掉默认的生日日期
'  ds("stature")=stature
 ' ds("waistline")=waistline
  ds("vippaper")=vippaper
  ds("vippassport")=vippassport
 ' ds("people")=people
  ds("vipoccupation")=vipoccupation
 ' ds("vippay")=vippay
 ' ds("viptel")=viptel
  ds("mobtel")=mobtel
  ds("vipemail")=vipemail
 ' ds("country")=country
  ds("vippostalcode")=vippostalcode
  ds("vipadd")=vipadd
  ds("comment")=comment
  ds("depotid")=depotid
  
 ' ds("vipgrab")=vipgrab
 ' ds("vipstyle")=vipstyle
 ' ds("vipsize")=vipsize
 ' ds("vipsize1")=vipsize1
 ' ds("city")=city
 ' ds("vipapply")=vipapply
 ' ds("viplove")=viplove
 ' ds("vipmax")=vipmax
 ' ds("vipmin")=vipmin
 ' ds("vipplace")=vipplace
 ' ds("tj_name")=tjname
 ' ds("tz_name")=tzname
 ' ds("fbuyid")=fbuyid
 ' ds("fbuydate")=fbuydate
 ' ds("fbuysums")=fbuysums
'  ds("fremark")=fremark
'  ds("viptypeid")=viptypeid
'  ds("schools")=schools
'  ds("parents")=parents
'  ds("relation")=relation
'  ds("add_city")=add_city
'  ds("add_region")=add_region
'  ds("age")=age

end sub
'
'sub fszl(vid,typ)
'for i=1 to vip_pnum
'    vip_str=vip_str&request.form("vip_p"&i&"_name")&"^"&request.Form("vip_p"&i)&"~"
'next

'if vip_str<>"" then
'vip_str=left(vip_str,len(vip_str)-1)
'vip_p=split(vip_str,"~")
'end if

'if vip_str<>"" then
''插入附属资料
'if typ="add" then
'   cn.execute "delete from vip_usersub where vipid='"&vid&"'"
'else
'   cn.execute "delete from vip_usersub where vipid="&vid&""
'end if
'for i=0 to ubound(vip_p)
'    vip_p1=split(vip_p(i),"^")
'	if typ="add" then
'	   cn.execute "insert into vip_usersub (vipid,p_code,p_name,p_value) values ('"&vid&"',"&i+1&",'"&vip_p1(0)&"','"&vip_p1(1)&"')"
'	else
'       cn.execute "insert into vip_usersub (vipid,p_code,p_name,p_value) values ("&vid&","&i+1&",'"&vip_p1(0)&"','"&vip_p1(1)&"')"
'	end if
'next
'end if

'end sub

'sub getsums
'  '取销售日期、金额
'  if fbuyid<>"" then
'    set rs=server.CreateObject("adodb.recordset")
'    rs.open "select convert(char(10),a.sure_date,126) as suredate,sum(b.nums*b.s_price) as sums from d_retail a,d_retailsub b "&_
'	        "where a.retailid=b.retailid and a.retailid='"&fbuyid&"' group by convert(char(10),a.sure_date,126)",cn
'    if not rs.eof then
'      fbuydate=rs("suredate")
'	  fbuysums=rs("sums")
'    else
'      mbox "不存在此购买单号，请确认！"
'    end if
'  else
'    fbuydate="1900-01-01"
'	fbuysums=0
'  end if
'end sub

%>
