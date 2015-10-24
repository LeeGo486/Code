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
using System.Data.SqlClient;

namespace HZY.COM.WS.CommonInterface
{
    /// <summary>
    ///DRPStlyeInfoSync  同步 DRP款式档案到业务系统 读取MDM配置、、
    ///@COM 表示品牌 如 EP  DL  GL
    //@Type 类型  1 表示按款式输出  2 表示按SKU输出
    //@Styleid 指定款式 传值为指定款式，不传为所有
    ///Cookie 2015-06-28
    /// </summary>
    public class DRPStlyeInfoSync : LogicBase, ILogicExecute
    {
        public DRPStlyeInfoSync()
        {

            this.m_SessionCheck = false;
        }

        Dbconn m_Conn_F22GP_DRP_REPORT = new Dbconn("F22GP_DRP_REPORT");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();

        public bool Execute()
        {
            Dbconn m_Conn_MDM = new Dbconn("MDM");
            DataSet Config = new DataSet();



            string strSql = @" SELECT  [Com] ,
                            [Type] ,
                            [Conn] ,
                            [SKUTable]
                    FROM    [DRPStlyeInfoSyncConfig] ";
            Config = m_Conn_MDM.GetDataSet(strSql);

            for (int i = 0; i < Config.Tables[0].Rows.Count; i++)
            {
                string Com = Config.Tables[0].Rows[i]["Com"].ToString();
                string Type = Config.Tables[0].Rows[i]["Type"].ToString();
                string SKUTable = Config.Tables[0].Rows[i]["SKUTable"].ToString();
                string Conn = Config.Tables[0].Rows[i]["Conn"].ToString();
                Dbconn BillConn = new Dbconn(Conn);

                DataSet DRPSKU = m_Conn_F22GP_DRP_REPORT.GetDataSetBySP("SP_OnlineStyle", new string[3] { "@COM", "@Type", "@Styleid" },
                                   new string[3] { Com, Type, "" });
                try
                {
                    BillConn.BeginTransaction();

                    if (DRPSKU.Tables[0] == null || DRPSKU.Tables[0].Rows.Count == 0)
                    {
                        throw new Exception("请传入需要导入的数据！");
                    }

                    BillConn.ExcuteQuerryByTran("TRUNCATE TABLE " + SKUTable);
                    BillConn.InsertBYSQLBC(SKUTable, DRPSKU.Tables[0]);

                    BillConn.CommitTransaction();

                    //HZY.COM.Common.Log.WirteLogWS("成功", null);
                    //return true;
                }
                catch (SqlException ex)
                {

                    BillConn.RollbackTransaction();

                    if (ex.Message.Contains("唯一索引"))
                    {
                        dt_EditResult.Rows.Add(new object[] { 1, "插入了重复键值，请检查！" });
                        m_dsRequturn.Tables.Add(dt_EditResult.Copy());
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { 1, ex.Message });
                        m_dsRequturn.Tables.Add(dt_EditResult.Copy());
                    }

                    HZY.COM.Common.Log.WirteLogWS(ex, null);
                    return false;
                }
                catch (Exception ex)
                {
                    BillConn.RollbackTransaction();
                    dt_EditResult.Rows.Add(new object[] { 1, ex.Message });
                    m_dsRequturn.Tables.Add(dt_EditResult.Copy());
                    HZY.COM.Common.Log.WirteLogWS(ex, null);
                    return false;
                }
            }

            dt_EditResult.Rows.Add(new object[] { 0, "成功！" });
            m_dsRequturn.Tables.Add(dt_EditResult.Copy());
            return true;
        }
    }
}