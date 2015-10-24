IF EXISTS (SELECT name FROM sysobjects
      WHERE name = 'Card_cardBatCongeal' AND type = 'P')
   DROP PROCEDURE Card_cardBatCongeal
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*最后修改日期:2007-07-27 增加类型以区分是消费还是扣年费 1消费 2扣取年费*/

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
     WHERE datediff(month,sure_date,getdate())>=@monthnum and comment='扣取年费' and dbname=@dbname and dtype='2'

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
      --select @num=count(*) from (SELECT A.*,B.s_name FROM d_Retailsub A inner join J_style B on A.styleid=B.styleid)as view_d_retailsub where vipcardid=@strcardid and crdate>=@deductdate 
      select @num=count(*) from cashcard.dbo.d_consume where cardid=@strcardid and crdate>=@deductdate 
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
--批量冻结充值卡(start 2表示冻结 congeal 1表示冻结 0表示不冻结)
UPDATE a SET congeal=1,start=2,lastdate=getdate()  
FROM  cashcard.dbo.j_card a INNER JOIN @tmptab b ON a.cardid=b.cardid
WHERE a.sums<=0  and a.dbname=@dbname



GO



IF EXISTS (SELECT name FROM sysobjects
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
		and a.depotid*=d.depotid and a.depotid=@depotid and a.crname*=e.userid and a.start*=f.id
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
					and a.depotid*=d.depotid and a.depotid=@depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --发至店铺未发给顾客1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                    from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and  c.access=1
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
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
                from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			 and a.dbname=@dbname and b.dbname=@dbname
end



GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardSelectLoseUser' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectLoseUser
GO

/*挂失解挂List*/
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
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 			,b.addcardid,b.cardid,b.start,b.sums,d.statename  
        from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,cashcard.dbo.j_card_state d
	where a.proposerid=b.proposerid  and a.dbname=@dbname and b.dbname=@dbname
	        and b.start*=d.id
end
else if(@names <>'' and @cardid='')
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 				a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 		,b.addcardid,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid  and a.names=@names and a.dbname=@dbname and b.dbname=@dbname
		 and b.start*=d.id
end
else if(@names ='' and @cardid<>'')
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 				a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 		,b.addcardid,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid  and b.cardid=@cardid and a.dbname=@dbname and b.dbname=@dbname
		 and b.start*=d.id
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 				a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,b.addcardid,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid  and b.cardid=@cardid and  a.names=@names
		 and b.start*=d.id and a.dbname=@dbname and b.dbname=@dbname
end



GO



IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dloggingSelect' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelect
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23修改:操作员店铺为空时可以有店铺选择功能查询卡充值记录*/

CREATE PROCEDURE Card_dloggingSelect

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(20)
 AS

/*2007.3.31
hkm
功能:查询限定店铺范围内的客户充值记录
*/
if(@depotid = '-' and @cardid = '-')
begin
	select a.*,b.d_name from  cashcard.dbo.d_logging a,j_depot b
	where  a.dbname=@dbname and a.depotid*=b.depotid
end

else if(@depotid = '-' and @cardid <> '-')
begin
	select a.*,b.d_name from  cashcard.dbo.d_logging a,j_depot b
	where  a.dbname=@dbname and a.cardid=@cardid and a.depotid*=b.depotid
end
else if(@depotid <> '-' and @cardid = '-')
begin
	select a.*,b.d_name from  cashcard.dbo.d_logging a,j_depot b
	where  a.dbname=@dbname and a.depotid=@depotid
end
else
begin
	select a.*,b.d_name from  cashcard.dbo.d_logging a,j_depot b
	where  a.dbname=@dbname and a.depotid=@depotid and a.cardid=@cardid and a.depotid*=b.depotid
end

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dloggingSelectCommon' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelectCommon
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23修改:店员查询卡充值记录*/

CREATE PROCEDURE Card_dloggingSelectCommon

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(20)
 AS

/*2007.3.31
hkm
功能:查询限定店铺范围内的客户充值记录
*/
if(@cardid = '-')
begin
	select a.*,b.d_name from  cashcard.dbo.d_logging a,j_depot b
	where  a.dbname=@dbname  and a.depotid=@depotid and a.depotid*=b.depotid
end 
else
begin
	select a.*,b.d_name from  cashcard.dbo.d_logging a,j_depot b
	where  a.dbname=@dbname and a.cardid=@cardid and a.depotid*=b.depotid
end
	

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dloggingSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelectDateBegEnd
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23修改:操作员店铺为空时按日期可以有店铺选择功能查询卡充值记录*/

CREATE PROCEDURE Card_dloggingSelectDateBegEnd

@userid varchar(10),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20),
@depotid varchar(20)
 AS

