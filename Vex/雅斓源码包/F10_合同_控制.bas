Attribute VB_Name = "F10_��ͬ_����"
Sub ��ͬ_load()
    Dim XMLStr As String
    ScreenUpdate False                  'ֹͣ����
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "��ͬ", False
        SetValueByName "Contract_Change", "1"
        SetValueByName "Contract_SelectionChange", "1"
        ClearTable "ContractList"
        ClearTable "ContractNewList"
        ClearTable "��74"
'        Sheets("��ͬ").CommandButton5.Enabled = True        '������˰�ť
'        Sheets("��ͬ").CommandButton6.Enabled = True        '�����鿴�ɹ�����ť
'        Sheets("��ͬ").CommandButton7.Enabled = True        '���������ɹ�����ť
'        Sheets("��ͬ").CommandButton8.Enabled = True        '�����ϴ�ɨ�����ť
        XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST></LIST>" & _
        "</ROOT></xml></Interface>"

        
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        XMLStr = GetWsrrRlt(XMLStr)
        '��XML��ʽת��Ϊ�����б����Ҫ���XML��ʽ
        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("ContractList")))
        
        CreateTableForXML "ContractList", XMLStr, "ROOT", "��ͬ", "A9"
        If GetRowId("ContractList", "MAX") <> GetRowId("ContractList", "MIN") Then _
        DeleteRows "��ͬ", GetRowId("ContractList", "MIN") & ":" & GetRowId("ContractList", "MIN")

        SetFormat_ContractList_All
        'SetFormat_CommandButton_All
        
        'ProtectSheetWithEnableAllowFiltering "��ͬ", True
        Sheets("��ͬ").Activate
        Sheets("��ͬ").Range("D10").Select
'    End If
    SetValueByName "Contract_Change", "0"
    SetValueByName "Contract_SelectionChange", "0"
    ScreenUpdate True
End Sub
Sub ��ͬ_CreateSplit()
    '��ͬ�½�����
    ProtectSheet "��ͬ", False

'    If CheckIsLogin() = False Then GoTo N:

        Dim CurRow As Long
        Dim PSno As String

    If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        ScreenUpdate False
        InsertLine "��ͬ", 8, True
        CurRow = Selection.Row

        SetValueByHead "ContractList", CurRow, "����", "I"
        SetValueByHead "ContractList", CurRow, "��ͬ���", "ϵͳ�Զ�����"
        PSno = Sheets("��ͬ").Range("E11").Value
        SetValueByHead "ContractList", CurRow, "��Ӧ�̱��", PSno

        SetFormat_ContractList_Line CurRow, CurRow
        'SetFormat_CommandButton_All
        CurRow = Selection.Row
        ScreenUpdate True
N:
    'ProtectSheetWithEnableAllowFiltering "��ͬ", True
End Sub


'-----------by liuhong 20130730 begin-----------
Sub ��ͬ_Cancelline()
    'ɾ���½���
    Dim CurRow As Long
    ScreenUpdate False
    If CheckSelectionInTable("ContractNewList", True) = False Then GoTo N
    CurRow = Selection.Row
    If GetValueByHead("ContractNewList", CurRow, "����") = "" And GetValueByHead("ContractNewList", CurRow, "��ͬ���") <> "ϵͳ����" Then
        MsgBox "��ѡ���¼��", vbCritical, "��ʾ"
        GoTo N
    End If
    
    DeleteRows "��ͬ", CurRow & ":" & CurRow
    Range("C10").Select
N:
    ScreenUpdate True
End Sub
Sub Contract_New()
    Dim XMLStr As String
    Dim wrksht As Worksheet
    Dim CurRow As Long
    
    ScreenUpdate False
    ProtectSheet "��ͬ", False
    ��Ӧ�̻���_load
'    Sheets("��ͬ").CommandButton5.Enabled = False       '�ر���˰�ť
'    Sheets("��ͬ").CommandButton6.Enabled = False
'    Sheets("��ͬ").CommandButton7.Enabled = False
'    Sheets("��ͬ").CommandButton8.Enabled = False
    Set wrksht = ActiveWorkbook.Worksheets("��ͬ")
    SetValueByName "Contract_Change", "1"
    SetValueByName "Contract_SelectionChange", "1"
    If TableIsExists("��ͬ") = True Then  '�����ͬ���д���Table
        If wrksht.ListObjects(1).Name = "ContractList" Then '���TableName��"ContractList"
            ClearTable "ContractList"                    '���"ContractList"
            
            XMLStr = "<ROOT><LIST><Rows><PR0_CONO></PR0_CONO><PR0_DIVI></PR0_DIVI><PR0_ContractCode></PR0_ContractCode><PR0_ContractId></PR0_ContractId>" & _
            "<PR0_SU0_SupplierId></PR0_SU0_SupplierId><SU0_SupplierCode></SU0_SupplierCode><PR0_Amount></PR0_Amount><PR0_CurrencyId></PR0_CurrencyId><PR0_SettleAccount></PR0_SettleAccount>" & _
            "<AccountDictName></AccountDictName><PR0_PrePayRate></PR0_PrePayRate><CurrencyDictName></CurrencyDictName>" & _
            "<PR0_Description></PR0_Description><PR0_Status></PR0_Status><StatusDictName></StatusDictName><PR0_ECopyPath></PR0_ECopyPath><PR0_StartDate></PR0_StartDate>" & _
            "<PR0_EndDate></PR0_EndDate><PR0_RgUser></PR0_RgUser><PR0_LmUser></PR0_LmUser></Rows></LIST></ROOT>"
            
            XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("")))
            CreateTableForXML "ContractNewList", XMLStr, "ROOT", "��ͬ", "A9"
            If GetRowId("ContractNewList", "MAX") <> GetRowId("ContractNewList", "MIN") Then _
            DeleteRows "��ͬ", GetRowId("ContractNewList", "MIN") & ":" & GetRowId("ContractNewList", "MIN")
            SetFormat_ContractNewList_All
            CurRow = Selection.Row + 1
            SetValueByHead "ContractNewList", CurRow, "����", "I"
            SetValueByHead "ContractNewList", CurRow, "����", "100"
            SetValueByHead "ContractNewList", CurRow, "��ҵ��", "200"
