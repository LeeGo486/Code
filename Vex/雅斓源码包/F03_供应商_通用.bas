Attribute VB_Name = "F03_供应商_通用"
Function SetFormat_SupplyList_All()
    
    '将Main表B2单元个的字体样式复制到SupplyList表中
    CopyCellFontFormat "Main", "B2", Range("SupplyList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "SupplyList", GetHeadMap("SupplyList")
    '关闭自动筛选功能
    Range("Supplylist[#headers]").AutoFilter
    '表体自适应格式
    Range("SupplyList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
  HideTableColumns "SupplyList", "【SU0_CONO】【SU0_DIVI】【SU0_SupplierId】【SU0_SupplierType】【SU0_RgDt】【SU0_LmDt】", True
    
    '冻结窗口
'    FreezeCell "供应商", "H10", False
    Rows("10:10").Select
    ActiveWindow.FreezePanes = True
    '设置可编辑区域
    AddEditRangeByHead "SupplyList", 0, GetEditColumnsName("SupplyList")
    '设置下拉菜单
    SetValidationStr Range("SupplyList[[供应商分类]]"), "=基础!$E$7:$E$" & GetRowId("GYSFLList", "MAX")
End Function

Function SetFormat_SupplyList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("供应商").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("SupplyList", rw.Row, "操作")
        str2 = GetValueByHead("SupplyList", rw.Row, "供应商编号")
        CurRow = Selection.Row
        If Str1 = "I" Then
            AddEditRangeByHead "SupplyList", CurRow, "【新建供应商简称】" & "【新建供应商全称】" & GetEditColumnsName("SupplyList")
        End If
    Next
End Function

Function 供应商_Change(CurRow As Long, Curcol As Long)
Dim LocationStr As String
Dim ColumnName As String
ScreenUpdate False

'限定区域
If IsInTable("SupplyList", CurRow, Curcol) Then
   ColumnName = Sheets("供应商").Cells(GetRowId("SupplyList", "Min") - 1, Curcol).Value
Else
    GoTo N
End If
If ColumnName <> "操作" Then   '如果获取的表头名称不为[操作]
    If GetValueByHead("SupplyList", CurRow, "供应商编号") <> "系统自动生成" And GetValueByHead("SupplyList", CurRow, "供应商编号") <> "" Then     '获取SupplyList的CurRow行、供应商编号的值不为空,不能为系统自动生成
        SetValueByHead "SupplyList", CurRow, "操作", "U"  '将该行的操作字段变为为U
        'SetFormat_ProductList_Line CurRow, CurRow   '根据SProductList_Line设置字段格式
    End If
Else
    GoTo N
End If
N:
ScreenUpdate True
End Function
Function SetFormat_CommandButton_All()
'固定Sheet中按钮的位置与大小
    Sheets("供应商").CommandButton1.Top = 37.5
    Sheets("供应商").CommandButton1.Width = 67.5
    Sheets("供应商").CommandButton1.Left = 1.5
    Sheets("供应商").CommandButton1.Height = 24
    
    Sheets("供应商").CommandButton2.Top = 37.5
    Sheets("供应商").CommandButton2.Width = 67.5
    Sheets("供应商").CommandButton2.Left = 70.5
    Sheets("供应商").CommandButton2.Height = 24
    
End Function

