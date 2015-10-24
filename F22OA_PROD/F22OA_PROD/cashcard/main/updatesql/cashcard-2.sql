use cashcard
go

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[j_card_state]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[j_card_state]
GO

CREATE TABLE [dbo].[j_card_state] (
	[id] [char] (1) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[statename] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '0', '未启用' ) 
go
INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '1', '启用' ) 
go
INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '2', '冻结' ) 
go
INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '3', '挂失' ) 
go
INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '4', '失效' ) 
go


IF EXISTS(SELECT name FROM sysobjects
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


/*创建时间：2007-3-26
  创建人：HKM
 功能：更新指定范围的卡号档案分发给店铺。


*/
update  j_card set depotid=@depotid where dbname=@dbname and isnull(proposerid,0)=0 and (cardid between @cardstr and @cardend)

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposerReg' AND type = 'P')
   DROP PROCEDURE jproposerReg
GO
/*建立申请人档案*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE [dbo].[jproposerReg] 

 @names varchar(50),
 @sex varchar(2),
 @identity varchar(20),
 @tel varchar(20),
 @add varchar(200),
 @mtel varchar(20),
 @pswtel varchar(20),
 @psw varchar(20),
 @comment1 varchar(200),
 @presenter varchar(50),
 @depotid varchar(8),
@cardid varchar(30),
@insums numeric(12,2),--实充值
@rate numeric(12,6),--比例
@crname varchar(20),--操作员
@comment2 varchar(100),--说明
@dbname varchar(20)
AS
declare @proposerid int
begin
exec jproposerInsert @names,@sex,@identity,@tel,@add,@mtel,@pswtel,@psw,@comment1,@presenter,@depotid,@crname,@dbname,@proposerid output

exec jcardUpdataSetUser  @cardid, @psw,@proposerid , @depotid ,@dbname

exec dloggingInsert  @cardid,@insums,@crname,@comment2,@depotid,@dbname

select @proposerid as proposerid
end

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposerInsert' AND type = 'P')
   DROP PROCEDURE jproposerInsert
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE [dbo].[jproposerInsert] 
 @names varchar(50),
 @sex varchar(2),
 @identity varchar(20),
 @tel varchar(20),
 @add varchar(200),
 @mtel varchar(20),
 @pswtel varchar(20),
 @psw varchar(20),
 @comment varchar(200),
 @presenter varchar(50),
 @depotid varchar(8),
@crname varchar(20),
@dbname varchar(20),
@proposerid int output

 AS
/*
时间：2007-3-14
创建人：HKM
功能：用户注册，写入用户信息
*/
insert j_proposer(names,sex,[identity],tel,[add],mtel,passwordtel,password,comment,presenter,depotid,crname,dbname) 
    values( @names , @sex, @identity,@tel, @add , @mtel, @pswtel, @psw , @comment, @presenter, @depotid,@crname,@dbname )

select @proposerid=@@identity


GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jcardUpdataSetUser' AND type = 'P')
   DROP PROCEDURE jcardUpdataSetUser
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE [dbo].[jcardUpdataSetUser]
@cardid varchar(30),
@psw varchar(50),
@proposerid int,
@depotid varchar(10),
@dbname varchar(20)

 AS

update j_card set proposerid=@proposerid,password=@psw,start=1,depotid=@depotid where cardid=@cardid and dbname=@dbname

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'dloggingInsert' AND type = 'P')
   DROP PROCEDURE dloggingInsert
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
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
时间：2007-3-14
创建人：HKM
功能：用户充值购物卡，写入充值记录，同时调用刷新卡档案的金额信息的存储过程,传送参数：卡号，实充值+奖励金额
*/
declare @rate numeric(12,6) --比例
declare @bounty numeric(12,2)

--判断正充或反充
if @insums>0 
   set @rate=dbo.getrate(@insums)
else
   set @rate=0


 set @bounty=(@insums*@rate/100)
insert d_logging(cardid,insums,rate,bounty,crname,crdate,sure_date,comment,depotid,dbname)
values (@cardid,@insums,@rate,@bounty,@crname,getdate(),getdate(),@comment,@depotid,@dbname)


--同步更新卡档案
 set @bounty=@insums+@bounty
exec dbo.cashcardup @cardid,@bounty
--返回充值流水ID作为打印票据依据
select @@identity as loggingid

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposer_hisInsert' AND type = 'P')
   DROP PROCEDURE jproposer_hisInsert
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
CREATE PROCEDURE jproposer_hisInsert
 @names varchar(50),
 @sex varchar(2),
 @identity varchar(20),
 @tel varchar(20),
 @add varchar(200),
 @mtel varchar(20),
 @pswtel varchar(20),
 @psw varchar(20),
 @comment varchar(200),
 @presenter varchar(50),
 @depotid varchar(8),
 @crname varchar(20),--操作员
 @dbname varchar(20)


 AS
