Attribute VB_Name = "F15_�������뵥_ͨ��"
Function SetFormat_PayList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�PayList����
    CopyCellFontFormat "Main", "B2", Range("PayList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "PayList", GetHeadMap("PayList")
    '�ر��Զ�ɸѡ����
'    Range("PayList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("PayList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "PayList", "��FNP_CONO����FNP_DIVI�������뵥ID������Ӧ��GUID�������뵥���͡���FNP_Status��", True
    
    '���ᴰ��
    FreezeCell "��Ӧ��", "G9", False
    '���ÿɱ༭����
    AddEditRangeByHead "PayList", 0, GetEditColumnsName("PayList")
    '���������˵�
'    SetValidationStr Range("PayList[[���뵥����]]"), "=����!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function SetFormat_PayMXList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�PayMXList����
    CopyCellFontFormat "Main", "B2", Range("PayMXList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "PayMXList", GetHeadMap("PayMXList")
    '�ر��Զ�ɸѡ����
'    Range("PayMXList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("PayMXList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
'  HideTableColumns "PayMXList", "��SU0_CONO����SU0_DIVI����SU0_SupplierId����SU0_SupplierType����SU0_RgDt����SU0_LmDt��", True
    
    '���ᴰ��
    FreezeCell "��Ӧ��", "G9", False
    '���ÿɱ༭����
    AddEditRangeByHead "PayMXList", 0, GetEditColumnsName("PayMXList")
    '���������˵�
'    SetValidationStr Range("PayMXList[[���뵥����]]"), "=����!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function SetFormat_PayDHMXList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�PayDHMXList����
    CopyCellFontFormat "Main", "B2", Range("PayDHMXList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "PayDHMXList", GetHeadMap("PayDHMXList")
    '�ر��Զ�ɸѡ����
'    Range("PayDHMXList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("PayDHMXList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
'  HideTableColumns "PayDHMXList", "��SU0_CONO����SU0_DIVI����SU0_SupplierId����SU0_SupplierType����SU0_RgDt����SU0_LmDt��", True
    
    '���ᴰ��
    FreezeCell "��Ӧ��", "G9", False
    '���ÿɱ༭����
    AddEditRangeByHead "PayDHMXList", 0, GetEditColumnsName("PayDHMXList")
    '���������˵�
'    SetValidationStr Range("PayDHMXList[[���뵥����]]"), "=����!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function SetFormat_PayTHMXList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�PayTHMXList����
    CopyCellFontFormat "Main", "B2", Range("PayTHMXList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "PayTHMXList", GetHeadMap("PayTHMXList")
    '�ر��Զ�ɸѡ����
'    Range("PayTHMXList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("PayTHMXList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
'  HideTableColumns "PayTHMXList", "��SU0_CONO����SU0_DIVI����SU0_SupplierId����SU0_SupplierType����SU0_RgDt����SU0_LmDt��", True
    
    '���ᴰ��
    FreezeCell "��Ӧ��", "G9", False
    '���ÿɱ༭����
    AddEditRangeByHead "PayTHMXList", 0, GetEditColumnsName("PayTHMXList")
    '���������˵�
'    SetValidationStr Range("PayTHMXList[[���뵥����]]"), "=����!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function SetFormat_PayList2_GS()
'   �÷����Ĺ��ܣ����ڽ�ǰ̨�������ֶ�ת�����ϴ�XML��Ҫ���ֶ�
    Dim A As String
    Dim B As String
    Dim rw As Long
'    �ж����뵥����
    rw = Selection.Row
    If GetValueByHead("PayList", rw, "���״̬") <> "" Then
        A = GetValueByHead("PayList", rw, "���״̬")
        
        For Each cl In Range("StatusList[[DC0_DictName1]]")
            If cl.Value = A Then
            B = GetValueByHead("StatusList", cl.Row, "DC0_DictId")
            End If
            SetValueByHead "PayList", rw, "FNP_Status", B
        Next
    Else: MsgBox "�������뵥״̬�Ƿ���ȷ��", vbCritical, "��ʾ"
        GoTo N
    End If
    
N:
    ProtectSheetWithEnableAllowFiltering "�������뵥", True
End Function
Function �������뵥_Change(CurRow As Long, Curcol As Long)
Dim LocationStr As String
Dim ColumnName As String
ScreenUpdate False

'�޶�����
If IsInTable("PayList", CurRow, Curcol) Then
   ColumnName = Sheets("�������뵥").Cells(GetRowId("PayList", "Min") - 1, Curcol).Value
Else
    GoTo N
End If
If ColumnName <> "����" Then   '�����ȡ�ı�ͷ���Ʋ�Ϊ[����]
    If GetValueByHead("PayList", CurRow, "����ʱ��") <> "ϵͳ�Զ�����" And GetValueByHead("PayList", CurRow, "����ʱ��") <> "" Then     '��ȡPayList��CurRow�С���Ӧ�̱�ŵ�ֵ��Ϊ��,����Ϊϵͳ�Զ�����
        SetValueByHead "PayList", CurRow, "����", "U"  '�����еĲ����ֶα�ΪΪU
'        SetFormat_PayList_Line CurRow, CurRow   '����PayList_Line�����ֶθ�ʽ
    End If
Else
    GoTo N
End If
N:
ScreenUpdate True
End Function
'        -----------by sunyulong 20130814 end   -----------
Function SetSaveValue()

    Dim selectItemPD0_SUO_SupplierId As String, selectItemPD0_YearId As String, selectItemPD0_SeasonId As String, selectItemPD0_Lvl1 As String, selectItemPD0_Lvl2 As String
    Dim dictIdPD0_SUO_SupplierId As String, dictIdPD0_YearId As String, dictIdPD0_SeasonId As String, dictIdPD0_Lvl1 As String, dictIdPD0_Lvl2 As String
    
'    Dim selectItemPD0_ColorSUId As String, selectItemPD0_SizeSUId As String, selectItemPD0_ColorId As String, selectItemPD0_SizeId As String, selectItemPD0_StandardId As String, selectItemPD0_SecurityLevelId As String
'    Dim dictIdPD0_ColorSUId As String, dictIdPD0_SizeSUId As String, dictIdPD0_ColorId As String, dictIdPD0_SizeId As String, dictIdPD0_StandardId  As String, dictIdPD0_SecurityLevelId As String
    
    CurRow = Selection.Row
    
     '���ù�Ӧ�̱�ŵ�������ȡֵ
    selectItemPD0_SUO_SupplierId = GetValueByHead("PayNewList", CurRow, "��Ӧ�̱��")
    dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "��Ӧ�̱��", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
    SetValueByHead "PayNewList", CurRow, "PD0_SUO_SupplierId", dictIdPD0_SUO_SupplierId
    
End Function


