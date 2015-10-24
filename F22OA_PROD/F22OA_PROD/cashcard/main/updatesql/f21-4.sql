IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_cardBatCongeal' AND type = 'P')
   DROP PROCEDURE Card_cardBatCongeal
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */

/*批量冻结充值卡(一定时期未消费且卡金额<=0)*/
CREATE PROCEDURE  Card_cardBatCongeal
@dbname varchar(20)
AS
--得到未消费月数
DECLARE @monthnum int
select @monthnum=monthnum from cashcard.dbo.j_setnotconsumetime  where dbname=@dbname
--声明一个临时表@tmptab(用于存放按扣年费日期后该卡没有消费的记录)
DECLARE @tmptab table(cardid varchar(50))
--声明一游标
DECLARE tcardid_cursor CURSOR
FOR
     SELECT cardid,sure_date
     FROM  cashcard.dbo.d_consume  
     WHERE datediff(month,sure_date,getdate())>=@monthnum and comment='扣取年费' and dbname=@dbname

OPEN tcardid_cursor
--变量@strcardid与@deductdate分别用于存放'卡号'和'扣年费日期'
DECLARE @strcardid varchar(50),@deductdate datetime 

FETCH NEXT FROM tcardid_cursor INTO @strcardid,@deductdate

WHILE (@@FETCH_STATUS <> -1)
BEGIN
   IF (@@FETCH_STATUS <> -2)
   BEGIN
      /*如果@num=0则表示扣年费后一定时期未消费,则插入表@tmptab*/
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
--批量冻结充值卡(1表示冻结 0表示不冻结)
UPDATE a SET congeal=1,start=2  
FROM  cashcard.dbo.j_card a INNER JOIN @tmptab b ON a.cardid=b.cardid
WHERE a.sums<=0  and a.dbname=@dbname


GO
/************************************************/


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'ReturnStrIntercept' AND type = 'FN')
   DROP function ReturnStrIntercept
GO
 
/*字符串截取函数(多余字符用...代替)*/
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


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'jcardinsert' AND type = 'P')
   DROP PROCEDURE jcardinsert
GO
/*建立充值卡档案*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by dpipi */
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
/*维护充值卡档案*/
/*说明：为增加区别数据库字段*/
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
            --已发卡
            if (@yesnosendcard = '1')
            begin
                --是否发至顾客
                if (@yesnosendcust = '-')
	                begin
	                    --不限-
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
	                    --发至店铺未发给顾客1
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
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c ,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
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
            --已发卡
            if (@yesnosendcard = '1')
            begin
                --是否发至顾客
                if (@yesnosendcust ='-')
	                begin
	                    --不限-
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
                    --发至店铺未发给顾客1
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
	                    --已发给顾客2
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
            begin--未发卡
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
            --已发卡
            if (@yesnosendcard = '1')
            begin
                --是否发至顾客
                if (@yesnosendcust = '-')
	                begin
	                    --不限-
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
	                    --发至店铺未发给顾客1
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
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
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
            --已发卡
            if (@yesnosendcard = '1')
            begin
                --是否发至顾客
                if (@yesnosendcust ='-')
	                begin
	                    --不限-
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
                    --发至店铺未发给顾客1
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
	                    --已发给顾客2
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
            begin--未发卡
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
/*普通用户维护充值卡档案*/
/*功能：为增加区别数据库字段*/
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
            --已发卡
            if (@yesnosendcard = '1')
            begin
                --是否发至顾客
                if (@yesnosendcust = '-')
	                begin
	                    --不限-
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
	                    --发至店铺未发给顾客1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                    from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
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
            --已发卡
            if (@yesnosendcard = '1')
            begin
                --是否发至顾客
                if (@yesnosendcust ='-')
	                begin
	                    --不限-
	                   select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                   from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
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
/*普通用户查询充值卡档案*/
/*功能：为增加区别数据库字段*/
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
/*管理员查询充值卡档案*/
/*功能：为增加区别数据库字段*/
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
/*店铺领取充值卡列表*/
/*功能：为增加区别数据库字段*/
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

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE Card_jproposerSelect
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
时间：2007-3-14
创建人：HKM
功能：查询客户信息,
修改2007.4.1
原因：只可限本店铺人查询
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

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE card_jproposerQuerySelect
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
时间：2007-7-3
功能：查询客户信息
原因：只可限本店铺人查询
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

