Attribute VB_Name = "F16_付款申请单_控制"
Sub 查询付款单_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "付款申请单", False
        SetValueByName "付款申请单_Change", "1"
        ClearTable "PayList"
        ClearTable "PayNewList"
        ClearTable "PayDHList"
        ClearTable "PayTHList"
        Dim XMLStr As String
        Dim YFK As String
        Dim CurRow As Long
        CurRow = Selection.Row

        If Sheets("付款申请单").Range("A7").Value = "预付款" Then
        
        XMLStr = "<Interface WSID=""93ccc11f-19ad-4b9c-a794-ce587314cdbb""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNP_PayApply】" & _
        "【返回内容,集团,事业体,申请单ID,申请单编号,合同GUID,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,应付款金额,是否已付款,创建人,创建时间,最后修改人,最后修改时间,修改次数,状态,状态名称,合同编号,供应商编号,开户行,银行账户,银行SWIFT号】" & _
        "【条件内容,《W》判断,《W》申请单类型】【《W》判断,全部加载】【《W》申请单类型,B71F574F-45F0-4AD2-9F4B-30FAAAD3CDC1】</ConditionStr>" & _
        "</Interface>"
        
        XMLStr = GetWsrrRlt(XMLStr)
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PayList")))
        CreateTableForXML "PayList", XMLStr, "ROOT", "付款申请单", "A9"
        If GetRowId("PayList", "MAX") <> GetRowId("PayList", "MIN") Then _
        DeleteRows "付款申请单", GetRowId("PayList", "MIN") & ":" & GetRowId("PayList", "MIN")
    Else
        If Sheets("付款申请单").Range("A7").Value = "尾款" Then
        
        XMLStr = "<Interface WSID=""93ccc11f-19ad-4b9c-a794-ce587314cdbb""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNP_PayApply】" & _
        "【返回内容,集团,事业体,申请单ID,申请单编号,合同GUID,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,应付款金额,是否已付款,创建人,创建时间,最后修改人,最后修改时间,修改次数,状态,状态名称,合同编号,供应商编号,开户行,银行账户,银行SWIFT号】" & _
        "【条件内容,《W》判断,《W》申请单类型】【《W》判断,全部加载】【《W》申请单类型,915DE132-6245-47EF-ABCB-913DD8ABD184】</ConditionStr>" & _
        "</Interface>"
        
        XMLStr = GetWsrrRlt(XMLStr)
    
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PayList")))
        CreateTableForXML "PayList", XMLStr, "ROOT", "付款申请单", "A9"
        If GetRowId("PayList", "MAX") <> GetRowId("PayList", "MIN") Then _
        DeleteRows "付款申请单", GetRowId("PayList", "MIN") & ":" & GetRowId("PayList", "MIN")
    Else
        If Sheets("付款申请单").Range("A7").Value = "退货款" Then
        
        XMLStr = "<Interface WSID=""5352bd6f-6933-48a8-8d06-cf6ffb8d67bd""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNP_PayApply】" & _
        "【返回内容,集团,事业体,申请单ID,申请单编号,退货单GUID,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,应付款金额,是否已付款,创建人,创建时间,最后修改人,最后修改时间,修改次数,状态,状态名称,合同编号,供应商编号,开户行,银行账户,银行SWIFT号】" & _
        "【条件内容,《W》申请单类型,《W》判断】【《W》判断,全部加载】【《W》申请单类型,F9698ED2-F95F-48C8-903A-52FA4D7F152D】</ConditionStr></Interface>"
'                        Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
        XMLStr = GetWsrrRlt(XMLStr)
    
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("PayList")))
        CreateTableForXML "PayList", XMLStr, "ROOT", "付款申请单", "A9"
        If GetRowId("PayList", "MAX") <> GetRowId("PayList", "MIN") Then _
        DeleteRows "付款申请单", GetRowId("PayList", "MIN") & ":" & GetRowId("PayList", "MIN")
        End If
    End If
End If
        SetFormat_PayList_All
        'ProtectSheetWithEnableAllowFiltering "付款申请单", True
        Sheets("付款申请单").Activate
        Sheets("付款申请单").Range("B10").Select
        SetValueByName "付款申请单_Change", "0"
    ScreenUpdate True
