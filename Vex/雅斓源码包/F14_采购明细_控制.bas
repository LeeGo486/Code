Attribute VB_Name = "F14_采购明细_控制"
Sub PODetail_Load()
    Dim XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    SetValueByName "PODetail_Change", "1"
        ClearTable "PODetailList"
        ClearTable "NewPODetailList"
         XMLStr = "<Interface WSID=""0b6f9fcf-fdfa-4012-84ea-b7de4a1656da""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition></Condition></Row></LIST>" & _
        "</ROOT></xml></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        XMLStr = GetWsrrRlt(XMLStr)

        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PODetailList")))
        CreateTableForXML "PODetailList", XMLStr, "ROOT", "采购单明细", "A8"
        If GetRowId("PODetailList", "MAX") <> GetRowId("PODetailList", "MIN") Then _
        DeleteRows "采购单明细", GetRowId("PODetailList", "MIN") & ":" & GetRowId("PODetailList", "MIN")
        SetFormat_PODetailList_All

N:
    ProtectSheetWithEnableAllowFiltering "采购单", False
    SetValueByName "PODetail_Change", "0"
    ScreenUpdate True
End Sub

Sub PODetail_CreateSplit()      '采购明细新建插入
    Dim PORow As Long, wrksht As Worksheet
    Dim CoNo As String, DIVI As String, POId As String, POCode As String, SupplyCode As String, SupplyType As String, POStatus As String
    Dim SendDate As String, Seq As String, RgUser As String, ContractCode As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单明细", False
    SetValueByName "PODetail_Change", "1"
    Set wrksht = ActiveWorkbook.Worksheets("采购单明细")
    If wrksht.ListObjects(1).Name = "PODetailList" Then
        If CheckSelectionInTable("PODetailList", True) = False Then GoTo N
        PORow = Selection.Row
        
        CoNo = GetValueByHead("PODetailList", PORow, "集团")    '集团
        DIVI = GetValueByHead("PODetailList", PORow, "事业体")    '事业体
        POId = GetValueByHead("PODetailList", PORow, "采购单编号GUID")    '采购单GUID
        POCode = GetValueByHead("PODetailList", PORow, "采购单编号")  '采购单编号
        SupplyCode = GetValueByHead("PODetailList", PORow, "供应商编号")  '供应商编号
        SupplyType = GetValueByHead("PODetailList", PORow, "供应商类型")  '供应商类型
        POStatus = GetValueByHead("PODetailList", PORow, "采购单状态") '采购单状态
        SendDate = GetValueByHead("PODetailList", PORow, "预计出货日期") '预计发货日期
        Seq = GetValueByHead("PODetailList", PORow, "序号")     '序号
        RgUser = GetValueByHead("PODetailList", PORow, "创建人")  '创建人
        
        InsertLine "采购单明细", PORow, True
        
        SetValueByHead "PODetailList", PORow + 1, "操作", "I"
        SetValueByHead "PODetailList", PORow + 1, "集团", CoNo
        SetValueByHead "PODetailList", PORow + 1, "事业体", DIVI
        SetValueByHead "PODetailList", PORow + 1, "采购单编号GUID", POId
        SetValueByHead "PODetailList", PORow + 1, "采购单编号", POCode
        SetValueByHead "PODetailList", PORow + 1, "供应商编号", SupplyCode
        SetValueByHead "PODetailList", PORow + 1, "供应商类型", SupplyType
        SetValueByHead "PODetailList", PORow + 1, "采购单状态", POStatus
        SetValueByHead "PODetailList", PORow + 1, "预计出货日期", SendDate
        SetValueByHead "PODetailList", PORow + 1, "序号", Seq + 1
        SetValueByHead "PODetailList", PORow + 1, "创建人", RgUser
        SetValueByHead "PODetailList", PORow + 1, "创建时间", Date
        SetValueByHead "PODetailList", PORow + 1, "最后修改时间", Date
        SetValidationStr Range("PODetailList[[采购币种]]"), "=基础!$FT$7:$FT$" & GetRowId("CurrencyBaseList", "MAX")
    Else
        If wrksht.ListObjects(1).Name = "NewPODetailList" Then
        PORow = Selection.Row
        
        CoNo = GetValueByHead("NewPODetailList", PORow, "集团")    '集团
        DIVI = GetValueByHead("NewPODetailList", PORow, "事业体")    '事业体
        POId = GetValueByHead("NewPODetailList", PORow, "采购单编号GUID")    '采购单GUID
        POCode = GetValueByHead("NewPODetailList", PORow, "采购单编号")  '采购单编号
        SupplyCode = GetValueByHead("NewPODetailList", PORow, "供应商编号")  '供应商编号
        SupplyType = GetValueByHead("NewPODetailList", PORow, "供应商类型")  '供应商类型
        ContractCode = GetValueByHead("NewPODetailList", PORow, "合同编号") '合同编号
        'POStatus = GetValueByHead("NewPODetailList", PORow, "采购单状态") '采购单状态
        SendDate = GetValueByHead("NewPODetailList", PORow, "预计出货日期") '预计发货日期
        Seq = GetValueByHead("NewPODetailList", PORow, "序号")     '序号
        RgUser = GetValueByHead("NewPODetailList", PORow, "创建人")  '创建人
        
        InsertLine "采购单明细", PORow, True
        
        SetValueByHead "NewPODetailList", PORow + 1, "操作", "I"
        SetValueByHead "NewPODetailList", PORow + 1, "集团", CoNo
        SetValueByHead "NewPODetailList", PORow + 1, "事业体", DIVI
        SetValueByHead "NewPODetailList", PORow + 1, "采购单编号GUID", POId
        SetValueByHead "NewPODetailList", PORow + 1, "采购单编号", POCode
        SetValueByHead "NewPODetailList", PORow + 1, "供应商编号", SupplyCode
        SetValueByHead "NewPODetailList", PORow + 1, "供应商类型", SupplyType
        SetValueByHead "NewPODetailList", PORow + 1, "合同编号", ContractCode
        'SetValueByHead "NewPODetailList", PORow + 1, "采购单状态", POStatus
        SetValueByHead "NewPODetailList", PORow + 1, "预计出货日期", SendDate
        SetValueByHead "NewPODetailList", PORow + 1, "序号", Seq + 1
        SetValueByHead "NewPODetailList", PORow + 1, "创建人", RgUser
        SetValueByHead "NewPODetailList", PORow + 1, "最后修改人", "zhaoz"
        End If
    End If
