Attribute VB_Name = "F10_合同_控制"
Sub 合同_load()
    Dim XMLStr As String
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "合同", False
        SetValueByName "Contract_Change", "1"
        SetValueByName "Contract_SelectionChange", "1"
        ClearTable "ContractList"
        ClearTable "ContractNewList"
        ClearTable "表74"
'        Sheets("合同").CommandButton5.Enabled = True        '开启审核按钮
'        Sheets("合同").CommandButton6.Enabled = True        '开启查看采购单按钮
'        Sheets("合同").CommandButton7.Enabled = True        '开启新增采购单按钮
'        Sheets("合同").CommandButton8.Enabled = True        '开启上传扫描件按钮
        XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST></LIST>" & _
        "</ROOT></xml></Interface>"

        
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        XMLStr = GetWsrrRlt(XMLStr)
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("ContractList")))
        
        CreateTableForXML "ContractList", XMLStr, "ROOT", "合同", "A9"
        If GetRowId("ContractList", "MAX") <> GetRowId("ContractList", "MIN") Then _
        DeleteRows "合同", GetRowId("ContractList", "MIN") & ":" & GetRowId("ContractList", "MIN")

        SetFormat_ContractList_All
        'SetFormat_CommandButton_All
        
        'ProtectSheetWithEnableAllowFiltering "合同", True
        Sheets("合同").Activate
        Sheets("合同").Range("D10").Select
'    End If
    SetValueByName "Contract_Change", "0"
    SetValueByName "Contract_SelectionChange", "0"
    ScreenUpdate True
End Sub
Sub 合同_CreateSplit()
    '合同新建插入
    ProtectSheet "合同", False

'    If CheckIsLogin() = False Then GoTo N:

        Dim CurRow As Long
        Dim PSno As String

    If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        ScreenUpdate False
        InsertLine "合同", 8, True
        CurRow = Selection.Row

        SetValueByHead "ContractList", CurRow, "操作", "I"
        SetValueByHead "ContractList", CurRow, "合同编号", "系统自动生成"
        PSno = Sheets("合同").Range("E11").Value
        SetValueByHead "ContractList", CurRow, "供应商编号", PSno

        SetFormat_ContractList_Line CurRow, CurRow
        'SetFormat_CommandButton_All
        CurRow = Selection.Row
        ScreenUpdate True
N:
    'ProtectSheetWithEnableAllowFiltering "合同", True
End Sub


'-----------by liuhong 20130730 begin-----------
Sub 合同_Cancelline()
    '删除新建行
    Dim CurRow As Long
    ScreenUpdate False
    If CheckSelectionInTable("ContractNewList", True) = False Then GoTo N
    CurRow = Selection.Row
    If GetValueByHead("ContractNewList", CurRow, "操作") = "" And GetValueByHead("ContractNewList", CurRow, "合同编号") <> "系统生成" Then
        MsgBox "请选择记录行", vbCritical, "提示"
        GoTo N
    End If
    
    DeleteRows "合同", CurRow & ":" & CurRow
    Range("C10").Select
N:
    ScreenUpdate True
End Sub
Sub Contract_New()
    Dim XMLStr As String
    Dim wrksht As Worksheet
    Dim CurRow As Long
    
    ScreenUpdate False
    ProtectSheet "合同", False
    供应商基础_load
'    Sheets("合同").CommandButton5.Enabled = False       '关闭审核按钮
'    Sheets("合同").CommandButton6.Enabled = False
'    Sheets("合同").CommandButton7.Enabled = False
'    Sheets("合同").CommandButton8.Enabled = False
    Set wrksht = ActiveWorkbook.Worksheets("合同")
    SetValueByName "Contract_Change", "1"
    SetValueByName "Contract_SelectionChange", "1"
    If TableIsExists("合同") = True Then  '如果合同表中存在Table
        If wrksht.ListObjects(1).Name = "ContractList" Then '如果TableName是"ContractList"
            ClearTable "ContractList"                    '清除"ContractList"
            
            XMLStr = "<ROOT><LIST><Rows><PR0_CONO></PR0_CONO><PR0_DIVI></PR0_DIVI><PR0_ContractCode></PR0_ContractCode><PR0_ContractId></PR0_ContractId>" & _
            "<PR0_SU0_SupplierId></PR0_SU0_SupplierId><SU0_SupplierCode></SU0_SupplierCode><PR0_Amount></PR0_Amount><PR0_CurrencyId></PR0_CurrencyId><PR0_SettleAccount></PR0_SettleAccount>" & _
            "<AccountDictName></AccountDictName><PR0_PrePayRate></PR0_PrePayRate><CurrencyDictName></CurrencyDictName>" & _
            "<PR0_Description></PR0_Description><PR0_Status></PR0_Status><StatusDictName></StatusDictName><PR0_ECopyPath></PR0_ECopyPath><PR0_StartDate></PR0_StartDate>" & _
            "<PR0_EndDate></PR0_EndDate><PR0_RgUser></PR0_RgUser><PR0_LmUser></PR0_LmUser></Rows></LIST></ROOT>"
            
            XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("")))
            CreateTableForXML "ContractNewList", XMLStr, "ROOT", "合同", "A9"
            If GetRowId("ContractNewList", "MAX") <> GetRowId("ContractNewList", "MIN") Then _
            DeleteRows "合同", GetRowId("ContractNewList", "MIN") & ":" & GetRowId("ContractNewList", "MIN")
            SetFormat_ContractNewList_All
            CurRow = Selection.Row + 1
            SetValueByHead "ContractNewList", CurRow, "操作", "I"
            SetValueByHead "ContractNewList", CurRow, "集团", "100"
            SetValueByHead "ContractNewList", CurRow, "事业体", "200"
