Attribute VB_Name = "F08_商品信息_控制"
Sub 商品信息_CreateSplit()
    '商品信息新建插入
        Dim P_Sno As String
    ProtectSheet "商品信息", False
'    If CheckIsLogin() = False Then GoTo N:

        Dim CurRow As Long
        Dim PSno As String
        Dim BH As String
        Dim CJR As String               '定义一个变量用于存放登陆人名
        Dim Guid As String
        CurRow = Selection.Row
        PSno = GetValueByHead("ProductList", CurRow, "供应商编号")

    If CheckSelectionInTable("ProductList", True) = False Then GoTo N
        ScreenUpdate False
        InsertLine "商品信息", 5, True
        CurRow = Selection.Row
        CJR = Sheets("供应商").Range("B1").Value
        Guid = LCase(Mid$(CreateObject("Scriptlet.TypeLib").Guid, 2, 36))
        BH = GetValueByHead("ProductList", CurRow, "供应商编号")
        SetValueByHead "ProductList", CurRow, "操作", "I"
        SetValueByHead "ProductList", CurRow, "PD0_SecurityLevelId", "系统自动生成"
        SetValueByHead "ProductList", CurRow, "品牌名称", "必填项"
        SetValueByHead "ProductList", CurRow, "品名", "必填项"
        SetValueByHead "ProductList", CurRow, "供应商款号", "必填项"
        SetValueByHead "ProductList", CurRow, "供应商颜色", "必填项"
        SetValueByHead "ProductList", CurRow, "供应商尺码", "必填项"
        SetValueByHead "ProductList", CurRow, "供应商编号", PSno
        SetValueByHead "ProductList", CurRow, "创建人", CJR
        SetValueByHead "ProductList", CurRow, "商品ID", Guid
        SetFormat_ProductList_Line CurRow, CurRow
        'SetFormat_CommandButton_All
        CurRow = Selection.Row
        ScreenUpdate True
'        PSno = Sheets("商品信息").Range("D11").Value
'        SetValueByHead "ProductList", CurRow, "供应商编号", PSno
'        SetValidationStr Range("ProductList[[供应商编号]]"), "=基础!$CD$7:$AW$" & GetRowId("SupplyBASEList", "MAX")
'        SetValidationStr Range("ProductList[[品牌名称]]"), GetAddressByHead2("BrandBASEList", "SU0_SupplierCode", PSno, "品牌名称")
        SetValueByHead "ProductList", CurRow, "采购价", "0"
        SetValueByHead "ProductList", CurRow, "吊牌价", "0"
        
N:
    'ProtectSheetWithEnableAllowFiltering "商品信息", True
End Sub
Sub 商品信息_return()

    ScreenUpdate False
'    If Not CheckIsLogin() Then GoTo N

    ProtectSheet "商品信息", False
    Sheets("商品信息").Range("C4").Clear
    Sheets("商品信息").Range("E4").Clear
    ClearTable "LXRList"

    'HideSheet "供应商", False
    'HideSheet "商品信息",true

    Sheets("供应商").Activate
    Sheets("供应商").Range("C7").Select
    'SetFormat_CommandButton_All
N:
    ScreenUpdate True
End Sub


Sub 商品信息_load()
     ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "商品信息", False
        SetValueByName "商品信息_Change", "1"
        ClearTable "ProductList"
        ClearPic "商品信息", "ProductList*"
        Dim XMLStr As String

        XMLStr = "<Interface WSID=""2b798196-4e64-4ecf-ab73-4ed6598e87cd""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition></Condition></Row></LIST>" & _
        "</ROOT></xml></Interface>"
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        XMLStr = Replace(XMLStr, "'", "\u0027")

        XMLStr = GetWsrrRlt(XMLStr)
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub

        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("ProductLoadList")))
         
        CreateTableForXML "ProductList", XMLStr, "ROOT", "商品信息", "A5"
        If GetRowId("ProductList", "MAX") <> GetRowId("ProductList", "MIN") Then _
        DeleteRows "商品信息", GetRowId("ProductList", "MIN") & ":" & GetRowId("ProductList", "MIN")

        SetFormat_ProductLoadList_All
        'SetFormat_CommandButton_All
        
        ProtectSheetWithEnableAllowFiltering "商品信息", True
        Sheets("商品信息").Activate
        Sheets("商品信息").Range("B10").Select
        SetValueByName "商品信息_Change", "0"
