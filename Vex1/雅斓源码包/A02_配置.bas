Attribute VB_Name = "A02_配置"
Function GetPwd() As String
'获取工作表、工作薄密码
GetPwd = "3D42CE79E1AB674DB01DCEBE41D4C35A"
End Function
Function LoginAction(Usr As String)
Login.Hide
SetCellValueByRange "供应商", "A1", "用户名"
SetCellValueByRange "供应商", "B1", Usr
ClearLog
SetAdminPower
Sheets("供应商").Activate
Sheets("供应商").Range("C7").Select
End Function
Function GetWsrrUrl() As String
'WS服务器的地址
GetWsrrUrl = "http://172.16.205.57:8080/wsrr.asmx/CallByXML" '测试地址
'GetWsrrUrl = "http://192.168.0.37/wsrr.asmx/CallByXML" '正式地址
End Function
Function GetLoginSrv() As String
    '指定登录的Srv,，比如SSO、PLMFZ
    GetLoginSrv = "SSO"
End Function
Function GetUsr() As String
'获取当前用户
GetUsr = Sheets("供应商").Range("B1").Value
End Function
Function GetAppName() As String
'设置APPName
GetAppName = "GL_ERP"
End Function
Function GetSessionWin() As String
GetSessionWin = "华之毅PLMTOOL_SID_"
End Function
Function GetUrlPath()
GetUrlPath = "/1002B_ITDCTool.aspx?sid="
End Function
Function SetAdminPower()
'设置管理员权限
If GetUsr = "刘洪" Then
    AddEditRange "供应商", "C7"
    ProtectSheet "供应商", False
End If
End Function
Function LoginInitialize()
SetCellValueByRange "供应商", "B1", ""
'Login.AppName.Caption = "雅澜ERP"
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
    ProtectSheet "供应商", False
    ClearTable "SupplyList"
    ClearTable "BrandList"
    ClearTable "ProductList"
    ClearTable "OrderList"
    ClearTable "ContractList"
    ClearTable "PayList"
'    Sheets("供应商").CommandButton1.Visible = True
'    Sheets("供应商").CommandButton2.Visible = True
''    Sheets("供应商").CommandButton8.Visible = False
''    Sheets("供应商").CommandButton3.Visible = False
''    Sheets("供应商").CommandButton4.Visible = False
''    Sheets("供应商").CommandButton7.Visible = False
    HideSheet "CONF", True
    HideSheet "TEMP", True
    HideSheet "Main", True
    HideSheet "TEMP1", True
    HideSheet "LOG", True
    ProtectSheet "供应商", True
ClearConf
ThisWorkbook.Protect GetPwd
For Each st In ThisWorkbook.Sheets
    If UCase(st.Name) <> "MAIN" Then ProtectSheet st.Name, True
Next
End Function

Function GetHeadMap(TableName As String) As String

If TableName = "SupplyList" Then
    GetHeadMap = "【SU0_SupplierCode,供应商编号】【SU0_SupplierName,供应商名称】【SU0_SupplierType,SU0_SupplierType】【DC0_DictName1,供应商分类】 " & _
    "【SU0_Contact,联系人】【SU0_Phone,联系电话】【SU0_Address,地址】【SU0_Bank,开户行】" & _
    "【SU0_BankAccount,银行账户】【SU0_BankAddress,银行地址】【SU0_BankSwift,银行SWIFT号】SU0_Status【SU0_Status,状态】【SU0_RgUser,新建人】【SU0_LmUser,最后修改人】【SU0_UptNo,修改时间】"
