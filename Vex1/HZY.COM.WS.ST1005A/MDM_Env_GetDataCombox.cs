using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.ST1005A
{
    /// <summary>
    /// MDM_SysEnv_GetDataCombox 取到系统环境Combox
    /// </summary>
    public class MDM_SysEnv_GetDataCombox : LogicBase, ILogicGetData
    {
        public MDM_SysEnv_GetDataCombox()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM");
            DataSet ds = conn.GetDataSet(@"
                 SELECT                 [Env_ID] 环境ID,
                                        [Env_SN] +' ' + [Env_Name] 环境名称
                    FROM dbo.MDM_System_Env WITH(NOLOCK)
                    ORDER BY 环境名称 ASC");
            return ds;
        }

    }

}