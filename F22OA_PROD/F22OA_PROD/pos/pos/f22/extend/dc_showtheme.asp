<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#include file="inc/function.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>自定义调查</title>
<style>
input,textarea,select{ font-family:tahoma; font-size:9pt;}
*{
font-size:12px;
font-family:tahoma;
}
ul{
margin:0 0 0 20px;
}
#jstable{
background:#99bbe8;
}
#jstable th{
background:#d9e5f4;
width:120px;
border-top:solid 1px #f0f5fa;
border-right:solid 1px #f0f5fa;
}
#jstable td{
background:#FFF;
}
h3{
font-size:16px;
}
</style>
<script type="text/javascript">
function showmsg(id,self){
	var div = document.getElementById(id)
	if(div.style.display=='none'){
		div.style.display='';
		div.value='';
		self.innerHTML='取消填写';
	}else{
		div.style.display='none';
		self.innerHTML='填写意见';
	}
}
</script>
</head>

<body>
<%
username=trim(session("dm").System_UserName)
userid=trim(session("dm").System_UserId)
depotid=trim(session("dm").System_Depotid)

set conn=server.CreateObject("adodb.connection")
conn.open session("cn")


dcid=request("dcid")
act=request("act")
if dcid="" then response.Redirect("dc_theme.asp")
set rs=server.CreateObject("adodb.recordset")

if act="submit" then

'删除多余记录
sql="delete from i_feedback where DCID='"&dcid&"' and depotid='"&depotid&"'"
conn.execute(sql)

'插入已选择
rs.open "select * from i_subject where dcid='"&dcid&"' and "&_
				" (dcbrand in (select competename from j_depotcompete where depotid='"&depotid&"')"&_
				" or isnull(dcbrand,'')='')",cn,1,1
do while not rs.eof
subjectid=rs(0)
	opt = request.Form("opt_"&subjectid)
	opt1=split(opt,",")		'一层分割
	idstr=""
	aastr=""
	
	for i=0 to ubound(opt1)
		if instr(opt1(i),".")<=0 then opt1(i)="0."&opt1(i)
		opt2=split(opt1(i),".")		'二层分割
		
		if trim(opt2(1))<>"" then 
			aa=trim(opt2(1))
		else
			aa=trim(request.form("ipt_"&subjectid&"_"&trim(opt2(0))))
		end if
		
		if aa<>"" then
			idstr=idstr&trim(opt2(0))&","
			aastr=aastr&aa&","
		end if
		
	Next
	
	if len(idstr)=0 then
		response.write "<script>alert('请检查该调查所有题目是否已填写！');history.go(-1)</script>"
		response.end
	
	else
		AnswerID = left(idstr,(len(idstr)-1))
		Answer = left(aastr,(len(aastr)-1))
		sql="insert into i_feedback (dcid,depotid,SubjectID,AnswerID,Answer,cruser) "&_
				" values ('"&dcid&"','"&depotid&"','"&subjectid&"','"&AnswerID&"','"&Answer&"','"&username&"')"
		conn.execute(sql)
	end if
	
'添加意见
	msg=trim(request.Form("msg"&subjectid))
	if msg<>"" then msg=replace(replace(replace(replace(msg,"<","&lt;"),">","&gt;"),chr(13)+chr(10)," "),"'","’")
	if msg<>"" then
		sql="insert into i_subjectMsg (SubjectID,depotid,msg,cruser) values ("&subjectid&",'"&depotid&"','"&msg&"','"&username&"')"
		conn.execute(sql)
	end if
rs.movenext
loop
rs.close
	sql="update i_todpt set isok=1 where DCID='"&dcid&"' and depotid='"&depotid&"'"
	conn.execute(sql)
	response.write "<script>alert('保存成功!谢谢!');location.href='dc_theme.asp'</script>"
	response.end()
end if
%>
<%
sql="select * from i_Feedback where dcid='"&dcid&"' and depotid='"&depotid&"'"
rs.open sql,cn,1,1
if rs.eof and rs.bof then
	view=false
else
	view=true
end if
rs.close

sql=" select a.cruser,a.ititle,a.iresume,a.crdate,a.eddate,"&_
		" a.istate,CONVERT(varchar(100), a.stdate, 111) as stdate,"&_
		" a.shuser,a.shdate,a.sxuser,a.sxdate,CONVERT(varchar(100), a.eddate, 111) as eddate,b.typename"&_
		" from i_topics a,i_type b where dcid='"&dcid&"' and a.itype=b.[id]"
