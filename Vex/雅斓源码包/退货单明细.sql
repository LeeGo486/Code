USE [GL_ERP]
GO

/****** Object:  StoredProcedure [API_GLERP].[Sp_PRCD_ReturnDetail]    Script Date: 09/12/2013 10:35:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
CREATE proc [API_GLERP].[Sp_PRCD_ReturnDetail]
 
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
	declare @Lvl varchar(50)
-----自动生成	
	DECLARE @PRCD_CONO	        VARCHAR(50)
	DECLARE @PRCD_DIVI	        VARCHAR(50)
	DECLARE @PRCD_UptNo          VARCHAR(50)
    DECLARE @PRCD_RgDt           VARCHAR(50)
    DECLARE @PRCD_LmDt           VARCHAR(50)
	DECLARE @PRC_ReturnId		 VARCHAR(50)
	DECLARE @PRCD_ReturnDetailId VARCHAR(50)
	DECLARE @PRC_ReturnCode			VARCHAR(50)
	DECLARE @PRC_PR1_OrderId   VARCHAR(50)
	DECLARE @PRC_Status				 VARCHAR(50)
	DECLARE @PRC_RgUser				VARCHAR(50)
	DECLARE @PRC_Total			VARCHAR(50)
	DECLARE @PRC_PRC_Amount		VARCHAR(50)
	DECLARE @PlanCode				VARCHAR(50)
    DECLARE @PRC_PR1_OrderCode VARCHAR(50)
    DECLARE @PRCD_Total		VARCHAR(50)
    DECLARE @PRCD_Amount		VARCHAR(50)
    DECLARE @PRC_SU0_SupplierId		VARCHAR(50)
	DECLARE @PRC_CHECK				VARCHAR(50)
	DECLARE @PRCD_POriginalPrice			VARCHAR(50)
	--DECLARE @PRBD_Total				VARCHAR(20)
	DECLARE @PRCD_PR1D_OrderDetailId VARCHAR(50)
	DECLARE @PRC_Amount		VARCHAR(50)	
	DECLARE @PRCD_RetDeptID			VARCHAR(50)
	DECLARE @PRCD_POSRetCode		VARCHAR(50)
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】')  
		begin
   
			set @HelpString=
			'【操作类型,GET】【实体,B02_Bill.PRCD_ReturnDetail】【返回内容,必填】【条件内容,】【《W》集团,】【《W》事业体,】'+
			'【《W》退货单ID,】【《W》退货单编号,】【《W》商品ID,】【《W》单位,】' +
			'【《W》采购原币价,】【《W》采购本币价,】【《W》吊牌价,】【《W》退货仓ID,】' +
		    '【《W》POS_退货单号,】【《W》收货数量,】【《W》退货金额,】【《W》退货原因,】【《W》状态,】'+
		    '【《W》创建人,】【《W》创建时间,】【《W》修改人,】【《W》最后修改时间,】' 
	
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,B02_Bill.PRB_Receipt】【新增内容,必填】'+
			'【《N》收货单编号,】【《N》商品ID,】【《N》单位,】【《N》采购原币价,】【《N》采购本币价,】'+
			'【《N》吊牌价,】【《N》入仓ID,】【《N》储位,】【《N》计划到货数量,】【《N》收货数量,】【《N》POS_入库单号,】'+
			'【《N》状态,】【《N》创建人,】【《N》创建时间,】【《N》修改人,】【《N》最后修改时间,】 ' 
			 
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,UPDATE】【实体,B02_Bill.PRA_ArrivalPlan】【更新内容,必填】'+
			'【《N》收货单编号,】【《N》商品ID,】【《N》单位,】【《N》采购原币价,】【《N》采购本币价,】'+
			'【《N》吊牌价,】【《N》入仓ID,】【《N》储位,】【《N》计划到货数量,】【《N》收货数量,】【《N》POS_入库单号,】'+
			'【《N》状态,】【《N》修改人,】' + 
			'【《W》集团,】【《W》事业体,】'+					          
			'【《W》收货单ID,】【《W》收货单编号,】【《W》商品ID,】【《W》单位,】' +
			'【《W》采购原币价,】【《W》采购本币价,】【《W》吊牌价,】【《W》入仓ID,】' +
		    '【《W》储位,】【《W》计划到货数量,】【《W》收货数量,】【《W》POS_入库单号,】【《W》状态,】'+
		    '【《W》创建人,】【《W》创建时间,】【《W》修改人,】【《W》最后修改时间,】' 
 						
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,DELETE】【实体,B02_Bill.PRA_ArrivalPlan】【更新内容,必填】【条件内容,】'+
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
            '【《W》退货单主表ID,   PRC_ReturnId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')			+'】'  
  
	 
	--	set @PRAD_CONO=[~FrameDb].[API_Common].[ConvertNameListToSql](@MapString,'Select'	,'【集团】',0	)
		 
		set @PRC_ReturnId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')	
   PRINT @PRC_ReturnId
		IF @PRC_ReturnId<>'' 
		BEGIN
		    
		     set @MapString1 = 
					'【集团,					PRCD_CONO,							String,'													   +'】' + 
                    '【事业体,					PRCD_DIVI,							String,'													   +'】' + 
                    '【退货单明细ID,			PRCD_ReturnDetailId,				String,'													   +'】' + 
                    '【退货单主表ID,			PRCD_PRC_ReturnId,					String,'													   +'】' + 
                  --  '【退货单编号,				PRCD_PRC_ReturnCode,				String,'													   +'】' +  
                    '【采购单明细ID,			PRCD_PR1D_OrderDetailId,			String,'													   +'】' +
                    '【商品ID,					PRCD_PD0_ProductId,					String,'													   +'】' + 
                    '【单位,					PRCD_UnitID,						String,'													   +'】' + 
                    '【采购原币价,				PRCD_POriginalPrice,				String,'													   +'】' + 
                    '【采购本币价,				PRCD_PCurrencyPrice,				String,'													   +'】' + 
                    '【吊牌价,					PRCD_SCurrencyPrice,				String,'													   +'】' +                    
                    '【退货仓ID,				PRCD_RetDeptID,						String,'													   +'】' + 
					'【POS_退货单号,			PRCD_POSRetCode,					String,'													   +'】' + 
                    '【退货数量,				PRCD_Total,							String,'													   +'】' + 
                    '【退货金额,				PRCD_Amount,						String,'													   +'】' + 
                    '【退货原因,				PRCD_Reson,							String,'													   +'】' + 
                    '【状态,					PRCD_Status,						String,'													   +'】' + 
                    '【创建人,					PRCD_RgUser,						String,'													   +'】' + 
                    '【创建时间,		        PRCD_RgDt,							String,'													   +'】' + 
                    '【最后修改人,		        PRCD_LmUser,						String,'													   +'】' + 
                    '【最后修改时间,		    PRCD_LmDt,							String,'													   +'】' + 
					'【供应商款号,		        A.PD0_ProductCodeSU~PD0_ProductCodeSU ,						String,'													   +'】' + 
                    '【款号,					A.PD0_Code~PD0_Code,							String,'													   +'】' + 
                   
                    '【单位对照,				D.DC0_DictName1~UnitDictName,		String,'													   +'】' + 
                    '【供应商尺码,		        E.DC0_DictName1~SizeSU_DictName ,	String,'													   +'】' +
                    '【尺码,					G.DC0_DictName1~Size_DictName ,		String,'													   +'】' + 
                	'【供应商颜色,		        H.DC0_DictName1~ColorSU_DictName ,	String,'													   +'】' +   
                    '【颜色,					F.DC0_DictName1~Color_DictName ,	String,'													   +'】' + 

					'【《W》退货单主表ID,			PRCD_PRC_ReturnId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')			+'】'  
  
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
			Set @SqlString='select ' +  @SelectFieldList1 + ' 
			FROM   B02_Bill.PRCD_ReturnDetail WITH ( NOLOCK ) 
			LEFT JOIN   B01_MDM.PD0_Product A			ON A.PD0_ProductId=PRCD_PD0_ProductId
		 
			LEFT JOIN   M01_CONF.DC0_Dictionary D        ON PRCD_UnitID=D.DC0_DictId  
			LEFT JOIN   M01_CONF.DC0_Dictionary E        ON A.PD0_SizeSUId=E.DC0_DictId 
			LEFT JOIN   M01_CONF.DC0_Dictionary F        ON A.PD0_ColorId=F.DC0_DictId        
			LEFT JOIN   M01_CONF.DC0_Dictionary G        ON A.PD0_SizeId=G.DC0_DictId 
			LEFT JOIN   M01_CONF.DC0_Dictionary H        ON A.PD0_ColorSUId=H.DC0_DictId         
			where  PRCD_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1  ORDER BY PRCD_LmDt''   '  
 		end
 		ELSE
 		BEGIN
			Set @SqlString='select ' +  @SelectFieldList1 + ' 
			FROM   B02_Bill.PRCD_ReturnDetail WITH ( NOLOCK ) 
			LEFT JOIN   B01_MDM.PD0_Product A			ON A.PD0_ProductId=PRCD_PD0_ProductId
		 
			LEFT JOIN   M01_CONF.DC0_Dictionary D        ON PRCD_UnitID=D.DC0_DictId  
			LEFT JOIN   M01_CONF.DC0_Dictionary E        ON A.PD0_SizeSUId=E.DC0_DictId 
			LEFT JOIN   M01_CONF.DC0_Dictionary F        ON A.PD0_ColorId=F.DC0_DictId        
			LEFT JOIN   M01_CONF.DC0_Dictionary G        ON A.PD0_SizeId=G.DC0_DictId 
			LEFT JOIN   M01_CONF.DC0_Dictionary H        ON A.PD0_ColorSUId=H.DC0_DictId    
			where  PRCD_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND  ' + @WhereFieldList1
			+' ORDER BY PRCD_LmDt'
 		END
 		
 PRINT @SqlString
 
		END 
		ELSE
		BEGIN
 
		  set @MapString1 = 
					'【集团,					PR1_CONO,												String,'													   +'】' + 
                    '【事业体,					PR1_DIVI,												String,'													   +'】' + 
                    '【退货单明细ID,			''''~PRCD_ReturnDetailId,								String,'													   +'】' + 
                    '【退货单主表ID,			''''~PRCD_PRC_ReturnId,									String,'													   +'】' + 
                    '【退货单编号,				''''~PRCD_PRC_ReturnCode,								String,'													   +'】' + 
                    '【商品ID,					PR1D_PD0_ProductId,										String,'													   +'】' + 
                    '【单位,					PR1D_UnitID,											String,'													   +'】' + 
                    '【采购单主表ID,			PR1_OrderId,											String,'													   +'】' + 
                    '【采购单主表编号,			PR1_OrderCode,											String,'													   +'】' + 
                    '【供应商GUID,			    PR1_SU0_SupplierId,										String,'													   +'】' + 
                    '【采购单明细ID,		    PR1D_OrderDetailId,										String,'													   +'】' +                     
                    '【采购原币价,				PR1D_POriginalPrice,									String,'													   +'】' + 
                    '【采购本币价,				PR1D_PCurrencyPrice,									String,'													   +'】' +                    
                    '【吊牌价,					PR1D_SCurrencyPrice,									String,'													   +'】' +
                    '【退货仓ID,				''''~PRCD_RetDeptID,									String,'													   +'】' + 
					'【POS_退货单号,			''''~PRCD_POSRetCode,									String,'													   +'】' + 
                    '【退货数量,				''0''~PRCD_Total,										String,'													   +'】' + 
                    '【退货金额,				''0''~PRCD_Amount,										String,'													   +'】' + 
                    '【退货原因,				''''~PRCD_Reson,										String,'													   +'】' + 
                    '【状态,					''''~PRBD_Status,										String,'													   +'】' + 
                    '【创建人,					''''~PRBD_RgUser,										String,'													   +'】' + 
                    '【创建时间,		        ''''~PRBD_RgDt,											String,'													   +'】' + 
                    '【最后修改人,		        ''''~PRBD_LmUser,										String,'													   +'】' + 
                    '【最后修改时间,		    ''''~PRBD_LmDt,											String,'													   +'】' + 
                    '【供应商款号,		        A.PD0_ProductCodeSU~PD0_ProductCodeSU ,						String,'													   +'】' + 
                    '【款号,					A.PD0_Code~PD0_Code,							String,'													   +'】' + 
					'【供应商颜色,		        E.DC0_DictName1~ColorSU_DictName ,						String,'													   +'】' + 
                    '【供应商尺码,		        F.DC0_DictName1~SizeSU_DictName ,						String,'													   +'】' + 
                    '【颜色,					G.DC0_DictName1~Color_DictName ,						String,'													   +'】' + 
                    '【尺码,					H.DC0_DictName1~Size_DictName ,							String,'													   +'】' + 
                    
                    '【单位对照,				D.DC0_DictName1~UnitDictName,							String,'													   +'】' + 
                                     
					'【《W》采购单主表ID,		PR1_OrderId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单主表ID'),'')			+'】'  
 
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
			FROM  B02_Bill.PR1_Order WITH ( NOLOCK )    
			LEFT JOIN B02_Bill.PR1D_OrderDetail			 ON PR1_OrderId=PR1D_PR1_OrderId 
            LEFT JOIN   B01_MDM.PD0_Product A			 ON A.PD0_ProductId=PR1D_PD0_ProductId
			LEFT JOIN   M01_CONF.DC0_Dictionary D        ON PR1D_UnitID=D.DC0_DictId    
			LEFT JOIN   M01_CONF.DC0_Dictionary E        ON A.PD0_ColorSUId=E.DC0_DictId  
			LEFT JOIN   M01_CONF.DC0_Dictionary F        ON A.PD0_SizeSUId=F.DC0_DictId 
			LEFT JOIN   M01_CONF.DC0_Dictionary G        ON A.PD0_ColorId=G.DC0_DictId        
			LEFT JOIN   M01_CONF.DC0_Dictionary H        ON A.PD0_SizeId=H.DC0_DictId                             
			where PR1_Status<>''E3CA9B7A-8E17-4E52-B667-39689445D4A1'' AND  ' + @WhereFieldList1
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
 
           '【商品ID,				PRCD_PD0_ProductId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')			+'】'+
           '【单位,					PRCD_UnitID,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单位'),'')			+'】'+
           '【采购单明细ID,			PRCD_PR1D_OrderDetailId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单明细ID'),'')	+'】'+
           '【采购原币价,			PRCD_POriginalPrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'')		+'】'+
           '【采购本币价,			PRCD_PCurrencyPrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购本币价'),'')		+'】'+                
           '【吊牌价,				PRCD_SCurrencyPrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》吊牌价'),'')			+'】'+    
          -- '【入仓ID,				PRBD_DeptID,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》入仓ID'),'')			+'】'+
          -- '【储位,				PRBD_StorageId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》储位'),'')			+'】'+
          
		   '【退货数量,				PRCD_Total,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货数量'),'')			+'】'+    
           '【退货原因,				PRCD_Reson,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货原因'),'')	+'】'+
           '【状态,					PRCD_Status,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			+'】'+
           '【创建人,				PRCD_RgUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')			+'】'+            
           '【最后修改人,		    PRCD_LmUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		+'】'
		   --'【采购单编号,		    PRA_PR1_OrderId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')		+'】'+
            
 
 		set @MapString1 =          
	       '【退货单主表ID,			PRC_ReturnId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单主表ID'),'')			+'】' + 
           '【退货单编号,			PRC_ReturnCode,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单编号'),'')	    +'】'+
           '【供应商ID,			    PRC_SU0_SupplierId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商ID'),'')	    +'】'+
           '【采购单主表ID,			PRC_PR1_OrderId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单主表ID'),'')			+'】'+
		   '【采购单编号,		    PRC_PR1_OrderCode,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'')	+'】'
 
		SET @PRCD_CONO='100'
		 
		SET @PRCD_DIVI='200'
		SET @PRCD_ReturnDetailId=newID() 
	--	SET @PRB_ReceiptId=newID() 
        SET @PRCD_RetDeptID='G0001001'
	    SET @PRCD_UptNo='0'
 	
		SET @PRCD_RgDt=CONVERT(VARCHAR(100),GETDATE(),121)
		SET @PRCD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
		
 
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
       
		set @PRC_ReturnId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单主表ID'),'')	
		set @PRC_ReturnCode=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单编号'),'')	
        set @PRC_PR1_OrderId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单主表ID'),'')
        set @PRC_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
        set @PRC_RgUser=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》创建人'),'')
		set @PRC_SU0_SupplierId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》供应商ID'),'')
		set @PRCD_Total=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货数量'),'0')
        set @PRCD_PR1D_OrderDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单明细ID'),'') 	
        set @PRC_PR1_OrderCode=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单编号'),'') 
        set @PRCD_POriginalPrice=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'') 
        
        
            
 
        SELECT  @PRCD_POSRetCode=ISNULL(MAX(PRCD_POSRetCode),''),
				    @PlanCode='TC1001'+'-'+left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)+'-'
					+LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)+'-'
					+RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),2)+'-'
					FROM B02_Bill.PRCD_ReturnDetail where 
					LEFT(PRCD_POSRetCode,6)='TC1001' 
					AND RIGHT(LEFT(PRCD_POSRetCode,11),4)=left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)  
					AND RIGHT(LEFT(PRCD_POSRetCode,14),2)=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
	                AND RIGHT(LEFT(PRCD_POSRetCode,17),2)=RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),2)
		 
		 			IF @PRCD_POSRetCode='' 
						BEGIN
							set  @PRCD_POSRetCode=@PlanCode+'0001'		
						END 
						ELSE
						BEGIN
							set @PRCD_POSRetCode=@PlanCode+RIGHT('0000'+CAST(CAST(RIGHT(@PRCD_POSRetCode,4) AS INT )+1 AS VARCHAR(20)),4 )   
						END 
        
        
        
        
        
  
        SELECT @PRC_CHECK=ISNULL(max(PRC_ReturnId),'')    
        FROM B02_Bill.PRC_Return
        WHERE PRC_ReturnId=@PRC_ReturnId
       
        if @PRC_CHECK=''
        begin
			IF @PRC_ReturnCode=''
         
				BEGIN
 
					
					SELECT  @PRC_ReturnCode=ISNULL(MAX(PRC_ReturnCode),''),
					@PlanCode= 'TH'+left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)  
					+LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
					FROM B02_Bill.PRC_Return where 
					LEFT(PRC_ReturnCode,2)='TH' 
					AND RIGHT(LEFT(PRC_ReturnCode,6),4)=left( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4)   
					AND left(right(PRC_ReturnCode,7),2)=LEFT(RIGHT( CONVERT(VARCHAR(100),DateAdd(m,+0,GETDATE()),112),4),2)
  
        				IF @PRC_ReturnCode='' 
						BEGIN
							set  @PRC_ReturnCode=@PlanCode+'00001'		
						END 
						ELSE
						BEGIN
				 		    
					 	
							set @PRC_ReturnCode=@PlanCode+RIGHT('00000'+CAST(CAST(RIGHT(@PRC_ReturnCode,5) AS INT )+1 AS VARCHAR(20)),5 )   
						END 			
			END	
		 
	 
		--set @PRA_PerchaseTotal=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购总数'),'')
 		     
 
	  	 		set @SqlString1 ='【操作类型,NEW】【实体,B02_Bill.PRC_Return】
						      【新增内容,退货单主表ID,退货单编号,采购单ID,采购单编号,供应商ID,退货总数,退货总金额,状态,创建人,最后修改人】       
						     
						     【条件内容,《N》退货单主表ID《N》退货单编号,《N》采购单ID,《N》采购单编号,《N》供应商ID,
							  《N》退货总数,《N》退货总金额,《N》状态,《N》创建人,《N》最后修改人】 								        
							 【《N》退货单主表ID,'+@PRC_ReturnId+'】【《N》退货单编号,'+@PRC_ReturnCode+'】【《N》采购单ID,'+@PRC_PR1_OrderId+'】【《N》采购单编号,'+@PRC_PR1_OrderCode+'】
							 【《N》供应商ID,'+@PRC_SU0_SupplierId+'】【《N》退货总数,0】【《N》退货总金额,0】
							 【《N》状态,'+@PRC_Status+'】【《N》创建人,'+@PRC_RgUser+'】【《N》最后修改人,'+@PRC_RgUser+'】'	
	      print @SqlString1
 
				EXEC API_GLERP.Sp_PRC_Return 'AML','DB','RS',@SqlString1	       
        end 
 
        SELECT @PRCD_Amount=ISNULL(ISNULL(@PRCD_POriginalPrice,'0') *cast(@PRCD_Total as DECIMAL(20,0)),'0')
      
 
 
 
       
 
 
 
 		Set @SqlString='INSERT INTO  B02_Bill.PRCD_ReturnDetail(PRCD_CONO,PRCD_DIVI,PRCD_ReturnDetailId,
 		PRCD_UptNo,PRCD_RgDt,PRCD_LmDt,PRCD_PRC_ReturnId,PRCD_Amount,PRCD_RetDeptID,PRCD_POSRetCode,' 	 
		Set @SqlString=@SqlString+''+@InsertToFieldNameList+') VALUES('''+@PRCD_CONO+''','''+@PRCD_DIVI+''','''+@PRCD_ReturnDetailId+''','			 
		Set @SqlString=@SqlString+' '''+@PRCD_UptNo+''','''+@PRCD_RgDt+''','''+@PRCD_LmDt+''','''+@PRC_ReturnId+''','''+@PRCD_Amount+''','''+@PRCD_RetDeptID+''','''+@PRCD_POSRetCode+''','+@InsertFromValueList+')'				
 
	 print @SqlString
 
	end
 
if @mdl='UPDATE'  
	begin
	 
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
		   '【商品ID,				PRCD_PD0_ProductId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》商品ID'),'')			+'】'+
           '【单位,					PRCD_UnitID,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单位'),'')			+'】'+
           '【采购单明细ID,			PRCD_PR1D_OrderDetailId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单明细ID'),'')	+'】'+
           '【采购原币价,			PRCD_POriginalPrice,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'')		+'】'+
		   '【退货数量,				PRCD_Total,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货数量'),'')			+'】'+    
           '【退货原因,				PRCD_Reson,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货原因'),'')	+'】'+
           '【状态,					PRCD_Status,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			+'】'+
           '【最后修改人,		    PRCD_LmUser,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		+'】'+
 
           '【《W》集团,			PRCD_CONO,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
           '【《W》事业体,			PRCD_DIVI,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
           '【《W》采购单明细ID,	PRCD_PR1D_OrderDetailId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单明细ID') ,'')	+'】' + 
		   '【《W》商品ID,			PRCD_PD0_ProductId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')			+'】' +
	       '【《W》退货单明细ID,	PRCD_ReturnDetailId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单明细ID') ,'')	+'】'  
			set @MapString1 = 
		   '【《W》退货单主表ID,	 PRC_ReturnId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')		+'】' + 
           '【《W》采购单主表ID,	 PRC_PR1_OrderId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单主表ID'),'')	    +'】'
          
 
		SET @PRCD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
 
 
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
		
		set @PRC_ReturnId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')	
        set @PRC_PR1_OrderId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单主表ID'),'')
        set @PRC_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
		set @PRCD_Total=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货数量'),'0')
        set @PRCD_PR1D_OrderDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单明细ID'),'0') 	
        set @PRCD_POriginalPrice=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'') 
       -- PRINT @PRC_ReturnId
		SELECT @PRCD_Amount=ISNULL(ISNULL(@PRCD_POriginalPrice,'0') *cast(@PRCD_Total as DECIMAL(20,0)),'0')
 
  
  
  
		Set @SqlString='UPDATE  B02_Bill.PRCD_ReturnDetail SET PRCD_UptNo=CAST(PRCD_UptNo AS INT)+1,
		PRCD_LmDt='''+@PRCD_LmDt+''',PRCD_Amount='''+@PRCD_Amount+''', 
	   ' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		
 	--	print @SqlString 
				 			
		 
	end
	 
	
  if @mdl='DELETE'  
	begin
		set @UpdateFieldNameList= [~FrameDB].[API_Common].[FormatString](@UpdateFieldNameList, ',')	
		set @WhereFieldNameList= [~FrameDB].[API_Common].[FormatString](@WhereFieldNameList, ',')
	 
		set @MapString = 
           
           '【状态,					PRCD_Status,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')			+'】'+
           '【最后修改人,		    PRCD_LmUser,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》最后修改人'),'')		+'】'+      
           
           '【《W》集团,			PRCD_CONO,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》集团'),'')			+'】' +
           '【《W》事业体,			PRCD_DIVI,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》事业体') ,'')			+'】' +
           '【《W》采购单明细ID,	PRCD_PR1D_OrderDetailId,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单明细ID') ,'')	+'】' + 
		   '【《W》商品ID,			PRCD_PD0_ProductId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》商品ID') ,'')			+'】' +
	       '【《W》退货单明细ID,	PRCD_ReturnDetailId,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单明细ID') ,'')	+'】'  
			set @MapString1 = 
		   '【《W》退货单主表ID,	 PRC_ReturnId,					String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')		+'】' + 
           '【《W》采购单主表ID,	 PRC_PR1_OrderId,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单主表ID'),'')	    +'】'
          
   
           	SET @PRCD_LmDt=CONVERT(VARCHAR(100),GETDATE(),121)
			
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
		
 
 
		set @PRC_ReturnId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》退货单主表ID'),'')	
        set @PRC_PR1_OrderId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》采购单主表ID'),'')
        set @PRC_Status=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》状态'),'')
		set @PRCD_Total='0'
        set @PRCD_PR1D_OrderDetailId=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购单明细ID'),'0') 	
        set @PRCD_POriginalPrice=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》采购原币价'),'') 
       -- PRINT @PRC_ReturnId
		SELECT @PRCD_Amount=ISNULL(ISNULL(@PRCD_POriginalPrice,'0') *cast(@PRCD_Total as DECIMAL(20,0)),'0')
	 
		print @UpdateFieldList
		Set @SqlString='UPDATE B02_Bill.PRCD_ReturnDetail SET PRCD_UptNo=CAST(PRCD_UptNo AS INT)+1,PRCD_LmDt='''+@PRCD_LmDt+''', ' +  @UpdateFieldList + '  where ' + @WhereFieldList   
		 
 		print @SqlString
							
		  
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

       SELECT @PRC_Total=SUM(ISNULL(PRCD_Total,'0')),              
             @PRC_Amount=SUM(ISNULL(PRCD_Amount,'0'))                                            
             FROM   B02_Bill.PRCD_ReturnDetail 
             WHERE  PRCD_PRC_ReturnId=@PRC_ReturnId
             AND PRCD_Status<>'E3CA9B7A-8E17-4E52-B667-39689445D4A1'
             GROUP BY PRCD_PRC_ReturnId
             
 
     set @SqlString2 ='【操作类型,UPDATE】【实体,B02_Bill.PRC_Return】
					  【更新内容,退货总数,退货总金额,状态】
					  【条件内容,《N》退货总数,《N》退货总金额,《N》状态,《W》退货单主表ID】
					  【《N》退货总数,'+@PRC_Total+'】【《N》退货总金额,'+@PRC_Amount+'】【《N》状态,'+@PRC_Status+'】
					  【《W》退货单主表ID,'+@PRC_ReturnId+'】'	
	 EXEC API_GLERP.Sp_PRC_Return 'AML','DB','RS',@SqlString2	 
 
  
  end	  
end   

 

GO

