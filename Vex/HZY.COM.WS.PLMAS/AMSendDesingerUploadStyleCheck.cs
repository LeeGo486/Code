using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using HZY.COM.Common.Base;

/// 类名：AMSendDesingerUploadStyleCheck
/// 类说明：PLMAS-CONF-设计师上传款式提醒
/// 创建人：马卫清
/// 创建日期：2014-04-23
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.PLMAS
{

    public class AMSendDesingerUploadStyleCheck : HZYLogicBase, ILogicExecute
    {
        public AMSendDesingerUploadStyleCheck()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("PLM_AS");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        public bool Execute()
        {
            try
            {
                DataSet ds = new DataSet();
                ds = conn.GetDataSet(@"
                                        SELECT  Designer ,
                                                t2.username,
                                                t2.password,
                                                t1.brand,
                                                COUNT(1) AS cnt
                                        FROM    dbo.FLEXPLMProduct t1
                                        LEFT JOIN dbo.USERINFO t2 ON t1.Designer=t2.UserNameC
                                        WHERE   CONVERT(VARCHAR(10), CreateDate, 21) = CONVERT(VARCHAR(10), DATEADD(DAY,
                                                                                                      -1, GETDATE()), 21)
                                        GROUP BY Designer,t2.username,t2.password,t1.brand
                                        ");
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string strUserName = ds.Tables[0].Rows[i]["username"].ToString();
                    string strPassWord = ds.Tables[0].Rows[i]["password"].ToString();
                    string strDesigner = ds.Tables[0].Rows[i]["Designer"].ToString();
                    string strCount = ds.Tables[0].Rows[i]["cnt"].ToString();
                    string strBrand = ds.Tables[0].Rows[i]["brand"].ToString();

                    //strPassWord = Common.Common.GetMD5(strPassWord);

                    string strContent = "";
                    string strURL = "http://192.168.0.35:85/WEB/Base/LoginAndRedirect_PLMAS.html?EnvID=PLM_FZ&UserName={0}&PassWord={1}&URL=../base/main_PLMAS.html?openmenu=/web/PLMAS/FLEXPLMProductCheck.html";
                    strURL = string.Format(strURL, new string[] { strUserName, strPassWord });
                    strContent = strDesigner + @",你好!
        你昨日共上传款式" + strCount + "个！请及时核对款式信息是否正确！<a href=" + strURL + " target=_blank>点击直接登录！</a>";
                    if (Common.Common.m_RouteCode != null && Common.Common.m_RouteCode.ToUpper() == "PROD")
                    {
                        AM.AMSendMsg.Send("AM", "PLMAS", strDesigner, "PLM系统", strContent, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

                    }
                    else
                    {
                        AM.AMSendMsg.Send("AM", "PLMAS", "马卫清", "PLM系统", strContent, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                    }
                    
                }
                return true;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}
