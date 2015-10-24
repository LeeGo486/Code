<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Class retail
'********************************** 属性 ***************************************
Private ds
Private rs
Private cd
Private sql

Public retailid
Public depotid
Public userid
Public username

Private colorid
Private sizeid
Private sname
Private c_name
Private kc


  Private Sub Class_Initialize()
	retailid=session("retailid")
	depotid=trim(session("dm").System_Depotid)
	userid=trim(session("dm").System_Userid)
	username=session("dm").System_UserName
  End Sub

'*********************************** 调用接口 **********************************************
  '取得总金额************************************************************************************************
  Function getSums()
    sql="select sum(s_price*nums) from webtmp_retailsub where retailid="&qts(retailid)
	ds.Source=sql
	ds.Open
	if not ds.eof then
	  getSums=ds(0)
	else
	  getSums=0
	end if
	ds.close
  End Function
  
  '赠送(款式编号，附加金额)*******************************************************************************
  Sub zs(clothingid,tmid,sums)
    
	call chkRetailId() '修改主单
	
    clothingid=ucase(clothingid)
	
	sql = "select a.clothingid from j_clothing a where a.oldclothingid="&qts(clothingid)
	ds.Source = sql '查货号**********
	ds.open
	if not ds.eof then '找到了
	  clothingid=trim(ds("clothingid"))
	end if
	ds.close
	
    if clothingid<>"" then
	  sql = "select distinct a.styleid,a.colorid,a.sizeid,b.s_name,c.c_name from j_clothing a,j_style b,j_color c where a.styleid=b.styleid and a.colorid=c.colorid and a.clothingid="&qts(clothingid)
	  ds.Source = sql '查货号**********
	  ds.open
	  if not ds.eof then
	    styleid=ds("styleid")
	    colorid=ds("colorid")
	    sizeid=ds("sizeid")
	    sname=ds("s_name")
		c_name=ds("c_name")
	    ds.close
			sql="select k_num from j_stock where depotid="&qts(depotid)&" and clothingid="&qts(clothingid)
			ds.source = sql '求库存*********
			ds.open
			if not ds.eof then
			  kc=ds(0)
			else
			  kc=0
			end if
			ds.close
	  else
        ds.close
	    call bClose("货号 " & clothingid &" 不存在!")
        response.End
	  end if
    end if
    
	if clothingid<>"" then
	  dim j_price,x_price,discount,s_price,v,j_cost
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getclothingprice"
	  v = Session("dm").System_DepotId
	  cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, 1)
	  cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  cd.Parameters.Append cd.CreateParameter("@clothingid", 200, 1, 34, clothingid)
	  Set rs = cd.Execute '求价格*************
	  cd.Parameters.delete 2
	  cd.Parameters.delete 1
	  cd.Parameters.delete 0
  	  If rs.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if
	  
	  j_cost=rs.Fields.Item("j_cost").value
	  If IsNull(j_cost) Then
	    j_cost = 0
	  End If
	  
	  j_price=rs.Fields.Item("j_price").value
	  If IsNull(j_price) Then
	    j_price = 0
	  End If
	  
	  x_price=rs("x_price")
	  If IsNull(x_price) Then
	    x_price = 0
	  Else
	    x_price = cdbl(x_price)
	  End If
	  
	  s_price=rs.Fields.Item("s_price").value
	  If IsNull(s_price) Then
	    s_price = 0
	  Else
	    s_price = cdbl(s_price)
	  End If
	  
	  discount=rs.Fields.Item("discount").value
	  If IsNull(discount) Then
	    discount = 0
	  Else
	    discount = cdbl(discount)
	  End If
	  rs.Close	
	  set rs=nothing
	
	if x_price>0 then'根据附加金额计算折扣
	  discount=sums/x_price
	else
	  discount=1
	end if
	
    sql="select top 1 * from webtmp_retailsub"
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	ds.Addnew
	  ds("boxid")=getboxid()
	  ds("retailid")=retailid
	  ds("clothingid")=clothingid
	  ds("styleid")=styleid
	  ds("s_name")=sname
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  ds("c_name")=c_name
	  ds("s_price")=sums
	  ds("x_price")=x_price
	  ds("j_price")=j_price
	  ds("nums")=1
	  ds("discount")=discount
	  ds("kc")=kc
	  ds("zs")=1
	  ds("back")=0
	  ds("oldj_price")=j_price
	  ds("oldx_price")=x_price
	  ds("olds_price")=sums
	  ds("olddiscount")=discount
	  ds("tmid")=tmid
	  ds("prodiscount")=discount
	  ds("pros_price")=sums
	ds.Update
	ds.Close
	end if
  End Sub

  '整单退货(款式编号,退货金额)********************************************************************************
  Sub thall(oldid)
    
	call chkRetailId() '修改主单
	Dim vipcode,shopcard
	sql="select isnull(vipcode,'') as vipcode from d_retail where sure>0 and retailid="&qts(oldid)
	ds.Source = sql
	ds.open
	if ds.eof then
	   call mbox("此销售单 "&oldid&" 不存在！")
	   response.end
	else
	   vipcode=ds("vipcode")
	end if
	ds.close
	
	'明细
	sql="delete from webtmp_retailsub where retailid="&qts(retailid)
	cn.execute sql
	sql="insert into webtmp_retailsub "&_
        "(retailid,clothingid,styleid,sizeid,s_name,colorid,c_name,nums,j_price,x_price,s_price,discount,zs,back,boxid,code,"&_
        "oldj_price,oldx_price,olds_price,olddiscount,tmid,prodiscount,pros_price,J_cost) "&_
        "select "&qts(retailid)&",a.clothingid,a.styleid,a.sizeid,b.s_name,a.colorid,c.c_name,-1*a.nums,a.j_price,a.x_price,a.s_price,"&_
				"a.discount,isnull(a.larg,0),isnull(a.back,0),a.boxid,a.code,a.j_price,a.x_price,a.s_price,a.discount,a.clothingid,"&_
				"a.discount,a.s_price,isnull(a.J_cost,0) from d_retailsub a,j_style b,j_color c "&_
				"where a.retailid="&qts(oldid)&" and a.styleid*=b.styleid and a.colorid*=c.colorid"
    cn.execute sql
	
	'更新主单
	sql="update webtmp_retail set comment='"&oldid&"整单退货',vipcode=null,inputvip=0,discount=null where retailid="&qts(retailid)
	cn.execute sql
	session("comment")=oldid&"整单退货"
	session("oldid")=oldid

	if vipcode<>"" then
	   sql="update webtmp_retail set vipcode="&qts(vipcode)&",inputvip=1 where retailid="&qts(retailid)
	   cn.execute sql
	   sql="update webtmp_retailsub set vipcode="&qts(vipcode)&" where retailid="&qts(retailid)
	   cn.execute sql
	   session("posvipcode")=vipcode
	end if
  End Sub
 
  '无单退货(款式编号,退货金额)********************************************************************************
  Sub th(clothingid,tmid,sums,thsums)
    
	call chkRetailId() '修改主单
	
    clothingid=ucase(clothingid)
	
	sql = "select a.clothingid from j_clothing a where a.oldclothingid="&qts(clothingid)
	ds.Source = sql '查货号**********
	ds.open
	if not ds.eof then '找到了
	  clothingid=trim(ds("clothingid"))
	end if
	ds.close
	
    if clothingid<>"" then
	  sql = "select distinct a.styleid,a.colorid,a.sizeid,b.s_name,c.c_name from j_clothing a,j_style b,j_color c "&_
					" where a.styleid=b.styleid and a.colorid=c.colorid and a.clothingid="&qts(clothingid)
	  ds.Source = sql '查货号**********
	  ds.open
	  if not ds.eof then
	    styleid=ds("styleid")
	    colorid=ds("colorid")
	    sizeid=ds("sizeid")
	    sname=ds("s_name")
		c_name=ds("c_name")
	    ds.close
			sql="select k_num from j_stock where depotid="&qts(depotid)&" and clothingid="&qts(clothingid)
			ds.source = sql '求库存*********
			ds.open
			if not ds.eof then
			  kc=ds(0)
			else
			  kc=0
			end if
			ds.close
	  else
        ds.close
	    call aClose("货号 " & clothingid &" 不存在!")
        response.End
	  end if
    end if
    
	if clothingid<>"" then
	  dim j_price,x_price,discount,s_price,v,j_cost
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getclothingprice"
	  v = Session("dm").System_DepotId
	  cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, 1)
	  cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  cd.Parameters.Append cd.CreateParameter("@clothingid", 200, 1, 34, clothingid)
	  Set rs = cd.Execute '求价格*************8
	  cd.Parameters.delete 2
	  cd.Parameters.delete 1
	  cd.Parameters.delete 0
  	  If rs.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if
	  
	  j_cost=rs.Fields.Item("j_cost").value
	  If IsNull(j_cost) Then
	    j_cost = 0
	  End If
	  
	  j_price=rs.Fields.Item("j_price").value
	  If IsNull(j_price) Then
	    j_price = 0
	  Else
	    j_price = cdbl(j_price)
	  End If
	  
	  x_price=rs.Fields.Item("x_price").value
	  If IsNull(x_price) Then
	    x_price = 0
	  Else
	    x_price = cdbl(x_price)
	  End If
	  
	  s_price=rs.Fields.Item("s_price").value
	  If IsNull(s_price) Then
	    s_price = 0
	  End If
	  
	  if sums=1 then
	    if thsums=0 then
	      discount=rs.Fields.Item("discount").value
	      If IsNull(discount) Then
	         discount = 1
	      End If
		else
		  s_price=thsums
		  if x_price=0 then
		     discount=0 
		  else
		     discount=round(thsums/x_price,2)
		  end if
		end if
	  else  
	    discount=sums
		s_price=x_price*discount
	  end if
	  
	  rs.Close	
	  set rs=nothing
	

    sql="select top 1 * from webtmp_retailsub"
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	ds.Addnew
	  ds("boxid")=getboxid()
	  ds("retailid")=retailid
	  ds("clothingid")=clothingid
	  ds("styleid")=styleid
	  ds("s_name")=sname
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  ds("c_name")=c_name
	  ds("s_price")=s_price
	  ds("x_price")=x_price
	  ds("j_price")=j_price
	  ds("nums")=-1
	  ds("discount")=discount
	  ds("kc")=kc
	  ds("zs")=0
	  ds("back")=1
	  ds("oldj_price")=j_price
	  ds("oldx_price")=x_price
	  ds("olds_price")=s_price
	  ds("olddiscount")=discount
	  ds("tmid")=tmid
	  ds("prodiscount")=discount
	  ds("pros_price")=s_price
 	  ds("comment")="退货."
	ds.Update
	ds.Close
	end if
  End sub
  
  '挂单*******************************************************************************************************
  Sub gd(comment)
    sql="update webtmp_retail set gd=1,intra="&qts(comment)&" where retailid="&qts(retailid)
    ds.Source =sql
    ds.open
  End Sub
  
  '取单**********************************************************************************************************
  Function qd(retailid)
    sql="update webtmp_retail set gd=0 where retailid="&qts(retailid)
