Attribute VB_Name = "A02_����"
Function GetPwd() As String
'��ȡ����������������
GetPwd = "3D42CE79E1AB674DB01DCEBE41D4C35A"
End Function
Function LoginAction(Usr As String)
Login.Hide
SetCellValueByRange "��Ӧ��", "A1", "�û���"
SetCellValueByRange "��Ӧ��", "B1", Usr
ClearLog
SetAdminPower
Sheets("��Ӧ��").Activate
Sheets("��Ӧ��").Range("C7").Select
End Function
Function GetWsrrUrl() As String
'WS�������ĵ�ַ
GetWsrrUrl = "http://172.16.205.57:8080/wsrr.asmx/CallByXML" '���Ե�ַ
'GetWsrrUrl = "http://192.168.0.37/wsrr.asmx/CallByXML" '��ʽ��ַ
End Function
Function GetLoginSrv() As String
    'ָ����¼��Srv,������SSO��PLMFZ
    GetLoginSrv = "SSO"
End Function
Function GetUsr() As String
'��ȡ��ǰ�û�
GetUsr = Sheets("��Ӧ��").Range("B1").Value
End Function
Function GetAppName() As String
'����APPName
GetAppName = "GL_ERP"
End Function
Function GetSessionWin() As String
GetSessionWin = "��֮��PLMTOOL_SID_"
End Function
Function GetUrlPath()
GetUrlPath = "/1002B_ITDCTool.aspx?sid="
End Function
Function SetAdminPower()
'���ù���ԱȨ��
If GetUsr = "����" Then
    AddEditRange "��Ӧ��", "C7"
    ProtectSheet "��Ӧ��", False
End If
End Function
Function LoginInitialize()
SetCellValueByRange "��Ӧ��", "B1", ""
'Login.AppName.Caption = "����ERP"
'Login.AppName.TextAlign = fmTextAlignCenter
End Function
Function WorkBookOpen()
SetApplication
    
    For Each st In ThisWorkbook.Sheets
    If UCase(st.Name) <> "MAIN" Then
        ProtectSheet st.Name, False
'        ClearEditRange st.Name
        ProtectSheet st.Name, True
    Else
        ProtectSheet st.Name, False
    End If
    Next
    ProtectSheet "��Ӧ��", False
    ClearTable "SupplyList"
    ClearTable "BrandList"
    ClearTable "ProductList"
    ClearTable "OrderList"
    ClearTable "ContractList"
    ClearTable "PayList"
'    Sheets("��Ӧ��").CommandButton1.Visible = True
'    Sheets("��Ӧ��").CommandButton2.Visible = True
''    Sheets("��Ӧ��").CommandButton8.Visible = False
''    Sheets("��Ӧ��").CommandButton3.Visible = False
''    Sheets("��Ӧ��").CommandButton4.Visible = False
''    Sheets("��Ӧ��").CommandButton7.Visible = False
    HideSheet "CONF", True
    HideSheet "TEMP", True
    HideSheet "Main", True
    HideSheet "TEMP1", True
    HideSheet "LOG", True
    ProtectSheet "��Ӧ��", True
ClearConf
ThisWorkbook.Protect GetPwd
For Each st In ThisWorkbook.Sheets
    If UCase(st.Name) <> "MAIN" Then ProtectSheet st.Name, True
Next
End Function

Function GetHeadMap(TableName As String) As String

If TableName = "SupplyList" Then
    GetHeadMap = "��SU0_SupplierCode,��Ӧ�̱�š���SU0_SupplierName,��Ӧ�����ơ���SU0_SupplierType,SU0_SupplierType����DC0_DictName1,��Ӧ�̷��ࡿ " & _
    "��SU0_Contact,��ϵ�ˡ���SU0_Phone,��ϵ�绰����SU0_Address,��ַ����SU0_Bank,�����С�" & _
    "��SU0_BankAccount,�����˻�����SU0_BankAddress,���е�ַ����SU0_BankSwift,����SWIFT�š�SU0_Status��SU0_Status,״̬����SU0_RgUser,�½��ˡ���SU0_LmUser,����޸��ˡ���SU0_UptNo,�޸�ʱ�䡿"
