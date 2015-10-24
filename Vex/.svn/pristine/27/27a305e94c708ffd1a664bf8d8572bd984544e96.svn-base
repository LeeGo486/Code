Attribute VB_Name = "F21_收货明细_控制"
Sub RecDetails_Save()
    Dim A As String, B As String, C As String, D As String, E As String, F As String, G As String, H As Integer, Q As String
    Dim R As String, I As Integer, J As String, K As String, L As String, M As String, N As String, O As String, p As String
    Dim XMLStr As String, CurRow As Long, wrksht As Worksheet
    
    ScreenUpdate False
    ProtectSheet "收货明细", False
    Set wrksht = ActiveWorkbook.Worksheets("收货明细")
    If TableIsExists("收货明细") = False Then GoTo N
    
    If wrksht.ListObjects(1).Name = "RecDetailsList" Then
        For X = GetTableRowId("RecDetailsList", 1) To GetTableRowId("RecDetailsList", -1)
            If Cells(X, 1) = "I" Then
                CurRow = X
                H = GetValueByHead("RecDetailsList", CurRow, "计划到货数量") '计划到货数量
                I = GetValueByHead("RecDetailsList", CurRow, "本次收货数量") '收货数量
                If H < I Then
                    MsgBox "收货数量超出计划数量，请检查！"
                    GoTo N
                End If
            End If
        Next
        For X = GetTableRowId("RecDetailsList", 1) To GetTableRowId("RecDetailsList", -1)
            If Cells(X, 1) = "I" Then
                CurRow = X
                A = GetValueByHead("RecDetailsList", CurRow, "商品ID")  '商品ID
                B = GetValueByHead("RecDetailsList", CurRow, "单位GUID") '单位GUID
                C = GetValueByHead("RecDetailsList", CurRow, "到货计划明细ID") '到货计划明细ID
                D = GetValueByHead("RecDetailsList", CurRow, "采购原币价（单件）") '采购原币价（单件）
                E = GetValueByHead("RecDetailsList", CurRow, "采购本币价（单件）") '采购本币价（单件）
                F = GetValueByHead("RecDetailsList", CurRow, "吊牌价")  '吊牌价
                G = GetValueByHead("RecDetailsList", CurRow, "入仓ID")  '入仓ID
                H = GetValueByHead("RecDetailsList", CurRow, "计划到货数量") '计划到货数量
                I = GetValueByHead("RecDetailsList", CurRow, "本次收货数量") '收货数量
                J = GetValueByHead("RecDetailsList", CurRow, "收货单主表GUID") '收货单主表GUID
                K = Cells(6, 4) '收货单编号
                L = GetValueByHead("RecDetailsList", CurRow, "到货计划ID")  '到货计划主表ID
                M = GetValueByHead("RecDetailsList", CurRow, "收货单类型")  '收货单类型
                N = GetValueByHead("RecDetailsList", CurRow, "计划到货主表数量") '计划到货主表数量
                O = GetValueByHead("RecDetailsList", CurRow, "计划到货主表金额") '计划到货主表金额
                p = GetValueByHead("RecDetailsList", CurRow, "供应商编号") '供应商编号
                XMLStr = "<Interface WSID=""e77c9315-4ae9-442a-a2c6-7c1af2c31f31""" & _
                " App=""" & GetAppName & """ SessionID="""">" & _
                "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,NEW】【实体,B02_Bill.PRBD_ReceiveDetail】" & _
                "【新增内容,商品ID,单位,到货计划明细ID,采购原币价,采购本币价,吊牌价,入仓ID,计划到货数量,收货数量,状态,创建人,最后修改人" & _
                "收货单主表ID,收货单编号,到货计划主表ID,,收货单类型,计划到货主表数量,计划到货主表金额,收货时间,供应商编号】" & _
                "【条件内容,《N》商品ID,《N》单位,《N》到货计划明细ID,《N》采购原币价,《N》采购本币价,《N》吊牌价,《N》计划到货数量," & _
                "《N》收货数量,《N》POS_入库单号,《N》状态,《N》创建人,《N》最后修改人,《N》收货单主表ID,《N》收货单编号,《N》到货计划主表ID,《N》收货单类型," & _
                "《N》计划到货主表数量 ,《N》计划到货主表金额,《N》收货时间,《N》供应商编号】" & _
                "【《N》商品ID," & A & "】【《N》单位," & B & "】【《N》到货计划明细ID," & C & "】【《N》采购原币价," & D & "】【《N》采购本币价," & E & "】【《N》吊牌价," & F & "】" & _
                "【《N》计划到货数量," & H & "】【《N》收货数量," & I & "】【《N》状态,40862D71-AAB5-4894-8680-56573725DB2E】" & _
                "【《N》创建人,qianc】【《N》最后修改人,qianc】【《N》收货单主表ID," & J & "】【《N》收货单编号," & K & "】" & _
                "【《N》到货计划主表ID," & L & "】【《N》收货单类型," & M & "】【《N》计划到货主表数量," & N & "】" & _
                "【《N》计划到货主表金额," & O & "】【《N》收货时间," & Date & "】【《N》供应商编号," & p & "】</ConditionStr></Interface>"
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = GetWsrrRlt(XMLStr)
    '            Msg "FORM", vbCritical, "", "", XMLStr
    '            Exit Sub
                If GetValueFromXml(XMLStr, "Root") = "" Then
                    SetValueByHead "RecDetailsList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                    GoTo N
                End If
            End If
        Next
        MsgBox "恭喜你，保存成功！ "
    End If
N:
    ProtectSheet "收货明细", False
    ScreenUpdate False
End Sub

Sub ClearTotal_One()
    Dim ReRow As Long, wrksht As Worksheet
    ScreenUpdate False
    ProtectSheet "收货明细", False
    
    Set wrksht = ActiveWorkbook.Worksheets("收货明细")
    If TableIsExists("收货明细") = False Then GoTo N
    If wrksht.ListObjects(1).Name = "RecDetailsList" Then
        If CheckSelectionInTable("RecDetailsList", True) = False Then GoTo N
        ReRow = Selection.Row
        SetValueByHead "RecDetailsList", ReRow, "本次收货数量", "0"
    End If
N:
    ScreenUpdate False
    ProtectSheet "收货明细", False
End Sub

Sub ClearTotal_All()
    Dim ReRow As Long, wrksht As Worksheet
    ScreenUpdate False
    ProtectSheet "收货明细", False
    Set wrksht = ActiveWorkbook.Worksheets("收货明细")
    If TableIsExists("收货明细") = False Then GoTo N
    If wrksht.ListObjects(1).Name = "RecDetailsList" Then
        For I = GetTableRowId("RecDetailsList", 1) To GetTableRowId("RecDetailsList", -1)
        ReRow = I
        SetValueByHead "RecDetailsList", ReRow, "本次收货数量", "0"
        Next
    End If
N:
    ScreenUpdate False
    ProtectSheet "收货明细", False
End Sub

