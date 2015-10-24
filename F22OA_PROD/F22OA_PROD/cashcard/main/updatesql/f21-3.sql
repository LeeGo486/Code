


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_cardBatCongeal' AND type = 'P')
   DROP PROCEDURE Card_cardBatCongeal
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */

/*���������ֵ��(һ��ʱ��δ�����ҿ����<=0)*/
CREATE PROCEDURE  Card_cardBatCongeal
@dbname varchar(20)
AS
--�õ�δ��������
DECLARE @monthnum int
select @monthnum=monthnum from cashcard.dbo.j_setnotconsumetime  where dbname=@dbname
--����һ����ʱ��@tmptab(���ڴ�Ű���������ں�ÿ�û�����ѵļ�¼)
DECLARE @tmptab table(cardid varchar(50))
--����һ�α�
DECLARE tcardid_cursor CURSOR
FOR
     SELECT cardid,sure_date
     FROM  cashcard.dbo.d_consume  
     WHERE datediff(month,sure_date,getdate())>=@monthnum and comment='��ȡ���' and dbname=@dbname

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
UPDATE a SET congeal=1,start=2  
FROM  cashcard.dbo.j_card a INNER JOIN @tmptab b ON a.cardid=b.cardid
WHERE a.sums<=0  and a.dbname=@dbname


GO
/************************************************/


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'ReturnStrIntercept' AND type = 'FN')
   DROP function ReturnStrIntercept
GO
 
/*�ַ�����ȡ����(�����ַ���...����)*/
CREATE Function dbo.ReturnStrIntercept(@strContent varchar(2000))
RETURNS varchar(50)
AS
BEGIN 
    DECLARE @RetString varchar(50)
    SET @RetString=''
    IF LEN(@strContent)>6
	BEGIN
		SET @RetString = LEFT(@strContent,6)+'...'
	END
    ELSE
	SET @RetString = @strContent

    RETURN @RetString

END

GO

/*=======================================================================================*/
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

insert cashcard.dbo.j_card(cardid,cardname,sums,crdate,lastdate,crname,comment,start,proposerid,depotid,dbname) 
          values(@cardid,@cardname,@sums,getdate(),getdate(),@crname,@comment,@start,@proposerid,@depotid,@dbname)

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardFillCard' AND type = 'P')
   DROP PROCEDURE Card_jcardFillCard
GO
/*ά����ֵ������*/
/*˵����Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */
CREATE  PROCEDURE Card_jcardFillCard

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@depotid varchar(10),
@userid varchar(20),
@yesnosendcard char(1),
@yesnosendcust char(1),
@dbname varchar(20)

AS

if(@depotid='-')
begin
if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
		and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.[id]
		and a.dbname=@dbname and b.dbname=@dbname
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
	                    	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e ,cashcard.dbo.j_card_state f
	                	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') and a.depotid*=d.depotid
					 and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid  and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c ,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--δ����
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
	                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c ,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                      and isnull(a.depotid,'')='' and a.proposerid='0' 
				and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
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
	                   select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c ,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c ,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'  
				and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--δ����
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c ,j_depot d,j_user e,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c ,j_depot d,j_user e,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
end

end
else
begin
if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 and a.depotid=@depotid
		 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
		and a.dbname=@dbname and b.dbname=@dbname
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
	                    	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') and a.depotid=@depotid
					 and a.depotid*=d.depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' and a.depotid=@depotid 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--δ����
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e ,cashcard.dbo.j_card_state f
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                      and isnull(a.depotid,'')='' and a.proposerid='0' and a.depotid=@depotid 
				and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
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
	                   select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
			and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0' and a.depotid=@depotid
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--δ����
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e ,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e ,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd and a.depotid=@depotid  
			and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
end
end



GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardFillCardCommon' AND type = 'P')
   DROP PROCEDURE Card_jcardFillCardCommon
GO
/*��ͨ�û�ά����ֵ������*/
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE  PROCEDURE Card_jcardFillCardCommon

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@depotid varchar(10),
@userid varchar(20),
@yesnosendcard char(1),
@yesnosendcust char(1),
@dbname varchar(20)

AS

if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
        from      cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
		and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
		and a.dbname=@dbname and b.dbname=@dbname
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
	                    	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                 	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1 
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                    from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--δ����
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                      and isnull(a.depotid,'')='' and a.proposerid='0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
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
	                   select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                   from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--δ����
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
                from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			 and a.dbname=@dbname and b.dbname=@dbname
