USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_FNP_ContracPayApply]    Script Date: 09/12/2013 10:32:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
 
CREATE proc [API_GLERP].[Sp_FNP_ContracPayApply]

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
	DECLARE @FNP_CONO	        VARCHAR(20)
	DECLARE @FNP_DIVI	        VARCHAR(20)
	DECLARE @PR0_ContractId	    VARCHAR(MAx)
	DECLARE @PR0_ContractId1    VARCHAR(MAx)
	DECLARE @FNP_UptNo          VARCHAR(20)
    DECLARE @FNP_RgDt           VARCHAR(50)
    DECLARE @FNP_LmDt           VARCHAR(50)
    DECLARE @PR0_ContractCode   VARCHAR(50)
    
    DECLARE @PreCode            VARCHAR(50)
    DECLARE @WFP_BillId         VARCHAR(100)
    DECLARE @PR0_Status         VARCHAR(100)
    DECLARE @PR0_RgUser			VARCHAR(20)
    DECLARE @FNP_PayApplyId		VARCHAR(50)
    DECLARE @FNPD_PayApplyDetailId VARCHAR(50)
    DECLARE @getValue			varchar(max)
    DECLARE @i						int 
    DECLARE @setValue			varchar(max)
    DECLARE @FNP_CHECK			VARCHAR(50)
    DECLARE @FNP_PayApplyCode	VARCHAR(50)
    DECLARE @PlanCode           VARCHAR(50)
    DECLARE @FNP_Type		  	VARCHAR(50)
    DECLARE @FNP_Status			VARCHAR(50)
    DECLARE @FNP_RgUser			VARCHAR(50)
    DECLARE @COUNT              VARCHAR(50)
    DECLARE @FNP_LmUser     VARCHAR(50)
    DECLARE @CHECK				VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
  
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.FNP_PayApply】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》申请单ID,】【《W》申请单编号,】【《W》合同编号,】【《W》供应商编号,】【《W》申请单类型,】' +
			'【《W》财务水单号,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】 '  			
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B02_Bill.FNP_PayApply】【新增内容,必填】【条件内容,】'+
			'【《N》供应商编号,】【《N》申请单编号,】【《N》供应商编号,】【《N》申请单类型,】'+
			'【《N》财务水单号,】【《N》付款总金额,】【《N》付款百分比,】【《N》应付款金额,】【《N》是否已付款,】'+
			'【《N》状态,】【《N》创建人,】【《N》最后修改人,】'  		
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B02_Bill.FNP_PayApply】【更新内容,必填】'+
			'【《N》供应商编号,】【《N》申请单编号,】【《N》供应商编号,】【《N》申请单类型,】'+
			'【《N》财务水单号,】【《N》付款总金额,】【《N》付款百分比,】【《N》应付款金额,】【《N》是否已付款,】'+
			'【《N》创建人,】【《N》最后修改人,】【《N》状态,】' +					          
            '【《W》集团,】【《W》事业体,】'+
            '【《W》申请单ID,】【《W》申请单编号,】【《W》合同编号,】【《W》供应商编号,】【《W》申请单类型,】' +
			'【《W》财务水单号,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】 '								
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B02_Bill.FNP_PayApply】【更新内容,必填】【条件内容,】【《N》状态,】'+
			'【《N》最后修改人,】'+
            '【《W》集团,】【《W》事业体,】'+
		    '【《W》集团,】【《W》事业体,】'+
            '【《W》申请单ID,】【《W》申请单编号,】【《W》合同编号,】【《W》供应商编号,】【《W》申请单类型,】' +
			'【《W》财务水单号,】【《W》状态,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】【《W》最后修改时间,】 '				
			 
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
            '【《W》判断,	  CHECK,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》判断'),'')			+'】'  
  
		set @SelectFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](		
			@MapString
			,'Select'	
			,@SelectFieldNameList
			,0	
		)
		
		set @CHECK=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》判断'),'')	
		
        
		IF @CHECK='全部加载' 
		BEGIN	
			set @MapString = 
			'【集团,		     FNP_CONO~FNP_CONO,							String,'														     +'】' + 
            '【事业体,		     FNP_DIVI~FNP_DIVI,							String,'														     +'】' + 
            '【申请单ID,		 FNP_PayApplyId~FNP_PayApplyId,		        String,'														     +'】' + 
            '【申请单编号,		 FNP_PayApplyCode~FNP_PayApplyCode,			String,'														     +'】' + 
           -- '【合同GUID,		 PR0_ContractId~PR0_ContractId,				String,'														     +'】' + 
            '【供应商GUID,		 FNP_SU0_SupplierId~FNP_SU0_SupplierId,		String,'														     +'】' + 
            '【申请单类型,		 FNP_Type~FNP_Type,							String,'														     +'】' + 
            '【财务水单号,		 FNP_BankReceipt~FNP_BankReceipt,			String,'														     +'】' + 
            '【付款总金额,		 FNP_PayAmount~FNP_PayAmount,				String,'														     +'】' + 
            '【付款百分比,		 FNP_PayRate~FNP_PayRate,					String,'														     +'】' + 
			'【应付款金额,		 FNP_DuesAmount~FNP_DuesAmount,				String,'														     +'】' +     
            '【是否已付款,		 FNP_IsPayed~FNP_IsPayed,					String,'														     +'】' +   
            '【状态,		     FNP_Status~FNP_Status,						String,'														     +'】' + 
            '【创建人,		     FNP_RgUser~PR0_RgUser,						String,'														     +'】' + 
            '【创建时间,         FNP_RgDt~PR0_RgDt,							String,'														     +'】' +             
            '【最后修改人,       FNP_LmUser~PR0_LmUser,						String,'														     +'】' +     
            '【最后修改时间,     FNP_LmDt~PR0_LmDt,						    String,'														     +'】' +  
            '【修改次数,         FNP_UptNo~PR0_UptNo,						String,'														     +'】' +                         
	 		
			--'【合同编号,		 A.PR0_ContractCode~PR0_ContractCode,		String,'														     +'】' +               
            '【供应商编号,       B.SU0_SupplierCode~SU0_SupplierCode,		String,'														     +'】' +                          
			'【开户行,			 B.SU0_Bank~SU0_Bank,						String,'														     +'】' +                                    
			'【银行账户,		 B.SU0_BankAccount~SU0_BankAccount,			String,'														     +'】' +   
			'【银行SWIFT号,		 B.SU0_BankSwift~SU0_BankSwift,				String,'														     +'】' +           
            '【申请单类型,       C.DC0_DICTNAME1~TypeDictName,				String,'														     +'】' +   
            '【节点名称1,        D.WFT_NODE~WFT_NODE1,						String,'														     +'】' +  
            '【节点名称2,        E.WFT_NODE~WFT_NODE2,						String,'														     +'】' +  
            '【节点名称3,        F.WFT_NODE~WFT_NODE3,						String,'														     +'】' +             
            '【节点名称4,        G.WFT_NODE~WFT_NODE4,						String,'														     +'】' +              
            '【审批结果1,        N.DC0_DICTNAME1~DC0_DICTNAME1,				String,'														     +'】' +  
            '【审批结果2,        O.DC0_DICTNAME1~DC0_DICTNAME2,				String,'														     +'】' +  
            '【审批结果3,        P.DC0_DICTNAME1~DC0_DICTNAME3,				String,'														     +'】' +             
            '【审批结果4,        Q.DC0_DICTNAME1~DC0_DICTNAME4,				String,'														     +'】' +  
            '【审批时间1,        I.WFP_AuditTime~WFP_AuditTime1,			String,'														     +'】' +  
            '【审批时间2,        J.WFP_AuditTime~WFP_AuditTime2 ,			String,'														     +'】' + 
            '【审批时间3,        K.WFP_AuditTime~WFP_AuditTime3,			String,'														     +'】' + 
            '【审批时间4,        L.WFP_AuditTime~WFP_AuditTime4,			String,'														     +'】' +            
            '【审批流ID1,        I.WFP_AFID~WFP_AFID1,						String,'														     +'】' + 
            '【审批流ID2,        J.WFP_AFID~WFP_AFID2,						String,'														     +'】' + 
            '【审批流ID3,        K.WFP_AFID~WFP_AFID3,						String,'														     +'】' + 
            '【审批流ID4,        L.WFP_AFID~WFP_AFID4,						String,'														     +'】' + 
            '【状态名称,         R.DC0_DictName1~StatusDictName,			String,'														     +'】' +  
            
          
            '【《W》集团,			FNP_CONO,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			FNP_DIVI,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》申请单ID,		FNP_PayApplyId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单ID') ,'')		+'】' +
            '【《W》申请单编号,		FNP_PayApplyCode,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单编号'),'')		+'】' +
            '【《W》合同GUID,		FNP_PR0_ContractId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同GUID'),'')		+'】' +
            '【《W》供应商GUID,	    FNP_SU0_SupplierId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商GUID'),'')		+'】' +
            '【《W》申请单类型,     FNP_Type,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单类型'),'')		+'】' +
            '【《W》财务水单号,	    FNP_BankReceipt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》财务水单号'),'')		+'】' +
            '【《W》付款总金额,		FNP_PayAmount~FNP_PayAmount,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》付款总金额'),'')		+'】' +
            '【《W》付款百分比,		FNP_PayRate~FNP_PayRate,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》付款百分比'),'')		+'】' +
			'【《W》应付款金额,		FNP_DuesAmount~FNP_DuesAmount,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》应付款金额'),'')		+'】' +
            '【《W》是否已付款,		FNP_IsPayed~FNP_IsPayed,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》是否已付款'),'')		+'】' +
            '【《W》创建人,			FNP_RgUser,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')			+'】' +
            '【《W》创建时间,		FNP_RgDt,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		FNP_LmUser,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +
            '【《W》最后修改时间,	FNP_LmDt,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' 
   
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
	     FROM  B02_Bill.FNP_PayApply

         LEFT JOIN  B01_MDM.SU0_Supplier  B       ON    FNP_SU0_SupplierId=B.SU0_SupplierId   
         LEFT JOIN  M01_CONF.DC0_Dictionary C     ON    FNP_Type=C.DC0_DictId     
         LEFT JOIN  M02_BPM.WFT_AuditFlowDefine D ON    D.WFT_Type=''PayApply'' and D.WFT_Step=''1''
         LEFT JOIN  M02_BPM.WFT_AuditFlowDefine E ON    E.WFT_Type=''PayApply'' and E.WFT_Step=''2''
         LEFT JOIN  M02_BPM.WFT_AuditFlowDefine F ON    F.WFT_Type=''PayApply'' and F.WFT_Step=''3''
         LEFT JOIN  M02_BPM.WFT_AuditFlowDefine G ON    G.WFT_Type=''PayApply'' and G.WFT_Step=''4''

         LEFT JOIN  M02_BPM.WFP_AuditFlow I       ON    FNP_PayApplyId=I.WFP_BillId AND I.WFP_WFT_AFDId=D.WFT_AFDId
         LEFT JOIN  M02_BPM.WFP_AuditFlow J       ON    FNP_PayApplyId=J.WFP_BillId AND J.WFP_WFT_AFDId=E.WFT_AFDId
         LEFT JOIN  M02_BPM.WFP_AuditFlow K       ON    FNP_PayApplyId=K.WFP_BillId AND K.WFP_WFT_AFDId=F.WFT_AFDId
         LEFT JOIN  M02_BPM.WFP_AuditFlow L       ON    FNP_PayApplyId=L.WFP_BillId AND L.WFP_WFT_AFDId=G.WFT_AFDId

         LEFT JOIN  M01_CONF.DC0_Dictionary N     ON    I.WFP_AFResultId=N.DC0_DictId 
         LEFT JOIN  M01_CONF.DC0_Dictionary O     ON    J.WFP_AFResultId=O.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary P     ON    K.WFP_AFResultId=P.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary Q     ON    L.WFP_AFResultId=Q.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary R     ON    FNP_Status=R.DC0_DictId    	    
		 where FNP_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1  ORDER BY FNP_LmDt'' ' 
		
 		end
 		ELSE
 		BEGIN
 			Set @SqlString='select ' +  @SelectFieldList + ' 
	     FROM  B02_Bill.FNP_PayApply

         LEFT JOIN  B01_MDM.SU0_Supplier  B       ON    FNP_SU0_SupplierId=B.SU0_SupplierId   
         LEFT JOIN  M01_CONF.DC0_Dictionary C     ON    FNP_Type=C.DC0_DictId     
         LEFT JOIN  M02_BPM.WFT_AuditFlowDefine D ON    D.WFT_Type=''PayApply'' and D.WFT_Step=''1''
         LEFT JOIN  M02_BPM.WFT_AuditFlowDefine E ON    E.WFT_Type=''PayApply'' and E.WFT_Step=''2''
         LEFT JOIN  M02_BPM.WFT_AuditFlowDefine F ON    F.WFT_Type=''PayApply'' and F.WFT_Step=''3''
         LEFT JOIN  M02_BPM.WFT_AuditFlowDefine G ON    G.WFT_Type=''PayApply'' and G.WFT_Step=''4''

         LEFT JOIN  M02_BPM.WFP_AuditFlow I       ON    FNP_PayApplyId=I.WFP_BillId AND I.WFP_WFT_AFDId=D.WFT_AFDId
         LEFT JOIN  M02_BPM.WFP_AuditFlow J       ON    FNP_PayApplyId=J.WFP_BillId AND J.WFP_WFT_AFDId=E.WFT_AFDId
         LEFT JOIN  M02_BPM.WFP_AuditFlow K       ON    FNP_PayApplyId=K.WFP_BillId AND K.WFP_WFT_AFDId=F.WFT_AFDId
         LEFT JOIN  M02_BPM.WFP_AuditFlow L       ON    FNP_PayApplyId=L.WFP_BillId AND L.WFP_WFT_AFDId=G.WFT_AFDId

         LEFT JOIN  M01_CONF.DC0_Dictionary N     ON    I.WFP_AFResultId=N.DC0_DictId 
         LEFT JOIN  M01_CONF.DC0_Dictionary O     ON    J.WFP_AFResultId=O.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary P     ON    K.WFP_AFResultId=P.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary Q     ON    L.WFP_AFResultId=Q.DC0_DictId
         LEFT JOIN  M01_CONF.DC0_Dictionary R     ON    FNP_Status=R.DC0_DictId    	    
		 where FNP_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' and ' + @WhereFieldList
		 +' ORDER BY FNP_LmDt'
 		END
		
		   
		 			
	end
	IF @CHECK='合同新建'  	
	BEGIN	
	/*
	declare @getValue varchar(max),@i int ,@setValue varchar(max)
	set @i=1
	 set @PR0_ContractId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同GUID'),'')	 
	 print  @PR0_ContractId
	 
	while len(@PR0_ContractId) >0 
	 begin
	   set @getValue= substring(@PR0_ContractId,charindex('/',@PR0_ContractId,@i)+1, charindex(',',@PR0_ContractId,@i)-2)
       print @getValue
       
	 end
	
	-- set @PR0_ContractId1=replace(@PR0_ContractId,'/',',')
	*/
	 
	set @PR0_ContractId= isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同GUID'),'')	 
    set  @PR0_ContractId1=@PR0_ContractId
    
 
	set @i=1
	set @setValue=''
	 
	while len(@PR0_ContractId) >10
	 begin
	   print '1' + @PR0_ContractId
	   set @getValue= substring(@PR0_ContractId,charindex('/',@PR0_ContractId,@i)+1, charindex('/',@PR0_ContractId,2)-2)
       set @setValue=@setValue+ ','+''''+@getValue+''''
       
       print '2' + @setValue
       
       set @PR0_ContractId=substring(@PR0_ContractId,len(@getValue)+2,len(@PR0_ContractId)-len(@getValue)-1)
	
	 end
	 
	 set @setValue=substring(@setValue,2,len(@setValue)-1)
	 
	 print '3' + @setValue
	 
		set @MapString = 
			'【集团,		     PR0_CONO~FNP_CONO,								String,'														     +'】' + 
            '【事业体,		     PR0_DIVI~FNP_DIVI,								String,'														     +'】' + 
            '【申请单ID,		 ''''~FNP_PayApplyId,							String,'														     +'】' + 
            '【申请单编号,		 ''''~FNP_PayApplyCode,							String,'														     +'】' + 
            '【合同GUID,		 '''+@PR0_ContractId1+'''~PR0_ContractId,					String,'														     +'】' + 
            '【供应商GUID,		 SU0_SupplierId~SU0_SupplierId,					String,'														     +'】' + 
            '【申请单类型,		 ''''~FNP_Type,									String,'														     +'】' + 
            '【财务水单号,		 ''''~FNP_BankReceipt,							String,'														     +'】' + 
			'【付款总金额,		 SUM(PR0_Amount)~FNP_PayAmount,					String,'														     +'】' + 
            '【付款百分比,		 PR0_PrePayRate~FNP_PayRate,					String,'														     +'】' + 
			'【应付款金额,		 SUM(PR0_Amount)*PR0_PrePayRate~FNP_DuesAmount,	String,'														     +'】' +     
            '【是否已付款,		 ''''~FNP_IsPayed,								String,'														     +'】' +             
            '【状态,		     ''''~FNP_Status,								String,'														     +'】' + 
            '【创建人,		     ''''~FNP_RgUser,								String,'														     +'】' + 
            '【创建时间,         ''''~FNP_RgDt,									String,'														     +'】' +             
            '【最后修改人,       ''''~FNP_LmUser,								String,'														     +'】' +     
            '【最后修改时间,     ''''~FNP_LmDt,									String,'														     +'】' +  
            '【修改次数,         ''''~FNP_UptNo,								String,'														     +'】' +                         
	 		
			--'【合同编号,		 PR0_ContractCode~PR0_ContractCode,				String,'														     +'】' +               
            '【供应商编号,       B.SU0_SupplierCode~SU0_SupplierCode,			String,'														     +'】' +                          
			'【开户行,			 B.SU0_Bank~SU0_Bank,							String,'														     +'】' +                                    
			'【银行账户,		 B.SU0_BankAccount~SU0_BankAccount,				String,'														     +'】' +   
			'【银行SWIFT号,		 B.SU0_BankSwift~SU0_BankSwift,					String,'														     +'】' +           
          
 
          
            '【《W》集团,			PR0_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			PR0_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》合同GUID,	    PR0_ContractId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》合同GUID'),'')		+'】' +
            '【《W》供应商GUID,	    PR0_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》供应商GUID'),'')		+'】' +
            '【《W》创建人,			PR0_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建人') ,'')			+'】' +
            '【《W》创建时间,		PR0_RgDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》创建时间'),'')		+'】' +
            '【《W》最后修改人,		PR0_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改人') ,'')		+'】' +
            '【《W》最后修改时间,	PR0_LmDt,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》最后修改时间') ,'')	+'】' 
   
		 
		
		 	
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
	     FROM  B02_Bill.PR0_Contract   
         LEFT JOIN  B01_MDM.SU0_Supplier  B       ON    PR0_SU0_SupplierId=B.SU0_SupplierId    	    
		 where PR0_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND PR0_ContractId IN('+@setValue+')'+
		 'GROUP BY PR0_CONO,PR0_DIVI,SU0_SupplierId,PR0_PrePayRate,B.SU0_SupplierCode,B.SU0_Bank,B.SU0_BankAccount,B.SU0_BankSwift'
		
		PRINT @SqlString		

	END 

 end