End If
If TableName = "ProductLoadList" Then
    GetHeadMap = "【PD0_PicPath,款图】【PD0_ProductId,商品ID】【PD0_SUO_SupplierId,PD0_SUO_SupplierId】【SU0_SupplierCode,供应商编号】【PD0_BD0_BrandId,PD0_BD0_BrandId】【BD0_BrandName,品牌名称】【PD0_Lvl0,品名】【PD0_ProductCodeSU,供应商款号】【PD0_ColorSUId,供应商颜色】" & _
    "【ColorBSUName,供应商颜色（简）】【PD0_SizeSUId,供应商尺码】【PD0_SKUSU,供应商SKU】【PD0_Code,款号】【PD0_ColorId,PD0_ColorId】【ColorDictName,颜色】 " & _
    "【PD0_SizeId,PD0_SizeId】【SizeDictName,尺码】【PD0_SKU,SKU】【PD0_UnitId,单位】【PD0_PurchasePrice,采购价】【PD0_SalePrice,吊牌价】【PD0_YearId,PD0_YearId】【YearDictName,年份】" & _
    "【PD0_SeasonId,季节】【PD0_Lvl1,款式种类】【PD0_Lvl2,款式大类】【PD0_Lvl3,款式小类】" & _
    "【PD0_SourceCountry,产地】【PD0_Composition,成分】【PD0_QulityLevel,等级】【PD0_StandardId,PD0_StandardId】【StandardDictName,执行标准】【PD0_SecurityLevelId,PD0_SecurityLevelId】【SecurityLevelDictName,安全技术类别】【PD0_IsPrinted,是否打印】【PD0_Status,状态】" & _
    "【PD0_RgUser,创建人】【PD0_RgDt,创建时间】【PD0_LmUser,最后修改人】【PD0_LmDt,最后修改时间】【PD0_UptNo,修改次数】"
End If
If TableName = "SupplyBASEList" Then
    GetHeadMap = "【SU0_SupplierCode,供应商编号】"
End If
If TableName = "BrandList" Then
    GetHeadMap = "【SU0_SupplierCode,供应商编号】【BD0_BrandCode,品牌编号】【BD0_BrandName,品牌名称】【BD0_CountryId,品牌所在国家】【CusGrpDictName,目标群体】【StyleDictName,品牌风格】" & _
    "【BD0_RgUser,创建人】【BD0_RgDt,创建时间】【BD0_LmUser,最后修改人】【BD0_LmDt,最后修改时间】"
End If
If TableName = "BrandBASEList" Then
    GetHeadMap = "【BD0_BrandCode,品牌编号】【BD0_SU0_BrandCode,供应商编号】【BD0_BrandName,品牌名称】【BD0_CountryId,品牌所在国家】 " & _
    "【BD0_StyleId,品牌风格】【BD0_CusGrpId,目标群体】【BD0_RgUser,新建人】"
End If
If TableName = "ContractList" Then
    GetHeadMap = "【PR0_CONO,集团】【PR0_DIVI,事业体】【PR0_ContractCode,合同编号】【SU0_SupplierCode,供应商编号】【StatusDictName,合同状态】" & _
    "【PR0_Amount,合同金额】【CurrencyDictName,结算币种】【AccountDictName,结算方式】【PR0_PrePayRate,预付款百分比】【PR0_Description,合同说明】" & _
    "【PR0_StartDate,合同开始时间】【PR0_EndDate,合同截止时间】【PR0_ECopyPath,合同扫描件】" & _
    "【WFT_NODE1,总监审核】【WFP_AuditTime1,总监审核时间】【DC0_DICTNAME1,总监审核状态】" & _
    "【WFT_NODE2,法务审核】【WFP_AuditTime2,法务审核时间】【DC0_DICTNAME2,法务审核状态】【WFT_NODE3,财务审核】【WFP_AuditTime3,财务审核时间】【DC0_DICTNAME3,财务审核状态】" & _
    "【WFT_NODE4,副总裁审核】【WFP_AuditTime4,副总裁审核时间】【DC0_DICTNAME4,副总裁审核状态】【WFT_NODE5,财务水单】【WFP_AuditTime5,财务水单时间】【DC0_DICTNAME5,财务水单状态】" & _
    "【PR0_RgUser,创建人】【PR0_RgDt,创建时间】【PR0_LmUser,最后修改人】【PR0_LmDt,最后修改时间】【PR0_UptNo,修改次数】【PR0_ContractId,合同ID】【PR0_SU0_SupplierId,供应商编号ID】" & _
    "【PR0_Status,状态ID】【PR0_CurrencyId,结算币种ID】【PR0_SettleAccount,结算方式ID】"