'            SetValueByHead "ContractNewList", CurRow, "创建时间", Date & Time
            SetValueByHead "ContractNewList", CurRow, "合同编号", "系统生成"
            SetValueByHead "ContractNewList", CurRow, "合同编号ID", "系统生成"
            SetValueByHead "ContractNewList", CurRow, "合同金额", "0"
            SetValueByHead "ContractNewList", CurRow, "状态ID", "40862D71-AAB5-4894-8680-56573725DB2E"
            SetValueByHead "ContractNewList", CurRow, "合同状态", "未审核"
            SetValueByHead "ContractNewList", CurRow, "合同开始时间", Format(Date, "yyyymmdd")
            SetValueByHead "ContractNewList", CurRow, "创建人", "qianc"
            SetValueByHead "ContractNewList", CurRow, "最后修改人", "qianc"
            SetValidationStr Range("ContractNewList[[结算币种]]"), "=基础!$FT$7:$FT$" & GetRowId("CurrencyBaseList", "MAX")
            SetValidationStr Range("ContractNewList[[结算方式]]"), "=基础!$GI$7:$GI$" & GetRowId("AccountTypeBaseList", "MAX")
'            HideTableColumns "ContractNewList", "【PR0_DIVI】【PR0_CONO】【PR0_ContractId】【PR0_SU0_SupplierId】" & _
'            "【PR0_CurrencyId】【CurrencyDictName】【PR0_Status】", True
'            Range("ContractNewList[#All]").Columns.EntireColumn.AutoFit
        Else
            If wrksht.ListObjects(1).Name = "ContractNewList" Then
                If CheckSelectionInTable("ContractNewList", True) = False Then GoTo N
                InsertLine "合同", 9, True
                CurRow = Selection.Row
                SetValueByHead "ContractNewList", CurRow, "操作", "I"
                SetValueByHead "ContractNewList", CurRow, "集团", "100"
                SetValueByHead "ContractNewList", CurRow, "事业体", "200"
                SetValueByHead "ContractNewList", CurRow, "合同编号", "系统生成"
                SetValueByHead "ContractNewList", CurRow, "合同编号ID", "系统生成"
                SetValueByHead "ContractNewList", CurRow, "合同金额", "0"
