USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_PR0_Contract]    Script Date: 09/12/2013 10:33:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc [API_GLERP].[Sp_PR0_Contract]

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
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
  
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.PR0_Contract】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》合同ID,】【《W》合同编号,】【《W》供应商编号,】【《W》合同金额,】【《W》结算币种,】' +
			'【《W》合同说明,】【《W》合同状态,】【《W》合同扫描件,】【《W》合同开始时间,】【《W》合同截止时间,】 ' +
			'【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】【《W》结算方式,】'			
			
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
		set @MapString = 
			'【集团,		     PR0_CONO~DC0_CONO,							String,'														     +'】' + 
            '【事业体,		     PR0_DIVI~DC0_DIVI,							String,'														     +'】' + 
            '【合同ID,			 PR0_ContractId~PR0_ContractId,		        String,'														     +'】' + 
            '【合同编号,		 PR0_ContractCode~PR0_ContractCode,			String,'														     +'】' + 
            '【供应商编号,		 PR0_SU0_SupplierId~PR0_SU0_SupplierId,	    String,'														     +'】' + 
            '【合同金额,		 PR0_Amount~PR0_Amount,						String,'														     +'】' + 
            '【结算币种,		 PR0_CurrencyId~PR0_CurrencyId,				String,'														     +'】' + 
            '【合同说明,		 PR0_Description~PR0_Description,			String,'														     +'】' + 
            '【合同状态,	  	 PR0_Status~PR0_Status,						String,'														     +'】' + 
            '【合同扫描件,	     PR0_ECopyPath~PR0_ECopyPath,				String,'														     +'】' + 
            '【合同开始时间,	 PR0_StartDate~PR0_StartDate,				String,'														     +'】' + 
            '【合同截止时间,	 PR0_EndDate~PR0_EndDate,					String,'														     +'】' + 
            '【创建人,		     PR0_RgUser~PR0_RgUser,						String,'														     +'】' + 
            '【创建时间,         PR0_RgDt~PR0_RgDt,							String,'														     +'】' +             
            '【最后修改人,       PR0_LmUser~PR0_LmUser,						String,'														     +'】' +     
            '【最后修改时间,     PR0_LmDt~PR0_LmDt,						    String,'														     +'】' +  
            '【修改次数,         PR0_UptNo~PR0_UptNo,						String,'														     +'】' +                         
            '【结算方式,         PR0_SettleAccount~PR0_SettleAccount,		String,'														     +'】' + 
            '【供应商编号,       A.SU0_SupplierCode ~SU0_SupplierCode,		String,'														     +'】' +               
            '【节点名称1,        B.WFT_NODE~WFT_NODE1,						String,'														     +'】' +   
            '【节点名称2,        C.WFT_NODE~WFT_NODE2,						String,'														     +'】' +  
            '【节点名称3,        D.WFT_NODE~WFT_NODE3,						String,'														     +'】' +  
            '【节点名称4,        E.WFT_NODE~WFT_NODE4,						String,'														     +'】' +  
            '【节点名称5,        F.WFT_NODE~WFT_NODE5,						String,'														     +'】' +              
            '【审批结果1,        L.DC0_DICTNAME1~DC0_DICTNAME1,				String,'														     +'】' +  
            '【审批结果2,        M.DC0_DICTNAME1~DC0_DICTNAME2,				String,'														     +'】' +  
            '【审批结果3,        N.DC0_DICTNAME1~DC0_DICTNAME3,				String,'														     +'】' +  
            '【审批结果4,        O.DC0_DICTNAME1~DC0_DICTNAME4,				String,'														     +'】' +  
            '【审批结果5,        P.DC0_DICTNAME1~DC0_DICTNAME5,				String,'														     +'】' +  
            '【审批流ID1,        G.WFP_AFID~WFP_AFID1,						String,'														     +'】' + 
            '【审批流ID2,        H.WFP_AFID~WFP_AFID2,						String,'														     +'】' + 
            '【审批流ID3,        I.WFP_AFID~WFP_AFID3,						String,'														     +'】' + 
            '【审批流ID4,        J.WFP_AFID~WFP_AFID4,						String,'														     +'】' + 
            '【审批流ID5,        K.WFP_AFID~WFP_AFID5,						String,'														     +'】' +                          
            '【审批时间1,        G.WFP_AuditTime~WFP_AuditTime1,			String,'														     +'】' + 
            '【审批时间2,        H.WFP_AuditTime~WFP_AuditTime2,			String,'														     +'】' + 
            '【审批时间3,        I.WFP_AuditTime~WFP_AuditTime3,			String,'														     +'】' + 
            '【审批时间4,        J.WFP_AuditTime~WFP_AuditTime4,			String,'														     +'】' + 
            '【审批时间5,        K.WFP_AuditTime~WFP_AuditTime5,			String,'														     +'】' +  
            '【结算币种,         Q.DC0_DictName1~CurrencyDictName,			String,'														     +'】' +  
            '【状态名称,         R.DC0_DictName1~StatusDictName,			String,'														     +'】' +  
            '【结算方式名称,     S.DC0_DictName1~AccountDictName,			String,'														     +'】' +        
          
            '【《W》集团,			PR0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			PR0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》合同ID,			PR0_ContractId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同ID') ,'')			+'】' +
            '【《W》合同编号,		PR0_ContractCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同编号'),'')		+'】' +
            '【《W》供应商编号,		PR0_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')		+'】' +
            '【《W》合同金额,	    PR0_Amount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同金额'),'')		+'】' +
            '【《W》结算币种,       PR0_CurrencyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》结算币种'),'')		+'】' +
            '【《W》合同说明,	    PR0_Description,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同说明'),'')		+'】' +
            '【《W》合同状态,		PR0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同状态') ,'')		+'】' +
            '【《W》合同扫描件,		PR0_ECopyPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同扫描件'),'')		+'】' +
            '【《W》合同开始时间,	PR0_StartDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同开始时间') ,'')	+'】' +
            '【《W》合同截止时间,	PR0_EndDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同截止时间') ,'')	+'】' +
            '【《W》创建人,		    PR0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人'),'')			+'】' +            
            '【《W》创建时间,		PR0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		PR0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +          
            '【《W》最后修改时间,	PR0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' +  
            '【《W》结算方式,		PR0_SettleAccount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》结算方式') ,'')		+'】'    
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
	    FROM   B02_Bill.PR0_Contract WITH ( NOLOCK )  
	    LEFT JOIN  B01_MDM.SU0_Supplier A        ON    PR0_SU0_SupplierId=A.SU0_SupplierId  
        LEFT JOIN  M02_BPM.WFT_AuditFlowDefine B ON    B.WFT_Type=''Contract'' and B.WFT_Step=''1''
        LEFT JOIN  M02_BPM.WFT_AuditFlowDefine C ON    C.WFT_Type=''Contract'' and C.WFT_Step=''2''
        LEFT JOIN  M02_BPM.WFT_AuditFlowDefine D ON    D.WFT_Type=''Contract'' and D.WFT_Step=''3''
        LEFT JOIN  M02_BPM.WFT_AuditFlowDefine E ON    E.WFT_Type=''Contract'' and E.WFT_Step=''4''
        LEFT JOIN  M02_BPM.WFT_AuditFlowDefine F ON    F.WFT_Type=''Contract'' and F.WFT_Step=''5''
        LEFT JOIN  M02_BPM.WFP_AuditFlow G       ON    PR0_ContractId=G.WFP_BillId AND G.WFP_WFT_AFDId=B.WFT_AFDId
        LEFT JOIN  M02_BPM.WFP_AuditFlow H       ON    PR0_ContractId=H.WFP_BillId AND H.WFP_WFT_AFDId=C.WFT_AFDId
        LEFT JOIN  M02_BPM.WFP_AuditFlow I       ON    PR0_ContractId=I.WFP_BillId AND I.WFP_WFT_AFDId=D.WFT_AFDId
        LEFT JOIN  M02_BPM.WFP_AuditFlow J       ON    PR0_ContractId=J.WFP_BillId AND J.WFP_WFT_AFDId=E.WFT_AFDId
        LEFT JOIN  M02_BPM.WFP_AuditFlow K       ON    PR0_ContractId=K.WFP_BillId AND K.WFP_WFT_AFDId=F.WFT_AFDId
        LEFT JOIN  M01_CONF.DC0_Dictionary L     ON    G.WFP_AFResultId=L.DC0_DictId 
        LEFT JOIN  M01_CONF.DC0_Dictionary M     ON    H.WFP_AFResultId=M.DC0_DictId
        LEFT JOIN  M01_CONF.DC0_Dictionary N     ON    I.WFP_AFResultId=N.DC0_DictId
        LEFT JOIN  M01_CONF.DC0_Dictionary O     ON    J.WFP_AFResultId=O.DC0_DictId
        LEFT JOIN  M01_CONF.DC0_Dictionary P     ON    K.WFP_AFResultId=P.DC0_DictId 
        LEFT JOIN  M01_CONF.DC0_Dictionary Q     ON    PR0_CurrencyId=Q.DC0_DictId   
        LEFT JOIN  M01_CONF.DC0_Dictionary R     ON    PR0_Status=R.DC0_DictId                             
        LEFT JOIN  M01_CONF.DC0_Dictionary Q     ON    PR0_CurrencyId=Q.DC0_DictId     	    
		where  ' + @WhereFieldList +' ORDER BY PR0_LmDt'
 		
		PRINT @SqlString					
		
	end


