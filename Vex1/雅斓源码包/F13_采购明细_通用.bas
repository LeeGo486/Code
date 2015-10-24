Attribute VB_Name = "F13_�ɹ���ϸ_ͨ��"
Function SetFormat_PODetailList_All()
    '��Main��B2��Ԫ����������ʽ���Ƶ�ProductList����
    CopyCellFontFormat "Main", "B2", Range("PODetailList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "PODetailList", GetHeadMap("PODetailList")
    '��������Ӧ��ʽ
    Range("PODetailList[#All]").Columns.EntireColumn.AutoFit
    '����������
    SetValidationStr Range("PODetailList[[��λ]]"), "=����!$FE$7:$FE$" & GetRowId("GYSFLList", "MAX")
    '�����ֶ�
    HideTableColumns "PODetailList", "�����š�����ҵ�塿���ɹ�����ϸID������Ӧ�����͡����ɹ������GUID������Ӧ����ɫID������Ӧ�̳���ID����SKU������ƷID������λGUID�����ɹ�����GUID�����ɹ���״̬GUID������š���PD0_ProductCodeSU����PD0_ColorId����PD0_ColorBSUId��", True
End Function

Function SetFormat_NewPODetailList_All()
    '��Main��B2��Ԫ����������ʽ���Ƶ�ProductList����
    CopyCellFontFormat "Main", "B2", Range("NewPODetailList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "NewPODetailList", GetHeadMap("NewPODetailList")
    '��������Ӧ��ʽ
    Range("NewPODetailList[#All]").Columns.EntireColumn.AutoFit
    '���������˵�
    SetValidationStr Range("NewPODetailList[[��λ]]"), "=����!$FE$7:$FE$" & GetRowId("GYSFLList", "MAX")
    Range("NewPODetailList[[Ԥ�Ƴ�������]]").NumberFormatLocal = "yyyy/mm/dd"
    '�����ֶ�
    HideTableColumns "NewPODetailList", "�����š�����ҵ�塿���ɹ�����ϸID������Ӧ�����͡����ɹ������GUID������ƷID������λID��", True
End Function


Function PODetail_Change(CurRow As Long, Curcol As Long)
    Dim LocationStr As String
    Dim ColumnName As String
    Dim wrksht As Worksheet
    
    ScreenUpdate False
    Set wrksht = ActiveWorkbook.Worksheets("�ɹ�����ϸ")
    '�޶�����
    If TableIsExists("�ɹ�����ϸ") = True Then
        If wrksht.ListObjects(1).Name = "PODetailList" Then
            If GetValueByHead("PODetailList", CurRow, "����") <> "I" Then
                If IsInTable("PODetailList", CurRow, Curcol) Then
                    ColumnName = Sheets("�ɹ�����ϸ").Cells(GetRowId("PODetailList", "Min") - 1, Curcol).Value
                Else
                    GoTo N
                End If
                
                If ColumnName <> "����" Then   '�����ȡ�ı�ͷ���Ʋ�Ϊ[����]
                    SetValueByHead "PODetailList", CurRow, "����", "U"  '�����еĲ����ֶα�ΪΪU
                End If
            End If
        End If
    End If
N:
    ScreenUpdate True
End Function
