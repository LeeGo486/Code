<%option explicit%>
<!--#include file="inc/function.asp"-->
<%dim vipname,vipsex,vipbirth,stature,waistline,vippaper,vippassport,people,vipid,viplove,vipmin,vipmax,vipplace,vipid2'用得修改时的
dim vipoccupation,vippay,viptel,mobtel,vipemail,country,vippostalcode,vipadd,comment
dim vipgrab,vipstyle,vipsize,vipsize1,city,vipapply
dim byear,bmonth,bday,fbuyid,fbuydate,fbuysums,fremark,viptypeid,vipcolor
dim depotid,userid,rs
dim act,tzid,tzname,tjname,tjId,vip_pnum,i,vip_str,vip_p,vip_p1,schools,parents,relation,add_city,add_region,age
dim qq,weibo,liketalktype,add_province,vipbrand1,vipbrand2,vipbrand3,getmag
dim AgeRange, Children, StyleDemand1, StyleDemand2, OccasionDemand1, OccasionDemand2, Hobby1 
dim Hobby2, Hobby3, ChildrenHave, ChildrenSex, Ayina, ToStoreTime1, ToStoreTime2, Body, Fabric, WeiXin, FollowWeiXin 
dim InforChannel, ShoppingType, FavouritesBook, FavouritesMoive, FavouritesColour, HopeGift, FavouritesActivties
dim FavouritesColour1,Fabric1,islunar,family,remarkFamily,loveFruit,remarkFruit,role,MemorialDay1,MemorialDay2,remarkMemorial
dim firstDisc,profession,Position,Constellation,MarkActivitie1,MarkActivitie2,ShoppingHabits,Vehicle,RemarkVehicle
dim Taboo,isReceipt,ReceiptName,Scarf


depotid=trim(session("dm").System_depotid)
userid=trim(session("dm").System_UserId)

act=trim(request("act"))

sub req()

FavouritesColour1=request.Form("FavouritesColour1")
Fabric1=request.Form("Fabric1")

if request.Form("islunar") ="on" then
islunar= 1
else
islunar= 0
end if

family=request.Form("family")
remarkFamily=request.Form("remarkFamily")
loveFruit=request.Form("loveFruit")
remarkFruit=request.Form("remarkFruit")
role=request.Form("role")
MemorialDay1=request.Form("MemorialDay1")
MemorialDay2=request.Form("MemorialDay2")
remarkMemorial=request.Form("remarkMemorial")
if trim(request.Form("firstDisc"))="" then
    firstDisc=0
else
    firstDisc=request.Form("firstDisc")
end if
profession=request.Form("profession")
Position=request.Form("Position")
Constellation=request.Form("Constellation")
MarkActivitie1=request.Form("MarkActivitie1")
MarkActivitie2=request.Form("MarkActivitie2")
ShoppingHabits=request.Form("ShoppingHabits")
Vehicle=request.Form("Vehicle")
RemarkVehicle=request.Form("RemarkVehicle")
Taboo=request.Form("Taboo")
if request.Form("isReceipt")="on" then
isReceipt=1
else
isReceipt=0
end if
ReceiptName=request.Form("ReceiptName")
Scarf=request.Form("Scarf")

 if trim(request.Form("getmag")) = "on" then
    getmag= 1
 else
    getmag = 0
 end if
vipbrand1=trim(request.Form("vipbrand1"))
if vipbrand1 = "其他" then
    vipbrand1 = trim(request.Form("vipbrand1other")) 
end if  
vipbrand2=trim(request.Form("vipbrand2"))
vipbrand3=trim(request.Form("vipbrand3"))

qq=trim(request.Form("qq"))
weibo=trim(request.Form("weibo"))
liketalktype=trim(request.Form("liketalktype"))
add_province=trim(request.Form("add_province"))

vipid2=trim(request.Form("vipid"))
vipname=trim(request.Form("vipname"))
vipsex=trim(request.Form("vipsex"))

byear=trim(request.Form("byear"))
bmonth=trim(request.Form("bmonth"))
bday=trim(request.Form("bday"))

stature=trim(request.Form("stature"))
waistline=trim(request.Form("waistline"))
vippaper=trim(request.Form("vippaper"))
vippassport=trim(request.Form("vippassport"))
people=trim(request.Form("people"))
vipoccupation=trim(request.Form("vipoccupation"))
if vipoccupation = "其他" then
    vipoccupation = trim(request.Form("vipoccupationother"))
