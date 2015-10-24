USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_WFP_AuditFlow]    Script Date: 09/12/2013 10:35:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc [API_GLERP].[Sp_WFP_AuditFlow]
 
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
	Declare @MapString1 nvarchar(max)
	--设置特定变量
	declare @Mdl varchar(100)
	declare @ETY varchar(50)
	Declare @UserName varchar(50)	

	Declare @SelectFieldNameList  varchar(max)
	Declare @SelectFieldNameList1 varchar(max)	
	Declare @UpdateFieldNameList varchar(max)	
	Declare @InsertToFieldNameList varchar(max)	
	Declare @WhereFieldNameList varchar(max)
	Declare @InsertFromFieldNameList	varchar(max)

	Declare @SelectFieldList varchar(max)
	Declare @SelectFieldList1 varchar(max)	 
	Declare @UpdateFieldList varchar(max)
	Declare @InsertToFieldList varchar(max)
	Declare @InsertFromValueList varchar(max)
	Declare @WhereFieldList varchar(max)	
	Declare @WhereFieldList1 varchar(max)	
	Declare @PowerList varchar(max)	
	declare @Lvl varchar(10)
-----自动生成	
	DECLARE @WFP_CONO	        VARCHAR(20)
	DECLARE @WFP_DIVI	        VARCHAR(20)
	DECLARE @WFP_AFID			VARCHAR(100)
	DECLARE @WFP_UptNo          VARCHAR(20)
    DECLARE @WFP_RgDt           VARCHAR(50)
    DECLARE @WFP_LmDt           VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
  
			set @HelpString=
			'【操作类型,GET】【实体,M02_BPM.WFT_AuditFlow】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》审批流ID,】【《W》模版编号,】【《W》单据编号,】【《W》单据类型,】【《W》审批结果,】' +
			'【《W》状态,】【《W》描述,】【《W》创建人,】 【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】'			
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,M02_BPM.WFT_AuditFlow】【新增内容,必填】【条件内容,】'+
			'【《N》模版编号,】【《N》单据编号,】【《N》单据类型,】【《N》审批结果,】'+
			'【《N》状态,】【《N》描述,】【《N》创建人,】【《N》最后修改人,】'  		
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,M02_BPM.WFT_AuditFlow】【更新内容,必填】'+
			'【《N》模版编号,】【《N》单据编号,】【《N》单据类型,】【《N》审批结果,】'+
			'【《N》状态,】【《N》描述,】【《N》创建人,】【《N》最后修改人,】'+  
								          
            '【《W》集团,】【《W》事业体,】'+
			'【《W》审批流ID,】【《W》模版编号,】【《W》单据编号,】【《W》单据类型,】【《W》审批结果,】' +
			'【《W》状态,】【《W》描述,】【《W》创建人,】 【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】'  							
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,M02_BPM.WFT_AuditFlow】【更新内容,必填】【条件内容,】'+
			'【《N》状态,】【《N》最后修改人,】【《N》修改时间,】'+
            '【《W》集团,】【《W》事业体,】'+
			'【《W》审批流ID,】【《W》模版编号,】【《W》单据编号,】【《W》单据类型,】【《W》审批结果,】' +
			'【《W》状态,】【《W》描述,】【《W》创建人,】 【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】'    			
			 
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
			'【集团,		     WFP_CONO~WFP_CONO,							String,'														     +'】' + 
            '【事业体,		     WFP_DIVI~WFP_DIVI,							String,'														     +'】' + 
            '【审批流ID,		 WFP_AFID~WFP_AFID,							String,'														     +'】' + 
            '【模版编号,		 WFP_WFT_AFDId~WFP_WFT_AFDId,				String,'														     +'】' + 
            '【单据编号,		 WFP_BillId~WFP_BillId,						String,'														     +'】' + 
            '【单据类型,		 WFP_BillTypeId~WFP_BillTypeId,				String,'														     +'】' + 
            '【审批结果,		 WFP_AFResultId~WFP_AFResultId,				String,'														     +'】' + 
            '【审批时间,		 WFP_AuditTime~WFP_AuditTime,				String,'														     +'】' + 
            '【状态,			 WFP_Status~WFP_Status,						String,'														     +'】' + 
            '【描述,			 WFP_Describe~WFP_Describe,					String,'														     +'】' +           
            '【创建人,	  		 WFP_RgUser~WFP_RgUser,						String,'														     +'】' + 
            '【创建时间,	     WFP_RgDt~WFP_RgDt,							String,'														     +'】' + 
            '【最后修改人,		 WFP_LmUser~WFP_LmUser,						String,'														     +'】' + 
            '【最后修改时间,	 WFP_LmDt~WFP_LmDt,							String,'														     +'】' + 
            '【更新次数,         WFP_UptNo~WFP_UptNo,						String,'														     +'】' +                                          
			'【节点名称,         B.WFT_Node~WFT_Node,						String,'														     +'】' +                                          
          
            '【《W》集团,			WFP_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			WFP_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》审批流ID,		WFP_AFID,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批流ID') ,'')		+'】' +
            '【《W》模版编号,		WFP_WFT_AFDId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》模版编号'),'')		+'】' +
            '【《W》单据编号,		WFP_BillId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据编号'),'')		+'】' +
            '【《W》单据类型,		WFP_BillTypeId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据类型'),'')		+'】' +
            '【《W》审批结果,		WFP_AFResultId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批结果'),'')		+'】' +
            '【《W》审批时间,	    WFP_AuditTime,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批时间'),'')		+'】' +
			'【《W》状态,			WFP_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')			+'】' +           
			'【《W》描述,			WFP_Describe,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》描述'),'')			+'】' +                     
            '【《W》创建人,			WFP_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')			+'】' +
            '【《W》创建时间,		WFP_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		WFP_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +
            '【《W》最后修改时间,	WFP_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' 
 
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
	    FROM   M02_BPM.WFP_AuditFlow WITH ( NOLOCK ) 
	    LEFT JOIN M02_BPM.WFT_AuditFlowDefine B ON WFP_WFT_AFDId=B.WFT_AFDId        	    
		where  ' + @WhereFieldList
		+' ORDER BY WFP_LmDt'
 		
		PRINT @SqlString					
		
	end


