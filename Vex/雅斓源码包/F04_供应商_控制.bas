Attribute VB_Name = "F04_��Ӧ��_����"
Sub ��Ӧ��_load()
    ScreenUpdate False                  'ֹͣ����
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "��Ӧ��", False
        SetValueByName "��Ӧ��_Change", "1"
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
        '��XML��ʽת��Ϊ�����б����Ҫ���XML��ʽ
        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("SupplyList")))
        CreateTableForXML "SupplyList", XMLStr, "ROOT", "��Ӧ��", "A9"
        If GetRowId("SupplyList", "MAX") <> GetRowId("SupplyList", "MIN") Then _
        DeleteRows "��Ӧ��", GetRowId("SupplyList", "MIN") & ":" & GetRowId("SupplyList", "MIN")

        SetFormat_SupplyList_All
        ProtectSheetWithEnableAllowFiltering "��Ӧ��", True
        Sheets("��Ӧ��").Activate
        Sheets("��Ӧ��").Range("B10").Select
    SetValueByName "��Ӧ��_Change", "0"
'    End If
    ScreenUpdate True
End Sub
   
        
Sub ��Ӧ��_CreateSplit()
    '��Ӧ���½�����
    ProtectSheet "��Ӧ��", False

'    If CheckIsLogin() = False Then GoTo N:

    Dim CurRow As Long
'        -----------by sunyulong 20130801 begin   -----------
    Dim CJR As String               '����һ���������ڴ�ŵ�½����
'        -----------by sunyulong 20130801 end   -----------
    If CheckSelectionInTable("SupplyList", True) = False Then GoTo N
        ScreenUpdate False
        InsertLine "��Ӧ��", 9, True
        CurRow = Selection.Row
'        -----------by sunyulong 20130801 begin   -----------
        CJR = Sheets("��Ӧ��").Range("B1").Value
'        -----------by sunyulong 20130801 end   -----------
        SetValueByHead "SupplyList", CurRow, "����", "I"
        SetValueByHead "SupplyList", CurRow, "��Ӧ�̱��", "ϵͳ�Զ�����"
'        -----------by sunyulong 20130730 begin   -----------
        SetValueByHead "SupplyList", CurRow, "��Ӧ������", "������"
        SetValueByHead "SupplyList", CurRow, "��Ӧ�̷���", "������"
'        -----------by sunyulong 20130730 end   -----------
'        -----------by sunyulong 20130801 begin   -----------
        SetValueByHead "SupplyList", CurRow, "�½���", CJR
'        -----------by sunyulong 20130801 end   -----------
        SetFormat_SupplyList_Line CurRow, CurRow
        'SetFormat_CommandButton_All
        CurRow = Selection.Row
        ScreenUpdate True
N:
    ProtectSheetWithEnableAllowFiltering "��Ӧ��", True
End Sub

Sub ��Ӧ��_Cancelline()
    'ɾ���½���
    Dim CurRow As Long
    ScreenUpdate False

    If CheckSelectionInTable("SupplyList", True) = False Then
        GoTo N
    End If

    CurRow = Selection.Row

    If GetValueByHead("SupplyList", CurRow, "����") = "" And GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��") <> "ϵͳ�Զ�����" _
    Then
        MsgBox "��ѡ���¼��", vbCritical, "��ʾ"
        GoTo N
    End If
    
    DeleteRows "��Ӧ��", CurRow & ":" & CurRow
    Range("C8").Select
N:
    ScreenUpdate True
End Sub

Sub ��Ӧ��_save()
    '�����½�
   
    ScreenUpdate False
    'If Not CheckIsLogin() Then GoTo N
    ProtectSheet "��Ӧ��", False
    
    Dim XMLStr As String, ColumnList As String, CurRow As Long, Str1 As String
     Dim selectItem As String, dictId As String, XGR As String
     
    CurRow = Selection.Row
'        -----------by sunyulong 20130730 begin   -----------
    If GetValueByHead("SupplyList", CurRow, "��Ӧ������") = "������" _
    Then
        MsgBox "��Ӧ�����Ʋ���Ϊ�գ�", vbCritical, "��ʾ"
        GoTo N
    End If
    If GetValueByHead("SupplyList", CurRow, "��Ӧ�̷���") = "������" _
    Then
        MsgBox "��Ӧ�̷��಻��Ϊ�գ�", vbCritical, "��ʾ"
        GoTo N
    End If
'        -----------by sunyulong 20130730 end   -----------
    selectItem = GetValueByHead("SupplyList", CurRow, "��Ӧ�̷���")