End If
If TableName = "ContractNewList" Then
    GetHeadMap = "【PR0_CONO,集团】【PR0_DIVI,事业体】【PR0_ContractCode,合同编号】" & _
    "【SU0_SupplierCode,供应商编号】【StatusDictName,合同状态】【PR0_PrePayRate,预付款百分比】【PR0_CurrencyId,结算币种ID】" & _
    "【CurrencyDictName,结算币种】【PR0_SettleAccount,结算方式ID】【AccountDictName,结算方式】【PR0_Amount,合同金额】【PR0_Description,合同说明】" & _
    "【PR0_ECopyPath,合同扫描件】【PR0_StartDate,合同开始时间】【PR0_EndDate,合同截止时间】" & _
    "【PR0_RgUser,创建人】【PR0_LmUser,最后修改人】【PR0_ContractId,合同编号ID】【PR0_SU0_SupplierId,供应商ID】【PR0_Status,状态ID】【PR0_CurrencyId,结算币种ID】"
End If
If TableName = "NewPurchaseOrderList" Then
    GetHeadMap = "【PR1_OrderCode,采购单编号】" & _
    "【OrderTypeDictName,采购类型】【PR0_ContractCode,合同编号】【SU0_SupplierCode,供应商编号】【BD0_BrandName,品牌名称】【PR1_PurchaseTotal,采购总数】【PR1_SupplierType,供应商类型】" & _
    "【PR1_Discount,采购折扣】【PR1_ExchangeRate,实时汇率】【CurrencyTypeDictName,币种】【PR1_PurchaseAmount,采购本币价】【PR1_POriginalAmount,采购原币价】【StatusDictName,采购单状态】" & _
    "【PR1_Tariff,关税】【PR1_VAT,增值税】【PR1_Freight,运费】【PR1_Times,倍率】" & _
    "【PR1_RgUser,创建人】【PR1_LmUser,最后修改人】【PR1_Status,状态ID】【PR1_OrderId,采购单ID】【PR1_OrderTypeId,采购单类型ID】【PR1_PR0_ContractId,合同编号ID】【PR1_SU0_SupplierId,供应商编号ID】【PR1_BD0_BrandId,品牌编号ID】"
End If

If TableName = "PurchaseOrderList" Then
    GetHeadMap = "【PR1_CONO,集团】【PR1_DIVI,事业体】【PR1_OrderId,采购单ID】【PR1_OrderCode,采购单编号】" & _
    "【PR1_OrderTypeId,采购单类型ID】【OrderTypeDictName,采购类型】【PR1_PR0_ContractId,合同编号ID】【PR0_ContractCode,合同编号】" & _
    "【PR1_SU0_SupplierId,供应商编号ID】【SU0_SupplierCode,供应商编号】【SU0_SupplierType,供应商类型ID】【PR1_BD0_BrandId,品牌编号ID】" & _
    "【BD0_BrandName,品牌名称】【PR1_PurchaseTotal,采购总数】【PR1D_UnitID,单位】" & _
    "【CurrencyTypeDictName,币种】【PR1_PurchaseAmount,采购本币价】【PR1_POriginalAmount,采购原币价】【PR1_Discount,折扣】【PR1_ExchangeRate,实时汇率】" & _
    "【PR1_Tariff,关税】【PR1_VAT,增值税】【PR1_Freight,运费】【PR1_Times,倍率】【PR1_CurrencyTypeId,币种ID】【PR1_SupplierType,供应商类型】" & _
    "【PR1_Status,状态ID】【StatusDictName,采购单状态】【PR1_RgUser,创建人】【PR1_RgDt,创建时间】【PR1_LmUser,最后修改人】【PR1_LmDt,最后修改时间】【PR1_UptNo,修改次数】"
End If

If TableName = "PayList" Then
    GetHeadMap = "【TypeDictName,付款单类型】【FNP_PayApplyId,申请单ID】【FNP_PayApplyCode,申请单编号】【SU0_SupplierCode,供应商编号】【SU0_Bank,开户行】【SU0_BankAccount,银行账户】【SU0_BankSwift,银行SWIFT号】【FNP_SU0_SupplierId,供应商GUID】【FNP_Type,申请单类型】【FNP_BankReceipt,财务水单号】【FNP_PayAmount,付款总金额】【FNP_PayRate,付款百分比】" & _
    "【FNP_DuesAmount,应付款金额】【FNP_IsPayed,是否已付款】【StatusDictName,状态】【PR0_RgUser,创建人】【PR0_RgDt,创建时间】【PR0_LmUser,最后修改人】【PR0_LmDt,最后修改时间】【PR0_UptNo,更改次数】"