'                SetValueByHead "ContractNewList", CurRow, "创建时间", Date & Time
                SetValueByHead "ContractNewList", CurRow, "状态ID", "40862D71-AAB5-4894-8680-56573725DB2E"
                SetValueByHead "ContractNewList", CurRow, "合同状态", "未审核"
                SetValueByHead "ContractNewList", CurRow, "合同开始时间", Format(Date, "yyyymmdd")
                SetValueByHead "ContractNewList", CurRow, "创建人", "qianc"
                SetValueByHead "ContractNewList", CurRow, "最后修改人", "qianc"
                Range("ContractNewList[#All]").Columns.EntireColumn.AutoFit
                '设置可编辑区域
                AddEditRangeByHead "ContractNewList", 0, GetEditColumnsName("ContractNewList")
                SetValidationStr Range("ContractNewList[[结算币种]]"), "=基础!$FT$7:$FT$" & GetRowId("CurrencyBaseList", "MAX")
                SetValidationStr Range("ContractNewList[[结算方式]]"), "=基础!$GI$7:$GI$" & GetRowId("AccountTypeBaseList", "MAX")
            End If
        End If
    Else
        If TableIsExists("合同") = False Then  '如果合同表中不存在Table
            XMLStr = "<ROOT><LIST><Rows><PR0_CONO></PR0_CONO><PR0_DIVI></PR0_DIVI><PR0_ContractCode></PR0_ContractCode><PR0_ContractId></PR0_ContractId>" & _
            "<PR0_SU0_SupplierId></PR0_SU0_SupplierId><SU0_SupplierCode></SU0_SupplierCode><PR0_CurrencyId></PR0_CurrencyId><PR0_Amount></PR0_Amount><PR0_SettleAccount></PR0_SettleAccount>" & _
            "<AccountDictName></AccountDictName><PR0_PrePayRate></PR0_PrePayRate><CurrencyDictName></CurrencyDictName>" & _
            "<PR0_Description></PR0_Description><PR0_Status></PR0_Status><StatusDictName></StatusDictName><PR0_ECopyPath></PR0_ECopyPath><PR0_StartDate></PR0_StartDate>" & _
            "<PR0_EndDate></PR0_EndDate><PR0_RgUser></PR0_RgUser><PR0_LmUser></PR0_LmUser></Rows></LIST></ROOT>"
            
            XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("")))
            CreateTableForXML "ContractNewList", XMLStr, "ROOT", "合同", "A9"
            If GetRowId("ContractNewList", "MAX") <> GetRowId("ContractNewList", "MIN") Then _
            DeleteRows "合同", GetRowId("ContractNewList", "MIN") & ":" & GetRowId("ContractNewList", "MIN")
            SetFormat_ContractNewList_All
            CurRow = Selection.Row
            SetValueByHead "ContractNewList", CurRow, "操作", "I"
            SetValueByHead "ContractNewList", CurRow, "集团", "100"
            SetValueByHead "ContractNewList", CurRow, "事业体", "200"
            SetValueByHead "ContractNewList", CurRow, "合同编号", "系统生成"
            SetValueByHead "ContractNewList", CurRow, "合同编号ID", "系统生成"
            SetValueByHead "ContractNewList", CurRow, "状态ID", "40862D71-AAB5-4894-8680-56573725DB2E"
            SetValueByHead "ContractNewList", CurRow, "合同状态", "未审核"
            SetValueByHead "ContractNewList", CurRow, "合同金额", "0"
            SetValueByHead "ContractNewList", CurRow, "合同开始时间", Format(Date, "yyyymmdd")
            SetValueByHead "ContractNewList", CurRow, "创建人", "qianc"
            SetValueByHead "ContractNewList", CurRow, "最后修改人", "qianc"
            
            SetValidationStr Range("ContractNewList[[结算币种]]"), "=基础!$FT$7:$FT$" & GetRowId("CurrencyBaseList", "MAX")
            SetValidationStr Range("ContractNewList[[结算方式]]"), "=基础!$GI$7:$GI$" & GetRowId("AccountTypeBaseList", "MAX")
'            Range("ContractNewList[#All]").Columns.EntireColumn.AutoFit
'            HideTableColumns "ContractNewList", "【PR0_DIVI】【PR0_CONO】【PR0_ContractId】【PR0_SU0_SupplierId】" & _
'            "【PR0_CurrencyId】【CurrencyDictName】【PR0_Status】", False
        End If
    End If
N:
    ProtectSheet "合同", False
    ScreenUpdate False
End Sub
'-----------by liuhong 20130730 end   -----------
Sub Contract_Save()
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "合同", False
    
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
    Dim XMLStr1 As String '定义一个保存审批流的xml
    Dim selectItemPR0_SU0_SupplierId As String, selectItemPR0_CurrencyId As String
    Dim dictIdPR0_SU0_SupplierId As String, dictIdPR0_CurrencyId As String
    Dim wrksht As Worksheet
    SetValueByName "Contract_Change", "1"
    Set wrksht = ActiveWorkbook.Worksheets("合同")
    
    If TableIsExists("合同") = True Then  '如果合同表中存在Table
        If wrksht.ListObjects(1).Name = "ContractNewList" Then '如果TableName是"ContractNewList"
            CurRow = Selection.Row
            '设置供应商编号下拉的取值
            selectItemPR0_SU0_SupplierId = GetValueByHead("ContractNewList", CurRow, "供应商编号")
            dictIdPR0_SU0_SupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemPR0_SU0_SupplierId, "SU0_SupplierId")
            SetValueByHead "ContractNewList", CurRow, "供应商ID", dictIdPR0_SU0_SupplierId
            '设置采购币种下拉的取值
            selectItemPR0_SU0_SupplierId = GetValueByHead("ContractNewList", CurRow, "结算币种")
            dictIdPR0_SU0_SupplierId = getMBQTGUID("CurrencyBaseList", "DC0_DictName1", selectItemPR0_SU0_SupplierId, "DC0_DictId")
            SetValueByHead "ContractNewList", CurRow, "结算币种ID", dictIdPR0_SU0_SupplierId
            '设置采购结算方式下拉的取值
            selectItemPR0_SU0_SupplierId = GetValueByHead("ContractNewList", CurRow, "结算方式")
            dictIdPR0_SU0_SupplierId = getMBQTGUID("AccountTypeBaseList", "DC0_DictName1", selectItemPR0_SU0_SupplierId, "DC0_DictId")
            SetValueByHead "ContractNewList", CurRow, "结算方式ID", dictIdPR0_SU0_SupplierId
            '选中需要上传的列
            If Not CheckSelectionInTable("ContractNewList", True) Then GoTo N
            If GetValueByHead("ContractNewList", CurRow, "操作") = "I" Then
