using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;

/// 类名：User_GetList
/// 类说明：获取小翅膀人员信息
/// 创建人：郭琦琦 
/// 创建日期：2014-02-18  
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.EPAcount
{

    public class MDM_Employees_AppUser_Link_GetList : LogicBase, ILogicGetData
    {
        public MDM_Employees_AppUser_Link_GetList()
        {
            this.m_SessionCheck = false;
        }

        private Dbconn conn = new Dbconn("MDM");

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
                    {
                        int nPage = 1;
                        int nPageRowCount = 20;
                        string strOrder = " desc  ";
                        string strSort = " AM_User_ID ";
                        string strWhere = "";
                        string strSearchFilter = " ";

                        nPage = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                        nPageRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                        strOrder = m_request.Tables[0].Rows[0]["order"].ToString() != "" ? m_request.Tables[0].Rows[0]["order"].ToString() : strOrder;
                        strSort = m_request.Tables[0].Rows[0]["sort"].ToString() != "" ? m_request.Tables[0].Rows[0]["sort"].ToString() : strSort;
                        strWhere = m_request.Tables[0].Rows[0]["where"].ToString() != "" ? m_request.Tables[0].Rows[0]["where"].ToString() : strWhere;
                        strSearchFilter = m_request.Tables[0].Rows[0]["searchFilter"].ToString() != "" ? m_request.Tables[0].Rows[0]["searchFilter"].ToString() : strSearchFilter;

                        if (strWhere.Trim() != "")
                        {
                            strWhere = " AND " + strWhere;
                        }

                        if (strSearchFilter.Trim() != "")
                        {
                            strWhere += " AND " + strSearchFilter;
                        }

                        string strSQL = @"
                             SELECT  
		                        AM_User_id ,
                                AM_LOGIN ,
                                AM_USER_NAME ,
                                AM_PASSWORD ,
                                AM_EMAIL ,
                                AM_TITLE ,
                                AM_HANDSET ,
                                AM_ISDELETE ,
                                CreateTime ,
                                UpdateTime ,
                                Timestamps FROM dbo.AM_User WITH(NOLOCK)
                                WHERE  1 = 1  AND AM_ISDELETE=0" + strWhere;
                          
                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], nPage, nPageRowCount, strSort + " " + strOrder);
                    }
                      
                
                return ds_Return;
            }
            catch
            {
                throw;
            }
        }
    }
}


