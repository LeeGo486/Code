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

/// 类名：VIPCustomerInfo
/// 类说明：VIPCustomerInfo(VIP会员管理) 新增，修改
/// 创建人：郭琦琦
/// 创建日期：2015-03-28 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.CommonInterface
{
    public class VIPCustomerInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public VIPCustomerInfo()
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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCustomerInfo".ToUpper())//查询VIP信息
                {
                    GetCustomerInfo(dtList);
                }

                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddCustomerInfo".ToUpper())//新增会员
                {
                    AddCustomerInfo(dtList);
                }

                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UpdateCustomerInfo".ToUpper())//会员维护
                {
                    UpdateCustomerInfo(dtList);
                }

                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCustomerRetail".ToUpper())//获取顾客消费记录
                {
                    GetCustomerRetail(dtList);
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

        #region 查询VIP
        /// <summary>
        /// 查询VIP
        /// </summary>
        private void GetCustomerInfo(DataTable pdt)
        {
            //定义微信号，官网ID，手机号码，VIP号，VIP编号，类型，公司
            string strWXID = ""; string strCODE = ""; string strPHONE = ""; string strVIPCODE = ""; string strVIPID = ""; string strTYPE = ""; string strCOM = "";
            strTYPE = pdt.Rows[0]["TYPE"].ToString();//查询类型  1.按照微信号查询 2.官网ID查询 3.手机号查询 4. vip卡号查询 5.VIPID查询
            strCOM = pdt.Rows[0]["COM"].ToString();//按照公司查询
            string strSearchValue = "";

            //类型和公司不能为空
            if (strTYPE == "" || strCOM == "")
            {
                dt_EditResult.Rows.Add(new object[] { false, "类型和公司不能为空！" });
                ds_Return.Tables.Add(dt_EditResult);
            }
            else
            {
                //如果传过来的接口包含性别，Email 生日 省 市 就接受
                if (pdt.Columns.Contains("CODE")) { strCODE = pdt.Rows[0]["CODE"].ToString(); }
                if (pdt.Columns.Contains("WXID")) { strWXID = pdt.Rows[0]["WXID"].ToString(); }
                if (pdt.Columns.Contains("PHONE")) { strPHONE = pdt.Rows[0]["PHONE"].ToString(); }
                if (pdt.Columns.Contains("VIPCODE")) { strVIPCODE = pdt.Rows[0]["VIPCODE"].ToString(); }
                if (pdt.Columns.Contains("VIPID ")) { strVIPID = pdt.Rows[0]["VIPID "].ToString(); }
                if (pdt.Columns.Contains("TYPE ")) { strTYPE = pdt.Rows[0]["TYPE "].ToString(); }
                if (pdt.Columns.Contains("COM ")) { strCOM = pdt.Rows[0]["COM "].ToString(); }


                switch (strTYPE.ToUpper())
                {
                    case "1":
                        strSearchValue = strWXID;
                        break;
                    case "2":
                        strSearchValue = strCODE;
                        break;
                    case "3":
                        strSearchValue = strPHONE;
                        break;
                    case "4":
                        strSearchValue = strVIPCODE;
                        break;
                    case "5":
                        strSearchValue = strVIPID;
                        break;
                };
                ds_Return = m_Conn.GetDataSetBySP("SP_HWA_VIPCustomerInfo", new string[4] { "@COM_Name", "@OperationType", "@ConditionID", "@ConditionValue" },
                            new string[4] { strCOM, "SELECT", strTYPE, strSearchValue });
            }
        }
        #endregion

        #region 新增会员
        /// <summary>
        /// 新增会员
        /// </summary>
        private void AddCustomerInfo(DataTable pdt)
        {

            // 类型 1，微信，2，官网  公司 姓名 手机号码 性别 邮箱 生日 省 市 区
            string strTYPE = ""; string strCOM = ""; string strNAME = ""; string strPHONE = ""; string strWXID = ""; string strCODE = "";
            string strSEX = ""; string strEMAIL = ""; string strBIRTHDAY = ""; string strPROVINCE = ""; string strCITY = ""; string strCOUNTY = "";
            string strOCCUPATION = ""; string strWXNICK = ""; string strValue = ""; string strVIPCODE = ""; string strVIPID = ""; string strVIPADD = "";
            //如果传过来的接口包含性别，Email 生日 省 市 就接受
            if (pdt.Columns.Contains("TYPE")) { strTYPE = pdt.Rows[0]["TYPE"].ToString(); }
            if (pdt.Columns.Contains("COM")) { strCOM = pdt.Rows[0]["COM"].ToString(); }
            if (pdt.Columns.Contains("NAME")) { strNAME = pdt.Rows[0]["NAME"].ToString(); }
            if (pdt.Columns.Contains("PHONE")) { strPHONE = pdt.Rows[0]["PHONE"].ToString(); }
            if (pdt.Columns.Contains("SEX")) { strSEX = pdt.Rows[0]["SEX"].ToString(); }
            if (pdt.Columns.Contains("EMAIL")) { strEMAIL = pdt.Rows[0]["EMAIL"].ToString(); }
            if (pdt.Columns.Contains("BIRTHDAY")) { strBIRTHDAY = pdt.Rows[0]["BIRTHDAY"].ToString().Replace("年", "-").Replace("月", "-").Replace("日", "-"); }
            if (pdt.Columns.Contains("PROVINCE")) { strPROVINCE = pdt.Rows[0]["PROVINCE"].ToString(); }
            if (pdt.Columns.Contains("CITY")) { strCITY = pdt.Rows[0]["CITY"].ToString(); }
            if (pdt.Columns.Contains("COUNTY")) { strCOUNTY = pdt.Rows[0]["COUNTY"].ToString(); }
            if (pdt.Columns.Contains("WXID")) { strWXID = pdt.Rows[0]["WXID"].ToString(); }
            if (pdt.Columns.Contains("CODE")) { strCODE = pdt.Rows[0]["CODE"].ToString(); }
            if (pdt.Columns.Contains("OCCUPATION")) { strOCCUPATION = pdt.Rows[0]["OCCUPATION"].ToString(); }
            if (pdt.Columns.Contains("WXNICK")) { strWXNICK = pdt.Rows[0]["WXNICK"].ToString(); }
            if (pdt.Columns.Contains("VIPCODE")) { strVIPCODE = pdt.Rows[0]["VIPCODE"].ToString(); }
            if (pdt.Columns.Contains("VIPID")) { strVIPID = pdt.Rows[0]["VIPID"].ToString(); }
            if (pdt.Columns.Contains("VIPADD")) { strVIPADD = pdt.Rows[0]["VIPADD"].ToString(); }
            if (strTYPE == "" || strCOM == "" || strNAME == "" || strPHONE == "")//类型 公司 姓名 手机不能为空
            {
                dt_EditResult.Rows.Add(new object[] { false, "类型,公司,姓名,手机不能为空！" });
                ds_Return.Tables.Add(dt_EditResult);
            }
            else
            {
                switch (strTYPE.ToUpper())
                {
                    case "1":
                        strValue = strWXID;
                        break;
                    case "2":
                        strValue = strCODE;
                        break;
                    case "3":
                        strValue = strPHONE;
                        break;
                    case "4":
                        strValue = strVIPCODE;
                        break;
                    case "5":
                        strValue = strVIPID;
                        break;
                };
                ds_Return = m_Conn.GetDataSetBySP("SP_HWA_VIPCustomerInfo", new string[5] { "@COM_Name", "@OperationType", "@ConditionID", "@ConditionValue", "@DataStr" },
                 new string[5] { strCOM, "Insert", strTYPE, strValue, "【姓名," + strNAME + "】【手机号," + strPHONE + "】【生日," + strBIRTHDAY + @"】
                【官网ID," + strCODE + "】【省份," + strPROVINCE + "】【城市," + strCITY + "】【区," + strCOUNTY + "】【性别," + strSEX + "】【EMail," + strEMAIL + @"】
                【微信号ID," + strWXID + "】【微信昵称," + strWXNICK + "】【职业," + strOCCUPATION + "】【详细地址," + strVIPADD + "】" });
            }
        }

        #endregion

        #region 修改会员
        /// <summary>
        /// 修改会员
        /// </summary>
        private void UpdateCustomerInfo(DataTable pdt)
        {
            //1	WeiXinid	2	OnlineVipid	3	Mobtel	4	Vipcode	5	vipid )
            // 类型 1，微信，2，官网  公司 姓名 手机号码 性别 邮箱 生日 省 市
            string strTYPE = ""; string strCOM = ""; string strNAME = ""; string strPHONE = ""; string strWXID = ""; string strCODE = "";
            string strSEX = ""; string strEMAIL = ""; string strBIRTHDAY = ""; string strPROVINCE = ""; string strCITY = ""; string strCOUNTY = "";
            string strOCCUPATION = ""; string strWXNICK = ""; string strValue = ""; string strVIPCODE = ""; string strVIPID = ""; string strVIPADD = "";
            //如果传过来的接口包含性别，Email 生日 省 市 就接受
            if (pdt.Columns.Contains("TYPE")) { strTYPE = pdt.Rows[0]["TYPE"].ToString(); }
            if (pdt.Columns.Contains("COM")) { strCOM = pdt.Rows[0]["COM"].ToString(); }
            if (pdt.Columns.Contains("NAME")) { strNAME = pdt.Rows[0]["NAME"].ToString(); }
            if (pdt.Columns.Contains("PHONE")) { strPHONE = pdt.Rows[0]["PHONE"].ToString(); }
            if (pdt.Columns.Contains("SEX")) { strSEX = pdt.Rows[0]["SEX"].ToString(); }
            if (pdt.Columns.Contains("EMAIL")) { strEMAIL = pdt.Rows[0]["EMAIL"].ToString(); }
            if (pdt.Columns.Contains("BIRTHDAY")) { strBIRTHDAY = pdt.Rows[0]["BIRTHDAY"].ToString().Replace("年", "-").Replace("月", "-").Replace("日", ""); }
            if (pdt.Columns.Contains("PROVINCE")) { strPROVINCE = pdt.Rows[0]["PROVINCE"].ToString(); }
            if (pdt.Columns.Contains("COUNTY")) { strCOUNTY = pdt.Rows[0]["COUNTY"].ToString(); }
            if (pdt.Columns.Contains("CITY")) { strCITY = pdt.Rows[0]["CITY"].ToString(); }
            if (pdt.Columns.Contains("WXID")) { strWXID = pdt.Rows[0]["WXID"].ToString(); }
            if (pdt.Columns.Contains("CODE")) { strCODE = pdt.Rows[0]["CODE"].ToString(); }
            if (pdt.Columns.Contains("OCCUPATION")) { strOCCUPATION = pdt.Rows[0]["OCCUPATION"].ToString(); }
            if (pdt.Columns.Contains("WXNICK")) { strWXNICK = pdt.Rows[0]["WXNICK"].ToString(); }
            if (pdt.Columns.Contains("VIPCODE")) { strVIPCODE = pdt.Rows[0]["VIPCODE"].ToString(); }
            if (pdt.Columns.Contains("VIPID")) { strVIPID = pdt.Rows[0]["VIPID"].ToString(); }
            if (pdt.Columns.Contains("VIPADD")) { strVIPADD = pdt.Rows[0]["VIPADD"].ToString(); }
            if (strTYPE == "" || strCOM == "")//类型 公司 不能为空
            {
                dt_EditResult.Rows.Add(new object[] { false, "类型,公司不能为空！" });
                ds_Return.Tables.Add(dt_EditResult);
            }
            else
            {

                switch (strTYPE.ToUpper())
                {
                    case "1":
                        //if (strWXID == "" || strBIRTHDAY == "" || strPROVINCE == "" || strCITY == "" || strSEX == "")
                        //{
                        //    dt_EditResult.Rows.Add(new object[] { false, "微信号，生日，省，市，性别不能为空！" });
                        //    ds_Return.Tables.Add(dt_EditResult);
                        //}
                        strValue = strWXID;
                        break;
                    case "2":
                        //if (strNAME == "" || strPHONE == "" || strBIRTHDAY == "" || strCODE == "")
                        //{
                        //    dt_EditResult.Rows.Add(new object[] { false, "姓名，手机，生日，官网code不能为空！" });
                        //    ds_Return.Tables.Add(dt_EditResult);
                        //}
                        strValue = strCODE;
                        break;
                    case "3":
                        strValue = strPHONE;
                        break;
                    case "4":
                        strValue = strVIPCODE;
                        break;
                    case "5":
                        strValue = strVIPID;
                        break;
                }

                ds_Return = m_Conn.GetDataSetBySP("SP_HWA_VIPCustomerInfo", new string[5] { "@COM_Name", "@OperationType", "@ConditionID", "@ConditionValue", "@DataStr" },
                 new string[5] { strCOM, "Update", strTYPE, strValue, "【姓名," + strNAME + "】【手机号," + strPHONE + "】【生日," + strBIRTHDAY + @"】
                 【官网ID," + strCODE +"】【省份," + strPROVINCE + "】【城市," + strCITY + "】【区," + strCOUNTY + "】【性别," + strSEX + "】【EMail," + strEMAIL + @"】
                 【微信号ID," + strWXID +"】【微信昵称," + strWXNICK + "】【职业," + strOCCUPATION + "】【详细地址," + strVIPADD + "】" });
            }
        }

        #endregion

        #region 查询VIP消费记录
        /// <summary>
        /// 查询VIP消费记录
        /// </summary>
        private void GetCustomerRetail(DataTable pdt)
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
                ds_Return = m_Conn.GetDataSetBySP("SP_HWA_CustomerRetail", new string[3] { "@COM_Name", "@ConditionID", "@ConditionValue" },
                            new string[3] { strCOM, strConditionID, strConditionValue });
            }
        }
        #endregion
        #endregion

        #region 内部函数


        #endregion
    }
}