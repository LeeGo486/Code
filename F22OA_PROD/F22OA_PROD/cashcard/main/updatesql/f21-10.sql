
IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardFillCard' AND type = 'P')
   DROP PROCEDURE Card_jcardFillCard
GO

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
	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
        from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
        where a.proposerid*=b.proposerid  
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
	                    	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e ,cashcard.dbo.j_card_state f
	                	where a.proposerid*=b.proposerid  
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') and a.depotid*=d.depotid
					 and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --发至店铺未发给顾客1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid 
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid  and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid 
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
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
	                   select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid 
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid 
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid  
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'  
				and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid  
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
	                    	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                 	from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                	where a.proposerid*=b.proposerid  
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') and a.depotid=@depotid
					 and a.depotid*=d.depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --发至店铺未发给顾客1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid 
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' and a.depotid=@depotid 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                    where a.proposerid*=b.proposerid 
	                          and a.proposerid<>'0' and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
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
	                   select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                   from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid 
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
				and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f 
                    where a.proposerid*=b.proposerid 
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
			and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f 
	                    where a.proposerid*=b.proposerid  
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0' and a.depotid=@depotid
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
                from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e ,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid  
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			and a.depotid=@depotid and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot d,j_user e ,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid 
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd and a.depotid=@depotid  
			and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			and a.dbname=@dbname and b.dbname=@dbname
end
end







GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardFillCardCommon' AND type = 'P')
   DROP PROCEDURE Card_jcardFillCardCommon
GO


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
	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
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
	                    	select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 			a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                 	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                	where a.proposerid*=b.proposerid  
	                	       and (isnull(a.depotid,'')<>'' or a.proposerid<>'0') 
					and a.depotid*=d.depotid and a.depotid=@depotid and a.crname*=e.userid and a.start*=f.id
					and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
	                begin
	                    --发至店铺未发给顾客1
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
	                    from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid  and a.depotid=@depotid 
	                               and isnull(a.depotid,'')<>'' and a.proposerid='0' 
					and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else
	                begin 
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid  and a.depotid=@depotid 
	                          and a.proposerid<>'0' and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
		--未发卡
            else
	            begin
	                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
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
	                   select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                   from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                   where a.proposerid*=b.proposerid  and a.depotid=@depotid 
	                       and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and (isnull(a.depotid,'')<>'' or a.proposerid<>'0')
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
                else if (@yesnosendcust ='1')
                begin
                    --发至店铺未发给顾客1
                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 	a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename  
                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
                    where a.proposerid*=b.proposerid  and a.depotid=@depotid 
                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and isnull(a.depotid,'')<>'' and a.proposerid='0'
				 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
                end
                else
	                begin
	                    --已发给顾客2
	                    select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename 
	                    from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	                    where a.proposerid*=b.proposerid  and a.depotid=@depotid  
	                         and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd   and a.proposerid<>'0'
					 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
	                end
            end
            else
            begin--未发卡
                select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
                from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
                where a.proposerid*=b.proposerid  and a.depotid=@depotid  
                   and  a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and isnull(a.depotid,'')='' and a.proposerid='0'
			 and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
            end
            
end
else if ((@cardidBeg<>'-' or @cardidEnd<>'-') and @yesnosendcard ='-')
begin
            select a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,
		 a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names,d.d_name,e.username,f.statename
            from     cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
            where a.proposerid*=b.proposerid  and a.depotid=@depotid 
                 and a.cardid>=@cardidBeg and a.cardid<=@cardidEnd  and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
			 and a.dbname=@dbname and b.dbname=@dbname
end





GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardSelectDepotBegEndAll' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectDepotBegEndAll
GO


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
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	 from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid  and a.start*=f.id
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.dbname=@dbname and b.dbname=@dbname
     end
else if((@cardidBeg ='-' and @cardidEnd='-') and @depotid <>'-')
    begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,a.crname,
	a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	 from  cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid  and a.depotid=@depotid 
		  and a.dbname=@dbname and b.dbname=@dbname
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.start*=f.id
     end
else if((@cardidBeg <>'-' or @cardidEnd<>'-') and @depotid='-')
     begin
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	 from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	 where a.proposerid*=b.proposerid 
		and cardid>=@cardidBeg and cardid<=@cardidEnd and a.depotid*=d.depotid and a.crname*=e.userid and a.start*=f.id
		  and a.dbname=@dbname and b.dbname=@dbname
     end
else
    begin
	--select a.*,b.names 
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
 	where a.proposerid*=b.proposerid and a.depotid=@depotid and cardid>=@cardidBeg and cardid<=@cardidEnd and a.start*=f.id
		
		and a.depotid*=d.depotid and a.crname*=e.userid   and a.dbname=@dbname and b.dbname=@dbname
     end



GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardSelectDepotBegEndAllcomm' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectDepotBegEndAllcomm
GO


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
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	where a.proposerid*=b.proposerid  and a.depotid=@depotid
		and a.depotid*=d.depotid and a.crname*=e.userid  and a.start*=f.id and a.dbname=@dbname and b.dbname=@dbname
     end