'            SetValueByHead "ContractNewList", CurRow, "����ʱ��", Date & Time
            SetValueByHead "ContractNewList", CurRow, "��ͬ���", "ϵͳ����"
            SetValueByHead "ContractNewList", CurRow, "��ͬ���ID", "ϵͳ����"
            SetValueByHead "ContractNewList", CurRow, "��ͬ���", "0"
            SetValueByHead "ContractNewList", CurRow, "״̬ID", "40862D71-AAB5-4894-8680-56573725DB2E"
            SetValueByHead "ContractNewList", CurRow, "��ͬ״̬", "δ���"
            SetValueByHead "ContractNewList", CurRow, "��ͬ��ʼʱ��", Format(Date, "yyyymmdd")
            SetValueByHead "ContractNewList", CurRow, "������", "qianc"
            SetValueByHead "ContractNewList", CurRow, "����޸���", "qianc"
            SetValidationStr Range("ContractNewList[[�������]]"), "=����!$FT$7:$FT$" & GetRowId("CurrencyBaseList", "MAX")
            SetValidationStr Range("ContractNewList[[���㷽ʽ]]"), "=����!$GI$7:$GI$" & GetRowId("AccountTypeBaseList", "MAX")
'            HideTableColumns "ContractNewList", "��PR0_DIVI����PR0_CONO����PR0_ContractId����PR0_SU0_SupplierId��" & _
'            "��PR0_CurrencyId����CurrencyDictName����PR0_Status��", True
'            Range("ContractNewList[#All]").Columns.EntireColumn.AutoFit
        Else
            If wrksht.ListObjects(1).Name = "ContractNewList" Then
                If CheckSelectionInTable("ContractNewList", True) = False Then GoTo N
                InsertLine "��ͬ", 9, True
                CurRow = Selection.Row
                SetValueByHead "ContractNewList", CurRow, "����", "I"
                SetValueByHead "ContractNewList", CurRow, "����", "100"
                SetValueByHead "ContractNewList", CurRow, "��ҵ��", "200"
                SetValueByHead "ContractNewList", CurRow, "��ͬ���", "ϵͳ����"
                SetValueByHead "ContractNewList", CurRow, "��ͬ���ID", "ϵͳ����"
                SetValueByHead "ContractNewList", CurRow, "��ͬ���", "0"
