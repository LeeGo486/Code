USE [StroeBusinissSystem]
GO

/****** Object:  StoredProcedure [API_Tag].[TagInfo]    Script Date: 05/08/2014 14:58:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 
 
/*

EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,NEW】【实体,数据新增】【CONO,EP】【DIVI,D01】【公司,雅莹】【店铺ID,E0009369】【店铺名称,郭琦琦】【店铺电话,0573-82221053】【客户经理ID,E00001804】【客户经理名字,特卖收银2】【申请总数,1】【备注,aaa】【图片,】【申请人,特卖收银2】【申请明细,<ROOT><LIST><Rows><prad_styleid>E14EW1059ag5</prad_styleid><prad_total>1</prad_total></Rows></LIST></ROOT>】'
EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,NEW】【实体,数据新增】【CONO,EP】【DIVI,D01】【公司,雅莹】【店铺ID,E0009369】【店铺名称,郭琦琦】【店铺电话,0573-82221053】【客户经理ID,E00001807】【客户经理名字,特卖收银5】【申请总数,5】【备注,cececececececece】【图片,/upload/HZY_Tag/20140505143903151Desert.jpg】【申请人,特卖收银5】【申请明细,<ROOT><LIST><Rows><prad_styleid>E14PY6005aA4</prad_styleid><prad_total>2</prad_total></Rows><Rows><prad_styleid>E14PC2031aP3</prad_styleid><prad_total>3</prad_total></Rows></LIST></ROOT>】'
EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,NEW】【实体,数据新增】【CONO,EP】【DIVI,D01】【公司,雅莹】【店铺ID,E0009369】【店铺名称,郭琦琦】【店铺电话,0573-82221053】【客户经理ID,E00001811】【客户经理名字,特卖收银9】【申请总数,2】【备注,】【图片,】【申请人,特卖收银9】【申请明细,<Root><List><Rows><prad_styleid>E14PC2031aP3</prad_styleid><prad_total>2</prad_total></Rows></List></Root>】'

*/
 
--EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,GET】【实体,取明细表信息】【CONO, EP】【DIVI, D01】【单据ID,1ED7BC3C-0A75-428A-971C-3D8FBD1ABC22】'

--EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,GET】【实体,取主表信息CS】【CONO,EP】【DIVI,D01】【每页行数,20】【页数,1】 【公司,】【店铺ID,】【状态,】【款号,】'

--EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,GET】【实体,取主表信息】【CONO,EP】【DIVI,D01】【每页行数,20】【页数,1】【公司,】【店铺ID,】【状态,】【款号,】'

--EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,UPDATE】【实体,更新主表状态】【CONO, EP】【DIVI, D01】【单据ID,2D9C445F-1A7C-4F10-9534-72D4DEBFED4C】'

--EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,GET】【实体,取公司】【CONO,EP】【DIVI,D01】【公司,测试】 '

--EXEC API_Tag.TagInfo 'AML','DB','RS','【操作类型,GET】【实体,取店铺】【CONO,EP】【DIVI,D01】【店铺名称,测试】 '


CREATE PROCEDURE [API_Tag].[TagInfo]
@InputFormat varchar(30),
@OutputFormat varchar(30),
@OutputContentType varchar(30),
@ConditionStr varchar(Max)

AS
 
BEGIN

/*****************************************
 
 Author : 沈洪彬
 Date:    2014-04-14
 Description: 用于赵振吊牌申请的需求

******************************************/
--SET NOCOUNT ON;
--设置特定变量
declare @MapString varchar(Max)
declare @SqlString varchar(Max)
declare @HelpString nvarchar(max)

declare @ETY varchar(50)
declare @Mdl varchar(100)
DECLARE @cono VARCHAR(128)
DECLARE @DIVI VARCHAR(128)
DECLARE @PR1D_OrderDetailId	    VARCHAR(60) --GUID
Declare @SelectFieldNameList varchar(max)	
Declare @WhereFieldNameList varchar(max)	
Declare @SelectFieldList varchar(max)	
Declare @WhereFieldList varchar(max)
DECLARE @posdbname varchar(128),@SCHEMA varchar(128) 
DECLARE @SRCAPP VARCHAR(128),@Result VARCHAR(2048),@STOP_SIGN INT
DECLARE @SQLSTR VARCHAR(MAX),   --用于放款式和数量
        @COLSTR VARCHAR(MAX),
        @COUNTS  INT             --用于判断更新是否成功