'                If GetValueByHead("ContractNewList", CurRow, "采购单编号") = Empty Then
'                    MsgBox "抱歉，请填写采购单编号。"
'                    GoTo N
'                End If
                If MsgBox("你确认要【保存】" & "合同名称： " & GetValueByHead("ContractNewList", CurRow, "供应商编号") & "的合同吗？    ", vbYesNo, "提示") = vbYes Then
                    ColumnList = "【集团】【事业体】【合同编号ID】【供应商ID】【结算币种ID】【结算方式ID】【合同说明】【状态ID】 " & _
                                "【合同扫描件】【合同开始时间】【合同截止时间】【创建人】【最后修改人】【预付款百分比】"
                    XMLStr = GetXMLByTableColumn("ContractNewList", ColumnList, "操作", "I", "=")
                    XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
'                    Msg "FORM", vbCritical, "", "", XMLStr
'                    Exit Sub
                    XMLStr = GetWsrrRlt(XMLStr)

                    If GetValueFromXml(XMLStr, "Result") = "true" Then
                        
                        MsgBox "保存成功！      ", vbInformation, "提示"
                        SetValueByHead "ContractNewList", CurRow, "操作", "F"
                    Else
                        MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                    End If
                End If
            End If
        Else
             If wrksht.ListObjects(1).Name = "ContractList" Then '如果TableName是"ContractList"
                CurRow = Selection.Row
                If GetValueByHead("ContractList", CurRow, "合同状态") = "未审核" Then
                    If GetValueByHead("ContractList", CurRow, "操作") = "U" Then
                        '设置结算币种的下拉和取值
                        selectItemPR0_CurrencyId = GetValueByHead("ContractList", CurRow, "结算币种")
                        dictIdPR0_CurrencyId = getMBQTGUID("CurrencyBaseList", "DC0_DictName1", selectItemPR0_CurrencyId, "DC0_DictId")
                        SetValueByHead "ContractList", CurRow, "结算币种ID", dictIdPR0_CurrencyId
                        '设置采购结算方式下拉的取值
                        selectItemPR0_SU0_SupplierId = GetValueByHead("ContractList", CurRow, "结算方式")
                        dictIdPR0_SU0_SupplierId = getMBQTGUID("AccountTypeBaseList", "DC0_DictName1", selectItemPR0_SU0_SupplierId, "DC0_DictId")
                        SetValueByHead "ContractList", CurRow, "结算方式ID", dictIdPR0_SU0_SupplierId
                        
                        If MsgBox("你确认要【修改】" & "合同编号： " & GetValueByHead("ContractList", CurRow, "合同编号") & "的信息吗？    ", vbYesNo, "提示") = vbYes Then
                            ColumnList = " 【集团】【事业体】【合同ID】【供应商编号ID】【结算币种ID】【结算方式ID】【合同说明】【状态ID】" & _
                            "【合同扫描件】【合同开始时间】【合同截止时间】【创建人】【最后修改人】【预付款百分比】"""
                            XMLStr = GetXMLByTableColumn("ContractList", ColumnList, "操作", "U", "=")
                        
                            XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
'                            Msg "FORM", vbCritical, "", "", XMLStr
'                            Exit Sub
                            XMLStr = GetWsrrRlt(XMLStr)
    '                         Msg "FORM", vbCritical, "", "", XMLStr
    '                        Exit Sub
                            If GetValueFromXml(XMLStr, "Result") = "true" Then
                                MsgBox "保存成功！      ", vbInformation, "提示"
                                SetValueByHead "ContractList", CurRow, "操作", "F"
                            Else
                                MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                            End If
                        End If
                    End If
                End If
             End If
        End If
    Else: MsgBox "请加载或者新增合同，谢谢！      "
    End If
N:
    SetValueByName "Contract_Change", "0"
    ProtectSheetWithEnableAllowFiltering "合同", False
    ScreenUpdate True
