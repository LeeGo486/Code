using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DAO;
using EPReper.Model;
using System.Text;
using System.Data;

namespace EPReper.Web.EPSafe
{
    /// <summary>
    /// GetSafeRes 的摘要说明
    /// </summary>
    public class GetSafeRes : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {

            context.Response.ContentType = "text/plain";
            string fid = context.Request["fid"].ToString();
            string Type = context.Request["Type"].ToString();
            string method = context.Request["method"].ToString();

            context.Response.Write(InfoBind(fid,Type,method));
            context.Response.End();  
        }


        private string InfoBind(string fid, string type, string method)
        {
            CommonDao<SafePitFalls> newmgr = new CommonDao<SafePitFalls>();
           string JsonData= newmgr.GetSingalJson(fid);
           return JsonData;
        }

        #region dataTable转换成Json格式
        /// <summary>         
        /// /// dataTable转换成Json格式       
        /// /// </summary>          
        /// <param name="dt"></param>      
        /// /// <returns></returns>        
        public static string DataTable2Json(DataTable dt)
        {
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.Append("{\"");
            jsonBuilder.Append(dt.TableName);
            jsonBuilder.Append("\":[");
            jsonBuilder.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                jsonBuilder.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    jsonBuilder.Append("\"");
                    jsonBuilder.Append(dt.Columns[j].ColumnName);
                    jsonBuilder.Append("\":\"");
                    jsonBuilder.Append(dt.Rows[i][j].ToString());
                    jsonBuilder.Append("\",");
                }
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
                jsonBuilder.Append("},");
            }
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            jsonBuilder.Append("]");
            jsonBuilder.Append("}");
            return jsonBuilder.ToString();
        }

        #endregion dataTable转换成Json格式
        #region DataSet转换成Json格式
        /// <summary>         
        /// /// DataSet转换成Json格式   
        /// /// </summary>        
        /// /// <param name="ds">DataSet</param>    
        /// /// <returns></returns>      
        public static string Dataset2Json(DataSet ds)
        {
            StringBuilder json = new StringBuilder();
            foreach (DataTable dt in ds.Tables)
            {
                json.Append("{\"");
                json.Append(dt.TableName);
                json.Append("\":");
                json.Append(DataTable2Json(dt));
                json.Append("}");
            } return json.ToString();
        }
        #endregion
        /// <summary>    
        /// /// Msdn      
        /// /// </summary>      
        /// /// <param name="jsonName"></param>   
        /// /// <param name="dt"></param>      
        /// /// <returns></returns>        
        public static string DataTableToJson(string jsonName, DataTable dt)
        {
            StringBuilder Json = new StringBuilder();
            Json.Append("{\"" + jsonName + "\":[");
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    Json.Append("{");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        Json.Append("\"" + dt.Columns[j].ColumnName.ToString() + "\":\"" + dt.Rows[i][j].ToString() + "\"");
                        if (j < dt.Columns.Count - 1)
                        {
                            Json.Append(",");
                        }
                    }
                    Json.Append("}");
                    if (i < dt.Rows.Count - 1)
                    {
                        Json.Append(",");
                    }
                }
            }
            Json.Append("]}"); return Json.ToString();
        }





        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}