End If
If TableName = "ProductLoadList" Then
    GetHeadMap = "��PD0_PicPath,��ͼ����PD0_ProductId,��ƷID����PD0_SUO_SupplierId,PD0_SUO_SupplierId����SU0_SupplierCode,��Ӧ�̱�š���PD0_BD0_BrandId,PD0_BD0_BrandId����BD0_BrandName,Ʒ�����ơ���PD0_Lvl0,Ʒ������PD0_ProductCodeSU,��Ӧ�̿�š���PD0_ColorSUId,��Ӧ����ɫ��" & _
    "��ColorBSUName,��Ӧ����ɫ���򣩡���PD0_SizeSUId,��Ӧ�̳��롿��PD0_SKUSU,��Ӧ��SKU����PD0_Code,��š���PD0_ColorId,PD0_ColorId����ColorDictName,��ɫ�� " & _
    "��PD0_SizeId,PD0_SizeId����SizeDictName,���롿��PD0_SKU,SKU����PD0_UnitId,��λ����PD0_PurchasePrice,�ɹ��ۡ���PD0_SalePrice,���Ƽۡ���PD0_YearId,PD0_YearId����YearDictName,��ݡ�" & _
    "��PD0_SeasonId,���ڡ���PD0_Lvl1,��ʽ���ࡿ��PD0_Lvl2,��ʽ���ࡿ��PD0_Lvl3,��ʽС�ࡿ" & _
    "��PD0_SourceCountry,���ء���PD0_Composition,�ɷ֡���PD0_QulityLevel,�ȼ�����PD0_StandardId,PD0_StandardId����StandardDictName,ִ�б�׼����PD0_SecurityLevelId,PD0_SecurityLevelId����SecurityLevelDictName,��ȫ������𡿡�PD0_IsPrinted,�Ƿ��ӡ����PD0_Status,״̬��" & _
    "��PD0_RgUser,�����ˡ���PD0_RgDt,����ʱ�䡿��PD0_LmUser,����޸��ˡ���PD0_LmDt,����޸�ʱ�䡿��PD0_UptNo,�޸Ĵ�����"
End If
If TableName = "SupplyBASEList" Then
    GetHeadMap = "��SU0_SupplierCode,��Ӧ�̱�š�"
End If
If TableName = "BrandList" Then
    GetHeadMap = "��SU0_SupplierCode,��Ӧ�̱�š���BD0_BrandCode,Ʒ�Ʊ�š���BD0_BrandName,Ʒ�����ơ���BD0_CountryId,Ʒ�����ڹ��ҡ���CusGrpDictName,Ŀ��Ⱥ�塿��StyleDictName,Ʒ�Ʒ��" & _
    "��BD0_RgUser,�����ˡ���BD0_RgDt,����ʱ�䡿��BD0_LmUser,����޸��ˡ���BD0_LmDt,����޸�ʱ�䡿"
End If
If TableName = "BrandBASEList" Then
    GetHeadMap = "��BD0_BrandCode,Ʒ�Ʊ�š���BD0_SU0_BrandCode,��Ӧ�̱�š���BD0_BrandName,Ʒ�����ơ���BD0_CountryId,Ʒ�����ڹ��ҡ� " & _
    "��BD0_StyleId,Ʒ�Ʒ�񡿡�BD0_CusGrpId,Ŀ��Ⱥ�塿��BD0_RgUser,�½��ˡ�"
End If
If TableName = "ContractList" Then
    GetHeadMap = "��PR0_CONO,���š���PR0_DIVI,��ҵ�塿��PR0_ContractCode,��ͬ��š���SU0_SupplierCode,��Ӧ�̱�š���StatusDictName,��ͬ״̬��" & _
    "��PR0_Amount,��ͬ����CurrencyDictName,������֡���AccountDictName,���㷽ʽ����PR0_PrePayRate,Ԥ����ٷֱȡ���PR0_Description,��ͬ˵����" & _
    "��PR0_StartDate,��ͬ��ʼʱ�䡿��PR0_EndDate,��ͬ��ֹʱ�䡿��PR0_ECopyPath,��ͬɨ�����" & _
    "��WFT_NODE1,�ܼ���ˡ���WFP_AuditTime1,�ܼ����ʱ�䡿��DC0_DICTNAME1,�ܼ����״̬��" & _
    "��WFT_NODE2,������ˡ���WFP_AuditTime2,�������ʱ�䡿��DC0_DICTNAME2,�������״̬����WFT_NODE3,������ˡ���WFP_AuditTime3,�������ʱ�䡿��DC0_DICTNAME3,�������״̬��" & _
    "��WFT_NODE4,���ܲ���ˡ���WFP_AuditTime4,���ܲ����ʱ�䡿��DC0_DICTNAME4,���ܲ����״̬����WFT_NODE5,����ˮ������WFP_AuditTime5,����ˮ��ʱ�䡿��DC0_DICTNAME5,����ˮ��״̬��" & _
    "��PR0_RgUser,�����ˡ���PR0_RgDt,����ʱ�䡿��PR0_LmUser,����޸��ˡ���PR0_LmDt,����޸�ʱ�䡿��PR0_UptNo,�޸Ĵ�������PR0_ContractId,��ͬID����PR0_SU0_SupplierId,��Ӧ�̱��ID��" & _
    "��PR0_Status,״̬ID����PR0_CurrencyId,�������ID����PR0_SettleAccount,���㷽ʽID��"
