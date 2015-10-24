using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_Store_App_From_F22_GetList 
/// 类说明：获取F22相关的店铺链接数据
/// 创建人：马卫清
/// 创建日期：2013-05-04
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取F22相关的店铺链接数据
    /// </summary>
    public class MDM_Store_App_From_F22_GetList : LogicBase, ILogicGetData
    {
        public MDM_Store_App_From_F22_GetList()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 获取F22相关的店铺链接数据
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet dsRequest = new DataSet();

                string strMainEntity = "006";
                string strAppBodyID = m_request.Tables[0].Rows[0]["AppBodyID"].ToString();

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

                DataSet ds_Store= mdm.GetData();


                //取到Link的数据
                dt.Clear();
                dt.Columns.Remove("page");
                dt.Rows.Add(new object[] { "", "body_ID_L01='"+strAppBodyID+"'", "L05"});
                DataSet ds_App_Store_Link = mdm.GetData();

                ds_Store.Tables[0].Columns.Add("body_ID_L01");
                ds_Store.Tables[0].Columns.Add("body_ID_L05");
                ds_Store.Tables[0].Columns["body_ID_L01"].SetOrdinal(0);
                //ds_Store.Tables[0].Columns["body_ID_L05"].SetOrdinal(0);
                for (int i = 0; i < ds_Store.Tables[0].Rows.Count; i++)
                {
                    string strBodyID = ds_Store.Tables[0].Rows[i]["body_id"].ToString();
                    DataRow[] dr = ds_App_Store_Link.Tables[0].Select("Body_ID_006='"+strBodyID+"'");
                    if (dr.Length > 0)
                    {
                        ds_Store.Tables[0].Rows[i]["body_ID_L01"] = dr[0]["body_ID_L01"].ToString();
                        ds_Store.Tables[0].Rows[i]["body_ID_L05"] = dr[0]["body_ID"].ToString();
                    }
                }
                return ds_Store;
            }
            catch
            {
                throw;

            }



        }

    }

}