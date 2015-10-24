using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：DRP_Comment_EditByXML.cs.cs
/// 类说明：店铺查询
/// 创建人：钱超
/// 创建日期：2013-09-17
/// 修改人：
/// 修改日期： 
namespace HZY.COM.DRP
{
    /// <summary>
    /// 根据XML内容查询店铺查询
    /// </summary>
    public class class1 : LogicBase, ILogicGetData
    {
        public class1()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容询店铺查询
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();
                Dbconn conn = new Dbconn();
                ArrayList listAMSendList = new ArrayList();

                string strXML = "";
                string strSQL = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                //XML是前台传入
                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {

                    conn = new Dbconn("MDM");



                    //if (ds.Tables["LIST"].Rows[0]["CONO"].ToString().Trim() == "YL")
                    //{
                    //    conn = new Dbconn("YL_F22");

                    //}

                    string strWHERE = " and 1=1";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }
                    strSQL = @" SELECT 
                                    DEPOT.J_DQ,
                                    DEPOT.J_DEPOTID,
                                    SUBSTRING(POSUSER.J_NOTES,3,LEN(POSUSER.J_NOTES)) AS  J_NOTES 
                                    FROM POSUSER,DEPOT                          
                                WHERE POSUSER.J_DEPOTID=DEPOT.J_DEPOTID " + strWHERE;
                    ds_Return = conn.GetDataSet(strSQL);


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