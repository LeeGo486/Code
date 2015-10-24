USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_PRC_Return]    Script Date: 09/12/2013 10:35:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
 
CREATE proc [API_GLERP].[Sp_PRC_Return]
 
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
	DECLARE @PRC_CONO	        VARCHAR(20)
	DECLARE @PRC_DIVI	        VARCHAR(20)
	DECLARE @PRC_UptNo          VARCHAR(20)
    DECLARE @PRC_RgDt           VARCHAR(50)
    DECLARE @PRC_LmDt           VARCHAR(50)
    DECLARE @PRC_Status			 VARCHAR(50)
    DECLARE @PRC_ReturnId			 VARCHAR(50)
 	--DECLARE @PRC_ReturnCode    VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
   
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.PRC_Return】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》退货单主表ID,】【《W》退货单编号,】【《W》采购单ID,】【《W》采购单编号,】' +
			'【《W》供应商ID,】【《W》退货总数,】【《W》退货总金额,】 【《W》状态,】
			 【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 
	
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B02_Bill.PRC_Return】【新增内容,必填】'+
			'【《N》退货单主表ID,】【《N》退货单编号,】【《N》采购单ID,】【《N》采购单编号,】【《N》供应商ID,】【《N》退货总数,】'+
			'【《N》退货总金额,】 【《N》状态,】【《N》创建人,】【《N》最后修改人,】'
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B02_Bill.PRC_Return】【更新内容,必填】'+
			'【《N》退货单编号,】【《N》采购单ID,】【《N》采购单编号,】【《N》供应商ID,】【《N》退货总数,】'+
			'【《N》退货总金额,】【《N》状态,】 【《N》最后修改人,】' + 			 
								          
			'【《W》集团,】【《W》事业体,】'+
			'【《W》退货单主表ID,】【《W》退货单编号,】【《W》采购单ID,】【《W》采购单编号,】' +
			'【《W》供应商ID,】【《W》退货总数,】【《W》退货总金额,】 【《W》状态,】
			 【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 
 						
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B02_Bill.PRC_Return】【更新内容,必填】【条件内容,】'+
			'【《N》状态,】【《N》最后修改人,】【《N》修改时间,】'+
			
			'【《W》集团,】【《W》事业体,】'+
			'【《W》退货单主表ID,】【《W》退货单编号,】【《W》采购单ID,】【《W》采购单编号,】' +
			'【《W》供应商ID,】【《W》退货总数,】【《W》退货总金额,】 【《W》状态,】
			 【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】' 		
			 
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
			'【集团,		     PRC_CONO,								String,'														     +'】' + 
            '【事业体,		     PRC_DIVI,								String,'														     +'】' + 
            '【退货单主表ID,	 PRC_ReturnId,							String,'														     +'】' + 
            '【退货单编号,		 PRC_ReturnCode,						String,'														     +'】' + 
			'【采购单ID,		 PRC_PR1_OrderId,						String,'														     +'】' +            			
            '【采购单编号,		 PRC_PR1_OrderCode,						String,'														     +'】' +            			
            '【供应商ID,		 PRC_SU0_SupplierId,					String,'														     +'】' + 
            '【退货总数,		 PRC_Total,								String,'														     +'】' + 
            '【退货总金额,		 PRC_Amount,							String,'														     +'】' + 
            '【状态,			 PRC_Status,							String,'														     +'】' +            
            '【创建人,           PRC_RgUser,							String,'														     +'】' +                                          
			'【创建时间,         PRC_RgDt,								String,'														     +'】' +                                          
			'【最后修改人,       PRC_LmUser,							String,'														     +'】' +                                          
			'【最后修改时间,     PRC_LmDt,								String,'														     +'】' +                                          
			--'【采购单编号,       A.PR1_OrderCode~PR1_OrderCode,			String,'														     +'】' +                                          
            '【状态对照,		 B.DC0_DictName1~StatusDictName,		String,'														     +'】' +                                                                         

                                          
            '【《W》集团,				PRC_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRC_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》退货单主表ID,		PRC_ReturnId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单ID') ,'')			+'】' +
            '【《W》退货单编号,			PRC_ReturnCode,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单编号'),'')			+'】' +
            '【《W》采购单ID,			PRC_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货主表计划ID'),'')		+'】' +
            '【《W》采购单编号,			PRC_PR1_OrderCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单类型'),'')			+'】' +
            '【《W》供应商ID,			PRC_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商ID'),'')			+'】' +
            '【《W》退货总数,			PRC_Total,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货数量'),'')		+'】' +
            '【《W》退货总金额,			PRC_Amount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货金额'),'')		+'】' +
            '【《W》状态,				PRC_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')				+'】' +
            '【《W》创建人,				PRC_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRC_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRC_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRC_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 
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
		PRINT 1111111111111
		if @WhereFieldList='' 
		begin
			Set @SqlString='select ' +  @SelectFieldList + ' 
			FROM  B02_Bill.PRC_Return WITH ( NOLOCK ) 
		 
			LEFT JOIN  M01_CONF.DC0_Dictionary  B ON  PRC_Status=B.DC0_DictId  
			where  PRC_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1   ORDER BY PRC_LmDt'' ' 
 		end
 		ELSE
 		BEGIN
 			Set @SqlString='select ' +  @SelectFieldList + ' 
			FROM  B02_Bill.PRC_Return WITH ( NOLOCK ) 
			 
			LEFT JOIN  M01_CONF.DC0_Dictionary  B ON  PRC_Status=B.DC0_DictId     
			where  PRC_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND ' + @WhereFieldList
			+' ORDER BY PRC_LmDt'
 		END
 		
		--	LEFT JOIN  B02_Bill.PR1_Order A ON  PRC_PR1_OrderId=PR1_OrderId
		
 
 		
		 PRINT @SqlString					
		
	end


