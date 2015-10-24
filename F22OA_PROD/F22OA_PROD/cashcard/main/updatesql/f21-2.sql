/**************���ܣ������ͻ���ǰʹ�õ�f21�����ݿ⣬���Ȩ��card����*************/
/*��������:2007-07-09*/
/* write by dpipi */
/*��ֵ��*/
/*�޸�����2007-07-06*/

/*��ֵ����*/
if not exists (select 1
            from  syscolumns
           where  id = object_id('d_retail')
           and   name ='cardid')
	ALTER TABLE d_retail add cardid varchar(50) null
go

/*��ֵ�ۼ����*/
if not exists (select 1
            from  syscolumns
           where  id = object_id('d_retail')
           and   name ='cardsums')
	ALTER TABLE d_retail add cardsums numeric(8,2) null
go

--ά����ֵ������2007-07-08
--��ƽƽ
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardFillCard' AND type = 'P')
   DROP PROCEDURE Card_jcardFillCard 
GO

CREATE  PROCEDURE Card_jcardFillCard

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@depotid varchar(10),
@userid varchar(20),
@yesnosendcard char(1),
@yesnosendcust char(1)

AS

if(@depotid='-')
begin
if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.*,b.names 
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
end
else if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard<> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust = '-')
	                begin
	                    --����-
	                    	select a.*,b.names 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.*,b.names 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo._proposer b,sys_depotpower18ql c
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0'
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                          and a.proposerid<>'0'
	                end
            end
		--δ����
            else
	            begin
	                select a.*,b.names 
	                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                      and isnull(a.depotid,'')='' and a.proposerid='0'
	            end
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard <> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust ='-')
	                begin
	                    --����-
	                   select a.*,b.names 
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.*,b.names 
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
	                end
            end
            else
            begin--δ����
                select a.*,b.names
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.*,b.names
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd 
end

end
else
begin
if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.*,b.names 
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 and a.depotid=@depotid
end
else if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard<> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust = '-')
	                begin
	                    --����-
	                    	select a.*,b.names 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') and a.depotid=@depotid
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.*,b.names 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' and a.depotid=@depotid
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid=@depotid
	                end
            end
		--δ����
            else
	            begin
	                select a.*,b.names 
	                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                      and isnull(a.depotid,'')='' and a.proposerid='0' and a.depotid=@depotid
	            end
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard <> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust ='-')
	                begin
	                    --����-
	                   select a.*,b.names 
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				and a.depotid=@depotid
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.*,b.names 
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
			and a.depotid=@depotid
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0' and a.depotid=@depotid
	                end
            end
            else
            begin--δ����
                select a.*,b.names
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			and a.depotid=@depotid
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.*,b.names
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd and a.depotid=@depotid 
end
end

go

/*����ʱ�䣺2007-7-8
  �����ˣ�dpipi
 ���ܣ���ѯָ����Χ�Ŀ��ŵ���


*/
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardQueryBegEnd' AND type = 'P')
   DROP PROCEDURE Card_jcardQueryBegEnd 
GO
CREATE PROCEDURE Card_jcardQueryBegEnd 

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@userid varchar(20)
AS


select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
	a.depotid,a.crdate,a.lastdate
from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
where a.proposerid*=b.proposerid and  cardid>=@cardidBeg and cardid<=@cardidEnd

and c.userid=@userid and a.depotid=c.depotid and c.access=1
GO

/*����ʱ�䣺2007-7-8
  �����ˣ�dpipi
 ���ܣ�ά������������ѯ����ָ����Χ�Ŀ��ŵ���
*/
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardSelectDepotBegEndAll' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectDepotBegEndAll
GO

CREATE  PROCEDURE Card_jcardSelectDepotBegEndAll

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@depotid varchar(10),
@userid varchar(20)
AS



if @depotid='-'  and @cardidBeg ='-' and @cardidEnd='-'
    begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
	a.depotid,a.crdate,a.lastdate,b.names
	 from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
	 where a.proposerid*=b.proposerid  
	
	and c.userid=@userid and a.depotid*=c.depotid and c.access=1

     end
