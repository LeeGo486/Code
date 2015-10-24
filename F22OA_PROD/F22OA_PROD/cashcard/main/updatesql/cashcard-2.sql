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
		 VALUES ( '0', 'δ����' ) 
go
INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '1', '����' ) 
go
INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '2', '����' ) 
go
INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '3', '��ʧ' ) 
go
INSERT INTO dbo.j_card_state ( id, statename ) 
		 VALUES ( '4', 'ʧЧ' ) 
go


IF EXISTS(SELECT name FROM sysobjects
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
update  j_card set depotid=@depotid where dbname=@dbname and isnull(proposerid,0)=0 and (cardid between @cardstr and @cardend)

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposerReg' AND type = 'P')
   DROP PROCEDURE jproposerReg
GO
/*���������˵���*/
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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
@insums numeric(12,2),--ʵ��ֵ
@rate numeric(12,6),--����
@crname varchar(20),--����Ա
@comment2 varchar(100),--˵��
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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
ʱ�䣺2007-3-14
�����ˣ�HKM
���ܣ��û�ע�ᣬд���û���Ϣ
*/
insert j_proposer(names,sex,[identity],tel,[add],mtel,passwordtel,password,comment,presenter,depotid,crname,dbname) 
    values( @names , @sex, @identity,@tel, @add , @mtel, @pswtel, @psw , @comment, @presenter, @depotid,@crname,@dbname )

select @proposerid=@@identity


GO

IF EXISTS(SELECT name FROM sysobjects
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

update j_card set proposerid=@proposerid,password=@psw,start=1,depotid=@depotid where cardid=@cardid and dbname=@dbname

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'dloggingInsert' AND type = 'P')
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
   set @rate=dbo.getrate(@insums)
else
   set @rate=0


 set @bounty=(@insums*@rate/100)
insert d_logging(cardid,insums,rate,bounty,crname,crdate,sure_date,comment,depotid,dbname)
values (@cardid,@insums,@rate,@bounty,@crname,getdate(),getdate(),@comment,@depotid,@dbname)


--ͬ�����¿�����
 set @bounty=@insums+@bounty
exec dbo.cashcardup @cardid,@bounty
--���س�ֵ��ˮID��Ϊ��ӡƱ������
select @@identity as loggingid

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposer_hisInsert' AND type = 'P')
   DROP PROCEDURE jproposer_hisInsert
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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
 @crname varchar(20),--����Ա
 @dbname varchar(20)


 AS
insert j_proposer_history(names,sex,[identity],tel,[add],mtel,passwordtel,password,comment,presenter,depotid,crname,dbname) 
    values( @names , @sex, @identity,@tel, @add , @mtel, @pswtel, @psw , @comment, @presenter, @depotid,@crname,@dbname )





GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposerDelete' AND type = 'P')
   DROP PROCEDURE jproposerDelete
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE [dbo].[jproposerDelete]
@proposerid int,
@dbname varchar(20)

 AS
/*
ʱ�䣺2007-3-14
�����ˣ�HKM
���ܣ�ɾ���ͻ���Ϣ
*/

delete j_proposer  where proposerid=@proposerid and dbname=@dbname

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jcardDelete' AND type = 'P')
   DROP PROCEDURE jcardDelete
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE [dbo].[jcardDelete] 

@cardid varchar(30),
@dbname varchar(20)
AS


/*����ʱ�䣺2007-3-26
  �����ˣ�HKM
 ���ܣ�ɾ��ָ���Ŀ��ŵ���,ֻ��ɾ��δʹ�õĿ���


*/

delete j_card where cardid=@cardid and isnull(start,0)=0 and dbname=@dbname

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jproposerSelect' AND type = 'P')
   DROP PROCEDURE jproposerSelect
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */



CREATE PROCEDURE [dbo].[jproposerSelect]
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
ʱ�䣺2007-3-14
�����ˣ�HKM
���ܣ���ѯ�ͻ���Ϣ,
�޸�2007.4.1
ԭ��ֻ���ޱ������˲�ѯ
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE jproposerDeletehis
@proposerid int,
@dbname varchar(20)

 AS
/*
ʱ�䣺2007-7-7
���ܣ�ɾ���ͻ���ʷ��Ϣ
*/
delete j_proposer_history  where proposerid=@proposerid and dbname=@dbname


GO



IF EXISTS(SELECT name FROM sysobjects
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
update j_card set start=3 where cardid=@cardid and depotid=@depotid and dbname=@dbname 
else 
update j_card set start=1 where cardid=@cardid and depotid=@depotid and dbname=@dbname 

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jcardlostupdate' AND type = 'P')
   DROP PROCEDURE jcardlostupdate
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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
ʱ�䣺2007-3-14
�����ˣ�HKM
���ܣ������û���ʧ�����¾ɿ��������¿���Ϣ�����Ѿɿ��Ľ���ֵ������ת�Ƶ��¿���
*/


--�����¿� a.sums=b.sums,
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

IF EXISTS(SELECT name FROM sysobjects
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


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'rateInsert' AND type = 'P')
   DROP PROCEDURE rateInsert
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�,���Ӵ�����*/
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*��ȡ���*/
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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
select cardid,@sums,@sums,@enddate,'��ȡ���',@depotid,@crname,@dbname from #tmptab

update a set a.sums=a.sums-@sums from j_card a ,#tmptab b 
where a.cardid=b.cardid and a.dbname=@dbname

GO
