if @mdl='NEW'  
	begin
 
	    set @SelectFieldNameList= [~FrameDB].[API_Common].[FormatString](@SelectFieldNameList, ',')		
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
				 
		set @MapString = 
			'【退货单主表ID,		PRC_ReturnId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单主表ID'),'')			+'】' + 
			'【退货单编号,			PRC_ReturnCode,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单编号'),'')			+'】' + 
            '【采购单ID,			PRC_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单ID'),'')	    +'】' +
            '【采购单编号,			PRC_PR1_OrderCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')			+'】' +          
            '【供应商ID,			PRC_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商ID'),'')			+'】' +          
            '【退货总数,			PRC_Total,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货总数'),'')		+'】' +
			'【退货总金额,			PRC_Amount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货总金额'),'')		+'】' +
		    '【状态,				PRC_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')				+'】' + 
		    '【创建人,				PRC_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')				+'】' +
		    '【最后修改人,			PRC_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')			+'】'  
 		
		--print @MapString
		 --print @WhereFieldNameList
	 
		
		SET @PRC_CONO='100'
		SET @PRC_DIVI='200'
		--SET @PRA_ArrivalPlanId=newID() 
	    SET @PRC_UptNo='0'
		SET @PRC_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @PRC_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
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
        
    --   SET @PRC_ReturnCode=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单编号'),'')	
 
        Set @SqlString='INSERT INTO B02_Bill.PRC_Return(PRC_CONO,PRC_DIVI,PRC_UptNo,PRC_RgDt,PRC_LmDt,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@PRC_CONO+''','''+@PRC_DIVI+''','		
		Set @SqlString=@SqlString+''''+@PRC_UptNo+''','''+@PRC_RgDt+''','''+@PRC_LmDt+''','+@InsertFromValueList+')'
  PRINT @SqlString
 
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
		
             
			'【退货单编号,			PRC_ReturnCode,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单编号'),'')			+'】' + 
            '【采购单ID,			PRC_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单ID'),'')	    +'】' +
            '【采购单编号,			PRC_PR1_OrderCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')			+'】' +          
            '【供应商ID,			PRC_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商ID'),'')			+'】' +          
            '【退货总数,			PRC_Total,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货总数'),'')		+'】' +
			'【退货总金额,			PRC_Amount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货总金额'),'')		+'】' +
		    '【状态,				PRC_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')				+'】' + 
		    '【创建人,				PRC_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')				+'】' +
		    '【最后修改人,			PRC_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')			+'】' + 
 		             
            '【《W》集团,				PRC_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRC_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》退货单主表ID,		PRC_ReturnId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID') ,'')			+'】' +
            '【《W》退货单编号,			PRC_ReturnCode,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单编号'),'')			+'】' +
            '【《W》采购单ID,			PRC_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单ID'),'')		+'】' +
            '【《W》采购单编号,			PRC_PR1_OrderCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单编号'),'')			+'】' +
            '【《W》供应商ID,			PRC_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商ID'),'')			+'】' +
            '【《W》退货总数,			PRC_Total,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货总数'),'')		+'】' +
            '【《W》退货总金额,			PRC_Amount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货总金额'),'')		+'】' +
            '【《W》状态,				PRC_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')				+'】' +
            '【《W》创建人,				PRC_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRC_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRC_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRC_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 

		SET @PRC_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
 
 
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
		
		set @PRC_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	
	    set @PRC_ReturnId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')
	    
		print @UpdateFieldList
		Set @SqlString='UPDATE B02_Bill.PRC_Return SET PRC_UptNo=CAST(PRC_UptNo AS INT)+1,PRC_LmDt='''+@PRC_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		
		IF @PRC_Status<>''
		BEGIN 
 		Set @SqlString1='UPDATE B SET B.PRCD_Status='''+@PRC_Status+'''	
 			 FROM B02_Bill.PRC_Return A, B02_Bill.PRCD_ReturnDetail B
 		     WHERE A.PRC_ReturnId=B.PRCD_PRC_ReturnId
 		     AND A.PRC_ReturnId='''+@PRC_ReturnId+'''	
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
            '【状态,					PRC_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【最后修改人,				PRC_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +  
                               
            '【《W》集团,				PRC_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')				+'】' +
            '【《W》事业体,				PRC_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')				+'】' +
            '【《W》退货单主表ID,		PRC_ReturnId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单ID') ,'')			+'】' +
            '【《W》退货单编号,			PRC_ReturnCode,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单编号'),'')			+'】' +
            '【《W》采购单ID,			PRC_PR1_OrderId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货主表计划ID'),'')		+'】' +
            '【《W》采购单编号,			PRC_PR1_OrderCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单类型'),'')			+'】' +
            '【《W》供应商ID,			PRC_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商ID'),'')			+'】' +
            '【《W》退货总数,			PRC_Total,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货数量'),'')		+'】' +
            '【《W》退货总金额,			PRC_Amount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》计划到货金额'),'')		+'】' +
            '【《W》状态,				PRC_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')				+'】' +
            '【《W》创建人,				PRC_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')				+'】' +
            '【《W》创建时间,			PRC_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')			+'】' +
            '【《W》最后修改人,			PRC_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')			+'】' +
            '【《W》最后修改时间,		PRC_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')		+'】' 
 
   
   
           	SET @PRC_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		
		set @PRC_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	
	    set @PRC_ReturnId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')
	    
		--print @UpdateFieldList
		Set @SqlString='UPDATE B02_Bill.PRC_Return SET PRB_UptNo=CAST(PRC_UptNo AS INT)+1,PRC_LmDt='''+@PRC_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		Set @SqlString1='UPDATE B SET B.PRCD_Status='''+@PRC_Status+'''	
 			 FROM B02_Bill.PRC_Return A, B02_Bill.PRCD_ReturnDetail B
 		     WHERE A.PRC_ReturnId=B.PRCD_PRC_ReturnId
 		     AND A.PRC_ReturnId='''+@PRC_ReturnId+'''	
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