/*2007.3.31
hkm
功能:查询限定店铺范围内的客户充值记录
*/
if(@depotid = '-')
begin
	select a.*,b.d_name from cashcard.dbo.d_logging a,j_depot b
	where (sure_date between @datebeg and DATEADD(day, 1,@dateend)) 
		and a.dbname=@dbname and a.depotid*=b.depotid
end
else
begin
	select a.*,b.d_name from cashcard.dbo.d_logging a,j_depot b
	where (sure_date between @datebeg and DATEADD(day, 1,@dateend)) 
		and a.dbname=@dbname
		and a.depotid=@depotid and a.depotid*=b.depotid
end




GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dloggingSelectDateBegEndComm' AND type = 'P')
   DROP PROCEDURE Card_dloggingSelectDateBegEndComm
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23修改:店员按日期查询卡充值记录*/

CREATE PROCEDURE Card_dloggingSelectDateBegEndComm

@userid varchar(10),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20),
@depotid varchar(20)
 AS

/*2007.3.31
hkm
功能:查询限定店铺范围内的客户充值记录
*/
select a.*,b.d_name from cashcard.dbo.d_logging a,j_depot b
where (sure_date between @datebeg and DATEADD(day, 1,@dateend)) 
	and a.dbname=@dbname
	and a.depotid=@depotid and a.depotid*=b.depotid

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelect' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelect
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23修改:操作员店铺为空时可以有店铺选择功能查询卡消费记录*/

CREATE PROCEDURE Card_dconsumeSelect

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(20)

 AS
/*
2007.3.31
HKM
功能：查询限定店铺范围内客户的消息记录 
*/
if(@depotid = '-' and @cardid = '-')
begin
	select a.*,b.d_name from cashcard.dbo.d_consume a,j_depot b
	where  a.dbname=@dbname and a.depotid*=b.depotid
end
else if(@depotid <> '-' and @cardid = '-')
begin
	select a.*,b.d_name from cashcard.dbo.d_consume a,j_depot b
	where  a.dbname=@dbname and a.depotid=@depotid and a.depotid*=b.depotid
end
else if(@depotid = '-' and @cardid <> '-')
begin
	select a.*,b.d_name from cashcard.dbo.d_consume a,j_depot b
	where  a.dbname=@dbname and a.cardid=@cardid and a.depotid*=b.depotid
end
else
begin
	select a.*,b.d_name from cashcard.dbo.d_consume a,j_depot b
	where  a.dbname=@dbname and a.cardid=@cardid and a.depotid=@depotid and a.depotid*=b.depotid
end

GO

IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelectCommon' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelectCommon
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23修改:店员查询卡消费记录*/

CREATE PROCEDURE Card_dconsumeSelectCommon

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(20)

 AS
/*
2007.3.31
HKM
功能：查询限定店铺范围内客户的消息记录 
*/
if(@cardid = '-')
begin
	select a.*,b.d_name from cashcard.dbo.d_consume a,j_depot b
	where  a.dbname=@dbname and a.depotid=@depotid and a.depotid*=b.depotid
end
else
begin
	select a.*,b.d_name from cashcard.dbo.d_consume a,j_depot b
	where  a.dbname=@dbname and  a.cardid=@cardid and a.depotid*=b.depotid
end


GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelectDateBegEnd' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelectDateBegEnd
GO


/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23修改:操作员店铺为空时可以有店铺选择功能按日期查询卡消费记录*/

CREATE PROCEDURE Card_dconsumeSelectDateBegEnd

@userid varchar(10),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20),
@depotid varchar(20)

 AS
/*
2007.3.31
HKM
功能：查询限定店铺范围内客户的消息记录
*/
if(@depotid = '-')
begin
	select a.*,c.d_name from cashcard.dbo.d_consume a,j_depot c 
	where  (sure_date between @datebeg and DATEADD(day, 1,@dateend))
		and a.dbname=@dbname and a.depotid*=c.depotid
end
else
begin
	select a.*,c.d_name from cashcard.dbo.d_consume a,j_depot c 
	where  (sure_date between @datebeg and DATEADD(day, 1,@dateend))
		and a.dbname=@dbname and a.depotid*=c.depotid and a.depotid=@depotid
