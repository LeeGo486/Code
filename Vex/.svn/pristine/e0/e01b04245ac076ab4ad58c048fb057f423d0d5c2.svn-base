using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：EHRForSalary
/// 类说明：总部薪资查询
/// 创建人：郭琦琦
/// 创建日期：2014-10-20
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.PointToPoint
{
    public class EHRForSalary : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public EHRForSalary()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("EHRFORSalary");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetEHRForSalary".ToUpper())//总部薪资查询
                {
                    GetEHRForSalary(dtList);
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 薪资
        /// <summary>
        /// 薪资
        /// </summary>
        private void GetEHRForSalary(DataTable pdt)
        {

            //string strname = pdt.Rows[0]["name"].ToString();
            string strsfz = pdt.Rows[0]["sfz"].ToString();
            string str月 = pdt.Rows[0]["month"].ToString();
            string str年 = pdt.Rows[0]["year"].ToString();
            string strPas = pdt.Rows[0]["password"].ToString();
            //string strname = "张三";
            //strsfz = "1234567890";
            string Where = " 1=1 ";


            if (str月 == "" || str月 == null && str年 == "" || str年 == null)
            {
                Where = " ORDER BY 年份 desc, 月份 desc ";
            }
            else
            {
                Where = " AND 年份 = '" + str年 + "' AND 月份='" + str月 + "'";
            }

            //            string strEHRSQL = @"   SELECT top 1 * FROM  ehrtest.dbo.EHRForSalary2
            //                                    WHERE   姓名 = '" + strname + "' AND 身份证 = '" + strsfz + "' ";

            string strEHRSQL = @"   SELECT top 1 * FROM  dbo.EHRForSalary2
                                    WHERE 身份证 = '" + strsfz + "' and 密码= '" + strPas + "'";
            ds_Return = m_conn.GetDataSet(strEHRSQL + Where, new string[] { });
        }
        #endregion

        #endregion
    }
}
