<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>无标题文档</title>
</head>

<body>

<!--#include file="inc/function.asp" -->
<%dim opt,id,nums,cd,sp,ds,styleid,fkname,act,numName,boxid
dim ext
tiss=trim(request.form("tiss"))
if tiss<>"" then
  act=trim(request.form("act"))
  opt=trim(request.form("opt"))
  id=trim(request.form("id"))
  styleid=trim(request.form("styleid"))
  boxid=trim(request.Form("boxid"))
  numName=trim(request.Form("numName"))
end if

set ds = server.CreateObject("ADODB.Recordset")
ds.ActiveConnection = cn

'opt="indent"

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
'de fkname
call sub_save(sql,fkname) '保存
response.Redirect "two_inputsubsub.asp?id="&id&"&styleid="&styleid&"&act="&act&"&opt="&opt&"&boxid="&boxid&"&numName="&numName
%>
</body>
</html>

<%
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
  Dim j_price1, x_price1, s_price1, discount1
  Dim pj_price, px_price 'As String
  Dim set_nums, get_nums, chknums 'As String

  rows = CInt(Trim(Request.Form.Item("rows")))
  cols = CInt(Trim(Request.Form.Item("cols")))
  TableName=lcase(TableName)
  
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
  Response.Write ("<table border=1>")
  For i = 0 To rows
   Response.Write ("<tr>")
    For j = 0 To cols
      Response.Write ("<td>" + arr(i, j) + "</td>")
    Next
    Response.Write ("</tr>")
  Next
  Response.Write ("</table>")
  Response.Write ("<br>****************************")
  Response.Write rows
  Response.Write cols
  'Response.End
  
  sql = "select * from " & TableName & " where " & PkName & "='" & id & "' and styleid='" & styleid & "' and boxid='" & boxid & "'"
  'de sql
  ds.Source = sql
  ds.Open
  
If TableName = "d_indentsub" Or TableName = "d_retailsub" Or TableName = "d_inventorysub" Or TableName="d_movesub" Or TableName="d_msellsub" Then '订货单
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
    
    If IsNull(ds.Fields.Item("discount").value)  Then
      discount = "0"
    Else
      discount = CStr(ds.Fields.Item("discount").value)
    End If
    
    If discount = "" Then
      discount = "0"
    End If
  End If
