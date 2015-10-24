Attribute VB_Name = "F20_到货计划明细_控制"
Sub 到货计划明细_save()
    '保存新建

    ScreenUpdate False
    'If Not CheckIsLogin() Then GoTo N
    ProtectSheet "到货计划明细", False
    Dim wrksht As Worksheet
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String, A As String, B As String, C As String, D As String, E As String, F As String
    Dim G As String, H As String, I As String, J As String, K As String, L As String, M As String, N As String, O As String, p As String, Q As String, R As String
    Dim S As String, T As String, U As String, V As String, W As String, X As String, Y As String, Z As String
    Dim RowMIN As String, RowMAX As String
    Set wrksht = ActiveWorkbook.Worksheets("到货计划明细")
    If TableIsExists("到货计划明细") = True Then  '如果合同表中存在Table
    If wrksht.ListObjects(1).Name = "DeliveryPlanList" Then '如果TableName是"PayNewList"
     CurRow = Selection.Row
    '设定要上传的列
    If Not CheckSelectionInTable("DeliveryPlanList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If
    SetValueByHead "DeliveryPlanList", CurRow, "操作", "I"
    If GetValueByHead("DeliveryPlanList", CurRow, "操作") = "I" Then
    '保存新建到货计划信息
        If MsgBox("你确认要【保存】" & "到货计划名称： " & GetValueByHead("DeliveryPlanList", CurRow, "PR1_CONO") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
''    增加循环开始------by zz 20130901
    RowMIN = GetRowId("DeliveryPlanList", "MIN")
    RowMAX = GetRowId("DeliveryPlanList", "MAX")
    For CurRow = RowMIN To RowMAX
''    增加循环开始------by zz 20130901
            B = Sheets("到货计划明细").Range("B1").Value
            C = Sheets("到货计划明细").Range("F5").Value
            D = GetValueByHead("DeliveryPlanList", CurRow, "采购单编号")
            E = GetValueByHead("DeliveryPlanList", CurRow, "商品ID")
            F = GetValueByHead("DeliveryPlanList", CurRow, "单位")
            G = GetValueByHead("DeliveryPlanList", CurRow, "采购单明细ID")
            H = GetValueByHead("DeliveryPlanList", CurRow, "采购原币价")
            I = GetValueByHead("DeliveryPlanList", CurRow, "采购本币价")
            J = GetValueByHead("DeliveryPlanList", CurRow, "吊牌价")
            K = GetValueByHead("DeliveryPlanList", CurRow, "预计到货日期")
            L = GetValueByHead("DeliveryPlanList", CurRow, "本次计划到货数量")
            M = GetValueByHead("DeliveryPlanList", CurRow, "本次计划到货金额")
            N = GetValueByHead("DeliveryPlanList", CurRow, "状态")
            O = GetValueByHead("DeliveryPlanList", CurRow, "创建人")
            p = GetValueByHead("DeliveryPlanList", CurRow, "创建时间")
            Q = GetValueByHead("DeliveryPlanList", CurRow, "最后修改人")
            R = GetValueByHead("DeliveryPlanList", CurRow, "最后修改时间")
            S = GetValueByHead("DeliveryPlanList", CurRow, "采购主表总数")
            T = GetValueByHead("DeliveryPlanList", CurRow, "采购主表金额")
            U = GetValueByHead("DeliveryPlanList", CurRow, "采购总数")
            V = GetValueByHead("DeliveryPlanList", CurRow, "已到数量")
            W = GetValueByHead("DeliveryPlanList", CurRow, "已生成计划数量")
            X = GetValueByHead("DeliveryPlanList", CurRow, "数量差异")
            If L = "0" Then
               GoTo F
            End If

            XMLStr = "<Interface WSID=""a7c3649a-4104-4e4d-90e3-d09af73515c1""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType>" & _
            "<ConditionStr>【操作类型,NEW】【实体,B02_Bill.PRAD_ArrivalPlanDetail】" & _
            "【新增内容,商品ID,单位,采购单明细ID,采购原币价,采购本币价,吊牌价,预计到货日期,采购总数,已到数量,已生产计划数量,本次计划到货数量,状态,创建人,最后修改人,到货计划编号,采购单编号,采购主表总数,采购主表金额】" & _
            "【条件内容,《N》商品ID,《N》单位,《N》采购单明细ID,《N》采购原币价,《N》采购本币价,《N》吊牌价,《N》预计到货日期," & _
            "《N》采购总数,《N》已到数量,《N》已生产计划数量,《N》本次计划到货数量,《N》状态" & _
            "《N》创建人,《N》最后修改人,《N》到货计划编号,《N》到货计划主表ID《N》采购单编号,《N》采购主表总数,《N》采购主表金额】" & _
            "【《N》商品ID," & E & "】【《N》单位," & F & "】【《N》采购单明细ID," & G & "】" & _
            "【《N》采购原币价," & H & "】【《N》采购本币价," & I & "】【《N》吊牌价," & J & "】" & _
            "【《N》预计到货日期ID," & K & "】" & _
            "【《N》采购总数," & U & "】【《N》已到数量," & V & "】【《N》已生产计划数量," & W & "】【《N》本次计划到货数量," & L & "】【《N》状态,40862D71-AAB5-4894-8680-56573725DB2E】" & _
            "【《N》创建人," & O & "】【《N》最后修改人," & Q & "】【《N》到货计划编号," & C & "】【《N》采购单编号," & D & "】【《N》到货计划主表ID," & B & "】" & _
            "【《N》采购主表总数," & S & "】【《N》采购主表金额," & T & "】</ConditionStr>" & _
            "</Interface>"
'                '构造上传xml格式,注意WSID和OPTYPE类型
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
'                '增加循环结束------by zz 20130901
F:
                Next CurRow
'                '增加循环结束------by zz 20130901
                If GetValueFromXml(XMLStr, "ROOT") = "" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "DeliveryPlanList", CurRow - 1, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                    GoTo N
                End If
            End If
        End If
    End If
        If TableIsExists("到货计划明细") = True Then  '如果合同表中存在Table
        If wrksht.ListObjects(1).Name = "DeliveryPlanMXList" Then '如果TableName是"PayNewList"
        CurRow = Selection.Row
        SetValueByHead "DeliveryPlanMXList", CurRow, "操作", "I"
        If GetValueByHead("DeliveryPlanMXList", CurRow, "操作") = "I" Then
        '保存新建到货计划信息
        If MsgBox("你确认要【保存】" & "到货计划名称： " & GetValueByHead("DeliveryPlanMXList", CurRow, "到货计划明细ID") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
        '增加循环开始------by zz 20130901
        RowMIN = GetRowId("DeliveryPlanMXList", "MIN")
        RowMAX = GetRowId("DeliveryPlanMXList", "MAX")
    
        For CurRow = RowMIN To RowMAX
        '增加循环开始------by zz 20130901
            DHJHID = GetValueByHead("DeliveryPlanMXList", CurRow, "到货计划明细ID")
            DHJHBH = GetValueByHead("DeliveryPlanMXList", CurRow, "到货计划主表ID")
            E = GetValueByHead("DeliveryPlanMXList", CurRow, "商品ID")
            F = GetValueByHead("DeliveryPlanMXList", CurRow, "单位")
            G = GetValueByHead("DeliveryPlanMXList", CurRow, "采购单明细ID")
            L = GetValueByHead("DeliveryPlanMXList", CurRow, "本次计划到货数量")
            M = GetValueByHead("DeliveryPlanMXList", CurRow, "本次计划到货金额")
            U = GetValueByHead("DeliveryPlanMXList", CurRow, "采购总数")
            V = GetValueByHead("DeliveryPlanMXList", CurRow, "已到数量")
            
            XMLStr = "<Interface WSID=""a7c3649a-4104-4e4d-90e3-d09af73515c1""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.PRAD_ArrivalPlanDetail】" & _
            "【更新内容,本次计划到货数量,采购总数,已到数量】【条件内容,《N》本次计划到货数量,《N》采购总数,《N》已到数量,《W》采购单明细ID,《W》到货计划主表ID,《W》商品ID,《W》到货计划明细ID】" & _
            "【《N》本次计划到货数量," & L & "】【《N》采购总数," & U & "】【《N》已到数量," & V & "】【《W》采购单明细ID," & G & "】【《W》到货计划主表ID," & DHJHBH & "】" & _
            "【《W》到货计划明细ID," & DHJHID & "】【《W》商品ID," & E & "】</ConditionStr></Interface>"


                XMLStr = GetWsrrRlt(XMLStr)

                '增加循环结束------by zz 20130901
                Next CurRow
                 '增加循环结束------by zz 20130901
                If GetValueFromXml(XMLStr, "ROOT") = "" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "DeliveryPlanMXList", CurRow - 1, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                    GoTo N
                End If
                End If
            End If
        End If
    End If
End If
'    ProtectSheetWithEnableAllowFiltering "到货计划", True
N:
    ScreenUpdate True

End Sub
