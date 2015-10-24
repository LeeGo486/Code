using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：EnvoTemplates
/// 类说明：EnvoTemplates信息的CRUD
/// 创建人：马卫清
/// 创建日期：2014-01-08
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.SDK
{
    /// <summary>
    /// EnvoTemplates信息的CRUD
    /// </summary>
    public class EnvoTemplates : LogicBase, ILogicGetData
    {
        public EnvoTemplates()
        {
            this.m_SessionCheck = false;

        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();


        /// <summary>
        /// EnvoTemplates信息的CRUD
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

            string strEnvo_ID = m_request.Tables[0].Rows[0]["Envo_ID"].ToString();

            DataSet ds = Common.Common.GetDSByExcelXML(strXML);
            DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

            Dbconn conn = new Dbconn("HZY_SDK");

            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
            {

                if (strEnvo_ID == "")
                {
                    throw new Exception("Envo_ID不能为空");
                }

                ds_Return = conn.GetDataSet(@"
                            SELECT 
                                    Template_ID ,
                                    Envo_ID ,
                                    Template_Name ,
                                    --replace(replace(REPLACE([Text],CHAR(9),'    '),char(13),'ㄧ'),char(10),'ㄧ') Text ,
                                    Text ,
                                    ViewCount ,
                                    UpdateTime ,
                                    UpdateUser 
                            FROM dbo.EnvoTemplates
                            WHERE Envo_ID=@param0
                            ORDER BY ViewCount DESC 
                    ", new string[] { strEnvo_ID });

            }
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UPDATE")
            {

                bool bResult = true;

                if (ds.Tables["list"].Rows.Count > 0)
                {
                    string strTemplate_ID = ds.Tables["list"].Rows[0]["Template_ID"].ToString();
                    if (strTemplate_ID == "")
                    {
                        throw new Exception("Template_ID不能为空");
                    }

                    ds.Tables["list"].Columns.Remove("Template_ID");

                    Commom_Ds.SetUpdateInfo(ds.Tables["list"], hzyMessage);

                    conn.BeginTransaction();
                    if (CheckName(ds.Tables["list"], conn) == false)
                    {
                        conn.RollbackTransaction();
                        throw new Exception("模板名称已经存在");
                    }

                    bResult = conn.Update("EnvoTemplates", ds.Tables["list"], "Template_ID='" + strTemplate_ID + "'");
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
                    ds.Tables["list"].Columns.Remove("Template_ID");

                    Commom_Ds.SetUpdateInfo(ds.Tables["list"], hzyMessage);

                    conn.BeginTransaction();
                    if (CheckName(ds.Tables["list"], conn) == false)
                    {
                        conn.RollbackTransaction();
                        throw new Exception("模板名称已经存在");
                    }
                    bResult = conn.Insert("EnvoTemplates", ds.Tables["list"]);
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
            else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DELETE")
            {

                bool bResult = true;

                if (ds.Tables["list"].Rows.Count > 0)
                {
                    string strTemplate_ID = ds.Tables["list"].Rows[0]["Template_ID"].ToString();
                    if (strTemplate_ID == "")
                    {
                        throw new Exception("Template_ID不能为空");
                    }

                    conn.BeginTransaction();
                    bResult = conn.Delete("EnvoTemplates", "Template_ID='" + strTemplate_ID + "'");
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

            return ds_Return;



        }


        private bool CheckName(DataTable dt, Dbconn conn)
        {
            bool bResult = true;

            if (dt.Columns.Contains("Template_Name"))
            {
                string strTemplate_ID = "";
                string strEnvo_ID = "";
                if (dt.Columns.Contains("Template_ID"))
                {
                    strTemplate_ID = dt.Rows[0]["Template_ID"].ToString();
                }

                if (dt.Columns.Contains("Envo_ID"))
                {
                    strEnvo_ID = dt.Rows[0]["Envo_ID"].ToString();
                }
                string strEnvo_Name = dt.Rows[0]["Template_Name"].ToString();

                if (conn.GetDataTableRowCount("select Template_ID from [EnvoTemplates] where Template_ID!=@param0 and [Template_Name]=@param1 and Envo_id=@param2", new string[3] { strTemplate_ID, strEnvo_Name,strEnvo_ID }) > 0)
                {
                    bResult = false;
                }
            }


            return bResult;
        }


    }

}