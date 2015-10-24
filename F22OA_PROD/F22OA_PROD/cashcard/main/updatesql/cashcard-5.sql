use cashcard
go


IF EXISTS (SELECT name FROM sysobjects 
      WHERE name = 'getRate' and type = 'FN')
DROP FUNCTION getRate
GO

CREATE FUNCTION [dbo].[getRate]
(@sums numeric(18,2),
 @dbname varchar(20))
RETURNS   numeric(18,2)
AS  
BEGIN 
declare @rate numeric(18,2)
select @rate=isnull(rate,0) from j_rate where ratemax>=@sums and ratemin<=@sums  and dbname=@dbname
if(@rate is null)
 set @rate=0
RETURN  @rate 


END

GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardlostupdate' AND type = 'P')
   DROP PROCEDURE jcardlostupdate
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*2007-07-23增加保存新换卡号*/

CREATE PROCEDURE [dbo].[jcardlostupdate] 
@oldcardid varchar(30),
@newcardid varchar(30),
@crname varchar(30),
@depotid varchar(8),
@dbname varchar(20)

AS
/*
时间：2007-3-14
创建人：HKM
功能：用于用户挂失，更新旧卡，更新新卡信息。并把旧卡的金额、充值、消费转移到新卡。
*/


--更新新卡 a.sums=b.sums,
update j_card
set addcardid=@newcardid
where cardid=@oldcardid and dbname=@dbname

update a set a.comment='换卡:'+@oldcardid,a.start=1,a.proposerid=b.proposerid,a.[password]=b.[password],a.depotid=@depotid
from j_card a, j_card b where a.cardid=@newcardid and b.cardid=@oldcardid and a.dbname=@dbname and b.dbname=@dbname



--取消旧卡金钱，使用人仍归原持卡人，以保留原充值与消费记录
declare @sums numeric(18,2)
--update j_card set sums=0,[password]='' where cardid=@oldcardid
--采用反充、充值来进行金额的转换，存档。
--注间：不能直接调充值过程，因为不存在奖励比例
select @sums=sums from j_card where cardid=@oldcardid and dbname=@dbname

insert d_logging(cardid,insums,rate,bounty,crname,crdate,sure_date,comment,depotid,dbname)
values (@newcardid,@sums,0,0,@crname,getdate(),getdate(),'挂失补卡',@depotid,@dbname)


--同步更新卡档案
exec dbo.cashcardup @newcardid,@sums,@dbname


--调用反充过程
set @sums=0-@sums
exec dloggingInsert @oldcardid,@sums,@crname,'挂失补卡',@depotid,@dbname

--更新原有充值记录，消费记录
/*2007.3.31 
修改人：HKM
修改原因：因为考虑修改了旧卡充值、消费记录与之前打印的小票对应不上，固保存旧卡的记录。并且不能删除。
                   使之成为客户永久记录。
begin*/
--update d_logging set cardid=@newcardid where cardid=@oldcardid
--update d_consume set cardid=@newcardid where cardid=@oldcardid

/*end*/
GO

