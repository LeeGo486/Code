/***********************************************************************
  * 
  *  参数： n
  *  返回值： sessionid
  *  DLY
  *  2014-05-05
  */ 
function peoa_GetWSRRURL(n)
{    
    var s = '11111111-1111-1111-1111-111111111111';
    switch(n)
    {
        case 1:           //任务中心
            s = '646c3648-269e-4ff5-876a-ea519c25f575';
            break;
        case 2:          //基础数据信息
            s = '366bc60b-5b43-44e0-9cc5-d79677a25e32';
            break;
        case 3:          //固定资产申购单
            s = 'd3092007-4394-4aed-9d49-b04327215d91';
            break;
        case 4:          //人员信息
            s = 'fc86d0e7-72f3-40ca-8fd5-9fe24ccccd0c';
            break;
        case 5:          //固定资产预算信息
            s = '332855fe-7e8a-48af-8bb8-29ebca1d17c1';
            break;
        case 6:          //信息类资产诊断报告
            s = '662c1fc8-38cc-478e-a51f-513f29e0aab1';
            break;
        case 7:          //退出系统
            s = 'f5f35aca-469b-463c-b33c-2e872dabbec3';
            break;
        case 8:          //系统菜单获取
            s = '2f43e442-d6a8-4ca8-a4f6-ee7b8457578a';
            break;
        case 9:          //系统角色获取
            s = '88ba3fe2-139b-4075-add5-c79b50d1df95';
            break;
        case 10:          //电脑更换及鉴定标志表单
            s = '2b93a8b1-9e28-4cca-90ba-594865d5e12f';
            break;
        case 11:          //组织架构信息
            s = '200ae38e-676b-4683-a1eb-999f906415a7';
            break;
        case 12:          //现金报销单
            s = 'efe524b6-26a3-4c5d-892b-a2885bd4683c';
            break; 
        case 13:          //日历管理
            s = '35c2758f-6b2b-4b5d-8fee-edf4b8dc750c';
            break; 
        case 14:          //预算编制
            s = '25658ed2-0fae-4a16-b818-49dcbfbb5a57';
            break;
        case 15:          //低值易耗品申购单
            s = 'd8696348-8fb2-4d90-8082-4230deebc18a';
            break;

        
        // HR辅助系统 begin
        case 1001:          //店铺人员加班
            s = '2948324c-39de-4d9b-b998-f58bf5ef449a';
            break;
        case 1002:          //hr系统接口
            s = '261f8014-1912-4768-87ec-994eb365cf01a';
            break; 
        // HR辅助系统 end
        default:
            s = '11111111-1111-1111-1111-111111111111';
    }
    return s;
 } 
 
 
/***********************************************************************
  * 
  *  参数： n
  *  返回值： fid
  *  DLY 
  */ 