end


GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardSelectDepotBegEndAllcomm' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectDepotBegEndAllcomm
GO
/*��ͨ�û���ѯ��ֵ������*/
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE  PROCEDURE Card_jcardSelectDepotBegEndAllcomm

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@depotid varchar(10),
@userid varchar(20),
@dbname varchar(20)
AS

if (@cardidBeg ='-' and @cardidEnd='-')
    begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 and a.depotid=@depotid
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
     end
else
     begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 and a.depotid=@depotid
		and a.depotid*=d.depotid and a.crname*=e.userid and cardid>=@cardidBeg and cardid<=@cardidEnd  and a.start*=f.id
		 and a.dbname=@dbname and b.dbname=@dbname
     end

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardSelectDepotBegEndAll' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectDepotBegEndAll
GO
/*����Ա��ѯ��ֵ������*/
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */
CREATE  PROCEDURE Card_jcardSelectDepotBegEndAll

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@depotid varchar(10),
@userid varchar(20),
@dbname varchar(20)
AS

if (@depotid='-'  and @cardidBeg ='-' and @cardidEnd='-')
    begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	 from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 and a.start*=f.id
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.dbname=@dbname and b.dbname=@dbname
     end
else if((@cardidBeg ='-' and @cardidEnd='-') and @depotid <>'-')
    begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
	a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	 from  cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid  and a.depotid=@depotid 
		and c.userid=@userid and a.depotid*=c.depotid and c.access=1  and a.dbname=@dbname and b.dbname=@dbname
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.start*=f.id
     end
else if((@cardidBeg <>'-' or @cardidEnd<>'-') and @depotid='-')
     begin
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	 from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
		and cardid>=@cardidBeg and cardid<=@cardidEnd and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
		  and a.dbname=@dbname and b.dbname=@dbname
     end
else
    begin
	--select a.*,b.names 
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
 	where a.proposerid*=b.proposerid and a.depotid=@depotid and cardid>=@cardidBeg and cardid<=@cardidEnd and a.start*=f.id
		and c.userid=@userid and a.depotid*=c.depotid and c.access=1
		and a.depotid*=d.depotid and a.crname*=e.userid   and a.dbname=@dbname and b.dbname=@dbname
     end

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardSelectDepotBegEnd' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectDepotBegEnd
GO
/*������ȡ��ֵ���б�*/
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */
CREATE PROCEDURE Card_jcardSelectDepotBegEnd

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@used int,
@dbname varchar(20)
AS


SELECT a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment, 
		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names, c.d_name,d.username,e.statename
from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot c,j_user d,cashcard.dbo.j_card_state e
where a.proposerid*=b.proposerid and start=@used and cardid>=@cardidBeg and cardid<=@cardidEnd
		and a.depotid*=c.depotid and a.crname*=d.userid and a.start*=e.id
		and a.dbname=@dbname and a.dbname=@dbname


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jproposerSelect' AND type = 'P')
   DROP PROCEDURE Card_jproposerSelect
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE Card_jproposerSelect
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
	select  a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.d_name 
	from   cashcard.dbo.j_proposer a, sys_depotpower18ql b ,j_depot c
	where  b.userid=@userid and a.depotid=b.depotid
	 	and b.access=1  and a.depotid=c.depotid and a.dbname=@dbname
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from   cashcard.dbo.j_proposer a, sys_depotpower18ql b ,j_depot c
	where a.names=@username  and b.userid=@userid and a.depotid=b.depotid
 	and b.access=1 and a.depotid=c.depotid and a.dbname=@dbname
end




GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'card_jproposerQuerySelect' AND type = 'P')
   DROP PROCEDURE card_jproposerQuerySelect
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE card_jproposerQuerySelect
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
ʱ�䣺2007-7-3
���ܣ���ѯ�ͻ���Ϣ
ԭ��ֻ���ޱ������˲�ѯ
*/
if (@username ='')
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where  b.userid=@userid and a.depotid=b.depotid  and a.dbname=@dbname 
		 	and b.access=1 and a.proposerid*=c.proposerid and a.depotid=d.depotid
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where a.names=@username  and  b.userid=@userid and a.depotid=b.depotid and a.dbname=@dbname
		 	and b.access=1 and a.proposerid*=c.proposerid and a.depotid=d.depotid
