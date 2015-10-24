USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_BD0_Brand]    Script Date: 09/12/2013 10:30:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc   [API_GLERP].[Sp_BD0_Brand]

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
	DECLARE @BD0_CONO	        VARCHAR(20)
	DECLARE @BD0_DIVI	        VARCHAR(20)
	DECLARE @BD0_BrandId	    VARCHAR(100)
	DECLARE @BD0_UptNo	        VARCHAR(20)
    DECLARE @BD0_RgDt           VARCHAR(50)
    DECLARE @BD0_LmDt           VARCHAR(50)
   

	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】') 
		begin
 
			set @HelpString=
			'【操作类型,GET】【实体,B01_MDM.BD0_Brand】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》品牌ID,】【《W》品牌编码,】【《W》供应商编号,】【《W》品牌名称,】【《W》品牌所在国家,】' +
			'【《W》品牌风格,】【《W》目标群体,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】' +
            '【《W》修改时间,】'	
            		
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B01_MDM.BD0_Brand】【新增内容,必填】【条件内容,】'+
			'【《N》品牌编码,】【《N》供应商编号,】【《N》品牌名称,】【《N》品牌所在国家,】' +
			'【《N》品牌风格,】【《N》目标群体,】【《N》状态,】【《N》创建人,】【《N》最后修改人,】' 
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B01_MDM.BD0_Brand】【更新内容,必填】'+
			'【《N》品牌编码,】【《N》供应商编号,】【《N》品牌名称,】【《N》品牌所在国家,】' +
			'【《N》品牌风格,】【《N》目标群体,】【《N》状态,】【《N》最后修改人,】'+
            '【《W》集团,】【《W》事业体,】'+
			'【《W》品牌ID,】【《W》品牌编码,】【《W》供应商编号,】【《W》品牌名称,】【《W》品牌所在国家,】' +
			'【《W》品牌风格,】【《W》目标群体,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】' +
            '【《W》修改时间,】'											
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B01_MDM.BD0_Brand】【更新内容,必填】【条件内容,】'+
			'【《N》状态,】【《N》最后修改人,】【《N》修改时间,】'+
            '【《W》集团,】【《W》事业体,】'+
			'【《W》品牌ID,】【《W》品牌编码,】【《W》供应商编号,】【《W》品牌名称,】【《W》品牌所在国家,】' +
			'【《W》品牌风格,】【《W》目标群体,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】' +
            '【《W》修改时间,】'			
			 
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
			'【集团,				BD0_CONO~BD0_CONO,	                    String,'														     +'】' + 
            '【事业体,				BD0_DIVI~BD0_DIVI,			            String,'														     +'】' + 
            '【品牌ID,				BD0_BrandId~BD0_BrandId,		        String,'														     +'】' + 
            '【品牌编码,			BD0_BrandCode~BD0_BrandCode,		    String,'														     +'】' + 
            '【供应商编号,			BD0_SU0_SupplierId~BD0_SU0_SupplierId,	String,'														     +'】' + 
            '【品牌名称,			BD0_BrandName~BD0_BrandName,		    String,'														     +'】' + 
            '【品牌所在国家,		BD0_CountryId~BD0_CountryId,	        String,'														     +'】' + 
            '【品牌风格,		    BD0_StyleId~BD0_StyleId,		        String,'														     +'】' + 
            '【目标群体,	  	    BD0_CusGrpId~BD0_CusGrpId,		        String,'														     +'】' + 
            '【状态,				BD0_Status~BD0_Status,			        String,'														     +'】' + 
            '【创建人,			    BD0_RgUser~BD0_RgUser,		       	    String,'														     +'】' + 
            '【创建时间,		    BD0_RgDt~BD0_RgDt,			            String,'														     +'】' + 
            '【最后修改人,		    BD0_LmUser~BD0_LmUser,			        String,'														     +'】' + 
            '【修改时间,		    BD0_LmDt~BD0_LmDt,			            String,'														     +'】' + 
            '【更新次数,            BD0_UptNo~BD0_UptNo,			        String,'														     +'】' + 
            '【供应商名称,          A.SU0_SupplierCode~SU0_SupplierCode,    String,'								                             +'】' + 
            '【国家名称,            B.DC0_DictName1~CountryDictName,		String,'														     +'】' + 
            '【品牌风格名称,        C.DC0_DictName1~StyleDictName,			String,'														     +'】' + 
            '【目标群体名称,        D.DC0_DictName1~CusGrpDictName,			String,'														     +'】' +            
            '【《W》集团,			BD0_CONO,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	      +'】' +
            '【《W》事业体,			BD0_DIVI,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')       +'】' +
            '【《W》品牌ID,			BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌ID') ,'')       +'】' +
            '【《W》品牌编码,		BD0_BrandCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌编码'),'')      +'】' +
            '【《W》供应商编号,		BD0_SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')    +'】' +
            '【《W》品牌名称,		BD0_BrandName,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌名称'),'')      +'】' +
            '【《W》品牌所在国家,	BD0_CountryId,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌所在国家'),'')  +'】' +
            '【《W》品牌风格,       BD0_StyleId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌风格'),'')      +'】' +
            '【《W》目标群体,	    BD0_CusGrpId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》目标群体'),'')      +'】' +
            '【《W》状态,			BD0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')         +'】' +
            '【《W》创建人,		    BD0_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人'),'')        +'】' +
            '【《W》创建时间,       BD0_RgDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')     +'】' +
            '【《W》最后修改人,     BD0_LmUser,		    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人'),'')    +'】' +
            '【《W》修改时间,       BD0_LmDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改时间') ,'')     +'】' +
            '【《W》更新次数,       BD0_UptNo,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》更新次数') ,'')     +'】'  
             
             
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
		PRINT @SelectFieldList		
		Set @SqlString='select ' +  @SelectFieldList + ' from B01_MDM.BD0_Brand 
		  LEFT JOIN  B01_MDM.SU0_Supplier A    ON  BD0_SU0_SupplierId=A.SU0_SupplierId   
          LEFT JOIN  M01_CONF.DC0_Dictionary B ON  BD0_CountryId=B.DC0_DictId  
          LEFT JOIN  M01_CONF.DC0_Dictionary C ON  BD0_StyleId=C.DC0_DictId 
          LEFT JOIN  M01_CONF.DC0_Dictionary D ON  BD0_CusGrpId=D.DC0_DictId               
		  where ' + @WhereFieldList
 		+' ORDER BY BD0_LmUser'
		PRINT @SelectFieldList					
		
	end


