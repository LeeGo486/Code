USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_PRBD_ReceiveDetail_TEST]    Script Date: 09/12/2013 10:34:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc [API_GLERP].[Sp_PRBD_ReceiveDetail_TEST]
 
@InputFormat varchar(30),
@OutputFormat varchar(30),
@OutputContentType varchar(30),
@ConditionStr varchar(Max)
as

begin
    declare @SqlString nvarchar(max)
    declare @SqlString1  nvarchar(max)
    declare @SqlString2  nvarchar(max)
    declare @SqlString3  nvarchar(max)
	declare @HelpString nvarchar(max)
	Set @HelpString=''
	Declare @MapString nvarchar(max)
	Declare @MapString1 nvarchar(max)
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
	Declare @SelectFieldList1 varchar(max)
	Declare @UpdateFieldList varchar(max)
	Declare @InsertToFieldList varchar(max)
	Declare @InsertFromValueList varchar(max)
	Declare @WhereFieldList varchar(max)	
	Declare @WhereFieldList1  varchar(max)
	Declare @PowerList varchar(max)	
	declare @Lvl varchar(10)
	declare @List varchar(max)	
	declare @XmlTempTableName varchar(max)
-----自动生成	
	DECLARE @PRBD_CONO	        VARCHAR(20)
	DECLARE @PRBD_DIVI	        VARCHAR(20)
	DECLARE @PRBD_UptNo          VARCHAR(20)
    DECLARE @PRBD_RgDt           VARCHAR(50)
    DECLARE @PRBD_LmDt           VARCHAR(50)
	DECLARE @PRBD_PRB_ReceiveId  VARCHAR(50)
	DECLARE @PRBD_ReceiveDetailId VARCHAR(50)
	DECLARE @PRB_ReceiptId			VARCHAR(50)
	DECLARE @PRB_ReceiptCode		VARCHAR(50)
	DECLARE @PRB_PRA_ArrivalPlanId   VARCHAR(50)
	DECLARE @PRB_Status				 VARCHAR(50)
	DECLARE @PRB_RgUser				VARCHAR(50)
	DECLARE @PRB_PlanTotal			VARCHAR(20)
	DECLARE @PRB_PlanAmount			VARCHAR(20)
	DECLARE @PlanCode				VARCHAR(20)
	DECLARE @PRB_TypeID				VARCHAR(20)
	DECLARE @PRB_ReceiptDate		VARCHAR(20)
	DECLARE @PRB_ReceiptTotal		VARCHAR(20)
    DECLARE @PRB_ReceiptAmount		VARCHAR(20)
    DECLARE @PRBD_PlanAmount		VARCHAR(20)
    DECLARE @PRBD_PlanTotal			VARCHAR(20)
    DECLARE @PRB_SU0_SupplierId		VARCHAR(20)
	DECLARE @PRB_CHECK				VARCHAR(20)
	DECLARE @PRAD_TotalDiff			VARCHAR(20)
	DECLARE @PRBD_Total				VARCHAR(20)
	DECLARE @PRBD_PRAD_ArrivalPlanDetailId VARCHAR(20)
	DECLARE @PRA_ArrivalAmount		VARCHAR(50)	
	DECLARE @PRAD_ArrivalTotal		VARCHAR(50)	
	DECLARE @PRBD_DeptID			VARCHAR(50)
	DECLARE @PRBD_POSWHNumber		VARCHAR(50)
	DECLARE @PRBD_LmUser			VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
   
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.PRBD_ReceiveDetail】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》收货单ID,】【《W》收货单编号,】【《W》商品ID,】【《W》单位,】' +
			'【《W》采购原币价,】【《W》采购本币价,】【《W》吊牌价,】【《W》入仓ID,】' +
		    '【《W》储位,】【《W》计划到货数量,】【《W》收货数量,】【《W》POS_入库单号,】【《W》状态,】'+
		    '【《W》创建人,】【《W》创建时间,】【《W》修改人,】【《W》最后修改时间,】' 
	
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B02_Bill.PRBD_ReceiveDetail】【新增内容,必填】'+
			'【《N》收货单编号,】【《N》商品ID,】【《N》单位,】【《N》采购原币价,】【《N》采购本币价,】'+
			'【《N》吊牌价,】【《N》入仓ID,】【《N》储位,】【《N》计划到货数量,】【《N》收货数量,】【《N》POS_入库单号,】'+
			'【《N》状态,】【《N》创建人,】【《N》创建时间,】【《N》修改人,】【《N》最后修改时间,】 ' 
			 
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B02_Bill.PRBD_ReceiveDetail】【更新内容,必填】'+
			'【《N》收货单编号,】【《N》商品ID,】【《N》单位,】【《N》采购原币价,】【《N》采购本币价,】'+
			'【《N》吊牌价,】【《N》入仓ID,】【《N》储位,】【《N》计划到货数量,】【《N》收货数量,】【《N》POS_入库单号,】'+
			'【《N》状态,】【《N》修改人,】' + 
			'【《W》集团,】【《W》事业体,】'+					          
			'【《W》收货单ID,】【《W》收货单编号,】【《W》商品ID,】【《W》单位,】' +
			'【《W》采购原币价,】【《W》采购本币价,】【《W》吊牌价,】【《W》入仓ID,】' +
		    '【《W》储位,】【《W》计划到货数量,】【《W》收货数量,】【《W》POS_入库单号,】【《W》状态,】'+
		    '【《W》创建人,】【《W》创建时间,】【《W》修改人,】【《W》最后修改时间,】' 
 						
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B02_Bill.PRBD_ReceiveDetail】【更新内容,必填】【条件内容,】'+
			'【《N》状态,】【《N》最后修改人,】【《N》修改时间,】'+
			
			'【《W》集团,】【《W》事业体,】'+					          
			'【《W》收货单ID,】【《W》收货单编号,】【《W》商品ID,】【《W》单位,】' +
			'【《W》采购原币价,】【《W》采购本币价,】【《W》吊牌价,】【《W》入仓ID,】' +
		    '【《W》储位,】【《W》计划到货数量,】【《W》收货数量,】【《W》POS_入库单号,】【《W》状态,】'+
		    '【《W》创建人,】【《W》创建时间,】【《W》修改人,】【《W》最后修改时间,】' 
			 
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
			'【集团,		      PRBD_CONO,							String,'																							+'】' + 
            '【《W》收货单编号,   PRBD_PRB_ReceiveId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单编号'),'')			+'】'  
  
		set @SelectFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](		
			@MapString
			,'Select'	
			,@SelectFieldNameList
			,0	
		)
	--	set @PRAD_CONO=[~FrameDb].[API_Common].[ConvertNameListToSql](@MapString,'Select'	,'【集团】',0	)
		 
		set @PRBD_PRB_ReceiveId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单编号'),'')	
 
		IF @PRBD_PRB_ReceiveId<>'' 
		BEGIN
		   
		     set @MapString1 = 
					'【集团,					PRBD_CONO,							String,'													   +'】' + 
                    '【事业体,					PRBD_DIVI,							String,'													   +'】' + 
                    '【收货单ID,				PRBD_ReceiveDetailId,				String,'													   +'】' + 
                    '【收货单编号,				PRBD_PRB_ReceiveId,					String,'													   +'】' + 
                    '【到货计划主表ID,			PRB_PRA_ArrivalPlanId,				String,'													   +'】' +  
                    '【到货计划明细ID,			PRBD_PRAD_ArrivalPlanDetailId,		String,'													   +'】' +  
                    '【商品ID,					PRBD_PD0_ProductId,					String,'													   +'】' + 
                    '【单位,					PRBD_UnitID,						String,'													   +'】' + 
                    '【采购原币价,				PRBD_POriginalPrice,				String,'													   +'】' + 
                    '【采购本币价,				PRBD_PCurrencyPrice,				String,'													   +'】' + 
                    '【吊牌价,					PRBD_SCurrencyPrice,				String,'													   +'】' +                    
                    '【入仓ID,				    PRBD_DeptID,						String,'													   +'】' + 
                    '【储位,					PRBD_StorageId,						String,'													   +'】' + 
                    '【计划到货数量,		    PRBD_PlanTotal,						String,'													   +'】' + 
                    '【收货数量,				PRBD_Total,							String,'													   +'】' + 
                    '【POS_入库单号,			PRBD_POSWHNumber,					String,'													   +'】' + 
                    '【状态,					PRBD_Status,						String,'													   +'】' + 
                    '【创建人,					PRBD_RgUser,						String,'													   +'】' + 
                    '【创建时间,		        PRBD_RgDt,							String,'													   +'】' + 
                    '【最后修改人,		        PRBD_LmUser,						String,'													   +'】' + 
                    '【最后修改时间,		    PRBD_LmDt,							String,'													   +'】' + 
                    '【供应商款号,		        A.PD0_ProductCodeSU~PD0_ProductCodeSU ,						String,'													   +'】' + 
                    '【款号,					A.PD0_Code~PD0_Code,							String,'													   +'】' + 
                    '【单位对照,				D.DC0_DictName1~UnitDictName,		String,'													   +'】' + 
					'【《W》到货计划主表ID,		PRBD_PRB_ReceiveId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')			+'】'  
					
 
 
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
		--  PRINT 11111
			Set @SqlString='select ' +  @SelectFieldList1 + ' 
			FROM   B02_Bill.PRBD_ReceiveDetail WITH ( NOLOCK ) 
			LEFT JOIN   B01_MDM.PD0_Product A			ON A.PD0_ProductId=PRAD_PD0_ProductId
			 
			LEFT JOIN   M01_CONF.DC0_Dictionary D        ON PRBD_UnitID=D.DC0_DictId  
			LEFT JOIN   B02_Bill.PRB_Receipt E			 ON E.PRB_ReceiveId=PRBD_PRB_ReceiveId
			where  PRBD_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1  ORDER BY PRBD_LmDt ''   '  
		--	PRINT @SqlString
 		end
 		ELSE
 		BEGIN 
 		  
			Set @SqlString='select ' +  @SelectFieldList1 + ' 
			FROM   B02_Bill.PRBD_ReceiveDetail WITH ( NOLOCK ) 
			LEFT JOIN   B01_MDM.PD0_Product A			ON A.PD0_ProductId=PRAD_PD0_ProductId
		 
			LEFT JOIN   M01_CONF.DC0_Dictionary D        ON PRBD_UnitID=D.DC0_DictId  
			where  PRBD_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND  ' + @WhereFieldList1
			+' ORDER BY PRBD_LmDt'
 		END
 		
    
 
		END 
		ELSE
		BEGIN
 
		  set @MapString1 = 
					'【集团,					PRA_CONO,												String,'													   +'】' + 
                    '【事业体,					PRA_DIVI,												String,'													   +'】' + 
                    '【收货单ID,				''''~PRBD_ReceiveDetailId,								String,'													   +'】' + 
                    '【收货单主表ID,			''''~PRB_ReceiptId,										String,'													   +'】' + 
                    '【收货单编号,				''''~PRB_ReceiptId,										String,'													   +'】' + 
                    '【收货单类型,				''''~PRB_TypeID,										String,'													   +'】' + 
                    '【商品ID,					PRAD_PD0_ProductId,										String,'													   +'】' + 
                    '【单位,					PRAD_UnitID,											String,'													   +'】' + 
                    '【到货计划ID,			    PRA_ArrivalPlanId,										String,'													   +'】' + 
                    '【供应商编号,			    PRA_SU0_SupplierId,										String,'													   +'】' + 
                    '【到货计划明细ID,		    PRAD_ArrivalPlanDetailId,								String,'													   +'】' +                     
                    '【采购原币价,				PRAD_POriginalPrice,									String,'													   +'】' + 
                    '【采购本币价,				PRAD_PCurrencyPrice,									String,'													   +'】' +                    
                    '【吊牌价,					PRAD_SCurrencyPrice,									String,'													   +'】' +
                    '【入仓ID,					''''~PRBD_DeptID,										String,'													   +'】' + 
                    '【计划到货主表数量,		PRA_PlanTotal,											String,'													   +'】' + 
                    '【计划到货主表金额,		PRA_PlanAmount,											String,'													   +'】' +                    
                    '【储位,					''''~PRBD_StorageId,									String,'													   +'】' + 
                    '【计划到货数量,			0~PRAD_PlanArrival,										String,'													   +'】' + 
                    '【计划到货金额,			0~PRBD_PlanAmount,										String,'													   +'】' +                     
                    '【收货数量,		        0~PRBD_Total,											String,'													   +'】' + 
                    '【POS_入库单号,		    ''''~PRBD_POSWHNumber,									String,'													   +'】' + 
                    '【状态,					''''~PRBD_RgUser,										String,'													   +'】' + 
                    '【创建人,					''''~PRBD_RgUser,										String,'													   +'】' + 
                    '【创建时间,		        ''''~PRBD_RgDt,											String,'													   +'】' + 
                    '【最后修改人,		        ''''~PRBD_LmUser,										String,'													   +'】' + 
                    '【最后修改时间,		    ''''~PRBD_LmDt,											String,'													   +'】' + 
                    '【供应商款号,		        A.PD0_ProductCodeSU~PD0_ProductCodeSU ,						String,'													   +'】' + 
                    '【款号,					A.PD0_Code~PD0_Code,							String,'													   +'】' + 
					'【供应商颜色,		        E.DC0_DictName1~ColorSU_DictName ,						String,'													   +'】' + 
                    '【供应商尺码,		        F.DC0_DictName1~SizeSU_DictName ,						String,'													   +'】' + 
                    '【颜色,					G.DC0_DictName1~Color_DictName ,						String,'													   +'】' + 
                    '【尺码,					H.DC0_DictName1~Size_DictName ,						String,'													   +'】' + 
                    
                    '【单位对照,				D.DC0_DictName1~UnitDictName,							String,'													   +'】' + 
                                     
					'【《W》到货计划主表ID,			PRA_ArrivalPlanId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')			+'】'  
 
			set @SelectFieldList1=[~FrameDb].[API_Common].[ConvertNameListToSql](		
				@MapString1
				,'Select'	
				,@SelectFieldNameList
				,0	
				)
        
		  print @SelectFieldList1
			set @WhereFieldList1=[~FrameDb].[API_Common].[ConvertNameListToSql](
			@MapString1
			,'Where'	
			,@WhereFieldNameList
			,0	
		    )	 
  
 
			Set @SqlString='select ' +  @SelectFieldList1 + ' 
			FROM  B02_Bill.PRA_ArrivalPlan WITH ( NOLOCK )    
			LEFT JOIN B02_Bill.PRAD_ArrivalPlanDetail  ON PRA_ArrivalPlanId=PRAD_PRA_ArrivalPlanId
            LEFT JOIN B02_Bill.PRBD_ReceiveDetail      ON PRBD_PRB_ReceiveId=PRAD_ArrivalPlanDetailId  
            LEFT JOIN   B01_MDM.PD0_Product A			 ON A.PD0_ProductId=PRAD_PD0_ProductId
           
		 
			LEFT JOIN   M01_CONF.DC0_Dictionary D        ON PRAD_UnitID=D.DC0_DictId    
			LEFT JOIN   M01_CONF.DC0_Dictionary E        ON A.PD0_ColorSUId=E.DC0_DictId  
			LEFT JOIN   M01_CONF.DC0_Dictionary F        ON A.PD0_SizeSUId=F.DC0_DictId 
			LEFT JOIN   M01_CONF.DC0_Dictionary G        ON A.PD0_ColorId=G.DC0_DictId        
			LEFT JOIN   M01_CONF.DC0_Dictionary H        ON A.PD0_SizeId=H.DC0_DictId                             
			where PRA_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND  ' + @WhereFieldList1
			--+
			--'GROUP BY  PR1_CONO,PR1_DIVI ,PR1D_PD0_ProductId,PR1D_OrderDetailId,PR1D_UnitID    
			--,PR1D_Total,PR1D_POriginalPrice,PR1D_PCurrencyPrice,PR1D_SCurrencyPrice,B.DC0_DictName1,C.DC0_DictName1,D.DC0_DictName1'
   PRINT @SqlString
		  
		END
			  					
	end
 	 