End Sub
Sub 查看明细_load()
    ScreenUpdate False
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "TEMP1", False
        SetValueByName "TEMP1_Change", "1"  '关闭Change
        SetValueByName "供应商_Change", "1"  '关闭Change
        Dim CurRow As Long
        Dim XMLStr As String
        Dim sid As String
        Dim I As Long
        Dim MarkId As String
        ClearTable "PayMXList"
        ClearTable "PayDHMXList"
        ClearTable "PayTHMXList"
        CurRow = Selection.Row
        If GetValueByHead("PayList", CurRow, "操作") <> "" Or GetValueByHead("PayList", CurRow, "申请单ID") = "" Then
                MsgBox "请将光标定位在【操作】为空的行内，谢谢！"
                GoTo N
            End If
        If GetValueByHead("PayList", CurRow, "付款单类型") = "预付款" Then
            PayId = GetValueByHead("PayList", CurRow, "申请单ID")

            '开始执行
            
            XMLStr = "<Interface WSID=""71dbfa7c-b311-4880-8655-e982b195475e""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNPD_PayApplyDetail】" & _
            "【返回内容,集团,事业体,付款申请单明细ID,申请单ID,申请单编号,单据类型,单据ID,状态,创建人,创建时间,最后修改人,最后修改时间,合同编号,合同金额,预付款百分比,合同备注,结算方式,采购数量,状态,结算币种】" & _
            "【条件内容,《W》申请单ID】【《W》申请单ID," & PayId & "】</ConditionStr></Interface>"

            XMLStr = GetWsrrRlt(XMLStr)

            XMLStr = FormatXMLForListObject(XMLStr, "<S></S>" & ConvertColumnListToXML(GetHeadMap("PayMXList")))
            CreateTableForXML "PayMXList", XMLStr, "ROOT", "TEMP1", "A4"
            If GetRowId("PayMXList", "MAX") <> GetRowId("PayMXList", "MIN") Then _
            DeleteRows "TEMP1", GetRowId("PayMXList", "MIN") & ":" & GetRowId("PayMXList", "MIN")
            SetFormat_PayMXList_All
            '设置所有查看品牌的操作符为S，包括表头
            For Each cl In Range("PayMXList[[合同编号]]")
              If cl.Value <> "" Then
                SetValueByHead "PayMXList", cl.Row, "S", "S"
              End If
            Next
'            ProtectSheetWithEnableAllowFiltering "TEMP1", True
'
            '清除已查看的列表
            For I = GetTableRowId("PayList", -1) To CurRow Step -1 '在表PayList中循环，如果操作=S的话，就删除。
                If GetValueByHead("PayList", I, "操作") = "S" Then
                DeleteRows "付款申请单", I & ":" & I   '删除标记为S的行
                End If
            Next
            CopyRecords_Def1 "PayMXList", "PayList", CurRow + 1, "【S,操作】【合同编号,申请单编号】【合同金额,供应商编号】【预付款百分比,开户行】【合同备注,银行账户】【结算方式,银行SWIFT号】【结算币种,财务水单号】", True
            For Each rw In Range("PayList[[操作]]")
                If rw.Value = "S" Then
                    CopyCellFormat "新建品牌", "U1", Sheets("付款申请单").Range(Cells(rw.Row, GetColumnId("PayList", "Min")), Cells(rw.Row, GetColumnId("PayList", "Max")))
                End If
            Next
        Else
            If GetValueByHead("PayList", CurRow, "付款单类型") = "尾款" Then
            PayId = GetValueByHead("PayList", CurRow, "申请单ID")

            '开始执行
            XMLStr = "<Interface WSID=""6f011fbb-8275-46f1-8dfe-f3823087ee45""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNPD_PayApplyDetail】" & _
            "【返回内容,集团,事业体,付款申请单明细ID,申请单ID,申请单编号,单据类型,单据ID,状态,创建人,创建时间,最后修改人,最后修改时间,到货计划编号,采购金额,采购数量,单据类型,状态,采购币种】" & _
            "【条件内容,《W》申请单ID】【《W》申请单ID," & PayId & "】</ConditionStr></Interface>"

            XMLStr = GetWsrrRlt(XMLStr)

            XMLStr = FormatXMLForListObject(XMLStr, "<S></S>" & ConvertColumnListToXML(GetHeadMap("PayDHMXList")))
            CreateTableForXML "PayDHMXList", XMLStr, "ROOT", "TEMP1", "A4"
            If GetRowId("PayDHMXList", "MAX") <> GetRowId("PayDHMXList", "MIN") Then _
            DeleteRows "TEMP1", GetRowId("PayDHMXList", "MIN") & ":" & GetRowId("PayDHMXList", "MIN")
            SetFormat_PayDHMXList_All
            '设置所有查看品牌的操作符为S，包括表头
            For Each cl In Range("PayDHMXList[[到货计划编号]]")
              If cl.Value <> "" Then
                SetValueByHead "PayDHMXList", cl.Row, "S", "S"
              End If
            Next
