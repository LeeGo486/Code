using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HZY.COM.Common.DBAccess;

namespace HZY.COM.WS.AM
{
    /// <summary>
    /// 短信发送，立即
    /// </summary>
    public class SMSSendImmediately
    {
        public SMSSendImmediately()
        {
        }

        public static void Send(string pstrPhoneNumber, string pstrContent)
        {
            pstrPhoneNumber = pstrPhoneNumber.Replace("'", "");
            pstrContent = pstrContent.Replace("'", "");

            Dbconn conn = new Dbconn("SMS");
            string strSQL = @"
                EXEC SMS.DBO.sp_smstosend 'SMS', 'POS', '" + pstrPhoneNumber + @"', '', '" + pstrContent + @"', '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff") + @"',
                    '1', '' ;
                EXEC SMS.DBO.sp_smspush_phone '" + pstrPhoneNumber + @"';
            ";

            conn.Excute(strSQL);
        }
    }
}
