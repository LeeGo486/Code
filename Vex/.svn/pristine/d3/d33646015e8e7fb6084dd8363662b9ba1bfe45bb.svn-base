using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.DBAccess;

/// 类名：WS_Cfg_List
/// 类说明：获取WSRR的配置列表信息
/// 创建人：马卫清
/// 创建日期：2014-03-26
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    ///WS_Cfg_List 获取WSRR的配置列表信息
    /// </summary>
    public class WS_Cfg_List : LogicBase, ILogicGetData
    {
        public WS_Cfg_List()
        {
            this.m_SessionCheck = false;

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

            Dbconn conn = new Dbconn("WSRR");
            ds_Return = conn.GetDataSet(@"
                    SELECT  
                            cfg_List_ID as id,
                            cfg_List_Name as text 
                    FROM dbo.Cfg_List
                    WHERE cfg_List_type=@param0
                    order by Seq_No asc
            ", new string[1] { strCfg_List_Type });

            return ds_Return;
        }
    }

}