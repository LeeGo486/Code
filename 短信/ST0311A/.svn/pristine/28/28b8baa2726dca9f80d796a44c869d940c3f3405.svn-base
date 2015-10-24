using System;
using System.Collections.Generic;
using System.ServiceProcess;
using System.Text;
using System.Threading;
using System.Diagnostics;
using log4net;

namespace LYMessageService
{
    static class Program
    {
        //当前服务的路径
        public static readonly string strPath
            = System.AppDomain.CurrentDomain.BaseDirectory;

        private static readonly ILog log
                    = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        static void Main()
        {
            log4net.Config.DOMConfigurator.Configure();

            AppDomain.CurrentDomain.UnhandledException
                += new UnhandledExceptionEventHandler(UnhandledExceptionEventHandler);

            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[] 
            { 
                new Service1() 
            };
            ServiceBase.Run(ServicesToRun);

            
        }

        static void UnhandledExceptionEventHandler(object sender, UnhandledExceptionEventArgs args)
        {


            if (!(args.ExceptionObject is ThreadAbortException))
            {

                Exception ex = args.ExceptionObject as Exception;

                //LeeGo添加
                log.Error(ex.Message);

                using (System.IO.StreamWriter sw
                   = new System.IO.StreamWriter(Service1.strPath + "logError.txt", true))
                {
                    sw.WriteLine("日期："
                        + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ")
                        + "未捕获异常错误：" + ex.Message + "Path:" + strPath + @"restartServer.bat");
                }

            }
            else
            {


                Exception ex = args.ExceptionObject as Exception;


                //LeeGo添加
                log.Error(ex.Message);

                using (System.IO.StreamWriter sw
                   = new System.IO.StreamWriter(Service1.strPath + "logError.txt", true))
                {
                    sw.WriteLine("日期："
                        + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss ")
                        + "Thread未捕获异常错误：" + ex.Message +"Path:"+ strPath + @"restartServer.bat");
                }
            }

            
            //调用dos命令重启服务
            //Process.Start("CMD.exe", strPath + @"restartServer.bat");

            //退出服务 在服务器里设置服务属性 自动重启
            //System.Environment.Exit(0);


        }
    }
}