end

GO


IF EXISTS(SELECT name FROM sysobjects
      WHERE name = 'Card_dconsumeSelectDateBegEndcomm' AND type = 'P')
   DROP PROCEDURE Card_dconsumeSelectDateBegEndcomm
GO


/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23修改:店员按日期查询卡消费记录*/

CREATE PROCEDURE Card_dconsumeSelectDateBegEndcomm

@userid varchar(10),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20),
@depotid varchar(20)

 AS
/*
2007.3.31
HKM
功能：查询限定店铺范围内客户的消息记录
*/
select a.*,c.d_name from cashcard.dbo.d_consume a,j_depot c 
where  (sure_date between @datebeg and DATEADD(day, 1,@dateend))
	and a.dbname=@dbname and a.depotid*=c.depotid
	and a.depotid=@depotid

GO



IF EXISTS (SELECT name FROM sysobjects
      WHERE name = 'Card_jcardCongealnotList' AND type = 'P')
   DROP PROCEDURE Card_jcardCongealnotList
GO

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*查询卡冻结解冻记录*/
/*最后修改时间:2007-07-27 增加日期范围查询*/
CREATE PROCEDURE Card_jcardCongealnotList 
@cardid varchar(30),
@userid varchar(20),
@congealstate char(1),
@dbname varchar(20),
@startdate varchar(30),
@enddate varchar(30)

AS
if(@startdate = '1900-01-01' or @enddate='1900-01-01')
begin
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
end
else
begin
 	if (@congealstate ='-' and @cardid ='-')
        begin
    		select a.*,b.names,d.statename,e.username,f.d_name 
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,cashcard.dbo.j_card_state d,j_user e,j_depot f   
                where a.proposerid=b.proposerid 
                     and (start=2 or start=1) and a.proposerid<>0 and a.depotid=c.depotid and c.access=1 and c.userid=@userid 
                      and isnull(congeal,'')<>'' and a.start*=d.id and a.depotid*=f.depotid and a.crname*=e.userid 
                       and a.dbname=@dbname and b.dbname=@dbname and convert(char(10),a.lastdate,126) between @startdate and @enddate --and sums<=0
        end
        else if (@congealstate <>'-' and @cardid ='-')
	begin
    		select a.*,b.names,d.statename,e.username,f.d_name 
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,cashcard.dbo.j_card_state d,j_user e,j_depot f   
                where a.proposerid=b.proposerid 
                     and (start=2 or start=1) and a.proposerid<>0 and a.depotid=c.depotid and c.access=1 and c.userid=@userid 
                     and isnull(congeal,'')<>'' and congeal= @congealstate and a.start*=d.id and a.depotid*=f.depotid and a.crname*=e.userid 
                       and a.dbname=@dbname and b.dbname=@dbname and convert(char(10),a.lastdate,126) between @startdate and @enddate  --and sums<=0 
        end
        else if (@congealstate ='-' and @cardid <>'-')
        begin
    		select a.*,b.names,d.statename,e.username,f.d_name 
               from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,cashcard.dbo.j_card_state d,j_user e,j_depot f   
               where a.proposerid=b.proposerid 
                    and (start=2 or start=1) and a.proposerid<>0 and a.depotid=c.depotid and c.access=1 and c.userid=@userid 
                     and isnull(congeal,'')<>'' and a.cardid= @cardid  and a.start*=d.id and a.depotid*=f.depotid and a.crname*=e.userid 
                      and a.dbname=@dbname and b.dbname=@dbname and convert(char(10),a.lastdate,126) between @startdate and @enddate --and sums<=0
        end
        else
        begin
    		select a.*,b.names,d.statename,e.username,f.d_name 
               from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c,cashcard.dbo.j_card_state d,j_user e,j_depot f  
               where a.proposerid=b.proposerid 
                    and (start=2 or start=1) and a.proposerid<>0 and a.depotid=c.depotid and c.access=1 and c.userid=@userid 
                     and isnull(congeal,'')<>'' and a.cardid= @cardid and congeal= @congealstate and a.start*=d.id and a.depotid*=f.depotid and a.crname*=e.userid 
                      and a.dbname=@dbname and b.dbname=@dbname and convert(char(10),a.lastdate,126) between @startdate and @enddate --and sums<=0
        end
end

GO