end

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jproposerQueryDetilSelect' AND type = 'P')
   DROP PROCEDURE Card_jproposerQueryDetilSelect
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE Card_jproposerQueryDetilSelect
@proposerid int,
@dbname varchar(20)

 AS
   --select * from j_card where proposerid=@proposerid 
   select a.*,b.names,c.statename,e.d_name,d.username 
	from cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,cashcard.dbo.j_card_state c,j_user d,j_depot e
   where a.proposerid*=b.proposerid  and a.proposerid=@proposerid 
	and a.start*=c.id and a.depotid*=e.depotid and a.crname*=d.userid
	and a.dbname=@dbname and b.dbname=@dbname
GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jproposerSelecthis' AND type = 'P')
   DROP PROCEDURE Card_jproposerSelecthis
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE Card_jproposerSelecthis
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
��ʷ�����˵���
2007-07-07
*/
if (@username ='')
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,j_depot c 
	where  b.userid=@userid and a.depotid=b.depotid
	 	and b.access=1 and a.depotid=c.depotid and a.dbname=@dbname
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,j_depot c 
	where a.names=@username  and b.userid=@userid and a.depotid=b.depotid and a.dbname=@dbname
 	and b.access=1 and a.depotid=c.depotid
end

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jproposerQuerySelecthis' AND type = 'P')
   DROP PROCEDURE Card_jproposerQuerySelecthis
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE Card_jproposerQuerySelecthis
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
ʱ�䣺2007-7-7
���ܣ���ѯ�ͻ���Ϣ(��ʷ)
ԭ��ֻ���ޱ������˲�ѯ
*/
if (@username ='')
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where  b.userid=@userid and a.depotid=b.depotid and a.dbname=@dbname
		 	and b.access=1 and a.proposerid*=c.proposerid and a.depotid=d.depotid
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where a.names=@username  and  b.userid=@userid and a.depotid=b.depotid  and a.dbname=@dbname
		 	and b.access=1 and a.proposerid*=c.proposerid and a.depotid=d.depotid
end

GO



IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardSelectLoseUser' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectLoseUser
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE Card_jcardSelectLoseUser

@names varchar(50),
@depotid varchar(10),
@userid varchar(20),
@cardid varchar(50),
@dbname varchar(20)
AS
if(@names ='' and @cardid='')
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 			,b.cardid,b.start,b.sums,d.statename  
             from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid and b.depotid=@depotid and a.dbname=@dbname and b.dbname=@dbname
	           and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
end
else if(@names <>'' and @cardid='')
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 				a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 		,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid and b.depotid=@depotid and a.names=@names and a.dbname=@dbname and b.dbname=@dbname
	and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
end
else if(@names ='' and @cardid<>'')
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 				a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 		,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid and b.depotid=@depotid and b.cardid=@cardid and a.dbname=@dbname and b.dbname=@dbname
	and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 				a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 		,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid and b.depotid=@depotid and b.cardid=@cardid and  a.names=@names
	and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id and a.dbname=@dbname and b.dbname=@dbname
end


GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardSelectLoseUser' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectLoseUser
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE Card_jcardSelectLoseUser

@names varchar(50),
@depotid varchar(10),
@userid varchar(20),
@cardid varchar(50),
@dbname varchar(20)
AS
if(@names ='' and @cardid='')
		begin
			select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 					a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 					,b.cardid,b.start,b.sums,d.statename  
		             from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
			 where a.proposerid=b.proposerid and b.depotid=@depotid and a.dbname=@dbname and b.dbname=@dbname
			           and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
		end
else 
   if(@names <>'' and @cardid='')
	begin
		select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 					a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 			,b.cardid,b.start,b.sums,d.statename 
	              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
		 where a.proposerid=b.proposerid and b.depotid=@depotid and a.names=@names and a.dbname=@dbname and b.dbname=@dbname
		and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
	end
else 
   if(@names ='' and @cardid<>'')
	begin
		select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 					a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 			,b.cardid,b.start,b.sums,d.statename 
	              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
		 where a.proposerid=b.proposerid and b.depotid=@depotid and b.cardid=@cardid and a.dbname=@dbname and b.dbname=@dbname
		and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
	end
