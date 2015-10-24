IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'ReturnStrIntercept' AND type = 'FN')
   DROP FUNCTION ReturnStrIntercept
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
go

if exists (select 1
          from sysobjects
          where name = 'Card_cardBatCongeal'
          and type = 'P')
   drop procedure Card_cardBatCongeal
go


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


if exists (select 1
          from sysobjects
          where name = 'Card_Getshoplist'
          and type = 'P')
   drop procedure Card_Getshoplist
go

/*日期:2007-07-09*/
/* write by dpipi */
/*2007-07-30修改 按店铺名称查询时按模糊查询（不一定要从第一个开始匹配）*/
create  procedure Card_Getshoplist
@userid varchar(20),
@shopnum varchar(50),
@type varchar(50)
as
begin
     --如果店铺编号不填，为搜索所有的店铺
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

if exists (select 1
          from sysobjects
          where name = 'Card_User_dconsumeSelect'
          and type = 'P')
   drop procedure Card_User_dconsumeSelect
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-31*/
/*write by zcy */
/*顾客按日期查询卡消费记录*/

CREATE PROCEDURE Card_User_dconsumeSelect
@cardid varchar(30),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20)

 AS
/*
2007.3.31
HKM
功能：查询限定店铺范围内客户的消息记录
*/
select a.*,b.d_name from cashcard.dbo.d_consume a,j_depot b 
where  (sure_date between @datebeg and DATEADD(day, 1,@dateend))
	and a.dbname=@dbname and a.depotid*=b.depotid and a.cardid=@cardid



GO

if exists (select 1
          from sysobjects
          where name = 'Card_User_dloggingSelectDate'
          and type = 'P')
   drop procedure Card_User_dloggingSelectDate
go

CREATE PROCEDURE dbo.Card_User_dloggingSelectDate

@cardid varchar(30),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20)
AS

/*2007.3.31
hkm
功能:查询限定店铺范围内的客户充值记录
*/

select a.*,b.d_name from cashcard.dbo.d_logging a,j_depot b
where cardid=@cardid  and (sure_date between @datebeg and DATEADD(day, 1,@dateend))
	and dbname=@dbname and a.depotid*=b.depotid


GO


if exists (select 1
          from sysobjects
          where name = 'Card_dconsumeSelect'
          and type = 'P')
   drop procedure Card_dconsumeSelect
go

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

if exists (select 1
          from sysobjects
          where name = 'Card_dconsumeSelectCommon'
          and type = 'P')
   drop procedure Card_dconsumeSelectCommon
go


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

if exists (select 1
          from sysobjects
          where name = 'Card_dconsumeSelectDateBegEnd'
          and type = 'P')
   drop procedure Card_dconsumeSelectDateBegEnd
go

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

if exists (select 1
          from sysobjects
          where name = 'Card_dconsumeSelectDateBegEndcomm'
          and type = 'P')
   drop procedure Card_dconsumeSelectDateBegEndcomm
go


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

if exists (select 1
          from sysobjects
          where name = 'Card_dconsumeSelectRetailSub'
          and type = 'P')
   drop procedure Card_dconsumeSelectRetailSub
go


/*功能：为增加区别数据库字段*/
/*date:2007-07-19*/
/*write by zcy */

CREATE PROCEDURE dbo.Card_dconsumeSelectRetailSub 

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

if exists (select 1
          from sysobjects
          where name = 'Card_dloggingSelect'
          and type = 'P')
   drop procedure Card_dloggingSelect
go

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
	where  a.dbname=@dbname and a.depotid=@depotid and a.depotid*=b.depotid
end
else
begin
	select a.*,b.d_name from  cashcard.dbo.d_logging a,j_depot b
	where  a.dbname=@dbname and a.depotid=@depotid and a.cardid=@cardid and a.depotid*=b.depotid
end



GO


if exists (select 1
          from sysobjects
          where name = 'Card_dloggingSelectCommon'
          and type = 'P')
   drop procedure Card_dloggingSelectCommon
go



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


