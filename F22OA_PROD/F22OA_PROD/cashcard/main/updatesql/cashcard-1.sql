use cashcard
go

IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_batdelallusertable' AND type = 'P')
   DROP PROCEDURE Card_batdelallusertable
GO
/*ɾ�����ݿ�cashcard�����û���*/
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
/*���ܣ�Ϊ���ӽ�������*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('d_consume')
   and   name ='crdate')
ALTER TABLE d_consume add crdate datetime  default getdate()
go

/*���ܣ�Ϊ���ӽ�����*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('d_consume')
   and   name ='crname')
ALTER TABLE d_consume add crname varchar (20) NULL
go

/*���ܣ�Ϊ���ӽ�������*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_proposer')
   and   name ='crdate')
ALTER TABLE j_proposer add crdate datetime  default getdate()
go

/*���ܣ�Ϊ���ӽ�����*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_proposer')
   and   name ='crname')
ALTER TABLE j_proposer add crname varchar (20) NULL
go

/*���ܣ�Ϊ���ӽ�������*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_proposer_history')
   and   name ='crdate')
ALTER TABLE j_proposer_history add crdate datetime  default getdate()
go

/*���ܣ�Ϊ���ӽ�����*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_proposer_history')
   and   name ='crname')
ALTER TABLE j_proposer_history add crname varchar (20) NULL
go

/*���ܣ�Ϊ���ӽ�������*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_rate')
   and   name ='crdate')
ALTER TABLE j_rate add crdate datetime  default getdate()
go

/*���ܣ�Ϊ���ӽ�����*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_rate')
   and   name ='crname')
ALTER TABLE j_rate add crname varchar (20) NULL
go



/*���ܣ�Ϊ���ӽ�������*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_setnotconsumetime')
   and   name ='crdate')
ALTER TABLE j_setnotconsumetime add crdate datetime  default getdate()
go

/*���ܣ�Ϊ���ӽ�����*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_setnotconsumetime')
   and   name ='crname')
ALTER TABLE j_setnotconsumetime add crname varchar (20) NULL
go


/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.d_consume')
   and   name ='dbname')
ALTER TABLE dbo.d_consume add dbname varchar (20) NULL
go

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.d_logging')
   and   name ='dbname')
ALTER TABLE dbo.d_logging add dbname varchar (20) NULL
go

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_card')
   and   name ='dbname')
ALTER TABLE dbo.j_card add dbname varchar (20) NULL
go

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_proposer')
   and   name ='dbname')
ALTER TABLE dbo.j_proposer add dbname varchar (20) NULL
go

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_proposer_history')
   and   name ='dbname')
ALTER TABLE dbo.j_proposer_history add dbname varchar (20) NULL
go



/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('j_rate')
   and   name ='dbname')
ALTER TABLE j_rate add dbname varchar (20) NULL
go

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_setnotconsumetime')
   and   name ='dbname')
ALTER TABLE dbo.j_setnotconsumetime add dbname varchar (20) NULL
go


/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-17*/
/*write by dpipi */
if not exists (select 1
  from  syscolumns
   where  id = object_id('dbo.j_setnotconsumetime')
   and   name ='dbname')
ALTER TABLE dbo.j_setnotconsumetime add dbname varchar (20) NULL
go


/*���ܣ�Ϊ�����������ݿ��ֶ�*/
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

/*���ܣ����ӿ��ĵ�״̬*/
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
/*���ܣ��޸Ŀ���״̬*/
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


/*���ϲ����Ŀ���*/
if not exists (select 1
            from  syscolumns
           where  id = object_id('j_card')
           and   name ='addcardid')
	ALTER TABLE j_card add addcardid varchar(30) null
go

/*�����շ����͵Ŀ���*/
/*dtype 1Ϊ���ۣ�2Ϊ���*/
/*2007-07-20*/
if not exists (select 1
            from  syscolumns
           where  id = object_id('d_consume')
           and   name ='dtype')
	ALTER TABLE d_consume add dtype int null
go

