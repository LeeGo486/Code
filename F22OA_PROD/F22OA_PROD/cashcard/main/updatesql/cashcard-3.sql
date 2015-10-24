use cashcard
go

--����һ��������ſ���ʱ��ʼ��С����ע��Ľ��
--������:2007-07-27
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-07-21���������ֶ� 1�������� 2��ȡ���*/

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
select cardid,@sums,@enddate,'��ȡ���',@depotid,@crname,@dbname,2 from #tmptab

update a set a.sums=a.sums-@sums from j_card a ,#tmptab b 
where a.cardid=b.cardid and a.dbname=@dbname


GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'jcardSelectYearNotLogin' AND type = 'P')
   DROP PROCEDURE jcardSelectYearNotLogin
GO


/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*��ȡ���*/
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE jcardlose
@cardid varchar(30),
@crname varchar(30),
@depotid varchar(8),
@dbname varchar(20)

AS
/*
ʱ�䣺2007-5-17
�����ˣ�HKM
���ܣ������û���ʧ��
*/

--�����¿� a.sums=b.sums,
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


/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */
/*2007-07-23���ӱ����»�����*/

CREATE PROCEDURE [dbo].[jcardlostupdate] 
@oldcardid varchar(30),
@newcardid varchar(30),
@crname varchar(30),
@depotid varchar(8),
@dbname varchar(20)

AS
/*
ʱ�䣺2007-3-14
�����ˣ�HKM
���ܣ������û���ʧ�����¾ɿ��������¿���Ϣ�����Ѿɿ��Ľ���ֵ������ת�Ƶ��¿���
*/


--�����¿� a.sums=b.sums,
update j_card
set addcardid=@newcardid
where cardid=@oldcardid and dbname=@dbname

update a set a.comment='����:'+@oldcardid,a.start=1,a.proposerid=b.proposerid,a.[password]=b.[password],a.depotid=@depotid
from j_card a, j_card b where a.cardid=@newcardid and b.cardid=@oldcardid and a.dbname=@dbname and b.dbname=@dbname



--ȡ���ɿ���Ǯ��ʹ�����Թ�ԭ�ֿ��ˣ��Ա���ԭ��ֵ�����Ѽ�¼
declare @sums numeric(18,2)
--update j_card set sums=0,[password]='' where cardid=@oldcardid
--���÷��䡢��ֵ�����н���ת�����浵��
--ע�䣺����ֱ�ӵ���ֵ���̣���Ϊ�����ڽ�������
select @sums=sums from j_card where cardid=@oldcardid and dbname=@dbname

insert d_logging(cardid,insums,rate,bounty,crname,crdate,sure_date,comment,depotid,dbname)
values (@newcardid,@sums,0,0,@crname,getdate(),getdate(),'��ʧ����',@depotid,@dbname)


--ͬ�����¿�����
exec dbo.cashcardup @newcardid,@sums


--���÷������
set @sums=0-@sums
exec dloggingInsert @oldcardid,@sums,@crname,'��ʧ����',@depotid,@dbname

--����ԭ�г�ֵ��¼�����Ѽ�¼
/*2007.3.31 
�޸��ˣ�HKM
�޸�ԭ����Ϊ�����޸��˾ɿ���ֵ�����Ѽ�¼��֮ǰ��ӡ��СƱ��Ӧ���ϣ��̱���ɿ��ļ�¼�����Ҳ���ɾ����
                   ʹ֮��Ϊ�ͻ����ü�¼��
begin*/
--update d_logging set cardid=@newcardid where cardid=@oldcardid
--update d_consume set cardid=@newcardid where cardid=@oldcardid

/*end*/


GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'rateSelect' AND type = 'P')
   DROP PROCEDURE rateSelect
GO
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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


/*����ʱ�䣺2007-3-31
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-31*/
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
ʱ�䣺2007-7-31
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
/*date:2007-07-31*/
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
ʱ�䣺2007.7.31 
�����ˣ�HKM
���ܣ��޸Ĺ��￨����
*/

update j_card set [password]=@psw where cardid=@cardid and dbname=@dbname

GO