End Sub
Sub ContractToPurchaseOrder()
    Dim CurRow As Long
    Dim XMLStr As String
    Dim ContractId As String
    Dim ContractIdGUID As String '合同编号的GUID
    Dim SupplyId As String      '供应商编号
    Dim SupplyIdGUID As String  '供应商编号的GUID
    Dim SupplyType As String    '供应商类型
    Dim CurrencyDictN As String '结算币种
    Dim CurrencyDictId As String    '结算币种Id
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "合同", False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    ClearTable "PurchaseOrderList"
    ClearTable "NewPurchaseOrderList"
    
    If TableIsExists("合同") = True Then
        If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        CurRow = Selection.Row
        
        ContractIdGUID = GetValueByHead("ContractList", CurRow, "合同ID")     '取合同编号GUID
        ContractId = GetValueByHead("ContractList", CurRow, "合同编号")
        SupplyIdGUID = GetValueByHead("ContractList", CurRow, "供应商编号ID")       '取供应商编号GUID
        SupplyId = GetValueByHead("ContractList", CurRow, "供应商编号")
        SupplyType = getMBQTGUID("SupplyBASEList", "供应商编号", GetValueByHead("ContractList", CurRow, "供应商编号"), "DC0_DictName1")   '取供应商类型
        CurrencyDictN = GetValueByHead("ContractList", CurRow, "结算币种")              '取合同的结算币种
        CurrencyDictId = GetValueByHead("ContractList", CurRow, "PR0_CurrencyId")    '取结算币种ID
        If GetValueByHead("ContractList", CurRow, "合同状态") = "已审核" Then
            
            XMLStr = "<Interface WSID=""e844f940-858e-467a-a167-b96c4488dba9""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition>PR1_PR0_ContractId= '" & ContractId & "'</Condition></Row></LIST>" & _
            "</ROOT></xml></Interface>"
            XMLStr = Replace(XMLStr, "'", "\u0027")  '将SQL查询条件中的逗号替换& ContractId &
            XMLStr = GetWsrrRlt(XMLStr)
'            Msg "FORM", vbCritical, "", "", XMLStr
'            Exit Sub
            
            If GetValueFromXml(XMLStr, "PR1_OrderId") <> Empty Then
                Sheets("采购单").Activate
                
                XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("")))
                CreateTableForXML "PurchaseOrderList", XMLStr, "ROOT", "采购单", "A8"
                If GetRowId("PurchaseOrderList", "MAX") <> GetRowId("PurchaseOrderList", "MIN") Then _
                DeleteRows "采购单", GetRowId("PurchaseOrderList", "MIN") & ":" & GetRowId("PurchaseOrderList", "MIN")
                'SetFormat_LXRList_All
            Else
                If GetValueFromXml(XMLStr, "PR1_OrderId") = Empty Then
                    If MsgBox("该合同： " & GetValueByHead("ContractList", CurRow, "合同编号") & "无采购单,请问需要新建吗？    ", vbYesNo, "提示") = vbYes Then
                        Sheets("采购单").Activate
                        ClearTable "PurchaseOrderList"
                        ClearTable "NewPurchaseOrderList"
                        XMLStr = "<ROOT><LIST><Rows><PR1_CONO></PR1_CONO><PR1_DIVI></PR1_DIVI><PR1_OrderId></PR1_OrderId><PR1_OrderCode></PR1_OrderCode>" & _
                        "<PR1_OrderTypeId></PR1_OrderTypeId><PR1_PR0_ContractId></PR1_PR0_ContractId><PR1_SU0_SupplierId></PR1_SU0_SupplierId><PR1_BD0_BrandId></PR1_BD0_BrandId>" & _
                        "<PR1_PurchaseTotal></PR1_PurchaseTotal><PR1_POriginalAmount></PR1_POriginalAmount><PR1_PurchaseAmount></PR1_PurchaseAmount><PR1_Discount></PR1_Discount>" & _
                        "<PR1_ExchangeRate></PR1_ExchangeRate><PR1_Tariff></PR1_Tariff><PR1_VAT></PR1_VAT><PR1_Freight></PR1_Freight><PR1_Times></PR1_Times><PR1_Status></PR1_Status>" & _
                        "<PR1_RgUser></PR1_RgUser><PR1_RgDt></PR1_RgDt><PR1_LmUser></PR1_LmUser><PR1_LmDt></PR1_LmDt><PR1_UptNo></PR1_UptNo><PR1_CurrencyTypeId></PR1_CurrencyTypeId>" & _
                        "<SU0_SupplierCode></SU0_SupplierCode><BD0_BrandName></BD0_BrandName><PR0_ContractCode></PR0_ContractCode>" & _
                        "<OrderTypeDictName></OrderTypeDictName><StatusDictName></StatusDictName><PR1_SupplierType></PR1_SupplierType><CurrencyTypeDictName></CurrencyTypeDictName></Rows></LIST></ROOT>"
        
                        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("NewPurchaseOrderList")))
                        CreateTableForXML "NewPurchaseOrderList", XMLStr, "ROOT", "采购单", "A8"
                        If GetRowId("NewPurchaseOrderList", "MAX") <> GetRowId("NewPurchaseOrderList", "MIN") Then _
                        DeleteRows "采购单", GetRowId("NewPurchaseOrderList", "MIN") & ":" & GetRowId("NewPurchaseOrderList", "MIN")
            
                        Sheets("采购单").Range("A9").Select
                        CurRow = Selection.Row
                        SetValueByHead "NewPurchaseOrderList", CurRow, "操作", "I"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_CONO", "0"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_DIVI", "0"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderId", "0"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderCode", "系统生成"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderTypeId", "9FDCF85F-C3AA-4F0A-8621-7AC8A0AB26FD"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR0_ContractCode", ContractId
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PR0_ContractId", ContractIdGUID
                        SetValueByHead "NewPurchaseOrderList", CurRow, "SU0_SupplierCode", SupplyId
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_SU0_SupplierId", SupplyIdGUID
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_SupplierType", SupplyType
                        SetValidationStr Range("NewPurchaseOrderList[[BD0_BrandName]]"), GetAddressByHead2("BrandBASEList", "SU0_SupplierCode", SupplyId, "品牌名称")
                        'SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_BD0_BrandId", ""
                        SetValueByHead "NewPurchaseOrderList", CurRow, "CurrencyTypeDictName", CurrencyDictN
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_CurrencyTypeId", CurrencyDictId
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PurchaseTotal", "0"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_Status", "40862D71-AAB5-4894-8680-56573725DB2E"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_RgUser", "LiuH"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_LmUser", "LiuH"
                        Sheets("采购单").CommandButton10.Enabled = False
                        Sheets("采购单").CommandButton11.Enabled = False
                        SetFormat_NewPurchaseOrderList_All
                    End If
                End If
            End If
            
            
        Else
            MsgBox "该合同未审核，无采购单信息！谢谢。     "
            GoTo N
        End If
    Else
        MsgBox "请先加载合同数据，谢谢！   "
    End If
