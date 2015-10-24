using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：WS_Cfg_List_ForEasyUICombox
/// 类说明：获取WSRR的配置列表信息
/// 创建人：马卫清
/// 创建日期：2013-09-22
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{
    /// <summary>
    ///WS_Cfg_List_ForEasyUICombox 获取WSRR的配置列表信息
    /// </summary>
    public class WS_Cfg_List_ForEasyUICombox : LogicBase, ILogicGetData
    {
        public WS_Cfg_List_ForEasyUICombox()
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

                string strCfg_Type = m_request.Tables[0].Rows[0]["ComboxType"].ToString();
                ds_Return = GetCfgData(strCfg_Type);

                return ds_Return;
            }
            catch
            {
                throw;

            }



        }


        private DataSet GetCfgData(string strCfg_List_Type)
        {
            DataSet ds_Return = new DataSet();

            if (strCfg_List_Type == "")
            {
                throw new Exception("列表类型不能为空!");
            }

            Dbconn conn = new Dbconn("WSRR_Manager");
            ds_Return = conn.GetDataSet(@"
                    SELECT  
                            cfgListID as id,
                            cfgListName as text 
                    FROM dbo.CfgList
                    WHERE cfgList_type=@param0
                    order by SeqNo asc
            ", new string[1] { strCfg_List_Type });

            return ds_Return;
        }
    }

}