if @mdl='NEW'  
	begin
	 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @MapString =  
 
            '【供应商编号,		 PR0_SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')	     +'】' +
            '【合同金额,		 PR0_Amount,		    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同金额'),'')	     +'】' +
            '【结算币种,		 PR0_CurrencyId,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算币种'),'')	     +'】' +
            '【合同说明,		 PR0_Description,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同说明'),'')	     +'】' + 
            '【合同扫描件,		 PR0_ECopyPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同扫描件'),'')	     +'】' +
            '【合同开始时间,	 PR0_StartDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同开始时间'),'')	 +'】' +
            '【合同截止时间,	 PR0_EndDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同截止时间'),'')	 +'】' +
            '【状态,             PR0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +   
            '【创建人,			 PR0_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')	         +'】' +
            '【最后修改人,	     PR0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' + 
            '【结算方式,	     PR0_SettleAccount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算方式'),'')	     +'】' 
                    
 		
		SET @PR0_CONO='100'
		SET @PR0_DIVI='200'
		SET @PR0_ContractId=newID() 
	    SET @PR0_UptNo='0'
		SET @PR0_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @PR0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
		SELECT  @PR0_ContractCode=ISNULL(MAX(PR0_ContractCode),''),
        @PreCode=RIGHT(left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)+'-'+
        LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)  FROM B02_Bill.PR0_Contract where 
        left(PR0_ContractCode,2)=RIGHT(left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
        AND left(right(PR0_ContractCode,4),2)=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
		
		IF @PR0_ContractCode='' 
		BEGIN
		   set  @PR0_ContractCode=@PreCode+'01'		
		END 
		ELSE
		BEGIN
		  set @PR0_ContractCode=@PreCode+CAST(CAST(RIGHT(@PR0_ContractCode,2)AS INT )+1 AS VARCHAR(20))		    
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
 
		Set @SqlString='INSERT INTO  B02_Bill.PR0_Contract(PR0_CONO,PR0_DIVI,PR0_ContractId,PR0_UptNo,PR0_RgDt,PR0_LmDt,PR0_ContractCode,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@PR0_CONO+''','''+@PR0_DIVI+''','''+@PR0_ContractId+''','		
		Set @SqlString=@SqlString+''''+@PR0_UptNo+''','''+@PR0_RgDt+''','''+@PR0_LmDt+''','''+@PR0_ContractCode+''',  '+@InsertFromValueList+')'
 
       -- '''+@PR0_ContractId+'''】【《N》单据类型,Contract】【《N》状态,@PR0_Status】
        --【《N》创建人,@PR0_RgUser】【《N》最后修改人,@PR0_RgUser】      
       -- 【《W》合同号,@PR0_ContractId】
        --【《W》审核类型,Contract】'		
 
		
		PRINT @SqlString
		 
 		
							
		
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
        
 
		set @MapString = 
            '【供应商编号,		 PR0_SU0_SupplierId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')	     +'】' +
            '【合同金额,		 PR0_Amount,		    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同金额'),'')	     +'】' +
            '【结算币种,		 PR0_CurrencyId,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算币种'),'')	     +'】' +
            '【合同说明,		 PR0_Description,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同说明'),'')	     +'】' + 
            '【合同扫描件,		 PR0_ECopyPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同扫描件'),'')	     +'】' +
            '【合同开始时间,	 PR0_StartDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同开始时间'),'')	 +'】' +
            '【合同截止时间,	 PR0_EndDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同截止时间'),'')	 +'】' +         
            '【状态,             PR0_Status,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【创建人,			 PR0_RgUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')	         +'】' +
            '【最后修改人,	     PR0_LmUser,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +
            '【结算方式,	     PR0_SettleAccount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算方式'),'')	     +'】' + 
             
            '【《W》集团,			PR0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			PR0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》合同ID,			PR0_ContractId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同ID') ,'')			+'】' +        
            '【《W》合同编号,		PR0_ContractCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同编号'),'')		+'】' +
            '【《W》供应商编号,		PR0_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商编号'),'')		+'】' +
            '【《W》合同金额,	    PR0_Amount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同金额'),'')		+'】' +
            '【《W》结算币种,       PR0_CurrencyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》结算币种'),'')		+'】' +
            '【《W》合同说明,	    PR0_Description,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同说明'),'')		+'】' +
            '【《W》合同状态,		PR0_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同状态') ,'')		+'】' +
            '【《W》合同扫描件,		PR0_ECopyPath,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同扫描件'),'')		+'】' +
            '【《W》合同开始时间,	PR0_StartDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同开始时间') ,'')   +'】' +
            '【《W》合同截止时间,	PR0_EndDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同截止时间') ,'')   +'】' +
            '【《W》创建人,		    PR0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人'),'')			+'】' +            
            '【《W》创建时间,		PR0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		PR0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +          
            '【《W》最后修改时间,	PR0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' +  
            '【结算方式,			PR0_SettleAccount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算方式'),'')	     +'】' 


           set @MapString1 =            
            '【《W》单据编号,		WFP_BillId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》单据编号') ,'')		+'】' 
     
		     SET @PR0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
 
 
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
		
			set @WhereFieldList1=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString1
			,'Where'	
			,@WhereFieldNameList
			,0	
		)	
 
       
        Set @SqlString1='select @WFP_BillId=WFP_BillId '+ 'FROM  M02_BPM.WFP_AuditFlow   where  ' + @WhereFieldList1+' AND WFP_AFResultId<>'''' '
 
		
		if @WFP_BillId=''
		BEGIN
		 PRINT 1111111111
		end 	
		else
		BEGIN
		 PRINT 22222222222
		END
 
		Set @SqlString='UPDATE B02_Bill.PR0_Contract SET PR0_UptNo=CAST(PR0_UptNo AS INT)+1,PR0_LmDt='''+@PR0_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
 		
 
					
 
	end
	
	
