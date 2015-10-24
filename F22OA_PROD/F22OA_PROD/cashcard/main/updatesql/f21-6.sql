IF EXISTS (SELECT name FROM sysobjects 
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
	where  a.dbname=@dbname and a.depotid=@depotid and a.depotid*=b.depotid
end
else
begin
	select a.*,b.d_name from  cashcard.dbo.d_logging a,j_depot b
	where  a.dbname=@dbname and a.depotid=@depotid and a.cardid=@cardid and a.depotid*=b.depotid
end


GO