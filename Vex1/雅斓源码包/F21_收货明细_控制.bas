Attribute VB_Name = "F21_�ջ���ϸ_����"
Sub RecDetails_Save()
    Dim A As String, B As String, C As String, D As String, E As String, F As String, G As String, H As Integer, Q As String
    Dim R As String, I As Integer, J As String, K As String, L As String, M As String, N As String, O As String, p As String
    Dim XMLStr As String, CurRow As Long, wrksht As Worksheet
    
    ScreenUpdate False
    ProtectSheet "�ջ���ϸ", False
    Set wrksht = ActiveWorkbook.Worksheets("�ջ���ϸ")
    If TableIsExists("�ջ���ϸ") = False Then GoTo N
    
    If wrksht.ListObjects(1).Name = "RecDetailsList" Then
        For X = GetTableRowId("RecDetailsList", 1) To GetTableRowId("RecDetailsList", -1)
            If Cells(X, 1) = "I" Then
                CurRow = X
                H = GetValueByHead("RecDetailsList", CurRow, "�ƻ���������") '�ƻ���������
                I = GetValueByHead("RecDetailsList", CurRow, "�����ջ�����") '�ջ�����
                If H < I Then
                    MsgBox "�ջ����������ƻ����������飡"
                    GoTo N
                End If
            End If
        Next
        For X = GetTableRowId("RecDetailsList", 1) To GetTableRowId("RecDetailsList", -1)
            If Cells(X, 1) = "I" Then
                CurRow = X
                A = GetValueByHead("RecDetailsList", CurRow, "��ƷID")  '��ƷID
                B = GetValueByHead("RecDetailsList", CurRow, "��λGUID") '��λGUID
                C = GetValueByHead("RecDetailsList", CurRow, "�����ƻ���ϸID") '�����ƻ���ϸID
                D = GetValueByHead("RecDetailsList", CurRow, "�ɹ�ԭ�Ҽۣ�������") '�ɹ�ԭ�Ҽۣ�������
                E = GetValueByHead("RecDetailsList", CurRow, "�ɹ����Ҽۣ�������") '�ɹ����Ҽۣ�������
                F = GetValueByHead("RecDetailsList", CurRow, "���Ƽ�")  '���Ƽ�
                G = GetValueByHead("RecDetailsList", CurRow, "���ID")  '���ID
                H = GetValueByHead("RecDetailsList", CurRow, "�ƻ���������") '�ƻ���������
                I = GetValueByHead("RecDetailsList", CurRow, "�����ջ�����") '�ջ�����
                J = GetValueByHead("RecDetailsList", CurRow, "�ջ�������GUID") '�ջ�������GUID
                K = Cells(6, 4) '�ջ������
                L = GetValueByHead("RecDetailsList", CurRow, "�����ƻ�ID")  '�����ƻ�����ID
                M = GetValueByHead("RecDetailsList", CurRow, "�ջ�������")  '�ջ�������
                N = GetValueByHead("RecDetailsList", CurRow, "�ƻ�������������") '�ƻ�������������
                O = GetValueByHead("RecDetailsList", CurRow, "�ƻ�����������") '�ƻ�����������
                p = GetValueByHead("RecDetailsList", CurRow, "��Ӧ�̱��") '��Ӧ�̱��
                XMLStr = "<Interface WSID=""e77c9315-4ae9-442a-a2c6-7c1af2c31f31""" & _
                " App=""" & GetAppName & """ SessionID="""">" & _
                "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,NEW����ʵ��,B02_Bill.PRBD_ReceiveDetail��" & _
                "����������,��ƷID,��λ,�����ƻ���ϸID,�ɹ�ԭ�Ҽ�,�ɹ����Ҽ�,���Ƽ�,���ID,�ƻ���������,�ջ�����,״̬,������,����޸���" & _
                "�ջ�������ID,�ջ������,�����ƻ�����ID,,�ջ�������,�ƻ�������������,�ƻ�����������,�ջ�ʱ��,��Ӧ�̱�š�" & _
                "����������,��N����ƷID,��N����λ,��N�������ƻ���ϸID,��N���ɹ�ԭ�Ҽ�,��N���ɹ����Ҽ�,��N�����Ƽ�,��N���ƻ���������," & _
                "��N���ջ�����,��N��POS_��ⵥ��,��N��״̬,��N��������,��N������޸���,��N���ջ�������ID,��N���ջ������,��N�������ƻ�����ID,��N���ջ�������," & _
                "��N���ƻ������������� ,��N���ƻ�����������,��N���ջ�ʱ��,��N����Ӧ�̱�š�" & _
                "����N����ƷID," & A & "������N����λ," & B & "������N�������ƻ���ϸID," & C & "������N���ɹ�ԭ�Ҽ�," & D & "������N���ɹ����Ҽ�," & E & "������N�����Ƽ�," & F & "��" & _
                "����N���ƻ���������," & H & "������N���ջ�����," & I & "������N��״̬,40862D71-AAB5-4894-8680-56573725DB2E��" & _
                "����N��������,qianc������N������޸���,qianc������N���ջ�������ID," & J & "������N���ջ������," & K & "��" & _
                "����N�������ƻ�����ID," & L & "������N���ջ�������," & M & "������N���ƻ�������������," & N & "��" & _
                "����N���ƻ�����������," & O & "������N���ջ�ʱ��," & Date & "������N����Ӧ�̱��," & p & "��</ConditionStr></Interface>"
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = GetWsrrRlt(XMLStr)
    '            Msg "FORM", vbCritical, "", "", XMLStr
    '            Exit Sub
                If GetValueFromXml(XMLStr, "Root") = "" Then
                    SetValueByHead "RecDetailsList", CurRow, "����", "F"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                    GoTo N
                End If
            End If
        Next
        MsgBox "��ϲ�㣬����ɹ��� "
    End If
N:
    ProtectSheet "�ջ���ϸ", False
    ScreenUpdate False
End Sub

Sub ClearTotal_One()
    Dim ReRow As Long, wrksht As Worksheet
    ScreenUpdate False
    ProtectSheet "�ջ���ϸ", False
    
    Set wrksht = ActiveWorkbook.Worksheets("�ջ���ϸ")
    If TableIsExists("�ջ���ϸ") = False Then GoTo N
    If wrksht.ListObjects(1).Name = "RecDetailsList" Then
        If CheckSelectionInTable("RecDetailsList", True) = False Then GoTo N
        ReRow = Selection.Row
        SetValueByHead "RecDetailsList", ReRow, "�����ջ�����", "0"
    End If
N:
    ScreenUpdate False
    ProtectSheet "�ջ���ϸ", False
End Sub

Sub ClearTotal_All()
    Dim ReRow As Long, wrksht As Worksheet
    ScreenUpdate False
    ProtectSheet "�ջ���ϸ", False
    Set wrksht = ActiveWorkbook.Worksheets("�ջ���ϸ")
    If TableIsExists("�ջ���ϸ") = False Then GoTo N
    If wrksht.ListObjects(1).Name = "RecDetailsList" Then
        For I = GetTableRowId("RecDetailsList", 1) To GetTableRowId("RecDetailsList", -1)
        ReRow = I
        SetValueByHead "RecDetailsList", ReRow, "�����ջ�����", "0"
        Next
    End If
N:
    ScreenUpdate False
    ProtectSheet "�ջ���ϸ", False
End Sub

