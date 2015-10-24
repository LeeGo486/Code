<%

set rs=server.CreateObject("adodb.recordset")

'得到权限
if formid<>"" then
	rs.open "f18master.dbo.f22_getUserForm18 '"&userid&"','"&formid&"'",cn,1,1
	if not rs.eof and not rs.bof then
	if not isNull(rs("pwrin")) then pwrin=cdbl(rs("pwrin")) else pwrin=false end if
	if not isNull(rs("pexport")) then pexport=cdbl(rs("pexport")) else pexport=false end if
	if not isNull(rs("pprint")) then pprint=cdbl(rs("pprint")) else pprint=false end if
	if not isNull(rs("pchk")) then pchk=cdbl(rs("pchk")) else pchk=false end if
	if not isNull(rs("psure")) then psure=cdbl(rs("psure")) else psure=false end if
	if not isNull(rs("padd")) then padd=cdbl(rs("padd")) else padd=false end if
	if not isNull(rs("pedit")) then pedit=cdbl(rs("pedit")) else pedit=false end if
	if not isNull(rs("pdel")) then pdel=cdbl(rs("pdel")) else pdel=false end if
	if not isNull(rs("punchk")) then punchk=cdbl(rs("punchk")) else punchk=false end if
	if not isNull(rs("punsure")) then punsure=cdbl(rs("punsure")) else punsure=false end if
	if not isNull(rs("pwr_cost")) then pcost=cdbl(rs("pwr_cost")) else pcost=false end if
	if not isNull(rs("pwr_price")) then pxprice=cdbl(rs("pwr_price")) else pxprice=false end if
	if not isNull(rs("pwr_sprice")) then psprice=cdbl(rs("pwr_sprice")) else psprice=false end if
	end if
	rs.close
end if
'过滤HTML代码
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
		strHTML=replace(strHTML,chr(13)+chr(10)," ")
		RemoveHTML=strHTML 
		Set objRegExp = Nothing 
	end if
End Function

'获取单选品牌列表
function getbrand(val)
		sql="select lookname from j18_lookupsub where lookupid='8001' "
		rs.open sql,cn,1,1
      response.write "<option value=""""></option>"
		do while not rs.eof
		brandid=rs(0)
			response.write "<option value="""&brandid&""""
			if trim(val)=trim(brandid) then response.write " selected=selected"
			response.write ">"&brandid&"</option>"
		rs.movenext
		loop
		rs.close
end function

'类别列表
function gettype(sel)
		sql="select [ID],typename from i_type order by [ID] "
		rs.open sql,cn,1,1
		response.write "<option value=""0"" ></option>"
		do while not rs.eof
		typeid=rs(0)
			response.write "<option value="""&typeid&""""
			if eval(sel)=eval(typeid) then response.write " selected=selected"
			response.write ">"&rs(1)&"</option>"
		rs.movenext
		loop
		rs.close
end function

'获取状态列表
function getstate(sel)
		sql="select [ID],statename from i_state where [ID] in (2,10,12) order by [ID] "
		rs.open sql,cn,1,1
			response.write "<option value=""""></option>"
		do while not rs.eof
		stateid=rs(0)
			response.write "<option value="""&stateid&""""
			if eval(sel)=eval(stateid) then response.write " selected=selected"
			response.write ">"&rs(1)&"</option>"
		rs.movenext
		loop
		rs.close
end function

'获取品牌列表
function getbrands(dcid)
		sql="select lookname from j18_lookupsub where lookupid='8001' "&_
				" and lookname  not in (select dcbrand from i_subject where dcid='"&dcid&"' )"
		rs.open sql,cn,1,1
		do while not rs.eof
		brandid=trim(rs(0))
			response.write "<option value="""&brandid&""">"&brandid&"</option>"
		rs.movenext
		loop
		rs.close
end function

'获取已选品牌列表
function getbrds(dcid)
	sql="select lookname from j18_lookupsub where lookupid='8001' "&_
	    " and lookname in (select dcbrand from i_subject where dcid='"&dcid&"' )"
	rs.open sql,cn,1,1
	do while not rs.eof
	brandid=trim(rs(0))
		response.write "<option value="""&brandid&""">"&brandid&"</option>"
	rs.movenext
	loop
	rs.close
end function

'获取店铺列表
function getdepot(dcid)
	sql="select depotid,d_name from j_depot where depotid not in(select depotid from i_todpt where dcid='"&dcid&"') order by depotid"
	rs.open sql,cn,1,1
	do while not rs.eof
	depotid=rs(0)
		response.write "<option value="""&depotid&""" ondblclick=""alert('aa')"">"&depotid&"（"&rs(1)&"）</option>"
	rs.movenext
	loop
	rs.close
end function

'获取已选择的店铺列表
function getdptList(dcid)
	sql="select a.depotid,a.d_name from j_depot a,i_todpt b where b.dcid='"&dcid&"' and a.depotid=b.depotid order by a.depotid"
	rs.open sql,cn,1,1
	do while not rs.eof
	depotid=rs(0)
		response.write "<option value="""&depotid&""">"&depotid&"（"&rs(1)&"）</option>"
	rs.movenext
	loop
	rs.close
end function

'获取调查类型
function getitype(itype)
	sql="select [id],typename from i_type order by [ID]"
	rs.open sql,cn,1,1
	if rs.eof and rs.bof then
		response.write "<option>请先建立一个类型</option>"
	else
		response.write "<option value=""""> -- 请选择 -- 	</option>"
		do while not rs.eof
		depotid=rs(0)
			response.write "<option value="""&depotid&""""
			if cdbl(itype)=cdbl(depotid) then response.write " selected=selected"
			response.write ">"&rs(1)&"</option>"
		rs.movenext
		loop
	end if
	rs.close
	
end function

'将到期的调查结束
cn.execute("update i_topics set istate=10 where (getdate()-1)>eddate and istate=2")
%>