'                SetValueByHead "ContractNewList", CurRow, "����ʱ��", Date & Time
                SetValueByHead "ContractNewList", CurRow, "״̬ID", "40862D71-AAB5-4894-8680-56573725DB2E"
                SetValueByHead "ContractNewList", CurRow, "��ͬ״̬", "δ���"
                SetValueByHead "ContractNewList", CurRow, "��ͬ��ʼʱ��", Format(Date, "yyyymmdd")
                SetValueByHead "ContractNewList", CurRow, "������", "qianc"
                SetValueByHead "ContractNewList", CurRow, "����޸���", "qianc"
                Range("ContractNewList[#All]").Columns.EntireColumn.AutoFit
                '���ÿɱ༭����
                AddEditRangeByHead "ContractNewList", 0, GetEditColumnsName("ContractNewList")
                SetValidationStr Range("ContractNewList[[�������]]"), "=����!$FT$7:$FT$" & GetRowId("CurrencyBaseList", "MAX")
                SetValidationStr Range("ContractNewList[[���㷽ʽ]]"), "=����!$GI$7:$GI$" & GetRowId("AccountTypeBaseList", "MAX")
            End If
        End If
    Else
        If TableIsExists("��ͬ") = False Then  '�����ͬ���в�����Table
            XMLStr = "<ROOT><LIST><Rows><PR0_CONO></PR0_CONO><PR0_DIVI></PR0_DIVI><PR0_ContractCode></PR0_ContractCode><PR0_ContractId></PR0_ContractId>" & _
            "<PR0_SU0_SupplierId></PR0_SU0_SupplierId><SU0_SupplierCode></SU0_SupplierCode><PR0_CurrencyId></PR0_CurrencyId><PR0_Amount></PR0_Amount><PR0_SettleAccount></PR0_SettleAccount>" & _
            "<AccountDictName></AccountDictName><PR0_PrePayRate></PR0_PrePayRate><CurrencyDictName></CurrencyDictName>" & _
            "<PR0_Description></PR0_Description><PR0_Status></PR0_Status><StatusDictName></StatusDictName><PR0_ECopyPath></PR0_ECopyPath><PR0_StartDate></PR0_StartDate>" & _
            "<PR0_EndDate></PR0_EndDate><PR0_RgUser></PR0_RgUser><PR0_LmUser></PR0_LmUser></Rows></LIST></ROOT>"
            
            XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("")))
            CreateTableForXML "ContractNewList", XMLStr, "ROOT", "��ͬ", "A9"
            If GetRowId("ContractNewList", "MAX") <> GetRowId("ContractNewList", "MIN") Then _
            DeleteRows "��ͬ", GetRowId("ContractNewList", "MIN") & ":" & GetRowId("ContractNewList", "MIN")
            SetFormat_ContractNewList_All
            CurRow = Selection.Row
            SetValueByHead "ContractNewList", CurRow, "����", "I"
            SetValueByHead "ContractNewList", CurRow, "����", "100"
            SetValueByHead "ContractNewList", CurRow, "��ҵ��", "200"
            SetValueByHead "ContractNewList", CurRow, "��ͬ���", "ϵͳ����"
            SetValueByHead "ContractNewList", CurRow, "��ͬ���ID", "ϵͳ����"
            SetValueByHead "ContractNewList", CurRow, "״̬ID", "40862D71-AAB5-4894-8680-56573725DB2E"
            SetValueByHead "ContractNewList", CurRow, "��ͬ״̬", "δ���"
            SetValueByHead "ContractNewList", CurRow, "��ͬ���", "0"
            SetValueByHead "ContractNewList", CurRow, "��ͬ��ʼʱ��", Format(Date, "yyyymmdd")
            SetValueByHead "ContractNewList", CurRow, "������", "qianc"
            SetValueByHead "ContractNewList", CurRow, "����޸���", "qianc"
            
            SetValidationStr Range("ContractNewList[[�������]]"), "=����!$FT$7:$FT$" & GetRowId("CurrencyBaseList", "MAX")
            SetValidationStr Range("ContractNewList[[���㷽ʽ]]"), "=����!$GI$7:$GI$" & GetRowId("AccountTypeBaseList", "MAX")
'            Range("ContractNewList[#All]").Columns.EntireColumn.AutoFit
'            HideTableColumns "ContractNewList", "��PR0_DIVI����PR0_CONO����PR0_ContractId����PR0_SU0_SupplierId��" & _
'            "��PR0_CurrencyId����CurrencyDictName����PR0_Status��", False
        End If
    End If
N:
    ProtectSheet "��ͬ", False
    ScreenUpdate False
End Sub
'-----------by liuhong 20130730 end   -----------
Sub Contract_Save()
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "��ͬ", False
    
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
    Dim XMLStr1 As String '����һ��������������xml
    Dim selectItemPR0_SU0_SupplierId As String, selectItemPR0_CurrencyId As String
    Dim dictIdPR0_SU0_SupplierId As String, dictIdPR0_CurrencyId As String
    Dim wrksht As Worksheet
    SetValueByName "Contract_Change", "1"
    Set wrksht = ActiveWorkbook.Worksheets("��ͬ")
    
    If TableIsExists("��ͬ") = True Then  '�����ͬ���д���Table
        If wrksht.ListObjects(1).Name = "ContractNewList" Then '���TableName��"ContractNewList"
            CurRow = Selection.Row
            '���ù�Ӧ�̱��������ȡֵ
            selectItemPR0_SU0_SupplierId = GetValueByHead("ContractNewList", CurRow, "��Ӧ�̱��")
            dictIdPR0_SU0_SupplierId = getMBQTGUID("SupplyBASEList", "��Ӧ�̱��", selectItemPR0_SU0_SupplierId, "SU0_SupplierId")
            SetValueByHead "ContractNewList", CurRow, "��Ӧ��ID", dictIdPR0_SU0_SupplierId
            '���òɹ�����������ȡֵ
            selectItemPR0_SU0_SupplierId = GetValueByHead("ContractNewList", CurRow, "�������")
            dictIdPR0_SU0_SupplierId = getMBQTGUID("CurrencyBaseList", "DC0_DictName1", selectItemPR0_SU0_SupplierId, "DC0_DictId")
            SetValueByHead "ContractNewList", CurRow, "�������ID", dictIdPR0_SU0_SupplierId
            '���òɹ����㷽ʽ������ȡֵ
            selectItemPR0_SU0_SupplierId = GetValueByHead("ContractNewList", CurRow, "���㷽ʽ")
            dictIdPR0_SU0_SupplierId = getMBQTGUID("AccountTypeBaseList", "DC0_DictName1", selectItemPR0_SU0_SupplierId, "DC0_DictId")
            SetValueByHead "ContractNewList", CurRow, "���㷽ʽID", dictIdPR0_SU0_SupplierId
            'ѡ����Ҫ�ϴ�����
            If Not CheckSelectionInTable("ContractNewList", True) Then GoTo N
            If GetValueByHead("ContractNewList", CurRow, "����") = "I" Then
