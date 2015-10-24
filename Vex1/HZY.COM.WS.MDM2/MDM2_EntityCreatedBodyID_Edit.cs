using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：MDM2_EntityCreatedBodyID_Edit
/// 类说明：编辑BodyID
/// 创建人：马卫清
/// 创建日期：2013-11-07
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 编辑BodyID
    /// </summary>
    public class MDM2_EntityCreatedBodyID_Edit : LogicBase,ILogicExecute
    {
        public MDM2_EntityCreatedBodyID_Edit()
        {
            this.m_SessionCheck = true;
        }

        #region 属性
        private Dbconn m_Conn = null;

        string m_BodyID = "";
        string m_MDMClass = "";
        string m_LinkBodyIDList = "";

        public string LinkBodyIDList
        {
            get { return m_LinkBodyIDList; }
            set { m_LinkBodyIDList = value; }
        }

        public string MDMClass
        {
            get { return m_MDMClass; }
            set { m_MDMClass = value; }
        }

        public string BodyID
        {
            get { return m_BodyID; }
            set { m_BodyID = value; }
        }

        public Dbconn Conn
        {
            get { return m_Conn; }
            set { m_Conn = value; }
        }

        #endregion

        /// <summary>
        /// 编辑BodyID
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            DataSet ds = new DataSet();
            bool bRollBack = false;
            try
            {
                if (m_Conn == null)
                {
                    m_Conn = new Dbconn("MDM_Master2");
                    bRollBack = true;
                }
                string[] strParam = new string[5];
                string[] strValue = new string[5];

                strParam[0] = "@MDMClass";
                strParam[1] = "@bodyID";
                strParam[2] = "@ReturnTable";
                strParam[3] = "@TranControl";
                strParam[4] = "@LinkBodyIDList";

                strValue[0] = m_MDMClass;
                strValue[1] = m_BodyID;
                strValue[2] = "1";
                strValue[3] = "0";
                strValue[4] = m_LinkBodyIDList;

                ds = m_Conn.GetDataSetBySP("SP_0030_CreateDataBodyID", strParam, strValue);

                if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    m_BodyID = ds.Tables[0].Rows[0][0].ToString();
                }
            }
            catch
            {
                throw;

            }
            finally
            {
                if (bRollBack)
                {
                    m_Conn.RollbackTransaction();
                }
            }


            return true;
        }
    }

}