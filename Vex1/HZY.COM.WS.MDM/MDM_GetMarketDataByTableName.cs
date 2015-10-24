using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


/// 类名：MDM_GetMarketDataByTableName 
/// 类说明：根据表名的获取MDMMarket中对应表所有数据
/// 创建人：马卫清
/// 创建日期：2013-06-19
/// 修改人：马卫清
/// 修改日期：2013-08-04
/// 修改内容：加入权限控制
namespace HZY.COM.MDM
{
    /// <summary>
    /// 根据表名的获取MDMMarket中对应表所有数据
    /// </summary>
    public class MDM_GetMarketDataByTableName : LogicBase, ILogicGetData
    {
        public MDM_GetMarketDataByTableName()
        {
            this.m_SessionCheck = true;

        }


        private string m_TableType = "UI";

        /// <summary>
        /// 返回数据的表类型
        /// </summary>
        public string TableType
        {
            get { return m_TableType; }
            set { m_TableType = value; }
        }


        private bool m_CheckAUZ = false;

        /// <summary>
        /// 是否需要权限认证
        /// </summary>
        public bool CheckAUZ
        {
            get { return m_CheckAUZ; }
            set { m_CheckAUZ = value; }
        }


        ArrayList m_AUZList = new ArrayList();
        string m_MainEntity = "";
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


                int nPage = 1;
                int nPageRowCount = 200000;
                string strOrder = " desc  ";
                string strSort = " body_id ";
                string strWhere = " 1=1 ";

                if (m_request != null && m_request.Tables.Contains("Page_Info"))
                {
                    nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                    nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                    strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                    strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                   
                    string strWhereTemp = m_request.Tables[0].Rows[0]["where"].ToString();

                    if (strWhereTemp.Trim() != "")
                    {
                        strWhere = " AND " + strWhereTemp;
                    } 
                }
                if (m_request != null && m_request.Tables[0].Columns.Contains("TableType"))
                {
                    this.m_TableType = m_request.Tables[0].Rows[0]["TableType"].ToString();
                }

                string strTableName = "";
                strTableName = m_request.Tables[0].Rows[0]["MarketTableName"].ToString();

                if (m_request.Tables[0].Columns.Contains("Condition"))
                { 
                    strWhere += " AND " + m_request.Tables[0].Rows[0]["Condition"].ToString() + " ";
                }

                Dbconn conn = new Dbconn("MDM_Master");

                string strSQL = "SELECT MainEntity,Filter FROM Lib_View_Table WITH(NOLOCK)  WHERE Table_Name = '" + strTableName + "' ";

                //取到主实体信息
                DataTable dtInfo = conn.GetDataTable(strSQL);

                if (dtInfo.Rows.Count == 0)
                {
                    throw new Exception(strTableName + "不存在");
                }

                
                m_MainEntity = dtInfo.Rows[0]["MainEntity"].ToString();

                if (dtInfo.Rows[0]["Filter"].ToString().Trim() != "")
                {
                    strWhere += " AND " + dtInfo.Rows[0]["Filter"].ToString().Trim();
                }

                
                //获取所有的属性列
                string strAUZProperty = " 1=1 ";
                string strAUZEntity = " 1=1 ";

                if (m_CheckAUZ)
                {
                    strAUZProperty = GetAuzProperty(false);
                    if (strAUZProperty == "")
                    {
                        strAUZProperty = " 1=1 ";
                    }

                    //获取所有有权限的实体
                    strAUZEntity = "  Entity IN (" + GetAUZEntity() + @")";

                    //获取权限的过滤条件
                    strWhere += " AND " + GetAUZFilter(strTableName);
                }

                ds = conn.GetDataSet(@"

                SELECT  t2.Porperty_Name ,
                        t2.Table_Property_Name ,
                        Expression_Name ,
                        Entity ,
                        MainEntity ,
                        IsSelfConnection ,
                        [SPType]
                FROM    [dbo].[Lib_View_Table] t1
                        LEFT JOIN dbo.Lib_View_TableColumn t2 ON t1.Table_ID = t2.Table_ID
                        LEFT JOIN dbo.Lib_MDM_Config t3 ON t1.MainEntity = t3.MDM_Entity
                        LEFT JOIN dbo.Lib_AUZ_Property t4 ON t2.Porperty_ID=t4.Property_ID
                WHERE   Table_Name = '" + strTableName + @"'
                        AND Table_Type = 'Market'
                        AND (
                        " + strAUZProperty + @"
                        )
                        AND "+strAUZEntity+@"
                    ");

                if (ds.Tables[0].Rows.Count == 0)
                {
                    return new DataSet();
                }


                string strColumns = "";

                string strMainEntity = ds.Tables[0].Rows[0]["MainEntity"].ToString();

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    strColumns += "[";
                    strColumns += ds.Tables[0].Rows[i]["Table_Property_Name"].ToString() + ",";
                    strColumns += ds.Tables[0].Rows[i]["Entity"].ToString() + ",";
                    strColumns += ds.Tables[0].Rows[i]["Porperty_Name"].ToString() + ",";
                    strColumns += ds.Tables[0].Rows[i]["Expression_Name"].ToString() + ",";

                    strColumns += "]";
                }