'	sql="select gd from webtmp_retail  where retailid="&qts(retailid)
'	ds.CursorType = 1
    ds.Source =sql
    ds.open
	sql="select retailid,comment,shopcard,vipcode from webtmp_retail where retailid="&qts(retailid)
	ds.Source =sql
	ds.open
    if not ds.eof and not ds.bof then
    session("retailid")=ds("retailid")
		session("comment")=ds("comment")
		session("posvipcode")=ds("vipcode")
		session("shopcard")=ds("shopcard")
	end if
	ds.close
	qd=retailid
'	if not ds.eof then
'	  ds("gd")=0
'	  ds.Update
'	  qd=retailid
'	else
'	  qd="0"
'	end if
'	ds.close
  End Function
  
  '作费*************************************************************************************************************
  Sub zf()
    sql="delete from webtmp_retail where retailid="&qts(retailid)
    ds.Source =sql
    ds.open
	session("retailid")=""
	session("posvipcode")=""
	session("cashcard")=""
	session("shopcard")=""
	session("comment")=""
  End Sub
  
  '整单打折*************************************************************************************************************
  Sub allzk(discount)
    if cdbl(request.Cookies("lowerzk")("zk2"))=-1 then '-1不控制
      sql="update webtmp_retailsub set discount=round(discount*"&discount&",3),s_price=round(s_price*"&discount&",2), "&_
					" prodiscount=round(discount*"&discount&",3),pros_price=round(s_price*"&discount&",2) "&_
					" where isnull(zs,0)=0 and isnull(back,0)=0 and retailid="&qts(retailid)
	  ds.source =sql
	  ds.open
	else
	  Dim found
	  sql="select clothingid,boxid,discount,s_price from webtmp_retailsub where retailid="&qts(retailid)
	  ds.Source=sql
	  ds.open
	  while not ds.eof
	    if cdbl(cdbl(ds("discount"))*cdbl(discount))>=cdbl(request.cookies("lowerzk")("zk2")) then '大于最低折上折
		   cn.execute "update webtmp_retailsub set discount=round(discount*"&discount&",3),s_price=round(s_price*"&discount&",2), "&_
	                  "prodiscount=round(discount*"&discount&",3),pros_price=round(s_price*"&discount&",2) "&_
					  "where retailid="&qts(retailid)&" and clothingid="&qts(ds("clothingid"))&" and isnull(zs,0)=0 and isnull(back,0)=0 and boxid="&qts(ds("boxid"))
		else
		   found=found&ds("clothingid")&"\n"
		end if
	    ds.movenext
	  wend
	  ds.close
	  if found<>"" then
		 response.write("<script>alert('以下款号的折上折超出"&request.cookies("lowerzk")("zk2")&"折上折权限\n所以折上折没有生效\n\n"&found&"')</script>")
	  end if
	end if
  End Sub
  
  '添加款************************************************************************************************************
  Sub Add(clothingid,tmid,nums)
	call chkRetailId() '修改主单
	
    clothingid=ucase(clothingid)
    if clothingid<>"" then
	
	  sql = "select a.styleid from j_style a where a.helpid="&qts(clothingid)
	  ds.Source = sql '查货号**********
	  ds.open
	  if not ds.eof then '找到了
	    clothingid=trim(ds("styleid"))
	  end if
	  ds.close
	  
	  sql = "select a.clothingid from j_clothing a where a.oldclothingid="&qts(clothingid)
	  ds.Source = sql '查货号**********
	  ds.open
	  if not ds.eof then '找到了
	    clothingid=trim(ds("clothingid"))
	  end if
	  ds.close
	  
	  sql = "select distinct a.styleid,a.colorid,a.sizeid,b.s_name,c.c_name from j_clothing a,j_style b,j_color c where a.styleid=b.styleid and a.colorid=c.colorid and a.clothingid="&qts(clothingid)
	  ds.Source = sql '查货号**********
	  ds.open
	  if not ds.eof then '找到了
	    styleid=ds("styleid")
	    colorid=ds("colorid")
	    sizeid=ds("sizeid")
	    sname=ds("s_name")
		c_name=ds("c_name")
	    ds.close
			sql="select k_num from j_stock where depotid="&qts(depotid)&" and clothingid="&qts(clothingid)
			ds.source = sql '求库存*********
			ds.open
			if not ds.eof then
			  kc=ds(0)
			else
			  kc=0
			end if
			ds.close
	    else '没找到
          ds.close
		  sql="select 1 from j_stock a where a.styleid='"&clothingid&"'"
		  ds.Source = sql
		  ds.open
		  if not ds.eof then '找到了,不带色码
		    ds.close
			set ds=nothing
			set cd=nothing
		    call showinput(clothingid,"addi")
		  else '没找到
		    ds.close
			set ds=nothing
			set cd=nothing
	        call aClose("货号 " & clothingid &" 不存在!")
            response.End
		  end if
	    end if
      end if
    
	if clothingid<>"" then
	  dim j_price,x_price,discount,s_price,v,j_cost
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getclothingprice"
	  v = Session("dm").System_DepotId
	  cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, 1)
	  cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  cd.Parameters.Append cd.CreateParameter("@clothingid", 200, 1, 34, clothingid)
	  'cd.Parameters.Append cd.CreateParameter("@pricedate", 200, 1, 10, get_date(date))
	  Set rs = cd.Execute '求价格*************
	  cd.Parameters.delete 2
	  cd.Parameters.delete 1
	  cd.Parameters.delete 0
  	  If rs.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if
	  
	  j_cost=rs.Fields.Item("j_cost").value
	  If IsNull(j_cost) Then
	    j_cost = 0
	  End If
	  
	  j_price=rs.Fields.Item("j_price").value
	  If IsNull(j_price) Then
	    j_price = 0
	  End If
	  
	  x_price=rs.Fields.Item("x_price").value
	  If IsNull(x_price) Then
	    x_price = 0
	  End If
	  
	  s_price=rs.Fields.Item("s_price").value
	  If IsNull(s_price) Then
	    s_price = 0
	  End If
	  
	  discount=rs.Fields.Item("discount").value
	  If IsNull(discount) Then
	    discount = 0
	  End If
	  rs.Close	
	  set rs=nothing
	  
	'discount = 1 '12月6号新加,问题3
    sql="select top 1 * from webtmp_retailsub"
	ds.LockType = 3
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	ds.Addnew
	  ds("boxid")=getboxid()
	  ds("retailid")=retailid
	  ds("clothingid")=clothingid
	  ds("styleid")=styleid
	  ds("s_name")=sname
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  ds("c_name")=c_name
	  ds("s_price")=s_price
	  'ds("s_price")=x_price
	  ds("x_price")=x_price
	  ds("j_price")=j_price
	  ds("j_cost")=j_cost
	  ds("nums")=nums
	  ds("discount")=discount
	  ds("kc")=kc
	  ds("zs")=0
	  ds("back")=0
	  ds("oldj_price")=j_price
	  ds("oldx_price")=x_price
	  ds("olds_price")=s_price
	  ds("olddiscount")=discount
	  ds("tmid")=tmid
	  ds("prodiscount")=discount
	  ds("pros_price")=s_price
	ds.Update
	ds.Close
	
	'调用促销*************************************
	'  cd.CommandType = 4
	'  cd.CommandText = "pos_cxgl"
	'  v = Session("dm").System_DepotId
	'  cd.Parameters.Append cd.CreateParameter("@djid", 200, 1, 22, retailid)
	'  cd.Execute '求价格*************
	'  cd.Parameters.delete 0
	end if
  End Sub
  
  '添加内部编码
  Sub AddCode(id,code)
	sql="select retailid from webtmp_retailsub where code="&qts(code)
    ds.Source = sql
    ds.Open
    if ds.eof then
      ds.close
  	  sql="select retailid from d_retailsub where (isnull(back,0)<>1) and code="&qts(code)
	  'de sql
  	  ds.Source = sql
  	  ds.Open
  	  if ds.eof then
    	ds.close
    	sql="update webtmp_retailsub set code="&qts(code)&" where retailid="&qts(retailid)&" and id="&id
    	ds.Source =sql
    	ds.open
	  else
	    ds.close
		set ds = nothing
		call mbox("此内部编码在销售记录中已存在!")
	  end if
    else
      ds.close
	  set ds = nothing
	  call mbox("此内部编码在销售记录中已存在!")
    end if
  End Sub
  
  '删除************************************************************************************************
  Sub Del(id)
    sql="delete from webtmp_retailsub where retailid="&qts(retailid)&" and id="&id
    ds.Source =sql
    ds.open
  End Sub
  
  '修改数量********************************************************************************************
  Sub mNums(id,nums)
    sql="update webtmp_retailsub set nums="&nums&" where retailid="&qts(retailid)&" and id="&id
    ds.Source =sql
    ds.open
  End Sub
  
  '修改折扣*********************************************************************************************
  Sub mDiscount(id,discount)
    sql="update webtmp_retailsub set discount="&discount&",s_price=x_price*"&discount&",sums=x_price*"&discount&"*nums,"&_
	    "prodiscount="&discount&",pros_price=x_price*"&discount&",vipdisc=0,cxdisc=1 where retailid="&qts(retailid)&" and id="&id
    ds.Source =sql
    ds.open
    'sql="update webtmp_retailsub set sums=s_price*nums where retailid="&qts(retailid)&" and id="&id
    'ds.Source =sql
    'ds.open
  End Sub
  
  '修改结算价****************************************************************************************************
  Sub mSPrice(id,s_price)
    sql="update webtmp_retailsub set s_price="&s_price&",discount=case when x_price<>0 then round("&s_price&"/x_price,4) else 1 end,"&_
	    "prodiscount=case when x_price<>0 then round("&s_price&"/x_price,4) else 1 end,pros_price="&s_price&" where retailid="&qts(retailid)&" and id="&id
    ds.Source =sql
    ds.open
  End Sub
  
  '修改VIP折扣***************************************************************************************************
  Sub mVipDiscount(vipcode)
    dim viptypename,vipcentum,ds1,d,sql,beg,cnt,vipcode2
		vipcode2 = vipcode
		'VIP卡刷卡截取
		if request.cookies("vipflash")("cut")=1 then
			beg = request.cookies("vipflash")("beg")
			cnt = request.cookies("vipflash")("cnt")
			vipcode = mid(vipcode,beg,cnt)
		end if

		'判断是否使用姓名+手机号码识别模式
		if session("cf_VipSet_symb")>0  then
			sql="select vipcode from vip_user where vipname+mobtel in("&qts(vipcode)&","&qts(vipcode2)&") "
			if session("cf_VipSet_symb")=2 then sql=sql&" or vipcode in("&qts(vipcode)&","&qts(vipcode2)&") "
			ds.open sql,cn,1,1
			if not(ds.eof and ds.bof) then
				vipcode=ds(0)
			end if
			ds.close
		end if
 
    ds.open chkvip(vipcode,0),cn,1,3
    if ds.eof then
      ds.close
			set ds=nothing
			'cn.execute "update webtmp_retail set vipcode=null where retailid="&qts(retailid)
			'cn.execute "update webtmp_retailsub set vipcode=null where retailid="&qts(retailid)
			response.write("<script>alert('没有找到此VIP卡号或已过期，请确认后重新输入！');")
			'response.write("window.parent.form1.tmpvipcode.value='';")
			response.write("window.parent.is.location.href='pos_create_retail_sub.asp';")
			response.write("</script>")
			response.End()
    else
		
		'tempcard=1时并且已消费过一次的VIP卡
		
		'set ds1=server.createobject("ADODB.Recordset")
		'if ds("tempcard")=1  then
		'	sql ="select isnull(count(retailid),0) as retailsum from d_retail where vipcode="&qts(vipcode)
		'	ds1.open sql,cn,1,1
		'		if ds1(0)>0 then
		'			response.write("<script>alert('该临时卡未通过审核，暂时不能消费！');")
		'			response.write("window.parent.is.location.href='pos_create_retail_sub.asp';")
		'			response.write("</script >")
		'			response.End()
		'		end if
		'	ds1.close
		'end if
      'viptypename=ds(0)
	  'vipcentum=ds("centum")
     ' ds.close
	  'sql="select * from webtmp_retailsub where retailid="&qts(retailid)
	 ' ds.Source = sql
	 ' ds.open
		
	 ' while not ds.eof
	  '  discount=cdbl(ds("discount"))
		'if isnumeric(discount) then
		   'discount=cdbl(discount)
		'else
		'  discount=1
		'end if
		'de ds("discount")
	    'ds1.source = " select isnull(b.rate,1) from vip_rate a,vip_ratesub b "& _
				'" where a.rateid=b.rateid and a.viptypename="&qts(viptypename)& _
				''" and begcentum >= "&vipcentum&" and endcentum <= "&vipcentum& _
				'" and b.begrate >="&discount&" and b.endrate <="&discount
		'	ds1.open  "getvipdiscount '"&vipcode&"',"&vipcentum&","&discount&"",cn,1,1
	    'if ds1.eof then
	    '  discount=discount
	    'else '此处采用的折上折
    	'  discount=discount*cdbl(ds1(0))
	    'end if
		'ds1.close
		
	'	if not ds1.eof then
	'	   if (cdbl(ds1(0))<>1) and IsNull(ds("vipcode")) then
				'判断VIP是否折上折
	'		  if session("vipzsz")=0 then
	'	        discount=discount*cdbl(ds1(0))
	'		  else
	'		  		if cdbl(discount)>cdbl(ds1(0)) then
	'			    discount=cdbl(ds1(0))
	'				end if
	'		  end if
				'ds("discount")=discount
				'ds("s_price")=cdbl(ds("x_price"))*discount
				'ds("vipcode")=vipcode
				'ds("prodiscount")=discount
				'ds("pros_price")=cdbl(ds("x_price"))*discount
				'ds.update