End If
If TableName = "ContractNewList" Then
    GetHeadMap = "��PR0_CONO,���š���PR0_DIVI,��ҵ�塿��PR0_ContractCode,��ͬ��š�" & _
    "��SU0_SupplierCode,��Ӧ�̱�š���StatusDictName,��ͬ״̬����PR0_PrePayRate,Ԥ����ٷֱȡ���PR0_CurrencyId,�������ID��" & _
    "��CurrencyDictName,������֡���PR0_SettleAccount,���㷽ʽID����AccountDictName,���㷽ʽ����PR0_Amount,��ͬ����PR0_Description,��ͬ˵����" & _
    "��PR0_ECopyPath,��ͬɨ�������PR0_StartDate,��ͬ��ʼʱ�䡿��PR0_EndDate,��ͬ��ֹʱ�䡿" & _
    "��PR0_RgUser,�����ˡ���PR0_LmUser,����޸��ˡ���PR0_ContractId,��ͬ���ID����PR0_SU0_SupplierId,��Ӧ��ID����PR0_Status,״̬ID����PR0_CurrencyId,�������ID��"
End If
If TableName = "NewPurchaseOrderList" Then
    GetHeadMap = "��PR1_OrderCode,�ɹ�����š�" & _
    "��OrderTypeDictName,�ɹ����͡���PR0_ContractCode,��ͬ��š���SU0_SupplierCode,��Ӧ�̱�š���BD0_BrandName,Ʒ�����ơ���PR1_PurchaseTotal,�ɹ���������PR1_SupplierType,��Ӧ�����͡�" & _
    "��PR1_Discount,�ɹ��ۿۡ���PR1_ExchangeRate,ʵʱ���ʡ���CurrencyTypeDictName,���֡���PR1_PurchaseAmount,�ɹ����Ҽۡ���PR1_POriginalAmount,�ɹ�ԭ�Ҽۡ���StatusDictName,�ɹ���״̬��" & _
    "��PR1_Tariff,��˰����PR1_VAT,��ֵ˰����PR1_Freight,�˷ѡ���PR1_Times,���ʡ�" & _
    "��PR1_RgUser,�����ˡ���PR1_LmUser,����޸��ˡ���PR1_Status,״̬ID����PR1_OrderId,�ɹ���ID����PR1_OrderTypeId,�ɹ�������ID����PR1_PR0_ContractId,��ͬ���ID����PR1_SU0_SupplierId,��Ӧ�̱��ID����PR1_BD0_BrandId,Ʒ�Ʊ��ID��"
End If

If TableName = "PurchaseOrderList" Then
    GetHeadMap = "��PR1_CONO,���š���PR1_DIVI,��ҵ�塿��PR1_OrderId,�ɹ���ID����PR1_OrderCode,�ɹ�����š�" & _
    "��PR1_OrderTypeId,�ɹ�������ID����OrderTypeDictName,�ɹ����͡���PR1_PR0_ContractId,��ͬ���ID����PR0_ContractCode,��ͬ��š�" & _
    "��PR1_SU0_SupplierId,��Ӧ�̱��ID����SU0_SupplierCode,��Ӧ�̱�š���SU0_SupplierType,��Ӧ������ID����PR1_BD0_BrandId,Ʒ�Ʊ��ID��" & _
    "��BD0_BrandName,Ʒ�����ơ���PR1_PurchaseTotal,�ɹ���������PR1D_UnitID,��λ��" & _
    "��CurrencyTypeDictName,���֡���PR1_PurchaseAmount,�ɹ����Ҽۡ���PR1_POriginalAmount,�ɹ�ԭ�Ҽۡ���PR1_Discount,�ۿۡ���PR1_ExchangeRate,ʵʱ���ʡ�" & _
    "��PR1_Tariff,��˰����PR1_VAT,��ֵ˰����PR1_Freight,�˷ѡ���PR1_Times,���ʡ���PR1_CurrencyTypeId,����ID����PR1_SupplierType,��Ӧ�����͡�" & _
    "��PR1_Status,״̬ID����StatusDictName,�ɹ���״̬����PR1_RgUser,�����ˡ���PR1_RgDt,����ʱ�䡿��PR1_LmUser,����޸��ˡ���PR1_LmDt,����޸�ʱ�䡿��PR1_UptNo,�޸Ĵ�����"
End If

If TableName = "PayList" Then
    GetHeadMap = "��TypeDictName,������͡���FNP_PayApplyId,���뵥ID����FNP_PayApplyCode,���뵥��š���SU0_SupplierCode,��Ӧ�̱�š���SU0_Bank,�����С���SU0_BankAccount,�����˻�����SU0_BankSwift,����SWIFT�š���FNP_SU0_SupplierId,��Ӧ��GUID����FNP_Type,���뵥���͡���FNP_BankReceipt,����ˮ���š���FNP_PayAmount,�����ܽ���FNP_PayRate,����ٷֱȡ�" & _
    "��FNP_DuesAmount,Ӧ�������FNP_IsPayed,�Ƿ��Ѹ����StatusDictName,״̬����PR0_RgUser,�����ˡ���PR0_RgDt,����ʱ�䡿��PR0_LmUser,����޸��ˡ���PR0_LmDt,����޸�ʱ�䡿��PR0_UptNo,���Ĵ�����"
