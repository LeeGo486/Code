Attribute VB_Name = "F06_品牌_控制"
Sub 新建品牌_load()
    ScreenUpdate False                  '停止更新
    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "新建品牌", False
        SetValueByName "新建品牌_Change", "1"
        ClearTable "BrandList"
        Dim XMLStr As String
        XMLStr = "<Interface WSID=""ab42831d-3ac7-4391-8bac-0869379798fc""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition></Condition></Row></LIST>" & _
        "</ROOT></xml></Interface>"
        
        Msg "FORM", vbCritical, "", "", XMLStr
        
        XMLStr = GetWsrrRlt(XMLStr)
        
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("BrandList")))
        
        CreateTableForXML "BrandList", XMLStr, "ROOT", "新建品牌", "A4"
        If GetRowId("BrandList", "MAX") <> GetRowId("BrandList", "MIN") Then _
        DeleteRows "新建品牌", GetRowId("BrandList", "MIN") & ":" & GetRowId("BrandList", "MIN")

        SetFormat_BrandList_All
        'SetFormat_CommandButton_All
        
        'ProtectSheetWithEnableAllowFiltering "供应商", True
        Sheets("新建品牌").Activate
        Sheets("新建品牌").Range("B10").Select

        Dim CurRow As Long
        Dim sid As String
        CurRow = Selection.Row
        sid = CurRow.Value
        SetValidationStr Range("ProductList[[品牌编号]]"), GetAddressByHead2("BrandBASEList", "BD0_SU0_SupplierId", sid, "BD0_BrandId")
        
    End If
    SetValueByName "新建品牌_Change", "0"
    ScreenUpdate True
End Sub
Sub 新建品牌_CreateSplit()
    '新建品牌新建插入
    Dim B_Sno As String
    ProtectSheet "新建品牌", False

'    If CheckIsLogin() = False Then GoTo N:

        Dim CurRow As Long
        Dim BSno As String
        Dim sno As String
'        -----------by sunyulong 20130801 begin   -----------
        Dim CJR As String               '定义一个变量用于存放登陆人名
        CurRow = Selection.Row
        sno = GetValueByHead("BrandList", CurRow, "供应商编号")

'        -----------by sunyulong 20130801 end   -----------
    If CheckSelectionInTable("BrandList", True) = False Then GoTo N
        ScreenUpdate False
        InsertLine "新建品牌", 4, True
        CurRow = Selection.Row
'        -----------by sunyulong 20130801 begin   -----------
        CJR = Sheets("供应商").Range("B1").Value
'        -----------by sunyulong 20130801 end   -----------
        SetValueByHead "BrandList", CurRow, "操作", "I"
'        -----------by sunyulong 20130730 begin   -----------
        SetValueByHead "BrandList", CurRow, "品牌名称", "必填项"
'        -----------by sunyulong 20130730 end   -----------
'        -----------by sunyulong 20130801 begin   -----------
        SetValueByHead "BrandList", CurRow, "创建人", CJR
'        -----------by sunyulong 20130801 end   -----------
        SetValueByHead "BrandList", CurRow, "供应商编号", sno
        SetFormat_BrandList_Line CurRow, CurRow
        'SetFormat_CommandButton_All
        CurRow = Selection.Row
        ScreenUpdate True
N:
    'ProtectSheetWithEnableAllowFiltering "新建品牌", True
End Sub
Sub 新建品牌_return()

    ScreenUpdate False
'    If Not CheckIsLogin() Then GoTo N

    ProtectSheet "新建品牌", False
    Sheets("新建品牌").Range("C4").Clear
    Sheets("新建品牌").Range("E4").Clear
    ClearTable "LXRList"

    'HideSheet "供应商", False
    'HideSheet "商品信息",true

    Sheets("供应商").Activate
    Sheets("供应商").Range("C7").Select
    'SetFormat_CommandButton_All
N:
    ScreenUpdate True
End Sub



Sub 新建品牌_Cancelline()
    '删除新建行
    Dim CurRow As Long
    ScreenUpdate False

    If CheckSelectionInTable("BrandList", True) = False Then
        GoTo N
    End If

    CurRow = Selection.Row

    If GetValueByHead("BrandList", CurRow, "操作") = "" _
    Then
        MsgBox "请选择记录行", vbCritical, "提示"
        GoTo N
    End If
    
    DeleteRows "新建品牌", CurRow & ":" & CurRow
    'SetFormat_CommandButton_All
    Range("C6").Select
N:
    ScreenUpdate True
    

