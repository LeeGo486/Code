using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Web;
using System.Configuration;
using System.Web.UI;
using System.Text.RegularExpressions;

namespace ElegantWM.Tools
{
    /// <summary>
    /// AspxToHtml 的摘要说明。
    /// 注:使用此类,你可以在web.config文件对模板类进行配置.如下
    /// /*<appSettings>
    /// <add key="templateFilePath" value="htmlmoudel.htm" />
    /// <add key="htmlFilePath" value="new/"></add>
    /// <add key="ErrLogPath" value="aspxTohtml_log.txt"></add> 
    ///  </appSettings>*/
    /// </summary>
    public class AspxToHtml
    {
        /// <summary>
        /// 模板文件中要替代的参数个数
        /// </summary>
        private int _templateParamCount = 0;
        /// <summary>
        /// 模板文件所在的路径
        /// </summary>
        private string _templateFilePath = ConfigurationSettings.AppSettings["templateFilePath"];
        /// <summary>
        /// 转换后的html文件所存放的路径
        /// </summary>
        private string _htmlFilePath = ConfigurationSettings.AppSettings["htmlFilePath"];

        /// <summary>
        /// 模板页页面编码
        /// </summary>
        private Encoding _templateHtmlCode = Encoding.GetEncoding("gb2312");

        /// <summary>
        /// 转换后的文件编码
        /// </summary>
        private Encoding _code = Encoding.GetEncoding("gb2312");

        /// <summary>
        /// 转换后的html文件名
        /// </summary>
        private string _convertedFilename = "";
        /// <summary>
        /// 模板文件中的参数
        /// </summary>
        private string[] _templateFileparameter;

        /// <summary>
        /// aspx文件中的要代替HTML文件中的参数实际值
        /// </summary>
        private string[] _aspxFileparameter;

        private string _errlogPath = ConfigurationSettings.AppSettings["ErrLogPath"];

        #region 属性

        /// <summary>
        /// 模板文件中要替代的参数个数
        /// </summary>
        public int TemplateParamCount
        {
            get
            {
                return this._templateParamCount;
            }
            set//分配参数个数时，同时为模板文件中的参数和aspx文件中的要代替HTML文件中的参数实际值这两个分配实际数组
            {
                if (value < 0)
                    throw new ArgumentException();

                if (value > 0)
                {
                    this._templateParamCount = value;
                    //模板文件中的参数     
                    _templateFileparameter = new string[value];
                    //aspx文件中的要代替HTML文件中的参数实际值
                    _aspxFileparameter = new string[value];
                }
                else
                    this._templateParamCount = 0;
            }
        }

        /// <summary>
        /// 模板文件所在的路径
        /// 
        /// </summary>
        public string TemplateFilePath
        {
            get { return this._templateFilePath; }
            set { this._templateFilePath = value; }
        }
        /// <summary>
        /// 转换后的html文件所存放的路径
        /// </summary>
        public string HtmlFilePath
        {
            get { return this._htmlFilePath; }
            set { this._htmlFilePath = value; }
        }

        /// <summary>
        /// html模板文件编码
        /// </summary>
        public Encoding TemplateHtmlCode
        {
            get { return this._templateHtmlCode; }
            set { this._templateHtmlCode = Encoding.GetEncoding(value.ToString()); }
        }
        /// <summary>
        /// 编码
        /// </summary>
        public Encoding Code
        {
            get { return this._code; }
            set { this._code = Encoding.GetEncoding(value.ToString()); }
        }
        /// <summary>
        /// 错误文件所在路径
        /// </summary>
        public string ErrLogPath
        {
            get
            {
                if (!(this._errlogPath == null))
                    return this._errlogPath;
                else
                    return "aspxTohtml_log.txt";
            }
            set { this._errlogPath = value; }
        }


        #endregion

        #region 操作

        /// <summary>
        /// 获取转换后的html文件所在相对文件路径
        /// 如：如果HtmlFilePath="/news/"
        /// 转换后的html文件名为200505050505.html
        /// 则返回的值为/news/200505050505.html
        /// </summary>
        /// <remarks>如果在未调用StartConvert方法之前调用此属性则返回null</remarks>
        public string HtmlFileVirtualPath
        {
            get
            {
                if (!(this._convertedFilename == ""))
                    return this.HtmlFilePath + this._convertedFilename;
                else
                    return null;
            }
        }

