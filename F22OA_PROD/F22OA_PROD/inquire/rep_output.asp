<!--#include file="inc_config.asp"-->
<%
act=request.form("act")
ID=request.form("ID")
subjectTitle=request.form("subjectTitle")
if act="brand" then
filename=server.urlencode(ID&"_调查分析")
elseif act="theme" then
filename=server.urlencode(left(trim(subjectTitle),12)&"_调查分析")
else
	response.write "参数错误"
	response.end()
end if

abc = array("A","B","C","D","E","F","G","H","I","J")
set rs2=server.createobject("adodb.recordset")

'输出Excel文件
Response.AddHeader "Content-type","application/vnd.ms-excel"
Response.AddHeader "Content-Disposition","attachment;filename="&filename&"_"&right(year(now()),2)&"-"&month(now())&"-"&day(now())&".xls"


if act="theme" then
	call showtheme
elseif act="brand" then
	call showbrand
else
	response.write server.urlencode("参数错误")
	response.end()
end if

'显示主题调查
sub showtheme
dcid=ID
if dcid<>"" then
	sql=" select d.[typename] as tname,e.[statename] as sname,(select count(dcid) from i_todpt b where b.dcid =a.dcid and b.isok=1) as cy,"&_
			" (select count(c.dcid) from i_todpt c where c.dcid =a.dcid) as cya,"&_
			" a.* from i_topics a,i_type d,i_state e where dcid='"&dcid&"' and a.itype = d.[ID] and a.istate = e.[ID] "
	rs.open sql,cn,1,1
	if not(rs.eof and rs.bof) then
		cy=rs("cy")
		cya=rs("cya")
		tname=rs("tname")
		sname=rs("sname")
		cruser=rs("cruser")
		ititle=rs("ititle")
		iresume=rs("iresume")
		itype=rs("itype")
		crdate=rs("crdate")
		eddate=rs("eddate")
		istate=rs("istate")
		stdate=rs("stdate")
		eddate=rs("eddate")
	end if
	rs.close
	iyeslist=""
	inolist=""
	rs.open "select b.depotid,b.d_name,a.isok from i_todpt a,j_depot b where a.dcid ='"&dcid&"' and a.depotid=b.depotid"
		do while not rs.eof
			if rs(2)=1 then
			iyeslist=iyeslist&rs(0)&"（"&rs(1)&"）"&"， "
			else
			inolist=inolist&rs(0)&"（"&rs(1)&"）"&"， "
			end if
		rs.movenext
		loop
		if len(iyeslist)>2 then iyeslist=left(iyeslist,len(iyeslist)-2) else iyeslist="无" end if
		if len(inolist)>2 then inolist=left(inolist,len(inolist)-2) else inolist="无" end if
	rs.close
else
	response.Redirect("rep_themes.asp")
	response.End()
end if

%>
<table border="1" cellpadding="10" cellspacing="0"  style="border-collapse:collapse;font-family:arial;font-size:12px;width:19cm;">
    <tr>
      <td bgcolor="#FFFFFF" height=45 align=center><strong style="font-size:16px;"><%=subjectTitle%></strong></td>
      </tr>
    <tr>
      <td bgcolor="#FFFFFF" height=30>此次调查共有 <b><%=cy%></b> 间店铺参与，约占调查店铺总数
								 <strong><%=cya%></strong> 间的 <b><%=formatNumber((cy/cya)*100,2,-1,0)%></b> %</td>
      </tr>
      <tr>
        <td><strong>调查类型：</strong><%=tname%></td>
      </tr>
      <tr>
        <td><strong>调查日期：</strong><%=stdate&" 至 "&eddate%></td>
      </tr>
      <tr>
        <td><strong>调查说明：</strong><%=iresume%></td>
      </tr>
      <tr>
        <td><strong>已参与店铺：</strong><%=iyeslist%></td>
      </tr>
      <tr>
        <td><strong>未参与店铺：</strong><%=inolist%></td>
      </tr>
      
<%
sql = "select subjectID,iSubject,iType,iOption,dcbrand from i_subject where dcid='"&dcid&"' order by iOrder"
rs.open sql,cn,1,1
n=1
do while not rs.eof
dcbrand=rs("dcbrand")
	response.write "<tr>"
		response.write " <td bgcolor=""yellow"" height=35><strong>第&nbsp;"&n&"&nbsp;题：</strong>"
			if dcbrand<>"" then dcbrand="<strong>["&dcbrand&"]</strong>&nbsp;"
			response.write dcbrand&""&rs("iSubject")
			ioption=rs("iOption")
			ipts=split(ioption,",")
			subjectID=rs("subjectID")
			iType=rs("iType")
				rs2.open "select isnull(count(dcid),0) from i_Feedback where subjectID="&subjectID&"",cn,1,1
					if rs2.eof and rs2.bof then ps1=0 else ps1=rs2(0) end if
				rs2.close
			if iType=1 or  iType=2 then
			
