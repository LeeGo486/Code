using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：PE_OA_Calendar
/// 类说明：日历管理
/// 创建人：DLY
/// 创建日期：2014-06-16
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_Calendar : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        Dbconn conn = new Dbconn("PE_OA");

        #region 构造函数
        public PE_OA_Calendar()
        {
            this.m_SessionCheck = false;
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        #endregion

        #region GetData
        public DataSet GetData()
        {
            try
            {
                string strType = m_request.Tables[0].Rows[0]["type"].ToString();

                DataSet ds = new DataSet();
                if (strType == "New" || strType == "Upd" || strType == "Del")
                {
                    ds = SetCalendar(conn, strType);

                }
                else if (strType == "GetHs")
                {
                    ds = GetCalendarList(conn, strType);
                }
                else if (strType == "GetPers")
                {
                    ds = GetPersList(conn, strType);
                }
                return ds;

            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region 新建或修改日历记录
        /// <summary>
        /// 新建或修改日历记录
        /// </summary>
        /// <returns></returns>
        public DataSet SetCalendar(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            //获取日历主数据
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["dail_id"].ToString();
            DataTable dt_List = dsXML.Tables["LIST"];
            if (strID == "")
            {
                throw new Exception("数据异常，缺少主键，请联系管理员！");
            }

            bool bResult = false;
            if (strType == "New") //新建
            {
                conn.BeginTransaction();
                bResult = conn.Insert("[B01_MDM].[DAIL_DailyManage]", dt_List);
                conn.CommitTransaction();
            }
            else if (strType == "Upd") //修改
            {
                conn.BeginTransaction();
                bResult = conn.Update("[B01_MDM].[DAIL_DailyManage]", dt_List, "dail_id='" + strID + "'");
                conn.CommitTransaction();
            }
            else if (strType == "Del") //删除
            {
                conn.BeginTransaction();
                bResult = conn.Delete("[B01_MDM].[DAIL_DailyManage]", "dail_id='" + strID + "'");
                conn.CommitTransaction();
            }

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion

        #region 根据条件获取日历记录数据集
        /// <summary>
        /// 根据条件获取鉴定单数据集  
        /// </summary>
        /// <returns></returns>
        public DataSet GetCalendarList(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            string[] strParam = new string[] { };
            strSQL = @" SELECT DAIL_ID AS id, DAIL_M01P_ID, DAIL_M02C_ID,
                        convert(varchar(10), DAIL_EventDate, 111) AS date,
                        convert(varchar(5), DAIL_ValidateFrom, 108) AS bgtime , 
                        convert(varchar(5), DAIL_ValidateTo, 108) AS edtime , 
                        DAIL_Desp AS remark, DAIL_Travel AS theme, DAIL_Appointment AS persons, 
                        DAIL_Rgdt, DAIL_RgUser AS per, DAIL_LmDt, DAIL_LmUser, DAIL_UptNo
                      FROM [B01_MDM].[DAIL_DailyManage] WHERE 1=1 " + strCons + strOrderBy;
            ds = conn.GetDataSet(strSQL);
            return ds;
        }
        #endregion


        #region 根据条件获取关注人员
        /// <summary>
        ///  根据条件获取关注人员
        /// </summary>
        /// <returns></returns>
        public DataSet GetPersList(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            string[] strParam = new string[] { };
            strSQL = @" select AUTH_UserName as name from F01_CERT.AUTH_Authority 
                    WHERE 1=1 " + strCons + strOrderBy;
            ds = conn.GetDataSet(strSQL);
            return ds;
        }
        #endregion

    }
}