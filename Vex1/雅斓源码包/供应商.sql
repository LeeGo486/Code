USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_SU0_Supplier]    Script Date: 09/12/2013 10:35:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE proc   [API_GLERP].[Sp_SU0_Supplier]

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
	DECLARE @SU0_CONO	        VARCHAR(20)
	DECLARE @SU0_DIVI	        VARCHAR(20)
	DECLARE @SU0_SupplierId	    VARCHAR(100)
	DECLARE @SU0_SupplierCode	VARCHAR(20)
	DECLARE @SU0_UptNo	        VARCHAR(20)
	DECLARE @SU0_MAXUptNo       VARCHAR(20)
    DECLARE @MaxCode            VARCHAR(20)
    DECLARE @SU0_RgDt           VARCHAR(50)
    DECLARE @SU0_LmDt           VARCHAR(50)
    
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】') 
		begin
 
			set @HelpString=
			'【操作类型,GET】【实体,B01_MDM.SU0_Supplier】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》供应商ID,】【《W》供应商编号,】【《W》供应商分类,】【《W》供应商名称,】【《W》地址,】' +
			'【《W》联系人,】【《W》联系电话,】【《W》开户行,】【《W》银行账户,】【《W》银行地址,】【《W》银行SWFIT号,】' +
            '【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》修改人,】【《W》修改时间,】'	
            		
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B01_MDM.SU0_Supplier】【新增内容,必填】【条件内容,】'+
			'【《N》供应商分类,】【《N》供应商名称,】【《N》地址,】' +
			'【《N》联系人,】【《N》联系电话,】【《N》开户行,】【《N》银行账户,】【《N》银行地址,】【《N》银行SWFIT号,】' +
            '【《N》创建人,】【《N》修改人,】'					
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B01_MDM.SU0_Supplier】【更新内容,必填】'+
			'【《N》供应商分类,】【《N》供应商名称,】【《N》地址,】' +
			'【《N》联系人,】【《N》联系电话,】【《N》开户行,】【《N》银行账户,】【《N》银行地址,】【《N》银行SWFIT号,】' +
            '【《N》修改人,】'+
            '【《W》集团,】【《W》事业体,】'+
			'【《W》供应商ID,】【《W》供应商编号,】【《W》供应商分类,】【《W》供应商名称,】【《W》地址,】' +
			'【《W》联系人,】【《W》联系电话,】【《W》开户行,】【《W》银行账户,】【《W》银行地址,】【《W》银行SWFIT号,】' +
            '【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》修改人,】【《W》修改时间,】'										
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B01_MDM.SU0_Supplier】【更新内容,必填】【条件内容,】【《N》状态,】'+
			'【《N》修改人,】【《N》修改时间,】【《W》集团,】【《W》事业体,】' +
			'【《W》供应商ID,】【《W》供应商编号,】【《W》供应商分类,】【《W》供应商名称,】【《W》地址,】' +
			'【《W》联系人,】【《W》联系电话,】【《W》开户行,】【《W》银行账户,】【《W》银行地址,】【《W》银行SWFIT号,】' +
            '【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》修改人,】【《W》修改时间,】'			
			 
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
			'【集团,	    SU0_CONO~SU0_CONO,	                String,'														     +'】' + 
			'【事业体,	    SU0_DIVI~SU0_DIVI,	                String,'														     +'】' + 			
			'【供应商ID,	SU0_SupplierId~SU0_SupplierId,	    String,'										            	     +'】' + 			
			'【供应商编号,	SU0_SupplierCode~SU0_SupplierCode,	String,'										                     +'】' + 
			'【供应商分类,	SU0_SupplierType~SU0_SupplierType,	String,'										                     +'】' + 
			'【供应商名称,	SU0_SupplierName~SU0_SupplierName,	String,'										                     +'】' + 
			'【地址,	    SU0_Address~SU0_Address,	        String,'												             +'】' + 
			'【联系人,	    SU0_Contact~SU0_Contact,	        String,'												             +'】' + 
			'【联系电话,	SU0_Phone~SU0_Phone,	            String,'													         +'】' + 
			'【开户行,	    SU0_Bank~SU0_Bank,	                String,'														     +'】' + 
			'【银行账户,	SU0_BankAccount~SU0_BankAccount,	String,'										                     +'】' + 
			'【银行地址,	SU0_BankAddress~SU0_BankAddress,	String,'										                     +'】' + 
			'【银行SWFIT号,	SU0_BankSwift~SU0_BankSwift,	    String,'											                 +'】' + 
			'【状态,	    SU0_Status~SU0_Status,	            String,'													         +'】' + 
			'【创建人,	    SU0_RgUser~SU0_RgUser,	            String,'													         +'】' +
			'【创建时间,	SU0_RgDt~SU0_RgDt,	                String,'												    	     +'】' +	
			'【修改人,	    SU0_LmUser~SU0_LmUser,             	String,'													         +'】' +	
			'【修改时间,	SU0_LmDt~SU0_LmDt,	                String,'													         +'】' +	
			'【更新次数,	SU0_UptNo~SU0_UptNo,             	String,'													         +'】' +
			'【供应商分类,	DC0_DictName1~DC0_DictName1,        String,'													         +'】' +										
			'【《W》集团,        SU0_CONO,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	    +'】' +
            '【《W》事业体,      SU0_DIVI,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')     +'】' +
            '【《W》供应商ID,    SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商ID') ,'')   +'】' +
            '【《W》供应商编号,  SU0_SupplierCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')  +'】' +
            '【《W》供应商分类,  SU0_SupplierType,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商分类'),'')  +'】' +
            '【《W》供应商名称,  SU0_SupplierName,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商名称'),'')  +'】' +
            '【《W》地址,        SU0_Address,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》联系人'),'')      +'】' +
            '【《W》联系人,      SU0_Contact,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体'),'')      +'】' +
            '【《W》联系电话,    SU0_Phone,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》联系电话'),'')    +'】' +
            '【《W》开户行,      SU0_Bank,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》开户行') ,'')     +'】' +
            '【《W》银行账户,    SU0_BankAccount,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行账户'),'')    +'】' +
            '【《W》银行地址,    SU0_BankAddress,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行地址') ,'')   +'】' +
            '【《W》银行SWFIT号, SU0_BankSwift,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行SWFIT号'),'') +'】' +
            '【《W》状态,        SU0_Status,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')       +'】' +
            '【《W》创建人,      SU0_RgUser,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')     +'】' +
            '【《W》创建时间,    SU0_RgDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')    +'】' +
            '【《W》修改人,      SU0_LmUser,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改人') ,'')     +'】' +
            '【《W》修改时间,    SU0_LmDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改时间') ,'')   +'】' 
 	 
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
		Set @SqlString='select ' +  @SelectFieldList + ' from B01_MDM.SU0_Supplier LEFT JOIN  M01_CONF.DC0_Dictionary  ON  SU0_SupplierType=DC0_DictId where ' + @WhereFieldList
		+' ORDER BY SU0_LmDt'
 		
							
		
	end


