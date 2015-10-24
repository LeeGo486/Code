<%@ WebHandler Language="C#" Class="Register" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public class Register : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string act = context.Request["act"];
        if (act == "RetailRegister")
        {
            RetailRegister(context);
        }
        else if (act == "SaveRetail")
        {
            SaveRetail(context);
        }
        else if (act == "SureRetail")
        {
            SureRetail(context);
        }
        else if (act == "unSureRetail")
        {
            unSureRetail(context);
        }
        else if (act == "OnCount")
        {
            OnCount(context);
        }
    }

    /// <summary>
    /// 查询店铺月销售登记表
    /// </summary>
    /// <param name="context"></param>
    void RetailRegister(HttpContext context)
    {
        try
        {
            StringBuilder sbJSON = new StringBuilder();//返回的JSON
            string[] weekdays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
            string year = context.Request["year"];//年份
            string month = context.Request["month"];//月份
            //读取月目标设置
            DataTable goalDT = getMonthRetailGoal(year, month);
            DateTime time1 = DateTime.Parse(year + "-" + month + "-" + "1");//当月1号
            DateTime time2 = DateTime.Parse(year + "-" + month + "-" + "1").AddMonths(1);//下个月1号
            TimeSpan ts = time2 - time1;//计算时间差
            int days = ts.Days;//2个月相差天数
            
            string id = "";
            string columns = "";
            if (goalDT.Rows.Count > 0)
            {
                //金额目标
                decimal jemb = Convert.ToDecimal(goalDT.Rows[0]["Sums_RetailGoal"]);
                int slmb = Convert.ToInt32(goalDT.Rows[0]["Nums_RetailGoal"]);

                //取数据前先检查一次数据
                int Chk_Sure = 0;
                string sql = "select RetailId,Chk_Sure from D_MonthRetail where DepotId=@DepotId and SurveyYear=@SurveyYear and SurveyMonth=@SurveyMonth";
                DataTable dt = app_cn.getTable(sql, new SqlParameter[]{
                    new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@SurveyYear",year),
                    new SqlParameter("@SurveyMonth",month),
                }, CommandType.Text);
                bool f = true;
                if (dt.Rows.Count <= 0)
                {
                    if (DateTime.Now.Year == int.Parse(year) && DateTime.Now.Month == int.Parse(month))
                    {
                        f = false;
                        string RetailId = "DJ" + app_user.userid + "-" + year + "-" + month.PadLeft(2, '0') + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0') + "-0001";//ID
                        id = RetailId;
                        CheckedData(RetailId, year, month);
                    }
                }
                else
                {
                    Chk_Sure = Convert.ToInt32(dt.Rows[0]["Chk_Sure"]);
                    id = dt.Rows[0]["RetailId"].ToString();
                }
                if (DateTime.Now.Year == int.Parse(year) && DateTime.Now.Month == int.Parse(month))
                {
                    if (f)
                    {
                        //如果查新是本月的数据要检查看看有没有新的抬头加进来
                        sql = @"INSERT INTO D_MonthRetailType(CompeteYear,CompeteMonth,lookname,lookcode)
						    SELECT @year,@month,a.lookname,a.lookcode FROM j18_lookupsub a
						    WHERE a.lookupid=8005 AND NOT EXISTS(SELECT 1 FROM D_MonthRetailType b 
						    WHERE b.CompeteYear=@year AND b.CompeteMonth=@month AND b.lookname=a.lookname)
						    ORDER BY lookcode asc";
                        SqlParameter[] sp = new SqlParameter[] {
                        new SqlParameter("@year",year),
                        new SqlParameter("@month",month)
                    };
                        app_cn.ExecuteSQL(sql, sp, CommandType.Text);
                        sql = @"SELECT b.lookname,b.loption,ISNULL(b.lookcode,0) lookcode
						    INTO #temp 
						    FROM j18_lookupsub a 
						    INNER JOIN j18_lookupsubsub b on a.lookupid=b.lookupid AND a.lookname=b.lookname
						    WHERE a.lookupid=8005 AND NOT EXISTS(SELECT 1 FROM D_MonthRetailTypeSub c 
                            WHERE c.CompeteYear=@year AND c.CompeteMonth=@month AND c.lookname=b.lookname AND c.loption=b.loption) 
                            ORDER BY b.lookcode ASC,b.loption;

						    INSERT INTO D_MonthRetailTypeSub(CompeteYear,CompeteMonth,lookname,loption,lookcode)
						    SELECT @year,@month,a.lookname,a.loption,a.lookcode FROM #temp a
						    WHERE NOT EXISTS (SELECT 1 FROM D_MonthRetailTypeSub b 
                            WHERE CompeteYear=@year AND CompeteMonth=@month AND a.lookname=b.lookname and a.loption=b.loption)
						    DROP TABLE #temp";
                        app_cn.ExecuteSQL(sql, sp, CommandType.Text);

                        //检查本月当前的数据有没有，如果没有执行计算一次
                        sql = @"select 1 from D_MonthRetail a inner join D_MonthRetailSub b on a.RetailId=b.RetailId 
                        where DepotId=@DepotId and SurveyYear=@SurveyYear and SurveyMonth=@SurveyMonth and b.DayDate=@DayDate and b.Nums<>0";
                        DataTable subdt = app_cn.getTable(sql, new SqlParameter[]{
                            new SqlParameter("@DepotId",app_user.depotid),
                            new SqlParameter("@SurveyYear",DateTime.Now.Year),
                            new SqlParameter("@SurveyMonth",DateTime.Now.Month),
                            new SqlParameter("@DayDate",DateTime.Now.ToString("yyyy-MM-dd 00:00:00"))
                        }, CommandType.Text);
                        if (subdt.Rows.Count <= 0)
                        {
                            //读取数据时先计算当天数据
                            app_cn.ExecuteSQL("F22_Calc_MonthRetail", new SqlParameter[] { 
                                new SqlParameter("@DepotId",app_user.depotid),
                                new SqlParameter("@Date",DateTime.Now.ToString("yyyy-MM-dd 00:00:00")),
                                new SqlParameter("@RepeatCalc","0")
                            }, CommandType.StoredProcedure);
                        }
                    }
                }
                if (dt.Rows.Count > 0 || !string.IsNullOrEmpty(id))
                {
                    DataSet dtset = app_cn.getDataSet("f22qry_MonthRetail", new SqlParameter[] { 
                    new SqlParameter("@depotid",app_user.depotid),
                    new SqlParameter("@year",year),
                    new SqlParameter("@month",month)
                }, CommandType.StoredProcedure);
                    //读取主数据
                    DataTable mainDT = dtset.Tables[0];
                    //读取店铺本月销售数据
                    DataTable RetailDT = dtset.Tables[1];
                    decimal sums = Convert.ToDecimal(RetailDT.Rows[0]["sums"]);
                    int nums = Convert.ToInt32(RetailDT.Rows[0]["nums"]);
                    string jsonSums = "{\"mb\":\"" + jemb.ToString("f2") + "\",\"sums\":\"" + sums.ToString("f2") + "\"}";
                    string jsonNums = "{\"mb\":\"" + slmb.ToString() + "\",\"nums\":\"" + nums.ToString() + "\"}";
                    sbJSON.Append("[");
                    for (int j = 3; j < mainDT.Columns.Count; j++)
                    {
                        columns += mainDT.Columns[j].ColumnName.Replace("\\", "\\\\") + "|";
                    }
                    for (int i = 1; i <= days; i++)
                    {
                        string date = time1.AddDays(i - 1).ToString("yyyy-MM-dd");//当月日期
                        int week = (int)time1.AddDays(i - 1).DayOfWeek;//星期（数字）
                        string weekStr = weekdays[week];//星期（字符）
                        DataRow[] drs = mainDT.Select("DayDate='" + date + "'");
                        string json = "{\"date\":\"" + date + "\",\"week\":\"" + weekStr + "\",";
                        if (drs.Length > 0)
                        {
                            for (int j = 3; j < mainDT.Columns.Count; j++)
                            {
                                json += "\"v_" + (j - 3).ToString() + "\":\"" + drs[0][j] + "\",";
                            }
                        }
                        else
                        {
                            for (int j = 3; j < mainDT.Columns.Count; j++)
                            {
                                json += "\"v_" + (j - 3).ToString() + "\":\"0\",";
                            }
                        }
                        json = json.Trim(',');
                        if (i < days)
                            json += "},";
                        else
                            json += "}";
                        sbJSON.Append(json);
                    }
                    sbJSON.Append("]");
                    context.Response.Write("{\"error\":\"0\",\"id\":\"" + id + "\",\"Chk_Sure\":" + Chk_Sure.ToString() + ",\"columns\":\"" + columns.TrimEnd('|') + "\",\"sums\":" + jsonSums + ",\"nums\":" + jsonNums + ",\"mlist\":" + sbJSON.ToString() + "}");
                }
                else
                {
                    context.Response.Write("{\"error\":\"-2\"}");
                }
            }
            else
            {
                context.Response.Write("{\"error\":\"-1\"}");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":\"1\",\"msg\":\"" + ex.ToString() + "\"}");
        }
    }
    
    /// <summary>
    /// 读取店铺月目标
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <returns></returns>
    private DataTable getMonthRetailGoal(string year,string month)
    {
        DataTable dt = new DataTable();
        string sql = @"select Sums_RetailGoal,(Nums_CxRetailGoal+Nums_QdRetailGoal) Nums_RetailGoal 
                        FROM J_DepotMonthRetailGoal WHERE DepotId=@DepotId AND GoalYear=@GoalYear AND GoalMonth=@GoalMonth";
        dt = app_cn.getTable(sql, new SqlParameter[] { 
                new SqlParameter("@DepotId",app_user.depotid),
               new SqlParameter("@GoalYear",year),
               new SqlParameter("@GoalMonth",month)      
        }, CommandType.Text);
        return dt;
    }

    /// <summary>
    /// 读取店铺月销售明细
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <returns></returns>
    private DataTable getRetail(string year, string month)
    {
        DataTable dt = new DataTable();
        string sql = @"SELECT ISNULL((select SUM(b.Value) from D_DayRetail a INNER JOIN D_DayRetailsub b ON a.RetailId=b.RetailId 
                        WHERE a.DepotId=@DepotId AND a.SurveyYear=@SurveyYear and a.SurveyMonth=@SurveyMonth AND b.TypeSubStr ='销售金额'),0) sums,
                        ISNULL((select SUM(b.Nums) from D_MonthRetail a INNER JOIN D_MonthRetailSub b ON a.RetailId=b.RetailId 
                        WHERE a.DepotId=@DepotId AND a.SurveyYear=@SurveyYear and a.SurveyMonth=@SurveyMonth AND b.TypeStr ='系列数量分布'),0) nums";
        dt = app_cn.getTable(sql, new SqlParameter[] { 
               new SqlParameter("@DepotId",app_user.depotid),
               new SqlParameter("@SurveyYear",year),
               new SqlParameter("@SurveyMonth",month),
              
        }, CommandType.Text);
        return dt;
    }

    /// <summary>
    /// 主表添加一条数据
    /// </summary>
    /// <param name="id"></param>
    /// <param name="year"></param>
    /// <param name="month"></param>
    void CheckedData(string id,string year,string month)
    {
        string sql = @"INSERT INTO D_MonthRetail(RetailId,Retail,DepotId,SurveyYear,SurveyMonth,Cr_Name,Cr_Date) 
                       VALUES('" + id + "','" + id + "','" + app_user.depotid + "'," + year + "," + month + ",'" + app_user.username + "',getdate());";
            app_cn.ExecuteSQL(sql, new SqlParameter[] { }, CommandType.Text);
            //当店铺第一次添加主表数据时先检查1级抬头和2级抬头是否有数据
            //因为1，2级抬头是所有店铺都共用的，所以每家店铺新加数据到主表时都会检查
            //1级
            sql = @"IF NOT EXISTS(SELECT TOP(1) 1 FROM D_MonthRetailType WHERE CompeteYear=@year AND CompeteMonth=@month)
                   BEGIN
						INSERT INTO D_MonthRetailType(CompeteYear,CompeteMonth,lookname,lookcode)
						SELECT @year,@month,a.lookname,a.lookcode FROM j18_lookupsub a
						WHERE a.lookupid=8005 ORDER BY lookcode asc
                   END";
            SqlParameter[] sp=new SqlParameter[] {
                new SqlParameter("@year",year),
                new SqlParameter("@month",month)
            };
            app_cn.ExecuteSQL(sql, sp, CommandType.Text);
            //2级
            sql = @"IF NOT EXISTS(SELECT TOP(1) 1 FROM D_MonthRetailTypeSub WHERE CompeteYear=@year AND CompeteMonth=@month)
					BEGIN
						SELECT b.lookname,b.loption,ISNULL(b.lookcode,0) lookcode
						INTO #temp 
						FROM j18_lookupsub a 
						INNER JOIN j18_lookupsubsub b on a.lookupid=b.lookupid AND a.lookname=b.lookname
						WHERE a.lookupid=8005 ORDER BY b.lookcode ASC,b.loption;

						INSERT INTO D_MonthRetailTypeSub(CompeteYear,CompeteMonth,lookname,loption,lookcode)
						SELECT @year,@month,lookname,loption,lookcode FROM #temp
					END";
            app_cn.ExecuteSQL(sql, sp, CommandType.Text);

            //新增单据时先计算当天数据
            app_cn.ExecuteSQL("F22_Calc_MonthRetail", new SqlParameter[] { 
                new SqlParameter("@DepotId",app_user.depotid),
                new SqlParameter("@Date",DateTime.Now.ToString("yyyy-MM-dd 00:00:00")),
                new SqlParameter("@RepeatCalc","0")
            }, CommandType.StoredProcedure);
    }

    /// <summary>
    /// 更新保存数据
    /// </summary>
    /// <param name="retailid"></param>
    /// <param name="date"></param>
    /// <param name="typestr"></param>
    /// <param name="typesubstr"></param>
    /// <param name="nums"></param>
    void SaveRetail(HttpContext context)
    {
        try
        {
            string retailid = context.Request["retailid"];
            string date = context.Request["date"];
            string typestr = context.Request["typestr"];
            string typesubstr = context.Request["typesubstr"];
            string nums = context.Request["nums"];
            string sql = @"MERGE D_MonthRetailSub as T1
                       USING (select @RetailId RetailId,@DayDate DayDate,@TypeStr TypeStr,@TypeSubStr TypeSubStr,@Nums Nums) as T2
                       ON T1.RetailId=T2.RetailId AND T1.DayDate=T2.DayDate AND T1.TypeStr=T2.TypeStr AND T1.TypeSubStr=T2.TypeSubStr
                       WHEN MATCHED
                       THEN UPDATE  SET T1.Nums=T2.Nums
                       WHEN NOT MATCHED
                       THEN INSERT VALUES(T2.RetailId,T2.DayDate,T2.TypeStr,T2.TypeSubStr,T2.Nums,'');";
            app_cn.ExecuteSQL(sql, new SqlParameter[] {
                new SqlParameter("@RetailId",retailid),
                new SqlParameter("@DayDate",date),
                new SqlParameter("@TypeStr",typestr),
                new SqlParameter("@TypeSubStr",typesubstr),
                new SqlParameter("@Nums",nums)
            }, CommandType.Text);
            context.Response.Write("{\"error\":0,\"msg\":\"\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 审核
    /// </summary>
    /// <param name="context"></param>
    void SureRetail(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];//id
            string sql = "SELECT Sure,Chk_Sure FROM D_MonthRetail where RetailId=@RetailId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                sql = "UPDATE D_MonthRetail SET Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=GETDATE() WHERE RetailId=@RetailId AND DepotId=@DepotId and Chk_Sure=0 and Sure=0";
                SqlParameter[] sp1 = new SqlParameter[]{
                new SqlParameter("@Chk_Sure","1"),
                new SqlParameter("@Chk_Name",app_user.username),
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DepotId",app_user.depotid)
                };
                app_cn.ExecuteSQL(sql, sp1, CommandType.Text);
                context.Response.Write("{\"error\":0,\"msg\":\"\"}");
            }
            else
            {
                context.Response.Write("{\"error\":-1,\"msg\":\"\"}");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 反审核
    /// </summary>
    /// <param name="context"></param>
    void unSureRetail(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];//id
            string sql = "SELECT Sure,Chk_Sure FROM D_MonthRetail where RetailId=@RetailId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                sql = "UPDATE D_MonthRetail SET Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=GETDATE() WHERE RetailId=@RetailId AND DepotId=@DepotId and Chk_Sure=1 and Sure=0";
                SqlParameter[] sp1 = new SqlParameter[]{
                new SqlParameter("@Chk_Sure","0"),
                new SqlParameter("@Chk_Name",app_user.username),
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DepotId",app_user.depotid)
                };
                app_cn.ExecuteSQL(sql, sp1, CommandType.Text);
                context.Response.Write("{\"error\":0,\"msg\":\"\"}");
            }
            else
            {
                context.Response.Write("{\"error\":-1,\"msg\":\"\"}");
                
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 计算当天数据
    /// </summary>
    /// <param name="context"></param>
    void OnCount(HttpContext context)
    {
        try
        {
            string date = context.Request["date"];
            string re = context.Request["re"];
            if (DateTime.Now.ToString("yyyy-MM-01") == DateTime.Parse(date).ToString("yyyy-MM-01"))
            {
                app_cn.ExecuteSQL("F22_Calc_MonthRetail", new SqlParameter[] { 
                    new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@Date",date),
                    new SqlParameter("@RepeatCalc",re)
                }, CommandType.StoredProcedure);
                context.Response.Write("{\"error\":0,\"msg\":\"\"}");
            }
            else
            {
                context.Response.Write("{\"error\":-1,\"msg\":\"\"}");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}