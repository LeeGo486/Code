/**************���ܣ������ͻ���ǰʹ�õ�f21�����ݿ⣬���Ȩ��ģ��*************/
/*��������:2007-07-09*/
/* write by dpipi */




/*==============================================================*/
/* View: webvw_user                                             */
/* 2007-7-9*/
/*==============================================================*/
if exists (select 1
            from  sysobjects
           where  id = object_id('webvw_user')
            and   type = 'V')
   drop view webvw_user
go

create view webvw_user as 
select userid,username,password,usermain,notuse,depotid,mb,dptype from j_user

GO
if exists (select 1
          from sysobjects
          where name = 'web_chkuser'
          and type = 'P')
   drop procedure web_chkuser
go

/*@userid �û�id*/
/*@pwd���û���*/
/* 2006-12-28*/
create procedure web_chkuser
@userid varchar(40),
@pwd varchar(40)
as
SELECT username,password,usermain,depotid,mb,dptype FROM webvw_user
    WHERE userid=@userid 
        and [password]=@pwd 
        and isnull(notuse,0)=0

GO


/* edit Ȩ�޸������ߣ�ȡ�˵�ʱ��Ӧ�ر䶯*/
/* ��ƽƽ 2007-07-06 */
if exists (select 1
          from sysobjects
          where name = 'A380web_getUserMenu'
          and type = 'P')
   drop procedure A380web_getUserMenu
go


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
	        --select aspxid,loadid,aspname,readme from aspnetdb.dbo.webvw_useraspx
                     --  group by aspxid,loadid,aspname,readme,ctype,username  
		     --   having username=@userid 
                    --order by ctype,loadid,aspxid
                /*2008.01.21ǰ*/--select aspxid,loadid,aspname,readme from aspnetdb.dbo.webvw_useraspx
                    --   group by aspxid,loadid,aspname,readme,ctype,username  
		      --  having username=@userid 
                    --order by ctype,loadid,aspxid
                select a.aspxid,a.loadid,a.aspname,a.readme from aspnetdb.dbo.web_aspx a
                       inner join aspnetdb.dbo.web_userrole b
                       on a.aspxid=b.aspxid
                       group by a.aspxid,a.loadid,a.aspname,a.readme,a.ctype,b.username  
		        having b.username=@userid
                    order by a.ctype,a.loadid,a.aspxid
 end

GO

if exists (select 1
          from sysobjects
          where name = 'Role_getuseraspxNosel'
          and type = 'P')
   drop procedure Role_getuseraspxNosel
go