'                If GetValueByHead("ContractNewList", CurRow, "�ɹ������") = Empty Then
'                    MsgBox "��Ǹ������д�ɹ�����š�"
'                    GoTo N
'                End If
                If MsgBox("��ȷ��Ҫ�����桿" & "��ͬ���ƣ� " & GetValueByHead("ContractNewList", CurRow, "��Ӧ�̱��") & "�ĺ�ͬ��    ", vbYesNo, "��ʾ") = vbYes Then
                    ColumnList = "�����š�����ҵ�塿����ͬ���ID������Ӧ��ID�����������ID�������㷽ʽID������ͬ˵������״̬ID�� " & _
                                "����ͬɨ���������ͬ��ʼʱ�䡿����ͬ��ֹʱ�䡿�������ˡ�������޸��ˡ���Ԥ����ٷֱȡ�"
                    XMLStr = GetXMLByTableColumn("ContractNewList", ColumnList, "����", "I", "=")
                    XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
'                    Msg "FORM", vbCritical, "", "", XMLStr
'                    Exit Sub
                    XMLStr = GetWsrrRlt(XMLStr)

                    If GetValueFromXml(XMLStr, "Result") = "true" Then
                        
                        MsgBox "����ɹ���      ", vbInformation, "��ʾ"
                        SetValueByHead "ContractNewList", CurRow, "����", "F"
                    Else
                        MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                    End If
                End If
            End If
        Else
             If wrksht.ListObjects(1).Name = "ContractList" Then '���TableName��"ContractList"
                CurRow = Selection.Row
                If GetValueByHead("ContractList", CurRow, "��ͬ״̬") = "δ���" Then
                    If GetValueByHead("ContractList", CurRow, "����") = "U" Then
                        '���ý�����ֵ�������ȡֵ
                        selectItemPR0_CurrencyId = GetValueByHead("ContractList", CurRow, "�������")
                        dictIdPR0_CurrencyId = getMBQTGUID("CurrencyBaseList", "DC0_DictName1", selectItemPR0_CurrencyId, "DC0_DictId")
                        SetValueByHead "ContractList", CurRow, "�������ID", dictIdPR0_CurrencyId
                        '���òɹ����㷽ʽ������ȡֵ
                        selectItemPR0_SU0_SupplierId = GetValueByHead("ContractList", CurRow, "���㷽ʽ")
                        dictIdPR0_SU0_SupplierId = getMBQTGUID("AccountTypeBaseList", "DC0_DictName1", selectItemPR0_SU0_SupplierId, "DC0_DictId")
                        SetValueByHead "ContractList", CurRow, "���㷽ʽID", dictIdPR0_SU0_SupplierId
                        
                        If MsgBox("��ȷ��Ҫ���޸ġ�" & "��ͬ��ţ� " & GetValueByHead("ContractList", CurRow, "��ͬ���") & "����Ϣ��    ", vbYesNo, "��ʾ") = vbYes Then
                            ColumnList = " �����š�����ҵ�塿����ͬID������Ӧ�̱��ID�����������ID�������㷽ʽID������ͬ˵������״̬ID��" & _
                            "����ͬɨ���������ͬ��ʼʱ�䡿����ͬ��ֹʱ�䡿�������ˡ�������޸��ˡ���Ԥ����ٷֱȡ�"""
                            XMLStr = GetXMLByTableColumn("ContractList", ColumnList, "����", "U", "=")
                        
                            XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
                            " App=""" & GetAppName & """ SessionID="""">" & _
                            " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                            "</ROOT></xml></Interface>"
'                            Msg "FORM", vbCritical, "", "", XMLStr
'                            Exit Sub
                            XMLStr = GetWsrrRlt(XMLStr)
    '                         Msg "FORM", vbCritical, "", "", XMLStr
    '                        Exit Sub
                            If GetValueFromXml(XMLStr, "Result") = "true" Then
                                MsgBox "����ɹ���      ", vbInformation, "��ʾ"
                                SetValueByHead "ContractList", CurRow, "����", "F"
                            Else
                                MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                            End If
                        End If
                    End If
                End If
             End If
        End If
    Else: MsgBox "����ػ���������ͬ��лл��      "
    End If
N:
    SetValueByName "Contract_Change", "0"
    ProtectSheetWithEnableAllowFiltering "��ͬ", False
    ScreenUpdate True
