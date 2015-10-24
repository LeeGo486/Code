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

/// 类名：VIP_Search
/// 类说明：对VIP_Search(VIP消费记录查询)
/// 创建人：郭琦琦
/// 创建日期：2014-06-26 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.StoreBusinessSystem
{
    public class VIP_Search : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public VIP_Search()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("F22GP");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();
        string strBeginDate = "";//全局变量,开始时间
        string strEndDate = "";//全局变量,结束时间
        string strVipCode = "";//全局变量,VIP卡号

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

                strBeginDate = ds.Tables["list"].Rows[0]["begindate"].ToString();//取前台传过来的开始时间
                strEndDate = ds.Tables["list"].Rows[0]["enddate"].ToString();//取前台传过来的结束时间
                strVipCode = ds.Tables["list"].Rows[0]["vipcode"].ToString();//取前台传过来的VIP卡号

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetVIPUSER".ToUpper())//查询VIP客户资料
                {
                    GetVIPUSER();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDRETAIL".ToUpper()) //消费明细
                {
                    GetDRETAIL();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetVIPJFCHANG".ToUpper())//积分变动记录
                {
                    GetVIPJFCHANG();
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

        #region 查询VIP客户资料
        /// <summary>
        /// 查询VIP客户资料
        /// </summary>
        private void GetVIPUSER()
        {
            string strSQL = @"
                                SELECT  vipcode vipcode ,
                                                vipname 姓名 ,
                                                vipsex 性别,
                                                vipbirth 出生日期 ,
                                                vipstate VIP状态 ,
                                                centum 总积分 ,
                                                sums 总储值 ,
                                                viptel 固定电话 ,
                                                mobtel 移动电话 ,
                                                vipoccupation 职业 ,
                                                country 籍贯 ,
                                                city 所在区域 ,
                                                vipadd 通讯地址 ,
                                                tz_name 拓展人
                                        FROM    VIP_USER WITH ( NOLOCK )
                                        WHERE   vipcode = '" + strVipCode + @"' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #region 消费明细
        /// <summary>
        /// 消费明细
        /// </summary>
        private void GetDRETAIL()
        {
            m_hzyPageInfo.Order = "销售日期";
            //m_hzyPageInfo.Sort = " DESC ";
            m_hzyPageInfo.PageRowCount = 0;
            string strSQL = @"
                             SELECT b.retailid 零售单号 ,
                                    b.vipcode VIP卡号 ,
                                    b.depotid 店铺编号 ,
                                    d.d_name 店铺名称 ,
                                    b.setdate 销售日期 ,
                                    c.clothingid 款号 ,
                                    c.x_price 现价 ,
                                    c.discount 折扣 ,
                                    c.nums 数量 ,
                                    c.s_price 结算价 ,
                                    c.FSSums 结算金额 ,
                                    c.FCalcSums 实销金额 ,
                                    c.vipcentum 积分 ,
                                    CASE WHEN c.j_price * c.nums = 0 THEN 0
                                         ELSE c.FCalcSums / c.j_price * c.nums
                                    END 实销折扣
                             FROM   D_RETAIL b WITH ( NOLOCK )
                                    LEFT JOIN D_RETAILSUB c WITH ( NOLOCK ) ON b.retailid = c.retailid
                                    LEFT JOIN dbo.j_depot d WITH ( NOLOCK ) ON b.depotid = d.depotid
                             WHERE  b.sure = 1
                                    AND b.setdate >= '" + strBeginDate + @"' 
                                    AND b.setdate <= '" + strEndDate + @"'
                                    AND EXISTS ( SELECT 1
                                                 FROM   dbo.vip_cardvip G WITH ( NOLOCK )
                                                        LEFT JOIN vip_user J ON G.vipid = J.vipid
                                                 WHERE  J.vipcode = '" + strVipCode + @"'
                                                        AND G.vipcardid = b.vipcode )" + m_hzyPageInfo.Where;
            m_conn.TimeOut = 3360000;
            //ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] {}, m_hzyPageInfo);
            ds_Return = m_conn.GetDataSet(strSQL);

        }
        #endregion

        #region 积分变动记录
        /// <summary>
        /// 积分变动记录
        /// </summary>
        private void GetVIPJFCHANG()
        {
            m_hzyPageInfo.Order = "调整日期";
            //m_hzyPageInfo.Sort = " DESC ";
            m_hzyPageInfo.PageRowCount = 0;
            string strSQL = @"
                            SELECT  
                                    CONVERT(VARCHAR(10), A.setdate, 120) AS 调整日期 ,
                                    B.centum 调整积分,
                                    B.sums 调整储值,
                                    B.comment  说明
                            FROM    vip_jfchange A WITH ( NOLOCK )
                                    LEFT JOIN vip_jfchangesub B WITH ( NOLOCK ) ON a.jfid = b.jfid
                            WHERE   A.setdate >= '" + strBeginDate + @"'
                                    AND A.setdate <= '" + strEndDate + @"'
                                    AND EXISTS ( SELECT *
                                                    FROM   dbo.vip_cardvip G WITH ( NOLOCK )
                                                        LEFT JOIN vip_user J ON G.vipid = J.vipid
                                                    WHERE  J.vipcode = '" + strVipCode + @"'
                                                        AND G.vipcardid = B.vipcode )
                                                        " + m_hzyPageInfo.Where;
            //ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] {}, m_hzyPageInfo);
            ds_Return = m_conn.GetDataSet(strSQL);
        }
        #endregion

        #endregion
    }
}