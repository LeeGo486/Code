using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_GetEntityDataByEntity 
/// 类说明：根据Entity的编号获取MDM中Entity的所有数据
/// 创建人：马卫清
/// 创建日期：2013-04-27
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 根据Entity的编号获取MDM中Entity的所有数据
    /// </summary>
    public class MDM_GetEntityDataByEntity : LogicBase, ILogicGetData
    {
        public MDM_GetEntityDataByEntity()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据Entity的编号获取MDM中Entity的所有数据
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


                int nPage = 1;
                int nPageRowCount = 20;
                string strOrder = " desc  ";
                string strSort = " body_id ";
                string strWhere = " ";

                if (m_request != null && m_request.Tables.Contains("Page_Info"))
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                    strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
                    

                    if (strWhere.Trim() != "")
                    {
                        strWhere = " " + strWhere;
                    }
                }

                //获取所有的列
                Dbconn conn = new Dbconn("MDM_Master");
                ds = conn.GetDataSet(@"
                    SELECT Property_Name FROM dbo.Lib_ExdPropertyList
                    WHERE Class_Name='" + strMainEntity + @"'
                    ");

                string strColumns = "";

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    strColumns += "[";
                    strColumns += ds.Tables[0].Rows[i]["Property_Name"].ToString() + ",";
                    strColumns += strMainEntity + ",";
                    strColumns += ds.Tables[0].Rows[i]["Property_Name"].ToString() + ",";
                    strColumns += "CN";
                    strColumns += "]";
                }

                MDM_GetEntityData mdm = new MDM_GetEntityData();
                DataTable dt = new DataTable();
                dt.Columns.Add("Columns");
                dt.Columns.Add("Where");
                dt.Columns.Add("MainEntity");

                dt.Columns.Add("Page");
                dt.Columns.Add("PageRowCount");
                dt.Columns.Add("Order");

                dt.Rows.Add(new object[] { strColumns, strWhere, strMainEntity, nPage, nPageRowCount,strSort + " " + strOrder });

                DataSet ds_request = new DataSet();
                ds_request.Tables.Add(dt);
                mdm.Request = ds_request;

                return mdm.GetData();
            }
            catch
            {
                throw;

            }



        }

    }

}