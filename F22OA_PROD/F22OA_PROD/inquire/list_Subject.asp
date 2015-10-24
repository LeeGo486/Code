<!--#include file="inc_config.asp"-->
<style>
*{
font-size:12px;
font-family:tahoma;
}
ul{
margin:0 0 0 20px;
}
</style>

<%
act=request("act")
key=request("key")
dcid=request("dcid")
udcid=request("udcid")
str=""
if act<>"" then
	subid=request("subid")
	if isnumeric(subid) then
		'使用
		if act="add" then
				cn.execute("update i_subject set dcid='"&dcid&"' where subjectID="&subid&"")
		'移除
		elseif act="remove" then
				cn.execute("update  i_subject set dcid='' where subjectID="&subid&" and dcid='"&dcid&"'")
		'删除
		elseif act="del" then
				cn.execute("delete from i_subject where subjectID="&subid&" and dcid='"&dcid&"' and readonly=0")
		'往上
		elseif act="up" then
			sql=" select top 1 a.iOrder,b.subjectid,b.iOrder from i_subject a,i_subject b "&_
					" where a.subjectid="&subid&" and b.iOrder<a.iOrder and a.dcid=b.dcid"&_
					" and a.dcid='"&dcid&"' order by b.iOrder desc"
			rs.open sql,cn,1,1
			if not(rs.eof and rs.bof) then
				sql2 = " update i_subject set iOrder="&rs(2)&" where subjectID="&subid&" "&_
							 " update i_subject set iOrder="&rs(0)&" where subjectID="&rs(1)&""
				cn.execute(sql2)
			end if
		'往下
		elseif act="down" then
			sql=" select top 1 a.iOrder,b.subjectid,b.iOrder from i_subject a,i_subject b  "&_
					" where a.subjectid="&subid&" and b.iOrder>a.iOrder and a.dcid=b.dcid "&_
					" and a.dcid='"&dcid&"' order by b.iOrder asc"
			rs.open sql,cn,1,1
			if not(rs.eof and rs.bof) then
				sql2 = " update i_subject set iOrder="&rs(2)&" where subjectID="&subid&" "&_
							 " update i_subject set iOrder="&rs(0)&" where subjectID="&rs(1)&""
				cn.execute(sql2)
			end if
		end if
	end if
		response.write "<script>location.href='list_subject.asp?dcid="&dcid&"'</script>"
end if
if udcid<>"" then 
	sql="select * from i_subject where readonly=0 and DCID<>'"&udcid&"' and cruser='"&username&"' order by iOrder"
else
	str="where DCID='"&dcid&"'"
	sql="select * from i_subject "&str&" order by iOrder"
end if
rs.open sql,cn,1,1
rscount=rs.recordcount
abc = array("A","B","C","D","E","F","G","H","I","J")
	response.write "<div style=""padding:20px;line-height:20px;"">"
if rs.eof and rs.bof then
	response.write "<center style='color:red'>请添加调查题目！  </center>"
else
	response.write "<ul type=1>"
do while not rs.eof
	iOption=rs("iOption")
	subjectID=rs("subjectID")
	opts = split(iOption,",")
	OptStr=""
	if rs("itype")=1 then
		
		for i = 0 to ubound(opts)
			opt = opts(i)
			if trim(opt)="" then opt="<span style='border:solid 1px #FFF;border-bottom:solid 1px #000;width:70px;' >&nbsp;</span>"
			OptStr=OptStr&" <label for="""&subjectID&"_"&i&""" >⊙ "&abc(i)&". "&opt&"</label>　　"
		Next

	elseif rs("itype")=2 then
		for i = 0 to ubound(opts)
			opt = opts(i)
			if trim(opt)="" then opt="<span style='border:solid 1px #FFF;border-bottom:solid 1px #000;width:70px;' >&nbsp;</span>"
			OptStr=OptStr&" <label for="""&subjectID&"_"&i&""">■ "&abc(i)&". "&opt&"</label>　　"
		Next

	elseif rs("itype")=3 then
			OptStr="<span style='border:solid 1px #FFF;border-bottom:solid 1px #000;width:90%;'>&nbsp;</span>"

	end if
		
	response.write "<li style=""padding: 0 0 20px 0;""><b>"
	
	dcbrand=rs("dcbrand")
	if dcbrand<>"" then dcbrand="<span style='color:blue'>["&dcbrand&"]</span>"
	response.write dcbrand&"&nbsp;"&rs("iSubject")
	
	if str<>"" then
		if rs("readonly")<1 then
		response.write " <a href=""#"" onclick=""parent.showMD('add_subject.asp?dcid="&dcid&"&subid="&subjectID&"',650,300);history.go(0)"">"&_
									 " <img alt=""编辑"" src=""scripts/edit.gif"" width=16 height=16 border=0 /></a>"
		response.write " <a href=""?act=del&dcid="&dcid&"&subid="&subjectID&""" onclick=""return confirm('确定永久删除吗？')"">"&_
											"<img alt=""永远删除"" src=""scripts/del.gif""  border=0 /></a>"
		end if
		if rs("readonly")<2 and pedit then
		response.write " <a href=""?act=remove&dcid="&dcid&"&subid="&subjectID&""" onclick=""return confirm('确定移除吗？')"">"&_
											"<img alt=""移除"" src=""scripts/remove.gif"" width=16 height=16 border=0 /></a>"
		response.write " <a href=""?act=up&dcid="&dcid&"&subid="&subjectID&"&iorder="&rs("iOrder")&"""><img alt=""上移"" src=""scripts/moveup.gif"" border=0 /></a>"
		response.write " <a href=""?act=down&dcid="&dcid&"&subid="&subjectID&"&iorder="&rs("iOrder")&"""><img alt=""下移"" src=""scripts/movedown.gif""  border=0 /></a>"
		end if
	
	end if
										
	if str="" then
	response.write " <a href=""#"" onclick=""rtnVal('"&subjectID&"',true)""><img alt=""使用"" src=""scripts/right.gif"" width=16 height=16 border=0 /></a>"
	'response.write " <a href=""#"" onclick=""return confirm('确定移除吗？')"">"&_
	'									"<img alt=""拷贝"" src=""scripts/copy.gif"" width=16 height=16 border=0 /></a>"
	end if

	'config------------------------------------------
	
	response.write "</b><br />"
	response.write OptStr

	response.write "</li>"
rs.movenext
loop
	response.write "</ul>"
	
end if
response.write "</div>"

%>
<script>
function rtnVal(subid,use){
	if(use){
	returnValue=subid;
	window.close();
	}
}
</script>
<script>
function autoheight(){
var frm = parent.document.getElementById("subjectView");
	if(frm){
		parent.document.getElementById("subject").value=<%=rscount%>;
		frm.style.height=window.document.body.scrollHeight;
		frm.style.width='98%';
	}
}
setTimeout(autoheight,10);//推后时间
</script>
<!--#include file="inc_footer.asp"-->
