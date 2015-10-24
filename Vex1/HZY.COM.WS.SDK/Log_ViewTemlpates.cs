using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：Log_ViewTemlpates
/// 类说明：Log_ViewTemlpates信息的CRUD
/// 创建人：马卫清
/// 创建日期：2014-01-08
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.SDK
{
    /// <summary>
    /// Log_ViewTemlpates信息的CRUD
    /// </summary>
    public class Log_ViewTemlpates : LogicBase, ILogicGetData
    {
        public Log_ViewTemlpates()
        {
            this.m_SessionCheck = false;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();


        /// <summary>
        /// EnvoTemplates信息的CRUD
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            DataSet ds_Return = new DataSet();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            if (strXML == "")
            {
                throw new Exception("XML不能为空");
            }

            string strTemplate_ID = m_request.Tables[0].Rows[0]["Template_ID"].ToString();
            if (strTemplate_ID == "")
            {
                throw new Exception("Template_ID不能为空");

            }

            DataSet ds = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

            Dbconn conn = new Dbconn("HZY_SDK");

            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "INSERT")
            {

                bool bResult = true;
                DataTable dt = new DataTable();
                dt.Columns.Add("Template_ID");
                dt.Rows.Add(new object[] { strTemplate_ID });
                Commom_Ds.SetUpdateInfo(dt, hzyMessage);

                conn.BeginTransaction();

                bResult = conn.Insert("Log_ViewTemlpates", dt);
                conn.ExcuteQuerryByTran("UPDATE EnvoTemplates set ViewCount=ViewCount+1 where Template_ID=" + strTemplate_ID);

                conn.CommitTransaction();


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


            return ds_Return;



        }

    }

}