end if    
vippay=trim(request.Form("vippay"))
viptel=trim(request.Form("viptel"))
mobtel=trim(request.Form("mobtel"))
vipemail=trim(request.Form("vipemail"))
country=trim(request.Form("country"))
vippostalcode=trim(request.Form("vippostalcode"))
vipadd=trim(request.Form("vipadd"))
comment=trim(request.Form("comment"))
vipcolor=trim(request.Form("vipcolor"))
vipgrab=trim(request.Form("vipgrab"))
vipstyle=trim(request.Form("vipstyle"))
vipsize=trim(request.Form("vipsize"))
vipsize1=trim(request.Form("vipsize1"))
city=trim(request.Form("city"))
vipapply=trim(request.Form("vipapply"))
viplove=trim(request.Form("viplove"))
vipplace=trim(request.Form("vipplace"))
vipmin=trim(request.Form("vipmin")):if vipmin="" then vipmin=0 
vipmax=trim(request.form("vipmax")):if vipmax="" then vipmax=0 

if byear<>"" and bmonth<>"" and bday<>"" then
   vipbirth=byear&"-"&bmonth&"-"&bday
   vipbirth=get_date(vipbirth)
else
   vipbirth=""
end if

tjname=trim(request.form("tjname"))
tjId=trim(request.form("tjId"))
tzname=trim(request.form("tzname"))
tzid=trim(request.form("tzid"))
vip_pnum=request.Form("vip_pnum")

fbuyid=request.Form("buyid")
viptypeid=request.Form("typeid")
fremark=request.Form("remark")
schools=trim(request.Form("schools"))
parents=trim(request.Form("parents"))
relation=trim(request.Form("relation"))
add_city=trim(request.Form("add_city"))
add_region=trim(request.Form("add_region"))
age=trim(request.Form("age"))
AgeRange=trim(request.Form("AgeRange"))
Children=trim(request.Form("Children"))
StyleDemand1=trim(request.Form("StyleDemand1"))
StyleDemand2=trim(request.Form("StyleDemand2"))
OccasionDemand1=trim(request.Form("OccasionDemand1"))
OccasionDemand2=trim(request.Form("OccasionDemand2"))
Hobby1=trim(request.Form("Hobby1"))
Hobby2=trim(request.Form("Hobby2"))
Hobby3=trim(request.Form("Hobby3"))
ChildrenHave=trim(request.Form("ChildrenHave"))
ChildrenSex=trim(request.Form("ChildrenSex"))
Ayina=trim(request.Form("Ayina"))
if Ayina = "其他" then
    Ayina=trim(request.Form("Ayinaother"))  
end if  
ToStoreTime1=trim(request.Form("ToStoreTime1"))
ToStoreTime2=trim(request.Form("ToStoreTime2"))
Body=trim(request.Form("Body"))
Fabric=trim(request.Form("Fabric"))
WeiXin=trim(request.Form("WeiXin"))
if trim(request.Form("FollowWeiXin")) = "是" then
    FollowWeiXin = true
else
    FollowWeiXin = false
end if    
InforChannel=trim(request.Form("InforChannel"))
if InforChannel = "其他" then
    InforChannel = trim(request.Form("InforChannelother"))
end if
ShoppingType=trim(request.Form("ShoppingType"))
if ShoppingType = "其他" then
    ShoppingType = trim(request.Form("ShoppingTypeother"))
end if
FavouritesBook=trim(request.Form("FavouritesBook"))
FavouritesMoive=trim(request.Form("FavouritesMoive"))
if FavouritesMoive = "其他" then
    FavouritesMoive = trim(request.Form("FavouritesMoiveother"))
end if
FavouritesColour=trim(request.Form("FavouritesColour"))
HopeGift=trim(request.Form("HopeGift"))
if HopeGift = "其他" then
    HopeGift = trim(request.Form("HopeGiftother"))
end if
FavouritesActivties=trim(request.Form("FavouritesActivties"))
end sub

dim ds,sql
set ds=server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
ds.LockType = 3

dim Tvp
Tvp = "VP"
'读取系统设置指定的VIP编号前缀
Tvp = GetVipHeadId(Tvp)
vipid=getid("vip_user","vipid",Tvp,userid)