                MDM_GetEntityData mdm = new MDM_GetEntityData();

                mdm.TableType = m_TableType;

                DataTable dt = new DataTable();

                dt.Columns.Add("Columns");
                dt.Columns.Add("Where");
                dt.Columns.Add("MainEntity");

                dt.Columns.Add("Page");
                dt.Columns.Add("PageRowCount");
                dt.Columns.Add("Order");

                dt.Rows.Add(new object[] { strColumns, strWhere, strMainEntity, nPage, nPageRowCount, strSort + " " + strOrder });

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

        #region 获取权限，并拼接成为SQL语句
        /// <summary>
        /// 获取权限，并拼接成为SQL语句
        /// </summary>
        /// <param name="pIsbody"></param>
        /// <returns></returns>
        private string GetAuzProperty(bool pIsbody)
        {
            string strReturn = "";

            ST1005A.MDM_System_User_Authorization_GetListBySession_ID cls = new ST1005A.MDM_System_User_Authorization_GetListBySession_ID();
            cls.hzyMessage = this.hzyMessage;
            DataSet ds = cls.GetData();
            if (ds.Tables.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string strAUZ = ds.Tables[0].Rows[i]["Authorization_Name"].ToString();
                    m_AUZList.Add(strAUZ);
                    if (strReturn != "")
                    {
                        strReturn += " OR ";
                    }

                    if (pIsbody == false) //属性权限
                    {
                        strReturn += " (Update_AUZ like '%【" + strAUZ + @"】%'";
                        strReturn += " OR View_AUZ like '%【" + strAUZ + @"】%')";
                    }
                    else
                    {
                        strReturn += " (Insert_AUZ like '%【" + strAUZ + @"】%'";
                        strReturn += " OR Delete_AUZ like '%【" + strAUZ + @"】%'";
                        strReturn += " OR Update_AUZ like '%【" + strAUZ + @"】%'";
                        strReturn += " OR View_AUZ like '%【" + strAUZ + @"】%')";
                    }
                }
            }

            return strReturn;
        }
        #endregion

        #region 获取拥有权限的实体
        /// <summary>
        /// 获取拥有权限的实体
        /// </summary>
        /// <returns></returns>
        private string GetAUZEntity()
        {
            string strReturn = "";

            ArrayList strEntityList = new ArrayList();
            for (int i = 0; i < m_AUZList.Count; i++)
            {
                DataSet ds = Common.Common.GetRequestDataSet(new string[2] { "AUZ", "Entity" }, new string[2] { m_AUZList[i].ToString(), m_MainEntity });
                MDM_Lib_AUZ_Body_GetListByAUZ cls = new MDM_Lib_AUZ_Body_GetListByAUZ();
                cls.hzyMessage = this.hzyMessage;
                cls.Request = ds;
                DataSet dsResponse = cls.GetData();

                string[] str = dsResponse.Tables[0].Rows[0][0].ToString().Split(',');
                for (int j = 0; j < str.Length; j++)
                {
                    if (!strEntityList.Contains(str[j]))
                    {
                        strEntityList.Add(str[j]);
                    }
                }

            }

            for (int i = 0; i < strEntityList.Count; i++)
            {
                if (strReturn != "")
                {
                    strReturn += ",";
                }
                strReturn +=  "'" + strEntityList[i].ToString() + "'";
            }

            return strReturn;
        }

        #endregion

        #region 获取数据过滤信息
        /// <summary>
        /// 获取数据过滤信息
        /// </summary>
        /// <returns></returns>
        private string GetAUZFilter(string strMarketTableName)
        {
            string strReturn = " 1 = 1";

            MDM_Lib_AUZ_AUZ_GetListByAUZ cls = new MDM_Lib_AUZ_AUZ_GetListByAUZ();
            cls.hzyMessage = this.hzyMessage;

            for (int i = 0; i < m_AUZList.Count; i++)
            {
                string strTemp = "";

                string strAUZ = m_AUZList[i].ToString();

                cls.Request = Common.Common.GetRequestDataSet(new string[2] { "AUZ", "MarketTableName" }, new string[2] { strAUZ, strMarketTableName });
                DataSet ds = cls.GetData();
                if (ds.Tables[0].Rows.Count > 0)
                {

                    for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                    {
                        if (j > 0)
                        {
                            strTemp += " AND ";
                        }
                        strTemp += " " + ds.Tables[0].Rows[j]["Filter"].ToString();
                    }
                }
                else
                {
                    strTemp = " 1 = 1 ";
                }

                strTemp = "(" + strTemp + ")";
                if (strReturn != "")
                {
                    strReturn += " AND ";
                }
                strReturn += strTemp;
            }

            return strReturn = "(" + strReturn + ")";
        }
        #endregion
    }

}