insert j_proposer_history(names,sex,[identity],tel,[add],mtel,passwordtel,password,comment,presenter,depotid,crname,dbname) 
    values( @names , @sex, @identity,@tel, @add , @mtel, @pswtel, @psw , @comment, @presenter, @depotid,@crname,@dbname )





GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposerDelete' AND type = 'P')
   DROP PROCEDURE jproposerDelete
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE [dbo].[jproposerDelete]
@proposerid int,
@dbname varchar(20)

 AS
/*
时间：2007-3-14
创建人：HKM
功能：删除客户信息
*/

delete j_proposer  where proposerid=@proposerid and dbname=@dbname

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jcardDelete' AND type = 'P')
   DROP PROCEDURE jcardDelete
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE [dbo].[jcardDelete] 

@cardid varchar(30),
@dbname varchar(20)
AS


/*创建时间：2007-3-26
  创建人：HKM
 功能：删除指定的卡号档案,只能删除未使用的卡号


*/

delete j_card where cardid=@cardid and isnull(start,0)=0 and dbname=@dbname

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposerSelect' AND type = 'P')
   DROP PROCEDURE jproposerSelect
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */



CREATE PROCEDURE [dbo].[jproposerSelect]
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
时间：2007-3-14
创建人：HKM
功能：查询客户信息,
修改2007.4.1
原因：只可限本店铺人查询
*/
if (@username ='')
begin
	select a.* from  j_proposer a, view_sys_depotpower18ql b where  b.userid=@userid and a.depotid=b.depotid
	 	and b.access=1 and a.dbname=@dbname
end
else
begin
	select a.* from  j_proposer a, view_sys_depotpower18ql b where a.names=@username  and b.userid=@userid and a.depotid=b.depotid
 	and b.access=1 and a.dbname=@dbname
end

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposerDeletehis' AND type = 'P')
   DROP PROCEDURE jproposerDeletehis
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE jproposerDeletehis
@proposerid int,
@dbname varchar(20)

 AS
/*
时间：2007-7-7
功能：删除客户历史信息
*/
delete j_proposer_history  where proposerid=@proposerid and dbname=@dbname


GO



IF EXISTS(SELECT name FROM sysobjects
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
update j_card set start=3 where cardid=@cardid and depotid=@depotid and dbname=@dbname 
else 
update j_card set start=1 where cardid=@cardid and depotid=@depotid and dbname=@dbname 

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jcardlostupdate' AND type = 'P')
   DROP PROCEDURE jcardlostupdate
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */


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

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_batdelallusertable' AND type = 'P')
   DROP PROCEDURE Card_batdelallusertable
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
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


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'rateInsert' AND type = 'P')
   DROP PROCEDURE rateInsert
GO

/*功能：为增加区别数据库字段,增加创建人*/
/*date:2007-07-19*/
/*write by zcy */
CREATE PROCEDURE [dbo].[rateInsert] 
@ratemin numeric(12,2),
@ratemax numeric(12,2),
@rate numeric(12,2),
@comment varchar(100),
@crname varchar(20),
@dbname varchar(20)
AS
insert j_rate (ratemin,ratemax,rate,comment,crname,dbname)values(@ratemin,@ratemax,@rate,@comment,@crname,@dbname)

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'rateSelect' AND type = 'P')
   DROP PROCEDURE rateSelect
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
CREATE PROCEDURE [dbo].[rateSelect]
@dbname varchar(20)
AS
select * from j_rate where dbname=@dbname order by ratemin,ratemax

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'rateDelete' AND type = 'P')
   DROP PROCEDURE rateDelete
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
CREATE PROCEDURE [dbo].[rateDelete]
@rateid int,
@dbname varchar(20)
AS
delete from j_rate where rateid=@rateid and dbname=@dbname 

GO


IF EXISTS(SELECT name FROM sysobjects
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

select A.consumseid,a.cardid,a.sure_date,a.depotid,c.sums,d.proposerid,d.names,d.passwordtel
into #tmptab
from d_consume A,( select distinct cardid,max(sure_date) as sure_date from d_consume where dbname=@dbname group by cardid) B,j_card c,j_proposer d
where A.cardid=B.cardid and A.sure_date = B.sure_date and datediff(year, B.sure_date,@enddate)>=1
	and a.cardid=c.cardid and c.proposerid=d.proposerid
	and a.dbname=@dbname and c.dbname=@dbname and d.dbname=@dbname

insert #tmptab(consumseid,cardid,sure_date,depotid,sums,proposerid,names,passwordtel)
select 0, b.cardid,b.crdate,b.depotid,b.sums, a.proposerid,a.names,a.passwordtel 
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

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'dconsumeNotLogin' AND type = 'P')
   DROP PROCEDURE dconsumeNotLogin
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */

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



insert d_consume(cardid,cardsums,sums,sure_date,comment,depotid,crname,dbname)
select cardid,@sums,@sums,@enddate,'扣取年费',@depotid,@crname,@dbname from #tmptab

update a set a.sums=a.sums-@sums from j_card a ,#tmptab b 
where a.cardid=b.cardid and a.dbname=@dbname

GO
















