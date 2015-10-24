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

/// 类名：HWA_CustomerJFchange
/// 类说明：HWA_CustomerJFchange(华之毅积分调整单加减积分) 
/// 创建人：郭琦琦
/// 创建日期：2015-07-14 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.CommonInterface
{
    public class HWA_CustomerJFchange : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public HWA_CustomerJFchange()
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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CustomerJFchange".ToUpper())//积分调整
                {
                    CustomerJFchange(dtList);
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

        #region 积分调整
        /// <summary>
        ///积分调整
        /// </summary>
        private void CustomerJFchange(DataTable pdt)
        {
            string strCOM = pdt.Rows[0]["COM"].ToString();//按照公司查询 公司(EP GL DL GL NP JL)
            string strConditionID = pdt.Rows[0]["ConditionID"].ToString();//条件ID (1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid )
            string strConditionValue = pdt.Rows[0]["ConditionValue"].ToString();//条件值 (13736814324)

            string strType = pdt.Rows[0]["type"].ToString();//条件值 (13736814324)   Add 增加积分	；Decrease 减少积分	
            string strIntegrale = pdt.Rows[0]["Integral"].ToString();//条件值 (13736814324)
            string strRemarks = pdt.Rows[0]["Remarks"].ToString();//条件值 (13736814324)

            //类型和公司不能为空
            if (strCOM == "" || strConditionID == "" || strType == "" || strIntegrale == "" || strIntegrale == "0")
            {
                dt_EditResult.Rows.Add(new object[] { false, "传入的条件错误，请检查条件！" });
                ds_Return.Tables.Add(dt_EditResult);
            }
            else
            {
                ds_Return = m_Conn.GetDataSetBySP("SP_HWA_CustomerJFchange", new string[4] { "@COM_Name", "@ConditionID", "@ConditionValue", "@DataStr" },
                            new string[4] { strCOM, strConditionID, strConditionValue, "【类型," + strType + "】【积分," + strIntegrale + "】【备注," + strRemarks + "】" });
            }
        }
        #endregion

        #endregion

        #region 内部函数


        #endregion
    }
}