'		   end if
'		end if
'		ds1.close

'	    ds.movenext
'	  wend
      ds.Close
	  sql="update webtmp_retail set vipcode="&qts(vipcode) &",inputvip=1 where retailid="&qts(retailid)
	  ds.Open sql,cn,1,1
	  session("posvipcode")=vipcode
		
    end if
  End Sub
	
  '商场卡折扣***************************************************************************************************
  Sub ShopcardDiscount(shopcard)
	Dim rs1,ds,a_rate,a_distype
	set rs1=server.createobject("ADODB.Recordset")
	set ds=server.createobject("ADODB.Recordset")
	
	sql = "select a.rate,isnull(a.distype,1) as a_distype from vip_shopcard a,vip_shopcarddpt b"&_
			  " where a.shopcardid="&qts(shopcard)&" and a.shopcardid=b.shopcardid and depotid="&qts(depotid)
	rs1.open sql,cn,1,1
	if not(rs1.eof and rs1.bof) then
	
			a_rate=cdbl(rs1(0))
			a_distype=cdbl(rs1(1))
				
			'原折扣
			sql="select isnull(prodiscount,0) as dis,* from webtmp_retailsub where retailid="&qts(retailid)
			ds.open sql,cn,1,3
			do while not ds.eof
		
	      discount=cdbl(ds("dis"))
				'判断使用的折扣方式
			  if a_distype=0 then					'折上折
		        discount=discount*a_rate
			  elseif a_distype=2 then			'使用此折扣
				    discount=a_rate
				elseif a_distype=1 then			'取最小折扣(默认)
			     if discount>a_rate then discount=a_rate
			  end if

			ds("discount")=discount
			ds("s_price")=cdbl(ds("x_price"))*discount
			ds("shopcard")=shopcard
			'ds("prodiscount")=discount
			'ds("pros_price")=cdbl(ds("x_price"))*discount
			
			ds.update
		ds.movenext
	  loop
			'response.write discount
			'response.end
				
		ds.Close
	else
		shopcard=""
	end if
	
		sql="update webtmp_retail set shopcard='"&shopcard&"' where retailid="&qts(retailid)
		cn.execute(sql)
	  session("shopcard")=shopcard
	rs1.close
	
  End Sub

  '保存零售单*******************************************************************************************************
  Function Save()
  
    dim ys,sureys,s_sums,z_sums,rows,i,tsums,groupid,sellname,sellnametel,msg
    dim retype(),v(),sa,s_name,sac,hsa,employeeid,setdate,zmdate,jfdksums,chkdate
    ys=trim(request.Form("ys"))
	sureys=trim(request.Form("sureys"))
    s_sums=trim(request.Form("ss"))
    'z_sums=trim(request.Form("zl"))
	
    rows=trim(request.Form("rows"))
	sa=trim(request.Form("empname"))
	hsa=trim(request.Form("hsname"))
	sellname=trim(request.Form("sellname"))
	sellnametel=trim(request.Form("sellnametel"))
	s_name=split(sa,",")
	employeeid=split(hsa,",")
	sac=ubound(s_name)
	'response.write sac
	'response.end
    if ys="" then
      mbox1("应收栏不能为空!")
    else
      ys=cdbl(ys)
	  sureys=cdbl(sureys)
    end if
    if s_sums="" then
      mbox1("实收栏不能为空!")
    else
      s_sums=cdbl(s_sums)
    end if
	z_sums=s_sums-ys
    'if z_sums="" then
    '  mbox1("找零不能为空,如为空,请填 0")
    'else
    '  z_sums=cdbl(z_sums)
    'end if
    if s_sums<ys then
      mbox1("实收不能小于应收!")
    end if
    'if s_sums-z_sums < ys then
    '  mbox1("找零太多!")
    'end if
  
    if not isnumeric(rows) then
      rows=0
    else
      rows=cint(rows)
    end if
  
    redim retype(rows)
    redim v(rows)
    tsums=0
	'取优惠金额*********************************************