else
	begin
		select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 					a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,b.cardid,
	               b.start,b.sums,d.statename 
	              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
		 where a.proposerid=b.proposerid and b.depotid=@depotid and b.cardid=@cardid and  a.names=@names
		and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id and a.dbname=@dbname and b.dbname=@dbname
	end


GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dloggingSelect' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelect
go
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
CREATE PROCEDURE Card_dloggingSelect
@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20)
 AS

/*2007.3.31
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
*/
select a.* from  cashcard.dbo.d_logging a,sys_depotpower18ql b 
where b.userid=@userid and a.depotid=b.depotid and b.access=1  and a.cardid=@cardid
	and a.dbname=@dbname



GO



IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dloggingSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelectDateBegEnd
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */

CREATE PROCEDURE Card_dloggingSelectDateBegEnd

@userid varchar(10),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20)
 AS

/*2007.3.31
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
*/
select a.* from cashcard.dbo.d_logging a,sys_depotpower18ql b 
where  b.userid=@userid and a.depotid=b.depotid and b.access=1  and 
(sure_date between @datebeg and DATEADD(day, 1,@dateend)) and a.dbname=@dbname


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelect' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelect
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */

CREATE PROCEDURE Card_dconsumeSelect

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
2007.3.31
HKM
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼
*/
select a.* from cashcard.dbo.d_consume a,sys_depotpower18ql b 
where b.userid=@userid and a.depotid=b.depotid and b.access=1 and cardid=@cardid
	and a.dbname=@dbname


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelectRetailSub' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelectRetailSub
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */

CREATE PROCEDURE [dbo].[Card_dconsumeSelectRetailSub] 

@consumseid int,
@dbname varchar(20)

AS

/*
2007.3.31
HKM
���ܣ���ѯָ�����ŵ�������ϸ��Ŀ
*/
select b.* from cashcard.dbo.d_consume a, 
(SELECT AA.*,BB.s_name FROM d_Retailsub AA inner join J_style BB on AA.styleid=BB.styleid)b
where a.retailid=b.retailid and a.consumseid=@consumseid and a.dbname=@dbname

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelectDateBegEnd
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */


CREATE PROCEDURE Card_dconsumeSelectDateBegEnd

@userid varchar(10),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20)

 AS
/*
2007.3.31
HKM
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼
*/
select a.*,c.d_name from cashcard.dbo.d_consume a,sys_depotpower18ql b,j_depot c 
where  b.userid=@userid and a.depotid=b.depotid and b.access=1 and (sure_date between @datebeg and DATEADD(day, 1,@dateend))
	and a.dbname=@dbname and a.depotid*=c.depotid


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardCallbackList' AND type = 'P')
   DROP PROCEDURE Card_jcardCallbackList
GO
/*�ջس�ֵ��*/
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE [dbo].[Card_jcardCallbackList] 
@cardidBeg varchar(30),
@cardidEnd varchar(30),
@userid varchar(20),
@callback char(1),
@depotid varchar(10),
@dbname varchar(20)

