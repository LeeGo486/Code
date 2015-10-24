<!-- #include file="setup.asp" -->
<!--#include file="ZHXeditor/fckeditor.asp" -->
<%

tid=RequestInt("tid")
if tid=0 then
   close("参数错误！")
end if
set rs=server.CreateObject("adodb.recordset")

sql="select a.*,b.typename,c.statename,d.username as clusername from o_threads a,o_type b,o_state c,j_user d "&_
    "where a.typeid=b.typeid and a.stateid=c.stateid and a.clname=d.userid and a.tid="&tid
rs.open sql,conn,1,1
	Baseid=rs("baseid")
	Typenames=rs("typename")
	Statename=rs("statename")
	Title=rs("title")
	Content=rs("Content")
	Crname=rs("crname")
	Crdate=rs("crdate")
	Cluserid=rs("clname")
	Clusername=rs("clusername")
	Lastname=rs("lastname")
	Lastdatetime=rs("lastdatetime")
	Isov=rs("isov")
rs.close

'记录日志
if Isov=1 then
   '结束查看日志
   if Crname=Request.Cookies("username") then 
      Sql="select 1 from O_Logov where tid="&tid&" and userid='"&Request.cookies("userid")&"'"
      rs.open Sql,conn,1,1
      if rs.eof then
         Sql="insert into O_Logov (tid,userid) values ("&tid&",'"&Request.cookies("userid")&"')"
	     Conn.Execute Sql
      end if
      rs.close
   end if
   
   '查阅查看日志
   Sql="select 1 from o_threads a,o_basesub b where a.tid="&tid&" and a.baseid=b.baseid and b.userid='"&Request.Cookies("userid")&"' and b.ifedit=1"
   rs.open Sql,conn,1,1
   if not rs.eof then
      set tmp=server.createobject("adodb.recordset")
	  tmp.open "select 1 from O_Logsee where tid="&tid&" and userid='"&Request.cookies("userid")&"'",conn,1,1
	  if tmp.eof then
	     Sql="insert into O_Logsee (tid,userid) values ("&tid&",'"&Request.cookies("userid")&"')"
	     Conn.Execute Sql
      end if
	  tmp.close
	  '日志
	  tmp.open "select 1 from O_Log where tid="&tid&" and crname='"&Request.cookies("username")&"' and logcomment='查阅'",conn,1,1
	  if tmp.eof then
	     Sql="insert into O_Log (tid,logcomment,crname) values ("&Tid&",'查阅','"&request.Cookies("UserName")&"')"
         Conn.execute Sql
	  end if
	  tmp.close
	  set tmp=nothing
   end if
   rs.close
end if

'判断当前用户是否可以看此文档
if Crname<>Request.Cookies("username") then
  rs.open "select 1 from O_Threads a,O_base b,O_basesub c where a.Tid="&tid&_
          " and a.baseid=b.baseid and b.baseid=c.baseid and c.userid='"&Request.cookies("userid")&"'",conn,1,1
  if rs.eof then
     close("你没有权限查看此文档！")
  end if
  rs.close
end if

Dim oFCKeditor							'编辑器定义
%>
<title><%=Title%></title>
<base target="_self">
<script type="text/javascript">
function qt(id){
	document.getElementById("qtval").value = document.getElementById(id).innerHTML;
	document.forms["hform"].submit();
	
/*	//_this.clreateA
	if(_this.document.getElementById('copytextarea'))
	{
		_this.innerHTML = _this.document.getElementById('copytextarea').value;
	}else{
		_this.innerHTML = '<textarea id="copytextarea" style="width:80%;" rows="10">'+_this.innerHTML+'</textarea>'
		_this.document.getElementById('copytextarea').select();
	}
*/}
</script>
<div align="center">
<input type="button" value="打印（Ctrl + P）" onClick="javascript:window.print();" /></div>
<div id="CommonBody">
<!--------------------------显示界面 start------------------------------------>
<table cellspacing=1 cellpadding=5 border=0 align=center id=CommonListArea  width=98%>
	<TR id=CommonListTitle>
		<TD vAlign=Left colSpan=4>文档审批明细记录</TD>
	</TR>
    <tr id="CommonListCell">
      <TD width="150" class="CommonListTi">流程分类</TD>
	  <TD><%=Typenames%></TD>
	  <td class="CommonListTi">紧急程度</td>
	  <td width="300"><%=Statename%></td>
    </tr>
	<TR id=CommonListCell>
      <TD class="CommonListTi">主题</TD>
      <TD colSpan=3 onDblClick="seltext(this)"><%=Title%></TD>
    </TR>
	<TR id=CommonListCell>
	  <TD class="CommonListTi">提交人</TD>
	  <TD><%=Crname%></TD>
	  <TD class="CommonListTi">提交时间</TD>
	  <TD><%=Crdate%></TD>
    </TR>
	<TR id=CommonListCell>
		<TD vAlign=top class="CommonListTi">
		<br>
		文档描述</TD>
		<TD colspan="3">
        <div class="QuestionDiv" id="c0"><%=Content%></div>
        <input type="button" value="引用内容" onClick="qt('c0')"  />
        </TD>
    </TR>
  </table>
  
</TABLE>
  <table cellspacing=1 cellpadding=5 border=0 align=center id=CommonListAreaDev  width=98%>
	<TR id=CommonListTitleDev>
		<TD vAlign=Left colSpan=3>此文档操作日志</TD>
	</TR>
	<tr id="CommonListCell">
	  <td width="150" class="CommonListTi">操作日志</td>
	  <td width="150" class="CommonListTi">操作人</td>
	  <td width="200" class="CommonListTi">操作时间</td>
    </tr>
	<%rs.open "select * from O_Log where tid="&tid&" order by Logid",conn,1,1
	while not rs.eof%>
	<tr id="CommonListCell">
	  <td width="150" class="CommonListTi"><%=rs("Logcomment")%></td>
	  <td width="150" class="CommonListTi"><%=rs("crname")%></td>
	  <td width="200" class="CommonListTi"><%=rs("crdate")%></td>
    </tr>
	<%rs.movenext
	Wend
	rs.close%>
  </table>