End If
If TableName = "PayNewList" Then
    GetHeadMap = "【FNP_PayApplyId,申请单ID】【FNP_PayApplyCode,申请单编号】【SU0_SupplierCode,供应商编号】【SU0_Bank,开户行】【SU0_BankAccount,银行账户】【SU0_BankSwift,银行SWIFT号】" & _
    "【PR0_ContractId,合同GUID】【SU0_SupplierId,供应商GUID】【FNP_Type,申请单类型】【FNP_BankReceipt,财务水单号】【FNP_PayAmount,付款总金额】【FNP_PayRate,付款百分比】【FNP_DuesAmount,应付款金额】【FNP_IsPayed,是否已付款】" & _
    "【FNP_RgUser,创建人】【FNP_RgDt,创建时间】【FNP_LmUser,最后修改人】【FNP_LmDt,最后修改时间】【FNP_UptNo,更改次数】"
End If
If TableName = "PayMXList" Then
    GetHeadMap = "【FNPD_PayApplyDetailId,付款申请单明细ID】【FNPD_FNP_PayApplyId,申请单ID】【FNPD_FNP_PayApplyCode,申请单编号】【FNPD_RefBillDetailID,单据ID】" & _
    "【PR0_RgUser,创建人】【PR0_RgDt,创建时间】【PR0_LmUser,最后修改人】【PR0_LmDt,最后修改时间】【PR0_ContractCode,合同编号】【PR0_Amount,合同金额】【PR0_PrePayRate,预付款百分比】【PR0_Description,合同备注】【PR0_SettleAccount,结算方式】" & _
    "【TypeDictName,单据类型】【PR1_PurchaseTotal,采购数量】【StatusDictName,状态】【CurrencyDictName,结算币种】"
End If
If TableName = "PayDHList" Then
    GetHeadMap = "【FNP_PayApplyId,申请单ID】【FNP_PayApplyCode,申请单编号】【SU0_SupplierCode,供应商编号】【SU0_Bank,开户行】【SU0_BankAccount,银行账户】【SU0_BankSwift,银行SWIFT号】【PRA_ArrivalPlanId,到货计划GUID】【SU0_SupplierId,供应商GUID】【FNP_Type,申请单类型】【FNP_BankReceipt,财务水单号】【FNP_PayAmount,付款总金额】【FNP_PayRate,付款百分比】" & _
    "【FNP_DuesAmount,应付款金额】【FNP_IsPayed,是否已付款】【FNP_RgUser,创建人】【FNP_RgDt,创建时间】【FNP_LmUser,最后修改人】【FNP_LmDt,最后修改时间】【FNP_UptNo,修改次数】"
End If
If TableName = "PayMXList" Then
    GetHeadMap = "【FNPD_PayApplyDetailId,付款申请单明细ID】【FNPD_FNP_PayApplyId,申请单ID】【FNPD_FNP_PayApplyCode,申请单编号】【FNPD_RefBillDetailID,单据ID】" & _
    "【PR0_RgUser,创建人】【PR0_RgDt,创建时间】【PR0_LmUser,最后修改人】【PR0_LmDt,最后修改时间】【PR0_ContractCode,合同编号】【PR0_Amount,合同金额】【PR0_PrePayRate,预付款百分比】【PR0_Description,合同备注】【PR0_SettleAccount,结算方式】" & _
    "【TypeDictName,单据类型】【PR1_PurchaseTotal,采购数量】【StatusDictName,状态】【CurrencyDictName,结算币种】"
End If
If TableName = "PayDHMXList" Then
    GetHeadMap = "【FNPD_PayApplyDetailId,付款申请单明细ID】【FNPD_FNP_PayApplyId,申请单ID】【FNPD_FNP_PayApplyCode,申请单编号】【FNPD_RefBillDetailID,单据ID】" & _
    "【CurrencyDictName,采购币种】【PRA_ArrivalPlanCode,到货计划编号】【PRA_PlanAmount,采购金额】【PRA_PlanTotal,采购数量】【PR0_ContractCode,合同编号】" & _
    "【TypeDictName,单据类型】【StatusDictName,状态】【PR0_RgUser,创建人】【PR0_RgDt,创建时间】【PR0_LmUser,最后修改人】【PR0_LmDt,最后修改时间】"