select case act
case "add"
  call req
  call chkmobtel
  call getsums
  call chkValue
  sql="select top 1 * from vip_user order by vipid"
  ds.Source = sql
  ds.open
  ds.AddNew
  ds("vipid")=vipid
  on   error   resume   next
  call Assign
  ds.Update
  if Err.number <> 0   then 
    response.write   Err.description 
    response.end 
  end   if 
  ds.Close
  call fszl(vipid,"add")
  call setvippic(vipid)
  call mbox("添加成功!")
case "edit"
  call req
  call chkmobtel2
  call getsums
  call chkValue
  sql="select top 1 * from vip_user where vipid="&vipid2&" order by vipid"
  'response.write sql
'response.end
  ds.Source = sql
  ds.open
  call Assign
  ds.Update
  ds.Close
  call fszl(vipid2,"edit")
  call mbox("修改成功!")
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
  if vipname="" then mbox "姓名不能为空！"
'  if vippassport="" then mbox "证件号码不能为空！"
'  if mobtel="" then mbox "移动电话不能为空！"
'  if vipadd="" then mbox "通信地址不能为空！"
  if stature="" then
    stature=0
  end if
  if waistline="" then waistline=0
end sub

sub Assign()
  ds("vipname")=vipname
  ds("vipsex")=vipsex
  if vipbirth<>"" then
    ds("vipbirth")=vipbirth
  end if
		ds("stature")=stature
		ds("waistline")=waistline
		ds("vippaper")=vippaper
		ds("vippassport")=vippassport
		ds("people")=people
		ds("vipoccupation")=vipoccupation
		ds("vippay")=vippay
		ds("viptel")=viptel
		ds("mobtel")=mobtel
		ds("vipemail")=vipemail
		ds("country")=country
		ds("vippostalcode")=vippostalcode
		ds("vipadd")=vipadd
		ds("comment")=comment
		ds("depotid")=depotid
		ds("vipcolor")=vipcolor
		ds("vipgrab")=vipgrab
		ds("vipstyle")=vipstyle
		ds("vipsize")=vipsize
		ds("vipsize1")=vipsize1
		ds("city")=city
		ds("vipapply")=vipapply
		ds("viplove")=viplove
		ds("vipmax")=vipmax
		ds("vipmin")=vipmin
		ds("vipplace")=vipplace
		ds("tj_name")=tjname
        ds("tj_Id")=tjId
		ds("tz_name")=tzname
		ds("Employeeid")=tzid
		ds("fbuyid")=fbuyid
		ds("fbuydate")=fbuydate
		ds("fbuysums")=fbuysums
		ds("fremark")=fremark
		ds("viptypeid")=viptypeid
		ds("schools")=schools
		ds("parents")=parents
		ds("relation")=relation
		ds("add_city")=add_city
		ds("add_region")=add_region
		ds("age")=age
        ds("crname")=trim(session("dm").System_UserName) 

        ds("qq")=qq
        ds("weibo")=weibo
        ds("liketalktype")=liketalktype
        ds("add_province")=add_province

         ds("vipbrand1")=vipbrand1
         ds("vipbrand2")=vipbrand2
         ds("vipbrand3")=vipbrand3
         ds("getmag") =getmag
         ds("AgeRange") =AgeRange
         ds("Children") =Children
         ds("StyleDemand1") =StyleDemand1
         ds("StyleDemand2") =StyleDemand2
         ds("OccasionDemand1") =OccasionDemand1
         ds("OccasionDemand2") =OccasionDemand2
         ds("Hobby1") =Hobby1
         ds("Hobby2") =Hobby2
         ds("Hobby3") =Hobby3
         ds("ChildrenHave") =ChildrenHave
         ds("ChildrenSex") =ChildrenSex
         ds("Ayina") =Ayina
         ds("ToStoreTime1") =ToStoreTime1
         ds("ToStoreTime2") =ToStoreTime2
         ds("Body") =Body
         ds("Fabric") =Fabric
         ds("WeiXin") =WeiXin
         ds("FollowWeiXin") =FollowWeiXin
         ds("InforChannel") =InforChannel
         ds("ShoppingType") =ShoppingType
         ds("FavouritesBook") =FavouritesBook
         ds("FavouritesMoive") =FavouritesMoive
         ds("FavouritesColour") =FavouritesColour
         ds("HopeGift") =HopeGift
         ds("FavouritesActivties") =FavouritesActivties

         ds("FavouritesColour1")=FavouritesColour1
        ds("Fabric1")=Fabric1
        ds("islunar")=islunar
        ds("family")=family
        ds("remarkFamily")=remarkFamily
        ds("loveFruit")=loveFruit
        ds("remarkFruit")=remarkFruit
        ds("role")=role
        ds("MemorialDay1")=MemorialDay1
        ds("MemorialDay2")=MemorialDay2
        ds("remarkMemorial")=remarkMemorial
        ds("firstDisc")=firstDisc
        ds("profession")=profession
        ds("Position")=Position
        ds("Constellation")=Constellation
        ds("MarkActivitie1")=MarkActivitie1
        ds("MarkActivitie2")=MarkActivitie2
        ds("ShoppingHabits")=ShoppingHabits
        ds("Vehicle")=Vehicle
        ds("RemarkVehicle")=RemarkVehicle
        ds("Taboo")=Taboo
        ds("isReceipt")=isReceipt
        ds("ReceiptName")=ReceiptName
        ds("Scarf")=Scarf
	'是否需要总部审核
		if not session("vip_chkup") then
			ds("vipup")=1
			ds("vipuse")=1
			ds("validate")=1
		end if
	end sub

