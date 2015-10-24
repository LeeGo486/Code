<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<%
Class SearchTable

  Dim FieldArr(40,3) '字段数组
  Dim FieldArrTop '数组中值的多少
  Dim RowColor(1) '交替的颜色
  
  Private Sub Class_Initialize()
	FieldArrTop = 0
	
	RowColor(0)="#F3E5E2"
	RowColor(1)="#FFFFFF"
  End Sub
  
  Public Sub SetField(FieldId,FieldName,Width,Color)
    FieldArr(FieldArrTop,0) = FieldId
    FieldArr(FieldArrTop,1) = FieldName
    FieldArr(FieldArrTop,2) = Width
    FieldArr(FieldArrTop,3) = Color
	FieldArrTop = FieldArrTop + 1
  End Sub
  
  Public Sub SetRowColor(c1,c2)
    RowColor(0) = c1
	RowColor(1) = c2
  End Sub
  
  Public Sub ShowTable(rs)
    Dim i,sumWidth,RowColorFlag
	RowColorFlag = true
	sumWidth = 0
	For i = 0 To FieldArrTop-1 '计算总宽度
	  sumWidth = sumWidth + FieldArr(i,2)
	Next
	
	Response.Write "<div id=""gt"" style=""width:"&sumWidth&";height:100%"&""&";"" border=0>"
    Response.Write "<table>"
	Response.Write "<thead>"

	Response.Write("<tr>")
	For i=0 To FieldArrTop-1
	  Response.Write("<th width="""&FieldArr(i,2)&""">")
	  Response.Write(FieldArr(i,1))
	  Response.Write("</th>")
	Next
	Response.Write("</tr>")
	Response.Write("</thead>")
	
	While Not rs.eof
	  If RowColorFlag Then
	    Response.Write("<tr bgcolor="""&RowColor(0)&""">")
	  Else
	    Response.Write("<tr bgcolor="""&RowColor(1)&""">")
	  End if
	  RowColorFlag = Not RowColorFlag
	  
	  For i=0 To FieldArrTop-1
	    Response.Write("<td>")
		
		on error resume next '用于调试*************************************
		
	    Response.Write(rs(FieldArr(i,0)))
		
		if err.number<>0 then '用于调试*******************************
		  de "没有 "&FieldArr(i,1)&" , "&FieldArr(i,0)&" 这个字段!"
		  response.end
		end if
		
	    Response.Write("</td>")
	  Next
	  Response.Write("</tr>")
	  rs.MoveNext
	Wend
	Response.Write("  </tbody>")	
	Response.Write("</table>")
	Response.Write("</div>")
  End Sub
  
End Class
%>