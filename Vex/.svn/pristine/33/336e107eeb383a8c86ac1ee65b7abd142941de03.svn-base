using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;

/// 类名：DRP_ShopEmpatt_EditByXML
/// 类说明：高单系统
/// 创建人：钱超
/// 创建日期：2013-09-26
/// 修改人：
/// 修改日期： 
namespace HZY.COM.DRP
{
    /// <summary>
    /// 根据XML查询高单奖金
    /// </summary>
    public class DRP_ShopEmpatt_EditByXML : LogicBase, ILogicGetData
    {
        public DRP_ShopEmpatt_EditByXML()
        {
            this.m_SessionCheck = false;

        }

        /// <summary>
        /// 根据XML内容查询高单奖金
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();

                ArrayList listAMSendList = new ArrayList();

                Dbconn conn = new Dbconn("X6_EPApp");

                string strXML = "";
                string strSQL = "";
 
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                //XML是前台传入
                ds = Common.Common.GetDSByExcelXML(strXML);

                if (ds.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper() == "GET")
                //读取ROWS到/ROWS 中的参数
                {
                    string strWHERE = "AND 1=1";
                    if (ds.Tables["LIST"].Columns.Contains("Condition"))
                    {
                        if (ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() != "")
                        //读取LIST之间参数
                        {
                            strWHERE += " AND (" + ds.Tables["LIST"].Rows[0]["Condition"].ToString().Trim() + ")";
                        }
                    }

                    strSQL = @"  SELECT B.WS_EMPLOYEEID,A.WP_COSTCENTER,
                                 left(CONVERT(VARCHAR(100),DateAdd(m,-1,A.WP_DATE),121),7)as DATES,
                                 '高单奖金' as GDJJ,B.WS_TMONEY  
                                 FROM
                                 TB_FYSP_WAGEPAYMENTS A,TB_FYSP_WAGEPAYMENTSSUB B
                                 WHERE A.WP_FID=B.WS_MASTERID " + strWHERE          
                                ;
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