<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="inc/function.asp" -->
<%
key=trim(request("key"))
cut=request("cut")
if not cut>0 then cut=1
act=request("act")
tmptab=request("tmptab")			'要更新的表 1/0
if tmptab<>"1" then tmptab="0"
if tmptab="1" then 
	tmptab="sys_stylepower18ql" '预留，用于取power库中的数据
else 
	tmptab="sys_stylepower18ql" 
end if
if not tab>0 then tab=0
gb=request("gb") 
chk=request("chk")
id=request("id")

userid=session("dm").System_Userid	

html=""

set rs=server.CreateObject("adodb.recordset")

if act="getroot" then
wsql=""
	sid = split(replace(id,"gb____",""),"$")
	sgb = split(gb,",")
	
	if id="0" then			'ROOT
		id = "gb____"
		root = 0
	else								'Expend
		root = ubound(sid)
		For i=0 to ubound(sid)-1
			val=sid(i+1)
			if trim(val)="_" then val=""
			wsql=wsql&" and isnull(convert(varchar(50),a."&sgb(i)&"),'')='"&val&"' "
		Next
	end if
	
	sql=" select count(*),a."&sgb(root)&" "&_
			" from j_colorstruct a,j_colorstructsub b,sys_stylecolorpower18ql c "&_
			" where a.structid=b.structid "&_
			" and b.stycolorid=c.stylecolorid and c.userid="&qts(userid)&" "&wsql&_
			" group by a."&sgb(root)&" order by a."&sgb(root)&" "
			
	rs.open sql,cn,1,1
	do while not rs.eof
		
		if lcase(chk)="true" then checked=" checked=""checked"" " else checked="" end if
		if root<ubound(sgb) then closed=" class=""closed"" " else closed="" end if
		
			ret=trim(rs(1))
			if ret="" or isnull(ret) or isempty(ret) then ret="_"
		
		html=html&"<li "&closed&"><input type=""checkbox"" id="""&id&"$"&ret&""" "&checked&" class=""gbfolder"" />"&_
		"<label for="""&id&"$"&ret&""">"&ret&"<i> ("&rs(0)&")</i></label>"
		if closed<>"" then html=html&"<ul></ul>"
		html=html&"</li>"
	rs.movenext
	loop
	rs.close
	
elseif act="move" then			'移动部分

			g = split(gb,",")			'group by 
			id= replace(id,"gb____$","")
			x = split(id,",")			'value
			sql3=""

			for n = 0 to ubound(x)
				v = split(x(n),"$")
				sql2=""
				For i = 0 to ubound(v)
					val=v(i)
					if trim(val)="_" then val=""
					if sql2<>"" then sql2 = sql2&" and "
					sql2=sql2&" isnull(convert(varchar(50),"&g(i)&"),'')='"&val&"' "
				Next
				if sql3<>"" then sql3=sql3&" or "
				sql3=sql3&"("&sql2&") "
			next
			
			sql=" update sys_stylecolorpower18ql set selection=0 where userid='"&userid&"' "&_
					" update c set c.selection=1,c.struc1=a.maxname,c.struc2=a.name2,c.struc3=a.name3, "&_
					" c.struc4=a.name4,c.struc5=a.name5,c.struc6=a.name6,c.struc7=a.name7 "&_
					" from j_colorstruct a,j_colorstructsub b,sys_stylecolorpower18ql c "&_
					" where a.structid=b.structid and b.stycolorid=c.stylecolorid and c.userid='"&userid&"'"
			if key<>"" then
				sql2=""
				key = split(key,",")
				For n=0 to ubound(key)
					if n>0 then sql2=sql2&" or "
					sql2=sql2&" substring(c.styleid,"&cut&",len('"&key(n)&"'))='"&key(n)&"' "
				Next
				sql=sql&" and ("&sql2&")"
			elseif sql3<>"" then
				sql=sql&" and ("&sql3&") "
			end if
			cn.Execute (sql)
			'html = sql
		

		sql=" update sys_stylepower18ql set selection=0 where userid='"&userid&"'" 
		sql=sql&" update a set a.selection=1 from sys_stylepower18ql a,sys_stylecolorpower18ql b "&_
	" where a.userid=b.userid and a.styleid=b.styleid  and b.selection=1 and a.userid='"&userid&"'"
     'de sql
cn.Execute (sql)

end if



set rs=nothing
response.Write(html)

%>