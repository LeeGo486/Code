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
    ///MDM_System_GetDataCombox 取到系统用户Combox
    /// </summary>
    public class MDM_System_GetDataCombox : LogicBase, ILogicGetData
    {
        public MDM_System_GetDataCombox()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("VexSSO");
            DataSet ds = conn.GetDataSet(@"
                 SELECT                 [system_ID] 系统ID,
                                        [system_code] +' ' + [System_Name] 系统编号
                    FROM dbo.MDM_System WITH(NOLOCK)
                    ORDER BY system_code ");
            return ds;
        }

    }

}