if @mdl='NEW'  
	begin
	 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @MapString =  
			--'【申请单主表ID,		FNP_PayApplyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》申请单主表ID'),'')	     +'】' +
			--'【申请单编号,			FNP_PayApplyCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》申请单编号'),'')	     +'】' +
			--'【合同GUID,			PR0_ContractId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同GUID'),'')	     +'】' +
            '【供应商GUID,			FNP_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商GUID'),'')	     +'】' +
            '【申请单类型,			FNP_Type,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》申请单类型'),'')	     +'】' + 
            '【财务水单号,			FNP_BankReceipt,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》财务水单号'),'')	     +'】' +
            '【付款总金额,			FNP_PayAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》付款总金额'),'')	     +'】' +
            '【付款百分比,			FNP_PayRate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》付款百分比'),'')	     +'】' +
			'【应付款金额,			FNP_DuesAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》应付款金额'),'')	     +'】' +
            '【是否已付款,			FNP_IsPayed,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》是否已付款'),'')	     +'】' +
            '【状态,				FNP_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			 +'】' +
            '【创建人,				FNP_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')			 +'】' +
            '【最后修改人,			FNP_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		 +'】'  
 
          		
          		
          	set @MapString1 =          
	      -- '【申请单主表ID,				FNP_PayApplyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单主表ID'),'')	+'】' + 
           '【合同ID,					PR0_ContractId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同ID'),'')	    +'】'
           
 
     
		SET @FNP_CONO='100'
		SET @FNP_DIVI='200'
		SET @FNP_PayApplyId=newID() 
	    SET @FNP_UptNo='0'
		SET @FNP_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @FNP_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
		 
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
		
		--set @FNP_PayApplyId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》申请单主表ID'),'')	
		set @PR0_ContractId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》合同ID'),'')	
		set @FNP_Type=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》申请单类型'),'')	
        set @FNP_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
        set @FNP_RgUser=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')
		set @FNP_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
		--	print @PR0_ContractId
		--SELECT @FNP_CHECK=ISNULL(max(FNP_PayApplyId),'')      
       -- FROM B02_Bill.FNP_PayApply
       -- WHERE FNP_PayApplyId=@FNP_PayApplyId
 
        
     --   PRINT @FNP_CHECK
       -- if @FNP_CHECK=''
      --  begin
			SELECT  @FNP_PayApplyCode=ISNULL(MAX(FNP_PayApplyCode),''),
				@PlanCode= 'FK'+left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)  
				+LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
			FROM B02_Bill.FNP_PayApply 
			where LEFT(FNP_PayApplyCode,2)='FK' 
				AND RIGHT(LEFT(FNP_PayApplyCode,6),4)=left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)   
				AND left(right(FNP_PayApplyCode,7),2)=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
  
        		IF @FNP_PayApplyCode='' 
				BEGIN
 
					set  @FNP_PayApplyCode=@PlanCode+'00001'		
				END 
				ELSE
				BEGIN	
 	 		    					 	
					set @FNP_PayApplyCode=@PlanCode+RIGHT('00000'+CAST(CAST(right(@FNP_PayApplyCode,5) AS INT )+1 AS VARCHAR(20)),5 )   
			 
				end		
		--end
		
 
 
 
			
			 
			
		set  @PR0_ContractId1=@PR0_ContractId 
		PRINT @PR0_ContractId1
		set @i=1
		set @setValue=''
 
		while len(@PR0_ContractId) >10
			begin
		 
			set @getValue= substring(@PR0_ContractId,charindex('/',@PR0_ContractId,@i)+1, charindex('/',@PR0_ContractId,2)-2)
			set @setValue=@setValue+ ','+''''+@getValue+''''
       
		 
       
			set @PR0_ContractId=substring(@PR0_ContractId,len(@getValue)+2,len(@PR0_ContractId)-len(@getValue)-1)
	
			end
	 
			set @setValue=substring(@setValue,2,len(@setValue)-1)
 
		    
			-- Set @SqlString1='SELECT @COUNT=COUNT(PR0_ContractId)    
			-- FROM B02_Bill.PR0_Contract  
			-- WHERE PR0_ContractId IN ('+@setValue+')' 
		 
			--EXEC sp_executesql @SqlString1
 

	--	SET  @i=1
	--	 while @i< @COUNT 
	--	 BEGIN
 
			
			Set @SqlString1='INSERT INTO   B02_Bill.FNPD_PayApplyDetail(FNPD_CONO,FNPD_DIVI,FNPD_PayApplyDetailId,FNPD_FNP_PayApplyId,FNPD_FNP_PayApplyCode,
				FNPD_RefBillDetailType,FNPD_RefBillDetailID,FNPD_Status,FNPD_RgUser,FNPD_RgDt,FNPD_LmUser,FNPD_LmDt,FNPD_UptNo)
				SELECT '''+@FNP_CONO+''','''+@FNP_DIVI+''',newID(),'''+@FNP_PayApplyId+''','''+@FNP_PayApplyCode+''', 
				'''+@FNP_Type+''',PR0_ContractId,'''+@FNP_Status+''','''+@FNP_RgUser+''','''+@FNP_RgDt+''','''+@FNP_RgUser+''','''+@FNP_LmDt+''','''+@FNP_UptNo+'''
				FROM B02_Bill.PR0_Contract 
				WHERE PR0_ContractId IN ('+@setValue+')'
			EXEC sp_executesql @SqlString1
 
 
		--	 set @i=@i+1
		-- END 
 
		 Set @SqlString='INSERT INTO  B02_Bill.FNP_PayApply(FNP_CONO,FNP_DIVI,FNP_PayApplyId,FNP_UptNo,FNP_RgDt,FNP_LmDt,FNP_PayApplyCode,'
		 Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@FNP_CONO+''','''+@FNP_DIVI+''','''+@FNP_PayApplyId+''','		
		 Set @SqlString=@SqlString+''''+@FNP_UptNo+''','''+@FNP_RgDt+''','''+@FNP_LmDt+''','''+@FNP_PayApplyCode+''',  '+@InsertFromValueList+')'
     
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
           
            '【申请单类型,			FNP_Type,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》申请单类型'),'')	     +'】' + 
            '【财务水单号,			FNP_BankReceipt,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》财务水单号'),'')	     +'】' +
            '【是否已付款,			FNP_IsPayed,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》是否已付款'),'')	     +'】' +
            '【状态,				FNP_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			 +'】' +
            '【最后修改人,			FNP_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		 +'】' + 
            '【《W》集团,			FNP_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			FNP_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》申请单主表ID,	FNP_PayApplyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单主表ID') ,'')		+'】'  
           

          --	set @MapString1 =          
          --  '【《W》申请单主表ID,				FNP_PayApplyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单主表ID'),'')	+'】'  
           
            
		     SET @FNP_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
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
	 
		set @FNP_Type=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》申请单类型'),'')	
		set @FNP_PayApplyId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单主表ID'),'')
		set @FNP_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	
		set @FNP_LmUser=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	
		
	 
		Set @SqlString1='UPDATE B02_Bill.FNPD_PayApplyDetail SET FNPD_UptNo=CAST(FNPD_UptNo AS INT)+1,
				FNPD_RefBillDetailType='''+@FNP_Type+''',FNPD_LmUser='''+@FNP_LmUser+''',FNPD_Status='''+@FNP_Status+'''
				WHERE FNPD_FNP_PayApplyId='''+@FNP_PayApplyId+''' '
      		 
		EXEC sp_executesql @SqlString1
  
		
 
		Set @SqlString='UPDATE B02_Bill.FNP_PayApply SET FNP_UptNo=CAST(FNP_UptNo AS INT)+1,FNP_LmDt='''+@FNP_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
 
	end

if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
 
            '【状态,				FNP_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			 +'】' +
            '【最后修改人,			FNP_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		 +'】' + 
            '【《W》集团,			FNP_CONO,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			FNP_DIVI,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》申请单主表ID,	FNP_PayApplyId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单主表ID') ,'')		+'】'  
           

   
           	SET @FNP_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
	 
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
 
		set @FNP_PayApplyId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》申请单主表ID'),'')
		set @FNP_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')	
		set @FNP_LmUser=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	
		
		 
		Set @SqlString1='UPDATE B02_Bill.FNPD_PayApplyDetail SET FNPD_UptNo=CAST(FNPD_UptNo AS INT)+1,
				 FNPD_LmUser='''+@FNP_LmUser+''',FNPD_Status='''+@FNP_Status+'''
				 WHERE FNPD_FNP_PayApplyId='''+@FNP_PayApplyId+''' '
      		 
		EXEC sp_executesql @SqlString1
  
  
		
		Set @SqlString='UPDATE B02_Bill.FNP_PayApply SET FNP_UptNo=CAST(FNP_UptNo AS INT)+1,FNP_LmDt='''+@FNP_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
 
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
		
 
	
end

 

GO