if exists (select 1
          from sysobjects
          where name = 'Card_dloggingSelectDateBegEnd'
          and type = 'P')
   drop procedure Card_dloggingSelectDateBegEnd
go


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


if exists (select 1
          from sysobjects
          where name = 'Card_dloggingSelectDateBegEndComm'
          and type = 'P')
   drop procedure Card_dloggingSelectDateBegEndComm
go


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

if exists (select 1
          from sysobjects
          where name = 'Card_jcardCallbackList'
          and type = 'P')
   drop procedure Card_jcardCallbackList
go

/*收回充值卡*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

CREATE PROCEDURE Card_jcardCallbackList
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
                            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f  
                            where a.proposerid*=b.proposerid  
                                     
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
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid
                                          
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='已收回'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id 
                                         and a.dbname=@dbname and b.dbname=@dbname 
                end
                else
                begin
                    --未收回
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                where a.proposerid*=b.proposerid  
                                         
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
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd
                                          
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='已收回'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --未收回
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f
                                where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd 
                                         
                                        and isnull(a.depotid,'')<>'' and a.proposerid='0'  
                                       and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
            end
            else
            begin
                  select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                           a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                           from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                           where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd 
                                    
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
                            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                            where a.proposerid*=b.proposerid and a.depotid=@depotid 
                                     
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
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid  and a.depotid=@depotid 
                                          
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='已收回'  
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --未收回
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                where a.proposerid*=b.proposerid  and a.depotid=@depotid   
                                         
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
                                 from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                 where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd
                                          
                                         and isnull(a.depotid,'')='' and a.proposerid='0' and a.comment='已收回'  and a.depotid=@depotid   
                                        and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
                else
                begin
                    --未收回
                     select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                                a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                                where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd 
                                         
                                        and isnull(a.depotid,'')<>'' and a.proposerid='0'  and a.depotid=@depotid   
                                       and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
                end
            end
            else
            begin
                  select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
                           a.depotid,a.crdate,a.lastdate,d.d_name,e.username,f.statename
                           from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                           where a.proposerid*=b.proposerid and  cardid>= @cardidBeg and cardid<= @cardidEnd 
                                    
                                  and (isnull(a.depotid,'')<>'' and a.proposerid='0')  and a.depotid=@depotid   
                                 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
                                    and a.dbname=@dbname and b.dbname=@dbname  
            end
        end




GO

if exists (select 1
          from sysobjects
          where name = 'Card_jcardCallbackList_back'
          and type = 'P')
   drop procedure Card_jcardCallbackList_back
go

/*收回充值卡*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE dbo.Card_jcardCallbackList_back 
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


if exists (select 1
          from sysobjects
          where name = 'Card_jcardCongealnotList'
          and type = 'P')
   drop procedure Card_jcardCongealnotList
go

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
if(@startdate = '-' or @enddate='-')
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

if exists (select 1
          from sysobjects
          where name = 'Card_jcardFillCard'
          and type = 'P')
   drop procedure Card_jcardFillCard
go


/*维护充值卡档案*/
/*说明：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/
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
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
        where a.proposerid*=b.proposerid  
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e ,cashcard.dbo.j_card_state f
	                	where a.proposerid*=b.proposerid  
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') and a.depotid*=d.depotid
					 and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --发至店铺未发给顾客1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid 
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid  and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid 
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
	                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                where a.proposerid*=b.proposerid 
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid 
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid 
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid  
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'  
				and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid  
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid 
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
end

end
else
begin
if(@cardidBeg = '-' and @cardidEnd = '-' and @yesnosendcard = '-')
begin 
	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
        where a.proposerid*=b.proposerid  and a.depotid=@depotid
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                	where a.proposerid*=b.proposerid  
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') and a.depotid=@depotid
					 and a.depotid*=d.depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --发至店铺未发给顾客1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid 
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' and a.depotid=@depotid 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                    where a.proposerid*=b.proposerid 
	                          and a.proposerid<>'0' and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e ,cashcard.dbo.j_card_state f
	                where a.proposerid*=b.proposerid 
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid 
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                    where a.proposerid*=b.proposerid 
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
			and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                    where a.proposerid*=b.proposerid  
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0' and a.depotid=@depotid
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e ,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid  
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e ,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid 
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd and a.depotid=@depotid  
			and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
end
end

GO

if exists (select 1
          from sysobjects
          where name = 'Card_jcardFillCardCommon'
          and type = 'P')
   drop procedure Card_jcardFillCardCommon
go

/*普通用户维护充值卡档案*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/
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
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
        from      cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
        where a.proposerid*=b.proposerid 
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                 	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                	where a.proposerid*=b.proposerid  
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') 
					and a.depotid*=d.depotid and a.depotid=@depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --发至店铺未发给顾客1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                    from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid  and a.depotid=@depotid 
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid  and a.depotid=@depotid 
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                where a.proposerid*=b.proposerid  and a.depotid=@depotid 
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                   from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid  and a.depotid=@depotid 
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid  and a.depotid=@depotid 
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid  and a.depotid=@depotid  
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
                from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid  and a.depotid=@depotid  
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid  and a.depotid=@depotid 
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			 and a.dbname=@dbname and b.dbname=@dbname
end





GO

if exists (select 1
          from sysobjects
          where name = 'Card_jcardFillCardCommon_back'
          and type = 'P')
   drop procedure Card_jcardFillCardCommon_back
go

/*普通用户维护充值卡档案*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE  PROCEDURE Card_jcardFillCardCommon_back

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
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                    from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                   from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
                from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1 
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			 and a.dbname=@dbname and b.dbname=@dbname
end





GO

if exists (select 1
          from sysobjects
          where name = 'Card_jcardFillCard_back'
          and type = 'P')
   drop procedure Card_jcardFillCard_back
go

/*维护充值卡档案*/
/*说明：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE  PROCEDURE Card_jcardFillCard_back

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
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
        where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1 
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 	a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
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
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 			a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
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
		 		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 	a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
		 a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e ,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid*=c.depotid and c.access=1
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd and a.depotid=@depotid  
			and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
end
end





GO

if exists (select 1
          from sysobjects
          where name = 'Card_jcardQueryBegEnd'
          and type = 'P')
   drop procedure Card_jcardQueryBegEnd
go

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


if exists (select 1
          from sysobjects
          where name = 'Card_jcardQuerydepot'
          and type = 'P')
   drop procedure Card_jcardQuerydepot
go

CREATE PROCEDURE Card_jcardQuerydepot

@depotid varchar(10),
@userid varchar(20)

AS

/*创建时间：2007-7-11
  创建人：HKM
 功能：查询指定范围的卡号档案
*/