/* creat Ȩ�޸������ߣ�ȡ�˵�ʱ��Ӧ�ر䶯*/
/* ��ƽƽ 2007-07-07 */
CREATE  procedure Role_getuseraspxNosel
	@rolesid nvarchar (50),
	@userid  nvarchar (50),
        @touserid  nvarchar (50)
 as

  declare @roles bit,
        @dptype int,
        @depotid varchar(10),
        @merchantid varchar(10),
        @parentid varchar(10)
  
    select @roles=usermain,@depotid=depotid,@merchantid=mb,@dptype=isnull(dptype,0) from webvw_user where userid=@userid
    /*�ܲ������û�*/
    if @roles=1 and @dptype=0 
             select C.rolesid,A.aspxid,A.readme,A.ctype,A.comment,
		isnull(C.p_add,0) as p_add,
		isnull(C.p_edit,0) as p_edit,
		isnull(C.p_del,0) as p_del,
		isnull(C.p_chk,0) as p_chk,
		isnull(C.p_sure,0) as p_sure,
		isnull(C.p_prn,0) as p_prn,
		isnull(C.p_unchk,0) as p_unchk,
		isnull(C.p_unsure,0) as p_unsure,
		isnull(C.p_reta,0) as p_reta,
		isnull(C.p_ereta,0) as p_ereta,
		isnull(C.p_export,0) as p_export,
		isnull(C.p_cost,0) as p_cost,
		isnull(C.p_price,0) as p_price,
		isnull(C.p_sprice,0) as p_sprice  
		        from aspnetdb.dbo.web_aspx A
		    
		          inner join  aspnetdb.dbo.web_rolesaspx C
		           ON A.aspxid=C.aspxid 
		         where C.rolesid=@rolesid  

		          and A.aspxid not in
		             (
		                 select aspxid 
                                        from  aspnetdb.dbo.web_userrole 
                                          where username=@touserid 
                                             and rolesid=@rolesid
		              )
		          order by A.aspxid 
     /*�����û�*/
    else

		select C.rolesid,A.aspxid,A.readme,A.ctype,A.comment,
		isnull(C.p_add,0) as p_add,
		isnull(C.p_edit,0) as p_edit,
		isnull(C.p_del,0) as p_del,
		isnull(C.p_chk,0) as p_chk,
		isnull(C.p_sure,0) as p_sure,
		isnull(C.p_prn,0) as p_prn,
		isnull(C.p_unchk,0) as p_unchk,
		isnull(C.p_unsure,0) as p_unsure,
		isnull(C.p_reta,0) as p_reta,
		isnull(C.p_ereta,0) as p_ereta,
		isnull(C.p_export,0) as p_export,
		isnull(C.p_cost,0) as p_cost,
		isnull(C.p_price,0) as p_price,
		isnull(C.p_sprice,0) as p_sprice  
		        from  aspnetdb.dbo.web_aspx A
		         inner join 
		           aspnetdb.dbo.web_userrole B 
		          ON A.aspxid=B.aspxid 
		          inner join 
                              aspnetdb.dbo.web_rolesaspx C
		           ON A.aspxid=C.aspxid 
		         where C.rolesid=@rolesid  
		          and  B.username=@userid
		          and A.aspxid not in
		             (
		                 select aspxid 
                                        from  aspnetdb.dbo.web_userrole 
                                          where username=@touserid 
                                              and rolesid=@rolesid
		              )
		          order by A.aspxid 


GO

if exists (select 1
          from sysobjects
          where name = 'Role_getuseraspxNosel'
          and type = 'P')
   drop procedure Role_getuseraspxNosel
go

/* creat Ȩ�޸������ߣ�ȡ�˵�ʱ��Ӧ�ر䶯*/
/* ��ƽƽ 2007-07-07 */
CREATE  procedure Role_getuseraspxNosel
	@rolesid nvarchar (50),
	@userid  nvarchar (50),
        @touserid  nvarchar (50)
 as

  declare @roles bit,
        @dptype int,
        @depotid varchar(10),
        @merchantid varchar(10),
        @parentid varchar(10)
  
    select @roles=usermain,@depotid=depotid,@merchantid=mb,@dptype=isnull(dptype,0) from webvw_user where userid=@userid
    /*�ܲ������û�*/
    if @roles=1 and @dptype=0 
             select C.rolesid,A.aspxid,A.readme,A.ctype,A.comment,
		isnull(C.p_add,0) as p_add,
		isnull(C.p_edit,0) as p_edit,
		isnull(C.p_del,0) as p_del,
		isnull(C.p_chk,0) as p_chk,
		isnull(C.p_sure,0) as p_sure,
		isnull(C.p_prn,0) as p_prn,
		isnull(C.p_unchk,0) as p_unchk,
		isnull(C.p_unsure,0) as p_unsure,
		isnull(C.p_reta,0) as p_reta,
		isnull(C.p_ereta,0) as p_ereta,
		isnull(C.p_export,0) as p_export,
		isnull(C.p_cost,0) as p_cost,
		isnull(C.p_price,0) as p_price,
		isnull(C.p_sprice,0) as p_sprice  
		        from aspnetdb.dbo.web_aspx A
		    
		          inner join  aspnetdb.dbo.web_rolesaspx C
		           ON A.aspxid=C.aspxid 
		         where C.rolesid=@rolesid  

		          and A.aspxid not in
		             (
		                 select aspxid 
                                        from  aspnetdb.dbo.web_userrole 
                                          where username=@touserid 
                                             and rolesid=@rolesid
		              )
		          order by A.aspxid 
     /*�����û�*/
    else

		select C.rolesid,A.aspxid,A.readme,A.ctype,A.comment,
		isnull(C.p_add,0) as p_add,
		isnull(C.p_edit,0) as p_edit,
		isnull(C.p_del,0) as p_del,
		isnull(C.p_chk,0) as p_chk,
		isnull(C.p_sure,0) as p_sure,
		isnull(C.p_prn,0) as p_prn,
		isnull(C.p_unchk,0) as p_unchk,
		isnull(C.p_unsure,0) as p_unsure,
		isnull(C.p_reta,0) as p_reta,
		isnull(C.p_ereta,0) as p_ereta,
		isnull(C.p_export,0) as p_export,
		isnull(C.p_cost,0) as p_cost,
		isnull(C.p_price,0) as p_price,
		isnull(C.p_sprice,0) as p_sprice  
		        from  aspnetdb.dbo.web_aspx A
		         inner join 
		           aspnetdb.dbo.web_userrole B 
		          ON A.aspxid=B.aspxid 
		          inner join 
                              aspnetdb.dbo.web_rolesaspx C
		           ON A.aspxid=C.aspxid 
		         where C.rolesid=@rolesid  
		          and  B.username=@userid
		          and A.aspxid not in
		             (
		                 select aspxid 
                                        from  aspnetdb.dbo.web_userrole 
                                          where username=@touserid 
                                              and rolesid=@rolesid
		              )
		          order by A.aspxid 