'
   dictId = getMBQTGUID("GYSFLList", "DC0_DictName1", selectItem, "DC0_DictId")
   
   SetValueByHead "SupplyList", CurRow, "SU0_SupplierType", dictId
    
    '�趨Ҫ�ϴ�����
    If Not CheckSelectionInTable("SupplyList", True) Then
        MsgBox "���ڵ�ǰ�����ѡ��һ�У�      ", vbCritical, "��ʾ"
        GoTo N
    End If
       
    If GetValueByHead("SupplyList", CurRow, "����") = "I" Then
    '�����½���Ӧ����Ϣ
        If MsgBox("��ȷ��Ҫ�����桿" & "��Ӧ�����ƣ� " & GetValueByHead("SupplyList", CurRow, "��Ӧ������") & "��������    ", vbYesNo, "��ʾ") = vbYes Then
    
            ColumnList = " ��SU0_CONO����SU0_DIVI����SU0_SupplierId������Ӧ�̱�š���SU0_SupplierType������Ӧ�����ơ�����ϵ�ˡ�����ϵ�绰������ַ���������С��������˻��������е�ַ��������SWIFT�š����½��ˡ����޸��ˡ�"""
            XMLStr = GetXMLByTableColumn("SupplyList", ColumnList, "����", "I", "=")
            
            XMLStr = "<Interface WSID=""f2769b90-ffa3-4cc9-93a5-49ac49badd80""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            "<xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
            "</ROOT></xml></Interface>"
                '�����ϴ�xml��ʽ,ע��WSID��OPTYPE����

                XMLStr = GetWsrrRlt(XMLStr)
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
                

                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "����ɹ���      ", vbInformation, "��ʾ"
                    SetValueByHead "SupplyList", CurRow, "����", "F"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                End If
        End If
    End If
    
    If GetValueByHead("SupplyList", CurRow, "����") = "U" Then
    '���湩Ӧ���޸���Ϣ
        If MsgBox("��ȷ��Ҫ���޸ġ�" & "��Ӧ�����ƣ� " & GetValueByHead("SupplyList", CurRow, "��Ӧ������") & "�Ĺ�Ӧ����Ϣ��    ", vbYesNo, "��ʾ") = vbYes Then
            XGR = Sheets("��Ӧ��").Range("B1").Value
            SetValueByHead "SupplyList", CurRow, "����޸���", XGR
    
            ColumnList = " ��SU0_CONO����SU0_DIVI����SU0_SupplierId������Ӧ�̱�š���SU0_SupplierType������Ӧ�����ơ�����ϵ�ˡ�����ϵ�绰������ַ���������С��������˻��������е�ַ��������SWIFT�š����½��ˡ�������޸��ˡ�"""
            XMLStr = GetXMLByTableColumn("SupplyList", ColumnList, "����", "I", "=")
            
            XMLStr = GetXMLByTableColumn("SupplyList", ColumnList, "����", "U", "=")
            XGR = Sheets("��Ӧ��").Range("B1").Value
            SetValueByHead "SupplyList", CurRow, "����޸���", XGR
    
            '�Ƿ�����ϴ�xml��ʽ��
                 XMLStr = "<Interface WSID=""f2769b90-ffa3-4cc9-93a5-49ac49badd80""" & _
                 " App=""" & GetAppName & """ SessionID="""">" & _
                 " <xml><ROOT><OPTYPE>EDIT</OPTYPE><LIST>" & XMLStr & "</LIST>" & _
                 "</ROOT></xml></Interface>"
                '�����ϴ�xml��ʽ,ע��WSID��OPTYPE����
'                Msg "FORM", vbCritical, "", "", XMLStr
'                Exit Sub
         
                XMLStr = GetWsrrRlt(XMLStr)
                
                If GetValueFromXml(XMLStr, "Result") = "true" Then
                    MsgBox "����ɹ���      ", vbInformation, "��ʾ"
                    'Msg "FORM", vbCritical, "", "", GetValueFromXml(XMLStr, "Message")
                    SetValueByHead "SupplyList", CurRow, "����", "F"
                Else
                    MsgBox "����ʧ�ܣ�" & GetValueFromXml(XMLStr, "Message") & "      ", vbCritical, "��ʾ"
                End If
        End If
    End If
    'SetFormat_CommandButton_All
    ��Ӧ�̻���_load
    ProtectSheetWithEnableAllowFiltering "��Ӧ��", True
        
N:
    ScreenUpdate True

End Sub



