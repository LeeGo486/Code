Attribute VB_Name = "F12_采购单_控制"
Sub PurchaseOrder_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "采购单", False
        ClearTable "PurchaseOrderList"
        ClearTable "NewPurchaseOrderList"
        Dim XMLStr As String
        XMLStr = "<Interface WSID=""e844f940-858e-467a-a167-b96c4488dba9""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST></LIST>" & _
        "</ROOT></xml></Interface>"
        
        'Msg "FORM", vbCritical, "", "", XMLStr
        
        XMLStr = GetWsrrRlt(XMLStr)
        
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PurchaseOrderList")))
        
        CreateTableForXML "PurchaseOrderList", XMLStr, "ROOT", "采购单", "A9"
        If GetRowId("PurchaseOrderList", "MAX") <> GetRowId("PurchaseOrderList", "MIN") Then _
        DeleteRows "采购单", GetRowId("PurchaseOrderList", "MIN") & ":" & GetRowId("PurchaseOrderList", "MIN")

        SetFormat_PurchaseOrderList_All
'        Sheets("采购单").CommandButton10.Enabled = True
'        Sheets("采购单").CommandButton11.Enabled = True
'        Sheets("采购单").CommandButton14.Enabled = True
'        Sheets("采购单").CommandButton12.Enabled = True
'        Sheets("采购单").CommandButton18.Enabled = True
        'SetFormat_CommandButton_All
        
        'ProtectSheetWithEnableAllowFiltering "采购单", True
        Sheets("采购单").Activate
        Sheets("采购单").Range("E10").Select
        
'    End If
    ScreenUpdate True
End Sub

Sub PurchaseOrder_New()
    Dim XMLStr As String
    Dim wrksht As Worksheet
    Dim CurRow As Long
    Dim ContractId As String    '合同编号
    Dim ContractIdGUID As String '合同编号的GUID
    Dim SupplyId As String      '供应商编号
    Dim SupplyIdGUID As String  '供应商编号的GUID
    Dim SupplyType As String, SupplyTypeId As String   '供应商类型
    Dim CurrencyDictN As String '结算币种
    Dim CurrencyDictId As String    '结算币种Id
    Dim CJR As String  '创建人
    Dim ZHXGR As String  '最后修改人
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    Set wrksht = ActiveWorkbook.Worksheets("采购单")
    
    If TableIsExists("采购单") = True Then
        If wrksht.ListObjects(1).Name = "PurchaseOrderList" Then
            If CheckSelectionInTable("PurchaseOrderList", True) = False Then GoTo N
            CurRow = Selection.Row
            ContractId = GetValueByHead("PurchaseOrderList", CurRow, "合同编号")
            ContractIdGUID = GetValueByHead("PurchaseOrderList", CurRow, "合同编号ID")
            SupplyId = GetValueByHead("PurchaseOrderList", CurRow, "供应商编号")
            SupplyIdGUID = GetValueByHead("PurchaseOrderList", CurRow, "供应商编号ID")
            CJR = GetValueByHead("PurchaseOrderList", CurRow, "创建人")
            ZHXGR = GetValueByHead("PurchaseOrderList", CurRow, "最后修改人")
            SupplyTypeId = GetValueByHead("PurchaseOrderList", CurRow, "供应商类型ID")
            SupplyType = GetValueByHead("PurchaseOrderList", CurRow, "供应商类型")
            CurrencyDictN = GetValueByHead("PurchaseOrderList", CurRow, "币种")    '取结算币种ID
            CurrencyDictId = GetValueByHead("PurchaseOrderList", CurRow, "币种ID")       '取结算币种ID
            
