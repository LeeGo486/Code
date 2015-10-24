using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;


/// 类名：ITSM_Common 
/// 类说明：ITSM通用函数
/// 创建人：马卫清
/// 创建日期：2013-06-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.ITSM
{
    /// <summary>
    /// ITSM通用函数
    /// </summary>
    public class ITSM_Common 
    {
        public ITSM_Common()
        {
           
        }

        public static void SendAMMessage(string strGuid, string strAMRevier,string strKey_Code)
        {
            SendAMMessage(strGuid, strAMRevier, "您有需要审批的服务器申请单", "您有需要审批的服务器申请单(" + strKey_Code + "),<a href=http://192.168.0.88:8001/Check.aspx?id=" + strGuid + " target=_blank>点击查看</a>");
        }

        public static void SendAMMessage(string strGuid, string strAMRevier,string strTitle,string strContent)
        {
            AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
            string strResult = msg.SendSubjectMsg("AM", "ITSM", strTitle, strAMRevier, "信息部服务中心", strContent, DateTime.Now.AddHours(-1).ToString("yyyy-MM-dd HH:mm:ss"), "1");
        }

    }

}