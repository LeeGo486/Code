USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_FNP_ContracPayApplyDetail]    Script Date: 09/12/2013 10:32:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
 
CREATE proc [API_GLERP].[Sp_FNP_ContracPayApplyDetail]

@InputFormat varchar(30),
@OutputFormat varchar(30),
@OutputContentType varchar(30),
@ConditionStr varchar(Max)
as

begin
    declare @SqlString nvarchar(max)
    declare @SqlString1 nvarchar(max)
    declare @SqlString2 nvarchar(max)
	declare @HelpString nvarchar(max)
	Set @HelpString=''
	Declare @MapString nvarchar(max)
	Declare @MapString1 nvarchar(max)
	--设置特定变量
	declare @Mdl varchar(100)
	declare @ETY varchar(50)
	Declare @UserName varchar(50)	

	Declare @SelectFieldNameList varchar(max)	
	Declare @UpdateFieldNameList varchar(max)	
	Declare @InsertToFieldNameList varchar(max)	
	Declare @WhereFieldNameList varchar(max)
	Declare @WhereFieldNameList1 varchar(max)
	Declare @InsertFromFieldNameList	varchar(max)

	Declare @SelectFieldList varchar(max)	
	Declare @UpdateFieldList varchar(max)
	Declare @InsertToFieldList varchar(max)
	Declare @InsertFromValueList varchar(max)
	Declare @WhereFieldList varchar(max)	
	Declare @WhereFieldList1 varchar(max)	
	Declare @PowerList varchar(max)	
	declare @Lvl varchar(10)
-----自动生成	
	DECLARE @PR0_CONO	        VARCHAR(20)
	DECLARE @PR0_DIVI	        VARCHAR(20)
	DECLARE @PR0_ContractId	    VARCHAR(100)
	DECLARE @PR0_UptNo          VARCHAR(20)
    DECLARE @PR0_RgDt           VARCHAR(50)
    DECLARE @PR0_LmDt           VARCHAR(50)
    DECLARE @PR0_ContractCode   VARCHAR(50)
    DECLARE @PreCode            VARCHAR(50)
    DECLARE @WFP_BillId         VARCHAR(100)
    DECLARE @PR0_Status         VARCHAR(100)
    DECLARE @PR0_RgUser			VARCHAR(20)
    DECLARE @FNP_PayApplyId		VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
  
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.FNPD_PayApplyDetail】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》付款申请单明细ID,】【《W》申请单ID,】【《W》申请单编号,】【《W》单据类型,】【《W》单据ID,】' +
			'【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】 '  			
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B02_Bill.PR0_Contract】【新增内容,必填】【条件内容,】'+
			'【《N》合同编号,】【《N》供应商编号,】【《N》合同金额,】【《N》结算币种,】'+
			'【《N》合同扫描件,】【《N》合同开始时间,】【《N》合同截止时间,】【《N》合同状态,】【《W》创建人,】'+
			'【《N》最后修改人,】【《N》结算方式,】'  		
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B02_Bill.PR0_Contract】【更新内容,必填】'+
			'【《N》合同编号,】【《N》供应商编号,】【《N》合同金额,】【《N》结算币种,】'+
			'【《N》合同扫描件,】【《N》合同开始时间,】【《N》合同截止时间,】【《W》最后修改人,】【《N》合同状态,】【《N》结算方式,】'+					          
            '【《W》集团,】【《W》事业体,】'+
			'【《W》合同ID,】【《W》合同编号,】【《W》供应商编号,】【《W》合同金额,】【《W》结算币种,】' +
			'【《W》合同说明,】【《W》合同状态,】【《W》合同扫描件,】【《W》合同开始时间,】【《W》合同截止时间,】 ' +
			'【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】【《W》单据编号,】【《W》结算方式,】'									
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B02_Bill.PR0_Contract】【更新内容,必填】【条件内容,】【《N》合同状态,】'+
			'【《N》最后修改人,】【《N》修改时间,】'+
            '【《W》集团,】【《W》事业体,】'+
			'【《W》合同ID,】【《W》合同编号,】【《W》供应商编号,】【《W》合同金额,】【《W》结算币种,】' +
			'【《W》合同说明,】【《W》合同状态,】【《W》合同扫描件,】【《W》合同开始时间,】【《W》合同截止时间,】 ' +
			'【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】【《W》结算方式,】'					
			 
			if @OutputContentType in ('HELP','帮助') begin goto n end
		end
	--解析传入参数
	
	if @InputFormat in ('AML','【,】') 
		begin
			set @Mdl=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'操作类型')		
			set @SelectFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'返回内容')
			set @UpdateFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'更新内容')
			set @InsertToFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'新增内容')
			set @WhereFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'条件内容')	
			 
		end
	
 
