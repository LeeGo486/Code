Attribute VB_Name = "F18_�����ƻ�_����"
Sub �����ƻ�_load()
    ScreenUpdate False                  'ֹͣ����
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "�����ƻ�", False
'        SetValueByName "�����ƻ�_Change", "1"
        ClearTable "DeliveryPlan2List"
        ClearTable "DeliveryPlanList"
        Dim XMLStr As String
        Dim CGDH As String
        Dim CurRow As Long
        CurRow = Selection.Row
'        CGDH = GetValueByHead("PurchaseOrderList", CurRow, "�ɹ���ID")
        XMLStr = "<Interface WSID=""fc4bd3e2-c825-45db-a1c5-f4d300752879""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,GET����ʵ��,B02_Bill.PRA_ArrivalPlan��" & _
        "����������,����,��ҵ��,�����ƻ�ID,�����ƻ����,��Ӧ�̱��,��Ӧ�̱��,�ɹ������,�ɹ�����,�ѵ�����,���μƻ���������,�ɹ����,�ѵ������,���μƻ��������,��������,������,״̬,״̬����,������,����ʱ��,����޸���,����޸�ʱ��,�ɹ�����š�</ConditionStr></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
'        XMLStr = Replace(XMLStr, "'", "\u0027")
        XMLStr = GetWsrrRlt(XMLStr)
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '��XML��ʽת��Ϊ�����б����Ҫ���XML��ʽ
        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("DeliveryPlan2List")))
        CreateTableForXML "DeliveryPlan2List", XMLStr, "ROOT", "�����ƻ�", "A9"
        If GetRowId("DeliveryPlan2List", "MAX") <> GetRowId("DeliveryPlan2List", "MIN") Then _
        DeleteRows "�����ƻ�", GetRowId("DeliveryPlan2List", "MIN") & ":" & GetRowId("DeliveryPlan2List", "MIN")
        SetFormat_DeliveryPlan2List_All
        'ProtectSheetWithEnableAllowFiltering "�����ƻ�", True
        Sheets("�����ƻ�").Activate
        Sheets("�����ƻ�").Range("C10").Select
'    SetValueByName "�����ƻ�_Change", "0"
'    End If
    ScreenUpdate True
End Sub
Sub ������ϸ_load()
    ScreenUpdate False                  'ֹͣ����
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "�����ƻ���ϸ", False
'        SetValueByName "�����ƻ���ϸ_Change", "1"
        ClearTable "DeliveryPlanList"
        ClearTable "DeliveryPlanMXList"
        Dim XMLStr As String
        Dim CGDH As String
        Dim CurRow As Long
        CurRow = Selection.Row
        DHJHBH = GetValueByHead("DeliveryPlan2List", CurRow, "�����ƻ�ID")
        CGD = GetValueByHead("DeliveryPlan2List", CurRow, "�ɹ���ID")
        XMLStr = "<Interface WSID=""a7c3649a-4104-4e4d-90e3-d09af73515c1""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,GET����ʵ��,B02_Bill.PRAD_ArrivalPlanDetail��" & _
        "����������,����,��ҵ��,�����ƻ�ID,�����ƻ����,��ƷID,��λ,�ɹ�����ϸID,�ɹ�ԭ�Ҽ�,�ɹ����Ҽ�,���Ƽ�,Ԥ�Ƶ�������,�ɹ�����,�ѵ�����,�������ƻ�����,���μƻ���������,���μƻ��������,��������,״̬,״̬����,������,����ʱ��,����޸���,����޸�ʱ��,��Ӧ�̿��,���,��λ���ա�" & _
        "����������,��W�������ƻ����,��W���ɹ����š�����W�������ƻ����," & DHJHBH & "������W���ɹ�����," & CGD & "��</ConditionStr></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
'        XMLStr = Replace(XMLStr, "'", "\u0027")
        XMLStr = GetWsrrRlt(XMLStr)
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '��XML��ʽת��Ϊ�����б����Ҫ���XML��ʽ
        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("DeliveryPlanMXList")))
        CreateTableForXML "DeliveryPlanMXList", XMLStr, "ROOT", "�����ƻ���ϸ", "A6"
        If GetRowId("DeliveryPlanMXList", "MAX") <> GetRowId("DeliveryPlanMXList", "MIN") Then _
        DeleteRows "�����ƻ���ϸ", GetRowId("DeliveryPlanMXList", "MIN") & ":" & GetRowId("DeliveryPlanMXList", "MIN")
        
        Sheets("�����ƻ���ϸ").Activate
        SetFormat_DeliveryPlanMXList_All
        CurRow = Selection.Row
        'ProtectSheetWithEnableAllowFiltering "�����ƻ���ϸ", True
        
        Sheets("�����ƻ���ϸ").Range("D8").Select
'    SetValueByName "�����ƻ���ϸ_Change", "0"
'    End If
    ScreenUpdate True
End Sub
Sub ���ɸ��_load()
    ScreenUpdate False                  'ֹͣ����
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "�������뵥", False
        SetValueByName "�������뵥_Change", "1"
        ClearTable "PayNewList"
        ClearTable "PayList"
        ClearTable "PayDHList"
        ClearTable "PayTHList"
        Dim XMLStr As String
        Dim HTID As String
        Dim CurRow As Long
        CurRow = Selection.Row

        If GetValueByHead("DeliveryPlan2List", CurRow, "����") = "U" Or GetValueByHead("DeliveryPlan2List", CurRow, "����") = "" Then
            MsgBox "������Ҫ������ǰ�򡰡̡�лл��", vbCritical, "��ʾ"
            GoTo N
        End If
        '����ѭ����ʼ------by zz 20130901
        Dim RowMIN As String, RowMAX As String, CombGUID As String
        CombGUID = ""
        RowMIN = GetRowId("DeliveryPlan2List", "MIN")
        RowMAX = GetRowId("DeliveryPlan2List", "MAX")
        
        For CurRow = RowMIN To RowMAX
            If GetValueByHead("DeliveryPlan2List", CurRow, "����") = "��" Then
                CombGUID = CombGUID + "/" + GetValueByHead("DeliveryPlan2List", CurRow, "�����ƻ�ID")
            End If
        Next CurRow
        '����ѭ����ʼ------by zz 20130901
