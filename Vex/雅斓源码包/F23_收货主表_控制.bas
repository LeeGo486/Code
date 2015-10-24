Attribute VB_Name = "F23_收货主表_控制"
Sub RecDetailsMain_Load()
    Dim XMLStr As String
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "收货主表", False
    ClearTable "RecDetailsMainList"
    XMLStr = "<Interface WSID=""cf511a4e-118b-470c-b127-99995f77013f""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat>" & _
            "<OutputContentType>RS</OutputContentType>" & _
            "<ConditionStr>【操作类型,GET】【实体,B02_Bill.PRB_Receipt】" & _
            "【返回内容,集团,事业体,收货单ID,收货单编号,到货主表计划ID,收货单类型,计划到货数量,计划到货金额,此次收货数量,此次收货金额," & _
            "收货时间,状态,状态对照,创建人,创建时间,最后修改人,最后修改时间,到货计划编号,收货单类型对照】" & _
            "【条件内容 , 《W》收货单ID】" & _
            "【《W》收货单ID,】</ConditionStr></Interface>"
    XMLStr = GetWsrrRlt(XMLStr)
    'Msg "FORM", vbCritical, "", "", XMLStr
    'Exit Sub
    XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("RecDetailsMainList")))
    CreateTableForXML "RecDetailsMainList", XMLStr, "ROOT", "收货主表", "A9"
    If GetRowId("RecDetailsMainList", "MAX") <> GetRowId("RecDetailsMainList", "MIN") Then _
    DeleteRows "收货主表", GetRowId("RecDetailsMainList", "MIN") & ":" & GetRowId("RecDetailsMainList", "MIN")
'    ReplaceTableHead "RecDetailsMainList", GetHeadMap("RecDetailsMainList")
    SetFormat_RecDetailsMainList_All
    Sheets("收货主表").Range("E10").Select
N:
    ProtectSheetWithEnableAllowFiltering "收货主表", False
    ScreenUpdate False
End Sub

Sub MainToDetails_load()
    Dim XMLStr As String, GRNId As String, ArrivalPlanId As String, ReRow As Long
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "收货主表", False
    ProtectSheetWithEnableAllowFiltering "收货明细", False
    SetValueByName "收货明细_Change", "1"
    
    If TableIsExists("收货主表") = False Then GoTo N
    If CheckSelectionInTable("RecDetailsMainList", True) = False Then GoTo N
    ReRow = Selection.Row
    GRNId = GetValueByHead("RecDetailsMainList", ReRow, "收货单编号")
    ArrivalPlanId = GetValueByHead("RecDetailsMainList", ReRow, "收货单ID")
    
    Sheets("收货明细").Activate
    ClearTable "ReceiptMDList"
    ClearTable "RecDetailsList"
    XMLStr = "<Interface WSID=""e77c9315-4ae9-442a-a2c6-7c1af2c31f31""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat>" & _
            "<OutputContentType>RS</OutputContentType>" & _
            "<ConditionStr>【操作类型,GET】【实体,B02_Bill.PRBD_ReceiveDetail】" & _
            "【返回内容,集团,事业体,收货单ID,收货单编号,收货单类型,商品ID,单位,到货计划ID,到货计划明细ID,采购原币价," & _
            "采购本币价,吊牌价,入仓ID,计划到货主表数量,计划到货主表金额,储位,收货数量,计划到货数量,计划到货金额,POS_入库单号," & _
            "状态,创建人,创建时间,最后修改人,最后修改时间,供应商款号,款号,单位对照】" & _
            "【条件内容,《W》收货单编号,《W》收货单主表ID】" & _
            "【《W》收货单编号," & ArrivalPlanId & "】【《W》收货单主表ID," & ArrivalPlanId & "】</ConditionStr></Interface>"
'                Msg "FORM", vbCritical, "", "", XMLStr
'    Exit Sub
    XMLStr = GetWsrrRlt(XMLStr)

    XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("")))
    CreateTableForXML "ReceiptMDList", XMLStr, "ROOT", "收货明细", "A9"
    If GetRowId("ReceiptMDList", "MAX") <> GetRowId("ReceiptMDList", "MIN") Then _
    DeleteRows "收货明细", GetRowId("ReceiptMDList", "MIN") & ":" & GetRowId("ReceiptMDList", "MIN")
    ReplaceTableHead "ReceiptMDList", GetHeadMap("ReceiptMDList")
