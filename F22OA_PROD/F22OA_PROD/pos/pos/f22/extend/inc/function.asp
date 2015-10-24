<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<%dim cn,dc(4)
cn=session("cn")
dc(1)="竞争品牌目录"
dc(2)="新产品调查项目"
dc(3)="竞争品牌项目"
dc(4)="促销效果项目"

function qts(str)
  qts="'"& str &"'"
end function

function aclose(str,opt)
  response.Write "<script language='javascript'>"
  response.Write "alert('"& str &"');"
  if opt=0 then
    response.Write "window.close();"
  elseif opt=1 then
    response.Write "window.history.back();"
  end if
  response.Write "</script>"
end function

'格式化日期字符串
function get_date(tdate)
  dim y,m,d
  y=year(tdate)
  m=month(tdate)
  d=day(tdate)
  m=cint(m)
  d=cint(d)
  if m<10 then m="0"&m
  if d<10 then d="0"&d
  d=y & "-" & m & "-" & d
  get_date=d
end function


function getpid(pid)
  response.Write "<select name=""pid"" id=""pid"" style=""width:120px; "" onChange=""showcname();"">"
	  set ds=server.CreateObject("ADODB.ReCordset")
	    ds.Activeconnection = cn
		ds.source = "select pid,pname,cid from web_product"
		ds.open
		while not ds.eof
		  cname=dc(ds("cid")-8000)
          response.Write "<option value='"&ds("pid")&","&cname&"'"
		  if pid=ds("pid") then
		    response.Write " selected"
		  end if
		  response.Write ">"
		  response.Write ds("pname")
		  response.Write "</option>"
		  ds.movenext
		wend
		ds.close
  response.Write "</select> "
end function

'执行完后关闭窗口的函数
Sub close(str)
  response.Write("<script language='javascript'>")
  response.Write("alert('"& str &"');window.close();")
  response.Write("</script>")
End Sub

sub de(str)
  response.Write str
  response.End()
end sub

function GetId(TableName,PkName,Fchar,UserId)
 dim rs10
 
 TableName=Trim(TableName)
 PkName=Trim(PkName)
 Fchar=Trim(Fchar)
 UserId=trim(UserId)
 
 if TableName=null or TableName="" then
   Err.Raise 50001,"function.GetId","表名不能为空!"
 end if
 if PkName=null or PkName="" then
   Err.Raise 50001,"function.GetId","字段名不能为空!"
 end if
 if Fchar=null or Fchar="" then
   Err.Raise 50001,"function.GetId","前两个字母不能为空!"
 end if
 if UserId=null or UserId="" then
   Err.Raise 50001,"function.GetId","用户ID不能为空!"
 end if
   
 set rs10=server.createobject("adodb.recordset")
 rs10.open "f18_getid '"&TableName&"','"&PkName&"','"&Fchar&"','"&UserId&"'",cn
 if isnull(rs10(0)) then
   getid=rs10(1)&"-0001"
 else
   getid=rs10(1)&"-"&right("0000"+trim(cstr(cint(right(rs10(0),4))+1)),4)
 end if
 
 rs10.close
 set rs10=nothing
end function

%>