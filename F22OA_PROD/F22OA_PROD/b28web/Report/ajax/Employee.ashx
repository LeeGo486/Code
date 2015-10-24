<%@ WebHandler Language="C#" Class="Employee" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public class Employee : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string act=context.Request["act"];
        if (act == "EmployeeRegister")
        {
            EmployeeRegister(context);
        }
        else if (act == "SaveData")
        {
            SaveData(context);
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
    /// 读取每日营业员销售登记表记录
    /// </summary>
    /// <param name="context"></param>
    void EmployeeRegister(HttpContext context)
    {
        try
        {
            string[] weekdays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
            string year = context.Request["year"];//年份
            string month = context.Request["month"];//月份
            //读取月目标设置
            DataTable goalDT = getMonthRetailGoal(year, month);
            DateTime time1 = DateTime.Parse(year + "-" + month + "-" + "1");//当月1号
            DateTime time2 = DateTime.Parse(year + "-" + month + "-" + "1").AddMonths(1);//下个月1号
            string dt1 = time1.ToString("yyyy-MM-dd 00:00:00");//查询销售明细开始时间
            string dt2 = time2.ToString("yyyy-MM-dd 00:00:00");//查询销售明细结束时间
            TimeSpan ts = time2 - time1;//计算时间差
            int days = ts.Days;//2个月相差天数
            
            string id = "";
            //金额目标
            decimal jemb = 0;
            if (goalDT.Rows.Count > 0)
            {
                jemb = Convert.ToDecimal(goalDT.Rows[0]["Sums_RetailGoal"]);
            }

            //取数据前先检查一次数据
            int Chk_Sure = 0;
            string sql = "select RetailId,Chk_Sure from D_DayRetail where DepotId=@DepotId and SurveyYear=@SurveyYear and SurveyMonth=@SurveyMonth";
            DataTable dt = app_cn.getTable(sql, new SqlParameter[]{
                    new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@SurveyYear",year),
                    new SqlParameter("@SurveyMonth",month)
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
                    //如果是查询当月时，检查看看有没有新的营业员，如果有就加去记录表
                    sql = @"INSERT INTO D_DayRetailEmployee(RetailId,employeeid,names,groupid)
                SELECT @RetailId,a.employeeid,a.names,a.groupid FROM j_employee a 
                WHERE a.depotid=@depotid AND isnull(a.valid,0)=0
                AND NOT EXISTS (SELECT 1 FROM D_DayRetailEmployee b WHERE b.RetailId=@RetailId AND b.employeeid=a.employeeid)
                ORDER BY a.groupid";
                    app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                    new SqlParameter("@RetailId",id),
                    new SqlParameter("@depotid",app_user.depotid)
                }, CommandType.Text);

                    //如果是查询当月时,检查当然是否有新加2级抬头是记录表没有的，没有的就加上
                    sql = @"INSERT INTO D_DayRetailEmployeeTitle(CompeteYear,CompeteMonth,lookname,lookcode)
	                    SELECT @year,@month,a.lookname,a.lookcode FROM j18_lookupsub a 
	                    where a.lookupid='4006' AND NOT EXISTS(SELECT 1 FROM D_DayRetailEmployeeTitle b WHERE b.CompeteYear=@year 
	                    AND b.CompeteMonth=@month AND a.lookname=b.lookname) ORDER BY a.lookcode";
                    app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                        new SqlParameter("@year",year),
                        new SqlParameter("@month",month)
                    }, CommandType.Text);

                    //读取子表是否有当天的数据
                    sql = @"select 1 from D_DayRetail a 
                    INNER JOIN D_DayRetailSub b ON a.RetailId=b.RetailId 
                    where DepotId=@DepotId and SurveyYear=@SurveyYear and SurveyMonth=@SurveyMonth 
                    AND b.DayDate=@DayDate and b.Value<>0";
                    DataTable subdt = app_cn.getTable(sql, new SqlParameter[]{
                        new SqlParameter("@DepotId",app_user.depotid),
                        new SqlParameter("@SurveyYear",DateTime.Now.Year),
                        new SqlParameter("@SurveyMonth",DateTime.Now.Month),
                        new SqlParameter("@DayDate",DateTime.Now.ToString("yyyy-MM-dd 00:00:00"))
                    }, CommandType.Text);

                    if (subdt.Rows.Count <= 0)
                    {
                        //没有当天的数据就生成当天的数据
                        app_cn.ExecuteSQL("F22_Calc_DayRetail", new SqlParameter[] { 
                            new SqlParameter("@DepotId",app_user.depotid),
                            new SqlParameter("@Date",DateTime.Now.ToString("yyyy-MM-dd 00:00:00")),
                            new SqlParameter("@RepeatCalc","0")
                        }, CommandType.StoredProcedure);
                    }
                }
            }
            if (dt.Rows.Count > 0 || !string.IsNullOrEmpty(id))
            {
                DataSet dtSet = app_cn.getDataSet("f22qry_DayRetail", new SqlParameter[] { 
                new SqlParameter("@id",id),
                new SqlParameter("@depotid",app_user.depotid),
                new SqlParameter("@year",year),
                new SqlParameter("@month",month),
                new SqlParameter("@days",days)
            }, CommandType.StoredProcedure);

                //营业员表
                DataTable employeeDT = dtSet.Tables[0];
                //二级抬头表
                DataTable headDT = dtSet.Tables[1];
                //营业员销售登数据
                DataTable mainDT = dtSet.Tables[2];
                string employeeJSON = app_tools.dtjson(employeeDT);//营业员列表
                string headJSON = app_tools.dtjson(headDT);//抬头列表
                StringBuilder mainJSON = new StringBuilder();
                mainJSON.Append("[ ");

                for (int i = 0; i < mainDT.Rows.Count; i++)
                {
                    DateTime date = Convert.ToDateTime(mainDT.Rows[i]["dates"]);//当月日期
                    string d = date.Month + "月" + date.Day + "日";
                    int week = (int)date.DayOfWeek;//星期（数字）
                    string weekStr = weekdays[week];//星期（字符）
                    mainJSON.Append("{ ");
                    mainJSON.Append("\"date\":\"" + d + "\",\"week\":\"" + weekStr + "\",\"d\":\"" + date.ToString("yyyy-MM-dd") + "\",");
                    for (int j = 1; j < mainDT.Columns.Count; j++)
                    {
                        if (j < mainDT.Columns.Count - 1)
                        {
                            mainJSON.Append("\"" + mainDT.Columns[j].ColumnName.ToString() + "\":" + "\"" + mainDT.Rows[i][j].ToString().Replace("\\","\\\\") + "\",");
                        }
                        else if (j == mainDT.Columns.Count - 1)
                        {
                            mainJSON.Append("\"" + mainDT.Columns[j].ColumnName.ToString() + "\":" + "\"" + mainDT.Rows[i][j].ToString().Replace("\\", "\\\\") + "\"");
                        }
                    }
                    if (i == mainDT.Rows.Count - 1)
                    {
                        mainJSON.Append("} ");
                    }
                    else
                    {
                        mainJSON.Append("}, ");
                    }
                }
                mainJSON.Append("]");
                context.Response.Write("{\"error\":\"0\",\"goal\":" + jemb.ToString("f2") + ",\"id\":\"" + id + "\",\"chkSure\":" + Chk_Sure.ToString() + ",\"employee\":" + employeeJSON.TrimEnd(';') + ",\"head\":" + headJSON.TrimEnd(';') + ",\"main\":" + mainJSON.ToString() + "}");
                //}
                //else
                //{
                //    context.Response.Write("{\"error\":\"-1\",\"msg\":\"\"}");
                //}
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
    /// 读取店铺月目标
    /// </summary>
    /// <param name="year"></param>
    /// <param name="month"></param>
    /// <returns></returns>
    private DataTable getMonthRetailGoal(string year, string month)
    {
        DataTable dt = new DataTable();
        string sql = @"select Sums_RetailGoal FROM J_DepotMonthRetailGoal WHERE DepotId=@DepotId AND GoalYear=@GoalYear AND GoalMonth=@GoalMonth";
        dt = app_cn.getTable(sql, new SqlParameter[] { 
                new SqlParameter("@DepotId",app_user.depotid),
               new SqlParameter("@GoalYear",year),
               new SqlParameter("@GoalMonth",month)
               
        }, CommandType.Text);
        return dt;
    }

    /// <summary>
    /// 主表添加一条数据
    /// </summary>
    /// <param name="id"></param>
    /// <param name="year"></param>
    /// <param name="month"></param>
    void CheckedData(string id, string year, string month)
    {
        string sql = @"INSERT INTO D_DayRetail(RetailId,Retail,DepotId,SurveyYear,SurveyMonth,Cr_Name,Cr_Date) 
                       VALUES('" + id + "','" + id + "','" + app_user.depotid + "'," + year + "," + month + ",'" + app_user.username + "',getdate());";
        app_cn.ExecuteSQL(sql, new SqlParameter[] { }, CommandType.Text);

        //第一次查询本月数据时把营业员添加到营业员记录表
        sql = @"INSERT INTO D_DayRetailEmployee(RetailId,employeeid,names,groupid)
                SELECT @RetailId,a.employeeid,a.names,a.groupid FROM j_employee a 
                WHERE a.depotid=@depotid AND isnull(a.valid,0)=0
                AND NOT EXISTS (SELECT 1 FROM D_DayRetailEmployee b WHERE b.RetailId=@RetailId AND b.employeeid=a.employeeid)
                ORDER BY a.groupid";
        app_cn.ExecuteSQL(sql, new SqlParameter[] { 
            new SqlParameter("@RetailId",id),
            new SqlParameter("@depotid",app_user.depotid)
        }, CommandType.Text);
        
        //把营业员登记表的2级抬头添加到记录表
        sql = @"IF NOT EXISTS(SELECT TOP(1) 1 FROM D_DayRetailEmployeeTitle WHERE CompeteYear=@year AND CompeteMonth=@month)
                BEGIN
	                INSERT INTO D_DayRetailEmployeeTitle(CompeteYear,CompeteMonth,lookname,lookcode)
	                SELECT @year,@month,a.lookname,a.lookcode FROM j18_lookupsub a 
	                where a.lookupid='4006' ORDER BY a.lookcode
                END";
        app_cn.ExecuteSQL(sql, new SqlParameter[] { 
            new SqlParameter("@year",year),
            new SqlParameter("@month",month)
        }, CommandType.Text);

        //新增单据数据生成当天的数据
        app_cn.ExecuteSQL("F22_Calc_DayRetail", new SqlParameter[] { 
            new SqlParameter("@DepotId",app_user.depotid),
            new SqlParameter("@Date",DateTime.Now.ToString("yyyy-MM-dd 00:00:00")),
            new SqlParameter("@RepeatCalc","0")
        }, CommandType.StoredProcedure);
    }

    /// <summary>
    /// 保存数据
    /// </summary>
    /// <param name="content"></param>
    void SaveData(HttpContext context)
    {
        string type = context.Request["type"];
        string id = context.Request["id"];
        string date = context.Request["date"];
        string employeeid = context.Request["employeeid"];
        string typesubstr = context.Request["typesubstr"];
        string value = context.Request["value"];
        string sql = "";
        try
        {
            if (type == "num")
            {
                //修改营业员销售情况
                sql = @"MERGE D_DayRetailSub as T1
                       USING (select @RetailId RetailId,@DayDate DayDate,@employeeid employeeid,@TypeSubStr TypeSubStr,@value value) as T2
                       ON T1.RetailId=T2.RetailId AND T1.DayDate=T2.DayDate AND T1.employeeid=T2.employeeid AND T1.TypeSubStr=T2.TypeSubStr
                       WHEN MATCHED
                       THEN UPDATE  SET T1.value=T2.value
                       WHEN NOT MATCHED
                       THEN INSERT VALUES(T2.RetailId,T2.DayDate,'',0,T2.employeeid,T2.TypeSubStr,T2.value,'');";
                app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                new SqlParameter("@value",value),
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DayDate",date),
                new SqlParameter("@employeeid",employeeid),
                new SqlParameter("@TypeSubStr",typesubstr)
            }, CommandType.Text);
            }
            else if (type == "zk")
            {
                //修改折扣
                sql = @"MERGE D_DayRetailSub as T1
                       USING (select @RetailId RetailId,@DayDate DayDate ,@value value) as T2
                       ON T1.RetailId=T2.RetailId AND T1.DayDate=T2.DayDate
                       WHEN MATCHED
                       THEN UPDATE  SET T1.ActivityDis=T2.value
                       WHEN NOT MATCHED
                       THEN INSERT VALUES(T2.RetailId,T2.DayDate,'',T2.value,'','',0,'');";
                app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                new SqlParameter("@value",value),
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DayDate",date)
            }, CommandType.Text);
            }
            else if (type == "tq")
            {
                //修改天气
                sql = @"MERGE D_DayRetailSub as T1
                       USING (select @RetailId RetailId,@DayDate DayDate ,@value value) as T2
                       ON T1.RetailId=T2.RetailId AND T1.DayDate=T2.DayDate 
                       WHEN MATCHED
                       THEN UPDATE  SET T1.Weather=T2.value
                       WHEN NOT MATCHED
                       THEN INSERT VALUES(T2.RetailId,T2.DayDate,T2.value,0,'','',0,'');";
                app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                new SqlParameter("@value",value),
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DayDate",date)
            }, CommandType.Text);

            }
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
            string sql = "SELECT Sure,Chk_Sure FROM D_DayRetail where RetailId=@RetailId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                sql = "UPDATE D_DayRetail SET Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=GETDATE() WHERE RetailId=@RetailId AND DepotId=@DepotId and Chk_Sure=0 and Sure=0";
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
            string sql = "SELECT Sure,Chk_Sure FROM D_DayRetail where RetailId=@RetailId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@RetailId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                sql = "UPDATE D_DayRetail SET Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=GETDATE() WHERE RetailId=@RetailId AND DepotId=@DepotId and Chk_Sure=1 and Sure=0";
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
                app_cn.ExecuteSQL("F22_Calc_DayRetail", new SqlParameter[] { 
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