End If
If TableName = "PayTHList" Then
    GetHeadMap = "【FNP_PayApplyId,申请单ID】【FNP_PayApplyCode,申请单编号】【PRC_ReturnId,退货单主表ID】【SU0_SupplierId,供应商ID】【FNP_Type,申请单类型】【SU0_SupplierCode,供应商编号】【SU0_Bank,开户行】【SU0_BankAccount,银行账户】【SU0_BankSwift,银行SWIFT号】" & _
    "【FNP_BankReceipt,财务水单号】【FNP_PayAmount,付款总金额】【FNP_PayRate,付款百分比】【FNP_DuesAmount,应付款金额】【FNP_IsPayed,是否已付款】【FNP_RgUser,创建人】【FNP_RgDt,创建时间】【FNP_LmUser,最后修改人】【FNP_LmDt,最后修改时间】【FNP_UptNo,修改次数】"
End If
If TableName = "PayTHMXList" Then
    GetHeadMap = "【FNPD_PayApplyDetailId,付款申请单明细ID】【FNPD_FNP_PayApplyId,申请单ID】【FNPD_FNP_PayApplyCode,申请单编号】【FNPD_RefBillDetailID,单据ID】" & _
    "【PR0_ContractCode,合同编号】【PRC_ReturnCode,退货单编号】【PRC_Amount,退货金额】【PRC_Total,退货数量】" & _
    "【TypeDictName,单据类型】【StatusDictName,状态】【PR0_RgUser,创建人】【PR0_RgDt,创建时间】【PR0_LmUser,最后修改人】【PR0_LmDt,最后修改时间】"
End If
If TableName = "PODetailList" Then
    GetHeadMap = "【PR1D_CONO,集团】【PR1D_DIVI,事业体】【PR1_OrderCode,采购单编号】【SU0_SupplierCode,供应商编号】【PD0_ProductCodeSU,供应商款号】【SU0_SupplierType,供应商类型】" & _
    "【ColorSUIdDictName,供应商颜色】【ColorTypeDictName,颜色类型】" & _
    "【ColorBSUIdDictName,供应商颜色简】【SizeSUIdTypeDictName,供应商尺码】【PR1D_PD0_SKUSU,供应商SKU】【PR1D_PD0_SKU,SKU】" & _
    "【PR1D_Total,采购数】【PR1D_UnitID,单位GUID】【UnitDictName,单位】【PR1D_CurrencyTypeId,采购币种GUID】【CurrencyTypeDictName,采购币种】【PR1D_POriginalPrice,采购原币价（单件）】" & _
    "【PR1D_PCurrencyPrice,采购本币价（单件）】【PR1D_EstimateCost,预估成本】【PR1D_SCurrencyPrice,吊牌本币价（单件）】【PR1D_Discount,采购折扣】" & _
    "【PR1D_OriginalAmount,采购原币金额】【PR1D_CurrencyAmount,采购本币金额】【PR1D_Status,采购单状态GUID】【StatusDictName,采购单状态】【PR1D_SendDate,预计出货日期】" & _
    "【PR1D_Seq,序号】【PR1D_RgUser,创建人】【PR1D_RgDt,创建时间】【PR1D_LmUser,最后修改人】【PR1D_LmDt,最后修改时间】【PR1D_UptNo,修改次数】【PD0_SizeSUId,供应商尺码ID】【PR1D_PD0_ProductId,商品ID】【PR1D_OrderDetailId,采购单明细ID】【PR1D_PR1_OrderId,采购单编号GUID】【PD0_ColorSUId,供应商颜色ID】"
End If

If TableName = "NewPODetailList" Then
    GetHeadMap = "【PR1D_CONO,集团】【PR1D_DIVI,事业体】【SupplyId,供应商编号】【PR1D_SupplierType,供应商类型】【ContractId,合同编号】【PR1D_PR1_OrderId,采购单编号GUID】" & _
    "【POCode,采购单编号】【PR1D_OrderDetailId,采购单明细ID】" & _
    "【ProductCodeSU,供应商款号】【PD0_ColorId,颜色ID】【ColorSUIdDictName,供应商颜色】【PD0_ColorBSUId,供应商颜色简ID】【ColorBSUIdDictName,供应商颜色简】【SizeSUIdTypeDictName,供应商尺码】【PR1D_PD0_SKUSU,供应商SKU】【PR1D_PD0_ProductId,商品ID】" & _
    "【PR1D_Total,采购数】【PR1D_UnitID,单位ID】【UnitDictName,单位】【PR1D_POriginalPrice,采购原币价（单件)】【PR1D_SCurrencyPrice,吊牌本币价】" & _
    "【PR1D_CurrencyAmount,采购本币金额】【PR1D_Discount,采购折扣】【PR1D_SendDate,预计出货日期】" & _
    "【PR1D_Seq,序号】【PR1D_RgUser,创建人】【PR1D_LmUser,最后修改人】"
