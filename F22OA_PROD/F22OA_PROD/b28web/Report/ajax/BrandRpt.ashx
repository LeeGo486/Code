<%@ WebHandler Language="C#" Class="BrandRpt" %>

using System;
using System.Web;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Collections;

public class BrandRpt : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string Str_act = context.Request["act"];
        if (Str_act == "BrandReport")
        {
            BrandReport(context);
        }  
    }
    /// <summary>
    /// 竞争品牌调查表
    /// </summary>
    /// <param name="context"></param>
    void BrandReport(HttpContext context)
    {
        string year = context.Request["year"];//年份
        string begMonth = context.Request["bm"];//开始月份
        string endMonth = context.Request["em"];//结束月份
        string MonthList = "";//界面显示的月份
        for (int m = int.Parse(begMonth); m <= int.Parse(endMonth); m++)
        {
            MonthList += m.ToString() + ",";
        }
        //取出今年的所有竞争品牌ID和品牌名称
        string depotid = app_user.dptype != 4 ? "" : app_user.depotid;
        string sql = @"CREATE TABLE #dpt(depotid VARCHAR(8));";
        if (depotid == "")
        {
            sql += @"INSERT INTO #dpt
                            SELECT depotid FROM " + app_user.dbname.Trim() + @"_f22_power.dbo.power_dpt" + app_user.userid + @" WHERE access=1 and selection=1;";
        }
        else
        {
            sql += @"INSERT INTO #dpt
                            SELECT depotid FROM j_depot WHERE depotid=@depotid;";
        }
        sql+=@"SELECT b.DepotId,a.BrandId 
                INTO #tmp
                from D_CompeteBrandData a INNER JOIN D_CompeteBrandSurvey b
                on a.SurveyId=b.SurveyId 
                WHERE b.SurveyYear=@year AND b.SurveyMonth BETWEEN @begMonty and @endMonth
                AND EXISTS(SELECT 1 from #dpt c WHERE c.depotid=b.DepotId )        
                GROUP BY b.DepotId,a.BrandId;

                DECLARE @dptid varchar(8)
                SET @dptid=''
                SELECT TOP(1) @dptid=DepotId 
                FROM #tmp GROUP BY DepotId ORDER BY COUNT(1) DESC              
                PRINT @depotid;

                SELECT ISNULL(STUFF((select ','+BrandId FROM #tmp where depotid=@dptid FOR XML PATH('')),1,1,''),'')AS BrandID,
                ISNULL(STUFF((select ','+BrandId FROM #tmp where depotid=@dptid FOR XML PATH('')),1,1,''),'')AS BrandName;
                DROP TABLE #dpt";
        DataTable brandDT = app_cn.getTable(sql, new SqlParameter[] {
            new SqlParameter("@depotid",depotid),
            new SqlParameter("@year",year),
            new SqlParameter("@begMonty",begMonth),
            new SqlParameter("@endMonth",endMonth)
        }, CommandType.Text);
        string BrandIDList = brandDT.Rows[0]["BrandID"].ToString();//所有的品牌ID，','分隔
        string BrandNameList = brandDT.Rows[0]["BrandName"].ToString();//所有的品牌名称，','分隔
        //读取数据
        
        DataSet dtset = app_cn.getDataSet("f22qry_BrandSurvey", new SqlParameter[] {
            new SqlParameter("@userid",app_user.userid),
            new SqlParameter("@depotid",depotid),
            new SqlParameter("@year",year),
            new SqlParameter("@begMonty",begMonth),
            new SqlParameter("@endMonth",endMonth)
        }, CommandType.StoredProcedure);

        DataTable mianDT = dtset.Tables[0];
        //排名数据
        DataTable pmDT = dtset.Tables[1];
        //销售业绩数据
        DataTable xsDT = dtset.Tables[2];
        //店铺表
        DataTable dptDT = dtset.Tables[3];
        //返回JSON
        StringBuilder sbJSON = new StringBuilder();
        if (mianDT.Rows.Count > 0)
        {
            //店铺品牌销售业绩和排名数据
            string mainJSON = app_tools.dtjson(mianDT);
            string xsjson = toJson(xsDT, dptDT);
            string pmjson = toJson(pmDT, dptDT);
            //context.Response.Write("{\"m\":" + xsjson + "}");
            context.Response.Write("{\"msg\":\"\",\"m\":\"" + MonthList.Trim(',') + "\",\"bid\":\"" + BrandIDList.Replace("\\", "\\\\") + "\",\"bname\":\"" + BrandNameList.Replace("\\", "\\\\") + "\",\"mlist\":" + mainJSON.Trim(';') + ",\"xs\": " + xsjson + ",\"pm\":" + pmjson + "}");
        }
        else
        {
            context.Response.Write("{\"msg\":\"nodpt\"}");
        }
    }

    /// <summary>
    /// datatable转json
    /// </summary>
    /// <param name="dt"></param>
    /// <param name="valueFile"></param>
    /// <returns></returns>
    private string toJson(DataTable dt, DataTable dptdt)
    {
        StringBuilder sbjson = new StringBuilder();
        sbjson.Append("{");
        string j = "";
        foreach (DataRow dr in dptdt.Rows)
        {
            string depotid = dr["depotid"].ToString();
            DataRow[] drs = dt.Select("DepotID='" + depotid + "'");//找出店铺的排名数据
            if (drs.Length > 0) 
            {
                DataTable temp = dt.Clone();
                string xjson = "\"dpt_" + depotid + "\":";
                foreach (DataRow xdr in drs)
                {
                    temp.ImportRow(xdr);
                }
                string json = app_tools.dtjson(temp);
                j += xjson + json.Trim(';') + ",";
                temp.Clear();
            }
        }
        sbjson.Append(j.TrimEnd(','));
        sbjson.Append("}");
        return sbjson.ToString();
    }
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}