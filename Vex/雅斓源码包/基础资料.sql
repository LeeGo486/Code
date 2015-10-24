USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_DC0_Dictionary]    Script Date: 09/12/2013 10:30:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 

CREATE proc [API_GLERP].[Sp_DC0_Dictionary]

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
	DECLARE @DC0_CONO	        VARCHAR(20)
	DECLARE @DC0_DIVI	        VARCHAR(20)
	DECLARE @DC0_DictId	        VARCHAR(100)
	DECLARE @DC0_UptNo          VARCHAR(20)
    DECLARE @DC0_RgDt           VARCHAR(50)
    DECLARE @DC0_LmDt           VARCHAR(50)
    
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
  
			set @HelpString=
			'【操作类型,GET】【实体,M01_CONF.DC0_Dictionary】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》字典ID,】【《W》字典父节点,】【《W》字典类型,】【《W》字典名称,】【《W》字典名称2,】' +
			'【《W》字典名称3,】【《W》字典名称4,】【《W》字典名称5,】【《W》字典状态,】 ' +
			'【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】'+	
            '【《W》最后修改时间,】'			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,M01_CONF.DC0_Dictionary】【新增内容,必填】【条件内容,】'+
			'【《N》字典父节点,】【《N》字典类型,】【《N》字典名称,】【《N》字典名称2,】'+
			'【《N》字典名称3,】【《N》字典名称4,】【《N》字典名称5,】【《W》字典状态,】【《N》创建人,】【《N》最后修改人,】'  		
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,M01_CONF.DC0_Dictionary】【更新内容,必填】'+
			'【《N》字典父节点,】【《N》字典类型,】【《N》字典名称,】【《N》字典名称2,】'+
			'【《N》字典名称3,】【《N》字典名称4,】【《N》字典名称5,】【《N》字典状态,】【《N》最后修改人,】'+		          
            '【《W》集团,】【《W》事业体,】'+
			'【《W》字典ID,】【《W》字典父节点,】【《W》字典类型,】【《W》字典名称,】【《W》字典名称2,】' +
			'【《W》字典名称3,】【《W》字典名称4,】【《W》字典名称5,】【《W》字典状态,】 ' +
			'【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】'+	
            '【《W》最后修改时间,】'												
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,M01_CONF.DC0_Dictionary】【更新内容,必填】【条件内容,】【《N》字典状态,】'+
			'【《N》最后修改人,】【《N》修改时间,】'+
            '【《W》集团,】【《W》事业体,】'+
			'【《W》字典ID,】【《W》字典父节点,】【《W》字典类型,】【《W》字典名称,】【《W》字典名称2,】' +
			'【《W》字典名称3,】【《W》字典名称4,】【《W》字典名称5,】【《W》字典状态,】 ' +
			'【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】'+	
            '【《W》最后修改时间,】'											
			 
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
			'【集团,		     B.DC0_CONO~DC0_CONO,	                    String,'														     +'】' + 
            '【事业体,		     B.DC0_DIVI~DC0_DIVI,			            String,'														     +'】' + 
            '【字典ID,			 B.DC0_DictId~DC0_DictId,		            String,'														     +'】' + 
            '【字典父节点,		 B.DC0_FartherDictId~DC0_FartherDictId,		String,'														     +'】' + 
            '【字典名称,		 B.DC0_DictName1~DC0_DictName1,	            String,'														     +'】' + 
            '【字典名称2,		 B.DC0_DictName2~DC0_DictName2,			    String,'														     +'】' + 
            '【字典名称3,		 B.DC0_DictName3~DC0_DictName3,				String,'														     +'】' + 
            '【字典名称4,		 B.DC0_DictName4~DC0_DictName4,				String,'														     +'】' + 
            '【字典名称5,	  	 B.DC0_DictName5~DC0_DictName5,			    String,'														     +'】' + 
            '【字典状态,	     B.DC0_DictStatus~DC0_DictStatus,		    String,'														     +'】' + 
            '【创建人,			 B.DC0_RgUser~DC0_RgUser,					String,'														     +'】' + 
            '【创建时间,		 B.DC0_RgDt~DC0_RgDt,					    String,'														     +'】' + 
            '【最后修改人,		 B.DC0_LmUser~DC0_LmUser,					String,'														     +'】' + 
            '【最后修改时间,     B.DC0_LmDt~DC0_LmDt,					    String,'														     +'】' +             
            '【更新次数,         B.DC0_UptNo~DC0_UptNo,						String,'														     +'】' +     
          
            '【《W》集团,			A.DC0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	      +'】' +
            '【《W》事业体,			A.DC0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')       +'】' +
            '【《W》字典ID,			A.DC0_DictId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典ID') ,'')       +'】' +
            '【《W》字典父节点,		A.DC0_FartherDictId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典父节点'),'')    +'】' +
            '【《W》字典名称,		A.DC0_DictName1,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称'),'')      +'】' +
            '【《W》字典名称2,	    A.DC0_DictName2,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称2'),'')     +'】' +
            '【《W》字典名称3,      A.DC0_DictName3,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称3'),'')     +'】' +
            '【《W》字典名称4,	    A.DC0_DictName4,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称4'),'')     +'】' +
            '【《W》字典名称5,		A.DC0_DictName5,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称5') ,'')    +'】' +
            '【《W》字典状态,		A.DC0_DictStatus,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典状态'),'')      +'】' +
            '【《W》创建人,			A.DC0_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')       +'】' +
            '【《W》创建时间,		A.DC0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')      +'】' +
            '【《W》最后修改人,		A.DC0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')   +'】' +
            '【《W》最后修改时间,	A.DC0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'') +'】' 
              
             
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
	    FROM   M01_CONF.DC0_Dictionary A,M01_CONF.DC0_Dictionary B  WITH ( NOLOCK ) 
		where A.DC0_DictId=B.DC0_FartherDictId AND ' + @WhereFieldList
 		+' ORDER BY B.DC0_LmDt'
		PRINT @SqlString					
		
	end


