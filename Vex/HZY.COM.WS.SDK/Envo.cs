using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：Envo
/// 类说明：技术环境信息的CRUD
/// 创建人：马卫清
/// 创建日期：2014-01-08
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.SDK
{
    /// <summary>
    /// 技术环境信息的CRUD
    /// </summary>
    public class Envo : LogicBase, ILogicGetData
    {
        public Envo()
        {
            this.m_SessionCheck = false;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();


        /// <summary>
        /// 获取WSRR的基本信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            DataSet ds_Return = new DataSet();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            if (strXML == "")
            {
                throw new Exception("XML不能为空");
            }


            DataSet ds = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

            Dbconn conn = new Dbconn("HZY_SDK");

            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
            {
                ds_Return = conn.GetDataSet(@"
                            SELECT  t1.Envo_ID ,
                                    t1.Envo_Name ,
                                    COUNT(t2.ViewCount) AS ViewCount
                            FROM    dbo.Envo t1
                                    LEFT JOIN dbo.EnvoTemplates t2 ON t1.Envo_ID = t2.Envo_ID
                            GROUP BY t1.Envo_ID ,
                                    t1.Envo_Name
                            ORDER BY ViewCount DESC
                    ");

            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UPDATE")
            {

                bool bResult = true;

                if (ds.Tables["list"].Rows.Count > 0)
                {
                    string strEnvo_ID = ds.Tables["list"].Rows[0]["Envo_ID"].ToString();
                    if (strEnvo_ID == "")
                    {
                        throw new Exception("Envo_ID不能为空");
                    }

                    ds.Tables["list"].Columns.Remove("Envo_ID");

                    Commom_Ds.SetUpdateInfo(ds.Tables["list"], hzyMessage);

                    conn.BeginTransaction();

                    if (CheckName(ds.Tables["list"], conn) == false)
                    {
                        conn.RollbackTransaction();
                        throw new Exception("名称不能重复！");
                    }
                    bResult = conn.Update("Envo", ds.Tables["list"], "Envo_ID='" + strEnvo_ID + "'");
                    conn.CommitTransaction();
                }


                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "修改失败" });

                }
                ds_Return.Tables.Add(dt_EditResult);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "INSERT")
            {

                bool bResult = true;

                if (ds.Tables["list"].Rows.Count > 0)
                {

                    if (ds.Tables["list"].Columns.Contains("Envo_ID"))
                    {
                        ds.Tables["list"].Columns.Remove("Envo_ID");
                    }

                    Commom_Ds.SetUpdateInfo(ds.Tables["list"], hzyMessage);

                    conn.BeginTransaction();

                    if (CheckName(ds.Tables["list"], conn) == false)
                    {
                        conn.RollbackTransaction();
                        throw new Exception("名称不能重复！");
                    }
                    bResult = conn.Insert("Envo", ds.Tables["list"]);
                    conn.CommitTransaction();
                }


                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "添加成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "添加成功" });

                }
                ds_Return.Tables.Add(dt_EditResult);
            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DELETE")
            {

                bool bResult = true;

                if (ds.Tables["list"].Rows.Count > 0)
                {
                    string strEnvo_ID = ds.Tables["list"].Rows[0]["Envo_ID"].ToString();
                    if (strEnvo_ID == "")
                    {
                        throw new Exception("Envo_ID不能为空");
                    }

                    conn.BeginTransaction();

                    if (CheckName(ds.Tables["list"], conn) == false)
                    {
                        conn.RollbackTransaction();
                        throw new Exception("名称不能重复！");
                    }
                    bResult = conn.Delete("Envo", "Envo_ID='" + strEnvo_ID + "'");
                    conn.CommitTransaction();
                }


                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "添加成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "添加成功" });

                }
                ds_Return.Tables.Add(dt_EditResult);
            }

            return ds_Return;



        }

        private bool CheckName(DataTable dt, Dbconn conn)
        {
            bool bResult = true;

            if (dt.Columns.Contains("Envo_Name"))
            {
                string strEnvo_ID = "";
                if (dt.Columns.Contains("Envo_ID"))
                {
                    strEnvo_ID = dt.Rows[0]["Envo_ID"].ToString();
                }
                string strEnvo_Name = dt.Rows[0]["Envo_Name"].ToString();

                if (conn.GetDataTableRowCount("select Envo_ID from [Envo] where Envo_ID!=@param0 and [Envo_Name]=@param1", new string[2] { strEnvo_ID, strEnvo_Name }) > 0)
                {
                    bResult = false;
                }
            }


            return bResult;
        }

    }

}