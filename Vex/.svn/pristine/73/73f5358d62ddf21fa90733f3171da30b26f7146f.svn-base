Attribute VB_Name = "F07_商品信息_通用"
'Function SetFormat_ProductList_All()
'
'    '将Main表B2单元个的字体样式复制到ProductList表中
'    CopyCellFontFormat "Main", "B2", Range("ProductList[#ALL]")
'    '设置下列表对象名，用新的替换旧的
'    ReplaceTableHead "ProductList", GetHeadMap("ProductList")
'    '关闭自动筛选功能
'    Range("Productlist[#headers]").AutoFilter
'    '表体自适应格式
'    Range("ProductList[#All]").Columns.EntireColumn.AutoFit
'    '隐藏某字段
'    HideTableColumns "ProductList", "【PD0_CONO】【PD0_DIVI】", True
'    '冻结窗口HideTableColumns "ProductList", "【操作】" & GetHeadMap("ProductList"), False
'    FreezeCell "商品信息", "G6", True
'    '设置可编辑区域
'   ' AddEditRangeByHead "ProductList", 0, GetEditColumnsName("ProductList")
'    '设置下拉菜单
'    SetValidationStr Range("ProductList[[供应商编号]]"), "=基础!$AW$7:$AW$500"
'    SetValidationStr Range("ProductList[[年份]]"), "=基础!$CW$7:$CW$50"
'    SetValidationStr Range("ProductList[[季节]]"), "=基础!$DL$7:$DL$20"
'    SetValidationStr Range("ProductList[[款式种类]]"), "=基础!$EA$7:$EA$50"
'    SetValidationStr Range("ProductList[[款式大类]]"), "=基础!$EP$7:$EP$50"
'
'End Function