End Sub
Sub 新建品牌_save()
ScreenUpdate False
    'If Not CheckIsLogin() Then GoTo N
    ProtectSheet "新建品牌", False
    
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
    Dim selectItemCusGrpId As String, selectItemSupplierId As String, selectItemStyleId As String, selectItemBD0_CountryId As String
    Dim dictIdCusGrpId As String, dictIdSupplierId As String, dictIdStyleId As String, dictIdBD0_CountryId As String
    CurRow = Selection.Row
    '设置目标群体的下拉和取值
'        -----------by sunyulong 20130730 begin   -----------
    If GetValueByHead("BrandList", CurRow, "品牌名称") = "必填项" _
    Then
        MsgBox "请检查品牌信息！", vbCritical, "提示"
        GoTo N
    End If
'        -----------by sunyulong 20130730 end   -----------

    
    '设定要上传的列
    If Not CheckSelectionInTable("BrandList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If
    
    CurRow = Selection.Row
    

    
    If GetValueByHead("BrandList", CurRow, "操作") = "I" Then
    '保存新建新建品牌信息
        If MsgBox("你确认要【保存】" & "新建品牌名称： " & GetValueByHead("BrandList", CurRow, "品牌名称") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
             
             selectItemCusGrpId = GetValueByHead("BrandList", CurRow, "目标群体")
             dictIdCusGrpId = getMBQTGUID("MBQTList", "DC0_DictName1", selectItemCusGrpId, "DC0_DictId")
             SetValueByHead "BrandList", CurRow, "BD0_CusGrpId", dictIdCusGrpId
            
             '设置供应商编号的下拉和取值
             selectItemSupplierId = GetValueByHead("BrandList", CurRow, "供应商编号")
             dictIdSupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemSupplierId, "SU0_SupplierId")
             SetValueByHead "BrandList", CurRow, "BD0_SU0_SupplierId", dictIdSupplierId
             
              '设置品牌风格的下拉和取值
             selectItemStyleId = GetValueByHead("BrandList", CurRow, "品牌风格")
             dictIdStyleId = getMBQTGUID("PPFGList", "DC0_DictName1", selectItemStyleId, "DC0_DictId")
             SetValueByHead "BrandList", CurRow, "BD0_StyleId", dictIdStyleId
    
            ColumnList = "【BD0_CONO】【BD0_DIVI】【BD0_BrandId】【BD0_BrandCode】【BD0_SU0_SupplierId】【品牌名称】【品牌所在国家】【BD0_SU0_SupplierId】【BD0_StyleId】【BD0_CusGrpId】【创建人】【创建时间】"
            XMLStr = GetXMLByTableColumn("BrandList", ColumnList, "操作", "I", "=")
            
            

            XMLStr = "<Interface WSID=""ab42831d-3ac7-4391-8bac-0869379798fc""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
            "</ROOT></xml></Interface>"
                '构造上传xml格式,注意WSID和OPTYPE类型
'            Msg "FORM", vbCritical, "", "", XMLStr
'            Exit Sub

         
                XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "BrandList", CurRow, "操作", "F"
                    品牌名称基础_load
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
        End If
    End If
    
    If GetValueByHead("BrandList", CurRow, "操作") = "U" Then
    '保存新建品牌修改信息
        If MsgBox("你确认要【修改】" & "新建品牌名称： " & GetValueByHead("BrandList", CurRow, "品牌名称") & "的新建品牌信息吗？    ", vbYesNo, "提示") = vbYes Then
    
            ColumnList = "【BD0_CONO】【BD0_DIVI】【BD0_BrandId】【BD0_BrandCode】【BD0_SU0_SupplierId】【品牌名称】【品牌所在国家】【BD0_SU0_SupplierId】【BD0_StyleId】【BD0_CusGrpId】【创建人】【创建时间】"
            XMLStr = GetXMLByTableColumn("BrandList", ColumnList, "操作", "U", "=")
        
    
            '是否符合上传xml格式？
                 XMLStr = "<Interface WSID=""ab42831d-3ac7-4391-8bac-0869379798fc""" & _
                 " App=""" & GetAppName & """ SessionID="""">" & _
                 " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                 "</ROOT></xml></Interface>"
                '构造上传xml格式,注意WSID和OPTYPE类型
    '            Msg "FORM", vbCritical, "", "", XMLStr
    '            Exit Sub
         
                XMLStr = GetWsrrRlt(XMLStr)
                
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    'Msg "FORM", vbCritical, "", "", GetValueFromXml(XMLStr, "MSG")
                    SetValueByHead "BrandList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
        End If
    End If
    'SetFormat_CommandButton_All
    ProtectSheetWithEnableAllowFiltering "新建品牌", True
        
N:
    ScreenUpdate True

End Sub






