using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.CRM
{
    /// <summary>
    ///CRM_InPut_EditByXML 的摘要说明
    /// </summary>
    public class CRM_InPut_EditByXML : LogicBase, ILogicGetData
    {
        public CRM_InPut_EditByXML()
        {
            this.m_SessionCheck = false;
        }

        public DataSet GetData()
        {
             
            try
            {
                string strXML = this.m_request.Tables[0].Rows[0]["XML"].ToString();

                CRM_WSRR.WS_System ws = new CRM_WSRR.WS_System();

                CRM_EAI.WS_EAI EAI = new CRM_EAI.WS_EAI();
                
                CRM_EAI.WSO_SOAPHeader HEADER = new CRM_EAI.WSO_SOAPHeader();

                //取SessionID
                string str = ws.login("admin", "", 2);

                HEADER.PHPSESSID = str;

                EAI.WSO_SOAPHeaderValue = HEADER;

                string  str1 = EAI.process(strXML);

                return Common.Common.GetRequestDataSet(new string[1] { "Message" }, new string[1] { str1 });
                
            }
            catch
            {
                throw;
            }
        }
        
        
    }
}