if  @cardidBeg ='-' and @cardidEnd='-'
    begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
	a.depotid,a.crdate,a.lastdate,b.names
	 from  cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
	 where a.proposerid*=b.proposerid  and a.depotid=@depotid 
	
	and c.userid=@userid and a.depotid*=c.depotid and c.access=1

     end
else
    begin
	--select a.*,b.names 
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
 where a.proposerid*=b.proposerid and a.depotid=@depotid and cardid>=@cardidBeg and cardid<=@cardidEnd

and c.userid=@userid and a.depotid*=c.depotid and c.access=1

     end
GO


/*����ʱ�䣺2007-7-8
  �����ˣ�dpipi
 ���ܣ���ѯָ����Χ���Ѿ�ʹ�û�δʹ�õĿ��ŵ���

*/
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardSelectDepotBegEnd' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectDepotBegEnd
GO
CREATE PROCEDURE Card_jcardSelectDepotBegEnd

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@used int
AS


select a.*,b.names 
      from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b 
     where a.proposerid*=b.proposerid and start=@used and cardid>=@cardidBeg and cardid<=@cardidEnd

GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardFillCardCommon' AND type = 'P')
   DROP PROCEDURE Card_jcardFillCardCommon
GO

/*����ʱ�䣺2007-7-8
  �����ˣ�dpipi
 ���ܣ���ͨ�û�ά����ֵ������
*/

CREATE  PROCEDURE Card_jcardFillCardCommon

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@depotid varchar(10),
@userid varchar(20),
@yesnosendcard char(1),
@yesnosendcust char(1)

AS

if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.*,b.names 
        from      cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
end
else if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard<> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust = '-')
	                begin
	                    --����-
	                    	select a.*,b.names 
	                 	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1 
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.*,b.names 
	                    from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0'
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                          and a.proposerid<>'0'
	                end
            end
		--δ����
            else
	            begin
	                select a.*,b.names 
	                from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                      and isnull(a.depotid,'')='' and a.proposerid='0'
	            end
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard <> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust ='-')
	                begin
	                    --����-
	                   select a.*,b.names 
	                   from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.*,b.names 
                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
	                end
            end
            else
            begin--δ����
                select a.*,b.names
                from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.*,b.names
            from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd 
end

GO

IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerSelect' AND type = 'P')
   DROP PROCEDURE Card_jproposerSelect
GO
CREATE PROCEDURE Card_jproposerSelect
@username varchar(30),
@userid varchar(4)

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
	select a.* from   cashcard.dbo.j_proposer a, sys_depotpower18ql b where  b.userid=@userid and a.depotid=b.depotid
	 	and b.access=1
end
else
begin
	select a.* from   cashcard.dbo.j_proposer a, sys_depotpower18ql b where a.names=@username  and b.userid=@userid and a.depotid=b.depotid
 	and b.access=1
end


GO
----��ѯ�ͻ���Ϣ
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerQuerySelect' AND type = 'P')
   DROP PROCEDURE Card_jproposerQuerySelect
GO
CREATE PROCEDURE Card_jproposerQuerySelect
@username varchar(30),
@userid varchar(4)

 AS
/*
ʱ�䣺2007-7-3
���ܣ���ѯ�ͻ���Ϣ
ԭ��ֻ���ޱ������˲�ѯ
*/
if (@username ='')
begin
	select a.* from   cashcard.dbo.j_proposer a, sys_depotpower18ql b where  b.userid=@userid and a.depotid=b.depotid
	 	and b.access=1
end
else
begin
	select a.* from   cashcard.dbo.j_proposer a, sys_depotpower18ql b where a.names=@username  and b.userid=@userid and a.depotid=b.depotid
 	and b.access=1
end
GO

--��ѯ�ͻ���Ϣ(��ʷ)
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerQuerySelecthis' AND type = 'P')
   DROP PROCEDURE Card_jproposerQuerySelecthis
GO

CREATE PROCEDURE Card_jproposerQuerySelecthis
@username varchar(30),
@userid varchar(4)

 AS