End If

If TableName = "DeliveryPlanList" Then
    GetHeadMap = "【PRAD_ArrivalPlanDetailId,到货计划ID】【PRA_ArrivalPlanId,到货计划编号】【PR1D_PD0_ProductId,商品ID】【PD0_ProductCodeSU,供应商款号】【PD0_Code,款号】【UnitDictName,单位】【PR1_OrderId,采购单编号】【PR1D_OrderDetailId,采购单明细ID】" & _
    "【PR1D_POriginalPrice,采购原币价】【PR1D_PCurrencyPrice,采购本币价】【PR1D_SCurrencyPrice,吊牌价】【PRAD_ArrivalDate,预计到货日期】" & _
    "【PR1_PurchaseTotal,采购主表总数】【PR1_PurchaseAmount,采购主表金额】【PR1D_Total,采购总数】【PRAD_ArrivalTotal,已到数量】【PRAD_PlanTotal,已生成计划数量】【PRAD_PlanArrival,本次计划到货数量】【PRAD_PlanArrivalAmount,本次计划到货金额】【PRAD_TotalDiff,数量差异】" & _
    "【PRAD_Status,状态】【PRAD_RgUser,创建人】【PRAD_RgDt,创建时间】【PRAD_LmUser,最后修改人】【PRAD_LmDt,最后修改时间】"
End If
If TableName = "DeliveryPlan2List" Then
    GetHeadMap = "【PRA_ArrivalPlanId,到货计划ID】【PRA_ArrivalPlanCode,到货计划编号】【PRA_PR1_OrderId,采购单ID】【PR1_OrderCode,采购单编号】【PRA_SU0_SupplierCode,供应商编号】【PRA_PerchaseTotal,采购总数】【PRA_ArrivalTotal,已到数量】【PRA_PlanTotal,本次计划到货数量】【PRA_TotalDiff,数量差异】【PRA_PerchaseAmount,采购金额】【PRA_ArrivalAmount,已到货金额】" & _
    "【PRA_PlanAmount,本次计划到货金额】【PRA_AmountDiff,金额差异】【StatusDictName,状态】【PRA_RgUser,创建人】【PRA_RgDt,创建时间】【PRA_LmUser,最后修改人】【PRA_LmDt,最后修改时间】"
End If
If TableName = "DeliveryPlanMXList" Then
    GetHeadMap = "【PRAD_ArrivalPlanDetailId,到货计划明细ID】【PRAD_PRA_ArrivalPlanId,到货计划主表ID】【PRAD_PD0_ProductId,商品ID】【PD0_ProductCodeSU,供应商款号】【PD0_Code,款号】【UnitDictName,单位】【PRAD_PR1D_OrderDetailId,采购单明细ID】【PRAD_POriginalPrice,采购原币价】【PRAD_PCurrencyPrice,采购本币价】【PRAD_SCurrencyPrice,吊牌价】【PRAD_ArrivalDate,预计到货日期】" & _
    "【PRAD_PerchaseTotal,采购总数】【PRAD_ArrivalTotal,已到数量】【PRAD_PlanTotal,已生产计划数量】【PRAD_PlanArrival,本次计划到货数量】【PRAD_PlanArrivalAmount,本次计划到货金额】" & _
    "【PRAD_TotalDiff,数量差异】【StatusDictName,状态】【PRAD_RgUser,创建人】【PRAD_RgDt,创建时间】【PRAD_LmUser,最后修改人】【PRAD_LmDt,最后修改时间】"
