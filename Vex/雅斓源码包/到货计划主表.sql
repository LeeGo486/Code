USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_PRA_ArrivalPlan]    Script Date: 09/12/2013 10:33:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc [API_GLERP].[Sp_PRA_ArrivalPlan]
 
@InputFormat varchar(30),
@OutputFormat varchar(30),
@OutputContentType varchar(30),
@ConditionStr varchar(Max)
as

begin
    declare @SqlString nvarchar(max)
	declare @SqlString1 nvarchar(max)
	declare @HelpString nvarchar(max)
	Set @HelpString=''
	Declare @MapString nvarchar(max)
 
	--设置特定变量
	declare @Mdl varchar(100)
	declare @ETY varchar(50)
	Declare @UserName varchar(50)	

	Declare @SelectFieldNameList  varchar(max)
 
	Declare @UpdateFieldNameList varchar(max)	
	Declare @InsertToFieldNameList varchar(max)	
	Declare @WhereFieldNameList varchar(max)
	Declare @InsertFromFieldNameList	varchar(max)

	Declare @SelectFieldList varchar(max)
 
	Declare @UpdateFieldList varchar(max)
	Declare @InsertToFieldList varchar(max)
	Declare @InsertFromValueList varchar(max)
	Declare @WhereFieldList varchar(max)	
 
	Declare @PowerList varchar(max)	
	declare @Lvl varchar(10)