End Sub
Sub ContractToPurchaseOrder()
    Dim CurRow As Long
    Dim XMLStr As String
    Dim ContractId As String
    Dim ContractIdGUID As String '��ͬ��ŵ�GUID
    Dim SupplyId As String      '��Ӧ�̱��
    Dim SupplyIdGUID As String  '��Ӧ�̱�ŵ�GUID
    Dim SupplyType As String    '��Ӧ������
    Dim CurrencyDictN As String '�������
    Dim CurrencyDictId As String    '�������Id
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "��ͬ", False
    ProtectSheetWithEnableAllowFiltering "�ɹ���", False
    ClearTable "PurchaseOrderList"
    ClearTable "NewPurchaseOrderList"
    
    If TableIsExists("��ͬ") = True Then
        If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        CurRow = Selection.Row
        
        ContractIdGUID = GetValueByHead("ContractList", CurRow, "��ͬID")     'ȡ��ͬ���GUID
        ContractId = GetValueByHead("ContractList", CurRow, "��ͬ���")
        SupplyIdGUID = GetValueByHead("ContractList", CurRow, "��Ӧ�̱��ID")       'ȡ��Ӧ�̱��GUID
        SupplyId = GetValueByHead("ContractList", CurRow, "��Ӧ�̱��")
        SupplyType = getMBQTGUID("SupplyBASEList", "��Ӧ�̱��", GetValueByHead("ContractList", CurRow, "��Ӧ�̱��"), "DC0_DictName1")   'ȡ��Ӧ������
        CurrencyDictN = GetValueByHead("ContractList", CurRow, "�������")              'ȡ��ͬ�Ľ������
        CurrencyDictId = GetValueByHead("ContractList", CurRow, "PR0_CurrencyId")    'ȡ�������ID
        If GetValueByHead("ContractList", CurRow, "��ͬ״̬") = "�����" Then
            
            XMLStr = "<Interface WSID=""e844f940-858e-467a-a167-b96c4488dba9""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition>PR1_PR0_ContractId= '" & ContractId & "'</Condition></Row></LIST>" & _
            "</ROOT></xml></Interface>"
            XMLStr = Replace(XMLStr, "'", "\u0027")  '��SQL��ѯ�����еĶ����滻& ContractId &
            XMLStr = GetWsrrRlt(XMLStr)
'            Msg "FORM", vbCritical, "", "", XMLStr
'            Exit Sub
            
            If GetValueFromXml(XMLStr, "PR1_OrderId") <> Empty Then
                Sheets("�ɹ���").Activate
                
                XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("")))
                CreateTableForXML "PurchaseOrderList", XMLStr, "ROOT", "�ɹ���", "A8"
                If GetRowId("PurchaseOrderList", "MAX") <> GetRowId("PurchaseOrderList", "MIN") Then _
                DeleteRows "�ɹ���", GetRowId("PurchaseOrderList", "MIN") & ":" & GetRowId("PurchaseOrderList", "MIN")
                'SetFormat_LXRList_All
            Else
                If GetValueFromXml(XMLStr, "PR1_OrderId") = Empty Then
                    If MsgBox("�ú�ͬ�� " & GetValueByHead("ContractList", CurRow, "��ͬ���") & "�޲ɹ���,������Ҫ�½���    ", vbYesNo, "��ʾ") = vbYes Then
                        Sheets("�ɹ���").Activate
                        ClearTable "PurchaseOrderList"
                        ClearTable "NewPurchaseOrderList"
                        XMLStr = "<ROOT><LIST><Rows><PR1_CONO></PR1_CONO><PR1_DIVI></PR1_DIVI><PR1_OrderId></PR1_OrderId><PR1_OrderCode></PR1_OrderCode>" & _
                        "<PR1_OrderTypeId></PR1_OrderTypeId><PR1_PR0_ContractId></PR1_PR0_ContractId><PR1_SU0_SupplierId></PR1_SU0_SupplierId><PR1_BD0_BrandId></PR1_BD0_BrandId>" & _
                        "<PR1_PurchaseTotal></PR1_PurchaseTotal><PR1_POriginalAmount></PR1_POriginalAmount><PR1_PurchaseAmount></PR1_PurchaseAmount><PR1_Discount></PR1_Discount>" & _
                        "<PR1_ExchangeRate></PR1_ExchangeRate><PR1_Tariff></PR1_Tariff><PR1_VAT></PR1_VAT><PR1_Freight></PR1_Freight><PR1_Times></PR1_Times><PR1_Status></PR1_Status>" & _
                        "<PR1_RgUser></PR1_RgUser><PR1_RgDt></PR1_RgDt><PR1_LmUser></PR1_LmUser><PR1_LmDt></PR1_LmDt><PR1_UptNo></PR1_UptNo><PR1_CurrencyTypeId></PR1_CurrencyTypeId>" & _
                        "<SU0_SupplierCode></SU0_SupplierCode><BD0_BrandName></BD0_BrandName><PR0_ContractCode></PR0_ContractCode>" & _
                        "<OrderTypeDictName></OrderTypeDictName><StatusDictName></StatusDictName><PR1_SupplierType></PR1_SupplierType><CurrencyTypeDictName></CurrencyTypeDictName></Rows></LIST></ROOT>"
        
                        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("NewPurchaseOrderList")))
                        CreateTableForXML "NewPurchaseOrderList", XMLStr, "ROOT", "�ɹ���", "A8"
                        If GetRowId("NewPurchaseOrderList", "MAX") <> GetRowId("NewPurchaseOrderList", "MIN") Then _
                        DeleteRows "�ɹ���", GetRowId("NewPurchaseOrderList", "MIN") & ":" & GetRowId("NewPurchaseOrderList", "MIN")
            
                        Sheets("�ɹ���").Range("A9").Select
                        CurRow = Selection.Row
                        SetValueByHead "NewPurchaseOrderList", CurRow, "����", "I"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_CONO", "0"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_DIVI", "0"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderId", "0"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderCode", "ϵͳ����"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderTypeId", "9FDCF85F-C3AA-4F0A-8621-7AC8A0AB26FD"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR0_ContractCode", ContractId
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PR0_ContractId", ContractIdGUID
                        SetValueByHead "NewPurchaseOrderList", CurRow, "SU0_SupplierCode", SupplyId
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_SU0_SupplierId", SupplyIdGUID
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_SupplierType", SupplyType
                        SetValidationStr Range("NewPurchaseOrderList[[BD0_BrandName]]"), GetAddressByHead2("BrandBASEList", "SU0_SupplierCode", SupplyId, "Ʒ������")
                        'SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_BD0_BrandId", ""
                        SetValueByHead "NewPurchaseOrderList", CurRow, "CurrencyTypeDictName", CurrencyDictN
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_CurrencyTypeId", CurrencyDictId
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PurchaseTotal", "0"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_Status", "40862D71-AAB5-4894-8680-56573725DB2E"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_RgUser", "LiuH"
                        SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_LmUser", "LiuH"
                        Sheets("�ɹ���").CommandButton10.Enabled = False
                        Sheets("�ɹ���").CommandButton11.Enabled = False
                        SetFormat_NewPurchaseOrderList_All
                    End If
                End If
            End If
            
            
        Else
            MsgBox "�ú�ͬδ��ˣ��޲ɹ�����Ϣ��лл��     "
            GoTo N
        End If
    Else
        MsgBox "���ȼ��غ�ͬ���ݣ�лл��   "
    End If
