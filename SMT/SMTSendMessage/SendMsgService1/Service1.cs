using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.ServiceProcess;
using System.Text;
using System.Timers;
using System.Configuration;
using log4net;

using System.Threading;//线程


namespace SendMsgService
{
    public partial class Service1 : ServiceBase
    {
        public Service1()
        {
            InitializeComponent();
        }
        
        private static readonly ILog log 
            = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        Thread threadSend;
        Thread threadGet;
        Thread threadReport;
        
        private object sync = new object();
        //当前服务的路径
        public static readonly string strPath
            = AppDomain.CurrentDomain.BaseDirectory;

       
        

        protected override void OnStart(string[] args)
        {
            //启用另外一个线程来处理业务.否则 OnStart方法执行不完.服务无法进行停止启动操作.
            threadSend = new Thread(new ThreadStart(SendMsg));
            threadGet = new Thread(new ThreadStart(GetMsg));
            threadReport = new Thread(new ThreadStart(GetReoprt));

            threadSend.Priority = ThreadPriority.Normal;//正常
            threadReport.Priority = ThreadPriority.BelowNormal;//低
            threadGet.Priority = ThreadPriority.Lowest;//低

            threadSend.IsBackground = true;
            threadReport.IsBackground = true;
            threadGet.IsBackground = true;

            threadSend.Start();
            threadGet.Start();
            threadReport.Start();

            using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "logService.txt", true))
            {
                sw.WriteLine(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ") + "SMT_SendMessageService is Stat.");
            }
        }

