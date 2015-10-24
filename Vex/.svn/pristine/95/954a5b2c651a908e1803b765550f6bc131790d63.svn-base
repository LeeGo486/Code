using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.ST1005A;
using HZY.COM.Common.Base;

 
namespace HZY.COM.WS.MDM2
{

    public class MDM2_DEPOT_Clothing_Info : HZYLogicBase, ILogicGetData
    {
        public MDM2_DEPOT_Clothing_Info()
        {
            this.m_SessionCheck = false ;
        }

        private Dbconn conn = new Dbconn("F22GP");

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                //根据用户登录信息取到权限信息
                MDM_System_User_Authorization_GetListBySession_ID cls = new MDM_System_User_Authorization_GetListBySession_ID();
                cls.hzyMessage = this.hzyMessage;
                DataSet dsAUZ = cls.GetData();

                string strComList = "";
                if (dsAUZ.Tables[0].Rows.Count > 0)
                {
                    DataRow[] listAuzCom = dsAUZ.Tables[0].Select("Authorization_Name" + " like'%COM%'");
                    for (int k = 0; k < listAuzCom.Length; k++)
                    {
                        if (k > 0)
                        {
                            strComList += ",";
                        }
                        string strCom = listAuzCom[k]["Authorization_Name"].ToString();
                        strComList += strCom.Substring(strCom.Length - 1);
                    }
                }
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    //判断款号是否存在
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "CHECKCLOTHING")
                    {
                        string strSQL = @"
                                        SELECT  count(1) AS COUNT
                                            FROM j_clothing WITH(NOLOCK)
                                        WHERE  1=1" + m_hzyPageInfo.Where;
                        //ds_Return = conn.GetDataSetForPageList(strSQL + strWhereTmp, new string[0],m_hzyPageInfo);
                        ds_Return = conn.GetDataSet(strSQL);
                    }
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETALLCLOTHING")
                    {
                        string strSQL = @"
                                        SELECT  *
                                            FROM j_clothing WITH(NOLOCK)
                                        WHERE  1=1" + m_hzyPageInfo.Where;
                        //ds_Return = conn.GetDataSetForPageList(strSQL + strWhereTmp, new string[0],m_hzyPageInfo);
                        ds_Return = conn.GetDataSet(strSQL);
                    }
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
