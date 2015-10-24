USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_PRAD_ArrivalPlanDetail]    Script Date: 09/12/2013 10:33:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc [API_GLERP].[Sp_PRAD_ArrivalPlanDetail]
 
@InputFormat varchar(30),
@OutputFormat varchar(30),
@OutputContentType varchar(30),
@ConditionStr varchar(Max)
as

begin
    declare @SqlString nvarchar(max)
    declare @SqlString1  nvarchar(max)
    declare @SqlString2  nvarchar(max)
     
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
	DECLARE @PRAD_CONO	        VARCHAR(20)
	DECLARE @PRAD_DIVI	        VARCHAR(20)
	DECLARE @PRAD_AFID			VARCHAR(100)
	DECLARE @PRAD_UptNo          VARCHAR(20)
    DECLARE @PRAD_RgDt           VARCHAR(50)
    DECLARE @PRAD_LmDt           VARCHAR(50)
    DECLARE @PRAD_ArrivalPlanDetailId VARCHAR(50)
    DECLARE @PRAD_PRA_ArrivalPlanId VARCHAR(50)
    DECLARE @PRA_ArrivalPlanCode VARCHAR(50)
    DECLARE @PRA_PR1_OrderId VARCHAR(50)
    DECLARE @PRA_PerchaseTotal VARCHAR(50)
    DECLARE @PRA_Status VARCHAR(50)
    DECLARE @PRA_RgUser VARCHAR(50)
    DECLARE @PRAD_TotalDiff VARCHAR(20)
    DECLARE @PRAD_PlanArrivalAmount VARCHAR(20)
    DECLARE @PRA_ArrivalPlanId VARCHAR(50)
    DECLARE @PR1_PurchaseTotal VARCHAR(20)
    DECLARE @PR1_PurchaseAmount VARCHAR(20)
    DECLARE @PRA_PlanTotal VARCHAR(20)
    DECLARE @PRA_PlanAmount VARCHAR(20)
    DECLARE @PRA_TotalDiff VARCHAR(20)
    DECLARE @PRA_AmountDiff VARCHAR(20)
    DECLARE @PlanCode VARCHAR(50)
    DECLARE @PR1_SU0_SupplierId VARCHAR(50)
	DECLARE @PRB_CHECK  VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
 
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.PRAD_ArrivalPlanDetail】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》到货计划ID,】【《W》到货计划编号,】【《W》商品ID,】【《W》单位,】【《W》采购单明细ID,】' +
			'【《W》预计到货日期,】【《W》采购总数,】【《W》已到数量,】 【《W》已生成计划数量,】' +
		    '【《W》本次计划到货数量,】【《W》数量差异,】【《W》创建人,】【《W》创建时间,】【《W》最后修改人,】'+
		    '【《W》最后修改时间,】'			
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B02_Bill.PRA_ArrivalPlan】【新增内容,必填】【条件内容,】'+
			'【《N》到货计划编号,】【《N》商品ID,】【《N》单位,】【《N》采购单明细ID,】'+
			'【《N》采购原币价,】【《N》采购本币价,】【《N》吊牌价,】'+  		
			'【《N》预计到货日期,】【《N》采购总数,】【《N》已到数量,】【《N》已生产计划数量,】'+  		
			'【《N》本次计划到货数量,】【《N》状态,】【《N》创建人,】【《N》最后修改人,】'+        
			'【《N》采购单编号,】【《N》采购主表总数,】【《N》采购主表金额,】'
 
 
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B02_Bill.PRA_ArrivalPlan】【更新内容,必填】'+
			'【《N》商品ID,】【《N》单位,】【《N》采购单明细ID,】【《N》采购原币价,】'+
			'【《N》采购本币价,】【《N》吊牌价,】【《N》预计到货日期,】【《N》采购总数,】'+  
 			'【《N》已到数量,】【《N》已生产计划数量,】【《N》本次计划到货数量,】【《N》状态,】'+ 		          
            '【《N》创建人,】【《N》最后修改人,】'+ 
            '【《W》集团,】【《W》事业体,】'+
			'【《W》采购单明细ID,】【《W》商品ID,】【《W》到货计划主表ID,】'  							
			
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B02_Bill.PRA_ArrivalPlan】【更新内容,必填】【条件内容,】'+
			'【《N》状态,】【《N》最后修改人,】'+
            '【《W》集团,】【《W》事业体,】'+
			'【《W》采购单明细ID,】【《W》商品ID,】【《W》到货计划主表ID,】'   			
			 
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
			'【集团,		      PRAD_CONO,							String,'																							+'】' + 
            '【《W》到货计划编号, PRAD_PRA_ArrivalPlanId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划编号'),'')			+'】'  
  
		set @SelectFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](		
			@MapString
			,'Select'	
			,@SelectFieldNameList
			,0	
		)
	--	set @PRAD_CONO=[~FrameDb].[API_Common].[ConvertNameListToSql](@MapString,'Select'	,'【集团】',0	)
		
		set @PRAD_PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划编号'),'')	
      PRINT @PRAD_PRA_ArrivalPlanId
		IF @PRAD_PRA_ArrivalPlanId<>'' 
		BEGIN
		
		     set @MapString1 = 
					'【集团,					PRAD_CONO,							String,'													   +'】' + 
                    '【事业体,					PRAD_DIVI,							String,'													   +'】' + 
                    '【到货计划ID,				PRAD_ArrivalPlanDetailId,			String,'													   +'】' + 
                    '【到货计划编号,		    PRAD_PRA_ArrivalPlanId,				String,'													   +'】' + 
                    '【商品ID,					PRAD_PD0_ProductId,					String,'													   +'】' + 
                    '【单位,					PRAD_UnitID,						String,'													   +'】' + 
                    '【采购单明细ID,		    PRAD_PR1D_OrderDetailId,			String,'													   +'】' + 
                    '【采购原币价,				PRAD_POriginalPrice,				String,'													   +'】' + 
                    '【采购本币价,				PRAD_PCurrencyPrice,				String,'													   +'】' + 
                    '【吊牌价,					PRAD_SCurrencyPrice,				String,'													   +'】' +                    
                    '【预计到货日期,		    PRAD_ArrivalDate,					String,'													   +'】' + 
                    '【采购总数,		        PRAD_PerchaseTotal,					String,'													   +'】' + 
                    '【已到数量,		        PRAD_ArrivalTotal,					String,'													   +'】' + 
                    '【已生产计划数量,		    PRAD_PlanTotal,						String,'													   +'】' + 
                    '【本次计划到货数量,		PRAD_PlanArrival,					String,'													   +'】' + 
                    '【本次计划到货金额,		PRAD_PlanArrivalAmount,				String,'													   +'】' + 
                    '【数量差异,		        PRAD_TotalDiff,						String,'													   +'】' + 
                    '【状态,					PRAD_Status,						String,'													   +'】' + 
                    '【创建人,					PRAD_RgUser,						String,'													   +'】' + 
                    '【创建时间,		        PRAD_RgDt,							String,'													   +'】' + 
                    '【最后修改人,		        PRAD_LmUser,						String,'													   +'】' + 
                    '【最后修改时间,		    PRAD_LmDt,							String,'													   +'】' + 
                    '【供应商款号,		        A.PD0_ProductCodeSU~PD0_ProductCodeSU ,						String,'													   +'】' + 
                    '【款号,					A.PD0_Code~PD0_Code,							String,'													   +'】' + 
                    '【单位对照,				D.DC0_DictName1~UnitDictName,		String,'													   +'】' + 
                                     
					'【《W》到货计划编号,		PRAD_PRA_ArrivalPlanId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划编号'),'')			+'】'  
  
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
 
					
		if @WhereFieldList1='' 
		begin
			Set @SqlString='select ' +  @SelectFieldList + ' 
			FROM   B02_Bill.PRA_ArrivalPlan WITH ( NOLOCK ) 
			LEFT JOIN B02_Bill.PR1_Order A ON PRA_PR1_OrderId=PR1_OrderId	    
			where  PRA_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1  ORDER BY PRAD_LmDt '' ' 
 		end
 		ELSE
 		BEGIN
 				Set @SqlString='select ' +  @SelectFieldList1 + ' 
			FROM   B02_Bill.PRAD_ArrivalPlanDetail WITH ( NOLOCK ) 
			LEFT JOIN   B01_MDM.PD0_Product A       ON A.PD0_ProductId=PRAD_PD0_ProductId
			 
			LEFT JOIN   M01_CONF.DC0_Dictionary D        ON PRAD_UnitID=D.DC0_DictId  
			where  PRAD_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND  ' + @WhereFieldList1
			+' ORDER BY PRAD_LmDt'
 		END
 		
 
 
		END 
		ELSE
		BEGIN
 
		  set @MapString1 = 
					'【集团,					PR1_CONO,												String,'													   +'】' + 
                    '【事业体,					PR1_DIVI,												String,'													   +'】' + 
                    '【到货计划ID,				''''~PRAD_ArrivalPlanDetailId,							String,'													   +'】' + 
                    '【到货计划编号,		    ''''~PRA_ArrivalPlanId,									String,'													   +'】' + 
                    '【商品ID,					PR1D_PD0_ProductId,										String,'													   +'】' + 
                    '【单位,					PR1D_UnitID,											String,'													   +'】' + 
                    '【采购单编号,			    PR1_OrderId,											String,'													   +'】' + 
					'【供应商编号,			    PR1_SU0_SupplierId,										String,'													   +'】' +                     
                    '【采购单明细ID,		    PR1D_OrderDetailId,										String,'													   +'】' +                     
                    '【采购原币价,				PR1D_POriginalPrice,									String,'													   +'】' + 
                    '【采购本币价,				PR1D_PCurrencyPrice,									String,'													   +'】' +                    
                    '【吊牌价,					PR1D_SCurrencyPrice,									String,'													   +'】' +
                    '【预计到货日期,		    ''''~PRAD_ArrivalDate,									String,'													   +'】' + 
                    '【采购主表总数,		    PR1_PurchaseTotal,										String,'													   +'】' + 
                    '【采购主表金额,		    PR1_PurchaseAmount,										String,'													   +'】' + 
                    '【采购总数,		        PR1D_Total~PR1D_Total,									String,'													   +'】' + 
                    '【已到数量,		        SUM(PRAD_ArrivalTotal)~PRAD_ArrivalTotal ,				String,'													   +'】' + 
                    '【已生产计划数量,		    SUM(PRAD_PlanArrival)~PRAD_PlanTotal,					String,'													   +'】' + 
                    '【本次计划到货数量,		0~PRAD_PlanArrival ,									String,'													   +'】' + 
                    '【本次计划到货金额,		0~PRAD_PlanArrivalAmount,								String,'													   +'】' + 
                    '【数量差异,		        0~PRAD_TotalDiff,										String,'													   +'】' + 
                    '【状态,					''''~PRAD_Status,										String,'													   +'】' + 
                    '【创建人,					''''~PRAD_RgUser,										String,'													   +'】' + 
                    '【创建时间,		        ''''~PRAD_RgDt,											String,'													   +'】' + 
                    '【最后修改人,		        ''''~PRAD_LmUser,										String,'													   +'】' + 
                    '【最后修改时间,		    ''''~PRAD_LmDt,											String,'													   +'】' + 
                   
                    '【供应商款号,		        A.PD0_ProductCodeSU~PD0_ProductCodeSU ,						String,'													   +'】' + 
                    '【款号,					A.PD0_Code~PD0_Code,							String,'													   +'】' + 
                    '【单位对照,				D.DC0_DictName1~UnitDictName,							String,'													   +'】' + 
                                     
					'【《W》采购单号,			PR1_OrderId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单号'),'')			+'】'  
  
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
 
		PRINT @SelectFieldList1	
			Set @SqlString='select ' +  @SelectFieldList1 + ' 
			FROM  B02_Bill.PR1_Order WITH ( NOLOCK ) 
			LEFT JOIN B02_Bill.PR1D_OrderDetail  ON PR1_OrderId=PR1D_PR1_OrderId
            LEFT JOIN B02_Bill.PRAD_ArrivalPlanDetail ON PR1D_OrderDetailId=PRAD_PR1D_OrderDetailId  
            LEFT JOIN   B01_MDM.PD0_Product A			 ON A.PD0_ProductId=PR1D_PD0_ProductId
           
			LEFT JOIN   M01_CONF.DC0_Dictionary D        ON PRAD_UnitID=D.DC0_DictId                                       
			where PR1_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND  ' + @WhereFieldList1+
			'GROUP BY  PR1_CONO,PR1_DIVI ,PR1D_PD0_ProductId,PR1D_OrderDetailId,PR1D_UnitID    
			,PR1D_Total,PR1D_POriginalPrice,A.PD0_ProductCodeSU,A.PD0_Code,PR1D_PCurrencyPrice,PR1_PurchaseTotal,PR1_PurchaseAmount,PR1D_SCurrencyPrice,PR1_SU0_SupplierId,D.DC0_DictName1'
  
  
   -- LEFT JOIN   M01_CONF.DC0_Dictionary B        ON A.PD0_ProductCodeSU=B.DC0_DictId
		--	LEFT JOIN   M01_CONF.DC0_Dictionary C        ON A.PD0_Code=C.DC0_DictId
 	PRINT @SqlString	
		  
		END
			  					
	end


