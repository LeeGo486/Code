use cashcard
go

---------------------------�������ݿ�cashcard--------------------------------

/********�ռǱ�***************/

/*�����ռǱ�*/

/*==========================================================*/
/* Table: �ռǱ�                                           */
/* date 2007-09-24                                             */
/* writer by dpipi                                            */
/* LogID id                                            */
/* Crdate                                            */
/* UserId                                           */
/* UserName                                             */
/* TabName �������������                               */
/* tabValue ��������Ĵ���                                */
/* hostname �ͻ�ip                                            */
/* UpType ��������                                            */
/*==========================================================*/

if not exists (select 1
            from  sysobjects
           where  id = object_id('sys_log18ql')
            and   type = 'U')
begin
CREATE TABLE [sys_log18ql] (
	[LogID] [int] IDENTITY (1, 1) NOT NULL ,
	[Crdate] [datetime] NULL  DEFAULT (getdate()),
	[UserId] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[UserName] [char] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	[TabName] [varchar] (40) COLLATE Chinese_PRC_CI_AS NULL ,
	[tabValue] [varchar] (254) COLLATE Chinese_PRC_CI_AS NULL ,
	[hostname] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[UpType] [varchar] (20) COLLATE Chinese_PRC_CI_AS NULL ,
	
	 constraint PK_sys_log18ql primary key  (LogID)
)
end
go

---------------------------------------- up data 2007-09-27---------------
/*���������쿨ʱ����ջؿ���ʱ��*/
if not exists (select 1 
     from  syscolumns
  where  id = object_id('j_card')
        and   name ='getcardtime')
ALTER TABLE j_card ADD getcardtime datetime null
go
if not exists (select 1 
     from  syscolumns
  where  id = object_id('j_card')
        and   name ='losecardtime')
ALTER TABLE j_card ADD losecardtime datetime null
go


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'dconsumeNotLogin' AND type = 'P')
   DROP PROCEDURE dconsumeNotLogin
GO
/*���ܣ�Ϊ����һ��δ��ֵҲҪ��*/
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
begin
--1.insert ���һ���������ڴ���һ���
select A.consumseid,a.cardid,a.sure_date,a.depotid,c.sums,d.proposerid,d.names,d.passwordtel 
 into #tmptab 
from d_consume A,
--���������һ�ε��������ڣ��Ϳ����г���
( select distinct cardid,max(sure_date) as sure_date from d_consume where dbname=@dbname group by cardid) B,
j_card c,j_proposer d
where A.cardid=B.cardid 
      and A.sure_date = B.sure_date 
      and datediff(year, B.sure_date,@enddate)>=1
      and a.cardid=c.cardid 
      and c.proposerid=d.proposerid 
      and a.dbname=@dbname 
      and c.dbname=@dbname 
      and d.dbname=@dbname

--2.insert ���һ�γ�ֵ���ڴ���һ���

insert  #tmptab (consumseid,cardid,sure_date,depotid,sums,proposerid,names,passwordtel)
select A.consumseid,a.cardid,a.sure_date,a.depotid,c.sums,d.proposerid,d.names,d.passwordtel 
from d_consume A,
( select distinct cardid,max(sure_date) as sure_date from d_logging where dbname=@dbname group by cardid) B,
  j_card c,j_proposer d
where A.cardid=B.cardid 
      and A.sure_date = B.sure_date 
      and datediff(year, B.sure_date,@enddate)>=1
      and a.cardid=c.cardid 
      and c.proposerid=d.proposerid 
      and a.dbname=@dbname 
      and c.dbname=@dbname 
      and d.dbname=@dbname

--3.insert�ѷ�����һ��ģ���û�����Ѽ�¼�ģ�������Ϣ
insert #tmptab(consumseid,cardid,sure_date,depotid,sums,proposerid,names,passwordtel)
     select 0, b.cardid,b.crdate,b.depotid,b.sums, a.proposerid,a.names,a.passwordtel 
        from j_proposer a,j_card b 
         where a.proposerid=b.proposerid
	    and cardid in(
                   
                    select cardid from j_card 
			where cardid not in( 
                                                 --û�����Ѽ�¼
                                                 select cardid from d_consume where dbname=@dbname
                                            ) 
				and isnull(proposerid,0)<>0 
                                and datediff(year, isnull(B.getcardtime,getdate()),@enddate)>=1  
                                and dbname=@dbname
			)
	and a.dbname=@dbname and b.dbname=@dbname



insert d_consume(cardid,sums,sure_date,comment,depotid,crname,dbname,dtype)
select cardid,@sums,@enddate,'��ȡ���',@depotid,@crname,@dbname,2 from #tmptab

update a set a.sums=a.sums-@sums from j_card a ,#tmptab b 
where a.cardid=b.cardid and a.dbname=@dbname


end
GO

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
update  j_card set depotid=@depotid,getcardtime=getdate(),comment='' where dbname=@dbname and isnull(proposerid,0)=0 and (cardid between @cardstr and @cardend)



GO
