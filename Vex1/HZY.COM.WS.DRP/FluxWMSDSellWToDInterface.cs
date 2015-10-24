using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using System.Data.SqlClient;


/// 类名：FluxWMSDSellWToDInterface
/// 类说明：门店发货出库发货数据回传DRP	WMS->DRP	发货单登账
/// 创建人：郭琦琦 
/// 创建日期：2015-03-12
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{
    public class FluxWMSDSellWToDInterface : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public FluxWMSDSellWToDInterface()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("WMS_GP");
        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();
        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            string strOptype = "";
            string strResult = "";
            try
            {
                DateTime time = DateTime.Now;

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                strOptype = dt_OPTYPE.Rows[0][0].ToString().ToUpper();

                //事务开始
                m_conn.BeginTransaction();

                if (strOptype == "Insert".ToUpper())      //数据写入
                {
                    Insert();
                }
                //事务提交 --注意：不能移动到每个方法里面，这里面的方法会有互相调用的情况
                m_conn.CommitTransaction();

                HZY.COM.Common.Log.WirteLogWS("成功", null);


            }
            catch (SqlException ex)
            {

                m_conn.RollbackTransaction();

                if (ex.Message.Contains("唯一索引"))
                {
                    dt_EditResult.Rows.Add(new object[] { 1, "插入了重复键值，请检查！" });
                    m_dsRequturn.Tables.Add(dt_EditResult.Copy());
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { 1, "执行SQL出错！" });
                    m_dsRequturn.Tables.Add(dt_EditResult.Copy());
                }

                HZY.COM.Common.Log.WirteLogWS(ex, null);

            }
            catch (Exception ex)
            {
                m_conn.RollbackTransaction();
                dt_EditResult.Rows.Add(new object[] { 1, ex.Message });
                m_dsRequturn.Tables.Add(dt_EditResult.Copy());
                HZY.COM.Common.Log.WirteLogWS(ex, null);
            }


            return m_dsRequturn;
        }
        #endregion


        #region  内部函数

        #region  Insert 插入数据
        /// <summary>
        /// 插入数据
        /// </summary>
        private void Insert()
        {
            DataTable dtList = ds.Tables["List"];

            if (dtList == null || dtList.Rows.Count == 0)
            {
                throw new Exception("请传入需要导入的数据！");
            }

            m_conn.InsertBYSQLBC("Get_FLUXWMS_D_Sell", dtList);

            dt_EditResult.Rows.Add(new object[] { 0, "成功！" });

            m_dsRequturn.Tables.Add(dt_EditResult.Copy());
        }
        #endregion

        #endregion
    }

}