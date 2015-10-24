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


/// 类名：MDM2_BodyIDCheck
/// 类说明：核对BodyID是否正确
/// 创建人：马卫清
/// 创建日期：2013-11-09
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 核对BodyID是否正确
    /// </summary>
    public class MDM2_BodyIDCheck : LogicBase, ILogicExecute
    {
        public MDM2_BodyIDCheck()
        {
            this.m_SessionCheck = true;
        }

        #region 属性定义
        private Dbconn m_Conn = null;

        string m_MDMClass = "";
        string m_Message = "";
        string m_Body_ID = "";

        public string Body_ID
        {
            get { return m_Body_ID; }
            set { m_Body_ID = value; }
        }

        public string Message
        {
            get { return m_Message; }
            set { m_Message = value; }
        }

        public string MDMClass
        {
            get { return m_MDMClass; }
            set { m_MDMClass = value; }
        }
        public Dbconn Conn
        {
            get { return m_Conn; }
            set { m_Conn = value; }
        }
        #endregion

        #region Execute
        /// <summary>
        /// 核对BodyID是否正确
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {
            if (m_Body_ID == "")
            {
                return false;
            }
            int nCount = m_Conn.GetDataTableRowCount(@"SELECT * FROM 
                                                        MDM_Master2.dbo.MDM_" + m_MDMClass + @"_B
                                                        WHERE Body_ID='" + m_Body_ID + "'");
            if (nCount > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        #endregion
    }

}