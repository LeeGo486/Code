Attribute VB_Name = "F09_合同_通用"
Function SetFormat_ContractList_All()
    
    '将Main表B2单元个的字体样式复制到ProductList表中
    CopyCellFontFormat "Main", "B2", Range("ContractList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "ContractList", GetHeadMap("ContractList")
    '关闭自动筛选功能
    Range("ContractList[#headers]").AutoFilter
    '表体自适应格式
    Range("ContractList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "ContractList", "【集团】【事业体】【总监审核】【总监审核时间】【总监审核状态】【合同ID】【供应商编号ID】【状态ID】【结算币种ID】【结算方式ID】" & _
    "【法务审核】【法务审核时间】【法务审核状态】【财务审核】【财务审核时间】【财务审核状态】【副总裁审核】【副总裁审核时间】【副总裁审核状态】" & _
    "【财务水单】【财务水单时间】【财务水单状态】【PR0_StartDate1】【WFP_AFID1】【WFP_AFID2】【WFP_AFID3】【WFP_AFID4】【WFP_AFID5】", True
    '冻结窗口HideTableColumns "ProductList", "【操作】" & GetHeadMap("ProductList"), False
'    FreezeCell "合同", "K9", True
    '设置可编辑区域
    AddEditRangeByHead "ContractList", 0, GetEditColumnsName("ContractList")
   
End Function
Function SetFormat_ContractList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("合同").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("ContractList", rw.Row, "操作")
        str2 = GetValueByHead("ContractList", rw.Row, "合同编号")
        CurRow = Selection.Row
        If Str1 = "I" Then
            AddEditRangeByHead "ContractList", CurRow, "【新建合同简称】" & "【新建合同全称】" & GetEditColumnsName("ContractList")
        End If
    Next
End Function
 Function SetFormat_ContractNewList_All()
    
    CopyCellFontFormat "Main", "B2", Range("ContractNewList[#ALL]")
    ReplaceTableHead "ContractNewList", GetHeadMap("ContractNewList")
    Range("ContractNewList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
'    HideTableColumns "ContractNewList", "【PR0_CONO】【PR0_DIVI】【PR0_ContractId】【PR0_SU0_SupplierId】【PR0_CurrencyId】【CurrencyDictName】【PR0_Status】", True
    FreezeCell "合同", "K9", False
    '设置可编辑区域
    AddEditRangeByHead "ContractNewList", 0, GetEditColumnsName("ContractNewList")
    '设置下拉菜单
     SetValidationStr Range("ContractNewList[[供应商编号]]"), "=基础!$AW$7:$AW$" & GetRowId("SupplyBASEList", "MAX")
     '定位光标
     Range("B9").Select
End Function
Function SetFormat_PayNewList_All()
    
    '将Main表B2单元个的字体样式复制到PayNewList表中
    CopyCellFontFormat "Main", "B2", Range("PayNewList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PayNewList", GetHeadMap("PayNewList")
    '关闭自动筛选功能
'    Range("PayNewList[#headers]").AutoFilter
    '表体自适应格式
    Range("PayNewList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "PayNewList", "【FNP_CONO】【FNP_DIVI】【申请单ID】【合同GUID】【供应商GUID】【申请单类型】", True
    
    '冻结窗口
    FreezeCell "供应商", "G9", False
    '设置可编辑区域
    AddEditRangeByHead "PayNewList", 0, GetEditColumnsName("PayNewList")
    '设置下拉菜单
'    SetValidationStr Range("PayNewList[[申请单类型]]"), "=基础!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
Function Contract_Change(CurRow As Long, Curcol As Long)
    Dim LocationStr As String
    Dim ColumnName As String
    Dim wrksht As Worksheet
    
    ScreenUpdate False
    Set wrksht = ActiveWorkbook.Worksheets("合同")
    '限定区域
    If TableIsExists("合同") = True Then
        If wrksht.ListObjects(1).Name = "ContractList" Then
'            If CheckSelectionInTable("ContractList", True) = False Then GoTo N
            If IsInTable("ContractList", CurRow, Curcol) Then
                ColumnName = Sheets("合同").Cells(GetRowId("ContractList", "Min") - 1, Curcol).Value
            Else
                GoTo N
            End If
            
            If ColumnName <> "操作" Then   '如果获取的表头名称不为[操作]
                If GetValueByHead("ContractList", CurRow, "合同状态") = "未审核" Then
                    SetValueByHead "ContractList", CurRow, "操作", "U"  '将该行的操作字段变为为U
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