End If
If TableName = "RecDetailsList" Then
    GetHeadMap = "【PD0_ProductCodeSU,供应商SKU】【PD0_Code,SKU】【PRBD_DeptID,入仓ID】【PRAD_PlanArrival,计划到货数量】【PRBD_Total,本次收货数量】【PRAD_UnitID,单位GUID】【UnitDictName,单位】" & _
    "【ColorSU_DictName,供应商颜色】【SizeSU_DictName,供应商尺码】【Color_DictName,颜色】【Size_DictName,尺码】【PRAD_POriginalPrice,采购原币价（单件）】" & _
    "【PRAD_PCurrencyPrice,采购本币价（单件）】【PRAD_SCurrencyPrice,吊牌价】" & _
    "【PRA_ArrivalPlanId,到货计划ID】【PRAD_PD0_ProductId,商品ID】【PRAD_ArrivalPlanDetailId,到货计划明细ID】【PRB_ReceiptId1,收货单主表GUID】" & _
    "【PRB_TypeID,收货单类型】【PRA_PlanTotal,计划到货主表数量】【PRA_PlanAmount,计划到货主表金额】【PRA_SU0_SupplierId,供应商编号】"
End If

If TableName = "RecDetailsMainList" Then
    GetHeadMap = "【PRA_CONO,集团】【PRA_DIVI,事业体】【PRB_PRA_ArrivalPlanId,到货计划ID】【PRA_ArrivalPlanCode,到货计划编号】" & _
    "【PRB_ReceiptId,收货单ID】【PRB_ReceiptCode,收货单编号】【PRB_TypeId,收货单类型】【PRB_PlanTotal,计划到货数量】" & _
    "【PRB_ReceiptTotal,此次收货数量】【PRB_PlanAmount,计划到货金额】【PRB_ReceiptAmount,此次收货金额】" & _
    "【PRB_Status,状态Id】【StatusDictName,状态】【PRB_RgUser,创建人】【PRB_RgDt,创建时间】【PRB_LmUser,最后修改人】【PRB_LmDt,最后修改时间】" & _
    "【TypeIdDictName,收货单类型对照】"
End If

If TableName = "ReceiptMDList" Then
    GetHeadMap = "【PRBD_CONO,集团】【PRBD_DIVI,事业体】【PRBD_ReceiveDetailId,收货单ID】【PRBD_PRB_ReceiveId,收货单编号】【PRBD_PRAD_ArrivalPlanDetailId,到货计划明细ID】【PRBD_PD0_ProductId,商品ID】" & _
    "【UnitDictName,单位】【PRBD_UnitID,单位ID】【PRBD_POriginalPrice,采购原币价】【PRBD_PCurrencyPrice,采购本币价】【PRBD_SCurrencyPrice,吊牌价】【PRBD_DeptID,入仓ID】【PRBD_StorageId,储位】【PRBD_PlanTotal,计划到货数量】" & _
    "【PRBD_Total,收货数量】【PRBD_POSWHNumber,POS_入库单号】【PRBD_Status,状态Id】【PRBD_RgUser,创建人】【PRBD_RgDt,创建时间】" & _
    "【PRBD_LmUser,最后修改人】【PRBD_LmDt,最后修改时间】【PD0_ProductCodeSU,供应商款号】【PD0_Code,款号】"
End If

If TableName = "ReturnBillMainList" Then
    GetHeadMap = "【PRC_CONO,集团】【PRC_DIVI,事业体】【PRC_ReturnId,退货单主表ID】【PRC_ReturnCode,退货单编号】【PRC_PR1_OrderId,采购单ID】" & _
    "【PRC_PR1_OrderCode,采购单编号】【PRC_SU0_SupplierId,供应商ID】【PRC_Total,退货总数】【PRC_Amount,退货总金额】" & _
    "【PRC_Status,状态ID】【StatusDictName,状态】【PRC_RgUser,创建人】【PRC_RgDt,创建时间】【PRC_LmUser,最后修改人】【PRC_LmDt,最后修改时间】"
End If