Function SetFormat_ProductLoadList_All()
    
    '将Main表B2单元个的字体样式复制到ProductList表中
    CopyCellFontFormat "Main", "B2", Range("ProductList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "ProductList", GetHeadMap("ProductLoadList")
    '关闭自动筛选功能
    Range("ProductList[#headers]").AutoFilter
    '表体自适应格式
    Range("ProductList[#All]").Columns.EntireColumn.AutoFit
    '隐藏某字段
    HideTableColumns "ProductList", "【PD0_CONO】【PD0_DIVI】【SKU】【PD0_ColorSUId1】【PD0_SUO_SupplierId】【PD0_BD0_BrandId】【PD0_ColorSUId】【PD0_SizeSUId】【PD0_ColorId】【PD0_SizeId】" & _
    "【PD0_YearId】【PD0_SeasonId】【PD0_Lvl1】【PD0_Lvl2】【PD0_StandardId】【PD0_SecurityLevelId】【商品ID】【PD0_ColorBSUId】【PD0_Lvl0】【ColorSUDictName】【SizeSUDictName】" & _
    "【SeasonDictName】【Lvl1DictName】【Lvl2DictName】 ", True
    '冻结窗口HideTableColumns "ProductList", "【操作】" & GetHeadMap("ProductList"), False
    FreezeCell "商品信息", "J6", True
    
    '重新设定列的验证
    Sheets("商品信息").Columns("U:V").Select
    Selection.NumberFormatLocal = "0.00_ "
    With Selection.Validation
        .Delete
        .Add Type:=xlValidateDecimal, AlertStyle:=xlValidAlertStop, Operator _
        :=xlBetween, Formula1:="-999999999", Formula2:="99999999999"
        .IgnoreBlank = True
        .InCellDropdown = True
        .InputTitle = ""
        .ErrorTitle = ""
        .InputMessage = ""
        .ErrorMessage = ""
        .IMEMode = xlIMEModeNoControl
        .ShowInput = True
        .ShowError = True
    End With
        
    '设置可编辑区域
    AddEditRangeByHead "ProductList", 0, GetEditColumnsName("ProductList")
    '设置下拉菜单
'    SetValidationStr Range("ProductList[[供应商编号]]"), "=基础!$AW$7:$AW$" & GetRowId("SupplyBASEList", "MAX")
    SetValidationStr Range("ProductList[[年份]]"), "=基础!$CW$7:$CW$" & GetRowId("YearBaseList", "MAX")
    SetValidationStr Range("ProductList[[季节]]"), "=基础!$DL$7:$DL$" & GetRowId("SeasonBaseList", "MAX")
'    SetValidationStr Range("ProductList[[款式种类]]"), "=基础!$EA$7:$EA$" & GetRowId("Lvl1BaseList", "MAX")
'    SetValidationStr Range("ProductList[[款式大类]]"), "=基础!$EP$7:$EP$" & GetRowId("Lvl2BaseList", "MAX")
'    SetValidationStr Range("ProductList[[供应商颜色]]"), "=基础!$GX$7:$GX$" & GetRowId("SUColorBaseList", "MAX")
'    SetValidationStr Range("ProductList[[供应商尺码]]"), "=基础!$IB$7:$IB$" & GetRowId("SUSizeBaseList", "MAX")
    SetValidationStr Range("ProductList[[单位]]"), "=基础!$FE$7:$FE$" & GetRowId("UnitNameBaseList", "MAX")
    SetValidationStr Range("ProductList[[颜色]]"), "=基础!$HM$7:$HM$" & GetRowId("ColorBaseList", "MAX")
    SetValidationStr Range("ProductList[[尺码]]"), "=基础!$IQ$7:$IQ$" & GetRowId("SizeBaseList", "MAX")
    SetValidationStr Range("ProductList[[品牌名称]]"), "=基础!$BT$7:$BT$" & GetRowId("PMList", "MAX")
    '自动调整图片
    Range("ProductList[[款图]]").Columns.EntireColumn.ShrinkToFit = True
    'URL图片地址转换
    If (Range("ProductList[[款图]]").Rows.Count >= 1) Then
        For Each cl In Range("ProductList[[款图]]")
            If GetValueByHead("ProductList", cl.Row, "款图") <> "" Then
                cl.Value = Replace(cl.Value, "\\", "\")
                If Dir(cl.Value) <> "" Then
                    LoadPicInCell "商品信息", cl.Address(), "ProductList", 50, 50, cl.Value, GetValueByHead("ProductList", cl.Row, "款图")
                Else: SetValueByHead "ProductList", cl.Row, "款图", ""
                End If
            End If
        Next
     End If
End Function


Function SetFormat_ProductList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("商品信息").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("ProductList", rw.Row, "操作")
        str2 = GetValueByHead("ProductList", rw.Row, "供应商编号")
'        CopyCellFormat "商品信息", GetRangeStrByHead("ProductList", rw.Row, "操作"), Sheets("商品信息").Range(GetRangeStrByHead("ProductList", rw.Row, "商品信息编号"))
        If Str1 = "I" And str2 = "系统自动生成" Then
'                SetValidationStr Range("ProductList[[供应商编号]]"), "=基础!$AW$7:$AW$" & GetRowId("SupplyBASEList", "MAX")
                SetValidationStr Range("ProductList[[年份]]"), "=基础!$CW$7:$CW$" & GetRowId("YearBaseList", "MAX")
                SetValidationStr Range("ProductList[[季节]]"), "=基础!$DL$7:$DL$" & GetRowId("SeasonBaseList", "MAX")
'                SetValidationStr Range("ProductList[[款式种类]]"), "=基础!$EA$7:$EA$" & GetRowId("Lvl1BaseList", "MAX")
'                SetValidationStr Range("ProductList[[款式大类]]"), "=基础!$EP$7:$EP$" & GetRowId("Lvl2BaseList", "MAX")
                SetValidationStr Range("ProductList[[供应商颜色]]"), "=基础!$GX$7:$GX$" & GetRowId("SUColorBaseList", "MAX")
                SetValidationStr Range("ProductList[[供应商尺码]]"), "=基础!$IB$7:$IB$" & GetRowId("SUSizeBaseList", "MAX")
                SetValidationStr Range("ProductList[[颜色]]"), "=基础!$HM$7:$HM$" & GetRowId("ColorBaseList", "MAX")
                SetValidationStr Range("ProductList[[尺码]]"), "=基础!$IQ$7:$IQ$" & GetRowId("SizeBaseList", "MAX")
        End If
        CurRow = Selection.Row
        If Str1 = "I" Then
            AddEditRangeByHead "ProductList", CurRow, "【品牌名称】" & "【供应商款号】" & GetEditColumnsName("ProductList")
        End If
    Next
End Function
Function 商品信息_Change(CurRow As Long, Curcol As Long)
Dim LocationStr As String
Dim ColumnName As String

ScreenUpdate False

'限定区域
If IsInTable("ProductList", CurRow, Curcol) Then
   ColumnName = Sheets("商品信息").Cells(GetRowId("ProductList", "Min") - 1, Curcol).Value
Else
    GoTo N
End If

If ColumnName <> "操作" Then   '如果获取的表头名称不为[操作]
    If GetValueByHead("ProductList", CurRow, "PD0_SecurityLevelId") <> "系统自动生成" Then      '获取ProductList的CurRow行、商品信息编号的值不为空,不能为系统自动生成
        SetValueByHead "ProductList", CurRow, "操作", "U"  '将该行的操作字段变为为U
        'SetFormat_ProductList_Line CurRow, CurRow   '根据SProductList_Line设置字段格式
    End If
Else
    GoTo N
End If
N:
ScreenUpdate True
End Function
Function SetFormat_CommandButton_All()
'固定Sheet中按钮的位置与大小
    Sheets("商品信息").CommandButton1.Top = 37.5
    Sheets("商品信息").CommandButton1.Width = 67.5
    Sheets("商品信息").CommandButton1.Left = 1.5
    Sheets("商品信息").CommandButton1.Height = 24
    
    Sheets("商品信息").CommandButton2.Top = 37.5
    Sheets("商品信息").CommandButton2.Width = 67.5
    Sheets("商品信息").CommandButton2.Left = 70.5
    Sheets("商品信息").CommandButton2.Height = 24
    
    Sheets("商品信息").CommandButton8.Top = 37.5
    Sheets("商品信息").CommandButton8.Width = 67.5
    Sheets("商品信息").CommandButton8.Left = 138.75
    Sheets("商品信息").CommandButton8.Height = 24
    
    Sheets("商品信息").CommandButton3.Top = 37.5
    Sheets("商品信息").CommandButton3.Width = 67.5
    Sheets("商品信息").CommandButton3.Left = 207
    Sheets("商品信息").CommandButton3.Height = 24
           
    Sheets("商品信息").CommandButton4.Top = 66
    Sheets("商品信息").CommandButton4.Width = 47.25
    Sheets("商品信息").CommandButton4.Left = 1.5
    Sheets("商品信息").CommandButton4.Height = 27
        
    Sheets("商品信息").CommandButton7.Top = 66
    Sheets("商品信息").CommandButton7.Width = 47.25
    Sheets("商品信息").CommandButton7.Left = 57.75
    Sheets("商品信息").CommandButton7.Height = 27
    
    Sheets("商品信息").CommandButton5.Top = 11.25
    Sheets("商品信息").CommandButton5.Width = 67.5
    Sheets("商品信息").CommandButton5.Left = 1.5
    Sheets("商品信息").CommandButton5.Height = 24
    
    Sheets("商品信息").CommandButton6.Top = 11.25
    Sheets("商品信息").CommandButton6.Width = 67.5
    Sheets("商品信息").CommandButton6.Left = 105
    Sheets("商品信息").CommandButton6.Height = 24
    
    Sheets("商品信息").CommandButton9.Top = 11.25
    Sheets("商品信息").CommandButton9.Width = 67.5
    Sheets("商品信息").CommandButton9.Left = 206.25
    Sheets("商品信息").CommandButton9.Height = 24
End Function


Function SetSaveValue()

    Dim selectItemPD0_SUO_SupplierId As String, selectItemPD0_YearId As String, selectItemPD0_SeasonId As String, selectItemPD0_Lvl1 As String, selectItemPD0_Lvl2 As String
    Dim dictIdPD0_SUO_SupplierId As String, dictIdPD0_YearId As String, dictIdPD0_SeasonId As String, dictIdPD0_Lvl1 As String, dictIdPD0_Lvl2 As String
    
'    Dim selectItemPD0_ColorSUId As String, selectItemPD0_SizeSUId As String, selectItemPD0_ColorId As String, selectItemPD0_SizeId As String, selectItemPD0_StandardId As String, selectItemPD0_SecurityLevelId As String
'    Dim dictIdPD0_ColorSUId As String, dictIdPD0_SizeSUId As String, dictIdPD0_ColorId As String, dictIdPD0_SizeId As String, dictIdPD0_StandardId  As String, dictIdPD0_SecurityLevelId As String
    
    CurRow = Selection.Row
    
     '设置供应商编号的下拉和取值
    selectItemPD0_SUO_SupplierId = GetValueByHead("ProductList", CurRow, "供应商编号")
    dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
    SetValueByHead "ProductList", CurRow, "PD0_SUO_SupplierId", dictIdPD0_SUO_SupplierId
    
    '设置年份的下拉和取值
     selectItemPD0_YearId = GetValueByHead("ProductList", CurRow, "年份")
     dictIdPD0_YearId = getMBQTGUID("YearBaseList", "DC0_DictName1", selectItemPD0_YearId, "DC0_DictId")
     MsgBox dictIdPD0_YearId
     SetValueByHead "ProductList", CurRow, "PD0_YearId", dictIdPD0_YearId
     
     

     '设置季节的下拉和取值
    selectItemPD0_SeasonId = GetValueByHead("ProductList", CurRow, "季节")
    dictIdPD0_SeasonId = getMBQTGUID("SeasonBaseList", "DC0_DictName1", selectItemPD0_SeasonId, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_SeasonId", dictIdPD0_SeasonId
    
    '设置款式种类的下拉和取值
    selectItemPD0_Lvl1 = GetValueByHead("ProductList", CurRow, "款式种类")
    dictIdPD0_Lvl1 = getMBQTGUID("Lvl1BaseList", "DC0_DictName1", selectItemPD0_Lvl1, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_Lvl1", dictIdPD0_Lvl1
   
   '设置款式种类的下拉和取值
    selectItemPD0_Lvl2 = GetValueByHead("ProductList", CurRow, "款式大类")
    dictIdPD0_Lvl2 = getMBQTGUID("Lvl2BaseList", "DC0_DictName1", selectItemPD0_Lvl2, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_Lvl2", dictIdPD0_Lvl2
    
  
    
     '设置供应商编号的下拉和取值
    selectItemPD0_SUO_SupplierId = GetValueByHead("ProductList", CurRow, "供应商编号")
    dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "供应商编号", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
    SetValueByHead "ProductList", CurRow, "PD0_SUO_SupplierId", dictIdPD0_SUO_SupplierId
    
    '设置年份的下拉和取值
     selectItemPD0_YearId = GetValueByHead("ProductList", CurRow, "年份")
     dictIdPD0_YearId = getMBQTGUID("YearBaseList", "DC0_DictName1", selectItemPD0_YearId, "DC0_DictId")
     MsgBox dictIdPD0_YearId
     SetValueByHead "ProductList", CurRow, "PD0_YearId", dictIdPD0_YearId
     
     

     '设置季节的下拉和取值
    selectItemPD0_SeasonId = GetValueByHead("ProductList", CurRow, "季节")
    dictIdPD0_SeasonId = getMBQTGUID("SeasonBaseList", "DC0_DictName1", selectItemPD0_SeasonId, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_SeasonId", dictIdPD0_SeasonId
    
    '设置款式种类的下拉和取值
    selectItemPD0_Lvl1 = GetValueByHead("ProductList", CurRow, "款式种类")
    dictIdPD0_Lvl1 = getMBQTGUID("Lvl1BaseList", "DC0_DictName1", selectItemPD0_Lvl1, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_Lvl1", dictIdPD0_Lvl1
   
   '设置款式种类的下拉和取值
    selectItemPD0_Lvl2 = GetValueByHead("ProductList", CurRow, "款式大类")
    dictIdPD0_Lvl2 = getMBQTGUID("Lvl2BaseList", "DC0_DictName1", selectItemPD0_Lvl2, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_Lvl2", dictIdPD0_Lvl2
End Function

