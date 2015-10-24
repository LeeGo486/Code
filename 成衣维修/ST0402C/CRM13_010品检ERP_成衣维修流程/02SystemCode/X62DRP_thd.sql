USE [F22GP]
GO

/****** Object:  StoredProcedure [dbo].[X62DRP_thd]    Script Date: 04/23/2014 14:44:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 

CREATE PROC [dbo].[X62DRP_thd]
  @outindentid VARCHAR(50), --退货单号
  @set_depotid VARCHAR(50),--发货店铺ID
  @get_depotid VARCHAR(50),--收货店铺ID
  @boxid VARCHAR(50),--装箱号
  @Clothingid VARCHAR(50),--款号
  @Styleid VARCHAR(50),--款式编号
  @Colorid VARCHAR(50),--颜色
  @Sizeid VARCHAR(50),--尺码
  @set_Nums INT,--退货数量
  @j_cost FLOAT,--成本
  @j_price FLOAT,--原价
  @x_price FLOAT,--现价
  @s_price FLOAT,--结算价
  @discount NUMERIC(18,6),--折扣
  @djlx  varchar(50),--单据类型 
  @userid_send  VARCHAR(50),--发货操作员USERID
  @userid_receive VARCHAR(50),--收货操作员USERID
  @outindentid_sh VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON 
	DECLARE @merchantid VARCHAR(50),@parentid VARCHAR(8)
	
	SELECT @merchantid = jd.unitid,@parentid=parentid
	  FROM j_depot jd WHERE jd.depotid=@set_depotid


	SELECT @Styleid=Styleid,@Colorid=colorid,@Sizeid=sizeid FROM dbo.j_clothing WHERE clothingid=@Clothingid
	
	SELECT @merchantid = jd.unitid
	  FROM j_depot jd WHERE jd.depotid=@set_depotid
	  
 
	
	IF @djlx='发货' 
	BEGIN

	INSERT INTO d_OutindentSET
	  (
	    outindentid,
	    outindent,
	    merchantid,
	    parentid,
	    set_depotid,
	    depotid,
	    cr_name,
	    selltype,
	    comment,
	    crdate,
	    cr_date,
	    setdate,
	    ov_sure
	  )
	VALUES
	  (
	    @outindentid,
	    @outindentid,
	    @merchantid,
	    @merchantid,
	    @set_depotid,
	    @get_depotid,
	    @userid_send,
	    '退货',
	    'X6系统退货单',
	    GETDATE(),
	    GETDATE(),
	    GETDATE(),
	    0
	  )
	
 
	INSERT INTO d_outindentSETsub
	  (
	    outindentid,
	    boxid,
	    Clothingid,
	    Styleid,
	    Colorid,
	    Sizeid,
	    nums,
	    cost,
	    j_price,
	    x_price,
	    s_price,
	    crdate,
	    discount
	  )
	VALUES
	  (
	    @outindentid,
	    @boxid,
	    @Clothingid,
	    @Styleid,
	    @Colorid,
	    @Sizeid,
	    @set_Nums,
	    @j_cost,
	    @j_price,
	    @x_price,
	    @s_price,
	    GETDATE(),
	    @discount
	  )
 
	  
		declare @SqlString1 Nvarchar(max)
		Set @SqlString1='EXEC LOCAL.F22GP.dbo.F22_REFRESHDJ ''d_OutindentSET'','''+@outindentid+''''
 
	    
	   --exec  LOCAL.F22GP.dbo.F22_REFRESHDJ 'd_OutindentSET',@outindentid
	
	 -- create table #temp1(rownum int)
	 -- insert into #temp1 
	  EXEC sp_executesql @SqlString1

	 --  drop table #temp1
	   
	   
	   
	UPDATE d_OutindentSET
	SET    chk_date = GETDATE(),
	       chk_name = @userid_send,
	       sure_date = GETDATE(),
	       sure_name = @userid_send
	WHERE  outindentid = @outindentid
	
	--UPDATE d_OutindentSET
	--SET    chk_sure = 1
	--WHERE  outindentid = @outindentid
	
	UPDATE d_OutindentSET
	SET    sure         = 1
	WHERE  outindentid  = @outindentid
 
 
  END	
	
	
	IF @djlx='收货' 
	BEGIN
		
	--SELECT @outindentid_sh = SUBSTRING(@outindentid,1,18)
	--+ RIGHT('0000'+CAST(CAST( ISNULL(MAX( RIGHT(outindentid,4) ),0) AS INT)+1 AS VARCHAR(4)),4)
	--FROM d_outindent WHERE SUBSTRING(@outindentid,1,18) = SUBSTRING(outindentid,1,18)
	
	 --插入参照退货发货单的收货单主表
  INSERT INTO d_outindent (
  outindentid,outindent,quotaid,      merchantid,depotid,set_depotid,sure,chk_sure,setdate,cr_name,cr_date,comment,crdate,backrate,parentid,cw_sure,ds_type,cwcheck,dtype,getsure_date,outindentsq )
  SELECT
  @outindentid_sh,@outindentid_sh,outindentid,merchantid,depotid,set_depotid,0,   0,  setdate,cr_name,cr_date,'',crdate,backrate,parentid,0,ds_type,0,0,sure_date,quotaid
  FROM d_outindentset WHERE outindentid =@outindentid

  --插入子表
  INSERT INTO d_outindentsub (
  outindentid,boxid,clothingid,styleid,colorid,sizeid,cost,s_price,nums,discount,j_price,x_price,crdate )
  SELECT @outindentid_sh,boxid,clothingid,styleid,colorid,sizeid,cost,s_price,nums,discount,j_price,x_price,crdate
  FROM d_outindentsetsub WHERE outindentid =@outindentid
  
  
  UPDATE d_outindent
   Set backrate=1,
	 chk_name = @userid_receive,
	 sure_name = @userid_receive,
	 chk_date = GETDATE(),
	 sure_date = GETDATE()
	WHERE  outindentid = @outindentid_sh
	
	
 --UPDATE d_outindent
	--SET chk_sure=1
 --WHERE  outindentid = @outindentid_sh
 
  UPDATE d_outindent
	 SET sure=1
  WHERE  outindentid = @outindentid_sh
  --exec  F22_REFRESHDJ d_outindent,@outindentid_sh
	/*
	SELECT * FROM d_Outindent where outindentid = 'FH1545-2013-01-25-0001'
	SELECT * FROM d_OutindentSET where outindentid = 'FH1545-2013-01-25-0001'
	SELECT * FROM d_outindentSETsub WHERE  outindentid = 'FH1545-2013-01-25-0001'
	*/
  END


END


GO

