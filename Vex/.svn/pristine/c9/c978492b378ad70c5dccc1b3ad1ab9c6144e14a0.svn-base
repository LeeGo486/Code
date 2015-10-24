using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using HZY.COM.WS.DataSets;
using System.Collections;

namespace HZY.COM.WS.StoreBusinessSystem
{

    /// 类名：PercentageDistribution 
    /// 类说明：POS提成分配模块
    /// 创建人：马卫清
    /// 创建日期：2014-07-21
    /// 修改人：
    /// 修改日期：
    class PercentageDistribution : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public PercentageDistribution()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("HZY_Mat");
        private Dbconn m_conn_GP = new Dbconn("F22GP");
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
                string filter = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPercentageDistribution".ToUpper())      //根据销售单号查询提成分配信息
                {
                    string strRetailID = ds.Tables["list"].Rows[0]["RetailID"].ToString(); // 实时条件，用于下拉框查询数据
                    if (strRetailID == "")
                    {
                        throw new Exception("RetailID不能为空");
                    }
                    GetPercentageDistribution(strRetailID);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPercentageDistributionDetail".ToUpper())      //查询导购提成明细
                {
                    string strShopperAssign = ds.Tables["list"].Rows[0]["ShopperAssign"].ToString(); // 导购编号
                    string strBeginDate = ds.Tables["list"].Rows[0]["BeginDate"].ToString(); // 开始日期
                    string strEndDate = ds.Tables["list"].Rows[0]["EndDate"].ToString(); // 结束日期
                    if (strShopperAssign == "")
                    {
                        throw new Exception("ShopperAssign不能为空");
                    }


                    if (strBeginDate == "")
                    {
                        strBeginDate = "1970-01-01";
                    }

                    if (strEndDate == "")
                    {
                        strEndDate = "2999-01-01";
                    }

                    GetPercentageDistributionDetail(strShopperAssign, strBeginDate, strEndDate);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Percentage".ToUpper())      //根据销售单号查询提成分配信息
                {
                    //分配导购提成
                    Percentage(ds);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPercentageDistributionConfig".ToUpper())      //根据获取所有店铺信息(GP)
                {
                    //根据获取所有店铺信息
                    GetPercentageDistributionConfig(ds);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "updatePercentageDistributionConfig".ToUpper())      //update(GP)
                {
                    //更新
                    updatePercentageDistributionConfig(ds);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "deletePercentageDistributionConfig".ToUpper())      //删除(GP)
                {
                    //删除
                    deletePercentageDistributionConfig(ds);
                }

                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "getDepot".ToUpper())      //获取数据(GP)
                {
                    //获取数据
                    getDepot(ds);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "updateDepot".ToUpper())      //更新数据(GP)
                {
                    //获取数据
                    updateDepot(ds);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "checkDepot".ToUpper())      //验证是否有权限
                {
                    //验证是否有权限
                    checkDepot(ds);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "work".ToUpper())      //调取锁帐规则作业
                {
                    //调取锁帐规则作业
                    work(ds);
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

        #region GetPercentageDistribution 根据销售单号查询提成分配信息
        /// <summary>
        /// 根据销售单号查询提成分配信息
        /// </summary>
        /// <param name="pstrRetailID">零售单号</param>
        private void GetPercentageDistribution(string pstrRetailID)
        {
            string strSQL = @"
                                SELECT  ID ,
                                        M01P_ID ,
                                        M02C_ID ,
                                        RetailCode retailid,
                                        Shopper employeeid,
                                        ShopperAssign percentageemployeeid,
                                        ShopperName names,
                                        ShopperAssignName percentagenames,
                                        isnull(Ratio,0) zssumspre,
                                        isnull(Amount,0) zssums,
                                        Rgdt ,
                                        RgUser ,
                                        LmDt ,
                                        LmUser ,
                                        UptNo
                                FROM    [B02_BILL].[COM1_Commission]
                                WHERE RetailCode = @param0    
";
            ds_Return = m_conn.GetDataSet(strSQL, new string[1] { pstrRetailID });
        }

        #endregion

        #region GetPercentageDistributionDetail 查询导购提成明细
        /// <summary>
        /// 查询导购提成明细
        /// </summary>
        /// <param name="pstrShopperAssign">导购工号</param>
        private void GetPercentageDistributionDetail(string pstrShopperAssign, string pstrBeginDate, string pstrEndDate)
        {
            string strSQL = @"
                                SELECT  ID ,
                                        M01P_ID ,
                                        M02C_ID ,
                                        RetailCode retailid,
                                        Shopper employeeid,
                                        ShopperAssign percentageemployeeid,
                                        ShopperName names,
                                        ShopperAssignName percentagenames,
                                        isnull(Ratio,0) zssumspre,
                                        isnull(Amount,0) zssums,
                                        Rgdt ,
                                        RgUser ,
                                        LmDt ,
                                        LmUser ,
                                        UptNo
                                FROM    [B02_BILL].[COM1_Commission]
                                WHERE RetailCode = @param0    
                                and RetailDate >=@Param1
                                    AND RetailDate <=@Param2
                                
                        ";
            ds_Return = m_conn.GetDataSet(strSQL, new string[3] { pstrShopperAssign, pstrBeginDate, pstrEndDate });
        }

        #endregion

        //        #region GetPercentageDistributionGroupByPonser 根据导购人员查询提成分配信息
        //        /// <summary>
        //        /// 根据导购人员查询提成分配信息
        //        /// </summary>
        //        /// <param name="pstrBeginDate">开始时间</param>
        //        /// <param name="pstrEndDate">结束时间</param>
        //        private void GetPercentageDistributionGroupByPonser(string pstrBeginDate, string pstrEndDate)
        //        {
        //            string strSQL = @"
        //                              SELECT 
        //                                   [ShopperAssign]
        //                                  ,[ShopperAssignName]
        //                                  ,SUM([Amount]) AS amount
        //                              FROM [StoreBusinessSystem].[B02_BILL].[COM1_Commission]
        //                              WHERE RetailDate >=@Param0
        //                                    AND RetailDate <=@Param1
        //                              GROUP BY  [ShopperAssign]
        //                                  ,[ShopperAssignName]
        //                              ORDER BY [ShopperAssign]
        //";
        //            ds_Return = m_conn.GetDataSet(strSQL, new string[] { pstrBeginDate, pstrEndDate });
        //        }

        //        #endregion

        #region PercentageDistribution 分配导购提成
        private void Percentage(DataSet pdsXML)
        {
            string strRetailCode = "";
            DateTime dateNow = DateTime.Now;

            if (pdsXML.Tables["List"].Rows.Count > 0)
            {
                strRetailCode = pdsXML.Tables["List"].Rows[0]["retailid"].ToString();

                DataTable dtData = new HZY_SBS.COM1_CommissionDataTable();

                m_conn.BeginTransaction();

                string strUptNo = m_conn.GetDataTableFirstValue("SELECT TOP 1 UptNo FROM [B02_BILL].[COM1_Commission] WHERE RetailCode=@Param0"
                    , new string[] { strRetailCode }).ToString();

                if (strUptNo == "")
                {
                    strUptNo = "1";
                }
                else
                {
                    strUptNo = (Convert.ToInt32(strUptNo) + 1).ToString();
                }

                for (int i = 0; i < pdsXML.Tables["List"].Rows.Count; i++)
                {

                    DataRow dr = dtData.NewRow();
                    dr["ID"] = System.Guid.NewGuid();
                    dr["M01P_ID"] = DBNull.Value;
                    dr["M02C_ID"] = DBNull.Value;
                    dr["RetailCode"] = pdsXML.Tables["List"].Rows[i]["retailid"];//零售单号
                    dr["Shopper"] = pdsXML.Tables["List"].Rows[i]["employeeid"];//导购员编码
                    dr["ShopperAssign"] = pdsXML.Tables["List"].Rows[i]["percentageemployeeid"];//分配导购员
                    dr["ShopperName"] = pdsXML.Tables["List"].Rows[i]["names"];//导购员姓名
                    dr["ShopperAssignName"] = pdsXML.Tables["List"].Rows[i]["percentagenames"];//分配导购员姓名
                    dr["Ratio"] = pdsXML.Tables["List"].Rows[i]["zssumspre"];//百分比
                    dr["Amount"] = pdsXML.Tables["List"].Rows[i]["zssums"];//提成金额
                    dr["Shopid"] = pdsXML.Tables["List"].Rows[i]["DepotID"];//店铺编号
                    dr["RetailDate"] = pdsXML.Tables["List"].Rows[i]["retailid"].ToString().Substring(7, 10);//零售日期

                    dr["Rgdt"] = dateNow;
                    dr["RgUser"] = hzyMessage.User_Name_CN;
                    dr["LmDt"] = dateNow;
                    dr["LmUser"] = hzyMessage.User_Name_CN;
                    dr["UptNo"] = strUptNo;

                    dtData.Rows.Add(dr);
                }


                string strSQL = @"
                        INSERT INTO [B02_BILL].[COM2_CommissionLog](
	                          [ID]
                              ,[M01P_ID]
                              ,[M02C_ID]
                              ,[RetailCode]
                              ,[Version]
                              ,[Shopper]
                              ,[ShopperAssign]
                              ,[ShopperName]
                              ,[ShopperAssignName]
                              ,[Ratio]
                              ,[Amount]
                              ,[RetailDate]
                              ,[Shopid]
                              ,[Rgdt]
                              ,[RgUser]
                              ,[LmDt]
                              ,[LmUser]
                              ,[UptNo]
                              ,[LogRgdt]
                              ,[LogRgUser]
                              ,[LogLmDt]
                              ,[LogLmUser]
                              ,[LogUptNo]) 

                        SELECT 
	                          [ID]
                              ,[M01P_ID]
                              ,[M02C_ID]
                              ,[RetailCode]
                              ," + strUptNo + @"
                              ,[Shopper]
                              ,[ShopperAssign]
                              ,[ShopperName]
                              ,[ShopperAssignName]
                              ,[Ratio]
                              ,[Amount]
                              ,[RetailDate]
                              ,[Shopid]
                              ,[Rgdt]
                              ,[RgUser]
                              ,[LmDt]
                              ,[LmUser]
                              ,[UptNo],
                              @param1,
                              @param2,
                              @param1,
                              @Param2,1
                          FROM [B02_BILL].[COM1_Commission]
                          WHERE RetailCode = @param0";

                m_conn.ExcuteQuerryByTran(strSQL, new object[] { strRetailCode, dateNow, hzyMessage.User_Name_CN });

                strSQL = @"DELETE FROM [B02_BILL].[COM1_Commission]
                          WHERE RetailCode = @param0";
                m_conn.ExcuteQuerryByTran(strSQL, new object[] { strRetailCode, dateNow, hzyMessage.User_Name_CN });


                m_conn.InsertBYSQLBC("B02_BILL.COM1_Commission", dtData);
                m_conn.CommitTransaction();
            }
            dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion


        #region  获取配置
        /// <summary>
        /// 获取配置
        /// </summary>
        private void GetPercentageDistributionConfig(DataSet pdsXML)
        {
            string strSQL = @"
                             SELECT  [id]
                                    ,[com]
                                    ,[form]
                                    ,[pc]
                                    ,[date]
                                FROM [dbo].[PercentageDistributionConfig]" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion


        #region  UPDATE
        /// <summary>
        /// update
        /// </summary>
        private void updatePercentageDistributionConfig(DataSet pdsXML)
        {

            m_conn.BeginTransaction(); // 开启事务
            string strSQL = @"DELETE  FROM  [dbo].[PercentageDistributionConfig]";
            m_conn.ExcuteQuerryByTran(strSQL);
            bool bResult = false;


            bResult = m_conn.Insert("PercentageDistributionConfig", pdsXML.Tables["List"]);


            m_conn.CommitTransaction();   //提交事务
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region  delete
        /// <summary>
        /// delete
        /// </summary>
        private void deletePercentageDistributionConfig(DataSet pdsXML)
        {

            m_conn.BeginTransaction(); // 开启事务

            bool bResult = false;
            string strid = pdsXML.Tables["List"].Rows[0]["id"].ToString();
            bResult = m_conn.Delete("PercentageDistributionConfig", "id=" + "'" + strid + "'");

            m_conn.CommitTransaction();   //提交事务
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region  获取店铺数据
        /// <summary>
        /// 获取店铺数据
        /// </summary>
        private void getDepot(DataSet pdsXML)
        {

            string strmonth = pdsXML.Tables["List"].Rows[0]["month"].ToString();

            string strSQL = @"
                               SELECT * FROM (
                                         SELECT    t2.shutname ,
                                                        t1.parentid ,
                                                        t3.ShutName parentname ,
                                                        t1.unitid ,
                                                        t3.ShutName parentname1 ,
                                                        t1.depotid ,
                                                        t1.d_name ,
                                                        CASE WHEN t1.m_type IN ( '92', '82' ) THEN '加盟'
                                                             WHEN t1.m_type = '11' THEN '自营'
                                                             WHEN t1.m_type = '0' THEN '总仓'
                                                        END m_type ,
                                                        t1.brandid ,
                                                        t1.d_dq ,
                                                        t4.szmonth ,
                                                        CASE WHEN t4.szrq = '' THEN NULL
                                                             ELSE CONVERT(VARCHAR(100), t4.szrq, 23)
                                                        END AS szrq
                                              FROM      gp.f22gp.dbo.j_depot t1 
                                                        LEFT JOIN gp.f22gp.dbo.j_area t2 ON t1.areaid = t2.areaid
                                                        LEFT JOIN gp.f22gp.dbo.J_Merchant t3 ON t1.parentid = t3.MerchantId
                                                        LEFT JOIN dbo.PercentageDistributionLockData t4 ON t1.depotid = t4.depotid
                                                        where t1.freeze = '0'
                                            )t99   
                                 WHERE 1=1 " + m_hzyPageInfo.Where;
            string strWhereTmp = " AND szmonth = '" + strmonth + "'";
            ds_Return = m_conn.GetDataSetForPageList(strSQL + strWhereTmp, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region  update店铺锁帐
        /// <summary>
        /// update店铺锁帐
        /// </summary>
        private void updateDepot(DataSet pdsXML)
        {

            m_conn.BeginTransaction(); // 开启事务
            bool bResult = false;

            ArrayList listKey = new ArrayList();
            listKey.Add("depotid");
            listKey.Add("szmonth");
            bResult = m_conn.Update("PercentageDistributionLockData", pdsXML.Tables["List"], listKey);


            m_conn.CommitTransaction();   //提交事务
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region  验证是否有权限分配提成
        /// <summary>
        /// 验证是否有权限分配提成
        /// </summary>
        private void checkDepot(DataSet pdsXML)
        {
            string strdepotid = pdsXML.Tables["List"].Rows[0]["depotid"].ToString();
            string strmonth = pdsXML.Tables["List"].Rows[0]["month"].ToString();
            string strSQL = @"
                            SELECT  COUNT(*) count
                                    FROM    dbo.PercentageDistributionLockData
                                    WHERE   depotid = '" + strdepotid + "' AND szmonth = " + strmonth + " AND GETDATE()<szrq";
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region  锁帐作业
        /// <summary>
        /// 锁帐作业
        /// </summary>
        private void work(DataSet pdsXML)
        {
            m_conn.GetDataSetBySP("PercentageDistributionLockData_pro", new string[0], new string[0]);
        }
        #endregion


        #endregion
    }
}