End If
If TableName = "PayNewList" Then
    GetHeadMap = "��FNP_PayApplyId,���뵥ID����FNP_PayApplyCode,���뵥��š���SU0_SupplierCode,��Ӧ�̱�š���SU0_Bank,�����С���SU0_BankAccount,�����˻�����SU0_BankSwift,����SWIFT�š�" & _
    "��PR0_ContractId,��ͬGUID����SU0_SupplierId,��Ӧ��GUID����FNP_Type,���뵥���͡���FNP_BankReceipt,����ˮ���š���FNP_PayAmount,�����ܽ���FNP_PayRate,����ٷֱȡ���FNP_DuesAmount,Ӧ�������FNP_IsPayed,�Ƿ��Ѹ��" & _
    "��FNP_RgUser,�����ˡ���FNP_RgDt,����ʱ�䡿��FNP_LmUser,����޸��ˡ���FNP_LmDt,����޸�ʱ�䡿��FNP_UptNo,���Ĵ�����"
End If
If TableName = "PayMXList" Then
    GetHeadMap = "��FNPD_PayApplyDetailId,�������뵥��ϸID����FNPD_FNP_PayApplyId,���뵥ID����FNPD_FNP_PayApplyCode,���뵥��š���FNPD_RefBillDetailID,����ID��" & _
    "��PR0_RgUser,�����ˡ���PR0_RgDt,����ʱ�䡿��PR0_LmUser,����޸��ˡ���PR0_LmDt,����޸�ʱ�䡿��PR0_ContractCode,��ͬ��š���PR0_Amount,��ͬ����PR0_PrePayRate,Ԥ����ٷֱȡ���PR0_Description,��ͬ��ע����PR0_SettleAccount,���㷽ʽ��" & _
    "��TypeDictName,�������͡���PR1_PurchaseTotal,�ɹ���������StatusDictName,״̬����CurrencyDictName,������֡�"
End If
If TableName = "PayDHList" Then
    GetHeadMap = "��FNP_PayApplyId,���뵥ID����FNP_PayApplyCode,���뵥��š���SU0_SupplierCode,��Ӧ�̱�š���SU0_Bank,�����С���SU0_BankAccount,�����˻�����SU0_BankSwift,����SWIFT�š���PRA_ArrivalPlanId,�����ƻ�GUID����SU0_SupplierId,��Ӧ��GUID����FNP_Type,���뵥���͡���FNP_BankReceipt,����ˮ���š���FNP_PayAmount,�����ܽ���FNP_PayRate,����ٷֱȡ�" & _
    "��FNP_DuesAmount,Ӧ�������FNP_IsPayed,�Ƿ��Ѹ����FNP_RgUser,�����ˡ���FNP_RgDt,����ʱ�䡿��FNP_LmUser,����޸��ˡ���FNP_LmDt,����޸�ʱ�䡿��FNP_UptNo,�޸Ĵ�����"
End If
If TableName = "PayMXList" Then
    GetHeadMap = "��FNPD_PayApplyDetailId,�������뵥��ϸID����FNPD_FNP_PayApplyId,���뵥ID����FNPD_FNP_PayApplyCode,���뵥��š���FNPD_RefBillDetailID,����ID��" & _
    "��PR0_RgUser,�����ˡ���PR0_RgDt,����ʱ�䡿��PR0_LmUser,����޸��ˡ���PR0_LmDt,����޸�ʱ�䡿��PR0_ContractCode,��ͬ��š���PR0_Amount,��ͬ����PR0_PrePayRate,Ԥ����ٷֱȡ���PR0_Description,��ͬ��ע����PR0_SettleAccount,���㷽ʽ��" & _
    "��TypeDictName,�������͡���PR1_PurchaseTotal,�ɹ���������StatusDictName,״̬����CurrencyDictName,������֡�"
End If
If TableName = "PayDHMXList" Then
    GetHeadMap = "��FNPD_PayApplyDetailId,�������뵥��ϸID����FNPD_FNP_PayApplyId,���뵥ID����FNPD_FNP_PayApplyCode,���뵥��š���FNPD_RefBillDetailID,����ID��" & _
    "��CurrencyDictName,�ɹ����֡���PRA_ArrivalPlanCode,�����ƻ���š���PRA_PlanAmount,�ɹ�����PRA_PlanTotal,�ɹ���������PR0_ContractCode,��ͬ��š�" & _
    "��TypeDictName,�������͡���StatusDictName,״̬����PR0_RgUser,�����ˡ���PR0_RgDt,����ʱ�䡿��PR0_LmUser,����޸��ˡ���PR0_LmDt,����޸�ʱ�䡿"
