Attribute VB_Name = "F08_��Ʒ��Ϣ_����"
Sub ��Ʒ��Ϣ_CreateSplit()
    '��Ʒ��Ϣ�½�����
        Dim P_Sno As String
    ProtectSheet "��Ʒ��Ϣ", False
'    If CheckIsLogin() = False Then GoTo N:

        Dim CurRow As Long
        Dim PSno As String
        Dim BH As String
        Dim CJR As String               '����һ���������ڴ�ŵ�½����
        Dim Guid As String
        CurRow = Selection.Row
        PSno = GetValueByHead("ProductList", CurRow, "��Ӧ�̱��")

    If CheckSelectionInTable("ProductList", True) = False Then GoTo N
        ScreenUpdate False
        InsertLine "��Ʒ��Ϣ", 5, True
        CurRow = Selection.Row
        CJR = Sheets("��Ӧ��").Range("B1").Value
        Guid = LCase(Mid$(CreateObject("Scriptlet.TypeLib").Guid, 2, 36))
        BH = GetValueByHead("ProductList", CurRow, "��Ӧ�̱��")
        SetValueByHead "ProductList", CurRow, "����", "I"
        SetValueByHead "ProductList", CurRow, "PD0_SecurityLevelId", "ϵͳ�Զ�����"
        SetValueByHead "ProductList", CurRow, "Ʒ������", "������"
        SetValueByHead "ProductList", CurRow, "Ʒ��", "������"
        SetValueByHead "ProductList", CurRow, "��Ӧ�̿��", "������"
        SetValueByHead "ProductList", CurRow, "��Ӧ����ɫ", "������"
        SetValueByHead "ProductList", CurRow, "��Ӧ�̳���", "������"
        SetValueByHead "ProductList", CurRow, "��Ӧ�̱��", PSno
        SetValueByHead "ProductList", CurRow, "������", CJR
        SetValueByHead "ProductList", CurRow, "��ƷID", Guid
        SetFormat_ProductList_Line CurRow, CurRow
        'SetFormat_CommandButton_All
        CurRow = Selection.Row
        ScreenUpdate True
'        PSno = Sheets("��Ʒ��Ϣ").Range("D11").Value
'        SetValueByHead "ProductList", CurRow, "��Ӧ�̱��", PSno
'        SetValidationStr Range("ProductList[[��Ӧ�̱��]]"), "=����!$CD$7:$AW$" & GetRowId("SupplyBASEList", "MAX")
'        SetValidationStr Range("ProductList[[Ʒ������]]"), GetAddressByHead2("BrandBASEList", "SU0_SupplierCode", PSno, "Ʒ������")
        SetValueByHead "ProductList", CurRow, "�ɹ���", "0"
        SetValueByHead "ProductList", CurRow, "���Ƽ�", "0"
        
N:
    'ProtectSheetWithEnableAllowFiltering "��Ʒ��Ϣ", True
End Sub
Sub ��Ʒ��Ϣ_return()

    ScreenUpdate False
'    If Not CheckIsLogin() Then GoTo N

    ProtectSheet "��Ʒ��Ϣ", False
    Sheets("��Ʒ��Ϣ").Range("C4").Clear
    Sheets("��Ʒ��Ϣ").Range("E4").Clear
    ClearTable "LXRList"

    'HideSheet "��Ӧ��", False
    'HideSheet "��Ʒ��Ϣ",true

    Sheets("��Ӧ��").Activate
    Sheets("��Ӧ��").Range("C7").Select
    'SetFormat_CommandButton_All
N:
    ScreenUpdate True
End Sub


Sub ��Ʒ��Ϣ_load()
     ScreenUpdate False                  'ֹͣ����
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "��Ʒ��Ϣ", False
        SetValueByName "��Ʒ��Ϣ_Change", "1"
        ClearTable "ProductList"
        ClearPic "��Ʒ��Ϣ", "ProductList*"
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

        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("ProductLoadList")))
         
        CreateTableForXML "ProductList", XMLStr, "ROOT", "��Ʒ��Ϣ", "A5"
        If GetRowId("ProductList", "MAX") <> GetRowId("ProductList", "MIN") Then _
        DeleteRows "��Ʒ��Ϣ", GetRowId("ProductList", "MIN") & ":" & GetRowId("ProductList", "MIN")

        SetFormat_ProductLoadList_All
        'SetFormat_CommandButton_All
        
        ProtectSheetWithEnableAllowFiltering "��Ʒ��Ϣ", True
        Sheets("��Ʒ��Ϣ").Activate
        Sheets("��Ʒ��Ϣ").Range("B10").Select
        SetValueByName "��Ʒ��Ϣ_Change", "0"
