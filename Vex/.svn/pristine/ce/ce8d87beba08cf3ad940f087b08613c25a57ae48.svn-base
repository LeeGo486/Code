Attribute VB_Name = "F25_退货主表_控制"
Sub Returnbill_Load()
    Dim XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    
    ClearTable "ReturnBillMainList"
    
    XMLStr = "<Interface WSID=""88825423-cfa2-4426-ab9a-3163bb0d7c5c""" & _
            " App=""ITDC_EXCEL"" SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType>" & _
            "<ConditionStr>【操作类型,GET】【实体,B02_Bill.PRC_Return】" & _
            "【返回内容,集团,事业体,退货单主表ID,退货单编号,采购单ID,采购单编号,供应商ID,退货总数,退货总金额,状态," & _
            "创建人,创建时间,最后修改人,最后修改时间,采购单编号,状态对照】" & _
            "</ConditionStr></Interface>"
    XMLStr = GetWsrrRlt(XMLStr)
'    Msg "FORM", vbCritical, "", "", XMLStr
'    Exit Sub
    XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("ReturnBillMainList")))
    CreateTableForXML "ReturnBillMainList", XMLStr, "ROOT", "退货主表", "A9"
    If GetRowId("ReturnBillMainList", "MAX") <> GetRowId("ReturnBillMainList", "MIN") Then _
    DeleteRows "退货主表", GetRowId("ReturnBillMainList", "MIN") & ":" & GetRowId("ReturnBillMainList", "MIN")
    ReplaceTableHead "ReturnBillMainList", GetHeadMap("ReturnBillMainList")
    Sheets("退货主表").Range("B10").Select
N:
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    ScreenUpdate False
End Sub

Sub ReturnBillDetails()
    Dim ReRow As Long, XMLStr As String, RetBDId As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    ProtectSheetWithEnableAllowFiltering "退货明细", False
    
    If TableIsExists("退货主表") = False Then GoTo N
    If CheckSelectionInTable("ReturnBillMainList", True) = False Then GoTo N
    ReRow = Selection.Row
    RetBDId = GetValueByHead("ReturnBillMainList", ReRow, "退货单主表ID")
    
    Sheets("退货明细").Activate
    ClearTable "ReturnBillDetailsList"
    ClearTable "ReturnBillDList"
    XMLStr = "<Interface WSID=""7163bbde-858e-4138-94fb-60d031963570""" & _
            " App=""ITDC_EXCEL"" SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType>" & _
            "<ConditionStr>【操作类型,GET】【实体,B02_Bill.PRCD_ReturnDetail】" & _
            "【返回内容,集团,事业体,退货单明细ID,退货单主表ID,退货单编号,商品ID,单位,采购单主表ID,供应商GUID,采购单明细ID,采购原币价," & _
            "采购本比价,吊牌价,退货仓ID,POS_退货单号,退货数量,采购总数,已到数量,已生产计划数量,本次计划到货数量,本次计划到货金额,数量差异," & _
            "退货金额,退货原因,状态,创建人,创建时间,最后修改人,最后修改时间,供应商款号,供应商颜色,供应商尺码,颜色,尺码,款号,单位对照】" & _
            "【条件内容,条件内容,《W》退货单主表ID,《W》采购单主表ID】【《W》退货单主表ID," & RetBDId & "】</ConditionStr></Interface>"

    XMLStr = GetWsrrRlt(XMLStr)
'            Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
    
    XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("ReturnBillDetailsList")))
    CreateTableForXML "ReturnBillDetailsList", XMLStr, "ROOT", "退货明细", "A9"
    If GetRowId("ReturnBillDetailsList", "MAX") <> GetRowId("ReturnBillDetailsList", "MIN") Then _
    DeleteRows "退货明细", GetRowId("ReturnBillDetailsList", "MIN") & ":" & GetRowId("ReturnBillDetailsList", "MIN")
    ReplaceTableHead "ReturnBillDetailsList", GetHeadMap("ReturnBillDetailsList")
    
'    Sheets("退货明细").CommandButton1.Enabled = False   '主表到明细表只能读取，对读取的数据只能更新，不能启用新建保存按钮
N:
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    ProtectSheetWithEnableAllowFiltering "退货明细", False
    ScreenUpdate False
End Sub