'            ProtectSheetWithEnableAllowFiltering "TEMP1", True
'
            '清除已查看的列表
            For I = GetTableRowId("PayList", -1) To CurRow Step -1 '在表PayList中循环，如果操作=S的话，就删除。
                If GetValueByHead("PayList", I, "操作") = "S" Then
                DeleteRows "付款申请单", I & ":" & I   '删除标记为S的行
                End If
            Next
            CopyRecords_Def1 "PayDHMXList", "PayList", CurRow + 1, "【S,操作】【到货计划编号,申请单编号】【采购金额,供应商编号】【采购币种,开户行】【采购数量,银行账户】", True
            For Each rw In Range("PayList[[操作]]")
                If rw.Value = "S" Then
                    CopyCellFormat "新建品牌", "U1", Sheets("付款申请单").Range(Cells(rw.Row, GetColumnId("PayList", "Min")), Cells(rw.Row, GetColumnId("PayList", "Max")))
                End If
            Next
        Else
            If GetValueByHead("PayList", CurRow, "付款单类型") = "退货款" Then
            PayId = GetValueByHead("PayList", CurRow, "申请单ID")

            '开始执行
            XMLStr = "<Interface WSID=""8ab8c3df-decb-44af-a8f3-d5aebdfac0f8""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,GET】【实体,B02_Bill.FNPD_PayApplyDetail】" & _
            "【返回内容,集团,事业体,付款申请单明细ID,申请单ID,申请单编号,单据类型,单据ID,状态,创建人,创建 时间,最后修改人,最后修改时间,退货单编号,退货金额,退货数量,单据类型,状态】" & _
            "【条件内容,《W》申请单ID】【《W》申请单ID," & PayId & "】</ConditionStr></Interface>"

            XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
            XMLStr = FormatXMLForListObject(XMLStr, "<S></S>" & ConvertColumnListToXML(GetHeadMap("")))
            CreateTableForXML "PayTHMXList", XMLStr, "ROOT", "TEMP1", "A4"
            If GetRowId("PayTHMXList", "MAX") <> GetRowId("PayTHMXList", "MIN") Then _
            DeleteRows "TEMP1", GetRowId("PayTHMXList", "MIN") & ":" & GetRowId("PayTHMXList", "MIN")
            SetFormat_PayTHMXList_All
            '设置所有查看品牌的操作符为S，包括表头
            For Each cl In Range("PayTHMXList[[退货单编号]]")
              If cl.Value <> "" Then
                SetValueByHead "PayTHMXList", cl.Row, "S", "S"
              End If
            Next
'            ProtectSheetWithEnableAllowFiltering "TEMP1", True

            '清除已查看的列表
            For I = GetTableRowId("PayList", -1) To CurRow Step -1 '在表PayList中循环，如果操作=S的话，就删除。
                If GetValueByHead("PayList", I, "操作") = "S" Then
                DeleteRows "付款申请单", I & ":" & I   '删除标记为S的行
                End If
            Next
            CopyRecords_Def1 "PayTHMXList", "PayList", CurRow + 1, "【S,操作】【退货单编号,申请单编号】【退货金额,供应商编号】【退货数量,开户行】", True
            For Each rw In Range("PayList[[操作]]")
                If rw.Value = "S" Then
                    CopyCellFormat "新建品牌", "U1", Sheets("付款申请单").Range(Cells(rw.Row, GetColumnId("PayList", "Min")), Cells(rw.Row, GetColumnId("PayList", "Max")))
                End If
            Next
    End If
  End If
End If
    ProtectSheetWithEnableAllowFiltering "TEMP1", False
    ProtectSheetWithEnableAllowFiltering "付款申请单", False
N:
    SetValueByName "TEMP1_Change", "0"   '关闭Change
    SetValueByName "供应商_Change", "0"     '关闭Change
    ScreenUpdate True
End Sub
Sub 付款申请单_save()
    '保存新建
    ScreenUpdate False
'    If Not CheckIsLogin() Then GoTo N
    
'    ProtectSheet "付款申请单", False
    