'    End If
    ScreenUpdate True
End Sub
Sub ��Ʒ��Ϣ_Cancelline()
    'ɾ���½���
    Dim CurRow As Long
    ScreenUpdate False

    If CheckSelectionInTable("ProductList", True) = False Then
        GoTo N
    End If

    CurRow = Selection.Row

    If GetValueByHead("ProductList", CurRow, "����") = "" And GetValueByHead("ProductList", CurRow, "��ƷID") <> "ϵͳ�Զ�����" _
    Then
        MsgBox "��ѡ���¼��", vbCritical, "��ʾ"
        GoTo N
    End If
    
    DeleteRows "��Ʒ��Ϣ", CurRow & ":" & CurRow
    'SetFormat_CommandButton_All
    Range("C7").Select
N:
    ScreenUpdate True
End Sub

Sub ��Ʒ��Ϣ_save()
    '�����½�
    ScreenUpdate False
    'If Not CheckIsLogin() Then GoTo N
    ProtectSheet "��Ʒ��Ϣ", False
    
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
    Dim PM As String, KH As String, YS As String, CM As String, YS2 As String, SKU As String, SP As String
    Dim selectItemPD0_SUO_SupplierId As String, selectItemPD0_BrandId As String, selectItemPD0_YearId As String, selectItemPD0_SeasonId As String, selectItemPD0_Lvl1 As String, selectItemPD0_Lvl2 As String
    Dim dictIdPD0_SUO_SupplierId As String, dictIdPD0_BrandId As String, dictIdPD0_YearId As String, dictIdPD0_SeasonId As String, dictIdPD0_Lvl1 As String, dictIdPD0_Lvl2 As String
    
    Dim selectItemPD0_ColorSUId As String, selectItemPD0_SizeSUId As String, selectItemPD0_ColorId As String, selectItemPD0_SizeId As String
    Dim dictIdPD0_ColorSUId As String, dictIdPD0_SizeSUId As String, dictIdPD0_ColorId As String, dictIdPD0_SizeId As String, SKU2 As String
    CurRow = Selection.Row
'        -----------by sunyulong 20130730 begin   -----------
    If GetValueByHead("ProductList", CurRow, "Ʒ������") = "������" _
    Then
        MsgBox "Ʒ�����Ʋ���Ϊ�գ�", vbCritical, "��ʾ"
        GoTo N
    End If
    If GetValueByHead("ProductList", CurRow, "Ʒ��") = "������" _
    Then
        MsgBox "Ʒ������Ϊ�գ�", vbCritical, "��ʾ"
        GoTo N
    End If
    If GetValueByHead("ProductList", CurRow, "��Ӧ�̿��") = "������" _
    Then
        MsgBox "��Ӧ�̿�Ų���Ϊ�գ�", vbCritical, "��ʾ"
        GoTo N
    End If
    If GetValueByHead("ProductList", CurRow, "��Ӧ����ɫ") = "������" _
    Then
        MsgBox "��Ӧ����ɫ����Ϊ�գ�", vbCritical, "��ʾ"
        GoTo N
    End If
        If GetValueByHead("ProductList", CurRow, "��Ӧ�̳���") = "������" _
    Then
        MsgBox "��Ӧ�̳��벻��Ϊ�գ�", vbCritical, "��ʾ"
        GoTo N
    End If