Sub CreateBrand()
    '��ת���½�Ʒ�ơ�Sheet
    
    If Not CheckSelectionInTable("SupplyList", True) Then
        MsgBox "���ڵ�ǰ�����ѡ��һ�У�      ", vbCritical, "��ʾ"
        GoTo N
    End If
    
    HideSheet "�½�Ʒ��", False
    ProtectSheet "�½�Ʒ��", False
    
    Dim BH As String            '����һ���������ڴ�Ź�Ӧ�̱��
    Dim JC As String            '����һ���������ڴ�Ź�Ӧ�̼��
    Dim CJR As String           '����һ���������ڴ�Ŵ�����
    Dim CurRow As Long
    
    CurRow = Selection.Row
    
    'BH = GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��")
    JC = GetValueByHead("SupplyList", CurRow, "��Ӧ������")
    BH = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", JC, "��Ӧ�̱��")
    
    CJR = Sheets("��Ӧ��").Range("B1").Value
    
    HideSheet "�½�Ʒ��", False
    HideSheet "��Ӧ��", False
    
    ProtectSheet "�½�Ʒ��", False
    
    
    
    Sheets("�½�Ʒ��").Activate
    Sheets("�½�Ʒ��").Range("C6").Select
N:
    ProtectSheet "�½�Ʒ��", True
    
End Sub
'        -----------by sunyulong 20130803 begin   -----------
Sub ��ѯƷ��_load()
    ScreenUpdate False
    ClearTable "BrandList"
'    If CheckIsLogin() Then
        ProtectSheetWithEnableAllowFiltering "��Ӧ��", False
        SetValueByName "�½�Ʒ��_Change", "1"
        SetValueByName "��Ӧ��_Change", "1"
        Dim CurRow As Long
        Dim XMLStr As String
        Dim sid As String
        Dim I As Long
        Dim MarkId As String
        CurRow = Selection.Row
        If GetValueByHead("SupplyList", CurRow, "����") <> "" Or GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��") = "" Then
                MsgBox "�뽫��궨λ�ڡ�������Ϊ�յ����ڣ�лл��"
                GoTo N
            End If
        MarkId = GetValueByHead("SupplyList", CurRow, "����")
        If MarkId <> "S" Then
'        If CheckSelectionInTable("SupplyList", True) = False Then GoTo N:
        '�ж��ǲ��ǲ�ѯƷ��
'        CurRow = FindValueRowByHead("B", "SupplyList", "����", 1)
        If GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��") <> "ϵͳ�Զ�����" Then
         sid = GetValueByHead("SupplyList", CurRow, "SU0_SupplierId")
        If GetValueByHead("SupplyList", CurRow, "����") = "B" Then
        End If
        '��ʼִ��
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
            CreateTableForXML "BrandList", XMLStr, "ROOT", "�½�Ʒ��", "A4"
            If GetRowId("BrandList", "MAX") <> GetRowId("BrandList", "MIN") Then _
            DeleteRows "�½�Ʒ��", GetRowId("BrandList", "MIN") & ":" & GetRowId("BrandList", "MIN")
            SetFormat_BrandList_All
            '�������в鿴Ʒ�ƵĲ�����ΪS��������ͷ
            For Each cl In Range("BrandList[[Ʒ������]]")
              If cl.Value <> "" Then
                SetValueByHead "BrandList", cl.Row, "S", "S"
              End If
            Next
            ProtectSheetWithEnableAllowFiltering "TEMP1", True
            
            '����Ѳ鿴���б�
            For I = GetTableRowId("SupplyList", -1) To CurRow Step -1 '�ڱ�SupplyList��ѭ�����������=S�Ļ�����ɾ����
                If GetValueByHead("SupplyList", I, "����") = "S" Then
                DeleteRows "��Ӧ��", I & ":" & I   'ɾ�����ΪS����
                End If
            Next
            CopyRecords_Def1 "BrandList", "SupplyList", CurRow + 1, "��S,��������Ʒ�Ʊ��,��Ӧ�̱�š�����Ӧ�̱��,��Ӧ�̷��ࡿ��Ʒ������,��Ӧ�����ơ���Ʒ�����ڹ���,��ϵ�ˡ���Ʒ�Ʒ��,��ϵ�绰����Ŀ��Ⱥ��,��ַ��", True
            For Each rw In Range("SupplyList[[����]]")
                    If rw.Value = "S" Then
                        CopyCellFormat "�½�Ʒ��", "U1", Sheets("��Ӧ��").Range(Cells(rw.Row, GetColumnId("SupplyList", "Min")), Cells(rw.Row, GetColumnId("SupplyList", "Max")))
                    End If
                Next
