using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.ServiceProcess;
using System.Timers;
using System.Text;
using System.Threading;
using System.Data.SqlClient;
using log4net;

namespace LYMessageService
{
    public partial class Service1 : ServiceBase
    {
        //field
        string strAcc = @"SELECT [Spid]
                              ,[LoginName]
                              ,[Password]
                              ,[QueryCNT]
                              ,[Aattribute]
                              ,[SendStatus]
                          FROM [dbo].[CFG_Account] WITH(NOLOCK)
                          WHERE [SendStatus] = 1
                          ORDER BY NEWID()";
        private object sync = new object();

        //当前服务的路径
        public static readonly string strPath
            = System.AppDomain.CurrentDomain.BaseDirectory;

        Thread threadSend;
        Thread threadGet;
        Thread threadReport;

        public Service1()
        {
            InitializeComponent();
        }


        //LeeGo添加
        private static readonly ILog log
            = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        protected override void OnStart(string[] args)
        {
            threadSend = new Thread(new ThreadStart(SendMsg));
            threadGet = new Thread(new ThreadStart(GetMsg));
            threadReport = new Thread(new ThreadStart(GetReport)); 

            threadSend.Priority = ThreadPriority.Normal;//正常
            threadGet.Priority = ThreadPriority.BelowNormal;//低
            threadReport.Priority = ThreadPriority.BelowNormal;//低

            threadSend.Start();
            threadGet.Start();
            threadReport.Start();
        }

        protected override void OnStop()
        {
            System.Threading.Thread.Sleep(2000);//这里要sleep
            threadSend.Abort();
            threadGet.Abort();
            threadReport.Abort();
        }

