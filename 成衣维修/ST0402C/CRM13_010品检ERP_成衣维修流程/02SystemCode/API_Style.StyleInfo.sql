USE [F22GP]
GO

/****** Object:  StoredProcedure [API_Style].[StyleInfo]    Script Date: 04/23/2014 14:44:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 

CREATE proc [API_Style].[StyleInfo]

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
-----自动生成	
 
	exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
	select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
	SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
	SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)

--设置帮助
	if @InputFormat in ('AML','【,】') 
		begin
 
			set @HelpString=
			'【操作类型,GET】【实体,j_clothing】【返回内容,必填】【条件内容,】【《W》款号,】  '			
			 			
			if @OutputContentType in ('HELP','帮助') begin goto n end
		end
	--解析传入参数
	
	if @InputFormat in ('AML','【,】') 
		begin
			set @Mdl=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'操作类型')		
			set @SelectFieldNameList=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'返回内容')
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
			'【款号,				STYLEID~STYLEID,	                        String,'														     +'】' + 
			'【颜色,				COLORID~COLORID,	                        String,'														     +'】' + 
			'【尺码,				SIZEID~SIZEID,	                        String,'														     +'】' + 
            
            '【《W》项目代号,		CLOTHINGID ~=,						String,'+ isnull([~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'《W》项目代号') ,'')		+'】'
 
 
		set @SelectFieldList=[~FrameDb].[API_Common].[ConvertNameListToSql](		
			@MapString
			,'Select'	
			,@SelectFieldNameList
			,0	
		)
		
		set @WhereFieldList=[~FrameDb].[API_Common].[ConvertNameListToSqlNew](
			@MapString
			,'Where'	
			,@WhereFieldNameList
			,0	
		)	
		
 
		if @WhereFieldList='' 
		begin
			Set @SqlString='SELECT  ' +  @SelectFieldList + ' FROM j_clothing 
			WHERE 1=1
 		    ORDER BY STYLEID ' 
		
 		end
 		ELSE
 		BEGIN
 			Set @SqlString='SELECT ' +  @SelectFieldList + ' FROM j_clothing 

			 WHERE ' + @WhereFieldList
			+' ORDER BY STYLEID'
 		END
		
		
		 
		PRINT @SqlString					
		
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
	
end

 

GO