'    Sheets("收货明细").CommandButton1.Enabled = False
'    Sheets("收货明细").CommandButton2.Enabled = False
'    Sheets("收货明细").CommandButton3.Enabled = False
N:
    ProtectSheetWithEnableAllowFiltering "收货主表", False
    ProtectSheetWithEnableAllowFiltering "收货明细", False
    ScreenUpdate False
    SetValueByName "收货明细_Change", "0"
End Sub

Sub Receipt_Check()
    Dim ReRow As Long, ReceiptId As String, XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "收货主表", False
    If TableIsExists("收货主表") = False Then GoTo N
    If CheckSelectionInTable("RecDetailsMainList", True) = False Then GoTo N
    ReRow = Selection.Row
    If GetValueByHead("RecDetailsMainList", ReRow, "状态") = "已审核" Or GetValueByHead("RecDetailsMainList", ReRow, "状态") = "已删除" Then
        MsgBox "抱歉,该收货单【已审核】或【已删除】无法修改！"
        GoTo N
    Else
        If GetValueByHead("RecDetailsMainList", ReRow, "状态") = "未审核" Then
            ReceiptId = GetValueByHead("RecDetailsMainList", ReRow, "收货单ID")
            
            XMLStr = "<Interface WSID=""cf511a4e-118b-470c-b127-99995f77013f""" & _
                " App=""" & GetAppName & """ SessionID="""">" & _
                "<InputFormat>AML</InputFormat>" & _
                "<OutputContentType>RS</OutputContentType>" & _
                "<ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.PRB_Receipt】" & _
                "【更新内容,状态】【条件内容,《N》状态,《W》收货单ID】" & _
                "【《N》状态,00DD6348-50D9-4E16-B214-CCFE3CD25D41】【《W》收货单ID," & ReceiptId & "】</ConditionStr></Interface>"
            XMLStr = GetWsrrRlt(XMLStr)
            If GetValueFromXml(XMLStr, "Root") = "" Then
                SetValueByHead "RecDetailsMainList", ReRow, "状态", "已审核"
                MsgBox "审核成功，谢谢！   "
            Else
                MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                GoTo N
            End If
        End If
    End If
N:
    ProtectSheetWithEnableAllowFiltering "收货主表", False
    ScreenUpdate False
End Sub

Sub Receipt_Delete()
    Dim ReRow As Long, ReceiptId As String, XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "收货主表", False
    If TableIsExists("收货主表") = False Then GoTo N
    If CheckSelectionInTable("RecDetailsMainList", True) = False Then GoTo N
    ReRow = Selection.Row
    If GetValueByHead("RecDetailsMainList", ReRow, "状态") = "已审核" Or GetValueByHead("RecDetailsMainList", ReRow, "状态") = "已删除" Then
        MsgBox "抱歉,该收货单【已审核】或【已删除】无法修改！"
        GoTo N
    Else
        If GetValueByHead("RecDetailsMainList", ReRow, "状态") = "未审核" Then
            ReceiptId = GetValueByHead("RecDetailsMainList", ReRow, "收货单ID")
            
            XMLStr = "<Interface WSID=""cf511a4e-118b-470c-b127-99995f77013f""" & _
                " App=""" & GetAppName & """ SessionID="""">" & _
                "<InputFormat>AML</InputFormat>" & _
                "<OutputContentType>RS</OutputContentType>" & _
                "<ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.PRB_Receipt】" & _
                "【更新内容,状态】【条件内容,《N》状态,《W》收货单ID】" & _
                "【《N》状态,E3CA9B7A-8E17-4E52-B667-39689445D4A1】【《W》收货单ID," & ReceiptId & "】</ConditionStr></Interface>"
            XMLStr = GetWsrrRlt(XMLStr)
            If GetValueFromXml(XMLStr, "Root") = "" Then
                SetValueByHead "RecDetailsMainList", ReRow, "状态", "已删除"
                MsgBox "删除成功，谢谢！   "
            Else
                MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                GoTo N
            End If
        End If
    End If
N:
    ProtectSheetWithEnableAllowFiltering "收货主表", False
    ScreenUpdate False
End Sub


