using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.FTP;
using System.IO;
using System.Text;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：MDM_App_Data_GetList
/// 类说明：从FTP中获取客流分析数据
/// 创建人：马卫清
/// 创建日期：2013-05-04
/// 修改人：
/// 修改日期：
namespace HZY.COM.BI
{
    public class CustomerFlow_GetFromFTP : LogicBase, ILogicExecute
    {
        public CustomerFlow_GetFromFTP()
        {
            this.m_SessionCheck = false;

        }

        private DataTable m_dtFTP = new BI_CustomerFlow.T_CustomerFlowDataTable();
        private string m_localFolder = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "temp/BI_CustomerFlow/FTPData/" + DateTime.Now.ToShortDateString();

        /// <summary>
        /// 获取MDM应用的数据
        /// </summary>
        /// <returns></returns>
        public bool Execute()
        {



            DateTime dateStart = DateTime.Now;
            DateTime dateEnd = DateTime.Now;


            if (m_request != null && m_request.Tables.Count >0 &&  m_request.Tables[0].Rows.Count == 1)
            {
                if (m_request.Tables[0].Columns.Contains("dateStart"))
                {
                    dateStart = Convert.ToDateTime(m_request.Tables[0].Rows[0]["dateStart"]).AddDays(-1);
                }

                if (m_request.Tables[0].Columns.Contains("dateEnd"))
                {
                    dateEnd = Convert.ToDateTime(m_request.Tables[0].Rows[0]["dateEnd"]).AddDays(-1);
                }
            }



            DateTime currentDate = dateStart;
            Dbconn conn = new Dbconn("BI_CustomerFlow");

            DataTable dtLog = new DataTable();
            dtLog.Columns.Add("Execute_Date");
            dtLog.Columns.Add("Result");
            dtLog.Columns.Add("Message");
            dtLog.Columns.Add("Exception");

            while (currentDate <= dateEnd)
            {
                try
                {
                    dtLog.Clear();

                    //获取FTP的数据
                    GetFTPData(currentDate);
                    conn.LockTableList.Add("T_CustomerFlow");
                    conn.BeginTransaction();

                    conn.Delete("T_CustomerFlow", "Local_Date_and_Time between '" + currentDate.ToString("yyyy-MM-dd 00:00:00.000") + "' and '" + currentDate.ToString("yyyy-MM-dd 23:59:59.999") + "' ");
                    //插入数据
                    conn.InsertBYSQLBC("T_CustomerFlow", m_dtFTP);

                    dtLog.Rows.Add(new object[] { currentDate, true, "", "" });
                    conn.Insert("Log_GetFTPData", dtLog);
                    //throw new Exception("test");
                    conn.CommitTransaction();

                }
                catch (Exception ex)
                {
                    conn.RollbackTransaction();


                    try
                    {
                        dtLog.Rows.Add(new object[] { currentDate, false, ex.Message, ex.ToString() });
                        conn.BeginTransaction();
                        conn.Insert("Log_GetFTPData", dtLog);
                        conn.CommitTransaction();

                    }
                    catch (Exception ex1)
                    {


                    }

                    try
                    {
                        AMSendWS.MsgCenter cls = new AMSendWS.MsgCenter();
                        cls.SendMsg("AM", "BI客流数据获取", "马卫清", "信息部服务中心", "BI客流数据获取:执行日期：“" + currentDate.ToString("yyyy-MM-dd") + "”时发生错误：" + ex.ToString(), DateTime.Now.AddDays(-1).ToString());
                    }
                    catch (Exception ex2)
                    {


                    }
                }

                currentDate = currentDate.AddDays(1);
            }
            return true;

        }