'           Msg "FORM", vbCritical, "", "", XMLStr
'           Exit Sub
'           ��XML��ʽת��Ϊ�����б����Ҫ���XML��ʽ
            Else
                If MsgBox("��Ӧ�̱�ţ� " & GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��") & "��Ʒ��,������Ҫ�½���    ", vbYesNo, "��ʾ") = vbYes Then
                    �½�Ʒ��_CreateBrands
                End If
            End If
            
        ProtectSheetWithEnableAllowFiltering "��Ӧ��", True
        ProtectSheetWithEnableAllowFiltering "�½�Ʒ��", True
N:
       End If
     End If
    SetValueByName "�½�Ʒ��_Change", "0"
    SetValueByName "��Ӧ��_Change", "0"
    ScreenUpdate True
'        -----------by sunyulong 20130819 end   -----------
End Sub
Sub ��Ʒ��Ϣ_CreateProduct()
ScreenUpdate False
    Dim sid As String
    Dim sno As String
    Dim sName As String
    Dim CurRow As Long
    Dim XMLStr As String
    Dim Rstr As String
    Dim Guid As String
    ProtectSheet "��Ʒ��Ϣ", False
    ClearTable "ProductList"
    ClearPic "��Ʒ��Ϣ", "ProductList*"
    SetValueByName "��Ʒ��Ϣ_Change", "1"
    If CheckSelectionInTable("SupplyList", True) = False Then GoTo N
    CurRow = Selection.Row
    Guid = LCase(Mid$(CreateObject("Scriptlet.TypeLib").Guid, 2, 36))
    If GetValueByHead("SupplyList", CurRow, "����") = "S" _
    Then
        MsgBox "��ѡ�й�Ӧ�̵ļ�¼�в�����", vbCritical, "��ʾ"
        GoTo N
    End If
    If GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��") <> "ϵͳ�Զ�����" Then
        sid = GetValueByHead("SupplyList", CurRow, "SU0_SupplierId")
        sno = GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��")
    Else
        sName = GetValueByHead("SupplyList", CurRow, "��Ӧ������")
        sno = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", sName, "��Ӧ�̱��")
        sid = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", sName, "SU0_SupplierId")
    End If
    ClearTable "ProductList"
    Ʒ�����ƻ���_load
    
    '--------20130819 by zz begin------------
    '�ж�������Ʒʱ�Ƿ��Ѵ���Ʒ��
     XMLStr = "<Interface WSID=""ab42831d-3ac7-4391-8bac-0869379798fc""" & _
            " App=""" & GetAppName & """ SessionID="""">" & _
            " <xml><ROOT><OPTYPE>GET</OPTYPE><LIST><Row><Condition>" & "BD0_SU0_SupplierId='" & sid & "'" & "</Condition></Row></LIST>" & _
            "</ROOT></xml></Interface>"
            XMLStr = Replace(XMLStr, "'", "\u0027")
            XMLStr = GetWsrrRlt(XMLStr)
'            Msg "FORM", vbCritical, "", "", XMLStr
'            Exit Sub
            If GetValueFromXml(XMLStr, "BD0_BrandName") = "" Then
               If MsgBox("�ù�Ӧ��������Ʒ��,�޷��½���Ʒ��������Ҫ���½�Ʒ����    ", vbYesNo, "��ʾ") = vbYes Then
                    �½�Ʒ��_CreateBrands
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
            
                XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("ProductLoadList")))
                CreateTableForXML "ProductList", XMLStr, "ROOT", "��Ʒ��Ϣ", "A5"
                If GetRowId("ProductList", "MAX") <> GetRowId("ProductList", "MIN") Then _
                DeleteRows "��Ʒ��Ϣ", GetRowId("ProductList", "MIN") & ":" & GetRowId("ProductList", "MIN")
                Sheets("��Ʒ��Ϣ").Activate
'                InsertLine "��Ʒ��Ϣ", GetTableRowId("ProductList", 0), True
                CurRow = Selection.Row
                SetValueByHead "ProductList", CurRow + 1, "����", "I"

                SetFormat_ProductLoadList_All
                SetValueByHead "ProductList", CurRow + 1, "��ƷID", Guid
                SetValueByHead "ProductList", CurRow + 1, "Ʒ������", "������"
                SetValueByHead "ProductList", CurRow + 1, "Ʒ��", "������"
                SetValueByHead "ProductList", CurRow + 1, "��Ӧ�̿��", "������"
                SetValueByHead "ProductList", CurRow + 1, "��Ӧ����ɫ", "������"
                SetValueByHead "ProductList", CurRow + 1, "��Ӧ�̳���", "������"
                SetValueByHead "ProductList", CurRow + 1, "PD0_SUO_SupplierId", sid
                SetValueByHead "ProductList", CurRow + 1, "PD0_SecurityLevelId", "ϵͳ�Զ�����"
                SetValueByHead "ProductList", CurRow + 1, "��Ӧ�̱��", sno
                SetValueByHead "ProductList", CurRow + 1, "�ɹ���", "0"
                SetValueByHead "ProductList", CurRow + 1, "���Ƽ�", "0"
                SetValidationStr Range("ProductList[[Ʒ������]]"), GetAddressByHead2("BrandBASEList", "BD0_SU0_SupplierId", sid, "Ʒ������")
            End If