Dim yhje,cdsums,ccsums
    ds.open "select isnull(sums,0) as sums from webtmp_skfs where retailid='"&retailid&"' and retype='促销优惠'",cn
    if not ds.eof then
 	  yhje=cdbl(ds("sums"))
    else
	  yhje=0
    end if
    ds.close
	ccsums=0
	jfdksums=0
    '取得收款方式*********************************************
    for i=1 to rows
      retype(i)=trim(request.form("retype"&i))
      v(i)=trim(request.form("n"&i))

			if not isnumeric(v(i)) then
				v(i)=0
			else
				v(i)=cdbl(v(i))
			end if

			if retype(i)="充值卡" then ccsums = v(i)
            if retype(i)="积分抵扣" then jfdksums = v(i)
			
      tsums=tsums+v(i)
			
    next
    if tsums-yhje<>sureys then mbox1("收款方式每项金额之和与应收金额不一致!")
  
	cd.CommandType = 1
	
	id=session("retailid")
    retailid=getid("d_retail","retailid","LS",userid)
	tmp=retailid
	'得到销售日期
	'ds.source = "select replace(convert(char(19),setdate,126),'T',' ') as setdate from webtmp_retail where retailid="&qts(id)
	'ds.open
	'setdate=ds("setdate")&" "&get_time(time)
	'setdate=ds("setdate")
	'换取Cookies日期
	setdate = request.cookies("setdate")
	chkdate=request.cookies("setdate")&" "&get_time(time)
	
	'ds.close
	
	'得到锁帐日期
	ds.source = "select isnull(convert(char(10),zmrqdate,126),'1900-01-01') as zmdate from j_depot where depotid='"&session("dm").system_depotid&"'"
	ds.open
	zmdate=ds("zmdate")
	ds.close
	
	'判断锁帐日期
	if get_date(setdate)<=zmdate then
	   'de "帐目已经锁定，此单销售日期小于锁帐日期，不能收银！"
	   response.write("<script>alert('帐目已经锁定，此单销售日期小于锁帐日期，不能收银！');window.close();</script>")
	   response.end
	end if
	
	'插入充值卡消费记录
	dim cardid
	if cdbl(ccsums)=0 then session("cashcard")=""
	
	'取得积分抵扣
	dim fjfcash, fjfnums
	fjfcash = session("fjfcash")
	fjfnums = session("fjfnums")

	if fjfcash="" then fjfcash="0"
	if fjfnums="" then fjfnums="0"

	'插入主单
	sql=" insert into d_retail(retailid,retail,depotid,vipcode,shopcardid,cardid,setdate,x_name,s_name,"&_
		" discount,daystat,sure,chk_sure,comment,s_sums,z_sums,cr_date,cr_name,sellname,sellnametel,dk_price,dk_centum,cx_price)"& _
		" select "&qts(retailid)&","&qts(retailid)&",depotid,vipcode,shopcard,'"&session("cashcard")&"',"&qts(setdate)&",x_name,s_name,"&_
		" discount,daystat,0,0,comment,"&s_sums&","&z_sums&","&qts(get_date(date))&","&qts(username)&","&qts(sellname)&","&qts(sellnametel)&","&_
		""&fjfcash&","&fjfnums&","&yhje&" from webtmp_retail where retailid="&qts(id)
	cd.CommandText = sql
	cd.Execute	
	'liangyu 20090908 修改vip信息未insert明细表
	'插子表
	sql=" insert into d_retailsub(boxid,retailid,vipcardid,vipcentum,clothingid,styleid,sizeid,colorid,nums,x_price,discount,s_price,"&_
			" j_price,larg,back,code,old_jprice,old_xprice,old_sprice,old_rate,j_cost,Fssums)"& _
			" select boxid,"&qts(retailid)&",vipcode,vipcentum,clothingid,styleid,sizeid,colorid,nums,x_price,discount,s_price,j_price,zs,back,"&_
			" code,oldj_price,oldx_price,olds_price,olddiscount,isnull(j_cost,0),(s_price*nums+isnull(FSSums,0))"&_
			" from webtmp_retailsub where retailid="&qts(id)
	cd.CommandText = sql
	cd.Execute
	
