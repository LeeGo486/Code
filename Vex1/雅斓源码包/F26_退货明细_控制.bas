Attribute VB_Name = "F26_�˻���ϸ_����"
Sub ReturnBillD_Save()
    Dim ReRow As Long, XMLStr As String, wrksht As Worksheet
    Dim A As String, B As String, C As String, D As String, E As String, F As String, G As String, H As String, I As String
    Dim J As String, K As String, L As String, M As String, N As String
    
    ScreenUpdate False
    ProtectSheet "�˻���ϸ", False
    Set wrksht = ActiveWorkbook.Worksheets("�˻���ϸ")
    If TableIsExists("�˻���ϸ") = False Then GoTo N
    If wrksht.ListObjects(1).Name = "ReturnBillDList" Then
        For X = GetTableRowId("ReturnBillDList", 1) To GetTableRowId("ReturnBillDList", -1)
            ReRow = X
            If GetValueByHead("ReturnBillDList", ReRow, "����") = "I" Then
                A = GetValueByHead("ReturnBillDList", ReRow, "��ƷID")
                B = GetValueByHead("ReturnBillDList", ReRow, "��λID")
                C = GetValueByHead("ReturnBillDList", ReRow, "�ɹ�����ϸID")
                D = GetValueByHead("ReturnBillDList", ReRow, "�ɹ�ԭ�Ҽ�")
                E = GetValueByHead("ReturnBillDList", ReRow, "�ɹ����Ҽ�")
                F = GetValueByHead("ReturnBillDList", ReRow, "���Ƽ�")
                G = GetValueByHead("ReturnBillDList", ReRow, "�˻�����")
                H = GetValueByHead("ReturnBillDList", ReRow, "״̬ID")
                I = GetValueByHead("ReturnBillDList", ReRow, "�˻�������ID")
                J = GetValueByHead("ReturnBillDList", ReRow, "�˻������")
                K = GetValueByHead("ReturnBillDList", ReRow, "��Ӧ��GUID")
                L = GetValueByHead("ReturnBillDList", ReRow, "�ɹ�������ID")
                M = GetValueByHead("ReturnBillDList", ReRow, "�ɹ�������ID") '�ɹ������
                N = GetValueByHead("ReturnBillDList", ReRow, "�˻�ԭ��")
                
                XMLStr = "<Interface WSID=""7163bbde-858e-4138-94fb-60d031963570""" & _
                " App=""ITDC_EXCEL"" SessionID="""">" & _
                "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,NEW����ʵ��,B02_Bill.PRCD_ReturnDetail��" & _
                "����������,��ƷID,��λ,�ɹ�����ϸID,�ɹ�ԭ�Ҽ�,�ɹ����Ҽ�,���Ƽ�,�˻�����,״̬,������,����޸���,�˻�������ID,�˻������,��Ӧ��ID," & _
                "�ɹ�������ID,�ɹ������,�˻�ԭ��" & _
                "����������,��N����ƷID,��N����λ,��N���ɹ�����ϸID,��N���ɹ�ԭ�Ҽ�,��N���ɹ����Ҽ�,��N�����Ƽ�,��N���˻�����,��N��״̬," & _
                "��N��������,��N������޸���,��N���˻�������ID,��N���˻������,��N����Ӧ��ID,��N���ɹ�������ID,��N���ɹ������,��N���˻�ԭ��" & _
                "����N����ƷID," & A & "������N����λ," & B & "������N���ɹ�����ϸID," & C & "������N���ɹ�ԭ�Ҽ�," & D & "��" & _
                "����N���ɹ����Ҽ�," & E & "������N�����Ƽ�," & F & "������N���˻�����," & G & "������N��״̬," & H & "��" & _
                "����N��������,qianc������N������޸���,qianc������N���˻�������ID," & I & "������N���˻������,��" & _
                "����N����Ӧ��ID," & K & "������N���ɹ�������ID," & L & "������N���ɹ������," & M & "������N���˻�ԭ��," & N & "��" & _
                "</ConditionStr></Interface>"
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                If GetValueFromXml(XMLStr, "Root") = "" Then
                    SetValueByHead "ReturnBillDList", ReRow, "����", "F"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                    GoTo N
                End If
            End If
        Next
        Sheets("�˻���ϸ").CommandButton2.Enabled = ture
        MsgBox "��ϲ�㣬����ɹ��� "
    End If
N:
    ProtectSheet "�˻���ϸ", False
    ScreenUpdate False
End Sub

Sub ReturnBillD_Update()
    
    Dim XMLStr As String, ReRow As Long, wrksht As Worksheet
    Dim POId As String, CoId As String, RetMId As String, RetDId As String
    Dim RetQ As String  '�˻�����
    Dim RetR As String  '�˻�ԭ��
    
    ScreenUpdate False
    ProtectSheet "�˻���ϸ", False
    Set wrksht = ActiveWorkbook.Worksheets("�˻���ϸ")
    If TableIsExists("�˻���ϸ") = False Then GoTo N
    If wrksht.ListObjects(1).Name = "ReturnBillDList" Then                  '����˻�����ϸ����ɹ������Ƿ��ִ�����Ҫ�޸��������˻�ԭ��ʱִ���������
        If CheckSelectionInTable("ReturnBillDList", True) = False Then GoTo N
        ReRow = Selection.Row
        If GetValueByHead("ReturnBillDList", ReRow, "����") = "F" Then
            If GetValueByHead("ReturnBillDList", ReRow, "״̬") = "δ���" Then
                POId = GetValueByHead("ReturnBillDList", ReRow, "�ɹ�����ϸID")
                CoId = GetValueByHead("ReturnBillDList", ReRow, "��ƷID")
                RetMId = GetValueByHead("ReturnBillDList", ReRow, "�˻�������ID")
                RetDId = GetValueByHead("ReturnBillDList", ReRow, "�˻�����ϸID")
                RetQ = GetValueByHead("ReturnBillDList", ReRow, "�˻�����")
                RetR = GetValueByHead("ReturnBillDList", ReRow, "�˻�ԭ��")
                XMLStr = "<Interface WSID=""7163bbde-858e-4138-94fb-60d031963570""" & _
                    " App=""ITDC_EXCEL"" SessionID="""">" & _
                    "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,UPDATE����ʵ��,B02_Bill.PRCD_ReturnDetail��" & _
                    "����������,��N���˻�����,��N���˻�ԭ��,��N������޸��ˡ�" & _
                    "����������,��N���˻�����,��N���˻�ԭ��,��W������,��W����ҵ��,��W���ɹ�����ϸID,��W����ƷID,��W���˻�����ϸID,��W���˻�������ID��" & _
                    "����N���˻�����," & RetQ & "������N���˻�ԭ��," & RetR & "������N������޸���,qianc��" & _
                    "����W������,100������W����ҵ��,200������W���ɹ�����ϸID," & POId & "������W����ƷID," & CoId & "������W���˻�����ϸID," & RetDId & "������W���˻�������ID," & RetMId & "��" & _
                    "</ConditionStr></Interface>"
                XMLStr = GetWsrrRlt(XMLStr)
                
                If GetValueFromXml(XMLStr, "Root") = "" Then
                    MsgBox "��ϲ�����³ɹ���"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                    GoTo N
                End If
            Else: MsgBox "��Ǹ�����е�״̬���ǡ�δ��ˡ����޷����¡�"
                GoTo N
            End If
        Else: MsgBox "��Ǹ�����°�ťֻ�ܸ��²����б�ʶΪF���С�"
            GoTo N
        End If
    Else
        If wrksht.ListObjects(1).Name = "ReturnBillDetailsList" Then    '������˻������鿴��ϸ������������ԭ�򲻶Ե�ʱ��ִ���������
            If CheckSelectionInTable("ReturnBillDetailsList", True) = False Then GoTo N
            ReRow = Selection.Row
            If GetValueByHead("ReturnBillDetailsList", ReRow, "״̬") = "δ���" Then
                POId = GetValueByHead("ReturnBillDetailsList", ReRow, "�ɹ�����ϸID")
                CoId = GetValueByHead("ReturnBillDetailsList", ReRow, "��ƷID")
                RetMId = GetValueByHead("ReturnBillDetailsList", ReRow, "�˻�������ID")
                RetDId = GetValueByHead("ReturnBillDetailsList", ReRow, "�˻�����ϸID")
                RetQ = GetValueByHead("ReturnBillDetailsList", ReRow, "�˻�����")
                RetR = GetValueByHead("ReturnBillDetailsList", ReRow, "�˻�ԭ��")
                
                XMLStr = "<Interface WSID=""7163bbde-858e-4138-94fb-60d031963570""" & _
                    " App=""ITDC_EXCEL"" SessionID="""">" & _
                    "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,UPDATE����ʵ��,B02_Bill.PRCD_ReturnDetail��" & _
                    "����������,��N���˻�����,��N���˻�ԭ��,��N������޸��ˡ�" & _
                    "����������,��N���˻�����,��N���˻�ԭ��,��W������,��W����ҵ��,��W���ɹ�����ϸID,��W����ƷID,��W���˻�����ϸID,��W���˻�������ID��" & _
                    "����N���˻�����," & RetQ & "������N���˻�ԭ��," & RetR & "������N������޸���,qianc��" & _
                    "����W������,100������W����ҵ��,200������W���ɹ�����ϸID," & POId & "������W����ƷID," & CoId & "������W���˻�����ϸID," & RetDId & "������W���˻�������ID," & RetMId & "��" & _
                    "</ConditionStr></Interface>"
                XMLStr = GetWsrrRlt(XMLStr)
                If GetValueFromXml(XMLStr, "Root") = "" Then
                    MsgBox "��ϲ�����³ɹ���"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                    GoTo N
                End If
            Else: MsgBox "��Ǹ�����е�״̬���ǡ�δ��ˡ����޷����¡�"
                GoTo N
            End If
        End If
    End If
N:
    ProtectSheet "�˻���ϸ", False
    ScreenUpdate False
End Sub