AS
if (@depotid = '-')
        begin
            if (@cardidBeg = '-' and @cardidEnd = '-' and @callback = '-')
            begin
                 select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname, 
                            a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename 
                            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f  
                            where a.proposerid*=b.proposerid  
                                    and c.userid= @userid and a.depotid*=c.depotid and c.access=1 
                                    and (isnull(a.depotid,'')<>'' and a.proposerid='0'  or a.comment='���ջ�') 
                                   and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id 
                                    and a.dbname=@dbname and b.dbname=@dbname  
            end
            else if (@cardidBeg = '-' and @cardidEnd = '-' and @callback <> '-')
            begin
                if (@callback = '1')
                begin
                    --���ջ�
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                 a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid
                                         and c.userid= @userid and a.depotid*=c.depotid and c.access=1 
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='���ջ�'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id 
                                         and a.dbname=@dbname and b.dbname=@dbname 
                end
                else
                begin
                    --δ�ջ�
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                where a.proposerid*=b.proposerid  
                                        and c.userid= @userid and a.depotid=c.depotid and c.access=1 
                                        and isnull(a.depotid,'')<>'' and a.proposerid='0'  
                                       and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                         and a.dbname=@dbname and b.dbname=@dbname  
                end

            end
            else if ((@cardidBeg <> '-' or @cardidEnd <> '-') and @callback <> '-')
            begin
                if (@callback = '1')
                begin
                    --���ջ�
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                 a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd
                                         and c.userid= @userid and a.depotid=c.depotid and c.access=1 
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='���ջ�'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --δ�ջ�
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c ,j_depot d,j_user e,cashcard.dbo.j_card_state f
                                where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd 
                                        and c.userid= @userid and a.depotid=c.depotid and c.access=1 
                                        and isnull(a.depotid,'')<>'' and a.proposerid='0'  
                                       and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
            end
            else
            begin
                  select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                           a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                           from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                           where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd 
                                   and c.userid= @userid and a.depotid*=c.depotid and c.access=1 
                                  and (isnull(a.depotid,'')<>'' and a.proposerid='0')   
                                 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
            end
        end
        else
        begin
            if (@cardidBeg = '-' and @cardidEnd = '-' and @callback = '-')
            begin
                 select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                            a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                            where a.proposerid*=b.proposerid and a.depotid=@depotid 
                                    and c.userid= @userid and a.depotid*=c.depotid and c.access=1 
                                    and (isnull(a.depotid,'')<>'' and a.proposerid='0'  or a.comment='���ջ�') 
                                   and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
            end
            else if (@cardidBeg = '-' and @cardidEnd = '-' and @callback <> '-')
            begin
                if (@callback = '1')
                begin
                    --���ջ�
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                 a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid  and a.depotid=@depotid 
                                         and c.userid= @userid and a.depotid*=c.depotid and c.access=1 
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='���ջ�'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --δ�ջ�
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                where a.proposerid*=b.proposerid  and a.depotid=@depotid   
                                        and c.userid= @userid and a.depotid=c.depotid and c.access=1 
                                        and isnull(a.depotid,'')<>'' and a.proposerid='0'  
                                       and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end

            end
            else if ((@cardidBeg <> '-' or @cardidEnd <> '-') and @callback <> '-')
            begin
                if (@callback = '1')
                begin
                    --���ջ�
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                 a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd
                                         and c.userid= @userid and a.depotid=c.depotid and c.access=1 
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='���ջ�'  and a.depotid=@depotid   
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --δ�ջ�
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd 
                                        and c.userid= @userid and a.depotid=c.depotid and c.access=1 
                                        and isnull(a.depotid,'')<>'' and a.proposerid='0'  and a.depotid=@depotid   
                                       and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
            end
            else
            begin
                  select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                           a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                           from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                           where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd 
                                   and c.userid= @userid and a.depotid*=c.depotid and c.access=1 
                                  and (isnull(a.depotid,'')<>'' and a.proposerid='0')  and a.depotid=@depotid   
                                 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
            end
        end

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardCongealnotList' AND type = 'P')
   DROP PROCEDURE Card_jcardCongealnotList
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */
/*��ѯ������ⶳ��¼*/
CREATE PROCEDURE [dbo].[Card_jcardCongealnotList] 
@cardid varchar(30),
@userid varchar(20),
@congealstate char(1),
@dbname varchar(20)