        protected void SendMsg()
        {

            //DbHandle dbH = new DbHandle();

            while (true)
            {
                lock (sync)
                {
                    try  //增加错误捕获
                    {

                        //getAccounts
                        DataTable dtAcc
                            = SqlHelper.GetDataTable(strAcc); //dbH.GetData(this.strAcc);
                        if (dtAcc == null)  //预判空跳过
                        {
                            continue;
                        }
                        int iCount = dtAcc.Rows.Count;

                        if (iCount > 0)
                        {
                            for (int i = 0; i < iCount; i++)
                            {

                                string strSpid
                                    = dtAcc.Rows[i]["Spid"].ToString();
                                string strLgN
                                    = dtAcc.Rows[i]["LoginName"].ToString();
                                string strPwd
                                    = dtAcc.Rows[i]["Password"].ToString();
                                string strQNT
                                    = dtAcc.Rows[i]["QueryCNT"].ToString();
                                string strAatt
                                    = dtAcc.Rows[i]["Aattribute"].ToString();

                                string strDetailSQL
                                    = @"SELECT TOP " + strQNT + @"
                                     [ID]
                                    ,[mobile]
                                    ,[content]
                                    ,[SubPort]
                                    ,[SendTime]
                                    ,[CreateTime]
                                    ,[Aattribute]
                                    FROM [dbo].[MobileSend_MT]
                                    WHERE [Flag] = 0 AND SendTime <= GETDATE() AND [Spid] = '"
                                    + strSpid + "' AND [Aattribute] = '" + strAatt + "'";


                                DataTable dtDetail = SqlHelper.GetDataTable(strDetailSQL);//dbH.GetData(strDetailSQL);

                                int iLoop = dtDetail.Rows.Count;

                                //发送短信

                                if (iLoop > 0)
                                {

                                    for (int j = 0; j < iLoop; j++)
                                    {
                                        string strID
                                            = dtDetail.Rows[j]["ID"].ToString();
                                        string SendMobile
                                            = dtDetail.Rows[j]["mobile"].ToString();
                                        string SendContent
                                            = dtDetail.Rows[j]["content"].ToString();
                                        string SendTime
                                            = Convert.ToDateTime(dtDetail.Rows[j]["SendTime"]).ToString("yyyy-MM-dd HH:mm:ss.fff");
                                        string SubPort
                                            = dtDetail.Rows[j]["SubPort"].ToString();
                                        string CreateTime
                                            = Convert.ToDateTime(dtDetail.Rows[j]["CreateTime"]).ToString("yyyy-MM-dd HH:mm:ss.fff");
                                        string Aattribute
                                            = dtDetail.Rows[j]["Aattribute"].ToString();

                                        //调用接口

                                        //LYMessage.Sms LYSendMsg = new LYMessage.Sms();

                                        //string strRst
                                        //    = LYSendMsg.CallSms(strSpid, strLgN, strPwd,
                                        //    SendContent, SendMobile, SubPort, "", "", "");

                                        string strRst = "";
                                        //单独记录请求WebServices 出错的问题
                                        try
                                        {
                                            LYMessage.Sms LYSendMsg = new LYMessage.Sms();
                                            strRst = LYSendMsg.CallSms(strSpid, strLgN, strPwd,
                                            SendContent, SendMobile, SubPort, "", "", "");
                                        }
                                        catch (Exception ex)
                                        {
                                            log.Error(ex);
                                            using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "RequetError.txt", true))
                                            {
                                                sw.WriteLine("日期：" + DateTime.Now.ToString("G") + " SendMsg请求WebServices错误:" + ex.StackTrace.ToString());
                                            }
                                        }



                                        using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "SendMsgLog.txt", true))
                                        {
                                            sw.WriteLine(strRst);
                                        };
                                        log.Info(strRst);

                                        string[] strArray = strRst.Split('&');

                                        if (strArray.Length > 0)
                                        {

                                            string[] arrRst00 = strArray[0].Split('=');
                                            string[] arrRst01 = strArray[1].Split('=');

                                            List<string> field = new List<string>();
                                            List<string> value = new List<string>();

                                            if (arrRst00[1] == "1000")
                                            {

                                                string[] arrRst02
                                                    = strArray[2].Split('=');

                                                field.Add("Spid");
                                                field.Add("Mobile");
                                                field.Add("Content");
                                                field.Add("SendTime");
                                                field.Add("CreateTime");
                                                field.Add("Result");
                                                field.Add("Description");
                                                field.Add("Smsid");
                                                field.Add("Aattribute");

                                                object[] obj = new object[]
                                            {strSpid,SendMobile,SendContent,SendTime,CreateTime,
                                                arrRst00[1],arrRst01[1],arrRst02[1],Aattribute};

                                                string where = " ID = " + strID;

                                                //bool bRstIst = dbH.Delete("[dbo].[MobileSend_MT]", where);

                                                string strDelMT = "Delete [dbo].[MobileSend_MT] where ID=@ID";

                                                SqlParameter[] sqlP = new SqlParameter[] { new SqlParameter("@ID", strID) };

                                                bool bRstIst = SqlHelper.ExcuteNoQuery(strDelMT, sqlP)>0;


                                                if (bRstIst)
                                                {
                                                    //dbH.Insert2("[dbo].[MobileSend_MT_Bak]", field, obj);

                                                    string strInsertBak = "Insert into [dbo].[MobileSend_MT_Bak](Spid,Mobile,Content,SendTime,CreateTime,Result,Description,Smsid,Aattribute)values(@Spid,@Mobile,@Content,@SendTime,@CreateTime,@Result,@Description,@Smsid,@Aattribute)";
                                                    if (SendMobile.IndexOf(',') > -1)
                                                    {
                                                        string[] strMobiles = SendMobile.Split(',');
                                                        for (int z = 0; z < strMobiles.Length; z++)
                                                        {
                                                            SqlParameter[] sqlPI = new SqlParameter[] { new SqlParameter("@Spid", strSpid), new SqlParameter("@Mobile", strMobiles[z]), new SqlParameter("@Content", SendContent), new SqlParameter("@SendTime", SendTime), new SqlParameter("@CreateTime", CreateTime), new SqlParameter("@Result", arrRst00[1]), new SqlParameter("@Description", arrRst01[1]), new SqlParameter("@Smsid", arrRst02[1]), new SqlParameter("@Aattribute", Aattribute) };
                                                            SqlHelper.ExcuteNoQuery(strInsertBak, sqlPI);
                                                        }
                                                    }
                                                    else
                                                    {
                                                        SqlParameter[] sqlPI = new SqlParameter[] { new SqlParameter("@Spid", strSpid), new SqlParameter("@Mobile", SendMobile), new SqlParameter("@Content", SendContent), new SqlParameter("@SendTime", SendTime), new SqlParameter("@CreateTime", CreateTime), new SqlParameter("@Result", arrRst00[1]), new SqlParameter("@Description", arrRst01[1]), new SqlParameter("@Smsid", arrRst02[1]), new SqlParameter("@Aattribute", Aattribute) };
                                                        SqlHelper.ExcuteNoQuery(strInsertBak, sqlPI);
                                                    }

                                                }
                                                else
                                                {
                                                    string strUpdateMT = "update [dbo].[MobileSend_MT] set Flag=@Flag,Result=@Result,Description=@Description,HandleTime=getdate() where ID=@ID";
                                                    SqlParameter[] sqlPU = new SqlParameter[] { new SqlParameter("@Flag", "2"), new SqlParameter("@Result", arrRst00[1]), new SqlParameter("@Description", arrRst01[1]), new SqlParameter("@ID", strID) };
                                                    SqlHelper.ExcuteNoQuery(strUpdateMT, sqlPU);

                                                    field.Add("Flag");
                                                    field.Add("Result");
                                                    field.Add("Description");

                                                    value.Add("2");
                                                    value.Add(arrRst00[1]);
                                                    value.Add(arrRst01[1]);

                                                    where = "[ID] = " + strID;

                                                    //dbH.UpdateMany("[dbo].[MobileSend_MT]", field, value, where);

                                                    field = null;
                                                    value = null;
                                                };

                                            }
                                            else
                                            {

                                                string strUpdateMT1 = "update [dbo].[MobileSend_MT] set Flag=@Flag,Result=@Result,Description=@Description,HandleTime=getdate() where ID=@ID";
                                                SqlParameter[] sqlPU1 = new SqlParameter[] { new SqlParameter("@Flag", "2"), new SqlParameter("@Result", arrRst00[1]), new SqlParameter("@Description", strArray[1].Substring(12, strArray[1].Length-12)), new SqlParameter("@ID", strID) };
                                                SqlHelper.ExcuteNoQuery(strUpdateMT1, sqlPU1);

                                                field.Add("Flag");
                                                field.Add("Result");
                                                field.Add("Description");

                                                value.Add("2");
                                                value.Add(arrRst00[1]);
                                                value.Add(arrRst01[1]);

                                                string where = "[ID] = " + strID;

                                                //dbH.UpdateMany("[dbo].[MobileSend_MT]", field, value, where);

                                                field = null;
                                                value = null;

                                            };
                                        };
                                    };
                                };

                            };

                            //线程休息200毫秒

                            System.Threading.Thread.Sleep(500);
                        };

                    }
                    catch (Exception ex)
                    {
                        log.Error(ex);
                        using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "SendMsgErrorLog.txt", true))
                        {
                            sw.WriteLine("日期：" + DateTime.Now.ToString("G") + " SendMsg错误:" + ex.StackTrace.ToString());
                        };
                    }

                };

            };

        }

        protected void GetReport()
        {
            List<string> field = new List<string>();
            

            field.Add("Spid");
            field.Add("Smsid");
            field.Add("mobile");
            field.Add("Status");
            field.Add("Statdesc");
            field.Add("Arrive_time");

            //定义表结构 用来处理合并单条记录多次发送的发送报告
            DataTable dt = new DataTable("msReport");
            DataColumn dc1 = new DataColumn("Spid", Type.GetType("System.String"));
            DataColumn dc2 = new DataColumn("Smsid", Type.GetType("System.String"));
            DataColumn dc3 = new DataColumn("mobile", Type.GetType("System.String"));
            DataColumn dc4 = new DataColumn("Status", Type.GetType("System.String"));
            DataColumn dc5 = new DataColumn("Statdesc", Type.GetType("System.String"));
            DataColumn dc6 = new DataColumn("Arrive_time", Type.GetType("System.String"));

            dt.Columns.Add(dc1);
            dt.Columns.Add(dc2);
            dt.Columns.Add(dc3);
            dt.Columns.Add(dc4);
            dt.Columns.Add(dc5);
            dt.Columns.Add(dc6);

            
            while (true)
            {
                lock (sync)
                {
                    try //增加错误捕获
                    {
                        dt.Clear();
                        //DbHandle dbH = new DbHandle();

                        DataTable dtAcc
                                = SqlHelper.GetDataTable(strAcc);//dbH.GetData(this.strAcc);
                        if (dtAcc == null)  //预判空跳过
                        {
                            continue;
                        }
                        if (dtAcc.Rows.Count > 0)
                        {
                            for (int i = 0; i < dtAcc.Rows.Count; i++)
                            {
                                string Spid
                                    = dtAcc.Rows[i]["Spid"].ToString();
                                string LoginName
                                    = dtAcc.Rows[i]["LoginName"].ToString();
                                string Password
                                    = dtAcc.Rows[i]["Password"].ToString();
                                //string result = "",rstDetail = "";
                                int iMach = -1;
                                string strRst = "";
                                //单独记录请求WebServices 出错的问题
                                try
                                {
                                    LYMessage.Sms LYMsg = new LYMessage.Sms();
                                    strRst = LYMsg.Report(Spid, LoginName, Password);
                                    iMach = strRst.IndexOf('&');
                                }
                                catch (Exception ex)
                                {
                                    log.Error(ex);
                                    using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "RequetError.txt", true))
                                    {
                                        sw.WriteLine("日期：" + DateTime.Now.ToString("G") + " GetReport请求WebServices错误:" + ex.StackTrace.ToString());
                                    }
                                }

                                if (iMach > -1)
                                {
                                    string[] report = strRst.Split('&');
                                    if (report[1].Length > 0)
                                    {
                                        int iHave = report[1].IndexOf('=');

                                        if (iHave > -1)
                                        {
                                            string[] str = report[1].Split('=');
                                            if (str[1].Length > 0)
                                            {
                                                string[] temp = str[1].Split(';');

                                                if (temp.Length > 0)
                                                {
                                                    log.Info("接收信息报告："+strRst);

                                                    for (int j = 0; j < temp.Length; j++)
                                                    {
                                                        if (temp[j].Length > 0)
                                                        {
                                                            string msgid = temp[j].Split(',')[0];
                                                            string mobile = temp[j].Split(',')[1];
                                                            string status = temp[j].Split(',')[2];
                                                            string statdesc = temp[j].Split(',')[3];
                                                            string arrTime = temp[j].Split(',')[4];

                                                            object[] obj
                                                                   = new object[] { Spid, msgid, mobile, 
                                                    status, statdesc, arrTime };

                                                            //把每行都加进去
                                                            DataRow dr = dt.NewRow();
                                                            dr["Spid"] = Spid;
                                                            dr["Smsid"] = msgid;
                                                            dr["mobile"] = mobile;
                                                            dr["Status"] = status;
                                                            dr["Statdesc"] = statdesc;
                                                            dr["Arrive_time"] = arrTime;
                                                            dt.Rows.Add(dr);


                                                            //string strSQLInsertReport = "Insert into [dbo].[MobileSend_Report](Spid,Smsid,mobile,Status,Statdesc,Arrive_time)values(@Spid,@Smsid,@mobile,@Status,@Statdesc,@Arrive_time) ";
                                                            //SqlParameter[] sqlPIReport = new SqlParameter[] { new SqlParameter("@Spid", Spid), new SqlParameter("@Smsid", msgid), new SqlParameter("@mobile", mobile), new SqlParameter("@Status", status), new SqlParameter("@Statdesc", statdesc), new SqlParameter("@Arrive_time", arrTime) };
                                                            //SqlHelper.ExcuteNoQuery(strSQLInsertReport, sqlPIReport);
                                                            //dbH.Insert2("[dbo].[MobileSend_Report]", field, obj);
                                                        };
                                                    };

                                                    //中间表临时表
                                                    DataView dv = dt.DefaultView;
                                                    dv.Sort = "Smsid";
                                                    DataTable dtTemp = dv.ToTable();

                                                    for (int z = 0; z < dtTemp.Rows.Count; z++)
                                                    {
                                                        string strSelect = "Spid='" + dtTemp.Rows[z]["Spid"].ToString() + "' and Smsid='" + dtTemp.Rows[z]["Smsid"].ToString() + "' and mobile='" + dtTemp.Rows[z]["mobile"].ToString() + "'";
                                                        DataRow[] drs = dtTemp.Select(strSelect, "Status desc");
                                                        //dtResult.Rows.Add(drs[0].ItemArray);

                                                        log.Info("drs.Length=" + drs.Length.ToString() + "z=" + z.ToString());

                                                        string strSQLInsertReport = "Insert into [dbo].[MobileSend_Report](Spid,Smsid,mobile,Status,Statdesc,Arrive_time)values(@Spid,@Smsid,@mobile,@Status,@Statdesc,@Arrive_time) ";
                                                        SqlParameter[] sqlPIReport = new SqlParameter[] { new SqlParameter("@Spid", drs[0]["Spid"]), new SqlParameter("@Smsid", drs[0]["Smsid"]), new SqlParameter("@mobile", drs[0]["mobile"]), new SqlParameter("@Status", drs[0]["Status"]), new SqlParameter("@Statdesc", drs[0]["Statdesc"]), new SqlParameter("@Arrive_time", drs[0]["Arrive_time"]) };
                                                        SqlHelper.ExcuteNoQuery(strSQLInsertReport, sqlPIReport);
                                                        

                                                        z += drs.Length;
                                                    }

                                                    


                                                };
                                            };

                                        };
                                    };
                                };
                            };
                        };
                    }
                    catch (Exception ex)
                    {

                        log.Error(ex);
                        using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "SendMsgErrorLog.txt", true))
                        {
                            sw.WriteLine("日期：" + DateTime.Now.ToString("G") + " GetReport错误:" + ex.StackTrace.ToString());
                        };
                        //throw;
                    }

                };
                //线程需要休息20秒
                System.Threading.Thread.Sleep(20000);



            };
        }

        protected void GetMsg()
        {
            LYMessage.Sms LYMsg = new LYMessage.Sms();
            LYMessage.Reply[] replys;
            //DbHandle dbH = new DbHandle();
            List<string> field = new List<string>();
            

            field.Add("Spid");
            field.Add("Confirm_time");
            field.Add("Smsid");
            field.Add("mobile");
            field.Add("Content");
            field.Add("Reply_time");

            while (true) 
            {
                lock (sync)
                {
                    try //增加错误捕获
                    {
                        DataTable dtAcc
                            = SqlHelper.GetDataTable(strAcc);//dbH.GetData(this.strAcc);

                        if (dtAcc == null)  //预判空跳过
                        {
                            continue;
                        }
                        int iCount = dtAcc.Rows.Count;

                        for (int i = 0; i < iCount; i++)
                        {
                            string Spid
                                = dtAcc.Rows[i]["Spid"].ToString();
                            string Password
                                = dtAcc.Rows[i]["Password"].ToString();
                            string LoginName
                                = dtAcc.Rows[i]["LoginName"].ToString();
                            string confirm_time="", id="";

                            string result = "";
                            //单独记录请求WebServices 出错的问题
                            try
                            {
                                 result= LYMsg.Reply(Spid, LoginName, Password, "",
                                out confirm_time, out id, out replys);

                                 if (result == "1000")
                                 {
                                     foreach (LYMessage.Reply reply in replys)
                                     {
                                         string mdn = reply.mdn.ToString();
                                         string content = reply.content.ToString();
                                         string reply_time = reply.reply_time.ToString();

                                         object[] obj = new object[] { Spid, confirm_time, id, mdn, content, reply_time };


                                         string strSQLInsertMO = "Insert into [dbo].[MobileSend_MO](Spid,Confirm_time,Smsid,mobile,Content,Reply_time)values(@Spid,@Confirm_time,@Smsid,@mobile,@Content,@Reply_time) ";
                                         SqlParameter[] sqlPIMO = new SqlParameter[] { new SqlParameter("@Spid", Spid), new SqlParameter("@Confirm_time", confirm_time), new SqlParameter("@Smsid", id), new SqlParameter("@mobile", mdn), new SqlParameter("@Content", content), new SqlParameter("@Reply_time", reply_time) };
                                         SqlHelper.ExcuteNoQuery(strSQLInsertMO, sqlPIMO);
                                         

                                         //dbH.Insert2("[dbo].[MobileSend_MO]", field, obj);


                                     };
                                 };
                            }
                            catch (Exception ex)
                            {
                                log.Error(ex);
                                using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "RequetError.txt", true))
                                {
                                    sw.WriteLine("日期：" + DateTime.Now.ToString("G") + " GetMsg请求WebServices错误:" + ex.StackTrace.ToString());
                                }
                            }
                            //string result
                               

                            
                        };

                    }
                    catch (Exception ex)
                    {
                        log.Error(ex);
                        using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "SendMsgErrorLog.txt", true))
                        {
                            sw.WriteLine("日期：" + DateTime.Now.ToString("G") + " GetMsg错误:" + ex.StackTrace.ToString());
                        };
                        //throw;
                    }
                    
                };
                //线程休息
                System.Threading.Thread.Sleep(20000);
            };

            
        }
    }
}
