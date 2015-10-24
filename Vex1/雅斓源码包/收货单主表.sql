USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_PRB_Receipt]    Script Date: 09/12/2013 10:34:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc [API_GLERP].[Sp_PRB_Receipt]
 
@InputFormat varchar(30),
@OutputFormat varchar(30),
@OutputContentType varchar(30),
@ConditionStr varchar(Max)
as

begin
    declare @SqlString nvarchar(max)
	declare @SqlString1  nvarchar(max)
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
	DECLARE @PRB_CONO	        VARCHAR(20)
	DECLARE @PRB_DIVI	        VARCHAR(20)
	DECLARE @PRB_UptNo          VARCHAR(20)
    DECLARE @PRB_RgDt           VARCHAR(50)
    DECLARE @PRB_LmDt           VARCHAR(50)
	DECLARE @PRB_ReceiptCode    VARCHAR(50)
	DECLARE @PRB_Status			 VARCHAR(50)
	DECLARE @PRB_ReceiptId		 VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
   
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.PRB_Receipt】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》收货单ID,】【《W》收货单编号,】【《W》到货计划ID,】【《W》收货单类型,】' +
			'【《W》计划到货数量,】【《W》计划到货金额,】【《W》此次收货数量,】【《W》此次收货金额,】' +
		    '【《W》收货时间,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 
	
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B02_Bill.PRB_Receipt】【新增内容,必填】'+
			'【《N》收货单主表ID,】【《N》收货单编号,】【《N》到货计划ID,】【《N》收货单类型,】【《N》计划到货数量,】【《N》计划到货金额,】'+
			'【《N》此次收货数量,】【《N》此次收货金额,】【《N》收货时间,】【《N》状态,】【《N》创建人,】【《N》最后修改人,】'
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B02_Bill.PRB_Receipt】【更新内容,必填】'+
			'【《N》收货单编号,】【《N》到货计划ID,】【《N》收货单类型,】【《N》计划到货数量,】【《N》计划到货金额,】'+
			'【《N》此次收货数量,】【《N》此次收货金额,】【《N》收货时间,】【《N》状态,】 【《N》最后修改人,】' + 			 
								          
			'【《W》收货单ID,】【《W》收货单编号,】【《W》到货计划ID,】【《W》收货单类型,】' +
			'【《W》计划到货数量,】【《W》计划到货金额,】【《W》此次收货数量,】【《W》此次收货金额,】' +
		    '【《W》收货时间,】【《W》状态,】 【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 
 						
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B02_Bill.PRB_Receipt】【更新内容,必填】【条件内容,】'+
			'【《N》状态,】【《N》最后修改人,】【《N》修改时间,】'+
			
			'【《W》收货单ID,】【《W》收货单编号,】【《W》到货计划ID,】【《W》收货单类型,】' +
			'【《W》计划到货数量,】【《W》计划到货金额,】【《W》此次收货数量,】【《W》此次收货金额,】' +
		    '【《W》收货时间,】【《W》状态,】 【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 		
			 
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
			'【集团,		     PRB_CONO~PRA_CONO,								String,'														     +'】' + 
            '【事业体,		     PRB_DIVI~PRA_DIVI,								String,'														     +'】' + 
            '【收货单ID,		 PRB_ReceiptId~PRB_ReceiptId,					String,'														     +'】' + 
            '【收货单编号,		 PRB_ReceiptCode~PRB_ReceiptCode,				String,'														     +'】' + 
			'【到货主表计划ID,	 PRB_PRA_ArrivalPlanId~PRB_PRA_ArrivalPlanId,   String,'														     +'】' +            			
            '【供应商编号,		 PRB_SU0_SupplierId~PRB_SU0_SupplierId,			String,'														     +'】' +            			
            '【收货单类型,		 PRB_TypeId~PRB_TypeId,							String,'														     +'】' + 
            '【计划到货数量,	 PRB_PlanTotal~PRB_PlanTotal,					String,'														     +'】' + 
            '【计划到货金额,	 PRB_PlanAmount~PRB_PlanAmount,					String,'														     +'】' + 
            '【此次收货数量,	 PRB_ReceiptTotal~PRB_ReceiptTotal,				String,'														     +'】' + 
            '【此次收货金额,	 PRB_ReceiptAmount~PRB_ReceiptAmount,			String,'														     +'】' +           
            '【收货时间,		 PRB_ReceiptDate~PRB_ReceiptDate				String,'														     +'】' + 
            '【状态,			 PRB_Status~PRB_Status,							String,'														     +'】' +            
            '【创建人,           PRB_RgUser~PRB_RgUser,							String,'														     +'】' +                                          
			'【创建时间,         PRB_RgDt~PRB_RgDt,								String,'														     +'】' +                                          
			'【最后修改人,       PRB_LmUser~PRB_LmUser,							String,'														     +'】' +                                          
			'【最后修改时间,     PRB_LmDt~PRB_LmDt,								String,'														     +'】' +                                          
			'【到货计划编号,     A.PRA_ArrivalPlanCode~PRA_ArrivalPlanCode,		String,'														     +'】' +                                          
			'【收货单类型对照,   B.DC0_DictName1~TypeIdDictName,						String,'														     +'】' +                                                 
			'【状态对照,		 C.DC0_DictName1~StatusDictName,						String,'														     +'】' +   
                                          
            '【《W》集团,				PRB_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRB_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》收货单ID,			PRB_ReceiptId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单ID') ,'')			+'】' +
            '【《W》收货单编号,			PRB_ReceiptCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单编号'),'')			+'】' +
            '【《W》到货主表计划ID,		PRB_PRA_ArrivalPlanId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货主表计划ID'),'')		+'】' +
            '【《W》收货单类型,			PRB_TypeId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单类型'),'')			+'】' +
            '【《W》计划到货数量,		PRB_PlanTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货数量'),'')		+'】' +
            '【《W》计划到货金额,		PRB_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货金额'),'')		+'】' +
			'【《W》此次收货数量,		PRB_ReceiptTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》此次收货数量'),'')		+'】' +           
			'【《W》此次收货金额,		PRB_ReceiptAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》此次收货金额'),'')		+'】' +                     
            '【《W》收货时间,			PRB_ReceiptDate,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货时间') ,'')			+'】' +
            '【《W》状态,				PRB_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')				+'】' +
            '【《W》创建人,				PRB_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRB_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRB_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRB_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 
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
			FROM  B02_Bill.PRB_Receipt WITH ( NOLOCK ) 
			LEFT JOIN  B02_Bill.PRA_ArrivalPlan A ON  PRB_PRA_ArrivalPlanId=PRA_ArrivalPlanId
			LEFT JOIN  M01_CONF.DC0_Dictionary  B ON  PRB_TypeId=B.DC0_DictId    	
			LEFT JOIN  M01_CONF.DC0_Dictionary  C ON  PRB_Status=C.DC0_DictId    	    
			where  PRB_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1  ORDER BY PRB_LmDt'' ' 
 		end
 		ELSE
 		BEGIN
 			Set @SqlString='select ' +  @SelectFieldList + ' 
			FROM  B02_Bill.PRB_Receipt WITH ( NOLOCK ) 
			LEFT JOIN  B02_Bill.PRA_ArrivalPlan A ON  PRB_PRA_ArrivalPlanId=PRA_ArrivalPlanId
			LEFT JOIN  M01_CONF.DC0_Dictionary  B ON  PRB_TypeId=B.DC0_DictId  
			LEFT JOIN  M01_CONF.DC0_Dictionary  C ON  PRB_Status=C.DC0_DictId    	   	    
			where  PRB_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND ' + @WhereFieldList
			+' ORDER BY PRB_LmDt'
 		END
 		
		
		
 
 		
		 PRINT @SqlString					
		
	end