End If
If TableName = "PayTHList" Then
    GetHeadMap = "��FNP_PayApplyId,���뵥ID����FNP_PayApplyCode,���뵥��š���PRC_ReturnId,�˻�������ID����SU0_SupplierId,��Ӧ��ID����FNP_Type,���뵥���͡���SU0_SupplierCode,��Ӧ�̱�š���SU0_Bank,�����С���SU0_BankAccount,�����˻�����SU0_BankSwift,����SWIFT�š�" & _
    "��FNP_BankReceipt,����ˮ���š���FNP_PayAmount,�����ܽ���FNP_PayRate,����ٷֱȡ���FNP_DuesAmount,Ӧ�������FNP_IsPayed,�Ƿ��Ѹ����FNP_RgUser,�����ˡ���FNP_RgDt,����ʱ�䡿��FNP_LmUser,����޸��ˡ���FNP_LmDt,����޸�ʱ�䡿��FNP_UptNo,�޸Ĵ�����"
End If
If TableName = "PayTHMXList" Then
    GetHeadMap = "��FNPD_PayApplyDetailId,�������뵥��ϸID����FNPD_FNP_PayApplyId,���뵥ID����FNPD_FNP_PayApplyCode,���뵥��š���FNPD_RefBillDetailID,����ID��" & _
    "��PR0_ContractCode,��ͬ��š���PRC_ReturnCode,�˻�����š���PRC_Amount,�˻�����PRC_Total,�˻�������" & _
    "��TypeDictName,�������͡���StatusDictName,״̬����PR0_RgUser,�����ˡ���PR0_RgDt,����ʱ�䡿��PR0_LmUser,����޸��ˡ���PR0_LmDt,����޸�ʱ�䡿"
End If
If TableName = "PODetailList" Then
    GetHeadMap = "��PR1D_CONO,���š���PR1D_DIVI,��ҵ�塿��PR1_OrderCode,�ɹ�����š���SU0_SupplierCode,��Ӧ�̱�š���PD0_ProductCodeSU,��Ӧ�̿�š���SU0_SupplierType,��Ӧ�����͡�" & _
    "��ColorSUIdDictName,��Ӧ����ɫ����ColorTypeDictName,��ɫ���͡�" & _
    "��ColorBSUIdDictName,��Ӧ����ɫ�򡿡�SizeSUIdTypeDictName,��Ӧ�̳��롿��PR1D_PD0_SKUSU,��Ӧ��SKU����PR1D_PD0_SKU,SKU��" & _
    "��PR1D_Total,�ɹ�������PR1D_UnitID,��λGUID����UnitDictName,��λ����PR1D_CurrencyTypeId,�ɹ�����GUID����CurrencyTypeDictName,�ɹ����֡���PR1D_POriginalPrice,�ɹ�ԭ�Ҽۣ���������" & _
    "��PR1D_PCurrencyPrice,�ɹ����Ҽۣ�����������PR1D_EstimateCost,Ԥ���ɱ�����PR1D_SCurrencyPrice,���Ʊ��Ҽۣ�����������PR1D_Discount,�ɹ��ۿۡ�" & _
    "��PR1D_OriginalAmount,�ɹ�ԭ�ҽ���PR1D_CurrencyAmount,�ɹ����ҽ���PR1D_Status,�ɹ���״̬GUID����StatusDictName,�ɹ���״̬����PR1D_SendDate,Ԥ�Ƴ������ڡ�" & _
    "��PR1D_Seq,��š���PR1D_RgUser,�����ˡ���PR1D_RgDt,����ʱ�䡿��PR1D_LmUser,����޸��ˡ���PR1D_LmDt,����޸�ʱ�䡿��PR1D_UptNo,�޸Ĵ�������PD0_SizeSUId,��Ӧ�̳���ID����PR1D_PD0_ProductId,��ƷID����PR1D_OrderDetailId,�ɹ�����ϸID����PR1D_PR1_OrderId,�ɹ������GUID����PD0_ColorSUId,��Ӧ����ɫID��"
End If

