using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Collections;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：Menu
/// 类说明：根据SessionID获取菜单
/// 创建人：马卫清
/// 创建日期：2014-04-15
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{

    public class Menu : HZYLogicBase, ILogicGetData
    {
        public Menu()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("WSRR");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();

                string strSessionID = hzyMessage.Session_ID;

                string strSQL = @"
                                SELECT  DISTINCT
		                            t4.MenuID ,
                                    t4.MenuName ,
                                    t4.MenuFatherID ,
                                    t4.ActionURL	
                                FROM  [F01_CERT].[Login] t1
                                LEFT JOIN [F01_CERT].[UserAUZ] t3 ON t1.LoginUser=t3.[UserName]
                                LEFT JOIN [F01_CERT].[AUZMenu] t2 ON t2.AUZID=t3.AUZID
                                LEFT JOIN [F01_CERT].[Menu] t4 ON t4.MenuID=t2.MenuID
                                WHERE t1.loginsessionid=@Param0
                                AND LogoutTime IS NULL
                                AND DATEADD(day,1,t1.[LoginTime])>GETDATE()
                                AND t4.MenuID IS NOT null
                                Order by MenuName ASC
                ";
                DataSet dsMenu = conn.GetDataSet(strSQL, new string[] { strSessionID });
                FindFatherMenu(dsMenu, conn);//添加父节点的菜单信息

                dsMenu.Tables[0].Columns.Add("Leaver", typeof(Int32));
                SetLeaver(dsMenu, "0", 0);
                return dsMenu;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }

        private void FindFatherMenu(DataSet ds, Dbconn conn)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string strMenuFatherID = ds.Tables[0].Rows[i]["MenuFatherID"].ToString();
                if (strMenuFatherID == "")
                {
                    continue;
                }

                DataRow[] dr = ds.Tables[0].Select("MenuID='" + strMenuFatherID+"'"); //找到是否已经存在父节点
                if (dr.Length > 0)
                {
                    continue;
                }
                DataTable dt = conn.GetDataTable(@"
                         SELECT MenuID ,
                                MenuName ,
                                MenuFatherID ,
                                ActionURL
                         FROM   F01_Cert.Menu
                         WHERE MenuID='" + strMenuFatherID + @"'
                ", new string[0]);

                if (dt.Rows.Count > 0)
                {
                    ds.Tables[0].ImportRow(dt.Rows[0]);
                }
            }
        }

        private void SetLeaver(DataSet ds, string strMenuID, int nLeaver)
        {
            DataRow[] dr = ds.Tables[0].Select("MenuFatherID='" + strMenuID+"'");
            for (int i = 0; i < dr.Length; i++)
            {
                dr[i]["Leaver"] = nLeaver + 1;
                string strMenuID1 = dr[i]["MenuId"].ToString();
                SetLeaver(ds, strMenuID1, nLeaver + 1);
            }
        }
    }
}
