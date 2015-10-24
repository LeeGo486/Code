Attribute VB_Name = "F04_供应商_控制"
Sub 供应商_load()
    ScreenUpdate False                  '停止更新
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "供应商", False
        SetValueByName "供应商_Change", "1"
        ClearTable "SupplyList"
        Dim XMLStr As String
        XMLStr = "<Interface WSID=""f2769b90-ffa3-4cc9-93a5-49ac49badd80""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition></Condition></Row></LIST>" & _
        "</ROOT></xml></Interface>"
        XMLStr = Replace(XMLStr, "'", "\u0027")
        
        XMLStr = GetWsrrRlt(XMLStr)
         
       ' Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '将XML格式转化为符合列表对象要求的XML格式
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("SupplyList")))
        CreateTableForXML "SupplyList", XMLStr, "ROOT", "供应商", "A9"
        If GetRowId("SupplyList", "MAX") <> GetRowId("SupplyList", "MIN") Then _
        DeleteRows "供应商", GetRowId("SupplyList", "MIN") & ":" & GetRowId("SupplyList", "MIN")

        SetFormat_SupplyList_All
        ProtectSheetWithEnableAllowFiltering "供应商", True
        Sheets("供应商").Activate
        Sheets("供应商").Range("B10").Select
    SetValueByName "供应商_Change", "0"
'    End If
    ScreenUpdate True
End Sub
   
        
Sub 供应商_CreateSplit()
    '供应商新建插入
    ProtectSheet "供应商", False

'    If CheckIsLogin() = False Then GoTo N:

    Dim CurRow As Long
'        -----------by sunyulong 20130801 begin   -----------
    Dim CJR As String               '定义一个变量用于存放登陆人名
'        -----------by sunyulong 20130801 end   -----------
    If CheckSelectionInTable("SupplyList", True) = False Then GoTo N
        ScreenUpdate False
        InsertLine "供应商", 9, True
        CurRow = Selection.Row
'        -----------by sunyulong 20130801 begin   -----------
        CJR = Sheets("供应商").Range("B1").Value
'        -----------by sunyulong 20130801 end   -----------
        SetValueByHead "SupplyList", CurRow, "操作", "I"
        SetValueByHead "SupplyList", CurRow, "供应商编号", "系统自动生成"
'        -----------by sunyulong 20130730 begin   -----------
        SetValueByHead "SupplyList", CurRow, "供应商名称", "必填项"
        SetValueByHead "SupplyList", CurRow, "供应商分类", "必填项"
'        -----------by sunyulong 20130730 end   -----------
'        -----------by sunyulong 20130801 begin   -----------
        SetValueByHead "SupplyList", CurRow, "新建人", CJR
'        -----------by sunyulong 20130801 end   -----------
        SetFormat_SupplyList_Line CurRow, CurRow
        'SetFormat_CommandButton_All
        CurRow = Selection.Row
        ScreenUpdate True
N:
    ProtectSheetWithEnableAllowFiltering "供应商", True
End Sub

Sub 供应商_Cancelline()
    '删除新建行
    Dim CurRow As Long
    ScreenUpdate False

    If CheckSelectionInTable("SupplyList", True) = False Then
        GoTo N
    End If

    CurRow = Selection.Row

    If GetValueByHead("SupplyList", CurRow, "操作") = "" And GetValueByHead("SupplyList", CurRow, "供应商编号") <> "系统自动生成" _
    Then
        MsgBox "请选择记录行", vbCritical, "提示"
        GoTo N
    End If
    
    DeleteRows "供应商", CurRow & ":" & CurRow
    Range("C8").Select
N:
    ScreenUpdate True
End Sub

Sub 供应商_save()
    '保存新建
   
    ScreenUpdate False
    'If Not CheckIsLogin() Then GoTo N
    ProtectSheet "供应商", False
    
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
     Dim selectItem As String, dictId As String, XGR As String
     
    CurRow = Selection.Row
