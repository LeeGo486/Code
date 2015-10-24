Attribute VB_Name = "F17_�����ƻ�_ͨ��"
Function SetFormat_DeliveryPlanMXList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�DeliveryPlanMXList����
    CopyCellFontFormat "Main", "B2", Range("DeliveryPlanMXList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "DeliveryPlanMXList", GetHeadMap("DeliveryPlanMXList")
    '�ر��Զ�ɸѡ����
    Range("DeliveryPlanMXList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("DeliveryPlanMXList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "DeliveryPlanMXList", "��PRAD_CONO����PRAD_DIVI���������ƻ�ID����PRAD_Status����״̬���������ƻ���ϸID���������ƻ�����ID������ƷID����PRAD_UnitID�����ɹ�����ϸID�� ", True
    
     '�����趨�е���֤
    Sheets("�����ƻ���ϸ").Columns("S:S").Select
    Selection.NumberFormatLocal = "0_ "
    With Selection.Validation
        .Delete
        .Add Type:=xlValidateWholeNumber, AlertStyle:=xlValidAlertStop, _
        Operator:=xlGreaterEqual, Formula1:="0"
        .IgnoreBlank = True
        .InCellDropdown = True
        .InputTitle = ""
        .ErrorTitle = ""
        .InputMessage = ""
        .ErrorMessage = "��������ݱ���Ϊ����0������"
        .IMEMode = xlIMEModeNoControl
        .ShowInput = True
        .ShowError = True
    End With
    
    '���ᴰ��
'    FreezeCell "��Ӧ��", "H10", True
    '���ÿɱ༭����
    AddEditRangeByHead "DeliveryPlanMXList", 0, GetEditColumnsName("DeliveryPlanMXList")
    '���������˵�
'    SetValidationStr Range("DeliveryPlanMXList[[��Ӧ�̷���]]"), "=����!$E$7:$E$" & GetRowId("GYSFLList", "MAX")
End Function
Function SetFormat_PayDHList_All()
    
    '��Main��B2��Ԫ����������ʽ���Ƶ�PayDHList����
    CopyCellFontFormat "Main", "B2", Range("PayDHList[#ALL]")
    '�������б�����������µ��滻�ɵ�
    ReplaceTableHead "PayDHList", GetHeadMap("PayDHList")
    '�ر��Զ�ɸѡ����
'    Range("PayDHList[#headers]").AutoFilter
    '��������Ӧ��ʽ
    Range("PayDHList[#All]").Columns.EntireColumn.AutoFit
    '����ĳ�ֶ�
    HideTableColumns "PayDHList", "��DC0_CONO����DC0_DIVI�������뵥ID���������ƻ�GUID������Ӧ��GUID����SU0_LmDt��", True
    
    '���ᴰ��
    FreezeCell "��Ӧ��", "G9", False
    '���ÿɱ༭����
    AddEditRangeByHead "PayDHList", 0, GetEditColumnsName("PayDHList")
    '���������˵�
'    SetValidationStr Range("PayDHList[[���뵥����]]"), "=����!KY$7:$KY$" & GetRowId("SQDLXList", "MAX")
End Function
