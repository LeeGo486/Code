<!--#include file="inc_header.asp"-->
<%
dcid=request.querystring("dcid")
depotid=request.QueryString("depotid")
if depotid<>"" then
depotstr=" and depotid='"&depotid&"' "
depotstr2=" and a.depotid='"&depotid&"' "
iyes="全部&nbsp;|&nbsp;"
end if
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
				dpid=rs(0)
				boldstr=""
				if dpid=depotid then boldstr="style='font-weight:bold;'"
			iyeslist=iyeslist&"<a href='?depotid="&dpid&"&dcid="&dcid&"#depot' "&boldstr&" title='查看该店铺填写情况'>"&dpid&"（"&rs(1)&"）"&"</a>， "
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
<script type="text/javascript">
function showmsg(id,self){
	var div = document.getElementById(id)
	if(div.style.display=='none'){
		div.style.display='';
		self.innerHTML='隐藏内容';
	}else{
		div.style.display='none';
		self.innerHTML='显示内容';
	}
}
</script>

<h3 align="center"><%=ititle%></h3>
<p align="center" style="line-height:20px;margin:0">（此次调查共有 <b><%=cy%></b> 间店铺参与，约占调查店铺总数
								 <strong><%=cya%></strong> 间的 <b><%=formatNumber((cy/cya)*100,2,-1,0)%></b> %）</p>
<p align="right">
<button onclick="self.history.go(-1)" class="btn">返　回</button>&nbsp;
<button onclick="location.href='rep_themes.asp'" class="btn">返回列表</button>&nbsp;
<button onclick="javascript:document.form1.submit();" class="btn">导出数据</button>　　&nbsp;
</p>
<div id="lrtable">
<form id="form1" name="form1" method="post" action="rep_output.asp" target="_blank">
<input type="hidden" value="theme" name="act" />
<input type="hidden" value="<%=dcid%>" name="ID" />
<input type="hidden" value="<%=trim(ititle)%>" name="subjectTitle"  />
</form>
<table width="100%" border="0">
  <tr>
    <td>调查编号：</td>
    <td><%=dcid%></td>
  </tr>
  <tr>
    <td>调查状态：</td>
    <td><%=sname%></td>
  </tr>
  <tr>
    <td>调查类型：</td>
    <td><%=tname%></td>
  </tr>
  <tr>
    <td>调查日期：</td>
    <td><%=stdate&" 至 "&eddate%></td>
  </tr>
  <tr>
    <td>调查说明：</td>
    <td><%=iresume%></td>
  </tr>
  <tr>
    <td>已参与店铺：</td>
    <td><a name="depot" href="?dcid=<%=dcid%>#depot"><%=iyes%></a><%=iyeslist%></td>
  </tr>
  <tr>
    <td>未参与店铺：</td>
    <td><%=inolist%></td>
  </tr>
</table>
</div>
<table width="100%" border="0" cellpadding="15" cellspacing="1" style="background:#99bbe8;line-height:20px;margin:10px 0 0 0;font-family:arial;">
<%
abc = array("A","B","C","D","E","F","G","H","I","J")
color = array("#0FF","#F0F","#FF0","#00F","#F00","#0F0","#0C0","#00C","#CC0","#C00")
set rs2=server.createobject("adodb.recordset")
sql = "select subjectID,iSubject,iType,iOption,dcbrand from i_subject where dcid='"&dcid&"' order by iOrder"
rs.open sql,cn,1,1
n=1
max = rs.recordcount
%>
  <tr>
    <td bgcolor="#FFFFFF"><strong>该调查共有&nbsp;<%=max%>&nbsp;题</strong></td>
  </tr>
