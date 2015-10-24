using System;
using System.Collections.Generic;
using System.ServiceProcess;
using System.Text;
using log4net;
using System.Threading;

namespace SendMsgService
{
    static class Program
    {
        private static readonly ILog log
                    = LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        static void Main()
        {
            log4net.Config.DOMConfigurator.Configure();
            ServiceBase[] ServicesToRun;
            ServicesToRun = new ServiceBase[] 
            { 
                new Service1() 
            };
            ServiceBase.Run(ServicesToRun);

            AppDomain.CurrentDomain.UnhandledException
                += new UnhandledExceptionEventHandler(UnhandledExceptionEventHandler);
        }
        //.Net 下未捕获异常的处理
        static void UnhandledExceptionEventHandler(object sender, UnhandledExceptionEventArgs args)
        {
             

            if (!(args.ExceptionObject is ThreadAbortException))
            {

                Exception ex = args.ExceptionObject as Exception;

                log.Error(ex.Message);

            };

        }
    }
}
