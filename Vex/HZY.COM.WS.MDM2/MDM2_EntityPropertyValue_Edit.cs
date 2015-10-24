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


/// 类名：MDM2_Entity_Edit
/// 类说明：编辑实体属性值
/// 创建人：马卫清
/// 创建日期：2013-11-07
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 编辑实体信息
    /// </summary>
    public class MDM2_EntityPropertyValue_Edit : LogicBase, ILogicExecute
    {
        public MDM2_EntityPropertyValue_Edit()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn m_Conn = null;

        string m_MDMClass = "";
        string m_Message = "";

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
        string m_PropertyName = "";

        public string PropertyName
        {
            get { return m_PropertyName; }
            set { m_PropertyName = value; }
        }
        string m_ExpressionName = "";

        public string ExpressionName
        {
            get { return m_ExpressionName; }
            set { m_ExpressionName = value; }
        }
        string m_PropertyValue = "";

        public string PropertyValue
        {
            get { return m_PropertyValue; }
            set { m_PropertyValue = value; }
        }
        string m_BodyID = "";

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



        /// <summary>
        /// 编辑实体信息
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {

            bool bRollBack = false;
            try
            {
                if (m_Conn == null)
                {
                    m_Conn = new Dbconn("MDM_Master2");
                    bRollBack = true;
                }
                string[] strParam = new string[6];
                string[] strValue = new string[6];

                strParam[0] = "@MDMClass";
                strParam[1] = "@PropertyName";
                strParam[2] = "@ExpressionName";
                strParam[3] = "@PropertyValue";
                strParam[4] = "@BodyID";
                strParam[5] = "@TranControl";

                strValue[0] = m_MDMClass;
                strValue[1] = m_PropertyName;
                strValue[2] = m_ExpressionName;
                strValue[3] = m_PropertyValue;
                strValue[4] = m_BodyID;
                strValue[5] = "0";

                DataSet ds = m_Conn.GetDataSetBySP("SP_0040_Update_Property_Value", strParam, strValue);

                if (ds.Tables[0].Rows[0]["Result"].ToString().ToLower() == "false")
                {
                    this.m_Message = ds.Tables[0].Rows[0]["Message"].ToString();
                    return false;
                }

                if (bRollBack)
                {
                    m_Conn.CommitTransaction();
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