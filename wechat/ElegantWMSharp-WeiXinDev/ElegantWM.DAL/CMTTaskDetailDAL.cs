using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Data;
using System.Data.SqlClient;

/**
 * 作者：WebMisSharp
 * 时间：2014-10-21 17:53:47
 * 功能：数据访问层
 * 版本：V1.0
 * 网站：http://www.chinacloudtech.com
 * ------------------------------------
 * 修改人：
 * 修改时间：
 * 修改内容：
 * 版本： 
 **/

 namespace ElegantWM.DAL
{
    public class CMTTaskDetailDAL : EFRepository<TK2_TaskDetail>, ICMTTaskDetailDAL
    {
        /* 如果是多数据库，请开启*/
        public CMTTaskDetailDAL()
            : base("CMTFeedBack")
        {

        }

        //获取计划明细
        public DataTable TaskDetailPlan(string ID,string Type, DateTime date)
        {
            string where = "";
            if (Type == "Plan"){
                where = " AND d.ArrivalDate IS NULL";
            }else{
                where = " AND d.ArrivalDate IS NOT NULL";
            };
            string strSQL = @"SELECT h.Name AS TaskName,d.CUS1_ID AS TaskID,c.Name AS CUS_Name,n1.Name AS result,n2.Name AS Reason,
                        d.ReservationDate,d.ReservationDateAgain,d.InvitationDate,
                        d.ArrivalDate,d.Status,t.Name
                        FROM M02_BPM.TK2_TaskDetail AS d
                        INNER JOIN B01_MDM.CUS1_CustomerDoc AS c  ON c.Code=d.CUS1_ID
                        INNER JOIN M02_BPM.TK1_TaskHead AS h ON h.ID=d.TK1_ID
                        INNER JOIN M01_CONF.DICP_Dictionary AS n1 ON n1.ID=d.DICP_ID_Result
                        INNER JOIN M01_CONF.DICP_Dictionary AS n2 ON n2.ID=d.DICP_ID_Reason
                        INNER JOIN M02_BPM.TKT_TaskType AS t ON h.TKT_ID=t.ID
                        WHERE c. CustomerManagerID = " + ID + " AND d.ReservationDate = " + date.ToString() + where;
            return Query(strSQL, null);
        }

        //获取任务数据

        //        public DataTable TaksView(string ID, DateTime StartDate, DateTime EndDate) {
        //            string strSQL = @"
        //                    SELECT h.Name AS 预约主题,d.CUS1_ID AS 客户ID,c.Name AS 客户姓名,n1.Name AS 预约结果,n2.Name AS 拒绝原因,
        //                    d.ReservationDate AS 预约时间,d.ReservationDateAgain AS 再次预约时间,d.InvitationDate AS 应邀时间,
        //                    d.ArrivalDate AS 到店时间,d.Status AS 是否已预约,t.Name AS 任务类型
        //                    FROM M02_BPM.TK2_TaskDetail AS d
        //                    INNER JOIN B01_MDM.CUS1_CustomerDoc AS c  ON c.Code=d.CUS1_ID
        //                    INNER JOIN M02_BPM.TK1_TaskHead AS h ON h.ID=d.TK1_ID
        //                    INNER JOIN M01_CONF.DICP_Dictionary AS n1 ON n1.ID=d.DICP_ID_Result
        //                    INNER JOIN M01_CONF.DICP_Dictionary AS n2 ON n2.ID=d.DICP_ID_Reason
        //                    INNER JOIN M02_BPM.TKT_TaskType AS t ON h.TKT_ID=t.ID
        //                    WHERE c. CustomerManagerID =用户ID AND d.ReservationDate =传入时间";
        //            return Query(strSQL, null);
        //        }





        #region 调取任务的存储过程
            public DataSet TaskResult(string strName,string strAml)
                {
                    using (SqlConnection connection = new SqlConnection(_db.Database.Connection.ConnectionString))
                    {
                        SqlCommand cmd = new SqlCommand();
                        cmd.CommandText = strName;    //存储过程名
                        cmd.CommandType = CommandType.StoredProcedure;//存储过程
                        cmd.Connection = connection;//数据库连接
                
                        //参数

                        //@InputFormat
                        cmd.Parameters.Add("@InputFormat", SqlDbType.VarChar);
                        cmd.Parameters["@InputFormat"].Value = "AML";

                        //@OutputFormat
                        cmd.Parameters.Add("@OutputFormat", SqlDbType.VarChar);
                        cmd.Parameters["@OutputFormat"].Value = "DB";

                        //@OutputContentType
                        cmd.Parameters.Add("@OutputContentType", SqlDbType.VarChar);
                        cmd.Parameters["@OutputContentType"].Value = "RS";

                        //@ConditionStr
                        cmd.Parameters.Add("@ConditionStr", SqlDbType.VarChar);
                        cmd.Parameters["@ConditionStr"].Value = strAml;

                

                        //cmd.Parameters.Add("@type", SqlDbType.Int);
                        //cmd.Parameters["@type"].Value = type;

                        //cmd.Parameters.Add("@param", SqlDbType.VarChar);
                        //cmd.Parameters["@param"].Value = param;

                        //cmd.Parameters.Add("@date", SqlDbType.Int);
                        //cmd.Parameters["@date"].Value = date;

                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataSet ds = new DataSet();
                        connection.Open();
                        adapter.Fill(ds);
                        connection.Close();
                        return ds;
                    }
                }
        #endregion

    }
}
