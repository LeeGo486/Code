Attribute VB_Name = "F22_收货主表_通用"
Function SetFormat_RecDetailsMainList_All()
    
    '将Main表B2单元个的字体样式复制到RecDetailsMainList表中
    CopyCellFontFormat "Main", "B2", Range("RecDetailsMainList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "RecDetailsMainList", GetHeadMap("RecDetailsMainList")
    '关闭自动筛选功能
'    Range("RecDetailsMainList[#headers]").AutoFilter
    '表体自适应格式
    Range("RecDetailsMainList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "RecDetailsMainList", "【集团】【事业体】【到货计划ID】【收货单ID】【状态ID】", True
    
    '冻结窗口
'    FreezeCell "供应商", "G9", False
    '设置可编辑区域
    AddEditRangeByHead "RecDetailsMainList", 0, GetEditColumnsName("RecDetailsMainList")
    '设置下拉菜单
'    SetValidationStr Range("RecDetailsMainList[[申请单类型]]"), "=基础!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function

