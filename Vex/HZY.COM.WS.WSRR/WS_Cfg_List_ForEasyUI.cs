using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：WS_Cfg_List_ForEasyUI
/// 类说明：获取WSRR的配置列表信息
/// 创建人：马卫清
/// 创建日期：2013-09-22
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    ///WS_Cfg_List_ForEasyUI 获取WSRR的配置列表信息
    /// </summary>
    public class WS_Cfg_List_ForEasyUI : LogicBase, ILogicGetData
    {
        public WS_Cfg_List_ForEasyUI()
        {
            this.m_SessionCheck = true;

        }

        /// <summary>
        /// 获取WSRR的配置列表信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
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
                        string strCfg_Type = ds.Tables[i].Rows[0]["Cfg_List_Type"].ToString();
                        
                    }                    
                }



                return ds_Return;
            }
            catch  
            {
                throw;

            }



        }

    }

}