<!--#include file="inc_header.asp"-->
<%
brand=request.querystring("brand")
istate=request.querystring("istate")

stdate1=request.querystring("stdate1")
stdate2=request.querystring("stdate2")
eddate1=request.querystring("eddate1")
eddate2=request.querystring("eddate2")

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

<h3 align="center">“<%=brand%>”调查分析</h3>
                 
<p align="right">
<button onclick="self.history.go(-1)" class="btn">返　回</button>&nbsp;
<button onclick="javascript:document.form1.submit();" class="btn">导出数据</button>　　&nbsp;
</p>
<form id="form1" name="form1" method="post" action="rep_output.asp" target="_blank">
<input type="hidden" value="brand" name="act" />
<input type="hidden" value="<%=brand%>" name="ID" />
</form>
<%
abc = array("A","B","C","D","E","F","G","H","I","J")
color = array("#0FF","#F0F","#FF0","#00F","#F00","#0F0","#0C0","#00C","#CC0","#C00")
set rs2=server.createobject("adodb.recordset")
sql = "select a.dcid,a.subjectID,a.iSubject,a.iType,a.iOption,a.dcbrand,b.ititle from i_subject a,i_topics b"&_
			" where dcbrand='"&brand&"' and a.dcid=b.dcid order by a.iType"
rs.open sql,cn,1,1
n=1
max = rs.recordcount
%>
<table width="100%" border="0" cellpadding="15" cellspacing="1" style="background:#99bbe8;line-height:20px;margin:10px 0 0 0;font-family:arial;">
  <tr>
    <td bgcolor="#FFFFFF"><strong>该竞争品牌共有&nbsp;<%=max%>&nbsp;条相关调查题目</strong></td>
    </tr>
    <%
do while not rs.eof
ititle="<a style='color:blue' href='rep_showtheme.asp?dcid="&rs("dcid")&"' title='查看此调查详细'>《 <strong>"&rs("ititle")&"</strong> 》</a>&nbsp;<br />"
	response.write "<tr>"
		response.write " <td bgcolor=""#FFFFFF""><strong style='font-size:14px;'>第&nbsp;"&n&"&nbsp;题</strong><br />"
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
				
				response.write "共计有效票数： <strong>"&ps1&"</strong><br><br>"
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
				response.write "（简答题）<br><br>"
				rs2.open "select a.Answer,b.d_name,b.depotid,a.cruser,a.crdate from i_Feedback a,j_depot b where subjectID="&subjectID&" and a.depotid=b.depotid ",cn,1,1
				m=1
				if rs2.eof and rs2.bof then
					response.write "　　<span style=""color:red"">无反馈结果</span><br><br><br>"
				else
					do while not rs2.eof
						response.write "<div style='clear:both;border-bottom:solid 1px #999;'><div style='width:200px;float:left;margin:5px 0;'>"&_
													"　<b>"&m&". </b>"&rs2(1)&"（"&rs2(2)&"）</div> "&_
													"<div style='float:left;margin:5px 0;'><span style='color:blue'>"&rs2(3)&"</span>"&_
													" 答："&rs2(0)&"</div><div style='clear:both'></div></div>"
					m=m+1
					rs2.movenext
					loop
				end if
				rs2.close
			end if
			'附加留言显示
			rs2.open "select Msg,cruser,crdate,depotid from i_subjectMsg where SubjectID="&subjectID&"",cn,1,1
			response.write "<p>该题共计有<strong> "&rs2.recordcount&" </strong>条附加留言。"
			if not rs2.eof and not rs2.bof then
			response.write "<a href='javascript:;' style='color:blue' onclick=""javascript:showmsg('msg-"&subjectID&"',this);"">显示内容</a></p>"
			response.write "<div style='display:none;background:#efefef;line-height:24px;' id='msg-"&subjectID&"'>"
				do while not rs2.eof
					response.write "<div style='border-bottom:solid 1px #CCC;'>　　（"&rs2(3)&"）<span style='color:blue'>"&rs2(1)&"：</span>"
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
<!--#include file="inc_footer.asp"-->
