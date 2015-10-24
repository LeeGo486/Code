using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Employees_GetBySessionID 
/// 类说明：通过Session_ID获取MDM人员信息
/// 创建人：马卫清
/// 创建日期：2013-03-22
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_Employees_GetBySessionID 通过Session_ID获取MDM人员信息
    /// </summary>
    public class MDM_Employees_GetBySessionID : LogicBase, ILogicGetData
    {
        public MDM_Employees_GetBySessionID()
        {
            this.m_SessionCheck = true;

        }

        /// <summary>
        /// 获取MDM人员信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strVexSSONewID = m_hzyMessage.VexSSONewID;

                Dbconn conn = new Dbconn("VexSSO");
                DataSet ds = conn.GetDataSet(@"
                 SELECT  0 [Employee_ID] ,
                        t2.[Name] ,
                        '' [Sex] ,
                        t2.Phone [Phone] ,
                        t1.VexSSOLoginUser [Moblie] ,
                        t1.VexSSOLoginUser [SSO_UserName] ,
                        NULL [In_Time] ,
                        NULL [Leave_Time] ,
                        NULL [Leave_Flag] ,
                        NULL [IsActived]
                FROM    B01_MDM.[VEXSSOUser] t1
                        LEFT JOIN B01_MDM.[VexSSOUserInfo] t2 ON t2.VexSSONewId = t1.VexSSONewID
                WHERE t1.VexSSONewId=@param0
                    ", new string[1] { strVexSSONewID });

                return ds;
            }
            catch  
            {
                throw;

            }



        }

    }

}