-----自动生成	
	DECLARE @PRA_CONO	        VARCHAR(20)
	DECLARE @PRA_DIVI	        VARCHAR(20)
	DECLARE @PRA_ArrivalPlanId	VARCHAR(100)
	DECLARE @PRA_UptNo          VARCHAR(20)
    DECLARE @PRA_RgDt           VARCHAR(50)
    DECLARE @PRA_LmDt           VARCHAR(50)
    DECLARE @PRA_ArrivalPlanCode VARCHAR(50)
    DECLARE @PRA_Status   VARCHAR(50)
    DECLARE @PlanCode VARCHAR(50)
    
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
   
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.PRA_ArrivalPlan】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》到货计划ID,】【《W》到货计划编号,】【《W》采购单编号,】【《W》采购总数,】' +
			'【《W》已到数量,】【《W》本次计划到货数量,】【《W》采购金额,】【《W》已到货金额,】' +
		    '【《W》本次计划到货金额,】【《W》数量差异,】【《W》金额差异,】【《W》金额差异,】【《W》状态,】' +
		    '【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 
	
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B02_Bill.PRA_ArrivalPlan】【新增内容,必填】'+
			'【《N》到货计划编号,】【《N》采购单编号,】【《N》采购总数,】【《N》已到总数,】【《N》本次计划到货数量,】'+
			'【《N》采购主表金额,】【《N》已到货金额,】【《N》本次计划到货金额,】【《N》数量差异,】【《N》金额差异,】【《N》状态,】'  +		
			'【《N》创建人,】【《N》最后修改人,】'
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B02_Bill.PRA_ArrivalPlan】【更新内容,必填】'+
			'【《N》到货计划编号,】【《N》采购单编号,】【《N》采购总数,】【《N》已到总数,】【《N》本次计划到货数量,】'+
			'【《N》采购金额,】【《N》已到货金额,】【《N》本次计划到货金额,】【《N》数量差异,】【《N》金额差异,】【《N》状态,】'  +		
			'【《N》最后修改人,】'+  
								          
			'【《W》到货计划ID,】【《W》到货计划编号,】【《W》采购单编号,】【《W》采购总数,】' +
			'【《W》已到数量,】【《W》本次计划到货数量,】【《W》采购金额,】【《W》已到货金额,】' +
		    '【《W》本次计划到货金额,】【《W》数量差异,】【《W》金额差异,】【《W》金额差异,】【《W》状态,】' +
		    '【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 							
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B02_Bill.PRA_ArrivalPlan】【更新内容,必填】【条件内容,】'+
			'【《N》状态,】【《N》最后修改人,】【《N》修改时间,】'+
			'【《W》到货计划ID,】【《W》到货计划编号,】【《W》采购单编号,】【《W》采购总数,】' +
			'【《W》已到数量,】【《W》本次计划到货数量,】【《W》采购金额,】【《W》已到货金额,】' +
		    '【《W》本次计划到货金额,】【《W》数量差异,】【《W》金额差异,】【《W》金额差异,】【《W》状态,】' +
		    '【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 	   			
			 
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
		set @MapString = 
			'【集团,		     PRA_CONO~PRA_CONO,										String,'														     +'】' + 
            '【事业体,		     PRA_DIVI~PRA_DIVI,										String,'														     +'】' + 
            '【到货计划ID,		 PRA_ArrivalPlanId~PRA_ArrivalPlanId,					String,'														     +'】' + 
            '【到货计划编号,	 PRA_ArrivalPlanCode~PRA_ArrivalPlanCode,				String,'														     +'】' + 
            '【采购单编号,		 PRA_PR1_OrderId~PRA_PR1_OrderId,						String,'														     +'】' + 
			'【供应商ID,		 PRA_SU0_SupplierId~PRA_SU0_SupplierId,					String,'														     +'】' +    
			'【供应商编号,		 B.SU0_SupplierCode~PRA_SU0_SupplierCode,				String,'														     +'】' +            			        			
            '【采购总数,		 PRA_PerchaseTotal~PRA_PerchaseTotal,					String,'														     +'】' + 
            '【已到数量,		 PRA_ArrivalTotal~PRA_ArrivalTotal,						String,'														     +'】' + 
            '【本次计划到货数量, PRA_PlanTotal~PRA_PlanTotal,							String,'														     +'】' + 
            '【采购金额,		 PRA_PerchaseAmount~PRA_PerchaseAmount,					String,'														     +'】' + 
            '【已到货金额,		 PRA_ArrivalAmount~PRA_ArrivalAmount,					String,'														     +'】' +           
            '【本次计划到货金额, PRA_PlanAmount~PRA_PlanAmount,							String,'														     +'】' + 
            '【数量差异,	     PRA_TotalDiff~PRA_TotalDiff,							String,'														     +'】' + 
            '【金额差异,		 PRA_AmountDiff~PRA_AmountDiff,							String,'														     +'】' + 
            '【状态,			 PRA_Status~PRA_Status,									String,'														     +'】' + 
            '【创建人,           PRA_RgUser~PRA_RgUser,									String,'														     +'】' +                                          
			'【创建时间,         PRA_RgDt~PRA_RgDt,										String,'														     +'】' +                                          
			'【最后修改人,       PRA_LmUser~PRA_LmUser,									String,'														     +'】' +                                          
			'【最后修改时间,     PRA_LmDt~PRA_LmDt,										String,'														     +'】' +                                          
			'【采购单编号,       A.PR1_OrderCode~PR1_OrderCode,							String,'														     +'】' +                                          
			 '【状态对照,		 C.DC0_DictName1~StatusDictName,						String,'														     +'】' +          

                                          
            '【《W》集团,				PRA_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRA_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》到货计划ID,			PRA_ArrivalPlanId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划ID') ,'')			+'】' +
            '【《W》到货计划编号,		PRA_ArrivalPlanCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划编号'),'')		+'】' +
            '【《W》采购单编号,			PRA_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单编号'),'')			+'】' +
            '【《W》供应商ID,			PRA_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商ID'),'')			+'】' +
            '【《W》单位,				PRA_UnitID,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单位'),'')				+'】' +
            '【《W》采购总数,			PRA_PerchaseTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购总数'),'')			+'】' +
            '【《W》已到数量,			PRA_ArrivalTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》已到数量'),'')			+'】' +
			'【《W》本次计划到货数量,	PRA_PlanTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》本次计划到货数量'),'')	+'】' +           
			'【《W》采购金额,			PRA_PerchaseAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购金额'),'')			+'】' +                     
            '【《W》已到货金额,			PRA_ArrivalAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》已到货金额') ,'')			+'】' +
            '【《W》本次计划到货金额,	PRA_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》本次计划到货金额'),'')	+'】' +
            '【《W》数量差异,			PRA_TotalDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》数量差异') ,'')			+'】' +
            '【《W》金额差异,			PRA_AmountDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》金额差异') ,'')			+'】' +
            '【《W》状态,				PRA_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')				+'】' +
            '【《W》创建人,				PRA_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRA_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRA_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRA_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 
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
			FROM   B02_Bill.PRA_ArrivalPlan WITH ( NOLOCK ) 
			LEFT JOIN B02_Bill.PR1_Order A ON PRA_PR1_OrderId=PR1_OrderId	
			LEFT JOIN B01_MDM.SU0_Supplier B ON  SU0_SupplierId=PRA_SU0_SupplierId 
			LEFT JOIN  M01_CONF.DC0_Dictionary  C ON  PRA_Status=C.DC0_DictId    	
			where  PRA_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1  ORDER BY PRA_LmDt '' ' 
 		end
 		ELSE
 		BEGIN
 			Set @SqlString='select ' +  @SelectFieldList + ' 
			FROM   B02_Bill.PRA_ArrivalPlan WITH ( NOLOCK ) 
			LEFT JOIN B02_Bill.PR1_Order A ON PRA_PR1_OrderId=PR1_OrderId	
			LEFT JOIN B01_MDM.SU0_Supplier B ON  SU0_SupplierId=PRA_SU0_SupplierId     
			LEFT JOIN  M01_CONF.DC0_Dictionary  C ON  PRA_Status=C.DC0_DictId    	
			where  PRA_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND ' + @WhereFieldList
			+' ORDER BY PRA_LmDt'
 		END
		
 
		--PRINT @SqlString					
		
	end