if @mdl='NEW'  
	begin
	    set @SelectFieldNameList= [~FrameDB].[API_Common].[FormatString](@SelectFieldNameList, ',')
		
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
		
		set @MapString =  
           -- '【审核类型,		 WFT_Type,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》审核类型'),'')	     +'】' +            
            '【单据编号,		 WFP_BillId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单据编号'),'')	     +'】' +
            '【单据类型,		 WFP_BillTypeId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单据类型'),'')			 +'】' +          
            '【状态,			 WFP_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	         +'】' +
			'【创建人,			 WFP_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +
		    '【最后修改人,	     WFP_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +     			 			 
		    '【《W》合同号,		 PR0_ContractId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同号'),'')	     +'】' +
		    '【《W》付款单号,	 FNP_PayApplyId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》付款单号'),'')	     +'】' 
		     
            
			               
 
 
 
		  set @MapString1 = 
			'【合同表,		     B02_Bill.PR0_Contract,			 String,'														     +'】'  +                                               
			'【《W》审核类型,	 WFT_Type,						 String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审核类型'),'')	     +'】' 
               
         
          set @SelectFieldList1=[~FrameDb].[API_Common].[ConvertNameListToSql](		
			@MapString1
			,'Select'	
			,@SelectFieldNameList
			,0	
		)
		
		
		set @WhereFieldList1=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString1
			,'Where'	
			,@WhereFieldNameList
			,0	
		)	
		
		
			set @WhereFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString
			,'Where'	
			,@WhereFieldNameList
			,0	
		)	
		
		--print @MapString
		 print @WhereFieldNameList
	 
		
		SET @WFP_CONO='100'
		SET @WFP_DIVI='200'
		--SET @WFP_AFID=newID() 
	    SET @WFP_UptNo='0'
		SET @WFP_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @WFP_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
 
		
 
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
 
       -- WFP_BillId,WFP_BillTypeId,WFP_Status,WFP_RgUser,WFP_LmUser
 
 
		Set @SqlString='INSERT INTO   M02_BPM.WFP_AuditFlow(WFP_CONO,WFP_DIVI,WFP_AFID,WFP_UptNo,WFP_RgDt,WFP_LmDt,
		WFP_Describe,WFP_WFT_AFDId,WFP_AFResultId,WFP_AUDITTIME,'
		Set @SqlString=@SqlString+'' +@InsertToFieldNameList+' ) 
	    SELECT '''+@WFP_CONO+''','''+@WFP_DIVI+''',newID() ,'''+@WFP_UptNo+''','''+@WFP_RgDt+''','''+@WFP_LmDt+''',   
	    '''',WFT_AFDId,'''','''','+@InsertFromValueList+' 
	    FROM   '+@SelectFieldList1+' 
	    LEFT JOIN M02_BPM.WFT_AuditFlowDefine ON '+@WhereFieldList1+' 
	    WHERE '+@WhereFieldList+'    
	    '
	    PRINT @SqlString
                        
		--VALUES('''+@WFP_CONO+''','''+@WFP_DIVI+''','''+@WFP_AFDId+''','		
		--Set @SqlString=@SqlString+''''+@WFP_UptNo+''','''+@WFP_RgDt+''','''+@WFP_LmDt+''','+@InsertFromValueList+')'
		
				
		
 
		 
 		
							
		
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
 
            '【审核结果,		 WFT_Type,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》审核结果'),'')	     +'】' +
            '【状态,			 WFT_Node,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	     +'】' +
            '【描述,			 WFT_Person,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》描述'),'')			 +'】' +
            '【审核时间,		 WFT_IsMust,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》审核时间'),'')	     +'】' +          
            '【最后修改人,	     WFT_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +
             
            '【《W》集团,			WFP_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			WFP_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》审批流ID,		WFP_AFID,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批流ID') ,'')		+'】' +
            '【《W》模版编号,		WFP_WFT_AFDId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》模版编号'),'')		+'】' +
            '【《W》单据编号,		WFP_BillId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据编号'),'')		+'】' +
            '【《W》单据类型,		WFP_BillTypeId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据类型'),'')		+'】' +
            '【《W》审批结果,		WFP_AFResultId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批结果'),'')		+'】' +
            '【《W》审批时间,	    WFP_AuditTime,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批时间'),'')		+'】' +
			'【《W》状态,			WFP_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')			+'】' +           
			'【《W》描述,			WFP_Describe,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》描述'),'')			+'】' +                     
            '【《W》创建人,			WFP_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')			+'】' +
            '【《W》创建时间,		WFP_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		WFP_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +
            '【《W》最后修改时间,	WFP_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' 
 

		SET @WFP_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
 
 
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
		Set @SqlString='UPDATE M02_BPM.WFP_AuditFlow SET WFP_UptNo=CAST(WFP_UptNo AS INT)+1,WFP_LmDt='''+@WFP_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
	end
	
	
 if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【状态,                WFP_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【最后修改人,		    WFP_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +                     
            
            '【《W》集团,			WFP_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			WFP_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》审批流ID,		WFP_AFID,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批流ID') ,'')		+'】' +
            '【《W》模版编号,		WFP_WFT_AFDId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》模版编号'),'')		+'】' +
            '【《W》单据编号,		WFP_BillId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据编号'),'')		+'】' +
            '【《W》单据类型,		WFP_BillTypeId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据类型'),'')		+'】' +
            '【《W》审批结果,		WFP_AFResultId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批结果'),'')		+'】' +
            '【《W》审批时间,	    WFP_AuditTime,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》审批时间'),'')		+'】' +
			'【《W》状态,			WFP_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')			+'】' +           
			'【《W》描述,			WFP_Describe,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》描述'),'')			+'】' +                     
            '【《W》创建人,			WFP_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')			+'】' +
            '【《W》创建时间,		WFP_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		WFP_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +
            '【《W》最后修改时间,	WFP_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' 
 
   
   
           	SET @WFP_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		Set @SqlString='UPDATE M02_BPM.WFP_AuditFlow SET WFP_UptNo=CAST(WFP_UptNo AS INT)+1,WFP_LmDt='''+@WFP_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
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