--select a.*,b.names 
select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,a.comment,a.crname,
	a.depotid,a.crdate,a.lastdate,b.names
from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b ,sys_depotpower18ql c
where a.proposerid*=b.proposerid and  a.depotid=@depotid
	and c.userid=@userid and a.depotid=c.depotid and c.access=1

GO

if exists (select 1
          from sysobjects
          where name = 'Card_jcardSelectDepotBegEnd'
          and type = 'P')
   drop procedure Card_jcardSelectDepotBegEnd
go

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
		a.start, a.proposerid, a.password, a.depotid, a.congeal, a.dbname,b.names, c.d_name,d.username,e.statename
from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot c,j_user d,cashcard.dbo.j_card_state e
where a.proposerid*=b.proposerid and start=@used and cardid>=@cardidBeg and cardid<=@cardidEnd
		and a.depotid*=c.depotid and a.crname*=d.userid and a.start*=e.id
		and a.dbname=@dbname and a.dbname=@dbname



GO


if exists (select 1
          from sysobjects
          where name = 'Card_jcardSelectDepotBegEndAll'
          and type = 'P')
   drop procedure Card_jcardSelectDepotBegEndAll
go


/*管理员查询充值卡档案*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/
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
	 from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid  and a.start*=f.id
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.dbname=@dbname and b.dbname=@dbname
     end
else if((@cardidBeg ='-' and @cardidEnd='-') and @depotid <>'-')
    begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
	a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	 from  cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid  and a.depotid=@depotid 
		  and a.dbname=@dbname and b.dbname=@dbname
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.start*=f.id
     end
else if((@cardidBeg <>'-' or @cardidEnd<>'-') and @depotid='-')
     begin
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	 from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid 
		and cardid>=@cardidBeg and cardid<=@cardidEnd and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
		  and a.dbname=@dbname and b.dbname=@dbname
     end
else
    begin
	--select a.*,b.names 
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
 	where a.proposerid*=b.proposerid and a.depotid=@depotid and cardid>=@cardidBeg and cardid<=@cardidEnd and a.start*=f.id
		
		and a.depotid*=d.depotid and a.crname*=e.userid   and a.dbname=@dbname and b.dbname=@dbname
     end



GO



if exists (select 1
          from sysobjects
          where name = 'Card_jcardSelectDepotBegEndAll_back'
          and type = 'P')
   drop procedure Card_jcardSelectDepotBegEndAll_back
go

/*管理员查询充值卡档案*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
CREATE  PROCEDURE Card_jcardSelectDepotBegEndAll_back

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


if exists (select 1
          from sysobjects
          where name = 'Card_jcardSelectDepotBegEndAllcomm'
          and type = 'P')
   drop procedure Card_jcardSelectDepotBegEndAllcomm
go


/*普通用户查询充值卡档案*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/
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
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	where a.proposerid*=b.proposerid  and a.depotid=@depotid
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
     end
else
     begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	where a.proposerid*=b.proposerid  and a.depotid=@depotid
		and a.depotid*=d.depotid and a.crname*=e.userid and cardid>=@cardidBeg and cardid<=@cardidEnd  and a.start*=f.id
		 and a.dbname=@dbname and b.dbname=@dbname
     end



GO

if exists (select 1
          from sysobjects
          where name = 'Card_jcardSelectDepotBegEndAllcomm_back'
          and type = 'P')
   drop procedure Card_jcardSelectDepotBegEndAllcomm_back
go

/*普通用户查询充值卡档案*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE  PROCEDURE Card_jcardSelectDepotBegEndAllcomm_back

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

if exists (select 1
          from sysobjects
          where name = 'Card_jcardSelectLoseUser'
          and type = 'P')
   drop procedure Card_jcardSelectLoseUser
go

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
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 	
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 
			,b.addcardid,b.cardid,b.start,b.sums,d.statename  
        from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,cashcard.dbo.j_card_state d
	where a.proposerid=b.proposerid  and a.dbname=@dbname and b.dbname=@dbname
	        and b.start*=d.id
end
else if(@names <>'' and @cardid='')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 
		,b.addcardid,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid  and a.names=@names and a.dbname=@dbname and b.dbname=@dbname
		 and b.start*=d.id
end
else if(@names ='' and @cardid<>'')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 
		,b.addcardid,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid  and b.cardid=@cardid and a.dbname=@dbname and b.dbname=@dbname
		 and b.start*=d.id
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,b.addcardid,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid  and b.cardid=@cardid and  a.names=@names
		 and b.start*=d.id and a.dbname=@dbname and b.dbname=@dbname
end




GO


if exists (select 1
          from sysobjects
          where name = 'Card_jcardSelectLoseUserBack'
          and type = 'P')
   drop procedure Card_jcardSelectLoseUserBack
go

/*挂失解挂List*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE Card_jcardSelectLoseUserBack

@names varchar(50),
@depotid varchar(10),
@userid varchar(20),
@cardid varchar(50),
@dbname varchar(20)
AS
if(@names ='' and @cardid='')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 	
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 
			,b.cardid,b.start,b.sums,d.statename  
        from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
	where a.proposerid=b.proposerid and b.depotid=@depotid and a.dbname=@dbname and b.dbname=@dbname
	           and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
end
else if(@names <>'' and @cardid='')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 
		,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid and b.depotid=@depotid and a.names=@names and a.dbname=@dbname and b.dbname=@dbname
	and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
end
else if(@names ='' and @cardid<>'')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid 
		,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid and b.depotid=@depotid and b.cardid=@cardid and a.dbname=@dbname and b.dbname=@dbname
	and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,b.cardid,b.start,b.sums,d.statename 
              from cashcard.dbo.j_proposer a,cashcard.dbo.j_card b,sys_depotpower18ql c,cashcard.dbo.j_card_state d
	 where a.proposerid=b.proposerid and b.depotid=@depotid and b.cardid=@cardid and  a.names=@names
	and c.userid=@userid and a.depotid=c.depotid and c.access=1 and b.start*=d.id and a.dbname=@dbname and b.dbname=@dbname
end




GO



if exists (select 1
          from sysobjects
          where name = 'Card_jproposerQueryDetilSelect'
          and type = 'P')
   drop procedure Card_jproposerQueryDetilSelect
go

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

if exists (select 1
          from sysobjects
          where name = 'Card_jproposerQuerySelecthis'
          and type = 'P')
   drop procedure Card_jproposerQuerySelecthis
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

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
if (@username ='-')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where   a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where a.names=@username  and   a.dbname=@dbname
		 	and a.proposerid*=c.proposerid and a.depotid*=d.depotid
end



GO

if exists (select 1
          from sysobjects
          where name = 'Card_jproposerQuerySelecthisComm'
          and type = 'P')
   drop procedure Card_jproposerQuerySelecthisComm
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

CREATE PROCEDURE Card_jproposerQuerySelecthisComm
@username varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(10)

 AS
/*
时间：2007-7-7
功能：查询客户信息(历史)
原因：只可限本店铺人查询
*/
if (@username ='-')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where   a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid and a.depotid=@depotid
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where a.names=@username  and   a.dbname=@dbname
		 	and a.proposerid*=c.proposerid and a.depotid*=d.depotid and a.depotid=@depotid
