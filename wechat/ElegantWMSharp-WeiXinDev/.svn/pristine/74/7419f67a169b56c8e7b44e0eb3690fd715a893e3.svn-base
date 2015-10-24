using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Data;
using System.Data.SqlClient;

/**
 * 作者：WebMisSharp
 * 时间：2014-12-09 18:04:31
 * 功能：数据访问层
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

 namespace ElegantWM.DAL
{
    public class Fire_QuestionDAL : EFRepository<Fire_Question>, IFire_QuestionDAL
    {
		/* 如果是多数据库，请开启
        public Fire_QuestionDAL()
            : base("Your web.config DbConnectString")
        {

        }
		*/

        #region 获取消防题目所有信息
        public DataTable FireKnowLedgeInfo(string TntId)
        {
            string strSQL = @"SELECT 
                                [Question]
                               ,[Answer]
                               ,[IsRight] 
                             FROM [dbo].[Fire_Question] T1
                             JOIN [dbo].[Fire_Answer] T2 ON T1.Id = T2.Qid
                             WHERE 1=1 AND [TntId] = '" + TntId + "'";
            return Query(strSQL, null);
        }
        #endregion

        #region 获取消防题目表头
        public DataTable FireKnowLedgeHead(string TntId) {
            string strSQL = @"SELECT 
                                [Question]
                             FROM [dbo].[Fire_Question] T1
                             WHERE 1=1 AND [TntId] = '" + TntId + "' ORDER BY NEWID()";
            return Query(strSQL, null);
        }
        #endregion
    }
}