--业务参数，按需增减
DECLARE @PRA_Company  VARCHAR(32),   @PRA_Depotid      VARCHAR(32),   @PRA_DepotName VARCHAR(100),
        @PRA_Phone    VARCHAR(50),   @PRA_EmployeeID   VARCHAR(32),   @PRA_EmployeeName VARCHAR(32),
        @PRA_Total    VARCHAR(32),   @PRA_Remark       VARCHAR(1000),   @PRA_PicPath VARCHAR(500),
        @PRAD_StyleID VARCHAR(32),   @PRAD_Total       int        ,   @PRA_RgUser  varchar(32),
        @PRA_Status   VARCHAR(32),   @skcsl            VARCHAR(100),  
        @XmlTempTableName varchar(max),@List varchar(max) ,
        @BS VARCHAR(1), --用与判断返回成功还是失败
        @nPageRowCount    VARCHAR(32),   --每页行数
        @nPage            VARCHAR(32),     --页数
        @COUNT_NUM        VARCHAR(32)     --总数量
--检查传入变量，参数格式、返回格式、返回内容
exec [~FrameDB].API_Common.CheckFormat @InputFormat ,@OutputFormat ,@OutputContentType
select @InputFormat=[~FrameDb].[API_Common].[GetInputFormat](@InputFormat)
SET @OutputFormat=[~FrameDB].API_Common.GetOutputFormat(@OutputFormat)
SET @OutputContentType=[~FrameDb].[API_Common].[GetOutputContentType](@OutputContentType)
 
    SET @STOP_SIGN=0
    --设置帮助
    if @InputFormat in ('AML','【,】') 
    begin
      set @HelpString=
	  '【操作类型,GET】【实体,取主表信息】【CONO,EP】【DIVI,D01】【每页行数,】【页数,】【公司,】【店铺名称,】【状态,】【款号,】'
     
      set @HelpString=@HelpString+char(13)+char(10)+
	  '【操作类型,GET】【实体,取主表信息CS】【CONO,EP】【DIVI,D01】【每页行数,】【页数,】【公司,】【店铺名称,】【状态,】【款号,】'
     
      
      set @HelpString=@HelpString+char(13)+char(10)+
      '【操作类型,GET】【实体,取明细表信息】【CONO,EP】【DIVI,D01】【单据ID,】'
    
      
      set @HelpString=@HelpString+char(13)+char(10)+
      '【操作类型,NEW】【实体,数据新增】【CONO,EP】【DIVI,D01】【单据ID,必须】【公司,必须】【店铺ID,必须】【店铺名称,必须】【店铺电话,必须】
       【客户经理ID,必须】【客户经理名字,必须】【申请总数,必须】【备注,必须】【图片,必须】【申请人,必须】【申请明细,必须】' 
    
      
      set @HelpString=@HelpString+char(13)+char(10)+
      '【操作类型,UPDATE】【实体,更新主表状态】【CONO,EP】【DIVI,D01】【单据ID,】'
    
      
     
	  if @OutputContentType in ('HELP','帮助') begin goto n end
						
    end 
    
    --解析传入参数
    if @InputFormat in ('AML','【,】') 
    BEGIN
            --获取参数
			set @Mdl=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'操作类型') 
			set @ETY=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'实体')	
			set @DIVI=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'DIVI')
			set @CONO=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'CONO')
			set @nPageRowCount=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'每页行数')
			set @nPage=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'页数')
		 
			set @PRA_Company=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'公司')
			set @PRA_Depotid=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'店铺ID')
			set @PRA_DepotName=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'店铺名称')
			set @PRA_Phone=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'店铺电话')
			set @PRA_EmployeeID=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'客户经理ID')
			set @PRA_EmployeeName=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'客户经理名字')
			set @PRA_Total=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'申请总数')
			set @PRA_Remark=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'备注')
			set @PRA_PicPath=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'图片')
			set @PRA_RgUser=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'申请人') 
			set @PRA_Status=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'状态')
			set @PRAD_StyleID=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'款号')
			set @List=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'申请明细') 
			set @PR1D_OrderDetailId=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'单据ID') 
	 
			--获取业务数据库指向 
   --         SELECT @POSDBNAME=APP_DBNAME,@SCHEMA=APP_SCHEMA
			--FROM CUSERP.DBO.DBNAME_API_CONFIG WHERE CONO=@CONO AND DIVI=@DIVI
            
            SET @POSDBNAME ='StroeBusinissSystem'  
            SET @SCHEMA='API_Tag'
             
    end
	
    if @mdl='GET'  AND @ETY='取主表信息'
    BEGIN 
          CREATE TABLE #PRA_TagApply_infor( PRA_Guid uniqueidentifier ,PRA_Company nvarchar(32),PRA_Brand nvarchar(32),
          PRA_ChannelType nvarchar(32),PRA_Depotid nvarchar(32) ,PRA_DepotName nvarchar(64) ,PRA_EmployeeID nvarchar(32) ,
	      PRA_EmployeeName nvarchar(32) ,PRA_Phone nvarchar(32) ,PRA_Total int ,PRA_PicPath nvarchar(128),
	      PRA_Remark nvarchar(max),PRA_Status int,PRA_StatusName  nvarchar(32), PRA_RgDt  nvarchar(32),PRA_RgUser nvarchar(32),PRA_Updatetime  nvarchar(32),
	      PRA_CONO VARCHAR(10),PRA_DIVI varchar(10)  )                        
          
		  SET @SqlString='INSERT INTO #PRA_TagApply_infor(PRA_Guid,PRA_Company,PRA_Brand,PRA_ChannelType,PRA_Depotid,
	                      PRA_DepotName,PRA_EmployeeID,PRA_EmployeeName,PRA_Phone,
	                      PRA_Total,PRA_PicPath,PRA_Remark,PRA_Status,PRA_StatusName,
	                      PRA_RgDt,PRA_RgUser,PRA_Updatetime,PRA_CONO,PRA_DIVI) 
		                  select DISTINCT PRA_Guid,PRA_Company,PRA_Brand,PRA_ChannelType,PRA_Depotid,
	                      PRA_DepotName,PRA_EmployeeID,PRA_EmployeeName,PRA_Phone,
	                      PRA_Total,PRA_PicPath,PRA_Remark,PRA_Status,PRA_StatusName,
	                      PRA_RgDt,PRA_RgUser,PRA_Updatetime,PRA_CONO,PRA_DIVI from ( SELECT ROW_NUMBER() OVER(ORDER BY A.PRA_Guid DESC) AS ROWNUM,
		                  A.PRA_Guid,PRA_Company,PRA_Brand,PRA_ChannelType,PRA_Depotid,
	                      PRA_DepotName,PRA_EmployeeID,PRA_EmployeeName,PRA_Phone,
	                      PRA_Total,PRA_PicPath,PRA_Remark,PRA_Status,CASE WHEN ISNULL(PRA_Status,''0'')=''0'' THEN ''未处理'' ELSE ''已处理'' END AS PRA_StatusName,
	                      CONVERT(VARCHAR(30),PRA_RgDt,23) PRA_RgDt,PRA_RgUser,CONVERT(VARCHAR(30),PRA_Updatetime,23) PRA_Updatetime,PRA_CONO,PRA_DIVI
		                  FROM '+@posdbname+'.'+@SCHEMA+'.PRA_TagApply  A
		                  LEFT JOIN '+@posdbname+'.'+@SCHEMA+'.PRAD_TagApplyDetail B ON  A.PRA_Guid=B.PRA_Guid  WHERE 1=1  
		   '
		   
		  IF @PRA_Status<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_Status='''+@PRA_Status+'''  '
		  END
		  IF @PRA_Company<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_Company='''+@PRA_Company+'''  '
		  END
		  IF @PRA_Depotid<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_Depotid='''+@PRA_Depotid+'''  '
		  END
		  IF @PRAD_StyleID<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRAD_StyleID='''+@PRAD_StyleID+'''  '
		  END
		  SET @SqlString=@SqlString+') a    where ROWNUM >= (1+CAST('''+@nPageRowCount+''' AS INT )*(CAST('''+@nPage+''' AS INT )-1)) and ROWNUM <=  (CAST('''+@nPageRowCount+''' AS INT )+CAST('''+@nPageRowCount+''' AS INT )*(CAST('''+@nPage+''' AS INT )-1)) '
		   
		  PRINT @SqlString
		  EXEC(@SqlString)
		  
		  
		  --取总数量
		  CREATE TABLE #PRA_TagApply_COUNT(COUNTS VARCHAR(10))
		  
		  SET @SqlString='INSERT INTO #PRA_TagApply_COUNT(COUNTS) SELECT COUNT(1)
          FROM MARKS_ERP.B02_BILL.PRA_TagApply  A
          LEFT JOIN MARKS_ERP.B02_BILL.PRAD_TagApplyDetail B ON  A.PRA_Guid=B.PRA_Guid  WHERE 1=1'  
		  IF @PRA_Status<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_Status='''+@PRA_Status+'''  '
		  END
		  IF @PRA_Company<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_Company='''+@PRA_Company+'''  '
		  END
		  IF @PRA_Depotid<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_Depotid='''+@PRA_Depotid+'''  '
		  END
		  IF @PRAD_StyleID<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRAD_StyleID='''+@PRAD_StyleID+'''  '
		  END
		   
		  PRINT @SqlString
		  EXEC(@SqlString)
		   
	      SELECT @COUNT_NUM=COUNTS FROM #PRA_TagApply_COUNT
		  
		  PRINT @COUNT_NUM
		  
		  --设置返回值SQL
		  SET @SqlString='select '+@COUNT_NUM+'AS COUNT_NUM,PRA_Guid,PRA_Company,PRA_Brand,PRA_ChannelType,PRA_Depotid,
	                      PRA_DepotName,PRA_EmployeeID,PRA_EmployeeName,PRA_Phone,
	                      PRA_Total,PRA_PicPath,PRA_Remark,PRA_Status,PRA_StatusName,
	                      PRA_RgDt,PRA_RgUser,PRA_Updatetime,PRA_CONO,PRA_DIVI from #PRA_TagApply_infor'
		  
		  
		  
	end	
	 
	if @mdl='GET'  AND @ETY='取主表信息CS'
    BEGIN 
          CREATE TABLE #PRA_TagApply_inforCS( PRA_Guid uniqueidentifier ,PRA_Company nvarchar(32),PRA_Brand nvarchar(32),
          PRA_ChannelType nvarchar(32),PRA_Depotid nvarchar(32) ,PRA_DepotName nvarchar(64) ,PRA_EmployeeID nvarchar(32) ,
	      PRA_EmployeeName nvarchar(32) ,PRA_Phone nvarchar(32) ,PRA_Total int ,PRA_PicPath nvarchar(128),
	      PRA_Remark nvarchar(max),PRA_Status int,PRA_StatusName  nvarchar(32), PRA_RgDt  nvarchar(32),PRA_RgUser nvarchar(32),PRA_Updatetime  nvarchar(32),
	      PRA_CONO VARCHAR(10),PRA_DIVI varchar(10)  )                        
         PRINT 1111 
		  SET @SqlString='INSERT INTO #PRA_TagApply_inforCS(PRA_Guid,PRA_Company,PRA_Brand,PRA_ChannelType,PRA_Depotid,
	                      PRA_DepotName,PRA_EmployeeID,PRA_EmployeeName,PRA_Phone,
	                      PRA_Total,PRA_PicPath,PRA_Remark,PRA_Status,PRA_StatusName,
	                      PRA_RgDt,PRA_RgUser,PRA_Updatetime,PRA_CONO,PRA_DIVI) 
		                  select DISTINCT 
		                  A.PRA_Guid,PRA_Company,PRA_Brand,PRA_ChannelType,PRA_Depotid,
	                      PRA_DepotName,PRA_EmployeeID,PRA_EmployeeName,PRA_Phone,
	                      PRA_Total,PRA_PicPath,PRA_Remark,PRA_Status,CASE WHEN ISNULL(PRA_Status,''0'')=''0'' THEN ''未处理'' ELSE ''已处理'' END AS PRA_StatusName,
	                      CONVERT(VARCHAR(30),PRA_RgDt,23) PRA_RgDt,PRA_RgUser,CONVERT(VARCHAR(30),PRA_Updatetime,23) PRA_Updatetime,PRA_CONO,PRA_DIVI
		                  FROM '+@posdbname+'.'+@SCHEMA+'.PRA_TagApply  A
		                  LEFT JOIN '+@posdbname+'.'+@SCHEMA+'.PRAD_TagApplyDetail B ON  A.PRA_Guid=B.PRA_Guid  WHERE 1=1  
		   '
		     PRINT 2222  
		  IF @PRA_Status<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_Status='''+@PRA_Status+'''  '
		  END
		  IF @PRA_Company<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_Company='''+@PRA_Company+'''  '
		  END
		  IF @PRA_DepotName<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRA_DepotName='''+@PRA_DepotName+'''  '
		  END
		  IF @PRAD_StyleID<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND PRAD_StyleID='''+@PRAD_StyleID+'''  '
		  END
		  --SET @SqlString=@SqlString+') a    where ROWNUM >= (1+CAST('''+@nPageRowCount+''' AS INT )*(CAST('''+@nPage+''' AS INT )-1)) and ROWNUM <=  (CAST('''+@nPageRowCount+''' AS INT )+CAST('''+@nPageRowCount+''' AS INT )*(CAST('''+@nPage+''' AS INT )-1)) '
		   PRINT 3333  
		  
		   
		  PRINT @SqlString
		  EXEC(@SqlString)
		  --设置返回值SQL
		  SET @SqlString=' select PRA_Guid,PRA_Company,PRA_Brand,PRA_ChannelType,PRA_Depotid,
	                      PRA_DepotName,PRA_EmployeeID,PRA_EmployeeName,PRA_Phone,
	                      PRA_Total,PRA_PicPath,PRA_Remark,PRA_Status,PRA_StatusName,
	                      PRA_RgDt,PRA_RgUser,PRA_Updatetime,PRA_CONO,PRA_DIVI from #PRA_TagApply_inforCS 
	                      order by PRA_Status,PRA_RgDt'
		  
	end	
	
	
	if @mdl='GET'  AND @ETY='取公司'
    BEGIN 
          
		  SET @SqlString='select distinct 
		                  PRA_Company 
		                  FROM '+@posdbname+'.'+@SCHEMA+'.PRA_TagApply  A where PRA_Company   like ''%'+@PRA_Company+'%''   order by PRA_Company
		   ' 
	end	
	
	if @mdl='GET'  AND @ETY='取店铺'
    BEGIN 
          
		  SET @SqlString='select distinct 
		                  PRA_DepotName 
		                  FROM '+@posdbname+'.'+@SCHEMA+'.PRA_TagApply  A where PRA_DepotName like ''%'+@PRA_DepotName+'%'' order by PRA_DepotName
		   ' 
		   PRINT  @SqlString 
	end	
	 
	
	if @mdl='GET'  AND @ETY='取明细表信息'
	begin
	      
	  
	      
          CREATE TABLE #PRAD_TagApplyDetail(PRA_Guid uniqueidentifier,
	      PRA_Remark nvarchar(max),PRA_PicPath nvarchar(128),PRAD_StyleID  nvarchar(32), PRAD_Total nvarchar(32)  )     
	        
		  SET @SqlString='INSERT INTO #PRAD_TagApplyDetail(PRA_Guid,PRA_Remark,PRA_PicPath,PRAD_StyleID,PRAD_Total )  
		                  select pt.PRA_Guid,pt.PRA_Remark, pt.PRA_PicPath, PRAD_StyleID , cast(PRAD_Total as varchar(10)) 
                          from '+@posdbname+'.'+@SCHEMA+'.PRA_TagApply as pt
                          left join '+@posdbname+'.'+@SCHEMA+'.PRAD_TagApplyDetail as ptd on pt.PRA_Guid = ptd.PRA_Guid 
		                  WHERE 1=1
		   '
		 
		  IF @PR1D_OrderDetailId<>''
		  BEGIN
		    SET  @SqlString=@SqlString+' AND pt.PRA_Guid='''+@PR1D_OrderDetailId+'''  '
		   
		    PRINT @SqlString
			EXEC(@SqlString)
		    SET @SQLSTR=''
			--select * from #PRAD_TagApplyDetail
		  
			--DECLARE PRA_Guid CURSOR
			--FOR 
			--  SELECT distinct skcsl FROM #PRAD_TagApplyDetail    
			--OPEN PRA_Guid
			--FETCH NEXT FROM PRA_Guid INTO @skcsl
			--WHILE(@@FETCH_STATUS = 0)
			--begin 
			--    PRINT @skcsl
			--	SET  @SQLSTR=@SQLSTR+@skcsl 
			--	PRINT @SQLSTR             
			--	FETCH NEXT FROM PRA_Guid INTO @skcsl
			--end
			--CLOSE PRA_Guid
			--DEALLOCATE PRA_Guid
			
			
			--设置返回值SQL
			SET @SqlString=' select DISTINCT PRAD_StyleID,PRAD_Total  ,PRA_Remark,PRA_PicPath from #PRAD_TagApplyDetail'
		  
		    
		  END
		  ELSE
		  BEGIN
		    SET @SqlString=' select ''3'' AS Result, ''请传入单据号''  AS MSG '
		  
		  END 
		  
		   
		  
	end
	 
	if @mdl='NEW'  
	BEGIN
	  --判断是否有上传图片，有返回标识1;无判断数量是否大于10，大于则返回标识0，小于返回标识1 
	  IF  @PRA_PicPath<>''
	  BEGIN
	    SET @BS='1' 
	  END
	  ELSE
	  BEGIN
	    if @PRA_Total>10 
	    begin
	      SET @BS='0' 
	    end
	    else
	    begin
	      SET @BS='1' 
	    end 
	  END 
	  --标识1表示能进行新增操作，0则返回报错
	  IF @BS='1'
	  BEGIN
	    set @List=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'申请明细')
	    --开启出错回滚
		--SET XACT_ABORT ON
		--BEGIN TRAN
		     
			SET @PR1D_OrderDetailId=newID()
			
			--将数据插入主表
			PRINT '111'
			PRINT @PR1D_OrderDetailId
			PRINT @PRA_Company
			PRINT @PRA_Depotid
			PRINT @PRA_DepotName
			PRINT @PRA_EmployeeID
			PRINT @PRA_EmployeeName
			PRINT @PRA_Phone
			PRINT @PRA_Total
			PRINT @PRA_PicPath
			PRINT @PRA_Remark
			PRINT @CONO
			PRINT @DIVI
			PRINT @PRA_RgUser
			
			IF @PRA_PicPath=''
			BEGIN
			  SET @PRA_PicPath=' '
			END
			SET @SqlString='INSERT INTO '+@posdbname+'.'+@SCHEMA+'.PRA_TagApply( '
			+'PRA_Guid,PRA_Company,PRA_ChannelType,PRA_Depotid,PRA_DepotName,PRA_EmployeeID'
			+',PRA_EmployeeName,PRA_Phone,PRA_Total,PRA_PicPath,PRA_Remark,PRA_Status,PRA_RgDt'
			+',PRA_CONO,PRA_DIVI, PRA_RgUser)  '
			+'SELECT '''+@PR1D_OrderDetailId+''','''+@PRA_Company+''',''自营'','''+@PRA_Depotid+''','''+@PRA_DepotName+''','''+@PRA_EmployeeID+''','
			+''''+@PRA_EmployeeName+''','''+@PRA_Phone+''','+@PRA_Total+','''+@PRA_PicPath+''','''+@PRA_Remark+''',''0'',GETDATE(),'     
			+''''+@CONO+''','''+@DIVI+''','''+@PRA_RgUser+''' '
			  
			PRINT @SqlString
			 
			EXEC(@SqlString)
			
			PRINT '2222'
			PRINT @List
			exec [~FrameDB].API_COMMON.SelectXMLAsTable 
			@List
			 
			,'/Root/List/Rows'
			,2
			,'( prad_styleid   varchar(32), 
				prad_total     varchar(20)
			)'
			,@XmlTempTableName output
			 
			
			--将数据插入子表  
			SET @SqlString='INSERT INTO '+@posdbname+'.'+@SCHEMA+'.PRAD_TagApplyDetail('
			+'PRAD_Guid,PRA_Guid,PRAD_StyleID,PRAD_Total,PRAD_DIVI'
			+',PRAD_CONO) '
			+'SELECT newID(),'''+@PR1D_OrderDetailId+''',PRAD_StyleID,CAST(PRAD_Total AS INT),'''+@DIVI+''',   '
			+' '''+@CONO+''' '
			+'FROM '+ @XmlTempTableName+ ' AS A  '  
			PRINT @SqlString 
			EXEC(@SqlString)
			--判断插入成功还是失败
			create table #PRAD_TagApplyDetail1(COUNTS VARCHAR(1))
			
			SET @SqlString='INSERT INTO #PRAD_TagApplyDetail1(COUNTS)   '
			+'SELECT COUNT(PRA_Guid) FROM '+@posdbname+'.'+@SCHEMA+'.PRAD_TagApplyDetail WHERE  PRA_Guid='''+@PR1D_OrderDetailId+''' '
			
			PRINT @SqlString 
			EXEC(@SqlString)
			if exists(select COUNTS from  #PRAD_TagApplyDetail1 )
			BEGIN
			  SET @SqlString=' select ''1'' AS Result, ''申请完成！''  AS MSG '
			END
			ELSE
			BEGIN
			  SET @SqlString=' select ''3'' AS Result, ''申请失败！''  AS MSG '
			END
			
			
			
	    --提交事务
		--COMMIT TRAN
	  END
	  ELSE
	  BEGIN
	    SET @SqlString=' select ''3'' AS Result, ''当月申请总数已超过10个，请上传审批单''  AS MSG '
	     
	  END 
	    
	    
	END
	    
	if  @mdl='UPDATE'
	BEGIN
	  set @PR1D_OrderDetailId=[~FrameDB].API_COMMON.[GetValueFromList](@ConditionStr,'单据ID') 
	  --通过申请单变更状态
	  SET @SqlString=' UPDATE  '+@posdbname+'.'+@SCHEMA+'.PRA_TagApply  SET PRA_Status=''1'' ,PRA_Updatetime =GETDATE()
	                   WHERE PRA_Guid='''+@PR1D_OrderDetailId+'''
	  '
	  PRINT @SqlString
	  EXEC(@SqlString)
	  
	  --查看申请单变状态是否变更成功
	  CREATE TABLE #TMP_PRA_TagApply(COUNTS INT)
	   
	  SET @SqlString='INSERT INTO #TMP_PRA_TagApply(COUNTS)  SELECT COUNT(PRA_Guid) FROM '+@posdbname+'.'+@SCHEMA+'.PRA_TagApply  
	                   WHERE PRA_Guid='''+@PR1D_OrderDetailId+''' AND PRA_Status=''1''
	  '
	  PRINT @SqlString
	  EXEC(@SqlString)
	  
	  SELECT @COUNTS=COUNTS FROM #TMP_PRA_TagApply
	  
	  IF  @COUNTS=0 
	  BEGIN
	    SET @SqlString=' select ''3'' AS Result, ''更新失败！''  AS MSG '
	  END
	  ELSE
	  BEGIN
	    SET @SqlString=' select ''1'' AS Result, ''更新成功！''  AS MSG ' 
	  END
	   
	  
	END
	
	
  	--根据格式返回结果
	Declare @DB varchar(250),@N_ID varchar(50),@SP_Name varchar(500),@SchemaName varchar(500)
	set @DB=DB_NAME()
	Set @SP_Name=object_name(@@PROCID)
	 
	N:
	exec [~FrameDb].API_COMMON.GetSchemaName @DB,@@PROCID,@SchemaName output
	exec [~FrameDB].API_COMMON.GetNewId @DB,@SchemaName,@SP_Name,@InputFormat,@OutputFormat ,@OutputContentType,@ConditionStr,@SqlString,@HelpString,@N_ID output 
	--print @N_ID
	exec [~FrameDB].API_Common.ReturnRlt @N_ID,@OutputFormat ,@OutputContentType,@DB,@SqlString,@HelpString
	--删除临时表
	IF OBJECT_ID('tempdb.DBO.#PRA_TagApply_infor') IS NOT NULL
			DROP TABLE #PRA_TagApply_infor
	IF OBJECT_ID('tempdb.DBO.#PRA_TagApply_inforCS') IS NOT NULL
			DROP TABLE #PRA_TagApply_inforCS		
	IF OBJECT_ID('tempdb.DBO.#PRAD_TagApplyDetail') IS NOT NULL
			DROP TABLE #PRAD_TagApplyDetail 
	IF OBJECT_ID('tempdb.DBO.#TMP_PRA_TagApply') IS NOT NULL
			DROP TABLE #TMP_PRA_TagApply		

END






GO