        protected override void OnStop()
        {
            //SendMsg("Off");
            System.Threading.Thread.Sleep(2000);//这里要sleep
            threadSend.Abort();
            threadGet.Abort();
            threadReport.Abort();
            using (System.IO.StreamWriter sw = new System.IO.StreamWriter(strPath + "logService.txt", true))
            {
                sw.WriteLine(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ") + "SMT_SendMessageService is Stop.");
            };
        }

        //Send Message
        protected void SendMsg()
        {
            string strSqlHead = @"SELECT T2.[Com]
                                ,T1.[AccountNo]
                                ,T1.[PassWord]
                                ,T1.[QueryCNT]
                            FROM [dbo].[CFG_Account] T1 WITH(NOLOCK)
                            LEFT JOIN [dbo].[CFG_Company] T2 WITH(NOLOCK) ON T1.CID = T2.ID
                            WHERE T1.AStatus = 1 AND T1.SendStatus = 1
                            ORDER BY NEWID()";
            DataTable dtHead = new DataTable();

            DBconn dbc = new DBconn();

            try
            {
                while (true)
                {
                    dtHead
                        = dbc.getDataView(strSqlHead);

                    if (dtHead != null)
                    {
                        int iHead = dtHead.Rows.Count;

                        if (iHead > 0)
                        {
                            for (int j = 0; j < iHead; j++)
                            {

                                string strDetailCom = dtHead.Rows[j]["Com"].ToString(),
                                       CorpID = dtHead.Rows[j]["AccountNo"].ToString(),
                                       Pwd = dtHead.Rows[j]["PassWord"].ToString(),
                                       strMaxLoop = dtHead.Rows[j]["QueryCNT"].ToString();

                                string strSQL = @"SELECT TOP " + strMaxLoop + @" 
                                               [ID]
                                              ,[Mobile]
                                              ,[Content]
                                              ,[CreateDate]
                                              ,ISNULL([DelaySendTime],GETDATE()) AS DelaySendTime
                                              ,[RealSendTime]
                                              ,[sCell]
                                              ,[Status]
                                              ,[com]
                                  FROM [dbo].[MobileSend] WHERE [Flag] = 0 AND Com = " + strDetailCom;

                                DataTable dtDeatail = dbc.getDataView(strSQL);


                                if (dtDeatail != null)
                                {
                                    int iLoop = dtDeatail.Rows.Count;
                                    //发送短信
                                    if (iLoop > 0)
                                    {
                                        for (int i = 0; i < iLoop; i++)
                                        {

                                            string strID = dtDeatail.Rows[i]["ID"].ToString();

                                            string SendMobile
                                                = dtDeatail.Rows[i]["Mobile"].ToString();

                                            string SendContent
                                                = dtDeatail.Rows[i]["Content"].ToString();

                                            string SendTime
                                                = dtDeatail.Rows[i]["DelaySendTime"].ToString();

                                            DateTime sendT = Convert.ToDateTime(SendTime);
                                            SendTime = sendT.ToString("yyyyMMddHHmmss.fff");

                                            //调用接口

                                            Dxt.LinkWS LinkWs = new Dxt.LinkWS();
                                            log.Info("SendMsg_If is Begin");


                                            string ReS2
                                                = LinkWs.BatchSend2(CorpID.Trim(), Pwd.Trim(), SendMobile.Trim(),
                                                SendContent.Trim(), "", SendTime.Trim());
                                            log.Info("SendMsg_If is Back. Result is " + ReS2);
                                            log.Info("------======------");
                                            int iReS2 = int.Parse(ReS2);

                                            
                                            string now
                                                    = DateTime.Now.ToLocalTime().ToString();

                                            if (iReS2 >= 0)
                                            {

                                                //删除旧数据
                                                bool bRst = DBconn.Delete("[dbo].[MobileSend]", " ID = " + strID);

                                                log.Info("Delete SendMsg is OK. Id is " + strID);



                                                //插入新数据
                                                if (bRst)
                                                {
                                                    InsertBak(strID, dtDeatail, ReS2, now);
                                                    log.Info("Insert SendMsgBak is OK. Id is " + strID);
                                                    log.Info("------======------");
                                                };
                                            }
                                            else
                                            {
                                                //更新数据
                                                DBconn.Update("[dbo].[MobileSend]", " [Flag] = 2,[Status] = '"
                                                    + ReS2 + "',[RealSendTime] = '" + now + "' WHERE ID = " + strID);

                                                log.Info("Update SendMsgBak is OK. Id is " + strID);
                                                log.Info("------======------");

                                            };
                                        };
                                    };

                                };
                            };
                            //当所有公司都循环一遍后，让线程休息200毫秒
                            System.Threading.Thread.Sleep(200);

                        };
                    };
                };

            }
            catch (Exception e)
            {
                log.Error(e);
                //throw;
            };    
        }

        //Get Message
        protected void GetMsg() {
            try
            {
                Dxt.LinkWS LinkWs = new Dxt.LinkWS();
                string result;
                string strSQL =
                            @"SELECT [AccountNo],[PassWord]
                          FROM [dbo].[CFG_Account] WITH(NOLOCK)
                          WHERE [AStatus] = 1 AND [SendStatus] = 1";
                DBconnGet dbcg = new DBconnGet();

                while (true)
                {
                        lock (sync)
                        {
                            DataTable dt = dbcg.getDataView(strSQL);

                            if (dt != null)
                            {
                                int iCount = dt.Rows.Count;
                                if (iCount > 0)
                                {
                                    for (int i = 0; i < iCount; i++)
                                    {
                                        string CorpID = dt.Rows[i]["AccountNo"].ToString();
                                        string Pwd = dt.Rows[i]["PassWord"].ToString();
                                        try
                                        {
                                            result = LinkWs.Get(CorpID.Trim(), Pwd.Trim());
                                            if (result.Length != 0)
                                            { 
                                                log.Info("GetMsg_If is Back. Result is :" + result);
                                                log.Info("------======------");
                                            };
                                            switch (result)
                                            {
                                                case "": break;
                                                case "-1": break;
                                                case "-2": break;
                                                case "-3": break;
                                                default: InsertMsg(CorpID, result);
                                                    log.Info("Insert GetMsg is OK.");
                                                    log.Info("------======------");
                                                    break;
                                            };
                                        }
                                        catch (Exception ex)
                                        {
                                            log.Error(ex);
                                        };
                                    };
                                }
                                else
                                {
                                    continue;
                                };
                            };

                        };

                    //每次收取短信要间隔5分钟。
                    System.Threading.Thread.Sleep(300000);
                };
            }
            catch (Exception e)
            {
                log.Error(e);
            };
        }

        private void InsertMsg(string CorpId, string Msg)
        {
            try
            {
                Msg = Msg.Replace("||", "|");
                string[] temp =
                    Msg.Split("|".ToCharArray());



                for (int i = 0; i < temp.Length; i++)
                {

                    if (temp[i].Trim() != "")
                    {

                        string[] temp1
                            = temp[i].Split("#".ToCharArray());

                        List<string> field = new List<string>();
                        List<string> value = new List<string>();

                        //temp0--手机号，temp1--回复内容，temp2--回复时间，temp3--回复号码

                        if (temp1.Length > 2)
                        {

                            field.Add("[Mobile]");
                            field.Add("[Content]");
                            field.Add("[GetDate]");
                            field.Add("[sendDate]");
                            field.Add("[CorpId]");
                            field.Add("[Flag]");

                            value.Add(temp1[0]);
                            value.Add(temp1[1]);
                            value.Add(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                            value.Add(temp1[2]);
                            value.Add(CorpId);
                            value.Add("0");

                            DBconnGet dbcg = new DBconnGet();

                            bool brst = dbcg.Insert("[dbo].[MobileGet]", field, value);


                        };
                    };
                };
            }
            catch (Exception e)
            {
                log.Error(e);

            };
        }

        //Insert Success SendMsg 
        private bool InsertBak(string ID, DataTable dtDetail, string RptNo,string now) {
            try
            {
                bool bRst = false;

                List<string> field = new List<string>();
                List<string> value = new List<string>();

                field.Add("ID");
                field.Add("Flag");
                field.Add("Com");
                field.Add("Mobile");
                field.Add("Content");
                field.Add("CreateDate");
                field.Add("DelaySendTime");
                field.Add("RealSendTime");
                field.Add("Status");
                field.Add("SmsID");

                for (int i = 0; i < dtDetail.Rows.Count; i++)
                {
                    if (dtDetail.Rows[i]["ID"].ToString() == ID)
                    {
                        value.Add(ID);
                        value.Add("1");
                        value.Add(dtDetail.Rows[i]["Com"].ToString());
                        value.Add(dtDetail.Rows[i]["Mobile"].ToString());
                        value.Add(dtDetail.Rows[i]["Content"].ToString());
                        value.Add(dtDetail.Rows[i]["CreateDate"].ToString());
                        value.Add(dtDetail.Rows[i]["DelaySendTime"].ToString());
                        value.Add(now);
                        value.Add("1");
                        value.Add(RptNo);
                    }

                };

                DBconnGet dbcg = new DBconnGet();
                bRst = dbcg.Insert("[dbo].[MobileSend_bak]", field, value);

                field = null;
                value = null;
                return bRst;
            }
            catch (Exception e)
            {
                
                log.Error(e);
                return false;
            };
                
        }

        //Get MsgReoprt
        protected void GetReoprt() {

            try
            {
                string strSQL
                = @"SELECT [AccountNo],[PassWord]
                    FROM [dbo].[CFG_Account] WITH(NOLOCK)
                    WHERE [AStatus] = 1 AND [SendStatus] = 1";
                Dxt.LinkWS linkWs = new Dxt.LinkWS();

                DBconnGet dbcg = new DBconnGet();

                while (true)
                {
                    lock (sync)
                    {

                        DataTable dtAccount
                            = dbcg.getDataView(strSQL);

                        if (dtAccount != null)
                        {
                            int iCount = dtAccount.Rows.Count;

                            if (iCount > 0)
                            {
                                for (int i = 0; i < iCount; i++)
                                {

                                    string CorpID
                                        = dtAccount.Rows[i]["AccountNo"].ToString();
                                    string Pwd
                                        = dtAccount.Rows[i]["PassWord"].ToString();
                                    //log.Info("GetReport_If is Begin");
                                    string Report
                                        = linkWs.GetReportSMS(CorpID, Pwd);

                                    if (Report.Length > 0)
                                    {
                                        log.Info("GetReport_If is Back. Result is :" + Report);
                                        log.Info("------======------");
                                        string[] cutReoprt
                                            = Report.Split("|||".ToCharArray());

                                        if (cutReoprt.Length > 0)
                                        {
                                            int Count = cutReoprt.Length;

                                            for (int j = 0; j < Count; j++)
                                            {
                                                string rptDetail = cutReoprt[j];

                                                if (rptDetail.Length > 0)
                                                {
                                                    rptDetail = rptDetail.Replace("$$$$$", "|");

                                                    string[] temp
                                                        = rptDetail.Split("|".ToCharArray());

                                                    if (temp.Length > 4)
                                                    {
                                                        List<string> field = new List<string>();
                                                        List<string> value = new List<string>();

                                                        field.Add("[CorpId]");
                                                        field.Add("[Smsid]");
                                                        field.Add("[Mobile]");
                                                        field.Add("[DelaySendTime]");
                                                        field.Add("[Result]");
                                                        field.Add("[Status]");
                                                        field.Add("[ReportDate]");

                                                        value.Add(CorpID);
                                                        value.Add(temp[0]);
                                                        value.Add(temp[1]);
                                                        value.Add(temp[2]);
                                                        value.Add(temp[3]);
                                                        value.Add(temp[4]);
                                                        value.Add(temp[5]);

                                                        dbcg.Insert("[dbo].[MobileSend_Report]"
                                                            , field, value);
                                                        log.Info("Insert GetReport is OK.");
                                                        log.Info("------======------");


                                                        field = null;
                                                        value = null;
                                                    };
                                                }
                                                else
                                                {
                                                    continue;
                                                };

                                            };
                                        };
                                    };
                                };
                            }
                            else
                            {
                                continue;
                            };

                        };

                    };

                    //每次收取报告后休息。
                    System.Threading.Thread.Sleep(30000);
                };
            }
            catch (Exception e)
            {

                log.Error(e);
            }
            
            
        }

        protected void Warn() {
            string strConn = ConfigurationManager.AppSettings["Caution"];
        }

    }
}