sub fszl(vid,typ)
for i=1 to vip_pnum
    vip_str=vip_str&request.form("vip_p"&i&"_name")&"^"&request.Form("vip_p"&i)&"~"
next

if vip_str<>"" then
vip_str=left(vip_str,len(vip_str)-1)
vip_p=split(vip_str,"~")
end if

if vip_str<>"" then
'插入附属资料
if typ="add" then
   cn.execute "delete from vip_usersub where vipid='"&vid&"'"
else
   cn.execute "delete from vip_usersub where vipid="&vid&""
end if
for i=0 to ubound(vip_p)
    vip_p1=split(vip_p(i),"^")
	if typ="add" then
	   cn.execute "insert into vip_usersub (vipid,p_code,p_name,p_value) values ('"&vid&"',"&i+1&",'"&vip_p1(0)&"','"&vip_p1(1)&"')"
	else
       cn.execute "insert into vip_usersub (vipid,p_code,p_name,p_value) values ("&vid&","&i+1&",'"&vip_p1(0)&"','"&vip_p1(1)&"')"
	end if
next
end if

end sub

'判断手机号码是否重复
sub chkmobtel
        set rs=server.CreateObject("adodb.recordset")
        rs.open " select 1 from vip_user where mobtel='"&mobtel&"' and '"&mobtel&"'<>'' ",cn
        if not rs.eof then
            rs.close
            set rs = nothing
            mbox "手机号码已存在！" 
        end if
end sub

sub chkmobtel2
        set rs=server.CreateObject("adodb.recordset")
        rs.open " select 1 from vip_user where mobtel='"&mobtel&"' and '"&mobtel&"'<>'' and vipid<>"&vipid2&"",cn
        if not rs.eof then
            rs.close
            set rs = nothing
            mbox "手机号码已存在！" 
        end if
end sub

sub getsums
  '取销售日期、金额
  if fbuyid<>"" then
    set rs=server.CreateObject("adodb.recordset")
    rs.open "select convert(char(10),a.sure_date,126) as suredate,sum(b.nums*b.s_price) as sums from d_retail a,d_retailsub b "&_
	        "where a.retailid=b.retailid and a.retailid='"&fbuyid&"' group by convert(char(10),a.sure_date,126)",cn
    if not rs.eof then
			fbuydate=rs("suredate")
			fbuysums=rs("sums")
    else
      mbox "不存在此购买单号，请确认！"
    end if
  else
    fbuydate="1900-01-01"
	fbuysums=0
  end if
end sub

sub setvippic(vipid)

  sql="update vip_user set userpicture=img from  vip_user a , vip_images b "&_
      " where a.vipid='"&vipid&"'"&_
	  " and b.vipid='"&session("viptmpid")&"'"

  cn.execute sql
  
  sql=" delete from vip_images where  vipid='"&session("viptmpid")&"'"
  cn.execute sql

end sub
%>
