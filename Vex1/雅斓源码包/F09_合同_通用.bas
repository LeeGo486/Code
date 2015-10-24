Attribute VB_Name = "F09_��ͬ_ͨ��"
Function SetFormat_ContractList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�ProductList����
    CopyCellFontFormat "Main", "B2", Range("ContractList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "ContractList", GetHeadMap("ContractList")
    '�ر��Զ�ɸѡ����
    Range("ContractList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("ContractList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "ContractList", "�����š�����ҵ�塿���ܼ���ˡ����ܼ����ʱ�䡿���ܼ����״̬������ͬID������Ӧ�̱��ID����״̬ID�����������ID�������㷽ʽID��" & _
    "��������ˡ����������ʱ�䡿���������״̬����������ˡ����������ʱ�䡿���������״̬�������ܲ���ˡ������ܲ����ʱ�䡿�����ܲ����״̬��" & _
    "������ˮ����������ˮ��ʱ�䡿������ˮ��״̬����PR0_StartDate1����WFP_AFID1����WFP_AFID2����WFP_AFID3����WFP_AFID4����WFP_AFID5��", True
    '���ᴰ��HideTableColumns "ProductList", "��������" & GetHeadMap("ProductList"), False
'    FreezeCell "��ͬ", "K9", True
    '���ÿɱ༭����
    AddEditRangeByHead "ContractList", 0, GetEditColumnsName("ContractList")
   
End Function
Function SetFormat_ContractList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("��ͬ").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("ContractList", rw.Row, "����")
        str2 = GetValueByHead("ContractList", rw.Row, "��ͬ���")
        CurRow = Selection.Row
        If Str1 = "I" Then
            AddEditRangeByHead "ContractList", CurRow, "���½���ͬ��ơ�" & "���½���ͬȫ�ơ�" & GetEditColumnsName("ContractList")
        End If
    Next
End Function
 Function SetFormat_ContractNewList_All()
    
    CopyCellFontFormat "Main", "B2", Range("ContractNewList[#ALL]")
    ReplaceTableHead "ContractNewList", GetHeadMap("ContractNewList")
    Range("ContractNewList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
'    HideTableColumns "ContractNewList", "��PR0_CONO����PR0_DIVI����PR0_ContractId����PR0_SU0_SupplierId����PR0_CurrencyId����CurrencyDictName����PR0_Status��", True
    FreezeCell "��ͬ", "K9", False
    '���ÿɱ༭����
    AddEditRangeByHead "ContractNewList", 0, GetEditColumnsName("ContractNewList")
    '���������˵�
     SetValidationStr Range("ContractNewList[[��Ӧ�̱��]]"), "=����!$AW$7:$AW$" & GetRowId("SupplyBASEList", "MAX")
     '��λ���
     Range("B9").Select
End Function
Function SetFormat_PayNewList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�PayNewList����
    CopyCellFontFormat "Main", "B2", Range("PayNewList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "PayNewList", GetHeadMap("PayNewList")
    '�ر��Զ�ɸѡ����
'    Range("PayNewList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("PayNewList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "PayNewList", "��FNP_CONO����FNP_DIVI�������뵥ID������ͬGUID������Ӧ��GUID�������뵥���͡�", True
    
    '���ᴰ��
    FreezeCell "��Ӧ��", "G9", False
    '���ÿɱ༭����
    AddEditRangeByHead "PayNewList", 0, GetEditColumnsName("PayNewList")
    '���������˵�
'    SetValidationStr Range("PayNewList[[���뵥����]]"), "=����!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function Contract_Change(CurRow As Long, Curcol As Long)
    Dim LocationStr As String
    Dim ColumnName As String
    Dim wrksht As Worksheet
    
    ScreenUpdate False
    Set wrksht = ActiveWorkbook.Worksheets("��ͬ")
    '�޶�����
    If TableIsExists("��ͬ") = True Then
        If wrksht.ListObjects(1).Name = "ContractList" Then
'            If CheckSelectionInTable("ContractList", True) = False Then GoTo N
            If IsInTable("ContractList", CurRow, Curcol) Then
                ColumnName = Sheets("��ͬ").Cells(GetRowId("ContractList", "Min") - 1, Curcol).Value
            Else
                GoTo N
            End If
            
            If ColumnName <> "����" Then   '�����ȡ�ı�ͷ���Ʋ�Ϊ[����]
                If GetValueByHead("ContractList", CurRow, "��ͬ״̬") = "δ���" Then
                    SetValueByHead "ContractList", CurRow, "����", "U"  '�����еĲ����ֶα�ΪΪU
                Else
                    GoTo N
                End If
            End If
        End If
    End If
N:
    ScreenUpdate True
End Function
'-------------by liuhong 20130817 end ---------------