<%
do while not rs.eof
dcbrand=rs("dcbrand")
	response.write "<tr>"
		response.write " <td bgcolor=""#FFFFFF""><strong>第&nbsp;"&n&"&nbsp;题</strong><br />"
			if dcbrand<>"" then dcbrand="<a style='color:blue' href='rep_showbrand.asp?brand="&server.URLEncode(dcbrand)&"'><strong>["&dcbrand&"]</strong></a>&nbsp;"
			response.write dcbrand&""&rs("iSubject")
			ioption=rs("iOption")
			ipts=split(ioption,",")
			subjectID=rs("subjectID")
			iType=rs("iType")
				rs2.open "select isnull(count(dcid),0) from i_Feedback where subjectID="&subjectID&"  "&depotstr&" ",cn,1,1
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
				rs2.open "select AnswerID from i_Feedback where subjectID="&rs("subjectID")&"  "&depotstr&" ",cn,1,1
					'if rs2.eof and rs2.bof then ps1=0 else ps1=rs2(0) end if
					do while not rs2.eof
						pts = split(rs2("AnswerID"),",")
						ps1 = ps1+eval(ubound(pts)+1)
					rs2.movenext
					loop
				rs2.close
				
				response.write "共计有效票数： <strong>"&ps1&"</strong><br><br>"
				for i = 0 to ubound(ipts)
				rs2.open "select isnull(count(dcid),0) from i_Feedback where subjectID="&subjectID&" and ','+AnswerID+',' LIKE '%,"&i&",%'  "&depotstr&" ",cn,1,1
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
						rs2.open "select AnswerID,Answer from i_Feedback where subjectID="&subjectID&" and ','+AnswerID+',' LIKE '%,"&i&",%'  "&depotstr&" ",cn,1,1
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
							response.write "<div style='height:25px;padding:3px 0;border-left:solid 1px #000'>"&_
														"<div style='border:solid 1px #ddd;border-left:none;width:400px;float:left;height:12px;overflow:hidden'>"&_
														"<div style='background:"&color(i)&";height:12px;width:"&(ps+2)&"px;overflow:hidden'>　</div></div> "&_
														"<div style='float:left;'><span style='color:red;'>"&_
															"　"&abc(i)&". "&xm&"</span> &nbsp; <strong>"&formatNumber((ps/4),2,-1,0)&"%</strong></div></div>"
					else
					'普通备选项 
						response.write "<div style='height:20px;padding:3px 0;border-left:solid 1px #000'>"&_
														"<div style='border:solid 1px #ddd;border-left:none;width:400px;float:left;height:12px;overflow:hidden'>"&_
													"<div style='background:"&color(i)&";height:12px;width:"&(ps+2)&"px;overflow:hidden'>　</div></div> "&_
													"<div style='float:left;'>　"&abc(i)&". "&ipts(i)&" &nbsp; <strong>"&formatNumber((ps/4),2,-1,0)&"%</strong></div></div>"
					end if
				Next
			elseif iType=3 then
'简答----------------------------------------------------------------------------------------------------
				response.write "（简答题）<br>"
				response.write "共计有效票数： <strong>"&ps1&"</strong><br><br>"
				rs2.open "select a.Answer,b.d_name,b.depotid,a.cruser,a.crdate from i_Feedback a,j_depot b where subjectID="&subjectID&" "&_
								 " and a.depotid=b.depotid "&depotstr2&" ",cn,1,1
				m=1
				if rs2.eof and rs2.bof then
					response.write "　　<span style=""color:red"">无反馈结果</span><br><br><br>"
				else
					do while not rs2.eof
						response.write "<div style='clear:both;border-bottom:solid 1px #999;'><div style='width:200px;float:left;margin:5px 0;'>"&_
													"　<b>"&m&". </b>"&rs2(1)&"（"&rs2(2)&"）</div> "&_
													"<div style='float:left;margin:5px 0;'><span style='color:green'>"&rs2(3)&"</span>"&_
													" 答："&rs2(0)&"</div><div style='clear:both'></div></div>"
					m=m+1
					rs2.movenext
					loop
				end if
				rs2.close
			end if
			
			'附加留言显示
			rs2.open "select Msg,cruser,crdate,depotid from i_subjectMsg where SubjectID="&subjectID&" "&depotstr&" ",cn,1,1
			response.write "<p>该题共计有<strong> "&rs2.recordcount&" </strong>条附加留言。"
			if not rs2.eof and not rs2.bof then
			response.write "<a href='javascript:;' style='color:blue' onclick=""javascript:showmsg('msg-"&subjectID&"',this);"">显示内容</a></p>"
			response.write "<div style='display:none;background:#efefef;line-height:24px;' id='msg-"&subjectID&"'>"
				do while not rs2.eof
					response.write "<div style='border-bottom:solid 1px #CCC;'>　　（"&rs2(3)&"）<span style='color:green'>"&rs2(1)&"：</span>"
					response.write ""&rs2(0)&"　"&rs2(2)&"</div>"
				rs2.movenext
				loop
			response.write "</div>"
			end if
			rs2.close
		response.write "</td>"
	response.write "</tr>"
n=n+1
rs.movenext
loop
rs.close
set rs2=nothing
%>
</table>
<script type="text/javascript">
    jsTable('lrtable','lr','100%','120','center');
  </script>
<!--#include file="inc_footer.asp"-->