/*
ʱ�䣺2007-7-7
���ܣ���ѯ�ͻ���Ϣ(��ʷ)
ԭ��ֻ���ޱ������˲�ѯ
*/
if (@username ='')
begin
	select a.* ,c.cardnum
	from   cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 group by proposerid ) c 
	where  b.userid=@userid and a.depotid=b.depotid 
		 	and b.access=1 and a.proposerid*=c.proposerid
end
else
begin
	select a.* ,c.cardnum
	from   cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 group by proposerid ) c 
	where a.names=@username  and  b.userid=@userid and a.depotid=b.depotid 
		 	and b.access=1 and a.proposerid*=c.proposerid
end
GO

--��ʷ�����˵���
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerSelecthis' AND type = 'P')
   DROP PROCEDURE Card_jproposerSelecthis
GO


CREATE PROCEDURE Card_jproposerSelecthis
@username varchar(30),
@userid varchar(4)

 AS
/*
��ʷ�����˵���
2007-07-07
*/
if (@username ='')
begin
	select a.* from  cashcard.dbo.j_proposer_history a, sys_depotpower18ql b where  b.userid=@userid and a.depotid=b.depotid
	 	and b.access=1
end
else
begin
	select a.* from  cashcard.dbo.j_proposer_history a, sys_depotpower18ql b where a.names=@username  and b.userid=@userid and a.depotid=b.depotid
 	and b.access=1
end
GO
---��ʧ���
--��@namesΪ��ʱ,Ĭ�ϲ�����
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardSelectLoseUser' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectLoseUser
GO
CREATE PROCEDURE Card_jcardSelectLoseUser

@names varchar(50),
@depotid varchar(10),
@userid varchar(20)
AS
if(@names ='')
begin
	select a.* ,b.cardid,b.start,b.sums 
             from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c
	 where a.proposerid=b.proposerid and b.depotid=@depotid
	           and c.userid=@userid and a.depotid=c.depotid and c.access=1
end
else
begin
	select a.* ,b.cardid,b.start,b.sums 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c
	 where a.proposerid=b.proposerid and b.depotid=@depotid and a.names=@names
	and c.userid=@userid and a.depotid=c.depotid and c.access=1
end

GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_dloggingSelect' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelect
GO

CREATE PROCEDURE Card_dloggingSelect

@cardid varchar(30),
@userid varchar(4)
 AS

/*2007.7.9
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
*/
select a.* from  cashcard.dbo.d_logging a,sys_depotpower18ql b 
where b.userid=@userid and a.depotid=b.depotid and b.access=1  and a.cardid=@cardid

GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_dloggingSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelectDateBegEnd
GO
CREATE PROCEDURE Card_dloggingSelectDateBegEnd

@userid varchar(10),
@datebeg datetime,
@dateend datetime
 AS

/*2007.7.9
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
*/
select a.* from cashcard.dbo.d_logging a,sys_depotpower18ql b 
where  b.userid=@userid and a.depotid=b.depotid and b.access=1  and (sure_date between @datebeg and DATEADD(day, 1,@dateend))

GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_dconsumeSelect' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelect
GO

CREATE PROCEDURE Card_dconsumeSelect

@cardid varchar(30),
@userid varchar(4)

 AS
/*
2007.7.9
HKM
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼
*/
select a.* from cashcard.dbo.d_consume a,sys_depotpower18ql b 
where b.userid=@userid and a.depotid=b.depotid and b.access=1 and cardid=@cardid

GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_dloggingSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelectDateBegEnd
GO

CREATE PROCEDURE Card_dloggingSelectDateBegEnd

@userid varchar(10),
@datebeg datetime,
@dateend datetime
 AS

/*2007.7.9
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
*/
select a.* from cashcard.dbo.d_logging a,sys_depotpower18ql b 
where  b.userid=@userid and a.depotid=b.depotid and b.access=1  and 
(sure_date between @datebeg and DATEADD(day, 1,@dateend))

GO

IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'card_jproposerQuerySelect' AND type = 'P')
   DROP PROCEDURE card_jproposerQuerySelect
GO

