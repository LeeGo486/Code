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

/// 类名：CheckWorkAttendance
/// 类说明：总部考勤
/// 创建人：郭琦琦
/// 创建日期：2014-10-30
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.PointToPoint
{
    public class CheckWorkAttendance : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public CheckWorkAttendance()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("EHRFORSalary");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        string strMaxID;//最大值
        int nMaxID, nMaxID1, nMaxID2, nMaxID3, nMaxID4, nMaxID5, nMaxID6, nMaxID7, nMaxID8, nMaxID9, nMaxID10;//最大值加123...
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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCheckWorkAttendance".ToUpper())//获取考勤信息
                {
                    GetCheckWorkAttendance(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "InsertAttendance".ToUpper())//考勤信息
                {
                    InsertAttendance(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetMangeCardRecordInfo".ToUpper())//获取漏打卡信息
                {
                    GetMangeCardRecordInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ApplyInfo".ToUpper())//申请漏打卡
                {
                    ApplyInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckDologin".ToUpper())//验证登入信息
                {
                    CheckDologin(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ApplyEdit".ToUpper())//申请漏打卡插入
                {
                    ApplyEdit(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetApprove".ToUpper())//获取审批考勤时间
                {
                    GetApprove(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Approve".ToUpper())//审批考勤
                {
                    Approve(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetOvertimeSearch".ToUpper())//加班申请查询
                {
                    GetOvertimeSearch(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ApplyOvertime".ToUpper())//加班申请插入
                {
                    ApplyOvertime(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetApplyOvertime".ToUpper())//获取审批信息
                {
                    GetApplyOvertime(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ApproveOvertime".ToUpper())//审批加班信息
                {
                    ApproveOvertime(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetVacationSearch".ToUpper())//休假申请查询
                {
                    GetVacationSearch(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckVacation".ToUpper())//休假申请插入验证是否该时间段存在休假申请
                {
                    CheckVacation(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ApplyVacation".ToUpper())//休假申请插入
                {
                    ApplyVacation(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetApproveVacationInfo".ToUpper())//获取审批休假信息
                {
                    GetApproveVacationInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ApproveVacationInfo".ToUpper())//审批休假信息
                {
                    ApproveVacationInfo(dtList);
                }

                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetBusinessOutSearch".ToUpper())//公出申请查询
                {
                    GetBusinessOutSearch(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CheckBusinessOut".ToUpper())//公出申请插入验证是否该时间段存在休假申请
                {
                    CheckBusinessOut(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ApplyBusinessOut".ToUpper())//公出申请插入
                {
                    ApplyBusinessOut(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetApproveBusinessOutInfo".ToUpper())//获取审批公出信息
                {
                    GetApproveBusinessOutInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ApproveBusinessOutInfo".ToUpper())//审批公出信息
                {
                    ApproveBusinessOutInfo(dtList);
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

        #region 考勤

        #region 获取考勤信息
        /// <summary>
        /// 获取考勤信息
        /// </summary>
        private void GetCheckWorkAttendance(DataTable pdt)
        {

            string strSfz = pdt.Rows[0]["sfz"].ToString();
            string strMonth = pdt.Rows[0]["month"].ToString();
            string strYear = pdt.Rows[0]["year"].ToString();


            string strEHRSQL = @"   SELECT  t2.C_NAME ,
                                            t1.C_EMPOID ,
                                            CONVERT(VARCHAR(10),t1.C_CARDRECORDDATE,20) C_CARDRECORDDATE ,
                                            t1.C_CARDRECORDTIME,
                                            YEAR(t1.C_CARDRECORDDATE) year ,
                                            MONTH(t1.C_CARDRECORDDATE) month
                                    FROM    ehr.TB_V_TMG_CARDRECORD t1 WITH ( NOLOCK )
                                            LEFT JOIN ehr.TB_INF_EMPLOYEE t2 ON t1.C_EMPOID = t2.C_OID
                                    WHERE   t2.C_IDCARD = '" + strSfz + "' AND YEAR(t1.C_CARDRECORDDATE) = '" + strYear + "' AND MONTH(t1.C_CARDRECORDDATE) = '" + strMonth + "' ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion

        #region 考勤信息
        /// <summary>
        /// 考勤信息
        /// </summary>
        private void InsertAttendance(DataTable pdt)
        {
            m_conn.BeginTransaction();

            //            string strDate = pdt.Rows[0]["date"].ToString();
            //            string strTime = pdt.Rows[0]["time"].ToString();
            //            string strDateTime = strDate + " " + strTime;
            //            DateTime dCreateTime = Convert.ToDateTime(strDateTime).AddMinutes(10);


            //            string strInsertSQL = @"   
            //                                DECLARE   @MAXC_OID_CARDRECORD BIGINT
            //                                SELECT    @MAXC_OID_CARDRECORD = MAX(C_OID_CARDRECORD)+1
            //                                FROM      [ehr].[TB_TMG_CARDRECORD]
            //                                WHERE     C_TEMPLEID = '0'
            //  
            //                                INSERT    INTO ehr.TB_TMG_CARDRECORD
            //                                        ( C_OID_CARDRECORD ,
            //                                            C_OPERATOR ,
            //                                            C_OPERATETIME ,
            //                                            C_EMPOID ,
            //                                            C_CARDRECORDTIME ,
            //                                            C_CARDRECORDDATE ,
            //                                            C_TEMPLEID
            //                                        )
            //                                VALUES    ( @MAXC_OID_CARDRECORD ,
            //                                            '1' ,
            //                                           '" + dCreateTime + @"' ,
            //                                            '84886467' ,
            //                                            '" + strDateTime + @"' ,
            //                                            '" + strDate + @"' ,
            //                                            '0' 
            //                                        )";
            // m_conn.ExcuteQuerryByTran(strInsertSQL, new object[] { });
            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 获取漏打卡信息
        /// <summary>
        /// 获取漏打卡信息
        /// </summary>
        private void GetMangeCardRecordInfo(DataTable pdt)
        {

            //string strName = pdt.Rows[0]["name"].ToString();
            string strMonth = pdt.Rows[0]["month"].ToString();
            string strYear = pdt.Rows[0]["year"].ToString();
            string strsfz = pdt.Rows[0]["sfz"].ToString();

            //strName = "郭琦琦";
            //strMonth = "3";
            //strYear = "2014";
            //strsfz = "330411198702140811";

            string strMangeCardRecordInfo = @"  
                             SELECT  t2.C_NAME ,
                                    t2.C_CODE ,
                                    t1.C_RENEWTIMECARDTIME ,
                                    t2.C_IDCARD ,
                                    t1.C_OPERATETIME ,
                                    t1.C_UNCARDRECORDREASON ,
                                    t1.C_REMARK ,
                                    t1.C_OID ,
                                    CASE when t1.C_STATUS = 1 THEN '审批通过' ELSE'审批不通过' END C_STATUS
                            FROM    ehr.[TB_V_TMG_MANGECARDRECORD] t1
                                    LEFT JOIN ehr.TB_INF_EMPLOYEE t2 ON t1.C_EMPOID = t2.c_oid   
                            WHERE   t2.C_IDCARD = '" + strsfz + "' AND YEAR(t1.C_OPERATETIME) = '"
                                                + strYear + "' AND MONTH(t1.C_OPERATETIME) = '"
                                                + strMonth + "' AND t2.C_IDCARD = '" + strsfz + "'";
            ds_Return = m_conn.GetDataSet(strMangeCardRecordInfo, new string[] { });
        }
        #endregion

        #region 申请漏打卡审批人
        /// <summary>
        /// 申请漏打卡
        /// </summary>
        private void ApplyInfo(DataTable pdt)
        {

            string strsfz = pdt.Rows[0]["sfz"].ToString();
            //strName = "郭琦琦";
            //strMonth = "3";
            //strYear = "2014";
            //strsfz = "330411198702140811";
            //string strName = pdt.Rows[0]["name"].ToString();
            //strsfz = "330411198702140811";
            string c_oid = m_conn.GetDataTableFirstValue(" SELECT  top 1 C_OID FROM    ehr.TB_INF_EMPLOYEE WHERE   C_IDCARD = '" + strsfz + "' ORDER BY C_JOINUNITDATE DESC ", new string[] { }).ToString();



            string strApply = @"  
                             SELECT  t1.C_NAME sjC_NAME ,
                                    t1.C_CODE sjC_CODE ,
                                    t1.C_OID sjC_OID ,
                                    '1' type
                            FROM    EHR.TB_INF_EMPLOYEE T1 ,
                                    EHR.TB_ORG_AJOBRELATION t3 ,
                                    EHR.TB_INF_EMPLOYEE t2
                            WHERE   t2.C_OID = @Param0
                                    AND t3.C_HIBERARCHYID = 1
                                    AND t2.C_JOBID = t3.C_AJOBID
                                    AND T1.C_JOBID = t3.C_PARENTAJOBID
                                    AND t3.C_STATUS = '1'
                                    AND t3.C_PARENTAJOBID <> 0
                                    AND t2.C_JOBID > 0
                                    AND ( T1.C_EMPLOYEESTATUS = '2'
                                            OR T1.C_EMPLOYEESTATUS = '1'
                                        )
                            UNION ALL
                            ( SELECT    T6.c_name ,
                                        T6.C_CODE ,
                                        T6.C_OID ,
                                        '2' type
                                FROM      ehr.TB_INF_EMPLOYEE T6 ,
                                        ehr.TB_INF_EMPLOYEE t4 ,
                                        ehr.TB_ORG_AJOBRELATION t5
                                WHERE     t4.C_OID IN ( SELECT    t9.C_OID
                                                        FROM      EHR.TB_INF_EMPLOYEE t9 ,
                                                                EHR.TB_ORG_AJOBRELATION t8 ,
                                                                EHR.TB_INF_EMPLOYEE t7
                                                        WHERE     t7.C_OID = @Param0
                                                                AND t8.C_HIBERARCHYID = 1
                                                                AND t7.C_JOBID = t8.C_AJOBID
                                                                AND t9.C_JOBID = t8.C_PARENTAJOBID
                                                                AND t8.C_STATUS = '1' )
                                        AND t5.C_HIBERARCHYID = 1
                                        AND t4.C_JOBID = t5.C_AJOBID
                                        AND T6.C_JOBID = t5.C_PARENTAJOBID
                                        AND T6.C_JOBID > 0
                                        AND t5.C_STATUS = '1'
                                        AND ( T6.C_EMPLOYEESTATUS = '2'
                                                OR T6.C_EMPLOYEESTATUS = '1'
                                                OR T6.C_EMPLOYEESTATUS = '7'
                                            )
                            )";

            ds_Return = m_conn.GetDataSet(strApply, new string[] { c_oid });
        }
        #endregion

        #region 漏打卡申请插入
        /// <summary>
        /// 漏打卡申请插入
        /// </summary>
        private void ApplyEdit(DataTable pdt)
        {
            DateTime timeNow = DateTime.Now;
            //string strName = pdt.Rows[0]["name"].ToString();
            string straddDate = pdt.Rows[0]["adddate"].ToString();//申请时间
            string straddDate1 = pdt.Rows[0]["adddate1"].ToString();//班次1
            string straddDate2 = pdt.Rows[0]["adddate2"].ToString();//班次2
            string straddcause = pdt.Rows[0]["addcause"].ToString();//申请原因
            string strchangeAP1 = pdt.Rows[0]["addchangeap1"].ToString();//一级审批员工号
            string strchangeAP2 = pdt.Rows[0]["addchangeap2"].ToString();//二级审批员工号
            string straddremarks = pdt.Rows[0]["addremarks"].ToString();//备注
            string strc_oid = pdt.Rows[0]["c_oid"].ToString();//员工号
            string strc_oid_code;//员工编号

            strc_oid_code = m_conn.GetDataTableFirstValue(@"SELECT*FROM ehr.TB_SYS_USER WHERE C_EMPLOYEEID='" + strc_oid + "'").ToString();

            m_conn.BeginTransaction();

            GetMaxID();//获取最大值和后面的ID
            #region 如果二个审批人的时候
            if (strchangeAP1 != "" && strchangeAP2 != "")//如果有2个审批人的时候
            {
                #region 如果有2个班次的时候
                if (straddDate1 != "" && straddDate2 != "")//如果有2个班次的时候
                {
                    //1          
                    string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW
                        )( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                    m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP1, "0", "0", strc_oid_code, timeNow, nMaxID1 });

                    //1.1
                    string strSQL11 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW
                        )( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                    m_conn.ExcuteQuerryByTran(strSQL11, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP2, "0", nMaxID1, strc_oid_code, timeNow, nMaxID2 });

                    //2
                    string strSQL2 = @"
                        insert into ehr.TB_TMG_RENEWCARDSIGN  (C_RENEWREMARK, C_OPERATETIME, C_OPERATOR, C_APPROVEFLOWID, C_APPLYSTATUS, C_OID_RENEWCARDSIGN 
                         ) (SELECT 
                         @Param0 C_RENEWREMARK,  @Param1 C_OPERATETIME,  @Param2 C_OPERATOR,  @Param3 C_APPROVEFLOWID,  @Param4 C_APPLYSTATUS,  @Param5 C_OID_RENEWCARDSIGN)";
                    m_conn.ExcuteQuerryByTran(strSQL2, new object[] { straddremarks, timeNow, "0", nMaxID1, "0", nMaxID3 });

                    //3
                    string strSQL3 = @"insert into ehr.TB_TMG_CARDSIGNEMP (C_OPERATETIME, C_OPERATOR, C_RENEWTIMECARDTIME, C_REMARK, C_UNCARDRECORDREASON, C_CONFIRMSTATUS, C_APPLYDATE, C_RENEWCARDSIGNID, C_EMPOID, C_OID_CARDSIGNEMP
                                    ) (SELECT  @Param0 C_OPERATETIME,  @Param1 C_OPERATOR,  @Param2 C_RENEWTIMECARDTIME,  @Param3 C_REMARK,  @Param4 C_UNCARDRECORDREASON,  @Param5 C_CONFIRMSTATUS,  @Param6 C_APPLYDATE,  @Param7 C_RENEWCARDSIGNID,  @Param8 C_EMPOID,  @Param9 C_OID_CARDSIGNEMP)";
                    m_conn.ExcuteQuerryByTran(strSQL3, new object[] { timeNow, strc_oid_code, straddDate1, straddremarks, straddcause, "0", timeNow, nMaxID3, strc_oid, nMaxID4 });

                    //4
                    string strSQL4 = @"insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW 
                                  ) ( SELECT @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,  @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW )";
                    m_conn.ExcuteQuerryByTran(strSQL4, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP1, "0", "0", strc_oid_code, timeNow, nMaxID5 });

                    //4.1
                    string strSQL41 = @"insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW 
                                  ) ( SELECT @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,  @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW )";
                    m_conn.ExcuteQuerryByTran(strSQL41, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP2, "0", nMaxID5, strc_oid_code, timeNow, nMaxID6 });

                    //5
                    string strSQL5 = @"insert into ehr.TB_TMG_RENEWCARDSIGN (C_RENEWREMARK, C_OPERATETIME, C_OPERATOR, C_APPROVEFLOWID, C_APPLYSTATUS, C_OID_RENEWCARDSIGN 
                                ) (SELECT  
                                 @Param0 C_RENEWREMARK,  @Param1 C_OPERATETIME,  @Param2 C_OPERATOR,  @Param3 C_APPROVEFLOWID,  @Param4 C_APPLYSTATUS,  @Param5 C_OID_RENEWCARDSIGN)";
                    m_conn.ExcuteQuerryByTran(strSQL5, new object[] { straddremarks, timeNow, "0", nMaxID5, "0", nMaxID7 });

                    //5.1
                    string strSQL51 = @"insert into ehr.TB_TMG_CARDSIGNEMP (C_OPERATETIME, C_OPERATOR, C_RENEWTIMECARDTIME, C_REMARK, C_UNCARDRECORDREASON, C_CONFIRMSTATUS, C_APPLYDATE, C_RENEWCARDSIGNID, C_EMPOID, C_OID_CARDSIGNEMP
                                    ) (SELECT  @Param0 C_OPERATETIME,  @Param1 C_OPERATOR,  @Param2 C_RENEWTIMECARDTIME,  @Param3 C_REMARK,  @Param4 C_UNCARDRECORDREASON,  @Param5 C_CONFIRMSTATUS,  @Param6 C_APPLYDATE,  @Param7 C_RENEWCARDSIGNID,  @Param8 C_EMPOID,  @Param9 C_OID_CARDSIGNEMP)";
                    m_conn.ExcuteQuerryByTran(strSQL51, new object[] { timeNow, strc_oid_code, straddDate2, straddremarks, straddcause, "0", timeNow, nMaxID7, strc_oid, nMaxID8 });

                    //6
                    string strSQL6 = @"update ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , 
                                                                     C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7  where C_OID_APPROVEFLOW= @Param8 ";
                    m_conn.ExcuteQuerryByTran(strSQL6, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP1, nMaxID2, "0", strc_oid_code, timeNow, nMaxID1 });

                    //7
                    string strSQL7 = @"update ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , 
                                                                     C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7  where C_OID_APPROVEFLOW= @Param8 ";
                    m_conn.ExcuteQuerryByTran(strSQL7, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP1, nMaxID6, "0", strc_oid_code, timeNow, nMaxID5 });

                }
                #endregion

                #region 如果只有一个漏打卡
                else//如果只有一个漏打卡
                {
                    string date = "";//定义漏打卡时间
                    if (straddDate1 == "")
                    {
                        date = straddDate2;
                    }
                    else
                    {
                        date = straddDate1;
                    }
                    //1
                    string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW
                        )( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                    m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP1, "0", "0", strc_oid_code, timeNow, nMaxID1 });

                    //1.1
                    string strSQL11 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW
                        )( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                    m_conn.ExcuteQuerryByTran(strSQL11, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP2, "0", nMaxID1, strc_oid_code, timeNow, nMaxID2 });

                    //2
                    string strSQL2 = @"
                        insert into ehr.TB_TMG_RENEWCARDSIGN  (C_RENEWREMARK, C_OPERATETIME, C_OPERATOR, C_APPROVEFLOWID, C_APPLYSTATUS, C_OID_RENEWCARDSIGN 
                         ) (SELECT 
                         @Param0 C_RENEWREMARK,  @Param1 C_OPERATETIME,  @Param2 C_OPERATOR,  @Param3 C_APPROVEFLOWID,  @Param4 C_APPLYSTATUS,  @Param5 C_OID_RENEWCARDSIGN)";
                    m_conn.ExcuteQuerryByTran(strSQL2, new object[] { straddremarks, timeNow, "0", nMaxID1, "0", nMaxID3 });

                    //3
                    string strSQL3 = @"insert into ehr.TB_TMG_CARDSIGNEMP (C_OPERATETIME, C_OPERATOR, C_RENEWTIMECARDTIME, C_REMARK, C_UNCARDRECORDREASON, C_CONFIRMSTATUS, C_APPLYDATE, C_RENEWCARDSIGNID, C_EMPOID, C_OID_CARDSIGNEMP
                                    ) (SELECT  @Param0 C_OPERATETIME,  @Param1 C_OPERATOR,  @Param2 C_RENEWTIMECARDTIME,  @Param3 C_REMARK,  @Param4 C_UNCARDRECORDREASON,  @Param5 C_CONFIRMSTATUS,  @Param6 C_APPLYDATE,  @Param7 C_RENEWCARDSIGNID,  @Param8 C_EMPOID,  @Param9 C_OID_CARDSIGNEMP)";
                    m_conn.ExcuteQuerryByTran(strSQL3, new object[] { timeNow, strc_oid_code, date, straddremarks, straddcause, "0", timeNow, nMaxID3, strc_oid, nMaxID4 });

                    //4
                    string strSQL4 = @"insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW 
                                  ) ( SELECT @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,  @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW )";
                    m_conn.ExcuteQuerryByTran(strSQL4, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP1, "0", "0", strc_oid_code, timeNow, nMaxID5 });


                    //4.1
                    string strSQL41 = @"insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW 
                                  ) ( SELECT @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,  @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW )";
                    m_conn.ExcuteQuerryByTran(strSQL41, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP2, "0", nMaxID5, strc_oid_code, timeNow, nMaxID6 });

                    //5
                    string strSQL5 = @"insert into ehr.TB_TMG_RENEWCARDSIGN (C_RENEWREMARK, C_OPERATETIME, C_OPERATOR, C_APPROVEFLOWID, C_APPLYSTATUS, C_OID_RENEWCARDSIGN 
                                ) (SELECT  
                                 @Param0 C_RENEWREMARK,  @Param1 C_OPERATETIME,  @Param2 C_OPERATOR,  @Param3 C_APPROVEFLOWID,  @Param4 C_APPLYSTATUS,  @Param5 C_OID_RENEWCARDSIGN)";
                    m_conn.ExcuteQuerryByTran(strSQL5, new object[] { straddremarks, timeNow, "0", nMaxID5, "0", nMaxID7 });

                    //6
                    string strSQL6 = @"update ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , 
                                                                     C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7  where C_OID_APPROVEFLOW= @Param8 ";
                    m_conn.ExcuteQuerryByTran(strSQL6, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP1, nMaxID2, "0", strc_oid_code, timeNow, nMaxID1 });

                    //7
                    string strSQL7 = @"update ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , 
                                                                     C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7  where C_OID_APPROVEFLOW= @Param8 ";
                    m_conn.ExcuteQuerryByTran(strSQL7, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strchangeAP1, nMaxID6, "0", strc_oid_code, timeNow, nMaxID5 });
                }
                #endregion
            }
            #endregion

            #region 如果只有一个审批人的时候
            else//如果只有一个审批人的时候ok
            {
                string change = "";//定义审批人
                if (strchangeAP1 == "")
                {
                    change = strchangeAP2;
                }
                else
                {
                    change = strchangeAP1;
                }
                #region 一个审批人,二个时间
                if (straddDate1 != "" && straddDate2 != "")//如果有2个班次的时候
                {
                    //1
                    string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW
                        )( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                    m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, change, "0", "0", strc_oid_code, timeNow, nMaxID1 });
                    //2
                    string strSQL2 = @"
                        insert into ehr.TB_TMG_RENEWCARDSIGN  (C_RENEWREMARK, C_OPERATETIME, C_OPERATOR, C_APPROVEFLOWID, C_APPLYSTATUS, C_OID_RENEWCARDSIGN 
                         ) (SELECT 
                         @Param0 C_RENEWREMARK,  @Param1 C_OPERATETIME,  @Param2 C_OPERATOR,  @Param3 C_APPROVEFLOWID,  @Param4 C_APPLYSTATUS,  @Param5 C_OID_RENEWCARDSIGN)";
                    m_conn.ExcuteQuerryByTran(strSQL2, new object[] { straddremarks, timeNow, "0", nMaxID1, "0", nMaxID2 });
                    //3
                    string strSQL3 = @"insert into ehr.TB_TMG_CARDSIGNEMP (C_OPERATETIME, C_OPERATOR, C_RENEWTIMECARDTIME, C_REMARK, C_UNCARDRECORDREASON, C_CONFIRMSTATUS, C_APPLYDATE, C_RENEWCARDSIGNID, C_EMPOID, C_OID_CARDSIGNEMP
                                    ) (SELECT  @Param0 C_OPERATETIME,  @Param1 C_OPERATOR,  @Param2 C_RENEWTIMECARDTIME,  @Param3 C_REMARK,  @Param4 C_UNCARDRECORDREASON,  @Param5 C_CONFIRMSTATUS,  @Param6 C_APPLYDATE,  @Param7 C_RENEWCARDSIGNID,  @Param8 C_EMPOID,  @Param9 C_OID_CARDSIGNEMP)";
                    m_conn.ExcuteQuerryByTran(strSQL3, new object[] { timeNow, strc_oid_code, straddDate1, straddremarks, straddcause, "0", timeNow, nMaxID2, strc_oid, nMaxID3 });

                    //4
                    string strSQL4 = @"insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW 
                                  ) ( SELECT @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,  @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW )";
                    m_conn.ExcuteQuerryByTran(strSQL4, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, change, "0", "0", strc_oid_code, timeNow, nMaxID4 });
                    //5
                    string strSQL5 = @"insert into ehr.TB_TMG_RENEWCARDSIGN (C_RENEWREMARK, C_OPERATETIME, C_OPERATOR, C_APPROVEFLOWID, C_APPLYSTATUS, C_OID_RENEWCARDSIGN 
                                ) (SELECT  
                                 @Param0 C_RENEWREMARK,  @Param1 C_OPERATETIME,  @Param2 C_OPERATOR,  @Param3 C_APPROVEFLOWID,  @Param4 C_APPLYSTATUS,  @Param5 C_OID_RENEWCARDSIGN)";
                    m_conn.ExcuteQuerryByTran(strSQL5, new object[] { straddremarks, timeNow, "0", nMaxID4, "0", nMaxID5 });
                    //6
                    string strSQL6 = @"insert into ehr.TB_TMG_CARDSIGNEMP (C_OPERATETIME, C_OPERATOR, C_RENEWTIMECARDTIME, C_REMARK, C_UNCARDRECORDREASON, C_CONFIRMSTATUS, C_APPLYDATE, C_RENEWCARDSIGNID, C_EMPOID, C_OID_CARDSIGNEMP
                                    )  (SELECT @Param0 C_OPERATETIME,  @Param1 C_OPERATOR,  @Param2 C_RENEWTIMECARDTIME,  @Param3 C_REMARK,  @Param4 C_UNCARDRECORDREASON,  @Param5 C_CONFIRMSTATUS,  @Param6 C_APPLYDATE,  @Param7 C_RENEWCARDSIGNID,  @Param8 C_EMPOID,  @Param9 C_OID_CARDSIGNEMP)";
                    m_conn.ExcuteQuerryByTran(strSQL6, new object[] { timeNow, strc_oid_code, straddDate2, straddremarks, straddcause, "0", timeNow, nMaxID5, strc_oid, nMaxID6 });
                }
                #endregion

                #region 一个审批人,一个时间
                else//一个审批人,一个时间
                {
                    string date = "";//定义漏打卡时间
                    if (straddDate1 == "")
                    {
                        date = straddDate2;
                    }
                    else
                    {
                        date = straddDate1;
                    }
                    //1
                    string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW
                        ) (SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                    m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, change, "0", "0", strc_oid_code, timeNow, nMaxID1 });
                    //2
                    string strSQL2 = @"
                        insert into ehr.TB_TMG_RENEWCARDSIGN  (C_RENEWREMARK, C_OPERATETIME, C_OPERATOR, C_APPROVEFLOWID, C_APPLYSTATUS, C_OID_RENEWCARDSIGN 
                         )( SELECT 
                         @Param0 C_RENEWREMARK,  @Param1 C_OPERATETIME,  @Param2 C_OPERATOR,  @Param3 C_APPROVEFLOWID,  @Param4 C_APPLYSTATUS,  @Param5 C_OID_RENEWCARDSIGN)";
                    m_conn.ExcuteQuerryByTran(strSQL2, new object[] { straddremarks, timeNow, "0", nMaxID1, "0", nMaxID2 });
                    //3
                    string strSQL3 = @"insert into ehr.TB_TMG_CARDSIGNEMP (C_OPERATETIME, C_OPERATOR, C_RENEWTIMECARDTIME, C_REMARK, C_UNCARDRECORDREASON, C_CONFIRMSTATUS, C_APPLYDATE, C_RENEWCARDSIGNID, C_EMPOID, C_OID_CARDSIGNEMP
                                    ) (SELECT  @Param0 C_OPERATETIME,  @Param1 C_OPERATOR,  @Param2 C_RENEWTIMECARDTIME,  @Param3 C_REMARK,  @Param4 C_UNCARDRECORDREASON,  @Param5 C_CONFIRMSTATUS,  @Param6 C_APPLYDATE,  @Param7 C_RENEWCARDSIGNID,  @Param8 C_EMPOID,  @Param9 C_OID_CARDSIGNEMP)";
                    m_conn.ExcuteQuerryByTran(strSQL3, new object[] { timeNow, strc_oid_code, date, straddremarks, straddcause, "0", timeNow, nMaxID2, strc_oid, nMaxID3 });

                    //4
                    string strSQL4 = @"insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW 
                                  ) ( SELECT @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,  @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW )";
                    m_conn.ExcuteQuerryByTran(strSQL4, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, change, "0", "0", strc_oid_code, timeNow, nMaxID4 });
                    //5
                    string strSQL5 = @"insert into ehr.TB_TMG_RENEWCARDSIGN (C_RENEWREMARK, C_OPERATETIME, C_OPERATOR, C_APPROVEFLOWID, C_APPLYSTATUS, C_OID_RENEWCARDSIGN 
                                ) ( SELECT 
                                 @Param0 C_RENEWREMARK,  @Param1 C_OPERATETIME,  @Param2 C_OPERATOR,  @Param3 C_APPROVEFLOWID,  @Param4 C_APPLYSTATUS,  @Param5 C_OID_RENEWCARDSIGN)";
                    m_conn.ExcuteQuerryByTran(strSQL5, new object[] { straddremarks, timeNow, "0", nMaxID4, "0", nMaxID5 });
                }
                #endregion
            }
            #endregion

            m_conn.CommitTransaction();

            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 获取审批考勤时间
        /// <summary>
        /// 获取审批考勤时间
        /// </summary>
        private void GetApprove(DataTable pdt)
        {


            string stroid = pdt.Rows[0]["oid"].ToString();
            //stroid = "81505586";
            string strApproveInfo = @"  
                             SELECT TOP 100
                                    t3.C_CODE,
                                    t3.C_NAME,
                                    t3.C_JOBNAME,
                                    t3.C_UNITNAME,
                                    T1.C_OID_CARDSIGNEMP ,
                                    T2.C_OID_RENEWCARDSIGN ,
                                    T1.C_OPERATETIME ,
                                    T1.C_OPERATOR ,
                                    T1.C_RENEWTIMECARDTIME ,
                                      CASE WHEN T1.C_REMARK ='' THEN '无' ELSE  T1.C_REMARK END C_REMARK,
                                    T1.C_UNCARDRECORDREASON ,
                                    T1.C_CONFIRMSTATUS,
                                    T1.C_APPLYDATE ,
                                    T1.C_RENEWCARDSIGNID  ,
                                    T1.C_EMPOID ,
                                    CASE WHEN T2.C_RENEWREMARK ='' THEN '无' ELSE  T2.C_RENEWREMARK END C_RENEWREMARK,
                                    T2.C_OPERATETIME ,
                                    T2.C_OPERATETIME ,
                                    T2.C_OPERATOR ,
                                    T2.C_APPROVEFLOWID ,
                                    CASE WHEN T2.C_APPLYSTATUS ='0' THEN '未审批' ELSE '审批通过' END C_APPLYSTATUS
                            FROM    ehr.TB_TMG_CARDSIGNEMP T1 ,
                                    ehr.TB_INF_EMPLOYEE T3 ,
                                    ehr.TB_TMG_RENEWCARDSIGN T2 ,
                                    ehr.TB_TMG_APPROVEFLOW T4
                            WHERE   T1.C_RENEWCARDSIGNID = T2.C_OID_RENEWCARDSIGN
                                    AND T1.C_EMPOID = T3.C_OID
                                    AND T4.C_OID_APPROVEFLOW = T2.C_APPROVEFLOWID
                                    AND T4.C_APPROVEEMPID ='" + stroid + @"' 
                                    AND ( T2.C_APPLYSTATUS = '1'
                                          OR T2.C_APPLYSTATUS = '0'
                                        )
                                    AND ( T4.C_RESULT IS NULL )
                            ORDER BY T1.C_OPERATETIME DESC";
            ds_Return = m_conn.GetDataSet(strApproveInfo, new string[] { });
        }
        #endregion

        #region 漏打卡审批
        /// <summary>
        /// 漏打卡审批
        /// </summary>
        private void Approve(DataTable pdt)
        {

            DateTime timeNow = DateTime.Now;
            string strc_oid = pdt.Rows[0]["c_oid"].ToString();//员工号
            string stroid_user = pdt.Rows[0]["m_oid_user"].ToString();//员工编号(操作员)
            string strc_approveflowid = pdt.Rows[0]["c_approveflowid"].ToString();//流程号
            string strc_oid_renewcardsign = pdt.Rows[0]["c_oid_renewcardsign"].ToString();//审批流程号
            string strc_remark = pdt.Rows[0]["c_remark"].ToString();//申请原因
            string strc_renewremark = pdt.Rows[0]["c_renewremark"].ToString();//备注
            string strapptype = pdt.Rows[0]["apptype"].ToString();//备注

            m_conn.BeginTransaction();

            #region
            if (strapptype == "1")
            {
                string strSQL1 = @"
                update  ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7 
                where C_OID_APPROVEFLOW = @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { timeNow, strc_remark, "0", strc_oid, "0", "0", stroid_user, timeNow, strc_approveflowid });
                string strSQL11 = @"
                update  ehr.TB_TMG_RENEWCARDSIGN set C_RENEWREMARK= @Param0 , C_OPERATETIME= @Param1 , C_OPERATOR= @Param2 , C_APPROVEFLOWID= @Param3 , C_APPLYSTATUS= @Param4
                where C_OID_RENEWCARDSIGN= @Param5 ";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { strc_renewremark, timeNow, "0", strc_approveflowid, "2", strc_oid_renewcardsign });
            }
            else
            {
                string strSQL1 = @"
                update  ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7 
                where C_OID_APPROVEFLOW = @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { timeNow, strc_remark, "0", strc_oid, "0", "0", stroid_user, timeNow, strc_approveflowid });
                string strSQL11 = @"
                update  ehr.TB_TMG_RENEWCARDSIGN set C_RENEWREMARK= @Param0 , C_OPERATETIME= @Param1 , C_OPERATOR= @Param2 , C_APPROVEFLOWID= @Param3 , C_APPLYSTATUS= @Param4
                where C_OID_RENEWCARDSIGN= @Param5 ";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { strc_renewremark, timeNow, "0", strc_approveflowid, "3", strc_oid_renewcardsign });
            }
            #endregion

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion

        #region 验证登入
        /// <summary>
        /// 验证登入
        /// </summary>
        private void CheckDologin(DataTable pdt)
        {

            string strName = pdt.Rows[0]["name"].ToString();
            string strpassword = pdt.Rows[0]["password"].ToString();
            string strCheckDologin = @"  
                                    SELECT  
                                            t2.C_PASSWORD ,
                                            t1.C_OID ,
                                            t1.C_EMPLOYEEID ,
                                            t1.C_CODE ,
                                            t1.C_IDCARD ,
                                            t1.C_NAME ,
                                            t2.C_OID_USER
                                    FROM    ehr.TB_INF_EMPLOYEE t1
                                            LEFT JOIN ehr.TB_SYS_USER t2 ON t1.C_OID = t2.C_EMPLOYEEID 
                                    WHERE   t2.C_PASSWORD = '" + strpassword + "' AND  t2.c_name = '" + strName + "'";
            ds_Return = m_conn.GetDataSet(strCheckDologin, new string[] { });
        }
        #endregion

        #region 加班

        #region 加班申请查询
        /// <summary>
        /// 加班申请查询
        /// </summary>
        private void GetOvertimeSearch(DataTable pdt)
        {

            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            string strYear;
            string strMonth;
            if (pdt.Columns.Contains("year") || pdt.Columns.Contains("month"))
            {
                strYear = pdt.Rows[0]["year"].ToString();
                strMonth = pdt.Rows[0]["month"].ToString();
            }
            else
            {
                strYear = DateTime.Now.Year.ToString();
                strMonth = DateTime.Now.Month.ToString();
            }

            string strEHRSQL = @"SELECT TOP 100
                                        T1.C_OID_OVERTTIMEEMPLOYEE ,
                                        T1.C_BEGINDATE ,
                                        T1.C_ENDDATE ,
                                        T1.C_VALUE ,
                                        T1.C_REMARK ,
                                        T1.C_REASON ,
                                        CASE WHEN T1.C_REASON = '1' THEN '根据生产计划加班'
                                             WHEN T1.C_REASON = '2' THEN '临时加班'
                                             WHEN T1.C_REASON = '3' THEN '其它原因'
                                        END C_REASON_CN ,
                                        T1.C_CONFIRMSTATUS ,
                                        T1.C_ATTITEMID ,
                                        CASE WHEN T1.C_ATTITEMID = '3847483' THEN '工作日加班'
                                             WHEN T1.C_ATTITEMID = '3847485' THEN '休息日加班'
                                             WHEN T1.C_ATTITEMID = '107872343' THEN '公休日加班'
                                        END C_ATTITEMNAME ,
                                        T1.C_APPLYID ,
                                        T1.C_EMPOID ,
                                        T1.C_RECORDID ,
                                        T1.C_OPERATOR ,
                                        T1.C_OPERATETIME ,
                                        T1.C_APPLYDATE ,
                                        CASE WHEN t2.C_APPLYSTATUS = '0' THEN '等待审批'
                                             WHEN t2.C_APPLYSTATUS = '2' THEN '审批通过'
                                             WHEN t2.C_APPLYSTATUS = '3' THEN '审批拒绝'
                                        END C_APPLYSTATUS
                                FROM    ehr.TB_TMG_OVERTTIMEEMPLOYEE T1 ,
                                        ehr.TB_TMG_OVERTTIMEAPPLY T2
                                WHERE   T1.C_APPLYID = T2.C_OID_OVERTIMEAPPLY
                                        AND T2.C_APPLYEMPID = '" + strC_oid + @"'
                                        AND T1.C_EMPOID =  '" + strC_oid + @"'
                                        AND year(C_APPLYDATE) = '" + strYear + "' AND MONTH(C_APPLYDATE) = '" + strMonth + @"'
                                ORDER BY T1.C_OPERATETIME DESC ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion

        #region 加班申请插入
        /// <summary>
        /// 加班申请插入
        /// </summary>
        private void ApplyOvertime(DataTable pdt)
        {
            DateTime timeNow = DateTime.Now;
            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            string strSP1 = pdt.Rows[0]["sp1"].ToString();//一级审批员工号
            string strC_remark = pdt.Rows[0]["c_remark"].ToString();//备注
            string strC_BeginDate = pdt.Rows[0]["begindate"].ToString();//开始时间
            string strC_EndDate = pdt.Rows[0]["enddate"].ToString();//结束时间
            string strC_value = pdt.Rows[0]["c_value"].ToString();//申请天数
            string strC_reason = pdt.Rows[0]["c_reason"].ToString();//申请原因
            string strC_attitemid = pdt.Rows[0]["c_attitemid"].ToString();//加班类型

            string strSP2 = pdt.Rows[0]["sp2"].ToString();//二级审批员工号


            string strc_oid_code;//申请人操作员编号
            strc_oid_code = m_conn.GetDataTableFirstValue(@"SELECT*FROM ehr.TB_SYS_USER WHERE C_EMPLOYEEID='" + strC_oid + "'").ToString();

            m_conn.BeginTransaction();


            #region 取值最大号,(按照我们的规则,不用EHR自己的规则)已经注销
            //            string strMaxID = m_conn.GetDataTableFirstValue(@"SELECT  ISNULL(MAX(maxcount), '1') maxcount
            //                                                                    FROM    ( SELECT    MAX(C_OID_APPROVEFLOW) maxcount
            //                                                                                FROM      ehr.TB_TMG_APPROVEFLOW
            //                                                                                WHERE     C_OID_APPROVEFLOW < 3674547
            //                                                                                UNION
            //                                                                                SELECT    MAX(C_OID_RENEWCARDSIGN) maxcount
            //                                                                                FROM      ehr.TB_TMG_RENEWCARDSIGN
            //                                                                                WHERE     C_OID_RENEWCARDSIGN < 3674547
            //                                                                                UNION
            //                                                                                SELECT    MAX(C_OID_CARDSIGNEMP) maxcount
            //                                                                                FROM      ehr.TB_TMG_CARDSIGNEMP
            //                                                                                WHERE     C_OID_CARDSIGNEMP < 3674547
            //                                                                                UNION
            //                                                                                SELECT    MAX(C_OID_OVERTIMEAPPLY) maxcount
            //                                                                                FROM      ehr.TB_TMG_OVERTTIMEAPPLY
            //                                                                                WHERE     C_OID_OVERTIMEAPPLY < 3674547
            //                                                                                UNION
            //                                                                                SELECT    MAX(C_OID_OVERTTIMEEMPLOYEE) maxcount
            //                                                                                FROM      ehr.TB_TMG_OVERTTIMEEMPLOYEE
            //                                                                                WHERE     C_OID_OVERTTIMEEMPLOYEE < 3674547
            //                                                                            ) t1
            //                                                            ", new string[] { }).ToString();
            //            int nMaxID = Convert.ToInt32(strMaxID);//最大号
            //            int nMaxID1 = nMaxID + 1;
            //            int nMaxID2 = nMaxID1 + 1;
            //            int nMaxID3 = nMaxID2 + 1;

            #endregion

            GetMaxID();//获取最大值和后面的ID
            if (strSP1 != "" && strSP2 != "")//如果有2个审批人的时候
            {
                #region 如果二个审批人的时候

                //1
                string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strSP1, "0", "0", strc_oid_code, timeNow, nMaxID1 });

                //1.1
                string strSQL11 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strSP2, "0", nMaxID1, strc_oid_code, timeNow, nMaxID2 });

                //2
                string strSQL2 = @"
                        insert into ehr.TB_TMG_OVERTTIMEAPPLY (C_REMARK, C_APPLYSTATUS, C_APPLYEMPID, C_APPROVEFLOWID, C_OPERATOR, C_OPERATETIME, C_OID_OVERTIMEAPPLY) 
                        ( SELECT 
                        @Param0 C_REMARK,  @Param1 C_APPLYSTATUS,  @Param2 C_APPLYEMPID,  @Param3 C_APPROVEFLOWID,  @Param4 C_OPERATOR,  @Param5 C_OPERATETIME,  @Param6 C_OID_OVERTIMEAPPLY)";
                m_conn.ExcuteQuerryByTran(strSQL2, new object[] { strC_remark, '0', strC_oid, nMaxID1, strc_oid_code, timeNow, nMaxID3 });

                //22
                string strSQL22 = @"
                       update TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3, C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , 
                                                C_OPERATOR= @Param6, C_OPERATETIME= @Param7  where C_OID_APPROVEFLOW=  @Param8";
                m_conn.ExcuteQuerryByTran(strSQL22, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strSP1, nMaxID2, "0", strc_oid_code, timeNow, nMaxID1 });


                //3
                string strSQL3 = @"
                        insert into ehr.TB_TMG_OVERTTIMEEMPLOYEE (C_BEGINDATE, C_ENDDATE, C_VALUE, C_REMARK, C_REASON, C_CONFIRMSTATUS, C_ATTITEMID, C_APPLYID, 
                                                              C_EMPOID, C_RECORDID,C_OPERATOR, C_OPERATETIME, C_APPLYDATE, C_OID_OVERTTIMEEMPLOYEE) 
                       ( SELECT 
                  @Param0 C_BEGINDATE,  @Param1 C_ENDDATE,  @Param2 C_VALUE,  @Param3 C_REMARK,  @Param4 C_REASON,  @Param5 C_CONFIRMSTATUS,  @Param6 C_ATTITEMID,
                  @Param7 C_APPLYID,  @Param8 C_EMPOID,  @Param9 C_RECORDID,  @Param10 C_OPERATOR,  @Param11 C_OPERATETIME,  @Param12 C_APPLYDATE,  @Param13 C_OID_OVERTTIMEEMPLOYEE)";
                m_conn.ExcuteQuerryByTran(strSQL3, new object[] { strC_BeginDate, strC_EndDate, strC_value, strC_remark, strC_reason, '0', strC_attitemid, nMaxID3,
                                                             strC_oid,'0',strc_oid_code,timeNow,timeNow,nMaxID4 });

                #endregion
            }
            else
            {
                #region 如果一个审批人的时候

                string change = "";//定义审批人
                if (strSP1 == "")
                {
                    change = strSP2;
                }
                else
                {
                    change = strSP1;
                }

                //1
                string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, change, "0", "0", strc_oid_code, timeNow, nMaxID1 });

                //2
                string strSQL2 = @"
                        insert into ehr.TB_TMG_OVERTTIMEAPPLY (C_REMARK, C_APPLYSTATUS, C_APPLYEMPID, C_APPROVEFLOWID, C_OPERATOR, C_OPERATETIME, C_OID_OVERTIMEAPPLY) 
                        ( SELECT 
                        @Param0 C_REMARK,  @Param1 C_APPLYSTATUS,  @Param2 C_APPLYEMPID,  @Param3 C_APPROVEFLOWID,  @Param4 C_OPERATOR,  @Param5 C_OPERATETIME,  @Param6 C_OID_OVERTIMEAPPLY)";
                m_conn.ExcuteQuerryByTran(strSQL2, new object[] { strC_remark, '0', strC_oid, nMaxID1, strc_oid_code, timeNow, nMaxID2 });

                //3
                string strSQL3 = @"
                        insert into ehr.TB_TMG_OVERTTIMEEMPLOYEE (C_BEGINDATE, C_ENDDATE, C_VALUE, C_REMARK, C_REASON, C_CONFIRMSTATUS, C_ATTITEMID, C_APPLYID, 
                                                              C_EMPOID, C_RECORDID,C_OPERATOR, C_OPERATETIME, C_APPLYDATE, C_OID_OVERTTIMEEMPLOYEE) 
                       ( SELECT 
                  @Param0 C_BEGINDATE,  @Param1 C_ENDDATE,  @Param2 C_VALUE,  @Param3 C_REMARK,  @Param4 C_REASON,  @Param5 C_CONFIRMSTATUS,  @Param6 C_ATTITEMID,
                  @Param7 C_APPLYID,  @Param8 C_EMPOID,  @Param9 C_RECORDID,  @Param10 C_OPERATOR,  @Param11 C_OPERATETIME,  @Param12 C_APPLYDATE,  @Param13 C_OID_OVERTTIMEEMPLOYEE)";
                m_conn.ExcuteQuerryByTran(strSQL3, new object[] { strC_BeginDate, strC_EndDate, strC_value, strC_remark, strC_reason, '0', strC_attitemid, nMaxID2,
                                                             strC_oid,'0',strc_oid_code,timeNow,timeNow,nMaxID3 });

                #endregion
            }
            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region 获取审批信息
        /// <summary>
        /// 获取审批信息
        /// </summary>
        private void GetApplyOvertime(DataTable pdt)
        {

            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            //strC_oid = "81505586";
            string strEHRSQL = @"SELECT TOP 100
                                        T1.C_OID_OVERTTIMEEMPLOYEE ,
                                        T2.C_OID_OVERTIMEAPPLY ,
                                        T3.C_OID ,
                                        T1.C_BEGINDATE ,
                                        T1.C_ENDDATE ,
                                        T1.C_VALUE ,
                                        T1.C_REMARK ,
                                        T1.C_REASON ,
                                        T1.C_CONFIRMSTATUS ,
                                        T1.C_ATTITEMID ,
                                        T1.C_APPLYID ,
                                        T1.C_EMPOID ,
                                        T1.C_RECORDID ,
                                        T1.C_OPERATOR ,
                                        T1.C_OPERATETIME ,
                                        T1.C_APPLYDATE ,
                                        T2.C_REMARK ,
                                        T2.C_APPLYSTATUS ,
                                        T2.C_APPLYEMPID ,
                                        T2.C_APPROVEFLOWID ,
                                        T2.C_OPERATOR ,
                                        T2.C_OPERATETIME ,
                                        T3.C_HIREDATE ,
                                        T3.C_UNITCODE ,
                                        T3.C_UNITNAME ,
                                        T3.C_JOBNAME ,
                                        T3.C_ORGID ,
                                        T3.C_NAME ,
                                        T3.C_UNITID ,
                                        T3.C_EMPLOYEETYPE ,
                                        T3.C_JOBCODE ,
                                        T3.C_JOBID ,
                                        T3.C_ORGNAME ,
                                        T3.C_CODE ,
                                        T3.C_ORGCODE ,
                                        T3.C_GENDER ,
                                        T3.C_EMPLOYEESTATUS ,
                                        T4.c_name ,
                                        T4.c_code ,
                                        T4.c_type ,
                                        T4.c_order ,
                                        T4.c_isforwork ,
                                        T4.c_precision ,
                                        T4.c_calunit ,
                                        T4.c_status ,
                                        T4.c_operator ,
                                        T4.c_operatetime
                                FROM    ehr.TB_TMG_OVERTTIMEEMPLOYEE T1 ,
                                        ehr.TB_TMG_ATTITEM T4 ,
                                        ehr.TB_INF_EMPLOYEE T3 ,
                                        ehr.TB_TMG_OVERTTIMEAPPLY T2 ,
                                        ehr.TB_TMG_APPROVEFLOW T5
                                WHERE   T1.C_APPLYID = T2.C_OID_OVERTIMEAPPLY
                                        AND T1.C_EMPOID = T3.C_OID
                                        AND T1.C_ATTITEMID = T4.c_oid_attitem
                                        AND T5.C_OID_APPROVEFLOW = T2.C_APPROVEFLOWID
                                        AND T5.C_APPROVEEMPID = '" + strC_oid + @"'
                                        AND ( T2.C_APPLYSTATUS = '1'
                                              OR T2.C_APPLYSTATUS = '0'
                                            )
                                ORDER BY T1.C_OPERATETIME DESC ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion

        #region 加班审批
        /// <summary>
        /// 加班审批
        /// </summary>
        private void ApproveOvertime(DataTable pdt)
        {

            DateTime timeNow = DateTime.Now;

            string strc_oid_overtimeapply = pdt.Rows[0]["c_oid_overtimeapply"].ToString();//申请流程号
            string strapplec_oid = pdt.Rows[0]["applec_oid"].ToString();//申请员工号
            string strc_renewremark = pdt.Rows[0]["c_renewremark"].ToString();//备注
            string strc_approveflowid = pdt.Rows[0]["c_approveflowid"].ToString();//流程号
            string strc_oid = pdt.Rows[0]["c_oid"].ToString();//员工号
            string stroid_user = pdt.Rows[0]["m_oid_user"].ToString();//员工编号(操作员)审批
            string strc_remark = pdt.Rows[0]["c_remark"].ToString();//备注
            string strOvertimetype = pdt.Rows[0]["overtimetype"].ToString();//审批类型,1同意,2 拒绝

            m_conn.BeginTransaction();

            #region
            if (strOvertimetype == "1")
            {
                string strSQL1 = @"
                update  ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7 
                where C_OID_APPROVEFLOW = @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { timeNow, strc_remark, "0", strc_oid, "0", "0", stroid_user, timeNow, strc_approveflowid });
                string strSQL11 = @"
                update  ehr.TB_TMG_OVERTTIMEAPPLY set C_REMARK= @Param0 , C_APPLYSTATUS= @Param1 , C_APPLYEMPID= @Param2 , C_APPROVEFLOWID= @Param3 , C_OPERATOR= @Param4,C_OPERATETIME= @Param5
                where C_OID_OVERTIMEAPPLY= @Param6 ";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { strc_renewremark, "2", strapplec_oid, strc_approveflowid, stroid_user, timeNow, strc_oid_overtimeapply });
            }
            else
            {
                string strSQL2 = @"
                update  ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7 
                where C_OID_APPROVEFLOW = @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL2, new object[] { timeNow, strc_remark, "0", strc_oid, "0", "0", stroid_user, timeNow, strc_approveflowid });
                string strSQL11 = @"
                update  ehr.TB_TMG_OVERTTIMEAPPLY set C_REMARK= @Param0 , C_APPLYSTATUS= @Param1 , C_APPLYEMPID= @Param2 , C_APPROVEFLOWID= @Param3 , C_OPERATOR= @Param4,C_OPERATETIME= @Param5
                where C_OID_OVERTIMEAPPLY= @Param6 ";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { strc_renewremark, "3", strapplec_oid, strc_approveflowid, stroid_user, timeNow, strc_oid_overtimeapply });
            }
            #endregion

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion

        #region 休假

        #region 休假申请查询
        /// <summary>
        /// 休假申请查询
        /// </summary>
        private void GetVacationSearch(DataTable pdt)
        {

            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            string strYear = pdt.Rows[0]["year"].ToString();
            string strMonth = pdt.Rows[0]["month"].ToString();

            string strEHRSQL = @"SELECT TOP 100
                                t2.c_approveflow ,
                                t3.c_vocationapplyOid ,
                                t3.c_oid_vocationApplyemp ,
                                t3.c_employeeOid ,
                                t3.c_year ,
                                t3.c_beginTime ,
                                t3.c_endTime ,
                                t3.c_days ,
                                t3.c_reason ,
                                t3.c_principal ,
                                t3.c_linkman ,
                                t3.c_remark ,
                                t3.c_operator ,
                                t1.c_oid_attitem ,
                                t1.c_name ,
                               CASE WHEN t2.c_applystatus = '0' THEN '待审批'
									WHEN t2.c_applystatus='2' THEN '通过'
									WHEN t2.c_applystatus='3'THEN '未通过' END c_applystatus,
                                t3.C_CONFIRMSTATUS ,
                                t3.C_CONFIRMSTATUS ,
                                t3.C_RECORDOID ,
                                t3.c_status ,
                                t3.c_operatetime ,
                                t3.C_APPLYDATE ,
                                t1.c_code ,
                                t1.c_type ,
                                t1.c_isforwork ,
                                t1.c_precision ,
                                t1.c_calunit ,
                                t1.c_operator
                        FROM    ehr.tb_tmg_vocationApplyemp t3
                                INNER JOIN ehr.TB_TMG_ATTITEM t1 ON t3.c_attItemOid = t1.c_oid_attitem
                                INNER JOIN ehr.tb_tmg_vocationApply t2 ON t3.c_vocationapplyOid = t2.c_oid_vocationapply
                        WHERE   t3.c_status = '1'
                                AND t3.c_employeeOid = '" + strC_oid + @"'
                                AND t3.C_YEAR = '" + strYear + @"' AND MONTH(t3.c_beginTime)  = '" + strMonth + @"' ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion

        #region 验证休假申请该时间段是否已经存在
        /// <summary>
        /// 验证休假申请该时间段是否已经存在
        /// </summary>
        private void CheckVacation(DataTable pdt)
        {

            string strC_beginTime = pdt.Rows[0]["c_beginTime"].ToString();
            string strC_endTime = pdt.Rows[0]["c_endTime"].ToString();
            string strC_oid = pdt.Rows[0]["c_oid"].ToString();


            string strCheckDoVacation = @"  
                                    DECLARE @NumberCount int
                                    DECLARE @NumberCount1 int
                                    DECLARE @NumberCount2 int

                                    SELECT  @NumberCount1=COUNT(*) 
                                    FROM    ehr.tb_tmg_vocationApplyemp t0 ,
                                            ehr.tb_tmg_vocationApply t1
                                    WHERE   t0.c_vocationapplyOid = t1.c_oid_vocationapply
                                            AND t0.c_employeeOid = '" + strC_oid + @"'
                                            AND t1.c_applystatus <> '3'
                                            AND t0.c_status = '1'
                                            AND t0.c_endTime >= '" + strC_beginTime + @"'
                                            AND t0.c_beginTime <= '" + strC_endTime + @"'

                                    SELECT  @NumberCount2=COUNT(*) 
                                    FROM    ehr.tb_tmg_vocationRecord t0
                                    WHERE   t0.c_employeeOid  = '" + strC_oid + @"'
                                            AND t0.c_status = '1'
                                             AND t0.c_endTime >= '" + strC_beginTime + @"'
                                            AND t0.c_beginTime <= '" + strC_endTime + @"'
                                    SET @NumberCount=@NumberCount1+@NumberCount2
                                    SELECT @NumberCount count";

            ds_Return = m_conn.GetDataSet(strCheckDoVacation, new string[] { });
        }
        #endregion

        #region 休假申请插入
        /// <summary>
        /// 休假申请插入
        /// </summary>
        private void ApplyVacation(DataTable pdt)
        {
            DateTime timeNow = DateTime.Now;
            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            string strSP1 = pdt.Rows[0]["sp1"].ToString();//一级审批员工号oid
            string strSP2 = pdt.Rows[0]["sp2"].ToString();//一级审批员工号oid
            string strC_attItemOid = pdt.Rows[0]["c_attitemoid"].ToString();//考勤项目(休假类型)
            string strC_year = pdt.Rows[0]["c_year"].ToString();//年份
            string strC_BeginDate = pdt.Rows[0]["begindate"].ToString();//开始时间
            string strC_EndDate = pdt.Rows[0]["enddate"].ToString();//结束时间
            string strC_days = pdt.Rows[0]["c_value"].ToString();//天数或者小时
            string strC_reason = pdt.Rows[0]["c_reason"].ToString();//申请原因
            string strC_principal = pdt.Rows[0]["c_principal"].ToString();//临时负责人
            string strC_linkman = pdt.Rows[0]["c_linkman"].ToString();//紧急联系人及电话
            string strC_remark = pdt.Rows[0]["c_remark"].ToString();//备注


            string strc_oid_code;//申请人操作员编号
            strc_oid_code = m_conn.GetDataTableFirstValue(@"SELECT*FROM ehr.TB_SYS_USER WHERE C_EMPLOYEEID='" + strC_oid + "'").ToString();

            m_conn.BeginTransaction();

            #region 取值最大号,(按照我们的规则,不用EHR自己的规则)已经注销
            //            string strMaxID = m_conn.GetDataTableFirstValue(@"SELECT  ISNULL(MAX(maxcount), '1') maxcount
            //                                                                FROM    ( SELECT    MAX(C_OID_APPROVEFLOW) maxcount
            //                                                                            FROM      ehr.TB_TMG_APPROVEFLOW
            //                                                                            WHERE     C_OID_APPROVEFLOW < 3674547
            //                                                                            UNION
            //                                                                            SELECT    MAX(C_OID_RENEWCARDSIGN) maxcount
            //                                                                            FROM      ehr.TB_TMG_RENEWCARDSIGN
            //                                                                            WHERE     C_OID_RENEWCARDSIGN < 3674547
            //                                                                            UNION
            //                                                                            SELECT    MAX(C_OID_CARDSIGNEMP) maxcount
            //                                                                            FROM      ehr.TB_TMG_CARDSIGNEMP
            //                                                                            WHERE     C_OID_CARDSIGNEMP < 3674547
            //                                                                            UNION
            //                                                                            SELECT    MAX(C_OID_OVERTIMEAPPLY) maxcount
            //                                                                            FROM      ehr.TB_TMG_OVERTTIMEAPPLY
            //                                                                            WHERE     C_OID_OVERTIMEAPPLY < 3674547
            //                                                                            UNION
            //                                                                            SELECT    MAX(C_OID_OVERTTIMEEMPLOYEE) maxcount
            //                                                                            FROM      ehr.TB_TMG_OVERTTIMEEMPLOYEE
            //                                                                            WHERE     C_OID_OVERTTIMEEMPLOYEE < 3674547
            //                                                                            UNION
            //                                                                            SELECT    MAX(c_oid_vocationApply) maxcount
            //                                                                            FROM      ehr.tb_tmg_vocationApply
            //                                                                            WHERE     c_oid_vocationApply < 3674547
            //                                                                            UNION
            //                                                                            SELECT    MAX(c_oid_vocationApply) maxcount
            //                                                                            FROM      ehr.tb_tmg_vocationApply
            //                                                                            WHERE     c_oid_vocationApply < 3674547
            //                                                                            UNION
            //                                                                            SELECT    MAX(C_OID_VOCATIONAPPLYEMP) maxcount
            //                                                                            FROM      ehr.tb_tmg_vocationApplyemp
            //                                                                            WHERE     C_OID_VOCATIONAPPLYEMP < 3674547
            //                                                                        ) t1
            //                                                            ", new string[] { }).ToString();
            //            int nMaxID = Convert.ToInt32(strMaxID);//最大号
            //            int nMaxID1 = nMaxID + 1;
            //            int nMaxID2 = nMaxID1 + 1;
            //            int nMaxID3 = nMaxID2 + 1;

            #endregion

            GetMaxID();//获取最大值和后面的ID


            if (strSP1 != "" && strSP2 != "")//如果有2个审批人的时候
            {
                #region 如果二个审批人的时候

                //1
                string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strSP1, "0", "0", strc_oid_code, timeNow, nMaxID1 });

                //11
                string strSQL11 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strSP2, "0", nMaxID1, strc_oid_code, timeNow, nMaxID2 });

                //2
                string strSQL2 = @"
                        insert into ehr.tb_tmg_vocationApply (c_applystatus, c_approveflow, c_status, c_operator, c_operatetime, c_oid_vocationapply) 
                        ( SELECT 
                        @Param0 c_applystatus,  @Param1 c_approveflow,  @Param2 c_status,  @Param3 c_operator,  @Param4 c_operatetime,  @Param5 c_oid_vocationapply)";
                m_conn.ExcuteQuerryByTran(strSQL2, new object[] { "0", nMaxID1, "1", strc_oid_code, timeNow, nMaxID3 });

                //22
                string strSQL22 = @"
                       update TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 ,
                               C_OPERATETIME= @Param7  where C_OID_APPROVEFLOW= @Param8
                        ";
                m_conn.ExcuteQuerryByTran(strSQL22, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strSP1, nMaxID2, "0", strc_oid_code, timeNow, nMaxID1 });

                //3
                string strSQL3 = @"
                        insert into ehr.tb_tmg_vocationApplyemp (c_employeeOid, c_attItemOid, c_year, c_beginTime, c_endTime, c_days, 
                                                                c_reason, c_principal, c_linkman, c_remark, c_vocationapplyOid, C_CONFIRMSTATUS,
                                                                C_RECORDOID, c_status, c_operator, c_operatetime, C_APPLYDATE, c_oid_vocationApplyemp) 
                       ( SELECT 
                        @Param0 c_employeeOid,  @Param1 c_attItemOid,  @Param2 c_year,  @Param3 c_beginTime,  @Param4 c_endTime,  @Param5 c_days, 
                        @Param6 c_reason,@Param7 c_principal,  @Param8 c_linkman,  @Param9 c_remark,  @Param10 c_vocationapplyOid,  @Param11 C_CONFIRMSTATUS,  
                        @Param12 C_RECORDOID,  @Param13 c_status,  @Param14 c_operator,  @Param15 c_operatetime,  @Param16 C_APPLYDATE,  @Param17 c_oid_vocationApplyemp)";
                m_conn.ExcuteQuerryByTran(strSQL3, new object[] { strC_oid, strC_attItemOid, strC_year, strC_BeginDate, strC_EndDate, strC_days,
                                                              strC_reason,strC_principal,strC_linkman,strC_remark ,nMaxID3,"0",
                                                              "0","1",strc_oid_code,timeNow,timeNow,nMaxID4});

                #endregion
            }
            else
            {
                #region 如果一个审批人的时候

                string change = "";//定义审批人
                if (strSP1 == "")
                {
                    change = strSP2;
                }
                else
                {
                    change = strSP1;
                }

                //1
                string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, change, "0", "0", strc_oid_code, timeNow, nMaxID1 });

                //2
                string strSQL2 = @"
                        insert into ehr.tb_tmg_vocationApply (c_applystatus, c_approveflow, c_status, c_operator, c_operatetime, c_oid_vocationapply) 
                        ( SELECT 
                        @Param0 c_applystatus,  @Param1 c_approveflow,  @Param2 c_status,  @Param3 c_operator,  @Param4 c_operatetime,  @Param5 c_oid_vocationapply)";
                m_conn.ExcuteQuerryByTran(strSQL2, new object[] { "0", nMaxID1, "1", strc_oid_code, timeNow, nMaxID2 });

                //3
                string strSQL3 = @"
                        insert into ehr.tb_tmg_vocationApplyemp (c_employeeOid, c_attItemOid, c_year, c_beginTime, c_endTime, c_days, 
                                                                c_reason, c_principal, c_linkman, c_remark, c_vocationapplyOid, C_CONFIRMSTATUS,
                                                                C_RECORDOID, c_status, c_operator, c_operatetime, C_APPLYDATE, c_oid_vocationApplyemp) 
                       ( SELECT 
                        @Param0 c_employeeOid,  @Param1 c_attItemOid,  @Param2 c_year,  @Param3 c_beginTime,  @Param4 c_endTime,  @Param5 c_days, 
                        @Param6 c_reason,@Param7 c_principal,  @Param8 c_linkman,  @Param9 c_remark,  @Param10 c_vocationapplyOid,  @Param11 C_CONFIRMSTATUS,  
                        @Param12 C_RECORDOID,  @Param13 c_status,  @Param14 c_operator,  @Param15 c_operatetime,  @Param16 C_APPLYDATE,  @Param17 c_oid_vocationApplyemp)";
                m_conn.ExcuteQuerryByTran(strSQL3, new object[] { strC_oid, strC_attItemOid, strC_year, strC_BeginDate, strC_EndDate, strC_days,
                                                              strC_reason,strC_principal,strC_linkman,strC_remark ,nMaxID2,"0",
                                                              "0","1",strc_oid_code,timeNow,timeNow,nMaxID3});

                #endregion
            }

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);

        }
        #endregion

        #region 获取审批休假信息
        /// <summary>
        /// 获取审批休假信息
        /// </summary>
        private void GetApproveVacationInfo(DataTable pdt)
        {

            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            //strC_oid = "81505586";
            string strEHRSQL = @"SELECT TOP 100
                                        t2.c_approveflow ,
                                        t1.c_oid_vocationApplyemp ,
                                        t2.c_oid_vocationapply ,
                                        t1.c_vocationapplyOid ,
                                        t1.c_employeeOid ,
                                        t1.c_operator ,
                                        t1.c_attItemOid ,
                                        t5.c_name c_attItemName ,
                                        t1.c_year ,
                                        t1.c_beginTime ,
                                        t1.c_endTime ,
                                        t1.c_days ,
                                        t1.c_reason ,
                                        t1.c_principal ,
                                        t1.c_linkman ,
                                        t1.c_remark ,
                                        t1.C_CONFIRMSTATUS ,
                                        t1.C_RECORDOID ,
                                        t1.c_status ,
                                        t1.c_operatetime ,
                                        t1.C_APPLYDATE ,
                                        t2.c_applystatus ,
                                        t2.c_status ,
                                        t2.c_operatetime ,
                                        t3.C_HIREDATE ,
                                        t3.C_UNITCODE ,
                                        t3.C_UNITNAME ,
                                        t3.C_JOBNAME ,
                                        t3.C_ORGID ,
                                        t3.C_NAME ,
                                        t3.C_UNITID ,
                                        t3.C_EMPLOYEETYPE ,
                                        t3.C_JOBCODE ,
                                        t3.C_JOBID ,
                                        t3.C_ORGNAME ,
                                        t3.C_CODE ,
                                        t3.C_ORGCODE ,
                                        t3.C_GENDER ,
                                        t3.C_EMPLOYEESTATUS
                                FROM    ehr.tb_tmg_vocationApplyemp t1 ,
                                        ehr.TB_TMG_ATTITEM t5 ,
                                        ehr.TB_INF_EMPLOYEE t3 ,
                                        ehr.tb_tmg_vocationApply t2 ,
                                        ehr.TB_TMG_APPROVEFLOW t4
                                WHERE   t1.c_attItemOid = t5.c_oid_attitem
                                        AND t2.c_approveflow = t4.C_OID_APPROVEFLOW
                                        AND t1.c_vocationapplyOid = t2.c_oid_vocationapply
                                        AND t1.c_employeeOid = t3.C_OID
                                        AND t4.C_APPROVEEMPID = '" + strC_oid + @"'
                                        AND ( t2.c_applystatus IN ( 1, 0 ) )
                                        AND t1.c_status = '1'
                                ORDER BY t1.c_operatetime DESC";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion

        #region 审批休假信息
        /// <summary>
        /// 审批休假信息
        /// </summary>
        private void ApproveVacationInfo(DataTable pdt)
        {

            DateTime timeNow = DateTime.Now;


            string strC_remark = pdt.Rows[0]["c_remark"].ToString();//审批备注
            string strc_oid = pdt.Rows[0]["c_oid"].ToString();//员工号
            string stroid_user = pdt.Rows[0]["m_oid_user"].ToString();//员工编号(操作员)审批
            string strc_approveflowid = pdt.Rows[0]["c_approveflowid"].ToString();//流程号
            string strC_oid_vocationapply = pdt.Rows[0]["c_oid_vocationapply"].ToString();//休假申请流程号
            string strVacation = pdt.Rows[0]["vacationtype"].ToString();//审批类型,1同意,2 拒绝

            m_conn.BeginTransaction();

            #region

            if (strVacation == "1")
            {
                string strSQL1 = @"
                update  ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7 
                where C_OID_APPROVEFLOW = @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { timeNow, strC_remark, "0", strc_oid, "0", "0", stroid_user, timeNow, strc_approveflowid });

                string strSQL11 = @"
                update  ehr.tb_tmg_vocationApply set c_applystatus= @Param0 , c_approveflow= @Param1 , c_status= @Param2 , c_operator= @Param3 , c_operatetime= @Param4
                where c_oid_vocationapply= @Param5 ";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { "2", strc_approveflowid, '1', stroid_user, timeNow, strC_oid_vocationapply });
            }
            else
            {
                string strSQL1 = @"
                update  ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7 
                where C_OID_APPROVEFLOW = @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { timeNow, strC_remark, "0", strc_oid, "0", "0", stroid_user, timeNow, strc_approveflowid });

                string strSQL11 = @"
                update  ehr.tb_tmg_vocationApply set c_applystatus= @Param0 , c_approveflow= @Param1 , c_status= @Param2 , c_operator= @Param3 , c_operatetime= @Param4
                where c_oid_vocationapply= @Param5 ";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { "3", strc_approveflowid, '1', stroid_user, timeNow, strC_oid_vocationapply });
            }
            #endregion

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion

        #region 公出

        #region 公出申请查询
        /// <summary>
        /// 公出申请查询
        /// </summary>
        private void GetBusinessOutSearch(DataTable pdt)
        {

            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            string strYear = pdt.Rows[0]["year"].ToString();
            string strMonth = pdt.Rows[0]["month"].ToString();

            string strEHRSQL = @"SELECT TOP 100
                                    t1.C_APPROVEFLOWID ,
                                    t1.C_OID_OUTAPPLY ,
                                    t0.C_OID_OUTEMPLOYEE ,
                                    t2.C_OID ,
                                    t0.C_OPERATOR ,
                                    t0.C_ATTITEMID ,
                                    t3.c_name ,
                                    t0.C_BEGINDATE ,
                                    t0.C_ENDDATE ,
                                    t0.C_VALUE ,
                                    t0.C_REMARK ,
                                    t0.C_DESTINATION ,
                                    t0.C_REASON ,
                                    t0.C_DESTNAME ,
                                    t0.C_DESTADDRESS ,
                                    t0.C_CONTACTPERSON ,
                                    t0.C_CONTACTPHONE ,
                                    t0.C_VEHICLE ,
                                    t0.C_OPERATETIME ,
                                    t0.C_CONFIRMSTATUS ,
                                    t0.C_RECORDID ,
                                     t1.C_REMARK ,
									CASE WHEN t1.C_APPLYSTATUS='0' THEN '待审核'
										WHEN t1.C_APPLYSTATUS='2' THEN '通过'
										WHEN t1.C_APPLYSTATUS='3' THEN '驳回' END C_APPLYSTATUS,
                                    t1.C_OPERATETIME ,
                                    t2.C_HIREDATE ,
                                    t2.C_UNITCODE ,
                                    t2.C_UNITNAME ,
                                    t2.C_JOBNAME ,
                                    t2.C_ORGID ,
                                    t2.C_NAME ,
                                    t2.C_UNITID ,
                                    t2.C_EMPLOYEETYPE ,
                                    t2.C_JOBCODE ,
                                    t2.C_JOBID ,
                                    t2.C_ORGNAME ,
                                    t2.C_CODE ,
                                    t2.C_ORGCODE ,
                                    t2.C_GENDER ,
                                    t2.C_EMPLOYEESTATUS ,
                                    t3.c_code ,
                                    t3.c_type ,
                                    t3.c_isforwork ,
                                    t3.c_precision ,
                                    t3.c_calunit ,
                                    t3.c_status
                            FROM    ehr.TB_TMG_OUTEMPLOYEE t0 ,
                                    ehr.TB_TMG_ATTITEM t3 ,
                                    ehr.TB_INF_EMPLOYEE t2 ,
                                    ehr.TB_TMG_OUTAPPLY t1
                            WHERE   t0.C_APPLYID = t1.C_OID_OUTAPPLY
                                    AND t0.C_EMPOID = t2.C_OID
                                    AND t0.C_ATTITEMID = t3.c_oid_attitem
                                    AND t1.C_APPLYEMPID = '" + strC_oid + @"'
                                    AND t0.C_EMPOID  = '" + strC_oid + @"'
                                    AND YEAR(t0.C_BEGINDATE) = '" + strYear + @"'
                                    AND MONTH(t0.C_BEGINDATE) = '" + strMonth + "'";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion

        #region 验证公出申请该时间段是否已经存在
        /// <summary>
        /// 验证公出申请该时间段是否已经存在
        /// </summary>
        private void CheckBusinessOut(DataTable pdt)
        {
            string strC_beginTime = pdt.Rows[0]["c_beginTime"].ToString();
            string strC_endTime = pdt.Rows[0]["c_endTime"].ToString();
            string strC_oid = pdt.Rows[0]["c_oid"].ToString();


            string strCheckDoVacation = @"  
                                    SELECT  COUNT(*) count
                                            FROM    ehr.TB_TMG_OUTEMPLOYEE t0 ,
                                                    ehr.TB_TMG_OUTAPPLY t1
                                            WHERE   t0.C_APPLYID = t1.C_OID_OUTAPPLY
                                                    AND t0.C_EMPOID = '" + strC_oid + @"'
                                                    AND t1.C_APPLYSTATUS <> '3'
                                                    AND t0.C_ENDDATE >= '" + strC_beginTime + @"'
                                                    AND t0.C_BEGINDATE <= '" + strC_endTime + @"'";
            ds_Return = m_conn.GetDataSet(strCheckDoVacation, new string[] { });
        }
        #endregion

        #region 公出申请插入
        /// <summary>
        /// 公出申请插入
        /// </summary>
        private void ApplyBusinessOut(DataTable pdt)
        {
            DateTime timeNow = DateTime.Now;
            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            string strSP1 = pdt.Rows[0]["sp1"].ToString();//一级审批员工号oid
            string strSP2 = pdt.Rows[0]["sp2"].ToString();//一级审批员工号oid
            string strC_remark = pdt.Rows[0]["c_remark"].ToString();//备注
            string strC_BeginDate = pdt.Rows[0]["begindate"].ToString();//开始时间
            string strC_EndDate = pdt.Rows[0]["enddate"].ToString();//结束时间
            string strC_value = pdt.Rows[0]["c_value"].ToString();//申请天数
            string strC_destination = pdt.Rows[0]["c_destination"].ToString();//出差地点
            string strC_reason = pdt.Rows[0]["c_reason"].ToString();//出差事由
            string strC_destname = pdt.Rows[0]["c_destname"].ToString();//单位名称
            string strC_destaddress = pdt.Rows[0]["c_destaddress"].ToString();//单位地址
            string strC_contactperson = pdt.Rows[0]["c_contactperson"].ToString();//联系人
            string strC_contactphone = pdt.Rows[0]["c_contactphone"].ToString();//联系电话
            string strC_vehicle = pdt.Rows[0]["c_vehicle"].ToString();//交通工具
            string strC_attitemid = pdt.Rows[0]["c_attitemid"].ToString();//出差类型

            string strc_oid_code;//申请人操作员编号
            strc_oid_code = m_conn.GetDataTableFirstValue(@"SELECT*FROM ehr.TB_SYS_USER WHERE C_EMPLOYEEID='" + strC_oid + "'").ToString();

            m_conn.BeginTransaction();

            GetMaxID();//获取最大值和后面的ID


            if (strSP1 != "" && strSP2 != "")//如果有2个审批人的时候
            {
                #region 如果二个审批人的时候

                //1
                string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strSP1, "0", "0", strc_oid_code, timeNow, nMaxID1 });

                //11
                string strSQL11 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strSP1, "0", nMaxID1, strc_oid_code, timeNow, nMaxID2 });

                //2
                string strSQL2 = @"
                        insert into ehr.TB_TMG_OUTAPPLY (C_REMARK, C_APPLYSTATUS, C_APPLYEMPID, C_APPROVEFLOWID, C_OPERATOR, C_OPERATETIME,C_OID_OUTAPPLY) 
                        ( SELECT 
                        @Param0  C_REMARK,@Param1 c_applystatus,  @Param2 c_approveflow,  @Param3 c_status,  @Param4 c_operator,  @Param5 c_operatetime,  @Param6 c_oid_vocationapply)";
                m_conn.ExcuteQuerryByTran(strSQL2, new object[] { strC_remark, "0", strC_oid, nMaxID1, strc_oid_code, timeNow, nMaxID3 });

                //22
                string strSQL22 = @"
                       update TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7  
                        where C_OID_APPROVEFLOW= @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL22, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, strC_oid, nMaxID2, "0", strc_oid_code, timeNow, nMaxID1 });

                //3
                string strSQL3 = @"
                        insert into ehr.TB_TMG_OUTEMPLOYEE (C_BEGINDATE, C_ENDDATE, C_VALUE, C_REMARK, C_CONFIRMSTATUS, C_DESTINATION, C_REASON,
                                                            C_DESTNAME,C_DESTADDRESS ,C_CONTACTPERSON, C_CONTACTPHONE, C_VEHICLE, C_ATTITEMID,
                                                            C_APPLYID, C_EMPOID,C_RECORDID,C_OPERATOR, C_OPERATETIME, C_APPLYDATE, C_OID_OUTEMPLOYEE) 
                       ( SELECT  @Param0 C_BEGINDATE, @Param1 C_ENDDATE,@Param2 C_VALUE, @Param3 C_REMARK,@Param4 C_CONFIRMSTATUS,@Param5 C_DESTINATION,@Param6 C_REASON,
                                 @Param7 C_DESTNAME, @Param8 C_DESTADDRESS ,@Param9 C_CONTACTPERSON , @Param10 C_CONTACTPHONE,@Param11 C_VEHICLE,@Param12 C_ATTITEMID,
                                 @Param13  C_APPLYID,@Param14 C_EMPOID,@Param15 C_RECORDID,@Param16 C_OPERATOR ,@Param17 C_OPERATETIME,@Param18 C_APPLYDATE,@Param19 C_OID_OUTEMPLOYEE
                       )";
                m_conn.ExcuteQuerryByTran(strSQL3, new object[] { strC_BeginDate, strC_EndDate, strC_value, strC_remark,"0", strC_destination,strC_reason,
                                                              strC_destname,strC_destaddress,strC_contactperson,strC_contactphone ,strC_vehicle,strC_attitemid,
                                                              nMaxID3,strC_oid,"0",strc_oid_code,timeNow,timeNow,nMaxID4});

                #endregion
            }
            else
            {
                #region 如果一个审批人的时候
                string change = "";//定义审批人
                if (strSP1 == "")
                {
                    change = strSP2;
                }
                else
                {
                    change = strSP1;
                }

                //1
                string strSQL1 = @"
                        insert into ehr.TB_TMG_APPROVEFLOW (C_APPROVEDATE, C_REMARK, C_RESULT, C_APPROVEEMPID, C_NXTAPPOVEID, C_PREAPPOVEID, C_OPERATOR, C_OPERATETIME, C_OID_APPROVEFLOW)
                        ( SELECT 
                        @Param0 C_APPROVEDATE,  @Param1 C_REMARK,  @Param2 C_RESULT,  @Param3 C_APPROVEEMPID,  @Param4 C_NXTAPPOVEID,  @Param5 C_PREAPPOVEID,  @Param6 C_OPERATOR,
                        @Param7 C_OPERATETIME,  @Param8 C_OID_APPROVEFLOW)";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { DBNull.Value, DBNull.Value, DBNull.Value, change, "0", "0", strc_oid_code, timeNow, nMaxID1 });

                //2
                string strSQL2 = @"
                        insert into ehr.TB_TMG_OUTAPPLY (C_REMARK, C_APPLYSTATUS, C_APPLYEMPID, C_APPROVEFLOWID, C_OPERATOR, C_OPERATETIME,C_OID_OUTAPPLY) 
                        ( SELECT 
                        @Param0  C_REMARK,@Param1 c_applystatus,  @Param2 c_approveflow,  @Param3 c_status,  @Param4 c_operator,  @Param5 c_operatetime,  @Param6 c_oid_vocationapply)";
                m_conn.ExcuteQuerryByTran(strSQL2, new object[] { strC_remark, "0", strC_oid, nMaxID1, strc_oid_code, timeNow, nMaxID2 });

                //3
                string strSQL3 = @"
                        insert into ehr.TB_TMG_OUTEMPLOYEE (C_BEGINDATE, C_ENDDATE, C_VALUE, C_REMARK, C_CONFIRMSTATUS, C_DESTINATION, C_REASON,
                                                            C_DESTNAME,C_DESTADDRESS ,C_CONTACTPERSON, C_CONTACTPHONE, C_VEHICLE, C_ATTITEMID,
                                                            C_APPLYID, C_EMPOID,C_RECORDID,C_OPERATOR, C_OPERATETIME, C_APPLYDATE, C_OID_OUTEMPLOYEE) 
                       ( SELECT  @Param0 C_BEGINDATE, @Param1 C_ENDDATE,@Param2 C_VALUE, @Param3 C_REMARK,@Param4 C_CONFIRMSTATUS,@Param5 C_DESTINATION,@Param6 C_REASON,
                                 @Param7 C_DESTNAME, @Param8 C_DESTADDRESS ,@Param9 C_CONTACTPERSON , @Param10 C_CONTACTPHONE,@Param11 C_VEHICLE,@Param12 C_ATTITEMID,
                                 @Param13  C_APPLYID,@Param14 C_EMPOID,@Param15 C_RECORDID,@Param16 C_OPERATOR ,@Param17 C_OPERATETIME,@Param18 C_APPLYDATE,@Param19 C_OID_OUTEMPLOYEE
                       )";
                m_conn.ExcuteQuerryByTran(strSQL3, new object[] { strC_BeginDate, strC_EndDate, strC_value, strC_remark,"0", strC_destination,strC_reason,
                                                              strC_destname,strC_destaddress,strC_contactperson,strC_contactphone ,strC_vehicle,strC_attitemid,
                                                              nMaxID2,strC_oid,"0",strc_oid_code,timeNow,timeNow,nMaxID3});

                #endregion
            }

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);


        }
        #endregion

        #region 获取审批公出信息
        /// <summary>
        /// 获取审批公出信息
        /// </summary>
        private void GetApproveBusinessOutInfo(DataTable pdt)
        {

            string strC_oid = pdt.Rows[0]["c_oid"].ToString();
            //strC_oid = "81505586";
            string strEHRSQL = @"SELECT TOP 100
                                    t2.C_APPROVEFLOWID ,
                                    t0.C_OID_OUTEMPLOYEE ,
                                    t2.C_OID_OUTAPPLY ,
                                    t3.C_OID ,
                                    t0.C_OPERATOR ,
                                    t0.C_BEGINDATE ,
                                    t0.C_ENDDATE ,
                                    t0.C_VALUE ,
                                    t0.C_REMARK ,
                                    t0.C_CONFIRMSTATUS ,
                                    t0.C_DESTINATION ,
                                    t0.C_REASON ,
                                    t0.C_DESTNAME ,
                                    t0.C_DESTADDRESS ,
                                    t0.C_CONTACTPERSON ,
                                    t0.C_CONTACTPHONE,
                                    t0.C_VEHICLE ,
                                    t0.C_ATTITEMID ,
                                    t4.C_NAME C_ATTITEMIDCN,
                                    t3.C_NAME ,
                                    t0.C_RECORDID ,
                                    t0.C_OPERATETIME ,
                                    t0.C_APPLYDATE ,
                                    t2.C_APPLYSTATUS ,
                                    t2.C_APPLYEMPID ,
                                    t2.C_OPERATOR ,
                                    t2.C_OPERATETIME ,
                                    t3.C_HIREDATE ,
                                    t3.C_UNITCODE ,
                                    t3.C_UNITNAME ,
                                    t3.C_JOBNAME ,
                                    t3.C_ORGID ,
                                    t3.C_UNITID ,
                                    t3.C_EMPLOYEETYPE ,
                                    t3.C_JOBCODE ,
                                    t3.C_JOBID,
                                    t3.C_ORGNAME ,
                                    t3.C_CODE ,
                                    t3.C_ORGCODE ,
                                    t3.C_GENDER ,
                                    t3.C_EMPLOYEESTATUS,
                                    t4.c_code,
                                    t4.c_type ,
                                    t4.c_order ,
                                    t4.c_isforwork ,
                                    t4.c_precision ,
                                    t4.c_calunit ,
                                    t4.c_status ,
                                    t4.c_operator ,
                                    t4.c_operatetime 
                            FROM    ehr.TB_TMG_OUTEMPLOYEE t0 ,
                                    ehr.TB_TMG_ATTITEM t4 ,
                                    ehr.TB_INF_EMPLOYEE t3 ,
                                    ehr.TB_TMG_OUTAPPLY t2 ,
                                    ehr.TB_TMG_APPROVEFLOW approveflo1_
                            WHERE   t0.C_APPLYID = t2.C_OID_OUTAPPLY
                                    AND t0.C_EMPOID = t3.C_OID
                                    AND t0.C_ATTITEMID = t4.c_oid_attitem
                                    AND approveflo1_.C_OID_APPROVEFLOW = t2.C_APPROVEFLOWID
                                    AND approveflo1_.C_APPROVEEMPID= '" + strC_oid + @"'
                                    AND ( t2.C_APPLYSTATUS = '1'
                                          OR t2.C_APPLYSTATUS = '0'
                                        )
                                    AND ( approveflo1_.C_RESULT IS NULL )
                            ORDER BY t0.C_OPERATETIME DESC";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion

        #region 审批公出信息
        /// <summary>
        /// 审批公出信息
        /// </summary>
        private void ApproveBusinessOutInfo(DataTable pdt)
        {

            DateTime timeNow = DateTime.Now;


            string strC_remark = pdt.Rows[0]["c_remark"].ToString();//审批备注
            string strc_oid = pdt.Rows[0]["c_oid"].ToString();//员工号
            string stroid_user = pdt.Rows[0]["m_oid_user"].ToString();//员工编号(操作员)审批
            string strc_approveflowid = pdt.Rows[0]["c_approveflowid"].ToString();//流程号
            string strC_oid_outapply = pdt.Rows[0]["c_oid_outapply"].ToString();//公出申请流程号
            string strBusinessOutType = pdt.Rows[0]["businessouttype"].ToString();//审批类型,1同意,2 拒绝
            string strapplec_oid = pdt.Rows[0]["applec_oid"].ToString();//申请员工号

            m_conn.BeginTransaction();

            #region

            if (strBusinessOutType == "1")
            {
                string strSQL1 = @"
                update  ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7 
                where C_OID_APPROVEFLOW = @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { timeNow, strC_remark, "0", strc_oid, "0", "0", stroid_user, timeNow, strc_approveflowid });

                string strSQL11 = @"
                update  ehr.TB_TMG_OUTAPPLY set C_REMARK= @Param0 , C_APPLYSTATUS= @Param1 , C_APPLYEMPID= @Param2 , C_APPROVEFLOWID= @Param3 , C_OPERATOR= @Param4,C_OPERATETIME=@Param5
                where c_oid_outapply= @Param6 ";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { strC_remark, "2", strapplec_oid, strc_approveflowid, stroid_user, timeNow, strC_oid_outapply });
            }
            else
            {
                string strSQL1 = @"
                update  ehr.TB_TMG_APPROVEFLOW set C_APPROVEDATE= @Param0 , C_REMARK= @Param1 , C_RESULT= @Param2 , C_APPROVEEMPID= @Param3 , C_NXTAPPOVEID= @Param4 , C_PREAPPOVEID= @Param5 , C_OPERATOR= @Param6 , C_OPERATETIME= @Param7 
                where C_OID_APPROVEFLOW = @Param8 ";
                m_conn.ExcuteQuerryByTran(strSQL1, new object[] { timeNow, strC_remark, "0", strc_oid, "0", "0", stroid_user, timeNow, strc_approveflowid });

                string strSQL11 = @"
                update  ehr.TB_TMG_OUTAPPLY set C_REMARK= @Param0 , C_APPLYSTATUS= @Param1 , C_APPLYEMPID= @Param2 , C_APPROVEFLOWID= @Param3 , C_OPERATOR= @Param4,C_OPERATETIME=@Param5
                where c_oid_outapply= @Param6 ";
                m_conn.ExcuteQuerryByTran(strSQL11, new object[] { strC_remark, "3", strapplec_oid, strc_approveflowid, stroid_user, timeNow, strC_oid_outapply });
            }
            #endregion

            m_conn.CommitTransaction();
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion

        #region GetMaxID获取流程等表最大值
        /// <summary>
        /// GetMaxID获取流程等表最大值
        /// </summary>
        private void GetMaxID()
        {
            strMaxID = m_conn.GetDataTableFirstValue(@"   SELECT ISNULL(MAX(maxcount), '1') maxcount
                                                         FROM   ( SELECT    MAX(C_OID_APPROVEFLOW) maxcount
                                                                  FROM      ehr.TB_TMG_APPROVEFLOW
                                                                  WHERE     C_OID_APPROVEFLOW < 3674547
                                                                  UNION
                                                                  SELECT    MAX(C_OID_RENEWCARDSIGN) maxcount
                                                                  FROM      ehr.TB_TMG_RENEWCARDSIGN
                                                                  WHERE     C_OID_RENEWCARDSIGN < 3674547
                                                                  UNION
                                                                  SELECT    MAX(C_OID_CARDSIGNEMP) maxcount
                                                                  FROM      ehr.TB_TMG_CARDSIGNEMP
                                                                  WHERE     C_OID_CARDSIGNEMP < 3674547
                                                                  UNION
                                                                  SELECT    MAX(C_OID_OVERTIMEAPPLY) maxcount
                                                                  FROM      ehr.TB_TMG_OVERTTIMEAPPLY
                                                                  WHERE     C_OID_OVERTIMEAPPLY < 3674547
                                                                  UNION
                                                                  SELECT    MAX(C_OID_OVERTTIMEEMPLOYEE) maxcount
                                                                  FROM      ehr.TB_TMG_OVERTTIMEEMPLOYEE
                                                                  WHERE     C_OID_OVERTTIMEEMPLOYEE < 3674547
                                                                  UNION
                                                                  SELECT    MAX(c_oid_vocationApply) maxcount
                                                                  FROM      ehr.tb_tmg_vocationApply
                                                                  WHERE     c_oid_vocationApply < 3674547
                                                                  UNION
                                                                  SELECT    MAX(C_OID_VOCATIONAPPLYEMP) maxcount
                                                                  FROM      ehr.tb_tmg_vocationApplyemp
                                                                  WHERE     C_OID_VOCATIONAPPLYEMP < 3674547
                                                                  UNION
                                                                  SELECT    MAX(C_OID_OUTAPPLY) maxcount
                                                                  FROM      ehr.TB_TMG_OUTAPPLY
                                                                  WHERE     C_OID_OUTAPPLY < 3674547
                                                                  UNION
                                                                  SELECT    MAX(C_OID_OUTEMPLOYEE) maxcount
                                                                  FROM      ehr.TB_TMG_OUTEMPLOYEE
                                                                  WHERE     C_OID_OUTEMPLOYEE < 3674547
                                                                ) t1
                                                            ", new string[] { }).ToString();
            nMaxID = Convert.ToInt32(strMaxID);
            nMaxID1 = nMaxID + 1;
            nMaxID2 = nMaxID1 + 1;
            nMaxID3 = nMaxID2 + 1;
            nMaxID4 = nMaxID3 + 1;
            nMaxID5 = nMaxID4 + 1;
            nMaxID6 = nMaxID5 + 1;
            nMaxID7 = nMaxID6 + 1;
            nMaxID8 = nMaxID7 + 1;
            nMaxID9 = nMaxID8 + 1;
            nMaxID10 = nMaxID9 + 1;
        }
        #endregion

        #endregion
    }
}
