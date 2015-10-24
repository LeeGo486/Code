using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using HZY.COM.Common.Base;

/// 类名：Designers
/// 类说明：PLMAS-产品-获取设计师信息
/// 创建人：马卫清
/// 创建日期：2014-04-21
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.PLMAS
{

    public class Designers : HZYLogicBase, ILogicGetData
    {
        public Designers()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn;
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dtOPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                var strzt = dtList.Rows[0]["zt"].ToString();//获取帐套

                conn = new Dbconn("PLM_AS_" + strzt);


                if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETComboxBySession".ToUpper())
                {
//                    string strUserPost = conn.GetDataTableFirstValue(@"
//                                                                        SELECT  UserPost
//                                                                        FROM    Userinfo
//                                                                        WHERE   username = @Param0
//                                                                        ", new string[] { m_hzyMessage.User_Name }).ToString();

                    string strOwnBrand = dtList.Rows[0]["OwnBrand"].ToString(),

                           strSQL = @"SELECT CBTX40 FROM PBINFO
                                      WHERE CBSTCO = '设计师' AND CBTX15 = '"+strOwnBrand+"'";

//                    if (strUserPost == "管理员")
//                    {
//                        strSQL = @"
//                                    SELECT  UserNameC
//                                    FROM    Userinfo
//                                    WHERE   UserPost = '设计师'";
//                    }
//                    else if (strUserPost == "设计师" || strUserPost == "版师助理")
//                    {
//                        strSQL = @"
//                                SELECT  UserNameC
//                                FROM    Userinfo
//                                WHERE   OwnedBrand IN (
//                                SELECT OwnedBrand FROM Userinfo
//                                WHERE username=@param0
//                                )
//                                and UserPost = '设计师'
//                        ";
//                    }
//                    else
//                    {
//                        strSQL = @"
//                                SELECT  UserNameC
//                                FROM    Userinfo
//                                WHERE username=@param0";
//                    }

                    ds_Return = conn.GetDataSet(strSQL, new string[] { m_hzyMessage.User_Name });

                }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}