else
     begin
	--select a.*,b.names
	select a.cardid,a.cardname,a.sums,a.start,a.proposerid,b.names,dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,a.crname,
		a.depotid,a.crdate,a.lastdate,b.names,d.d_name,e.username,f.statename
	from    cashcard.dbo.j_card a ,  cashcard.dbo.j_proposer b,j_depot d,j_user e,cashcard.dbo.j_card_state f
	where a.proposerid*=b.proposerid  and a.depotid=@depotid
		and a.depotid*=d.depotid and a.crname*=e.userid and cardid>=@cardidBeg and cardid<=@cardidEnd  and a.start*=f.id
		 and a.dbname=@dbname and b.dbname=@dbname
     end



GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jcardSelectDepotBegEnd' AND type = 'P')
   DROP PROCEDURE Card_jcardSelectDepotBegEnd
GO



/*店铺领取充值卡列表*/
/*功能：为增加区别数据库字段*/
/*date:2007-07-18*/
/*write by zcy */
/*2007-8.13如果已发给其它店铺则不允许再查询出来*/
CREATE PROCEDURE Card_jcardSelectDepotBegEnd

@cardidBeg varchar(30),
@cardidEnd varchar(30),
@used int,
@dbname varchar(20)
AS


SELECT a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment, a.comment as comment1,
		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names, c.d_name,d.username,e.statename
from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot c,j_user d,cashcard.dbo.j_card_state e
where a.proposerid*=b.proposerid and start=@used and cardid>=@cardidBeg and cardid<=@cardidEnd
		and a.depotid*=c.depotid and a.crname*=d.userid and a.start*=e.id
		and a.dbname=@dbname and a.dbname=@dbname and isnull(a.depotid,'')=''




GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerSelect' AND type = 'P')
   DROP PROCEDURE Card_jproposerSelect
GO

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
	select  a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.d_name 
	from   cashcard.dbo.j_proposer a, j_depot c
	where   a.depotid*=c.depotid and a.dbname=@dbname
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid,c.d_name 
	from   cashcard.dbo.j_proposer a,j_depot c
	where a.names=@username  and a.depotid*=c.depotid and a.dbname=@dbname
end






GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerSelectComm' AND type = 'P')
   DROP PROCEDURE Card_jproposerSelectComm
GO


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
	select  a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.d_name 
	from   cashcard.dbo.j_proposer a, j_depot c
	where   a.depotid*=c.depotid and a.dbname=@dbname and a.depotid=@depotid
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 			a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid,c.d_name 
	from   cashcard.dbo.j_proposer a,j_depot c
	where a.names=@username  and a.depotid*=c.depotid and a.dbname=@dbname and a.depotid=@depotid
end






GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'card_jproposerQuerySelect' AND type = 'P')
   DROP PROCEDURE card_jproposerQuerySelect
GO




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
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1,a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, 
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where   a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, 
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where a.names=@username   and a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid
end
GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'card_jproposerQuerySelectComm' AND type = 'P')
   DROP PROCEDURE card_jproposerQuerySelectComm
GO



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
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel, 		
		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, 
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where   a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid and a.depotid=@depotid
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.cardnum,d.d_name
	from  cashcard.dbo.j_proposer a, 
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid )c,j_depot d
	where a.names=@username   and a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid and a.depotid=@depotid
end



GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerSelecthis' AND type = 'P')
   DROP PROCEDURE Card_jproposerSelecthis
GO

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
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a, j_depot c 
	where   a.depotid*=c.depotid and a.dbname=@dbname
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a,j_depot c 
	where a.names=@username   and a.dbname=@dbname and a.depotid*=c.depotid
end



GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerSelecthisComm' AND type = 'P')
   DROP PROCEDURE Card_jproposerSelecthisComm
GO



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
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a, j_depot c 
	where   a.depotid*=c.depotid and a.dbname=@dbname and a.depotid=@depotid
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid,c.d_name 
	from  cashcard.dbo.j_proposer_history a,j_depot c 
	where a.names=@username   and a.dbname=@dbname and a.depotid*=c.depotid and a.depotid=@depotid
end



GO



IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerQuerySelecthis' AND type = 'P')
   DROP PROCEDURE Card_jproposerQuerySelecthis
GO

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
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where   a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where a.names=@username  and   a.dbname=@dbname
		 	and a.proposerid*=c.proposerid and a.depotid*=d.depotid
end



GO


IF EXISTS (SELECT name FROM sysobjects 
         WHERE name = 'Card_jproposerQuerySelecthisComm' AND type = 'P')
   DROP PROCEDURE Card_jproposerQuerySelecthisComm
GO



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
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where   a.dbname=@dbname and a.proposerid*=c.proposerid and a.depotid*=d.depotid and a.depotid=@depotid
end
else
begin
	select a.proposerid, a.[names], a.sex, a.[identity], a.tel,dbo.ReturnStrIntercept(a.[add]) as [add],a.[add] as add1, a.mtel,
 		a.passwordtel, a.password, dbo.ReturnStrIntercept(a.comment) as comment,a.comment as comment1, a.presenter, a.depotid ,c.cardnum,d.d_name
	from   cashcard.dbo.j_proposer_history a,
	      (select proposerid,count(*) as cardnum from cashcard.dbo.j_card where proposerid<>0 and dbname=@dbname group by proposerid ) c ,j_depot d
	where a.names=@username  and   a.dbname=@dbname
		 	and a.proposerid*=c.proposerid and a.depotid*=d.depotid and a.depotid=@depotid
end



GO