function peoa_GetBDFID(n) {
    var s = '11111111-1111-1111-1111-111111111111';
    switch (n) {
        case 0:  // 第一层的FatherID 统一用这个
            s = 'CB111111-2222-3333-4444-555555555555';
            break;

        //HWA
        case 1:   // HWA  D01	BDType	基础数据类型
            s = 'F0CEF54C-1D8C-4684-AFED-9EE7F69D6F1C';
            break;
        case 2:   // HWA  D01	TaskType	任务类型
            s = 'BF0850B5-85EC-41EE-9423-8C02CC89F73E';
            break;
        case 3:  // HWA  D01	FlowState	流程状态
            s = '6C12CA19-3A7D-4DAC-8E9B-A198AE0F3BA9';
            break;
        case 4:  // HWA  D01	YesOrNo	是否
            s = '697873D0-7AC7-455C-BC0F-BC4B22AC2896';
            break;
        case 5:  // HWA  D01	AssetsType	资产类别
            s = '9E0C04C1-69D8-43A7-84B3-CD5D653C52C6';
            break;
        case 6:  // HWA  D01	PlanUse	行动计划
            s = '17AFDF51-46A3-4D6A-A058-B2F17780D89A';
            break;
        case 7:  // HWA  D01	RejectType	驳回类型
            s = '8EF907C1-0F73-4D3F-936A-86AFA12D46A5';
            break;
        case 8:  // HWA  D01	FA_APPRejectType	固定资产驳回类型
            s = '52F026B1-A50C-4315-8AED-81555FB74803';
            break;
        case 9:   // HWA  D01	AdvancedCode	高薪代码
            s = '88ba3fe2-139b-4075-add5-c79b50d1df95';
            break;
        case 10:   // HWA  D01	SignInfo	签名信息 
            s = '8AFA11D6-0421-4679-8471-5448D8895D51';
            break;
        case 11:   // HWA  D01	FA_APPState	固定资产申购单状态
            s = '93D07FB5-8E76-424A-8936-00DEC664C4B5';
            break;
        case 12:   // HWA  D01	BudgetType	预算类型 
            s = '30C659BF-7CDC-4C60-86DE-6376F5F9053A';
            break;
        case 13:   // HWA  D01	FAClaseType	固定资产类别（大类） 
            s = '64CAA1B6-CD27-4970-B288-1234567DC067';
            break;
        case 14:   // HWA  D01	Com	公司 
            s = '4c1b1bd9-b9d6-48a6-a702-ed5286e16fb9';
            break;
        case 15:   // HWA  D01	Brand	品牌 
            s = 'eb7b0063-4627-48f4-a88c-fe8f696e91c9';
            break;
        case 16:   // HWA  D01	Branch	大区 
            s = 'B53E6B16-8A5E-4511-A3FE-08A846E97C55';
            break;
        case 17:   // HWA  D01	BMClaseType	预算科目类别（大类） 
            s = 'f5c8c2c0-cf37-42ec-bac0-87326f9a73a0';
            break;
        case 18:   // HWA  D01	BMModelType	预算科目模板 
            s = '14861566-a134-4ce5-815b-60ae3dab0473';
            break;
        case 19:   // HWA  D01	ProfitCenter  利润中心 
            s = '5FAD125C-7B69-4FE9-A491-817305536AC5';
        case 20:   // HWA  D01	BMModelType_Shop	预算科目模板(MD3)
            s = 'D351D6EE-22E1-AE81-7545-645625672758';
            break;
        case 21:   // HWA  D01 预算科目类别（大类） 统一福利 
            s = '2be3c4d4-ac90-c212-5656-09ca44da612f';
            break;

            
            

        //EP
        case 10001:   // EP	D01	BDType	基础数据类型
            s = 'ED50CF19-7BAB-4FAD-8E13-0CFE28831F0C';
            break;
        case 10002:   // EP	D01	AdvancedCode	高薪代码
            s = '42F155A7-852C-47F3-8F2D-470B8FDEE889C';
            break;
        case 10003:   // EP	D01	GenusCompany	所属公司
            s = 'C8110B3C-FC31-4CEA-9B39-D99B273D1BEB';
            break;
        case 10003:   // EP	D01	ProjectCode	项目代码
            s = 'A391CD8E-1DE1-4A21-829E-5D7943DC0C16';
            break;
        default:
            s = '11111111-1111-1111-1111-111111111111';
    }
    return s;
}
 


 
/***********************************************************************
  * 
  *  参数： n
  *  返回值： actorid
  *  DLY
  *  2014-10-29
  */
function peoa_GetActorID(n) {
    var s = 11111111;
    switch (n) { 
        //FA 固定资产
        case 1:           //申请人 
            s = 279;
            break;
        case 2:           //部门长  
            s = 278;
            break;
        case 3:           //事业部经理
            s = 283;
            break;
        case 4:          //信息专员
            s = 274;
            break;
        case 5:          //行政经理
            s = 275;
            break;
        case 6:          //采购经理 
            s = 277;
            break;
        case 7:          //财务经理
            s = 276;
            break;
        case 8:          //信息总监
            s = 280;
            break;
        case 9:          //信息类鉴定人
            s = 281;
            break;
        case 10:          //信息类审批人
            s = 282;
            break;
        case 11:          //固定资产运维
            s = 265;
            break;
        case 12:          //综合管理部负责人
            s = 287;
            break;
        default:
            s = '11111111';
            
    }
    return s;
}


/***********************************************************************
  * 
  *  参数： n
  *  返回值： orgid
  *  DLY
  *  2014-03-31
  */
function peoa_GetOrgID(n) {
    var s = 11111111;
    switch (n) {
        case 1:           //雅莹集团 
            s = '118502730';
            break;
        case 2:           //雅莹财务部
            s = '492453';
            break;
        case 3:           //其他财务部
            s = '20150331085209';
            break;
        default:
            s = '11111111';
    }
    return s;
}