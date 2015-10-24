using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;

public partial class MenuClick : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RecordStat();
    }

    private void RecordStat()
    {
        //System.Threading.Thread.Sleep(5000);
        string strAbsolutePath = ""; //被引用的访问对象绝对路径
        string strAbsoluteUri = "";//被引用的访问对象全部路径
        string strUri = ""; //当前请求的URL信息
        string strIP = ""; //请求的IP地址
        string strComputerName = "";//请求计算机名

        string strBrownserMajorVersion = "";//获取客户端浏览器的（主）版本号  
        string strBrownserVersion = "";//获取客户端浏览器的完整版本号  
        string strBrowserPlatform = "";//获取客户端使用平台的名字
        string strBrowserType = "";//获取客户端使用浏览器的类型
        string strBrowserName = "";//获取客户端使用浏览器的名字
        string strUA = "";
        string strReferrerUrl = "";//上一页面的URL
        string strUserId = "";

        strUri = Request.Url.AbsoluteUri;
        strBrownserMajorVersion = Request.Browser.MajorVersion.ToString();
        strBrownserVersion = Request.Browser.Version.ToString();
        strBrowserPlatform = Request.Browser.Platform.ToString();
        strBrowserType = Request.Browser.Type.ToString();
        strBrowserName = Request.Browser.Browser.ToString();
        strUA = Request.UserAgent;

        if (Request.UrlReferrer != null)
        {
            strAbsoluteUri = Request.UrlReferrer.AbsoluteUri;
            strAbsolutePath = Request.UrlReferrer.AbsolutePath;

        }


        strReferrerUrl = Request["referrer"];
        strUserId = Request["userid"];
        try
        {
            strIP = GetIPAddress();
            //strComputerName = Dns.GetHostByAddress(strIP).HostName;
            //System.Threading.Thread.Sleep(10000);
        }
        catch (Exception ex)
        {

        }


        HZY.COM.Common.Log.WirteLog_Menu_Click(strAbsolutePath, strAbsoluteUri, strUri, strIP, strComputerName, strBrownserMajorVersion, strUA, strBrowserPlatform, strBrowserType, strBrowserName, strReferrerUrl, strUserId);

    }

    /// <summary>
    /// 获取客户端IP地址
    /// </summary>
    /// <returns></returns>
    public static string GetIPAddress()
    {
        string user_IP = string.Empty;
        if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null)
        {
            if (System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"] != null)
            {
                user_IP = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
            }
            else
            { user_IP = System.Web.HttpContext.Current.Request.UserHostAddress; }
        }
        else
        {
            user_IP = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"].ToString();
        } return user_IP;
    }
}