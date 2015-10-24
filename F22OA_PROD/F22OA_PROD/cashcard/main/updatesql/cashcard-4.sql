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

/*������ȡ��ֵ��(ȷ���쿨)*/
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE [dbo].[jcardUpdataSetDepot] 
@cardstr varchar(30),
@cardend varchar(30),
@depotid varchar(10),
@dbname varchar(20)

AS


/*����ʱ�䣺2007-3-26
  �����ˣ�HKM
 ���ܣ�����ָ����Χ�Ŀ��ŵ����ַ������̡�


*/
update  j_card set depotid=@depotid,comment='' where dbname=@dbname and isnull(proposerid,0)=0 and (cardid between @cardstr and @cardend)


GO

IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardUpdataSetUser' AND type = 'P')
   DROP PROCEDURE jcardUpdataSetUser
GO
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */
CREATE PROCEDURE [dbo].[dloggingInsert]

@cardid varchar(30),--����
@insums numeric(12,2),--ʵ��ֵ
@crname varchar(20),--����Ա
@comment varchar(100),--˵��
@depotid varchar(8), --����
@dbname varchar(20)

 AS
/*
ʱ�䣺2007-3-14
�����ˣ�HKM
���ܣ��û���ֵ���￨��д���ֵ��¼��ͬʱ����ˢ�¿������Ľ����Ϣ�Ĵ洢����,���Ͳ��������ţ�ʵ��ֵ+�������
*/
declare @rate numeric(12,6) --����
declare @bounty numeric(12,2)

--�ж�����򷴳�
if @insums>0 
   set @rate=dbo.getrate(@insums,@dbname)
else
   set @rate=0

 set @bounty=(@insums*@rate/100)

insert d_logging(cardid,insums,rate,bounty,crname,crdate,sure_date,comment,depotid,dbname)
values (@cardid,@insums,@rate,@bounty,@crname,getdate(),getdate(),@comment,@depotid,@dbname)


--ͬ�����¿�����

 set @bounty=@insums+@bounty
exec dbo.cashcardup @cardid,@bounty,@dbname
--���س�ֵ��ˮID��Ϊ��ӡƱ������
select @@identity as loggingid

GO


IF EXISTS (SELECT name FROM sysobjects
      WHERE name = 'cashcardup' AND type = 'P')
   DROP PROCEDURE cashcardup
GO
CREATE PROCEDURE [dbo].[cashcardup]
@cardid varchar(30),--����
@sums numeric(12,2), --�ܳ�ֵ���
@dbname varchar(20)

 AS
/*
ʱ�䣺2007-3-14
�����ˣ�HKM
���ܣ���ֵ��ʵ�ʽ��+��������ۼӵ���ԭ�н��*/

update j_card set sums=sums+@sums where cardid=@cardid and dbname=@dbname

GO


IF EXISTS (SELECT name FROM sysobjects 
      WHERE name = 'Card_batdelallusertable' AND type = 'P')
   DROP PROCEDURE Card_batdelallusertable
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */

/*ɾ�����ݿ�cashcard�����û���*/
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
ʱ�䣺2007.3.15 
�����ˣ�HKM
���ܣ��޸Ĺ��￨����
*/

update j_card set [password]=@psw where cardid=@cardid and dbname=@dbname

GO