'    SetFormat_PayList_GS     '设置需要转换的列
    Dim wrksht As Worksheet
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String, C As String, D As String, E As String
    Dim G As String, H As String, I As String, J As String, K As String, L As String, M As String, N As String, O As String, p As String, Q As String, R As String
    Dim selectItemPD0_SUO_SupplierId As String, selectItemPD0_BrandId As String, selectItemPD0_YearId As String, selectItemPD0_SeasonId As String, selectItemPD0_Lvl1 As String, selectItemPD0_Lvl2 As String
    Dim dictIdPD0_SUO_SupplierId As String, dictIdPD0_BrandId As String, dictIdPD0_YearId As String, dictIdPD0_SeasonId As String, dictIdPD0_Lvl1 As String, dictIdPD0_Lvl2 As String
    Set wrksht = ActiveWorkbook.Worksheets("付款申请单")
    
    If TableIsExists("付款申请单") = True Then  '如果合同表中存在Table
        If wrksht.ListObjects(1).Name = "PayNewList" Then '如果TableName是"PayNewList"
         CurRow = Selection.Row
    If Not CheckSelectionInTable("PayNewList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If
    SetValueByHead "PayNewList", CurRow, "操作", "I"
    If GetValueByHead("PayNewList", CurRow, "操作") = "I" Then
    '保存新建付款申请单信息
        If MsgBox("你确认要【保存】" & "付款申请单： " & GetValueByHead("PayNewList", CurRow, "合同GUID") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
    
            C = GetValueByHead("PayNewList", CurRow, "申请单ID")
            D = GetValueByHead("PayNewList", CurRow, "申请单编号")
            E = GetValueByHead("PayNewList", CurRow, "合同GUID")
            G = GetValueByHead("PayNewList", CurRow, "申请单类型")
            H = GetValueByHead("PayNewList", CurRow, "财务水单号")
            I = GetValueByHead("PayNewList", CurRow, "付款总金额")
            J = GetValueByHead("PayNewList", CurRow, "付款百分比")
            K = GetValueByHead("PayNewList", CurRow, "应付款金额")
            L = GetValueByHead("PayNewList", CurRow, "是否已付款")
            M = GetValueByHead("PayNewList", CurRow, "创建人")
            N = GetValueByHead("PayNewList", CurRow, "最后修改人")
            O = GetValueByHead("PayNewList", CurRow, "供应商编号")
            p = GetValueByHead("PayNewList", CurRow, "开户行")
            Q = GetValueByHead("PayNewList", CurRow, "银行账户")
            R = GetValueByHead("PayNewList", CurRow, "银行SWIFT号")
            CurRow = Selection.Row
            '设置供应商编号的下拉和取值
            selectItemPD0_SUO_SupplierId = GetValueByHead("PayNewList", CurRow, "供应商编号")
            dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
           XMLStr = "<Interface WSID=""93ccc11f-19ad-4b9c-a794-ce587314cdbb""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,NEW】【实体,B02_Bill.FNP_PayApply】【新增内容,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,应付款金额,是否已付款,状态,创建人,最后修改人,合同ID】" & _
            "【条件内容,《N》供应商GUID,《N》申请单类型,《N》财务水单号,《N》付款总金额,《N》付款百分比,《N》应付款金额,《N》是否已付款,《N》状态,《N》创建人,《N》最后修改人,《N》合同ID 】" & _
            "【《N》供应商GUID," & dictIdPD0_SUO_SupplierId & "】【《N》申请单类型,B71F574F-45F0-4AD2-9F4B-30FAAAD3CDC1】【《N》财务水单号," & H & "】【《N》付款总金额," & I & "】【《N》付款百分比," & J & "】【《N》应付款金额," & K & "】【《N》是否已付款," & L & "】【《N》状态,40862D71-AAB5-4894-8680-56573725DB2E】" & _
            "【《N》创建人," & M & "】【《N》最后修改人," & N & "】【《N》合同ID," & E & "】</ConditionStr></Interface>"
           '构造上传xml格式,注意WSID和OPTYPE类型
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
    
           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "保存成功！      ", vbInformation, "提示"
               SetValueByHead "PayNewList", CurRow, "操作", "F"
           Else
               MsgBox "保存失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
               End If
            End If
        End If
    End If
End If
    If TableIsExists("付款申请单") = True Then  '如果合同表中存在Table
    If wrksht.ListObjects(1).Name = "PayDHList" Then '如果TableName是"PayDHList"
    CurRow = Selection.Row
    SetValueByHead "PayDHList", CurRow, "操作", "I"
    If GetValueByHead("PayDHList", CurRow, "操作") = "I" Then
    '保存新建付款申请单信息
        If MsgBox("你确认要【保存】" & "付款申请单： " & GetValueByHead("PayDHList", CurRow, "供应商GUID") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
    
            C = GetValueByHead("PayDHList", CurRow, "申请单ID")
            D = GetValueByHead("PayDHList", CurRow, "申请单编号")
            E = GetValueByHead("PayDHList", CurRow, "到货计划GUID")
            G = GetValueByHead("PayDHList", CurRow, "申请单类型")
            H = GetValueByHead("PayDHList", CurRow, "财务水单号")
            I = GetValueByHead("PayDHList", CurRow, "付款总金额")
            J = GetValueByHead("PayDHList", CurRow, "付款百分比")
            K = GetValueByHead("PayDHList", CurRow, "应付款金额")
            L = GetValueByHead("PayDHList", CurRow, "是否已付款")
            M = GetValueByHead("PayDHList", CurRow, "创建人")
            N = GetValueByHead("PayDHList", CurRow, "最后修改人")
            O = GetValueByHead("PayDHList", CurRow, "供应商编号")
            p = GetValueByHead("PayDHList", CurRow, "开户行")
            Q = GetValueByHead("PayDHList", CurRow, "银行账户")
            R = GetValueByHead("PayDHList", CurRow, "银行SWIFT号")
            CurRow = Selection.Row
            '设置供应商编号的下拉和取值
            selectItemPD0_SUO_SupplierId = GetValueByHead("PayDHList", CurRow, "供应商编号")
            dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
           XMLStr = "<Interface WSID=""b6ec361f-b577-4c3f-a2d2-9b686b265f31""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,NEW】【实体,B02_Bill.FNP_PayApply】【新增内容,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,应付款金额,是否已付款,状态,创建人,最后修改人,到货计划GUID】" & _
            "【条件内容,《N》供应商GUID,《N》申请单类型,《N》财务水单号,《N》付款总金额,《N》付款百分比,《N》应付款金额,《N》是否已付款,《N》状态,《N》创建人,《N》最后修改人,《N》到货计划GUID 】" & _
            "【《N》供应商GUID," & dictIdPD0_SUO_SupplierId & "】【《N》申请单类型,915DE132-6245-47EF-ABCB-913DD8ABD184】【《N》财务水单号," & H & "】【《N》付款总金额," & I & "】【《N》付款百分比," & J & "】【《N》应付款金额," & K & "】【《N》是否已付款," & L & "】【《N》状态,40862D71-AAB5-4894-8680-56573725DB2E】" & _
            "【《N》创建人," & M & "】【《N》最后修改人," & N & "】【《N》到货计划GUID," & E & "】</ConditionStr></Interface>"
           '构造上传xml格式,注意WSID和OPTYPE类型
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
    
           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "保存成功！      ", vbInformation, "提示"
               SetValueByHead "PayDHList", CurRow, "操作", "F"
           Else
               MsgBox "保存失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
               End If
            End If
        End If
    End If
End If
If TableIsExists("付款申请单") = True Then  '如果合同表中存在Table
    If wrksht.ListObjects(1).Name = "PayTHList" Then '如果TableName是"PayTHList"
    CurRow = Selection.Row
    SetValueByHead "PayTHList", CurRow, "操作", "I"
    If GetValueByHead("PayTHList", CurRow, "操作") = "I" Then
    '保存新建付款申请单信息
        If MsgBox("你确认要【保存】" & "付款申请单： " & GetValueByHead("PayTHList", CurRow, "退货单主表ID") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
    
            C = GetValueByHead("PayTHList", CurRow, "申请单ID")
            D = GetValueByHead("PayTHList", CurRow, "申请单编号")
            E = GetValueByHead("PayTHList", CurRow, "退货单主表ID")
            F = GetValueByHead("PayTHList", CurRow, "供应商ID")
            G = GetValueByHead("PayTHList", CurRow, "申请单类型")
            H = GetValueByHead("PayTHList", CurRow, "财务水单号")
            I = GetValueByHead("PayTHList", CurRow, "付款总金额")
            J = GetValueByHead("PayTHList", CurRow, "付款百分比")
            K = GetValueByHead("PayTHList", CurRow, "应付款金额")
            L = GetValueByHead("PayTHList", CurRow, "是否已付款")
            M = GetValueByHead("PayTHList", CurRow, "创建人")
            N = GetValueByHead("PayTHList", CurRow, "最后修改人")
            O = GetValueByHead("PayTHList", CurRow, "供应商编号")
            p = GetValueByHead("PayTHList", CurRow, "开户行")
            Q = GetValueByHead("PayTHList", CurRow, "银行账户")
            R = GetValueByHead("PayTHList", CurRow, "银行SWIFT号")
            CurRow = Selection.Row
            '设置供应商编号的下拉和取值
            selectItemPD0_SUO_SupplierId = GetValueByHead("PayTHList", CurRow, "供应商编号")
            dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
           XMLStr = "<Interface WSID=""5352bd6f-6933-48a8-8d06-cf6ffb8d67bd""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,NEW】【实体,B02_Bill.FNP_PayApply】" & _
            "【新增内容,供应商GUID,申请单类型,财务水单号,付款总金额,付款百分比,是否已付款,状态,创建人,最后修改人,到货计划GUID】" & _
            "【条件内容,《N》供应商GUID,《N》申请单类型,《N》财务水单号,《N》付款总金额,《N》付款百分比,《N》是否已付款,《N》状态,《N》创建人,《N》最后修改人,《N》退货单GUID】" & _
            "【《N》供应商GUID," & dictIdPD0_SUO_SupplierId & "】【《N》申请单类型,F9698ED2-F95F-48C8-903A-52FA4D7F152D】【《N》财务水单号," & H & "】【《N》付款总金额," & I & "】【《N》付款百分比," & J & "】【《N》是否已付款," & L & "】【《N》状态,40862D71-AAB5-4894-8680-56573725DB2E】" & _
            "【《N》创建人," & M & "】【《N》最后修改人," & N & "】【《N》退货单GUID," & E & "】</ConditionStr></Interface>"
           '构造上传xml格式,注意WSID和OPTYPE类型
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
    
           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "保存成功！      ", vbInformation, "提示"
               SetValueByHead "PayTHList", CurRow, "操作", "F"
           Else
               MsgBox "保存失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
               End If
            End If
        End If
    End If
End If
    ProtectSheetWithEnableAllowFiltering "付款申请单", False
        
N:
    ScreenUpdate True

End Sub
Sub 付款申请单_Delete()
    '删除付款单
    ScreenUpdate False
'    If Not CheckIsLogin() Then GoTo N
    
'    ProtectSheet "付款申请单", False
    
'    SetFormat_PayList_GS     '设置需要转换的列

    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String, C As String, N As String
    CurRow = Selection.Row
    If Not CheckSelectionInTable("PayList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If
    If GetValueByHead("PayList", CurRow, "付款单类型") = "预付款" Then
    SetValueByHead "PayList", CurRow, "操作", "D"
    If GetValueByHead("PayList", CurRow, "操作") = "D" Then
    '删除付款申请单信息
        If MsgBox("你确认要【删除】" & "付款申请单： " & GetValueByHead("PayList", CurRow, "申请单编号") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
    
            C = GetValueByHead("PayList", CurRow, "申请单ID")
            N = GetValueByHead("PayList", CurRow, "最后修改人")
            
           XMLStr = "<Interface WSID=""93ccc11f-19ad-4b9c-a794-ce587314cdbb""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,UPDATE】【操作类型,DELETE】【实体,B02_Bill.FNP_PayApply】" & _
            "【更新内容,状态,最后修改人】【条件内容,《N》状态,《N》最后修改人,《W》申请单主表ID】【【《N》状态,E3CA9B7A-8E17-4E52-B667-39689445D4A1】【《N》最后修改人," & N & "】" & _
            "【《W》申请单主表ID," & C & "】</ConditionStr></Interface>"
           '构造上传xml格式,注意WSID和OPTYPE类型
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
    
           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "删除成功！      ", vbInformation, "提示"
               SetValueByHead "PayList", CurRow, "操作", "F"
           Else
               MsgBox "删除失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
            End If
        End If
    End If
End If
    If GetValueByHead("PayList", CurRow, "付款单类型") = "尾款" Then
    SetValueByHead "PayList", CurRow, "操作", "D"
    If GetValueByHead("PayList", CurRow, "操作") = "D" Then
    '删除付款申请单信息
        If MsgBox("你确认要【删除】" & "付款申请单： " & GetValueByHead("PayList", CurRow, "申请单编号") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
    
            C = GetValueByHead("PayList", CurRow, "申请单ID")
            N = GetValueByHead("PayList", CurRow, "最后修改人")
            
           XMLStr = "<Interface WSID=""b6ec361f-b577-4c3f-a2d2-9b686b265f31""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,DELETE】【实体,B02_Bill.FNP_PayApply】" & _
            "【更新内容,状态,最后修改人】【条件内容,《N》状态,《N》最后修改人,《W》申请单主表ID】【《N》状态,E3CA9B7A-8E17-4E52-B667-39689445D4A1】【《N》最后修改人," & N & "】" & _
            "【《W》申请单主表ID," & C & "】</ConditionStr></Interface>"
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "删除成功！      ", vbInformation, "提示"
               SetValueByHead "PayList", CurRow, "操作", "F"
           Else
               MsgBox "删除失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
            End If
        End If
    End If
End If
If GetValueByHead("PayList", CurRow, "付款单类型") = "退货款" Then
    SetValueByHead "PayList", CurRow, "操作", "D"
    If GetValueByHead("PayList", CurRow, "操作") = "D" Then
    '删除付款申请单信息
        If MsgBox("你确认要【删除】" & "付款申请单： " & GetValueByHead("PayList", CurRow, "申请单编号") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
    
            C = GetValueByHead("PayList", CurRow, "申请单ID")
            N = GetValueByHead("PayList", CurRow, "最后修改人")
            
           XMLStr = "<Interface WSID=""5352bd6f-6933-48a8-8d06-cf6ffb8d67bd""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,DELETE】【实体,B02_Bill.FNP_PayApply】" & _
            "【更新内容,状态,最后修改人】【条件内容,《N》状态,《N》最后修改人,《W》申请单主表ID】【《N》状态,E3CA9B7A-8E17-4E52-B667-39689445D4A1】【《N》最后修改人," & N & "】" & _
            "【《W》申请单主表ID," & C & "】</ConditionStr></Interface>"
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "删除成功！      ", vbInformation, "提示"
               SetValueByHead "PayList", CurRow, "操作", "F"
           Else
               MsgBox "删除失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
            End If
        End If
    End If
End If
    ProtectSheetWithEnableAllowFiltering "付款申请单", False
        
N:
    ScreenUpdate True

End Sub
Sub 付款申请单_UPDATE()
    '保存新建
    ScreenUpdate False
'    If Not CheckIsLogin() Then GoTo N
    
'    ProtectSheet "付款申请单", False
    
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String, C As String, D As String, E As String
    Dim G As String, H As String, I As String, J As String, K As String, L As String, M As String, N As String, O As String, p As String, Q As String, R As String
    
    CurRow = Selection.Row
    If Not CheckSelectionInTable("PayList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If
   If GetValueByHead("PayList", CurRow, "付款单类型") = "预付款" Then
    SetValueByHead "PayList", CurRow, "操作", "S"
    If GetValueByHead("PayList", CurRow, "操作") = "S" Then
    '保存新建付款申请单信息
        If MsgBox("你确认要【审核】" & "付款申请单： " & GetValueByHead("PayList", CurRow, "申请单编号") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
    
            C = GetValueByHead("PayList", CurRow, "申请单ID")
            D = GetValueByHead("PayList", CurRow, "申请单编号")
            G = GetValueByHead("PayList", CurRow, "申请单类型")
            H = GetValueByHead("PayList", CurRow, "财务水单号")
            I = GetValueByHead("PayList", CurRow, "付款总金额")
            J = GetValueByHead("PayList", CurRow, "付款百分比")
            K = GetValueByHead("PayList", CurRow, "应付款金额")
            L = GetValueByHead("PayList", CurRow, "是否已付款")
            N = GetValueByHead("PayList", CurRow, "最后修改人")
           XMLStr = "<Interface WSID=""93ccc11f-19ad-4b9c-a794-ce587314cdbb""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.FNP_PayApply】" & _
            "【更新内容,申请单类型,财务水单号,是否已付款,状态,最后修改人】【条件内容,《N》申请单类型,《N》财务水单号,《N》是否已付款,《N》状态,《N》最后修改人,《W》申请单主表ID】" & _
            "【《N》申请单类型,B71F574F-45F0-4AD2-9F4B-30FAAAD3CDC1】 【《N》财务水单号," & H & "】【《N》是否已付款," & L & "】【《N》状态,00DD6348-50D9-4E16-B214-CCFE3CD25D41】【《N》最后修改人," & N & "】" & _
            "【《W》申请单主表ID," & C & "】</ConditionStr></Interface>"
           '构造上传xml格式,注意WSID和OPTYPE类型
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
    
           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "保存成功！      ", vbInformation, "提示"
               SetValueByHead "PayList", CurRow, "操作", "F"
           Else
               MsgBox "保存失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
               End If
            End If
        End If
    End If
    If GetValueByHead("PayList", CurRow, "付款单类型") = "尾款" Then
    SetValueByHead "PayList", CurRow, "操作", "S"
    If GetValueByHead("PayList", CurRow, "操作") = "S" Then
    '保存新建付款申请单信息
        If MsgBox("你确认要【保存】" & "付款申请单： " & GetValueByHead("PayList", CurRow, "申请单编号") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then

            C = GetValueByHead("PayList", CurRow, "申请单ID")
            D = GetValueByHead("PayList", CurRow, "申请单编号")
            G = GetValueByHead("PayList", CurRow, "申请单类型")
            H = GetValueByHead("PayList", CurRow, "财务水单号")
            I = GetValueByHead("PayList", CurRow, "付款总金额")
            J = GetValueByHead("PayList", CurRow, "付款百分比")
            K = GetValueByHead("PayList", CurRow, "应付款金额")
            L = GetValueByHead("PayList", CurRow, "是否已付款")
            N = GetValueByHead("PayList", CurRow, "最后修改人")
           XMLStr = "<Interface WSID=""b6ec361f-b577-4c3f-a2d2-9b686b265f31""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.FNP_PayApply】" & _
            "【更新内容,申请单类型,财务水单号,是否已付款,付款百分比,付款总金额,状态,最后修改人】" & _
            "【条件内容,《N》申请单类型,《N》财务水单号,《N》是否已付款,《N》付款百分比,《N》付款总金额,《N》状态,《N》最后修改人,《W》申请单主表ID】" & _
            "【《N》申请单类型,915DE132-6245-47EF-ABCB-913DD8ABD184】【《N》财务水单号," & H & "】【《N》是否已付款," & L & "】【《N》付款百分比," & J & "】【《N》付款总金额," & I & "】【《N》状态,00DD6348-50D9-4E16-B214-CCFE3CD25D41】【《N》最后修改人," & N & "】" & _
            "【《W》申请单主表ID," & C & "】</ConditionStr></Interface>"
           '构造上传xml格式,注意WSID和OPTYPE类型
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub

           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "审核成功！      ", vbInformation, "提示"
               SetValueByHead "PayList", CurRow, "操作", "F"
           Else
               MsgBox "审核失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
               End If
            End If
        End If
    End If
    CurRow = Selection.Row
    If GetValueByHead("PayList", CurRow, "付款单类型") = "退货款" Then
    SetValueByHead "PayList", CurRow, "操作", "S"
    If GetValueByHead("PayList", CurRow, "操作") = "S" Then
    '保存新建付款申请单信息
        If MsgBox("你确认要【保存】" & "付款申请单： " & GetValueByHead("PayList", CurRow, "申请单编号") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then

            C = GetValueByHead("PayList", CurRow, "申请单ID")
            D = GetValueByHead("PayList", CurRow, "申请单编号")
            G = GetValueByHead("PayList", CurRow, "申请单类型")
            H = GetValueByHead("PayList", CurRow, "财务水单号")
            I = GetValueByHead("PayList", CurRow, "付款总金额")
            J = GetValueByHead("PayList", CurRow, "付款百分比")
            K = GetValueByHead("PayList", CurRow, "应付款金额")
            L = GetValueByHead("PayList", CurRow, "是否已付款")
            N = GetValueByHead("PayList", CurRow, "最后修改人")
           XMLStr = "<Interface WSID=""5352bd6f-6933-48a8-8d06-cf6ffb8d67bd""" & _
            " App=""" & GetAppName & """ SessionID=""" & GetSessionId & """>" & _
            "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>【操作类型,UPDATE】【实体,B02_Bill.FNP_PayApply】" & _
            "【更新内容,申请单类型,财务水单号,是否已付款,付款百分比,付款总金额,状态,最后修改人】" & _
            "【条件内容,《N》申请单类型,《N》财务水单号,《N》是否已付款,《N》状态,《N》最后修改人,《W》申请单主表ID】" & _
            "【《N》申请单类型,F9698ED2-F95F-48C8-903A-52FA4D7F152D】【《N》财务水单号," & H & "】【《N》是否已付款," & L & "】【《N》状态,00DD6348-50D9-4E16-B214-CCFE3CD25D41】【《N》最后修改人," & N & "】" & _
            "【《W》申请单主表ID," & C & "】</ConditionStr></Interface>"
           '构造上传xml格式,注意WSID和OPTYPE类型
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub

           XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
           If GetValueFromXml(XMLStr, "Root") = "" Then
               MsgBox "审核成功！      ", vbInformation, "提示"
               SetValueByHead "PayList", CurRow, "操作", "F"
           Else
               MsgBox "审核失败：" & GetValueFromXml(XMLStr, "MSG") & "      ", vbCritical, "提示"
               End If
            End If
        End If
    End If
    ProtectSheetWithEnableAllowFiltering "付款申请单", False
        
N:
    ScreenUpdate True

End Sub

