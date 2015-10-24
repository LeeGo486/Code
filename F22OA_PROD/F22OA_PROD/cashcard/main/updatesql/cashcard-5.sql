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
exec dbo.cashcardup @newcardid,@sums,@dbname


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

