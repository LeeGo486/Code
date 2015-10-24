using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.ST1005A;
using HZY.COM.Common.Base;

namespace HZY.COM.UpdateByXML
{

    public class DHH_W_CLOTH_NF : LogicBase, ILogicGetData
    {
        public DHH_W_CLOTH_NF()
        {
            this.m_SessionCheck = true;
        }

        /// <summary>
        /// Test
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strXML = this.m_request.Tables[0].Rows[0]["XML"].ToString();

                ServerMDM_AccountQuery_GetByValues sqlServer = new ServerMDM_AccountQuery_GetByValues();
                string strConn = sqlServer.GetConnectionStr("HZY_DHH", "PROD", "maweiqing", "KIJS7^x");

                Dbconn conn = new Dbconn(strConn,true);

                DataSet ds = conn.GetDataSetBySP("WSXML_W_CLOTH_DHH_NF", new string[1] { "XML" }, new string[1] { strXML });
                return ds;
            }
            catch
            {
                throw;

            }



        }

    }
}