if @mdl='NEW'  
	begin
 
	    set @SelectFieldNameList= [~FrameDB].[API_Common].[FormatString](@SelectFieldNameList, ',')
		
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
				 
		set @MapString = 
			'【到货计划编号,		PRA_ArrivalPlanCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划编号'),'')	    +'】' + 
            '【到货计划主表ID,		PRA_ArrivalPlanId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划主表ID'),'')	    +'】' +
            '【采购单编号,			PRA_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')			+'】' +          
            '【供应商编号,			PRA_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')			+'】' +          
			'【采购总数,			PRA_PerchaseTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'')			+'】' +
		    '【已到数量,			PRA_ArrivalTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已到数量'),'')			+'】' +     			 			 
		    '【本次计划到货数量,	PRA_PlanTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货数量'),'')	+'】' +
		    '【采购主表金额,		PRA_PerchaseAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购主表金额'),'')			+'】' +
		    '【已到货金额,			PRA_ArrivalAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已到货金额'),'')			+'】' + 
		    '【本次计划到货金额,	PRA_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货金额'),'')	+'】' +
		    '【数量差异,			PRA_TotalDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》数量差异'),'')			+'】' +
		    '【金额差异,			PRA_AmountDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》金额差异'),'')			+'】' +
		    '【状态,				PRA_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')				+'】' +
		    '【创建人,				PRA_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')				+'】' +
		    '【最后修改人,			PRA_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')			 +'】'  
 		
		--print @MapString
		 --print @WhereFieldNameList
	 
		
		SET @PRA_CONO='100'
		SET @PRA_DIVI='200'
		--SET @PRA_ArrivalPlanId=newID() 
	    SET @PRA_UptNo='0'
		SET @PRA_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @PRA_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
		set @InsertToFieldNameList=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString
			,'InsertTO'	
			,@InsertToFieldNameList
			,0	
		)
		
 
		set @InsertFromValueList=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString
			,'InsertFrom'	
			,@InsertFromValueList
			,0	
		)
        
       SET @PRA_ArrivalPlanCode=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划编号'),'')	
 
        Set @SqlString='INSERT INTO B02_Bill.PRA_ArrivalPlan(PRA_CONO,PRA_DIVI,PRA_UptNo,PRA_RgDt,PRA_LmDt,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@PRA_CONO+''','''+@PRA_DIVI+''','		
		Set @SqlString=@SqlString+''''+@PRA_UptNo+''','''+@PRA_RgDt+''','''+@PRA_LmDt+''','+@InsertFromValueList+')'
		--PRINT @SqlString
 					
		
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
		
            '【到货计划编号,		PRA_ArrivalPlanCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划编号'),'')	    +'】' +
            '【供应商编号,			PRA_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')			+'】' +          
            '【采购单编号,			PRA_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')			+'】' +          
			'【采购总数,			PRA_PerchaseTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'')			+'】' +
		    '【已到数量,			PRA_ArrivalTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已到数量'),'')			+'】' +     			 			 
		    '【本次计划到货数量,	PRA_PlanTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货数量'),'')	+'】' +
		    '【采购金额,			PRA_PerchaseAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购金额'),'')			+'】' +
		    '【已到货金额,			PRA_ArrivalAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已到货金额'),'')			+'】' + 
		    '【本次计划到货金额,	PRA_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货金额'),'')	+'】' +
		    '【数量差异,			PRA_TotalDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》数量差异'),'')			+'】' +
		    '【金额差异,			PRA_AmountDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》金额差异'),'')			+'】' +
		    '【状态,				PRA_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')				+'】' +
		    '【最后修改人,			PRA_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')			+'】' + 
 		             
			'【《W》集团,				PRA_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRA_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》到货计划ID,			PRA_ArrivalPlanId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划ID') ,'')			+'】' +
            '【《W》到货计划编号,		PRA_ArrivalPlanCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划编号'),'')		+'】' +
            '【《W》供应商编号,			PRA_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')			+'】' +          
            '【《W》采购单编号,			PRA_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单编号'),'')			+'】' +
            '【《W》采购总数,			PRA_PerchaseTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购总数'),'')			+'】' +
            '【《W》已到数量,			PRA_ArrivalTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》已到数量'),'')			+'】' +
			'【《W》本次计划到货数量,	PRA_PlanTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》本次计划到货数量'),'')	+'】' +           
			'【《W》采购金额,			PRA_PerchaseAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购金额'),'')			+'】' +                     
            '【《W》已到货金额,			PRA_ArrivalAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》已到货金额') ,'')			+'】' +
            '【《W》本次计划到货金额,	PRA_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》本次计划到货金额'),'')	+'】' +
            '【《W》数量差异,			PRA_TotalDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》数量差异') ,'')			+'】' +
            '【《W》金额差异,			PRA_AmountDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》金额差异') ,'')			+'】' +
            '【《W》状态,				PRA_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')				+'】' +
            '【《W》创建人,				PRA_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRA_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRA_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRA_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 

		SET @PRA_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
 
 
	    set @UpdateFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString
			,'UpdateSet'	
			,@UpdateFieldNameList
			,0	
		)
	 
		set @WhereFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString
			,'Where'	
			,@WhereFieldNameList
			,0	
		)	

 		set @PRA_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	
	    set @PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划ID'),'')
	    
 
		Set @SqlString='UPDATE B02_Bill.PRA_ArrivalPlan SET PRA_UptNo=CAST(PRA_UptNo AS INT)+1,PRA_LmDt='''+@PRA_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		
		IF @PRA_Status<>''
		 BEGIN
 			Set @SqlString1='UPDATE B SET B.PRAD_Status='''+@PRA_Status+'''	
 				 FROM B02_Bill.PRA_ArrivalPlan A, B02_Bill.PRAD_ArrivalPlanDetail B
 				 WHERE A.PRA_ArrivalPlanId=B.PRAD_PRA_ArrivalPlanId
 				 AND A.PRA_ArrivalPlanId='''+@PRA_ArrivalPlanId+'''	
 				'
			 	print @SqlString1
			EXEC sp_executesql @SqlString1
							
		END					
		 
	end
	
	
 if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【状态,					PRA_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【最后修改人,				PRA_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +  
                               
			'【《W》集团,				PRA_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRA_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》到货计划ID,			PRA_ArrivalPlanId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划ID') ,'')			+'】' +
            '【《W》到货计划编号,		PRA_ArrivalPlanCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划编号'),'')		+'】' +
            '【《W》供应商编号,			PRA_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')			+'】' +    
            '【《W》采购单编号,			PRA_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单编号'),'')			+'】' +
            '【《W》单位,				PRA_UnitID,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单位'),'')				+'】' +
            '【《W》采购总数,			PRA_PerchaseTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购总数'),'')			+'】' +
            '【《W》已到数量,			PRA_ArrivalTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》已到数量'),'')			+'】' +
			'【《W》本次计划到货数量,	PRA_PlanTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》本次计划到货数量'),'')	+'】' +           
			'【《W》采购金额,			PRA_PerchaseAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购金额'),'')			+'】' +                     
            '【《W》已到货金额,			PRA_ArrivalAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》已到货金额') ,'')			+'】' +
            '【《W》本次计划到货金额,	PRA_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》本次计划到货金额'),'')	+'】' +
            '【《W》数量差异,			PRA_TotalDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》数量差异') ,'')			+'】' +
            '【《W》金额差异,			PRA_AmountDiff,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》金额差异') ,'')			+'】' +
            '【《W》状态,				PRA_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')				+'】' +
            '【《W》创建人,				PRA_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRA_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRA_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRA_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 
   
   
           	SET @PRA_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
			print @MapString
	    set @UpdateFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString
			,'UpdateSet'	
			,@UpdateFieldNameList
			,0	
		)
	 
		set @WhereFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString
			,'Where'	
			,@WhereFieldNameList
			,0	
		)	
	 	set @PRA_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	
	    set @PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划ID'),'')
	    
		Set @SqlString='UPDATE B02_Bill.PRA_ArrivalPlan SET PRA_UptNo=CAST(PRA_UptNo AS INT)+1,PRA_LmDt='''+@PRA_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		 		Set @SqlString1='UPDATE B SET B.PRAD_Status='''+@PRA_Status+'''	
 			 FROM B02_Bill.PRA_ArrivalPlan A, B02_Bill.PRAD_ArrivalPlanDetail B
 		     WHERE A.PRA_ArrivalPlanId=B.PRAD_PRA_ArrivalPlanId
 		     AND A.PRA_ArrivalPlanId='''+@PRA_ArrivalPlanId+'''	
 		     '
			 	print @SqlString1
			EXEC sp_executesql @SqlString1
							
		 
	end 

 	--根据格式返回结果
 
	Declare @DB varchar(250),@N_ID varchar(50),@SP_Name varchar(500),@SchemaName varchar(500)
	set @DB=DB_NAME()
	Set @SP_Name=object_name(@@PROCID)
	--print @SqlString
	N:
	exec [~FrameDb].API_COMMON.GetSchemaName @DB,@@PROCID,@SchemaName output
	
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString ,@HelpString,@N_ID output 
	
	
	exec [~FrameDB].API_Common.ReturnRlt @N_ID,@OutputFormat ,@OutputContentType,@DB,@SqlString,@HelpString

	print @N_ID
	print @SchemaName
	print @DB
	print @SP_Name

	
	
end

 

GO

