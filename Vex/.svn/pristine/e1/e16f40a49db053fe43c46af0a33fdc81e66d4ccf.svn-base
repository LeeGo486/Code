USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_WFT_AuditFlowDefine]    Script Date: 09/12/2013 10:35:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc [API_GLERP].[Sp_WFT_AuditFlowDefine]

@InputFormat varchar(30),
@OutputFormat varchar(30),
@OutputContentType varchar(30),
@ConditionStr varchar(Max)
as

begin
    declare @SqlString nvarchar(max)
	declare @HelpString nvarchar(max)
	Set @HelpString=''
	Declare @MapString nvarchar(max)
	
	--设置特定变量
	declare @Mdl varchar(100)
	declare @ETY varchar(50)
	Declare @UserName varchar(50)	

	Declare @SelectFieldNameList varchar(max)	
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
	DECLARE @WFT_CONO	        VARCHAR(20)
	DECLARE @WFT_DIVI	        VARCHAR(20)
	DECLARE @WFT_AFDId			VARCHAR(100)
	DECLARE @WFT_UptNo          VARCHAR(20)
    DECLARE @WFT_RgDt           VARCHAR(50)
    DECLARE @WFT_LmDt           VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
  
			set @HelpString=
			'【操作类型,GET】【实体,M02_BPM.WFT_AuditFlowDefine】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》审批流模版ID,】【《W》审核类型,】【《W》节点名称,】【《W》人员,】【《W》步骤,】' +
			'【《W》是否必审,】【《W》创建人,】 【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】'			
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,M02_BPM.WFT_AuditFlowDefine】【新增内容,必填】【条件内容,】'+
			'【《N》审核类型,】【《N》节点名称,】【《N》人员,】【《N》步骤,】'+
			'【《N》是否必审,】【《N》创建人,】【《N》最后修改人,】'  		
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,M02_BPM.WFT_AuditFlowDefine】【更新内容,必填】'+
			'【《N》审核类型,】【《N》节点名称,】【《N》人员,】【《N》步骤,】'+
			'【《N》是否必审,】【《N》创建人,】【《N》最后修改人,】'+
								          
            '【《W》集团,】【《W》事业体,】'+
			'【《W》审批流模板ID,】【《W》审核类型,】【《W》节点名称,】【《W》人员,】【《W》步骤,】' +
			'【《W》是否必审,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】 '  							
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,M02_BPM.WFT_AuditFlowDefine】【更新内容,必填】【条件内容,】'+
			'【《N》最后修改人,】【《N》修改时间,】'+
            '【《W》集团,】【《W》事业体,】'+
			'【《W》审批流模板ID,】【《W》审核类型,】【《W》节点名称,】【《W》人员,】【《W》步骤,】' +
			'【《W》是否必审,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】 '  			
			 
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
			'【集团,		     WFT_CONO~WFT_CONO,							String,'														     +'】' + 
            '【事业体,		     WFT_DIVI~WFT_DIVI,							String,'														     +'】' + 
            '【审批流模版ID,	 WFT_AFDId~WFT_AFDId,						String,'														     +'】' + 
            '【审核类型,		 WFT_Type~WFT_Type,							String,'														     +'】' + 
            '【节点名称,		 WFT_Node~WFT_Node,							String,'														     +'】' + 
            '【人员,			 WFT_Person~WFT_Person,						String,'														     +'】' + 
            '【步骤,			 WFT_Step~WFT_Step,							String,'														     +'】' + 
            '【是否必审,		 WFT_IsMust~WFT_IsMust,						String,'														     +'】' + 
            '【创建人,	  		 WFT_RgUser~WFT_RgUser,						String,'														     +'】' + 
            '【创建时间,	     WFT_RgDt~WFT_RgDt,							String,'														     +'】' + 
            '【最后修改人,		 WFT_LmUser~WFT_LmUser,						String,'														     +'】' + 
            '【最后修改时间,	 WFT_LmDt~WFT_LmDt,							String,'														     +'】' + 
            '【修改次数,         WFT_UptNo~WFT_UptNo,						String,'														     +'】' +                                          
          
            '【《W》集团,			WFT_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			WFT_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》审批流模版ID,	WFT_AFDId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批流模版ID') ,'')	+'】' +
            '【《W》审核类型,		WFT_Type,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审核类型'),'')		+'】' +
            '【《W》节点名称,		WFT_Node,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》节点名称'),'')		+'】' +
            '【《W》人员,			WFT_Person,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》人员'),'')			+'】' +
            '【《W》步骤,			WFT_Step,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》步骤'),'')			+'】' +
            '【《W》是否必审,	    WFT_IsMust,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》是否必审'),'')		+'】' +
            '【《W》创建人,			WFT_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')			+'】' +
            '【《W》创建时间,		WFT_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		WFT_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +
            '【《W》最后修改时间,	WFT_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' 
 
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
		Set @SqlString='select ' +  @SelectFieldList + ' 
	    FROM   M02_BPM.WFT_AuditFlowDefine WITH ( NOLOCK )  	    
		where  ' + @WhereFieldList
 		+' ORDER BY WFT_LmDt'
		PRINT @SqlString					
		
	end


