using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HZY.COM.WS.AM
{
    public class AMSendMsg
    {
        public AMSendMsg()
        {
        }

        public static string Send(string pstrType, string pstrSystem, string pstrReceiver,
            string pstrSender, string pstrContent, string pstrSendTime)
        {
            AMSendWS.MsgCenter msg = new AMSendWS.MsgCenter();
            return msg.SendMsg(pstrType, pstrSystem, pstrReceiver, pstrSender, pstrContent, pstrSendTime);

        }
    }
}
