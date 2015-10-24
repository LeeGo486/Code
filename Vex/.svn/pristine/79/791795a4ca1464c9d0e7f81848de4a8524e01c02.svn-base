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


/// 类名：MDM2_GetEntityBYName
/// 类说明：根据表名获取MDM2的所有数据
/// 创建人：马卫清
/// 创建日期：2013-11-07
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 根据表名获取MDM2的所有数据
    /// </summary>
    public class MDM2_GetEntityBYName : LogicBase, ILogicGetData
    {
        public MDM2_GetEntityBYName()
        {
            this.m_SessionCheck = true;

        }


        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        /// <summary>
        /// 部署WS,为Easyui专用
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {

            try
            {
                DataSet ds = new DataSet();
                DataSet dsRequest = new DataSet();


                int nPage = 1;
                int nPageRowCount = 200000;
                string strOrder = " desc  ";
                string strSort = " body_id ";
                string strWhere = " 1=1 ";
                string strSearchFilter = "";

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                if (strXML == "")
                {
                    throw new Exception("提交的XML为空！");
                }

                string strWhereTemp = "";
                if (m_request != null && m_request.Tables[0].Columns.Contains("where"))
                {
                    strWhereTemp = m_request.Tables[0].Rows[0]["where"].ToString();
                }

                if (m_request != null && m_request.Tables[0].Columns.Contains("page"))
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                    strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;




                    if (strSearchFilter.Trim() != "")
                    {
                        strWhere += " AND " + strSearchFilter;
                    }
                }

                if (strWhereTemp.Trim() != "")
                {
                    strWhere += " AND " + strWhereTemp;
                }
                DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);


                string strTableName = "";
                strTableName = dsXML.Tables["List"].Rows[0]["TableName"].ToString();

                if (strTableName == "")
                {
                    throw new Exception("TableName不能为空！");
                }

                Dbconn conn = new Dbconn("MDM_Market2");

                string strSQL = @"
                      select
                          CASE WHEN name = 'timestamps'  THEN 'ISNULL(CONVERT(bigint,' + c.name + '),0' + ') as ' + c.name + ','
                            ELSE 'ISNULL(CONVERT(VARCHAR(MAX),' + c.name + '),''''' + ') as ' + c.name + ','
                        END
                    from syscolumns c
                    where c.id = object_id('dbo." + strTableName + @"')
                    FOR XML path('')
                ";

                string strColumns = "";
                DataTable dtTmp = conn.GetDataTable(strSQL);
                for (int i = 0; i < dtTmp.Rows.Count; i++)
                {
                    strColumns += dtTmp.Rows[i][0].ToString();
                }

                strColumns = strColumns.Substring(0, strColumns.Length - 1);

                strSQL = " SELECT  " + strColumns + " FROM " +strTableName+@" WHERE     "+strWhere;

                ds = conn.GetDataSetForPageList(strSQL,new string[]{},nPage,nPageRowCount,strSort+" " + strOrder);
               
                return ds;
            }
            catch
            {
                throw;

            }


        }

        private void GetAUZ()
        {
            ST1005A.MDM_System_User_Authorization_GetListBySession_ID cls = new ST1005A.MDM_System_User_Authorization_GetListBySession_ID();
            cls.hzyMessage = this.hzyMessage;
            DataSet ds = cls.GetData();
        }
    }

}