if @mdl='NEW'  
	begin
	 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @MapString =  
 
            '【审核类型,		 WFT_Type,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》审核类型'),'')	     +'】' +
            '【节点名称,		 WFT_Node,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》节点名称'),'')	     +'】' +
            '【人员,			 WFT_Person,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》人员'),'')			 +'】' +
            '【步骤,			 WFT_Step,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》步骤'),'')			 +'】' + 
            '【是否必审,		 WFT_IsMust,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》是否必审'),'')	     +'】' +
            '【创建人,			 WFT_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')	         +'】' +
            '【最后修改人,	     WFT_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' 
             
                    
 		
		SET @WFT_CONO='100'
		SET @WFT_DIVI='200'
		SET @WFT_AFDId=newID() 
	    SET @WFT_UptNo='0'
		SET @WFT_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @WFT_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
 
		
 
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
 
		Set @SqlString='INSERT INTO  M02_BPM.WFT_AuditFlowDefine(WFT_CONO,WFT_DIVI,WFT_AFDId,WFT_UptNo,WFT_RgDt,WFT_LmDt,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@WFT_CONO+''','''+@WFT_DIVI+''','''+@WFT_AFDId+''','		
		Set @SqlString=@SqlString+''''+@WFT_UptNo+''','''+@WFT_RgDt+''','''+@WFT_LmDt+''','+@InsertFromValueList+')'
		
				
		
		PRINT @SqlString
		 
 		
							
		
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
 
            '【审核类型,		 WFT_Type,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》审核类型'),'')	     +'】' +
            '【节点名称,		 WFT_Node,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》节点名称'),'')	     +'】' +
            '【人员,			 WFT_Person,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》人员'),'')			 +'】' +
            '【步骤,			 WFT_Step,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》步骤'),'')			 +'】' + 
            '【是否必审,		 WFT_IsMust,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》是否必审'),'')	     +'】' +          
            '【最后修改人,	     WFT_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +
             
            '【《W》集团,			WFT_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			WFT_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》审批流模版ID,	WFT_AFDId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批流模版ID') ,'')	+'】' +
            '【《W》审核类型,		WFT_Type,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审核类型'),'')		+'】' +
            '【《W》节点名称,		WFT_Node,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》节点名称'),'')		+'】' +
            '【《W》人员,			WFT_Person,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》人员'),'')			+'】' +
            '【《W》步骤,			WFT_Step,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》步骤'),'')			+'】' +
            '【《W》是否必审,	    WFT_IsMust,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》是否必审'),'')		+'】' +
            '【《W》创建人,			WFT_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')			+'】' +
            '【《W》创建时间,		WFT_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		WFT_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +
            '【《W》最后修改时间,	WFT_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' 
 

		SET @WFT_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
 
 
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
		Set @SqlString='UPDATE M02_BPM.WFT_AuditFlowDefine SET WFT_UptNo=CAST(WFT_UptNo AS INT)+1,WFT_LmDt='''+@WFT_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
	end
	
	
/*if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【状态,                PR0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【最后修改人,		    PR0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +                     
            '【《W》集团,			PR0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			 +'】' +
            '【《W》事业体,			PR0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			 +'】' +
            '【《W》合同ID,			PR0_ContractId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同ID') ,'')			 +'】' +
            '【《W》合同编号,		PR0_ContractCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同编号'),'')		 +'】' +
            '【《W》供应商编号,		PR0_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')		 +'】' +
            '【《W》合同金额,	    PR0_Amount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同金额'),'')		 +'】' +
            '【《W》结算币种,       PR0_CurrencyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》结算币种'),'')		 +'】' +
            '【《W》合同说明,	    PR0_Description,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同说明'),'')		 +'】' +
            '【《W》合同状态,		PR0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同状态') ,'')		 +'】' +
            '【《W》合同扫描件,		PR0_ECopyPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同扫描件'),'')		 +'】' +
            '【《W》合同开始时间,	PR0_StartDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同开始时间') ,'')    +'】' +
            '【《W》合同截止时间,	PR0_EndDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同截止时间') ,'')    +'】' +
            '【《W》创建人,		    PR0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人'),'')			 +'】' +            
            '【《W》创建时间,		PR0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		 +'】' +
            '【《W》最后修改人,		PR0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		 +'】' +          
            '【《W》最后修改时间,	PR0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	 +'】'   
          
   
   
           	SET @WFT_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		Set @SqlString='UPDATE B02_Bill.PR0_Contract SET PR0_UptNo=CAST(PR0_UptNo AS INT)+1,PR0_LmDt='''+@WFT_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
	end*/

 	--根据格式返回结果
 
	Declare @DB varchar(250),@N_ID varchar(50),@SP_Name varchar(500),@SchemaName varchar(500)
	set @DB=DB_NAME()
	Set @SP_Name=object_name(@@PROCID)
	--print @SqlString
	N:
	exec [~FrameDb].API_COMMON.GetSchemaName @DB,@@PROCID,@SchemaName output
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString,@HelpString,@N_ID output 
	
	exec [~FrameDB].API_Common.ReturnRlt @N_ID,@OutputFormat ,@OutputContentType,@DB,@SqlString,@HelpString

	print @N_ID
	print @SchemaName
	print @DB
	print @SP_Name

	
	
end

 

GO