'        -----------by sunyulong 20130730 begin   -----------
    If GetValueByHead("SupplyList", CurRow, "供应商名称") = "必填项" _
    Then
        MsgBox "供应商名称不能为空！", vbCritical, "提示"
        GoTo N
    End If
    If GetValueByHead("SupplyList", CurRow, "供应商分类") = "必填项" _
    Then
        MsgBox "供应商分类不能为空！", vbCritical, "提示"
        GoTo N
    End If
'        -----------by sunyulong 20130730 end   -----------
    selectItem = GetValueByHead("SupplyList", CurRow, "供应商分类")
'
   dictId = getMBQTGUID("GYSFLList", "DC0_DictName1", selectItem, "DC0_DictId")
   
   SetValueByHead "SupplyList", CurRow, "SU0_SupplierType", dictId
    
    '设定要上传的列
    If Not CheckSelectionInTable("SupplyList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If
       
    If GetValueByHead("SupplyList", CurRow, "操作") = "I" Then
    '保存新建供应商信息
        If MsgBox("你确认要【保存】" & "供应商名称： " & GetValueByHead("SupplyList", CurRow, "供应商名称") & "的资料吗？    ", vbYesNo, "提示") = vbYes Then
    
            ColumnList = " 【SU0_CONO】【SU0_DIVI】【SU0_SupplierId】【供应商编号】【SU0_SupplierType】【供应商名称】【联系人】【联系电话】【地址】【开户行】【银行账户】【银行地址】【银行SWIFT号】【新建人】【修改人】"""
            XMLStr = GetXMLByTableColumn("SupplyList", ColumnList, "操作", "I", "=")
            
            XMLStr = "<Interface WSID=""f2769b90-ffa3-4cc9-93a5-49ac49badd80""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
            "</ROOT></xml></Interface>"
                '构造上传xml格式,注意WSID和OPTYPE类型

                XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                

                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    SetValueByHead "SupplyList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
        End If
    End If
    
    If GetValueByHead("SupplyList", CurRow, "操作") = "U" Then
    '保存供应商修改信息
        If MsgBox("你确认要【修改】" & "供应商名称： " & GetValueByHead("SupplyList", CurRow, "供应商名称") & "的供应商信息吗？    ", vbYesNo, "提示") = vbYes Then
            XGR = Sheets("供应商").Range("B1").Value
            SetValueByHead "SupplyList", CurRow, "最后修改人", XGR
    
            ColumnList = " 【SU0_CONO】【SU0_DIVI】【SU0_SupplierId】【供应商编号】【SU0_SupplierType】【供应商名称】【联系人】【联系电话】【地址】【开户行】【银行账户】【银行地址】【银行SWIFT号】【新建人】【最后修改人】"""
            XMLStr = GetXMLByTableColumn("SupplyList", ColumnList, "操作", "I", "=")
            
            XMLStr = GetXMLByTableColumn("SupplyList", ColumnList, "操作", "U", "=")
            XGR = Sheets("供应商").Range("B1").Value
            SetValueByHead "SupplyList", CurRow, "最后修改人", XGR
    
            '是否符合上传xml格式？
                 XMLStr = "<Interface WSID=""f2769b90-ffa3-4cc9-93a5-49ac49badd80""" & _
                 " App=""" & GetAppName & """ SessionID="""">" & _
                 " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                 "</ROOT></xml></Interface>"
                '构造上传xml格式,注意WSID和OPTYPE类型
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
         
                XMLStr = GetWsrrRlt(XMLStr)
                
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "保存成功！      ", vbInformation, "提示"
                    'Msg "FORM", vbCritical, "", "", GetValueFromXml(XMLStr, "Message")
                    SetValueByHead "SupplyList", CurRow, "操作", "F"
                Else
                    MsgBox "保存失败：" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "提示"
                End If
        End If
    End If
    'SetFormat_CommandButton_All
    供应商基础_load
    ProtectSheetWithEnableAllowFiltering "供应商", True
        
N:
    ScreenUpdate True

End Sub



Sub CreateBrand()
    '跳转“新建品牌”Sheet
    
    If Not CheckSelectionInTable("SupplyList", True) Then
        MsgBox "请在当前表格中选择一行！      ", vbCritical, "提示"
        GoTo N
    End If
    
    HideSheet "新建品牌", False
    ProtectSheet "新建品牌", False
    
    Dim BH As String            '创建一个变量用于存放供应商编号
    Dim JC As String            '创建一个变量用于存放供应商简称
    Dim CJR As String           '创建一个变量用于存放创建人
    Dim CurRow As Long
    
    CurRow = Selection.Row
    
    'BH = GetValueByHead("SupplyList", CurRow, "供应商编号")
    JC = GetValueByHead("SupplyList", CurRow, "供应商名称")
    BH = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", JC, "供应商编号")
    
    CJR = Sheets("供应商").Range("B1").Value
    
    HideSheet "新建品牌", False
    HideSheet "供应商", False
    
    ProtectSheet "新建品牌", False
    
    
    
    Sheets("新建品牌").Activate
    Sheets("新建品牌").Range("C6").Select
N:
    ProtectSheet "新建品牌", True
    
End Sub
'        -----------by sunyulong 20130803 begin   -----------
Sub 查询品牌_load()
    ScreenUpdate False
    ClearTable "BrandList"
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "供应商", False
        SetValueByName "新建品牌_Change", "1"
        SetValueByName "供应商_Change", "1"
        Dim CurRow As Long
        Dim XMLStr As String
        Dim sid As String
        Dim I As Long
        Dim MarkId As String
        CurRow = Selection.Row
        If GetValueByHead("SupplyList", CurRow, "操作") <> "" Or GetValueByHead("SupplyList", CurRow, "供应商编号") = "" Then
                MsgBox "请将光标定位在【操作】为空的行内，谢谢！"
                GoTo N
            End If
        MarkId = GetValueByHead("SupplyList", CurRow, "操作")
        If MarkId <> "S" Then
'        If CheckSelectionInTable("SupplyList", True) = False Then GoTo N:
        '判断是不是查询品牌
'        CurRow = FindValueRowByHead("B", "SupplyList", "操作", 1)
        If GetValueByHead("SupplyList", CurRow, "供应商编号") <> "系统自动生成" Then
         sid = GetValueByHead("SupplyList", CurRow, "SU0_SupplierId")
        If GetValueByHead("SupplyList", CurRow, "操作") = "B" Then
        End If
        '开始执行
            ClearTable "BrandList"
            XMLStr = "<Interface WSID=""ab42831d-3ac7-4391-8bac-0869379798fc""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition>" & "BD0_SU0_SupplierId='" & sid & "'" & "</Condition></Row></LIST>" & _
            "</ROOT></xml></Interface>"
            XMLStr = Replace(XMLStr, "'", "\u0027")
            XMLStr = GetWsrrRlt(XMLStr)
'            Msg "FORM", vbCritical, "", "", XMLStr
'            Exit Sub
            If GetValueFromXml(XMLStr, "BD0_BrandName") <> "" Then
            XMLStr = FormatXMLForListObject(XMLStr, "<S>I</S>" & ConvertColumnListToXML(GetHeadMap("BrandList")))
            CreateTableForXML "BrandList", XMLStr, "ROOT", "新建品牌", "A4"
            If GetRowId("BrandList", "MAX") <> GetRowId("BrandList", "MIN") Then _
            DeleteRows "新建品牌", GetRowId("BrandList", "MIN") & ":" & GetRowId("BrandList", "MIN")
            SetFormat_BrandList_All
            '设置所有查看品牌的操作符为S，包括表头
            For Each cl In Range("BrandList[[品牌名称]]")
              If cl.Value <> "" Then
                SetValueByHead "BrandList", cl.Row, "S", "S"
              End If
            Next
            ProtectSheetWithEnableAllowFiltering "TEMP1", True
            
            '清除已查看的列表
            For I = GetTableRowId("SupplyList", -1) To CurRow Step -1 '在表SupplyList中循环，如果操作=S的话，就删除。
                If GetValueByHead("SupplyList", I, "操作") = "S" Then
                DeleteRows "供应商", I & ":" & I   '删除标记为S的行
                End If
            Next
            CopyRecords_Def1 "BrandList", "SupplyList", CurRow + 1, "【S,操作】【品牌编号,供应商编号】【供应商编号,供应商分类】【品牌名称,供应商名称】【品牌所在国家,联系人】【品牌风格,联系电话】【目标群体,地址】", True
            For Each rw In Range("SupplyList[[操作]]")
                    If rw.Value = "S" Then
                        CopyCellFormat "新建品牌", "U1", Sheets("供应商").Range(Cells(rw.Row, GetColumnId("SupplyList", "Min")), Cells(rw.Row, GetColumnId("SupplyList", "Max")))
                    End If
                Next
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
'           将XML格式转化为符合列表对象要求的XML格式
            Else
                If MsgBox("供应商编号： " & GetValueByHead("SupplyList", CurRow, "供应商编号") & "无品牌,请问需要新建吗？    ", vbYesNo, "提示") = vbYes Then
                    新建品牌_CreateBrands
                End If
            End If
            
        ProtectSheetWithEnableAllowFiltering "供应商", True
        ProtectSheetWithEnableAllowFiltering "新建品牌", True
N:
       End If
     End If
    SetValueByName "新建品牌_Change", "0"
    SetValueByName "供应商_Change", "0"
    ScreenUpdate True
'        -----------by sunyulong 20130819 end   -----------
End Sub
Sub 商品信息_CreateProduct()
ScreenUpdate False
    Dim sid As String
    Dim sno As String
    Dim sName As String
    Dim CurRow As Long
    Dim XMLStr As String
    Dim Rstr As String
    Dim Guid As String
    ProtectSheet "商品信息", False
    ClearTable "ProductList"
    ClearPic "商品信息", "ProductList*"
    SetValueByName "商品信息_Change", "1"
    If CheckSelectionInTable("SupplyList", True) = False Then GoTo N
    CurRow = Selection.Row
    Guid = LCase(Mid$(CreateObject("Scriptlet.TypeLib").Guid, 2, 36))
    If GetValueByHead("SupplyList", CurRow, "操作") = "S" _
    Then
        MsgBox "请选中供应商的记录行操作！", vbCritical, "提示"
        GoTo N
    End If
    If GetValueByHead("SupplyList", CurRow, "供应商编号") <> "系统自动生成" Then
        sid = GetValueByHead("SupplyList", CurRow, "SU0_SupplierId")
        sno = GetValueByHead("SupplyList", CurRow, "供应商编号")
    Else
        sName = GetValueByHead("SupplyList", CurRow, "供应商名称")
        sno = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", sName, "供应商编号")
        sid = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", sName, "SU0_SupplierId")
    End If
    ClearTable "ProductList"
    品牌名称基础_load
    
    '--------20130819 by zz begin------------
    '判断新增商品时是否已存在品牌
     XMLStr = "<Interface WSID=""ab42831d-3ac7-4391-8bac-0869379798fc""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition>" & "BD0_SU0_SupplierId='" & sid & "'" & "</Condition></Row></LIST>" & _
            "</ROOT></xml></Interface>"
            XMLStr = Replace(XMLStr, "'", "\u0027")
            XMLStr = GetWsrrRlt(XMLStr)
'            Msg "FORM", vbCritical, "", "", XMLStr
'            Exit Sub
            If GetValueFromXml(XMLStr, "BD0_BrandName") = "" Then
               If MsgBox("该供应商下面无品牌,无法新建商品，请问需要先新建品牌吗？    ", vbYesNo, "提示") = vbYes Then
                    新建品牌_CreateBrands
               End If
            Else
    '--------20130819 by zz end------------
    

                XMLStr = "<ROOT><LIST><Rows><PD0_CONO></PD0_CONO><PD0_DIVI></PD0_DIVI>" & _
                "<PD0_ProductId></PD0_ProductId><PD0_SUO_SupplierId></PD0_SUO_SupplierId><SU0_SupplierCode></SU0_SupplierCode><PD0_BD0_BrandId></PD0_BD0_BrandId><BD0_BrandName></BD0_BrandName><PD0_ProductCodeSU></PD0_ProductCodeSU>" & _
                "<PD0_ColorSUId></PD0_ColorSUId><ColorSUDictName></ColorSUDictName><PD0_SizeSUId></PD0_SizeSUId><SizeDictName></SizeDictName><PD0_SKUSU></PD0_SKUSU><PD0_Code></PD0_Code>" & _
                "<PD0_ColorId></PD0_ColorId><ColorDictName></ColorDictName><PD0_SizeId></PD0_SizeId><PD0_ColorBSUId></PD0_ColorBSUId><PD0_Lvl0></PD0_Lvl0><PD0_PicPath></PD0_PicPath><SizeSUDictName></SizeSUDictName><PD0_SKU></PD0_SKU><PD0_YearId></PD0_YearId><YearDictName></YearDictName>" & _
                "<PD0_SeasonId></PD0_SeasonId><SeasonDictName></SeasonDictName><PD0_Lvl1></PD0_Lvl1><Lvl1DictName></Lvl1DictName><PD0_Lvl2></PD0_Lvl2><Lvl2DictName></Lvl2DictName><PD0_Lvl3></PD0_Lvl3>" & _
                "<PD0_SourceCountry></PD0_SourceCountry><PD0_Composition></PD0_Composition><PD0_QulityLevel></PD0_QulityLevel><PD0_StandardId></PD0_StandardId><StandardDictName></StandardDictName>" & _
                "<PD0_SecurityLevelId></PD0_SecurityLevelId><SecurityLevelDictName></SecurityLevelDictName><PD0_PurchasePrice></PD0_PurchasePrice><PD0_SalePrice></PD0_SalePrice><PD0_UnitId></PD0_UnitId>" & _
                "<PD0_IsPrinted></PD0_IsPrinted><PD0_Status></PD0_Status><PD0_RgUser></PD0_RgUser><PD0_RgDt></PD0_RgDt><PD0_LmUser></PD0_LmUser><PD0_LmDt></PD0_LmDt><PD0_UptNo></PD0_UptNo>" & _
                "</Rows></LIST></ROOT>"
            
                XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("ProductLoadList")))
                CreateTableForXML "ProductList", XMLStr, "ROOT", "商品信息", "A5"
                If GetRowId("ProductList", "MAX") <> GetRowId("ProductList", "MIN") Then _
                DeleteRows "商品信息", GetRowId("ProductList", "MIN") & ":" & GetRowId("ProductList", "MIN")
                Sheets("商品信息").Activate