N:
    ProtectSheetWithEnableAllowFiltering "合同", True
    ProtectSheetWithEnableAllowFiltering "采购单", True
End Sub

Sub ContractToNewPurchaseOrder()
    Dim CurRow As Long
    Dim XMLStr As String
    Dim ContractId As String    '合同编号
    Dim ContractIdGUID As String '合同编号的GUID
    Dim SupplyId As String      '供应商编号
    Dim SupplyIdGUID As String  '供应商编号的GUID
    Dim SupplyType As String    '供应商类型
    Dim CurrencyDictN As String '结算币种
    Dim CurrencyDictId As String    '结算币种Id
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "合同", False
    ProtectSheetWithEnableAllowFiltering "采购单", False
    If TableIsExists("合同") = True Then
        If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        CurRow = Selection.Row

        ContractIdGUID = GetValueByHead("ContractList", CurRow, "合同ID")     '取合同编号GUID
        ContractId = GetValueByHead("ContractList", CurRow, "合同编号")
        SupplyIdGUID = GetValueByHead("ContractList", CurRow, "供应商编号ID")       '取供应商编号GUID
        SupplyId = GetValueByHead("ContractList", CurRow, "供应商编号")
        SupplyType = getMBQTGUID("SupplyBASEList", "供应商编号", GetValueByHead("ContractList", CurRow, "供应商编号"), "DC0_DictName1")   '取供应商类型
        CurrencyDictN = GetValueByHead("ContractList", CurRow, "结算币种")              '取合同的结算币种
        CurrencyDictId = GetValueByHead("ContractList", CurRow, "结算币种ID")       '取结算币种ID
        If GetValueByHead("ContractList", CurRow, "合同状态") = "已审核" Or GetValueByHead("ContractList", CurRow, "合同状态") = "未审核" Then
            Sheets("采购单").Activate
            ClearTable "PurchaseOrderList"
            ClearTable "NewPurchaseOrderList"

            XMLStr = "<ROOT><LIST><Rows><PR1_CONO></PR1_CONO><PR1_DIVI></PR1_DIVI><PR1_OrderId></PR1_OrderId><PR1_OrderCode></PR1_OrderCode><PR1_OrderTypeId></PR1_OrderTypeId>" & _
            "<PR1_PR0_ContractId></PR1_PR0_ContractId><PR1_SU0_SupplierId></PR1_SU0_SupplierId><PR1_BD0_BrandId></PR1_BD0_BrandId><PR1_PurchaseTotal></PR1_PurchaseTotal>" & _
            "<PR1_POriginalAmount></PR1_POriginalAmount><PR1_PurchaseAmount></PR1_PurchaseAmount><PR1_Discount></PR1_Discount><PR1_ExchangeRate></PR1_ExchangeRate>" & _
            "<PR1_Tariff></PR1_Tariff><PR1_VAT></PR1_VAT><PR1_Freight></PR1_Freight><PR1_Times></PR1_Times><PR1_Status></PR1_Status><PR1_RgUser></PR1_RgUser><PR1_RgDt></PR1_RgDt>" & _
            "<PR1_LmUser></PR1_LmUser><PR1_LmDt></PR1_LmDt><PR1_UptNo></PR1_UptNo><PR1_CurrencyTypeId></PR1_CurrencyTypeId><SU0_SupplierCode></SU0_SupplierCode>" & _
            "<BD0_BrandName></BD0_BrandName><PR0_ContractCode></PR0_ContractCode>" & _
            "<OrderTypeDictName></OrderTypeDictName><StatusDictName></StatusDictName><PR1_SupplierType></PR1_SupplierType><CurrencyTypeDictName></CurrencyTypeDictName></Rows></LIST></ROOT>"
        

            XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("NewPurchaseOrderList")))
            CreateTableForXML "NewPurchaseOrderList", XMLStr, "ROOT", "采购单", "A8"
            If GetRowId("NewPurchaseOrderList", "MAX") <> GetRowId("NewPurchaseOrderList", "MIN") Then _
            DeleteRows "采购单", GetRowId("NewPurchaseOrderList", "MIN") & ":" & GetRowId("NewPurchaseOrderList", "MIN")
            Sheets("采购单").Range("A9").Select
            CurRow = Selection.Row
            SetValueByHead "NewPurchaseOrderList", CurRow, "操作", "I"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_CONO", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_DIVI", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderId", "0"
            'SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderCode", "系统生成"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderTypeId", "9FDCF85F-C3AA-4F0A-8621-7AC8A0AB26FD"
            SetValueByHead "NewPurchaseOrderList", CurRow, "OrderTypeDictName", "采购单"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR0_ContractCode", ContractId
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PR0_ContractId", ContractIdGUID
            SetValueByHead "NewPurchaseOrderList", CurRow, "SU0_SupplierCode", SupplyId
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_SU0_SupplierId", SupplyIdGUID
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_SupplierType", SupplyType
            'SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_BD0_BrandId", ""
            SetValueByHead "NewPurchaseOrderList", CurRow, "CurrencyTypeDictName", CurrencyDictN
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_CurrencyTypeId", CurrencyDictId
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PurchaseTotal", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_Status", "40862D71-AAB5-4894-8680-56573725DB2E"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_RgUser", "qianc"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_LmUser", "qianc"
            
            SetValidationStr Range("NewPurchaseOrderList[[BD0_BrandName]]"), GetAddressByHead2("BrandBASEList", "SU0_SupplierCode", SupplyId, "品牌名称")
            SetFormat_NewPurchaseOrderList_All
