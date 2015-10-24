Attribute VB_Name = "F11_采购单_通用"
Function SetFormat_PurchaseOrderList_All()
    
    '将Main表B2单元个的字体样式复制到ProductList表中
    CopyCellFontFormat "Main", "B2", Range("PurchaseOrderList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PurchaseOrderList", GetHeadMap("PurchaseOrderList")
    '表体自适应格式
    Range("PurchaseOrderList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "PurchaseOrderList", "【集团】【事业体】【采购单ID】【采购单类型ID】【采购类型】【合同编号ID】【供应商编号ID】【品牌编号ID】【供应商类型ID】【状态ID】【PR1_OrderTypeId】【PR1_PR0_ContractId】【PR1_SU0_SupplierId】【PR1_BD0_BrandId】【PR1_CurrencyTypeId】【PR1_Status】", True
    '冻结窗口HideTableColumns "OrderList", "【操作】" & GetHeadMap("OrderList"), False
    'FreezeCell "商品信息", "C9", True
    '设置可编辑区域
    AddEditRangeByHead "PurchaseOrderList", 0, GetEditColumnsName("PurchaseOrderList")
    '设置下拉菜单
End Function
Function SetFormat_NewPurchaseOrderList_All()
    
    '将Main表B2单元个的字体样式复制到ProductList表中
    CopyCellFontFormat "Main", "B2", Range("NewPurchaseOrderList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "NewPurchaseOrderList", GetHeadMap("NewPurchaseOrderList")
    '表体自适应格式
    Range("NewPurchaseOrderList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "NewPurchaseOrderList", "【PR1_CONO】【PR1_DIVI】【PR1_OrderId】【PR1_OrderTypeId】【采购类型】【PR1_PR0_ContractId】【PR1_SU0_SupplierId】【PR1_BD0_BrandId】【PR1_CurrencyTypeId】【PR1_UnitID】【PR1_SupplierType】【PR1_POriginalAmount】【PR1_Status】【PR1_RgDt】【PR1_LmDt】【PR1_UptNo】", True
    '冻结窗口HideTableColumns "OrderList", "【操作】" & GetHeadMap("OrderList"), False
    'FreezeCell "商品信息", "C9", True
    '设置可编辑区域
    AddEditRangeByHead "NewPurchaseOrderList", 0, GetEditColumnsName("NewPurchaseOrderList")
End Function
Function SetFormat_DeliveryPlanList_All()
    
    '将Main表B2单元个的字体样式复制到DeliveryPlanList表中
    CopyCellFontFormat "Main", "B2", Range("DeliveryPlanList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "DeliveryPlanList", GetHeadMap("DeliveryPlanList")
    '关闭自动筛选功能
    Range("DeliveryPlanList[#headers]").AutoFilter
    '表体自适应格式
    Range("DeliveryPlanList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "DeliveryPlanList", "【PR1_CONO】【PR1_DIVI】【到货计划ID】【到货计划编号】【商品ID】【采购单明细ID】【PR1D_UnitID】", True
    
    '冻结窗口
'    FreezeCell "供应商", "H10", True
    '设置可编辑区域
    AddEditRangeByHead "DeliveryPlanList", 0, GetEditColumnsName("DeliveryPlanList")
    '设置下拉菜单
'    SetValidationStr Range("DeliveryPlanList[[供应商分类]]"), "=基础!$E$7:$E$" & GetRowId("GYSFLList", "MAX")
End Function
Function SetFormat_DeliveryPlan2List_All()
    
    '将Main表B2单元个的字体样式复制到DeliveryPlan2List表中
    CopyCellFontFormat "Main", "B2", Range("DeliveryPlan2List[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "DeliveryPlan2List", GetHeadMap("DeliveryPlan2List")
    '关闭自动筛选功能
    Range("DeliveryPlan2List[#headers]").AutoFilter
    '表体自适应格式
    Range("DeliveryPlan2List[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "DeliveryPlan2List", "【PRA_CONO】【PRA_DIVI】【PRA_Status】【到货计划ID】【采购单ID】", True
    
    '冻结窗口
'    FreezeCell "供应商", "H10", True
    '设置可编辑区域
    AddEditRangeByHead "DeliveryPlan2List", 0, GetEditColumnsName("DeliveryPlan2List")
    '设置下拉菜单
'    SetValidationStr Range("DeliveryPlan2List[[供应商分类]]"), "=基础!$E$7:$E$" & GetRowId("GYSFLList", "MAX")
End Function
Function SetFormat_PurchaseOrderList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("采购单").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("PurchaseOrderList", rw.Row, "操作")
        str2 = GetValueByHead("PurchaseOrderList", rw.Row, "采购单编号")
        CurRow = Selection.Row
        If Str1 = "I" Then
            AddEditRangeByHead "PurchaseOrderList", CurRow, "【新建采购单简称】" & "【新建采购单全称】" & GetEditColumnsName("PurchaseOrderList")
        End If
    Next
End Function
