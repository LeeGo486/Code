Attribute VB_Name = "F18_到货计划_控制"
Sub 到货计划_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "到货计划", False
'        SetValueByName "到货计划_Change", "1"
        ClearTable "DeliveryPlan2List"
        ClearTable "DeliveryPlanList"
        Dim XMLStr As String
        Dim CGDH As String
        Dim CurRow As Long
        CurRow = Selection.Row
'        CGDH = GetValueByHead("PurchaseOrderList", CurRow, "采购单ID")
        XMLStr = "<Interface WSID=""fc4bd3e2-c825-45db-a1c5-f4d300752879""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.PRA_ArrivalPlan】" & _
        "【返回内容,集团,事业体,到货计划ID,到货计划编号,供应商编号,供应商编号,采购单编号,采购总数,已到数量,本次计划到货数量,采购金额,已到货金额,本次计划到货金额,数量差异,金额差异,状态,状态对照,创建人,创建时间,最后修改人,最后修改时间,采购单编号】</ConditionStr></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
'        XMLStr = Replace(XMLStr, "'", "\u0027")
        XMLStr = GetWsrrRlt(XMLStr)
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("DeliveryPlan2List")))
        CreateTableForXML "DeliveryPlan2List", XMLStr, "ROOT", "到货计划", "A9"
        If GetRowId("DeliveryPlan2List", "MAX") <> GetRowId("DeliveryPlan2List", "MIN") Then _
        DeleteRows "到货计划", GetRowId("DeliveryPlan2List", "MIN") & ":" & GetRowId("DeliveryPlan2List", "MIN")
        SetFormat_DeliveryPlan2List_All
        'ProtectSheetWithEnableAllowFiltering "到货计划", True
        Sheets("到货计划").Activate
        Sheets("到货计划").Range("C10").Select
'    SetValueByName "到货计划_Change", "0"
'    End If
    ScreenUpdate True
End Sub
Sub 更新明细_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "到货计划明细", False
'        SetValueByName "到货计划明细_Change", "1"
        ClearTable "DeliveryPlanList"
        ClearTable "DeliveryPlanMXList"
        Dim XMLStr As String
        Dim CGDH As String
        Dim CurRow As Long
        CurRow = Selection.Row
        DHJHBH = GetValueByHead("DeliveryPlan2List", CurRow, "到货计划ID")
        CGD = GetValueByHead("DeliveryPlan2List", CurRow, "采购单ID")
        XMLStr = "<Interface WSID=""a7c3649a-4104-4e4d-90e3-d09af73515c1""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.PRAD_ArrivalPlanDetail】" & _
        "【返回内容,集团,事业体,到货计划ID,到货计划编号,商品ID,单位,采购单明细ID,采购原币价,采购本币价,吊牌价,预计到货日期,采购总数,已到数量,已生产计划数量,本次计划到货数量,本次计划到货金额,数量差异,状态,状态对照,创建人,创建时间,最后修改人,最后修改时间,供应商款号,款号,单位对照】" & _
        "【条件内容,《W》到货计划编号,《W》采购单号】【《W》到货计划编号," & DHJHBH & "】【《W》采购单号," & CGD & "】</ConditionStr></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
'        XMLStr = Replace(XMLStr, "'", "\u0027")
        XMLStr = GetWsrrRlt(XMLStr)
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("DeliveryPlanMXList")))
        CreateTableForXML "DeliveryPlanMXList", XMLStr, "ROOT", "到货计划明细", "A6"
        If GetRowId("DeliveryPlanMXList", "MAX") <> GetRowId("DeliveryPlanMXList", "MIN") Then _
        DeleteRows "到货计划明细", GetRowId("DeliveryPlanMXList", "MIN") & ":" & GetRowId("DeliveryPlanMXList", "MIN")
        
        Sheets("到货计划明细").Activate
        SetFormat_DeliveryPlanMXList_All
        CurRow = Selection.Row
        'ProtectSheetWithEnableAllowFiltering "到货计划明细", True
        
        Sheets("到货计划明细").Range("D8").Select
'    SetValueByName "到货计划明细_Change", "0"
'    End If
    ScreenUpdate True
End Sub
Sub 生成付款单_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "付款申请单", False
        SetValueByName "付款申请单_Change", "1"
        ClearTable "PayNewList"
        ClearTable "PayList"
        ClearTable "PayDHList"
        ClearTable "PayTHList"
        Dim XMLStr As String
        Dim HTID As String
        Dim CurRow As Long
        CurRow = Selection.Row

        If GetValueByHead("DeliveryPlan2List", CurRow, "操作") = "U" Or GetValueByHead("DeliveryPlan2List", CurRow, "操作") = "" Then
            MsgBox "请在需要操作行前打“√”谢谢！", vbCritical, "提示"
            GoTo N
        End If
        '增加循环开始------by zz 20130901
        Dim RowMIN As String, RowMAX As String, CombGUID As String
        CombGUID = ""
        RowMIN = GetRowId("DeliveryPlan2List", "MIN")
        RowMAX = GetRowId("DeliveryPlan2List", "MAX")
        
        For CurRow = RowMIN To RowMAX
            If GetValueByHead("DeliveryPlan2List", CurRow, "操作") = "√" Then
                CombGUID = CombGUID + "/" + GetValueByHead("DeliveryPlan2List", CurRow, "到货计划ID")
            End If
        Next CurRow
        '增加循环开始------by zz 20130901
