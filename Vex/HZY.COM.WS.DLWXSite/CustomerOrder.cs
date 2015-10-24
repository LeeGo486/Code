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
/// 类说明：贝爱订单管理
/// 创建人：郭琦琦
/// 创建日期：2015-05-11
namespace HZY.COM.WS.DLWXSite
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
        private Dbconn conn = new Dbconn("DLWXWZ");//微站数据库
        private Dbconn m_conn = new Dbconn("DLWXSite");//DLPOS
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

            DataTable dt2 = m_conn.GetDataTable("SELECT d_name DEPT_Name, Tel DEPT_Phone  FROM dbo.j_depot WHERE depotid='" + dtList.Rows[0]["DEPT_ID"].ToString() + "'");



            //DataTable dt3 = m_conn.GetDataTable("SELECT vipsex FROM vip_user WHERE mobtel='" + tel + "'");

            //string contentSMS = "";
            //if (dt3.Rows[0]["vipsex"].ToString() == "男")
            //    contentSMS = "尊敬的" + dtList.Rows[0]["RgUser"].ToString() + "先生，您好!您的订单" + seq + "已经成功提交,请于" + dtList.Rows[0]["DeliveryDate"].ToString() + "前往" + dt2.Rows[0]["DEPT_Name"].ToString() + "取货，联系电话：" + dt2.Rows[0]["DEPT_Phone"].ToString() + "";
            //else
            //    contentSMS = "尊敬的" + dtList.Rows[0]["RgUser"].ToString() + "女士，您好!您的订单" + seq + "已经成功提交,请于" + dtList.Rows[0]["DeliveryDate"].ToString() + "前往" + dt2.Rows[0]["DEPT_Name"].ToString() + "取货，联系电话：" + dt2.Rows[0]["DEPT_Phone"].ToString() + "";

            dtList.Columns.Add("ID");
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

            //SendSMS(tel, contentSMS);

            //            //郭琦琦新增发送AM消息  
            //            DataTable dt4 = conn.GetDataTable(@" SELECT top 1 [ID] ,[CN_LOGIN] ,[CN_USER_NAME] ,[CN_DEPOTID] ,[CN_DEPOTNAME] ,[CN_WXDEPOTNAME]  
            //                                                 FROM    [B01_MDM].[AMSender]
            //                                                 WHERE id='" + dtList.Rows[0]["DEPT_ID"].ToString() + "'");

            DataTable dt5 = conn.GetDataTable(@" SELECT  t1.Amount ,
                                                        t1.DeliveryDate ,
                                                        --( SELECT    COUNT(*)
                                                        --  FROM      [B02_BILL].[CO2_CustomerOrderDetail] t4
                                                        --  WHERE     t4.CO1_ID = t1.ID
                                                        --) num ,
                                                        CONVERT(DECIMAL(20,0),t2.Number )  num,
		                                                CASE WHEN t1.Desp='' THEN '无' ELSE t1.Desp END Desp,
                                                        '款号为:' + t4.STYL_Code + ',颜色:' + t3.STL2_Color + ',尺码' + t3.STL2_Size SKU
                                                FROM   [B02_BILL].[CO1_CustomerOrderHead] t1
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


            string contentAMdepotname = "您好：顾客" + dtList.Rows[0]["RgUser"].ToString() + " 已预约到店体验,预约时间： " + strDeliveryDate + ",联系方式 ：" + tel + "<br /> 预约款号为" + strSKU + " <br />  的商品，请您尽快与顾客取得联系，并做好服务工作，谢谢。 <br /> 如有疑问，请咨询0573-83386690";

            SendAM("AM", "WeiXin", dt2.Rows[0]["DEPT_Name"].ToString(), "信息部服务中心", contentAMdepotname, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));

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
            //99

            DataTable dtHead = new DataTable();
            DataTable dtDetail = new DataTable();

            //添加列
            dtHead.Columns.Add("ID");
            dtHead.Columns.Add("MinState");
            dtHead.Columns.Add("MaxState");
            dtHead.Columns.Add("LmDt");
            dtHead.Columns.Add("LmUser");

            dtDetail.Columns.Add("CO1_ID");
            dtDetail.Columns.Add("State");
            dtDetail.Columns.Add("LmDt");
            dtDetail.Columns.Add("LmUser");


            //添加行
            DataRow newRow;
            newRow = dtHead.NewRow();
            dtHead.Rows.Add(newRow);

            DataRow newRowD;
            newRowD = dtDetail.NewRow();
            dtDetail.Rows.Add(newRowD);

            dtHead.Rows[0]["ID"] = id;
            dtHead.Rows[0]["MinState"] = "99";
            dtHead.Rows[0]["MaxState"] = "99"; ;
            dtHead.Rows[0]["LmDt"] = timeNow;
            dtHead.Rows[0]["LmUser"] = "DLWXSite";

            dtDetail.Rows[0]["CO1_ID"] = id;
            dtDetail.Rows[0]["State"] = "99";
            dtDetail.Rows[0]["LmDt"] = timeNow;
            dtDetail.Rows[0]["LmUser"] = "DLWXSite";

            bResult = conn.Update("[B02_BILL].[CO1_CustomerOrderHead]", dtHead, "ID='" + id + "'");
            bResult = conn.Update("[B02_BILL].[CO2_CustomerOrderDetail]", dtDetail, "CO1_ID='" + id + "'");

            //bResult = conn.Delete("[B02_BILL].[CO1_CustomerOrderHead]", "ID=" + "'" + id + "'");
            //bResult = conn.Delete("[B02_BILL].[CO2_CustomerOrderDetail]", "CO1_ID=" + "'" + id + "'");


            DataTable dt5 = conn.GetDataTable(@" SELECT  t1.Amount ,
                                                    t1.DeliveryDate ,
                                                    CONVERT(DECIMAL(20, 0), t2.Number) num ,
                                                    CASE WHEN t1.Desp = '' THEN '无'
                                                         ELSE t1.Desp
                                                    END Desp ,
                                                    '款号为:' + t4.STYL_Code + ',颜色:' + t3.STL2_Color + ',尺码' + t3.STL2_Size SKU,
		                                            t1.RgUser,
		                                            DEPT_ID
                                            FROM    [B02_BILL].[CO1_CustomerOrderHead] t1
                                                    LEFT JOIN [B02_BILL].[CO2_CustomerOrderDetail] t2 ON t1.ID = t2.CO1_ID
                                                    LEFT JOIN B01_MDM.STL2_StyleSKU t3 ON t2.STL2_ID = t3.STL2_ID
                                                    LEFT JOIN [B01_MDM].[STYL_Style] t4 ON t4.STYL_ID = t3.STL2_STYL_ID
                                            WHERE t1.ID='" + id + "' ");
            string contentAMCancel = "您好：顾客" + dt5.Rows[0]["RgUser"].ToString() + " 已经取消预约试穿,预约时间为： " + dt5.Rows[0]["DeliveryDate"] + "<br /> 预约款号为" + dt5.Rows[0]["SKU"].ToString() + " <br />  的商品，请您尽快与顾客取得联系，并做好服务工作，谢谢。 <br /> 如有疑问，请咨询0573-83386690";


            DataTable dtdepotinfo = m_conn.GetDataTable("SELECT d_name   FROM dbo.j_depot WHERE depotid='" + dt5.Rows[0]["DEPT_ID"].ToString() + "'");

            SendAM("AM", "WeiXin", dtdepotinfo.Rows[0]["d_name"].ToString(), "信息部服务中心", contentAMCancel, DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));


            conn.CommitTransaction();

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "订单取消成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "订单取消失败" });
            };
            m_dsRequturn.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 查询客户订单
        private void GetCustomerOrder()
        {
            string strSQL = @"SELECT A.[ID]
                          ,A.[ORB1_ID]
                          ,A.[Code]
                          ,A.[WeiXinID]
                          ,A.[DeliveryDate]
                          ,A.[MinState]
                          ,A.[MaxState]
                          ,A.[Amount]
                          ,A.[DEPT_ID]
                          ,A.[Phone]
                          ,A.[Desp]
                          ,A.[Rgdt]
                          ,A.[RgUser]
                          ,A.[LmDt]
                          ,A.[LmUser]
                          ,A.[UptNo]
                        ,B.[ID] AS DetailID
                        ,B.[Seq]
                        ,B.[SubSeq]
                        ,B.[STL2_ID]
                        ,B.[Number]
                        ,B.[Price]
                        ,B.[SellPrice]
                        ,B.[SettlementPrice]
                        ,B.[Amount] AS subAmount
                        ,Case When B.[State] = '20' Then '待取'
                              When B.[State] = '90' Then '完成'
                              When B.[State] = '99' Then '取消'
                         END AS State
                        ,C.[STL2_Color]
                        ,C.[STL2_Size]
                        ,D.[STYL_Name]
                        ,D.[STYL_Code]
                        ,D.[STYL_PicturePath]
                        ,E.j_name DEPT_NAME
                        ,E.g_sf
                        ,E.g_cs
                        ,E.g_address DEPT_Address
                        ,E.m_shoptel DEPT_Phone
                FROM [B02_BILL].[CO1_CustomerOrderHead] A with(NOLOCK)
                LEFT JOIN [B02_BILL].[CO2_CustomerOrderDetail] B with(NOLOCK) ON A.[ID]=B.[CO1_ID]
                LEFT JOIN [B01_MDM].[STL2_StyleSKU] C with(NOLOCK) ON B.[STL2_ID]=C.[STL2_ID]
                LEFT JOIN [B01_MDM].[STYL_Style] D with(NOLOCK) ON C.[STL2_STYL_ID]=D.[STYL_ID]
                LEFT JOIN mdm.MDM_Market2.dbo.V_L0013_BASE E with(NOLOCK) ON A.[DEPT_ID]=E.j_depotid
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
