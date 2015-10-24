<%@ WebHandler Language="C#" Class="XsMb" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class XsMb : IHttpHandler, System.Web.SessionState.IRequiresSessionState{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string Str_act = context.Request["act"];
        if (Str_act == "getXsMbDay")
        {
            getXsMbDay(context);
        }
        else if (Str_act == "SaveDayGoal")
        {
            SaveDayGoal(context);
        }
        else if (Str_act == "SureDayGoal")
        {
            SureDayGoal(context);
        }
        else if (Str_act == "unSureDayGoal")
        {
            unSureDayGoal(context);
        }
        else if (Str_act == "getXsMbEmployee")
        {
            getXsMbEmployee(context);
        }
        else if (Str_act == "SaveEmployeeGoal")
        {
            SaveEmployeeGoal(context);
        }
        else if (Str_act == "SureEmployeeGoal")
        {
            SureEmployeeGoal(context);
        }
        else if (Str_act == "unSureEmployeeGoal")
        {
            unSureEmployeeGoal(context);
        }
    }
    
    /// <summary>
    /// 获取日销售数据
    /// </summary>
    /// <param name="context"></param>
    void getXsMbDay(HttpContext context)
    {
        string[] weekdays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
        string Str_Year = context.Request["year"];//年份
        string Str_Month = context.Request["month"];//月份
        //读取店铺月销售目标
        DataTable dt = getMonthGoal(Str_Year, Str_Month);
        string Str_Json = "";
        if (dt.Rows.Count > 0)
        {
            string dw = "元";
            DateTime time = DateTime.Parse(Str_Year + "-" + Str_Month + "-01");//本月1号
            DateTime time1 = DateTime.Parse(Str_Year + "-" + Str_Month + "-01").AddMonths(1);//下月1号
            TimeSpan ts = time1 - time;//计算时间差
            int days = ts.Days;//2个月相差天数
            DataTable subdt = getDayGoal(Str_Year, Str_Month);

            if (subdt.Rows.Count <= 0)
            {
                if (DateTime.Now.Year == int.Parse(Str_Year) && DateTime.Now.Month == int.Parse(Str_Month))
                {
                    //如果没有录入日销售目标时要先录入
                    InsertDefaultData(Convert.ToDouble(dt.Rows[0]["Sums_RetailGoal"]), Str_Year, Str_Month, days, 0, ref subdt);
                }
            }
            if (subdt.Rows.Count > 0)
            {
                foreach (DataRow dr in subdt.Rows)
                {
                    DateTime t = Convert.ToDateTime(dr["DayDate"]);
                    string Str_Day = t.Month.ToString().PadLeft(2, '0') + "月" + t.Day.ToString().PadLeft(2, '0') + "日";//日期
                    int Int_week = (int)t.DayOfWeek;//星期几的数字形式
                    string Str_week = weekdays[Int_week];//星期字符形式
                    double Dec_Mb = Convert.ToDouble(dr["Sums_RetailGoal"]);
                    string Str_id = t.Year + "-" + t.Month + "-" + t.Day;
                    Str_Json += "{\"day\":\"" + Str_Day + "\",\"week\":\"" + Str_week + "\",\"goal\":\"" + Dec_Mb.ToString("f2") + "\",\"id\":\"" + dr["DayGoalId"].ToString() + "\",\"date\":\"" + Str_id + "\"},";
                }
                context.Response.Write("{\"msg\":1,\"chksure\":" + subdt.Rows[0]["Chk_Sure"].ToString() + ",\"totalgoal\":" + dt.Rows[0]["Sums_RetailGoal"].ToString() + ",\"dw1\":0,\"dw\":\"" + dw + "\",\"list\":[" + Str_Json.Trim(',') + "]}");
            }
            else
            {
                context.Response.Write("{\"msg\":-1,\"list\":null}");
            }
        }
        else
        {
            context.Response.Write("{\"msg\":0,\"list\":null}");
        }
    } 
    
    /// <summary>
    /// 读取店铺月销售目标
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <returns></returns>
    private DataTable getMonthGoal(string year,string month)
    {
        DataTable dt = new DataTable();
        string sql = @"select Sums_RetailGoal FROM J_DepotMonthRetailGoal WHERE DepotId=@DepotId AND GoalYear=@GoalYear AND GoalMonth=@GoalMonth";
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@DepotId",app_user.depotid),
            new SqlParameter("@GoalYear",year),
            new SqlParameter("@GoalMonth",month)
        };
        dt = app_cn.getTable(sql, sp, CommandType.Text);
        return dt;
    }

    /// <summary>
    /// 读取店铺日销售目标
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <returns></returns>
    private DataTable getDayGoal(string year, string month)
    {
        DataTable dt = new DataTable();
        string sql = @"select a.Chk_Sure,b.DayGoalId,b.Sums_RetailGoal,b.DayDate FROM D_DayRetailGoal a INNER JOIN D_DayRetailGoalSub b 
                        ON a.DayGoalId=b.DayGoalId  WHERE a.DepotId=@DepotId AND a.GoalYear=@GoalYear AND a.GoalMonth=@GoalMonth ORDER BY b.DayDate ASC";
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@DepotId",app_user.depotid),
            new SqlParameter("@GoalYear",year),
            new SqlParameter("@GoalMonth",month)
        };
        dt = app_cn.getTable(sql, sp, CommandType.Text);
        return dt;
    }

    /// <summary>
    /// 店铺第一次读取月销售标时把数据添加到日销售目标表
    /// </summary>
    private void InsertDefaultData(double Sums_RetailGoal, string year, string month, int days, int billtype,ref DataTable dt)
    {
        int r = 0;
        int Int_Dmb = (int)(Sums_RetailGoal / days);//通过月目标除以月天数得出日目标
        double D_sums = Sums_RetailGoal % days;//得出余数
        string id = "XS" + app_user.userid + "-" + year + "-" + month.PadLeft(2, '0') + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0') + "-0001";
        string sql = @"INSERT INTO D_DayRetailGoal(DayGoalId,DayGoal,DepotId,GoalYear,GoalMonth,Cr_Name,Cr_Date) 
                        VALUES('" + id + "','" + id + "','" + app_user.depotid + "'," + year + "," + month + ",'" + app_user.username + "',getdate());";
        string Str_UpdFile = billtype == 0 ? "Sums_RetailGoal" : "Nums_RetailGoal";
        for (int i = 1; i <= days; i++)
        {
            string Str_date = year + "-" + month + "-" + i.ToString();
            double sums = i == days ? ((double)Int_Dmb + D_sums) : Int_Dmb;
            sql += "INSERT INTO D_DayRetailGoalSub(DayGoalId,DayDate," + Str_UpdFile + ",Comment) ";
            sql += "VALUES('" + id + "','" + Str_date + "',0,'');";
        }

        r = app_cn.ExecuteSQL(sql, new SqlParameter[] { }, CommandType.Text);
        //添加完数据后返回DataTable
        dt = getDayGoal(year, month);
    }

    /// <summary>
    /// 保存日销售数据
    /// </summary>
    /// <param name="context"></param>
    void SaveDayGoal(HttpContext context)
    {
        try
        {
            string date = context.Request["date"];//日期
            string id = context.Request["id"];
            string goal = context.Request["goal"];//金额
            string billtype = context.Request["billtype"];
            string updfile = billtype == "0" ? "Sums_RetailGoal" : "Nums_RetailGoal";
            string sql = "UPDATE D_DayRetailGoalSub SET " + updfile + "=@value where DayGoalId=@DayGoalId and DayDate=@DayDate";
            SqlParameter[] sp = new SqlParameter[] {
                new SqlParameter("@value",goal),
                new SqlParameter("@DayGoalId",id),
                new SqlParameter("@DayDate",date)
            };
            app_cn.ExecuteSQL(sql, sp, CommandType.Text);
            context.Response.Write("{\"error\":0,\"msg\":\"\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 审核日销售目标单据
    /// </summary>
    /// <param name="context"></param>
    void SureDayGoal(HttpContext context)
    {
        string id = context.Request["id"];//id
        string year = context.Request["year"];//年份
        string month = context.Request["month"];//月份
        string billtype = context.Request["billtype"];
        try
        {
            string sql = "SELECT Sure,Chk_Sure FROM D_DayRetailGoal where DayGoalId=@DayGoalId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@DayGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                DataTable monthdt = getMonthGoal(year, month);//读取店铺月销售目标
                double monthgoal = Convert.ToDouble(monthdt.Rows[0]["Sums_RetailGoal"]);
                string updfile = billtype == "0" ? "Sums_RetailGoal" : "Nums_RetailGoal";
                sql = "select SUM(" + updfile + ") as Sums_RetailGoal from D_DayRetailGoalSub where DayGoalId=@DayGoalId";
                SqlParameter[] sp = new SqlParameter[]{
            new SqlParameter("@DayGoalId",id)
        };
                DataTable daydt = app_cn.getTable(sql, sp, CommandType.Text);
                double daygoal = Convert.ToDouble(daydt.Rows[0]["Sums_RetailGoal"]);
                //判断当月的日销售目标合计是否大于设置的月销售目标
                if (daygoal >= monthgoal)
                {
                    sql = "UPDATE D_DayRetailGoal SET Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=GETDATE() WHERE DayGoalId=@DayGoalId AND DepotId=@DepotId and Chk_Sure=0 and Sure=0";
                    SqlParameter[] sp1 = new SqlParameter[]{
                new SqlParameter("@Chk_Sure",1),
                new SqlParameter("@Chk_Name",app_user.username),
                new SqlParameter("@DayGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            };
                    app_cn.ExecuteSQL(sql, sp1, CommandType.Text);
                    context.Response.Write("{\"error\":0,\"msg\":\"\"}");
                }
                else
                {
                    context.Response.Write("{\"error\":-1,\"msg\":\"" + daygoal + "\"}");
                }
            }
            else
            {
                context.Response.Write("{\"error\":-2,\"msg\":\"sure\"}");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 反审核日销售目标单据
    /// </summary>
    /// <param name="context"></param>
    private void unSureDayGoal(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];//id
            string sql = "SELECT Sure,Chk_Sure FROM D_DayRetailGoal where DayGoalId=@DayGoalId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@DayGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure ==0)
            {
                sql = "UPDATE D_DayRetailGoal SET Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=GETDATE() WHERE DayGoalId=@DayGoalId AND DepotId=@DepotId and Chk_Sure=1";
                SqlParameter[] sp1 = new SqlParameter[]{
                new SqlParameter("@Chk_Sure","0"),
                new SqlParameter("@Chk_Name",app_user.username),
                new SqlParameter("@DayGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
                };
                app_cn.ExecuteSQL(sql, sp1, CommandType.Text);
                context.Response.Write("{\"error\":0,\"msg\":\"\"}");
            }
            else
            {
                context.Response.Write("{\"error\":-1,\"msg\":\"sure=1\"}");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    //*****************************************************************************************************//
    /// <summary>
    /// 获取店铺营业员
    /// </summary>
    /// <returns></returns>
    private DataTable getEmployee()
    {
        DataTable dt = new DataTable();
        string sql = "SELECT a.employeeid,a.names FROM j_employee a WHERE isnull(a.valid,0)=0 and a.depotid=@depotid";
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@depotid",app_user.depotid)
        };
        dt = app_cn.getTable(sql, sp, CommandType.Text);
        return dt;
    }

    /// <summary>
    /// 获取营业员销售数据
    /// </summary>
    /// <param name="context"></param>
    void getXsMbEmployee(HttpContext context)
    {
        string Str_Year = context.Request["year"];//年份
        string Str_Month = context.Request["month"];//月份
        //读取店铺月销售目标
        DataTable dt = getMonthGoal(Str_Year, Str_Month);
        string Str_Json = "";
        if (dt.Rows.Count > 0)
        {
            string dw = "元";
            string sql = @"SELECT 1 FROM D_EmployeeRetailGoal 
                           WHERE DepotId=@DepotId AND GoalYear=@GoalYear AND GoalMonth=@GoalMonth";
            DataTable xdt = app_cn.getTable(sql, new SqlParameter[] { 
                new SqlParameter("@DepotId",app_user.depotid),
                new SqlParameter("@GoalYear",Str_Year),
                new SqlParameter("@GoalMonth",Str_Month)
            }, CommandType.Text);
            
            DataTable subdt = new DataTable();
            if (xdt.Rows.Count <= 0)
            {
                //如果没有录入营业员销售目标时要先录入
                if (DateTime.Now.Year == int.Parse(Str_Year) && DateTime.Now.Month == int.Parse(Str_Month))
                {
                    DataTable employeedt = getEmployee();
                    InsertEmployee(Convert.ToDouble(dt.Rows[0]["Sums_RetailGoal"]), Str_Year, Str_Month, employeedt, 0, ref subdt);
                }
            }
            else
            {
                subdt = getEmployeeGoal(Str_Year, Str_Month);
            }
            if (subdt.Rows.Count > 0)
            {
                foreach (DataRow dr in subdt.Rows)
                {
                    double Dec_Mb = Convert.ToDouble(dr["Sums_RetailGoal"]);
                    Str_Json += "{\"employeeid\":\"" + dr["employeeid"].ToString() + "\",\"names\":\"" + dr["names"].ToString() + "\",\"goal\":\"" + Dec_Mb.ToString("f2") + "\",\"id\":\"" + dr["EmployeeGoalId"].ToString() + "\"},";
                }
                context.Response.Write("{\"msg\":1,\"chksure\":" + subdt.Rows[0]["Chk_Sure"].ToString() + ",\"totalgoal\":" + dt.Rows[0]["Sums_RetailGoal"].ToString() + ",\"dw1\":0,\"dw\":\"" + dw + "\",\"list\":[" + Str_Json.Trim(',') + "]}");
            }
            else
            {
                context.Response.Write("{\"msg\":-1,\"list\":null}");
            }
        }
        else
        {
            context.Response.Write("{\"msg\":0,\"list\":null}");
        }
    }

    /// <summary>
    /// 读取营业员销售目标
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <returns></returns>
    private DataTable getEmployeeGoal(string year, string month)
    {
        DataTable dt = new DataTable();
        string sql = "";
        if (DateTime.Now.Year == int.Parse(year) && DateTime.Now.Month == int.Parse(month))
        {
             sql = @"SELECT t2.EmployeeGoalId,t1.employeeid,t1.names,ISNULL(t2.Sums_RetailGoal,0) Sums_RetailGoal,ISNULL(t2.Chk_Sure,0) Chk_Sure 
                    FROM j_employee t1 LEFT JOIN ( SELECT a.EmployeeGoalId,c.employeeid,a.DepotId,b.Sums_RetailGoal,a.Chk_Sure 
                    FROM D_EmployeeRetailGoal a INNER JOIN D_EmployeeRetailGoalSub b ON a.EmployeeGoalId=b.EmployeeGoalId
                    INNER JOIN j_employee c ON a.DepotId=c.depotid AND b.EmployeeId=c.employeeid
                    WHERE a.DepotId=@DepotId AND a.GoalYear=@GoalYear AND a.GoalMonth=@GoalMonth AND isnull(c.valid,0)=0 ) t2 
                    ON t1.depotid=t2.DepotId and t1.employeeid=t2.employeeid WHERE t1.DepotId=@DepotId AND isnull(t1.valid,0)=0 
                    ORDER BY groupid,t1.employeeid";
        }
        else
        {
             sql = @" SELECT a.EmployeeGoalId,c.employeeid,c.names,b.Sums_RetailGoal,a.Chk_Sure 
                    FROM D_EmployeeRetailGoal a INNER JOIN D_EmployeeRetailGoalSub b ON a.EmployeeGoalId=b.EmployeeGoalId
                    INNER JOIN j_employee c ON a.DepotId=c.depotid AND b.EmployeeId=c.employeeid
                    WHERE a.DepotId=@DepotId AND a.GoalYear=@GoalYear AND a.GoalMonth=@GoalMonth  
                    ORDER BY c.groupid,c.employeeid ";
        }
        SqlParameter[] sp = new SqlParameter[] { 
            new SqlParameter("@DepotId",app_user.depotid),
            new SqlParameter("@GoalYear",year),
            new SqlParameter("@GoalMonth",month)
        };
        dt = app_cn.getTable(sql, sp, CommandType.Text);
        return dt;
    }

    /// <summary>
    /// 店铺第一次读取月销售标时把数据添加到营业员销售目标表
    /// </summary>
    private void InsertEmployee(double Sums_RetailGoal, string year, string month, DataTable Employee, int billtype, ref DataTable dt)
    {
        int r = 0;
        int Int_Dmb = (int)(Sums_RetailGoal / Employee.Rows.Count);//通过月目标除以营业员人数得出营业员目标
        double D_sums = Sums_RetailGoal % Employee.Rows.Count;//得出余数
        string id = "XE" + app_user.userid + "-" + year + "-" + month.PadLeft(2, '0') + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0') + "-0001";
        string sql = @"INSERT INTO D_EmployeeRetailGoal(EmployeeGoalId,EmployeeGoal,DepotId,GoalYear,GoalMonth,Cr_Name,Cr_Date) 
                        VALUES('" + id + "','" + id + "','" + app_user.depotid + "'," + year + "," + month + ",'" + app_user.username + "',getdate());";
        string Str_UpdFile = billtype == 0 ? "Sums_RetailGoal" : "Nums_RetailGoal";
        int i = 1;
        foreach (DataRow dr in Employee.Rows)
        {
            double sums = i == Employee.Rows.Count ? ((double)Int_Dmb + D_sums) : Int_Dmb;
            sql += "INSERT INTO D_EmployeeRetailGoalSub(EmployeeGoalId,EmployeeId," + Str_UpdFile + ",Comment) ";
            sql += "VALUES('" + id + "','" + dr["employeeid"].ToString() + "',0,'');";
            i++;
        }
        r = app_cn.ExecuteSQL(sql, new SqlParameter[] { }, CommandType.Text);
        //添加完数据后返回DataTable
        dt = getEmployeeGoal(year, month);
    }

    /// <summary>
    /// 保存营业员销售数据
    /// </summary>
    /// <param name="context"></param>
    void SaveEmployeeGoal(HttpContext context)
    {
        try
        {
            string employeeid = context.Request["employeeid"];//日期
            string id = context.Request["id"];
            string goal = context.Request["goal"];//金额
            string billtype = context.Request["billtype"];
            string updfile = billtype == "0" ? "Sums_RetailGoal" : "Nums_RetailGoal";
            string sql = @"MERGE D_EmployeeRetailGoalSub as T1
                           using (select '" + id + "' as EmployeeGoalId,'" + employeeid + "' ermloyeeid," + goal + @" Sums_RetailGoal ) as T2
                           ON T1.EmployeeGoalId=t2.EmployeeGoalId AND T1.EmployeeId=t2.ermloyeeid
                           WHEN MATCHED THEN
                           UPDATE SET T1.Sums_RetailGoal =T2.Sums_RetailGoal 
                           when not MATCHED 
                           THEN INSERT(EmployeeGoalId,EmployeeId," + updfile + ") VALUES(T2.EmployeeGoalId,T2.ermloyeeid,T2.Sums_RetailGoal);";
            app_cn.ExecuteSQL(sql, new SqlParameter[] { }, CommandType.Text);
            context.Response.Write("{\"error\":0,\"msg\":\"\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 审核营业员销售目标单据
    /// </summary>
    /// <param name="context"></param>
    void SureEmployeeGoal(HttpContext context)
    {
        string id = context.Request["id"];//id
        string year = context.Request["year"];//年份
        string month = context.Request["month"];//月份
        string billtype = context.Request["billtype"];
        try
        {
            string sql = "SELECT Sure,Chk_Sure FROM D_EmployeeRetailGoal where EmployeeGoalId=@EmployeeGoalId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@EmployeeGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                DataTable monthdt = getMonthGoal(year, month);//读取店铺月销售目标
                double monthgoal = Convert.ToDouble(monthdt.Rows[0]["Sums_RetailGoal"]);
                string updfile = billtype == "0" ? "Sums_RetailGoal" : "Nums_RetailGoal";
                sql = @"select ISNULL(SUM(" + updfile + @"),0) as Sums_RetailGoal from D_EmployeeRetailGoal a 
                           INNER JOIN D_EmployeeRetailGoalSub b ON a.EmployeeGoalId=b.EmployeeGoalId INNER JOIN j_employee c 
                           ON a.DepotId=c.depotid AND b.EmployeeId=c.employeeid 
                           WHERE a.DepotId=@DepotId AND a.EmployeeGoalId=@EmployeeGoalId AND isnull(c.valid,0)=0";
                SqlParameter[] sp = new SqlParameter[]{
                new SqlParameter("@EmployeeGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            };
                DataTable daydt = app_cn.getTable(sql, sp, CommandType.Text);
                double daygoal = Convert.ToDouble(daydt.Rows[0]["Sums_RetailGoal"]);
                //判断当月的营业员销售目标合计是否大于设置的月销售目标
                if (daygoal >= monthgoal)
                {
                    sql = "UPDATE D_EmployeeRetailGoal SET Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=GETDATE() WHERE EmployeeGoalId=@EmployeeGoalId AND DepotId=@DepotId and Chk_Sure=0 and Sure=0";
                    SqlParameter[] sp1 = new SqlParameter[]{
                new SqlParameter("@Chk_Sure",1),
                new SqlParameter("@Chk_Name",app_user.username),
                new SqlParameter("@EmployeeGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            };
                    app_cn.ExecuteSQL(sql, sp1, CommandType.Text);
                    context.Response.Write("{\"error\":0,\"msg\":\"\"}");
                }
                else
                {
                    context.Response.Write("{\"error\":-1,\"msg\":\"" + daygoal + "\"}");
                }
            }
            else
            {
                context.Response.Write("{\"error\":-2,\"msg\":\"sure\"}");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 反审核营业员销售目标单据
    /// </summary>
    /// <param name="context"></param>
    private void unSureEmployeeGoal(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];//id
            string sql = "SELECT Sure,Chk_Sure FROM D_EmployeeRetailGoal where EmployeeGoalId=@EmployeeGoalId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@EmployeeGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                sql = "UPDATE D_EmployeeRetailGoal SET Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=GETDATE() WHERE EmployeeGoalId=@EmployeeGoalId AND DepotId=@DepotId and Chk_Sure=1 and Sure=0";
                SqlParameter[] sp1 = new SqlParameter[]{
                new SqlParameter("@Chk_Sure","0"),
                new SqlParameter("@Chk_Name",app_user.username),
                new SqlParameter("@EmployeeGoalId",id),
                new SqlParameter("@DepotId",app_user.depotid)
                };
                app_cn.ExecuteSQL(sql, sp1, CommandType.Text);
                context.Response.Write("{\"error\":0,\"msg\":\"\"}");
            }
            else
            {
                context.Response.Write("{\"error\":-1,\"msg\":\"sure\"}");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }
    
    public bool IsReusable
    {
        get {
            return false;
        }
    }

}