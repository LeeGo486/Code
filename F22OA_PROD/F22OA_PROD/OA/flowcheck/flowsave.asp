<!-- #include file="setup.asp" -->
<%
typ=HTMLEncode(request.Form("typ"))
Content=request.Form("Content")
Content=replace(Content,chr(13)+chr(10),"")
Typeid=RequestInt("typeid")
Baseid=RequestInt("baseid")
Stateid=RequestInt("stateid")
Title=trim(HTMLEncode(request.Form("title")))
flowtype=HTMLEncode(request.Form("flowtype"))
Tid=RequestInt("tid")

if Content="" then
   mbox("文档内容不能为空！")
else
  set rs=server.CreateObject("ADODB.Recordset")
  select case typ
   case "newadd"  newadd   '新增
   case "read"    readedit '编辑
  end select
  set rs=nothing
end if


Sub newadd
   '得到第一个待处理人
   sql="select top 1 b.userid from O_base a,O_basesub b where a.baseid=b.baseid and a.baseid="&Baseid&" and b.ifedit=0 order by orders" 
   rs.open sql,Conn,1,1
   if rs.eof then
      mbox("此流程方案还未设定审批流程！")
   else
      clname=rs("userid")
   end if
   rs.close

   rs.open "select * from O_Threads",Conn,3,3
   rs.addnew
	  rs("typeid")=Typeid
	  rs("baseid")=Baseid
	  rs("stateid")=Stateid
	  rs("title")=title
	  rs("content")=Content
	  rs("crname")=request.Cookies("UserName")
	  rs("clname")=clname
	  rs("lastname")=Request.Cookies("Userid") 'lastname是记录上一个处理人
	  rs("lastdatetime")=Now()
	  rs("isov")=0
  	  rs.update
	  rs.MoveLast
	  Tid=rs("tid")
   rs.close
   '日志
   Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'提交文档','"&request.Cookies("UserName")&"')"
   Conn.execute Sql
   response.write("<script>alert('提交成功！')</script>")
   response.redirect "flowcheck.asp"
End Sub

Sub readedit
   if Tid=0 then
      mbox("参数出错！")
   else
     select case flowtype
     case "再次提交"  ReSubmit
     case "审批通过"  CheckPass
     case "退回"      Return
     case "结束"      Isover
     end select
   end if
   
   Call zclose
End Sub

Sub Resubmit
  '得到当前操作人的顺序号
  rs.open "select orders from O_basesub where baseid="&baseid&" and userid='"&request.cookies("userid")&"'",conn,1,1
  '如果不存在则是文档的提交人
  if not rs.eof then
     orders=rs("orders")
  else
     orders=0
  end if
  rs.close
  '得到下一个待处理人
  sql="select top 1 b.userid from O_base a,O_basesub b where a.baseid=b.baseid and a.baseid="&Baseid&" and b.ifedit=0 "&_
      "and b.orders>"&orders&" order by orders" 
  rs.open sql,Conn,1,1
   if rs.eof then
      mbox("此流程已结束！")
   else
      clname=rs("userid")
   end if
   rs.close
   
   rs.open "select * from O_Threadsub",Conn,3,3
   rs.addnew
	  rs("tid")=Tid
	  rs("content")=Content
	  rs("rpname")=Request.cookies("Username")
  	  rs.update
   rs.close
   '更新待处理人、最后处理人
   Sql="update O_Threads set clname='"&clname&"',lastname='"&Request.cookies("Userid")&"',lastdatetime=getdate() where Tid="&Tid
   Conn.execute Sql   
   '日志
   Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'再次提交','"&request.Cookies("UserName")&"')"
   Conn.execute Sql
End Sub

Sub Checkpass
  '得到当前操作人的顺序号
  rs.open "select orders from O_basesub where baseid="&baseid&" and userid='"&request.cookies("userid")&"'",conn,1,1
  orders=rs("orders")
  rs.close
  '得到下一个待处理人
  sql="select top 1 b.userid from O_base a,O_basesub b where a.baseid=b.baseid and a.baseid="&Baseid&" and b.ifedit=0 "&_
      "and b.orders>"&orders&" order by orders" 
  rs.open sql,Conn,1,1
   if rs.eof then
      mbox("此流程已结束！")
   else
      clname=rs("userid")
   end if
   rs.close
   
   rs.open "select * from O_Threadsub",Conn,3,3
   rs.addnew
	  rs("tid")=Tid
	  rs("content")=Content
	  rs("rpname")=Request.cookies("Username")
  	  rs.update
   rs.close
   '更新待处理人、最后处理人
   Sql="update O_Threads set clname='"&clname&"',lastname='"&Request.cookies("Userid")&"',lastdatetime=getdate() where Tid="&Tid
   Conn.execute Sql   
   '日志
   Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'审批通过','"&request.Cookies("UserName")&"')"
   Conn.execute Sql
End Sub

Sub Return
  '得到上一个处理人
  sql="select crname,isnull(lastname,'') as lastname from O_Threads where Tid="&tid 
  rs.open sql,Conn,1,1
  crname=GetUserId(rs("crname"))
  clname=rs("lastname")
  '如果上一个处理人为空就默认为提交人
  if clname="" then
     clname=crname
  end if
  rs.close
  '根据上一个处理人得到上上一个处理人，更新到lastname，恢复成上一步状态
  sql="select b.baseid,b.orders from O_Threads a,O_BaseSub b where a.Tid="&tid&" and a.baseid=b.baseid and b.userid='"&clname&"'"
  rs.open sql,Conn,1,1
  if not rs.eof then 
     '取得上一个处理人的顺序号
     orders=rs("orders")
	 baseid=rs("baseid")
	 rs.close
	 '根据顺序号取得上上一个处理人
	 sql="select top 1 userid from O_Basesub where ifedit=0 and baseid="&baseid&" and orders<"&orders
	 rs.open sql,Conn,1,1
	 if not rs.eof then
	    pclname=rs("userid")
	 else '没有上上一个处理人，就是上一个处理人为提交人
	    orders=0
	 end if
  else  '没有上上一个处理人，就是上一个处理人为提交人
     orders=0
  end if
  rs.close
   
  rs.open "select * from O_Threadsub",Conn,3,3
  rs.addnew
  rs("tid")=Tid
  rs("content")=Content
  rs("rpname")=Request.cookies("Username")
  rs.update
  rs.close
  '更新待处理人,因是退回不更新lastname
  if orders=0 then
     Sql="update O_Threads set clname='"&clname&"',lastname='"&crname&"' where Tid="&Tid
  else
     Sql="update O_Threads set clname='"&clname&"',lastname='"&pclname&"' where Tid="&Tid
  end if
  Conn.execute Sql   
  '日志
  Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'退回','"&request.Cookies("UserName")&"')"
  Conn.execute Sql
End Sub

Sub Isover
   rs.open "select * from O_Threadsub",Conn,3,3
   rs.addnew
	  rs("tid")=Tid
	  rs("content")=Content
	  rs("rpname")=Request.cookies("Username")
  	  rs.update
   rs.close
   '更新结束标记
   Sql="update O_Threads set isov=1,lastname='"&Request.cookies("Userid")&"',lastdatetime=getdate() where Tid="&Tid
   Conn.execute Sql   
   '日志
   Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'结束','"&request.Cookies("UserName")&"')"
   Conn.execute Sql
End Sub

Sub GetUserId(username)
set rs10=server.CreateObject("adodb.recordset")
rs10.open "select userid from j_user where rtrim(username)='"&trim(username)&"'",Conn
GetUserId=rs10("userid")
rs10.close
set rs10=nothing
End Sub

Call CloseConn%>

