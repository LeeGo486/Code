using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

namespace HZY.COM.WS.WX
{
    /// <summary>
    /// 卓莱雅券号生成
    /// </summary>
    public class JLWXSite : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public JLWXSite()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("F22JL");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "JLTicketCreate".ToUpper()) //JL微信生成券号单据99
                {
                    JLTicketCreate();
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数


        #region JL微信生成券号单据
        /// <summary>
        /// JL微信生成券号单据
        /// </summary>
        private void JLTicketCreate()
        {

            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strSums = ds.Tables["list"].Rows[0]["sums"].ToString();//券大小

            m_conn.BeginTransaction();

            DataSet dsSP_WX_CreateTicket = m_conn.GetDataSetBySP("SP_WX_CreateTicket",
                new string[10] { "@vipid", "@sums", "@tictypeid", "@Tictypename", "@ttype", "@acttype", "@Days", "@Begdate", "@Enddate", "@Closedate" },
                new string[10] { DBNull.Value.ToString(),strSums, "47", "春装代金券", "1", "1", DBNull.Value.ToString(), 
                    DBNull.Value.ToString(), DBNull.Value.ToString() ,"2015-3-31"});

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { "TicketID", dsSP_WX_CreateTicket.Tables[0].Rows[0]["TicketID"] });
            //dt_EditResult.Rows.Add(new object[] { "Verifycode", dsSP_WX_CreateTicket.Tables[0].Rows[0]["Verifycode"] });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion
    }
}