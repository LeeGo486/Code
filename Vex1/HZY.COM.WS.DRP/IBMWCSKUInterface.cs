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


/// 类名：IBMWCSKUInterface
/// 类说明：IBM WCS 商品信息接口
/// 创建人：马卫清
/// 创建日期：2014-11-25
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DRP
{
    public class IBMWCSKUInterface : HZYLogicBase, ILogicExecute
    {
        #region 构造函数
        public IBMWCSKUInterface()
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
            try
            {

                string strResult = "";
                HttpTools http = new HttpTools();

                int nExecuteRowCount = 200;
                string strurl = "http://172.16.71.137:8080/wcsportal/rest/goods/putGoodsDataList";

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
                            return false;
                        }
                    }
                }

                m_conn.TimeOut = 60;
                //事务开始

                m_conn.Excute("update [dbo].[Put_SKU] set WCSFlag=2 where isnull(WCSFlag,0)=0 and SKU_GROUP4 NOT IN ('E','G','F','J','K','N','S','T','Z','D','B','Q')");

                m_conn.BeginTransaction();

                string strSQL = @"
                        SELECT top " + nExecuteRowCount.ToString() + @" [NewID]
                              ,[CreateTime]
                              ,[Timestamps]
                              ,[WMSFlag]
                              ,[WCSFlag]
                              ,[SKU]
                              ,[Descr_C]
                              ,[SKU_GROUP4]
                              ,[SKU_GROUP1]
                              ,[Price]
                              ,[Alternate_SKU1]
                              ,[ReservedField01]
                              ,[ReservedField02]
                              ,[ReservedField03]
                              ,[ReservedField04]
                              ,[ReservedField05]
                              ,[ReservedField06]
                              ,[ReservedField07]
                              ,[NOTES]
                              ,styleid
                          INTO #tmp
                          FROM [dbo].[Put_SKU]
                          WHERE isnull(WCSFlag,0)=0
                          And SKU_GROUP4 IN ('E','G','F','J','K','N','S','T','Z','D','B','Q')


                          ORDER BY CreateTime ASC,Timestamps ASC 

                          UPDATE [dbo].[Put_SKU]
                          SET WCSFlag=1
                          WHERE EXISTS(SELECT 1 FROM #tmp WHERE #tmp.NewID = Put_SKU.newid)
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
                        strInputValue += "<price>" + dtData.Rows[i]["PRICE"].ToString() + "</price>";
                        strInputValue += "<sizeId>" + dtData.Rows[i]["ReservedField04"].ToString() + "</sizeId>";
                        strInputValue += "<colorId>" + dtData.Rows[i]["ReservedField05"].ToString() + "</colorId>";
                        strInputValue += "<goodsName>" + dtData.Rows[i]["Descr_C"].ToString() + "</goodsName>";
                        strInputValue += "<channelId>1</channelId>";
                        strInputValue += "<merchantId>1</merchantId>";
                        strInputValue += "<fid>" + dtData.Rows[i]["styleid"].ToString() + "</fid>";
                        //strInputValue += "<fid>001test</fid>";
                        strInputValue += "<barcode>" + dtData.Rows[i]["Alternate_SKU1"].ToString() + "</barcode>";
                        strInputValue += "<isUpdate>0</isUpdate>";
                        strInputValue += "<goodsCategory>" + dtData.Rows[i]["ReservedField03"].ToString() + "</goodsCategory>";
                        strInputValue += "<bigCategory>" + dtData.Rows[i]["SKU_GROUP1"].ToString() + "</bigCategory>";
                        strInputValue += "<smallCategory>" + dtData.Rows[i]["ReservedField01"].ToString() + "</smallCategory>";
                        strInputValue += "<goodsbrand>" + dtData.Rows[i]["SKU_GROUP4"].ToString() + "</goodsbrand>";
                        strInputValue += "<brandName>" + dtData.Rows[i]["ReservedField02"].ToString() + "</brandName>";
                        strInputValue += "<year>" + dtData.Rows[i]["ReservedField06"].ToString() + "</year>";
                        strInputValue += "<season>" + dtData.Rows[i]["ReservedField07"].ToString() + "</season>";

                        strInputValue += "</goodsData>";

                    }
                    //ws.Timeout = 3600 * 1000; 

                    strInputValue += "</goodsDatas>";
                    strInputValue = strInputValue.Replace("&", "&amp;");
                    strResult = http.CreateHttpPost(strurl, strInputValue, false, "UTF-8", "application/xml");


                    HZY.COM.Common.Log.WirteLogWS("IBMWCSKUInterface:" + strResult + " 传入参数：" + strInputValue, null);


                    //执行失败
                    if (!strResult.Contains("成功"))
                    {
                        m_conn.RollbackTransaction();
                        return false;
                    }
                }


                //事务提交 --注意：不能移动到每个方法里面，这里面的方法会有互相调用的情况
                m_conn.CommitTransaction();

            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
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