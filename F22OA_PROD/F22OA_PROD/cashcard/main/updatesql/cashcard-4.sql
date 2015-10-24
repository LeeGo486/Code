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
update  j_card set depotid=@depotid,comment='' where dbname=@dbname and isnull(proposerid,0)=0 and (cardid between @cardstr and @cardend)


GO

IF EXISTS (SELECT name FROM sysobjects 
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

update j_card set proposerid=@proposerid,password=@psw,start=1,depotid=@depotid,comment=''  where cardid=@cardid and dbname=@dbname


GO


IF EXISTS (SELECT name FROM sysobjects 
      WHERE name = 'dloggingInsert' and type = 'P')
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
时间：2007.3.15 
创建人：HKM
功能：修改购物卡密码
*/

update j_card set [password]=@psw where cardid=@cardid and dbname=@dbname

GO