'	'积分抵扣(已放将触发器中)
'	if session("posvipcode")<>"" and session("fjfnums")<>"" then
'		'扣减总积分
'	   sql="update vip_user set centum=isnull(centum,0)-("&cint(session("fjfnums"))&") where vipcode='"&session("posvipcode")&"'"
'	   cn.execute sql
'	   	'扣减当前卡上积分
'	   sql="update vip_cardvip set vipcentum=isnull(vipcentum,0)-("&cint(session("fjfnums"))&") where vipcardid='"&session("posvipcode")&"'"
'	   cn.execute sql
'	   session("fjfnums")=""
'	   session("fjfcash")=""
'	end if
	
	'插入短信
	if session("sysendmsg")=1 and sellnametel<>"" then
	   ds.source = "select isnull(comment,'') as msg from sys_system where systemid=2077"
	   ds.open
	   msg=replace(ds("msg"),"$N",sellname)
	   ds.close
	   sql="insert into vip_message (msg,setdate,sure,tel,crdate,crname) "&_
	       "select "&qts(msg)&",convert(char(19),getdate()+0.01,120),0,"&qts(sellnametel)&",getdate(),"&qts(session("dm").system_username)
	   cd.CommandText = sql
	   cd.Execute
	end if
	
	'记录条码
	if session("iftmlist")=1 then
	   sql="insert into t18_tmlist (tmlistid,tmid,clothingid,crname) "&_
	       "select '"&retailid&"',tmid,max(clothingid),'"&session("dm").system_username&"' from webtmp_retailsub "&_
		   "where  retailid="&qts(id) &" and tmid not in (select tmid from t18_tmlist where tmlistid='"&retailid&"') and isnull(tmid,'')<>'' group by tmid"
	   cd.CommandText = sql
	   cd.Execute
	end if
	
	'插入赠送
	'ds.source = "select styleid,colorid,isnull(nums,0) nums,isnull(x_price,0) x_price,isnull(rate,0) rate,isnull(s_price,0) s_price,isnull(j_price,0) j_price from d_retailzstmp where retailid="&qts(id)
	'ds.open
	'Randomize
	'dim aaa
	'while not ds.eof
	'  aaa=Int((10000)*Rnd(now())+1)
	'  sql=" insert into d_retailsub(boxid,retailid,clothingid,styleid,sizeid,colorid,nums,x_price,discount,s_price,j_price,larg,back,code) "& _
	'  " values( "&aaa&","&qts(retailid)&","&qts(ds("styleid"))&","&qts(ds("styleid"))&",0,"&qts(ds("colorid"))&","&ds("nums")&","&ds("x_price")&","&ds("rate")&","&ds("s_price")&","&ds("j_price")&",1,0,-1)"
	  'de sql
	'  cd.CommandText = sql
	'  cd.Execute
	'ds.movenext
	'wend
	'ds.close
	