'            Sheets("采购单").CommandButton10.Enabled = False
'            Sheets("采购单").CommandButton11.Enabled = False
'            Sheets("采购单").CommandButton14.Enabled = False
'            Sheets("采购单").CommandButton17.Enabled = False
'            Sheets("采购单").CommandButton18.Enabled = False
            
        Else: MsgBox "抱歉，合同状态为【未审核】程序不能为您生成新的采购单！"
        End If
    Else: MsgBox "请先加载合同数据，谢谢！   "
    End If
N:
    ProtectSheetWithEnableAllowFiltering "合同", False
End Sub
Sub 新建付款单_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "付款申请单", False
        SetValueByName "付款申请单_Change", "1"
        ClearTable "PayNewList"
        ClearTable "PayList"
        Dim XMLStr As String
        Dim HTID As String
        Dim CurRow As Long
        CurRow = Selection.Row
        
        If GetValueByHead("ContractList", CurRow, "操作") = "U" Or GetValueByHead("ContractList", CurRow, "操作") = "" Then
            MsgBox "请在需要操作行前打“√”谢谢！", vbCritical, "提示"
            GoTo N
        End If
        If GetValueByHead("ContractList", CurRow, "合同状态") = "未审核" Then
            MsgBox "该合同状态为未审核,无法生成付款单！", vbCritical, "提示"
            GoTo N
        End If
        '增加循环开始------by zz 20130901
        Dim RowMIN As String, RowMAX As String, CombGUID As String
        CombGUID = ""
        RowMIN = GetRowId("ContractList", "MIN")
        RowMAX = GetRowId("ContractList", "MAX")
        
        For CurRow = RowMIN To RowMAX
            If GetValueByHead("ContractList", CurRow, "操作") = "√" Then
                CombGUID = CombGUID + "/" + GetValueByHead("ContractList", CurRow, "合同ID")
            End If
        Next CurRow
        '增加循环开始------by zz 20130901
