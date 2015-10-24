using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1000A
{
    /// <summary>
    ///ESB_SP_PSKU 根据任务编号获取需求报表明细
    /// </summary>
    public class ESB_SP_PSKU_DL : LogicBase, ILogicGetData
    {
        public ESB_SP_PSKU_DL()
        {
            this.m_SessionCheck = false;
        }

        public DataSet GetData()
        {
            string strxm = "";
            string strfromId = "";
            string strtoid = "";

            try
            {
                if (m_request != null && m_request.Tables.Count > 0)
                {
                    strxm = m_request.Tables[0].Rows[0]["xm"].ToString();
                    strfromId = m_request.Tables[0].Rows[0]["fromId"].ToString();
                    strtoid = m_request.Tables[0].Rows[0]["toid"].ToString();
                }

                if (strxm == "" || strfromId == "" ||strtoid == "")
                {
                    throw new Exception("参数为空");
                }

                string[] strParam = new string[3];
                string[] strValue = new string[3];
                strParam[0] = "@xm";
                strParam[1] = "@fromId";
                strParam[2] = "@toid";

                strValue[0] = strxm;
                strValue[1] = strfromId;
                strValue[2] = strtoid;

                Dbconn conn = new Dbconn("DpPrint_ESB");
                DataSet ds = conn.GetDataSetBySP("printsku_DL20150117", strParam, strValue);

                ArrayList columnList = new ArrayList();
                columnList.Add("SKUID");
                columnList.Add("ID0");
                columnList.Add("ID");
                columnList.Add("SEQ");
                columnList.Add("SKU");

                for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
                {
                    if(! columnList.Contains(ds.Tables[0].Columns[i].ColumnName.ToUpper()))
                    {
                        ds.Tables[0].Columns.Remove(ds.Tables[0].Columns[i].ColumnName);
                        i--;
                    }
                }
                return ds;
            }
            catch
            {
                throw;
            }
        }

    }

}