end



GO

if exists (select 1
          from sysobjects
          where name = 'Card_jproposerQuerySelecthis_back'
          and type = 'P')
   drop procedure Card_jproposerQuerySelecthis_back
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */

CREATE PROCEDURE Card_jproposerQuerySelecthis_back
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
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where  b.userid=@userid and a.depotid=b.depotid and a.dbname=@dbname
		 	and b.access=1 and a.proposerid*=c.proposerid and a.depotid=d.depotid
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where a.names=@username  and  b.userid=@userid and a.depotid=b.depotid  and a.dbname=@dbname
		 	and b.access=1 and a.proposerid*=c.proposerid and a.depotid=d.depotid
end



GO

if exists (select 1
          from sysobjects
          where name = 'Card_jproposerSelect'
          and type = 'P')
   drop procedure Card_jproposerSelect
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

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
if (@username ='-')
begin
	select  a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.d_name 
	from   cashcard.dbo.j_proposer a, j_depot c
	where   a.depotid*=c.depotid and a.dbname=@dbname
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from   cashcard.dbo.j_proposer a,j_depot c
	where a.names=@username  and a.depotid*=c.depotid and a.dbname=@dbname
end






GO


if exists (select 1
          from sysobjects
          where name = 'Card_jproposerSelectComm'
          and type = 'P')
   drop procedure Card_jproposerSelectComm
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