Sub Return_Check()
    Dim ReRow As Long, ReturnId As String, XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    If TableIsExists("退货主表") = False Then GoTo N
    If CheckSelectionInTable("ReturnBillMainList", True) = False Then GoTo N
    ReRow = Selection.Row
    If GetValueByHead("ReturnBillMainList", ReRow, "状态") = "已审核" Or GetValueByHead("ReturnBillMainList", ReRow, "状态") = "已删除" Then
        MsgBox "抱歉,该收货单【已审核】或【已删除】无法修改！"
        GoTo N
    Else
        If GetValueByHead("ReturnBillMainList", ReRow, "状态") = "未审核" Then
            ReturnId = GetValueByHead("ReturnBillMainList", ReRow, "退货单主表ID")
            
            XMLStr = "<Interface WSID=""88825423-cfa2-4426-ab9a-3163bb0d7c5c""" & _
                " App=""ITDC_EXCEL"" SessionID="""">" & _
                "<InputFormat>AML</InputFormat>" & _
                "<OutputContentType>RS</OutputContentType>" & _
                "<ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.PRC_Return】" & _
                "【更新内容,状态】【条件内容,《N》状态,《W》退货单主表ID】" & _
                "【《N》状态,00DD6348-50D9-4E16-B214-CCFE3CD25D41】【《W》退货单主表ID," & ReturnId & "】</ConditionStr></Interface>"
'            Msg "FORM", vbCritical, "", "", XMLStr
'            Exit Sub
            XMLStr = GetWsrrRlt(XMLStr)

            If GetValueFromXml(XMLStr, "Root") = "" Then
                SetValueByHead "ReturnBillMainList", ReRow, "状态", "已审核"
                MsgBox "审核成功，谢谢！   "
            Else
                MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                GoTo N
            End If
        End If
    End If
N:
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    ScreenUpdate False
End Sub

Sub Return_Delete()
    Dim ReRow As Long, ReturnId As String, XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    If TableIsExists("退货主表") = False Then GoTo N
    If CheckSelectionInTable("ReturnBillMainList", True) = False Then GoTo N
    ReRow = Selection.Row
    If GetValueByHead("ReturnBillMainList", ReRow, "状态") = "已审核" Or GetValueByHead("ReturnBillMainList", ReRow, "状态") = "已删除" Then
        MsgBox "抱歉,该收货单【已审核】或【已删除】无法修改！"
        GoTo N
    Else
        If GetValueByHead("ReturnBillMainList", ReRow, "状态") = "未审核" Then
            ReturnId = GetValueByHead("ReturnBillMainList", ReRow, "退货单主表ID")
            
            XMLStr = "<Interface WSID=""88825423-cfa2-4426-ab9a-3163bb0d7c5c""" & _
                " App=""ITDC_EXCEL"" SessionID="""">" & _
                "<InputFormat>AML</InputFormat>" & _
                "<OutputContentType>RS</OutputContentType>" & _
                "<ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.PRC_Return】" & _
                "【更新内容,状态】【条件内容,《N》状态,《W》退货单主表ID】" & _
                "【《N》状态,E3CA9B7A-8E17-4E52-B667-39689445D4A1】【《W》退货单主表ID," & ReturnId & "】</ConditionStr></Interface>"
            XMLStr = GetWsrrRlt(XMLStr)
            If GetValueFromXml(XMLStr, "Root") = "" Then
                SetValueByHead "ReturnBillMainList", ReRow, "状态", "已审核"
                MsgBox "删除成功，谢谢！   "
            Else
                MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                GoTo N
            End If
        End If
    End If
N:
    ProtectSheetWithEnableAllowFiltering "退货主表", False
    ScreenUpdate False
End Sub
Sub 生成退款单_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "付款申请单", False
'        SetValueByName "付款申请单_Change", "1"
        ClearTable "PayNewList"
        ClearTable "PayList"
        ClearTable "PayTHList"
        ClearTable "PayDHList"
        Dim XMLStr As String
        Dim HTID As String
        Dim CurRow As Long
        CurRow = Selection.Row
        
        If GetValueByHead("ReturnBillMainList", CurRow, "操作") = "" Then
            MsgBox "请在需要操作行前打“√”谢谢！", vbCritical, "提示"
            GoTo N
        End If
        If GetValueByHead("ReturnBillMainList", CurRow, "状态") = "未审核" Then
            MsgBox "该退款单状态为未审核,无法生成付款单！", vbCritical, "提示"
            GoTo N
        End If
'        增加循环开始------by zz 20130901
        Dim RowMIN As String, RowMAX As String, CombGUID As String
        CombGUID = ""
        RowMIN = GetRowId("ReturnBillMainList", "MIN")
        RowMAX = GetRowId("ReturnBillMainList", "MAX")

        For CurRow = RowMIN To RowMAX
            If GetValueByHead("ReturnBillMainList", CurRow, "操作") = "√" Then
                CombGUID = CombGUID + "/" + GetValueByHead("ReturnBillMainList", CurRow, "退货单主表ID")
            End If
        Next CurRow
'        增加循环开始------by zz 20130901
'        Msg "FORM", vbCritical, "", "", CombGUID
        
        XMLStr = "<Interface WSID=""5352bd6f-6933-48a8-8d06-cf6ffb8d67bd""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNP_PayApply】" & _
        "【返回内容,集团,事业体,申请单ID,申请单编号,退货单GUID,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,应付款金额,是否已付款,创建人,创建时间,最后修改人,最后修改时间,修改次数,合同编号,供应商编号,开户行,银行账户,银行SWIFT号】" & _
        "【条件内容,《W》退货单GUID,《W》判断】【《W》判断,退货新建】【《W》退货单GUID," & CombGUID & "/】" & _
        "</ConditionStr></Interface>"

'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
         XMLStr = GetWsrrRlt(XMLStr)

        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PayTHList")))
        CreateTableForXML "PayTHList", XMLStr, "ROOT", "付款申请单", "A9"
        If GetRowId("PayTHList", "MAX") <> GetRowId("PayTHList", "MIN") Then _
        DeleteRows "付款申请单", GetRowId("PayTHList", "MIN") & ":" & GetRowId("PayTHList", "MIN")
        Sheets("付款申请单").Activate
        CurRow = Selection.Row
        SetValueByHead "PayTHList", CurRow + 1, "操作", "I"
        SetFormat_PayTHList_All
        
        Sheets("付款申请单").Range("A9").Select
'        SetValueByName "付款申请单_Change", "0"
N:
    ScreenUpdate True
End Sub