'                InsertLine "商品信息", GetTableRowId("ProductList", 0), True
                CurRow = Selection.Row
                SetValueByHead "ProductList", CurRow + 1, "操作", "I"

                SetFormat_ProductLoadList_All
                SetValueByHead "ProductList", CurRow + 1, "商品ID", Guid
                SetValueByHead "ProductList", CurRow + 1, "品牌名称", "必填项"
                SetValueByHead "ProductList", CurRow + 1, "品名", "必填项"
                SetValueByHead "ProductList", CurRow + 1, "供应商款号", "必填项"
                SetValueByHead "ProductList", CurRow + 1, "供应商颜色", "必填项"
                SetValueByHead "ProductList", CurRow + 1, "供应商尺码", "必填项"
                SetValueByHead "ProductList", CurRow + 1, "PD0_SUO_SupplierId", sid
                SetValueByHead "ProductList", CurRow + 1, "PD0_SecurityLevelId", "系统自动生成"
                SetValueByHead "ProductList", CurRow + 1, "供应商编号", sno
                SetValueByHead "ProductList", CurRow + 1, "采购价", "0"
                SetValueByHead "ProductList", CurRow + 1, "吊牌价", "0"
                SetValidationStr Range("ProductList[[品牌名称]]"), GetAddressByHead2("BrandBASEList", "BD0_SU0_SupplierId", sid, "品牌名称")
            End If