'        -----------by sunyulong 20130730 end   -----------
     '���ù�Ӧ�̱�ŵ�������ȡֵ
    selectItemPD0_SUO_SupplierId = GetValueByHead("ProductList", CurRow, "��Ӧ�̱��")
    dictIdPD0_SUO_SupplierId = getMBQTGUID("SupplyBASEList", "��Ӧ�̱��", selectItemPD0_SUO_SupplierId, "SU0_SupplierId")
    SetValueByHead "ProductList", CurRow, "PD0_SUO_SupplierId", dictIdPD0_SUO_SupplierId


     '����Ʒ�Ƶ�������ȡֵ
     selectItemPD0_BrandId = GetValueByHead("ProductList", CurRow, "Ʒ������")
     dictIdPD0_BrandId = getMBQTGUID("BrandBASEList", "Ʒ������", selectItemPD0_BrandId, "BD0_BrandId")
     SetValueByHead "ProductList", CurRow, "PD0_BD0_BrandId", dictIdPD0_BrandId


    '������ݵ�������ȡֵ
     selectItemPD0_YearId = GetValueByHead("ProductList", CurRow, "���")
     dictIdPD0_YearId = getMBQTGUID("YearBaseList", "DC0_DictName1", selectItemPD0_YearId, "DC0_DictId")
     SetValueByHead "ProductList", CurRow, "PD0_YearId", dictIdPD0_YearId

    '������ɫ��������ȡֵ
    selectItemPD0_ColorId = GetValueByHead("ProductList", CurRow, "��ɫ")
    dictIdPD0_ColorId = getMBQTGUID("ColorBaseList", "DC0_DictName1", selectItemPD0_ColorId, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_ColorId", dictIdPD0_ColorId

    '���ó����������ȡֵ
    selectItemPD0_SizeId = GetValueByHead("ProductList", CurRow, "����")
    dictIdPD0_SizeId = getMBQTGUID("SizeBaseList", "DC0_DictName1", selectItemPD0_SizeId, "DC0_DictId")
    SetValueByHead "ProductList", CurRow, "PD0_SizeId", dictIdPD0_SizeId
    
    '�趨Ҫ�ϴ�����
    If Not CheckSelectionInTable("ProductList", True) Then
        MsgBox "���ڵ�ǰ�����ѡ��һ�У�      ", vbCritical, "��ʾ"
        GoTo N
    End If

    CurRow = Selection.Row
    SKU2 = GetValueByHead("ProductList", CurRow, "��Ӧ�̿��") & "-" & GetValueByHead("ProductList", CurRow, "��Ӧ����ɫ") & "-" & GetValueByHead("ProductList", CurRow, "��Ӧ�̳���")
    SetValueByHead "ProductList", CurRow, "��Ӧ��SKU", SKU2
'    MsgBox SKU2
    If GetValueByHead("ProductList", CurRow, "����") = "I" Then
    '�����½���Ʒ��Ϣ��Ϣ
        If MsgBox("��ȷ��Ҫ�����桿" & "��Ʒ��Ϣ���ƣ� " & GetValueByHead("ProductList", CurRow, "��Ӧ�̿��") & "��������    ", vbYesNo, "��ʾ") = vbYes Then

            ColumnList = "��PD0_CONO����PD0_DIVI����PD0_SUO_SupplierId������ƷID����PD0_BD0_BrandId������Ӧ�̿�š�����Ӧ����ɫ������Ӧ�̳��롿 " & _
                         "����Ӧ��SKU������š���PD0_ColorId����PD0_SizeId����SKU����PD0_YearId��" & _
                         "�����ڡ�����ʽ���ࡿ����ʽ���ࡿ����ʽС�ࡿ�����ء����ɷ֡�����ͼ����Ʒ����" & _
                         "���ȼ�����PD0_StandardId����PD0_SecurityLevelId�����ɹ��ۡ������Ƽۡ�����λ����״̬�����Ƿ��ӡ���������ˡ�������޸��ˡ�"

            XMLStr = GetXMLByTableColumn("ProductList", ColumnList, "����", "I", "=")

            XMLStr = "<Interface WSID=""2b798196-4e64-4ecf-ab73-4ed6598e87cd""" & _
                     " App=""" & GetAppName & """ SessionID="""">" & _
                     " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                     "</ROOT></xml></Interface>"
                '�����ϴ�xml��ʽ,ע��WSID��OPTYPE����
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                XMLStr = Replace(XMLStr, "'", "\u0027")
                XMLStr = GetWsrrRlt(XMLStr)

                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "����ɹ���      ", vbInformation, "��ʾ"
                    SetValueByHead "ProductList", CurRow, "����", "F"
                    ProtectSheet "��ϸ����", False
                    CurRow = Selection.Row
                    PM = GetValueByHead("ProductList", CurRow, "Ʒ������")
                    KH = GetValueByHead("ProductList", CurRow, "��Ӧ�̿��")
                    YS = GetValueByHead("ProductList", CurRow, "��Ӧ����ɫ")
                    YS2 = GetValueByHead("ProductList", CurRow, "��Ӧ����ɫ����")
                    CM = GetValueByHead("ProductList", CurRow, "��Ӧ�̳���")
                    SKU = GetValueByHead("ProductList", CurRow, "��Ӧ��SKU")
                    SP = GetValueByHead("ProductList", CurRow, "��ƷID")
                    SetValueByHead "��118", CurRow, "Ʒ������", PM
                    Sheets("��ϸ����").Activate
                    InsertLine "��ϸ����", 1, True
                    CurRow = Selection.Row
                    SetValueByHead "��118", CurRow, "Ʒ������", PM
                    SetValueByHead "��118", CurRow, "��Ӧ�̿��", KH
                    SetValueByHead "��118", CurRow, "��Ӧ����ɫ", YS
                    SetValueByHead "��118", CurRow, "��Ӧ����ɫ����", YS2
                    SetValueByHead "��118", CurRow, "��Ӧ�̳���", CM
                    SetValueByHead "��118", CurRow, "��Ӧ��SKU", SKU
                    SetValueByHead "��118", CurRow, "��ƷID", SP
                    Sheets("��Ʒ��Ϣ").Activate
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                End If

        End If
    End If
    
    If GetValueByHead("ProductList", CurRow, "����") = "U" Then
    '������Ʒ��Ϣ�޸���Ϣ
        If MsgBox("��ȷ��Ҫ���޸ġ�" & "��Ʒ��Ϣ���ƣ� " & GetValueByHead("ProductList", CurRow, "��Ӧ�̿��") & "����Ʒ��Ϣ��Ϣ��    ", vbYesNo, "��ʾ") = vbYes Then
    
           
            ColumnList = "��PD0_CONO����PD0_DIVI����PD0_SUO_SupplierId������ƷID����PD0_BD0_BrandId������Ӧ�̿�š�����Ӧ����ɫ������Ӧ�̳��롿 " & _
                         "����Ӧ��SKU������š���PD0_ColorId����PD0_SizeId����SKU����PD0_YearId��" & _
                         "�����ڡ�����ʽ���ࡿ����ʽ���ࡿ����ʽС�ࡿ�����ء����ɷ֡�����ͼ����Ʒ����" & _
                         "���ȼ�����PD0_StandardId����PD0_SecurityLevelId�����ɹ��ۡ������Ƽۡ�����λ����״̬�����Ƿ��ӡ���������ˡ�������޸��ˡ�"
                         
            XMLStr = GetXMLByTableColumn("ProductList", ColumnList, "����", "U", "=")
        
    
            '�Ƿ�����ϴ�xml��ʽ��
                 XMLStr = "<Interface WSID=""2b798196-4e64-4ecf-ab73-4ed6598e87cd""" & _
                     " App=""" & GetAppName & """ SessionID="""">" & _
                     " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                     "</ROOT></xml></Interface>"
                '�����ϴ�xml��ʽ,ע��WSID��OPTYPE����
                Msg "FORM", vbCritical, "", "", XMLStr
    '            Exit Sub
         
                XMLStr = GetWsrrRlt(XMLStr)
                
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "����ɹ���      ", vbInformation, "��ʾ"
                    'Msg "FORM", vbCritical, "", "", GetValueFromXml(XMLStr, "MSG")
                    SetValueByHead "ProductList", CurRow, "����", "F"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                End If
        End If
    End If
    'SetFormat_CommandButton_All
    ProtectSheetWithEnableAllowFiltering "��Ʒ��Ϣ", True
        
N:
    ScreenUpdate True

End Sub

Sub ��Ʒ��Ϣ_�鿴()
    '�鿴��Ʒ��Ϣ
    ScreenUpdate False
    
'    If Not CheckIsLogin() Then GoTo N
        If Not CheckSelectionInTable("ProductList", True) Then
        MsgBox "���ڵ�ǰ�����ѡ��һ�У�      ", vbCritical, "��ʾ"
        GoTo N
    End If
    
    Dim CurRow As Long
    Dim BH As String                '����һ���������ڴ����Ʒ��Ϣ���
    Dim JC As String                '����һ���������ڴ����Ʒ��Ϣ���
    
    
    ProtectSheet "��Ʒ��Ϣ", False
    CurRow = Selection.Row
    BH = GetValueByHead("ProductList", CurRow, "��Ʒ��Ϣ���")
    JC = GetValueByHead("ProductList", CurRow, "��Ʒ��Ϣ���")
    
    SetCellValueByRange "��Ʒ��Ϣ", "A4", "����Ʒ��Ϣ��ƣ�"
    SetCellValueByRange "��Ʒ��Ϣ", "C4", JC
    SetCellValueByRange "��Ʒ��Ϣ", "D4", "����Ʒ��Ϣ��ţ�"
    SetCellValueByRange "��Ʒ��Ϣ", "E4", BH
    
    ��Ʒ��Ϣ_load
    HideSheet "��Ʒ��Ϣ", False
    HideSheet "��Ʒ��Ϣ", True
    Sheets("��Ʒ��Ϣ").Activate
    Sheets("��Ʒ��Ϣ").Range("A5").Select
    ProtectSheet "��Ʒ��Ϣ", True

N:
    ScreenUpdate True
End Sub







