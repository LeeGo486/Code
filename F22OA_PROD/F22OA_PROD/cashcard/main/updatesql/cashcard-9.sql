use cashcard
 go

/*充值卡月报表明细-2008-02-27 dpipi*/
if exists (select 1
          from sysobjects
          where name = 'Card_GetMontyAll'
          and type = 'P')
   drop procedure Card_GetMontyAll
go



CREATE PROCEDURE [dbo].[Card_GetMontyAll]
@datebeg datetime,
@dateend datetime,
@dbname varchar(20)
AS
begin
   

  -- declare @bdatebeg datetime
   --set @bdatebeg=CONVERT(char(10),(@datebeg-1), 126)
declare @bt table
	(cardid varchar (100),
 	  bsum numeric(12,2)
	)

declare @mit table
	( cardid varchar (100),
          addsum numeric(12,2),
          ratsum numeric(12,2)
	)
declare @mot table
	( cardid varchar (100),
          outsum numeric(12,2)
	)
declare @myt table
	( cardid varchar (100),
          ysum numeric(12,2)
	)
------------------------
--declare @bdatebeg datetime
 --  set @bdatebeg=CONVERT(char(10),(getdate()-60), 126)
--declare @dateend datetime
--   set @dateend=CONVERT(char(10),(getdate()+1), 126)
--print @bdatebeg

--declare @dbname varchar(20)
 --  set @dbname='F22'

------------------------
--得取月初金额
 insert into @bt(cardid,bsum)
select a.cardid,
 ( isnull(sum(c.insums),0)+isnull(sum(c.bounty),0)-isnull(sum(b.sums),0) ) as bsum
 --isnull(sum(c.insums),0) as addsum,isnull(sum(c.bounty),0) as ratsum,Max(c.sure_date),Max(@bdatebeg)
   from  j_card a 
     left join 
       dbo.d_consume b
     on a.cardid=b.cardid and a.dbname=b.dbname 
         and b.sure_date<@datebeg and b.sure_date>'2000-01-01'
   left join 
        dbo.d_logging c
     on a.cardid=c.cardid and a.dbname=c.dbname
         and c.sure_date<@datebeg and c.sure_date>'2000-01-01'
    where a.start>0 and a.dbname=@dbname
  group by a.cardid

--得取本月初金额消费
insert into @mot(cardid,outsum)
select a.cardid,isnull(sum(b.sums),0) as outsum 
      from  j_card a 
     left join 
       dbo.d_consume b
     on a.cardid=b.cardid and a.dbname=b.dbname 
         and b.sure_date<CONVERT(char(10),@dateend,126) and b.sure_date>CONVERT(char(10),@datebeg,126)
   
    where a.start>0 and a.dbname=@dbname and b.dtype=1
  group by a.cardid 


--得取本月年费消费
insert into @myt(cardid,ysum)
select a.cardid,isnull(sum(b.sums),0) as ysum 
      from  j_card a 
     left join 
       dbo.d_consume b
     on a.cardid=b.cardid and a.dbname=b.dbname 
         and b.sure_date<CONVERT(char(10),@dateend,126) and b.sure_date>CONVERT(char(10),@datebeg,126)
   
    where a.start>0 and a.dbname=@dbname and b.dtype=2
  group by a.cardid 
  
--得取本月初金额充值
insert into @mit(cardid,addsum,ratsum)
select a.cardid,
  isnull(sum(c.insums),0) as addsum,isnull(sum(c.bounty),0) as ratsum
      from  j_card a 
     
   left join 
        dbo.d_logging c
     on a.cardid=c.cardid and a.dbname=c.dbname
         and c.sure_date<CONVERT(char(10),@dateend,126) and c.sure_date>CONVERT(char(10),@datebeg,126)
    where a.start>0 and a.dbname=@dbname
  group by a.cardid 
     select a.cardid,isnull(a.bsum,0) as bsum,
          isnull(outsum,0) as outsum,
          isnull(addsum,0) as addsum,
          isnull(ratsum,0) as ratsum, 
          isnull(ysum,0) as ysum,
     (isnull(a.bsum,0)-isnull(outsum,0)-isnull(ysum,0)+isnull(addsum,0)+isnull(ratsum,0)) as esum 
from @bt a 
   left join @mot b 
         on a.cardid=b.cardid
     left join @mit c 
         on a.cardid=c.cardid
    left join @myt d
         on a.cardid=d.cardid
   where isnull(a.bsum,0)>0 or isnull(outsum,0) >0 or isnull(addsum,0)> 0 or isnull(ratsum,0)> 0 or isnull(ysum,0)>0

end
go

-----------------------------------
/*反充值-2008-03-04 dpipi*/
if exists (select 1
          from sysobjects
          where name = 'Card_Backupmoney'
          and type = 'P')
   drop procedure Card_Backupmoney
go



CREATE PROCEDURE [dbo].[Card_Backupmoney]
@loggingid int
AS
begin
declare @cardid varchar(50)
declare @dbname varchar(50)
declare @insums numeric(12,6) --比例
declare @bounty numeric(12,2)

select @cardid=cardid,@insums=-insums,@bounty=-bounty,@dbname=dbname from d_logging
 where loggingid=@loggingid

insert into d_logging(cardid,insums,rate,bounty,crname,crdate,sure_date,comment,depotid,dbname)
select cardid,-insums,rate,-bounty,crname,getdate(),getdate(),comment,depotid,dbname from d_logging
 where loggingid=@loggingid



--同步更新卡档案

 set @bounty=@insums+@bounty
exec dbo.cashcardup @cardid,@bounty,@dbname
--返回充值流水ID作为打印票据依据
select @@identity as loggingid
end
go