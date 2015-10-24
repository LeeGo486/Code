<%@ WebHandler Language="C#" Class="BrandSurvey" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public class BrandSurvey : IHttpHandler,System.Web.SessionState.IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        string Str_act = context.Request["act"];
        if (Str_act == "getBrandSurveyDay")
        {
            getBrandSurveyDay(context);
        }
        else if (Str_act == "SaveSurveyDay")
        {
            SaveSurveyDay(context);
        }
        else if (Str_act == "SureSurveyDay")
        {
            SureSurveyDay(context);
        }
        else if (Str_act == "unSureSurveyDay")
        {
            unSureSurveyDay(context);
        }
        else if (Str_act == "getBrandMonth")
        {
            getBrandMonth(context);
        }
        else if (Str_act == "SavegetBrandMonth")
        {
            SavegetBrandMonth(context);
        }
        else if (Str_act == "SureBrandMonth")
        {
            SureBrandMonth(context);
        }
        else if (Str_act == "unSureBrandMonth")
        {
            unSureBrandMonth(context);
        }
    }

    //*****************每日竞争品牌销售业绩调查*********************//
    /// <summary>
    /// 读取每日竞争品牌销售业绩调查数据
    /// </summary>
    /// <param name="context"></param>
    void getBrandSurveyDay(HttpContext context)
    {
        string[] weekdays = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六" };
        string year = context.Request["year"];
        string month = context.Request["month"];
        string id = "";
        StringBuilder sb_json = new StringBuilder();
        //先查询本月日否有单据
        string sql = @"SELECT SurveyId,Chk_Sure from dbo.D_CompeteBrandSurvey 
                    where DepotId=@DepotId AND SurveyYear=@SurveyYear AND SurveyMonth=@SurveyMonth";
        DataTable maindt = app_cn.getTable(sql, new SqlParameter[] {
                new SqlParameter("@DepotId", app_user.depotid), 
                new SqlParameter("@SurveyYear", year), 
                new SqlParameter("@SurveyMonth", month) 
            }, CommandType.Text);
        //如果没有就新增一条本会主表单据
        bool f = true;
        if (maindt.Rows.Count <= 0)
        {
            if (DateTime.Now.Year == int.Parse(year) && DateTime.Now.Month == int.Parse(month))
            {
                f = false;
                id = "JP" + app_user.userid + "-" + year + "-" + month.PadLeft(2, '0') + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0') + "-0001";//每个店铺每个月固定一个id
                sql = @"INSERT INTO D_CompeteBrandSurvey(SurveyId,Survey,DepotId,SurveyYear,SurveyMonth,Cr_Name,Cr_Date) 
                    values(@SurveyId,@SurveyId,@DepotId,@SurveyYear,@SurveyMonth,@Cr_Name,getdate())";
                app_cn.ExecuteSQL(sql, new SqlParameter[] {
                    new SqlParameter("@SurveyId",id),
                    new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@SurveyYear",year),
                    new SqlParameter("@SurveyMonth",month),
                    new SqlParameter("@Cr_Name",app_user.username)
                }, CommandType.Text);

                //添加第一条记录时把品牌数据添加到表里
                sql = @"INSERT INTO D_CompeteBrandData SELECT  '" + id + @"', a.BrandId from J_DptCompeteBrand a 
                    WHERE a.DepotId=@DepotId 
                    and NOT EXISTS (SELECT 1 FROM D_CompeteBrandData b where a.BrandId=b.BrandId AND b.SurveyId=@SurveyId)";
                app_cn.ExecuteSQL(sql, new SqlParameter[] {
                    new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@SurveyId",id),
                }, CommandType.Text);
            }
        }
        else
        {
            id = maindt.Rows[0]["SurveyId"].ToString();
        }
        if (maindt.Rows.Count > 0||!string.IsNullOrEmpty(id))
        {
            if (DateTime.Now.Year == int.Parse(year) && DateTime.Now.Month == int.Parse(month) && f)
            {
                //同时把本月的竞争品牌都加入到店铺竞争品牌表
                sql = @"INSERT INTO D_CompeteBrandData SELECT  '" + id + @"', a.BrandId from J_DptCompeteBrand a 
                    WHERE a.DepotId=@DepotId 
                    and NOT EXISTS (SELECT 1 FROM D_CompeteBrandData b where a.BrandId=b.BrandId AND b.SurveyId=@SurveyId)";
                app_cn.ExecuteSQL(sql, new SqlParameter[] {    
                    new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@SurveyId",id),
                }, CommandType.Text);
            }
            //读取店铺设置的竞争品牌组合成字符，如：[阿迪达斯],[安踏],[班尼路],[鳄鱼牌],[公羊],[IP Zone],[李宁],[耐克]
            sql = @"select STUFF((SELECT ','+b.BrandName FROM D_CompeteBrandData a INNER JOIN J_CompeteBrand b on a.BrandId=b.BrandId 
               WHERE SurveyId=@SurveyId for XML PATH('')),1,1,'') BrandName,
               (select STUFF((SELECT ','+BrandId FROM D_CompeteBrandData WHERE SurveyId=@SurveyId for XML PATH('')),1,1,'')) BrandCode,
               (SELECT 'ISNULL(MAX(case BrandId when '''+BrandId+''' then CAST(RetailSums as varchar) else '''' end),'''') ['+BrandId+'],' from D_CompeteBrandData 
               WHERE SurveyId=@SurveyId for XML PATH('')) selectFile";
            DataTable pp_dt = app_cn.getTable(sql, new SqlParameter[] { 
            new SqlParameter("@SurveyId", id) 
        }, CommandType.Text);
            string Str_brand = "";
            string Str_brandCode = "";
            string Str_files = "";
            if (pp_dt.Rows.Count > 0)
            {
                //获取品牌
                Str_brand = pp_dt.Rows[0]["BrandName"].ToString();
                Str_brandCode = pp_dt.Rows[0]["BrandCode"].ToString();
                Str_files = pp_dt.Rows[0]["selectFile"].ToString();
                //读取竞争品牌列表
                sql = @"SELECT a.SurveyId,b.DayDate,a.Chk_Sure," + Str_files + @" MAX(b.Number) Number
                    FROM D_CompeteBrandSurvey a inner join D_CompeteBrandSurveySub b on a.SurveyId=b.SurveyId 
                    WHERE a.DepotId=@DepotId AND a.SurveyYear=@SurveyYear and a.SurveyMonth=@SurveyMonth 
                    GROUP BY b.DayDate,a.Chk_Sure,a.SurveyId ORDER BY b.DayDate ASC ";
                DataTable dt = app_cn.getTable(sql, new SqlParameter[] {
                new SqlParameter("@DepotId", app_user.depotid), 
                new SqlParameter("@SurveyYear", year), 
                new SqlParameter("@SurveyMonth", month) 
            }, CommandType.Text);

                DateTime time = DateTime.Parse(year + "-" + month + "-01");//本月1号
                DateTime time1 = DateTime.Parse(year + "-" + month + "-01").AddMonths(1);//下月1号
                TimeSpan ts = time1 - time;//计算时间差
                int days = ts.Days;//2个月相差天数
                //所有字段
                string[] columns = Str_brandCode.Split(',');
                //是否审核
                int sure = maindt.Rows.Count <= 0 ? 0 : Convert.ToInt32(maindt.Rows[0]["Chk_Sure"]);
                //string id = maindt.Rows.Count <= 0 ? SurveyId : maindt.Rows[0]["SurveyId"].ToString();
                for (int i = 1; i <= days; i++)
                {
                    
                    string date = year + "-" + month + "-" + i.ToString();//获取日期
                    DateTime t = Convert.ToDateTime(date);
                    string Str_Day = t.Month.ToString().PadLeft(2, '0') + "月" + t.Day.ToString().PadLeft(2, '0') + "日";//日期
                    int Int_week = (int)t.DayOfWeek;//星期几的数字形式
                    string Str_week = weekdays[Int_week];//星期字符形式
                    DataRow[] drs = dt.Select("DayDate='" + date + "'");//在datatable 中查询出当前日期的记录
                    string json = "{\"did\":\"" + date + "\",\"date\":\"" + Str_Day + "\",\"week\":\"" + Str_week + "\",";
                    if (drs.Length > 0)
                    {
                        for (int j = 0; j < columns.Length; j++)
                        {
                            json += "\"" + columns[j] + "\":\"" + drs[0][columns[j]].ToString() + "\",";
                        }
                        json += "\"number\":\"" + drs[0]["Number"] + "\"";
                    }
                    else
                    {
                        for (int j = 0; j < columns.Length; j++)
                        {
                            json += "\"" + columns[j] + "\":\"\",";
                        }
                        json += "\"number\":\"\"";
                    }
                    json += "},";
                    sb_json.Append(json);
                }
                context.Response.Write("{\"id\":\"" + id + "\",\"columnsCode\":\"" + Str_brandCode.Replace("\\", "\\\\") + "\",\"columns\":\"" + Str_brand.Replace("\\", "\\\\") + "\",\"sure\":" + sure.ToString() + ",\"list\":[" + sb_json.ToString().Trim(',') + "]}");
            }
            else
            {
                //读取不到店铺设置的竞争品牌
                context.Response.Write("{\"columnsCode\":\"\"}");
            }
        }
        else
        {
            context.Response.Write("{\"columnsCode\":\"none\"}");
        }
    }

    /// <summary>
    /// 保存部品销售业绩
    /// </summary>
    /// <param name="context"></param>
    void SaveSurveyDay(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];//id
            string year = context.Request["year"];//年份
            string month = context.Request["month"];//月份
            string sums = context.Request["sums"];//业绩或者排名
            string type = context.Request["type"];//修改类型[xs-销售业绩,pm-排名]
            string date = context.Request["date"];//日期
            string brandid = context.Request["brandid"];//品牌
            string sql = "";
            //先查询竞品销售业绩主表看是否已经有当前月的记录，如果没有就新增一条
            if (type == "xs")
            {
                //如果是修改竞争品牌的销售业绩
                sql = @"MERGE D_CompeteBrandSurveySub as T1
                using (select @SurveyId SurveyId,@DayDate DayDate,@BrandID BrandID,@sums RetailSums ) as T2
                ON T1.SurveyId=T2.SurveyId AND T1.DayDate=T2.DayDate AND T1.BrandId=T2.BrandID
                WHEN MATCHED 
                THEN UPDATE SET T1.RetailSums=T2.RetailSums
                WHEN NOT MATCHED 
                THEN INSERT(SurveyId,DayDate,BrandID,RetailSums,Number) VALUES (T2.SurveyId,T2.DayDate,T2.BrandID,T2.RetailSums,0);";
                app_cn.ExecuteSQL(sql, new SqlParameter[] {
                    new SqlParameter("@SurveyId",id),
                    new SqlParameter("@DayDate",date),
                    new SqlParameter("@BrandID",brandid),
                    new SqlParameter("@sums",sums)
                }, CommandType.Text);
            }
            else if (type == "pm")
            {
                //如果修改的是排名
                //首先先查询子表有没有当天的品牌数据，如果有就把当前所以的品牌记录都修改，如果没有就添加
                sql = "select SurveyId from D_CompeteBrandSurveySub where SurveyId=@SurveyId AND DayDate=@DayDate";
                DataTable subdt = app_cn.getTable(sql, new SqlParameter[] {
                    new SqlParameter("@SurveyId",id),
                    new SqlParameter("@DayDate",date)
                }, CommandType.Text);
                if (subdt.Rows.Count > 0)
                {
                    //有记录就修改当天的所以记录
                    sql = "UPDATE D_CompeteBrandSurveySub SET Number=@Number WHERE SurveyId=@SurveyId AND DayDate=@DayDate";
                            app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                        new SqlParameter("@Number",sums),
                        new SqlParameter("@SurveyId",id),
                        new SqlParameter("@DayDate",date)
                    }, CommandType.Text);
                }
                else
                {
                    //无记录就添加当天的品牌记录
                    sql = @"INSERT INTO D_CompeteBrandSurveySub(SurveyId,DayDate,BrandId,RetailSums,Number) 
                    SELECT @SurveyId,@DayDate,BrandId,NULL,@Number FROM J_DptCompeteBrand WHERE DepotId=@DepotId";
                    app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                        new SqlParameter("@SurveyId",id),
                        new SqlParameter("@DayDate",date),
                        new SqlParameter("@Number",@sums),
                        new SqlParameter("@DepotId",app_user.depotid)
                        }, CommandType.Text);
                }
            }
            context.Response.Write("{\"error\":0,\"msg\":\"\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 审核竞争品牌销售业绩
    /// </summary>
    /// <param name="context"></param>
    void SureSurveyDay(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];
            string sql = "SELECT SurveyId,Sure,Chk_Sure from dbo.D_CompeteBrandSurvey where SurveyId=@SurveyId";
            DataTable maindt = app_cn.getTable(sql, new SqlParameter[] {
                                                                            new SqlParameter("@SurveyId", id)
                                                                        }, CommandType.Text);
            //如果主表没有数据不审核，要提示用户输入数据保存后才能审核
            if (maindt.Rows.Count > 0)
            {
                int chksure = Convert.ToInt32(maindt.Rows[0]["Chk_Sure"]);
                int sure = Convert.ToInt32(maindt.Rows[0]["Sure"]);
                if (sure == 0)
                {
                    sql = @"UPDATE D_CompeteBrandSurvey set Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=getdate() 
                            WHERE SurveyId=@SurveyId and Chk_Sure=0";
                    app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                        new SqlParameter("@Chk_Sure","1"),
                        new SqlParameter("@Chk_Name",app_user.username),
                        new SqlParameter("@SurveyId",id)
                    }, CommandType.Text);
                    context.Response.Write("{\"error\":0,\"msg\":\"\"}");
                }
                else
                {
                    context.Response.Write("{\"error\":-2,\"msg\":\"\"}");
                }
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
    /// 反审核竞争品牌销售业绩
    /// </summary>
    /// <param name="context"></param>
    void unSureSurveyDay(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];
            string sql = "SELECT SurveyId,Sure,Chk_Sure from dbo.D_CompeteBrandSurvey where SurveyId=@SurveyId";
            DataTable maindt = app_cn.getTable(sql, new SqlParameter[] {
                                                                            new SqlParameter("@SurveyId", id)
                                                                        }, CommandType.Text);
                int chksure = Convert.ToInt32(maindt.Rows[0]["Chk_Sure"]);
                int sure = Convert.ToInt32(maindt.Rows[0]["Sure"]);
                if (sure == 0)
                {
                    sql = @"UPDATE D_CompeteBrandSurvey set Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=getdate() 
                        WHERE SurveyId=@SurveyId and Chk_Sure=1";
                    app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                    new SqlParameter("@Chk_Sure","0"),
                    new SqlParameter("@Chk_Name",app_user.username),
                    new SqlParameter("@SurveyId",id)
                }, CommandType.Text);
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
    //**************************************************************//
    //*********************店铺竞争品牌月销售排名调查***************//
    /// <summary>
    /// 读取店铺竞争品牌月销售排名调查
    /// </summary>
    /// <param name="context"></param>
    void getBrandMonth(HttpContext context)
    {
        string year = context.Request["year"];
        string month = context.Request["month"];
        string id = "";
        string SurveyId = "JP" + app_user.userid + "-" + year + "-" + month.PadLeft(2, '0') + "-" + DateTime.Now.Day.ToString().PadLeft(2, '0') + "-0001";//每个店铺每个月固定一个id
        StringBuilder sb_json = new StringBuilder();
        //先查询本月日否有单据
        //CheckData(SurveyId, year, month);
        string sql = @"SELECT SurveyId,Chk_Sure from D_CompeteBrandMonth  
                where DepotId=@DepotId AND SurveyYear=@SurveyYear AND SurveyMonth=@SurveyMonth";
        DataTable maindt = app_cn.getTable(sql, new SqlParameter[] {
            new SqlParameter("@DepotId", app_user.depotid), 
            new SqlParameter("@SurveyYear", year), 
            new SqlParameter("@SurveyMonth", month) 
        }, CommandType.Text);
        //如果没有就新增一条本会主表单据
        if (maindt.Rows.Count <= 0)
        {
            if (DateTime.Now.Year == int.Parse(year) && DateTime.Now.Month == int.Parse(month))
            {
                id = SurveyId;
                sql = @"INSERT INTO D_CompeteBrandMonth(SurveyId,Survey,DepotId,SurveyYear,SurveyMonth,Cr_Name,Cr_Date) 
                    values(@SurveyId,@SurveyId,@DepotId,@SurveyYear,@SurveyMonth,@Cr_Name,getdate())";
                app_cn.ExecuteSQL(sql, new SqlParameter[] {
                    new SqlParameter("@SurveyId",SurveyId),
                    new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@SurveyYear",year),
                    new SqlParameter("@SurveyMonth",month),
                    new SqlParameter("@Cr_Name",app_user.username)
                }, CommandType.Text);
            }
        }
        else
        {
            id = maindt.Rows[0]["SurveyId"].ToString();
        }

        if (maindt.Rows.Count > 0 || !string.IsNullOrEmpty(id))
        {
            //查询本月竞争品牌排名
            sql = @"select T1.brandid,T1.BrandName,ISNULL(T2.Chk_Sure,0) Chk_Sure,ISNULL(T2.Number,0) Number,
                    ISNULL(T2.Sums_RetailGoal,0) AS Sums_RetailGoal
                    FROM (SELECT 0 n,'_'+@depotid+'_' AS brandid,'本店铺' AS BrandName 
                    UNION 
	                    SELECT ROW_NUMBER() OVER(ORDER BY a.BrandID ASC),a.BrandId,b.BrandName 
	                    FROM D_CompeteBrandData a INNER JOIN J_CompeteBrand b ON a.BrandId=b.BrandId INNER JOIN D_CompeteBrandSurvey c ON a.SurveyId=c.SurveyId
	                    WHERE c.DepotId=@depotid AND c.SurveyYear=@SurveyYear AND SurveyMonth=@SurveyMonth 
                    ) T1 
                    LEFT JOIN (
	                    SELECT b.BrandId,b.Number,a.Chk_Sure,b.Sums_RetailGoal
	                    FROM D_CompeteBrandMonth a INNER JOIN D_CompeteBrandMonthSub b ON a.SurveyId=b.SurveyId
	                    WHERE a.DepotId =@depotid and a.SurveyYear=@SurveyYear and a.SurveyMonth=@SurveyMonth 
                    ) T2
                    ON T1.brandid=T2.BrandId
                    ORDER BY T1.n ASC";
            DataTable dt = app_cn.getTable(sql, new SqlParameter[] { 
                                                                    new SqlParameter("@depotid",app_user.depotid),
                                                                    new SqlParameter("@SurveyYear",year),
                                                                    new SqlParameter("@SurveyMonth",month),
                                                                    new SqlParameter("@SurveyId",id)
                                                                }, CommandType.Text);

            if (dt.Rows.Count > 0)
            {
                //sql = "SELECT '_'+depotid+'_' brandid from j_depot where depotid=@depotid";
                //DataTable dptdt = app_cn.getTable(sql, new SqlParameter[] { 
                //new SqlParameter("@depotid",app_user.depotid)
            //}, CommandType.Text);

                string brandid = "_" + app_user.depotid + "_";
                string chksure = dt.Rows[0]["Chk_Sure"].ToString();

                foreach (DataRow dr in dt.Rows)
                {
                    string brandname = dr["BrandId"].ToString() == brandid ? "本店铺" : dr["BrandName"].ToString();
                    string json = "{\"BrandId\":\"" + dr["BrandId"].ToString().Replace("\\", "\\\\") + "\",\"drName\":\"" + brandname.Replace("\\", "\\\\") + "\",\"Number\":\"" + dr["Number"].ToString() + "\",\"Sums_RetailGoal\":\"" + dr["Sums_RetailGoal"].ToString() + "\"},";
                    sb_json.Append(json);
                }
                //context.Response.Write("{\"SurveyId\":\"11\"}");
                context.Response.Write("{\"SurveyId\":\"" + id + "\",\"chksure\":" + chksure + ",\"list\":[" + sb_json.ToString().Trim(',') + "]}");
            }
            else
            {
                //读取不到店铺设置的竞争品牌
                context.Response.Write("{\"SurveyId\":\"\"}");
            }
        }
        else
        {
            context.Response.Write("{\"SurveyId\":\"\"}");
        }
    }

    /// <summary>
    /// 检查数据
    /// </summary>
    /// <param name="SurveyId"></param>
    /// <param name="year"></param>
    /// <param name="month"></param>
    void CheckData(string SurveyId, string year, string month)
    {
        string sql = @"SELECT SurveyId,Chk_Sure from D_CompeteBrandSurvey where DepotId=@DepotId AND SurveyYear=@SurveyYear AND SurveyMonth=@SurveyMonth";
        DataTable xmaindt = app_cn.getTable(sql, new SqlParameter[] {
                new SqlParameter("@DepotId", app_user.depotid),
                new SqlParameter("@SurveyYear", year),
                new SqlParameter("@SurveyMonth", month) 
            }, CommandType.Text);
        if (xmaindt.Rows.Count <= 0)
        {
            sql = @"INSERT INTO D_CompeteBrandSurvey(SurveyId,Survey,DepotId,SurveyYear,SurveyMonth,Cr_Name,Cr_Date) 
                    values(@SurveyId,@SurveyId,@DepotId,@SurveyYear,@SurveyMonth,@Cr_Name,getdate())";
            app_cn.ExecuteSQL(sql, new SqlParameter[] {
                    new SqlParameter("@SurveyId",SurveyId),
                    new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@SurveyYear",year),
                    new SqlParameter("@SurveyMonth",month),
                    new SqlParameter("@Cr_Name",app_user.username)
                }, CommandType.Text);
            //店铺竞争品牌表跟D_CompeteBrandSurvey有约束，店铺竞争品牌表添加数据时必须检查D_CompeteBrandSurvey有没有一条对应的本月数据
            //同时把本月的竞争品牌都加入到店铺竞争品牌表
            //同时把本月的竞争品牌都加入到店铺竞争品牌表
            sql = sql = @"INSERT INTO D_CompeteBrandData SELECT  '" + SurveyId + @"', a.BrandId from J_DptCompeteBrand a 
                    WHERE a.DepotId=@DepotId 
                    and NOT EXISTS (SELECT 1 FROM D_CompeteBrandData b where a.BrandId=b.BrandId AND b.SurveyId=@SurveyId)";
            app_cn.ExecuteSQL(sql, new SqlParameter[] {
                     new SqlParameter("@DepotId",app_user.depotid),
                    new SqlParameter("@SurveyId",SurveyId)
                }, CommandType.Text);
        }
    }
    
    /// <summary>
    /// 保存店铺竞争品牌月销售排名调查
    /// </summary>
    /// <param name="context"></param>
    void SavegetBrandMonth(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];//id
            string brandid = context.Request["brandid"];//品牌
            string value = context.Request["value"];//排名
            string flag = context.Request["flag"];
            string flied = "";
            
            if (flag == "number")
                flied = "Number";
            else if (flag == "goal")
                flied = "Sums_RetailGoal";
            string sql = "";
            //先查询竞品销售业绩主表看是否已经有当前月的记录，如果没有就新增一条
            
            //如果是修改竞争品牌的销售业绩
            sql =string.Format(@"MERGE D_CompeteBrandMonthSub as T1
            using (select @SurveyId SurveyId,@BrandID BrandID,@value {0} ) as T2
            ON T1.SurveyId=T2.SurveyId AND T1.BrandId=T2.BrandID
            WHEN MATCHED 
            THEN UPDATE SET T1.{0}=T2.{0}
            WHEN NOT MATCHED 
            THEN INSERT(SurveyId,BrandID,{0}) VALUES (T2.SurveyId,T2.BrandID,T2.{0});", flied);
            app_cn.ExecuteSQL(sql, new SqlParameter[] {
                new SqlParameter("@SurveyId",id),
                new SqlParameter("@BrandID",brandid),
                new SqlParameter("@value",value)
            }, CommandType.Text);
            
            context.Response.Write("{\"error\":0,\"msg\":\"\"}");
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"error\":1,\"msg\":\"" + ex.ToString() + "\"}");
        }
    }

    /// <summary>
    /// 审核店铺竞争品牌月销售排名
    /// </summary>
    /// <param name="context"></param>
    void SureBrandMonth(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];
            string sql = "SELECT Sure,Chk_Sure FROM D_CompeteBrandMonth where SurveyId=@SurveyId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@SurveyId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                sql = @"UPDATE D_CompeteBrandMonth set Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=getdate() 
                        WHERE SurveyId=@SurveyId and Chk_Sure=0 and Sure=0";
                app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                    new SqlParameter("@Chk_Sure","1"),
                    new SqlParameter("@Chk_Name",app_user.username),
                    new SqlParameter("@SurveyId",id)
                }, CommandType.Text);
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
    /// 反审核店铺竞争品牌月销售排名
    /// </summary>
    /// <param name="context"></param>
    void unSureBrandMonth(HttpContext context)
    {
        try
        {
            string id = context.Request["id"];
            string sql = "SELECT Sure,Chk_Sure FROM D_CompeteBrandMonth where SurveyId=@SurveyId AND DepotId=@DepotId";
            DataTable chkdt = app_cn.getTable(sql,new SqlParameter[]{
                new SqlParameter("@SurveyId",id),
                new SqlParameter("@DepotId",app_user.depotid)
            },CommandType.Text);
            int chksure = Convert.ToInt32(chkdt.Rows[0]["Chk_Sure"]);
            int sure = Convert.ToInt32(chkdt.Rows[0]["Sure"]);
            if (sure == 0)
            {
                sql = @"UPDATE D_CompeteBrandMonth set Chk_Sure=@Chk_Sure,Chk_Name=@Chk_Name,Chk_Date=getdate() 
                        WHERE SurveyId=@SurveyId and Chk_Sure=1 and Sure=0";
                app_cn.ExecuteSQL(sql, new SqlParameter[] { 
                    new SqlParameter("@Chk_Sure","0"),
                    new SqlParameter("@Chk_Name",app_user.username),
                    new SqlParameter("@SurveyId",id)
                }, CommandType.Text);
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
    
    //**************************************************************//
    public bool IsReusable {
        get {
            return false;
        }
    }

}