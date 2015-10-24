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

/// 类名：Shop_CustomerFeedback
/// 类说明：对Shop_CustomerFeedback(3s反馈)
/// 创建人：郭琦琦
/// 创建日期：2014-09-01 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.StoreBusinessSystem
{
    public class Shop_CustomerFeedback : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Shop_CustomerFeedback()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("S3DB");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();
        string strBegDate = "";//全局变量开始
        string strEndDate = "";//全局变量结束

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

                strBegDate = ds.Tables["list"].Rows[0]["begindate"].ToString();//取前台传过来的时间
                strEndDate = ds.Tables["list"].Rows[0]["enddate"].ToString();//取前台传过来的时间

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetShopCustomerFeedback".ToUpper())//3s反馈
                {
                    GetShopCustomerFeedback();
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

        #region 查询顾客反馈
        /// <summary>
        /// 查询顾客反馈
        /// </summary>
        private void GetShopCustomerFeedback()
        {
            //m_hzyPageInfo.PageRowCount = 20000000;
            string strSQL = @"
                                  SELECT* FROM (SELECT   CONVERT(VARCHAR(100), T.CreateTime , 23) AS CreateTime  ,
                                Branch AS 大区 ,
                                DepotName AS 店铺 ,
                                CusManager AS 客户经理 ,
                                d3.Name 职业 ,--AS Prf
                                Age AS 年龄 ,
                                Mobile AS 手机号 ,
                                Last12MonthAmount AS 过去12月份消费金额 ,
                                d1.Name AS 大类 ,--AS MainType
                                d2.Name AS 小类 ,-- AS SubType 
                                d5.Name 体型 ,--AS Figure
                                d4.Name 身高 ,--AS Height 
                                T.SKC AS 款号 ,
                                Series AS 系列 ,
                                Remark AS 需求反馈
                        FROM    ( SELECT    Branch ,
                                            DepotName ,
                                            CusManager ,
                                            Age ,
                                            Mobile ,
                                            Last12MonthAmount ,
                                            Series ,
                                            Remark ,
                                            TypeId ,
                                            SubTypeId ,
                                            ProfessionId ,
                                            SKC ,
                                            HeightId ,
                                            FigureId ,
                                            CreateTime
                                  FROM      Shop_CustomerFeedback WITH ( NOLOCK )
                                ) T
                                LEFT JOIN S3_Dictionary d1 ON T.TypeId = d1.Id
                                                              AND d1.Type = '反馈类型'
                                LEFT JOIN S3_Dictionary d2 ON T.SubTypeId = d2.Id
                                                              AND d2.Type = '反馈小类'
                                LEFT JOIN S3_Dictionary d3 ON T.ProfessionId = d3.Id
                                                              AND d3.Type = '职业'
                                LEFT JOIN S3_Dictionary d4 ON T.HeightId = d4.Id
                                                              AND d4.Type = '身高'
                                LEFT JOIN S3_Dictionary d5 ON T.FigureId = d5.Id
                                                              AND d5.Type = '体型' 
                                                       ) t2
                                                       WHERE CreateTime >= '" + strBegDate + "' and CreateTime <= '" + strEndDate + "' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);

        }
        #endregion

        #endregion
    }
}