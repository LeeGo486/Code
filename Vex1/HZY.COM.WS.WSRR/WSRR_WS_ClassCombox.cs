using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

namespace HZY.COM.WSRR
{
    /// <summary>
    ///WSRR_WS_ClassCombox 取到WS分类Combox
    /// </summary>
    public class WSRR_WS_ClassCombox : LogicBase, ILogicGetData
    {
        public WSRR_WS_ClassCombox()
        {
            this.m_SessionCheck = false;

        }

        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("WSRR");
            DataSet ds = conn.GetDataSet(@"
                 WITH    cte ( Class_ID, P_Class_ID, Class_Name, Class_Name_all
)
          AS (--父项 
               SELECT   Class_ID ,
                        P_Class_ID ,
                        CONVERT(VARCHAR(200), Class_Name) ,
                        CONVERT(VARCHAR(200), Class_Name) 
                        --,
                        --CONVERT(VARCHAR(100), RIGHT('0000'
                        --                            + CONVERT(VARCHAR(10), ROW_NUMBER() OVER ( ORDER BY class_ID )),
                        --                            4)) OrderIndex
               FROM     ws_Class
               WHERE    1 = 1
                        AND P_Class_ID = 0
               UNION ALL 
               SELECT   t1.Class_ID ,
                        t1.P_Class_ID ,
                        CONVERT(VARCHAR(200), t1.Class_Name) ,
                        CONVERT(VARCHAR(200), t2.Class_Name_all + '\'
                        + t1.Class_Name) AS CN_GROUP_NAME 
                        --,
                        --CONVERT(VARCHAR(100), OrderIndex + RIGHT('0000'
                        --                                      + CONVERT(VARCHAR(4), ROW_NUMBER() OVER ( ORDER BY t1.class_ID )),
                        --                                      4))
               FROM     ws_Class t1 WITH ( NOLOCK )
                        INNER JOIN cte AS t2 ON t1.P_Class_ID = t2.Class_ID
             )
             
             SELECT Class_ID, Class_Name_all, P_Class_ID, Class_Name
             FROM cte;

            ");
            return ds;
        }

    }

}