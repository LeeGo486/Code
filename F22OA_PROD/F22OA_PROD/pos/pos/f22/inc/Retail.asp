<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%
Class Retail
  Private cn
  Private ds
  Private i
  Private j
  
  Public retailid
  Public retail
  Public depotid
  Public vipcode
  Public setdate
  Public x_name
  Public s_name
  Public discount '整单折扣
  Public daystat
  Public enable'是否已作废
  Public gd '挂单
  Public zj '总计,合计累加
  Public comment
  Public gdComment
  Public RetailArr
  Public RArrTop
  
  Private Sub Class_Initialize()
    cn=session("cn")
	depotid=session("Depotid")
    'If Session("RetailArr")<>""  then
      RetailArr=Session("RetailArr")
	  'RArrTop=UBound(RetailArr,1)
	  RArrTop=Session("RArrtop")
	  'de RArrtop
	  RetailSubArr=Session("RetailSubArr")
	  'RArrSubTop=UBound(RetailSubArr,1)
	  RArrSubTop=Session("RArrSubTop")
	  'response.write Rarrtop
	  'response.end
	'Else
	'  ReDim RetailArr(1,12)
	'  RArrTop=-1
	'End if
	
    'If ((Session("RetailSubArr")<>"") and (not isnull(Session("RetailSubArr")))) then
    '  RetailSubArr=Session("RetailSubArr")
	'  RArrSubTop=UBound(RetailSubArr)
	'Else
	'  ReDim RetailSubArr(1,10)
	'  RArrSubTop=-1
	'End if
  End Sub
    
  Public Sub addRetail() '开始添加新定货单
    retailid=""
    retail=""
    depotid=""
    vipcode=""
    setdate=""
    x_name=""
    s_name=""
    discount=1.0 '整单折扣
    daystat=""
    enable=false '是否已作废
    gd=false '挂单
    zj=0 '总计,合计累加
	comment=""
	gdcomment=""
  End Sub
  
  Public Sub updateRetail() '提交新定货单
  'de RArrtop
    For i=0 to RArrTop'先填充已作废的单
	  if RetailArr(i,0)=retailid then
		'RetailArr(i,0)=retailid
    	RetailArr(i,1)=retail
		RetailArr(i,2)=depotid
		RetailArr(i,3)=vipcode
		RetailArr(i,4)=setdate
		RetailArr(i,5)=x_name
		RetailArr(i,6)=s_name
		'RetailArr(i,7)=discount
		RetailArr(i,8)=daystat
		'RetailArr(i,9)=enable
		'RetailArr(i,10)=gd
		RetailArr(i,11)=zj
		RetailArr(i,12)=comment
		RetailArr(i,13)=gdcomment
		Session("RetailArr")=RetailArr
		call sessionAssign
		Exit Sub
	  end if
	Next
	
    For i=0 to RArrTop'先填充已作废的单
	  if RetailArr(i,9) then
		RetailArr(i,0)=retailid
    	RetailArr(i,1)=retail
		RetailArr(i,2)=depotid
		RetailArr(i,3)=vipcode
		RetailArr(i,4)=setdate
		RetailArr(i,5)=x_name
		RetailArr(i,6)=s_name
		'RetailArr(i,7)=discount
		RetailArr(i,8)=daystat
		'RetailArr(i,9)=enable
		'RetailArr(i,10)=gd
		RetailArr(i,11)=zj
		RetailArr(i,12)=comment
		RetailArr(i,13)=gdcomment
		Session("RetailArr")=RetailArr
		call sessionAssign
		Exit Sub
	  end if
	Next
    'RArrTop=RArrTop+1
	'ReDim RetailArr(RArrTop,11)
	Session("RArrTop")=RArrTop
	RetailArr(RArrTop,0)=retailid
    RetailArr(RArrTop,1)=retail
	RetailArr(RArrTop,2)=depotid
	RetailArr(RArrTop,3)=vipcode
	RetailArr(RArrTop,4)=setdate
	RetailArr(RArrTop,5)=x_name
	RetailArr(RArrTop,6)=s_name
	RetailArr(RArrTop,7)=discount
	RetailArr(RArrTop,8)=daystat
	RetailArr(RArrTop,9)=enable
	RetailArr(RArrTop,10)=gd
	RetailArr(RArrTop,11)=zj
	RetailArr(RArrTop,12)=comment
	RetailArr(RArrTop,13)=gdcomment
	Session("RetailArr")=RetailArr
	call sessionAssign
  End Sub
   
  Public Sub sessionAssign()
    session("Retailid")=Retailid
	session("daystat")=daystat
	session("vipcode")=vipcode
	session("comment")=comment
	session("s_name")=s_name
	session("x_name")=x_name
  End Sub
  
  Public retailsubid
  Public clothingid
  Public styleid
  Public sizeid
  Public colorid
  Public sname
  Public nums
  Public x_price
  Public subdiscount
  Public s_price
  Public j_price
  Public zs '赠送
  Public hj '合计
  Public kc
  
  Public RetailSubArr
  Public RArrSubTop
  
  Public Sub addRetailSub()'准备添加某个款
    retailsubid=""
    clothingid=""
    styleid=""
	sizeid=""
	colorid=""
    sname=""
    nums=0
    x_price=0
    subdiscount=1.0
    s_price=0
	j_price=0
	zs=false
    hj=0 '合计
	kc=0 '库存
	del=false
  End Sub

  Public Sub updateRetailSub() '暂时提交某个款
  
	If nums>0 then
	  for i=0 to RArrSubTop
		If not zs then'不是赠送
	      if RetailSubArr(i,0)=session("retailid") and RetailSubArr(i,1)=clothingid and RetailSubArr(i,11)=false then
		    'response.Write RetailSubArr(i,6)
		    RetailSubArr(i,6)=RetailSubArr(i,6)+nums
			'response.Write RetailSubArr(i,6)
		    RetailSubArr(i,12)=RetailSubArr(i,6)*RetailSubArr(i,9)
			Session("RetailSubArr")=RetailSubArr
		    Exit Sub
		  end if
		 else
		   if RetailSubArr(i,0)=retailsubid and RetailSubArr(i,1)=clothingid and RetailSubArr(i,11) then
		    RetailSubArr(i,6)=RetailSubArr(i,6)+nums
		    'RetailSubArr(i,12)=RetailSubArr(i,4)*RetailSubArr(i,9)
			Session("RetailSubArr")=RetailSubArr
		    Exit Sub
		    end if
		  end if
	  next
	  
	    RArrSubTop=RArrSubTop+1
		Session("RArrSubTop")=RArrSubTop
		'ReDim RetailSubArr(RArrSubTop,12)
        RetailSubArr(RArrSubTop,0)=retailsubid
	    RetailSubArr(RArrSubTop,1)=clothingid
	    RetailSubArr(RArrSubTop,2)=styleid
	    RetailSubArr(RArrSubTop,3)=sizeid
	    RetailSubArr(RArrSubTop,4)=colorid
	    RetailSubArr(RArrSubTop,5)=sname
	    RetailSubArr(RArrSubTop,6)=nums
	    RetailSubArr(RArrSubTop,7)=x_price
	    RetailSubArr(RArrSubTop,8)=subdiscount
	    RetailSubArr(RArrSubTop,9)=s_price
	    RetailSubArr(RArrSubTop,10)=j_price
	    RetailSubArr(RArrSubTop,11)=zs
		if zs then
		  RetailSubArr(RArrSubTop,12)=0
		else
	      RetailSubArr(RArrSubTop,12)=RetailSubArr(RArrSubTop,6)*RetailSubArr(RArrSubTop,9)
		end if
		RetailSubArr(RArrSubTop,13)=kc
		Session("RetailSubArr")=RetailSubArr
	end if
	
  End Sub
  
  Public Sub insertClothingid(clothingidv,zsv)'款号,是否赠送
	dim cn,ds,cd,sql
	
	if clothingidv<>"" then
	'de clothingidv&"aaaaaaaaaaaaa"
	  cn=session("cn")
	  set ds=server.CreateObject("ADODB.RecordSet")
	  ds.ActiveConnection = cn
	  sql = "select distinct a.styleid,a.colorid,a.sizeid,b.s_name from j_clothing a,j_style b where a.styleid=b.styleid and clothingid='"&clothingidv&"'"
	  ds.Source = sql
	  'response.Write(ds.Source)
	  'response.End()
	  ds.open
	  if not ds.eof then
	    styleid=ds(0)
		colorid=ds(1)
		sizeid=ds(2)
		sname=ds(3)
		clothingid=clothingidv
	  else
	    call aClose("货号 " & clothingidv &" 不存在!")
	    response.End
	  end if
	  ds.close
	  sql="select p_num,k_num from j_stock where depotid='"&depotid&"' and clothingid='"&clothingid&"'"
	  ds.source = sql
	  ds.open
	  if not ds.eof then
	    kc=ds("k_num")
	  else
	    kc=0
	  end if
	  set ds=Nothing
	'else
	'  call aClose("货号 不能为空!")
	'  response.End
	end if

	if styleid<>"" then
	  'dim ,j_price,x_price,discount,s_price,
	  dim v,j_cost
	  set cd=Server.CreateObject("ADODB.Command")
	  cd.ActiveConnection = cn
	  cd.CommandType = 4
	  cd.CommandText = "t18tj_Getstyleprice"
	  v = Session("dm").System_DepotId
	  cd.Parameters.Append cd.CreateParameter("@dtype", 3, 1, 4, 1)
	  cd.Parameters.Append cd.CreateParameter("@depotid", 200, 1, 10, v)
	  cd.Parameters.Append cd.CreateParameter("@styleid", 200, 1, 34, styleid)
	  'cd.Parameters.Append cd.CreateParameter("@pricedate", adVarChar, adParamInput, 10, "")
	  'Response.End
	  Set ds = cd.Execute
  	  If ds.eof then
	    call aClose("款式编码出错!请重新输入!")
		response.End()
	  End if
	  
	  'Call addRetailSub
	  retailsubid=session("retailid")
	  'de retailsubid
	  nums=1
	  If IsNull(ds.Fields.Item("j_cost").value) Then
	    j_cost = "0"
	  Else
	    j_cost = CStr(ds.Fields.Item("j_cost").value)
	  End If
	  If IsNull(ds.Fields.Item("j_price").value) Then
	    j_price = "0"
	  Else
	    j_price = CStr(ds.Fields.Item("j_price").value)
	  End If
	  If IsNull(ds.Fields.Item("x_price").value) Then
	    x_price = "0"
	  Else
	    x_price = CStr(ds.Fields.Item("x_price").value)
	  End If
	  If IsNull(ds.Fields.Item("s_price").value) Then
	    s_price = "0"
	  Else
	    s_price = CStr(ds.Fields.Item("j_price").value)
	  End If
	  If IsNull(ds.Fields.Item("discount").value) Then
	    subdiscount = "0"
	  Else
	    subdiscount = CStr(ds.Fields.Item("discount").value)
	  End If
	  ds.Close
	  zs=zsv
	  Call updateRetailSub
	  'de sname
	  'de RetailSubArr(RArrSubTop,5)
	end if
  End Sub
  
  Public Sub delClothingid(clothingidv)'
    Call editClothingid(clothingidv,0)
  End Sub
  
  Public Sub editClothingid(clothingidv,num)'
    For i=0 to RArrSubTop
	  if RetailSubArr(i,0)=Retailid and RetailSubArr(i,1)=clothingidv then
	    RetailSubArr(i,6)=num
	  end if
	Next
  End Sub
  
  Public Sub setRetailZk(id,discount)
    id=trim(id)
	discount=cdbl(discount)
	if discount<0.0 then discount=0.0
	if discount>1.0 then discount=1.0
	if id<>"" then
      For i=0 to RArrTop
	    If id=RetailArr(i,0) then
	      RetailArr(i,7)=discount
	    end if
	  Next
	else
	
	end if
  End Sub
  
  Public Sub setRetailZf(id)'整单作废
    id=trim(id)
	If id<>"" Then
      For i=0 to RArrTop
	    if id=RetailArr(i,0) then
	      RetailArr(i,9)=true
		  Call newRetailid '产生新单号
		  Exit Sub
	    end if
	  Next
	Else
	  Err.Raise 50001,"Retail.setRetailZf","整单作废时,单号不能为空!"
	End if
  End Sub
  
  Public Sub setRetailGd(id,gdc)'挂单
    id=trim(id)
	If id<>"" Then
      For i=0 to RArrTop
	    if id=RetailArr(i,0) then
	      RetailArr(i,10)=true
		  RetailArr(i,13)=gdc
		  Call newRetailid '产生新单号
		  Exit Sub
	    end if
	  Next
	Else
	  Err.Raise 50001,"Retail.setRetailGd","挂单时,单号不能为空!"
	End if
  End Sub
  
  Public Function getRetailGd(id)'取单
    id=trim(id)
	If id<>"" Then
      For i=0 to RArrTop
	    if id=RetailArr(i,0) then
	      RetailArr(i,10)=false
		  Session("Retailid")=id
		  Exit Function
	    end if
	  Next
	Else
	  Err.Raise 50001,"Retail.getRetailGd","取单时,单号不能为空!"
	End if
  End Function
 
  Public Sub saveRetail(id)'保存单
  printRetailArr(0)
    Dim tmp
    id=trim(id)
	If id<>"" Then
	  For i=0 to RArrTop
	    if id=RetailArr(i,0) then
		  Set ds=Server.CreateObject("ADODB.Recordset")
		  ds.ActiveConnection = cn
		  ds.LockType = 3
		  ds.Source = "select top 1 * from d_retail order by retailid"'保存主单
		  ds.Open
		  ds.AddNew
			ds("retailid")=RetailArr(i,0)
			ds("retail")=RetailArr(i,1)
			ds("depotid")=RetailArr(i,2)
			ds("vipcode")=RetailArr(i,3)
			ds("setdate")=RetailArr(i,4)
			ds("x_name")=RetailArr(i,5)
			ds("s_name")=RetailArr(i,6)
			ds("discount")=RetailArr(i,7)
			ds("daystat")=RetailArr(i,8)
			ds("sure")=0
			ds("chk_sure")=0
			ds("cr_date")=date
		  ds.Update
		  ds.Close
		  
		  tmp=0
		  For j=0 to RArrSubTop
		    if RetailSubArr(i,0)=id then
		      ds.Source = "select top 1 * from d_retailsub order by retailid"'保存子单
		      ds.Open
		      ds.AddNew
			    tmp=tmp+1
			    ds("boxid")="LS" & Right("0000"+tmp)
			    ds("retailid")=RetailArr(j,0)
			    ds("clothingid")=RetailArr(j,1)
			    ds("styleid")=RetailArr(j,2)
			    ds("sizeid")=RetailArr(j,3)
			    ds("colorid")=RetailArr(j,4)
			    ds("nums")=RetailArr(j,6)
			    ds("x_price")=RetailArr(j,7)
			    ds("discount")=RetailArr(j,8)
			    ds("s_price")=RetailArr(j,9)
				ds("j_price")=RetailArr(j,10)
			  ds.Update
		      ds.Close
			end if
		  Next
		  RetailArr(i,9)=true'保存完后,设为作废即可
		  Set ds=nothing
		  Call newRetailid '产生新单号
		  Exit Sub
		end if
	  Next
	Else
	  Err.Raise 50001,"Retail.saveRetail","保存时,单号不能为空!"
	End if
  End Sub
  
  Sub printRetailSubArr(i)
    response.Write "<br>0 -> Retailsubid: "&RetailSubArr(i,0)
    response.Write "<br>1 -> clothingid: "&RetailSubArr(i,1)
    response.Write "<br>2 -> styleid: "&RetailSubArr(i,2)
    response.Write "<br>3 -> sizeid: "&RetailSubArr(i,3)
    response.Write "<br>4 -> colorid: "&RetailSubArr(i,4)
    response.Write "<br>5 -> sname: "&RetailSubArr(i,5)
    response.Write "<br>6 -> nums: "&RetailSubArr(i,6)
    response.Write "<br>7 -> x_price: "&RetailSubArr(i,7)
    response.Write "<br>8 -> subdiscount: "&RetailSubArr(i,8)
    response.Write "<br>9 -> s_price: "&RetailSubArr(i,9)
    response.Write "<br>10 -> j_price: "&RetailSubArr(i,10)
    response.Write "<br>11 -> zs: "&RetailSubArr(i,11)
    response.Write "<br>12 -> hj: "&RetailSubArr(i,12)
	'response.End()
  End Sub

  Sub printRetailArr(i)
    response.Write "<br>0 -> Retailid: "&RetailArr(i,0)
    response.Write "<br>1 -> retail: "&RetailArr(i,1)
    response.Write "<br>2 -> depotid: "&RetailArr(i,2)
    response.Write "<br>3 -> vipcode: "&RetailArr(i,3)
    response.Write "<br>4 -> setdate: "&RetailArr(i,4)
    response.Write "<br>5 -> x_name: "&RetailArr(i,5)
    response.Write "<br>6 -> s_name: "&RetailArr(i,6)
    response.Write "<br>7 -> discount: "&RetailArr(i,7)
    response.Write "<br>8 -> daystat: "&RetailArr(i,8)
	response.End()
  End Sub

  Function newRetailid()
    session("Retailid")=cint(session("Retailid"))+1
  End Function
  
End Class%>