CREATE PROCEDURE Card_jproposerSelectComm
@username varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(10)

 AS
/*
时间：2007-3-14
创建人：HKM
功能：查询客户信息,
修改2007.4.1
原因：只可限本店铺人查询
*/
if (@username ='-')
begin
	select  a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.d_name 
	from   cashcard.dbo.j_proposer a, j_depot c
	where   a.depotid*=c.depotid and a.dbname=@dbname and a.depotid=@depotid
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from   cashcard.dbo.j_proposer a,j_depot c
	where a.names=@username  and a.depotid*=c.depotid and a.dbname=@dbname and a.depotid=@depotid
end

GO

if exists (select 1
          from sysobjects
          where name = 'Card_jproposerSelect_back'
          and type = 'P')
   drop procedure Card_jproposerSelect_back
go

CREATE PROCEDURE Card_jproposerSelect_back
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
	select  a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.d_name 
	from   cashcard.dbo.j_proposer a, sys_depotpower18ql b ,j_depot c
	where  b.userid=@userid and a.depotid=b.depotid
	 	and b.access=1  and a.depotid=c.depotid and a.dbname=@dbname
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from   cashcard.dbo.j_proposer a, sys_depotpower18ql b ,j_depot c
	where a.names=@username  and b.userid=@userid and a.depotid=b.depotid
 	and b.access=1 and a.depotid=c.depotid and a.dbname=@dbname