if @mdl='NEW'  
	begin
	 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @MapString = 
		 									
		    --'【集团,        SU0_CONO,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》集团'),'')	     +'】' +
           -- '【事业体,      SU0_DIVI,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》事业体') ,'')     +'】' +
           -- '【供应商ID,    SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商ID') ,'')   +'】' +
           -- '【供应商编号,  SU0_SupplierCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')  +'】' +
            '【供应商分类,  SU0_SupplierType,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商分类'),'')  +'】' +
            '【供应商名称,  SU0_SupplierName,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商名称'),'')  +'】' +
            '【地址,        SU0_Address,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》地址'),'')      +'】' +
            '【联系人,      SU0_Contact,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》联系人'),'')      +'】' +
            '【联系电话,    SU0_Phone,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》联系电话'),'')    +'】' +
            '【开户行,      SU0_Bank,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》开户行') ,'')     +'】' +
            '【银行账户,    SU0_BankAccount,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》银行账户'),'')    +'】' +
            '【银行地址,    SU0_BankAddress,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》银行地址') ,'')   +'】' +
            '【银行SWFIT号, SU0_BankSwift,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》银行SWFIT号'),'') +'】' +
            '【状态,        SU0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态') ,'')       +'】' +
            '【创建人,      SU0_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人') ,'')     +'】' +
          --  '【创建时间,    SU0_RgDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建时间'),'')    +'】' +
            '【修改人,      SU0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改人') ,'')     +'】' 
           -- '【修改时间,    SU0_LmDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改时间') ,'')   +'】' 
            --'【修改次数,    SU0_UptNo,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改次数') ,'')   +'】' 

 
		
		SET @SU0_CONO='100'
		SET @SU0_DIVI='200'
		SET @SU0_SupplierId=newID() 
	    SET @SU0_UptNo='0'
		SET @SU0_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @SU0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
		
		SELECT @MaxCode=ISNULL(MAX(SU0_SupplierCode),'')  FROM B01_MDM.SU0_Supplier
        WHERE SU0_SupplierCode LIKE 'A'+'%'
		
		IF @MaxCode='' 
		BEGIN
		   SET @SU0_SupplierCode='A0001'
		END
		ELSE
		BEGIN
		   SET @SU0_SupplierCode='A'+RIGHT('0000'+cast(CAST(RIGHT(@MaxCode,4) AS INT)+1 as varchar(20)),4)  
		END
		

 
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
 
		Set @SqlString='INSERT INTO B01_MDM.SU0_Supplier(SU0_CONO,SU0_DIVI,SU0_SupplierId,SU0_SupplierCode,SU0_UptNo,SU0_RgDt,SU0_LmDt,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@SU0_CONO+''','''+@SU0_DIVI+''','		
		Set @SqlString=@SqlString+''''+@SU0_SupplierId+''','''+@SU0_SupplierCode+''','''+@SU0_UptNo+''','''+@SU0_RgDt+''','''+@SU0_LmDt+''','+@InsertFromValueList+')'
		PRINT @SqlString
		 
 		
							
		
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
		  									
            '【供应商分类,  SU0_SupplierType,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商分类'),'')  +'】' +
            '【供应商名称,  SU0_SupplierName,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商名称'),'')  +'】' +
            '【地址,        SU0_Address,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》联系人'),'')      +'】' +
            '【联系人,      SU0_Contact,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》事业体'),'')      +'】' +
            '【联系电话,    SU0_Phone,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》联系电话'),'')    +'】' +
            '【开户行,      SU0_Bank,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》开户行') ,'')     +'】' +
            '【银行账户,    SU0_BankAccount,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》银行账户'),'')    +'】' +
            '【银行地址,    SU0_BankAddress,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》银行地址') ,'')   +'】' +
            '【银行SWFIT号, SU0_BankSwift,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》银行SWFIT号'),'') +'】' +
            '【修改人,      SU0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改人') ,'')     +'】' +
            '【状态,        SU0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态') ,'')       +'】' +
            --'【修改时间,    SU0_LmDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改时间') ,'')   +'】' +
            --'【修改次数,    SU0_UptNo,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改次数') ,'')   +'】' +
			'【《W》集团,        SU0_CONO,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	    +'】' +
            '【《W》事业体,      SU0_DIVI,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')     +'】' +
            '【《W》供应商ID,    SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商ID') ,'')   +'】' +
            '【《W》供应商编号,  SU0_SupplierCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')  +'】' +
            '【《W》供应商分类,  SU0_SupplierType,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商分类'),'')  +'】' +
            '【《W》供应商名称,  SU0_SupplierName,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商名称'),'')  +'】' +
            '【《W》地址,        SU0_Address,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》联系人'),'')      +'】' +
            '【《W》联系人,      SU0_Contact,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体'),'')      +'】' +
            '【《W》联系电话,    SU0_Phone,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》联系电话'),'')    +'】' +
            '【《W》开户行,      SU0_Bank,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》开户行') ,'')     +'】' +
            '【《W》银行账户,    SU0_BankAccount,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行账户'),'')    +'】' +
            '【《W》银行地址,    SU0_BankAddress,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行地址') ,'')   +'】' +
            '【《W》银行SWFIT号, SU0_BankSwift,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行SWFIT号'),'') +'】' +
            '【《W》状态,        SU0_Status,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')       +'】' +
            '【《W》创建人,      SU0_RgUser,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')     +'】' +
            '【《W》创建时间,    SU0_RgDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')    +'】' +
            '【《W》修改人,      SU0_LmUser,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改人') ,'')     +'】' +
            '【《W》修改时间,    SU0_LmDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改时间') ,'')   +'】' 
			
	   SET @SU0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
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
		Set @SqlString='UPDATE B01_MDM.SU0_Supplier SET SU0_UptNo=CAST(SU0_UptNo AS INT)+1,SU0_LmDt='''+@SU0_LmDt+''',' +  @UpdateFieldList + '   where SU0_Status=''0'' ' + @WhereFieldList   
		 
 		print @SqlString
							
		 
	end
	
	
if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
             '【状态,        SU0_Status,     	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')          +'】' +
            '【修改人,      SU0_LmUser,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改人'),'')        +'】' +
          --  '【修改时间,    SU0_LmDt,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改时间'),'')      +'】' +
           -- '【修改次数,    SU0_UptNo,		    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》修改次数'),'')      +'】' +      		  								
			'【《W》集团,        SU0_CONO,	        String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')	    +'】' +
            '【《W》事业体,      SU0_DIVI,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')     +'】' +
            '【《W》供应商ID,    SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商ID') ,'')   +'】' +
            '【《W》供应商编号,  SU0_SupplierCode,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')  +'】' +
            '【《W》供应商分类,  SU0_SupplierType,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商分类'),'')  +'】' +
            '【《W》供应商名称,  SU0_SupplierName,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商名称'),'')  +'】' +
            '【《W》地址,        SU0_Address,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》联系人'),'')      +'】' +
            '【《W》联系人,      SU0_Contact,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体'),'')      +'】' +
            '【《W》联系电话,    SU0_Phone,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》联系电话'),'')    +'】' +
            '【《W》开户行,      SU0_Bank,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》开户行') ,'')     +'】' +
            '【《W》银行账户,    SU0_BankAccount,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行账户'),'')    +'】' +
            '【《W》银行地址,    SU0_BankAddress,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行地址') ,'')   +'】' +
            '【《W》银行SWFIT号, SU0_BankSwift,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》银行SWFIT号'),'') +'】' +
            '【《W》状态,        SU0_Status,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》状态') ,'')       +'】' +
            '【《W》创建人,      SU0_RgUser,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')     +'】' +
            '【《W》创建时间,    SU0_RgDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')    +'】' +
            '【《W》修改人,      SU0_LmUser,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改人') ,'')     +'】' +
            '【《W》修改时间,    SU0_LmDt,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》修改时间') ,'')   +'】' 
			
			  SET @SU0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		Set @SqlString='UPDATE B01_MDM.SU0_Supplier SET SU0_UptNo=CAST(SU0_UptNo AS INT)+1,SU0_LmDt='''+@SU0_LmDt+''',' +  @UpdateFieldList + '  where SU0_Status=''0'' and ' + @WhereFieldList 
		 
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

