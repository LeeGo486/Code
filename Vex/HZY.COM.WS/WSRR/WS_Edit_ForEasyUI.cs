using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;
using HZY.COM.WS.DataSets;


/// 类名：WS_Edit_ForEasyUI
/// 类说明：对WSRR的CRUD,为Easyui专用
/// 创建人：马卫清
/// 创建日期：2013-09-22
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    /// 对WSRR的CRUD,为Easyui专用
    /// </summary>
    public class WS_Edit_ForEasyUI : LogicBase, ILogicGetData
    {
        public WS_Edit_ForEasyUI()
        {
            this.m_SessionCheck = true;

        }

        private Dbconn conn = new Dbconn("MDM_Master");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        int m_Page = 1;
        int m_Rows = 20;
        /// <summary>
        /// 对WSRR的CRUD,为Easyui专用
        /// </summary>
        /// <returns></returns>
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
                //bool bEdit = false;
                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        m_request.Tables[0].TableName = "Page_Info";
                        m_request.Tables[0].Columns.Remove("XML");
                        WS_GetList cls = new WS_GetList();
                        cls.hzyMessage = this.hzyMessage;
                        cls.Request = m_request;
                        ds_Return = cls.GetData();
                        
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        DataSet ds1 = new DataSet();
                        ds1.Tables.Add(ds.Tables["list"].Copy());

                        WS_Edit cls = new WS_Edit();
                        cls.hzyMessage = this.hzyMessage;

                        cls.Request = ds1;
                        bool bResult = cls.Execute();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "修改失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                        ds_Return.Tables.Add(dt_EditResult);

                    }
                }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;

            }
        }
    }

}