if @mdl='NEW'  
	begin
	 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @MapString =  
 
            '【字典父节点,		 DC0_FartherDictId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典父节点'),'')	     +'】' +
            '【字典名称,		 DC0_DictName1,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称'),'')	     +'】' +
            '【字典名称2,		 DC0_DictName2,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称2'),'')	     +'】' +
            '【字典名称3,		 DC0_DictName3,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称3'),'')	     +'】' + 
            '【字典名称4,		 DC0_DictName4,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称4'),'')	     +'】' +
            '【字典名称5,		 DC0_DictName5,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称5'),'')	     +'】' +
            '【字典状态,	  	 DC0_DictStatus,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典状态'),'')	     +'】' +
            '【创建人,			 DC0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')	         +'】' +
            '【最后修改人,	     DC0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' 
             
                    
 		
		SET @DC0_CONO='100'
		SET @DC0_DIVI='200'
		SET @DC0_DictId=newID() 
	    SET @DC0_UptNo='0'
		SET @DC0_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @DC0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
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
 
		Set @SqlString='INSERT INTO  M01_CONF.DC0_Dictionary(DC0_CONO,DC0_DIVI,DC0_DictId,DC0_UptNo,DC0_RgDt,DC0_LmDt,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@DC0_CONO+''','''+@DC0_DIVI+''','''+@DC0_DictId+''','		
		Set @SqlString=@SqlString+''''+@DC0_UptNo+''','''+@DC0_RgDt+''','''+@DC0_LmDt+''',  '+@InsertFromValueList+')'
		
				
		
		PRINT @SqlString
		 
 		
							
		
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【字典父节点,		 DC0_FartherDictId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典父节点'),'')	     +'】' +
            '【字典名称,		 DC0_DictName1,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称'),'')	     +'】' +
            '【字典名称2,		 DC0_DictName2,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称2'),'')	     +'】' +
            '【字典名称3,		 DC0_DictName3,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称3'),'')	     +'】' + 
            '【字典名称4,		 DC0_DictName4,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称4'),'')	     +'】' +
            '【字典名称5,		 DC0_DictName5,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典名称5'),'')	     +'】' +
            '【字典状态,	  	 DC0_DictStatus,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》字典状态'),'')	     +'】' +
            '【状态,             DC0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【创建人,			 DC0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')	         +'】' +
            '【最后修改人,	     DC0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +
             
            
            '【《W》集团,			DC0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	      +'】' +
            '【《W》事业体,			DC0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')       +'】' +
            '【《W》字典ID,			DC0_DictId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典ID') ,'')       +'】' +
            '【《W》字典父节点,		DC0_FartherDictId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典父节点'),'')    +'】' +
            '【《W》字典名称,		DC0_DictName1,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称'),'')      +'】' +
            '【《W》字典名称2,	    DC0_DictName2,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称2'),'')     +'】' +
            '【《W》字典名称3,      DC0_DictName3,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称3'),'')     +'】' +
            '【《W》字典名称4,	    DC0_DictName4,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称4'),'')     +'】' +
            '【《W》字典名称5,		DC0_DictName5,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称5') ,'')    +'】' +
            '【《W》字典状态,		DC0_DictStatus,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典状态'),'')      +'】' +
            '【《W》创建人,			DC0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')       +'】' +
            '【《W》创建时间,		DC0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')      +'】' +
            '【《W》最后修改人,		DC0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')   +'】' +
            '【《W》最后修改时间,	DC0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'') +'】' 
             

		SET @DC0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
 
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
		Set @SqlString='UPDATE M01_CONF.DC0_Dictionary SET DC0_UptNo=CAST(DC0_UptNo AS INT)+1,DC0_LmDt='''+@DC0_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
	end
	
	
if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【状态,				DC0_Status,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【最后修改人,			DC0_LmUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +          
            '【《W》集团,			DC0_CONO,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	      +'】' +
            '【《W》事业体,			DC0_DIVI,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')       +'】' +
            '【《W》字典ID,			DC0_DictId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典ID') ,'')       +'】' +
            '【《W》字典父节点,		DC0_FartherDictId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典父节点'),'')    +'】' +
            '【《W》字典名称,		DC0_DictName1,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称'),'')      +'】' +
            '【《W》字典名称2,	    DC0_DictName2,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称2'),'')     +'】' +
            '【《W》字典名称3,      DC0_DictName3,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称3'),'')     +'】' +
            '【《W》字典名称4,	    DC0_DictName4,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称4'),'')     +'】' +
            '【《W》字典名称5,		DC0_DictName5,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典名称5') ,'')    +'】' +
            '【《W》字典状态,		DC0_DictStatus,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》字典状态'),'')      +'】' +
            '【《W》创建人,			DC0_RgUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')       +'】' +
            '【《W》创建时间,		DC0_RgDt,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')      +'】' +
            '【《W》最后修改人,		DC0_LmUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')   +'】' +
            '【《W》最后修改时间,	DC0_LmDt,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'') +'】' 
             
   
   
           	SET @DC0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
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
		Set @SqlString='UPDATE M01_CONF.DC0_Dictionary SET DC0_UptNo=CAST(DC0_UptNo AS INT)+1,DC0_LmDt='''+@DC0_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
	end

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