if @mdl='NEW'  
	begin
 
	    set @SelectFieldNameList= [~FrameDB].[API_Common].[FormatString](@SelectFieldNameList, ',')		
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
				 
		set @MapString = 
			'【收货单主表ID,		PRB_ReceiptId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单主表ID'),'')			+'】' + 
			'【收货单编号,			PRB_ReceiptCode,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单编号'),'')			+'】' + 
            '【到货主表计划ID,		PRB_PRA_ArrivalPlanId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货主表计划ID'),'')	    +'】' +
            '【收货单类型,			PRB_TypeId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单类型'),'')			+'】' +          
            '【供应商编号,			PRB_SU0_SupplierId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')			+'】' +          
            '【计划到货主表数量,	PRB_PlanTotal,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货主表数量'),'')		+'】' +
			'【计划到货主表金额,	PRB_PlanAmount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货主表金额'),'')		+'】' +
		    '【此次收货数量,		PRB_ReceiptTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》此次收货数量'),'')		+'】' +     			 			 
		    '【此次收货金额,		PRB_ReceiptAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》此次收货金额'),'')		+'】' +
		    '【收货时间,			PRB_ReceiptDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货时间'),'')			+'】' +
		    '【状态,				PRB_Status,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')				+'】' + 
		    '【创建人,				PRB_RgUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')				+'】' +
		    '【最后修改人,			PRB_LmUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')			+'】'  
 		
		--print @MapString
		 --print @WhereFieldNameList
	 
		
		SET @PRB_CONO='100'
		SET @PRB_DIVI='200'
		--SET @PRA_ArrivalPlanId=newID() 
	    SET @PRB_UptNo='0'
		SET @PRB_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @PRB_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
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
        
       SET @PRB_ReceiptCode=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单编号'),'')	
 
        Set @SqlString='INSERT INTO B02_Bill.PRB_Receipt(PRB_CONO,PRB_DIVI,PRB_UptNo,PRB_RgDt,PRB_LmDt,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@PRB_CONO+''','''+@PRB_DIVI+''','		
		Set @SqlString=@SqlString+''''+@PRB_UptNo+''','''+@PRB_RgDt+''','''+@PRB_LmDt+''','+@InsertFromValueList+')'
		--PRINT @SqlString
 
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
		
            '【收货单编号,			PRB_ReceiptCode,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单编号'),'')			+'】' + 
            '【到货主表计划ID,		PRB_PRA_ArrivalPlanId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货主表计划ID'),'')	    +'】' +
            '【收货单类型,			PRB_TypeId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单类型'),'')			+'】' +          
            '【供应商编号,			PRB_SU0_SupplierId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')			+'】' +          
            '【计划到货数量,		PRB_PlanTotal,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货数量'),'')		+'】' +
			'【计划到货金额,		PRB_PlanAmount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货金额'),'')		+'】' +
		    '【此次收货数量,		PRB_ReceiptTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》此次收货数量'),'')		+'】' +     			 			 
		    '【此次收货金额,		PRB_ReceiptAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》此次收货金额'),'')		+'】' +
		    '【收货时间,			PRB_ReceiptDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货时间'),'')			+'】' +
		    '【状态,				PRB_RgUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')				+'】' + 
		    '【最后修改人,			PRB_LmUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')			+'】' + 
 		             
            '【《W》集团,				PRB_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRB_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》收货单ID,			PRB_ReceiptId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单ID') ,'')			+'】' +
            '【《W》收货单编号,			PRB_ReceiptCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单编号'),'')			+'】' +
            '【《W》到货主表计划ID,		PRB_PRA_ArrivalPlanId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货主表计划ID'),'')		+'】' +
            '【《W》收货单类型,			PRB_TypeId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单类型'),'')			+'】' +
            '【《W》供应商编号,			PRB_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')			+'】' +          
            '【《W》计划到货数量,		PRB_PlanTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货数量'),'')		+'】' +
            '【《W》计划到货金额,		PRB_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货金额'),'')		+'】' +
			'【《W》此次收货数量,		PRB_ReceiptTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》此次收货数量'),'')		+'】' +           
			'【《W》此次收货金额,		PRB_ReceiptAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》此次收货金额'),'')		+'】' +                     
            '【《W》收货时间,			PRB_ReceiptDate,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货时间') ,'')			+'】' +
            '【《W》状态,				PRB_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')				+'】' +
            '【《W》创建人,				PRB_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRB_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRB_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRB_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 

		SET @PRB_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
 
 
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
		
		set @PRB_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	
	    set @PRB_ReceiptId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单ID'),'')
  
		Set @SqlString='UPDATE B02_Bill.PRB_Receipt SET PRB_UptNo=CAST(PRB_UptNo AS INT)+1,PRB_LmDt='''+@PRB_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
	 	print @SqlString		
 		 Set @SqlString1='UPDATE B SET B.PRBD_Status='''+@PRB_Status+'''	
 			 FROM B02_Bill.PRB_Receipt A, B02_Bill.PRBD_ReceiveDetail B
 		     WHERE A.PRB_ReceiptId=B.PRBD_PRB_ReceiveId
 		     AND A.PRB_ReceiptId='''+@PRB_ReceiptId+'''	
 		     '
			 	print @SqlString1
			EXEC sp_executesql @SqlString1
          
							
		 
	end
	
	
 if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【状态,					PRB_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【最后修改人,				PRB_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +  
                               
			'【《W》集团,				PRB_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRB_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》收货单ID,			PRB_ReceiptId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单ID') ,'')			+'】' +
            '【《W》收货单编号,			PRB_ReceiptCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单编号'),'')			+'】' +
            '【《W》到货主表计划ID,		PRB_PRA_ArrivalPlanId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货主表计划ID'),'')		+'】' +
            '【《W》收货单类型,			PRB_TypeId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单类型'),'')			+'】' +
            '【《W》供应商编号,			PRB_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')			+'】' +          
            '【《W》计划到货数量,		PRB_PlanTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货数量'),'')		+'】' +
            '【《W》计划到货金额,		PRB_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货金额'),'')		+'】' +
			'【《W》此次收货数量,		PRB_ReceiptTotal,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》此次收货数量'),'')		+'】' +           
			'【《W》此次收货金额,		PRB_ReceiptAmount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》此次收货金额'),'')		+'】' +                     
            '【《W》收货时间,			PRB_ReceiptDate,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货时间') ,'')			+'】' +
            '【《W》状态,				PRB_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')				+'】' +
            '【《W》创建人,				PRB_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRB_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRB_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRB_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 
   
   
           	SET @PRB_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		print @UpdateFieldList
		Set @SqlString='UPDATE B02_Bill.PRB_Receipt SET PRB_UptNo=CAST(PRB_UptNo AS INT)+1,PRB_LmDt='''+@PRB_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
		 
		IF  @PRB_Status <>''
		BEGIN 		
	 		 Set @SqlString1='UPDATE B SET B.PRBD_Status='''+@PRB_Status+'''	
 			 FROM B02_Bill.PRB_Receipt A, B02_Bill.PRBD_ReceiveDetail B
 		     WHERE A.PRB_ReceiptId=B.PRBD_PRB_ReceiveId
 		     AND A.PRB_ReceiptId='''+@PRB_ReceiptId+'''	
 		     '
			--	print @SqlString1
			EXEC sp_executesql @SqlString1
        END 
							
		 
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

