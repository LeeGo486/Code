using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;

/**
 * 作者：WebMisSharp
 * 时间：2014/6/15 22:28:59
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
    public class WXMenuDAL : EFRepository<WX_Menu>, IWXMenuDAL
    {
        /* 如果是多数据库，请开启
        public WXMenuDAL()
            : base("Your web.config DbConnectString")
        {

        }
        */


        /// <summary>
        /// 复制行业菜单模板
        /// </summary>
        /// <param name="idtId">行业菜单id</param>
        /// <param name="wxId">微信号id</param>
        /// <param name="user">用户</param>
        /// <returns></returns>
        public bool CopyMenu(Guid idtId, Guid wxId, string user)
        {
            string sql = @"DELETE FROM WX_Menu WHERE AccountId='{0}';
                        SELECT NEWID() Id,Id AS OldId,'{0}' AccountId,Name,Type,RespType,KeyUrl,OrderIndex,FatherId,CreateUser
                        INTO #TEMP FROM OO_MenuTemplate WHERE IdtId='{2}';
                        UPDATE #TEMP SET #TEMP.FatherId = T.Id FROM #TEMP T,#TEMP WHERE #TEMP.FatherId=T.OldId;
                        INSERT INTO WX_Menu ( Id,AccountId,Name,Type,RespType,KeyUrl,OrderIndex,FatherId,CreateUser,CreateTime)
                        SELECT Id,AccountId,Name,Type,RespType,KeyUrl,OrderIndex,FatherId,'{1}',GETDATE() FROM #TEMP;";
            sql = string.Format(sql, wxId, user, idtId);
            RunCmd(sql);
            return true;
        }
    }
}
