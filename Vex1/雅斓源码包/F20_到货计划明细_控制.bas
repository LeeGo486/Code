Attribute VB_Name = "F20_�����ƻ���ϸ_����"
Sub �����ƻ���ϸ_save()
    '�����½�

    ScreenUpdate False
    'If Not CheckIsLogin() Then GoTo N
    ProtectSheet "�����ƻ���ϸ", False
    Dim wrksht As Worksheet
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String, A As String, B As String, C As String, D As String, E As String, F As String
    Dim G As String, H As String, I As String, J As String, K As String, L As String, M As String, N As String, O As String, p As String, Q As String, R As String
    Dim S As String, T As String, U As String, V As String, W As String, X As String, Y As String, Z As String
    Dim RowMIN As String, RowMAX As String
    Set wrksht = ActiveWorkbook.Worksheets("�����ƻ���ϸ")
    If TableIsExists("�����ƻ���ϸ") = True Then  '�����ͬ���д���Table
    If wrksht.ListObjects(1).Name = "DeliveryPlanList" Then '���TableName��"PayNewList"
     CurRow = Selection.Row
    '�趨Ҫ�ϴ�����
    If Not CheckSelectionInTable("DeliveryPlanList", True) Then
        MsgBox "���ڵ�ǰ�����ѡ��һ�У�      ", vbCritical, "��ʾ"
        GoTo N
    End If
    SetValueByHead "DeliveryPlanList", CurRow, "����", "I"
    If GetValueByHead("DeliveryPlanList", CurRow, "����") = "I" Then
    '�����½������ƻ���Ϣ
        If MsgBox("��ȷ��Ҫ�����桿" & "�����ƻ����ƣ� " & GetValueByHead("DeliveryPlanList", CurRow, "PR1_CONO") & "��������    ", vbYesNo, "��ʾ") = vbYes Then
''    ����ѭ����ʼ------by zz 20130901
    RowMIN = GetRowId("DeliveryPlanList", "MIN")
    RowMAX = GetRowId("DeliveryPlanList", "MAX")
    For CurRow = RowMIN To RowMAX
''    ����ѭ����ʼ------by zz 20130901
            B = Sheets("�����ƻ���ϸ").Range("B1").Value
            C = Sheets("�����ƻ���ϸ").Range("F5").Value
            D = GetValueByHead("DeliveryPlanList", CurRow, "�ɹ������")
            E = GetValueByHead("DeliveryPlanList", CurRow, "��ƷID")
            F = GetValueByHead("DeliveryPlanList", CurRow, "��λ")
            G = GetValueByHead("DeliveryPlanList", CurRow, "�ɹ�����ϸID")
            H = GetValueByHead("DeliveryPlanList", CurRow, "�ɹ�ԭ�Ҽ�")
            I = GetValueByHead("DeliveryPlanList", CurRow, "�ɹ����Ҽ�")
            J = GetValueByHead("DeliveryPlanList", CurRow, "���Ƽ�")
            K = GetValueByHead("DeliveryPlanList", CurRow, "Ԥ�Ƶ�������")
            L = GetValueByHead("DeliveryPlanList", CurRow, "���μƻ���������")
            M = GetValueByHead("DeliveryPlanList", CurRow, "���μƻ��������")
            N = GetValueByHead("DeliveryPlanList", CurRow, "״̬")
            O = GetValueByHead("DeliveryPlanList", CurRow, "������")
            p = GetValueByHead("DeliveryPlanList", CurRow, "����ʱ��")
            Q = GetValueByHead("DeliveryPlanList", CurRow, "����޸���")
            R = GetValueByHead("DeliveryPlanList", CurRow, "����޸�ʱ��")
            S = GetValueByHead("DeliveryPlanList", CurRow, "�ɹ���������")
            T = GetValueByHead("DeliveryPlanList", CurRow, "�ɹ�������")
            U = GetValueByHead("DeliveryPlanList", CurRow, "�ɹ�����")
            V = GetValueByHead("DeliveryPlanList", CurRow, "�ѵ�����")
            W = GetValueByHead("DeliveryPlanList", CurRow, "�����ɼƻ�����")
            X = GetValueByHead("DeliveryPlanList", CurRow, "��������")
            If L = "0" Then
               GoTo F
            End If

            XMLStr = "<Interface WSID=""a7c3649a-4104-4e4d-90e3-d09af73515c1""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType>" & _
            "<ConditionStr>����������,NEW����ʵ��,B02_Bill.PRAD_ArrivalPlanDetail��" & _
            "����������,��ƷID,��λ,�ɹ�����ϸID,�ɹ�ԭ�Ҽ�,�ɹ����Ҽ�,���Ƽ�,Ԥ�Ƶ�������,�ɹ�����,�ѵ�����,�������ƻ�����,���μƻ���������,״̬,������,����޸���,�����ƻ����,�ɹ������,�ɹ���������,�ɹ������" & _
            "����������,��N����ƷID,��N����λ,��N���ɹ�����ϸID,��N���ɹ�ԭ�Ҽ�,��N���ɹ����Ҽ�,��N�����Ƽ�,��N��Ԥ�Ƶ�������," & _
            "��N���ɹ�����,��N���ѵ�����,��N���������ƻ�����,��N�����μƻ���������,��N��״̬" & _
            "��N��������,��N������޸���,��N�������ƻ����,��N�������ƻ�����ID��N���ɹ������,��N���ɹ���������,��N���ɹ������" & _
            "����N����ƷID," & E & "������N����λ," & F & "������N���ɹ�����ϸID," & G & "��" & _
            "����N���ɹ�ԭ�Ҽ�," & H & "������N���ɹ����Ҽ�," & I & "������N�����Ƽ�," & J & "��" & _
            "����N��Ԥ�Ƶ�������ID," & K & "��" & _
            "����N���ɹ�����," & U & "������N���ѵ�����," & V & "������N���������ƻ�����," & W & "������N�����μƻ���������," & L & "������N��״̬,40862D71-AAB5-4894-8680-56573725DB2E��" & _
            "����N��������," & O & "������N������޸���," & Q & "������N�������ƻ����," & C & "������N���ɹ������," & D & "������N�������ƻ�����ID," & B & "��" & _
            "����N���ɹ���������," & S & "������N���ɹ�������," & T & "��</ConditionStr>" & _
            "</Interface>"
