Attribute VB_Name = "F20_收货明细_通用"
Function SSS_GS(Target As String)
'   该方法的功能：用于将前台操作的字段转换成上传XML需要的字段
    Dim A As String
    Dim B As String
'    判断申请单类型
    A = Target
    B = vbNullString
        For Each cl In Range("RecDetailsList[[SKU]]")
            If cl.Value = A Then
            B = GetValueByHead("RecDetailsList", cl.Row, "本次收货数量")
            C = GetValueByHead("RecDetailsList", cl.Row, "SKU")
            SetValueByHead "RecDetailsList", cl.Row, "本次收货数量", B + 1
            End If
            Sheets("收货明细").Range("G6").Select
        Next
    If A <> C Then
        MsgBox "该款号不存在！", vbCritical, "提示"
        GoTo N
    End If
'    Else: MsgBox "请检查申请单类型是否正确！", vbCritical, "提示"
'        GoTo N
'    End If

N:
End Function
