Attribute VB_Name = "F07_��Ʒ��Ϣ_ͨ��"
'Function SetFormat_ProductList_All()
'
'    '��Main��B2��Ԫ����������ʽ���Ƶ�ProductList����
'    CopyCellFontFormat "Main", "B2", Range("ProductList[#ALL]")
'    '�������б�����������µ��滻�ɵ�
'    ReplaceTableHead "ProductList", GetHeadMap("ProductList")
'    '�ر��Զ�ɸѡ����
'    Range("Productlist[#headers]").AutoFilter
'    '��������Ӧ��ʽ
'    Range("ProductList[#All]").Columns.EntireColumn.AutoFit
'    '����ĳ�ֶ�
'    HideTableColumns "ProductList", "��PD0_CONO����PD0_DIVI��", True
'    '���ᴰ��HideTableColumns "ProductList", "��������" & GetHeadMap("ProductList"), False
'    FreezeCell "��Ʒ��Ϣ", "G6", True
'    '���ÿɱ༭����
'   ' AddEditRangeByHead "ProductList", 0, GetEditColumnsName("ProductList")
'    '���������˵�
'    SetValidationStr Range("ProductList[[��Ӧ�̱��]]"), "=����!$AW$7:$AW$500"
'    SetValidationStr Range("ProductList[[���]]"), "=����!$CW$7:$CW$50"
'    SetValidationStr Range("ProductList[[����]]"), "=����!$DL$7:$DL$20"
'    SetValidationStr Range("ProductList[[��ʽ����]]"), "=����!$EA$7:$EA$50"
'    SetValidationStr Range("ProductList[[��ʽ����]]"), "=����!$EP$7:$EP$50"
'
'End Function