GO


/*���ܣ�ȡ���û��ĶԲ˵���Ȩ��*/
/*@userid���û��ɣ�*/
/*@aspxid:�˵��ɣ�*/
/*����:2007-07-09*/
/* write by dpipi */

if exists (select 1
          from sysobjects
          where name = 'A380web_getUserAspxPower'
          and type = 'P')
   drop procedure A380web_getUserAspxPower
go

create procedure A380web_getUserAspxPower
@userid varchar(10),
@aspxid varchar(10)
as
begin
declare @usermain bit

select @usermain=isnull(usermain,0) 
	from webvw_user
	where userid=@userid
if @usermain=1
	select @usermain as p_add,@usermain as p_edit,@usermain as p_del,@usermain as p_unchk,
		@usermain as p_chk,@usermain as p_prn,@usermain as p_sure,@usermain as p_unsure,@usermain as p_reta,@usermain as p_ereta
else
	select p_add,p_edit,p_del,p_chk,p_prn,p_sure,p_unchk,p_unsure,p_reta,p_ereta
		from aspnetdb.dbo.webvw_useraspx 
		where username=@userid and aspxid=@aspxid
end

GO


if exists (select 1
          from sysobjects
          where name = 'A380web_getUserRolesNoSelList'
          and type = 'P')
   drop procedure A380web_getUserRolesNoSelList
go

/*���ܣ�ȡ���û���û�з��䵽�Ĳ˵�*/
/*@cookieuserid ����Ա���*/
/*@userid������Ȩ������û����*/
/*����:2007-07-09*/
/* write by dpipi */
CREATE     procedure A380web_getUserRolesNoSelList 
@cookieuserid varchar(10),
@userid varchar(10)
as
begin
    declare @roles bit,
        @dptype int,
        @depotid varchar(10),
        @merchantid varchar(10),
        @parentid varchar(10)
    
    select @roles=usermain,@depotid=depotid,@merchantid=mb,@dptype=isnull(dptype,0) from webvw_user where userid=@cookieuserid
    /*�ܲ������û�*/
    if @roles=1 and @dptype=0 
    begin	
	--case �����û������---
	 select a.rolesid,a.rolesname,a.comment,cast(0 as bit) as sel 
		        from aspnetdb.dbo.web_roles a
		            where rolesid  in 
	                       (
					--ȡ���û�δѡ�Ĳ˵���ɫ---
					select rolesid 
					   from aspnetdb.dbo.web_rolesaspx 
					       where aspxid not in 
					          (
					              --ȡ���û���ѡ�Ĳ˵��ɣ�---
					               select aspxid   from aspnetdb.dbo.web_userrole where username=@userid
					           ) 
					    group by rolesid 
	
	                       )
	            return
    end
    
    /*�����û�*/
        select a.rolesid,a.rolesname,a.comment,cast(0 as bit) as sel 
	    from aspnetdb.dbo.web_roles a where
	        rolesid not in 
                (
                   --ȡ���û�δѡ�Ĳ˵���ɫ---
                    select rolesid 
				   from aspnetdb.dbo.web_rolesaspx 
				       where aspxid not in 
				          (
				              --ȡ���û���ѡ�Ĳ˵��ɣ�---
				               select aspxid   from aspnetdb.dbo.web_userrole where username=@userid
				           ) 
				    group by rolesid 
                )
                and rolesid  in 
                    ( select rolesid  from aspnetdb.dbo.web_userrole 
                      group by rolesid ,username     
                       having username=@cookieuserid
                    )