if @mdl='NEW'  
 
	begin
 
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
  	 	 
 
		set @MapString =          
	       --'【到货计划主表ID,		PRA_ArrivalPlanId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划主表ID'),'')+'】' +
           --'【到货计划编号,		    PRA_ArrivalPlanCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划编号'),'')	+'】' +
          -- '【商品ID,				PRBD_PD0_ProductId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')			+'】'+
           --'【单位,					PRBD_UnitID,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单位'),'')			+'】'+
           '【到货计划明细ID,		PRBD_PRAD_ArrivalPlanDetailId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划明细ID'),'')	+'】'+
         --  '【采购原币价,			PRBD_POriginalPrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'')		+'】'+
         -- '【采购本币价,			PRBD_PCurrencyPrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购本币价'),'')		+'】'+                
         --  '【吊牌价,				PRBD_SCurrencyPrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》吊牌价'),'')			+'】'+    
          -- '【入仓ID,				PRBD_DeptID,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》入仓ID'),'')			+'】'+
          -- '【储位,				PRBD_StorageId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》储位'),'')			+'】'+
           '【计划到货数量,		    PRBD_PlanTotal,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货数量'),'')	+'】'+
          -- '【计划到货金额,		PRBD_PlanAmount,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货金额'),'')	+'】'+
           '【收货数量,				PRBD_Total,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货数量'),'')		+'】'+
           --'【POS_入库单号,		PRBD_POSWHNumber,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》POS_入库单号'),'')	+'】'+
           '【状态,					PRBD_Status,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			+'】'+
           '【创建人,				PRBD_RgUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')			+'】'+            
           '【最后修改人,		    PRBD_LmUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		+'】'
		   --'【采购单编号,		    PRA_PR1_OrderId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')		+'】'+
            
 
 		set @MapString1 =          
	       '【收货单主表ID,				PRB_ReceiptId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单主表ID'),'')			+'】' + 
           '【收货单编号,				PRB_ReceiptCode,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划编号'),'')	    +'】'+
           '【供应商编号,			    PRB_SU0_SupplierId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'')	    +'】'+
           '【到货计划主表ID,			PRB_PRA_ArrivalPlanId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划主表ID'),'')			+'】'+ 
           '【收货单类型,				PRB_TypeID ,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单类型'),'')		+'】'+
		   '【计划到货主表数量,		    PRB_PlanTotal ,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货主表数量'),'')		+'】'+
           '【计划到货主表金额,		    PRB_PlanAmount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货主表金额'),'')		+'】'+
           '【收货时间,					PRB_ReceiptDate ,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货时间'),'')		+'】'
		   
		 
 
		SET @PRBD_CONO='100'
		 
		SET @PRBD_DIVI='200'
		SET @PRBD_ReceiveDetailId=newID() 
	--	SET @PRB_ReceiptId=newID() 
        SET @PRBD_DeptID='G0001001'
	    SET @PRBD_UptNo='0'
 	
		SET @PRBD_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @PRBD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
		 
 
 
 
 
 	 	
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
       
		set @PRB_ReceiptId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单主表ID'),'')	
		set @PRB_ReceiptCode=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单编号'),'')	
        set @PRB_PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划主表ID'),'')
        set @PRB_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
        set @PRB_RgUser=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')
		set @PRB_PlanTotal=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货主表数量'),'0')
		set @PRB_PlanAmount=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货主表金额'),'0')
		set @PRBD_PlanTotal=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货数量'),'0')
		set @PRB_TypeID=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货单类型'),'0')
		set @PRB_ReceiptDate=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货时间'),'0')
		set @PRB_SU0_SupplierId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商编号'),'0')
		set @PRBD_Total=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货数量'),'0')
      --  set @PRBD_PRAD_ArrivalPlanDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划明细ID'),'0') 	 
        
      
        
        SELECT @PRB_CHECK=ISNULL(max(PRB_ReceiptId),'')    
        FROM B02_Bill.PRB_Receipt
        WHERE PRB_ReceiptId=@PRB_ReceiptId
        PRINT @PRB_CHECK
        if @PRB_CHECK=''
        begin
			IF @PRB_ReceiptCode=''
         
				BEGIN
					
					
					SELECT  @PRB_ReceiptCode=ISNULL(MAX(PRB_ReceiptCode),''),
					@PlanCode= 'SH'+left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)  
					+LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
					FROM B02_Bill.PRB_Receipt where 
					LEFT(PRB_ReceiptCode,2)='SH' 
					AND RIGHT(LEFT(PRB_ReceiptCode,6),4)=left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)   
					AND left(right(PRB_ReceiptCode,7),2)=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
  
        				IF @PRB_ReceiptCode='' 
						BEGIN
							set  @PRB_ReceiptCode=@PlanCode+'00001'		
						END 
						ELSE
						BEGIN
				 		    
					 	
							set @PRB_ReceiptCode=@PlanCode+RIGHT('00000'+CAST(CAST(RIGHT(@PRB_ReceiptCode,5) AS INT )+1 AS VARCHAR(20)),5 )   
						END 			
			END	
		 
			 
		 
		--set @PRA_PerchaseTotal=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'')
 		     
 
				set @SqlString1 ='【操作类型,NEW】【实体,B02_Bill.PRB_Receipt】
						      【新增内容,收货单主表ID,到货计划主表ID,收货单编号,到货主表计划ID,收货单类型,计划到货主表数量,计划到货主表金额,此次收货数量,此次收货金额,收货时间,状态,创建人,最后修改人,供应商编号】       
						     
						     【条件内容,《N》收货单主表ID《N》收货单编号,《N》到货主表计划ID,《N》收货单类型,《N》计划到货主表数量,
							  《N》计划到货主表金额,《N》此次收货数量,《N》此次收货金额,《N》收货时间,《N》状态,《N》创建人,《N》最后修改人,《N》供应商编号】 								        
							 【《N》收货单主表ID,'+@PRB_ReceiptId+'】【《N》收货单编号,'+@PRB_ReceiptCode+'】【《N》到货主表计划ID,'+@PRB_PRA_ArrivalPlanId+'】【《N》收货单类型,'+@PRB_TypeID+'】
							 【《N》计划到货主表数量,'+@PRB_PlanTotal+'】【《N》计划到货主表金额,'+@PRB_PlanAmount+'】【《N》此次收货数量,0】【《N》此次收货金额,0】【《N》收货时间,'+@PRB_ReceiptDate+'】 
							 【《N》状态,'+@PRB_Status+'】【《N》创建人,'+@PRB_RgUser+'】【《N》最后修改人,'+@PRB_RgUser+'】【《N》供应商编号,'+@PRB_SU0_SupplierId+'】'	
	      
 
				EXEC API_GLERP.Sp_PRB_Receipt 'AML','DB','RS',@SqlString1	       
        end 
        
        
       set @List=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单明细Get_XML'),'')
 
		exec [~FrameDB].API_XML.SelectXMLAsTable 
		@List
		,'/ROOT/LIST/ROW'
		,2
		,'( PRBD_PD0_ProductId  varchar(50),PRBD_UnitID	varchar(50),PRBD_PRAD_ArrivalPlanDetailId varchar(50),PRBD_POriginalPrice varchar(50),
			PRBD_PCurrencyPrice varchar(50),PRBD_SCurrencyPrice  varchar(50),PRBD_PlanTotal	varchar(50),PRBD_Total varchar(50)
		 )'
		,@XmlTempTableName output
 
		 /*   SELECT  @PRBD_POSWHNumber=ISNULL(MAX(PRBD_POSWHNumber),''),
				    @PlanCode='RK1001'+'-'+left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)+'-'
					+LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)+'-'
					+RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),2)+'-'
					FROM B02_Bill.PRBD_ReceiveDetail where 
					LEFT(PRBD_POSWHNumber,6)='RK1001' 
					AND RIGHT(LEFT(PRBD_POSWHNumber,11),4)=left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)  
					AND RIGHT(LEFT(PRBD_POSWHNumber,14),2)=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
	                AND RIGHT(LEFT(PRBD_POSWHNumber,17),2)=RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),2)
			IF @PRBD_POSWHNumber='' 
						BEGIN
							set  @PRBD_POSWHNumber=@PlanCode+'0001'		
						END 
						ELSE
						BEGIN
							set @PRBD_POSWHNumber=@PlanCode+RIGHT('0000'+CAST(CAST(RIGHT(@PRBD_POSWHNumber,4) AS INT )+1 AS VARCHAR(20)),4 )   
						END */
						
						
						
 
		 SET @SqlString='INSERT INTO  B02_Bill.PRBD_ReceiveDetail(PRBD_CONO,PRBD_DIVI,	
		PRBD_ReceiveDetailId,PRBD_PRB_ReceiveId,PRBD_PRAD_ArrivalPlanDetailId,PRBD_PD0_ProductId,PRBD_UnitID, ' 
 		+'PRBD_POriginalPrice,PRBD_PCurrencyPrice,PRBD_SCurrencyPrice,PRBD_DeptID,PRBD_StorageId,'
 		+'PRBD_PlanTotal,PRBD_PlanAmount,PRBD_Total,PRBD_POSWHNumber,PRBD_Status,PRBD_RgUser,PRBD_RgDt,PRBD_LmUser,PRBD_LmDt,PRBD_UptNo)'
		+'  SELECT '''+@PRBD_CONO+''','''+@PRBD_DIVI+''',newID(),'''+@PRB_ReceiptId+''',PRBD_PRAD_ArrivalPlanDetailId,PRBD_PD0_ProductId,PRBD_UnitID,'
		+'PRBD_POriginalPrice,PRBD_PCurrencyPrice,PRBD_SCurrencyPrice,'''+@PRBD_DeptID+''','''',PRBD_PlanTotal,' 
		+'cast(cast(PRBD_POriginalPrice as decimal(20,6))*cast(PRBD_Total as decimal(20,6)) as decimal(20,6)),PRBD_Total,'''','
		+''''+@PRB_Status+''','''+@PRB_RgUser+''','''+@PRBD_LmDt+''','
		+''''+@PRB_RgUser+''','''+@PRBD_LmDt+''',''0'' '
		+ 'FROM '+ @XmlTempTableName+ ' ' 
 
   PRINT @SqlString
 
 
   /*     SELECT @PRBD_PlanAmount=ISNULL(ISNULL(CAST(PRAD_POriginalPrice AS DECIMAL(20,6)),'0') * cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货数量'),'0')as int),'0')
          FROM  B02_Bill.PRAD_ArrivalPlanDetail
          WHERE PRAD_ArrivalPlanDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划明细ID'),'')
          AND   PRAD_PD0_ProductId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')
 
 		Set @SqlString='INSERT INTO  B02_Bill.PRBD_ReceiveDetail(PRBD_CONO,PRBD_DIVI,PRBD_ReceiveDetailId,
 		PRBD_UptNo,PRBD_RgDt,PRBD_LmDt,PRBD_PRB_ReceiveId,PRBD_PlanAmount,PRBD_DeptID,PRBD_POSWHNumber,' 	 
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@PRBD_CONO+''','''+@PRBD_DIVI+''','''+@PRBD_ReceiveDetailId+''','			 
		Set @SqlString=@SqlString+' '''+@PRBD_UptNo+''','''+@PRBD_RgDt+''','''+@PRBD_LmDt+''','''+@PRB_ReceiptId+''','''+@PRBD_PlanAmount+''','''+@PRBD_DeptID+''','''+@PRBD_POSWHNumber+''','+@InsertFromValueList+')'				
 
   PRINT @SqlString*/
 

	end
 
