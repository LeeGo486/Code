Attribute VB_Name = "F15_付款申请单_通用"
Function SetFormat_PayList_All()
    
    '将Main表B2单元个的字体样式复制到PayList表中
    CopyCellFontFormat "Main", "B2", Range("PayList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PayList", GetHeadMap("PayList")
    '关闭自动筛选功能
'    Range("PayList[#headers]").AutoFilter
    '表体自适应格式
    Range("PayList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "PayList", "【FNP_CONO】【FNP_DIVI】【申请单ID】【供应商GUID】【申请单类型】【FNP_Status】", True
    
    '冻结窗口
    FreezeCell "供应商", "G9", False
    '设置可编辑区域
    AddEditRangeByHead "PayList", 0, GetEditColumnsName("PayList")
    '设置下拉菜单
'    SetValidationStr Range("PayList[[申请单类型]]"), "=基础!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function SetFormat_PayMXList_All()
    
    '将Main表B2单元个的字体样式复制到PayMXList表中
    CopyCellFontFormat "Main", "B2", Range("PayMXList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PayMXList", GetHeadMap("PayMXList")
    '关闭自动筛选功能
'    Range("PayMXList[#headers]").AutoFilter
    '表体自适应格式
    Range("PayMXList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
'  HideTableColumns "PayMXList", "【SU0_CONO】【SU0_DIVI】【SU0_SupplierId】【SU0_SupplierType】【SU0_RgDt】【SU0_LmDt】", True
    
    '冻结窗口
    FreezeCell "供应商", "G9", False
    '设置可编辑区域
    AddEditRangeByHead "PayMXList", 0, GetEditColumnsName("PayMXList")
    '设置下拉菜单
'    SetValidationStr Range("PayMXList[[申请单类型]]"), "=基础!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function SetFormat_PayDHMXList_All()
    
    '将Main表B2单元个的字体样式复制到PayDHMXList表中
    CopyCellFontFormat "Main", "B2", Range("PayDHMXList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PayDHMXList", GetHeadMap("PayDHMXList")
    '关闭自动筛选功能
'    Range("PayDHMXList[#headers]").AutoFilter
    '表体自适应格式
    Range("PayDHMXList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
'  HideTableColumns "PayDHMXList", "【SU0_CONO】【SU0_DIVI】【SU0_SupplierId】【SU0_SupplierType】【SU0_RgDt】【SU0_LmDt】", True
    
    '冻结窗口
    FreezeCell "供应商", "G9", False
    '设置可编辑区域
    AddEditRangeByHead "PayDHMXList", 0, GetEditColumnsName("PayDHMXList")
    '设置下拉菜单
'    SetValidationStr Range("PayDHMXList[[申请单类型]]"), "=基础!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function SetFormat_PayTHMXList_All()
    
    '将Main表B2单元个的字体样式复制到PayTHMXList表中
    CopyCellFontFormat "Main", "B2", Range("PayTHMXList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PayTHMXList", GetHeadMap("PayTHMXList")
    '关闭自动筛选功能
'    Range("PayTHMXList[#headers]").AutoFilter
    '表体自适应格式
    Range("PayTHMXList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
'  HideTableColumns "PayTHMXList", "【SU0_CONO】【SU0_DIVI】【SU0_SupplierId】【SU0_SupplierType】【SU0_RgDt】【SU0_LmDt】", True
    
    '冻结窗口
    FreezeCell "供应商", "G9", False
    '设置可编辑区域
    AddEditRangeByHead "PayTHMXList", 0, GetEditColumnsName("PayTHMXList")
    '设置下拉菜单
'    SetValidationStr Range("PayTHMXList[[申请单类型]]"), "=基础!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function SetFormat_PayList2_GS()
'   该方法的功能：用于将前台操作的字段转换成上传XML需要的字段
    Dim A As String
    Dim B As String
    Dim rw As Long
'    判断申请单类型
    rw = Selection.Row
    If GetValueByHead("PayList", rw, "付款单状态") <> "" Then
        A = GetValueByHead("PayList", rw, "付款单状态")
        
        For Each cl In Range("StatusList[[DC0_DictName1]]")
            If cl.Value = A Then
            B = GetValueByHead("StatusList", cl.Row, "DC0_DictId")
            End If
            SetValueByHead "PayList", rw, "FNP_Status", B
        Next
    Else: MsgBox "请检查申请单状态是否正确！", vbCritical, "提示"
        GoTo N
    End If
    
N:
    ProtectSheetWithEnableAllowFiltering "付款申请单", True
End Function
Function 付款申请单_Change(CurRow As Long, Curcol As Long)
Dim LocationStr As String
Dim ColumnName As String
ScreenUpdate False

'限定区域
If IsInTable("PayList", CurRow, Curcol) Then
   ColumnName = Sheets("付款申请单").Cells(GetRowId("PayList", "Min") - 1, Curcol).Value
Else
    GoTo N
End If
If ColumnName <> "操作" Then   '如果获取的表头名称不为[操作]
    If GetValueByHead("PayList", CurRow, "创建时间") <> "系统自动生成" And GetValueByHead("PayList", CurRow, "创建时间") <> "" Then     '获取PayList的CurRow行、供应商编号的值不为空,不能为系统自动生成
        SetValueByHead "PayList", CurRow, "操作", "U"  '将该行的操作字段变为为U
'        SetFormat_PayList_Line CurRow, CurRow   '根据PayList_Line设置字段格式
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
    
     '设置供应商编号的下拉和取值
    selectItemPD0_SUO_SupplierId = GetValueByHead("PayNewList", CurRow, "供应商编号")
    dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
    SetValueByHead "PayNewList", CurRow, "PD0_SUO_SupplierId", dictIdPD0_SUO_SupplierId
    
End Function