'        Msg "FORM", vbCritical, "", "", CombGUID
        
        XMLStr = "<Interface WSID=""93ccc11f-19ad-4b9c-a794-ce587314cdbb""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNP_PayApply】" & _
        "【返回内容,集团,事业体,申请单ID,申请单编号,合同GUID,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,应付款金额,是否已付款,创建人,创建时间,最后修改人,最后修改时间,修改次数,合同编号,供应商编号,开户行,银行账户,银行SWIFT号】" & _
        "【条件内容,《W》申请单ID,《W》合同GUID,《W》判断】【《W》申请单ID,】【《W》合同GUID," & CombGUID & "/】【《W》判断,合同新建】</ConditionStr>" & _
        "</Interface>"

'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
         XMLStr = GetWsrrRlt(XMLStr)
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PayNewList")))
        
        CreateTableForXML "PayNewList", XMLStr, "ROOT", "付款申请单", "A9"
        If GetRowId("PayNewList", "MAX") <> GetRowId("PayNewList", "MIN") Then _
        DeleteRows "付款申请单", GetRowId("PayNewList", "MIN") & ":" & GetRowId("PayNewList", "MIN")
        Sheets("付款申请单").Activate
        CurRow = Selection.Row
        SetFormat_PayNewList_All
        
        Sheets("付款申请单").Range("D7").Select
        SetValueByName "付款申请单_Change", "0"
N:
    ScreenUpdate True
End Sub
Sub Contract_Check()
    Dim CurRow As Long
    Dim ColumnList As String
    Dim XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "合同", False
    If TableIsExists("合同") = True Then  '如果合同表中存在Table
    SetValueByName "Contract_Change", "1"
        If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        CurRow = Selection.Row
        
        If GetValueByHead("ContractList", CurRow, "合同状态") = "未审核" And GetValueByHead("ContractList", CurRow, "最后修改人") <> Empty Then
            SetValueByHead "ContractList", CurRow, "状态ID", "00DD6348-50D9-4E16-B214-CCFE3CD25D41" '审核状态结果（此处只放已审核的GUID）
            SetValueByHead "ContractList", CurRow, "操作", "C"
            
            ColumnList = "【合同ID】【状态ID】【最后修改人】"
            XMLStr = GetXMLByTableColumn("ContractList", ColumnList, "操作", "C", "=")
            XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
                     " App=""" & GetAppName & """ SessionID="""">" & _
                     " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                     "</ROOT></xml></Interface>"
'            Msg "FORM", vbCritical, "", "", XMLStr
            'Exit Sub
            XMLStr = GetWsrrRlt(XMLStr)
            If GetValueFromXml(XMLStr, "Result") = "true" Then
                SetValueByHead "ContractList", CurRow, "合同状态", "已审核"
                SetValueByHead "ContractList", CurRow, "操作", Empty
                MsgBox "审核成功！      ", vbInformation, "提示"
            Else
                MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
            End If
        Else
            MsgBox "请注意合同状态是否为【未审核】，谢谢！    "
            GoTo N:
        End If
    Else: MsgBox "请先加在数据，谢谢！    "
    End If
    
N:
    ProtectSheetWithEnableAllowFiltering "合同", True
    SetValueByName "Contract_Change", "0"
    ScreenUpdate True
End Sub


Sub Contract_Delete()
    Dim CurRow As Long
    Dim ColumnList As String
    Dim XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "合同", False
    If TableIsExists("合同") = True Then  '如果合同表中存在Table
    SetValueByName "Contract_Change", "1"
        If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        CurRow = Selection.Row
        
        If GetValueByHead("ContractList", CurRow, "合同状态") = "未审核" And GetValueByHead("ContractList", CurRow, "最后修改人") <> Empty Then
            SetValueByHead "ContractList", CurRow, "状态ID", "00DD6348-50D9-4E16-B214-CCFE3CD25D41" '审核状态结果（此处只放已审核的GUID）
            SetValueByHead "ContractList", CurRow, "操作", "D"
            
            ColumnList = "【合同ID】【状态ID】【最后修改人】"
            XMLStr = GetXMLByTableColumn("ContractList", ColumnList, "操作", "D", "=")
            XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
                     " App=""" & GetAppName & """ SessionID="""">" & _
                     " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                     "</ROOT></xml></Interface>"
'            Msg "FORM", vbCritical, "", "", XMLStr
            'Exit Sub
            XMLStr = GetWsrrRlt(XMLStr)
            If GetValueFromXml(XMLStr, "Result") = "true" Then
                SetValueByHead "ContractList", CurRow, "合同状态", "已审核"
                SetValueByHead "ContractList", CurRow, "操作", Empty
                MsgBox "删除成功！      ", vbInformation, "提示"
            Else
                MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
            End If
        Else
            MsgBox "请注意合同状态是否为【未审核】，谢谢！    "
            GoTo N:
        End If
    Else: MsgBox "请先加在数据，谢谢！    "
    End If
    
N:
    ProtectSheetWithEnableAllowFiltering "合同", True
    SetValueByName "Contract_Change", "0"
    ScreenUpdate True
End Sub

