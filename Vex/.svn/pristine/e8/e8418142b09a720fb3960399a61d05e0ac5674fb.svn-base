USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_PD0_Product]    Script Date: 09/12/2013 10:33:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 

CREATE proc [API_GLERP].[Sp_PD0_Product]

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
	DECLARE @PD0_CONO	        VARCHAR(20)
	DECLARE @PD0_DIVI	        VARCHAR(20)
	DECLARE @PD0_ProductId	    VARCHAR(100)
	DECLARE @PD0_UptNo          VARCHAR(20)
    DECLARE @PD0_RgDt           VARCHAR(50)
    DECLARE @PD0_LmDt           VARCHAR(50)
    
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】') 
		begin
 
			set @HelpString=
			'【操作类型,GET】【实体,B01_MDM.PD0_Product】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》商品ID,】【《W》供应商编号,】【《W》品牌编号,】【《W》供应商款号,】【《W》供应商颜色,】' +
			'【《W》供应商尺码,】【《W》供应商SKU,】【《W》款号,】【《W》颜色,】【《W》尺码,】【《W》SKU,】' +
            '【《W》年份,】【《W》季节,】【《W》款式种类,】【《W》款式大类,】【《W》款式小类,】【《W》产地,】'+	
            '【《W》成分,】【《W》等级,】【《W》执行标准,】【《W》安全技术类别,】【《W》采购价,】【《W》吊牌价,】'+	
            '【《W》单位,】【《W》是否打印,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】'+	
            '【《W》最后修改时间,】【《W》供应商颜色简称,】【《W》款图路径,】【《W》品名,】'			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B01_MDM.PD0_Product】【新增内容,必填】【条件内容,】'+
			'【《N》集团,】【《N》事业体,】'+
			'【《N》供应商编号,】【《N》品牌编号,】【《N》供应商款号,】【《N》供应商颜色,】'+
			'【《N》供应商尺码,】【《N》供应商SKU,】【《N》款号,】【《N》颜色,】【《N》尺码,】【《N》SKU,】' +
			'【《N》年份,】【《N》季节,】【《N》款式种类,】【《N》款式大类,】【《N》款式小类,】【《N》产地,】'+	
            '【《N》成分,】【《N》等级,】【《N》执行标准,】【《N》安全技术类别,】【《N》采购价,】【《N》吊牌价,】'+	
            '【《N》单位,】【《N》是否打印,】【《W》创建人,】【《N》最后修改人,】【《N》供应商颜色简称,】【《N》款图路径,】【《N》品名,】'			
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B01_MDM.PD0_Product】【更新内容,必填】'+
			'【《N》供应商编号,】【《N》品牌编号,】【《N》供应商款号,】【《N》供应商颜色,】'+
			'【《N》供应商尺码,】【《N》供应商SKU,】【《N》款号,】【《N》颜色,】【《N》尺码,】【《N》SKU,】' +
			'【《N》年份,】【《N》季节,】【《N》款式种类,】【《N》款式大类,】【《N》款式小类,】【《N》产地,】'+	
            '【《N》成分,】【《N》等级,】【《N》执行标准,】【《N》安全技术类别,】【《N》采购价,】【《N》吊牌价,】'+	
            '【《N》单位,】【《N》是否打印,】【《N》最后修改人,】【《N》供应商颜色简,】【《N》款图路径,】【《N》品名,】'+		          
            '【《W》集团,】【《W》事业体,】'+
            '【《W》商品ID,】【《W》供应商编号,】【《W》品牌编号,】【《W》供应商款号,】【《W》供应商颜色,】'+
			'【《W》供应商尺码,】【《W》供应商SKU,】【《W》款号,】【《W》颜色,】【《W》尺码,】【《W》SKU,】' +
			'【《W》年份,】【《W》季节,】【《W》款式种类,】【《W》款式大类,】【《W》款式小类,】【《W》产地,】'+	
            '【《W》成分,】【《W》等级,】【《W》执行标准,】【《W》安全技术类别,】【《W》采购价,】【《W》吊牌价,】'+	
            '【《W》单位,】【《W》是否打印,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】' +
            '【《W》最后修改时间,】【《W》供应商颜色简称,】【《W》款图路径,】【《W》品名,】'									
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B01_MDM.PD0_Product】【更新内容,必填】【条件内容,】【《N》状态,】'+
			'【《N》最后修改人,】【《N》修改时间,】'+
            '【《W》集团,】【《W》事业体,】'+
            '【《W》商品ID,】【《W》供应商编号,】【《W》品牌编号,】【《W》供应商款号,】【《W》供应商颜色,】'+
			'【《W》供应商尺码,】【《W》供应商SKU,】【《W》款号,】【《W》颜色,】【《W》尺码,】【《W》SKU,】' +
			'【《W》年份,】【《W》季节,】【《W》款式种类,】【《W》款式大类,】【《W》款式小类,】【《W》产地,】'+	
            '【《W》成分,】【《W》等级,】【《W》执行标准,】【《W》安全技术类别,】【《W》采购价,】【《W》吊牌价,】'+	
            '【《W》单位,】【《W》是否打印,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】' +
            '【《W》最后修改时间,】【《W》供应商颜色简称,】【《W》款图路径,】【《W》品名,】'										
			 
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
			'【集团,				PD0_CONO~PD0_CONO,	                        String,'														     +'】' + 
            '【事业体,				PD0_DIVI~PD0_DIVI,			                String,'														     +'】' + 
            '【商品ID,				PD0_ProductId~PD0_ProductId,		        String,'														     +'】' + 
            '【供应商编号,			PD0_SUO_SupplierId~PD0_SUO_SupplierId,		String,'														     +'】' + 
            '【品牌编号,			PD0_BD0_BrandId~PD0_BD0_BrandId,		    String,'														     +'】' + 
            '【供应商款号,			PD0_ProductCodeSU~PD0_ProductCodeSU,	    String,'														     +'】' + 
            '【供应商颜色,			PD0_ColorSUId~PD0_ColorSUId,			    String,'														     +'】' + 
            '【供应商尺码,			PD0_SizeSUId~PD0_SizeSUId,					String,'														     +'】' + 
            '【供应商SKU,			PD0_SKUSU~PD0_SKUSU,						String,'														     +'】' + 
            '【款号,	  			PD0_Code~PD0_Code,							String,'														     +'】' + 
            '【颜色,				PD0_ColorId~PD0_ColorId,					String,'														     +'】' + 
            '【尺码,				PD0_SizeId~PD0_SizeId,						String,'														     +'】' + 
            '【SKU,					PD0_SKU~PD0_SKU,							String,'														     +'】' + 
            '【年份,				PD0_YearId~PD0_YearId,						String,'														     +'】' + 
            '【季节,				PD0_SeasonId~PD0_SeasonId,					String,'														     +'】' + 
            '【款式种类,			PD0_Lvl1~PD0_Lvl1,							String,'														     +'】' + 
            '【款式大类,			PD0_Lvl2~PD0_Lvl2,							String,'														     +'】' + 
            '【款式小类,			PD0_Lvl3~PD0_Lvl3,							String,'														     +'】' + 
            '【产地,				PD0_SourceCountry~PD0_SourceCountry,	    String,'														     +'】' +  
            '【成分,				PD0_Composition~PD0_Composition,			String,'														     +'】' +  
            '【等级,				PD0_QulityLevel~PD0_QulityLevel,			String,'														     +'】' + 
            '【执行标准,			PD0_StandardId~PD0_StandardId,				String,'														     +'】' + 
            '【安全技术类别,		PD0_SecurityLevelId~PD0_SecurityLevelId,	String,'														     +'】' + 
            '【采购价,				PD0_PurchasePrice~PD0_PurchasePrice,		String,'														     +'】' + 
            '【吊牌价,				PD0_SalePrice~PD0_SalePrice,				String,'														     +'】' +  
            '【单位,				PD0_UnitId~PD0_UnitId,						String,'														     +'】' + 
            '【是否打印,			PD0_IsPrinted~PD0_IsPrinted,				String,'														     +'】' + 
            '【状态,				PD0_Status~PD0_Status,						String,'														     +'】' + 
            '【创建人,				PD0_RgUser~PD0_RgUser,						String,'														     +'】' + 
            '【创建时间,			PD0_RgDt~PD0_RgDt,							String,'														     +'】' + 
            '【最后修改人,			PD0_LmUser~PD0_LmUser,						String,'														     +'】' + 
            '【最后修改时间,		PD0_LmDt~PD0_LmDt,							String,'														     +'】' + 
            '【供应商颜色简称,      PD0_ColorBSUId~PD0_ColorBSUId,				String,'														     +'】' +
            '【款图路径,			PD0_PicPath~PD0_PicPath,					String,'														     +'】' +
            '【品名,				PD0_Lvl0~PD0_Lvl0,							String,'														     +'】' +
            '【供应商名称,			A.SU0_SupplierCode~SU0_SupplierCode,		String,'														     +'】' + 
            '【品牌名称,			B.BD0_BrandName~BD0_BrandName,				String,'														     +'】' + 
            '【年份名称,			C.DC0_DictName1~YearDictName,				String,'														     +'】' + 
            '【季节名称,			D.DC0_DictName1~SeasonDictName,			String,'																 +'】' +            
            '【执行标准名称,		E.DC0_DictName1~StandardDictName,			String,'														     +'】' + 
            '【安全技术类别名称,	F.DC0_DictName1~SecurityLevelDictName,		String,'														     +'】' + 
            '【供应商颜色名称,		G.DC0_DictName1~ColorSUDictName,			String,'														     +'】' + 
            '【供应商尺码名称,		H.DC0_DictName1~SizeSUDictName,			String,'																 +'】' + 
            '【款式种类名称,		I.DC0_DictName1~Lvl1DictName,				String,'														     +'】' + 
            '【款式大类名称,		J.DC0_DictName1~Lvl2DictName,				String,'														     +'】' + 
            '【供应商颜色简称名称,  K.DC0_DictName1~ColorBSUName,				String,'														     +'】' +        
            '【品名名称,			L.DC0_DictName1~Lvl0DictName,				String,'														     +'】' + 
            
            '【《W》集团,				PD0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	      +'】' +
            '【《W》事业体,				PD0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')       +'】' +
            '【《W》商品ID,				PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')       +'】' +
            '【《W》供应商编号,			PD0_SUO_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')    +'】' +
            '【《W》品牌编号,			PD0_BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌编号'),'')	  +'】' +
            '【《W》供应商款号,			PD0_ProductCodeSU,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商款号'),'')    +'】' +
            '【《W》供应商颜色,			PD0_ColorSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商颜色'),'')    +'】' +
            '【《W》供应商尺码,			PD0_SizeSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商尺码'),'')    +'】' +
            '【《W》供应商SKU,			PD0_SKUSU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商SKU'),'')     +'】' +
            '【《W》款号,				PD0_Code,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款号') ,'')         +'】' +
            '【《W》颜色,				PD0_ColorId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》颜色'),'')          +'】' +
            '【《W》尺码,				PD0_SizeId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》尺码') ,'')         +'】' +
            '【《W》SKU,				PD0_SKU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》SKU'),'')           +'】' +
            '【《W》年份,				PD0_YearId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》年份') ,'')         +'】' +
            '【《W》季节,				PD0_SeasonId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》季节') ,'')         +'】' + 
            '【《W》款式种类,			PD0_Lvl1,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式种类'),'')      +'】' +
            '【《W》款式大类,			PD0_Lvl2,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式大类'),'')      +'】' +
            '【《W》款式小类,			PD0_Lvl3,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式小类'),'')      +'】' +
            '【《W》产地,				PD0_SourceCountry,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》产地'),'')          +'】' +
            '【《W》成分,				PD0_Composition,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》成分'),'')          +'】' +
            '【《W》等级,				PD0_QulityLevel,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》等级') ,'')         +'】' +
            '【《W》执行标准,			PD0_StandardId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》执行标准'),'')      +'】' +
            '【《W》安全技术类别,		PD0_SecurityLevelId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》安全技术类别') ,'') +'】' +
            '【《W》采购价,				PD0_PurchasePrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购价'),'')        +'】' +
            '【《W》吊牌价,				PD0_SalePrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》吊牌价') ,'')       +'】' +
            '【《W》单位,				PD0_UnitId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单位') ,'')         +'】' +  
            '【《W》是否打印,			PD0_IsPrinted,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》是否打印') ,'')     +'】' +
            '【《W》状态,				PD0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')          +'】' +
            '【《W》创建人,				PD0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')       +'】' +
            '【《W》创建时间,			PD0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')      +'】' +
            '【《W》最后修改人,			PD0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')   +'】' +
            '【《W》最后修改时间,		PD0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')  +'】'+   
            '【《W》供应商颜色简称名称, PD0_ColorBSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商颜色简称名称') ,'')  +'】'+
            '【《W》款图路径,			PD0_PicPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款图路径') ,'')  +'】' +
            '【《W》品名,				PD0_Lvl0,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品名') ,'')  +'】' 
		
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
		Set @SqlString='select ' +  @SelectFieldList + ' from B01_MDM.PD0_Product 
		 LEFT JOIN  B01_MDM.SU0_Supplier    A ON  PD0_SUO_SupplierId=A.SU0_SupplierId
         LEFT JOIN  B01_MDM.BD0_Brand       B ON  PD0_BD0_BrandId=B.BD0_BrandId  
         LEFT JOIN  M01_CONF.DC0_Dictionary C ON  PD0_YearId=C.DC0_DictId  
         LEFT JOIN  M01_CONF.DC0_Dictionary D ON  PD0_SeasonId=D.DC0_DictId  
         LEFT JOIN  M01_CONF.DC0_Dictionary E ON  PD0_StandardId=E.DC0_DictId  
         LEFT JOIN  M01_CONF.DC0_Dictionary F ON  PD0_SecurityLevelId=F.DC0_DictId  
         LEFT JOIN  M01_CONF.DC0_Dictionary G ON  PD0_ColorSUId=G.DC0_DictId  
         LEFT JOIN  M01_CONF.DC0_Dictionary H ON  PD0_SizeSUId=H.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary I ON  PD0_Lvl1=I.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary J ON  PD0_Lvl2=J.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary K ON  PD0_ColorBSUId=K.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary L ON  PD0_Lvl0=L.DC0_DictId
		where ' + @WhereFieldList+' ORDER BY PD0_LmDt'
 		
		PRINT @SqlString					
		
	end


