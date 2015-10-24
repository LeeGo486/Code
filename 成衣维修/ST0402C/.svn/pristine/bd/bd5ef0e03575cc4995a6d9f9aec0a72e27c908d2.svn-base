USE [F22GP]
GO

/****** Object:  StoredProcedure [API_Product].[ProdInfo]    Script Date: 04/23/2014 14:43:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 

CREATE proc [API_Product].[ProdInfo]

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
	declare @List varchar(max)	
	declare @XmlTempTableName varchar(max)
	


 DECLARE @SETDEPOTID VARCHAR(20)
 DECLARE @styleid VARCHAR(20)
 DECLARE @getsdate VARCHAR(20)
 DECLARE @getdepotid2 VARCHAR(20) 
	
	
	
-----自动生成	
 
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】') 
		begin
 
			set @HelpString=	 
			'【操作类型,new】【实体,X62DRP_thd】【新增内容,必填】【条件内容,】'+
			'【《N》发货店铺ID,】【《N》款式编号,】【《N》收货日期,】【《N》收货店铺ID,】'  			
			 			
			if @OutputContentType in ('HELP','帮助') begin goto n end
		end
	--解析传入参数
	
	if @InputFormat in ('AML','【,】') 
		begin
			set @Mdl=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'操作类型')		
			set @SelectFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'返回内容')
			set @InsertToFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'新增内容')
			set @WhereFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'条件内容')	
			 
		end
	
 
--设置默认值
	
	--生成@SqlString
	if @mdl='new'  
	begin
		set @InsertToFieldNameList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		set @InsertFromValueList= [~FrameDB].[API_Common].[FormatString](@InsertToFieldNameList, ',')
		
		set @MapString =  
			'【发货店铺ID,		set_depotid,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货店铺ID'),'')	    +'】' +
			'【收货店铺ID,		get_depotid,		String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货店铺ID'),'')	    +'】' +
            '【款式编号,		Styleid,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式编号'),'')	    +'】' +
            '【收货日期,		getsdate,			String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货日期'),'')		+'】' 
            
        set @SETDEPOTID=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》发货店铺ID'),'')	
		set @getdepotid2=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货店铺ID'),'')	
		set @styleid=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》款式编号'),'')	
		set @getsdate=isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《N》收货日期'),'')	
 
         

        Set @SqlString='
        
        CREATE TABLE #tmp
            (
              clotingid VARCHAR(20) ,
              styleid VARCHAR(20) ,
              s_name VARCHAR(30) ,
              sizegrpid VARCHAR(6) ,
              j_cost NUMERIC(8, 2) ,
              j_price NUMERIC(8, 2) ,
              x_price NUMERIC(8, 2) ,
              s_price NUMERIC(8, 2) ,
              discount NUMERIC(12, 6) ,
              colorid VARCHAR(3) ,
              sizeid VARCHAR(3) ,
              kc VARCHAR(2)
            )
            
        INSERT  INTO #tmp
                ( styleid ,
                  s_name ,
                  sizegrpid ,
                  j_cost ,
                  j_price ,
                  x_price ,
                  s_price ,
                  discount
                )
        
        EXEC [t18tj_GetStylePrice ] ''2'','''+ @SETDEPOTID+''','''+ @styleid+''','''+@getsdate+''',''3'', '''+@getdepotid2+'''
        SELECT  * FROM    #tmp
         '

         
		
		--Set @SqlString='EXEC  X62DRP_thd '''+@outindentid+''','''+@set_depotid+''' ,'''+@get_depotid+''' ,'''+@boxid+''' ,'''+@Clothingid+''' ,
		--  '''+@Styleid+''' ,'''+@Colorid+''' ,'''+@Sizeid+''' ,'''+@set_Nums+''' ,'''+@j_cost+''','''+@j_price+''' ,'''+@x_price+''' ,'''+@s_price+''' ,'''+@discount+'''   '


		 PRINT @SqlString					
		
	end
 

 	--根据格式返回结果
 
	Declare @DB varchar(250),@N_ID varchar(50),@SP_Name varchar(500),@SchemaName varchar(500)
	set @DB=DB_NAME()
	Set @SP_Name=object_name(@@PROCID)
	--print @SqlString
	N: 
--	print @DB
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
	
end

 

GO

