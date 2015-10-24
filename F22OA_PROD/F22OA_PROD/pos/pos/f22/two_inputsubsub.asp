<%Response.Expires=-1000%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
<link href="css/two_input.css" rel="stylesheet" type="text/css">
<script language="javascript">
function chkinput(t){
  var k=event.keyCode;
  if((k>=48 && k <=57)||(k>=96 && k <=105)||(k=189)){
     return k;
  }else if(k==8 || k ==46){
    return k;
  }else if(k==13){
	event.keyCode=9;
  }else{
    return false;
  }
}
</script>

</head>

<body>

<!--#include file="inc/function.asp" -->
<%dim opt,id,nums,cd,sp,ds,styleid,fkname,act,numName,boxid
act=trim(request.QueryString("act"))
opt=trim(request.QueryString("opt"))
id=trim(request.QueryString("id"))
styleid=trim(request.QueryString("styleid"))
numName=trim(request.QueryString("numName"))
boxid=trim(request.QueryString("boxid"))

set ds = server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn
if styleid="" or boxid="" then
  response.End()
end if
'opt="indent"
fkname=opt&"id"
select case opt
case "indent"
  sql="d_indentsub"
  fkname="indentid"
case "quota"
  sql="d_quotasub"
  fkname="quotaid"
case "sell"
  sql="d_sellsub"
  fkname="sellid"
case "move"
  sql="d_movesub"
  fkname="moveid"
case "retail"
  sql="d_retailsub"
  fkname="retailid"
case "outindent"
  sql="d_outindentsub"
  fkname="outindentid"
case "outindentPRO"
  sql="d_outindentPROsub"
  fkname="outindentid"
case "outindentsq"
  sql="d_outindentsqsub"
  fkname="outindentsqid"
case "outindentCHK"
  sql="d_outindentCHKsub"
  fkname="outindentid"
case "outindentset"
  sql="d_outindentsetsub"
  fkname="outindentid"
case "inventory"
  sql="d_inventorysub"
  fkname="inventoryid"
case "msell"
  sql="d_msellsub"
  fkname="msellid"
case else

end select
'de sql
call sub_save(sql,fkname) '保存

%>
<form action="two_inputsubsub_save.asp" method="post" name="form1" target="_self">
<%call show(sql,numName)
set ds =nothing%>
<input type="submit" name="Submit" value="保存" onClick="this.value='请稍等...';this.form.submit();this.disabled=true">
<input name="id" type="hidden" value="<%=id%>">
<input name="styleid" type="hidden" value="<%=styleid%>">
<input name="tiss" type="hidden" value="tiss">
<input type="hidden" name="opt" value="<%=opt%>">
<input type="hidden" name="act" value="<%=act%>">
<input type="hidden" name="numName" value="<%=numName%>">
<input name="boxid" type="hidden" value="<%=boxid%>">
</form>
</body>
</html>