'            Sheets("采购单").CommandButton10.Enabled = False
'            Sheets("采购单").CommandButton11.Enabled = False
            
            InsertLine "采购单", CurRow, True
            CurRow = Selection.Row
            SetValueByHead "PurchaseOrderList", CurRow, "操作", "I"
            SetValueByHead "PurchaseOrderList", CurRow, "集团", "0"
            SetValueByHead "PurchaseOrderList", CurRow, "事业体", "0"
            SetValueByHead "PurchaseOrderList", CurRow, "采购单ID", "0"
            SetValueByHead "PurchaseOrderList", CurRow, "采购单类型ID", "9FDCF85F-C3AA-4F0A-8621-7AC8A0AB26FD"
            SetValueByHead "PurchaseOrderList", CurRow, "采购类型", "采购单"
            SetValueByHead "PurchaseOrderList", CurRow, "合同编号", ContractId
            SetValueByHead "PurchaseOrderList", CurRow, "合同编号ID", ContractIdGUID
            SetValueByHead "PurchaseOrderList", CurRow, "供应商编号", SupplyId
            SetValueByHead "PurchaseOrderList", CurRow, "供应商编号ID", SupplyIdGUID
            SetValueByHead "PurchaseOrderList", CurRow, "币种", CurrencyDictN
            SetValueByHead "PurchaseOrderList", CurRow, "币种ID", CurrencyDictId
            SetValueByHead "PurchaseOrderList", CurRow, "状态ID", "40862D71-AAB5-4894-8680-56573725DB2E"
            SetValueByHead "PurchaseOrderList", CurRow, "创建人", CJR
            SetValueByHead "PurchaseOrderList", CurRow, "采购单状态", "未审核"
            SetValueByHead "PurchaseOrderList", CurRow, "供应商类型ID", SupplyTypeId
            SetValueByHead "PurchaseOrderList", CurRow, "供应商类型", SupplyType
            SetValueByHead "PurchaseOrderList", CurRow, "最后修改人", ZHXGR
            SetValidationStr Range("PurchaseOrderList[[品牌名称]]"), GetAddressByHead2("BrandBASEList", "SU0_SupplierCode", SupplyId, "品牌名称")
        End If
        
        If wrksht.ListObjects(1).Name = "NewPurchaseOrderList" Then
            If CheckSelectionInTable("NewPurchaseOrderList", True) = False Then GoTo N

            CurRow = Selection.Row
            ContractId = GetValueByHead("NewPurchaseOrderList", CurRow, "合同编号")
            ContractIdGUID = GetValueByHead("NewPurchaseOrderList", CurRow, "PR1_PR0_ContractId")
            SupplyId = GetValueByHead("NewPurchaseOrderList", CurRow, "供应商编号")
            SupplyIdGUID = GetValueByHead("NewPurchaseOrderList", CurRow, "PR1_SU0_SupplierId")
            SupplyType = GetValueByHead("NewPurchaseOrderList", CurRow, "供应商类型")
            CurrencyDictN = GetValueByHead("PurchaseOrderList", CurRow, "币种")
            CurrencyDictId = GetValueByHead("PurchaseOrderList", CurRow, "PR1_CurrencyTypeId")       '取结算币种ID
            CJR = GetValueByHead("NewPurchaseOrderList", CurRow, "创建人")
            ZHXGR = GetValueByHead("NewPurchaseOrderList", CurRow, "最后修改人")