'单选/多选----------------------------------------------------------------------------------------------------

				if iType=1 then
				response.write "（单选题）<br>"
				else
				response.write "（多选题）<br>"
				end if
				ps1=0
				rs2.open "select AnswerID from i_Feedback where subjectID="&rs("subjectID")&"",cn,1,1
					'if rs2.eof and rs2.bof then ps1=0 else ps1=rs2(0) end if
					do while not rs2.eof
						pts = split(rs2("AnswerID"),",")
						ps1 = ps1+eval(ubound(pts)+1)
					rs2.movenext
					loop
				rs2.close
				
				response.write "</td></tr><tr><td>共计有效票数： <strong>"&ps1&"</strong></td></tr>"
				for i = 0 to ubound(ipts)
				rs2.open "select isnull(count(dcid),0) from i_Feedback where subjectID="&subjectID&" and ','+AnswerID+',' LIKE '%,"&i&",%'",cn,1,1
				if rs2.eof and rs2.bof then
					 ps2=0 
				 else 
					 ps2=rs2(0) 
				 end if
				rs2.close
					if ps2=0 then 
						ps=0
					else
						ps = formatNumber((ps2/ps1)*400,2,-1,0)
					end if
					
					'有备填项 
					xm=""
					if trim(ipts(i))="" then
						rs2.open "select AnswerID,Answer from i_Feedback where subjectID="&subjectID&" and ','+AnswerID+',' LIKE '%,"&i&",%'",cn,1,1
						do while not rs2.eof
							AnsID = split(rs2(0),",")	'分隔问题ID
							Ans = split(rs2(1),",")		'分隔问题
							for m = 0 to ubound(AnsID)
								if eval(i) = eval(trim(AnsID(m))) then xm=xm&"，"&Ans(m)
							Next
						rs2.movenext
						loop
						rs2.close
						'截取第一个字符
						if xm<>"" then xm = right(xm,len(xm)-1)
							response.write "<tr><td height=25><span style='color:red;'>"&_
															"　　"&abc(i)&". "&xm&"</span> &nbsp; <strong>"&formatNumber((ps/4),2,-1,0)&"%</strong></td></tr>"
					else
					'普通备选项 
						response.write "<tr><td height=25>　　"&abc(i)&". "&ipts(i)&" &nbsp; <strong>"&formatNumber((ps/4),2,-1,0)&"%</strong></td></tr>	"
					end if
				Next
			elseif iType=3 then
'简答----------------------------------------------------------------------------------------------------
			response.write "（简答题）</td></tr>"
			response.write "<tr><td height=20>共计有效票数： <strong>"&ps1&"</strong></td></tr>"
				
				rs2.open "select a.Answer,b.d_name,b.depotid,a.cruser,a.crdate from i_Feedback a,j_depot b where subjectID="&subjectID&" and a.depotid=b.depotid ",cn,1,1
				m=1
				if rs2.eof and rs2.bof then
					response.write "<tr><td height=35>　　<span style=""color:red"">无反馈结果</span></td></tr>"
				else
					do while not rs2.eof
						response.write "<tr><td height=25>"&_
													"　<b>"&m&". </b>"&rs2(1)&"（"&rs2(2)&"） "&_
													"<span style='color:green'>"&rs2(3)&"</span>"&_
													" 答："&rs2(0)&"</td></tr>"
					m=m+1
					rs2.movenext
					loop
				end if
				rs2.close
			end if
			
n=n+1
rs.movenext
loop
rs.close
%>
</table>
<%
End sub

'显示品牌调查的
sub showbrand
brand=ID
sql = "select a.dcid,a.subjectID,a.iSubject,a.iType,a.iOption,a.dcbrand,b.ititle from i_subject a,i_topics b"&_
			" where dcbrand='"&brand&"' and a.dcid=b.dcid order by a.iType"
