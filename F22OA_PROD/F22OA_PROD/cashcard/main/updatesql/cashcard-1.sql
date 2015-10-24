use cashcard
go

IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_batdelallusertable' AND type = 'P')
   DROP PROCEDURE Card_batdelallusertable
GO
/*删除数据库cashcard所有用户表*/
CREATE PROCEDURE  Card_batdelallusertable
AS

delete from cashcard.dbo.j_proposer
delete from cashcard.dbo.d_logging
delete from cashcard.dbo.j_rate
delete from cashcard.dbo.d_consume
delete from cashcard.dbo.j_proposer_history
delete from cashcard.dbo.j_setnotconsumetime
delete from cashcard.dbo.j_card

GO
/*功能：为增加建立日期*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('d_consume')
   and   name ='crdate')
ALTER TABLE d_consume add crdate datetime  default getdate()
go

/*功能：为增加建立人*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('d_consume')
   and   name ='crname')
ALTER TABLE d_consume add crname varchar (20) NULL
go

/*功能：为增加建立日期*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_proposer')
   and   name ='crdate')
ALTER TABLE j_proposer add crdate datetime  default getdate()
go

/*功能：为增加建立人*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_proposer')
   and   name ='crname')
ALTER TABLE j_proposer add crname varchar (20) NULL
go

/*功能：为增加建立日期*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_proposer_history')
   and   name ='crdate')
ALTER TABLE j_proposer_history add crdate datetime  default getdate()
go

/*功能：为增加建立人*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_proposer_history')
   and   name ='crname')
ALTER TABLE j_proposer_history add crname varchar (20) NULL
go

/*功能：为增加建立日期*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_rate')
   and   name ='crdate')
ALTER TABLE j_rate add crdate datetime  default getdate()
go

/*功能：为增加建立人*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_rate')
   and   name ='crname')
ALTER TABLE j_rate add crname varchar (20) NULL
go



/*功能：为增加建立日期*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_setnotconsumetime')
   and   name ='crdate')
ALTER TABLE j_setnotconsumetime add crdate datetime  default getdate()
go

/*功能：为增加建立人*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_setnotconsumetime')
   and   name ='crname')
ALTER TABLE j_setnotconsumetime add crname varchar (20) NULL
go


/*功能：为增加区别数据库字段*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.d_consume')
   and   name ='dbname')
ALTER TABLE dbo.d_consume add dbname varchar (20) NULL
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.d_logging')
   and   name ='dbname')
ALTER TABLE dbo.d_logging add dbname varchar (20) NULL
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_card')
   and   name ='dbname')
ALTER TABLE dbo.j_card add dbname varchar (20) NULL
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_proposer')
   and   name ='dbname')
ALTER TABLE dbo.j_proposer add dbname varchar (20) NULL
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_proposer_history')
   and   name ='dbname')
ALTER TABLE dbo.j_proposer_history add dbname varchar (20) NULL
go



/*功能：为增加区别数据库字段*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_rate')
   and   name ='dbname')
ALTER TABLE j_rate add dbname varchar (20) NULL
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_setnotconsumetime')
   and   name ='dbname')
ALTER TABLE dbo.j_setnotconsumetime add dbname varchar (20) NULL
go


/*功能：为增加区别数据库字段*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_setnotconsumetime')
   and   name ='dbname')
ALTER TABLE dbo.j_setnotconsumetime add dbname varchar (20) NULL
go


/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by dpipi */

IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardinsert' AND type = 'P')
   DROP PROCEDURE jcardinsert
GO

create  PROCEDURE [dbo].[jcardinsert] 

@cardid varchar(30),
@cardname varchar(20),
@sums numeric(12,2),
@crname varchar(20),
@comment varchar(200),
@start int,
@proposerid int,
@depotid varchar(8),
@dbname varchar(20)
AS

insert j_card(cardid,cardname,sums,crdate,lastdate,crname,comment,start,proposerid,depotid,dbname) 
          values(@cardid,@cardname,@sums,getdate(),getdate(),@crname,@comment,@start,@proposerid,@depotid,@dbname)

GO

/*功能：增加卡的的状态*/
/*date:2007-07-17*/
/*write by zcy */

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[j_card_state]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[j_card_state]
GO

CREATE TABLE [dbo].[j_card_state] (
	[id] int  NOT NULL ,
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
/*功能：修改卡的状态*/
/*date:2007-07-17*/
/*write by zcy */
if exists (select 1 from  syscolumns where  id = object_id('dbo.j_card')
   and   name ='start')
ALTER TABLE dbo.j_card ALTER COLUMN start int null
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


/*加上补卡的卡号*/
if not exists (select 1
            from  syscolumns
           where  id = object_id('j_card')
           and   name ='addcardid')
	ALTER TABLE j_card add addcardid varchar(30) null
go

/*加上收费类型的卡号*/
/*dtype 1为销售，2为年费*/
/*2007-07-20*/
if not exists (select 1
            from  syscolumns
           where  id = object_id('d_consume')
           and   name ='dtype')
	ALTER TABLE d_consume add dtype int null
go

