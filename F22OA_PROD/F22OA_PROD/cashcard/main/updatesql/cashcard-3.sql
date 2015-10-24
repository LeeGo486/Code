use cashcard
go

--新增一表用来存放开卡时初始金额不小于所注册的金额
--创建于:2007-07-27
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[j_cardsumsless]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[j_cardsumsless]
GO

CREATE TABLE [dbo].[j_cardsumsless] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[lesssums] [numeric](19, 2) NULL ,
	[dbname] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[crname] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL, 
	constraint PK_j_cardsumsless primary key  (id)
	
) 


GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'dconsumeNotLogin' AND type = 'P')
   DROP PROCEDURE dconsumeNotLogin
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-07-21增加类型字段 1购物消费 2扣取年费*/

CREATE PROCEDURE [dbo].[dconsumeNotLogin] 
@enddate datetime,
@sums numeric(12,2),
@depotid varchar(10),
@crname varchar(20),
@dbname varchar(20)

AS
select A.consumseid,a.cardid,a.sure_date,a.depotid,c.sums,d.proposerid,d.names,d.passwordtel
into #tmptab
from d_consume A,( select distinct cardid,max(sure_date) as sure_date from d_consume where dbname=@dbname group by cardid) B,j_card c,j_proposer d
where A.cardid=B.cardid and A.sure_date = B.sure_date and datediff(year, B.sure_date,@enddate)>=1
    and a.cardid=c.cardid and c.proposerid=d.proposerid and a.dbname=@dbname and c.dbname=@dbname and d.dbname=@dbname

insert #tmptab(consumseid,cardid,sure_date,depotid,sums,proposerid,names,passwordtel)
select 0, b.cardid,b.crdate,b.depotid,b.sums, a.proposerid,a.names,a.passwordtel 
from j_proposer a,j_card b 
where a.proposerid=b.proposerid
	and cardid in(select cardid from j_card 
			where cardid not in(select cardid from d_consume where dbname=@dbname) 
				and isnull(proposerid,0)<>0 and datediff(year, B.crdate,@enddate)>=1  and dbname=@dbname
			)
	and a.dbname=@dbname and b.dbname=@dbname



insert d_consume(cardid,sums,sure_date,comment,depotid,crname,dbname,dtype)
select cardid,@sums,@enddate,'扣取年费',@depotid,@crname,@dbname,2 from #tmptab

update a set a.sums=a.sums-@sums from j_card a ,#tmptab b 
where a.cardid=b.cardid and a.dbname=@dbname


GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardSelectYearNotLogin' AND type = 'P')
   DROP PROCEDURE jcardSelectYearNotLogin
GO


/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*收取年费*/
CREATE PROCEDURE [dbo].[jcardSelectYearNotLogin]
@enddate datetime,
@dbname varchar(20)
 AS

select A.consumseid,a.cardid,a.sure_date,a.depotid,c.sums,d.proposerid,d.names,d.mtel
into #tmptab
from d_consume A,( select distinct cardid,max(sure_date) as sure_date from d_consume where dbname=@dbname group by cardid) B,j_card c,j_proposer d
where A.cardid=B.cardid and A.sure_date = B.sure_date and datediff(year, B.sure_date,@enddate)>=1
	and a.cardid=c.cardid and c.proposerid=d.proposerid
	and a.dbname=@dbname and c.dbname=@dbname and d.dbname=@dbname

insert #tmptab(consumseid,cardid,sure_date,depotid,sums,proposerid,names,mtel)
select 0, b.cardid,b.crdate,b.depotid,b.sums, a.proposerid,a.names,a.mtel 
from j_proposer a,j_card b 
where a.proposerid=b.proposerid
	and cardid in(select cardid from j_card 
			where cardid not in(select cardid from d_consume where dbname=@dbname) 
				and isnull(proposerid,0)<>0 and datediff(year, B.crdate,@enddate)>=1 
				and dbname=@dbname
			)
	and a.dbname=@dbname and b.dbname=@dbname

select * from #tmptab order by cardid


GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardlose' AND type = 'P')
   DROP PROCEDURE jcardlose
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE jcardlose
@cardid varchar(30),
@crname varchar(30),
@depotid varchar(8),
@dbname varchar(20)

AS
/*
时间：2007-5-17
创建人：HKM
功能：用于用户挂失。
*/

--更新新卡 a.sums=b.sums,
--declare @start bit

--select @start=isnull(start,0) from j_card where cardid=@cardid 
--if @start=1 
--update j_card set start=0 where cardid=@cardid and depotid=@depotid
--else 
--update j_card set start=1 where cardid=@cardid and depotid=@depotid
declare @start int

select @start=isnull(start,0) from j_card where cardid=@cardid and dbname=@dbname 
if @start=1 
update j_card set start=3 where cardid=@cardid  and dbname=@dbname
--update j_card set start=3 where cardid=@cardid and depotid=@depotid and dbname=@dbname 
else 
update j_card set start=1 where cardid=@cardid  and dbname=@dbname
--update j_card set start=1 where cardid=@cardid and depotid=@depotid and dbname=@dbname 


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
exec dbo.cashcardup @newcardid,@sums


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


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'rateSelect' AND type = 'P')
   DROP PROCEDURE rateSelect
