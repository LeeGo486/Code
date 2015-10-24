Attribute VB_Name = "F05_品牌_通用"
'        -----------by sunyulong 20130819 begin   -----------
Function SetFormat_BrandList_All()
    
    '将Main表B2单元个的字体样式复制到BrandList表中
    CopyCellFontFormat "Main", "B2", Range("BrandList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "BrandList", GetHeadMap("BrandList")
    '关闭自动筛选功能
    Range("Brandlist[#headers]").AutoFilter
    '表体自适应格式
   Range("BrandList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "BrandList", "【BD0_CONO】【BD0_DIVI】【BD0_BrandCode】【BD0_BrandId】【BD0_SU0_SupplierId】【BD0_StyleId】【BD0_CusGrpId】【BD0_Status】【BD0_UptNo】【SU0_SupplierCode】【CountryDictName】【StyleDictName】【CusGrpDictName】", True
    '冻结窗口
    'FreezeCell "新建品牌", "G9", True
    '设置可编辑区域
    AddEditRangeByHead "BrandList", 0, GetEditColumnsName("BrandList")
    '设置下拉菜单
    SetValidationStr Range("BrandList[[品牌风格]]"), "=基础!$T$7:$T$" & GetRowId("PPFGList", "MAX")
    SetValidationStr Range("BrandList[[目标群体]]"), "=基础!$AI$7:$AI$" & GetRowId("MBQTList", "MAX")
End Function
'        -----------by sunyulong 20130819 end   -----------
Function SetFormat_BrandList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("新建品牌").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("BrandList", rw.Row, "操作")
        str2 = GetValueByHead("BrandList", rw.Row, "供应商编号")
        CurRow = Selection.Row
        If Str1 = "I" Then
            SetValidationStr Range("BrandList[[品牌风格]]"), "=基础!$T$7:$T$" & GetRowId("PPFGList", "MAX")
            SetValidationStr Range("BrandList[[目标群体]]"), "=基础!$AI$7:$AI$" & GetRowId("MBQTList", "MAX")
            AddEditRangeByHead "BrandList", CurRow, "【品牌名称】" & "【品牌所在国家】" & GetEditColumnsName("BrandList")
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

'    Range("BrandsList[[BD0_CusGrpId]]").Value = getMBQTGUID("MBQTList", "DC0_DictName1", Range("BrandsList[[目标群体]]").Value, "DC0_DictId")
Sub SetRangeValueByTableColumn(TableName As String, ColName As String, ColValue As String, ReturnColName As String, ToRange As Range)
        For Each cl In Range(TableName & "[[" & ColName & "]]")
            If cl.Value = ColValue Then
                ToRange.Value = getMBQTGUID(TableName, ColName, ReturnColName)
                Exit Sub
            End If
        Next
End Sub
           
'"目标群体", "MBQTList", "DC0_DictName1", "DC0_DictId"

Sub testMBQT()

 Range("SupplyList[[SU0_SupplierType1]]").Value = getMBQTGUID("GYSFLList", "DC0_DictName1", Range("SupplyList[[供应商分类]]").Value, "DC0_DictId")
End Sub
Function SetFormat_BrandsList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("新建品牌").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("BrandsList", rw.Row, "操作")
        str2 = GetValueByHead("BrandsList", rw.Row, "新建品牌编号")
        CurRow = Selection.Row
        If Str1 = "I" Then
            AddEditRangeByHead "BrandsList", CurRow, "【新建品牌简称】" & "【新建品牌全称】" & GetEditColumnsName("BrandsList")
        End If
    Next
End Function

'Function 新建品牌_Change(CurRow As Long, Curcol As Long)
'Dim LocationStr As String
'Dim ColumnName As String
'
'ScreenUpdate False
'
''限定区域
'If IsInTable("BrandList", CurRow, Curcol) Then
'   ColumnName = Sheets("新建品牌").Cells(GetRowId("BrandList", "Min") - 1, Curcol).Value
'Else
'    GoTo n
'End If
'
'If ColumnName <> "操作" Then   '如果获取的表头名称不为[操作]
'    If GetValueByHead("BrandList", CurRow, "BD0_BrandCode") <> "系统自动生成" And GetValueByHead("BrandList", CurRow, "BD0_BrandCode") <> "" Then     '获取BrandList的CurRow行、新建品牌编号的值不为空,不能为系统自动生成
'        SetValueByHead "BrandList", CurRow, "操作", "U"  '将该行的操作字段变为为U
'        'SetFormat_BrandList_Line CurRow, CurRow   '根据SBrandList_Line设置字段格式
'    End If
'Else
'    GoTo n
'End If
'n:
'ScreenUpdate True
'End Function
Function SetFormat_CommandButton_All_Brand()
'固定Sheet中按钮的位置与大小
    Sheets("新建品牌").CommandButton1.Top = 37.5
    Sheets("新建品牌").CommandButton1.Width = 67.5
    Sheets("新建品牌").CommandButton1.Left = 1.5
    Sheets("新建品牌").CommandButton1.Height = 24
    
    Sheets("新建品牌").CommandButton2.Top = 37.5
    Sheets("新建品牌").CommandButton2.Width = 67.5
    Sheets("新建品牌").CommandButton2.Left = 70.5
    Sheets("新建品牌").CommandButton2.Height = 24
    
End Function

Sub InsertRw()
    Dim CurRow As Long
    InsertLine "新建品牌", 9, True
    CurRow = Selection.Row
    SetValueByHead "BrandsList", CurRow, "操作", "I"
End Sub
Sub GetSno()
    Dim sno As String
    
N:  ProtectSheetWithEnableAllowFiltering "供应商", True
End Sub