<!--------------------------跟进显示界面 start------------------------------------>
  <table cellspacing=1 cellpadding=5 border=0 align=center id=CommonListAreaSer  width=98%>
	<TR id=CommonListTitleSer>
		<TD vAlign=Left colSpan=4>审批操作记录</TD>
	</TR>
	<%rs.open "select * from O_Threadsub where tid="&tid&" order by sid",conn,1,1
	while not rs.eof%>
    <tr id="CommonListCell">
	  <td width="150" class="CommonListTi">操作时间</td>
	  <td><%=rs("rpdatetime")%></td>
	  <td class="CommonListTi">操作人</td>
	  <td width="300"><%=rs("rpname")%></td>
    </tr>
	<tr id="CommonListCell">
	  <td class="CommonListTi">操作内容</td>
	  <td colspan="3">
    <div class="QuestionDiv" id="c2"><%=rs("content")%></div>
    <input type="button" value="引用内容" onClick="qt('c2')"  />
    </td>
    </tr>
	<%rs.movenext
	Wend
	rs.close%>
  </table>
<!--------------------------跟进显示界面 end------------------------------------>  
<%if Isov=0 and Cluserid=Request.Cookies("Userid") then%>
<table cellspacing=1 cellpadding=5 border=0 align=center id=CommonListArea  width="98%">
<form name="form" method="post" action="flowsave.asp" target="hf">
<input type="hidden" name="typ" value="read">
<input type="hidden" name="baseid" value="<%=baseid%>" />
<input type="hidden" name="tid" value="<%=tid%>" />
	<TR id=CommonListTitle>
		<TD vAlign=Left colSpan=4>审 批</TD>
	</TR>
	<tr id="CommonListCell">
	  <td width="150" valign="top" class="CommonListTi"><br>
	    审批内容</td>
		<TD height=250 colspan="3"><%
            Set oFCKeditor = New FCKeditor
            oFCKeditor.BasePath = "ZHXeditor/"
            oFCKeditor.ToolbarSet = "Default"
            oFCKeditor.height = 250
            oFCKeditor.Value = request("qtval")
            oFCKeditor.Create "content"
            %></td>
	  </tr>
	<TR id=CommonListCell>
		<TD align=center colSpan=4>
		操作:<select name="flowtype">
		<%if Crname=Request.Cookies("username") then%>
		<option value="再次提交">再次提交</option>
		<%elseif CheckLastName(Baseid) then%>
		<option value="审批通过">审批通过</option>
		<option value="退回">退回</option>
		<%else%>
		<option value="结束">结束</option>
		<option value="退回">退回</option>
		<%end if%>
		</select>
        <INPUT type="submit" value=" 提 交 " name="EditSubmit">
        </TD>
	</TR>
</FORM>
<%End if%>
</TABLE>
  <table cellspacing=1 cellpadding=5 border=0 align=center id=CommonListAreaDev  width=98%>
	<TR id=CommonListTitleDev>
		<TD vAlign=Left colSpan=5>此流程方案的审批流程</TD>
	</TR>
	<tr id="CommonListCell">
	  <td width="150" class="CommonListTi">审批顺序</td>
	  <td width="150" class="CommonListTi">审批人</td>
	  <td width="150" class="CommonListTi">所属部门</td>
	  <td width="150" class="CommonListTi">预设处理时间</td>
	  <td width="150" class="CommonListTi">只需查阅</td>
    </tr>
	<%rs.open "select a.orders,c.department,a.userid,b.username,a.cltime,a.ifedit from O_basesub a,j_user b,j_department c "&_
	          "where a.baseid="&baseid&" and a.userid=b.userid and b.departid=c.departid order by a.orders",conn,1,1
	while not rs.eof%>
	<tr id="CommonListCell">
	  <td width="150" class="CommonListTi"><%=rs("orders")%></td>
	  <td width="150" class="CommonListTi"><%=rs("username")%></td>
	  <td width="150" class="CommonListTi"><%=rs("department")%></td>
	  <td width="150" class="CommonListTi"><%=rs("cltime")%> 小时</td>
	  <td width="150" class="CommonListTi"><%if round(rs("ifedit"))=1 then response.write("√") end if%></td>
    </tr>
	<%rs.movenext
	Wend
	rs.close%>
  </table>
</DIV>
<form name="hform" id="hform" method="post" action="?<%=request.ServerVariables("QUERY_STRING")%>">
	<input type="hidden" name="qtval" id="qtval" />
</form>

<%set rs=nothing

'判断是否有下一处理人
Function CheckLastName(ID)
  set tmp=server.createobject("adodb.recordset")
  '得到当前操作人的顺序号
  tmp.open "select orders from O_basesub where baseid="&ID&" and userid='"&request.cookies("userid")&"'",conn,1,1
  orders=tmp("orders")
  tmp.close
  '得到下一个待处理人
  sql="select top 1 b.userid from O_base a,O_basesub b where a.baseid=b.baseid and a.baseid="&ID&" and b.ifedit=0 "&_
      "and b.orders>"&orders&" order by orders" 
  tmp.open sql,Conn,1,1
   if tmp.eof then
      CheckLastName=false
   else
      CheckLastName=true
   end if
   tmp.close
   set tmp=nothing
End Function

call CloseConn
call Footer%>