N:
    SetValueByName "PODetail_Change", "0"
    ProtectSheetWithEnableAllowFiltering "采购单明细", False
    ScreenUpdate True
End Sub

Sub PODetail_Cancelline()
    '删除新建行
    Dim PORow As Long, wrksht As Worksheet
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单明细", False
    SetValueByName "PODetail_Change", "1"
    
    Set wrksht = ActiveWorkbook.Worksheets("采购单明细")
    
    If wrksht.ListObjects(1).Name = "PODetailList" Then
        If CheckSelectionInTable("PODetailList", True) = False Then GoTo N
        PORow = Selection.Row
        
        If GetValueByHead("PODetailList", PORow, "操作") <> "I" And GetValueByHead("PODetailList", PORow, "操作") <> "U" Then
            MsgBox "请选择操作为【I】or【U】 记录行", vbCritical, "提示"
            GoTo N
        End If
        If GetValueByHead("PODetailList", PORow, "操作") = "I" Then
        DeleteRows "采购单明细", PORow & ":" & PORow
        Rows(PORow - 1).Select
        End If
        
        If GetValueByHead("PODetailList", PORow, "操作") = "U" Then
        SetValueByHead "PODetailList", PORow, "操作", ""
        Rows(PORow).Select
        End If
        
    Else
        If wrksht.ListObjects(1).Name = "NewPODetailList" Then
            If CheckSelectionInTable("NewPODetailList", True) = False Then GoTo N
            PORow = Selection.Row
            If GetValueByHead("NewPODetailList", PORow, "操作") <> "I" Then
                MsgBox "请选择操作为【I】记录行", vbCritical, "提示"
                GoTo N
            End If
            PORow = Selection.Row
            If GetTableRowId("NewPODetailList", 1) = GetTableRowId("NewPODetailList", -1) Then
                MsgBox "只有一行数据，无法删除！  "
                GoTo N
            Else
                DeleteRows "采购单明细", PORow & ":" & PORow
                Rows(PORow - 1).Select
            End If
        End If
    End If
    