/*功能：为增加区别数据库字段*/
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

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE Card_jproposerSelecthis
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
历史建立人档案
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

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE Card_jproposerQuerySelecthis
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
时间：2007-7-7
功能：查询客户信息(历史)
原因：只可限本店铺人查询
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

/*功能：为增加区别数据库字段*/
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

/*功能：为增加区别数据库字段*/
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
      WHERE name = 'Card_dloggingSelect' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelect
go
/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
CREATE PROCEDURE Card_dloggingSelect

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20)
 AS

/*2007.3.31
hkm
功能:查询限定店铺范围内的客户充值记录
*/
select a.* from  cashcard.dbo.d_logging a,sys_depotpower18ql b 
where b.userid=@userid and a.depotid=b.depotid and b.access=1  and a.cardid=@cardid
	and a.dbname=@dbname



GO



IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dloggingSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelectDateBegEnd
GO

/*功能：为增加区别数据库字段*/
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
功能:查询限定店铺范围内的客户充值记录
*/
select a.* from cashcard.dbo.d_logging a,sys_depotpower18ql b 
where  b.userid=@userid and a.depotid=b.depotid and b.access=1  and 
(sure_date between @datebeg and DATEADD(day, 1,@dateend)) and a.dbname=@dbname


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelect' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelect
GO

/*功能：为增加区别数据库字段*/
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
功能：查询限定店铺范围内客户的消息记录
*/
select a.* from cashcard.dbo.d_consume a,sys_depotpower18ql b 
where b.userid=@userid and a.depotid=b.depotid and b.access=1 and cardid=@cardid
	and a.dbname=@dbname


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelectRetailSub' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelectRetailSub
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */

CREATE PROCEDURE [dbo].[Card_dconsumeSelectRetailSub] 

@consumseid int,
@dbname varchar(20)

AS

/*
2007.3.31
HKM
功能：查询指定卡号的消费明细项目
*/
select b.* from cashcard.dbo.d_consume a, 
(SELECT AA.*,BB.s_name FROM d_Retailsub AA inner join J_style BB on AA.styleid=BB.styleid)b
where a.retailid=b.retailid and a.consumseid=@consumseid and a.dbname=@dbname

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelectDateBegEnd
GO

/*功能：为增加区别数据库字段*/
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
功能：查询限定店铺范围内客户的消息记录
*/
select a.*,c.d_name from cashcard.dbo.d_consume a,sys_depotpower18ql b,j_depot c 
where  b.userid=@userid and a.depotid=b.depotid and b.access=1 and (sure_date between @datebeg and DATEADD(day, 1,@dateend))
	and a.dbname=@dbname and a.depotid*=c.depotid


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_jcardCallbackList' AND type = 'P')
   DROP PROCEDURE Card_jcardCallbackList
GO
/*收回充值卡*/
/*功能：为增加区别数据库字段*/
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
                                    and (isnull(a.depotid,'')<>'' and a.proposerid='0'  or a.comment='已收回') 
                                   and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id 
                                    and a.dbname=@dbname and b.dbname=@dbname  
            end
            else if (@cardidBeg = '-' and @cardidEnd = '-' and @callback <> '-')
            begin
                if (@callback = '1')
                begin
                    --已收回
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                 a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid
                                         and c.userid= @userid and a.depotid*=c.depotid and c.access=1 
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='已收回'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id 
                                         and a.dbname=@dbname and b.dbname=@dbname 
                end
                else
                begin
                    --未收回
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
                    --已收回
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                 a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd
                                         and c.userid= @userid and a.depotid=c.depotid and c.access=1 
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='已收回'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --未收回
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
                                    and (isnull(a.depotid,'')<>'' and a.proposerid='0'  or a.comment='已收回') 
                                   and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
            end
            else if (@cardidBeg = '-' and @cardidEnd = '-' and @callback <> '-')
            begin
                if (@callback = '1')
                begin
                    --已收回
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                 a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid  and a.depotid=@depotid 
                                         and c.userid= @userid and a.depotid*=c.depotid and c.access=1 
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='已收回'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --未收回
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
                    --已收回
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                 a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd
                                         and c.userid= @userid and a.depotid=c.depotid and c.access=1 
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='已收回'  and a.depotid=@depotid   
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --未收回
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

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*查询卡冻结解冻记录*/
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