N:
    ProtectSheetWithEnableAllowFiltering "��ͬ", True
    ProtectSheetWithEnableAllowFiltering "�ɹ���", True
End Sub

Sub ContractToNewPurchaseOrder()
    Dim CurRow As Long
    Dim XMLStr As String
    Dim ContractId As String    '��ͬ���
    Dim ContractIdGUID As String '��ͬ��ŵ�GUID
    Dim SupplyId As String      '��Ӧ�̱��
    Dim SupplyIdGUID As String  '��Ӧ�̱�ŵ�GUID
    Dim SupplyType As String    '��Ӧ������
    Dim CurrencyDictN As String '�������
    Dim CurrencyDictId As String    '�������Id
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "��ͬ", False
    ProtectSheetWithEnableAllowFiltering "�ɹ���", False
    If TableIsExists("��ͬ") = True Then
        If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        CurRow = Selection.Row

        ContractIdGUID = GetValueByHead("ContractList", CurRow, "��ͬID")     'ȡ��ͬ���GUID
        ContractId = GetValueByHead("ContractList", CurRow, "��ͬ���")
        SupplyIdGUID = GetValueByHead("ContractList", CurRow, "��Ӧ�̱��ID")       'ȡ��Ӧ�̱��GUID
        SupplyId = GetValueByHead("ContractList", CurRow, "��Ӧ�̱��")
        SupplyType = getMBQTGUID("SupplyBASEList", "��Ӧ�̱��", GetValueByHead("ContractList", CurRow, "��Ӧ�̱��"), "DC0_DictName1")   'ȡ��Ӧ������
        CurrencyDictN = GetValueByHead("ContractList", CurRow, "�������")              'ȡ��ͬ�Ľ������
        CurrencyDictId = GetValueByHead("ContractList", CurRow, "�������ID")       'ȡ�������ID
        If GetValueByHead("ContractList", CurRow, "��ͬ״̬") = "�����" Or GetValueByHead("ContractList", CurRow, "��ͬ״̬") = "δ���" Then
            Sheets("�ɹ���").Activate
            ClearTable "PurchaseOrderList"
            ClearTable "NewPurchaseOrderList"

            XMLStr = "<ROOT><LIST><Rows><PR1_CONO></PR1_CONO><PR1_DIVI></PR1_DIVI><PR1_OrderId></PR1_OrderId><PR1_OrderCode></PR1_OrderCode><PR1_OrderTypeId></PR1_OrderTypeId>" & _
            "<PR1_PR0_ContractId></PR1_PR0_ContractId><PR1_SU0_SupplierId></PR1_SU0_SupplierId><PR1_BD0_BrandId></PR1_BD0_BrandId><PR1_PurchaseTotal></PR1_PurchaseTotal>" & _
            "<PR1_POriginalAmount></PR1_POriginalAmount><PR1_PurchaseAmount></PR1_PurchaseAmount><PR1_Discount></PR1_Discount><PR1_ExchangeRate></PR1_ExchangeRate>" & _
            "<PR1_Tariff></PR1_Tariff><PR1_VAT></PR1_VAT><PR1_Freight></PR1_Freight><PR1_Times></PR1_Times><PR1_Status></PR1_Status><PR1_RgUser></PR1_RgUser><PR1_RgDt></PR1_RgDt>" & _
            "<PR1_LmUser></PR1_LmUser><PR1_LmDt></PR1_LmDt><PR1_UptNo></PR1_UptNo><PR1_CurrencyTypeId></PR1_CurrencyTypeId><SU0_SupplierCode></SU0_SupplierCode>" & _
            "<BD0_BrandName></BD0_BrandName><PR0_ContractCode></PR0_ContractCode>" & _
            "<OrderTypeDictName></OrderTypeDictName><StatusDictName></StatusDictName><PR1_SupplierType></PR1_SupplierType><CurrencyTypeDictName></CurrencyTypeDictName></Rows></LIST></ROOT>"
        

            XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("NewPurchaseOrderList")))
            CreateTableForXML "NewPurchaseOrderList", XMLStr, "ROOT", "�ɹ���", "A8"
            If GetRowId("NewPurchaseOrderList", "MAX") <> GetRowId("NewPurchaseOrderList", "MIN") Then _
            DeleteRows "�ɹ���", GetRowId("NewPurchaseOrderList", "MIN") & ":" & GetRowId("NewPurchaseOrderList", "MIN")
            Sheets("�ɹ���").Range("A9").Select
            CurRow = Selection.Row
            SetValueByHead "NewPurchaseOrderList", CurRow, "����", "I"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_CONO", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_DIVI", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderId", "0"
            'SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderCode", "ϵͳ����"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_OrderTypeId", "9FDCF85F-C3AA-4F0A-8621-7AC8A0AB26FD"
            SetValueByHead "NewPurchaseOrderList", CurRow, "OrderTypeDictName", "�ɹ���"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR0_ContractCode", ContractId
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PR0_ContractId", ContractIdGUID
            SetValueByHead "NewPurchaseOrderList", CurRow, "SU0_SupplierCode", SupplyId
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_SU0_SupplierId", SupplyIdGUID
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_SupplierType", SupplyType
            'SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_BD0_BrandId", ""
            SetValueByHead "NewPurchaseOrderList", CurRow, "CurrencyTypeDictName", CurrencyDictN
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_CurrencyTypeId", CurrencyDictId
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_PurchaseTotal", "0"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_Status", "40862D71-AAB5-4894-8680-56573725DB2E"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_RgUser", "qianc"
            SetValueByHead "NewPurchaseOrderList", CurRow, "PR1_LmUser", "qianc"
            
            SetValidationStr Range("NewPurchaseOrderList[[BD0_BrandName]]"), GetAddressByHead2("BrandBASEList", "SU0_SupplierCode", SupplyId, "Ʒ������")
            SetFormat_NewPurchaseOrderList_All