'            Sheets("采购单").CommandButton10.Enabled = False
'            Sheets("采购单").CommandButton11.Enabled = False
            
            InsertLine "采购单", CurRow, True
            CurRow = Selection.Row
            SetValueByHead "NewPurchaseOrderList", CurRow, "操作", "I"
            SetValueByHead "NewPurchaseOrderList", CurRow, "集团", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "事业体", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "采购单ID", "0"
            'SetValueByHead "NewPurchaseOrderList", CurRow, "采购单编号", "系统生成"
            SetValueByHead "NewPurchaseOrderList", CurRow, "采购单类型", "9FDCF85F-C3AA-4F0A-8621-7AC8A0AB26FD"
            SetValueByHead "PurchaseOrderList", CurRow, "采购类型", "采购单"
            SetValueByHead "NewPurchaseOrderList", CurRow, "合同编号", ContractId
            SetValueByHead "NewPurchaseOrderList", CurRow, "合同编号ID", ContractIdGUID
            SetValueByHead "NewPurchaseOrderList", CurRow, "供应商编号", SupplyId
            SetValueByHead "NewPurchaseOrderList", CurRow, "供应商编号ID", SupplyIdGUID
            SetValueByHead "NewPurchaseOrderList", CurRow, "供应商类型ID", SupplyTypeId
            SetValueByHead "NewPurchaseOrderList", CurRow, "供应商类型", SupplyTypeId
            SetValidationStr Range("NewPurchaseOrderList[[品牌名称]]"), GetAddressByHead2("BrandBASEList", "SU0_SupplierCode", SupplyId, "品牌名称")
            'SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_BD0_BrandId", ""
            SetValueByHead "NewPurchaseOrderList", CurRow, "币种", CurrencyDictN
            SetValueByHead "NewPurchaseOrderList", CurRow, "币种ID", CurrencyDictId
'            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PurchaseTotal", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "状态ID", "40862D71-AAB5-4894-8680-56573725DB2E"
            SetValueByHead "NewPurchaseOrderList", CurRow, "创建人", CJR
            SetValueByHead "NewPurchaseOrderList", CurRow, "最后修改人", ZHXGR
            SetValueByHead "NewPurchaseOrderList", CurRow, "采购单状态", "未审核"
        End If
    Else: MsgBox "请先加在采购单数据，谢谢！    "
    End If
N:
    Sheets("采购单").Range("B10").Select
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单", False
End Sub

Sub PurchaseOrder_Cancelline()
    '删除新建行
    Dim CurRow As Long
    Dim wrksht As Worksheet
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    Set wrksht = ActiveWorkbook.Worksheets("采购单")
    If TableIsExists("采购单") = True Then
        If wrksht.ListObjects(1).Name = "PurchaseOrderList" Then
            If CheckSelectionInTable("PurchaseOrderList", True) = False Then GoTo N
            CurRow = Selection.Row
            If GetValueByHead("PurchaseOrderList", CurRow, "操作") = "" Then    '如果操作字段为空，则提示选择I或者U
                MsgBox "请选择“操作”为【I】或【U】的记录行", vbCritical, "提示"
                GoTo N
            End If
            If GetValueByHead("PurchaseOrderList", CurRow, "操作") = "I" Then   '如果操作字段为I，则删除该行
                DeleteRows "采购单", CurRow & ":" & CurRow
                Sheets("采购单").Rows(CurRow).Select
            End If
            If GetValueByHead("PurchaseOrderList", CurRow, "操作") = "U" Then   '如果操作字段为U，则将U字段置空
                SetValueByHead "PurchaseOrderList", CurRow, "操作", ""
            End If
        End If
        
        If wrksht.ListObjects(1).Name = "NewPurchaseOrderList" Then
            If CheckSelectionInTable("NewPurchaseOrderList", True) = False Then GoTo N
            CurRow = Selection.Row
            If GetValueByHead("NewPurchaseOrderList", CurRow, "操作") = "" Then    '如果操作字段为空，则提示选择I或者U
                MsgBox "请选择“操作”为【I】的记录行", vbCritical, "提示"
                GoTo N
            End If
            DeleteRows "采购单", CurRow & ":" & CurRow
            Sheets("采购单").Rows(CurRow).Select
        End If

    Else: MsgBox "请先加在采购单数据，谢谢！"
    End If
N:
    ProtectSheetWithEnableAllowFiltering "采购单", False
    ScreenUpdate True
