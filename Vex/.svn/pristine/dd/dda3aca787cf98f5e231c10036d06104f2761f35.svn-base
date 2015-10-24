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

/// 类名：HWA_CustomerTicketInfo
/// 类说明：HWA_CustomerTicketInfo(华之毅券查询，送券，积分兑换券) 
/// 创建人：郭琦琦
/// 创建日期：2015-07-09 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.CommonInterface
{
    public class HWA_CustomerTicketInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public HWA_CustomerTicketInfo()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_Conn = new Dbconn("CUSGP");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();
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
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];
                //bool bResult = false;

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCustomerTicketInfo".ToUpper())//查询券信息
                {
                    GetCustomerTicketInfo(dtList);
                }

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddTicket".ToUpper())//新增券，送券
                {
                    AddTicket(dtList);
                }

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddTicketByExchangeIntegral".ToUpper())//积分兑换送券
                {
                    AddTicketByExchangeIntegral(dtList);
                }

                if (ds_Return.Tables.Count > 0)
                {
                    for (int i = 0; i < ds_Return.Tables.Count; i++)
                    {
                        if (ds_Return.Tables[0].Columns.Contains("Column1"))
                        {
                            ds_Return.Tables.RemoveAt(0);
                        }
                    }
                }
                return ds_Return;
            }
            catch
            {
                m_Conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 查询券信息
        /// <summary>
        ///查询券信息
        /// </summary>
        private void GetCustomerTicketInfo(DataTable pdt)
        {
            string strCOM = pdt.Rows[0]["COM"].ToString();//按照公司查询 公司(EP GL DL GL NP JL)
            string strConditionID = pdt.Rows[0]["ConditionID"].ToString();//条件ID (1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid )
            string strConditionValue = pdt.Rows[0]["ConditionValue"].ToString();//条件值 (13736814324)

            //类型和公司不能为空
            if (strCOM == "" || strConditionID == "")
            {
                dt_EditResult.Rows.Add(new object[] { false, "类型和公司不能为空！" });
                ds_Return.Tables.Add(dt_EditResult);
            }
            else
            {
                ds_Return = m_Conn.GetDataSetBySP("SP_HWA_CustomerTicketInfo", new string[4] { "@COM_Name", "@OperationType", "@ConditionID", "@ConditionValue" },
                            new string[4] { strCOM, "SELECT", strConditionID, strConditionValue });
            }
        }
        #endregion

        #region 新增券，送券
        /// <summary>
        /// 新增券，送券
        /// </summary>
        private void AddTicket(DataTable pdt)
        {
            string strCOM = ""; //按照公司查询 公司(EP GL DL GL NP JL)
            string strConditionID = ""; //1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid )
            string strConditionValue = "";//条件值 (13736814324)
            string strType = "";//券类型 0 抵值券; 1 现金券; 2 打折券	INT
            string strTicketName = "";//券名称显示在前台的名称啦
            string strTicketTypeNumber = "";//券类型编号需在DRP系统存在，并且使用每个公司自己的
            //string strDeductionIntegral = "";//扣减积分
            string strParType = "";//面值类型
            string strPar = "";//面值
            string strEffectiveWay = "";//生效方式 0 有效天数;1 截止日期;2 日期段	INT	PS:日期段方式 结束日期那天券就失效

            string strDay = "";//有效天数
            string strUpToTime = "";//截至时间
            string strBeginDate = "";//开始时间
            string strEndDate = "";//结束时间


            if (pdt.Columns.Contains("COM")) { strCOM = pdt.Rows[0]["COM"].ToString(); }
            if (pdt.Columns.Contains("ConditionID")) { strConditionID = pdt.Rows[0]["ConditionID"].ToString(); }
            if (pdt.Columns.Contains("ConditionValue")) { strConditionValue = pdt.Rows[0]["ConditionValue"].ToString(); }
            if (pdt.Columns.Contains("EffectiveWay")) { strEffectiveWay = pdt.Rows[0]["EffectiveWay"].ToString(); }
            if (pdt.Columns.Contains("Type")) { strType = pdt.Rows[0]["Type"].ToString(); }
            if (pdt.Columns.Contains("TicketName")) { strTicketName = pdt.Rows[0]["TicketName"].ToString(); }
            if (pdt.Columns.Contains("TicketTypeNumber")) { strTicketTypeNumber = pdt.Rows[0]["TicketTypeNumber"].ToString(); }
            //if (pdt.Columns.Contains("DeductionIntegral")) { strDeductionIntegral = pdt.Rows[0]["DeductionIntegral"].ToString(); }
            if (pdt.Columns.Contains("ParType")) { strParType = pdt.Rows[0]["ParType"].ToString(); }
            if (pdt.Columns.Contains("Day")) { strDay = pdt.Rows[0]["Day"].ToString(); }
            if (pdt.Columns.Contains("UpToTime")) { strUpToTime = pdt.Rows[0]["UpToTime"].ToString(); }
            if (pdt.Columns.Contains("BeginDate")) { strBeginDate = pdt.Rows[0]["BeginDate"].ToString(); }
            if (pdt.Columns.Contains("EndDate")) { strEndDate = pdt.Rows[0]["EndDate"].ToString(); }

            if (strCOM == "" || strConditionID == "" || strConditionValue == "" || strEffectiveWay == ""
                || strType == "" || strTicketName == "" || strTicketTypeNumber == "" || strParType == "" ||
                (strDay == "" && strUpToTime == "" && (strBeginDate == "" && strEndDate == "")))
            {
                dt_EditResult.Rows.Add(new object[] { false, "请检查条件！" });
                ds_Return.Tables.Add(dt_EditResult);
            }
            else
            {
                if (strParType == "1")//如果是1，面值就是88块钱
                {
                    strPar = "88";
                }
                if ((strEffectiveWay == "0" && strDay == "") ||
                    (strEffectiveWay == "1" && (strUpToTime == "") ||
                    (strEffectiveWay == "2" && (strBeginDate == "" || strEndDate == ""))
                    )) //0 有效天数;1 截止日期;2 日期段	INT	PS:日期段方式 结束日期那天券就失效
                {
                    dt_EditResult.Rows.Add(new object[] { false, "请检查条件！" });
                    ds_Return.Tables.Add(dt_EditResult);
                }
                else
                {
                    ds_Return = m_Conn.GetDataSetBySP("SP_HWA_CustomerTicketInfo", new string[5] { "@COM_Name", "@OperationType", "@ConditionID", "@ConditionValue", "@DataStr" },
                     new string[5] { strCOM, "Insert", strConditionID, strConditionValue, "【类型,Give】【生效方式," + strEffectiveWay + "】【种类," + strType + "】【名称," + strTicketName + "】【面值," + strPar + "】【券类型编号," + strTicketTypeNumber + "】【有效天数," + strDay + "】【截止日期," + strUpToTime + "】【开始日期," + strBeginDate + "】【结束日期," + strEndDate + "】" });
                }
            }
        }

        #endregion

        #region 积分兑换送券
        /// <summary>
        /// 积分兑换送券
        /// </summary>
        private void AddTicketByExchangeIntegral(DataTable pdt)
        {
            string strCOM = ""; //按照公司查询 公司(EP GL DL GL NP JL)
            string strConditionID = ""; //1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid )
            string strConditionValue = "";//条件值 (13736814324)
            string strType = "";//券类型 0 抵值券; 1 现金券; 2 打折券	INT
            string strTicketName = "";//券名称显示在前台的名称啦
            string strTicketTypeNumber = "";//券类型编号需在DRP系统存在，并且使用每个公司自己的
            string strDeductionIntegralType = "";//扣减积分类型
            string strDeductionIntegral = "";//扣减积分
            string strParType = "";//面值类型
            string strPar = "";//面值
            string strEffectiveWay = "";//生效方式 0 有效天数;1 截止日期;2 日期段	INT	PS:日期段方式 结束日期那天券就失效

            string strDay = "";//有效天数
            string strUpToTime = "";//截至时间
            string strBeginDate = "";//开始时间
            string strEndDate = "";//结束时间

            if (pdt.Columns.Contains("COM")) { strCOM = pdt.Rows[0]["COM"].ToString(); }
            if (pdt.Columns.Contains("ConditionID")) { strConditionID = pdt.Rows[0]["ConditionID"].ToString(); }
            if (pdt.Columns.Contains("ConditionValue")) { strConditionValue = pdt.Rows[0]["ConditionValue"].ToString(); }
            if (pdt.Columns.Contains("EffectiveWay")) { strEffectiveWay = pdt.Rows[0]["EffectiveWay"].ToString(); }
            if (pdt.Columns.Contains("Type")) { strType = pdt.Rows[0]["Type"].ToString(); }
            if (pdt.Columns.Contains("TicketName")) { strTicketName = pdt.Rows[0]["TicketName"].ToString(); }
            if (pdt.Columns.Contains("TicketTypeNumber")) { strTicketTypeNumber = pdt.Rows[0]["TicketTypeNumber"].ToString(); }
            if (pdt.Columns.Contains("DeductionIntegralType")) { strDeductionIntegralType = pdt.Rows[0]["DeductionIntegralType"].ToString(); }
            if (pdt.Columns.Contains("ParType")) { strParType = pdt.Rows[0]["ParType"].ToString(); }
            if (pdt.Columns.Contains("Day")) { strDay = pdt.Rows[0]["Day"].ToString(); }
            if (pdt.Columns.Contains("UpToTime")) { strUpToTime = pdt.Rows[0]["UpToTime"].ToString(); }
            if (pdt.Columns.Contains("BeginDate")) { strBeginDate = pdt.Rows[0]["BeginDate"].ToString(); }
            if (pdt.Columns.Contains("EndDate")) { strEndDate = pdt.Rows[0]["EndDate"].ToString(); }

            if (strCOM == "" || strConditionID == "" || strConditionValue == "" || strEffectiveWay == ""
                || strType == "" || strTicketName == "" || strTicketTypeNumber == "" || strDeductionIntegralType == "" || strParType == "" ||
                (strDay == "" && strUpToTime == "" && (strBeginDate == "" && strEndDate == "")))
            {
                dt_EditResult.Rows.Add(new object[] { false, "请检查条件！" });
                ds_Return.Tables.Add(dt_EditResult);
            }
            else
            {

                if (strParType == "1")//如果是1，面值就是88块钱
                {
                    strPar = "88";
                }
                else if (strParType == "2")//如果是2，面值就是200块钱
                {
                    strPar = "200";
                }

                if (strTicketTypeNumber == "14")
                {
                    strTicketName = strPar + "元券";
                }

                if (strDeductionIntegralType == "1")
                {
                    strDeductionIntegral = "5000";
                }
                else if (strDeductionIntegralType == "2")
                {
                    strDeductionIntegral = "10000";
                }

                if ((strEffectiveWay == "0" && strDay == "") ||
                    (strEffectiveWay == "1" && (strUpToTime == "") ||
                    (strEffectiveWay == "2" && (strBeginDate == "" || strEndDate == ""))
                    )) //0 有效天数;1 截止日期;2 日期段	INT	PS:日期段方式 结束日期那天券就失效
                {
                    dt_EditResult.Rows.Add(new object[] { false, "请检查条件！" });
                    ds_Return.Tables.Add(dt_EditResult);
                }
                else
                {
                    ds_Return = m_Conn.GetDataSetBySP("SP_HWA_CustomerTicketInfo", new string[5] { "@COM_Name", "@OperationType", "@ConditionID", "@ConditionValue", "@DataStr" },
                     new string[5] { strCOM, "Insert", strConditionID, strConditionValue, "【类型,Exchange】【生效方式," + strEffectiveWay + "】【种类," + strType + "】【名称," + strTicketName + "】【面值," + strPar + "】【券类型编号," + strTicketTypeNumber + "】【有效天数," + strDay + "】【截止日期," + strUpToTime + "】【开始日期," + strBeginDate + "】【结束日期," + strEndDate + "】【扣减积分," + strDeductionIntegral + "】" });
                }
            }
        }

        #endregion
        #endregion

        #region 内部函数


        #endregion
    }
}