If TableName = "NewPODetailList" Then
    GetHeadMap = "��PR1D_CONO,���š���PR1D_DIVI,��ҵ�塿��SupplyId,��Ӧ�̱�š���PR1D_SupplierType,��Ӧ�����͡���ContractId,��ͬ��š���PR1D_PR1_OrderId,�ɹ������GUID��" & _
    "��POCode,�ɹ�����š���PR1D_OrderDetailId,�ɹ�����ϸID��" & _
    "��ProductCodeSU,��Ӧ�̿�š���PD0_ColorId,��ɫID����ColorSUIdDictName,��Ӧ����ɫ����PD0_ColorBSUId,��Ӧ����ɫ��ID����ColorBSUIdDictName,��Ӧ����ɫ�򡿡�SizeSUIdTypeDictName,��Ӧ�̳��롿��PR1D_PD0_SKUSU,��Ӧ��SKU����PR1D_PD0_ProductId,��ƷID��" & _
    "��PR1D_Total,�ɹ�������PR1D_UnitID,��λID����UnitDictName,��λ����PR1D_POriginalPrice,�ɹ�ԭ�Ҽۣ�����)����PR1D_SCurrencyPrice,���Ʊ��Ҽۡ�" & _
    "��PR1D_CurrencyAmount,�ɹ����ҽ���PR1D_Discount,�ɹ��ۿۡ���PR1D_SendDate,Ԥ�Ƴ������ڡ�" & _
    "��PR1D_Seq,��š���PR1D_RgUser,�����ˡ���PR1D_LmUser,����޸��ˡ�"
End If

If TableName = "DeliveryPlanList" Then
    GetHeadMap = "��PRAD_ArrivalPlanDetailId,�����ƻ�ID����PRA_ArrivalPlanId,�����ƻ���š���PR1D_PD0_ProductId,��ƷID����PD0_ProductCodeSU,��Ӧ�̿�š���PD0_Code,��š���UnitDictName,��λ����PR1_OrderId,�ɹ�����š���PR1D_OrderDetailId,�ɹ�����ϸID��" & _
    "��PR1D_POriginalPrice,�ɹ�ԭ�Ҽۡ���PR1D_PCurrencyPrice,�ɹ����Ҽۡ���PR1D_SCurrencyPrice,���Ƽۡ���PRAD_ArrivalDate,Ԥ�Ƶ������ڡ�" & _
    "��PR1_PurchaseTotal,�ɹ�������������PR1_PurchaseAmount,�ɹ��������PR1D_Total,�ɹ���������PRAD_ArrivalTotal,�ѵ���������PRAD_PlanTotal,�����ɼƻ���������PRAD_PlanArrival,���μƻ�������������PRAD_PlanArrivalAmount,���μƻ���������PRAD_TotalDiff,�������졿" & _
    "��PRAD_Status,״̬����PRAD_RgUser,�����ˡ���PRAD_RgDt,����ʱ�䡿��PRAD_LmUser,����޸��ˡ���PRAD_LmDt,����޸�ʱ�䡿"
End If
If TableName = "DeliveryPlan2List" Then
    GetHeadMap = "��PRA_ArrivalPlanId,�����ƻ�ID����PRA_ArrivalPlanCode,�����ƻ���š���PRA_PR1_OrderId,�ɹ���ID����PR1_OrderCode,�ɹ�����š���PRA_SU0_SupplierCode,��Ӧ�̱�š���PRA_PerchaseTotal,�ɹ���������PRA_ArrivalTotal,�ѵ���������PRA_PlanTotal,���μƻ�������������PRA_TotalDiff,�������졿��PRA_PerchaseAmount,�ɹ�����PRA_ArrivalAmount,�ѵ�����" & _
    "��PRA_PlanAmount,���μƻ���������PRA_AmountDiff,�����졿��StatusDictName,״̬����PRA_RgUser,�����ˡ���PRA_RgDt,����ʱ�䡿��PRA_LmUser,����޸��ˡ���PRA_LmDt,����޸�ʱ�䡿"
End If
If TableName = "DeliveryPlanMXList" Then
    GetHeadMap = "��PRAD_ArrivalPlanDetailId,�����ƻ���ϸID����PRAD_PRA_ArrivalPlanId,�����ƻ�����ID����PRAD_PD0_ProductId,��ƷID����PD0_ProductCodeSU,��Ӧ�̿�š���PD0_Code,��š���UnitDictName,��λ����PRAD_PR1D_OrderDetailId,�ɹ�����ϸID����PRAD_POriginalPrice,�ɹ�ԭ�Ҽۡ���PRAD_PCurrencyPrice,�ɹ����Ҽۡ���PRAD_SCurrencyPrice,���Ƽۡ���PRAD_ArrivalDate,Ԥ�Ƶ������ڡ�" & _
    "��PRAD_PerchaseTotal,�ɹ���������PRAD_ArrivalTotal,�ѵ���������PRAD_PlanTotal,�������ƻ���������PRAD_PlanArrival,���μƻ�������������PRAD_PlanArrivalAmount,���μƻ�������" & _
    "��PRAD_TotalDiff,�������졿��StatusDictName,״̬����PRAD_RgUser,�����ˡ���PRAD_RgDt,����ʱ�䡿��PRAD_LmUser,����޸��ˡ���PRAD_LmDt,����޸�ʱ�䡿"
