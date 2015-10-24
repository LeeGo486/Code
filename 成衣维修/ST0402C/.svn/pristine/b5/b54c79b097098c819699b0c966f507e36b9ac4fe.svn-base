USE [F22GP]
GO

/****** Object:  StoredProcedure [API_Bill].[Thd_Info]    Script Date: 04/23/2014 14:41:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
 

CREATE proc [API_Bill].[Thd_Info]

@InputFormat varchar(30),
@OutputFormat varchar(30),
@OutputContentType varchar(30),
@ConditionStr varchar(Max)
as

begin
    SET NOCOUNT ON
    declare @SqlString nvarchar(max)
    declare @SqlString1 nvarchar(max)
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
	Declare @PlanCode  varchar(max)	
	Declare @PowerList varchar(max)	
	declare @Lvl varchar(10)
	declare @List varchar(max)	
	declare @XmlTempTableName varchar(max)
	declare @DJR VARCHAR(50)
	declare @userid_send  VARCHAR(50)
	declare @userid_receive  VARCHAR(50)
  declare @outindentid VARCHAR(50)
 declare @set_depotid VARCHAR(50)
 declare @get_depotid VARCHAR(50)
  
 declare @boxid VARCHAR(50)
 declare @Clothingid VARCHAR(50)
 declare @Styleid VARCHAR(50)
 declare @Colorid VARCHAR(50)
 declare @Sizeid VARCHAR(50)

 declare @set_Nums VARCHAR(50)
 declare @j_cost VARCHAR(50)
 declare @j_price VARCHAR(50)
 declare @x_price VARCHAR(50)
 declare @s_price VARCHAR(50)
 declare @discount VARCHAR(50)
 declare @djlx VARCHAR(50)
 declare @outindentid_sh VARCHAR(50)
	
 
	
	
-----自动生成	
 
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】') 
		begin
 
			set @HelpString=	 
			'【操作类型,NEW】【实体,发货】【新增内容,必填】【条件内容,】'+
			'【《N》退货单号,】【《N》发货店铺ID,】【《N》收货店铺ID,】【《N》装箱号,】'+
			'【《N》款号,】【《N》款式编号,】【《N》颜色,】【《N》尺码,】【《N》退货数量,】'+
			'【《N》成本,】【《N》原价,】【《N》现价,】【《N》结算价,】【《N》折扣,】'  			
			
			set @HelpString=@HelpString+char(13)+char(10)+
			'【操作类型,NEW】【实体,收货】【新增内容,必填】【条件内容,】'+
			'【《N》退货单号,】【《N》发货店铺ID,】【《N》收货店铺ID,】【《N》装箱号,】'+
			'【《N》款号,】【《N》款式编号,】【《N》颜色,】【《N》尺码,】【《N》退货数量,】'+
			'【《N》成本,】【《N》原价,】【《N》现价,】【《N》结算价,】【《N》折扣,】'  
			
			 			
			if @OutputContentType in ('HELP','帮助') begin goto n end
		end
	--解析传入参数
	
	if @InputFormat in ('AML','【,】') 
		begin
			set @Mdl=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'操作类型')	
		    set @ETY=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'实体')	
			set @SelectFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'返回内容')
			set @UpdateFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'更新内容')
			set @InsertToFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'新增内容')
			set @WhereFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'条件内容')	
			 
		end
	
 
--设置默认值
	
	--生成@SqlString
 
	if @mdl='NEW'    AND @ETY='发货'
	begin
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		
		set @MapString =  
			--'【退货单号,		outindentid,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单号'),'')	    +'】' +
			'【发货店铺ID,		set_depotid,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货店铺ID'),'')	    +'】' +
			'【收货店铺ID,		get_depotid,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货店铺ID'),'')	    +'】' +
            '【装箱号,			boxid,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》装箱号'),'')			+'】' +
            '【款号,			Clothingid,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款号'),'')			+'】' + 
            '【款式编号,		Styleid,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式编号'),'')	    +'】' +
            '【颜色,			Colorid,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》颜色'),'')			+'】' +
            '【尺码,			Sizeid,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》尺码'),'')			+'】' +
			'【退货数量,		set_Nums,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货数量'),'')	    +'】' +
            '【成本,			j_cost,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》成本'),'')			+'】' +
            '【原价,			j_price,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》原价'),'')			+'】' +
            '【现价,			x_price,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》现价'),'')			+'】' +
            '【折扣,			s_price,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》折扣'),'')			+'】' +
            '【结算价,			discount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算价'),'')			+'】' + 
            '【登记人,			DJR,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》登记人'),'')			+'】' +
			'【发货操作员,		userid_send,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货操作员'),'')		+'】' + 
			'【收货操作员,		userid_receive,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货操作员'),'')		+'】' + 
			'【发货单号,		outindentid_sh,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货单号'),'')		+'】'
		
		--set @outindentid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单号'),'')	
		set @set_depotid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货店铺ID'),'')	
		set @get_depotid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货店铺ID'),'')	
		set @boxid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》装箱号'),'')	
		set @Clothingid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款号'),'')	
		set @Styleid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式编号'),'')	
		set @Colorid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》颜色'),'')	
		set @Sizeid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》尺码'),'')	
		set @set_Nums=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货数量'),'')	
		set @j_cost=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》成本'),'')	
		set @j_price=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》原价'),'')	
		set @x_price=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》现价'),'')	
		set @s_price=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》折扣'),'')	
		set @discount=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算价'),'')	
		set @DJR=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》登记人'),'')	
 		set @userid_send=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货操作员'),'')	
		set @userid_receive=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货操作员'),'')	
		set @outindentid_sh=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货单号'),'')
		
		SELECT  @outindentid=ISNULL(MAX(outindentid),''),
				@PlanCode= 'FH'+@DJR+'-'+CONVERT(VARCHAR(100),GETDATE(),23)+'-'
				FROM d_OutindentSET where 
				LEFT(outindentid,2)='FH' 
				AND RIGHT(LEFT(outindentid,6),4)=@DJR
				AND right(LEFT(outindentid,17),10)=CONVERT(VARCHAR(100),GETDATE(),23)
  PRINT @outindentid
        			IF @outindentid=''  
					BEGIN
	 
						set  @outindentid=@PlanCode+'0001'	
	 
					END 
					ELSE
					BEGIN         	    
						set @outindentid=@PlanCode+RIGHT('0000'+CAST(CAST(RIGHT(@outindentid,4)  AS INT )+1 AS VARCHAR(20)),4 ) 		    
					END 
 
		Set @SqlString1='EXEC  LOCAL.F22GP.dbo.X62DRP_thd '''+@outindentid+''','''+@set_depotid+''' ,'''+@get_depotid+''' ,'''+@boxid+''' ,'''+@Clothingid+''' ,
		  '''+@Styleid+''' ,'''+@Colorid+''' ,'''+@Sizeid+''' ,'''+@set_Nums+''' ,'''+@j_cost+''','''+@j_price+''' ,'''+@x_price+''' ,'''+@s_price+''' ,'''+@discount+''',''发货'','''+@userid_send+''','''+@userid_receive+''','''+@outindentid_sh+'''    '
	    
	   
	 --  create table #temp1(rownum int)
	 --  insert into #temp1 
	     EXEC sp_executesql @SqlString1
		print @SqlString1
	 --  drop table #temp1
	   
	
		--PRINT 	@SqlString1
	   set @SqlString = ' SELECT ''TRUE'' AS FLAG ,'''+@outindentid+''' as outindentid'	
	 
	 --  PRINT 	@SqlString		
		
	end
	
	if @mdl='NEW'    AND @ETY='收货'
	begin	
	
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		
		set @MapString =  
			'【退货单号,		outindentid,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单号'),'')	    +'】' +
			'【发货店铺ID,		set_depotid,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货店铺ID'),'')	    +'】' +
			'【收货店铺ID,		get_depotid,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货店铺ID'),'')	    +'】' +
            '【装箱号,			boxid,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》装箱号'),'')			+'】' +
            '【款号,			Clothingid,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款号'),'')			+'】' + 
            '【款式编号,		Styleid,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式编号'),'')	    +'】' +
            '【颜色,			Colorid,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》颜色'),'')			+'】' +
            '【尺码,			Sizeid,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》尺码'),'')			+'】' +
			'【退货数量,		set_Nums,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货数量'),'')	    +'】' +
            '【成本,			j_cost,				String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》成本'),'')			+'】' +
            '【原价,			j_price,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》原价'),'')			+'】' +
            '【现价,			x_price,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》现价'),'')			+'】' +
            '【折扣,			s_price,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》折扣'),'')			+'】' +
            '【结算价,			discount,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算价'),'')			+'】' + 
            '【发货操作员,		userid_send,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货操作员'),'')		+'】' + 
			'【收货操作员,		userid_receive,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货操作员'),'')	
		
 
		set @outindentid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货单号'),'')	
		set @set_depotid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货店铺ID'),'')	
		set @get_depotid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货店铺ID'),'')	
		set @boxid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》装箱号'),'')	
		set @Clothingid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款号'),'')	
		set @Styleid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式编号'),'')	
		set @Colorid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》颜色'),'')	
		set @Sizeid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》尺码'),'')	
		set @set_Nums=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》退货数量'),'')	
		set @j_cost=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》成本'),'')	
		set @j_price=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》原价'),'')	
		set @x_price=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》现价'),'')	
		set @s_price=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》折扣'),'')	
		set @discount=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》结算价'),'')	
	--	set @djlx=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》单据类型'),'')	
		set @userid_send=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货操作员'),'')	
		set @userid_receive=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货操作员'),'')	
		
		SELECT @outindentid_sh = SUBSTRING(@outindentid,1,18)
	+ RIGHT('0000'+CAST(CAST( ISNULL(MAX( RIGHT(outindentid,4) ),0) AS INT)+1 AS VARCHAR(4)),4)
	FROM d_outindent WHERE SUBSTRING(@outindentid,1,18) = SUBSTRING(outindentid,1,18)
	
		
		
		Set @SqlString1='EXEC  X62DRP_thd '''+@outindentid+''','''+@set_depotid+''' ,'''+@get_depotid+''' ,'''+@boxid+''' ,'''+@Clothingid+''' ,
		  '''+@Styleid+''' ,'''+@Colorid+''' ,'''+@Sizeid+''' ,'''+@set_Nums+''' ,'''+@j_cost+''','''+@j_price+''' ,'''+@x_price+''' ,'''+@s_price+''' ,'''+@discount+''',''收货'','''+@userid_send+''','''+@userid_receive+''','''+@outindentid_sh+'''    '
	    print @SqlString1
	   
	 --  create table #temp1(rownum int)
	 --  insert into #temp1 
	     EXEC sp_executesql @SqlString1

	 --  drop table #temp1
	   
	
		--PRINT 	@SqlString1
	   set @SqlString = ' SELECT ''TRUE'' AS FLAG ,'''+@outindentid+''' as outindentid'	

							
		
	end
 

 	--根据格式返回结果
 
	Declare @DB varchar(250),@N_ID varchar(50),@SP_Name varchar(500),@SchemaName varchar(500)
	set @DB=DB_NAME()
	Set @SP_Name=object_name(@@PROCID)
	--print @SqlString
	N: 
--	print  @DB
--	print @@PROCID
--	print @SchemaName 
	exec [~FrameDb].API_COMMON.GetSchemaName @DB,@@PROCID,@SchemaName output
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString,@HelpString,@N_ID output 
	
	exec [~FrameDB].API_Common.ReturnRlt @N_ID,@OutputFormat ,@OutputContentType,@DB,@SqlString,@HelpString

	print @N_ID
	print @OutputFormat
	print @OutputContentType
	print @DB
	print @SqlString
	print @HelpString
	
	if @ETY='发货'
	begin
		  UPDATE d_OutindentSET
		  SET   chk_sure = 1
	     WHERE  outindentid = @outindentid
	end
	
	if @ETY='收货'
	begin
		 UPDATE d_outindent
			SET chk_sure=1
		 WHERE  outindentid = @outindentid_sh
 
	end
end

 




GO