CREATE PROCEDURE card_jproposerQuerySelect
@username varchar(30),
@userid varchar(4)

 AS
/*
ʱ�䣺2007-7-3
���ܣ���ѯ�ͻ���Ϣ
ԭ��ֻ���ޱ������˲�ѯ
*/
if (@username ='')
begin
	select a.* ,c.cardnum
	from  cashcard.dbo.j_proposer a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 group by proposerid )c
	where  b.userid=@userid and a.depotid=b.depotid 
		 	and b.access=1 and a.proposerid*=c.proposerid
end
else
begin
	select a.* ,c.cardnum
	from  cashcard.dbo.j_proposer a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 group by proposerid )c
	where a.names=@username  and  b.userid=@userid and a.depotid=b.depotid 
		 	and b.access=1 and a.proposerid*=c.proposerid
end
GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_dconsumeSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelectDateBegEnd
GO

CREATE PROCEDURE Card_dconsumeSelectDateBegEnd

@userid varchar(10),
@datebeg datetime,
@dateend datetime

 AS
/*
2007.3.31
HKM
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼
*/
select a.* from cashcard.dbo.d_consume a,sys_depotpower18ql b 
where  b.userid=@userid and a.depotid=b.depotid and b.access=1 and (sure_date between @datebeg and DATEADD(day, 1,@dateend))

GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardFillCard' AND type = 'P')
   DROP PROCEDURE Card_jcardFillCard
GO

CREATE  PROCEDURE Card_jcardFillCard

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@depotid varchar(10),
@userid varchar(20),
@yesnosendcard char(1),
@yesnosendcust char(1)

AS

if(@depotid='-')
begin
if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.*,b.names 
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
end
else if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard<> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust = '-')
	                begin
	                    --����-
	                    	select a.*,b.names 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.*,b.names 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0'
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                          and a.proposerid<>'0'
	                end
            end
		--δ����
            else
	            begin
	                select a.*,b.names 
	                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                      and isnull(a.depotid,'')='' and a.proposerid='0'
	            end
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard <> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust ='-')
	                begin
	                    --����-
	                   select a.*,b.names 
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.*,b.names 
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
	                end
            end
            else
            begin--δ����
                select a.*,b.names
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.*,b.names
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd 
end

end
else
begin
if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.*,b.names 
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 and a.depotid=@depotid
end
else if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard<> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust = '-')
	                begin
	                    --����-
	                    	select a.*,b.names 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') and a.depotid=@depotid
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.*,b.names 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' and a.depotid=@depotid
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid=@depotid
	                end
            end
		--δ����
            else
	            begin
	                select a.*,b.names 
	                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                      and isnull(a.depotid,'')='' and a.proposerid='0' and a.depotid=@depotid
	            end
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard <> '-')
begin
            --�ѷ���
            if (@yesnosendcard = '1')
            begin
                --�Ƿ����˿�
                if (@yesnosendcust ='-')
	                begin
	                    --����-
	                   select a.*,b.names 
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				and a.depotid=@depotid
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.*,b.names 
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
			and a.depotid=@depotid
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.*,b.names
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0' and a.depotid=@depotid
	                end
            end
            else
            begin--δ����
                select a.*,b.names
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			and a.depotid=@depotid
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.*,b.names
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c 
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd and a.depotid=@depotid 
end
end


GO
--���������ֵ��
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_cardBatCongeal' AND type = 'P')
   DROP PROCEDURE Card_cardBatCongeal
GO

/*���������ֵ��(һ��ʱ��δ�����ҿ����<=0)*/
CREATE PROCEDURE  Card_cardBatCongeal
AS
--�õ�δ��������
DECLARE @monthnum int
select @monthnum=monthnum from cashcard.dbo.j_setnotconsumetime 
--����һ����ʱ��@tmptab(���ڴ�Ű���������ں�ÿ�û�����ѵļ�¼)
DECLARE @tmptab table(cardid varchar(50))
--����һ�α�
DECLARE tcardid_cursor CURSOR
FOR
     SELECT cardid,sure_date
     FROM  cashcard.dbo.d_consume  
     WHERE datediff(month,sure_date,getdate())>=@monthnum and comment='��ȡ���'