end

GO

if exists (select 1
          from sysobjects
          where name = 'A380user_del'
          and type = 'P')
   drop procedure A380user_del
go

/*���ܣ�ɾ�����û�*/

/*����:2007-07-09*/
/* write by dpipi */
create procedure A380user_del
@userid varchar(4)
as
begin
   delete j_user where userid=@userid
end

GO


if exists (select 1
          from sysobjects
          where name = 'A380user_insert'
          and type = 'P')
   drop procedure A380user_insert
go

/*���ܣ�insert���û�*/
/*����:2007-07-09*/
/* write by dpipi */
create procedure A380user_insert
@userid varchar(4),
@username varchar(10),
@depotid varchar(10),
@mb varchar(10),
@dptype int,
@notuse bit
as
begin
   insert j_user(userid,username,depotid,mb,dptype,notuse,password) values(@userid,@username,@depotid,@mb,@dptype,@notuse,123)
end

GO



if exists (select 1
          from sysobjects
          where name = 'A380user_selectgroup'
          and type = 'P')
   drop procedure A380user_selectgroup
go

/*���ܣ���ȡ���û�*/
/*����:2007-07-09*/
/* write by dpipi */
create procedure A380user_selectgroup
@type int,
@depotid varchar(10),
@merchantid varchar(10)
as
begin
if @type=0 
select userid,username,usermain,notuse
	from j_user 
	where mb=@merchantid and dptype=@type
	order by userid
else
if @type=1
select userid,username,usermain,notuse
	from j_user 
	where mb=@merchantid and dptype=@type
	order by userid
else
if @type=2 
select userid,username,usermain,notuse
	from j_user 
	where mb=@merchantid and dptype=@type
	order by userid
if @type=3 
select userid,username,usermain,notuse
	from j_user 
	where mb=@merchantid and dptype=@type
	order by userid
if @type=4 
select userid,username,usermain,notuse 
	from j_user 
	where depotid=@depotid and dptype=@type
	order by userid
else
select userid,username,usermain,notuse
	from j_user 
    where 1=2

end

GO

if exists (select 1
          from sysobjects
          where name = 'A380user_selectoneall'
          and type = 'P')
   drop procedure A380user_selectoneall
go

/*���ܣ���ȡ���û�*/
/*����:2007-07-09*/
/* write by dpipi */
create procedure A380user_selectoneall 
@userid varchar(4)
as
begin
SELECT userid, username, password, usermain, notuse, pexport, pprint, pchk, psure, padd, 
      pedit, pdel, punchk, punsure, comment, crdate, pwr_grid, pwr_form, pwr_depot, 
      pwr_merchant, pwr_style, pwr_log, pwr_spid, updatetime, pwr_cost, pwr_price, 
      pwr_dis, pwr_rdis, pwr_sprice, depotid, message, download, usergroup, UpExeId, 
      merchantid, mb, dptype, crbm,  reg, pos_mdjp, pos_mdxp, pos_mdsp, 
      pos_mdzk, pos_back, regpc, regpcv 
FROM dbo.j_user where userid=@userid
end

GO

if exists (select 1
          from sysobjects
          where name = 'A380user_update'
          and type = 'P')
   drop procedure A380user_update
go

/*���ܣ�update���û�*/
/*����:2007-07-09*/
/* write by dpipi */
create procedure A380user_update
@userid varchar(4),
@username varchar(10),
@usermain bit,
@notuse bit
as
begin
   update j_user set username=@username,usermain=@usermain,notuse=@notuse where userid=@userid
end

GO