if @mdl='DELETE'  
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
            '【《W》最后修改时间,	PR0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	 +'】' +  
            '【结算方式,			PR0_SettleAccount,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算方式'),'')	     +'】' 
   
   
           	SET @PR0_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		Set @SqlString='UPDATE B02_Bill.PR0_Contract SET PR0_UptNo=CAST(PR0_UptNo AS INT)+1,PR0_LmDt='''+@PR0_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
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
		
		
		SELECT @PR0_Status=PR0_Status,@PR0_RgUser=PR0_RgUser FROM B02_Bill.PR0_Contract 
		WHERE PR0_LmDT=@PR0_LmDt			 
		
	set @SqlString2 ='【操作类型,NEW】【实体,M02_BPM.WFT_AuditFlow】
         【返回内容,合同表】【新增内容,单据编号,单据类型,状态,创建人,最后修改人】
         【条件内容,《N》单据编号,《N》单据类型,《N》状态,《N》创建人,《N》最后修改人,《W》合同号,《W》审核类型】
         【《N》单据编号,'+@PR0_ContractId+'】【《N》单据类型,Contract】【《N》状态,'+@PR0_Status+
         '】【《N》创建人,'+@PR0_RgUser+'】【《N》最后修改人,'+@PR0_RgUser+'】【《W》合同号,'+@PR0_ContractId
         +'】【《W》审核类型,Contract】'	
         
         PRINT @SqlString2
	EXEC API_GLERP.Sp_WFP_AuditFlow 'AML','DB','RS',@SqlString2	
		 
		 	

	print @N_ID
	print @SchemaName
	print @DB
	print @SP_Name

	
	
end

 

GO

