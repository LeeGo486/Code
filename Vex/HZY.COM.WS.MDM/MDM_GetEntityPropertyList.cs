using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_GetEntityPropertyList 
/// 类说明：根据Entity的编号获取MDM中Entity列的配置
/// 创建人：马卫清
/// 创建日期：2013-04-28
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 根据Entity的编号获取MDM中Entity列的配置
    /// </summary>
    public class MDM_GetEntityPropertyList : LogicBase, ILogicGetData
    {
        public MDM_GetEntityPropertyList()
        {
            this.m_SessionCheck = false;

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
                strMainEntity = m_request.Tables[0].Rows[0]["Entity"].ToString();

                //获取所有的列
                Dbconn conn = new Dbconn("MDM_Master");
                ds = conn.GetDataSet(@"
                    SELECT Property_Name FROM dbo.Lib_ExdPropertyList
                    WHERE Class_Name='" + strMainEntity + @"'
                    Order BY ColumnIndex
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