<%Public Sub show(TableName,nums)
Dim v, sql, str 'As String
Dim i, j, sum 'As Integer
Dim fc, fs 'As String
Dim fds 'As New ADODB.Recordset
  set fds = server.CreateObject("ADODB.Recordset")
  fds.ActiveConnection = cn
  
  sql = "Select Distinct jsgss.sizeid sizeid,js.s_order From j_style jst, j_sizegrp jsg,j_sizegrpsubs jsgss,j_size js " & _
  "Where jst.styleid='" & styleid & "' and jst.sizegrpid=jsg.sizegrpid and jsg.sizegrpid=jsgss.sizegrpid and js.sizeid=jsgss.sizeid " & _
  "Order by js.s_order"
	
  ds.Source = sql
  ds.Open
  '*******************************************************8
  sql = "Select Distinct jc.colorid 代码, jc.c_name 名称 "
  select case act
  case "add"
	
    While Not ds.EOF
      v = ds.Fields.Item("sizeid").value
      sql = sql & " ,0 As '" & v & "'"
      ds.MoveNext
    Wend
    ds.close
	sql = sql & " From  j_style jst,j_sizegrp jsg,j_sizegrpsubc jsgsc,j_sizegrpsubs jsgss,j_color jc "& _
			" Where  jst.styleid="&qts(styleid)&" And "& _
			" jst.sizegrpid=jsg.sizegrpid And jsg.sizegrpid=jsgss.sizegrpid And jsg.sizegrpid=jsgsc.sizegrpid "& _
			" And jsgsc.colorid=jc.colorid  Group By jc.colorid,jc.c_name"
  case else
	
    While Not ds.EOF
      v = ds.Fields.Item("sizeid").value
      sql = sql & " ,SUM(Case When (t.sizeid='" & v & "' and t.colorid=jsgsc.colorid) Then "&nums&" Else 0 End) As '" & v & "'"
      ds.MoveNext
    Wend
    ds.close
    sql = sql & " From " & TableName & " as t, j_style jst,j_sizegrp jsg,j_sizegrpsubc jsgsc,j_sizegrpsubs jsgss,j_color jc " & _
        "Where t." + FkName + "='" & id & "' And jst.styleid='" & styleid & "' And t.boxid='"&boxid&"' And t.styleid=jst.styleid And jst.sizegrpid=jsg.sizegrpid And jsg.sizegrpid=jsgss.sizegrpid " & _
        "And jsg.sizegrpid=jsgsc.sizegrpid And jsgsc.colorid=jc.colorid And jsgss.sizeid=t.sizeid " & _
        "Group By jc.colorid,jc.c_name"
    end select
  
  'de sql
  
  fds.Source = sql
  fds.Open
  '*************************************************************
  
  str = " " & _
      "<div id=""left"">"
  str = str & "<table id=""leftcontent"" border=""0"" cellpadding=""0"" cellspacing=""0"">"& _
  			" <thead><tr><th width=""30"">编号</td><th width=""70"">名称</td>"
  For i = 2 To fds.Fields.Count - 1
    str = str & "<th width=""" & CStr(Len(fds.Fields(i).Name) * 10 + 10) & """>" & fds.Fields(i).Name & "<input type=hidden name=""n0" & CStr(i) & """ value=""" & fds.Fields(i).Name & """</td>"
  Next
  str = str & "<th width=""40px"">合计</td></tr></thead> "
  j = 1
  While Not fds.EOF
   str = str & "<tr>"
   For i = 0 To fds.Fields.Count - 1
     v = fds.Fields(i).value
     select case i
	 case 0  '第0列,颜色代码列
       str = str & "<td>" & v & "<input type=""hidden""  name=""n" & CStr(j) & CStr(i) & """ value=" & v & "></td>"
     case 1 '第1列,颜色名称列
       str = str & "<td>" & v & "</td>"
     case Else '数量
       str = str & "<td><input type=""text"" size=""3"" onfocus=""this.select();"" name=""n"& cstr(j)& cstr(i)&""""
       If v <> "0" Then str = str & " value=" & v
       'str = str & "  onKeyDown=""return chkinput(this);""></td>"
	   str = str &" onkeydown=""if(event.keyCode==13)event.keyCode=9"" onKeypress=""if (event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;"" onBlur=""javascript:if(isNaN(this.value)){alert('数据类型错误！');this.focus();}this.value=Math.floor(this.value);""></td>"
       sum = sum + CInt(v)
     End Select
   Next
   '最后一列,合计列,名称为:n&行号&n,
   str = str & "<td><input type=""text"" disabled size=""3"" name=""n" & CStr(sum) & "n"" value=""" & CStr(sum) & """></td>"
   fds.MoveNext
   str = str & "</tr>"
   sum=0
   j = j + 1
  Wend
  
  str = str & "</table><input type=""hidden"" name=""rows"" value=" & CStr(j - 1) & ">"
  str = str & "<input type=""hidden"" name=""cols"" value=""" & CStr(i) & """>"
  str = str & "</div>"
 
  Response.Write str
  
  fds.Close
  Set fds = Nothing

End Sub

'保存保存保存保存
sub sub_save(tn,pn)
if request.Form("rows")<>"" then
  if styleid="" then
    call mbox("请先在左边选择一个款号,再修改保存!")
  else
    call Save(tn,pn)
  end if
end if
end sub



'保存修改
Public Sub Save(TableName,PkName)
  Dim i, j, rows, cols, nums 'As Integer
  Dim v, sql, hisnums, checked 'As String
  Dim arr() 'As String
  Dim clothingid, colorid, sizeid, crdate, comment 'As String
  Dim j_cost, j_price, x_price, s_price, discount, a_discount 'As String
  Dim pj_price, px_price 'As String
  Dim set_nums, get_nums, chknums 'As String

  rows = CInt(Trim(Request.Form.Item("rows")))
  cols = CInt(Trim(Request.Form.Item("cols")))
  ReDim arr(rows + 1, cols + 1)
  
  For i = 0 To rows '取得表单值
    For j = 0 To cols
      v = Trim(getV(Request.Form("n" + CStr(i) + CStr(j))))
      If v <> "" Then
        arr(i, j) = v
      End If
    Next
  Next
    
  '输出测试
  'Response.Write ("<table border=1>")
  'For i = 0 To rows
  '  Response.Write ("<tr>")
  '  For j = 0 To cols
  '    Response.Write ("<td>" + arr(i, j) + "</td>")
  '  Next
  '  Response.Write ("</tr>")
  'Next
  'Response.Write ("</table>")
  'Response.Write ("<br>****************************")
  'Response.End
  
  sql = "select * from " & TableName & " where " & PkName & "='" & id & "' and styleid='" & styleid & "' and boxid='" & boxid & "'"
  de sql
  ds.Source = sql
  ds.Open
  
If TableName = "d_indentsub" Or TableName = "d_retailsub" Or TableName = "d_inventorysub" Then '订货单
  If Not ds.EOF Then
    If IsNull(ds.Fields.Item("j_cost").value) Then
      j_cost = "0"
    Else
      j_cost = CStr(ds.Fields.Item("j_cost").value)
    End If
    
    If IsNull(ds.Fields.Item("j_price").value) Then
      j_price = "0"
    Else
      j_price = CStr(ds.Fields.Item("j_price").value)
    End If
    
    If IsNull(ds.Fields.Item("x_price").value) Then
      x_price = "0"
    Else
      x_price = CStr(ds.Fields.Item("x_price").value)
    End If
    
    If IsNull(ds.Fields.Item("crdate").value) Then
      crdate = "" 'Date
    Else
      crdate = CStr(ds.Fields.Item("crdate").value)
    End If

    If IsNull(ds.Fields.Item("comment").value) Then
      comment = ""
    Else
      comment = CStr(ds.Fields.Item("comment").value)
    End If
    
    If IsNull(ds.Fields.Item("s_price").value) Then
      s_price = "0"
    Else
      s_price = CStr(ds.Fields.Item("s_price").value)
    End If
    
    If IsNull(ds.Fields.Item("discount").value) Or ds.Fields.Item("discount").value = 0 Then
      discount = "0"
    Else
      discount = CStr(ds.Fields.Item("discount").value)
    End If
    
    If discount = "" Then
      discount = "0"
    End If
  End If
ElseIf TableName = "d_outindentsub" Or TableName = "d_outindentprosub" or TableName = "d_outindentsqsub" Then
  If Not ds.EOF Then
    If IsNull(ds.Fields.Item("cost").value) Then
      j_cost = "0"
    Else
      j_cost = CStr(ds.Fields.Item("cost").value)
    End If
    
    If IsNull(ds.Fields.Item("j_price").value) Then
      j_price = "0"
    Else
      j_price = CStr(ds.Fields.Item("j_price").value)
    End If
    
    If IsNull(ds.Fields.Item("x_price").value) Then
      x_price = "0"
    Else
      x_price = CStr(ds.Fields.Item("x_price").value)
    End If
    
    If IsNull(ds.Fields.Item("crdate").value) Then
      crdate = "" 'Date
    Else
      crdate = CStr(ds.Fields.Item("crdate").value)
    End If

    If IsNull(ds.Fields.Item("comment").value) Then
      comment = ""
    Else
      comment = CStr(ds.Fields.Item("comment").value)
    End If
    
    If IsNull(ds.Fields.Item("s_price").value) Then
      s_price = "0"
    Else
      s_price = CStr(ds.Fields.Item("s_price").value)
    End If
    
    If IsNull(ds.Fields.Item("discount").value) Or ds.Fields.Item("discount").value = 0 Then
      discount = "0"
    Else
      discount = CStr(ds.Fields.Item("discount").value)
    End If
    
    If discount = "" Then
      discount = "0"
    End If
    
    If IsNull(ds.Fields.Item("chknums").value) Then
      chknums = 0
    Else
      chknums = CStr(ds.Fields.Item("chknums").value)
    End If
   
  End If
ElseIf TableName = "d_quotasub" Then
    If Not ds.EOF Then
    If IsNull(ds.Fields.Item("j_cost").value) Then
      j_cost = "0"
    Else
      j_cost = CStr(ds.Fields.Item("j_cost").value)
    End If
    
    If IsNull(ds.Fields.Item("pj_price").value) Then
      pj_price = "0"
    Else
      pj_price = CStr(ds.Fields.Item("pj_price").value)
    End If
    
    If IsNull(ds.Fields.Item("px_price").value) Then
      px_price = "0"
    Else
      px_price = CStr(ds.Fields.Item("px_price").value)
    End If
    
    If IsNull(ds.Fields.Item("crdate").value) Then
      crdate = "" 'Date
    Else
      crdate = CStr(ds.Fields.Item("crdate").value)
    End If

    If IsNull(ds.Fields.Item("comment").value) Then
      comment = ""
    Else
      comment = CStr(ds.Fields.Item("comment").value)
    End If
    
    If IsNull(ds.Fields.Item("s_price").value) Then
      s_price = "0"
    Else
      s_price = CStr(ds.Fields.Item("s_price").value)
    End If
    
    If IsNull(ds.Fields.Item("discount").value) Or ds.Fields.Item("discount").value = 0 Then
      discount = "0"
    Else
      discount = CStr(ds.Fields.Item("discount").value)
    End If
    If discount = "" Then
      discount = "0"
    End If
  End If
Else
  If Not ds.EOF Then
    If IsNull(ds.Fields.Item("j_cost").value) Then
      j_cost = "0"
    Else
      j_cost = CStr(ds.Fields.Item("j_cost").value)
    End If
    
    If IsNull(ds.Fields.Item("j_price").value) Then
      j_price = "0"
    Else
      j_price = CStr(ds.Fields.Item("j_price").value)
    End If
    
    If IsNull(ds.Fields.Item("x_price").value) Then
      x_price = "0"
    Else
      x_price = CStr(ds.Fields.Item("x_price").value)
    End If
    
    If IsNull(ds.Fields.Item("a_discount").value) Or ds.Fields.Item("a_discount").value = 0 Then
      a_discount = "0"
    Else
      a_discount = CStr(ds.Fields.Item("a_discount").value)
    End If
    
    If a_discount = "" Then
      a_discount = "0"
    End If
    
    If IsNull(ds.Fields.Item("get_nums").value) Then
      get_nums = 0
    Else
        get_nums = CStr(ds.Fields.Item("get_nums").value)
    End If

    If IsNull(ds.Fields.Item("crdate").value) Then
      crdate = "" 'Date
    Else
      crdate = CStr(ds.Fields.Item("crdate").value)
    End If

    If IsNull(ds.Fields.Item("comment").value) Then
      comment = ""
    Else
      comment = CStr(ds.Fields.Item("comment").value)
    End If

    If IsNull(ds.Fields.Item("chknums").value) Then
      chknums = 0
    Else
      chknums = CStr(ds.Fields.Item("chknums").value)
    End If
    
  End If
End If
  
  ds.Close
  
  '****************************************开启事务控制**********************************************
  CN.BeginTrans
  '删除原有记录
  sql = "delete from " & TableName & " where " & PkName & "='" & id & "' and styleid='" & styleid & "' and boxid='" & boxid & "'"
  
  CN.Execute sql

  '将新记录添加进去,PkName是主表ID,是外键.
  s_price = Trim(Request.QueryString("s_price"))
  discount = Trim(Request.QueryString("discount"))
  comment = Trim(Request.QueryString("comment"))

  For i = 1 To rows
    colorid = arr(i, 0) '取出颜色代码,放入外层,优化循环
    For j = 2 To cols - 2
      sizeid = arr(0, j) '取出尺码
      clothingid = styleid & colorid & sizeid
      set_nums = Trim(arr(i, j)) '取出相应的数量

      If Len(set_nums) > 0 Then
        Select Case TableName
        Case "d_indentsub", "d_retailsub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,nums,comment)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " ,  " & set_nums & "  ,' " & comment & "')"
        Case "d_outindentsub", "d_outindentprosub", "d_outindentsetsub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,cost,j_price,x_price,s_price,discount,nums,comment,chknums)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " ,  " & set_nums & "  ,' " & comment & "' , " & chknums & ")"
				Case "d_outindentsqsub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,sq_tjnums,comment,chknums)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " ,  " & set_nums & "  ,' " & comment & "' , " & chknums & ")"
        Case "d_quotasub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,pj_price,px_price,s_price,discount,nums,comment)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & pj_price & " , " & px_price & " , " & s_price & " , " & discount & " ,  " & set_nums & "  ,' " & comment & "' )"
        Case "d_inventorysub"
          Select Case ext
          Case "0"
            sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,nums,comment)" & _
            "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
            sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " , " & set_nums & " ,' " & comment & "')"
          Case "1"
            sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,d_nums,comment)" & _
            "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
            sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " , " & set_nums & " ,' " & comment & "')"
          End Select
        Case Else
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,a_discount,set_nums,get_nums,comment,chknums)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " , " & a_discount & " , " & set_nums & " , " & get_nums & " ,' " & comment & "' , " & chknums & ")"
        End Select
        'Response.Write ("<textarea rows='600'>" & sql & "</textarea>")
        'Response.End
        CN.Execute sql
      End If
    Next
  Next
  '**********************************************关闭事务**************************
  If CN.Errors.Count = 0 Then
    CN.CommitTrans
  Else
    CN.RollbackTrans
    Err.Raise 500, 1, "事务执行出错!保存修改不成功!"
  End If
End Sub

'Function getV(v As String) As String '递归算法
Function getV(v) '递归算法
  Dim i 'As Integer
  i = InStr(v, ",")
  
  If i = 0 Then
    getV = v
  Else
    getV = getV(Right(v, Len(v) - i))
  End If
End Function

%>