N:
    SetValueByName "PODetail_Change", "0"
    ProtectSheetWithEnableAllowFiltering "采购单明细", False
    ScreenUpdate True
End Sub

Sub POtoDetail_New()
    Dim XMLStr As String, PORow As Long, POId As String
    Dim wrksht As Worksheet, SupplyId As String, ContractId As String, POCode As String, SupplyType As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    ProtectSheetWithEnableAllowFiltering "采购单明细", False
    SetValueByName "PODetail_Change", "1"
    
    If CheckSelectionInTable("PurchaseOrderList", True) = False Then GoTo N
    PORow = Selection.Row
        POId = GetValueByHead("PurchaseOrderList", PORow, "采购单ID")       '取PO的GUID
        POCode = GetValueByHead("PurchaseOrderList", PORow, "采购单编号")   '取采购单编号
        SupplyId = GetValueByHead("PurchaseOrderList", PORow, "供应商编号") '取供应商编号
        ContractId = GetValueByHead("PurchaseOrderList", PORow, "合同编号") '取合同编号
        SupplyType = getMBQTGUID("SupplyBASEList", "供应商编号", GetValueByHead("PurchaseOrderList", PORow, "供应商编号"), "DC0_DictName1")   '取供应商类型
        
        Sheets("采购单明细").Activate
        ClearTable "PODetailList"
        ClearTable "NewPODetailList"
        XMLStr = "<ROOT><LIST><Rows><PR1D_CONO></PR1D_CONO><PR1D_DIVI></PR1D_DIVI><SupplyId></SupplyId><ContractId></ContractId><PR1D_OrderDetailId>" & _
        "</PR1D_OrderDetailId><PR1D_PR1_OrderId></PR1D_PR1_OrderId><POCode></POCode><ProductCodeSU></ProductCodeSU><ColorSUIdDictName></ColorSUIdDictName>" & _
        "<ColorBSUIdDictName></ColorBSUIdDictName><SizeSUIdTypeDictName></SizeSUIdTypeDictName><PR1D_SCurrencyPrice></PR1D_SCurrencyPrice><PR1D_PD0_SKUSU></PR1D_PD0_SKUSU><PR1D_PD0_ProductId>" & _
        "</PR1D_PD0_ProductId><PR1D_Total></PR1D_Total><PR1D_CurrencyAmount></PR1D_CurrencyAmount><PR1D_UnitID></PR1D_UnitID><UnitDictName></UnitDictName><PR1D_POriginalPrice></PR1D_POriginalPrice><PR1D_SupplierType></PR1D_SupplierType>" & _
        "<PR1D_Discount></PR1D_Discount><PR1D_SendDate></PR1D_SendDate><PR1D_Seq></PR1D_Seq><PR1D_RgUser></PR1D_RgUser><PR1D_LmUser></PR1D_LmUser>" & _
        "</Rows></LIST></ROOT>"
    
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("NewPODetailList")))
        CreateTableForXML "NewPODetailList", XMLStr, "ROOT", "采购单明细", "A9"
        If GetRowId("NewPODetailList", "MAX") <> GetRowId("NewPODetailList", "MIN") Then _
        DeleteRows "采购单明细", GetRowId("NewPODetailList", "MIN") & ":" & GetRowId("NewPODetailList", "MIN")
        SetFormat_NewPODetailList_All
        Sheets("采购单明细").Range("A9").Select
        PORow = Selection.Row + 1
        SetValueByHead "NewPODetailList", PORow, "操作", "I"
        SetValueByHead "NewPODetailList", PORow, "采购单编号GUID", POId
        SetValueByHead "NewPODetailList", PORow, "供应商编号", SupplyId
        SetValueByHead "NewPODetailList", PORow, "采购单编号", POCode
        SetValueByHead "NewPODetailList", PORow, "合同编号", ContractId
        SetValueByHead "NewPODetailList", PORow, "供应商类型", SupplyType
        SetValueByHead "NewPODetailList", PORow, "预计出货日期", Date
        SetValueByHead "NewPODetailList", PORow, "序号", "0"
        SetValueByHead "NewPODetailList", PORow, "创建人", "zhaoz"
        SetValueByHead "NewPODetailList", PORow, "最后修改人", "zhaoz"
