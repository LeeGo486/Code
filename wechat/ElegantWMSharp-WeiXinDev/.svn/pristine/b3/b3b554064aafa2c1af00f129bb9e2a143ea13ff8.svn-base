using System;
using System.Linq;
using ElegantWM.EntityModel;
using ElegantWM.IDAL;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/**
 * 作者：WebMisSharp
 * 时间：2014/7/30 16:16:50
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
    public class SHOPCustomerFeedbackDAL : EFRepository<SHOP_CustomerFeedback>, ISHOPCustomerFeedbackDAL
    {
		/* 如果是多数据库，请开启
		*/
        public SHOPCustomerFeedbackDAL()
            : base("S3DB")
        {

        }

        /// <summary>
        /// 客户反馈IPAD报表
        /// </summary>
        /// <param name="type">报表类型101 客户需求大类，102 客户需求小类，103 skc，104 客户职业分布，201,202,203子类，skc，职业详细报表</param>
        /// <param name="param">参数，102需要，</param>
        /// <param name="date">时间范围1 昨天，2 近七天，3 本周，4 上周， 5 本月，6 上月，7本年度</param>
        /// <returns></returns>
        public DataTable Report(int type,string param,int date)
        {
            using (SqlConnection connection = new SqlConnection(_db.Database.Connection.ConnectionString))
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Click_CustomerFeedBack";
                cmd.CommandType = CommandType.StoredProcedure;//存储过程
                cmd.Connection = connection;//数据库连接
                cmd.Parameters.Add("@type", SqlDbType.Int);
                cmd.Parameters["@type"].Value = type;

                cmd.Parameters.Add("@param", SqlDbType.VarChar);
                cmd.Parameters["@param"].Value = param;

                cmd.Parameters.Add("@date", SqlDbType.Int);
                cmd.Parameters["@date"].Value = date;

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                connection.Open();
                adapter.Fill(ds);
                connection.Close();
                return ds.Tables[0];
            }
        }
    }
}
