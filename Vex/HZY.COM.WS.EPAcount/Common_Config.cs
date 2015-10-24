using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

namespace HZY.COM.WS.EPAcount
{
    class Common_Config : LogicBase, ILogicGetData
    {
        public Common_Config()
        {
            this.m_SessionCheck = false;
        }
        private Dbconn conn = new Dbconn("VexSSO");

        /// 系统通用配置信息
        public DataSet GetData()
        {
            DataSet ds = new DataSet();
            DataSet ds_Return = new DataSet();
            string strXML = "";
            strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            ds = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
            for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
            {
                if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                {
                    DataTable dt_list = ds.Tables["LIST"];
                    string common_config_type = dt_list.Rows[i][0].ToString();
                    if (common_config_type == "菜单类型")
                    {
                        DataTable dt = new DataTable();
                        dt.Columns.Add("ID");
                        dt.Columns.Add("value");
                        dt.Rows.Add(new object[] { "1", "菜单" });
                        dt.Rows.Add(new object[] { "2", "模块" });
                        ds_Return.Tables.Add(dt);
                    }
                }
            }
            return ds_Return;
        }
    }
}