GO
/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
CREATE PROCEDURE rateSelect
@dbname varchar(20)
AS
select * from j_rate where dbname=@dbname order by ratemin,ratemax


GO
------------------2007-07-31-------------

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
if(@rate = null)
 set @rate=0
RETURN  @rate 


END

GO




IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardUpdataSetDepot' AND type = 'P')
   DROP PROCEDURE jcardUpdataSetDepot
GO

/*店铺领取充值卡(确定领卡)*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE [dbo].[jcardUpdataSetDepot] 
@cardstr varchar(30),
@cardend varchar(30),
@depotid varchar(10),
@dbname varchar(20)

AS


/*创建时间：2007-3-31
  创建人：HKM
 功能：更新指定范围的卡号档案分发给店铺。


*/
update  j_card set depotid=@depotid,comment='' where dbname=@dbname and isnull(proposerid,0)=0 and (cardid between @cardstr and @cardend)


GO

IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardUpdataSetUser' AND type = 'P')
   DROP PROCEDURE jcardUpdataSetUser
GO
/*功能：为增加区别数据库字段*/
/*date:2007-07-31*/
/*write by zcy */

CREATE PROCEDURE [dbo].[jcardUpdataSetUser]
@cardid varchar(30),
@psw varchar(50),
@proposerid int,
@depotid varchar(10),
@dbname varchar(20)

 AS

update j_card set proposerid=@proposerid,password=@psw,start=1,depotid=@depotid,comment=''  where cardid=@cardid and dbname=@dbname


GO


IF EXISTS (SELECT name FROM sysobjects 
      WHERE name = 'dloggingInsert' and type = 'P')
DROP PROCEDURE dloggingInsert
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-31*/
/*write by zcy */
CREATE PROCEDURE [dbo].[dloggingInsert]

@cardid varchar(30),--卡号
@insums numeric(12,2),--实充值
@crname varchar(20),--操作员
@comment varchar(100),--说明
@depotid varchar(8), --店铺
@dbname varchar(20)

 AS
/*
时间：2007-7-31
创建人：HKM
功能：用户充值购物卡，写入充值记录，同时调用刷新卡档案的金额信息的存储过程,传送参数：卡号，实充值+奖励金额
*/
declare @rate numeric(12,6) --比例
declare @bounty numeric(12,2)

--判断正充或反充
if @insums>0 
   set @rate=dbo.getrate(@insums,@dbname)
else
   set @rate=0

 set @bounty=(@insums*@rate/100)

insert d_logging(cardid,insums,rate,bounty,crname,crdate,sure_date,comment,depotid,dbname)
values (@cardid,@insums,@rate,@bounty,@crname,getdate(),getdate(),@comment,@depotid,@dbname)


--同步更新卡档案

 set @bounty=@insums+@bounty
exec dbo.cashcardup @cardid,@bounty,@dbname
--返回充值流水ID作为打印票据依据
select @@identity as loggingid

GO


IF EXISTS (SELECT name FROM sysobjects
      WHERE name = 'cashcardup' AND type = 'P')
   DROP PROCEDURE cashcardup
GO
CREATE PROCEDURE [dbo].[cashcardup]
@cardid varchar(30),--卡号
@sums numeric(12,2), --总充值金额
@dbname varchar(20)

 AS
/*
时间：2007-3-14
创建人：HKM
功能：充值把实际金额+奖励金额累加到卡原有金额*/

update j_card set sums=sums+@sums where cardid=@cardid and dbname=@dbname

GO


IF EXISTS (SELECT name FROM sysobjects 
      WHERE name = 'Card_batdelallusertable' AND type = 'P')
   DROP PROCEDURE Card_batdelallusertable
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-31*/
/*write by zcy */

/*删除数据库cashcard所有用户表*/
CREATE PROCEDURE  Card_batdelallusertable
@dbname varchar(20)
AS

delete from cashcard.dbo.j_proposer where dbname=@dbname
delete from cashcard.dbo.d_logging where dbname=@dbname
delete from cashcard.dbo.j_rate where dbname=@dbname
delete from cashcard.dbo.d_consume where dbname=@dbname
delete from cashcard.dbo.j_proposer_history where dbname=@dbname
delete from cashcard.dbo.j_setnotconsumetime where dbname=@dbname
delete from cashcard.dbo.j_card where dbname=@dbname
delete from cashcard.dbo.j_cardsumsless where dbname=@dbname


GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardPswMd' AND type = 'P')
   DROP PROCEDURE jcardPswMd
GO

CREATE PROCEDURE [dbo].[jcardPswMd]

@cardid varchar(30),
@psw varchar(50),
@dbname varchar(20)

 AS
/*
时间：2007.7.31 
创建人：HKM
功能：修改购物卡密码
*/

update j_card set [password]=@psw where cardid=@cardid and dbname=@dbname

GO