        /// <summary>
        /// 为HTML页面参数数组付值
        /// </summary>
        /// <param ></param>
        public void setTemplateFileparameter(string[] param)
        {
            try
            {
                if (param.Length == this.TemplateParamCount)
                    this._templateFileparameter = param;
                //else//与原定义的个数不等
                //
            }
            catch (System.Exception ex)
            {
                WriteErrFile(ex);
            }
        }
        /// <summary>
        /// 为aspx文件中将要替换html文件中的参数数组付值
        /// </summary>
        /// <param ></param>
        public void setAspxFileparameter(string[] param)
        {
            try
            {
                if (param.Length == this.TemplateParamCount)
                    this._aspxFileparameter = param;
                //else//与原定义的个数不等
                //
            }
            catch (System.Exception ex)
            {
                WriteErrFile(ex);
            }
        }
        /// <summary>
        /// 开始进行aspxTohtml转换
        /// </summary>
        /// <returns>返回值为成功创建后的文件名称</returns>
        /// <remarks>在调用此方法之前必需确定已调用setTemplateFileparameter 和setAspxFileparameter方法进行相应的付值操作</remarks>
        public string StartConvert()
        {
            if (this._templateFileparameter.Length == this._aspxFileparameter.Length)
            {
                return writeFile();
            }
            else
            {
                return null;
            }
        }
        /// <summary>
        /// 开始进行aspxTohtml转换
        /// </summary>
        /// <param >html模板页中的所有参数数组</param>
        /// <param >aspx页面中要代替html模板页中参数值数组</param>
        /// <returns>返回值为成功创建后的文件名称</returns>
        public string StartConvert(string[] htmlparam, string[] aspxparam)
        {
            //先调用setTemplateFileparameter 和setAspxFileparameter方法，进行付值操作
            setTemplateFileparameter(htmlparam);
            setAspxFileparameter(aspxparam);
            //
            string fn = this.StartConvert();
            //
            _convertedFilename = fn;
            //
            return fn;
        }

        /// <summary>
        /// 用时间加随机数生成一个文件名
        /// </summary>
        /// <returns></returns>
        private string getfilename()
        {
            //用时间加随机数生成一个文件名
            System.Threading.Thread.Sleep(50);
            string yearStr = System.DateTime.Now.Year.ToString();
            string monthStr = string.Format("{0:0#}", System.DateTime.Now.Month);
            string dayStr = string.Format("{0:0#}", System.DateTime.Now.Day);
            string hourStr = string.Format("{0:0#}", System.DateTime.Now.Hour);
            string minuteStr = string.Format("{0:0#}", System.DateTime.Now.Minute);
            string secondStr = string.Format("{0:0#}", System.DateTime.Now.Second);
            string millisecondStr = string.Format("{0:000#}", System.DateTime.Now.Millisecond);
            System.Random rd = new System.Random();
            return yearStr + monthStr + dayStr + hourStr + minuteStr + secondStr + millisecondStr + string.Format("{0:0000#}", rd.Next(100)) + ".html";
            //return DateTime.Now.ToString("yyyyMMddHHmmss")+".html";
        }
        /// <summary>
        /// 进行转换处理
        /// </summary>
        /// <returns>返回以时间命名的文件名</returns>
        private string writeFile()
        {

            // 读取模板文件
            string temp = HttpContext.Current.Server.MapPath(this.TemplateFilePath);
            StreamReader sr = null;
            string str = "";
            try
            {
                sr = new StreamReader(temp, this.TemplateHtmlCode);
                str = sr.ReadToEnd(); // 读取文件
            }
            catch (Exception ex)
            {
                //HttpContext.Current.Response.Write(exp.Message);
                //HttpContext.Current.Response.End();  
                WriteErrFile(ex);
            }
            finally
            {
                sr.Close();
            }
            // 替换内容
            // 这时,模板文件已经读入到名称为str的变量中了
            for (int i = 0; i < this.TemplateParamCount; i++)
            {
                str = str.Replace(this._templateFileparameter[i], this._aspxFileparameter[i]);
            }

            return savefile(str);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param ></param>
        /// <returns></returns>

        private string savefile(string str)
        {
            // 写文件
            StreamWriter sw = null;
            try
            {

                string path = HttpContext.Current.Server.MapPath(this.HtmlFilePath);
                //html文件名称 
                string htmlfilename = getfilename();
                sw = new StreamWriter(path + htmlfilename, false, this.Code);
                sw.Write(str);
                sw.Flush();
                return htmlfilename;
            }
            catch (Exception ex)
            {
                WriteErrFile(ex);
            }
            finally
            {
                sw.Close();
            }
            return "";
        }

        /// <summary>
        /// 传入URL返回网页的html代码
        /// </summary>
        /// <param >URL</param>
        /// <returns></returns>
        public string getUrltoHtml(string Url)
        {
            try
            {
                System.Net.WebRequest wReq = System.Net.WebRequest.Create(Url);
                System.Net.WebResponse wResp = wReq.GetResponse();
                System.IO.Stream respStream = wResp.GetResponseStream();
                System.IO.StreamReader reader = new System.IO.StreamReader(respStream, System.Text.Encoding.GetEncoding("gb2312"));
                return savefile(reader.ReadToEnd());

            }
            catch (System.Exception ex)
            {
                WriteErrFile(ex);
            }
            return "";
        }
        #endregion


        #region 构造

        public AspxToHtml()
        {
            //
            // TODO: 在此处添加构造函数逻辑
            //   
        }

        private void settemplateParamCount(int templateParamCount)
        {
            if (templateParamCount > 0)
                this.TemplateParamCount = templateParamCount;
        }
        /// <summary>
        /// 提供欲代替的参数个数
        /// </summary>
        /// <param ></param>
        public AspxToHtml(int templateParamCount)
        {
            settemplateParamCount(templateParamCount);

        }
        /// <summary>
        /// 
        /// </summary>
        /// <param >html模板页中的参数个数</param>
        /// <param >生成的html文件所存放的文件夹路径</param>
        /// <param >html模板页路径</param>
        public AspxToHtml(int templateParamCount, string htmlFilePath, string templateFilePath)
        {
            settemplateParamCount(templateParamCount);
            this.HtmlFilePath = htmlFilePath;
            this.TemplateFilePath = templateFilePath;

        }
        #endregion

        #region

        /// <summary>
        /// 把错误写入文件方法#region 把错误写入文件方法
        /// </summary>
        /// <param ></param>
        private void WriteErrFile(Exception ee)
        {

            FileStream fs1 = new FileStream(HttpContext.Current.Server.MapPath(ErrLogPath), System.IO.FileMode.Append);
            StreamWriter sw1 = new StreamWriter(fs1);
            sw1.WriteLine("**************************************************");
            sw1.WriteLine("错误日期:" + System.DateTime.Now);
            sw1.WriteLine("错误描述:" + ee.Message);
            sw1.WriteLine("错误名称:" + ee.Source);
            sw1.WriteLine("详细:" + ee.ToString());
            sw1.WriteLine("*************************************************");
            sw1.Close();
        }
        #endregion
    }