N:
    ProtectSheetWithEnableAllowFiltering "采购单", False
    ProtectSheetWithEnableAllowFiltering "采购单明细", False
    SetValueByName "PODetail_Change", "0"
    ScreenUpdate False
End Sub
Sub PODetailList_Save()
    Dim wrksht As Worksheet
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
    Dim SelectBrandName As String, DictBrandId As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单明细", False
    Set wrksht = ActiveWorkbook.Worksheets("采购单明细")
    
    If TableIsExists("采购单明细") = True Then
        If wrksht.ListObjects(1).Name = "PODetailList" Then
            CurRow = Selection.Row
            SelectBrandName = GetValueByHead("PODetailList", CurRow, "单位")    '获取单位GUID
            DictBrandId = getMBQTGUID("UnitNameBaseList", "DC0_DictName1", SelectBrandName, "DC0_DictId")
            SetValueByHead "PODetailList", CurRow, "单位GUID", DictBrandId

'            SelectBrandName = GetValueByHead("PODetailList", CurRow, "采购币种")    '获取币种GUID
'            DictBrandId = getMBQTGUID("CurrencyBaseList", "DC0_DictName1", SelectBrandName, "DC0_DictId")
'            SetValueByHead "PODetailList", CurRow, "采购币种GUID", DictBrandId
'
            If GetValueByHead("PODetailList", CurRow, "操作") = "I" Then       '上传新增数据
                ColumnList = "【集团】【事业体】【采购单明细ID】【采购单编号GUID】【供应商SKU】【商品ID】【采购数】【单位ID】 " & _
                            "【采购原币价（单件)】【供应商类型】【采购折扣】【预计出货日期】【序号】【创建人】【最后修改人】【采购本币金额】" & _
                            "【吊牌本币价】"
                XMLStr = GetXMLByTableColumn("PODetailList", ColumnList, "操作", "I", "=")
                XMLStr = "<Interface WSID=""0b6f9fcf-fdfa-4012-84ea-b7de4a1656da""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = GetWsrrRlt(XMLStr)
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "PODetailList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
            End If

            If GetValueByHead("PODetailList", CurRow, "操作") = "U" Then       '上传变更数据
                ColumnList = "【集团】【事业体】【采购单明细ID】【采购单编号GUID】【供应商SKU】【商品ID】【采购数】【单位ID】 " & _
                            "【采购原币价（单件)】【供应商类型】【采购折扣】【预计出货日期】【序号】【创建人】【采购本币金额】【最后修改人】" & _
                            "【吊牌本币价】"
                XMLStr = GetXMLByTableColumn("PODetailList", ColumnList, "操作", "U", "=")
                XMLStr = "<Interface WSID=""0b6f9fcf-fdfa-4012-84ea-b7de4a1656da""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
                XMLStr = GetWsrrRlt(XMLStr)
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "PODetailList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
            End If
        End If
        
        If wrksht.ListObjects(1).Name = "NewPODetailList" Then
        
            CurRow = Selection.Row
            SelectBrandName = GetValueByHead("NewPODetailList", CurRow, "单位")    '获取单位GUID
            DictBrandId = getMBQTGUID("UnitNameBaseList", "DC0_DictName1", SelectBrandName, "DC0_DictId")
            SetValueByHead "NewPODetailList", CurRow, "单位ID", DictBrandId
            
            If GetValueByHead("NewPODetailList", CurRow, "操作") = "I" Then       '上传新建数据
                ColumnList = "【集团】【事业体】【采购单明细ID】【采购单编号GUID】【供应商SKU】【商品ID】【采购数】【单位ID】 " & _
                            "【采购原币价（单件)】【供应商类型】【采购折扣】【预计出货日期】【序号】【创建人】【采购本币金额】【最后修改人】" & _
                            "【吊牌本币价】"
                XMLStr = GetXMLByTableColumn("NewPODetailList", ColumnList, "操作", "I", "=")
                XMLStr = "<Interface WSID=""0b6f9fcf-fdfa-4012-84ea-b7de4a1656da""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
                XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "NewPODetailList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
            End If
        End If
    Else: MsgBox "请先加在采购单数据！   "
    End If
End Sub