End Sub
Sub PurchaseOrder_Save()
    Dim wrksht As Worksheet
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
    Dim SelectBrandName As String, DictBrandId As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    Set wrksht = ActiveWorkbook.Worksheets("采购单")
    
    If TableIsExists("采购单") = True Then
        If wrksht.ListObjects(1).Name = "PurchaseOrderList" Then
            CurRow = Selection.Row
            SelectBrandName = GetValueByHead("PurchaseOrderList", CurRow, "品牌名称")
            DictBrandId = getMBQTGUID("BrandBASEList", "品牌名称", SelectBrandName, "BD0_BrandId")
            SetValueByHead "PurchaseOrderList", CurRow, "品牌编号ID", DictBrandId
            
            If GetValueByHead("PurchaseOrderList", CurRow, "操作") = "I" Then       '上传新增数据
                ColumnList = "【集团】【事业体】【采购单ID】【采购单编号】【采购单类型ID】【合同编号ID】【供应商编号ID】【品牌编号ID】 " & _
                            "【采购总数】【采购折扣】【采购本币价】【实时汇率】【关税】【供应商类型】" & _
                            "【增值税】【运费】【采购原币价】【倍率】【状态ID】【创建人】【最后修改人】"
                XMLStr = GetXMLByTableColumn("PurchaseOrderList", ColumnList, "操作", "I", "=")
                XMLStr = "<Interface WSID=""e844f940-858e-467a-a167-b96c4488dba9""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
             
                XMLStr = GetWsrrRlt(XMLStr)

                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "PurchaseOrderList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
            End If
            
            If GetValueByHead("PurchaseOrderList", CurRow, "操作") = "U" Then       '上传变更数据
                ColumnList = "【集团】【事业体】【采购单ID】【采购单编号】【采购单类型ID】【合同编号ID】【供应商编号ID】【品牌编号ID】 " & _
                            "【采购总数】【采购折扣】【采购本币价】【实时汇率】【关税】【供应商类型】" & _
                            "【增值税】【运费】【采购原币价】【倍率】【状态ID】【创建人】【最后修改人】"
                XMLStr = GetXMLByTableColumn("PurchaseOrderList", ColumnList, "操作", "U", "=")
                XMLStr = "<Interface WSID=""e844f940-858e-467a-a167-b96c4488dba9""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
                XMLStr = GetWsrrRlt(XMLStr)
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "PurchaseOrderList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
            End If
        End If
        
        If wrksht.ListObjects(1).Name = "NewPurchaseOrderList" Then
        
            CurRow = Selection.Row
            SelectBrandName = GetValueByHead("NewPurchaseOrderList", CurRow, "品牌名称")
            DictBrandId = getMBQTGUID("BrandBASEList", "品牌名称", SelectBrandName, "BD0_BrandId")
            SetValueByHead "NewPurchaseOrderList", CurRow, "品牌编号ID", DictBrandId
            
            If GetValueByHead("NewPurchaseOrderList", CurRow, "操作") = "I" Then       '上传变更数据
                ColumnList = "【集团】【事业体】【采购单ID】【采购单编号】【采购单类型ID】【合同编号ID】【供应商编号ID】【品牌编号ID】 " & _
                            "【采购总数】【采购折扣】【采购本币价】【实时汇率】【关税】【供应商类型】" & _
                            "【增值税】【运费】【采购原币价】【倍率】【状态ID】【创建人】【最后修改人】"
                XMLStr = GetXMLByTableColumn("NewPurchaseOrderList", ColumnList, "操作", "I", "=")
                XMLStr = "<Interface WSID=""e844f940-858e-467a-a167-b96c4488dba9""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
                Msg "FORM", vbCritical, "", "", XMLStr
                Exit Sub
                XMLStr = GetWsrrRlt(XMLStr)

                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "NewPurchaseOrderList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
            End If
        End If
    Else: MsgBox "请先加在采购单数据！   "
    End If
End Sub