--设置默认值
	
	--生成@SqlString
	if @mdl='GET'  
	begin
        
		--print @FieldList
		set @SelectFieldNameList= [~FrameDB].[API_Common].[FormatString](@SelectFieldNameList, ',')
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
 
		BEGIN	
			set @MapString = 
			'【集团,		     FNPD_CONO~DC0_CONO,								String,'														     +'】' + 
            '【事业体,		     FNPD_DIVI~DC0_DIVI,								String,'														     +'】' + 
            '【付款申请单明细ID, FNPD_PayApplyDetailId~FNPD_PayApplyDetailId,		String,'														     +'】' + 
            '【申请单ID,		 FNPD_FNP_PayApplyId~FNPD_FNP_PayApplyId,			String,'														     +'】' + 
            '【申请单编号,		 FNPD_FNP_PayApplyCode~FNPD_FNP_PayApplyCode,		String,'														     +'】' + 
            '【单据类型,		 FNPD_RefBillDetailType~FNPD_RefBillDetailType,		String,'														     +'】' + 
            '【单据ID,		     FNPD_RefBillDetailID~FNPD_RefBillDetailID,			String,'														     +'】' + 
            '【状态,		     FNPD_Status~FNPD_Status,							String,'														     +'】' +  
            '【创建人,		     FNPD_RgUser~PR0_RgUser,							String,'														     +'】' + 
            '【创建时间,         FNPD_RgDt~PR0_RgDt,								String,'														     +'】' +             
            '【最后修改人,       FNPD_LmUser~PR0_LmUser,							String,'														     +'】' +     
            '【最后修改时间,     FNPD_LmDt~PR0_LmDt,								String,'														     +'】' +  
            '【修改次数,         FNPD_UptNo~PR0_UptNo,								String,'														     +'】' +                         
			'【合同编号,		 A.PR0_ContractCode~PR0_ContractCode,				String,'														     +'】' +  		             
            '【合同金额,		 A.PR0_Amount~PR0_Amount,							String,'														     +'】' +                          
			'【预付款百分比,	 A.PR0_PrePayRate~PR0_PrePayRate,					String,'														     +'】' +   
			'【合同备注,		 A.PR0_Description~PR0_Description,					String,'														     +'】' +           
            '【结算方式,         A.PR0_SettleAccount~PR0_SettleAccount,				String,'														     +'】' +   
            '【单据类型,		 C.DC0_DictName1~TypeDictName,						String,'														     +'】' +   
            '【采购数量,		 D.PR1_PurchaseTotal~PR1_PurchaseTotal,				String,'														     +'】' +   
            '【状态,			 E.DC0_DictName1~StatusDictName,					String,'														     +'】' +                                    
            '【结算币种,         F.DC0_DictName1~CurrencyDictName,					String,'														     +'】' +   
            
            
            '【《W》集团,				FNPD_CONO,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,				FNPD_DIVI,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》付款申请单明细ID,	FNPD_PayApplyDetailId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》付款申请单明细ID') ,'')		+'】' +
            '【《W》申请单ID,			FNPD_FNP_PayApplyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单ID'),'')		+'】' +
            '【《W》申请单编号,			FNPD_FNP_PayApplyCode,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单编号'),'')		+'】' +
            '【《W》单据类型,			FNPD_RefBillDetailType,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据类型'),'')		+'】' +
            '【《W》单据ID,				FNPD_RefBillDetailID,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据ID'),'')		+'】' +
            '【《W》状态,				FNPD_Status,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')			+'】' +
            '【《W》创建人,				FNP_RgUser,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')			+'】' +
            '【《W》创建时间,			FNP_RgDt,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,			FNP_LmUser,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +
            '【《W》最后修改时间,		FNP_LmDt,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' +
		    '【《W》最后修改时间,		FNP_LmDt,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】'
		 
		set @SelectFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](		
			@MapString
			,'Select'	
			,@SelectFieldNameList
			,0	
		) 
		set @WhereFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString
			,'Where'	
			,@WhereFieldNameList
			,0	
		)	
		
		
		if @WhereFieldList='' 
		begin
			Set @SqlString='select ' +  @SelectFieldList + ' 
	     FROM  B02_Bill.FNPD_PayApplyDetail
	     LEFT JOIN B02_Bill.PR0_Contract A        ON    FNPD_RefBillDetailID=A.PR0_ContractId  
         LEFT JOIN  M01_CONF.DC0_Dictionary C     ON    FNPD_RefBillDetailType=C.DC0_DictId  
         LEFT JOIN  B02_Bill.PR1_Order D		  ON    FNPD_RefBillDetailID=D.PR1_PR0_ContractId     
         LEFT JOIN  M01_CONF.DC0_Dictionary E     ON    FNPD_Status=E.DC0_DictId   
         LEFT JOIN  M01_CONF.DC0_Dictionary F     ON    A.PR0_CurrencyId=F.DC0_DictId    	     	    
		where FNPD_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1  ORDER BY FNPD_LmDt'' ' 
		
 		end
 		ELSE
 		BEGIN
 			Set @SqlString='select ' +  @SelectFieldList + ' 
	     FROM  B02_Bill.FNPD_PayApplyDetail
	     LEFT JOIN B02_Bill.PR0_Contract A        ON    FNPD_RefBillDetailID=A.PR0_ContractId  
         LEFT JOIN  M01_CONF.DC0_Dictionary C     ON    FNPD_RefBillDetailType=C.DC0_DictId  
         LEFT JOIN  B02_Bill.PR1_Order D		  ON    FNPD_RefBillDetailID=D.PR1_PR0_ContractId     
         LEFT JOIN  M01_CONF.DC0_Dictionary E     ON    FNPD_Status=E.DC0_DictId   
         LEFT JOIN  M01_CONF.DC0_Dictionary F     ON    A.PR0_CurrencyId=F.DC0_DictId    	     	    
		where FNPD_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND ' + @WhereFieldList
		+' ORDER BY FNPD_LmDt'
 		END
 
 		
		PRINT @SqlString					
 
	
	END 

 end
  

 	--根据格式返回结果
 
	Declare @DB varchar(250),@N_ID varchar(50),@SP_Name varchar(500),@SchemaName varchar(500)
	set @DB=DB_NAME()
	Set @SP_Name=object_name(@@PROCID)
	--print @SqlString
	N:
	exec [~FrameDb].API_COMMON.GetSchemaName @DB,@@PROCID,@SchemaName output
	
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString1,@HelpString,@N_ID output 
		
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString,@HelpString,@N_ID output 

 
	exec [~FrameDB].API_Common.ReturnRlt @N_ID,@OutputFormat ,@OutputContentType,@DB,@SqlString,@HelpString
		
	 
		 	

	print @N_ID
	print @SchemaName
	print @DB
	print @SP_Name

	
	
end

 

GO

