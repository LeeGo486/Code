using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;

/// 类名：Userinfo
/// 类说明：PLMAS-产品-用户信息获取
/// 创建人：马卫清
/// 创建日期：2014-04-21
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.PLMAS
{

    public class Userinfo : HZYLogicBase, ILogicGetData
    {
        public Userinfo()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("PLM_AS");
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

                if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETDesignerInfo".ToUpper())
                {
                    string strCBSTCO = dtList.Rows[0]["CBSTCO"].ToString();

                    if (strCBSTCO == "")
                    {
                        throw new Exception("传入的参数有误！");
                    }

                    string strSQL = @"
                                SELECT CBTX40 FROM pbinfo
                                WHERE CBSTCO=@Param0
                ";
                    ds_Return = conn.GetDataSet(strSQL, new string[] { strCBSTCO });

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