if @mdl='NEW'  
 
	begin
 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
  	 	 
 
		set @MapString =          
	       --'【到货计划主表ID,		PRAD_PRA_ArrivalPlanId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划主表ID'),'')+'】' +
           --'【到货计划编号,		    PRA_ArrivalPlanCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划编号'),'')	+'】' +
           '【商品ID,				PRAD_PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')			+'】'+
           '【单位,					PRAD_UnitID,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单位'),'')			+'】'+
           '【采购单明细ID,		    PRAD_PR1D_OrderDetailId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单明细ID'),'')	+'】'+
           '【采购原币价,			PRAD_POriginalPrice,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'')		+'】'+
           '【采购本币价,			PRAD_PCurrencyPrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购本币价'),'')		+'】'+                
           '【吊牌价,				PRAD_SCurrencyPrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》吊牌价'),'')			+'】'+    
           '【预计到货日期,		    PRAD_ArrivalDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》预计到货日期'),'')	+'】'+
           '【采购总数,		        PRAD_PerchaseTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'')		+'】'+
           '【已到数量,		        PRAD_ArrivalTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已到数量'),'')		+'】'+
           '【已生产计划数量,		PRAD_PlanTotal,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已生产计划数量'),'')	+'】'+
           '【本次计划到货数量,		PRAD_PlanArrival,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货数量'),'')+'】'+
           '【状态,					PRAD_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			+'】'+
           '【创建人,				PRAD_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')			+'】'+            
           '【最后修改人,		    PRAD_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		+'】'
		   --'【采购单编号,		    PRA_PR1_OrderId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')		+'】'+
            
 
 		set @MapString1 =          
	       '【到货计划主表ID,		PRA_ArrivalPlanId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划主表ID'),'')+'】' +
           '【到货计划编号,		    PRA_ArrivalPlanCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划编号'),'')	    +'】'+
           '【采购单编号,			PRA_PR1_OrderId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')			+'】'+ 
		   '【采购主表总数,		    PR1_PurchaseTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购主表总数'),'')		+'】'+
           '【采购主表金额,		    PR1_PurchaseAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购主表金额'),'')		+'】'+
           '【供应商编号,		    PR1_SU0_SupplierId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')			+'】'
		    
		
 
		SET @PRAD_CONO='100'
		 
		SET @PRAD_DIVI='200'
		SET @PRAD_ArrivalPlanDetailId=newID() 
 	
		--SET @PRA_ArrivalPlanId=newID() ---------到货计划主表生成会导致一条明细一个收货计划
 
	    SET @PRAD_UptNo='0'
 	
		SET @PRAD_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @PRAD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
 
		  	 print @InsertToFieldNameList
 			 print @MapString
 	 	
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
      --set @PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划主表ID'),'')	  
	  --SELECT @PRA_ArrivalPlanId=PRA_ArrivalPlanId 
      --FROM  B02_Bill.PRA_ArrivalPlan WHERE PRA_ArrivalPlanId=@PRA_ArrivalPlanId
     
      
      
		set @PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划主表ID'),'')
		set @PRA_ArrivalPlanCode=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划编号'),'')	
        set @PRA_PR1_OrderId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')
        set @PRA_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
        set @PRA_RgUser=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')
		set @PR1_PurchaseTotal=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购主表总数'),'0')
		set @PR1_PurchaseAmount=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购主表金额'),'0')
		set @PR1_SU0_SupplierId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'0')
 
		SELECT @PRB_CHECK=ISNULL(max(PRA_ArrivalPlanId),'')    
        FROM B02_Bill.PRA_ArrivalPlan
        WHERE PRA_ArrivalPlanId=@PRA_ArrivalPlanId
        PRINT @PRB_CHECK
        if @PRB_CHECK=''
        begin
          IF @PRA_ArrivalPlanCode=''
          BEGIN
				SELECT  @PRA_ArrivalPlanCode=ISNULL(MAX(PRA_ArrivalPlanCode),''),
				@PlanCode= 'DH'+left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)  
				+LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
				FROM B02_Bill.PRA_ArrivalPlan where 
				LEFT(PRA_ArrivalPlanCode,2)='DH' 
				AND RIGHT(LEFT(PRA_ArrivalPlanCode,6),4)=left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)   
				AND left(right(PRA_ArrivalPlanCode,7),2)=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
       
        			IF @PRA_ArrivalPlanCode='' 
					BEGIN
						set  @PRA_ArrivalPlanCode=@PlanCode+'00001'		
					END 
					ELSE
					BEGIN         	    
						set @PRA_ArrivalPlanCode=@PlanCode+RIGHT('00000'+CAST(CAST(RIGHT(@PRA_ArrivalPlanCode,5)  AS INT )+1 AS VARCHAR(20)),5 ) 		    
					END 	
		 END    
		        
		--set @PRA_PerchaseTotal=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'')
 		     
 
            set @SqlString1 ='【操作类型,NEW】【实体,B02_Bill.PRA_ArrivalPlan】
						      【新增内容,到货计划主表ID,到货计划编号,采购单编号,采购总数,已到数量,本次计划到货数量,采购主表金额,已到货金额,本次计划到货金额,数量差异,金额差异,状态,创建人,最后修改人,供应商编号】       
						     
						     【条件内容,《N》到货计划主表ID《N》到货计划编号,《N》采购单编号,《N》采购总数,《N》已到数量,
							   《N》本次计划到货数量,《N》采购主表金额,《N》已到货金额,《N》本次计划到货金额,《N》数量差异,
							   《N》金额差异,《N》状态,《N》创建人,《N》最后修改人,《N》供应商编号】 								        
							   【《N》到货计划主表ID,'+@PRA_ArrivalPlanId+'】【《N》到货计划编号,'+@PRA_ArrivalPlanCode+'】【《N》采购单编号,'+@PRA_PR1_OrderId+'】【《N》采购总数,'+@PR1_PurchaseTotal+'】
							  【《N》已到数量,0】【《N》本次计划到货数量,0】【《N》采购主表金额,'+@PR1_PurchaseAmount+'】【《N》已到货金额,0】【《N》本次计划到货金额,0】 
							  【《N》数量差异,0】【《N》金额差异,0】【《N》状态,'+@PRA_Status+'】【《N》创建人,'+@PRA_RgUser+'】【《N》最后修改人,'+@PRA_RgUser+'】【《N》供应商编号,'+@PR1_SU0_SupplierId+'】'	
	      
 
	       EXEC API_GLERP.Sp_PRA_ArrivalPlan 'AML','DB','RS',@SqlString1	
       end
          set @PRAD_TotalDiff=cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'0') as int)-
							  cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已到数量'),'0') as int)-
							  cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货数量'),'0')as int)
                    
 
         SELECT @PRAD_PlanArrivalAmount=ISNULL(ISNULL(PR1D_POriginalPrice,'0') * cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货数量'),'0')as int),'0')
         FROM  B02_Bill.PR1D_OrderDetail   
         WHERE PR1D_OrderDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单明细ID'),'')
         AND   PR1D_PD0_ProductId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')
          
 
 
 		Set @SqlString='INSERT INTO  B02_Bill.PRAD_ArrivalPlanDetail(PRAD_CONO,PRAD_DIVI,PRAD_ArrivalPlanDetailId,
 		PRAD_UptNo,PRAD_RgDt,PRAD_LmDt,PRAD_TotalDiff,PRAD_PlanArrivalAmount,PRAD_PRA_ArrivalPlanId,'
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@PRAD_CONO+''','''+@PRAD_DIVI+''','''+@PRAD_ArrivalPlanDetailId+''','		
		Set @SqlString=@SqlString+' '''+@PRAD_UptNo+''','''+@PRAD_RgDt+''','''+@PRAD_LmDt+''',
		'''+@PRAD_TotalDiff+''','''+@PRAD_PlanArrivalAmount+''','''+@PRA_ArrivalPlanId+''','+@InsertFromValueList+')'				
 
  PRINT @SqlString
	end

if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
 
           '【商品ID,				PRAD_PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')			+'】'+
           '【单位,					PRAD_UnitID,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单位'),'')			+'】'+
           '【采购单明细ID,		    PRAD_PR1D_OrderDetailId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单明细ID'),'')	+'】'+
           '【采购原币价,			PRAD_POriginalPrice,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'')		+'】'+
           '【采购本币价,			PRAD_PCurrencyPrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购本币价'),'')		+'】'+                
           '【吊牌价,				PRAD_SCurrencyPrice,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》吊牌价'),'')			+'】'+    
           '【预计到货日期,		    PRAD_ArrivalDate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》预计到货日期'),'')	+'】'+
           '【采购总数,		        PRAD_PerchaseTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'')		+'】'+
           '【已到数量,		        PRAD_ArrivalTotal,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已到数量'),'')		+'】'+
           '【已生产计划数量,		PRAD_PlanTotal,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已生产计划数量'),'')	+'】'+
           '【本次计划到货数量,		PRAD_PlanArrival,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货数量'),'')+'】'+
           '【状态,					PRAD_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			+'】'+
           '【创建人,				PRAD_RgUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')			+'】'+            
           '【最后修改人,		    PRAD_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		+'】'+            
           '【《W》集团,			PRAD_CONO,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
           '【《W》事业体,			PRAD_DIVI,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
           '【《W》到货计划明细ID,	PRAD_ArrivalPlanDetailId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划明细ID') ,'')		+'】'  
           
			
			set @MapString1 = 
		   '【《W》采购单明细ID,	PRAD_PR1D_OrderDetailId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单明细ID') ,'')	+'】' + 
		   '【《W》商品ID,			PRAD_PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')			+'】'  +
           '【《W》到货计划主表ID,	 PRA_ArrivalPlanId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')	    +'】'
          
 
		SET @PRAD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
 
 
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
		
		set @PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')
 
	 PRINT @PRA_ArrivalPlanId
      
        set @PRAD_TotalDiff=cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'0') as int)-
							cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》已到数量'),'0') as int)-
							cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货数量'),'0')as int)
            
 
 
         SELECT @PRAD_PlanArrivalAmount=ISNULL(ISNULL(PR1D_POriginalPrice,'0') * cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》本次计划到货数量'),'0')as int),'0')
         FROM  B02_Bill.PR1D_OrderDetail   
         WHERE PR1D_OrderDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单明细ID'),'')
         AND   PR1D_PD0_ProductId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID'),'')
   
 
	 
		Set @SqlString='UPDATE B02_Bill.PRAD_ArrivalPlanDetail SET PRAD_UptNo=CAST(PRAD_UptNo AS INT)+1,
		PRAD_LmDt='''+@PRAD_LmDt+''',PRAD_TotalDiff='''+@PRAD_TotalDiff+''',PRAD_PlanArrivalAmount='''+@PRAD_PlanArrivalAmount+''', 
	   ' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString 
							
		 
	end
	
	
 if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
            '【状态,                PRAD_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')		     +'】' +
            '【最后修改人,		    PRAD_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')	     +'】' +                     
           
            '【《W》集团,			PRAD_CONO,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
            '【《W》事业体,			PRAD_DIVI,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
            '【《W》采购单明细ID,	PRAD_PR1D_OrderDetailId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单明细ID') ,'')	+'】' + 
		    '【《W》商品ID,			PRAD_PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')			+'】'  
			
			set @MapString1 = 
  
           '【《W》到货计划主表ID,	 PRA_ArrivalPlanId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')	    +'】'
   
   
           	SET @PRAD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		Set @SqlString='UPDATE B02_Bill.PRAD_ArrivalPlanDetail SET PRAD_UptNo=CAST(PRAD_UptNo AS INT)+1,PRAD_LmDt='''+@PRAD_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
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
		 
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString1,@HelpString,@N_ID output 
	 
	exec [~FrameDB].API_Common.ReturnRlt @N_ID,@OutputFormat ,@OutputContentType,@DB,@SqlString,@HelpString
 
 
      SELECT @PRA_PlanTotal=SUM(ISNULL(PRAD_PlanArrival,'0')),              
             @PRA_PlanAmount=SUM(ISNULL(PRAD_PlanArrivalAmount,'0'))                                            
             FROM   B02_Bill.PRAD_ArrivalPlanDetail 
             WHERE  PRAD_PRA_ArrivalPlanId=@PRA_ArrivalPlanId
             AND PRAD_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
             GROUP BY PRAD_PRA_ArrivalPlanId
             
    PRINT @PRA_ArrivalPlanId
    
     SELECT  @PRA_TotalDiff=PRA_PerchaseTotal-PRA_ArrivalTotal-CAST(@PRA_PlanTotal AS FLOAT),
			 @PRA_AmountDiff=PRA_PerchaseAmount-PRA_ArrivalAmount-CAST(@PRA_PlanAmount AS FLOAT)
     FROM  B02_Bill.PRA_ArrivalPlan
     WHERE PRA_ArrivalPlanId=@PRA_ArrivalPlanId
     AND PRA_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
     
 
     set @SqlString2 ='【操作类型,UPDATE】【实体,B02_Bill.PRA_ArrivalPlan】
					  【更新内容,本次计划到货数量,本次计划到货金额,数量差异,金额差异,到货计划ID】
					  【条件内容,《N》本次计划到货数量,《N》本次计划到货金额,
					   《N》数量差异,《N》金额差异,《W》到货计划ID】
					  【《N》本次计划到货数量,'+@PRA_PlanTotal+'】【《N》本次计划到货金额,'+@PRA_PlanAmount+'】
					  【《N》数量差异,'+@PRA_TotalDiff+'】【《N》金额差异,'+@PRA_AmountDiff+'】
					  【《W》到货计划ID,'+@PRA_ArrivalPlanId+'】'	
	 EXEC API_GLERP.Sp_PRA_ArrivalPlan 'AML','DB','RS',@SqlString2	
 
 
 
   PRINT @SqlString2
 
	print @N_ID
	print @SchemaName
	print @DB
	print @SP_Name

	
	
end

 

GO

