using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;


namespace HZY.COM.PLM
{
    /// <summary>
    ///PLM_MaterialCount_EditByXML 的摘要说明
    /// </summary>
    public class PLM_MaterialCount_EditByXML : LogicBase, ILogicGetData
    {
        public PLM_MaterialCount_EditByXML()
        {
            this.m_SessionCheck = false;
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        public DataSet GetData()
        {
            string strdt1 = "";
            string strdt2 = "";
            string strpp = "";
            string strlx = "";

            try
            {
                if (m_request != null && m_request.Tables.Count > 0)
                {
                    strdt1 = m_request.Tables[0].Rows[0]["datetimemin"].ToString();
                    strdt2 = m_request.Tables[0].Rows[0]["datetimemax"].ToString();
                    strpp = m_request.Tables[0].Rows[0]["brand"].ToString();
                    strlx = m_request.Tables[0].Rows[0]["season"].ToString();
                }

                if (strdt1 == "" || strdt2 == "" || strpp == "")
                {
                    throw new Exception("参数为空");
                }

                string[] strParam = new string[4];
                string[] strValue = new string[4];
                strParam[0] = "@DT1";
                strParam[1] = "@DT2";
                strParam[2] = "@PP";
                strParam[3] = "@LB";

                strValue[0] = strdt1;
                strValue[1] = strdt2;
                strValue[2] = strpp;
                strValue[3] = strlx;

                Dbconn conn = new Dbconn("ERP_PROD");
                DataSet ds = conn.GetDataSetBySP("SP_PLM_WHLOCount", strParam, strValue);


                return ds;
            }
            catch
            {
                throw;
            }
        }
    }


}