if @mdl='NEW'  
	begin
	 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @MapString =  
           -- '【集团,		     PD0_CONO~PD0_CONO,	                        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》集团'),'')	     +'】' +
           -- '【事业体,		     PD0_DIVI~PD0_DIVI,			                String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》事业体'),'')	     +'】' +
           -- '【商品ID,			 PD0_ProductId~PD0_ProductId,		        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')	     +'】' +
            '【供应商编号,			PD0_SUO_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')	     +'】' +
            '【品牌编号,			PD0_BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌编号'),'')	     +'】' +
            '【供应商款号,			PD0_ProductCodeSU,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商款号'),'')	     +'】' +
            '【供应商颜色,			PD0_ColorSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商颜色'),'')	     +'】' + 
            '【供应商尺码,			PD0_SizeSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商尺码'),'')	     +'】' +
            '【供应商SKU,			PD0_SKUSU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商SKU'),'')	     +'】' +
            '【款号,	  			PD0_Code,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款号'),'')			 +'】' +
            '【颜色,				PD0_ColorId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》颜色'),'')			 +'】' +
            '【尺码,				PD0_SizeId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》尺码'),'')			 +'】' +
            '【SKU,					PD0_SKU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》SKU'),'')				 +'】' +
            '【年份,				PD0_YearId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》年份'),'')			 +'】' +
            '【季节,				PD0_SeasonId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》季节'),'')			 +'】' +
            '【款式种类,			PD0_Lvl1,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式种类'),'')	     +'】' +
            '【款式大类,			PD0_Lvl2,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式大类'),'')	     +'】' +
            '【款式小类,			PD0_Lvl3,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式小类'),'')	     +'】' +
            '【产地,				PD0_SourceCountry,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》产地'),'')			 +'】' +
            '【成分,				PD0_Composition,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》成分'),'')			 +'】' +
            '【等级,				PD0_QulityLevel,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》等级'),'')			 +'】' +
            '【执行标准,			PD0_StandardId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》执行标准'),'')	     +'】' +
            '【安全技术类别,		PD0_SecurityLevelId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》安全技术类别'),'')	 +'】' +
            '【采购价,				PD0_PurchasePrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购价'),'')			 +'】' +
            '【吊牌价,				PD0_SalePrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》吊牌价'),'')			 +'】' +
            '【单位,				PD0_UnitId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单位'),'')			 +'】' +
            '【是否打印,			PD0_IsPrinted,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》是否打印'),'')	     +'】' +
            '【状态,				PD0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			 +'】' +
            '【创建人,				PD0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')			 +'】' +
           -- '【创建时间,         PD0_RgDt~PD0_RgDt,							String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建时间'),'')	     +'】' +
            '【最后修改人,			PD0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】'+ 
           -- '【最后修改时间,     PD0_LmDt~PD0_LmDt,							String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改时间'),'')	     +'】' 
           '【供应商颜色简称名称,	PD0_ColorBSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商颜色简称名称'),'')+'】'+
           '【款图路径,				PD0_PicPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款图路径'),'')	      +'】'+  
           '【品名,					PD0_Lvl0,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品名'),'')	      +'】'           
 		
		SET @PD0_CONO='100'
		SET @PD0_DIVI='200'
		SET @PD0_ProductId=newID() 
	    SET @PD0_UptNo='0'
		SET @PD0_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @PD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
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
 
		Set @SqlString='INSERT INTO B01_MDM.PD0_Product(PD0_CONO,PD0_DIVI,PD0_ProductId,PD0_UptNo,PD0_RgDt,PD0_LmDt,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@PD0_CONO+''','''+@PD0_DIVI+''','''+@PD0_ProductId+''','		
		Set @SqlString=@SqlString+''''+@PD0_UptNo+''','''+@PD0_RgDt+''','''+@PD0_LmDt+''',  '+@InsertFromValueList+')'
		
				
		
		PRINT @SqlString
		 
 		
							
		
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【供应商编号,			PD0_SUO_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')	     +'】' +
            '【品牌编号,			PD0_BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品牌编号'),'')	     +'】' +
            '【供应商款号,			PD0_ProductCodeSU,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商款号'),'')	     +'】' +
            '【供应商颜色,			PD0_ColorSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商颜色'),'')	     +'】' + 
            '【供应商尺码,			PD0_SizeSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商尺码'),'')	     +'】' +
            '【供应商SKU,			PD0_SKUSU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商SKU'),'')	     +'】' +
            '【款号,	  			PD0_Code,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款号'),'')			 +'】' +
            '【颜色,				PD0_ColorId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》颜色'),'')			 +'】' +
            '【尺码,				PD0_SizeId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》尺码'),'')			 +'】' +
            '【SKU,					PD0_SKU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》SKU'),'')				 +'】' +
            '【年份,				PD0_YearId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》年份'),'')			 +'】' +
            '【季节,				PD0_SeasonId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》季节'),'')			 +'】' +
            '【款式种类,			PD0_Lvl1,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式种类'),'')	     +'】' +
            '【款式大类,			PD0_Lvl2,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式大类'),'')	     +'】' +
            '【款式小类,			PD0_Lvl3,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式小类'),'')	     +'】' +
            '【产地,				PD0_SourceCountry,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》产地'),'')			 +'】' +
            '【成分,				PD0_Composition,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》成分'),'')			 +'】' +
            '【等级,				PD0_QulityLevel,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》等级'),'')			 +'】' +
            '【执行标准,			PD0_StandardId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》执行标准'),'')	     +'】' +
            '【安全技术类别,		PD0_SecurityLevelId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》安全技术类别'),'')	 +'】' +
            '【采购价,				PD0_PurchasePrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购价'),'')			 +'】' +
            '【吊牌价,				PD0_SalePrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》吊牌价'),'')			 +'】' +
            '【单位,				PD0_UnitId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单位'),'')			 +'】' +
            '【是否打印,			PD0_IsPrinted,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》是否打印'),'')	     +'】' +
            '【状态,				PD0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			 +'】' +
            '【创建人,				PD0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')			 +'】' +
            '【最后修改人,			PD0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】'+ 
            '【供应商颜色简称名称,	PD0_ColorBSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商颜色简称名称'),'')+'】'+
			'【款图路径,			PD0_PicPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款图路径'),'')	      +'】' +  
            '【品名,					PD0_Lvl0,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》品名'),'')	      +'】' +
            
            '【《W》集团,					PD0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	      +'】' +
            '【《W》事业体,					PD0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')       +'】' +
            '【《W》商品ID,					PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')       +'】' +
            '【《W》供应商编号,				PD0_SUO_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')    +'】' +
            '【《W》品牌编号,				PD0_BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌编号'),'')	  +'】' +
            '【《W》供应商款号,				PD0_ProductCodeSU,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商款号'),'')    +'】' +
            '【《W》供应商颜色,				PD0_ColorSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商颜色'),'')    +'】' +
            '【《W》供应商尺码,				PD0_SizeSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商尺码'),'')    +'】' +
            '【《W》供应商SKU,				PD0_SKUSU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商SKU'),'')     +'】' +
            '【《W》款号,					PD0_Code,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款号') ,'')         +'】' +
            '【《W》颜色,					PD0_ColorId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》颜色'),'')          +'】' +
            '【《W》尺码,					PD0_SizeId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》尺码') ,'')         +'】' +
            '【《W》SKU,					PD0_SKU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》SKU'),'')           +'】' +
            '【《W》年份,					PD0_YearId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》年份') ,'')         +'】' +
            '【《W》季节,					PD0_SeasonId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》季节') ,'')         +'】' + 
            '【《W》款式种类,				PD0_Lvl1,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式种类'),'')      +'】' +
            '【《W》款式大类,				PD0_Lvl2,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式大类'),'')      +'】' +
            '【《W》款式小类,				PD0_Lvl3,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式小类'),'')      +'】' +
            '【《W》产地,					PD0_SourceCountry,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》产地'),'')          +'】' +
            '【《W》成分,					PD0_Composition,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》成分'),'')          +'】' +
            '【《W》等级,					PD0_QulityLevel,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》等级') ,'')         +'】' +
            '【《W》执行标准,				PD0_StandardId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》执行标准'),'')      +'】' +
            '【《W》安全技术类别,			PD0_SecurityLevelId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》安全技术类别') ,'') +'】' +
            '【《W》采购价,					PD0_PurchasePrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购价'),'')        +'】' +
            '【《W》吊牌价,					PD0_SalePrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》吊牌价') ,'')       +'】' +
            '【《W》单位,					PD0_UnitId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单位') ,'')         +'】' +  
            '【《W》是否打印,				PD0_IsPrinted,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》是否打印') ,'')     +'】' +
            '【《W》状态,					PD0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')          +'】' +
            '【《W》创建人,					PD0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')       +'】' +
            '【《W》创建时间,				PD0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')      +'】' +
            '【《W》最后修改人,				PD0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')   +'】' +
            '【《W》最后修改时间,			PD0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')  +'】'+               
			'【《W》供应商颜色简称名称,     PD0_ColorBSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商颜色简称名称') ,'')  +'】'+  
			'【《W》款图路径,				PD0_PicPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款图路径') ,'')  +'】'  + 
			'【《W》品名,					PD0_Lvl0,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品名') ,'')  +'】' 
		SET @PD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
 
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
		Set @SqlString='UPDATE B01_MDM.PD0_Product SET PD0_UptNo=CAST(PD0_UptNo AS INT)+1,PD0_LmDt='''+@PD0_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
	end
	
	