OPEN tcardid_cursor
--����@strcardid��@deductdate�ֱ����ڴ��'����'��'���������'
DECLARE @strcardid varchar(50),@deductdate datetime 

FETCH NEXT FROM tcardid_cursor INTO @strcardid,@deductdate

WHILE (@@FETCH_STATUS <> -1)
BEGIN
   IF (@@FETCH_STATUS <> -2)
   BEGIN
      /*���@num=0���ʾ����Ѻ�һ��ʱ��δ����,������@tmptab*/
      declare @num int
      select @num=count(*) from (SELECT A.*,B.s_name FROM d_Retailsub A inner join J_style B on A.styleid=B.styleid)as view_d_retailsub where vipcardid=@strcardid and crdate>=@deductdate 
      if(@num=0)
	begin
      		insert into @tmptab(cardid)
		values(@strcardid)
	end
   END
   FETCH NEXT FROM tcardid_cursor INTO @strcardid,@deductdate
END
CLOSE tcardid_cursor
DEALLOCATE tcardid_cursor

--select * from @tmptab
--���������ֵ��(1��ʾ���� 0��ʾ������)
UPDATE a SET congeal=1  
FROM  cashcard.dbo.j_card a INNER JOIN @tmptab b ON a.cardid=b.cardid
WHERE a.sums<=0 

GO

IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardQuerydepot' AND type = 'P')
   DROP PROCEDURE Card_jcardQuerydepot
GO

CREATE PROCEDURE Card_jcardQuerydepot

@depotid varchar(10),
@userid varchar(20)

AS

/*����ʱ�䣺2007-7-11
  �����ˣ�HKM
 ���ܣ���ѯָ����Χ�Ŀ��ŵ���
*/

--select a.*,b.names 
select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
	a.depotid,a.crdate,a.lastdate,b.names
from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c
where a.proposerid*=b.proposerid and  a.depotid=@depotid
	and c.userid=@userid and a.depotid=c.depotid and c.access=1
GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'A380web_getUserMenu' AND type = 'P')
   DROP PROCEDURE A380web_getUserMenu
GO
create  procedure dbo.A380web_getUserMenu
@userid varchar(10)
as
begin
    declare @roles bit,
        @dptype int,
        @depotid varchar(10),
        @merchantid varchar(10),
        @parentid varchar(10)
    
    select @roles=usermain,@depotid=depotid,@merchantid=mb,@dptype=isnull(dptype,0) from webvw_user where userid=@userid
    /*�ܲ������û�*/
    if @roles=1 and @dptype=0 
    	select aspxid,loadid,aspname,
            CASE isnull(userreadme,'') when  '' then readme else userreadme END AS readme
            from aspnetdb.dbo.web_aspx 
                group by aspxid,loadid,aspname,readme,userreadme,ctype   
		        order by ctype,loadid,aspxid
    else
	        select aspxid,loadid,aspname,readme from aspnetdb.dbo.webvw_useraspx
                       group by aspxid,loadid,aspname,readme,ctype,username  
		        having username=@userid 
                    order by ctype,loadid,aspxid
 end


GO


 ALTER  view webvw_user as 
select userid,username,password,usermain,notuse,depotid,mb,isnull(dptype,0) as dptype from j_user  
GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_Getshoplist' AND type = 'P')
   DROP PROCEDURE Card_Getshoplist
