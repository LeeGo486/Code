using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WSRR_Search
/// 类说明：对服务申请和WSRR的信息进行高级搜索
/// 创建人：马卫清
/// 创建日期：2014-03-21
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{

    public class WSRR_Search : HZYLogicBase, ILogicGetData
    {
        public WSRR_Search()
        {
            this.m_SessionCheck = false;

        }

        private Dbconn conn = new Dbconn("WSRR");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        int m_Page = 1;
        int m_Rows = 20;

        public DataSet GetData()
        {

            DataSet ds = new DataSet();
            DataSet ds_Return = new DataSet();

            string strXML = "";

            strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            ds = Common.Common.GetDSByExcelXML(strXML);

            Dbconn conn = new Dbconn("WSRR");
            DataTable dtOptype = ds.Tables["OPTYPE"];
            DataTable dtList = ds.Tables["LIST"];

            if (dtOptype.Rows[0][0].ToString().ToUpper() == "GET")
            {
                string strKeyWord = dtList.Rows[0]["KeyWord"].ToString();
                string strSQL = @"
                            SELECT   
                                 WS_Applay_ID ,
						         WS_Name ,
						         CONVERT(VARCHAR(10),Applay_Time,21) Applay_Time ,
						         Appliay_User ,
						         Function_Name ,
						         state ,
						         WS_Content ,
						         Input_Format ,
						         Return_Format ,
						         WS_DeployServer ,
						         WS_SPName ,
						         Logic_Content ,
						         Code ,
						         Service_Path ,
						         WS_SP_Server
                            FROM    [dbo].[WS_Applay] WITH ( NOLOCK )
                            WHERE   FREETEXT ( WS_Name, @Param0 )
                                    OR FREETEXT ( WS_Name, @Param0 )
                                    OR FREETEXT ( Appliay_User, @Param0 )
                                    OR FREETEXT ( state, @Param0 )
                                    OR FREETEXT ( WS_Content, @Param0 )
                                    OR FREETEXT ( Input_Format, @Param0 )
                                    OR FREETEXT ( Return_Format, @Param0 )
                                    OR FREETEXT ( WS_DeployServer, @Param0 )
                                    OR FREETEXT ( WS_SPName, @Param0 )
                                    OR FREETEXT ( Logic_Content, @Param0 )
                                    OR FREETEXT ( Code, @Param0 )
                                    OR FREETEXT ( Service_Path, @Param0 )
                                    OR FREETEXT ( Function_Name, @Param0 )
                                    OR FREETEXT ( WS_SP_Server, @Param0 )

                                ";

                ds_Return = conn.GetDataSetForPageList(strSQL, new string[1] { strKeyWord }, m_hzyPageInfo);
            }
            return ds_Return;

        }
    }

}