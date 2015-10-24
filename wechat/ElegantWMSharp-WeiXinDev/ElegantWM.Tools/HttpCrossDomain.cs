using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;


/* *
 * Copyright © 2013 CCT All Rights Reserved 
 * 作者：JackChain 
 * 时间：2013/8/23 18:21:23
 * 功能：跨域访问
 * 版本：V1.0
 *
 * 修改人：
 * 修改点：
 * */

namespace ElegantWM.Tools
{
    public class HttpCrossDomain
    {
        /// <summary>
        /// 跨域访问
        /// </summary>
        /// <param name="url"></param>
        /// <param name="param"></param>
        /// <returns></returns>
        public static string Post(string url, string param, int time = 60000)
        {
            Uri address = new Uri(url);
            HttpWebRequest request = WebRequest.Create(address) as HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "application/json;charset=utf-8"; //"application/x-www-form-urlencoded";
            request.Timeout = time;
            byte[] byteData = UTF8Encoding.UTF8.GetBytes(param == null ? "" : param);
            request.ContentLength = byteData.Length;
            using (Stream postStream = request.GetRequestStream())
            {
                postStream.Write(byteData, 0, byteData.Length);
            }
            string result = "";
            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                StreamReader reader = new StreamReader(response.GetResponseStream());
                result = reader.ReadToEnd();
            }
            return (result);
        }

        /// <summary>
        /// 跨域访问
        /// </summary>
        /// <param name="url"></param>
        /// <param name="param"></param>
        /// <returns></returns>
        public static string Get(string url, int time = 60000)
        {
            Uri address = new Uri(url);
            HttpWebRequest request = WebRequest.Create(address) as HttpWebRequest;
            request.Method = "GET";
            request.ContentType = "application/json;charset=utf-8"; //"application/x-www-form-urlencoded";
            request.Timeout = time;
            string result = "";
            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                StreamReader reader = new StreamReader(response.GetResponseStream());
                result = reader.ReadToEnd();
            }
            return (result);
        }

        public static void DownloadImage(string url, string param, string path, int time = 60000)
        {
            Uri address = new Uri(url);
            HttpWebRequest request = WebRequest.Create(address) as HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "application/json;charset=utf-8"; //"application/x-www-form-urlencoded";
            request.Timeout = time;
            byte[] byteData = UTF8Encoding.UTF8.GetBytes(param == null ? "" : param);
            request.ContentLength = byteData.Length;
            using (Stream postStream = request.GetRequestStream())
            {
                postStream.Write(byteData, 0, byteData.Length);
            }

            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                Stream s = response.GetResponseStream();
                FileStream fileStream = new FileStream(path, FileMode.OpenOrCreate, FileAccess.Write);
                int readNumber = 0;
                byte[] bye = new byte[8];
                while ((readNumber = s.Read(bye, 0, 8)) > 0)
                {
                    fileStream.Write(bye, 0, readNumber);
                    fileStream.Flush();
                }
                fileStream.Close();
            }
        }
    }
}
