Attribute VB_Name = "F05_Ʒ��_ͨ��"
'        -----------by sunyulong 20130819 begin   -----------
Function SetFormat_BrandList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�BrandList����
    CopyCellFontFormat "Main", "B2", Range("BrandList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "BrandList", GetHeadMap("BrandList")
    '�ر��Զ�ɸѡ����
    Range("Brandlist[#headers]").AutoFilter
    '��������Ӧ��ʽ
   Range("BrandList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "BrandList", "��BD0_CONO����BD0_DIVI����BD0_BrandCode����BD0_BrandId����BD0_SU0_SupplierId����BD0_StyleId����BD0_CusGrpId����BD0_Status����BD0_UptNo����SU0_SupplierCode����CountryDictName����StyleDictName����CusGrpDictName��", True
    '���ᴰ��
    'FreezeCell "�½�Ʒ��", "G9", True
    '���ÿɱ༭����
    AddEditRangeByHead "BrandList", 0, GetEditColumnsName("BrandList")
    '���������˵�
    SetValidationStr Range("BrandList[[Ʒ�Ʒ��]]"), "=����!$T$7:$T$" & GetRowId("PPFGList", "MAX")
    SetValidationStr Range("BrandList[[Ŀ��Ⱥ��]]"), "=����!$AI$7:$AI$" & GetRowId("MBQTList", "MAX")
End Function
'        -----------by sunyulong 20130819 end   -----------
Function SetFormat_BrandList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("�½�Ʒ��").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("BrandList", rw.Row, "����")
        str2 = GetValueByHead("BrandList", rw.Row, "��Ӧ�̱��")
        CurRow = Selection.Row
        If Str1 = "I" Then
            SetValidationStr Range("BrandList[[Ʒ�Ʒ��]]"), "=����!$T$7:$T$" & GetRowId("PPFGList", "MAX")
            SetValidationStr Range("BrandList[[Ŀ��Ⱥ��]]"), "=����!$AI$7:$AI$" & GetRowId("MBQTList", "MAX")
            AddEditRangeByHead "BrandList", CurRow, "��Ʒ�����ơ�" & "��Ʒ�����ڹ��ҡ�" & GetEditColumnsName("BrandList")
        End If
    Next
End Function
Function getMBQTGUID(TableName As String, ColName As String, ColValue As String, ReturnColName As String) As String
        
        getMBQTGUID = vbNullString
        For Each cl In Range(TableName & "[[" & ColName & "]]")
            If cl.Value = ColValue Then
                getMBQTGUID = GetValueByHead(TableName, cl.Row, ReturnColName)
                Exit Function
            End If
        Next
End Function

'    Range("BrandsList[[BD0_CusGrpId]]").Value = getMBQTGUID("MBQTList", "DC0_DictName1", Range("BrandsList[[Ŀ��Ⱥ��]]").Value, "DC0_DictId")
Sub SetRangeValueByTableColumn(TableName As String, ColName As String, ColValue As String, ReturnColName As String, ToRange As Range)
        For Each cl In Range(TableName & "[[" & ColName & "]]")
            If cl.Value = ColValue Then
                ToRange.Value = getMBQTGUID(TableName, ColName, ReturnColName)
                Exit Sub
            End If
        Next
End Sub
           
'"Ŀ��Ⱥ��", "MBQTList", "DC0_DictName1", "DC0_DictId"

Sub testMBQT()

 Range("SupplyList[[SU0_SupplierType1]]").Value = getMBQTGUID("GYSFLList", "DC0_DictName1", Range("SupplyList[[��Ӧ�̷���]]").Value, "DC0_DictId")
End Sub
Function SetFormat_BrandsList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("�½�Ʒ��").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("BrandsList", rw.Row, "����")
        str2 = GetValueByHead("BrandsList", rw.Row, "�½�Ʒ�Ʊ��")
        CurRow = Selection.Row
        If Str1 = "I" Then
            AddEditRangeByHead "BrandsList", CurRow, "���½�Ʒ�Ƽ�ơ�" & "���½�Ʒ��ȫ�ơ�" & GetEditColumnsName("BrandsList")
        End If
    Next
End Function

'Function �½�Ʒ��_Change(CurRow As Long, Curcol As Long)
'Dim LocationStr As String
'Dim ColumnName As String
'
'ScreenUpdate False
'
''�޶�����
'If IsInTable("BrandList", CurRow, Curcol) Then
'   ColumnName = Sheets("�½�Ʒ��").Cells(GetRowId("BrandList", "Min") - 1, Curcol).Value
'Else
'    GoTo n
'End If
'
'If ColumnName <> "����" Then   '�����ȡ�ı�ͷ���Ʋ�Ϊ[����]
'    If GetValueByHead("BrandList", CurRow, "BD0_BrandCode") <> "ϵͳ�Զ�����" And GetValueByHead("BrandList", CurRow, "BD0_BrandCode") <> "" Then     '��ȡBrandList��CurRow�С��½�Ʒ�Ʊ�ŵ�ֵ��Ϊ��,����Ϊϵͳ�Զ�����
'        SetValueByHead "BrandList", CurRow, "����", "U"  '�����еĲ����ֶα�ΪΪU
'        'SetFormat_BrandList_Line CurRow, CurRow   '����SBrandList_Line�����ֶθ�ʽ
'    End If
'Else
'    GoTo n
'End If
'n:
'ScreenUpdate True
'End Function
Function SetFormat_CommandButton_All_Brand()
'�̶�Sheet�а�ť��λ�����С
    Sheets("�½�Ʒ��").CommandButton1.Top = 37.5
    Sheets("�½�Ʒ��").CommandButton1.Width = 67.5
    Sheets("�½�Ʒ��").CommandButton1.Left = 1.5
    Sheets("�½�Ʒ��").CommandButton1.Height = 24
    
    Sheets("�½�Ʒ��").CommandButton2.Top = 37.5
    Sheets("�½�Ʒ��").CommandButton2.Width = 67.5
    Sheets("�½�Ʒ��").CommandButton2.Left = 70.5
    Sheets("�½�Ʒ��").CommandButton2.Height = 24
    
End Function

Sub InsertRw()
    Dim CurRow As Long
    InsertLine "�½�Ʒ��", 9, True
    CurRow = Selection.Row
    SetValueByHead "BrandsList", CurRow, "����", "I"
End Sub
Sub GetSno()
    Dim sno As String
    
N:  ProtectSheetWithEnableAllowFiltering "��Ӧ��", True
End Sub


