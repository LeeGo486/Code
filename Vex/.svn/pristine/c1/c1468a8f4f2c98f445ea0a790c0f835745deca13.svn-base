using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：AMUser
/// 类说明：AMUser基本信息获取
/// 创建人：郭琦琦
/// 创建日期：2015-03-23
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.CommonInterface
{
    public class AMUser : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public AMUser()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("AM");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheackAMUser".ToUpper()) //通过用户登入名获取显示名和密码 
                {
                    CheackAMUser(dtList);
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数


        #region 通过用户登入名获取显示名和密码
        /// <summary>
        /// 通过用户登入名获取显示名和密码
        /// </summary>
        private void CheackAMUser(DataTable pdt)
        {

            string strAM_login = pdt.Rows[0]["AM_login"].ToString();
            string strAM_Password = pdt.Rows[0]["AM_Password"].ToString();

            string SQL = @" SELECT  cn_id AS AM_User_id ,
                                    CN_LOGIN AS AM_login ,
                                    CN_USER_NAME AS AM_User_Name ,
                                    CN_PASSWORD AM_Password ,
                                    CN_EMAIL AM_Email ,
                                    CN_TITLE AM_Title ,
                                    CN_HANDSET AM_Handset ,
                                    CN_ISDELETE AM_IsDelete
                            FROM    dbo.TN_SYS_EM_USER t1 WITH (NOLOCK),
                                    dbo.TN_SYS_EM_USER_PROP t2 WITH (NOLOCK)
                            WHERE   t1.cn_id = t2.CN_USERID and CN_LOGIN=@param0  AND CN_PASSWORD=@param1 AND [CN_ISDELETE]=0 ";
            ds_Return = m_conn.GetDataSet(SQL, new string[] { strAM_login, strAM_Password });
        }
        #endregion

        #endregion
    }
}
