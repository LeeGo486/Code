Attribute VB_Name = "F26_退货明细_控制"
Sub ReturnBillD_Save()
    Dim ReRow As Long, XMLStr As String, wrksht As Worksheet
    Dim A As String, B As String, C As String, D As String, E As String, F As String, G As String, H As String, I As String
    Dim J As String, K As String, L As String, M As String, N As String
    
    ScreenUpdate False
    ProtectSheet "退货明细", False
    Set wrksht = ActiveWorkbook.Worksheets("退货明细")
    If TableIsExists("退货明细") = False Then GoTo N
    If wrksht.ListObjects(1).Name = "ReturnBillDList" Then
        For X = GetTableRowId("ReturnBillDList", 1) To GetTableRowId("ReturnBillDList", -1)
            ReRow = X
            If GetValueByHead("ReturnBillDList", ReRow, "操作") = "I" Then
                A = GetValueByHead("ReturnBillDList", ReRow, "商品ID")
                B = GetValueByHead("ReturnBillDList", ReRow, "单位ID")
                C = GetValueByHead("ReturnBillDList", ReRow, "采购单明细ID")
                D = GetValueByHead("ReturnBillDList", ReRow, "采购原币价")
                E = GetValueByHead("ReturnBillDList", ReRow, "采购本币价")
                F = GetValueByHead("ReturnBillDList", ReRow, "吊牌价")
                G = GetValueByHead("ReturnBillDList", ReRow, "退货数量")
                H = GetValueByHead("ReturnBillDList", ReRow, "状态ID")
                I = GetValueByHead("ReturnBillDList", ReRow, "退货单主表ID")
                J = GetValueByHead("ReturnBillDList", ReRow, "退货单编号")
                K = GetValueByHead("ReturnBillDList", ReRow, "供应商GUID")
                L = GetValueByHead("ReturnBillDList", ReRow, "采购单主表ID")
                M = GetValueByHead("ReturnBillDList", ReRow, "采购单主表ID") '采购单编号
                N = GetValueByHead("ReturnBillDList", ReRow, "退货原因")
                
                XMLStr = "<Interface WSID=""7163bbde-858e-4138-94fb-60d031963570""" & _
                " App=""ITDC_EXCEL"" SessionID="""">" & _
                "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,NEW】【实体,B02_Bill.PRCD_ReturnDetail】" & _
                "【新增内容,商品ID,单位,采购单明细ID,采购原币价,采购本币价,吊牌价,退货数量,状态,创建人,最后修改人,退货单主表ID,退货单编号,供应商ID," & _
                "采购单主表ID,采购单编号,退货原因】" & _
                "【条件内容,《N》商品ID,《N》单位,《N》采购单明细ID,《N》采购原币价,《N》采购本币价,《N》吊牌价,《N》退货数量,《N》状态," & _
                "《N》创建人,《N》最后修改人,《N》退货单主表ID,《N》退货单编号,《N》供应商ID,《N》采购单主表ID,《N》采购单编号,《N》退货原因】" & _
                "【《N》商品ID," & A & "】【《N》单位," & B & "】【《N》采购单明细ID," & C & "】【《N》采购原币价," & D & "】" & _
                "【《N》采购本币价," & E & "】【《N》吊牌价," & F & "】【《N》退货数量," & G & "】【《N》状态," & H & "】" & _
                "【《N》创建人,qianc】【《N》最后修改人,qianc】【《N》退货单主表ID," & I & "】【《N》退货单编号,】" & _
                "【《N》供应商ID," & K & "】【《N》采购单主表ID," & L & "】【《N》采购单编号," & M & "】【《N》退货原因," & N & "】" & _
                "</ConditionStr></Interface>"
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                If GetValueFromXml(XMLStr, "Root") = "" Then
                    SetValueByHead "ReturnBillDList", ReRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                    GoTo N
                End If
            End If
        Next
        Sheets("退货明细").CommandButton2.Enabled = ture
        MsgBox "恭喜你，保存成功！ "
    End If
N:
    ProtectSheet "退货明细", False
    ScreenUpdate False
End Sub

Sub ReturnBillD_Update()
    
    Dim XMLStr As String, ReRow As Long, wrksht As Worksheet
    Dim POId As String, CoId As String, RetMId As String, RetDId As String
    Dim RetQ As String  '退货数量
    Dim RetR As String  '退货原因
    
    ScreenUpdate False
    ProtectSheet "退货明细", False
    Set wrksht = ActiveWorkbook.Worksheets("退货明细")
    If TableIsExists("退货明细") = False Then GoTo N
    If wrksht.ListObjects(1).Name = "ReturnBillDList" Then                  '如果退货单明细保存成功，但是发现错误需要修改数量或退货原因时执行下面这段
        If CheckSelectionInTable("ReturnBillDList", True) = False Then GoTo N
        ReRow = Selection.Row
        If GetValueByHead("ReturnBillDList", ReRow, "操作") = "F" Then
            If GetValueByHead("ReturnBillDList", ReRow, "状态") = "未审核" Then
                POId = GetValueByHead("ReturnBillDList", ReRow, "采购单明细ID")
                CoId = GetValueByHead("ReturnBillDList", ReRow, "商品ID")
                RetMId = GetValueByHead("ReturnBillDList", ReRow, "退货单主表ID")
                RetDId = GetValueByHead("ReturnBillDList", ReRow, "退货单明细ID")
                RetQ = GetValueByHead("ReturnBillDList", ReRow, "退货数量")
                RetR = GetValueByHead("ReturnBillDList", ReRow, "退货原因")
                XMLStr = "<Interface WSID=""7163bbde-858e-4138-94fb-60d031963570""" & _
                    " App=""ITDC_EXCEL"" SessionID="""">" & _
                    "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.PRCD_ReturnDetail】" & _
                    "【更新内容,《N》退货数量,《N》退货原因,《N》最后修改人】" & _
                    "【条件内容,《N》退货数量,《N》退货原因,《W》集团,《W》事业体,《W》采购单明细ID,《W》商品ID,《W》退货单明细ID,《W》退货单主表ID】" & _
                    "【《N》退货数量," & RetQ & "】【《N》退货原因," & RetR & "】【《N》最后修改人,qianc】" & _
                    "【《W》集团,100】【《W》事业体,200】【《W》采购单明细ID," & POId & "】【《W》商品ID," & CoId & "】【《W》退货单明细ID," & RetDId & "】【《W》退货单主表ID," & RetMId & "】" & _
                    "</ConditionStr></Interface>"
                XMLStr = GetWsrrRlt(XMLStr)
                
                If GetValueFromXml(XMLStr, "Root") = "" Then
                    MsgBox "恭喜，更新成功。"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                    GoTo N
                End If
            Else: MsgBox "抱歉，该行的状态不是【未审核】，无法更新。"
                GoTo N
            End If
        Else: MsgBox "抱歉，更新按钮只能更新操作列标识为F的行。"
            GoTo N
        End If
    Else
        If wrksht.ListObjects(1).Name = "ReturnBillDetailsList" Then    '如果从退货主表到查看明细发现数量或者原因不对的时候，执行下面这段
            If CheckSelectionInTable("ReturnBillDetailsList", True) = False Then GoTo N
            ReRow = Selection.Row
            If GetValueByHead("ReturnBillDetailsList", ReRow, "状态") = "未审核" Then
                POId = GetValueByHead("ReturnBillDetailsList", ReRow, "采购单明细ID")
                CoId = GetValueByHead("ReturnBillDetailsList", ReRow, "商品ID")
                RetMId = GetValueByHead("ReturnBillDetailsList", ReRow, "退货单主表ID")
                RetDId = GetValueByHead("ReturnBillDetailsList", ReRow, "退货单明细ID")
                RetQ = GetValueByHead("ReturnBillDetailsList", ReRow, "退货数量")
                RetR = GetValueByHead("ReturnBillDetailsList", ReRow, "退货原因")
                
                XMLStr = "<Interface WSID=""7163bbde-858e-4138-94fb-60d031963570""" & _
                    " App=""ITDC_EXCEL"" SessionID="""">" & _
                    "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.PRCD_ReturnDetail】" & _
                    "【更新内容,《N》退货数量,《N》退货原因,《N》最后修改人】" & _
                    "【条件内容,《N》退货数量,《N》退货原因,《W》集团,《W》事业体,《W》采购单明细ID,《W》商品ID,《W》退货单明细ID,《W》退货单主表ID】" & _
                    "【《N》退货数量," & RetQ & "】【《N》退货原因," & RetR & "】【《N》最后修改人,qianc】" & _
                    "【《W》集团,100】【《W》事业体,200】【《W》采购单明细ID," & POId & "】【《W》商品ID," & CoId & "】【《W》退货单明细ID," & RetDId & "】【《W》退货单主表ID," & RetMId & "】" & _
                    "</ConditionStr></Interface>"
                XMLStr = GetWsrrRlt(XMLStr)
                If GetValueFromXml(XMLStr, "Root") = "" Then
                    MsgBox "恭喜，更新成功。"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                    GoTo N
                End If
            Else: MsgBox "抱歉，该行的状态不是【未审核】，无法更新。"
                GoTo N
            End If
        End If
    End If
N:
    ProtectSheet "退货明细", False
    ScreenUpdate False
End Sub