ElseIf TableName = "d_outindentsub" Or TableName = "d_outindentprosub" Or TableName="d_outindentsetsub" Then
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
    
    If IsNull(ds.Fields.Item("discount").value) Then
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
ElseIf TableName = "d_outindentsqsub" Then
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
    
    If IsNull(ds.Fields.Item("discount").value) Then
      discount = "0"
    Else
      discount = CStr(ds.Fields.Item("discount").value)
    End If
    
    If discount = "" Then
      discount = "0"
    End If
    
    If IsNull(ds.Fields.Item("sq_spnums").value) Then
      chknums = 0
    Else
      chknums = CStr(ds.Fields.Item("sq_spnums").value)
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
    
    If IsNull(ds.Fields.Item("discount").value) Then
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
    If IsNull(ds.Fields.Item("cost").value) Then
      cost = "0"
    Else
      cost = CStr(ds.Fields.Item("cost").value)
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
    
    If IsNull(ds.Fields.Item("discount").value)  Then
      discount = "0"
    Else
      discount = CStr(ds.Fields.Item("discount").value)
    End If
    
    If discount = "" Then
      discount = "0"
      end if
         
    If IsNull(ds.Fields.Item("nums").value) Then
      nums = 0
    Else
        nums = CStr(ds.Fields.Item("nums").value)
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
   
  if  TableName="d_msellsub" then
  
    If IsNull(ds.Fields.Item("j_price1").value) Then
      j_price1 = "0"
    Else
      j_price1 = CStr(ds.Fields.Item("j_price1").value)
    End If
	
	If IsNull(ds.Fields.Item("x_price1").value) Then
      x_price1 = "0"
    Else
      x_price1 = CStr(ds.Fields.Item("x_price1").value)
    End If
	
	If IsNull(ds.Fields.Item("s_price1").value) Then
      s_price1 = "0"
    Else
      s_price1 = CStr(ds.Fields.Item("s_price1").value)
    End If
	
	If IsNull(ds.Fields.Item("discount1").value) Then
      discount1 = "0"
    Else
      discount1 = CStr(ds.Fields.Item("discount1").value)
    End If
	
  end if
  
  
  If IsNull(ds("s_price")) then
     s_price=0
  else
     s_price = cdbl(trim(ds("s_price")))
  end if
  If IsNull(ds("discount")) then
     discount=0
  else
     discount=cdbl(trim(ds("discount")))
  end if
  comment=trim(ds("comment"))
  ds.Close
  
  '****************************************开启事务控制**********************************************
  CN.BeginTrans
  '删除原有记录
  sql = "delete from " & TableName & " where " & PkName & "='" & id & "' and styleid='" & styleid & "' and boxid='" & boxid & "'"
  
  CN.Execute sql

  '将新记录添加进去,PkName是主表ID,是外键.

  For i = 1 To rows
    colorid = arr(i, 0) '取出颜色代码,放入外层,优化循环
	
    For j = 2 To cols - 1
      sizeid = arr(0, j) '取出尺码
      clothingid = styleid & colorid & sizeid
      set_nums = Trim(arr(i, j)) '取出相应的数量
      
	  If TableName="d_inventorysub" then
	     if set_nums="" then set_nums=0 end if
			 
	     Select Case ext
          Case "0","" '盘点数量
            sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,"&numName&",comment)" & _
            "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
            sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " , " & set_nums & " ,' " & comment & "')"
          Case "1" '盘点差异
            sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,"&numName&",comment)" & _
            "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
            sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " , " & set_nums & " ,' " & comment & "')"
          End Select
		  'de sql
		  CN.Execute sql
      elseIf Len(set_nums) > 0 Then
        Select Case TableName
        Case "d_indentsub", "d_retailsub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,nums,comment)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " ,  " & set_nums & "  ,' " & comment & "')"
        Case "d_outindentsub", "d_outindentprosub","d_outindentsetsub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,cost,j_price,x_price,s_price,discount,nums,comment,chknums)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " ,  " & set_nums & "  ,' " & comment & "' , " & chknums & ")"
        Case "d_outindentsqsub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,sq_tjnums,comment,sq_spnums)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " ,  " & set_nums & "  ,' " & comment & "' , " & chknums & ")"
        Case "d_quotasub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,pj_price,px_price,s_price,discount,nums,comment)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & pj_price & " , " & px_price & " , " & s_price & " , " & discount & " ,  " & set_nums & "  ,' " & comment & "' )"
        Case "d_inventorysub"
          Select Case ext
          Case "0","" '盘点数量
            sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,nums,comment)" & _
            "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
            sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " , " & set_nums & " ,' " & comment & "')"
          Case "1" '盘点差异
            sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,d_nums,comment)" & _
            "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
            sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " , " & set_nums & " ,' " & comment & "')"
          End Select
		case "d_movesub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,set_nums,comment)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " ,  " & set_nums & " , '" & comment & "')"
        case "d_msellsub"
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,j_cost,j_price,x_price,s_price,discount,set_nums,comment,j_price1, x_price1, s_price1, discount1)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & j_cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " ,  " & set_nums & " , '" & comment & "'," & j_price1 & " , " & x_price1 & " , " & s_price1 & " , " & discount1 & ")"
		Case Else
          sql = "insert into " & TableName & "(" & PkName & ",boxid,clothingid,styleid,sizeid,colorid,cost,j_price,x_price,s_price,discount,nums,comment,chknums)" & _
          "values('" & id & "' , '" & boxid & "' , '" & clothingid & "' , '" & styleid & "' , '" & _
          sizeid & " ', '" & colorid & "' , " & cost & " , " & j_price & " , " & x_price & " , " & s_price & " , " & discount & " , "& nums & " , '" & comment & "' , " & chknums & ")"
        End Select
		'de sql
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