'            Sheets("�ɹ���").CommandButton10.Enabled = False
'            Sheets("�ɹ���").CommandButton11.Enabled = False
'            Sheets("�ɹ���").CommandButton14.Enabled = False
'            Sheets("�ɹ���").CommandButton17.Enabled = False
'            Sheets("�ɹ���").CommandButton18.Enabled = False
            
        Else: MsgBox "��Ǹ����ͬ״̬Ϊ��δ��ˡ�������Ϊ�������µĲɹ�����"
        End If
    Else: MsgBox "���ȼ��غ�ͬ���ݣ�лл��   "
    End If
N:
    ProtectSheetWithEnableAllowFiltering "��ͬ", False
End Sub
Sub �½����_load()
    ScreenUpdate False                  'ֹͣ����
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "�������뵥", False
        SetValueByName "�������뵥_Change", "1"
        ClearTable "PayNewList"
        ClearTable "PayList"
        Dim XMLStr As String
        Dim HTID As String
        Dim CurRow As Long
        CurRow = Selection.Row
        
        If GetValueByHead("ContractList", CurRow, "����") = "U" Or GetValueByHead("ContractList", CurRow, "����") = "" Then
            MsgBox "������Ҫ������ǰ�򡰡̡�лл��", vbCritical, "��ʾ"
            GoTo N
        End If
        If GetValueByHead("ContractList", CurRow, "��ͬ״̬") = "δ���" Then
            MsgBox "�ú�ͬ״̬Ϊδ���,�޷����ɸ����", vbCritical, "��ʾ"
            GoTo N
        End If
        '����ѭ����ʼ------by zz 20130901
        Dim RowMIN As String, RowMAX As String, CombGUID As String
        CombGUID = ""
        RowMIN = GetRowId("ContractList", "MIN")
        RowMAX = GetRowId("ContractList", "MAX")
        
        For CurRow = RowMIN To RowMAX
            If GetValueByHead("ContractList", CurRow, "����") = "��" Then
                CombGUID = CombGUID + "/" + GetValueByHead("ContractList", CurRow, "��ͬID")
            End If
        Next CurRow
        '����ѭ����ʼ------by zz 20130901
'        Msg "FORM", vbCritical, "", "", CombGUID
        
        XMLStr = "<Interface WSID=""93ccc11f-19ad-4b9c-a794-ce587314cdbb""" & _
        " App=""" & GetAppName & """ SessionID="""">" & _
        "<InputFormat>AML</InputFormat><OutputContentType>RS</OutputContentType><ConditionStr>����������,GET����ʵ��,B02_Bill.FNP_PayApply��" & _
        "����������,����,��ҵ��,���뵥ID,���뵥���,��ͬGUID,��Ӧ��GUID,���뵥����,����ˮ����,�����ܽ��,����ٷֱ�,Ӧ������,�Ƿ��Ѹ���,������,����ʱ��,����޸���,����޸�ʱ��,�޸Ĵ���,��ͬ���,��Ӧ�̱��,������,�����˻�,����SWIFT�š�" & _
        "����������,��W�����뵥ID,��W����ͬGUID,��W���жϡ�����W�����뵥ID,������W����ͬGUID," & CombGUID & "/������W���ж�,��ͬ�½���</ConditionStr>" & _
        "</Interface>"