rs.open sql,cn,1,1
	if rs.eof and rs.bof then
		response.Redirect("dc_theme.asp")
	else
		cruser=rs("cruser")
		ititle=rs("ititle")
		itypename=rs("typename")
		crdate=rs("crdate")
		eddate=rs("eddate")
		istate=rs("istate")
		stdate=rs("stdate")
		shuser=rs("shuser")
		shdate=rs("shdate")
		sxuser=rs("sxuser")
		sxdate=rs("sxdate")
		eddate=rs("eddate")
		iresume=rs("iresume")
		if iresume="" or isnull(iresume) then iresume="无"
	end if
	rs.close
%>
<table width="100%"  border="0" bordercolor="#C6AEA5" background="../img/smbg_b.gif" class="bk" style="font-size:12px ">
  <tr>
    <td height="21"> 业务中心 &gt;&gt; 扩展功能 &gt;&gt; 自定义调查&gt;&gt; <%=itypename%></td>
    <td align="right"><a href="dc_theme.asp">返 回</a></td>
</tr>
</table>
<h3 align="center"><%=ititle%></h3>
<p align="left" style="line-height:20px;margin:0 20px">
<strong>调查说明：</strong><br />
　　<%=iresume%></p>
<table width="100%" border="0" cellpadding="5" cellspacing="1" id="jstable" >
<form id="form1" name="form1" method="post" action="?">
<input name="act" type="hidden" id="dcid" value="submit" />
<input name="dcid" type="hidden" id="dcid" value="<%=dcid%>" />
  <tr>
    <th>调查编号：</th>
    <td><%=dcid%></td>
    </tr>
  <tr>
    <th>调查类型：</th>
    <td><%=itypename%></td>
    </tr>
  <tr>
    <th>&nbsp;</th>
    <td>
    <%
set rs2=server.createObject("adodb.recordset")
sql="select * from i_subject where DCID='"&dcid&"' order by iOrder"
rs.open sql,cn,1,1
abc = array("A","B","C","D","E","F","G","H","I","J")
	response.write "<div style=""padding:20px;line-height:20px;"">"
if rs.eof and rs.bof then
	response.write "<center style='color:red'>无相关调查题目，请直接提交！  </center>"
else
	response.write "<ul type=1>"
