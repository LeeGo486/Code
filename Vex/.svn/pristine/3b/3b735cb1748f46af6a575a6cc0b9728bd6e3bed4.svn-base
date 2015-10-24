<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Data;
using System.Web;
using System.Web.SessionState;
using System.Collections;
using System.Diagnostics;
using HZY.COM.WEB;


public class Handler : IHttpHandler, IRequiresSessionState
{
    private HandlerCfg m_HzyCfg = new HandlerCfg("HZY_DOR", "HZY_DOR");

    public void ProcessRequest(HttpContext context)
    {

        ////免登录设置，发布时需要删除
        //context.Session["SessionID" + m_HzyCfg.m_App] = "ad48a0e1-61a8-498f-bb48-7900707dfa14"; //测试库
        //context.Session["UserName" + m_HzyCfg.m_App] = "蒋国贤";
        //context.Session["DepotID" + m_HzyCfg.m_App] = "E1308002";
        //context.Session["DepotName" + m_HzyCfg.m_App] = "郭琦琦";
        //context.Session["SessionID"] = "23190b09-d963-49ed-b112-8af2f217202b"; //测试库
        //context.Session["UserName"] = "刘洪";
        //context.Session["SessionID"] = "7699c81e-d7c0-4d29-8612-eebbc611f242";//正式库
        //context.Session["SessionID"] = null; //测试库

        //不让浏览器缓存
        context.Response.Buffer = true;
        context.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        context.Response.AddHeader("pragma", "no-cache");
        context.Response.AddHeader("cache-control", "");
        context.Response.CacheControl = "no-cache";
        context.Response.ContentType = "text/plain";

        CallByJSON(context);
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

    #region "CallByJSON"
    public void CallByJSON(HttpContext context)
    {

        try
        {
            if (context.Request["WSID"].ToString() == "LoginName")
            {
                if (context.Session["UserName" + m_HzyCfg.m_App] == null)
                {
                    context.Session["UserName" + m_HzyCfg.m_App] = "";
                }

                context.Response.Write("{\"UserName\":\"" + context.Session["UserName" + m_HzyCfg.m_App].ToString() + "\"}");
            }
            else if (context.Request["WSID"].ToString() == "DepotID")
            {
                if (context.Session["DepotID" + m_HzyCfg.m_App] == null)
                {
                    context.Session["DepotID" + m_HzyCfg.m_App] = "";
                }

                context.Response.Write("{\"DepotID\":\"" + context.Session["DepotID" + m_HzyCfg.m_App].ToString() + "\"}");
            }
            else if (context.Request["WSID"].ToString() == "DepotName")
            {
                if (context.Session["DepotName" + m_HzyCfg.m_App] == null)
                {
                    context.Session["DepotName" + m_HzyCfg.m_App] = "";
                }

                context.Response.Write("{\"DepotName\":\"" + context.Session["DepotName" + m_HzyCfg.m_App].ToString() + "\"}");
            }
            else if (context.Request["WSID"].ToString() == "Ip")
            {
                if (context.Session["Ip" + m_HzyCfg.m_App] == null)
                {
                    context.Session["Ip" + m_HzyCfg.m_App] = "";
                }
                string Ip = context.Request.UserHostAddress;
                context.Response.Write("{\"Ip\":\"" + context.Session["Ip" + m_HzyCfg.m_App].ToString() + "\"}");
            }
                
            else
            {
               
                DataSet ds_Request = WebHandler.GetRequestData(context, m_HzyCfg);

                string strXML = WebHandler.GetXMLFromDS(ds_Request, m_HzyCfg);

                
                WSRR.WSRR wsrr = new WSRR.WSRR();
                wsrr.Timeout = 1000 * 60 * 60;
                string strResult = wsrr.CallByXML(strXML);//F11进后台
               
                //strResult = strResult.Replace("&gt;", ">").Replace("&lt;", "<").Replace("&amp;", "&");
                
                //登录接口
                if ((m_HzyCfg.m_WSID == "550fc164-adc8-4f88-bc9d-73c4248050bc"
                    || m_HzyCfg.m_WSID == "08d42db4-d2b3-4999-a3ea-8b4be8f2333e"
                    ) && !strResult.StartsWith("Error"))
                {
                    
                    //string Ip = context.Request.UserHostAddress;
                    //context.Session["Ip" + m_HzyCfg.m_App] = Ip;
                    
                    context.Session["DepotID" + m_HzyCfg.m_App] = null;
                    context.Session["DepotName" + m_HzyCfg.m_App] = null;
                    context.Session["SessionID" + m_HzyCfg.m_App] = strResult;
                    
                    
                    context.Session["UserName" + m_HzyCfg.m_App] = context.Request["UserName"];

                    //根据SessionID获取用户信息
                    string strXML1 = @"
                                <Interface WSID=""03b960ad-e6f2-4378-b060-5f7f29059e24""  App=""" + m_HzyCfg.m_App + @""" 
                                SessionID=""" + strResult + @""">
                                <SessionID>" + strResult + @"</SessionID>
                                </Interface>";

                    strResult = wsrr.CallByXML(strXML1);
                    DataSet dsUserInfo = HZY.COM.Common.Common.GetDSByExcelXML(strResult,false);
                    if (dsUserInfo.Tables.Count > 0 && dsUserInfo.Tables[0].Rows.Count > 0)
                    {
                        string strUserName_CN = dsUserInfo.Tables[0].Rows[0]["App_UserName_CN"].ToString();
                        context.Session["UserName" + m_HzyCfg.m_App] = strUserName_CN;
                        if (strUserName_CN.Length > 8 && strUserName_CN.Substring(8, 1) == "_")
                        {
                            context.Session["DepotID" + m_HzyCfg.m_App] = strUserName_CN.Substring(0, 8);
                            context.Session["DepotName" + m_HzyCfg.m_App] = strUserName_CN.Substring(9); 
                        }
                    }

                    context.Response.Write("{\"Result\":\"登录成功\"}");
                }
                
                else
                {
                    context.Response.Write(WebHandler.GetJSONFromXML(strResult, context, m_HzyCfg));
                }
                
                #region GetIP
                string Ip = "";
                try
                {
                    Ip = context.Request.UserHostAddress;
                    context.Session["Ip" + m_HzyCfg.m_App] = Ip;
                }
                catch (Exception ex)
                {

                }
                #endregion
                
            }
        }
        catch (Exception ex)
        {
            string strMessage = ex.Message;
            if (ex.Message == "")
            {
                strMessage = ex.ToString().Replace("\"", "").Replace("'", "");
            }
            if (strMessage == "")
            {
                strMessage = "未知错误";
            }
            context.Response.Write("{\"Error\":\"" + ex.ToString().Replace("\"", "").Replace("'", "") + "\"}");

        }
        finally
        {
            context.Response.End();
        }

    }
    #endregion


}