if @mdl='NEW'  
	begin
	 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @MapString =  
            '【供应商编号,		BD0_SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')     +'】' +
            '【品牌名称,		BD0_BrandName,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌名称'),'')       +'】' +
            '【品牌所在国家,	BD0_CountryId,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌所在国家'),'')   +'】' +
            '【品牌风格,        BD0_StyleId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌风格'),'')       +'】' +
            '【目标群体,	    BD0_CusGrpId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》目标群体'),'')       +'】' +
            '【状态,			BD0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态') ,'')          +'】' +
            '【创建人,		    BD0_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')         +'】' +
            '【最后修改人,      BD0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')     +'】' 
            
 
		
		SET @BD0_CONO='100'
		SET @BD0_DIVI='200'
		SET @BD0_BrandId=newID() 
	    SET @BD0_UptNo='0'
		SET @BD0_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @BD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
 
 
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
 
		Set @SqlString='INSERT INTO B01_MDM.BD0_Brand(BD0_CONO,BD0_DIVI,BD0_BrandId,BD0_UptNo,BD0_RgDt,BD0_LmDt,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@BD0_CONO+''','''+@BD0_DIVI+''','''+@BD0_BrandId+''','		
		Set @SqlString=@SqlString+''''+@BD0_UptNo+''','''+@BD0_RgDt+''','''+@BD0_LmDt+''',  '+@InsertFromValueList+')'
		
		
		
		PRINT @SqlString
		 
 		
							
		
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【品牌ID,			    BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌ID') ,'')       +'】' +
            '【品牌编码,		    BD0_BrandCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌编码'),'')      +'】' +
            '【供应商编号,		    BD0_SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')    +'】' +
            '【品牌名称,		    BD0_BrandName,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌名称'),'')      +'】' +
            '【品牌所在国家,	    BD0_CountryId,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌所在国家'),'')  +'】' +
            '【品牌风格,            BD0_StyleId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌风格'),'')      +'】' +
            '【目标群体,	        BD0_CusGrpId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》目标群体'),'')      +'】' +
            '【最后修改人,          BD0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')    +'】' +
            '【状态,			    BD0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态') ,'')         +'】' +
            '【《W》集团,			BD0_CONO,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	      +'】' +
            '【《W》事业体,			BD0_DIVI,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')       +'】' +
            '【《W》品牌ID,			BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌ID') ,'')       +'】' +
            '【《W》品牌编码,		BD0_BrandCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌编码'),'')      +'】' +
            '【《W》供应商编号,		BD0_SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')    +'】' +
            '【《W》品牌名称,		BD0_BrandName,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌名称'),'')      +'】' +
            '【《W》品牌所在国家,	BD0_CountryId,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌所在国家'),'')  +'】' +
            '【《W》品牌风格,       BD0_StyleId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌风格'),'')      +'】' +
            '【《W》目标群体,	    BD0_CusGrpId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》目标群体'),'')      +'】' +
            '【《W》状态,			BD0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')         +'】' +
            '【《W》创建人,		    BD0_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人'),'')        +'】' +
            '【《W》创建时间,       BD0_RgDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')     +'】' +
            '【《W》最后修改人,     BD0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人'),'')    +'】' +
            '【《W》修改时间,       BD0_LmDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改时间') ,'')     +'】' 

             
             
             
	   SET @BD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
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
		Set @SqlString='UPDATE B01_MDM.BD0_Brand SET BD0_UptNo=CAST(BD0_UptNo AS INT)+1,BD0_LmDt='''+@BD0_LmDt+''', ' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
	end
	
	
if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
 
            '【最后修改人,          BD0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')   +'】' + 
            '【状态,			    BD0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态') ,'')        +'】' +                      
            '【《W》集团,			BD0_CONO,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	     +'】' +
            '【《W》事业体,			BD0_DIVI,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')      +'】' +
            '【《W》品牌ID,			BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌ID') ,'')      +'】' +
            '【《W》品牌编码,		BD0_BrandCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌编码'),'')     +'】' +
            '【《W》供应商编号,		BD0_SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')   +'】' +
            '【《W》品牌名称,		BD0_BrandName,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌名称'),'')     +'】' +
            '【《W》品牌所在国家,	BD0_CountryId,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌所在国家'),'') +'】' +
            '【《W》品牌风格,        BD0_StyleId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌风格'),'')     +'】' +
            '【《W》目标群体,	    BD0_CusGrpId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》目标群体'),'')     +'】' +
            '【《W》状态,			BD0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')        +'】' +
            '【《W》创建人,		    BD0_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人'),'')       +'】' +
            '【《W》创建时间,        BD0_RgDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间') ,'')    +'】' +
            '【《W》最后修改人,      BD0_LmUser,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人'),'')   +'】' +
            '【《W》修改时间,        BD0_LmDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改时间') ,'')    +'】' 
            
   
      SET @BD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
   
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
		Set @SqlString='UPDATE B01_MDM.BD0_Brand SET BD0_UptNo=CAST(BD0_UptNo AS INT)+1,BD0_LmDt='''+@BD0_LmDt+''', ' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
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

