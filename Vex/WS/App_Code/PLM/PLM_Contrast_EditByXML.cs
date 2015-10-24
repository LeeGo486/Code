using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// <summary>
///PLM_Contrast_EditByXML 的摘要说明
/// </summary>

namespace HZY.COM.PLM
{
    public class PLM_Contrast_EditByXML : LogicBase, ILogicGetData

{
	public PLM_Contrast_EditByXML()
	{
        this.m_SessionCheck = true;
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public DataSet GetData()
    {
        try
        {

            
            string strSQL = "";
            string strwhere = m_request.Tables[0].Rows[0]["where"].ToString();

            //if (strwhere == "")
            //{
            //    strwhere = " 1=1 ";
            //}ERP_TEST

            Dbconn conn = new Dbconn("ERP_PROD");

            strSQL = @"SELECT rtrim(CTSTKY) CTSTKY,rtrim(CTTX40) CTTX40 FROM CSYTAB WHERE CTSTKY like 'N2%' and CTSTKY not in ('N207','N209','N211')  and  CTSTCO=   '" + strwhere + "'";

            DataSet ds = conn.GetDataSet(strSQL);
            return ds;

        }


        catch
        {
            throw;
        }
    }
}
}