if @mdl='UPDATE'  
	begin
 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
 
		set @MapString = 
		  -- '【商品ID,				PRBD_PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')			+'】'+
           -- '【到货计划明细ID,		PRBD_ReceiveDetailId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划明细ID'),'')	+'】'+
          -- '【采购原币价,			PRBD_POriginalPrice,	    String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'')		+'】'+
         --  '【入仓ID,				PRBD_DeptID,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》入仓ID'),'')			+'】'+
          -- '【储位,					PRBD_StorageId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》储位'),'')			+'】'+
          -- '【计划到货数量,		    PRBD_PlanTotal,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货数量'),'')	+'】'+
          -- '【收货数量,				PRBD_Total,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货数量'),'')		+'】'+
          -- '【POS_入库单号,			PRBD_POSWHNumber,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》POS_入库单号'),'')	+'】'+
           '【状态,					PRBD_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			+'】'+
           '【最后修改人,		    PRBD_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		+'】'+            
           '【《W》集团,			PRBD_CONO,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
           '【《W》事业体,			PRBD_DIVI,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' 
        -- '【《W》到货计划明细ID,	PRBD_PR1D_OrderDetailId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划明细ID') ,'')	+'】' + 
		--   '【《W》商品ID,			PRBD_PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')			+'】' +
	      -- '【《W》收货单明细ID,	PRBD_ReceiveDetailId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单明细ID') ,'')	+'】'  
			set @MapString1 = 
		   '【《W》收货单主表ID,	 PRB_ReceiptId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单主表ID'),'')		+'】' + 
           '【《W》到货计划主表ID,	 PRB_PRA_ArrivalPlanId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')	    +'】'
          
 
		SET @PRBD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
		
		
 
 
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
	 
		set @PRB_ReceiptId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单主表ID'),'')	
 
        set @PRB_PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')
       -- set @PRB_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
		--set @PRBD_Total=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货数量'),'0')
       -- set @PRBD_PRAD_ArrivalPlanDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划明细ID'),'0') 	
 		set @PRBD_LmUser=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')
 
 
      set @List=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单明细Get_XML'),'')
 
		exec [~FrameDB].API_XML.SelectXMLAsTable 
		@List
		,'/ROOT/LIST/ROW'
		,2
		,'(	PRBD_ReceiveDetailId varchar(50),PRBD_Status varchar(50),	PRBD_POriginalPrice varchar(50),PRBD_DeptID  varchar(50),
			PRBD_StorageId varchar(50), PRBD_PlanTotal	varchar(50),	PRBD_Total varchar(50)
		 )'
		,@XmlTempTableName output
		
 
		SET @SqlString='UPDATE  A SET A.PRBD_UptNo=CAST(A.PRBD_UptNo AS INT)+1,A.PRBD_Status=B.PRBD_Status, '
		+'A.PRBD_LmDt='''+@PRBD_LmDt+''','
		+'A.PRBD_PlanAmount=cast(cast(B.PRBD_POriginalPrice as decimal(20,6))*cast(B.PRBD_PlanTotal as decimal(20,6)) as decimal(20,6)),'
		+'A.PRBD_DeptID=B.PRBD_DeptID,A.PRBD_StorageId=B.PRBD_StorageId,A.PRBD_LmUser='''+@PRBD_LmUser+''',A.PRBD_Total=B.PRBD_Total FROM B02_Bill.PRBD_ReceiveDetail A,'+ @XmlTempTableName+ ' B '
		+' WHERE A.PRBD_ReceiveDetailId=B.PRBD_ReceiveDetailId'
 
 
       /*  SELECT @PRBD_PlanAmount=ISNULL(ISNULL(CAST(PRAD_POriginalPrice AS DECIMAL(20,6)),'0') * cast(isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》计划到货数量'),'0')as int),'0')
         FROM  B02_Bill.PRAD_ArrivalPlanDetail
         WHERE PRAD_ArrivalPlanDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划明细ID'),'')
         AND   PRAD_PD0_ProductId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')
 
   
 
	 
		Set @SqlString='UPDATE B02_Bill.PRBD_ReceiveDetail SET PRBD_UptNo=CAST(PRBD_UptNo AS INT)+1,
		PRBD_LmDt='''+@PRBD_LmDt+''',PRBD_PlanAmount='''+@PRBD_PlanAmount+''', 
	   ' +  @UpdateFieldList + '  where ' + @WhereFieldList   */
		
 		 
				 			
		 
	end
	 
	
  if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
          -- '【到货计划明细ID,		PRBD_ReceiveDetailId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》到货计划明细ID'),'')	+'】'+
           '【状态,					PRBD_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			+'】'+      
           '【最后修改人,		    PRBD_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		+'】'+            
           '【《W》集团,			PRBD_CONO,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
           '【《W》事业体,			PRBD_DIVI,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
           '【《W》到货计划明细ID,	PRBD_PR1D_OrderDetailId,	String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划明细ID') ,'')	+'】' + 
		   '【《W》商品ID,			PRBD_PD0_ProductId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')			+'】' +
	       '【《W》收货单明细ID,	PRBD_ReceiveDetailId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单明细ID') ,'')		+'】'  
			set @MapString1 = 
		   '【《W》收货单主表ID,	PRB_ReceiptId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单主表ID'),'')			+'】' + 
           '【《W》到货计划主表ID,	PRB_ReceiptId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')	    +'】'
   
   
           	SET @PRBD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		
 		set @PRB_ReceiptId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单主表ID'),'')	
 
        set @PRB_PRA_ArrivalPlanId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划主表ID'),'')
        set @PRB_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
		set @PRBD_Total='0'
      --  set @PRBD_PRAD_ArrivalPlanDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》到货计划明细ID'),'0') 	
 
	    set @List=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》收货单明细Get_XML'),'')
 
		exec [~FrameDB].API_XML.SelectXMLAsTable 
		@List
		,'/ROOT/LIST/ROW'
		,2
		,'(	PRBD_ReceiveDetailId varchar(50),PRBD_Status varchar(50))'
		,@XmlTempTableName output
		
 
		SET @SqlString='UPDATE  A SET A.PRBD_UptNo=CAST(A.PRBD_UptNo AS INT)+1,A.PRBD_Status=B.PRBD_Status, '
		+'A.PRBD_LmDt='''+@PRBD_LmDt+''','
		+'A.PRBD_LmUser='''+@PRBD_LmUser+''',A.PRBD_Total=''0'' FROM B02_Bill.PRBD_ReceiveDetail A,'+ @XmlTempTableName+ ' B '
		+' WHERE A.PRBD_ReceiveDetailId=B.PRBD_ReceiveDetailId'
 
	 
	 
	 
	 
		/*print @UpdateFieldList
		Set @SqlString='UPDATE B02_Bill.PRBD_ReceiveDetail SET PRBD_UptNo=CAST(PRBD_UptNo AS INT)+1,PRBD_LmDt='''+@PRBD_LmDt+''',' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							*/
		  
	end  

 	--根据格式返回结果
 
	Declare @DB varchar(250),@N_ID varchar(50),@SP_Name varchar(500),@SchemaName varchar(500)
	set @DB=DB_NAME()
	Set @SP_Name=object_name(@@PROCID)
	--print @SqlString
	N:
	exec [~FrameDb].API_COMMON.GetSchemaName @DB,@@PROCID,@SchemaName output
 
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString1 ,@HelpString,@N_ID output 
 
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString,@HelpString,@N_ID output 
 
	exec [~FrameDB].API_Common.ReturnRlt @N_ID,@OutputFormat ,@OutputContentType,@DB,@SqlString,@HelpString
 
   IF @mdl<>'GET'  
    begin   

      SELECT @PRB_ReceiptTotal=SUM(ISNULL(CAST(PRBD_PlanTotal AS DECIMAL(20,0)),'0')),              
             @PRB_ReceiptAmount=SUM(ISNULL(CAST(PRBD_PlanAmount AS DECIMAL(20,2)),'0'))                                            
             FROM   B02_Bill.PRBD_ReceiveDetail 
             WHERE  PRBD_PRB_ReceiveId=@PRB_ReceiptId
             AND PRBD_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
             GROUP BY PRBD_PRB_ReceiveId
 
     PRINT  @PRB_ReceiptTotal
 
     set @SqlString2 ='【操作类型,UPDATE】【实体,B02_Bill.PRB_Receipt】
					  【更新内容,此次收货数量,此次收货金额,到货计划ID,状态】
					  【条件内容,《N》此次收货数量,《N》此次收货金额,《N》状态,《W》收货单ID】
					  【《N》此次收货数量,'+@PRB_ReceiptTotal+'】【《N》此次收货金额,'+@PRB_ReceiptAmount+'】
					  【《N》状态,'+@PRB_Status+'】
					  【《W》收货单ID,'+@PRB_ReceiptId+'】'	
	 EXEC API_GLERP.Sp_PRB_Receipt 'AML','DB','RS',@SqlString2	 

 /*    set @SqlString3 ='【操作类型,UPDATE】【实体,Sp_PRAD_ArrivalPlanDetail】
					  【更新内容,此次收货数量,此次收货金额,到货计划ID】
					  【条件内容,《N》此次收货数量,《N》此次收货金额,《W》收货单ID】
					  【《N》此次收货数量,'+@PRB_ReceiptTotal+'】【《N》此次收货金额,'+@PRB_ReceiptAmount+'】
					  【《W》收货单ID,'+@PRB_ReceiptId+'】'	
	 EXEC API_GLERP.Sp_PRB_Receipt 'AML','DB','RS',@SqlString3	 
*/

 
     UPDATE A
     SET A.PRAD_ArrivalTotal=@PRBD_Total
     FROM B02_Bill.PRAD_ArrivalPlanDetail A,B02_Bill.PRBD_ReceiveDetail  B
     WHERE   A.PRAD_ArrivalPlanDetailId=B.PRBD_PRAD_ArrivalPlanDetailId
     AND    A.PRAD_PRA_ArrivalPlanId=@PRB_PRA_ArrivalPlanId
     AND	PRAD_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
	  
     UPDATE B02_Bill.PRAD_ArrivalPlanDetail SET PRAD_TotalDiff=
     CAST(ISNULL(CAST(PRAD_PerchaseTotal AS DECIMAL(20,0)),'0') AS int )-CAST(ISNULL(CAST(PRAD_ArrivalTotal AS DECIMAL(20,0)),'0') AS int ) 
     - CAST(ISNULL(CAST(PRAD_PlanArrival AS DECIMAL(20,0)),'0') AS int )  
     WHERE PRAD_PRA_ArrivalPlanId=@PRB_PRA_ArrivalPlanId
     AND PRAD_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
    
     SELECT   @PRAD_ArrivalTotal=SUM(CAST(B.PRAD_ArrivalTotal AS DECIMAL(20,0)))
     FROM B02_Bill.PRA_ArrivalPlan A,B02_Bill.PRAD_ArrivalPlanDetail B
     WHERE   A.PRA_ArrivalPlanId=B.PRAD_PRA_ArrivalPlanId
     and     A.PRA_ArrivalPlanId=@PRB_PRA_ArrivalPlanId
	 AND PRA_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
 
    select @PRA_ArrivalAmount=SUM(ISNULL(CAST(ISNULL(PRAD_POriginalPrice,'0') AS DECIMAL(20,6))*CAST(ISNULL(PRAD_ArrivalTotal,'0') AS DECIMAL(20,0)),'0'))
    FROM  B02_Bill.PRAD_ArrivalPlanDetail 
    WHERE PRAD_PRA_ArrivalPlanId=@PRB_PRA_ArrivalPlanId
    AND PRAD_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
    
     UPDATE   B02_Bill.PRA_ArrivalPlan 
     SET PRA_ArrivalTotal=@PRAD_ArrivalTotal,PRA_ArrivalAmount=@PRA_ArrivalAmount
     WHERE  PRA_ArrivalPlanId=@PRB_PRA_ArrivalPlanId
	 AND PRA_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
	 
 
	 
     UPDATE B02_Bill.PRA_ArrivalPlan  SET PRA_TotalDiff=
     CAST(ISNULL(CAST(PRA_PerchaseTotal AS DECIMAL(20,0)),'0') AS int )-ISNULL(CAST(PRA_ArrivalTotal AS DECIMAL(20,0)),'0')  
     - CAST(ISNULL(PRA_PlanAmount,'0') AS DECIMAL(20,0) ),
     PRA_AmountDiff=
      CAST(ISNULL(PRA_PerchaseAmount,'0') AS  DECIMAL(20,0) )-CAST(ISNULL(PRA_ArrivalAmount,'0') AS  DECIMAL(20,0) ) 
     - CAST(ISNULL(PRA_PlanAmount,'0') AS  DECIMAL(20,0) )
     WHERE PRA_ArrivalPlanId=@PRB_PRA_ArrivalPlanId
	 AND PRA_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'  
    end	
    
    IF @mdl='NEW'  
    begin
    
	    Declare READ_Design Cursor
		For Select distinct PRBD_ReceiveDetailId From B02_Bill.PRBD_ReceiveDetail 
		where PRBD_PRB_ReceiveId=@PRB_ReceiptId and PRBD_LmDt=@PRBD_LmDt
		and PRBD_POSWHNumber=''
		Open READ_Design 
		Fetch Next From READ_Design Into @PRBD_ReceiveDetailId
		While ( @@Fetch_Status=0 )
		Begin
			
					SELECT  @PRBD_POSWHNumber=ISNULL(MAX(PRBD_POSWHNumber),''),
							@PlanCode='RK1001'+'-'+left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)+'-'
							+LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)+'-'
							+RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),2)+'-'
							FROM B02_Bill.PRBD_ReceiveDetail where 
							LEFT(PRBD_POSWHNumber,6)='RK1001' 
							AND RIGHT(LEFT(PRBD_POSWHNumber,11),4)=left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)  
							AND RIGHT(LEFT(PRBD_POSWHNumber,14),2)=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
							AND RIGHT(LEFT(PRBD_POSWHNumber,17),2)=RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),2)
					IF @PRBD_POSWHNumber='' 
					BEGIN
						set  @PRBD_POSWHNumber=@PlanCode+'0001'		
					END 
					ELSE
					BEGIN
						set @PRBD_POSWHNumber=@PlanCode+RIGHT('0000'+CAST(CAST(RIGHT(@PRBD_POSWHNumber,4) AS INT )+1 AS VARCHAR(20)),4 )   
					END 	
			 
				UPDATE 	B02_Bill.PRBD_ReceiveDetail  SET PRBD_POSWHNumber=@PRBD_POSWHNumber
				WHERE PRBD_ReceiveDetailId=@PRBD_ReceiveDetailId	
				PRINT  @PRBD_ReceiveDetailId
		
		Fetch Next From READ_Design Into @PRBD_ReceiveDetailId
		END
		CLose READ_Design 
		Deallocate READ_Design
	end
end

 

GO

