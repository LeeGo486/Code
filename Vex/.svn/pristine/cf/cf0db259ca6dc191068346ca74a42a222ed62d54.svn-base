using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WSApplay
/// 类说明：对WSApplay的CRUD,为Easyui专用
/// 创建人：马卫清
/// 创建日期：2013-11-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{

    public class WSApplay : HZYLogicBase, ILogicGetData
    {
        public WSApplay()
        {
            this.m_SessionCheck = true;

        }

        private Dbconn conn = new Dbconn("WSRRManager");
        Dbconn connRoute = new Dbconn("WSRRManager");

        private DataTable dtEditResult = new dsCommon.dtResultDataTable();
        int mPage = 1;
        int mRows = 20;
        /// <summary>
        /// 对CFGRequestType的CRUD,为Easyui专用
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet dsReturn = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML, true, true);

                DataTable dtOPTYPE = ds.Tables["OPTYPE"];

                if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
                {
                    string strSQL = @"
                                  SELECT [WSApplayID]
                                      ,[WSName]
                                      ,convert(varchar(19),ApplayTime,21) ApplayTime
                                      ,[AppliayUser]
                                      ,[FunctionName]
                                      ,[state]
                                      ,[WSSPServer]
                                      ,replace(replace(REPLACE([WSContent],CHAR(9),'    '),char(13),'ㄧ'),char(10),'ㄧ')  [WSContent]
                                      ,replace(replace(REPLACE([InputFormat],CHAR(9),'    '),char(13),'ㄧ'),char(10),'ㄧ') [InputFormat]
                                      ,replace(replace(REPLACE([ReturnFormat],CHAR(9),'    '),char(13),'ㄧ'),char(10),'ㄧ') [ReturnFormat]
                                      ,[WSDeployServer]
                                      ,[WSSPName]
                                      ,replace(replace(REPLACE([LogicContent],CHAR(9),'    '),char(13),'ㄧ'),char(10),'ㄧ') [LogicContent]
                                      ,replace(replace(REPLACE([Code],CHAR(9),'    '),char(13),'ㄧ'),char(10),'ㄧ') [Code]
                                      ,ServicePath
                                  FROM  [dbo].[WSApplay]
                                  WHERE 1=1 " + m_hzyPageInfo.Where;


                    dsReturn = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);

                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT")
                {
                    bool bResult = false;
                    conn.LockTableList.Add("WSApplay");
                    conn.BeginTransaction();
                    string strWSApplayID = ds.Tables["list"].Rows[0]["WSApplayID"].ToString();

                    ds.Tables["list"].Columns.Remove("WSApplayID");

                    //进行XML格式化
                    for (int col = 0; col < ds.Tables["list"].Columns.Count; col++)
                    {
                        if (ds.Tables["list"].Columns[col].ColumnName == "InputFormat"
                            || ds.Tables["list"].Columns[col].ColumnName == "ReturnFormat"
                            )
                        {
                            ds.Tables["list"].Rows[0][col] = Common.Common.FormatXml(ds.Tables["list"].Rows[0][col].ToString());
                        }

                    }

                    //添加数据
                    if (strWSApplayID == "")
                    {
                        if (!ds.Tables["List"].Columns.Contains("AppliayUser"))
                        {
                            ds.Tables["List"].Columns.Add("AppliayUser");
                        }
                        ds.Tables["List"].Rows[0]["AppliayUser"] = hzyMessage.User_Name;


                        ds.Tables["List"].Rows[0]["state"] = "已提交";

                        bResult = conn.Insert("WSApplay", ds.Tables["List"]);
                    }
                    else//修改数据
                    {
                        if (ds.Tables["list"].Columns.Contains("AppliayUser"))
                        {
                            ds.Tables["list"].Columns.Remove("AppliayUser");
                        }
                        bResult = conn.Update("WSApplay", ds.Tables["List"], "WSApplayID='" + strWSApplayID + "'");
                    }
                    conn.CommitTransaction();

                    if (bResult)
                    {
                        dtEditResult.Rows.Add(new object[] { true, "提交成功" });
                    }
                    else
                    {
                        dtEditResult.Rows.Add(new object[] { false, "提交失败" });

                    }
                    dsReturn.Tables.Add(dtEditResult);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "UPDATESTATE")
                {
                    bool bResult = false;
                    conn.LockTableList.Add("WSApplay");

                    string strWSApplayID = ds.Tables["list"].Rows[0]["WSApplayID"].ToString();


                    DataTable dtState = new DataTable();
                    dtState.Columns.Add("state");

                    string strState = ds.Tables["List"].Rows[0]["state"].ToString();

                    dtState.Rows.Add(new object[] { strState });

                    conn.BeginTransaction();

                    bResult = conn.Update("WSApplay", dtState, "WSApplayID='" + strWSApplayID + "'");

                    conn.CommitTransaction();

                    if (bResult)
                    {
                        dtEditResult.Rows.Add(new object[] { true, "提交成功" });
                    }
                    else
                    {
                        dtEditResult.Rows.Add(new object[] { false, "提交失败" });

                    }
                    dsReturn.Tables.Add(dtEditResult);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "DELETE")
                {
                    bool bResult = false;
                    conn.LockTableList.Add("WSApplay");

                    string strWSApplayID = ds.Tables["list"].Rows[0]["WSApplayID"].ToString();

                    conn.BeginTransaction();

                    bResult = conn.Delete("WSApplay", "WSApplayID='" + strWSApplayID + "'");

                    conn.CommitTransaction();

                    if (bResult)
                    {
                        dtEditResult.Rows.Add(new object[] { true, "删除成功" });
                    }
                    else
                    {
                        dtEditResult.Rows.Add(new object[] { false, "删除失败" });

                    }
                    dsReturn.Tables.Add(dtEditResult);
                }
                //下发
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "SETDEVROUTE")
                {
                    bool bResult = false;
                    conn.LockTableList.Add("WSApplay");

                    string strWSApplayID = ds.Tables["list"].Rows[0]["WSApplayID"].ToString();
                    string strRouteDev = ds.Tables["list"].Rows[0]["RouteDev"].ToString();

                    string strDBServerCFG = conn.GetDataTableFirstValue("select DBServerCFG from [Route] where RouteID =@param0", new string[1] { strRouteDev }).ToString();

                    if (strDBServerCFG == "")
                    {
                        throw new Exception("提交的路由信息有误");
                    }

                    connRoute = new Dbconn(strDBServerCFG);
                    connRoute.LockTableList.Add("WS");


                    string strServicePath = "";
                    string strWSName = "";
                    string strWSID = "";
                    string strWSSrcID = "";
                    strWSID = conn.GetDataTableFirstValue("SELECT WSID FROM WSApplayRouteLink WHERE WSApplayID =@param0 AND RouteID=@Param1", new string[2] { strWSApplayID, strRouteDev }).ToString();

                    //没有绑定过，需要插入数据
                    if (strWSID == "")
                    {
                        DataTable dtAppaly = conn.GetDataTable("SELECT * FROM WSApplay WHERE WSApplayID =@param0", new string[1] { strWSApplayID });
                        if (dtAppaly.Rows.Count == 0)
                        {
                            throw new Exception("提交的信息有误！");
                        }
                        strServicePath = dtAppaly.Rows[0]["ServicePath"].ToString();
                        strWSName = dtAppaly.Rows[0]["WSName"].ToString();

                        string strWSHelp = dtAppaly.Rows[0]["WSContent"].ToString();

                        //查找目标路由服务器中是否已经拥有这个服务路径
                        DataTable dtRouteInfo = connRoute.GetDataTable("SELECT WSID,WSSrcID FROM WS WHERE WSName=@param0 AND ServicePath=@param1", new string[2] { strWSName, strServicePath });

                        if (dtRouteInfo.Rows.Count > 0)
                        {
                            strWSID = dtRouteInfo.Rows[0]["WSID"].ToString();
                            strWSSrcID = dtRouteInfo.Rows[0]["WSSrcID"].ToString();
                        }

                        //没有找到服务路径，需要路由服务器中新插入一条数据，并把状态改成 服务设计
                        if (strWSID == "")
                        {
                            strWSID = Guid.NewGuid().ToString();
                            strWSSrcID = Guid.NewGuid().ToString();

                            DataTable dtWS = new HZY.COM.WS.DataSets.DSWSRR.WSDataTable();
                            DataRow dr = dtWS.NewRow();
                            dr["WSID"] = strWSID;
                            dr["WSSrcID"] = strWSSrcID;
                            dr["ServicePath"] = strServicePath;
                            dr["WSName"] = strWSName;
                            dr["WSHelp"] = strWSHelp;
                            dr["WSState"] = "服务设计";
                            dtWS.Rows.Add(dr);
                            connRoute.InsertByVex("WS", dtWS);
                        }

                        //对WSApplayRouteLink表进行插入数据
                        DataTable dtWSApplayRouteLinkInsert = new HZY.COM.WS.DataSets.DSWSRR.WSApplayRouteLinkDataTable();
                        DataRow drWSApplayRouteLinkInsert = dtWSApplayRouteLinkInsert.NewRow();
                        drWSApplayRouteLinkInsert["RouteID"] = strRouteDev;
                        drWSApplayRouteLinkInsert["WSID"] = strWSID;
                        drWSApplayRouteLinkInsert["WSSrcID"] = strWSSrcID;
                        drWSApplayRouteLinkInsert["state"] = "禁用";
                        dtWSApplayRouteLinkInsert.Rows.Add(drWSApplayRouteLinkInsert);
                        conn.InsertByVex("WSApplayRouteLink", dtWSApplayRouteLinkInsert);
                    }
                    else //已经绑定，需要更新状态
                    {
                        //将WSApplayRouteLink表的状态


                    }

                    //判断路由表中是否已经有WSID的信息

                    DataTable dtState = new DataTable();
                    dtState.Columns.Add("state");

                    string strState = "已下发";

                    dtState.Rows.Add(new object[] { strState });

                    conn.BeginTransaction();
                    connRoute.BeginTransaction();

                    bResult = conn.Update("WSApplay", dtState, "WSApplayID='" + strWSApplayID + "'");

                    conn.CommitTransaction();

                    if (bResult)
                    {
                        dtEditResult.Rows.Add(new object[] { true, "提交成功" });
                    }
                    else
                    {
                        dtEditResult.Rows.Add(new object[] { false, "提交失败" });

                    }
                    dsReturn.Tables.Add(dtEditResult);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "SETPRODROUTE")
                {
                    bool bResult = false;
                    conn.LockTableList.Add("WSApplay");

                    string strWSApplayID = ds.Tables["list"].Rows[0]["WSApplayID"].ToString();
                    string strRouteDev = ds.Tables["list"].Rows[0]["RouteProd"].ToString();


                    DataTable dtState = new DataTable();
                    dtState.Columns.Add("state");

                    string strState = "已上线";

                    dtState.Rows.Add(new object[] { strState });

                    conn.BeginTransaction();

                    bResult = conn.Update("WSApplay", dtState, "WSApplayID='" + strWSApplayID + "'");

                    conn.CommitTransaction();

                    if (bResult)
                    {
                        dtEditResult.Rows.Add(new object[] { true, "提交成功" });
                    }
                    else
                    {
                        dtEditResult.Rows.Add(new object[] { false, "提交失败" });

                    }
                    dsReturn.Tables.Add(dtEditResult);
                }
                else
                {
                    dtEditResult.Rows.Add(new object[] { false, "修改失败" });
                    dsReturn.Tables.Add(dtEditResult);

                }

                return dsReturn;
            }
            catch
            {
                conn.RollbackTransaction();
                connRoute.RollbackTransaction();
                throw;

            }
        }
    }

}