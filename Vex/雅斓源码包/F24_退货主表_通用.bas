Attribute VB_Name = "F24_�˻�����_ͨ��"
Function SetFormat_PayTHList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�PayTHList����
    CopyCellFontFormat "Main", "B2", Range("PayTHList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "PayTHList", GetHeadMap("PayTHList")
    '�ر��Զ�ɸѡ����
'    Range("PayTHList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("PayTHList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "PayTHList", "��FNP_CONO����FNP_DIVI�������뵥ID�����˻�������ID������Ӧ��ID�������뵥���͡�", True
    
    '���ᴰ��
    FreezeCell "��Ӧ��", "G9", False
    '���ÿɱ༭����
    AddEditRangeByHead "PayTHList", 0, GetEditColumnsName("PayTHList")
    '���������˵�
'    SetValidationStr Range("PayTHList[[���뵥����]]"), "=����!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
