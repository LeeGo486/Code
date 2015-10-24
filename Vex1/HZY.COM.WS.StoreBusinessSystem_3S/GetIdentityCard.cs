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

/// 类名：HZY.COM.WS.StoreBusinessSystem_3S
/// 类说明：通过手机获取身份证号(手机\微信号\身份证\密码获取)
/// 创建人：郭琦琦
/// 创建日期：2014-10-13 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.StoreBusinessSystem_3S
{
    public class GetIdentityCard : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public GetIdentityCard()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("VexSSO");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataSet ds_Return_mdm = new DataSet();

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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetIdentityCardInfo".ToUpper())//通过手机号获取身份证和一些其他信息
                {
                    GetIdentityCardInfo(dtList);
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

        #region 获取数据
        /// <summary>
        /// 获取数据
        /// </summary>
        private void GetIdentityCardInfo(DataTable pdt)
        {

            string stroid = pdt.Rows[0]["oid"].ToString();

            string strGetIdentityCardInfoSQL = @"SELECT  VexSSOLoginUser tel ,
                                                        t4.App_UserName wxid ,
                                                        t5.App_UserName username ,
                                                        App_PasswordSrc identitycard
                                                FROM    ( SELECT    t1.VexSSONewID ,
                                                                    t3.VexSSOLoginUser ,
                                                                    t1.App_UserName
                                                          FROM      dbo.MDM_System_User t1
                                                                    LEFT JOIN B01_MDM.VEXSSOUser t3 ON t3.VexSSONewID = t1.VexSSONewID
                                                          WHERE     ISNULL(checked, 0) = 1
                                                                    AND EXISTS ( SELECT 1
                                                                                 FROM   dbo.MDM_System_Env t2
                                                                                 WHERE  Env_SN = '3SWeChat'
                                                                                        AND t1.Env_ID = t2.Env_ID )
                                                        ) t4
                                                        LEFT JOIN [dbo].[MDM_System_User] t5 ON t4.VexSSONewID = t5.VexSSONewID
                                                                                                AND t5.Env_ID = ( SELECT
                                                                                                                        Env_ID
                                                                                                                        FROM
                                                                                                                        MDM_System_Env
                                                                                                                        WHERE
                                                                                                                        Env_SN = 'EHRCard'
                                                                                                                        )
                                                WHERE   t4.App_UserName = '" + stroid + "'";
            ds_Return = m_conn.GetDataSet(strGetIdentityCardInfoSQL, new string[] { });
        }
        #endregion


        #endregion
    }
}
