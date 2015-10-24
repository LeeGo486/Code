Attribute VB_Name = "F24_退货主表_通用"
Function SetFormat_PayTHList_All()
    
    '将Main表B2单元个的字体样式复制到PayTHList表中
    CopyCellFontFormat "Main", "B2", Range("PayTHList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PayTHList", GetHeadMap("PayTHList")
    '关闭自动筛选功能
'    Range("PayTHList[#headers]").AutoFilter
    '表体自适应格式
    Range("PayTHList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "PayTHList", "【FNP_CONO】【FNP_DIVI】【申请单ID】【退货单主表ID】【供应商ID】【申请单类型】", True
    
    '冻结窗口
    FreezeCell "供应商", "G9", False
    '设置可编辑区域
    AddEditRangeByHead "PayTHList", 0, GetEditColumnsName("PayTHList")
    '设置下拉菜单
'    SetValidationStr Range("PayTHList[[申请单类型]]"), "=基础!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
