Attribute VB_Name = "F13_采购明细_通用"
Function SetFormat_PODetailList_All()
    '将Main表B2单元个的字体样式复制到ProductList表中
    CopyCellFontFormat "Main", "B2", Range("PODetailList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "PODetailList", GetHeadMap("PODetailList")
    '表体自适应格式
    Range("PODetailList[#All]").Columns.EntireColumn.AutoFit
    '设置下拉框
    SetValidationStr Range("PODetailList[[单位]]"), "=基础!$FE$7:$FE$" & GetRowId("GYSFLList", "MAX")
    '隐藏字段
    HideTableColumns "PODetailList", "【集团】【事业体】【采购单明细ID】【供应商类型】【采购单编号GUID】【供应商颜色ID】【供应商尺码ID】【SKU】【商品ID】【单位GUID】【采购币种GUID】【采购单状态GUID】【序号】【PD0_ProductCodeSU】【PD0_ColorId】【PD0_ColorBSUId】", True
End Function

Function SetFormat_NewPODetailList_All()
    '将Main表B2单元个的字体样式复制到ProductList表中
    CopyCellFontFormat "Main", "B2", Range("NewPODetailList[#ALL]")
    '设置下列表对象名，用新的替换旧的
    ReplaceTableHead "NewPODetailList", GetHeadMap("NewPODetailList")
    '表体自适应格式
    Range("NewPODetailList[#All]").Columns.EntireColumn.AutoFit
    '设置下拉菜单
    SetValidationStr Range("NewPODetailList[[单位]]"), "=基础!$FE$7:$FE$" & GetRowId("GYSFLList", "MAX")
    Range("NewPODetailList[[预计出货日期]]").NumberFormatLocal = "yyyy/mm/dd"
    '隐藏字段
    HideTableColumns "NewPODetailList", "【集团】【事业体】【采购单明细ID】【供应商类型】【采购单编号GUID】【商品ID】【单位ID】", True
End Function


Function PODetail_Change(CurRow As Long, Curcol As Long)
    Dim LocationStr As String
    Dim ColumnName As String
    Dim wrksht As Worksheet
    
    ScreenUpdate False
    Set wrksht = ActiveWorkbook.Worksheets("采购单明细")
    '限定区域
    If TableIsExists("采购单明细") = True Then
        If wrksht.ListObjects(1).Name = "PODetailList" Then
            If GetValueByHead("PODetailList", CurRow, "操作") <> "I" Then
                If IsInTable("PODetailList", CurRow, Curcol) Then
                    ColumnName = Sheets("采购单明细").Cells(GetRowId("PODetailList", "Min") - 1, Curcol).Value
                Else
                    GoTo N
                End If
                
                If ColumnName <> "操作" Then   '如果获取的表头名称不为[操作]
                    SetValueByHead "PODetailList", CurRow, "操作", "U"  '将该行的操作字段变为为U
                End If
            End If
        End If
    End If
N:
    ScreenUpdate True
End Function