Sub PurchaseOrderToDetail()
    Dim POId As String, POCode As String, PORow As Long
    Dim XMLStr As String, SupplyId As String, ContractId As String, SupplyType As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    SetValueByName "PODetail_Change", "1"
    If TableIsExists("采购单") = True Then
        If CheckSelectionInTable("PurchaseOrderList", True) = False Then GoTo N
        PORow = Selection.Row
        POId = GetValueByHead("PurchaseOrderList", PORow, "采购单ID")       '取PO的GUID
        POCode = GetValueByHead("PurchaseOrderList", PORow, "采购单编号")   '取采购单编号
        SupplyId = GetValueByHead("PurchaseOrderList", PORow, "供应商编号") '取供应商编号
        ContractId = GetValueByHead("PurchaseOrderList", PORow, "合同编号") '取合同编号
        SupplyType = getMBQTGUID("SupplyBASEList", "供应商编号", GetValueByHead("PurchaseOrderList", PORow, "供应商编号"), "DC0_DictName1")   '取供应商类型
        
        XMLStr = "<Interface WSID=""0b6f9fcf-fdfa-4012-84ea-b7de4a1656da""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition>PR1D_PR1_OrderId = '" & POId & "'</Condition></Row></LIST>" & _
        "</ROOT></xml></Interface>"
        XMLStr = Replace(XMLStr, "'", "\u0027")
        XMLStr = GetWsrrRlt(XMLStr)

        If GetValueFromXml(XMLStr, "PR1D_OrderDetailId") <> Empty Then
            Sheets("采购单明细").Activate
            ClearTable "PODetailList"
            ClearTable "NewPODetailList"
            XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PODetailList")))
            CreateTableForXML "PODetailList", XMLStr, "ROOT", "采购单明细", "A8"
            If GetRowId("PODetailList", "MAX") <> GetRowId("PODetailList", "MIN") Then _
            DeleteRows "采购单明细", GetRowId("PODetailList", "MIN") & ":" & GetRowId("PODetailList", "MIN")
            SetFormat_PODetailList_All
            Else
                If GetValueFromXml(XMLStr, "PR1D_OrderDetailId") = Empty Then
                    If MsgBox("该采购单： 【" & GetValueByHead("PurchaseOrderList", PORow, "采购单编号") & "】无采购明细,请问需要新建吗？    ", vbYesNo, "提示") = vbYes Then
                        Sheets("采购单明细").Activate
                        ClearTable "PODetailList"
                        ClearTable "NewPODetailList"
                        XMLStr = "<ROOT><LIST><Rows><PR1D_CONO></PR1D_CONO><PR1D_DIVI></PR1D_DIVI><SupplyId></SupplyId><ContractId></ContractId><PR1D_OrderDetailId>" & _
                        "</PR1D_OrderDetailId><PR1D_PR1_OrderId></PR1D_PR1_OrderId><POCode></POCode><ProductCodeSU></ProductCodeSU><ColorSUIdDictName></ColorSUIdDictName>" & _
                        "<ColorBSUIdDictName></ColorBSUIdDictName><SizeSUIdTypeDictName></SizeSUIdTypeDictName><PR1D_PD0_SKUSU></PR1D_PD0_SKUSU><PR1D_PD0_ProductId>" & _
                        "</PR1D_PD0_ProductId><PR1D_Total></PR1D_Total><PR1D_UnitID></PR1D_UnitID><UnitDictName></UnitDictName><PR1D_POriginalPrice></PR1D_POriginalPrice><PR1D_SupplierType></PR1D_SupplierType>" & _
                        "<PR1D_Discount></PR1D_Discount><PR1D_SendDate></PR1D_SendDate><PR1D_Seq></PR1D_Seq><PR1D_RgUser></PR1D_RgUser><PR1D_LmUser></PR1D_LmUser>" & _
                        "</Rows></LIST></ROOT>"
                        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("NewPODetailList")))
                        CreateTableForXML "NewPODetailList", XMLStr, "ROOT", "采购单明细", "A8"
                        If GetRowId("NewPODetailList", "MAX") <> GetRowId("NewPODetailList", "MIN") Then _
                        DeleteRows "采购单明细", GetRowId("NewPODetailList", "MIN") & ":" & GetRowId("NewPODetailList", "MIN")
                        SetFormat_NewPODetailList_All
                        
                        PORow = Selection.Row
                        SetValueByHead "NewPODetailList", PORow, "操作", "I"
                        SetValueByHead "NewPODetailList", PORow, "采购单编号GUID", POId
                        SetValueByHead "NewPODetailList", PORow, "供应商编号", SupplyId
                        SetValueByHead "NewPODetailList", PORow, "供应商类型", ContractId
                        SetValueByHead "NewPODetailList", PORow, "采购单编号", POCode
                        SetValueByHead "NewPODetailList", PORow, "合同编号", ContractId
                        SetValueByHead "NewPODetailList", PORow, "供应商类型", SupplyType
                        SetValueByHead "NewPODetailList", PORow, "预计出货日期", Date
                        SetValueByHead "NewPODetailList", PORow, "序号", "0"
                        SetValueByHead "NewPODetailList", PORow, "创建人", "zhaoz"
                        SetValueByHead "NewPODetailList", PORow, "最后修改人", "zhaoz"
                    End If
            End If
        End If

        
    Else: MsgBox "请先加载采购单数据！   "
    End If