AS
 	if (@congealstate ='-' and @cardid ='-')
        begin
    		select a.*,b.names,d.statename,e.username,f.d_name 
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,cashcard.dbo.j_card_state d,j_user e,j_depot f   
                where a.proposerid=b.proposerid 
                     and (start=2 or start=1) and a.proposerid<>0 and a.depotid=c.depotid and c.access=1 and c.userid=@userid 
                      and isnull(congeal,'')<>'' and a.start*=d.id and a.depotid*=f.depotid and a.crname*=e.userid 
                       and a.dbname=@dbname and b.dbname=@dbname --and sums<=0
        end
        else if (@congealstate <>'-' and @cardid ='-')
	begin
    		select a.*,b.names,d.statename,e.username,f.d_name 
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,cashcard.dbo.j_card_state d,j_user e,j_depot f   
                where a.proposerid=b.proposerid 
                     and (start=2 or start=1) and a.proposerid<>0 and a.depotid=c.depotid and c.access=1 and c.userid=@userid 
                     and isnull(congeal,'')<>'' and congeal= @congealstate and a.start*=d.id and a.depotid*=f.depotid and a.crname*=e.userid 
                       and a.dbname=@dbname and b.dbname=@dbname  --and sums<=0 
        end
        else if (@congealstate ='-' and @cardid <>'-')
        begin
    		select a.*,b.names,d.statename,e.username,f.d_name 
               from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,cashcard.dbo.j_card_state d,j_user e,j_depot f   
               where a.proposerid=b.proposerid 
                    and (start=2 or start=1) and a.proposerid<>0 and a.depotid=c.depotid and c.access=1 and c.userid=@userid 
                     and isnull(congeal,'')<>'' and a.cardid= @cardid  and a.start*=d.id and a.depotid*=f.depotid and a.crname*=e.userid 
                      and a.dbname=@dbname and b.dbname=@dbname --and sums<=0
        end
        else
        begin
    		select a.*,b.names,d.statename,e.username,f.d_name 
               from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,cashcard.dbo.j_card_state d,j_user e,j_depot f  
               where a.proposerid=b.proposerid 
                    and (start=2 or start=1) and a.proposerid<>0 and a.depotid=c.depotid and c.access=1 and c.userid=@userid 
                     and isnull(congeal,'')<>'' and a.cardid= @cardid and congeal= @congealstate and a.start*=d.id and a.depotid*=f.depotid and a.crname*=e.userid 
                      and a.dbname=@dbname and b.dbname=@dbname --and sums<=0
        end

GO




-------------------------2007-07-31 zcy���ڶ��β����޸ĵ�---------------
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_Getshoplist' AND type = 'P')
   DROP PROCEDURE Card_Getshoplist
GO

/*����:2007-07-31*/
/* write by dpipi */
/*2007-07-30 zcy�޸� ���������Ʋ�ѯʱ��ģ����ѯ����һ��Ҫ�ӵ�һ����ʼƥ�䣩*/
create  procedure Card_Getshoplist
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
		                                        and j_depot.d_name like '%' + @shopnum + '%' 
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


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_User_dloggingSelectDate' AND type = 'P')
   DROP PROCEDURE Card_User_dloggingSelectDate
GO

CREATE PROCEDURE [dbo].[Card_User_dloggingSelectDate]

@cardid varchar(30),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20)
AS

/*2007.7.31
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
*/

select a.*,b.d_name from cashcard.dbo.d_logging a,j_depot b
where cardid=@cardid  and (sure_date between @datebeg and DATEADD(day, 1,@dateend))
	and dbname=@dbname and a.depotid*=b.depotid

GO




IF EXISTS (SELECT name FROM sysobjects 
      WHERE name = 'Card_User_dconsumeSelect' AND type = 'P')
   DROP PROCEDURE Card_User_dconsumeSelect
GO
/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-31*/
/*write by zcy */
/*�˿Ͱ����ڲ�ѯ�����Ѽ�¼*/

CREATE PROCEDURE Card_User_dconsumeSelect
@cardid varchar(30),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20)

 AS
/*
2007.7.31
HKM
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼
*/
select a.*,b.d_name from cashcard.dbo.d_consume a,j_depot b 
where  (sure_date between @datebeg and DATEADD(day, 1,@dateend))
	and a.dbname=@dbname and a.depotid*=b.depotid and a.cardid=@cardid


GO






IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_cardBatCongeal' AND type = 'P')
   DROP PROCEDURE Card_cardBatCongeal
GO

/*���ܣ���������Ϊ0����ʱ��*/
/*date:2007-11-20*/
/*write by zcy */

/*���������ֵ��(һ��ʱ��δ�����ҿ����<=0)*/
CREATE PROCEDURE  Card_cardBatCongeal
@dbname varchar(20)
AS
--�õ�δ��������
DECLARE @monthnum int
select @monthnum=monthnum from cashcard.dbo.j_setnotconsumetime  where dbname=@dbname

--����һ����ʱ��@tmptab(��û��δ��ֵ�ļ�¼)
DECLARE @tmptab table(cardid varchar(50))

    
insert into  @tmptab(cardid) select cardid  from d_logging  
 group by cardid
having datediff(month,max(sure_date),getdate())>=@monthnum 
--select * from @tmptab
--���������ֵ��(1��ʾ���� 0��ʾ������)
UPDATE a SET congeal=1,start=2  
FROM  cashcard.dbo.j_card a INNER JOIN @tmptab b ON a.cardid=b.cardid
 
WHERE a.sums<=0  and a.dbname=@dbname


GO