'                '�����ϴ�xml��ʽ,ע��WSID��OPTYPE����
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
'                '����ѭ������------by zz 20130901
F:
                Next CurRow
'                '����ѭ������------by zz 20130901
                If GetValueFromXml(XMLStr, "ROOT") = "" Then
                    MsgBox "����ɹ���      ", vbInformation, "��ʾ"
                    SetValueByHead "DeliveryPlanList", CurRow - 1, "����", "F"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                    GoTo N
                End If
            End If
        End If
    End If
        If TableIsExists("�����ƻ���ϸ") = True Then  '�����ͬ���д���Table
        If wrksht.ListObjects(1).Name = "DeliveryPlanMXList" Then '���TableName��"PayNewList"
        CurRow = Selection.Row
        SetValueByHead "DeliveryPlanMXList", CurRow, "����", "I"
        If GetValueByHead("DeliveryPlanMXList", CurRow, "����") = "I" Then
        '�����½������ƻ���Ϣ
        If MsgBox("��ȷ��Ҫ�����桿" & "�����ƻ����ƣ� " & GetValueByHead("DeliveryPlanMXList", CurRow, "�����ƻ���ϸID") & "��������    ", vbYesNo, "��ʾ") = vbYes Then
        '����ѭ����ʼ------by zz 20130901
        RowMIN = GetRowId("DeliveryPlanMXList", "MIN")
        RowMAX = GetRowId("DeliveryPlanMXList", "MAX")
    
        For CurRow = RowMIN To RowMAX
        '����ѭ����ʼ------by zz 20130901
            DHJHID = GetValueByHead("DeliveryPlanMXList", CurRow, "�����ƻ���ϸID")
            DHJHBH = GetValueByHead("DeliveryPlanMXList", CurRow, "�����ƻ�����ID")
            E = GetValueByHead("DeliveryPlanMXList", CurRow, "��ƷID")
            F = GetValueByHead("DeliveryPlanMXList", CurRow, "��λ")
            G = GetValueByHead("DeliveryPlanMXList", CurRow, "�ɹ�����ϸID")
            L = GetValueByHead("DeliveryPlanMXList", CurRow, "���μƻ���������")
            M = GetValueByHead("DeliveryPlanMXList", CurRow, "���μƻ��������")
            U = GetValueByHead("DeliveryPlanMXList", CurRow, "�ɹ�����")
            V = GetValueByHead("DeliveryPlanMXList", CurRow, "�ѵ�����")
            
            XMLStr = "<Interface WSID=""a7c3649a-4104-4e4d-90e3-d09af73515c1""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,UPDATE����ʵ��,B02_Bill.PRAD_ArrivalPlanDetail��" & _
            "����������,���μƻ���������,�ɹ�����,�ѵ�����������������,��N�����μƻ���������,��N���ɹ�����,��N���ѵ�����,��W���ɹ�����ϸID,��W�������ƻ�����ID,��W����ƷID,��W�������ƻ���ϸID��" & _
            "����N�����μƻ���������," & L & "������N���ɹ�����," & U & "������N���ѵ�����," & V & "������W���ɹ�����ϸID," & G & "������W�������ƻ�����ID," & DHJHBH & "��" & _
            "����W�������ƻ���ϸID," & DHJHID & "������W����ƷID," & E & "��</ConditionStr></Interface>"


                XMLStr = GetWsrrRlt(XMLStr)

                '����ѭ������------by zz 20130901
                Next CurRow
                 '����ѭ������------by zz 20130901
                If GetValueFromXml(XMLStr, "ROOT") = "" Then
                    MsgBox "����ɹ���      ", vbInformation, "��ʾ"
                    SetValueByHead "DeliveryPlanMXList", CurRow - 1, "����", "F"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                    GoTo N
                End If
                End If
            End If
        End If
    End If
End If
'    ProtectSheetWithEnableAllowFiltering "�����ƻ�", True
N:
    ScreenUpdate True

End Sub
