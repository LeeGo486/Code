Attribute VB_Name = "F17_到货计划_通用"
Function SetFormat_DeliveryPlanMXList_All()
    
    '将Main表B2单元个的字体样式复制到DeliveryPlanMXList表中
    CopyCellFontFormat "Main", "B2", Range("DeliveryPlanMXList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "DeliveryPlanMXList", GetHeadMap("DeliveryPlanMXList")
    '关闭自动筛选功能
    Range("DeliveryPlanMXList[#headers]").AutoFilter
    '表体自适应格式
    Range("DeliveryPlanMXList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "DeliveryPlanMXList", "【PRAD_CONO】【PRAD_DIVI】【到货计划ID】【PRAD_Status】【状态】【到货计划明细ID】【到货计划主表ID】【商品ID】【PRAD_UnitID】【采购单明细ID】 ", True
    
     '重新设定列的验证
    Sheets("到货计划明细").Columns("S:S").Select
    Selection.NumberFormatLocal = "0_ "
    With Selection.Validation
        .Delete
        .Add Type:=xlValidateWholeNumber, AlertStyle:=xlValidAlertStop, _
        Operator:=xlGreaterEqual, Formula1:="0"
        .IgnoreBlank = True
        .InCellDropdown = True
        .InputTitle = ""
        .ErrorTitle = ""
        .InputMessage = ""
        .ErrorMessage = "输入的内容必须为大于0的整数"
        .IMEMode = xlIMEModeNoControl
        .ShowInput = True
        .ShowError = True
    End With
    
    '冻结窗口
'    FreezeCell "供应商", "H10", True
    '设置可编辑区域
    AddEditRangeByHead "DeliveryPlanMXList", 0, GetEditColumnsName("DeliveryPlanMXList")
    '设置下拉菜单
'    SetValidationStr Range("DeliveryPlanMXList[[供应商分类]]"), "=基础!$E$7:$E$" & GetRowId("GYSFLList", "MAX")
End Function
Function SetFormat_PayDHList_All()
    
    '将Main表B2单元个的字体样式复制到PayDHList表中
    CopyCellFontFormat "Main", "B2", Range("PayDHList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PayDHList", GetHeadMap("PayDHList")
    '关闭自动筛选功能
'    Range("PayDHList[#headers]").AutoFilter
    '表体自适应格式
    Range("PayDHList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "PayDHList", "【DC0_CONO】【DC0_DIVI】【申请单ID】【到货计划GUID】【供应商GUID】【SU0_LmDt】", True
    
    '冻结窗口
    FreezeCell "供应商", "G9", False
    '设置可编辑区域
    AddEditRangeByHead "PayDHList", 0, GetEditColumnsName("PayDHList")
    '设置下拉菜单
'    SetValidationStr Range("PayDHList[[申请单类型]]"), "=基础!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