    /// <summary>
    /// AspxToHtml 的摘要说明。
    /// </summary>

    public class AspxToHtml2
    {
        /// <summary>
        /// Aspx文件url
        /// </summary>
        public string strUrl;

        /// <summary>
        /// 生成html文件的保存路径
        /// </summary>
        public string strSavePath;

        /// <summary>
        /// 生成html文件的文件名
        /// </summary>
        public string strSaveFile;

       

        /// <summary>
        /// 将strUrl放到strSavePath目录下，保存为strSaveFile
        /// </summary>
        /// <returns>是否成功</returns>
        public  bool ExecAspxToHtml()
        {
            try
            {
                StringWriter strHTML = new StringWriter();
                System.Web.UI.Page myPage = new Page();   //System.Web.UI.Page中有个Server对象，我们要利用一下它
                myPage.Server.Execute(strUrl, strHTML);    //将asp_net.aspx将在客户段显示的html内容读到了strHTML中
                StreamWriter sw = new StreamWriter(strSavePath + strSaveFile, true, System.Text.Encoding.GetEncoding("GB2312"));
                //新建一个文件Test.htm，文件格式为GB2312
                sw.Write(strHTML.ToString());
                //将strHTML中的字符写到Test.htm中
                strHTML.Close();
                //关闭StringWriter 
                sw.Close();
                //关闭StreamWriter 
                return true;
            }
            catch
            {
                return false;
            }
        }


