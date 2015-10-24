<%option explicit%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<base target="_self">
<!--#include file="inc/function.asp"-->
<!--#include file="pos_main.asp"-->
</head>

<body>
<%
dim setdate,x_name,s_name,daystat,vipcode,zf,clothingid,act,retailid,userid,oldclothingid,shopcard,ci
dim comment,depotid,val,nums,discount,username,styleid,tmp,zs,back,t,id,sums,s_price,tmln,thsums,rr,oldid,x_price
id=trim(request.QueryString("id"))
oldid=trim(request.QueryString("oldid"))
retailid=trim(session("retailid"))
setdate=trim(request.QueryString("setdate"))

x_name=trim(request.QueryString("x_name"))
s_name=trim(request.QueryString("s_name"))
daystat=trim(request.QueryString("daystat"))
vipcode=trim(request.QueryString("vipcode"))
shopcard=trim(request.QueryString("shopcard"))
comment=trim(request.QueryString("comment"))
act=trim(request("act"))

val=trim(request.querystring("val"))
clothingid=trim(request.QueryString("clothingid"))
oldclothingid=clothingid
tmln=trim(request.QueryString("tmln"))
discount=trim(request.querystring("discount"))
nums=trim(request.querystring("nums"))

if tmln<>"" then
if round(tmln)>0 then
   clothingid=left(clothingid,len(clothingid)-round(tmln))
end if
end if

depotid=trim(session("dm").System_Depotid)
userid=trim(session("dm").System_UserId)
username=trim(session("dm").System_UserName)

'de act
set t=new retail
t.CreateAdo

select case act
case "add" '添加单款********************************
	dim cs 
		if instr(clothingid,"|")>0 then
		cs = split(clothingid,"|")
		for ci = 0 to ubound(cs)-1
		call t.add(cs(ci),cs(ci),1)
		next
	else
		call t.add(clothingid,oldclothingid,1)
	end if
  t.CloseAdo
  set t=nothing
  'set rr=server.CreateObject("adodb.recordset")
  'rr.open "select isnull(count(*),0) as cnt from webtmp_retailsub where retailid='"&retailid&"'",cn
  response.Redirect "pos_create_retail_sub.asp"
  'rr.close
  'set rr=nothing
case "addi" '添加多款**********************************
  call addi()
  call zclose()
case "del" '删除款************************************
  call t.del(id)
  t.CloseAdo
  set t=nothing
  response.Redirect "pos_create_retail_sub.asp"
case "editnums"
  call t.editnums(id,nums)
  set t=nothing
  response.Redirect "pos_create_retail_sub.asp"
case "mdisc" '修改折扣***********************************
  if (not isnumeric(discount)) or (discount="") then
    discount=0
  end if
  if cdbl(discount)<0 then
    call mbox("折扣不能小于0!")
  else
    if (cdbl(request.Cookies("lowerzk")("zk1"))<>-1) and (cdbl(discount)<cdbl(request.cookies("lowerzk")("zk1"))) then '-1不控制
	   call mbox("不能超出"&request.cookies("lowerzk")("zk1")&"折扣权限!")
	else
       discount=cdbl(discount)
	end if
  end if
  call t.mDiscount(id,discount)
  t.CloseAdo
  set t=nothing
  response.Redirect "pos_create_retail_sub.asp"
case "editsp" '修改结算价
  s_price=trim(request.QueryString("s_price"))
  x_price=trim(request.QueryString("x_price"))
  if not isnumeric(s_price) then
    call mbox("结算价只能为数字!")
  elseif cdbl(s_price)<0 then
    call mbox("结算价不能小于0!")
  else
    if cdbl(x_price)=0 then 
	   discount=0
	else
	   discount=cdbl(s_price)/cdbl(x_price)
	end if
    if (cdbl(request.Cookies("lowerzk")("zk1"))<>-1) and (cdbl(discount)<cdbl(request.cookies("lowerzk")("zk1"))) then '-1不控制
	   call mbox("不能超出"&request.cookies("lowerzk")("zk1")&"折扣权限!")
	else
       call t.mSPrice(id,s_price)
	end if
  end if
  t.CloseAdo
  set t=nothing
  response.Redirect "pos_create_retail_sub.asp"
case "code" '添加内部编码************************************
  dim code
  code=trim(request.QueryString("code"))
  call t.AddCode(id,code)
  t.CloseAdo
  set t=nothing
  response.Redirect "pos_create_retail_sub.asp"
case "zf" '整单作费******************************************
  call t.zf()
  t.CloseAdo
  set t=nothing
  response.Redirect "pos_create_retail.asp" 
case "zk" '整单打折******************************************
  if not IsNumeric(discount) then
     discount=1
  end if
  call t.allzk(discount)
  t.CloseAdo
  set t=nothing
  call sreload()
  response.end
case "zs" '赠送*********************************************
  sums=trim(request.QueryString("sums"))
  if clothingid="" then
     call mbox("货号不能为空!")
  end if
  if not isnumeric(sums) then
    sums=0
  else
    sums=cdbl(sums)
  end if
  call t.zs(clothingid,oldclothingid,sums)
  t.CloseAdo
  set t=nothing
  call sreload()
  response.end
