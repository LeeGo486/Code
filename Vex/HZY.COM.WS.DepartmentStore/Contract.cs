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

/// 类名：Contract
/// 类说明：对Contract(百货应收合同管理)
/// 创建人：郭琦琦
/// 创建日期：2014-11-01 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.DepartmentStore
{
    public class Contract : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Contract()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("DepartmentStore");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();
        DateTime timeNow = DateTime.Now;
        string m_type = "";//主子类型
        string m_UserName;

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
                m_type = dtList.Rows[0]["type"].ToString();//主子表类型
                m_UserName = hzyMessage.User_Name_CN;//登入姓名
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetContractInfo".ToUpper())//获取合同信息
                {
                    GetContractInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EditContractInfo".ToUpper())//编辑合同信息
                {
                    EditContractInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DelContractInfo".ToUpper())//删除合同信息
                {
                    DelContractInfo(dtList);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "exportExcel".ToUpper())//独立导出
                {
                    exportExcel(dtList);
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

        #region 获取合同信息
        /// <summary>
        /// 获取合同信息
        /// </summary>
        private void GetContractInfo(DataTable pdt)
        {
            string strGetContractInfoSQL = "";
            //如果m_type 为head 主表操作
            if (m_type == "head")
            {
                strGetContractInfoSQL = @"
                                       SELECT  *
                                            FROM    ( SELECT    t1.CONH_ID ,
                                                                t1.CONH_M01P_ID ,
                                                                t1.CONH_M02C_ID ,
                                                                t1.CONH_Code ,
                                                                t1.CONH_DEPT_ID ,
                                                                t1.CONH_Area ,
                                                                CONVERT(VARCHAR(10), t1.CONH_StartDate, 120) CONH_StartDate ,
                                                                CONVERT(VARCHAR(10), t1.CONH_EndDate, 120) CONH_EndDate ,
                                                                t1.CONH_State ,
                                                                CONVERT(VARCHAR(10), t1.CONH_CheckDate, 120) CONH_CheckDate ,
                                                                t1.CONH_MonthCloseDate ,
                                                                CONVERT(VARCHAR(10), t1.CONH_DelayDate, 120) CONH_DelayDate ,
                                                                t1.CONH_DelayState ,
                                                                CONVERT(VARCHAR(10), t1.CONH_Rgdt, 120) CONH_Rgdt ,
                                                                t1.CONH_RgUser ,
                                                                CONVERT(VARCHAR(10), t1.CONH_LmDt, 120) CONH_LmDt ,
                                                                t1.CONH_LmUser ,
                                                                t1.CONH_UptNo ,
                                                                t2.店铺名称 ,
                                                                t2.督导姓名 督导 ,
                                                                t2.店铺等级 ,
                                                                t2.楼层 ,
                                                                t2.位置 ,
                                                                t2.开店时间
                                                      FROM      [B02_BILL].[CONH_ContractHead] t1
                                                                LEFT JOIN DSReader.MDM_Market2.dbo.V_L0013 t2 ON t1.CONH_DEPT_ID = t2.店铺ID
                                                                WHERE ISNULL(CONH_State,'') != '已删除'
                                                    ) T9
                                            WHERE   1 = 1    " + m_hzyPageInfo.Where;
            }
            else
            {
                strGetContractInfoSQL = @"SELECT    COND_ID ,
                                                    COND_M01P_ID ,
                                                    COND_M02C_ID ,
                                                    COND_DPCN_ID ,
                                                    COND_FeeName ,
                                                    COND_CalculateType ,
                                                    COND_FeePeriod ,
                                                    CONVERT(VARCHAR(10), COND_StartDate, 120) COND_StartDate ,
                                                    CONVERT(VARCHAR(10), COND_EndDate, 120) COND_EndDate ,
                                                    COND_SaleTask ,
                                                    COND_GuaranteeAmount ,
                                                    COND_TotalPeriod ,
                                                    COND_PayType ,
                                                    COND_FixAmount ,
                                                    COND_FixRate ,
                                                    COND_InGuaranteeRate ,
                                                    COND_OutGuaranteeRate ,
                                                    COND_PayDesp ,
                                                    CONVERT(VARCHAR(10), COND_Rgdt, 120) COND_Rgdt ,
                                                    COND_RgUser ,
                                                    CONVERT(VARCHAR(10), COND_LmDt, 120) COND_LmDt ,
                                                    COND_LmUser ,
                                                    COND_UptNo
                                                    FROM B02_BILL.COND_ContractDetail WITH ( NOLOCK ) WHERE   1 = 1 " + m_hzyPageInfo.Where;
            }
            ds_Return = m_conn.GetDataSetForPageList(strGetContractInfoSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 导出
        /// <summary>
        /// 导出
        /// </summary>
        private void exportExcel(DataTable pdt)
        {
            m_hzyPageInfo.Page = 1;
            m_hzyPageInfo.PageRowCount = 100000;
            string strexportExcel = @"
                                       SELECT * FROM (
                                        SELECT  t2.CONH_Code 合同编号 ,
                                                t3.店铺名称 ,
                                                t3.督导姓名 ,
                                                t3.店铺等级 ,
                                                t3.楼层 ,
                                                t3.位置 ,
                                                t2.conh_area 合同面积 ,
                                                t3.开店时间 ,
                                                t2.conh_startdate 起始时间主 ,
                                                t2.CONH_EndDate 截止时间主 ,
                                                t2.CONH_State 状态 ,
                                                t2.conh_checkdate 对账日期 ,
                                                t2.conh_delaydate 延期时间 ,
                                                t2.conh_delaystate 延期状态 ,
                                                T1.COND_FeeName 费用名称 ,
                                                t1.COND_CalculateType 计算类型 ,
                                                t1.COND_FeePeriod 费用周期 ,
                                                t1.COND_StartDate 起始时间子 ,
                                                t1.COND_EndDate 截止时间 ,
                                                t1.COND_SaleTask 销售任务 ,
                                                t1.COND_GuaranteeAmount 保底金额 ,
                                                t1.COND_TotalPeriod 累计周期 ,
                                                T1.COND_PayType 扣款类型 ,
                                                T1.COND_FixAmount 固定金额 ,
                                                T1.COND_FixRate 固定扣点 ,
                                                T1.COND_InGuaranteeRate 保内扣点 ,
                                                T1.COND_OutGuaranteeRate 保外扣点 ,
                                                T1.COND_PayDesp 扣费说明,
                                                t2.CONH_Rgdt
                                        FROM    B02_BILL.COND_ContractDetail T1
                                                RIGHT JOIN B02_BILL.CONH_ContractHead T2 ON T1.COND_DPCN_ID = T2.CONH_ID
                                                LEFT JOIN DSReader.MDM_Market2.dbo.V_L0013 t3 ON t2.CONH_DEPT_ID = t3.店铺ID
                                        WHERE   T2.CONH_State != '已删除') T99
                                        WHERE   1 = 1    " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strexportExcel, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 编辑合同信息
        /// <summary>
        /// 编辑合同信息
        /// </summary>
        private void EditContractInfo(DataTable pdt)
        {
            if (m_type == "head")
            {
                string strConh_id = ds.Tables["list"].Rows[0]["conh_id"].ToString();//conh_id编号
                string strConh_code = ds.Tables["list"].Rows[0]["conh_code"].ToString();//conh_code编号
                string strConh_startdate = ds.Tables["list"].Rows[0]["conh_startdate"].ToString();//合同开始时间
                string strConh_dept_id = ds.Tables["list"].Rows[0]["conh_dept_id"].ToString();//店铺编号

                string strConh_idV = "";
                m_conn.BeginTransaction(); // 开启事务
                bool bResult = false;
                string strGuid = System.Guid.NewGuid().ToString();//创建GUID

                //验证合同好是否存在
                if (strConh_id == "")
                {
                    strConh_idV = strGuid;
                }
                else
                {
                    strConh_idV = strConh_id;
                }
                string strVar = m_conn.GetDataTableFirstValue(@" 
                                                              SELECT  count(*) count  
                                                              FROM  [B02_BILL].[CONH_ContractHead] 
                                                              WHERE   conh_code ='" + strConh_code + "' and conh_id != '" + strConh_idV + "'").ToString();
                if (strVar != "0")
                {
                    //throw new Exception("该合同号已经存在!");
                    dt_EditResult.Rows.Add(new object[] { "1", "该合同号已经存在" });
                }
                else
                {
                    if (strConh_id == "" || strConh_id == null)
                    {
                        string strIsHere = m_conn.GetDataTableFirstValue(@" 
                                                              SELECT  COUNT(*) COUNT
                                                              FROM    B02_BILL.CONH_ContractHead
                                                              WHERE   CONH_DEPT_ID = '" + strConh_dept_id + @"'
                                                              AND  conh_state != '已删除' ").ToString();
                        if (strIsHere != "0")
                        {
                            string strIsTime = m_conn.GetDataTableFirstValue(@" 
                                                              SELECT  COUNT(*) COUNT
                                                              FROM    B02_BILL.CONH_ContractHead
                                                              WHERE   CONH_DEPT_ID = '" + strConh_dept_id + @"'
                                                              AND  CONH_EndDate < '" + strConh_startdate + "'").ToString();
                            if (strIsHere != "1")
                            {
                                throw new Exception("每家店铺同一合同期内只有一个商场合同，不允许重复建 ！");
                            }
                        }
                        else
                        {
                            ds.Tables["list"].Columns.Remove("type");
                            ds.Tables["List"].Rows[0]["conh_id"] = strGuid;
                            ds.Tables["list"].Columns.Add("conh_rgdt");
                            ds.Tables["list"].Columns.Add("conh_rguser");
                            ds.Tables["list"].Columns.Add("conh_lmdt");
                            ds.Tables["list"].Columns.Add("conh_lmuser");
                            ds.Tables["list"].Columns.Add("conh_uptno");
                            ds.Tables["List"].Rows[0]["conh_rguser"] = m_UserName;
                            ds.Tables["List"].Rows[0]["conh_rgdt"] = timeNow;
                            ds.Tables["List"].Rows[0]["conh_lmuser"] = m_UserName;
                            ds.Tables["List"].Rows[0]["conh_lmdt"] = timeNow;
                            ds.Tables["List"].Rows[0]["conh_uptno"] = "0";
                            bResult = m_conn.Insert("[B02_BILL].[CONH_ContractHead]", ds.Tables["List"]);
                        }
                    }
                    else
                    {


                        string strNo = m_conn.GetDataTableFirstValue(" SELECT  CONH_UptNo  FROM  [B02_BILL].[CONH_ContractHead] WHERE   conh_id ='" + strConh_id + "'").ToString();
                        int NmaxUpdateNo = Convert.ToInt32(strNo) + 1;
                        ds.Tables["list"].Columns.Remove("type");
                        ds.Tables["list"].Columns.Add("conh_lmuser");
                        ds.Tables["list"].Columns.Add("conh_lmdt");
                        ds.Tables["list"].Columns.Add("conh_uptno");
                        ds.Tables["List"].Rows[0]["conh_lmuser"] = m_UserName;
                        ds.Tables["List"].Rows[0]["conh_lmdt"] = timeNow;
                        ds.Tables["List"].Rows[0]["conh_uptno"] = NmaxUpdateNo;

                        ArrayList listKey = new ArrayList();
                        listKey.Add("conh_id");
                        bResult = m_conn.Update("[B02_BILL].[CONH_ContractHead]", ds.Tables["List"], listKey);
                    }
                    m_conn.CommitTransaction();   //提交事务

                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "提交失败" });
                    }
                }
            }
            else if (m_type == "detail")
            {
                string strCond_id = ds.Tables["list"].Rows[0]["cond_id"].ToString();//cond_id编号

                m_conn.BeginTransaction(); // 开启事务
                bool bResult = false;
                string strGuid = System.Guid.NewGuid().ToString();//创建GUID

                if (strCond_id == "" || strCond_id == null)
                {
                    ds.Tables["list"].Columns.Remove("type");

                    ds.Tables["List"].Rows[0]["cond_id"] = strGuid;
                    ds.Tables["list"].Columns.Add("cond_rgdt");
                    ds.Tables["list"].Columns.Add("cond_rguser");
                    ds.Tables["list"].Columns.Add("cond_lmdt");
                    ds.Tables["list"].Columns.Add("cond_lmuser");
                    ds.Tables["list"].Columns.Add("cond_uptno");
                    ds.Tables["List"].Rows[0]["cond_rguser"] = m_UserName;
                    ds.Tables["List"].Rows[0]["cond_rgdt"] = timeNow;
                    ds.Tables["List"].Rows[0]["cond_lmuser"] = m_UserName;
                    ds.Tables["List"].Rows[0]["cond_lmdt"] = timeNow;
                    ds.Tables["List"].Rows[0]["cond_uptno"] = "0";
                    bResult = m_conn.Insert("[B02_BILL].[COND_ContractDetail]", ds.Tables["List"]);
                }
                else
                {
                    CheckNumColumnValue(ds);//验证关键列里面值是否为空,如果为空为0
                    string strNoD = m_conn.GetDataTableFirstValue(" SELECT  CONd_UptNo  FROM  [B02_BILL].COND_ContractDetail WHERE   cond_id ='" + strCond_id + "'").ToString();
                    int NmaxUpdateNoD = Convert.ToInt32(strNoD) + 1;

                    ds.Tables["list"].Columns.Remove("type");
                    ds.Tables["list"].Columns.Add("cond_lmuser");
                    ds.Tables["list"].Columns.Add("cond_lmdt");
                    ds.Tables["list"].Columns.Add("cond_uptno");
                    ds.Tables["List"].Rows[0]["cond_lmuser"] = m_UserName;
                    ds.Tables["List"].Rows[0]["cond_lmdt"] = timeNow;
                    ds.Tables["List"].Rows[0]["cond_uptno"] = NmaxUpdateNoD;

                    ArrayList listKey = new ArrayList();
                    listKey.Add("cond_id");
                    bResult = m_conn.Update("[B02_BILL].COND_ContractDetail", ds.Tables["List"], listKey);
                }
                m_conn.CommitTransaction();   //提交事务

                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "提交失败" });
                }

            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 删除合同信息
        /// <summary>
        /// 删除合同信息
        /// </summary>
        private void DelContractInfo(DataTable pdt)
        {
            if (m_type == "head")
            {
                string strConh_id = pdt.Rows[0]["conh_id"].ToString();//合同ID

                m_conn.BeginTransaction();

                string strSQL2 = @"UPDATE [B02_BILL].[CONH_ContractHead] SET CONH_State ='已删除' WHERE conh_id ='" + strConh_id + "'";

                m_conn.ExcuteQuerryByTran(strSQL2, new object[] { });

                m_conn.CommitTransaction();

                dt_EditResult.Rows.Add(new object[] { true, "成功" });
            }
            else if (m_type == "detail")
            {
                string strCond_id = pdt.Rows[0]["cond_id"].ToString();//合同ID子表

                m_conn.BeginTransaction();

                string strSQL3 = @"DELETE FROM [B02_BILL].[COND_ContractDetail]  WHERE cond_id ='" + strCond_id + "'";

                m_conn.ExcuteQuerryByTran(strSQL3, new object[] { });

                m_conn.CommitTransaction();

                dt_EditResult.Rows.Add(new object[] { true, "成功" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region CheckNumColumnValue检查列值，如果为空，附上默认值
        /// <summary>
        /// 检查列值，如果为空，附上默认值
        /// </summary>
        /// <param name="pds"></param>
        private void CheckNumColumnValue(DataSet pds)
        {
            if (pds.Tables["list"].Columns.Contains("cond_outguaranteerate") && pds.Tables["list"].Rows[0]["cond_outguaranteerate"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["cond_outguaranteerate"] = "0";
            }
            if (pds.Tables["list"].Columns.Contains("cond_inguaranteerate") && pds.Tables["list"].Rows[0]["cond_inguaranteerate"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["cond_inguaranteerate"] = "0";
            }
            if (pds.Tables["list"].Columns.Contains("cond_fixrate") && pds.Tables["list"].Rows[0]["cond_fixrate"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["cond_fixrate"] = "0";
            }
            if (pds.Tables["list"].Columns.Contains("cond_fixamount") && pds.Tables["list"].Rows[0]["cond_fixamount"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["cond_fixamount"] = "0";
            }
        }
        #endregion

        #endregion
    }
}