Attribute VB_Name = "F22_�ջ�����_ͨ��"
Function SetFormat_RecDetailsMainList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�RecDetailsMainList����
    CopyCellFontFormat "Main", "B2", Range("RecDetailsMainList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "RecDetailsMainList", GetHeadMap("RecDetailsMainList")
    '�ر��Զ�ɸѡ����
'    Range("RecDetailsMainList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("RecDetailsMainList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "RecDetailsMainList", "�����š�����ҵ�塿�������ƻ�ID�����ջ���ID����״̬ID��", True
    
    '���ᴰ��
'    FreezeCell "��Ӧ��", "G9", False
    '���ÿɱ༭����
    AddEditRangeByHead "RecDetailsMainList", 0, GetEditColumnsName("RecDetailsMainList")
    '���������˵�
'    SetValidationStr Range("RecDetailsMainList[[���뵥����]]"), "=����!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function

