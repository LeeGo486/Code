Attribute VB_Name = "F20_�ջ���ϸ_ͨ��"
Function SSS_GS(Target As String)
'   �÷����Ĺ��ܣ����ڽ�ǰ̨�������ֶ�ת�����ϴ�XML��Ҫ���ֶ�
    Dim A As String
    Dim B As String
'    �ж����뵥����
    A = Target
    B = vbNullString
        For Each cl In Range("RecDetailsList[[SKU]]")
            If cl.Value = A Then
            B = GetValueByHead("RecDetailsList", cl.Row, "�����ջ�����")
            C = GetValueByHead("RecDetailsList", cl.Row, "SKU")
            SetValueByHead "RecDetailsList", cl.Row, "�����ջ�����", B + 1
            End If
            Sheets("�ջ���ϸ").Range("G6").Select
        Next
    If A <> C Then
        MsgBox "�ÿ�Ų����ڣ�", vbCritical, "��ʾ"
        GoTo N
    End If
'    Else: MsgBox "�������뵥�����Ƿ���ȷ��", vbCritical, "��ʾ"
'        GoTo N
'    End If

N:
End Function