end


GO

if exists (select 1
          from sysobjects
          where name = 'Card_jproposerSelecthis'
          and type = 'P')
   drop procedure Card_jproposerSelecthis
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

CREATE PROCEDURE Card_jproposerSelecthis
@username varchar(30),
@userid varchar(4),
@dbname varchar(20)

 AS
/*
历史建立人档案
2007-07-07
*/
if (@username ='-')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a, j_depot c 
	where   a.depotid*=c.depotid and a.dbname=@dbname
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a,j_depot c 
	where a.names=@username   and a.dbname=@dbname and a.depotid*=c.depotid
end



GO


if exists (select 1
          from sysobjects
          where name = 'Card_jproposerSelecthisComm'
          and type = 'P')
   drop procedure Card_jproposerSelecthisComm
go


/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

CREATE PROCEDURE Card_jproposerSelecthisComm
@username varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(10)

 AS
/*
历史建立人档案
2007-07-07
*/
if (@username ='-')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a, j_depot c 
	where   a.depotid*=c.depotid and a.dbname=@dbname and a.depotid=@depotid
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a,j_depot c 
	where a.names=@username   and a.dbname=@dbname and a.depotid*=c.depotid and a.depotid=@depotid
end



GO



if exists (select 1
          from sysobjects
          where name = 'Card_jproposerSelecthis_back'
          and type = 'P')
   drop procedure Card_jproposerSelecthis_back
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE Card_jproposerSelecthis_back
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
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,j_depot c 
	where  b.userid=@userid and a.depotid=b.depotid
	 	and b.access=1 and a.depotid=c.depotid and a.dbname=@dbname
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a, sys_depotpower18ql b ,j_depot c 
	where a.names=@username  and b.userid=@userid and a.depotid=b.depotid and a.dbname=@dbname
 	and b.access=1 and a.depotid=c.depotid
end



GO

if exists (select 1
          from sysobjects
          where name = 'card_jproposerQuerySelect'
          and type = 'P')
   drop procedure card_jproposerQuerySelect
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

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
if (@username ='-')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, 
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where   a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, 
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where a.names=@username   and a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid
end
GO


if exists (select 1
          from sysobjects
          where name = 'card_jproposerQuerySelectComm'
          and type = 'P')
   drop procedure card_jproposerQuerySelectComm
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*不再使用权力sys_depotpower18ql表来控制可以查看哪些店铺2007-08-09*/

CREATE PROCEDURE card_jproposerQuerySelectComm
@username varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(10)

 AS
/*
时间：2007-7-3
功能：查询客户信息
原因：只可限本店铺人查询
*/
if (@username ='-')
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, 
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where   a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid and a.depotid=@depotid
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, 
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where a.names=@username   and a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid and a.depotid=@depotid
end



GO


if exists (select 1
          from sysobjects
          where name = 'card_jproposerQuerySelect_back'
          and type = 'P')
   drop procedure card_jproposerQuerySelect_back
go

/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */


CREATE PROCEDURE card_jproposerQuerySelect_back
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
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where  b.userid=@userid and a.depotid=b.depotid  and a.dbname=@dbname 
		 	and b.access=1 and a.proposerid*=c.proposerid and a.depotid=d.depotid
end
else
begin
	select a.proposerid, a.names, a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add], a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, sys_depotpower18ql b ,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where a.names=@username  and  b.userid=@userid and a.depotid=b.depotid and a.dbname=@dbname
		 	and b.access=1 and a.proposerid*=c.proposerid and a.depotid=d.depotid
end



GO