'        Msg "FORM", vbCritical, "", "", CombGUID
        
        XMLStr = "<Interface WSID=""b6ec361f-b577-4c3f-a2d2-9b686b265f31""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,GET����ʵ��,B02_Bill.FNP_PayApply��" & _
        "����������,����,��ҵ��,���뵥ID,���뵥���,�����ƻ�GUID,��Ӧ��GUID,���뵥����,����ˮ����,�����ܽ��,����ٷֱ�,Ӧ������,�Ƿ��Ѹ���,������,����ʱ��,����޸���,����޸�ʱ��,�޸Ĵ���,��ͬ���,��Ӧ�̱��,������,�����˻�,����SWIFT�š�" & _
        "����������,��W���ж�,��W�������ƻ�GUID������W���ж�,�����½�������W�������ƻ�GUID," & CombGUID & "/��</ConditionStr></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub

        XMLStr = GetWsrrRlt(XMLStr)

        Msg "FORM", vbCritical, "", "", XMLStr
        Exit Sub
        '��XML��ʽת��Ϊ�����б����Ҫ���XML��ʽ
        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("PayDHList")))
        
        CreateTableForXML "PayDHList", XMLStr, "ROOT", "�������뵥", "A9"
        If GetRowId("PayDHList", "MAX") <> GetRowId("PayDHList", "MIN") Then _
        DeleteRows "�������뵥", GetRowId("PayDHList", "MIN") & ":" & GetRowId("PayDHList", "MIN")

        SetFormat_PayDHList_All
        Sheets("�������뵥").Activate
        CurRow = Selection.Row
        SetValueByHead "PayDHList", CurRow + 1, "����", "I"
        'ProtectSheetWithEnableAllowFiltering "�������뵥", True
        
        Sheets("�������뵥").Range("D7").Select
        SetValueByName "�������뵥_Change", "0"
N:
    ScreenUpdate True
End Sub
Sub DHtoRecDetails()
    Dim ReRow As Long, DHId As String, XMLStr As String, RecDetGUID As String
    
    ScreenUpdate False
    ProtectSheet "�ջ���ϸ", False
    ProtectSheet "�����ƻ�", False
    SetValueByName "�ջ���ϸ_Change", "1"
    
    If TableIsExists("�����ƻ�") = True Then
        If CheckSelectionInTable("DeliveryPlan2List", True) = False Then GoTo N
        ReRow = Selection.Row
        DHId = GetValueByHead("DeliveryPlan2List", ReRow, "�����ƻ�ID")     '��ȡ�����ƻ�ID
        
        XMLStr = "<Interface WSID=""e77c9315-4ae9-442a-a2c6-7c1af2c31f31""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,GET����ʵ��,B02_Bill.PRBD_ReceiveDetail��" & _
        "����������,�����ƻ�ID,�����ƻ���ϸID,��ƷID,�ջ�������ID,��Ӧ�̿��,��Ӧ����ɫ,�ջ�������,��Ӧ�̳���,���,��ɫ,����,��λ,��λ����," & _
        "�ƻ�������������,�ƻ�����������,�ɹ�ԭ�Ҽ�,�ɹ����Ҽ�,���Ƽ�,�ƻ���������,�ջ�����,���ID,��Ӧ�̱�š�" & _
        "����������,��W���ջ������,��W�������ƻ�����ID������W���ջ������,������W�������ƻ�����ID," & DHId & "��</ConditionStr></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        XMLStr = GetWsrrRlt(XMLStr)

        Sheets("�ջ���ϸ").Activate
        ClearTable "RecDetailsList"
        ClearTable "ReceiptMDList"
        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("")))
        CreateTableForXML "RecDetailsList", XMLStr, "ROOT", "�ջ���ϸ", "A9"
        If GetRowId("RecDetailsList", "MAX") <> GetRowId("RecDetailsList", "MIN") Then _
        DeleteRows "�ջ���ϸ", GetRowId("RecDetailsList", "MIN") & ":" & GetRowId("RecDetailsList", "MIN")
        ReplaceTableHead "RecDetailsList", GetHeadMap("RecDetailsList")
        RecDetGUID = Mid$(CreateObject("Scriptlet.TypeLib").Guid, 2, 36)
'        ReRow = GetTableRowId("RecDetailsList", 1)
        For I = GetTableRowId("RecDetailsList", 1) To GetTableRowId("RecDetailsList", -1)
            ReRow = I
            If Cells(I, 1) = Empty Then
                SetValueByHead "RecDetailsList", ReRow, "����", "I"
                SetValueByHead "RecDetailsList", ReRow, "�ջ�������GUID", RecDetGUID
            End If
        Next
'        Sheets("�ջ���ϸ").CommandButton1.Enabled = True
'        Sheets("�ջ���ϸ").CommandButton2.Enabled = True
'        Sheets("�ջ���ϸ").CommandButton3.Enabled = True
    Else: MsgBox "���ȼ��ء������ƻ��������ݣ�лл�� "
        GoTo N
    End If
N:
    ProtectSheet "�ջ���ϸ", False
    ProtectSheet "�����ƻ�", False
    SetValueByName "�ջ���ϸ_Change", "0"
    ScreenUpdate False
End Sub

