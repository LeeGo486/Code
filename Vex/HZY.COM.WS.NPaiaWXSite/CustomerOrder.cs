using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：ShoppingCart
/// 类说明：恩派雅订单
/// 创建人：金敏杰
/// 创建日期：2014-09-25
/// WSID:150fb7e6-111a-4752-a7c5-546ad9d169a4
/// 修改人：郭琦琦
/// 修改日期：2015-1-20/2015-2-3
namespace HZY.COM.WS.NPaiaWXSite
{
    public class CustomerOrder : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public CustomerOrder()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("NPaia");
        private Dbconn m_conn = new Dbconn("F22XY_TEST");
        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_dsRequturn = new DataSet();
        DateTime timeNow = DateTime.Now;

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
                DateTime time = DateTime.Now;

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddCustomerOrder".ToUpper())      //新建客户订单
                {
                    AddCustomerOrder();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditCustomerOrder".ToUpper())      //修改客户订单
                {
                    //EditCustomerOrder();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DelCustomerOrder".ToUpper())      //删除客户订单
                {
                    DelCustomerOrder();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCustomerOrder".ToUpper())      //查询客户订单
                {
                    GetCustomerOrder();
                }
                return m_dsRequturn;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region  内部函数

        #region 新建客户订单
        private void AddCustomerOrder()
        {
            DataTable dtList = ds.Tables[1];
            DataTable subList = ds.Tables[2];

            string seq;//编号最大值

            conn.BeginTransaction(); // 开启事务
            #region 取项次最大值

            DataTable dt1 = conn.GetDataTable("SELECT CONVERT(VARCHAR(6),GETDATE(),12)+RIGHT('0000'+CAST(CAST(ISNULL(MAX(RIGHT(Code,3)),'0')  AS INT)+1 AS VARCHAR(3)),3) AS Code FROM [B02_BILL].[CO1_CustomerOrderHead] WHERE DATEDIFF(DAY,Rgdt,GETDATE())=0");
            seq = dt1.Rows[0]["Code"].ToString();

            #endregion

            #region 新增购物车信息

            //子表添加字段
            subList.Columns.Add("M01P_ID");
            subList.Columns.Add("M02C_ID");
            subList.Columns.Add("CO1_ID");
            subList.Columns.Add("Seq");
            subList.Columns.Add("Rgdt");
            subList.Columns.Add("RgUser");
            subList.Columns.Add("LmDt");
            subList.Columns.Add("LmUser");
            subList.Columns.Add("UptNo");
            subList.Columns.Add("State");

            //主表添加字段
            string tel = dtList.Rows[0]["Phone"].ToString();

            DataTable dt2 = conn.GetDataTable("SELECT DEPT_Name,DEPT_Phone FROM [B01_MDM].[DEPT_Depot] WHERE DEPT_ID='" + dtList.Rows[0]["DEPT_ID"].ToString() + "'");
            DataTable dt3 = m_conn.GetDataTable("SELECT vipsex FROM vip_user WHERE mobtel='" + tel + "'");

            string contentSMS = "";
            if (dt3.Rows[0]["vipsex"].ToString() == "男")
                contentSMS = "尊敬的" + dtList.Rows[0]["RgUser"].ToString() + "先生，您好!您的订单" + seq + "已经成功提交,请于" + dtList.Rows[0]["DeliveryDate"].ToString() + "前往" + dt2.Rows[0]["DEPT_Name"].ToString() + "取货，联系电话：" + dt2.Rows[0]["DEPT_Phone"].ToString() + "，如有问题可致电恩派雅服务热线4008881273。";
            else
                contentSMS = "尊敬的" + dtList.Rows[0]["RgUser"].ToString() + "女士，您好!您的订单" + seq + "已经成功提交,请于" + dtList.Rows[0]["DeliveryDate"].ToString() + "前往" + dt2.Rows[0]["DEPT_Name"].ToString() + "取货，联系电话：" + dt2.Rows[0]["DEPT_Phone"].ToString() + "，如有问题可致电恩派雅服务热线4008881273。";
            //string credit = "";
            //if (float.Parse(dtList.Rows[0]["Amount"].ToString()) >= 5000)
            //    credit = "500";
            //else if (float.Parse(dtList.Rows[0]["Amount"].ToString()) >= 3000)
            //    credit = "300";
            //else
            //    credit = "100";
            //if (dt3.Rows[0]["vipsex"].ToString() == "男")
            //    contentSMS = "【暖意圣诞，针织情怀】尊敬的" + dtList.Rows[0]["RgUser"].ToString() + "先生，您好!您的订单" + seq + "已经成功提交,请于" + dtList.Rows[0]["DeliveryDate"].ToString() + "前往" + dt2.Rows[0]["DEPT_Name"].ToString() + "取货，联系电话：" + dt2.Rows[0]["DEPT_Phone"].ToString() + "。您已收到" + credit + "元积分赠送，可于本次订单使用，祝您购物愉快！如有问题可致电恩派雅服务热线4008881273。";
            //else
            //    contentSMS = "【暖意圣诞，针织情怀】尊敬的" + dtList.Rows[0]["RgUser"].ToString() + "女士，您好!您的订单" + seq + "已经成功提交,请于" + dtList.Rows[0]["DeliveryDate"].ToString() + "前往" + dt2.Rows[0]["DEPT_Name"].ToString() + "取货，联系电话：" + dt2.Rows[0]["DEPT_Phone"].ToString() + "。您已收到" + credit + "元积分赠送，可于本次订单使用，祝您购物愉快！如有问题可致电恩派雅服务热线4008881273。";

            //string contentAM = "您好，客户：" + dtList.Rows[0]["RgUser"].ToString() + "(" + tel + ")，在微信端已下单，单号" + seq + "，详情请至VEX后台查询。";

            dtList.Columns.Add("ID");
            dtList.Columns.Add("M01P_ID");
            dtList.Columns.Add("M02C_ID");
            dtList.Columns.Add("Code");
            dtList.Columns.Add("Rgdt");
            dtList.Columns.Add("LmDt");
            dtList.Columns.Add("LmUser");
            dtList.Columns.Add("UptNo");
            dtList.Columns.Add("MinState");
            dtList.Columns.Add("MaxState");

            //主表ID
            string guid = System.Guid.NewGuid().ToString();

            dtList.Rows[0]["ID"] = guid;
            dtList.Rows[0]["M01P_ID"] = System.Guid.NewGuid().ToString();
            dtList.Rows[0]["M02C_ID"] = System.Guid.NewGuid().ToString();
            dtList.Rows[0]["Code"] = seq;
            dtList.Rows[0]["Rgdt"] = timeNow;
            dtList.Rows[0]["LmDt"] = timeNow;
            dtList.Rows[0]["LmUser"] = dtList.Rows[0]["RgUser"].ToString();
            dtList.Rows[0]["UptNo"] = 0;
            dtList.Rows[0]["MinState"] = 20;
            dtList.Rows[0]["MaxState"] = 20;

            int rowCount = subList.Rows.Count;

            for (int i = 0; i < rowCount; i++)
            {
                //删除购物车信息
                conn.Delete("[B02_BILL].[SHPC_ShoppingCart]", "ID=" + "'" + subList.Rows[i]["ID"].ToString() + "'");

                subList.Rows[i]["ID"] = System.Guid.NewGuid().ToString();
                subList.Rows[i]["M01P_ID"] = System.Guid.NewGuid().ToString();
                subList.Rows[i]["M02C_ID"] = System.Guid.NewGuid().ToString();
                subList.Rows[i]["CO1_ID"] = guid;
                subList.Rows[i]["Seq"] = i + 1;
                subList.Rows[i]["Rgdt"] = timeNow;
                subList.Rows[i]["RgUser"] = dtList.Rows[0]["RgUser"].ToString();
                subList.Rows[i]["LmDt"] = timeNow;
                subList.Rows[i]["LmUser"] = dtList.Rows[0]["RgUser"].ToString();
                subList.Rows[i]["UptNo"] = 0;
                subList.Rows[i]["State"] = 20;
            }

            Boolean bResult = false;
            bResult = conn.Insert("[B02_BILL].[CO1_CustomerOrderHead]", dtList);
            bResult = conn.Insert("[B02_BILL].[CO2_CustomerOrderDetail]", subList);

            SendSMS(tel, contentSMS);

            //郭琦琦新增发送AM消息  
            DataTable dt4 = conn.GetDataTable(@" SELECT top 1 [ID] ,[CN_LOGIN] ,[CN_USER_NAME] ,[CN_DEPOTID] ,[CN_DEPOTNAME] ,[CN_WXDEPOTNAME]  
                                                 FROM    [B01_MDM].[AMSender]
                                                 WHERE id='" + dtList.Rows[0]["DEPT_ID"].ToString() + "'");

            DataTable dt5 = conn.GetDataTable(@" SELECT  t1.Amount ,
                                                        t1.DeliveryDate ,
                                                        --( SELECT    COUNT(*)
                                                        --  FROM      [B02_BILL].[CO2_CustomerOrderDetail] t4
                                                        --  WHERE     t4.CO1_ID = t1.ID
                                                        --) num ,
                                                        CONVERT(DECIMAL(20,0),t2.Number )  num,
		                                                CASE WHEN t1.Desp='' THEN '无' ELSE t1.Desp END Desp,
                                                        '款号为:' + t4.STYL_Code + ',颜色:' + t3.STL2_Color + ',尺码' + t3.STL2_Size SKU
                                                FROM    [NPAIACMS].[B02_BILL].[CO1_CustomerOrderHead] t1
                                                        LEFT JOIN [B02_BILL].[CO2_CustomerOrderDetail] t2 ON t1.ID = t2.CO1_ID
                                                        LEFT JOIN B01_MDM.STL2_StyleSKU t3 ON t2.STL2_ID = t3.STL2_ID
                                                        LEFT JOIN [B01_MDM].[STYL_Style] t4 ON t4.STYL_ID = t3.STL2_STYL_ID
		                                                WHERE t1.Code='" + seq + "' ");
            string strSKU = "";
            for (int i = 0; i < dt5.Rows.Count; i++)
            {
                strSKU += dt5.Rows[i]["SKU"].ToString() + ",数量为:" + dt5.Rows[i]["num"].ToString() + " , <br /> ";
            }

            string strAmount = dt5.Rows[0]["Amount"].ToString();
            string strDesp = dt5.Rows[0]["Desp"].ToString();
            string strDeliveryDate = dt5.Rows[0]["DeliveryDate"].ToString();


            string contentAMdepotname = "客户：" + dtList.Rows[0]["RgUser"].ToString() + ",电话:" + tel + "，已在微信客户端下单，单号" + seq + @",订单总金额为 " + strAmount + ", <br /> " + strSKU + " <br />  预订到店时间为" + strDeliveryDate + " , 留言:" + strDesp + " ,详情请至VEX后台订单中心查询或致电店铺管理部赵佳悦(15967368456)";

            SendAM("AM", "NPAIA", "赵佳悦", "信息部服务中心", contentAMdepotname, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

            SendAM("AM", "NPAIA", dt4.Rows[0]["CN_LOGIN"].ToString(), "信息部服务中心", contentAMdepotname, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
            //SendAM("AM", "NPAIA", "郭琦琦", "信息部服务中心", contentAMdepotname, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

            conn.CommitTransaction();

            #endregion

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "订单添加成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "订单添加失败" });
            };
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 删除客户订单
        private void DelCustomerOrder()
        {
            DataTable dtList = ds.Tables["List"];

            string id = dtList.Rows[0]["ID"].ToString();

            Boolean bResult = false;

            conn.BeginTransaction(); // 开启事务
            bResult = conn.Delete("[B02_BILL].[CO1_CustomerOrderHead]", "ID=" + "'" + id + "'");
            bResult = conn.Delete("[B02_BILL].[CO2_CustomerOrderDetail]", "CO1_ID=" + "'" + id + "'");
            conn.CommitTransaction();

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "订单删除成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "订单删除失败" });
            };
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 查询客户订单
        private void GetCustomerOrder()
        {
            string strSQL = @"SELECT A.[ID]
                          ,A.[M01P_ID]
                          ,A.[M02C_ID]
                          ,A.[ORB1_ID]
                          ,A.[Code]
                          ,A.[WeiXinID]
                          ,A.[DeliveryDate]
                          ,A.[MinState]
                          ,A.[MaxState]
                          ,A.[Amount]
                          ,A.[DEPT_ID]
                          ,A.[Desp]
                          ,A.[Rgdt]
                          ,A.[RgUser]
                          ,A.[LmDt]
                          ,A.[LmUser]
                          ,A.[UptNo]
                        ,B.[Seq]
                        ,B.[STL2_ID]
                        ,B.[Number]
                        ,B.[Price]
                        ,B.[SellPrice]
                        ,B.[Amount] AS subAmount
                        ,B.[State]
                        ,C.[STL2_Color]
                        ,C.[STL2_Size]
                        ,D.[STYL_Name]
                        ,D.[STYL_Code]
                        ,D.[STYL_PicturePath]
                        ,E.[DEPT_Name]
                        ,E.[DEPT_Address]
                        ,E.[DEPT_Phone]
                FROM [B02_BILL].[CO1_CustomerOrderHead] A
                LEFT JOIN [B02_BILL].[CO2_CustomerOrderDetail] B ON A.[ID]=B.[CO1_ID]
                LEFT JOIN [B01_MDM].[STL2_StyleSKU] C ON B.[STL2_ID]=C.[STL2_ID]
                LEFT JOIN [B01_MDM].[STYL_Style] D ON C.[STL2_STYL_ID]=D.[STYL_ID]
                LEFT JOIN [B01_MDM].[DEPT_Depot] E ON A.[DEPT_ID]=E.[DEPT_ID]
                WHERE 1=1 " + m_hzyPageInfo.Where;

            m_dsRequturn = conn.GetDataSet(strSQL);
        }
        #endregion

        public static void SendSMS(string pstrPhoneNumber, string pstrContent)
        {
            pstrPhoneNumber = pstrPhoneNumber.Replace("'", "");
            pstrContent = pstrContent.Replace("'", "");

            Dbconn conn = new Dbconn("SMS");
            string strSQL = @"
                EXEC SMS.DBO.sp_smstosend 'SMS', 'weixin', '" + pstrPhoneNumber + @"', '', '" + pstrContent + @"', '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + @"',
                    '4', '' ;
                EXEC SMS.DBO.sp_smspush_phone '" + pstrPhoneNumber + @"';
            ";
            conn.Excute(strSQL);
        }

        public static string SendAM(string pstrType, string pstrSystem, string pstrReceiver,
            string pstrSender, string pstrContent, string pstrSendTime)
        {
            HZY.COM.CommonWS.AMSendWS.MsgCenter msg = new HZY.COM.CommonWS.AMSendWS.MsgCenter();
            return msg.SendMsg(pstrType, pstrSystem, pstrReceiver, pstrSender, pstrContent, pstrSendTime);

        }

        #endregion
    }
}