'    End If
    ScreenUpdate True
End Sub
Sub 商品信息_Cancelline()
    '删除新建行
    Dim CurRow As Long
    ScreenUpdate False

    If CheckSelectionInTable("ProductList", True) = False Then
        GoTo N
    End If

    CurRow = Selection.Row

    If GetValueByHead("ProductList", CurRow, "操作") = "" And GetValueByHead("ProductList", CurRow, "商品ID") <> "系统自动生成" _
    Then
        MsgBox "请选择记录行", vbCritical, "提示"
        GoTo N
    End If
    
    DeleteRows "商品信息", CurRow & ":" & CurRow
    'SetFormat_CommandButton_All
    Range("C7").Select
N:
    ScreenUpdate True
End Sub

Sub 商品信息_save()
    '保存新建
    ScreenUpdate False
    'If Not CheckIsLogin() Then GoTo N
    ProtectSheet "商品信息", False
    
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
    Dim PM As String, KH As String, YS As String, CM As String, YS2 As String, SKU As String, SP As String
    Dim selectItemPD0_SUO_SupplierId As String, selectItemPD0_BrandId As String, selectItemPD0_YearId As String, selectItemPD0_SeasonId As String, selectItemPD0_Lvl1 As String, selectItemPD0_Lvl2 As String
    Dim dictIdPD0_SUO_SupplierId As String, dictIdPD0_BrandId As String, dictIdPD0_YearId As String, dictIdPD0_SeasonId As String, dictIdPD0_Lvl1 As String, dictIdPD0_Lvl2 As String
    
    Dim selectItemPD0_ColorSUId As String, selectItemPD0_SizeSUId As String, selectItemPD0_ColorId As String, selectItemPD0_SizeId As String
    Dim dictIdPD0_ColorSUId As String, dictIdPD0_SizeSUId As String, dictIdPD0_ColorId As String, dictIdPD0_SizeId As String, SKU2 As String
    CurRow = Selection.Row
'        -----------by sunyulong 20130730 begin   -----------
    If GetValueByHead("ProductList", CurRow, "品牌名称") = "必填项" _
    Then
        MsgBox "品牌名称不能为空！", vbCritical, "提示"
        GoTo N
    End If
    If GetValueByHead("ProductList", CurRow, "品名") = "必填项" _
    Then
        MsgBox "品名不能为空！", vbCritical, "提示"
        GoTo N
    End If
    If GetValueByHead("ProductList", CurRow, "供应商款号") = "必填项" _
    Then
        MsgBox "供应商款号不能为空！", vbCritical, "提示"
        GoTo N
    End If
    If GetValueByHead("ProductList", CurRow, "供应商颜色") = "必填项" _
    Then
        MsgBox "供应商颜色不能为空！", vbCritical, "提示"
        GoTo N
    End If
        If GetValueByHead("ProductList", CurRow, "供应商尺码") = "必填项" _
    Then
        MsgBox "供应商尺码不能为空！", vbCritical, "提示"
        GoTo N
    End If