rs.open sql,cn,1,1
n=1
max = rs.recordcount
%>
<table border="1" cellpadding="10" cellspacing="0"  style="border-collapse:collapse;font-family:arial;font-size:12px;width:19cm;">
    <tr>
      <td bgcolor="#FFFFFF" height=45 align=center><strong style="font-size:16px;">“<%=brand%>”调查分析</strong></td>
      </tr>
      <%
  do while not rs.eof
		ititle="<span>《 <strong>"&rs("ititle")&"</strong> 》</span>"
    response.write "<tr>"
      response.write " <td bgcolor=""yellow"" height=35><strong style='font-size:14px;'>第&nbsp;"&n&"&nbsp;题</strong>"
        response.write ititle&""&rs("iSubject")
        ioption=rs("iOption")
        ipts=split(ioption,",")
        subjectID=rs("subjectID")
        iType=rs("iType")
          rs2.open "select isnull(count(dcid),0) from i_Feedback where subjectID="&subjectID&"",cn,1,1
            if rs2.eof and rs2.bof then ps1=0 else ps1=rs2(0) end if
          rs2.close
        if iType=1 or  iType=2 then
  '多选----------------------------------------------------------------------------------------------------
          if iType=1 then
          response.write "（单选题）"
          else
          response.write "（多选题）"
          end if
          ps1=0
          rs2.open "select AnswerID from i_Feedback where subjectID="&rs("subjectID")&"",cn,1,1
            'if rs2.eof and rs2.bof then ps1=0 else ps1=rs2(0) end if
            do while not rs2.eof
              pts = split(rs2("AnswerID"),",")
              ps1 = ps1+eval(ubound(pts)+1)
            rs2.movenext
            loop
          rs2.close
          
          response.write "</td></tr><tr><td height=20>共计有效票数： <strong>"&ps1&"</strong></td></tr>"
          for i = 0 to ubound(ipts)
          rs2.open "select isnull(count(dcid),0) from i_Feedback where subjectID="&subjectID&" and ','+AnswerID+',' LIKE '%,"&i&",%'",cn,1,1
          if rs2.eof and rs2.bof then
             ps2=0 
           else 
             ps2=rs2(0) 
           end if
          rs2.close
            if ps2=0 then 
              ps=0
            else
              ps = formatNumber((ps2/ps1)*400,2,-1,0)
            end if
            
            '有备填项 
            if trim(ipts(i))="" then
            xm=""
              rs2.open "select AnswerID,Answer from i_Feedback where subjectID="&subjectID&" and ','+AnswerID+',' LIKE '%,"&i&",%'",cn,1,1
              do while not rs2.eof
                AnsID = split(rs2(0),",")	'分隔问题ID
                Ans = split(rs2(1),",")		'分隔问题
                for m = 0 to ubound(AnsID)
                  if eval(i) = eval(trim(AnsID(m))) then xm=xm&"，"&Ans(m)
                Next
              rs2.movenext
              loop
              rs2.close
              if xm<>"" then xm=right(xm,len(xm)-1)
							response.write "<tr><td height=25><span style='color:red;'>"&_
															"　　"&abc(i)&". "&xm&"</span> &nbsp; <strong>"&formatNumber((ps/4),2,-1,0)&"%</strong></td></tr>"
            else
            '普通备选项 
              response.write "<tr><td height=25>　　"&abc(i)&". "&ipts(i)&" &nbsp; <strong>"&formatNumber((ps/4),2,-1,0)&"%</strong></td></tr>"
            end if
          Next
        elseif iType=3 then
  '简答----------------------------------------------------------------------------------------------------
          response.write "（简答题）</td></tr>"
          rs2.open "select a.Answer,b.d_name,b.depotid,a.cruser,a.crdate from i_Feedback a,j_depot b where subjectID="&subjectID&" and a.depotid=b.depotid ",cn,1,1
          m=1
          response.write "<tr><td>共计有效票数： <strong>"&rs2.recordcount&"</strong></td></tr>"
          if rs2.eof and rs2.bof then
            response.write "<tr><td height=25>　　<span style=""color:red"">无反馈结果</span></td></tr>"
          else
            do while not rs2.eof
              response.write "<tr><td height=25>　　<span style='color:blue'>"&rs2(3)&"：</span>"&rs2(0)&"</div><div style='clear:both'></td></tr>"
            m=m+1
            rs2.movenext
            loop
          end if
          rs2.close
        end if
      response.write "</td>"
    response.write "</tr>"
  n=n+1
  rs.movenext
  loop
  rs.close
  set rs2=nothing
  %>
  </table>
<%
End sub
set rs2=nothing
set rs=nothing

%>
