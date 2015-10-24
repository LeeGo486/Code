using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;


using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.ST1005A;

namespace HZY.COM.WS.Present
{
    public class EmpOrderHeadInfo : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
            public EmpOrderHeadInfo() {
                this.m_SessionCheck = true;
            }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("HZY_Present");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        private DataTable dt_List = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_ReturnData = new DataSet();

        DateTime now = DateTime.Now;
        #endregion

        #region 入口
        public DataSet GetData()
        {
            try
            {
                //接收XML的内容
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_RequestXML = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = m_RequestXML.Tables["OPTYPE"];
                dt_List = m_RequestXML.Tables["List"];
                string strTag = dt_OPTYPE.Rows[0][0].ToString().ToUpper().ToString();

                if (strTag == "CarNum".ToUpper())
                {
                    CarNum();
                }
                else if (strTag == "Classify".ToUpper())
                {
                 
                };
                return m_ReturnData;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            };
        }
        #endregion

        #region 内部方法

            #region CarNum
                private void CarNum() {
                        string strSQLPoint =@"
                                  SELECT ISNULL(SUM(UnusedCredits),0) AS Credits
                                  FROM [dbo].[EmployeeInfo] WITH(NOLOCK)
                                  WHERE [Status] IN ('可兑换','待确认') AND [EmployeeNo] = '" + m_hzyMessage.User_Name + @"'";
                        DataTable dtPoint = conn.GetDataTable(strSQLPoint);
                        
                        dtPoint.Columns.Add("Num");
                        
                        string strSQLNum = @"
                        SELECT ISNULL(SUM([GoodsNum]),0) AS Num
                        FROM [dbo].[Cart] WITH(NOLOCK)
                        WHERE [Status] = '未确认' AND EmployeeNo = '" + m_hzyMessage.User_Name + @"'";

                        string Num = conn.GetDataTableFirstValue(strSQLNum).ToString();

                        dtPoint.Rows[0]["Num"] = Num;
                        dtPoint.TableName = "dtPoint";
                        m_ReturnData.Tables.Add(dtPoint.Copy());
                }
            #endregion

        #endregion
    }
}
