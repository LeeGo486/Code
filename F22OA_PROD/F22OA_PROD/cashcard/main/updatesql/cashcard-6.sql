use cashcard
go

IF EXISTS (SELECT name FROM sysobjects 
      WHERE name = 'jcardlostupdate' and type = 'P')
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
values (@newcardid,@sums,0,0,@crname,getdate(),getdate(),'����(��'+@oldcardid+'ת��)',@depotid,@dbname)
--values (@newcardid,@sums,0,0,@crname,getdate(),getdate(),'��ʧ����',@depotid,@dbname)


--ͬ�����¿�����
exec dbo.cashcardup @newcardid,@sums,@dbname


--���÷������
declare @strcomment varchar(100)
set @strcomment='��ʧ����(ת����' + @newcardid +')'
set @sums=0-@sums
exec dloggingInsert @oldcardid,@sums,@crname,@strcomment,@depotid,@dbname
--exec dloggingInsert @oldcardid,@sums,@crname,'��ʧ����',@depotid,@dbname

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
      WHERE name = 'jproposerReg' and type = 'P')
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

--exec dloggingInsert  @cardid,@insums,@crname,@comment2,@depotid,@dbname
select @proposerid as proposerid
end
GO