N:
    Sheets("��Ʒ��Ϣ").Range("G6").Select
    SetValueByName "��Ʒ��Ϣ_Change", "0"
    ProtectSheet "��Ʒ��Ϣ", True
    ScreenUpdate True
End Sub
Sub �½�Ʒ��_CreateBrands()
    Dim sno As String, sid As String, sName As String
    Dim CurRow As Long
    Dim XMLStr As String
    Dim Rstr As String
    Dim CJR As String
    ScreenUpdate False
    ProtectSheet "�½�Ʒ��", False
    SetValueByName "�½�Ʒ��_Change", "1"
    If CheckSelectionInTable("SupplyList", True) = False Then GoTo N
    CurRow = Selection.Row
    CJR = Sheets("��Ӧ��").Range("B1").Value
    If GetValueByHead("SupplyList", CurRow, "����") = "S" _
    Then
        MsgBox "��ѡ�й�Ӧ�̵ļ�¼�в�����", vbCritical, "��ʾ"
        GoTo N
    End If
    If GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��") <> "ϵͳ�Զ�����" Then
        sno = GetValueByHead("SupplyList", CurRow, "��Ӧ�̱��")
        sid = getMBQTGUID("SupplyBASEList", "��Ӧ�̱��", sno, "SU0_SupplierId")
    Else
        sName = GetValueByHead("SupplyList", CurRow, "��Ӧ������")
        sno = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", sName, "��Ӧ�̱��")
        sid = getMBQTGUID("SupplyBASEList", "SU0_SupplierName", sName, "SU0_SupplierId")
    End If
    
    ClearTable "BrandList"
         XMLStr = "<ROOT><LIST><Rows>" & _
        "<BD0_CONO></BD0_CONO><BD0_DIVI></BD0_DIVI><BD0_BrandId></BD0_BrandId><BD0_BrandCode></BD0_BrandCode><BD0_SU0_SupplierId></BD0_SU0_SupplierId><BD0_BrandName></BD0_BrandName><BD0_CountryId></BD0_CountryId><SU0_SupplierCode></SU0_SupplierCode><CountryDictName></CountryDictName><StyleDictName></StyleDictName><CusGrpDictName></CusGrpDictName>" & _
        "<BD0_StyleId></BD0_StyleId><BD0_CusGrpId></BD0_CusGrpId><BD0_Status></BD0_Status><BD0_RgUser></BD0_RgUser><BD0_RgDt></BD0_RgDt><BD0_LmUser></BD0_LmUser><BD0_LmDt></BD0_LmDt><BD0_UptNo>" & _
        "</BD0_UptNo>" & _
        "</Rows></LIST></ROOT>"
        
        XMLStr = FormatXMLForListObject(XMLStr, "<����></����>" & ConvertColumnListToXML(GetHeadMap("")))
        CreateTableForXML "BrandList", XMLStr, "ROOT", "�½�Ʒ��", "A4"
        If GetRowId("BrandList", "MAX") <> GetRowId("BrandList", "MIN") Then _
        DeleteRows "�½�Ʒ��", GetRowId("BrandList", "MIN") & ":" & GetRowId("BrandList", "MIN")
        Sheets("�½�Ʒ��").Activate
        CurRow = Selection.Row
     SetFormat_BrandList_All
     SetValueByHead "BrandList", CurRow + 1, "����", "I"
     SetValueByHead "BrandList", CurRow + 1, "��Ӧ�̱��", sno
     SetValueByHead "BrandList", CurRow + 1, "Ʒ�Ʊ��", "������"
     SetValueByHead "BrandList", CurRow + 1, "Ʒ������", "������"
     SetValueByHead "BrandList", CurRow + 1, "������", CJR
    
N:
    Sheets("�½�Ʒ��").Range("E5").Select
    SetValueByName "�½�Ʒ��_Change", "0"
    ScreenUpdate True
End Sub