do while not rs.eof
	disstr=""
	disabled=""
	if view then disabled=" disabled=disabled "
	dcbrand= rs("dcbrand")
	'判断竞争品牌
	if dcbrand<>"" then
		sql="select competename from j_depotcompete where depotid='"&depotid&"' and competename='"&dcbrand&"'"
		rs2.open sql,cn,1,1
		if rs2.eof and rs2.bof then
			disstr=disstr&" <span style='color:red'>（注：当前店铺无此竞争品牌，无需填写此项。）</span> "
			disabled=" disabled=disabled"
		end if
		rs2.close
	end if
	iOption=rs("iOption")
	subjectID=rs("subjectID")
	opts = split(iOption,",")
	OptStr=""
	
	'如果有提交过的
	sql="select AnswerID,Answer from i_Feedback where dcid='"&dcid&"' and depotid='"&depotid&"' and subjectID='"&subjectID&"'"
	rs2.open sql,cn,1,1
	if not rs2.eof and not rs2.bof then
		AnswerID=rs2(0)
		Answer=rs2(1)
	end if
	
	rs2.close
	if rs("itype")=1 then
		for i = 0 to ubound(opts)
			opt = opts(i)
			if trim(opt)="" and view then
					if eval(AnswerID)=eval(i) then opt="<span style='color:red;text-decoration:underline'>"&Answer&"</span>"
			elseif trim(opt)="" then
			opt="<input type='text' value='' name=""ipt_"&subjectID&"_"&i&""" "&disabled&""&_
										" onchange=""this.value=this.value.replace(',','，').replace('.','。')"" "&_
										" style='border:solid 1px #FFF;border-bottom:solid 1px #000;width:70px;color:red' />"			
			end if
			OptStr=OptStr&" <label for="""&subjectID&"_"&i&"""><input type=radio name=""opt_"&subjectID&"""  "&disabled&""&_
										" id="""&subjectID&"_"&i&""" value="""&i&"."&opts(i)&""""
											if eval(AnswerID)=eval(i) and answerID<>"" then OptStr=OptStr&" checked=checked "
										OptStr=OptStr&"  /> "&abc(i)&". "&opt&"</label>　　"
		Next

	elseif rs("itype")=2 then
		for i = 0 to ubound(opts)
			opt = opts(i)
			if trim(opt)="" and view then
				iAnswer=""
				sAnswerID=split(AnswerID,",")
				sAnswer = Split(Answer,",")
				for m = 0 to ubound(sAnswerID)
					if eval(trim(sAnswerID(m)))=i then iAnswer=sAnswer(m)
				Next
			opt="<span style='color:red;text-decoration:underline'>"&iAnswer&"</span>"
			elseif  trim(opt)="" then
			opt="<input type='text' value='' name=""ipt_"&subjectID&"_"&i&""" "&disabled&""&_
										" onchange=""this.value=this.value.replace(',','，').replace('.','。')"" "&_
										" style='border:solid 1px #FFF;border-bottom:solid 1px #000;width:70px;color:red' />"			
			end if
			OptStr=OptStr&" <label for="""&subjectID&"_"&i&"""><input type=checkbox name=""opt_"&subjectID&"""  "&disabled&""&_
										" id="""&subjectID&"_"&i&""" value="""&i&"."&opts(i)&""""
										if instr(","&AnswerID&",",","&i&",")>0 then OptStr=OptStr&" checked=checked "
										OptStr=OptStr&"   /> "&abc(i)&". "&opt&"</label>　　"
		Next

	elseif rs("itype")=3 then
			OptStr=" <input type='text' onchange=""this.value=this.value.replace(',','，').replace('.','。')""  "&disabled&""&_
						 " name=""opt_"&subjectID&""" value="""&Answer&""" "&_
						 " style='border:solid 1px #FFF;border-bottom:solid 1px #000;width:90%;color:red;' />"

	end if
		
	response.write "<li style=""padding: 0 0 20px 0;""><b>"
	dcbrand=rs("dcbrand")
	if dcbrand<>"" then dcbrand="<span style='color:blue'>["&dcbrand&"]</span>"
	response.write dcbrand&"&nbsp;"&rs("iSubject")&"&nbsp;</b>"
	if view=false then
	response.write "&nbsp;&nbsp;<a href='javascript:;' "&_
								 " onclick=""javascript:showmsg('msg"&subjectID&"',this);"">填写意见</a>"
	end if
	response.write disstr
	response.write "<br />"
	response.write OptStr
	if view=false then
		response.write "<br><textarea name=""msg"&subjectID&""" style=""display:none;margin:5px 0 0 0;"" cols=""100"" "&_
								 " onkeydown=""if(event.keyCode==13) return false"" rows=""2"" id=""msg"&subjectID&"""></textarea>"				
	else
		'读取附加留言
		rs2.open "select msg,cruser,crdate from i_subjectMsg where depotid='"&depotid&"' and subjectID="&subjectID&"",cn,1,1
		if not rs2.eof and not rs2.bof then 
			response.write "<div style='background:#EFEFEF;padding:5px 10px;margin:5px 0;'>"&_
					"<strong>"&rs2(1)&"</strong>"&rs2(2)&"<br>"&rs2(0)&"</div>"
		end if
		rs2.close
	end if
	response.write "</li>"
rs.movenext
loop
	response.write "</ul>"
	
end if
response.write "</div>"
		%>
    <label>
    </label></td>
  </tr>
  <tr>
    <th>发布日期：</th>
    <td><%=stdate%></td>
  </tr>
  <tr>
    <th>结束日期：</th>
    <td><%=eddate%></td>
  </tr>
  <tr>
    <th>创 建 人：</th>
    <td><%=cruser%></td>
  </tr>
  <tr>
    <th>创建日期：</th>
    <td><%=crdate%></td>
  </tr>
  <tr>
    <th>&nbsp;</th>
    <td style="height:50px;">
    <input type="submit" name="chodpt2" id="chodpt2" value="　提　　交　" class="btn" <%if view then response.write "disabled=disabled"%>/>
    <input type="button" name="chodpt2" id="chodpt2" value="返　回" class="btn"  onclick="self.location.href='dc_theme.asp'" />    </td>
  </tr>
</form>
</table>
</body>
</html>