Function SetFormat_ProductLoadList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�ProductList����
    CopyCellFontFormat "Main", "B2", Range("ProductList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "ProductList", GetHeadMap("ProductLoadList")
    '�ر��Զ�ɸѡ����
    Range("ProductList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("ProductList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "ProductList", "��PD0_CONO����PD0_DIVI����SKU����PD0_ColorSUId1����PD0_SUO_SupplierId����PD0_BD0_BrandId����PD0_ColorSUId����PD0_SizeSUId����PD0_ColorId����PD0_SizeId��" & _
    "��PD0_YearId����PD0_SeasonId����PD0_Lvl1����PD0_Lvl2����PD0_StandardId����PD0_SecurityLevelId������ƷID����PD0_ColorBSUId����PD0_Lvl0����ColorSUDictName����SizeSUDictName��" & _
    "��SeasonDictName����Lvl1DictName����Lvl2DictName�� ", True
    '���ᴰ��HideTableColumns "ProductList", "��������" & GetHeadMap("ProductList"), False
    FreezeCell "��Ʒ��Ϣ", "J6", True
    
    '�����趨�е���֤
    Sheets("��Ʒ��Ϣ").Columns("U:V").Select
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
        
    '���ÿɱ༭����
    AddEditRangeByHead "ProductList", 0, GetEditColumnsName("ProductList")
    '���������˵�
'    SetValidationStr Range("ProductList[[��Ӧ�̱��]]"), "=����!$AW$7:$AW$" & GetRowId("SupplyBASEList", "MAX")
    SetValidationStr Range("ProductList[[���]]"), "=����!$CW$7:$CW$" & GetRowId("YearBaseList", "MAX")
    SetValidationStr Range("ProductList[[����]]"), "=����!$DL$7:$DL$" & GetRowId("SeasonBaseList", "MAX")
'    SetValidationStr Range("ProductList[[��ʽ����]]"), "=����!$EA$7:$EA$" & GetRowId("Lvl1BaseList", "MAX")
'    SetValidationStr Range("ProductList[[��ʽ����]]"), "=����!$EP$7:$EP$" & GetRowId("Lvl2BaseList", "MAX")
'    SetValidationStr Range("ProductList[[��Ӧ����ɫ]]"), "=����!$GX$7:$GX$" & GetRowId("SUColorBaseList", "MAX")
'    SetValidationStr Range("ProductList[[��Ӧ�̳���]]"), "=����!$IB$7:$IB$" & GetRowId("SUSizeBaseList", "MAX")
    SetValidationStr Range("ProductList[[��λ]]"), "=����!$FE$7:$FE$" & GetRowId("UnitNameBaseList", "MAX")
    SetValidationStr Range("ProductList[[��ɫ]]"), "=����!$HM$7:$HM$" & GetRowId("ColorBaseList", "MAX")
    SetValidationStr Range("ProductList[[����]]"), "=����!$IQ$7:$IQ$" & GetRowId("SizeBaseList", "MAX")
    SetValidationStr Range("ProductList[[Ʒ������]]"), "=����!$BT$7:$BT$" & GetRowId("PMList", "MAX")
    '�Զ�����ͼƬ
    Range("ProductList[[��ͼ]]").Columns.EntireColumn.ShrinkToFit = True
    'URLͼƬ��ַת��
    If (Range("ProductList[[��ͼ]]").Rows.Count >= 1) Then
        For Each cl In Range("ProductList[[��ͼ]]")
            If GetValueByHead("ProductList", cl.Row, "��ͼ") <> "" Then
                cl.Value = Replace(cl.Value, "\\", "\")
                If Dir(cl.Value) <> "" Then
                    LoadPicInCell "��Ʒ��Ϣ", cl.Address(), "ProductList", 50, 50, cl.Value, GetValueByHead("ProductList", cl.Row, "��ͼ")
                Else: SetValueByHead "ProductList", cl.Row, "��ͼ", ""
                End If
            End If
        Next
     End If
End Function


Function SetFormat_ProductList_Line(FRowid As Long, TRowId As Long)

    Dim Str1 As String
    Dim str2 As String
    Dim CurRow As Long
    For Each rw In Sheets("��Ʒ��Ϣ").Range(FRowid & ":" & TRowId).Rows
        Str1 = GetValueByHead("ProductList", rw.Row, "����")
        str2 = GetValueByHead("ProductList", rw.Row, "��Ӧ�̱��")
'        CopyCellFormat "��Ʒ��Ϣ", GetRangeStrByHead("ProductList", rw.Row, "����"), Sheets("��Ʒ��Ϣ").Range(GetRangeStrByHead("ProductList", rw.Row, "��Ʒ��Ϣ���"))
        If Str1 = "I" And str2 = "ϵͳ�Զ�����" Then
'                SetValidationStr Range("ProductList[[��Ӧ�̱��]]"), "=����!$AW$7:$AW$" & GetRowId("SupplyBASEList", "MAX")
                SetValidationStr Range("ProductList[[���]]"), "=����!$CW$7:$CW$" & GetRowId("YearBaseList", "MAX")
                SetValidationStr Range("ProductList[[����]]"), "=����!$DL$7:$DL$" & GetRowId("SeasonBaseList", "MAX")
'                SetValidationStr Range("ProductList[[��ʽ����]]"), "=����!$EA$7:$EA$" & GetRowId("Lvl1BaseList", "MAX")
'                SetValidationStr Range("ProductList[[��ʽ����]]"), "=����!$EP$7:$EP$" & GetRowId("Lvl2BaseList", "MAX")
                SetValidationStr Range("ProductList[[��Ӧ����ɫ]]"), "=����!$GX$7:$GX$" & GetRowId("SUColorBaseList", "MAX")
                SetValidationStr Range("ProductList[[��Ӧ�̳���]]"), "=����!$IB$7:$IB$" & GetRowId("SUSizeBaseList", "MAX")
                SetValidationStr Range("ProductList[[��ɫ]]"), "=����!$HM$7:$HM$" & GetRowId("ColorBaseList", "MAX")
                SetValidationStr Range("ProductList[[����]]"), "=����!$IQ$7:$IQ$" & GetRowId("SizeBaseList", "MAX")
        End If
        CurRow = Selection.Row
        If Str1 = "I" Then
            AddEditRangeByHead "ProductList", CurRow, "��Ʒ�����ơ�" & "����Ӧ�̿�š�" & GetEditColumnsName("ProductList")
        End If
    Next
End Function
Function ��Ʒ��Ϣ_Change(CurRow As Long, Curcol As Long)
Dim LocationStr As String
Dim ColumnName As String

ScreenUpdate False

'�޶�����
If IsInTable("ProductList", CurRow, Curcol) Then
   ColumnName = Sheets("��Ʒ��Ϣ").Cells(GetRowId("ProductList", "Min") - 1, Curcol).Value
Else
    GoTo N
End If

If ColumnName <> "����" Then   '�����ȡ�ı�ͷ���Ʋ�Ϊ[����]
    If GetValueByHead("ProductList", CurRow, "PD0_SecurityLevelId") <> "ϵͳ�Զ�����" Then      '��ȡProductList��CurRow�С���Ʒ��Ϣ��ŵ�ֵ��Ϊ��,����Ϊϵͳ�Զ�����
        SetValueByHead "ProductList", CurRow, "����", "U"  '�����еĲ����ֶα�ΪΪU
        'SetFormat_ProductList_Line CurRow, CurRow   '����SProductList_Line�����ֶθ�ʽ
    End If
Else
    GoTo N
End If
N:
ScreenUpdate True
End Function
Function SetFormat_CommandButton_All()
'�̶�Sheet�а�ť��λ�����С
    Sheets("��Ʒ��Ϣ").CommandButton1.Top = 37.5
    Sheets("��Ʒ��Ϣ").CommandButton1.Width = 67.5
    Sheets("��Ʒ��Ϣ").CommandButton1.Left = 1.5
    Sheets("��Ʒ��Ϣ").CommandButton1.Height = 24
    
    Sheets("��Ʒ��Ϣ").CommandButton2.Top = 37.5
    Sheets("��Ʒ��Ϣ").CommandButton2.Width = 67.5
    Sheets("��Ʒ��Ϣ").CommandButton2.Left = 70.5
    Sheets("��Ʒ��Ϣ").CommandButton2.Height = 24
    
    Sheets("��Ʒ��Ϣ").CommandButton8.Top = 37.5
    Sheets("��Ʒ��Ϣ").CommandButton8.Width = 67.5
    Sheets("��Ʒ��Ϣ").CommandButton8.Left = 138.75
    Sheets("��Ʒ��Ϣ").CommandButton8.Height = 24
    
    Sheets("��Ʒ��Ϣ").CommandButton3.Top = 37.5
    Sheets("��Ʒ��Ϣ").CommandButton3.Width = 67.5
    Sheets("��Ʒ��Ϣ").CommandButton3.Left = 207
    Sheets("��Ʒ��Ϣ").CommandButton3.Height = 24
           
    Sheets("��Ʒ��Ϣ").CommandButton4.Top = 66
    Sheets("��Ʒ��Ϣ").CommandButton4.Width = 47.25
    Sheets("��Ʒ��Ϣ").CommandButton4.Left = 1.5
    Sheets("��Ʒ��Ϣ").CommandButton4.Height = 27
        
    Sheets("��Ʒ��Ϣ").CommandButton7.Top = 66
    Sheets("��Ʒ��Ϣ").CommandButton7.Width = 47.25
    Sheets("��Ʒ��Ϣ").CommandButton7.Left = 57.75
    Sheets("��Ʒ��Ϣ").CommandButton7.Height = 27
    
    Sheets("��Ʒ��Ϣ").CommandButton5.Top = 11.25
    Sheets("��Ʒ��Ϣ").CommandButton5.Width = 67.5
    Sheets("��Ʒ��Ϣ").CommandButton5.Left = 1.5
    Sheets("��Ʒ��Ϣ").CommandButton5.Height = 24
    
    Sheets("��Ʒ��Ϣ").CommandButton6.Top = 11.25
    Sheets("��Ʒ��Ϣ").CommandButton6.Width = 67.5
    Sheets("��Ʒ��Ϣ").CommandButton6.Left = 105
    Sheets("��Ʒ��Ϣ").CommandButton6.Height = 24
    
    Sheets("��Ʒ��Ϣ").CommandButton9.Top = 11.25
    Sheets("��Ʒ��Ϣ").CommandButton9.Width = 67.5
    Sheets("��Ʒ��Ϣ").CommandButton9.Left = 206.25
    Sheets("��Ʒ��Ϣ").CommandButton9.Height = 24
End Function


Function SetSaveValue()

    Dim selectItemPD0_SUO_SupplierId As String, selectItemPD0_YearId As String, selectItemPD0_SeasonId As String, selectItemPD0_Lvl1 As String, selectItemPD0_Lvl2 As String
    Dim dictIdPD0_SUO_SupplierId As String, dictIdPD0_YearId As String, dictIdPD0_SeasonId As String, dictIdPD0_Lvl1 As String, dictIdPD0_Lvl2 As String
    
'    Dim selectItemPD0_ColorSUId As String, selectItemPD0_SizeSUId As String, selectItemPD0_ColorId As String, selectItemPD0_SizeId As String, selectItemPD0_StandardId As String, selectItemPD0_SecurityLevelId As String
'    Dim dictIdPD0_ColorSUId As String, dictIdPD0_SizeSUId As String, dictIdPD0_ColorId As String, dictIdPD0_SizeId As String, dictIdPD0_StandardId  As String, dictIdPD0_SecurityLevelId As String
    
    CurRow = Selection.Row
    
     '���ù�Ӧ�̱�ŵ�������ȡֵ
    selectItemPD0_SUO_SupplierId = GetValueByHead("ProductList", CurRow, "��Ӧ�̱��")
    dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "��Ӧ�̱��", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
    SetValueByHead "ProductList", CurRow, "PD0_SUO_SupplierId", dictIdPD0_SUO_SupplierId
    
    '������ݵ�������ȡֵ
     selectItemPD0_YearId = GetValueByHead("ProductList", CurRow, "���")
     dictIdPD0_YearId = getMBQTGUID("YearBaseList", "DC0_DictName1", selectItemPD0_YearId, "DC0_DictId")
     MsgBox dictIdPD0_YearId
     SetValueByHead "ProductList", CurRow, "PD0_YearId", dictIdPD0_YearId
     
     

     '���ü��ڵ�������ȡֵ
    selectItemPD0_SeasonId = GetValueByHead("ProductList", CurRow, "����")
    dictIdPD0_SeasonId = getMBQTGUID("SeasonBaseList", "DC0_DictName1", selectItemPD0_SeasonId, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_SeasonId", dictIdPD0_SeasonId
    
    '���ÿ�ʽ�����������ȡֵ
    selectItemPD0_Lvl1 = GetValueByHead("ProductList", CurRow, "��ʽ����")
    dictIdPD0_Lvl1 = getMBQTGUID("Lvl1BaseList", "DC0_DictName1", selectItemPD0_Lvl1, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_Lvl1", dictIdPD0_Lvl1
   
   '���ÿ�ʽ�����������ȡֵ
    selectItemPD0_Lvl2 = GetValueByHead("ProductList", CurRow, "��ʽ����")
    dictIdPD0_Lvl2 = getMBQTGUID("Lvl2BaseList", "DC0_DictName1", selectItemPD0_Lvl2, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_Lvl2", dictIdPD0_Lvl2
    
  
    
     '���ù�Ӧ�̱�ŵ�������ȡֵ
    selectItemPD0_SUO_SupplierId = GetValueByHead("ProductList", CurRow, "��Ӧ�̱��")
    dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "��Ӧ�̱��", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
    SetValueByHead "ProductList", CurRow, "PD0_SUO_SupplierId", dictIdPD0_SUO_SupplierId
    
    '������ݵ�������ȡֵ
     selectItemPD0_YearId = GetValueByHead("ProductList", CurRow, "���")
     dictIdPD0_YearId = getMBQTGUID("YearBaseList", "DC0_DictName1", selectItemPD0_YearId, "DC0_DictId")
     MsgBox dictIdPD0_YearId
     SetValueByHead "ProductList", CurRow, "PD0_YearId", dictIdPD0_YearId
     
     

     '���ü��ڵ�������ȡֵ
    selectItemPD0_SeasonId = GetValueByHead("ProductList", CurRow, "����")
    dictIdPD0_SeasonId = getMBQTGUID("SeasonBaseList", "DC0_DictName1", selectItemPD0_SeasonId, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_SeasonId", dictIdPD0_SeasonId
    
    '���ÿ�ʽ�����������ȡֵ
    selectItemPD0_Lvl1 = GetValueByHead("ProductList", CurRow, "��ʽ����")
    dictIdPD0_Lvl1 = getMBQTGUID("Lvl1BaseList", "DC0_DictName1", selectItemPD0_Lvl1, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_Lvl1", dictIdPD0_Lvl1
   
   '���ÿ�ʽ�����������ȡֵ
    selectItemPD0_Lvl2 = GetValueByHead("ProductList", CurRow, "��ʽ����")
    dictIdPD0_Lvl2 = getMBQTGUID("Lvl2BaseList", "DC0_DictName1", selectItemPD0_Lvl2, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_Lvl2", dictIdPD0_Lvl2
End Function

