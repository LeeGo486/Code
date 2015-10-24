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

/// 类名：EHRInfo
/// 类说明：EHR基本信息获取
/// 创建人：郭琦琦
/// 创建日期：2014-12-30
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.PointToPoint
{
    public class EHRInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public EHRInfo()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("EHRFORSalary");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();

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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEHRUnitInfo".ToUpper()) //获取部门信息 
                {
                    GetEHRUnitInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEHRShopPersonInfo".ToUpper())//获取店铺人员信息
                {
                    GetEHRShopPersonInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEHRPersonInfo".ToUpper())//获取人员信息
                {
                    GetEHRPersonInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCodeItems".ToUpper())//获取基础选项
                {
                    GetCodeItems(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEHRJobInfo".ToUpper())//获取岗位信息
                {
                    GetEHRJobInfo(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetBank".ToUpper())//获取银行
                {
                    GetBank(dtList);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ActDataSync".ToUpper())//数据同步
                {
                    ActDataSync(dtList);
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


        #region 部门信息
        /// <summary>
        /// 部门信息
        /// </summary>
        private void GetEHRUnitInfo(DataTable pdt)
        {
            string strCons = pdt.Rows[0]["cons"].ToString();  //TB_INF_EMPLOYEE 条件
            string strType = pdt.Rows[0]["type"].ToString();  
            string strRows = pdt.Rows[0]["rows"].ToString();
            string strCons1 = "";    //TB_ORG_ORGUNIT 条件 (可无)

            if(strRows==null || strRows==""){
                strRows = "20";
            }

            string strEHRSQL = "";

            if(strType == "1" || strType == "3"){
                /*
                strEHRSQL = @" SELECT DISTINCT TOP " + strRows + @" C_ORGID, C_ORGCODE, C_ORGNAME 
                                    , C_UNITID, C_UNITCODE, C_UNITNAME 
                                FROM  ehr.TB_INF_EMPLOYEE A , ehr.TB_ORG_ORGUNIT B
                                WHERE A.C_STATUS = 1 AND ISNULL(A.C_ORGCODE,'') <> '' AND  B.C_STATUS = 1
                                   AND A.C_UNITID = B.C_OID_ORGUNIT";
                 * 
                 strEHRSQL = @"SELECT DISTINCT TOP " + strRows + @" C_ORGID, C_ORGCODE, C_ORGNAME, C_UNITID, C_UNITCODE, C_UNITNAME
	                           FROM  ehr.TB_INF_EMPLOYEE A WHERE A.C_STATUS = 1 " + strCons + @" 
		                         AND ISNULL(A.C_ORGCODE,'') <> ''
	                             AND  C_OPERATETIME = (SELECT MAX(C_OPERATETIME) 
			                        FROM ehr.TB_INF_EMPLOYEE WHERE C_UNITID =  A.C_UNITID ) 
                                 AND 1 = isnull((SELECT  TOP  1  C_STATUS 
			                        FROM ehr.TB_ORG_ORGUNIT  WHERE C_OID_ORGUNIT =  A.C_UNITID 
                                            AND C_CODE = A.C_UNITCODE " + strCons1 + "),0)";
                */
                if (strType == "3")
                {
                    strCons1 = pdt.Rows[0]["cons1"].ToString();
                }
                strEHRSQL = @"SELECT DISTINCT TOP " + strRows + @" B1.C_OID_ORGUNIT c_orgid, B1.C_CODE c_orgcode, B1.C_NAME c_orgname 
		                               , A.C_OID_ORGUNIT c_unitid, A.C_CODE c_unitcode, A.C_NAME c_unitname1  
		                               , CASE WHEN I.C_NAME IS NOT NULL THEN I.C_NAME + '\' ELSE '' END
		                               + CASE WHEN G.C_NAME IS NOT NULL THEN G.C_NAME + '\' ELSE '' END
		                               + CASE WHEN E.C_NAME IS NOT NULL THEN E.C_NAME + '\' ELSE '' END
		                               + CASE WHEN C.C_NAME IS NOT NULL THEN C.C_NAME + '\' ELSE '' END
		                               + CASE WHEN A.C_NAME IS NOT NULL THEN A.C_NAME  ELSE '' END c_unitname
		                              FROM ehr.TB_ORG_ORGUNIT  A
		                              JOIN ehr.temp_orgstree B ON  B.unitid = A.C_OID_ORGUNIT AND state <> 9 " + strCons1 + @"
		                              LEFT JOIN ehr.TB_ORG_ORGUNIT B1 ON  B1.C_OID_ORGUNIT = B.orgid AND B1.C_STATUS = 1
		                              LEFT JOIN ehr.TB_ORG_ORGUNIT C ON C.C_OID_ORGUNIT = B.parentid AND C.C_STATUS = 1 AND C.C_ADDON1 >= 3 
		                              LEFT JOIN ehr.temp_orgstree D ON  D.unitid = C.C_OID_ORGUNIT 
		                              LEFT JOIN ehr.TB_ORG_ORGUNIT E ON E.C_OID_ORGUNIT = D.parentid AND E.C_STATUS = 1 AND E.C_ADDON1 >= 3 
		                              LEFT JOIN ehr.temp_orgstree F ON  F.unitid = E.C_OID_ORGUNIT  
		                              LEFT JOIN ehr.TB_ORG_ORGUNIT G ON G.C_OID_ORGUNIT = F.parentid AND G.C_STATUS = 1 AND G.C_ADDON1 >= 3 
		                              LEFT JOIN ehr.temp_orgstree H ON  H.unitid = G.C_OID_ORGUNIT 
		                              LEFT JOIN ehr.TB_ORG_ORGUNIT I ON I.C_OID_ORGUNIT = H.parentid AND I.C_STATUS = 1 AND I.C_ADDON1 >= 3 
	                              WHERE A.C_STATUS = 1  AND A.C_ADDON1 >= 3 " + strCons ;
            }
            else if (strType == "2")
            {
                strEHRSQL = @" SELECT TOP " + strRows + @" * FROM ehr.TB_ORG_ORGUNIT  WHERE C_STATUS = 1 ";
            } 
            strEHRSQL = strEHRSQL + " ORDER BY C_ORGID, C_UNITCODE ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion

        #region 店铺人员信息
        /// <summary>
        /// 店铺人员信息
        /// </summary>
        private void GetEHRShopPersonInfo(DataTable pdt)
        {

            string strC_employeestatus = pdt.Rows[0]["c_employeestatus"].ToString();
            string strC_orgunitid = pdt.Rows[0]["c_orgunitid"].ToString();
            string strType = pdt.Rows[0]["type"].ToString();

            string fields = "C_CODE , C_NAME ";
            if (strType == "1")
            {
                fields = "C_CODE , C_NAME ";
            }else if (strType == "2"){
                fields = @" C_OID ,
                            C_CODE ,
                            C_NAME ,
                            C_GENDER,
                            C_EMPLOYEESTATUS, 
                            C_JOBNAME,
                            CONVERT(varchar(10), C_HIREDATE,120) C_HIREDATE ";
            }
            string strEHRSQL = "  SELECT " + fields + "  FROM    ehr.TB_INF_EMPLOYEE A"
                             + "  WHERE C_UNITID = '" + strC_orgunitid +"' ";
            if(strC_employeestatus!=""){
                strEHRSQL = strEHRSQL + " AND C_EMPLOYEESTATUS in(" + strC_employeestatus + ")";
            }  
            //排除离职在1个月外的
            strEHRSQL = strEHRSQL + @" AND 60 > CASE WHEN C_EMPLOYEESTATUS = 3 
                                        THEN  DATEDIFF(DAY,ISNULL((SELECT MAX(C_DIMISSIONDATE) FROM ehr.TB_PER_Dimission 
	                                    WHERE c_empoid = A.C_OID GROUP BY C_EMPOID), '1900-01-01'),GETDATE()) ELSE 0 END ";
            strEHRSQL = strEHRSQL + " order by C_EMPLOYEESTATUS, C_CODE ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion 

        #region 获取人员信息
        /// <summary>
        /// 获取人员信息
        /// </summary>
        private void GetEHRPersonInfo(DataTable pdt)
        {

            string strC_oid = pdt.Rows[0]["c_oid"].ToString();

            string strEHRSQL = @" SELECT  A.*, B.C_BANKID, B.C_ACCOUNT,
                                    convert(varchar(10),C.C_BEGINDATE,120) AS HR5_syqBeginDate, 
                                    convert(varchar(10),C.C_ENDDATE,120) AS HR5_syqEndDate 
                                    FROM    ehr.TB_INF_EMPLOYEE A 
                                    LEFT JOIN  ehr.TB_CNB_INDIACCOUNT B
                                        ON  A.C_OID = B.C_EMPLOYEEOID  AND B.C_TYPE=0
                                    LEFT JOIN  ehr.TB_PER_PROBATION C
                                        ON  A.C_OID = C.C_EMPOID  
                                        AND convert(varchar(10),A.c_joinunitdate,120) = convert(varchar(10),C.c_begindate,120)
                                    WHERE A.C_OID = '" + strC_oid + @"'
                                    ORDER BY A.C_OPERATETIME DESC";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion





        #region 获取岗位信息
        /// <summary>
        /// 获取岗位信息
        /// </summary>
        private void GetEHRJobInfo(DataTable pdt)
        {

            string strC_unitid = pdt.Rows[0]["c_unitid"].ToString();

            string strEHRSQL = @"   SELECT C_JOBID, C_CODE, C_NAME FROM ehr.TB_ORG_ASSIGNEDJOB  
                                    WHERE   C_ORGUNITID = '" + strC_unitid + @"' AND C_STATUS = 1
                                    ORDER BY C_CODE ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion
      
        #region 基础数据选项
        /// <summary>
        /// 基础数据选项
        /// </summary> 
        public void GetCodeItems(DataTable pdt)
        {
            string strC_typecode = pdt.Rows[0]["c_typecode"].ToString();

            string strEHRSQL = @" SELECT C_typecode, C_Code, C_Name FROM ehr.TB_SYS_CODEITEM 
                                    WHERE C_typecode in  ("
                                    + strC_typecode + @" ) ORDER BY C_ORDER ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        } 
        #endregion

        #region 获取银行信息
        /// <summary>
        /// 获取银行信息
        /// </summary>
        private void GetBank(DataTable pdt)
        {

            string strEHRSQL = @"  select * from ehr.TB_CNB_BANK  ";
            ds_Return = m_conn.GetDataSet(strEHRSQL, new string[] { });
        }
        #endregion


        #region  信息同步
        /// <summary>
        /// 信息同步
        /// </summary>
        /// <returns></returns>
        public DataSet ActDataSync(DataTable pdt)
        {  
            //获取条件值 
            string strType = pdt.Rows[0]["type"].ToString();  
            if (strType=="emp"){ 
                string strTaskID = pdt.Rows[0]["taskid"].ToString();
                string strActorID = pdt.Rows[0]["actorid"].ToString();
                ds_Return = m_conn.GetDataSetBySP("[ehr].[PROC_EHRFZ_EMP]", new string[2] { "@sTaskID", "@sActorID" }
                   , new string[2] { strTaskID, strActorID });
            }
            else if (strType == "ovt")
            {
                string strMonth = pdt.Rows[0]["month"].ToString();
                string strActorID = pdt.Rows[0]["actorid"].ToString();
                ds_Return = m_conn.GetDataSetBySP("[ehr].[PROC_EHRFZ_OVT]", new string[2] { "@sMonth", "@sActorID" }
                   , new string[2] { strMonth, strActorID });
            } 
            return ds_Return; 
        }
        #endregion

        #endregion
    }
}