'        -----------by sunyulong 20130730 end   -----------
     '设置供应商编号的下拉和取值
    selectItemPD0_SUO_SupplierId = GetValueByHead("ProductList", CurRow, "供应商编号")
    dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
    SetValueByHead "ProductList", CurRow, "PD0_SUO_SupplierId", dictIdPD0_SUO_SupplierId


     '设置品牌的下拉和取值
     selectItemPD0_BrandId = GetValueByHead("ProductList", CurRow, "品牌名称")
     dictIdPD0_BrandId = getMBQTGUID("BrandBASEList", "品牌名称", selectItemPD0_BrandId, "BD0_BrandId")
     SetValueByHead "ProductList", CurRow, "PD0_BD0_BrandId", dictIdPD0_BrandId


    '设置年份的下拉和取值
     selectItemPD0_YearId = GetValueByHead("ProductList", CurRow, "年份")
     dictIdPD0_YearId = getMBQTGUID("YearBaseList", "DC0_DictName1", selectItemPD0_YearId, "DC0_DictId")
     SetValueByHead "ProductList", CurRow, "PD0_YearId", dictIdPD0_YearId

    '设置颜色的下拉和取值
    selectItemPD0_ColorId = GetValueByHead("ProductList", CurRow, "颜色")
    dictIdPD0_ColorId = getMBQTGUID("ColorBaseList", "DC0_DictName1", selectItemPD0_ColorId, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_ColorId", dictIdPD0_ColorId

    '设置尺码的下拉和取值
    selectItemPD0_SizeId = GetValueByHead("ProductList", CurRow, "尺码")
    dictIdPD0_SizeId = getMBQTGUID("SizeBaseList", "DC0_DictName1", selectItemPD0_SizeId, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_SizeId", dictIdPD0_SizeId
    
    '设定要上传的列
    If Not CheckSelectionInTable("ProductList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If

    CurRow = Selection.Row
    SKU2 = GetValueByHead("ProductList", CurRow, "供应商款号") & "-" & GetValueByHead("ProductList", CurRow, "供应商颜色") & "-" & GetValueByHead("ProductList", CurRow, "供应商尺码")
    SetValueByHead "ProductList", CurRow, "供应商SKU", SKU2
'    MsgBox SKU2
    If GetValueByHead("ProductList", CurRow, "操作") = "I" Then
    '保存新建商品信息信息
        If MsgBox("你确认要【保存】" & "商品信息名称： " & GetValueByHead("ProductList", CurRow, "供应商款号") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then

            ColumnList = "【PD0_CONO】【PD0_DIVI】【PD0_SUO_SupplierId】【商品ID】【PD0_BD0_BrandId】【供应商款号】【供应商颜色】【供应商尺码】 " & _
                         "【供应商SKU】【款号】【PD0_ColorId】【PD0_SizeId】【SKU】【PD0_YearId】" & _
                         "【季节】【款式种类】【款式大类】【款式小类】【产地】【成分】【款图】【品名】" & _
                         "【等级】【PD0_StandardId】【PD0_SecurityLevelId】【采购价】【吊牌价】【单位】【状态】【是否打印】【创建人】【最后修改人】"

            XMLStr = GetXMLByTableColumn("ProductList", ColumnList, "操作", "I", "=")

            XMLStr = "<Interface WSID=""2b798196-4e64-4ecf-ab73-4ed6598e87cd""" & _
                     " App=""" & GetAppName & """ SessionID="""">" & _
                     " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                     "</ROOT></xml></Interface>"
                '构造上传xml格式,注意WSID和OPTYPE类型
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = Replace(XMLStr, "'", "\u0027")
                XMLStr = GetWsrrRlt(XMLStr)

                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "ProductList", CurRow, "操作", "F"
                    ProtectSheet "明细联动", False
                    CurRow = Selection.Row
                    PM = GetValueByHead("ProductList", CurRow, "品牌名称")
                    KH = GetValueByHead("ProductList", CurRow, "供应商款号")
                    YS = GetValueByHead("ProductList", CurRow, "供应商颜色")
                    YS2 = GetValueByHead("ProductList", CurRow, "供应商颜色（简）")
                    CM = GetValueByHead("ProductList", CurRow, "供应商尺码")
                    SKU = GetValueByHead("ProductList", CurRow, "供应商SKU")
                    SP = GetValueByHead("ProductList", CurRow, "商品ID")
                    SetValueByHead "表118", CurRow, "品牌名称", PM
                    Sheets("明细联动").Activate
                    InsertLine "明细联动", 1, True
                    CurRow = Selection.Row
                    SetValueByHead "表118", CurRow, "品牌名称", PM
                    SetValueByHead "表118", CurRow, "供应商款号", KH
                    SetValueByHead "表118", CurRow, "供应商颜色", YS
                    SetValueByHead "表118", CurRow, "供应商颜色（简）", YS2
                    SetValueByHead "表118", CurRow, "供应商尺码", CM
                    SetValueByHead "表118", CurRow, "供应商SKU", SKU
                    SetValueByHead "表118", CurRow, "商品ID", SP
                    Sheets("商品信息").Activate
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If

        End If
    End If
    
    If GetValueByHead("ProductList", CurRow, "操作") = "U" Then
    '保存商品信息修改信息
        If MsgBox("你确认要【修改】" & "商品信息名称： " & GetValueByHead("ProductList", CurRow, "供应商款号") & "的商品信息信息吗？    ", vbYesNo, "提示") = vbYes Then
    
           
            ColumnList = "【PD0_CONO】【PD0_DIVI】【PD0_SUO_SupplierId】【商品ID】【PD0_BD0_BrandId】【供应商款号】【供应商颜色】【供应商尺码】 " & _
                         "【供应商SKU】【款号】【PD0_ColorId】【PD0_SizeId】【SKU】【PD0_YearId】" & _
                         "【季节】【款式种类】【款式大类】【款式小类】【产地】【成分】【款图】【品名】" & _
                         "【等级】【PD0_StandardId】【PD0_SecurityLevelId】【采购价】【吊牌价】【单位】【状态】【是否打印】【创建人】【最后修改人】"
                         
            XMLStr = GetXMLByTableColumn("ProductList", ColumnList, "操作", "U", "=")
        
    
            '是否符合上传xml格式？
                 XMLStr = "<Interface WSID=""2b798196-4e64-4ecf-ab73-4ed6598e87cd""" & _
                     " App=""" & GetAppName & """ SessionID="""">" & _
                     " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                     "</ROOT></xml></Interface>"
                '构造上传xml格式,注意WSID和OPTYPE类型
                Msg "FORM", vbCritical, "", "", XMLStr
    '            Exit Sub
         
                XMLStr = GetWsrrRlt(XMLStr)
                
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    'Msg "FORM", vbCritical, "", "", GetValueFromXml(XMLStr, "MSG")
                    SetValueByHead "ProductList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
        End If
    End If
    'SetFormat_CommandButton_All
    ProtectSheetWithEnableAllowFiltering "商品信息", True
        
N:
    ScreenUpdate True

End Sub

Sub 商品信息_查看()
    '查看商品信息
    ScreenUpdate False
    
'    If Not CheckIsLogin() Then GoTo N
        If Not CheckSelectionInTable("ProductList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If
    
    Dim CurRow As Long
    Dim BH As String                '定义一个变量用于存放商品信息编号
    Dim JC As String                '定义一个变量用于存放商品信息简称
    
    
    ProtectSheet "商品信息", False
    CurRow = Selection.Row
    BH = GetValueByHead("ProductList", CurRow, "商品信息编号")
    JC = GetValueByHead("ProductList", CurRow, "商品信息简称")
    
    SetCellValueByRange "商品信息", "A4", "※商品信息简称："
    SetCellValueByRange "商品信息", "C4", JC
    SetCellValueByRange "商品信息", "D4", "※商品信息编号："
    SetCellValueByRange "商品信息", "E4", BH
    
    商品信息_load
    HideSheet "商品信息", False
    HideSheet "商品信息", True
    Sheets("商品信息").Activate
    Sheets("商品信息").Range("A5").Select
    ProtectSheet "商品信息", True

N:
    ScreenUpdate True
End Sub







