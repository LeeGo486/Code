using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1001A
{
    /// <summary>
    ///EPAPP_IT_TASKNODE_GetList 根据任务编号获取需求报表明细
    /// </summary>
    public class EPAPP_IT_TASKNODE_GetList : LogicBase, ILogicGetData
    {
        public EPAPP_IT_TASKNODE_GetList()
        {
            this.m_SessionCheck = false;
        }

        public DataSet GetData()
        {
            string strTid = "";

            try
            {
                if (m_request != null && m_request.Tables.Count > 0)
                {
                    strTid = m_request.Tables[0].Rows[0]["tid"].ToString();
                }

                if (strTid == "")
                {
                    throw new Exception("tid为空");
                }

                Dbconn conn = new Dbconn("X6_EPApp");
                DataSet ds = conn.GetDataSet(@"               

                    SELECT  fid ,
                            tid ,
                            fTaskID ,
                            fProjectName ,
                            fPrincipal ,
                            fPlanningFinishDate ,
                            fActualFinishDate ,
                            fDays ,
                            fDifficultyLevel ,
                            fState ,
                            fGrade ,
                            fProgressDescription ,
                            fConfirmNote
                    FROM    dbo.IT_TASKNODE WITH ( NOLOCK )
                    WHERE   tid = '" + strTid + @"'
                    ORDER BY fTaskNumber ASC
            ");
                return ds;
            }
            catch
            {
                throw;
            }
        }

    }

}