If TableName = "ReturnBillDetailsList" Then
    GetHeadMap = "【PRCD_CONO,集团】【PRCD_DIVI,事业体】【PRCD_ReturnDetailId,退货单明细ID】【PRCD_PRC_ReturnId,退货单主表ID】【PRCD_PRC_ReturnCode,退货单编号】" & _
    "【PRCD_PR1D_OrderDetailId,采购单明细ID】【PRCD_PD0_ProductId,商品ID】【PRCD_UnitID,单位】【PRCD_POriginalPrice,采购原币价】【PRCD_PCurrencyPrice,采购本币价】" & _
    "【PRCD_SCurrencyPrice,吊牌价】【PRCD_RetDeptID,退货仓ID】【PRCD_POSRetCode,POS_退货单号】【PRCD_Total,退货数量】【PRCD_Amount,退货金额】【PRCD_Reson,退货原因】" & _
    "【PRCD_Status,状态ID】【PRCD_RgUser,创建人】【PRCD_RgDt,创建时间】【PRCD_LmUser,最后修改人】【PRCD_LmDt,最后修改时间】【PD0_ProductCodeSU,供应商款号】" & _
    "【PD0_Code,款号】【UnitDictName,单位】【SizeSU_DictName,供应商尺码】【Size_DictName,尺码】" & _
    "【ColorSU_DictName,供应商颜色】【Color_DictName,颜色】"
End If

If TableName = "ReturnBillDList" Then
    GetHeadMap = "【PR1_CONO,集团】【PR1_DIVI,事业体】" & _
    "【PRCD_PRC_ReturnCode,退货单编号】【PRCD_POSRetCode,POS_退货单号】【PR1_OrderCode,采购单主表编号】【PD0_ProductCodeSU,供应商款号】【PD0_Code,款号】【PRCD_Total,退货数量】" & _
    "【PRCD_Amount,退货金额】【PRCD_Reson,退货原因】【ColorSU_DictName,供应商颜色】【Color_DictName,颜色】【SizeSU_DictName,供应商尺码】【Size_DictName,尺码】" & _
    "【UnitDictName,单位】【PR1D_POriginalPrice,采购原币价】【PR1D_PCurrencyPrice,采购本币价】【PR1D_SCurrencyPrice,吊牌价】" & _
    "【PRBD_RgUser,创建人】【PRBD_RgDt,创建日期】【PRBD_LmUser,最后修改人】【PRBD_LmDt,最后修改时间】" & _
    "【PR1D_PD0_ProductId,商品ID】【PR1_SU0_SupplierId,供应商GUID】【PR1D_UnitID,单位ID】【PRCD_ReturnDetailId,退货单明细ID】【PRCD_PRC_ReturnId,退货单主表ID】【PR1_OrderId,采购单主表ID】" & _
    "【PR1D_OrderDetailId,采购单明细ID】【PRCD_RetDeptID,退货仓ID】【PRBD_Status,状态ID】"
End If
End Function
Function GetEditColumnsName(TableName As String) As String

If TableName = "SupplyList" Then
    GetEditColumnsName = "【供应商分类】【供应商名称】【联系人】【联系电话】【地址】【开户行】【银行账户】【银行地址】【银行SWIFT号】【新建人】"
End If

If TableName = "LXRList" Then
    GetEditColumnsName = "【联系人姓名】【职务】【电话1】【电话2】【邮箱】【联系人状态】"
End If
If TableName = "BrandList" Then
    GetEditColumnsName = "【品牌编号】【品牌名称】【品牌所在国家】【目标群体】【品牌风格】"
End If
If TableName = "ContractList" Then
    GetEditColumnsName = "【合同说明】【合同开始时间】【合同截止时间】"
End If
If TableName = "ContractNewList" Then
    GetEditColumnsName = "【供应商编号】【合同金额】【合同说明】【合同开始时间】【合同截止时间】"
End If
If TableName = "ProductList" Then
    GetEditColumnsName = "【品牌名称】【供应商款号】【供应商颜色】" & _
    "【供应商颜色（简）】【供应商尺码】【款号】【品名】【颜色】【尺码】【年份】【季节】【款式种类】【款式大类】【款式小类】【产地】" & _
    "【成分】【等级】【执行标准】【安全技术类别】【采购价】【吊牌价】【单位】【是否打印】"
End If
If TableName = "PayNewList" Then
    GetEditColumnsName = "【财务水单号】【是否已付款】"
End If
If TableName = "PayDHList" Then
    GetEditColumnsName = "【财务水单号】【是否已付款】"
End If
If TableName = "PayTHList" Then
    GetEditColumnsName = "【财务水单号】【是否已付款】"
End If
If TableName = "DeliveryPlanList" Then
    GetEditColumnsName = "【本次计划到货数量】"
End If
If TableName = "DeliveryPlanMXList" Then
    GetEditColumnsName = "【本次计划到货数量】"
End If
End Function