'        Msg "FORM", vbCritical, "", "", CombGUID
        
        XMLStr = "<Interface WSID=""b6ec361f-b577-4c3f-a2d2-9b686b265f31""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNP_PayApply】" & _
        "【返回内容,集团,事业体,申请单ID,申请单编号,到货计划GUID,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,应付款金额,是否已付款,创建人,创建时间,最后修改人,最后修改时间,修改次数,合同编号,供应商编号,开户行,银行账户,银行SWIFT号】" & _
        "【条件内容,《W》判断,《W》到货计划GUID】【《W》判断,到货新建】【《W》到货计划GUID," & CombGUID & "/】</ConditionStr></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub

        XMLStr = GetWsrrRlt(XMLStr)

        Msg "FORM", vbCritical, "", "", XMLStr
        Exit Sub
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PayDHList")))
        
        CreateTableForXML "PayDHList", XMLStr, "ROOT", "付款申请单", "A9"
        If GetRowId("PayDHList", "MAX") <> GetRowId("PayDHList", "MIN") Then _
        DeleteRows "付款申请单", GetRowId("PayDHList", "MIN") & ":" & GetRowId("PayDHList", "MIN")

        SetFormat_PayDHList_All
        Sheets("付款申请单").Activate
        CurRow = Selection.Row
        SetValueByHead "PayDHList", CurRow + 1, "操作", "I"
        'ProtectSheetWithEnableAllowFiltering "付款申请单", True
        
        Sheets("付款申请单").Range("D7").Select
        SetValueByName "付款申请单_Change", "0"
N:
    ScreenUpdate True
End Sub
Sub DHtoRecDetails()
    Dim ReRow As Long, DHId As String, XMLStr As String, RecDetGUID As String
    
    ScreenUpdate False
    ProtectSheet "收货明细", False
    ProtectSheet "到货计划", False
    SetValueByName "收货明细_Change", "1"
    
    If TableIsExists("到货计划") = True Then
        If CheckSelectionInTable("DeliveryPlan2List", True) = False Then GoTo N
        ReRow = Selection.Row
        DHId = GetValueByHead("DeliveryPlan2List", ReRow, "到货计划ID")     '获取到货计划ID
        
        XMLStr = "<Interface WSID=""e77c9315-4ae9-442a-a2c6-7c1af2c31f31""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.PRBD_ReceiveDetail】" & _
        "【返回内容,到货计划ID,到货计划明细ID,商品ID,收货单主表ID,供应商款号,供应商颜色,收货单类型,供应商尺码,款号,颜色,尺码,单位,单位对照," & _
        "计划到货主表数量,计划到货主表金额,采购原币价,采购本币价,吊牌价,计划到货数量,收货数量,入仓ID,供应商编号】" & _
        "【条件内容,《W》收货单编号,《W》到货计划主表ID】【《W》收货单编号,】【《W》到货计划主表ID," & DHId & "】</ConditionStr></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        XMLStr = GetWsrrRlt(XMLStr)

        Sheets("收货明细").Activate
        ClearTable "RecDetailsList"
        ClearTable "ReceiptMDList"
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("")))
        CreateTableForXML "RecDetailsList", XMLStr, "ROOT", "收货明细", "A9"
        If GetRowId("RecDetailsList", "MAX") <> GetRowId("RecDetailsList", "MIN") Then _
        DeleteRows "收货明细", GetRowId("RecDetailsList", "MIN") & ":" & GetRowId("RecDetailsList", "MIN")
        ReplaceTableHead "RecDetailsList", GetHeadMap("RecDetailsList")
        RecDetGUID = Mid$(CreateObject("Scriptlet.TypeLib").Guid, 2, 36)
'        ReRow = GetTableRowId("RecDetailsList", 1)
        For I = GetTableRowId("RecDetailsList", 1) To GetTableRowId("RecDetailsList", -1)
            ReRow = I
            If Cells(I, 1) = Empty Then
                SetValueByHead "RecDetailsList", ReRow, "操作", "I"
                SetValueByHead "RecDetailsList", ReRow, "收货单主表GUID", RecDetGUID
            End If
        Next
'        Sheets("收货明细").CommandButton1.Enabled = True
'        Sheets("收货明细").CommandButton2.Enabled = True
'        Sheets("收货明细").CommandButton3.Enabled = True
    Else: MsgBox "请先加载【到货计划】的数据，谢谢！ "
        GoTo N
    End If
N:
    ProtectSheet "收货明细", False
    ProtectSheet "到货计划", False
    SetValueByName "收货明细_Change", "0"
    ScreenUpdate False
End Sub

