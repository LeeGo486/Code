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


/// 类名：IBMWCStockInterface
/// 类说明：IBM WCS 库存信息同步
/// 创建人：马卫清
/// 创建日期：2014-11-26
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{
    public class IBMWCStockInterface : HZYLogicBase, ILogicExecute
    {
        #region 构造函数
        public IBMWCStockInterface()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("DRP_EC");
        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();
        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public Boolean Execute()
        {
            Log log = new Log();

            try
            {

                string strResult = "";
                HttpTools http = new HttpTools();

                int nExecuteRowCount = 200;
                string strurl = "http://172.16.205.130:8080/wcsportal/rest/goodsStork/putGoodsDataList";
                                 


                if (m_request != null && m_request.Tables.Count > 0 && m_request.Tables[0].Rows.Count == 1)
                {
                    if (m_request.Tables[0].Columns.Contains("executeRowCount"))
                    {
                        try
                        {
                            nExecuteRowCount = Convert.ToInt32(m_request.Tables[0].Rows[0]["executeRowCount"]);
                        }
                        catch (Exception ex)
                        {

                        }
                    }


                    if (m_request.Tables[0].Columns.Contains("posturl"))
                    {
                        try
                        {
                            strurl = m_request.Tables[0].Rows[0]["posturl"].ToString();

                        }
                        catch (Exception ex)
                        {
                            throw new Exception("目标服务器URL不正确，请查看配置。");
                        }
                    }
                }



                m_conn.TimeOut = 60;
                //事务开始
                m_conn.BeginTransaction();

                string strSQL = @"
                        SELECT top " + nExecuteRowCount.ToString() + @" [NewID]
                          ,[CreateTime]
                          ,[WCSFlag]
                          ,[SKU]
                          ,[totalInventory]
                          ,[UpdateTime] 
                          INTO #tmp
                          FROM [dbo].[Put_SkuStock] 
                          WHERE isnull(WCSFlag,0)=0 AND LEFT(SKU, 1) IN ( 'P','B', 'G', 'K', 'N', 'S', 'Z', 'T', 'E', 'R', 'X',
                              'D', 'F', 'J' )

                          ORDER BY CreateTime ASC,Timestamps DESC 

                          UPDATE [dbo].[Put_SkuStock]
                          SET WCSFlag=1
                          WHERE EXISTS(SELECT 1 FROM #tmp WHERE #tmp.NewID = Put_SkuStock.newid)
                          SELECT * FROM #tmp
                          DROP TABLE #tmp
                                                        ";

                DataTable dtData = m_conn.GetDataTable(strSQL);


                string strInputValue = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?><goodsDatas>";

                if (dtData.Rows.Count > 0)
                {

                    for (int i = 0; i < dtData.Rows.Count; i++)
                    {
                        strInputValue += "<goodsData>";
                        strInputValue += "<sku>" + dtData.Rows[i]["SKU"].ToString() + "</sku>";
                        strInputValue += "<totalStork>" + dtData.Rows[i]["totalInventory"].ToString() + "</totalStork>";
                        strInputValue += "<updateFlag>0</updateFlag>";
                        strInputValue += "</goodsData>";

                    }

                    strInputValue += "</goodsDatas>";


                    log.WritePostLog("IBMWCStockInterface", strurl, strInputValue);

                    strResult = http.CreateHttpPost(strurl, strInputValue, false, "UTF-8", "application/xml");
                    log.WritePostLogUpdateResult(strResult);

                    //执行失败
                    if (!strResult.Contains("成功"))
                    {
                        m_conn.RollbackTransaction();
                        throw new Exception("调用接口失败，返回信息为：" + "调用地址：" + strurl+" 返回信息：" + strResult);
                        return false;
                    }
                }


                //事务提交 --注意：不能移动到每个方法里面，这里面的方法会有互相调用的情况
                m_conn.CommitTransaction();

            }
            catch(Exception ex)
            {
                log.WritePostLogUpdateResult(ex.ToString());

                m_conn.RollbackTransaction();
                throw ex;
            }

            return true;
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

            m_conn.InsertBYSQLBC("Get_FLUXWMSOrder", dtList);

            dt_EditResult.Rows.Add(new object[] { 0, "成功！" });

            m_dsRequturn.Tables.Add(dt_EditResult.Copy());
        }
        #endregion

        #endregion
    }

}