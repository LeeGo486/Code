using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：MDM_System_Property_Info_GetList 
/// 类说明：取到系统属性值的交叉表
/// 创建人：马卫清
/// 创建日期：2012-12-03
/// 修改人：
/// 修改日期：
namespace HZY.COM.ST1005A
{
    /// <summary>
    ///MDM_System_Property_Info_GetList 取到系统属性值的交叉表
    /// </summary>
    public class MDM_System_Property_Info_GetList : LogicBase, ILogicGetData
    {
        public MDM_System_Property_Info_GetList()
        {
            this.m_SessionCheck = false;

        }


        /// <summary>
        /// 取到系统属性值的交叉表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {

            //由于分页实现比较麻烦，目前只对行数进行控制，没有控制筛选和排序功能

            int nPage = 1;
            int nPageRowCount = 20;
            string strOrder = " ASC  ";
            string strSort = " System_CODE";
            string strWhere = " ";

            if (m_request != null && m_request.Tables.Contains("Page_Info"))
            {
                nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;

                //如果不是对列进行筛选，那么传入系统列表的筛选
                if (m_request.Tables[0].Rows[0]["where"].ToString().Trim() != ""
                    && m_request.Tables[0].Rows[0]["where"].ToString().Trim().Length > 3
                    && m_request.Tables[0].Rows[0]["where"].ToString().Substring(0, 3) == "col")
                {
                    
                    m_request.Tables[0].Rows[0]["where"] = "";
                    m_request.Tables[0].Rows[0]["page"] = 1;
                    m_request.Tables[0].Rows[0]["pagerows"] = 10000;
                }
             }
            strOrder = " ASC  ";
            Dbconn conn = new Dbconn("MDM");

            //取到系统列表(已将分页信息传入)
            MDM_System_GetList sysList = new MDM_System_GetList();
            sysList.Request = m_request;
            DataSet ds_System = sysList.GetData();

            //取到属性表
            MDM_System_Property_GetList sysPorList = new MDM_System_Property_GetList();
            DataSet ds_Property = sysPorList.GetData();
            DataSet ds = new DataSet("Data");

            string strSystem_IDList = "0";
            for (int i = 0; i < ds_System.Tables[0].Rows.Count; i++)
            {
                if (strSystem_IDList.Length>0)
                {
                    strSystem_IDList += ",";

                }
                strSystem_IDList += ds_System.Tables[0].Rows[i]["System_ID"].ToString();
            }

            //取到属性值数据
            DataTable dt = conn.GetDataTable(@" SELECT [Property_Info_ID]
                  ,[System_ID]
                  ,[System_Code]
                  ,[Property_ID]
                  ,[Property_Text]
              FROM [MDM].[dbo].[MDM_System_Property_Info] WITH(NOLOCK)
              Where System_ID in (" + strSystem_IDList + ")", new string[0]);


            //添加列:
            for (int i = 0; i < ds_Property.Tables[0].Rows.Count; i++)
            {
                ds_System.Tables[0].Columns.Add("col"+ds_Property.Tables[0].Rows[i]["Property_ID"].ToString());
            }


            //将值放进去
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string strSystem_ID = dt.Rows[i]["System_ID"].ToString();
                string strProperty_ID = "col" + dt.Rows[i]["Property_ID"].ToString();

                DataRow[] dr = ds_System.Tables[0].Select("System_ID=" + strSystem_ID);
                if (dr.Length > 0 && ds_System.Tables[0].Columns.Contains(strProperty_ID))
                {
                    dr[0][strProperty_ID] = dt.Rows[i]["Property_Text"].ToString();
                }
            }

            DataSet ds_return = new DataSet();
            DataTable dt1 = ds_System.Tables[0].Clone();
            if (strWhere.Trim() != "")
            {
                DataRow[] dr1 = ds_System.Tables[0].Select(strWhere);

                for (int i = (nPage-1)*nPageRowCount; i < dr1.Length; i++)
                {
                    if (i == nPage * nPageRowCount-1)
                    {
                        break;
                    }
                    dt1.ImportRow(dr1[i]);

                }
                ds_return.Tables.Add(dt1);
                ds_System.Tables["PageRowCount"].Rows[0][0] = dr1.Length;

            }
            else
            {
                ds_return.Tables.Add(ds_System.Tables["Data"].Copy());
            }

            ds_return.Tables.Add(ds_System.Tables["PageRowCount"].Copy());//分页信息
            ds_System = null;

            return ds_return;
        }

    }

}