        private void GetFTPData(DateTime currentDate)
        {
            m_localFolder = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "temp/BI_CustomerFlow/FTPData/" + currentDate.ToShortDateString();

            FTPClient client = new FTPClient("192.168.0.26", "", "jk", "jk654@123", 21);
            client.Connect();
            GetFolder("*", ".ep01", client, CreateFolder(), currentDate);
            //由于 FTP的数据有滞后，所以需要缓冲一天的数据
            //GetFolder("*", ".ep01", client, CreateFolder(), "BRK.PCNT.Site Name." + currentDate.AddDays(1).ToString("yyMMdd"));
            client.DisConnect();
            //ClearFolder()
            Console.WriteLine("下载完毕");

            m_dtFTP = new BI_CustomerFlow.T_CustomerFlowDataTable();
            m_dtFTP.Columns.Remove("Seq_No");

            //获取数据
            foreach (string strFileName in Directory.GetFiles(m_localFolder))
            {
                FileStream fs = new FileStream(strFileName, FileMode.Open, FileAccess.Read);
                byte[] buffer = new byte[fs.Length];
                fs.Read(buffer, 0, (Int32)fs.Length);
                fs.Close();
                fs.Close();
                fs.Close();
                fs.Dispose();
                fs.Dispose();
                fs.Dispose();

                string[] strText = Encoding.UTF8.GetString(buffer).Replace("\r\n", "\n").Split('\n');

                //案例数据：25||Site ID||New Zone0|2|09/11/2013 04:00:00|1|1|160|159|192.168.254.2|
                foreach (string strRow in strText)
                {
                    if (strRow == "")
                    {
                        continue;
                    }
                    string strTemp = "";
                    if (strRow.Substring(strRow.Length - 1) == "|")
                    {
                        strTemp = strRow.Substring(0, strRow.Length - 1);
                    }

                    string[] str = (System.Guid.NewGuid().ToString() + "|" + strTemp).Split('|');

                    //错误数据
                    if (str.Length != 13)
                    {
                        continue;
                    }

                    if (str[7].StartsWith(currentDate.ToString("MM/dd/yyyy")))
                    {
                        m_dtFTP.Rows.Add(str);

                    }

                }
            }

        }



        /// <summary>
        /// 在本地目录下创建一个以日期为名称的目录，我做这个ftp的主要目的是为了每天都备份
        /// </summary>
        /// <returns>创建的目录名</returns>
        private string CreateFolder()
        {
            string folder = m_localFolder;
            if (!Directory.Exists(folder))
            {
                Directory.CreateDirectory(folder);
            }
            else
            {
                string strTemp = DateTime.Now.ToString(@"_HHmmss");
                Directory.Move(folder, folder + strTemp);
                Directory.CreateDirectory(folder);

            }

            return folder;
        }


        /**/
        /// <summary>
        /// 在下载结束后清空程序目录的多余文件
        /// </summary>
        private static void ClearFolder()
        {
            string folder = Environment.CurrentDirectory;
            string[] dictorys = Directory.GetFiles(folder);
            foreach (string dictory in dictorys)
            {
                FileInfo info = new FileInfo(dictory);
                if (info.Length == 0)
                    File.Delete(dictory);
            }
        }


        /**/
        /// <summary>
        /// 递归获取ftp文件夹的内容
        /// </summary>
        /// <param name="fileMark">文件标记</param>
        /// <param name="path">远程路径</param>
        /// <param name="client"></param>
        /// <param name="folder"></param>
        private static void GetFolder(string fileMark, string path, FTPClient client, string folder, DateTime currentDate)
        {
            string[] dirs = client.Dir(path);  //获取目录下的内容
            client.ChDir(path);  //改变目录
            foreach (string dir in dirs)
            {
                string[] infos = dir.Split(' ');
                //string info = infos[infos.Length - 1].Replace("\r", "");
                string info = getFileName(dir.Replace("\r", ""));

                if (dir.StartsWith("d") && !string.IsNullOrEmpty(dir))  //为目录
                {

                    if (!info.EndsWith(".") && !info.EndsWith(".."))  //筛选出真实的目录
                    {
                        Directory.CreateDirectory(folder + "\\" + info);
                        GetFolder(fileMark, path + "/" + info, client, folder + "\\" + info, currentDate);
                        client.ChDir(path);
                    }
                }
                else if (dir.StartsWith("-r"))  //为文件
                {
                    string file = folder + "\\" + info;
                    if (File.Exists(file))
                    {
                        long remotingSize = client.GetFileSize(info);
                        FileInfo fileInfo = new FileInfo(file);
                        long localSize = fileInfo.Length;

                        if (remotingSize != localSize)  //短点续传
                        {
                            client.GetBrokenFile(info, folder, info, localSize);
                        }
                    }
                    else
                    {
                        //由于FTP有滞后，所以需要多取一天的数据
                        if (info.StartsWith("BRK.PCNT.Site Name." + currentDate.ToString("yyMMdd"))
                            || info.StartsWith("BRK.PCNT.Site Name." + currentDate.AddDays(1).ToString("yyMMdd")))
                        {
                            client.GetFile(info, folder, info);  //下载文件
                            Console.WriteLine("文件" + folder + info + "已经下载");
                        }
                    }
                }
            }

        }

        private static string getFileName(string strDirString)
        {
            for (int i = 0; i < 8; i++)
            {
                strDirString = strDirString.Trim();
                int n = strDirString.IndexOf(" ");
                if (n < 1)
                {
                    return "";
                }
                strDirString = strDirString.Substring(n);
            }

            if (strDirString.Length > 0)
            {
                //去掉首空格
                strDirString = strDirString.Substring(1);
            }
            return strDirString;
        }


    }

}