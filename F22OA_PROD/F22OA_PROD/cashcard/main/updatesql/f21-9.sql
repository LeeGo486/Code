
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


SELECT a.cardid, a.cardname, a.sums, a.crdate, a.lastdate, a.crname, dbo.ReturnStrIntercept(a.comment) as comment, 
		a.start, a.proposerid, a.[password], a.depotid, a.congeal, a.dbname,b.names, c.d_name,d.username,e.statename
from  cashcard.dbo.j_card a ,cashcard.dbo.j_proposer b,j_depot c,j_user d,cashcard.dbo.j_card_state e
where a.proposerid*=b.proposerid and start=@used and cardid>=@cardidBeg and cardid<=@cardidEnd
		and a.depotid*=c.depotid and a.crname*=d.userid and a.start*=e.id
		and a.dbname=@dbname and a.dbname=@dbname and isnull(a.depotid,'')=''



GO