case "th" '无单退货*********************************************
  sums=trim(request.QueryString("discount"))
  thsums=trim(request.querystring("thsums"))
  if clothingid="" then
     call mbox("货号不能为空!")
  end if
  if not isnumeric(sums) then
    sums=0
  else
    sums=cdbl(sums)
  end if
  if not isnumeric(thsums) then
    thsums=0
  else
    thsums=cdbl(thsums)
  end if
  call t.th(clothingid,oldclothingid,sums,thsums)
  t.CloseAdo
  set t=nothing
  call sreload()
  response.end
case "thall" '整单退货*********************************************
  call t.thall(oldid)
  t.CloseAdo
  set t=nothing
  call preload()
  response.end
case "gd" '挂单**********************************************
  call t.gd(comment)
  t.CloseAdo
  set t=nothing
  session("retailid")=""
  session("cashcard")=""
  session("posvipcode")=""
  session("shopcard")=""
  session("comment")=""
	
  call preload()
  response.End()
case "qd" '取单**********************************************
  id=t.qd(id)
  t.CloseAdo
  set t=nothing
  call preload()
  response.End()
case "sy" '收银*************************************************
	
  call t.Save()
  
  t.CloseAdo
  set t=nothing
  'call preload()
  'response.redirect "pos_zs.asp?id="&tmp
	
  session("retailid")=""
  session("cashcard")=""
  session("posvipcode")=""
  session("shopcard")=""
  session("comment")=""
  if session("xpname")<>"" then
  
     response.redirect session("xpname")&"?id="&tmp
  else
	  call preload()	'修改关于打印小票不会自动刷新的问题
     'response.write("<script>window.close();</script >")
  end if
  response.End()
case "vip"    
  call t.mVipDiscount(vipcode)
  response.write("<script>parent.location.reload();</script >")
    response.end
	t.CloseAdo
	set t = Nothing
  'response.Redirect("pos_create_retail_sub.asp")
 'response.write("<script>window.parent.location.href=window.parent.location.href;</script >")
 response.write("<script>parent.location.reload();</script >")
  response.End()
case "shopcard"
  call t.ShopcardDiscount(shopcard)
	t.CloseAdo
	set t = Nothing
  response.write("<script>window.parent.location.href=window.parent.location.href;</script >")
  response.End()
end select

t.CloseAdo
set t = Nothing

'添加多款***************************************************************************
sub addi()
  dim rows,cols,v(),indentid,id,styleid,d,action,clothingid
  dim i,j,colorid,sizeid
  id=trim(request.Form("id"))
  styleid=id
  rows=trim(request.Form("rows"))
  cols=trim(request.Form("cols"))
  retailid=session("retailid")
  action=trim(request.Form("action"))
  'if indentid="" or isnull(indentid) then
  '  response.Redirect ""
  'end if
  redim v(rows,cols)
  if rows<> "" then
    rows=cint(rows)
  else
    rows=0
  end if
  if cols<> "" then
    cols=cint(cols)
  else
    cols=0
  end if
  for i=1 to rows
    v(i,0)=request.Form("colorid")(i)'取得每行颜色
    for j=1 to cols
      v(i,j)=request.Form("n"&i&j+1)'取得值
    next
  next
  dim flag
  flag=false
  for i=1 to rows
    for j=1 to cols
      if v(i,j)="" then
	    v(i,j)=0
	  else
        v(i,j)=cint(v(i,j))
	    flag=true
	  end if
    next
  next
  if not flag then
    call zclose()
    response.End()
  end if

  for j=1 to cols
    v(0,j)=request.Form("sizeid")(j)'取得每列尺码
  next

  'for i=0 to rows
  '  response.Write "<br>第 "&i&" 行:"
  '  for j=0 to cols
  '    response.Write v(i,j) &"&nbsp;"
  '  next
  'next
  for i=1 to rows
    colorid=v(i,0)
	for j=1 to cols
	  if v(i,j)>0 then
	    sizeid =v(0,j)
        clothingid = styleid & colorid & sizeid
		call t.addi(clothingid,v(i,j))
	  end if
	next
  next

end sub
%>
<%Sub aClose(msg)%>
<script language="javascript">
  alert("<%=msg%>");
  window.history.back();
  window.parent.form1.key.focus();
</script>
<%End Sub%>

<%Sub bClose(msg)%>
<script language="javascript">
  alert("<%=msg%>");
  window.close();
  //window.parent.form1.key.focus();
</script>
<%End Sub%>

<%sub preload()%>
<script language="javascript">
  window.returnValue=1;
  window.close();
</script>
<%end sub%>

<%sub sreload()%>
<script language="javascript">
  window.returnValue=2;
  window.close();
</script>
<%end sub%>

<%
sub de(str)
response.Write "<textarea cols=40 rows=8>"&str&"</textarea>"
response.End()
end sub
%>

<%Sub mbox(msg)%>
<script language="javascript">
  alert("<%=msg%>");
  window.history.back();
  //window.parent.form1.ss.focus();
</script>
<%response.end
End Sub%>
<%Sub showinput(id,act)%>
<script language="javascript">
  showModalDialog("pos_input.asp?id=<%=id%>&act=<%=act%>",window,"dialogWidth:300px;dialogHeight:300px;center: yes;help:no;resizable:yes;status:no");
  window.location.href="pos_create_retail_sub.asp";
</script>
<%response.end
End Sub%>
<%Sub mbox1(msg)%>
<script language="javascript">
  alert("<%=msg%>");
  //window.location.href="pos_sy.asp";
  window.close();
</script>
<%response.end
End Sub%>
</body>
</html>