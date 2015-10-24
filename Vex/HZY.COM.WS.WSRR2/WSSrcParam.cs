using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：MgrWSSrcParam
/// 类说明：对WSParam的CRUD
/// 创建人：马卫清
/// 创建日期：2014-03-28
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    /// 对WSSrc的CRUD,为Easyui专用
    /// </summary>
    public class WSSrcParam : HZYLogicBase, ILogicGetData
    {
        public WSSrcParam()
        {
            this.m_SessionCheck = true;

        }

        public Dbconn conn = null;
        public DataSet m_ds = new DataSet();
        public string m_RouteCode = "";

        public bool m_CallByDll = false;

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 对MgrWSSrcParam的CRUD 
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                //DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";
                string strRouteCode = "";

                if (m_CallByDll)
                {
                    strRouteCode = m_RouteCode;
                }
                else
                {
                    conn = new Dbconn("WSRR");

                    strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                    strRouteCode = m_request.Tables[0].Rows[0]["WSRRRouteCode"].ToString();
                    m_ds = Common.Common.GetDSByExcelXML(strXML);

                }


                conn.HZYMessage = this.m_hzyMessage;


                if (strRouteCode == "")
                {
                    throw new Exception("传入的WSRRRouteCode不正确！");
                }

                DataTable dt_OPTYPE = m_ds.Tables["OPTYPE"];
                for (int i = 0; i < m_ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        string strWSSrcID = m_ds.Tables["LIst"].Rows[0]["WSSrcID"].ToString();
                        m_hzyPageInfo.Order = "asc";
                        m_hzyPageInfo.Sort = "ParamIndex";
                        string strSQL = @"
                              SELECT  
                                    [ParamID] ,
                                    [WSSrcID] ,
                                    [WSID] ,
                                    [ParamIndex] ,
                                    [ParamContent] ,
                                    [ParamName] ,
                                    [ParamType] ,
                                    ParamMustFlag AS [ParamMustFlagint] ,
                                    CASE ISNULL(ParamMustFlag,0) WHEN 1 THEN '必须' WHEN '0' THEN '否' WHEN '2' THEN '系统默认' END AS ParamMustFlag ,
                                    [DefaultValue] ,
                                    [CreateTime] ,
                                    [CreateUser] ,
                                    Convert(varchar(200),[UpdateTime],21) as  UpdateTime,
                                    [UpdateUser]
                              FROM [B01_MDM].[WS2_WS" + strRouteCode + @"Detail] WITH(NOLOCK)
                              WHERE  WSSrcID=@param0
                                " + m_hzyPageInfo.Where + "";

                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[] { strWSSrcID }, m_hzyPageInfo);

                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT"
                        || dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                    {
                        string strTableName = "[B01_MDM].[WS2_WS" + strRouteCode + @"Detail]";

                        if (m_CallByDll == false)
                        {
                            ArrayList listTable = new ArrayList();
                            listTable.Add(strTableName);
                            listTable.Add("[B01_MDM].[WS1_WS" + strRouteCode + @"Head]");
                            conn.BeginTransaction();
                            conn.TableLock(listTable);
                        }

                        DataTable dtList = m_ds.Tables["List"];
                        for (int row = 0; row < dtList.Rows.Count; row++)
                        {
                            string strParamID = dtList.Rows[row]["ParamID"].ToString();
                            string strParamIndex = dtList.Rows[row]["ParamIndex"].ToString();
                            string strWSSrcID = dtList.Rows[row]["WSSrcID"].ToString();
                            string strParamName = dtList.Rows[row]["ParamName"].ToString();
                            string strWSID = "";

                            //获取WSID
                            strWSID = conn.GetDataTableFirstValue("SELECT WSID FROM [B01_MDM].[WS1_WS" + strRouteCode + @"Head] WHERE WSSrcID=@Param0", new string[1] { strWSSrcID }).ToString();

                            if (strWSID == "")
                            {
                                throw new Exception("提交的信息有误！");
                            }

                            //判断ParamIndex是否重复
                            string strWhere = " ParamIndex='" + strParamIndex + "' AND WSSrcID='" + strWSSrcID + "'";

                            if (strParamID != "")
                            {
                                strWhere += " AND ParamID != '" + strParamID + "'";
                            }
                            int nRow = conn.GetDataTableRowCount("SELECT 'A' as A FROM " + strTableName + " WHERE " + strWhere, new string[0]);
                            if (nRow > 0)
                            {
                                throw new Exception("序号" + strParamIndex + "已经存在，不能更新");
                            }

                            //判断ParamName是否重复
                            strWhere = " ParamName='" + strParamName + "' AND WSSrcID='" + strWSSrcID + "'";

                            if (strParamID != "")
                            {
                                strWhere += " AND ParamID != '" + strParamID + "'";
                            }
                            nRow = conn.GetDataTableRowCount("SELECT 'A' as A FROM " + strTableName + " WHERE " + strWhere, new string[0]);
                            if (nRow > 0)
                            {
                                throw new Exception("参数名" + strParamName + "已经存在，不能更新");
                            }

                            DataTable dtAdd = dtList.Clone();
                            dtAdd.ImportRow(dtList.Rows[row]);
                            dtAdd.Columns.Add("WSID");
                            dtAdd.Rows[0]["WSID"] = strWSID;

                            if (strParamID == "")
                            {
                                dtAdd.Rows[0]["ParamID"] = Guid.NewGuid();

                                conn.InsertByVex(strTableName, dtAdd);
                            }
                            else
                            {

                                conn.TableKeyList.Add("ParamID");
                                conn.UpdateByVex(strTableName, dtAdd);
                            }
                        }

                        if (m_CallByDll == false)
                        {
                            conn.CommitTransaction();
                        }
                        dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        string strTableName = "[B01_MDM].[WS2_WS" + strRouteCode + @"Detail]";
                        ArrayList listTable = new ArrayList();
                        listTable.Add(strTableName);
                        listTable.Add("[B01_MDM].[WS1_WS" + strRouteCode + @"Head]");
                        conn.BeginTransaction();
                        conn.TableLock(listTable);

                        DataTable dtList = m_ds.Tables["List"];

                        for (int row = 0; row < dtList.Rows.Count; row++)
                        {
                            conn.TableKeyList.Add("ParamID");
                            conn.DeleteByVex(strTableName, dtList);
                        }

                        conn.CommitTransaction();
                        dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
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