End If
If TableName = "RecDetailsList" Then
    GetHeadMap = "��PD0_ProductCodeSU,��Ӧ��SKU����PD0_Code,SKU����PRBD_DeptID,���ID����PRAD_PlanArrival,�ƻ�������������PRBD_Total,�����ջ���������PRAD_UnitID,��λGUID����UnitDictName,��λ��" & _
    "��ColorSU_DictName,��Ӧ����ɫ����SizeSU_DictName,��Ӧ�̳��롿��Color_DictName,��ɫ����Size_DictName,���롿��PRAD_POriginalPrice,�ɹ�ԭ�Ҽۣ���������" & _
    "��PRAD_PCurrencyPrice,�ɹ����Ҽۣ�����������PRAD_SCurrencyPrice,���Ƽۡ�" & _
    "��PRA_ArrivalPlanId,�����ƻ�ID����PRAD_PD0_ProductId,��ƷID����PRAD_ArrivalPlanDetailId,�����ƻ���ϸID����PRB_ReceiptId1,�ջ�������GUID��" & _
    "��PRB_TypeID,�ջ������͡���PRA_PlanTotal,�ƻ�����������������PRA_PlanAmount,�ƻ������������PRA_SU0_SupplierId,��Ӧ�̱�š�"
End If

If TableName = "RecDetailsMainList" Then
    GetHeadMap = "��PRA_CONO,���š���PRA_DIVI,��ҵ�塿��PRB_PRA_ArrivalPlanId,�����ƻ�ID����PRA_ArrivalPlanCode,�����ƻ���š�" & _
    "��PRB_ReceiptId,�ջ���ID����PRB_ReceiptCode,�ջ�����š���PRB_TypeId,�ջ������͡���PRB_PlanTotal,�ƻ�����������" & _
    "��PRB_ReceiptTotal,�˴��ջ���������PRB_PlanAmount,�ƻ���������PRB_ReceiptAmount,�˴��ջ���" & _
    "��PRB_Status,״̬Id����StatusDictName,״̬����PRB_RgUser,�����ˡ���PRB_RgDt,����ʱ�䡿��PRB_LmUser,����޸��ˡ���PRB_LmDt,����޸�ʱ�䡿" & _
    "��TypeIdDictName,�ջ������Ͷ��ա�"
End If

If TableName = "ReceiptMDList" Then
    GetHeadMap = "��PRBD_CONO,���š���PRBD_DIVI,��ҵ�塿��PRBD_ReceiveDetailId,�ջ���ID����PRBD_PRB_ReceiveId,�ջ�����š���PRBD_PRAD_ArrivalPlanDetailId,�����ƻ���ϸID����PRBD_PD0_ProductId,��ƷID��" & _
    "��UnitDictName,��λ����PRBD_UnitID,��λID����PRBD_POriginalPrice,�ɹ�ԭ�Ҽۡ���PRBD_PCurrencyPrice,�ɹ����Ҽۡ���PRBD_SCurrencyPrice,���Ƽۡ���PRBD_DeptID,���ID����PRBD_StorageId,��λ����PRBD_PlanTotal,�ƻ�����������" & _
    "��PRBD_Total,�ջ���������PRBD_POSWHNumber,POS_��ⵥ�š���PRBD_Status,״̬Id����PRBD_RgUser,�����ˡ���PRBD_RgDt,����ʱ�䡿" & _
    "��PRBD_LmUser,����޸��ˡ���PRBD_LmDt,����޸�ʱ�䡿��PD0_ProductCodeSU,��Ӧ�̿�š���PD0_Code,��š�"
End If

If TableName = "ReturnBillMainList" Then
    GetHeadMap = "��PRC_CONO,���š���PRC_DIVI,��ҵ�塿��PRC_ReturnId,�˻�������ID����PRC_ReturnCode,�˻�����š���PRC_PR1_OrderId,�ɹ���ID��" & _
    "��PRC_PR1_OrderCode,�ɹ�����š���PRC_SU0_SupplierId,��Ӧ��ID����PRC_Total,�˻���������PRC_Amount,�˻��ܽ�" & _
    "��PRC_Status,״̬ID����StatusDictName,״̬����PRC_RgUser,�����ˡ���PRC_RgDt,����ʱ�䡿��PRC_LmUser,����޸��ˡ���PRC_LmDt,����޸�ʱ�䡿"
End If

If TableName = "ReturnBillDetailsList" Then
    GetHeadMap = "��PRCD_CONO,���š���PRCD_DIVI,��ҵ�塿��PRCD_ReturnDetailId,�˻�����ϸID����PRCD_PRC_ReturnId,�˻�������ID����PRCD_PRC_ReturnCode,�˻�����š�" & _
    "��PRCD_PR1D_OrderDetailId,�ɹ�����ϸID����PRCD_PD0_ProductId,��ƷID����PRCD_UnitID,��λ����PRCD_POriginalPrice,�ɹ�ԭ�Ҽۡ���PRCD_PCurrencyPrice,�ɹ����Ҽۡ�" & _
    "��PRCD_SCurrencyPrice,���Ƽۡ���PRCD_RetDeptID,�˻���ID����PRCD_POSRetCode,POS_�˻����š���PRCD_Total,�˻���������PRCD_Amount,�˻�����PRCD_Reson,�˻�ԭ��" & _
    "��PRCD_Status,״̬ID����PRCD_RgUser,�����ˡ���PRCD_RgDt,����ʱ�䡿��PRCD_LmUser,����޸��ˡ���PRCD_LmDt,����޸�ʱ�䡿��PD0_ProductCodeSU,��Ӧ�̿�š�" & _
    "��PD0_Code,��š���UnitDictName,��λ����SizeSU_DictName,��Ӧ�̳��롿��Size_DictName,���롿" & _
    "��ColorSU_DictName,��Ӧ����ɫ����Color_DictName,��ɫ��"
