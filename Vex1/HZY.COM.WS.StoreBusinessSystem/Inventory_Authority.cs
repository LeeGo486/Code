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
using System.Web;
using System.Data;
using HZY.COM.ST1005A;
using HZY.COM.Common.Base;


/// 类名：Inventory_Authority
/// 类说明：对Inventory_Authority	设置各店铺审批人员以及对应小翅膀
/// 创建人：郭琦琦 
/// 创建日期：2014-03-13
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.StoreBusinessSystem
{
    public class Inventory_Authority : HZYLogicBase, ILogicGetData
    {
        public Inventory_Authority()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("HZY_Mat");
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
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        string strSQL = @"
                                            SELECT  
                                                    [Inventort_Authority_ID] ,
                                                    [Store_prefix] ,
                                                    [AreaName] ,
                                                    [Branch_POS] ,
                                                    [Branch_AM] ,
                                                    [General_POS] ,
                                                    [General_AM] ,
                                                    [Financial_POS] ,
                                                    [Financial_AM]
                                            FROM    [inventory].[Inventort_Authority]
                                            where 1=1 " + m_hzyPageInfo.Where;
                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                    }
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("[inventory].[Inventort_Authority]");

                        string strInventort_Authority_ID = ds.Tables["list"].Rows[0]["inventort_authority_id"].ToString();
                        ds.Tables["list"].Columns.Remove("inventort_authority_id");

                        conn.BeginTransaction();
                        if (strInventort_Authority_ID == "")
                        {
                            bResult = conn.Insert("[inventory].[Inventort_Authority]", ds.Tables["List"]);

                        }
                        else
                        {
                            int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM [inventory].[Inventort_Authority] WHERE inventort_authority_id = '" + strInventort_Authority_ID + "'");
                            if (nCodeCount == 0)
                            {
                                throw new Exception("你修改的数据异常，请刷新再尝试修改！");
                            }
                            else {
                                bResult = conn.Update("[inventory].[Inventort_Authority]", ds.Tables["List"], "inventort_authority_id=" + strInventort_Authority_ID);
                            }
                        }
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }

                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        bool bResult = false;
                        conn.LockTableList.Add("[inventory].[Inventort_Authority]");

                        string strInventort_Authority_ID = ds.Tables["list"].Rows[0]["inventort_authority_id"].ToString();
                        ds.Tables["list"].Columns.Remove("inventort_authority_id");

                        conn.BeginTransaction();

                        bResult = conn.Delete("[inventory].[Inventort_Authority]", "inventort_authority_id=" + strInventort_Authority_ID);

                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "删除成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "删除失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
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