'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
         XMLStr = GetWsrrRlt(XMLStr)
'        Msg "FORM", vbCritical, "", "", XMLStr
'        Exit Sub
        '��XML��ʽת��Ϊ�����б����Ҫ���XML��ʽ
        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("PayNewList")))
        
        CreateTableForXML "PayNewList", XMLStr, "ROOT", "�������뵥", "A9"
        If GetRowId("PayNewList", "MAX") <> GetRowId("PayNewList", "MIN") Then _
        DeleteRows "�������뵥", GetRowId("PayNewList", "MIN") & ":" & GetRowId("PayNewList", "MIN")
        Sheets("�������뵥").Activate
        CurRow = Selection.Row
        SetFormat_PayNewList_All
        
        Sheets("�������뵥").Range("D7").Select
        SetValueByName "�������뵥_Change", "0"
N:
    ScreenUpdate True
End Sub
Sub Contract_Check()
    Dim CurRow As Long
    Dim ColumnList As String
    Dim XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "��ͬ", False
    If TableIsExists("��ͬ") = True Then  '�����ͬ���д���Table
    SetValueByName "Contract_Change", "1"
        If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        CurRow = Selection.Row
        
        If GetValueByHead("ContractList", CurRow, "��ͬ״̬") = "δ���" And GetValueByHead("ContractList", CurRow, "����޸���") <> Empty Then
            SetValueByHead "ContractList", CurRow, "״̬ID", "00DD6348-50D9-4E16-B214-CCFE3CD25D41" '���״̬������˴�ֻ������˵�GUID��
            SetValueByHead "ContractList", CurRow, "����", "C"
            
            ColumnList = "����ͬID����״̬ID��������޸��ˡ�"
            XMLStr = GetXMLByTableColumn("ContractList", ColumnList, "����", "C", "=")
            XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
                     " App=""" & GetAppName & """ SessionID="""">" & _
                     " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                     "</ROOT></xml></Interface>"
'            Msg "FORM", vbCritical, "", "", XMLStr
            'Exit Sub
            XMLStr = GetWsrrRlt(XMLStr)
            If GetValueFromXml(XMLStr, "Result") = "true" Then
                SetValueByHead "ContractList", CurRow, "��ͬ״̬", "�����"
                SetValueByHead "ContractList", CurRow, "����", Empty
                MsgBox "��˳ɹ���      ", vbInformation, "��ʾ"
            Else
                MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
            End If
        Else
            MsgBox "��ע���ͬ״̬�Ƿ�Ϊ��δ��ˡ���лл��    "
            GoTo N:
        End If
    Else: MsgBox "���ȼ������ݣ�лл��    "
    End If
    
N:
    ProtectSheetWithEnableAllowFiltering "��ͬ", True
    SetValueByName "Contract_Change", "0"
    ScreenUpdate True
End Sub


Sub Contract_Delete()
    Dim CurRow As Long
    Dim ColumnList As String
    Dim XMLStr As String
    
    ScreenUpdate False
    ProtectSheetWithEnableAllowFiltering "��ͬ", False
    If TableIsExists("��ͬ") = True Then  '�����ͬ���д���Table
    SetValueByName "Contract_Change", "1"
        If CheckSelectionInTable("ContractList", True) = False Then GoTo N
        CurRow = Selection.Row
        
        If GetValueByHead("ContractList", CurRow, "��ͬ״̬") = "δ���" And GetValueByHead("ContractList", CurRow, "����޸���") <> Empty Then
            SetValueByHead "ContractList", CurRow, "״̬ID", "00DD6348-50D9-4E16-B214-CCFE3CD25D41" '���״̬������˴�ֻ������˵�GUID��
            SetValueByHead "ContractList", CurRow, "����", "D"
            
            ColumnList = "����ͬID����״̬ID��������޸��ˡ�"
            XMLStr = GetXMLByTableColumn("ContractList", ColumnList, "����", "D", "=")
            XMLStr = "<Interface WSID=""7543c48c-e7da-4f6d-8af4-d141bc12aa2b""" & _
                     " App=""" & GetAppName & """ SessionID="""">" & _
                     " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                     "</ROOT></xml></Interface>"
'            Msg "FORM", vbCritical, "", "", XMLStr
            'Exit Sub
            XMLStr = GetWsrrRlt(XMLStr)
            If GetValueFromXml(XMLStr, "Result") = "true" Then
                SetValueByHead "ContractList", CurRow, "��ͬ״̬", "�����"
                SetValueByHead "ContractList", CurRow, "����", Empty
                MsgBox "ɾ���ɹ���      ", vbInformation, "��ʾ"
            Else
                MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
            End If
        Else
            MsgBox "��ע���ͬ״̬�Ƿ�Ϊ��δ��ˡ���лл��    "
            GoTo N:
        End If
    Else: MsgBox "���ȼ������ݣ�лл��    "
    End If
    
N:
    ProtectSheetWithEnableAllowFiltering "��ͬ", True
    SetValueByName "Contract_Change", "0"
    ScreenUpdate True
End Sub

