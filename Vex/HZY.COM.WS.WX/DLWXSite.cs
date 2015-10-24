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
    public class DLWXSite : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public DLWXSite()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("DLWXSite");
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
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DLTicketCreate".ToUpper()) //DL微信生成券号单据99
                {
                    DLTicketCreate();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DLTicketCreateTnn".ToUpper())//399
                {
                    DLTicketCreateTnn();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DLTicketCreateFnn".ToUpper())//599
                {
                    DLTicketCreateFnn();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DLTicketCreateSS".ToUpper())//66
                {
                    DLTicketCreateSS();
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


        #region DL微信生成券号单据
        /// <summary>
        /// DL微信生成券号单据
        /// </summary>
        private void DLTicketCreate()
        {

            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strTictypename = ds.Tables["list"].Rows[0]["tictypename"].ToString();//连衣裙节券
            string strClosedate = ds.Tables["list"].Rows[0]["closedate"].ToString();//2015-01-31

            m_conn.BeginTransaction();

            DataSet dsSP_WX_CreateTicket = m_conn.GetDataSetBySP("SP_WX_CreateTicket",
                new string[10] { "@vipid", "@sums", "@tictypeid", "@Tictypename", "@ttype", "@acttype", "@Days", "@Begdate", "@Enddate", "@Closedate" },
                new string[10] { DBNull.Value.ToString(), "199", "26", strTictypename, "1", "1", DBNull.Value.ToString(), 
                    DBNull.Value.ToString(), DBNull.Value.ToString() ,strClosedate});

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { "TicketID", dsSP_WX_CreateTicket.Tables[0].Rows[0]["TicketID"] });
            dt_EditResult.Rows.Add(new object[] { "Verifycode", dsSP_WX_CreateTicket.Tables[0].Rows[0]["Verifycode"] });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region DL微信生成券号单据399
        /// <summary>
        /// DL微信生成券号单据399
        /// </summary>
        private void DLTicketCreateTnn()
        {

            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strTictypename = ds.Tables["list"].Rows[0]["tictypename"].ToString();//连衣裙节券
            string strClosedate = ds.Tables["list"].Rows[0]["closedate"].ToString();//2015-01-31

            m_conn.BeginTransaction();

            DataSet dsSP_WX_CreateTicket = m_conn.GetDataSetBySP("SP_WX_CreateTicket",
                new string[10] { "@vipid", "@sums", "@tictypeid", "@Tictypename", "@ttype", "@acttype", "@Days", "@Begdate", "@Enddate", "@Closedate" },
                new string[10] { DBNull.Value.ToString(), "399", "26", strTictypename, "1", "1", DBNull.Value.ToString(), 
                    DBNull.Value.ToString(), DBNull.Value.ToString() ,strClosedate});

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { "TicketID", dsSP_WX_CreateTicket.Tables[0].Rows[0]["TicketID"] });
            dt_EditResult.Rows.Add(new object[] { "Verifycode", dsSP_WX_CreateTicket.Tables[0].Rows[0]["Verifycode"] });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region DL微信生成券号单据599
        /// <summary>
        /// DL微信生成券号单据599
        /// </summary>
        private void DLTicketCreateFnn()
        {

            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strTictypename = ds.Tables["list"].Rows[0]["tictypename"].ToString();//连衣裙节券
            string strClosedate = ds.Tables["list"].Rows[0]["closedate"].ToString();//2015-01-31

            m_conn.BeginTransaction();

            DataSet dsSP_WX_CreateTicket = m_conn.GetDataSetBySP("SP_WX_CreateTicket",
                new string[10] { "@vipid", "@sums", "@tictypeid", "@Tictypename", "@ttype", "@acttype", "@Days", "@Begdate", "@Enddate", "@Closedate" },
                new string[10] { DBNull.Value.ToString(), "599", "26", strTictypename, "1", "1", DBNull.Value.ToString(), 
                    DBNull.Value.ToString(), DBNull.Value.ToString() ,strClosedate});

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { "TicketID", dsSP_WX_CreateTicket.Tables[0].Rows[0]["TicketID"] });
            dt_EditResult.Rows.Add(new object[] { "Verifycode", dsSP_WX_CreateTicket.Tables[0].Rows[0]["Verifycode"] });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region DL微信生成券号单据66
        /// <summary>
        /// DL微信生成券号单据66
        /// </summary>
        private void DLTicketCreateSS()
        {

            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strTictypename = ds.Tables["list"].Rows[0]["tictypename"].ToString();//
            string strClosedate = ds.Tables["list"].Rows[0]["closedate"].ToString();//

            m_conn.BeginTransaction();

            DataSet dsSP_WX_CreateTicket = m_conn.GetDataSetBySP("SP_WX_CreateTicket",
                new string[10] { "@vipid", "@sums", "@tictypeid", "@Tictypename", "@ttype", "@acttype", "@Days", "@Begdate", "@Enddate", "@Closedate" },
                new string[10] { DBNull.Value.ToString(), "66", "26", strTictypename, "1", "1", DBNull.Value.ToString(), 
                    DBNull.Value.ToString(), DBNull.Value.ToString() ,strClosedate});
            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { "TicketID", dsSP_WX_CreateTicket.Tables[0].Rows[0]["TicketID"] });
            dt_EditResult.Rows.Add(new object[] { "Verifycode", dsSP_WX_CreateTicket.Tables[0].Rows[0]["Verifycode"] });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion
    }
}