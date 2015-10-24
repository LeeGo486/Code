IF EXISTS (SELECT name FROM sysobjects
      WHERE name = 'Card_cardBatCongeal' AND type = 'P')
   DROP PROCEDURE Card_cardBatCongeal
GO

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*����޸�����:2007-07-27 �������������������ѻ��ǿ���� 1���� 2��ȡ���*/

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
     WHERE datediff(month,sure_date,getdate())>=@monthnum and comment='��ȡ���' and dbname=@dbname and dtype='2'

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
--���������ֵ��(start 2��ʾ���� congeal 1��ʾ���� 0��ʾ������)
UPDATE a SET congeal=1,start=2,lastdate=getdate()  
FROM  cashcard.dbo.j_card a INNER JOIN @tmptab b ON a.cardid=b.cardid
WHERE a.sums<=0  and a.dbname=@dbname



GO



IF EXISTS (SELECT name FROM sysobjects
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
		and a.depotid*=d.depotid and a.depotid=@depotid and a.crname*=e.userid and a.start*=f.id
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
					and a.depotid*=d.depotid and a.depotid=@depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --��������δ�����˿�1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                    from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --�ѷ����˿�2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--δ����
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
	                   where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --��������δ�����˿�1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --�ѷ����˿�2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,sys_depotpower18ql c,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid and c.userid=@userid and a.depotid=c.depotid and a.depotid=@depotid and c.access=1 
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--δ����
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

/*��ʧ���List*/
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23�޸�:����Ա����Ϊ��ʱ�����е���ѡ���ܲ�ѯ����ֵ��¼*/

CREATE PROCEDURE Card_dloggingSelect

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(20)
 AS

/*2007.3.31
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23�޸�:��Ա��ѯ����ֵ��¼*/

CREATE PROCEDURE Card_dloggingSelectCommon

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(20)
 AS

/*2007.3.31
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23�޸�:����Ա����Ϊ��ʱ�����ڿ����е���ѡ���ܲ�ѯ����ֵ��¼*/

CREATE PROCEDURE Card_dloggingSelectDateBegEnd

@userid varchar(10),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20),
@depotid varchar(20)
 AS

/*2007.3.31
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23�޸�:��Ա�����ڲ�ѯ����ֵ��¼*/

CREATE PROCEDURE Card_dloggingSelectDateBegEndComm

@userid varchar(10),
@datebeg datetime,
@dateend datetime,
@dbname varchar(20),
@depotid varchar(20)
 AS

/*2007.3.31
hkm
����:��ѯ�޶����̷�Χ�ڵĿͻ���ֵ��¼
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23�޸�:����Ա����Ϊ��ʱ�����е���ѡ���ܲ�ѯ�����Ѽ�¼*/

CREATE PROCEDURE Card_dconsumeSelect

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(20)

 AS
/*
2007.3.31
HKM
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼ 
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23�޸�:��Ա��ѯ�����Ѽ�¼*/

CREATE PROCEDURE Card_dconsumeSelectCommon

@cardid varchar(30),
@userid varchar(4),
@dbname varchar(20),
@depotid varchar(20)

 AS
/*
2007.3.31
HKM
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼ 
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


/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23�޸�:����Ա����Ϊ��ʱ�����е���ѡ���ܰ����ڲ�ѯ�����Ѽ�¼*/

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
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼
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


/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-19*/
/*write by zcy */
/*2007-7-23�޸�:��Ա�����ڲ�ѯ�����Ѽ�¼*/

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
���ܣ���ѯ�޶����̷�Χ�ڿͻ�����Ϣ��¼
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

/*���ܣ�Ϊ�����������ݿ��ֶ�*/
/*date:2007-07-18*/
/*write by zcy */
/*��ѯ������ⶳ��¼*/
/*����޸�ʱ��:2007-07-27 �������ڷ�Χ��ѯ*/
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