GO
/*���ܣ�ѡ�����*/
/*����:2007-07-18*/
/* write by dpipi */
create procedure Card_Getshoplist
@userid varchar(20),
@shopnum varchar(50),
@type varchar(50)
as
begin
     --������̱�Ų��Ϊ�������еĵ���
    if(@shopnum='-')
	    begin
			   SELECT j_depot.*, sys_depotpower18ql.access, sys_depotpower18ql.selection,
			                   sys_depotpower18ql.userid 
			                 FROM j_depot INNER JOIN 
			                   sys_depotpower18ql 
			                  ON j_depot.depotid = sys_depotpower18ql.depotid 
			                where sys_depotpower18ql.userid=@userid
	    end
     else
        begin
	           -- if search by shopid
	          if(@type='num')
	             begin
		            SELECT j_depot.*, sys_depotpower18ql.access, sys_depotpower18ql.selection,
					                   sys_depotpower18ql.userid 
					                 FROM j_depot INNER JOIN 
					                   sys_depotpower18ql 
					                  ON j_depot.depotid = sys_depotpower18ql.depotid 
					                where sys_depotpower18ql.userid=@userid 
		                                        and j_depot.depotid like @shopnum+ '%' 
	            end
	           -- if search by shopname
	         if(@type='name')
	             begin
		            SELECT j_depot.*, sys_depotpower18ql.access, sys_depotpower18ql.selection,
					                   sys_depotpower18ql.userid 
					                 FROM j_depot INNER JOIN 
					                   sys_depotpower18ql 
					                  ON j_depot.depotid = sys_depotpower18ql.depotid 
					                where sys_depotpower18ql.userid=@userid 
		                                        and j_depot.d_name like @shopnum + '%' 
	            end

	          -- if search by shopname
	         if(@type='code')
	             begin
		            SELECT j_depot.*, sys_depotpower18ql.access, sys_depotpower18ql.selection,
					                   sys_depotpower18ql.userid 
					                 FROM j_depot INNER JOIN 
					                   sys_depotpower18ql 
					                  ON j_depot.depotid = sys_depotpower18ql.depotid 
					                where sys_depotpower18ql.userid=@userid 
		                                        and j_depot.dpthelp like @shopnum + '%' 
	            end
        
        
        end

end

GO


/*---------------2007-07-20-----------------*/
/*1���������۱�ĳ�ֵ���Ĵ�����*/
/*����޸�����2007-07-20*/

if exists (select 1
          from sysobjects
          where id = object_id('Tu_retailcard')
          and type = 'TR')
   drop trigger Tu_retailcard
go

/*��ֵ��������*/
CREATE TRIGGER [Tu_retailcard] ON [dbo].[d_retail] 
with encryption FOR  UPDATE 
AS
begin
      declare @numrows  int,
              @dbname nvarchar(128)
      select  @numrows = @@rowcount
      if @numrows = 0
      return


     if update(sure) 
     begin
       declare @cur table (
       retailid varchar(22),
       sure int
       )

       select @dbname=db_name()       

       insert into @cur
       select t1.retailid,t1.sure from d_retail t1, inserted i1,deleted d1
           where t1.retailid =i1.retailid and i1.retailid = d1.retailid and (isnull(i1.sure,0) != isnull(d1.sure,0))
             group by t1.retailid,t1.sure
       
       /*�������Ѽ�¼*/
       insert into cashcard.dbo.d_consume (retailid,cardid,cardsums,sums,sure_date,comment,depotid,crdate,crname,dbname,dtype)
       select a.retailid,a.cardid,b.sums,a.cardsums,a.sure_date,'��������',a.depotid,getdate(),a.sure_name,@dbname,1
             from d_retail a,cashcard.dbo.j_card b,@cur c where a.retailid=c.retailid and a.cardid=b.cardid
                  and isnull(c.sure,0)=1 and b.dbname=@dbname
       /*�ۼ����*/
       update a set a.sums=isnull(a.sums,0)-isnull(b.cardsums,0) from cashcard.dbo.j_card a,d_retail b,@cur c
              where a.cardid=b.cardid and b.retailid=c.retailid and isnull(c.sure,0)=1 and a.dbname=@dbname
       
       /*ɾ�����Ѽ�¼*/
       delete from cashcard.dbo.d_consume where dbname=@dbname and retailid in (select retailid from @cur where isnull(sure,0)=0)
       /*�ӻؽ��*/
       update a set a.sums=isnull(a.sums,0)+isnull(b.cardsums,0) from cashcard.dbo.j_card a,d_retail b,@cur c
              where a.cardid=b.cardid and b.retailid=c.retailid and isnull(c.sure,0)=0 and a.dbname=@dbname
        
       return
     end

end
go