N:
    Sheets("采购单明细").Range("B10").Select
    ProtectSheetWithEnableAllowFiltering "采购单", False
    SetValueByName "PODetail_Change", "0"
    ScreenUpdate False
End Sub

Sub Return_PO()
    Sheets("采购单").Activate
    Range("B10").Select
End Sub
Sub POtoReturnD_Load()
    Dim PORow As Long, XMLStr As String, POId As String, Row As Long, RetMainGUID As String, POCode As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    If TableIsExists("采购单") = False Then GoTo N
    If CheckSelectionInTable("PurchaseOrderList", True) = False Then GoTo N
    PORow = Selection.Row
    If GetValueByHead("PurchaseOrderList", PORow, "采购单状态") = "已审核" Then
    POId = GetValueByHead("PurchaseOrderList", PORow, "采购单ID")
    POCode = GetValueByHead("PurchaseOrderList", PORow, "采购单编号")

    Sheets("退货明细").Activate
    ClearTable "ReturnBillDetailsList"
    ClearTable "ReturnBillDList"
    XMLStr = "<Interface WSID=""7163bbde-858e-4138-94fb-60d031963570""" & _
        " App=""ITDC_EXCEL"" SessionID="""">" & _
        "<InputFormat>AML</InputFormat>" & _
        "<OutputContentType>RS</OutputContentType>" & _
        "<ConditionStr>【操作类型,GET】【实体,B02_Bill.PRCD_ReturnDetail】" & _
        "【返回内容,集团,事业体,退货单明细ID,退货单主表ID,退货单编号,商品ID,单位,采购单主表ID,供应商GUID,采购单明细ID,采购原币价," & _
        "采购本币价,吊牌价,退货仓ID,POS_退货单号,退货数量,采购总数,已到数量,已生产计划数量,本次计划到货数量,本次计划到货金额,数量差异," & _
        "退货金额,退货原因,状态,创建人,创建时间,最后修改人,最后修改时间,供应商款号,供应商颜色,供应商尺码,颜色,尺码,款号,单位对照】" & _
        "【条件内容,《W》退货单主表ID,《W》采购单主表ID】【《W》退货单主表ID】【《W》采购单主表ID," & POId & "】" & _
        "</ConditionStr></Interface>"
'    Msg "FORM", vbCritical, "", "", XMLStr
'    Exit Sub
    XMLStr = GetWsrrRlt(XMLStr)

    XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("ReturnBillDList")))
    CreateTableForXML "ReturnBillDList", XMLStr, "ROOT", "退货明细", "A9"
    If GetRowId("ReturnBillDList", "MAX") <> GetRowId("ReturnBillDList", "MIN") Then _
    DeleteRows "退货明细", GetRowId("ReturnBillDList", "MIN") & ":" & GetRowId("ReturnBillDList", "MIN")
    ReplaceTableHead "ReturnBillDList", GetHeadMap("ReturnBillDList")
    Sheets("退货明细").CommandButton2.Enabled = False
    
    RetMainGUID = Mid$(CreateObject("Scriptlet.TypeLib").Guid, 2, 36)    '生成退货单主表ID
    For I = GetTableRowId("ReturnBillDList", 1) To GetTableRowId("ReturnBillDList", -1)
        Row = I
        SetValueByHead "ReturnBillDList", Row, "操作", "I"
        SetValueByHead "ReturnBillDList", Row, "退货单编号", "系统生成"
        SetValueByHead "ReturnBillDList", Row, "POS_退货单号", "系统生成"
        SetValueByHead "ReturnBillDList", Row, "状态ID", "40862D71-AAB5-4894-8680-56573725DB2E"
        SetValueByHead "ReturnBillDList", Row, "退货单主表ID", RetMainGUID
        SetValueByHead "ReturnBillDList", Row, "采购单主表编号", POCode
        SetValueByHead "ReturnBillDList", Row, "创建人", "qianc"
        SetValueByHead "ReturnBillDList", Row, "最后修改人", "qianc"
    Next
    Else: MsgBox "抱歉，请检查采购单状态！ "
    End If
    
N:
    Sheets("退货主表").Activate
    Sheets("退货主表").Range("B10").Select
    ProtectSheetWithEnableAllowFiltering "采购单", False
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    ScreenUpdate False
    End Sub
Sub POMain_Check()
    Dim XMLStr As String, PORow As Long, POId As String, SupplierType As String, ExchangeRate As String
    
    ScreenUpdate False
    ProtectSheet "采购单", False
    If TableIsExists("采购单") = False Then GoTo N
    If CheckSelectionInTable("PurchaseOrderList", True) = False Then GoTo N

    PORow = Selection.Row
    If GetValueByHead("PurchaseOrderList", PORow, "采购单状态") <> "已审核" Then
        POId = GetValueByHead("PurchaseOrderList", PORow, "采购单ID")
        SupplierType = GetValueByHead("PurchaseOrderList", PORow, "供应商类型")
        ExchangeRate = GetValueByHead("PurchaseOrderList", PORow, "实时汇率")
        
        XMLStr = "<Interface WSID=""e844f940-858e-467a-a167-b96c4488dba9""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST><Row>" & _
        "<PR1_OrderId>" & POId & "</PR1_OrderId>" & _
        "<PR1_Status>00DD6348-50D9-4E16-B214-CCFE3CD25D41</PR1_Status>" & _
        "<PR1_SupplierType>" & SupplierType & "</PR1_SupplierType>" & _
        "<PR1_ExchangeRate>" & ExchangeRate & "</PR1_ExchangeRate>" & _
        "<PR1_LmUser>qianc</PR1_LmUser></Row></LIST>" & _
        "</ROOT></xml></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr

        XMLStr = GetWsrrRlt(XMLStr)
        If GetValueFromXml(XMLStr, "Result") = "true" Then
            MsgBox "恭喜，审核成功！      ", vbInformation, "提示"
            SetValueByHead "PurchaseOrderList", PORow, "采购单状态", "已审核"
            SetValueByHead "PurchaseOrderList", PORow, "状态ID", "00DD6348-50D9-4E16-B214-CCFE3CD25D41"
        Else
            MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
        End If
    Else: MsgBox "抱歉，采购单状态为【已审核】不能审核！"
    End If
N:
    ProtectSheetWithEnableAllowFiltering "采购单", False
    ScreenUpdate False
End Sub

Sub POMain_Delete()
    Dim XMLStr As String, PORow As Long, POId As String, SupplierType As String, ExchangeRate As String
    
    ScreenUpdate False
    ProtectSheet "采购单", False
    If TableIsExists("采购单") = False Then GoTo N
    If CheckSelectionInTable("PurchaseOrderList", True) = False Then GoTo N

    PORow = Selection.Row
    If GetValueByHead("PurchaseOrderList", PORow, "采购单状态") <> "已审核" Then
        POId = GetValueByHead("PurchaseOrderList", PORow, "采购单ID")
        SupplierType = GetValueByHead("PurchaseOrderList", PORow, "供应商类型")
        ExchangeRate = GetValueByHead("PurchaseOrderList", PORow, "实时汇率")
        
        XMLStr = "<Interface WSID=""e844f940-858e-467a-a167-b96c4488dba9""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST><Row>" & _
        "<PR1_OrderId>" & POId & "</PR1_OrderId>" & _
        "<PR1_Status>E3CA9B7A-8E17-4E52-B667-39689445D4A1</PR1_Status>" & _
        "<PR1_SupplierType>" & SupplierType & "</PR1_SupplierType>" & _
        "<PR1_ExchangeRate>" & ExchangeRate & "</PR1_ExchangeRate>" & _
        "<PR1_LmUser>qianc</PR1_LmUser></Row></LIST>" & _
        "</ROOT></xml></Interface>"
    '    Msg "FORM", vbCritical, "", "", XMLStr
        XMLStr = GetWsrrRlt(XMLStr)
        If GetValueFromXml(XMLStr, "Result") = "true" Then
            MsgBox "恭喜，删除成功！      ", vbInformation, "提示"
            SetValueByHead "PurchaseOrderList", PORow, "采购单状态", "删除"
            SetValueByHead "PurchaseOrderList", PORow, "状态ID", "E3CA9B7A-8E17-4E52-B667-39689445D4A1"
        Else
            MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
        End If
    Else: MsgBox "抱歉，采购单状态为【已审核】不能删除！"
    End If
N:
    ProtectSheetWithEnableAllowFiltering "采购单", False
    ScreenUpdate False
End Sub
Sub 到货计划明细_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "到货计划明细", False
'        SetValueByName "到货计划明细_Change", "1"
        ClearTable "DeliveryPlanList"
        ClearTable "DeliveryPlanMXList"
        Sheets("到货计划明细").Range("F5").Clear
        Dim XMLStr As String
        Dim CGDH As String
        Dim CurRow As Long
        Dim Guid As String
        CurRow = Selection.Row
        CGDH = GetValueByHead("PurchaseOrderList", CurRow, "采购单ID")
        Guid = LCase(Mid$(CreateObject("Scriptlet.TypeLib").Guid, 2, 36))
        XMLStr = "<Interface WSID=""a7c3649a-4104-4e4d-90e3-d09af73515c1""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.PRAD_ArrivalPlanDetail】" & _
        "【返回内容,集团,事业体,到货计划ID,到货计划编号,商品ID,单位,采购单明细ID,采购原币价,采购本币价,吊牌价,预计到货日期,采购主表总数,采购主表金额,采购总数,已到数量,已生产计划数量,本次计划到货数量,本次计划到货金额,数量差异,状态,创建人,创建时间,最后修改人,最后修改时间,供应商款号,款号,单位对照】" & _
        "【条件内容,《W》采购单号】【《W》采购单号," & CGDH & "】</ConditionStr>" & _
        "</Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
         XMLStr = GetWsrrRlt(XMLStr)
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("DeliveryPlanList")))
        CreateTableForXML "DeliveryPlanList", XMLStr, "ROOT", "到货计划明细", "A6"
        If GetRowId("DeliveryPlanList", "MAX") <> GetRowId("DeliveryPlanList", "MIN") Then _
        DeleteRows "到货计划明细", GetRowId("DeliveryPlanList", "MIN") & ":" & GetRowId("DeliveryPlanList", "MIN")
        Sheets("到货计划明细").Activate
        CurRow = Selection.Row
        SetCellValueByRange "到货计划明细", "B1", Guid
        SetFormat_DeliveryPlanList_All
        'ProtectSheetWithEnableAllowFiltering "到货计划明细", True
        
        Sheets("到货计划明细").Range("F5").Select
'    SetValueByName "到货计划明细_Change", "0"
'    End If
    ScreenUpdate True
End Sub