N:
    Sheets("商品信息").Range("G6").Select
    SetValueByName "商品信息_Change", "0"
    ProtectSheet "商品信息", True
    ScreenUpdate True
End Sub
Sub 新建品牌_CreateBrands()
    Dim sno As String, sid As String, sName As String
    Dim CurRow As Long
    Dim XMLStr As String
    Dim Rstr As String
    Dim CJR As String
    ScreenUpdate False
    ProtectSheet "新建品牌", False
    SetValueByName "新建品牌_Change", "1"
    If CheckSelectionInTable("SupplyList", True) = False Then GoTo N
    CurRow = Selection.Row
    CJR = Sheets("供应商").Range("B1").Value
    If GetValueByHead("SupplyList", CurRow, "操作") = "S" _
    Then
        MsgBox "请选中供应商的记录行操作！", vbCritical, "提示"
        GoTo N
    End If
    If GetValueByHead("SupplyList", CurRow, "供应商编号") <> "系统自动生成" Then
        sno = GetValueByHead("SupplyList", CurRow, "供应商编号")
        sid = getMBQTGUID("SupplyBASEList", "供应商编号", sno, "SU0_SupplierId")
    Else
        sName = GetValueByHead("SupplyList", CurRow, "供应商名称")
        sno = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", sName, "供应商编号")
        sid = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", sName, "SU0_SupplierId")
    End If
    
    ClearTable "BrandList"
         XMLStr = "<ROOT><LIST><Rows>" & _
        "<BD0_CONO></BD0_CONO><BD0_DIVI></BD0_DIVI><BD0_BrandId></BD0_BrandId><BD0_BrandCode></BD0_BrandCode><BD0_SU0_SupplierId></BD0_SU0_SupplierId><BD0_BrandName></BD0_BrandName><BD0_CountryId></BD0_CountryId><SU0_SupplierCode></SU0_SupplierCode><CountryDictName></CountryDictName><StyleDictName></StyleDictName><CusGrpDictName></CusGrpDictName>" & _
        "<BD0_StyleId></BD0_StyleId><BD0_CusGrpId></BD0_CusGrpId><BD0_Status></BD0_Status><BD0_RgUser></BD0_RgUser><BD0_RgDt></BD0_RgDt><BD0_LmUser></BD0_LmUser><BD0_LmDt></BD0_LmDt><BD0_UptNo>" & _
        "</BD0_UptNo>" & _
        "</Rows></LIST></ROOT>"
        
        XMLStr = FormatXMLForListObject(XMLStr, "<操作></操作>" & ConvertColumnListToXML(GetHeadMap("")))
        CreateTableForXML "BrandList", XMLStr, "ROOT", "新建品牌", "A4"
        If GetRowId("BrandList", "MAX") <> GetRowId("BrandList", "MIN") Then _
        DeleteRows "新建品牌", GetRowId("BrandList", "MIN") & ":" & GetRowId("BrandList", "MIN")
        Sheets("新建品牌").Activate
        CurRow = Selection.Row
     SetFormat_BrandList_All
     SetValueByHead "BrandList", CurRow + 1, "操作", "I"
     SetValueByHead "BrandList", CurRow + 1, "供应商编号", sno
     SetValueByHead "BrandList", CurRow + 1, "品牌编号", "必填项"
     SetValueByHead "BrandList", CurRow + 1, "品牌名称", "必填项"
     SetValueByHead "BrandList", CurRow + 1, "创建人", CJR
    
N:
    Sheets("新建品牌").Range("E5").Select
    SetValueByName "新建品牌_Change", "0"
    ScreenUpdate True
End Sub
