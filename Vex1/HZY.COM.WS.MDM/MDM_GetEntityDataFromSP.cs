using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_GetEntityData 
/// 类说明：执行SP_Create_Market_Table_New存储过程
/// 创建人：马卫清
/// 创建日期：2013-04-27
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 执行SP_Create_Market_Table_New存储过程
    /// </summary>
    public class MDM_GetEntityData : LogicBase, ILogicGetData
    {
        public MDM_GetEntityData()
        {
            this.m_SessionCheck = false;

        }

        private string m_TableType = "UI";

        public string TableType
        {
            get { return m_TableType; }
            set { m_TableType = value; }
        }


        /// <summary>
        /// 执行SP_Create_Market_Table_New存储过程
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strTableName = "GetData";
                string strTableColumns = "";
                string strWhere = "";
                string strMainEntity = "";

                DataSet returnDs = new DataSet();
                if (m_request != null)
                {
                    for (int i = 0; i < m_request.Tables[0].Rows.Count; i++)
                    {
                        strTableColumns = m_request.Tables[0].Rows[i]["Columns"].ToString();
                        strWhere = m_request.Tables[0].Rows[i]["Where"].ToString();
                        strMainEntity = m_request.Tables[i].Rows[0]["MainEntity"].ToString();
                        Dbconn conn = new Dbconn("MDM_Master");

                        string[] strParam;
                        string[] strValue;

                        if (m_request.Tables[0].Columns.Contains("page"))
                        {
                            strValue = new string[8];
                            strParam = new string[8];
                        }
                        else
                        {
                            strValue = new string[5];
                            strParam = new string[5];
                        }

                        strParam[0] = "@TableName";
                        strParam[1] = "@TableColumns";
                        strParam[2] = "@Where";
                        strParam[3] = "@MainEntity";
                        strParam[4] = "@TableType";


                        strValue[0] = strTableName;
                        strValue[1] = strTableColumns;
                        strValue[2] = strWhere;
                        strValue[3] = strMainEntity;
                        strValue[4] = m_TableType;

                        if (m_request.Tables[0].Columns.Contains("page"))
                        {
                            strParam[5] = "@Page";
                            strParam[6] = "@PageRowCount";
                            strParam[7] = "@OrderBy";

                            strValue[5] = m_request.Tables[0].Rows[0]["page"].ToString();
                            strValue[6] = m_request.Tables[0].Rows[0]["PageRowCount"].ToString();
                            strValue[7] = m_request.Tables[0].Rows[0]["Order"].ToString();
                        }

                        DataSet ds = new DataSet();

                        ds = conn.GetDataSetBySP("SP_Create_Market_Table_New", strParam, strValue);

                        if (ds.Tables[0].Columns.Contains("STATE"))
                        {
                            throw new Exception("Error:" + ds.Tables[0].Rows[0]["Message"].ToString());
                        }

                        
                        //ds.Tables[0].Columns.Remove("timestamps");
                        //ds.Tables[0].Columns.Remove("rowIndex");

                        returnDs.Tables.Add(ds.Tables[0].Copy());

                        if (ds.Tables.Count > 1)
                        {
                            ds.Tables[1].TableName = "PageRowCount";
                            returnDs.Tables.Add(ds.Tables[1].Copy());
                        }
                    }

                }
                return returnDs;
            }
            catch
            {
                throw;

            }



        }

    }

}