'	sql=" insert into d_retailsub(boxid,retailid,clothingid,styleid,sizeid,colorid,nums,x_price,discount,s_price,j_price,larg,back,code)"& _
'	" select left(rand()*10000,4),"&qts(retailid)&",styleid,styleid,0,colorid,nums,x_price,rate,s_price,j_price,1,0,-1"& _
'	" from d_retailzstmp where retailid="&qts(id)
'	cd.CommandText = sql
'	cd.Execute
	
	sql="delete from d_retailzstmp where retailid="&qts(retailid)
	cd.CommandText = sql
	cd.Execute
	sql="delete from webtmp_skfs where retailid="&qts(retailid)
	cd.CommandText = sql
	cd.Execute

	'收款方式
	for i=1 to rows
	  if v(i)<>0 then
		sql="insert into pos_skfs(retailid,retype,sums) values("&qts(retailid)&","&qts(retype(i))&","&v(i)&")"
		cd.CommandText = sql
		cd.Execute
		'de sql
	  end if
	next
	
	'导购员
	for i=1 to sac
	  if s_name(i)<>"" then
		sql="insert into jk_retailhistory(retailid,groupid,employeeid,names) values("&qts(retailid)&","&qts(groupid)&","&qts(employeeid(i))&","&qts(s_name(i))&")"
		cd.CommandText = sql
		cd.Execute
	  end if
	next
	
	sql=" update d_retail set chk_date='"&chkdate&"',chk_name="&qts(username)&",sure_date='"&chkdate&"',sure_name="&qts(username)&" where retailid="&qts(retailid) 
	cd.CommandText = sql
	cd.Execute
	
	'审核主单
	sql=" update d_retail set chk_sure=1 where retailid="&qts(retailid) 
	cd.CommandText = sql
	cd.Execute
	
	'主单登帐
	sql=" update d_retail set sure=1 where retailid="&qts(retailid) 
	cd.CommandText = sql
	cd.Execute
	
	'删除临时数据
	sql="delete from webtmp_retail where retailid="&qts(id)
	cd.CommandText = sql
	cd.Execute
    set cd=Nothing
	session("boxid")=1
  End Function
  
  '新建一张零售单(临时)****************************************************************************************************
  Function chkRetailId()
    dim dt
  setdate=trim(request.QueryString("setdate"))
	x_name=trim(request.QueryString("x_name"))
	s_name=trim(request.QueryString("s_name"))
	daystat=trim(request.QueryString("daystat"))
	vipcode=trim(request.QueryString("vipcode"))
	comment=trim(request.QueryString("comment"))
	session("oldid")=""
	session("fjfnums")=""
	session("fjfcash")=""
    session("daystat")=daystat
    session("comment")=comment
    session("x_name")=x_name
    session("s_name")=s_name
    setdate=setdate&" "&get_time(time)
	'de setdate
    ds.Source = "select * from webtmp_retail where retailid='"&retailid&"'"
    ds.Open
    if ds.Eof then '新的
	  dt=time
      dt=hour(dt)&"-"&minute(dt)&"-"&second(dt)
      retailid=depotid&"-"&userid&"-"&dt
      ds.Addnew
	  ds("retailid")=retailid
	  ds("depotid")=depotid
		ds("setdate")=setdate
	  ds("vipcode")=vipcode
	  ds("shopcard")=shopcard
	  ds("daystat")=daystat
	  ds("s_name")=s_name
	  ds("x_name")=x_name
	  ds("comment")=comment
	  ds("userid")=userid
	  ds.Update
	  session("retailid")=retailid
    else
      ds("setdate")=setdate
	  ds("vipcode")=vipcode
	  ds("shopcard")=shopcard
	  ds("daystat")=daystat
	  ds("s_name")=s_name
	  ds("x_name")=x_name
	  ds("comment")=comment
	  ds.Update
    end if
    ds.close
  End Function

  '促销**********************************************************************************************************
  Sub cx()
    '
  End Sub

  'ADO操作********************************************************************************************************8
  Sub CreateAdo()
	set ds=Server.CreateObject("ADODB.Recordset")
	ds.ActiveConnection = cn
	ds.LockType = 3
	set cd=Server.CreateObject("ADODB.Command")
	cd.ActiveConnection = cn
  End Sub
  
  Sub CloseAdo()
    set ds=Nothing
	set cd=Nothing
  End Sub
  
  '取得boxid****************************************************************************************************
  function getboxid()
    if session("boxid")="" then
	  session("boxid")=1
	end if
	session("boxid")=cint(session("boxid"))+1
	getboxid=session("boxid")
  end function
  
  function getboxid_tmp()
    dim ds,boxid,bid
    set ds=server.CreateObject("ADODB.RecordSet")
    ds.ActiveConnection = cn
    ds.Source = "Select top 1 boxid from d_retailsub where boxid like 'W_________' order by boxid desc"
    ds.open
    if not ds.eof then
      boxid=ds(0)
    else
      boxid="W000000000"
    end if
    ds.Close
    Set ds=nothing
    bid=right(boxid,9)
    bid=cdbl(bid)
    bid=bid+1
    boxid="000000000" &bid
    boxid=right(boxid,9)
    boxid="W" &boxid
    getboxid=boxid
  end function

  function editnums(id,nums)
    if isnumeric(nums) then
      cd.Commandtype = 1
	  cd.CommandText = "update webtmp_retailsub set nums="&nums&",vipdisc=0,cxdisc=1 where retailid="&qts(retailid)&" and id="&id
	  cd.Execute
	end if
  end function


  '添加款,不改时间*******************************************************************************
  Sub Addi(clothingid,nums)
    
	
    clothingid=ucase(clothingid)
    if clothingid<>"" then
	
	  sql = "select a.styleid from j_style a where a.helpid="&qts(clothingid)
	  ds.Source = sql '查货号**********
	  ds.open
	  if not ds.eof then '找到了
	    clothingid=trim(ds("styleid"))
	  end if
	  ds.close
	  
	  sql = "select distinct a.styleid,a.colorid,a.sizeid,b.s_name,c.c_name from j_clothing a,j_style b,j_color c "&_
					" where a.styleid=b.styleid and a.colorid=c.colorid and a.clothingid="&qts(clothingid)
	  ds.Source = sql '查货号**********
	  ds.open
	  if not ds.eof then '找到了
	    styleid=ds("styleid")
	    colorid=ds("colorid")
	    sizeid=ds("sizeid")
	    sname=ds("s_name")
		c_name=ds("c_name")
	    ds.close
			sql="select k_num from j_stock where depotid="&qts(depotid)&" and clothingid="&qts(clothingid)
			ds.source = sql '求库存*********
			ds.open
			if not ds.eof then
			  kc=ds(0)
			else
			  kc=0
			end if
			ds.close
	    else '没找到
          ds.close
		  sql="select 1 from j_stock a where a.styleid='"&clothingid&"'"
		  ds.Source = sql
		  ds.open
		  if not ds.eof then '找到了,不带色码
		    ds.close
			set ds=nothing
			set cd=nothing
		    call showinput(clothingid,"addi")
		  else '没找到
		    ds.close
			set ds=nothing
			set cd=nothing
	        call aClose("货号 " & clothingid &" 不存在!")
            response.End
		  end if
	    end if
      end if
    
	if clothingid<>"" then
	  dim j_price,x_price,discount,s_price,v,j_cost
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getclothingprice"
	  v = Session("dm").System_DepotId
	  cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, 1)
	  cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  cd.Parameters.Append cd.CreateParameter("@clothingid", 200, 1, 34, clothingid)
	  Set rs = cd.Execute '求价格*************
	  cd.Parameters.delete 2
	  cd.Parameters.delete 1
	  cd.Parameters.delete 0
  	  If rs.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if
	  
	  j_cost=rs.Fields.Item("j_cost").value
	  If IsNull(j_cost) Then
	    j_cost = 0
	  End If
	  
	  j_price=rs.Fields.Item("j_price").value
	  If IsNull(j_price) Then
	    j_price = 0
	  End If
	  
	  x_price=rs.Fields.Item("x_price").value
	  If IsNull(x_price) Then
	    x_price = 0
	  End If
	  
	  s_price=rs.Fields.Item("s_price").value
	  If IsNull(s_price) Then
	    s_price = 0
	  End If
	  
	  discount=rs.Fields.Item("discount").value
	  If IsNull(discount) Then
	    discount = 0
	  End If
	  rs.Close	
	  set rs=nothing
	  
	'discount = 1 '12月6号新加,问题3
    sql="select top 1 * from webtmp_retailsub"
	ds.LockType = 3
	ds.CursorType = 1
	ds.Source = sql
	ds.Open
	ds.Addnew
	  ds("boxid")=getboxid()
	  ds("retailid")=retailid
	  ds("clothingid")=clothingid
	  ds("styleid")=styleid
	  ds("s_name")=sname
	  ds("colorid")=colorid
	  ds("sizeid")=sizeid
	  ds("c_name")=c_name
	  ds("s_price")=s_price
	  'ds("s_price")=x_price
	  ds("x_price")=x_price
	  ds("j_price")=j_price
	  ds("nums")=nums
	  ds("discount")=discount
	  ds("kc")=kc
	  ds("zs")=0
	  ds("back")=0
	  ds("oldj_price")=j_price
	  ds("oldx_price")=x_price
	  ds("olds_price")=s_price
	  ds("olddiscount")=discount
	  ds("prodiscount")=discount
	  ds("pros_price")=s_price
	ds.Update
	ds.Close
	
	'调用促销*************************************
	'  cd.CommandType = 4
	'  cd.CommandText = "pos_cxgl"
	'  v = Session("dm").System_DepotId
	'  cd.Parameters.Append cd.CreateParameter("@djid", 200, 1, 22, retailid)
	'  cd.Execute '求价格*************
	'  cd.Parameters.delete 0

	end if
  End Sub

End Class
%>
