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
   mbox("�ĵ����ݲ���Ϊ�գ�")
else
  set rs=server.CreateObject("ADODB.Recordset")
  select case typ
   case "newadd"  newadd   '����
   case "read"    readedit '�༭
  end select
  set rs=nothing
end if


Sub newadd
   '�õ���һ����������
   sql="select top 1 b.userid from O_base a,O_basesub b where a.baseid=b.baseid and a.baseid="&Baseid&" and b.ifedit=0 order by orders" 
   rs.open sql,Conn,1,1
   if rs.eof then
      mbox("�����̷�����δ�趨�������̣�")
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
	  rs("lastname")=Request.Cookies("Userid") 'lastname�Ǽ�¼��һ��������
	  rs("lastdatetime")=Now()
	  rs("isov")=0
  	  rs.update
	  rs.MoveLast
	  Tid=rs("tid")
   rs.close
   '��־
   Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'�ύ�ĵ�','"&request.Cookies("UserName")&"')"
   Conn.execute Sql
   response.write("<script>alert('�ύ�ɹ���')</script>")
   response.redirect "flowcheck.asp"
End Sub

Sub readedit
   if Tid=0 then
      mbox("��������")
   else
     select case flowtype
     case "�ٴ��ύ"  ReSubmit
     case "����ͨ��"  CheckPass
     case "�˻�"      Return
     case "����"      Isover
     end select
   end if
   
   Call zclose
End Sub

Sub Resubmit
  '�õ���ǰ�����˵�˳���
  rs.open "select orders from O_basesub where baseid="&baseid&" and userid='"&request.cookies("userid")&"'",conn,1,1
  '��������������ĵ����ύ��
  if not rs.eof then
     orders=rs("orders")
  else
     orders=0
  end if
  rs.close
  '�õ���һ����������
  sql="select top 1 b.userid from O_base a,O_basesub b where a.baseid=b.baseid and a.baseid="&Baseid&" and b.ifedit=0 "&_
      "and b.orders>"&orders&" order by orders" 
  rs.open sql,Conn,1,1
   if rs.eof then
      mbox("�������ѽ�����")
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
   '���´������ˡ��������
   Sql="update O_Threads set clname='"&clname&"',lastname='"&Request.cookies("Userid")&"',lastdatetime=getdate() where Tid="&Tid
   Conn.execute Sql   
   '��־
   Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'�ٴ��ύ','"&request.Cookies("UserName")&"')"
   Conn.execute Sql
End Sub

Sub Checkpass
  '�õ���ǰ�����˵�˳���
  rs.open "select orders from O_basesub where baseid="&baseid&" and userid='"&request.cookies("userid")&"'",conn,1,1
  orders=rs("orders")
  rs.close
  '�õ���һ����������
  sql="select top 1 b.userid from O_base a,O_basesub b where a.baseid=b.baseid and a.baseid="&Baseid&" and b.ifedit=0 "&_
      "and b.orders>"&orders&" order by orders" 
  rs.open sql,Conn,1,1
   if rs.eof then
      mbox("�������ѽ�����")
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
   '���´������ˡ��������
   Sql="update O_Threads set clname='"&clname&"',lastname='"&Request.cookies("Userid")&"',lastdatetime=getdate() where Tid="&Tid
   Conn.execute Sql   
   '��־
   Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'����ͨ��','"&request.Cookies("UserName")&"')"
   Conn.execute Sql
End Sub

Sub Return
  '�õ���һ��������
  sql="select crname,isnull(lastname,'') as lastname from O_Threads where Tid="&tid 
  rs.open sql,Conn,1,1
  crname=GetUserId(rs("crname"))
  clname=rs("lastname")
  '�����һ��������Ϊ�վ�Ĭ��Ϊ�ύ��
  if clname="" then
     clname=crname
  end if
  rs.close
  '������һ�������˵õ�����һ�������ˣ����µ�lastname���ָ�����һ��״̬
  sql="select b.baseid,b.orders from O_Threads a,O_BaseSub b where a.Tid="&tid&" and a.baseid=b.baseid and b.userid='"&clname&"'"
  rs.open sql,Conn,1,1
  if not rs.eof then 
     'ȡ����һ�������˵�˳���
     orders=rs("orders")
	 baseid=rs("baseid")
	 rs.close
	 '����˳���ȡ������һ��������
	 sql="select top 1 userid from O_Basesub where ifedit=0 and baseid="&baseid&" and orders<"&orders
	 rs.open sql,Conn,1,1
	 if not rs.eof then
	    pclname=rs("userid")
	 else 'û������һ�������ˣ�������һ��������Ϊ�ύ��
	    orders=0
	 end if
  else  'û������һ�������ˣ�������һ��������Ϊ�ύ��
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
  '���´�������,�����˻ز�����lastname
  if orders=0 then
     Sql="update O_Threads set clname='"&clname&"',lastname='"&crname&"' where Tid="&Tid
  else
     Sql="update O_Threads set clname='"&clname&"',lastname='"&pclname&"' where Tid="&Tid
  end if
  Conn.execute Sql   
  '��־
  Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'�˻�','"&request.Cookies("UserName")&"')"
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
   '���½������
   Sql="update O_Threads set isov=1,lastname='"&Request.cookies("Userid")&"',lastdatetime=getdate() where Tid="&Tid
   Conn.execute Sql   
   '��־
   Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'����','"&request.Cookies("UserName")&"')"
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

