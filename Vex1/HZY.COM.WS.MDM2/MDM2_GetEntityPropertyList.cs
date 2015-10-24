using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM2_GetEntityPropertyList 
/// 类说明：根据Entity的编号获取MDM中Entity列的配置
/// 创建人：马卫清
/// 创建日期：2013-04-28
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 根据Entity的编号获取MDM中Entity列的配置
    /// </summary>
    public class MDM2_GetEntityPropertyList : LogicBase, ILogicGetData
    {
        public MDM2_GetEntityPropertyList()
        {
            this.m_SessionCheck = false;

        }

        private string m_MainEntity = "";

        public string MainEntity
        {
            get { return m_MainEntity; }
            set { m_MainEntity = value; }
        }


        /// <summary>
        /// 根据Entity的编号获取MDM中Entity列的配置
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {


                DataSet ds = new DataSet();
                DataSet dsRequest = new DataSet();

                string strMainEntity = "";

                if (m_request != null)
                {
                    strMainEntity = m_request.Tables[0].Rows[0]["Entity"].ToString();
                }
                else
                {
                    strMainEntity = m_MainEntity;
                }

                if (strMainEntity == "")
                {
                    throw new Exception("实体编号不能为空！");
                }

                //获取所有的列
                Dbconn conn = new Dbconn("MDM_Master2");
                ds = conn.GetDataSet(@"
                    SELECT Property_Name FROM dbo.Lib_ExdPropertyList
                    WHERE MDM_Entity='" + strMainEntity + @"'
                    ");

                return ds;
            }
            catch
            {
                throw;

            }



        }

    }

}