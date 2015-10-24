using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Talent.Web
{
    /// <summary>
    /// ajaxWebServices 的摘要说明
    /// </summary>
    public class ajaxWebServices : IHttpHandler,IRequiresSessionState 
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.Clear();
            // context.Response.ContentType = "application/json";
            context.Response.ContentType = "text/plain";
            string tmp = Common.Constants.getReqValue(context.Request, "webmethod");
            string message = "";
            string callbackType = "";
            string forwardurl = "";
            string navTabId = Common.Constants.getReqValue(context.Request, "navTabId");
            string saveOrSummit = "99";
            int id = 0;
            int statusCode = 0;

          /*  if (tmp.StartsWith("xheditoraddImage")) 
            {
                context.Response.Write(addImage(context.Request));
                context.Response.End();
                return;
            }

            if (tmp == "login") 
            {
                context.Response.Write(checkUser(context.Request));
                context.Response.End();
                return;
            }
            */
            var userid = Tools.SessionHelper.Get("userid");
            if (userid == null || userid.Trim() == "")
            {
                statusCode = -1;
                message = "登录状态异常，请重新登录";
            }
            else
            {
                switch (tmp)
                {
                  /*  case "addTopic":
                        callbackType = "closeCurrent";
                        statusCode = HotSuject.AddTopic(context.Request, ref message);
                        break;*/
                    case "addTalentClass":
                        callbackType = "closeCurrent";
                        statusCode = TalentClass.TalentClassCx.AddTalentClass(context.Request, ref message);
                        break;
                    case "delTalentClass":
                        statusCode = TalentClass.TalentClassCx.DelTalentClass(context.Request, ref message);
                        break;
                    case "updateTalentClass":
                        callbackType = "closeCurrent";
                        statusCode = TalentClass.TalentClassCx.UpdateTalentClass(context.Request, ref message);
                        break;
                    case "addLabelCompanyDialog":
                        callbackType = "closeCurrent";
                        statusCode = TalentInfo.TalentInfo.AddLabelCompanyDialog(context.Request, ref message,ref id);
                        break;
                    case "updateTalentInfo":
                        callbackType = "closeCurrent";
                        statusCode = TalentInfo.TalentInfo.UpdateTalentInfo(context.Request, ref message, ref id);
                        break;
                    case "delTalentInfo":
                        statusCode = TalentInfo.TalentInfo.DelTalentInfo(context.Request, ref message);
                        break;
                    case "addTalentDocument":
                        statusCode = TalentInfo.TalentDocument.AddTalentDocument(context.Request, ref message, ref forwardurl);
                        break;
                    case "delTalentDocument":
                        statusCode = TalentInfo.TalentDocument.DelTalentDocument(context.Request, ref message, ref forwardurl);
                        break;
                    case "addTalentUpkeep":
                        statusCode = TalentInfo.TalentUpkeep.AddUpkeep(context.Request, ref message, ref forwardurl);
                        break;
                    case "delTalentUpkeep":
                        statusCode = TalentInfo.TalentUpkeep.DelTalentUpkeep(context.Request, ref message, ref forwardurl);
                        break;
                    case "addAddressBook": /*增加通讯录*/
                        statusCode = Authority.AuthorityCx.AddAddressBook(context.Request, ref message);
                        break;
                    case "updateQx": /*修改权限*/
                        callbackType = "closeCurrent";
                        statusCode = Authority.AuthorityCx.UpdateQx(context.Request, ref message);
                        break;
                    case "delAuthorityList":
                        statusCode = Authority.AuthorityCx.DelAuthorityList(context.Request, ref message);
                        break;
                    default:
                        statusCode = 0;
                        message = "没有定义该方法【" + tmp + "】";
                        break;
                }
            }
            context.Response.Write("{\"statusCode\":\"" + statusCode + "\",\"message\":\"" + message + "\", \"navTabId\":\"" + navTabId + "\", \"rel\":\"" + Common.Constants.getReqValue(context.Request, "rel") + "\", \"callbackType\":\"" + callbackType + "\",\"forwardUrl\":\"" + forwardurl + "\",\"confirmMsg\":\"\",\"saveOrSummit\":\"" + saveOrSummit + "\",\"addId\":\""+ id +"\"}");
            context.Response.End();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}