End If

If TableName = "ReturnBillDList" Then
    GetHeadMap = "��PR1_CONO,���š���PR1_DIVI,��ҵ�塿" & _
    "��PRCD_PRC_ReturnCode,�˻�����š���PRCD_POSRetCode,POS_�˻����š���PR1_OrderCode,�ɹ��������š���PD0_ProductCodeSU,��Ӧ�̿�š���PD0_Code,��š���PRCD_Total,�˻�������" & _
    "��PRCD_Amount,�˻�����PRCD_Reson,�˻�ԭ�򡿡�ColorSU_DictName,��Ӧ����ɫ����Color_DictName,��ɫ����SizeSU_DictName,��Ӧ�̳��롿��Size_DictName,���롿" & _
    "��UnitDictName,��λ����PR1D_POriginalPrice,�ɹ�ԭ�Ҽۡ���PR1D_PCurrencyPrice,�ɹ����Ҽۡ���PR1D_SCurrencyPrice,���Ƽۡ�" & _
    "��PRBD_RgUser,�����ˡ���PRBD_RgDt,�������ڡ���PRBD_LmUser,����޸��ˡ���PRBD_LmDt,����޸�ʱ�䡿" & _
    "��PR1D_PD0_ProductId,��ƷID����PR1_SU0_SupplierId,��Ӧ��GUID����PR1D_UnitID,��λID����PRCD_ReturnDetailId,�˻�����ϸID����PRCD_PRC_ReturnId,�˻�������ID����PR1_OrderId,�ɹ�������ID��" & _
    "��PR1D_OrderDetailId,�ɹ�����ϸID����PRCD_RetDeptID,�˻���ID����PRBD_Status,״̬ID��"
End If
End Function
Function GetEditColumnsName(TableName As String) As String

If TableName = "SupplyList" Then
    GetEditColumnsName = "����Ӧ�̷��ࡿ����Ӧ�����ơ�����ϵ�ˡ�����ϵ�绰������ַ���������С��������˻��������е�ַ��������SWIFT�š����½��ˡ�"
End If

If TableName = "LXRList" Then
    GetEditColumnsName = "����ϵ����������ְ�񡿡��绰1�����绰2�������䡿����ϵ��״̬��"
End If
If TableName = "BrandList" Then
    GetEditColumnsName = "��Ʒ�Ʊ�š���Ʒ�����ơ���Ʒ�����ڹ��ҡ���Ŀ��Ⱥ�塿��Ʒ�Ʒ��"
End If
If TableName = "ContractList" Then
    GetEditColumnsName = "����ͬ˵��������ͬ��ʼʱ�䡿����ͬ��ֹʱ�䡿"
End If
If TableName = "ContractNewList" Then
    GetEditColumnsName = "����Ӧ�̱�š�����ͬ������ͬ˵��������ͬ��ʼʱ�䡿����ͬ��ֹʱ�䡿"
End If
If TableName = "ProductList" Then
    GetEditColumnsName = "��Ʒ�����ơ�����Ӧ�̿�š�����Ӧ����ɫ��" & _
    "����Ӧ����ɫ���򣩡�����Ӧ�̳��롿����š���Ʒ��������ɫ�������롿����ݡ������ڡ�����ʽ���ࡿ����ʽ���ࡿ����ʽС�ࡿ�����ء�" & _
    "���ɷ֡����ȼ�����ִ�б�׼������ȫ������𡿡��ɹ��ۡ������Ƽۡ�����λ�����Ƿ��ӡ��"
End If
If TableName = "PayNewList" Then
    GetEditColumnsName = "������ˮ���š����Ƿ��Ѹ��"
End If
If TableName = "PayDHList" Then
    GetEditColumnsName = "������ˮ���š����Ƿ��Ѹ��"
End If
If TableName = "PayTHList" Then
    GetEditColumnsName = "������ˮ���š����Ƿ��Ѹ��"
End If
If TableName = "DeliveryPlanList" Then
    GetEditColumnsName = "�����μƻ�����������"
End If
If TableName = "DeliveryPlanMXList" Then
    GetEditColumnsName = "�����μƻ�����������"
End If
End Function