        /// <summary>
        /// 将Url放到Path目录下，保存为FileName
        /// </summary>
        /// <param name="Url">aspx页面url</param>
        /// <param name="Path">生成html文件的保存路径</param>
        /// <param name="FileName">生成html文件的文件名</param>
        /// <returns></returns>
        public bool ExecAspxToHtml(string Url, string Path, string FileName)
        {
            try
            {
                StringWriter strHTML = new StringWriter();
                System.Web.UI.Page myPage = new Page();
                //System.Web.UI.Page中有个Server对象，我们要利用一下它
                myPage.Server.Execute(Url, strHTML);
                //将asp_net.aspx将在客户段显示的html内容读到了strHTML中
                StreamWriter sw = new StreamWriter(Path + FileName, false, System.Text.Encoding.GetEncoding("GB2312"));
                //新建一个文件Test.htm，文件格式为GB2312
                sw.Write(strHTML.ToString());
                //将strHTML中的字符写到Test.htm中
                strHTML.Close();
                //关闭StringWriter 
                sw.Close();
                //关闭StreamWriter 
                return true;
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// 将Url放到Path目录下，保存为FileName
        /// </summary>
        /// <param name="Url">aspx页面url</param>
        /// <param name="FileName">生成html文件的保存路径文件名</param>
        /// <returns></returns>
        public bool ExecAspxToHtml(string Url, string pathFileName)
        {
            try
            {


                //System.Web.HttpContext.Current.Response.Write(Url + " <br>" + pathFileName);

                //StringWriter strHTML = new StringWriter();
                //System.Web.UI.Page myPage = new Page();
                ////System.Web.UI.Page中有个Server对象，我们要利用一下它
                //myPage.Server.Execute(Url, strHTML);
                ////将asp_net.aspx将在客户段显示的html内容读到了strHTML中
                //StreamWriter sw = new StreamWriter(pathFileName,false, System.Text.Encoding.GetEncoding("GB2312"));
                ////新建一个文件Test.htm，文件格式为GB2312
                //sw.Write(strHTML.ToString());
                ////将strHTML中的字符写到Test.htm中
                //strHTML.Close();
                ////关闭StringWriter 
                //sw.Close();
                ////关闭StreamWriter 


                System.IO.StringWriter sw = new System.IO.StringWriter();
                System.Web.HttpContext.Current.Server.Execute(Url, sw, true);
                //判读时候存在，存在删除
                if (File.Exists(pathFileName))
                {
                    File.Delete(pathFileName);
                }
                //Response.Write(sw);
                System.IO.StreamWriter objwrite = new System.IO.StreamWriter(pathFileName, false, System.Text.Encoding.UTF8);
                objwrite.Write(sw);
                objwrite.Flush();
                objwrite.Close();
                objwrite = null;

                return true;
            }
            catch (Exception ee)
            {
                System.Web.HttpContext.Current.Response.Write("<br>" + ee.Message);
                return false;
            }
        }
    }


    /// <summary>
    /// 调用方法
    /// </summary>
    public class AspxToHtml3
    {   
        /// <summary>
        /// .aspx生成Html或者aspx
        /// </summary>
        /// <param name="Url">"http://www.xxxx.com/default.aspx"</param>
        /// <param name="html">Server.MapPath( "~/index.aspx")或者新的网页</param>
        /// <returns>成功或者失败</returns>
        public static bool aspxToHtml(string Url, string html)
        {

                  

            if (File.Exists(html))
            {
                File.Delete(html);
            }

            StreamWriter sw = null;
            StreamReader reader = null;
            bool ret = true;
            string htmlstr = "";
            try
            {
                System.Net.WebRequest wReq = System.Net.WebRequest.Create(Url);

                //   Get   the   response   instance.  

                wReq.Timeout =200000;//20秒超时 

                System.Net.WebResponse wResp = wReq.GetResponse();
               


                //   Read   an   HTTP-specific   property  
                //if   (wResp.GetType()   ==HttpWebResponse)  
                //{  
                //DateTime   updated     =((System.Net.HttpWebResponse)wResp).LastModified;  
                //}  
                //   Get   the   response   stream.  


                System.IO.Stream respStream = wResp.GetResponseStream();

                reader = new System.IO.StreamReader(respStream, System.Text.Encoding.UTF8);

                htmlstr = reader.ReadToEnd();
                reader.Close();


                string tempstr = htmlstr;


                Regex r1 = new Regex("<input type=\"hidden\" name=\"__EVENTTARGET\".*/>", RegexOptions.IgnoreCase);
                Regex r2 = new Regex("<input type=\"hidden\" name=\"__EVENTARGUMENT\".*/>", RegexOptions.IgnoreCase);
                Regex r3 = new Regex("<input type=\"hidden\" name=\"__VIEWSTATE\".*/>", RegexOptions.IgnoreCase);
                //过滤<form>代码 
                Regex r4 = new Regex("<form name=\"aspnetForm\".*id=\"aspnetForm\">", RegexOptions.IgnoreCase);
                Regex r5 = new Regex("</form>");
                tempstr = r1.Replace(tempstr, "");
                tempstr = r2.Replace(tempstr, "");
                tempstr = r3.Replace(tempstr, "");
                tempstr = r4.Replace(tempstr, "");
                tempstr = r5.Replace(tempstr, "");             
                tempstr=Regex.Replace(tempstr, @"(?s)\n\s*\n", "\n");
                htmlstr = tempstr;

            }
            catch (System.Exception ex)
            {
                HttpContext.Current.Response.Write(ex.Message);
                ret = false;
            }
            finally
            {
                reader.Close();
            }
            try
            {

               
                sw = new StreamWriter(html, false, System.Text.Encoding.UTF8);
                sw.Write(htmlstr);
                sw.Flush();
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write(ex.Message);
           
                HttpContext.Current.Response.End();
                ret = false;
            }
            finally
            {
                sw.Close();
            }

            sw.Dispose();
            reader.Dispose();
         
           // return htmlstr;
            return ret;
        }

     

    }
}