if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【状态,						PD0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	      +'】' +
            '【最后修改人,					PD0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	  +'】' +            
            '【《W》集团,					PD0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	      +'】' +
            '【《W》事业体,					PD0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')       +'】' +
            '【《W》商品ID,					PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')       +'】' +
            '【《W》供应商编号,				PD0_SUO_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')    +'】' +
            '【《W》品牌编号,				PD0_BD0_BrandId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品牌编号'),'')	  +'】' +
            '【《W》供应商款号,				PD0_ProductCodeSU,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商款号'),'')    +'】' +
            '【《W》供应商颜色,				PD0_ColorSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商颜色'),'')    +'】' +
            '【《W》供应商尺码,				PD0_SizeSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商尺码'),'')    +'】' +
            '【《W》供应商SKU,				PD0_SKUSU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商SKU'),'')     +'】' +
            '【《W》款号,					PD0_Code,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款号') ,'')         +'】' +
            '【《W》颜色,					PD0_ColorId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》颜色'),'')          +'】' +
            '【《W》尺码,					PD0_SizeId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》尺码') ,'')         +'】' +
            '【《W》SKU,					PD0_SKU,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》SKU'),'')           +'】' +
            '【《W》年份,					PD0_YearId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》年份') ,'')         +'】' +
            '【《W》季节,					PD0_SeasonId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》季节') ,'')         +'】' + 
            '【《W》款式种类,				PD0_Lvl1,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式种类'),'')      +'】' +
            '【《W》款式大类,				PD0_Lvl2,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式大类'),'')      +'】' +
            '【《W》款式小类,				PD0_Lvl3,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款式小类'),'')      +'】' +
            '【《W》产地,					PD0_SourceCountry,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》产地'),'')          +'】' +
            '【《W》成分,					PD0_Composition,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》成分'),'')          +'】' +
            '【《W》等级,					PD0_QulityLevel,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》等级') ,'')         +'】' +
            '【《W》执行标准,				PD0_StandardId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》执行标准'),'')      +'】' +
            '【《W》安全技术类别,			PD0_SecurityLevelId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》安全技术类别') ,'') +'】' +
            '【《W》采购价,					PD0_PurchasePrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购价'),'')        +'】' +
            '【《W》吊牌价,					PD0_SalePrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》吊牌价') ,'')       +'】' +
            '【《W》单位,					PD0_UnitId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单位') ,'')         +'】' +  
            '【《W》是否打印,				PD0_IsPrinted,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》是否打印') ,'')     +'】' +
            '【《W》状态,					PD0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态'),'')          +'】' +
            '【《W》创建人,					PD0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')       +'】' +
            '【《W》创建时间,				PD0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')      +'】' +
            '【《W》最后修改人,				PD0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')   +'】' +
            '【《W》最后修改时间,			PD0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')  +'】'+              
			'【《W》供应商颜色简称名称,     PD0_ColorBSUId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商颜色简称名称') ,'')  +'】'+  
			'【《W》款图路径,				PD0_PicPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》款图路径') ,'')  +'】' +   
            '【《W》品名,					PD0_Lvl0,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》品名') ,'')  +'】' 
		SET @PD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
           	SET @PD0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
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
		Set @SqlString='UPDATE B01_MDM.PD0_Product SET PD0_UptNo=CAST(PD0_UptNo AS INT)+1,PD0_LmDt='''+@PD0_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
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

