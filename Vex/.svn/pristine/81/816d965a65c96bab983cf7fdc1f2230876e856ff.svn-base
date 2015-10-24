using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;
 
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets; 
using HZY.COM.Common.Base;


/// 类名：PE_OA_TaskCenter
/// 类说明：Tasks信息管理
/// 创建人：DLY
/// 创建日期：2014-04-29
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_TaskCenter : LogicBase, ILogicGetData
    {
        #region 构造函数
        public PE_OA_TaskCenter()
	    {
            this.m_SessionCheck = true;
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
                Dbconn conn = new Dbconn("PE_OA");
                DataSet ds = new DataSet();
                if (strType == "GetWFTList" )
                {
                   ds = GetWorkFlowTaskList(conn, strType);
                } if (strType == "GetWFTHisList")
                {
                   ds = GetWFTHisList(conn, strType);
                } 
                return ds;

            }
            catch
            {
                 throw;
            }
        }
        #endregion


        #region 根据条件获取待办任务数据集 条件-分页-排序等
        /// <summary>
        /// 根据条件获取待办任务数据集 条件-分页-排序等
        /// </summary>
        /// <returns></returns>
        public DataSet GetWorkFlowTaskList(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons1 = dsXML.Tables["LIST"].Rows[0]["Cons1"].ToString();
            string strCons2 = dsXML.Tables["LIST"].Rows[0]["Cons2"].ToString();
            string strCons3 = dsXML.Tables["LIST"].Rows[0]["Cons3"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();

            String strXMLC = "【操作类型,GET】【实体,任务查询】【CONO,】【DIVI,】"
                           + "【《W》页码," + strPage + "】【《W》记录数," + strNum + "】"
                           + "【《W》查询条件1," + strCons1 + "】"
                           + "【《W》查询条件2," + strCons2 + "】"
                           + "【《W》查询条件3," + strCons3 + "】"
                           + "【排序方式," + strOrderBy + "】"
                           + "【Type," + strType + "】"
                           + "【返回内容, 任务列表】"; 

            ds = conn.GetDataSetBySP("SRV_BPM.WorkFlowTask_APP", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
        } 
        #endregion

        #region 根据条件获取审批历史
        /// <summary>
        /// 根据条件获取审批历史
        /// </summary>
        /// <returns></returns>
        public DataSet GetWFTHisList(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons1 = dsXML.Tables["LIST"].Rows[0]["Cons1"].ToString();
            string strCons2 = dsXML.Tables["LIST"].Rows[0]["Cons2"].ToString();
            string strCons3 = dsXML.Tables["LIST"].Rows[0]["Cons3"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();

            String strXMLC = "【操作类型,GET】【实体,历史查询】【CONO,】【DIVI,】"
                           + "【《W》页码," + strPage + "】【《W》记录数," + strNum + "】"
                           + "【《W》查询条件1," + strCons1 + "】"
                           + "【《W》查询条件2," + strCons2 + "】"
                           + "【《W》查询条件3," + strCons3 + "】"
                           + "【排序方式," + strOrderBy + "】"
                           + "【Type," + strType + "】"
                           + "【返回内容, 任务列表】";

            ds = conn.GetDataSetBySP("SRV_BPM.WorkFlowTask_APP", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
        }
        #endregion
        

    }
}