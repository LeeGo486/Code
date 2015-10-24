using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WSServiceInfo
/// 类说明：对WSApplay的CRUD,为Easyui专用
/// 创建人：马卫清
/// 创建日期：2013-11-14
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{

    public class WSServiceInfo : HZYLogicBase, ILogicGetData
    {
        public WSServiceInfo()
        {
            this.m_SessionCheck = true;

        }

        private Dbconn conn = new Dbconn("WSRR");

        private DataTable dtEditResult = new dsCommon.dtResultDataTable();

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
                conn.HZYMessage = this.m_hzyMessage;
                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML, true, true);

                DataTable dtOPTYPE = ds.Tables["OPTYPE"];

                if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
                {
                    string strSearchText = "";
                    if (ds.Tables["list"] != null && ds.Tables["list"].Columns.Contains("SearchText"))
                    {
                        strSearchText = ds.Tables["list"].Rows[0]["SearchText"].ToString();
                    }

                    string strSQL = @"
                                    SELECT t1.[WSID] , 
                                        t1.[WSName] ,
                                        CONVERT(VARCHAR(19), ApplayTime, 21) ApplayTime ,
                                        [AppliayUser] ,
                                        t1.[state] ,
                                        [WSSPServer] ,
                                        REPLACE(REPLACE(REPLACE([WSContent], CHAR(9), '    '), CHAR(13), 'ㄧ'),
                                                CHAR(10), 'ㄧ') [WSContent] ,
                                        [WSDeployServer] ,
                                        [WSSPName] ,
                                        REPLACE(REPLACE(REPLACE([Code], CHAR(9), '    '), CHAR(13), 'ㄧ'),
                                                CHAR(10), 'ㄧ') [Code] ,
                                        t1.ServicePath,
                                        Convert(varchar(100),t1.updatetime,21) as updatetime
                                    FROM   [B01_MDM].[WS0E_WSExtDoc] t1
                                        LEFT JOIN [B01_MDM].[WS0_WSMainDoc] t2 ON t1.WSID = t2.WSID

                                    WHERE 1=1 " + m_hzyPageInfo.Where;


                    if (strSearchText != "")
                    {
                        strSQL += @" AND EXISTS (SELECT 1 FROM [B05_RPT].[WS0V_WSMethodView] T2 WITH(NOLOCK) WHERE FREETEXT ( fulltext, @Param0 )
                            AND T1.WSID=T2.WSID )";
                    }

                    dsReturn = conn.GetDataSetForPageList(strSQL, new string[] { strSearchText }, m_hzyPageInfo);

                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETRouteINFO".ToUpper())
                {
                    string strWSID = ds.Tables["List"].Rows[0]["WSID"].ToString();

                    string strSQL = @"
                                   SELECT   
                                        t1.LinkID ,
                                        t1.WSID ,
                                        t1.WSSrcID ,
                                        t1.state ,
                                        Convert(varchar(100),t1.UpdateTime,21) as updatetime,
                                        t1.CreateTime ,
                                        t1.CreateUser ,
                                        t1.UpdateUser ,
                                        t2.RouteCode ,
                                        t2.RouteType ,
                                        t2.Name AS RouteName
                                FROM    B01_MDM.WSR_WSRouteLink t1
                                        LEFT JOIN [B01_MDM].[RT0_Routes] t2 ON t1.RouteCode = t2.RouteCode
                                WHERE   WSID = @param0
                                   " + m_hzyPageInfo.Where;

                    dsReturn = conn.GetDataSetForPageList(strSQL, new string[] { strWSID }, m_hzyPageInfo);

                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT")
                {
                    bool bResult = false;
                    conn.LockTableList.Add("[B01_MDM].[WS0E_WSExtDoc]");
                    conn.BeginTransaction();
                    string strWSID = ds.Tables["list"].Rows[0]["WSID"].ToString();

                    //添加数据
                    if (strWSID == "")
                    {
                        string strServicePath = ds.Tables["List"].Rows[0]["ServicePath"].ToString();
                        string strWSName = ds.Tables["List"].Rows[0]["WSName"].ToString();

                        if (strServicePath == "" || strWSName == "")
                        {
                            throw new Exception("传入的参数有误！");
                        }

                        //判断服务路径和服务名称是否已经存在
                        if (conn.GetDataTableRowCount("SELECT TOP 50 'a' AS a FROM [B01_MDM].[WS0_WSMainDoc] WHERE ISNULL(ServicePath,'')+ISNULL(WSName,'')=@Param0", new string[] { strServicePath + strWSName }) > 0)
                        {
                            throw new Exception("该服务已经存在，请检查！");
                        }

                        strWSID = Guid.NewGuid().ToString();

                        DataTable dtWSService = new DataTable();
                        dtWSService.Columns.Add("WSID");
                        dtWSService.Columns.Add("ServicePath");
                        dtWSService.Columns.Add("WSName");
                        dtWSService.Rows.Add(new object[] { strWSID, strServicePath, strWSName });
                        conn.InsertByVex("[B01_MDM].[WS0_WSMainDoc]", dtWSService);

                        if (!ds.Tables["List"].Columns.Contains("AppliayUser"))
                        {
                            ds.Tables["List"].Columns.Add("AppliayUser");
                        }
                        ds.Tables["List"].Rows[0]["AppliayUser"] = hzyMessage.User_Name;

                        ds.Tables["List"].Rows[0]["state"] = "已提交";
                        ds.Tables["List"].Rows[0]["WSID"] = strWSID;

                        bResult = conn.InsertByVex("[B01_MDM].[WS0E_WSExtDoc]", ds.Tables["List"]);
                    }
                    else//修改数据
                    {
                        if (ds.Tables["list"].Columns.Contains("AppliayUser"))
                        {
                            ds.Tables["list"].Columns.Remove("AppliayUser");
                        }

                        string strServicePath = ds.Tables["list"].Rows[0]["ServicePath"].ToString();
                        string strWSName = ds.Tables["list"].Rows[0]["WSName"].ToString();
                        DataTable dtInfo = conn.GetDataTable("SELECT * FROM [B01_MDM].[WS0_WSMainDoc] WHERE WSID=@Param0", new string[] { strWSID });
                        if (dtInfo.Rows.Count == 0)
                        {
                            throw new Exception("提交的数据有误！");
                        }

                        if (strServicePath != dtInfo.Rows[0]["ServicePath"].ToString()
                            || strWSName != dtInfo.Rows[0]["WSName"].ToString())
                        {
                            //判断服务路径与服务名称是否允许修改
                            int nCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM B01_MDM.WSR_WSRouteLink WHERE WSID=@Param0", new string[] { strWSID });
                            if (nCount > 0)
                            {
                                throw new Exception("该服务曾经被下发过，不能修改服务路径和服务名称！");
                            }
                            else
                            {
                                DataTable dtUpdateService = new DataTable();
                                dtUpdateService.Columns.Add("ServicePath");
                                dtUpdateService.Columns.Add("WSName");
                                dtUpdateService.Rows.Add(new object[] { strServicePath, strWSName });
                                conn.Update("B01_MDM.WS0_WSMainDoc", dtUpdateService, "WSID='" + strWSID + "'");
                                conn.Update("B01_MDM.WS0E_WSExtDoc", dtUpdateService, "WSID='" + strWSID + "'");
                            }
                        }

                        conn.TableKeyList.Add("WSID");
                        bResult = conn.UpdateByVex("[B01_MDM].[WS0E_WSExtDoc]", ds.Tables["List"]);
                    }

                    //更新全文检索的数据
                    UpdateFullText(strWSID, conn);

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
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "UpdateLinkState".ToUpper())
                {
                    bool bResult = false;
                    conn.LockTableList.Add("B01_MDM.WSR_WSRouteLink");

                    string strLinkID = ds.Tables["list"].Rows[0]["LinkID"].ToString();


                    DataTable dtState = new DataTable();
                    dtState.Columns.Add("LinkID");
                    dtState.Columns.Add("state");
                    dtState.Columns.Add("updatetime");

                    string strState = ds.Tables["List"].Rows[0]["state"].ToString();

                    dtState.Rows.Add(new object[] { strLinkID, strState, ds.Tables["List"].Rows[0]["updatetime"] });

                    conn.BeginTransaction();

                    conn.TableKeyList.Clear();
                    conn.TableKeyList.Add("LinkID");
                    bResult = conn.UpdateByVex("B01_MDM.WSR_WSRouteLink", dtState);

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
                    conn.LockTableList.Add("[B01_MDM].[WS0E_WSExtDoc]");

                    string strWSID = ds.Tables["list"].Rows[0]["WSID"].ToString();


                    DataTable dtState = new DataTable();
                    dtState.Columns.Add("state");
                    dtState.Columns.Add("wsid");
                    dtState.Columns.Add("updatetime");

                    string strState = ds.Tables["List"].Rows[0]["state"].ToString();

                    dtState.Rows.Add(new object[] { strState, strWSID, ds.Tables["List"].Rows[0]["updatetime"] });



                    conn.BeginTransaction();

                    conn.TableKeyList.Clear();
                    conn.TableKeyList.Add("WSID");
                    bResult = conn.UpdateByVex("[B01_MDM].[WS0E_WSExtDoc]", dtState);

                    if (strState == "已禁用")
                    {
                        //更新路由表信息
                        conn.Update("[B01_MDM].[WSR_WSRouteLink]", dtState, "WSID='" + strWSID + "'");
                    }
                    //更新全文检索的数据
                    UpdateFullText(strWSID, conn);

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
                //else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "DELETE")
                //{
                //    bool bResult = false;
                //    conn.LockTableList.Add("WSApplay");

                //    string strWSApplayID = ds.Tables["list"].Rows[0]["WSApplayID"].ToString();

                //    conn.BeginTransaction();

                //    bResult = conn.Delete("WSApplay", "WSApplayID='" + strWSApplayID + "'");

                //    conn.CommitTransaction();

                //    if (bResult)
                //    {
                //        dtEditResult.Rows.Add(new object[] { true, "删除成功" });
                //    }
                //    else
                //    {
                //        dtEditResult.Rows.Add(new object[] { false, "删除失败" });

                //    }
                //    dsReturn.Tables.Add(dtEditResult);
                //}
                //下发
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "SETDEVROUTE")
                {
                    bool bResult = false;
                    conn.LockTableList.Add("[B01_MDM].[WS0E_WSExtDoc]");
                    conn.BeginTransaction();


                    string strWSID = ds.Tables["list"].Rows[0]["WSID"].ToString();
                    string strRouteDev = ds.Tables["list"].Rows[0]["RouteDev"].ToString();
                    string strUpdateTime = ds.Tables["list"].Rows[0]["UpdateTime"].ToString();

                    string strRouteCode = conn.GetDataTableFirstValue("SELECT RouteCode FROM [B01_MDM].[RT0_Routes] WHERE RouteID =@param0", new string[1] { strRouteDev }).ToString();

                    if (strRouteCode == "")
                    {
                        throw new Exception("提交的路由信息有误");
                    }


                    string strServicePath = "";
                    string strWSName = "";
                    string strWSSrcID = "";

                    DataTable dtLink = conn.GetDataTable("SELECT * FROM B01_MDM.WSR_WSRouteLink WHERE WSID =@param0 AND RouteCode=@Param1", new string[2] { strWSID, strRouteCode });
                    string strLinkID = "";
                    if (dtLink.Rows.Count > 0)
                    {
                        strLinkID = dtLink.Rows[0]["LinkID"].ToString();
                    }

                    //没有绑定过，需要插入数据
                    if (strLinkID == "")
                    {
                        DataTable dtServiceInfo = conn.GetDataTable("SELECT * FROM [B01_MDM].[WS0E_WSExtDoc] WHERE WSID =@param0", new string[1] { strWSID });
                        if (dtServiceInfo.Rows.Count == 0)
                        {
                            throw new Exception("提交的信息有误！");
                        }
                        strServicePath = dtServiceInfo.Rows[0]["ServicePath"].ToString();
                        strWSName = dtServiceInfo.Rows[0]["WSName"].ToString();

                        string strWSHelp = dtServiceInfo.Rows[0]["WSContent"].ToString();

                        //查找目标路由服务器中是否已经拥有这个服务路径
                        DataTable dtRouteInfo = conn.GetDataTable("SELECT WSSrcID FROM  [B01_MDM].[WS1_WS" + strRouteCode + "Head] WHERE WSID=@Param0", new string[] { strWSID });

                        if (dtRouteInfo.Rows.Count > 0)
                        {
                            strWSSrcID = dtRouteInfo.Rows[0]["WSSrcID"].ToString();
                        }

                        //没有找到服务路径，需要路由服务器中新插入一条数据，并把状态改成 服务设计
                        if (strWSSrcID == "")
                        {
                            strWSSrcID = Guid.NewGuid().ToString();

                            DataTable dtWS = new HZY.COM.WS.DataSets.DSWSRR2.WSDataTable();
                            DataRow dr = dtWS.NewRow();
                            dr["WSID"] = strWSID;
                            dr["WSSrcID"] = strWSSrcID;
                            dr["ServicePath"] = strServicePath;
                            dr["WSName"] = strWSName;
                            dr["WSHelp"] = strWSHelp;
                            dr["WSState"] = "规划中";
                            dtWS.Rows.Add(dr);
                            conn.InsertByVex("[B01_MDM].[WS1_WS" + strRouteCode + "Head]", dtWS);
                        }

                        //对WSApplayRouteLink表进行插入数据
                        DataTable dtWSApplayRouteLinkInsert = new HZY.COM.WS.DataSets.DSWSRR2.WSApplayRouteLinkDataTable();
                        DataRow drWSApplayRouteLinkInsert = dtWSApplayRouteLinkInsert.NewRow();
                        drWSApplayRouteLinkInsert["RouteCode"] = strRouteCode;
                        drWSApplayRouteLinkInsert["WSID"] = strWSID;
                        drWSApplayRouteLinkInsert["WSSrcID"] = strWSSrcID;
                        drWSApplayRouteLinkInsert["state"] = "已禁用";
                        drWSApplayRouteLinkInsert["LinkID"] = Guid.NewGuid();
                        dtWSApplayRouteLinkInsert.Rows.Add(drWSApplayRouteLinkInsert);
                        conn.InsertByVex("B01_MDM.WSR_WSRouteLink", dtWSApplayRouteLinkInsert);
                    }
                    else //已经绑定，如果该服务已经启用，需要更新状态
                    {
                        if (dtLink.Rows[0]["state"].ToString() == "已启用")
                        {
                            //将WSApplayRouteLink表的状态
                            dtLink.Rows[0]["state"] = "已禁用";

                            conn.TableKeyList.Clear();
                            conn.TableKeyList.Add("LinkID");
                            conn.UpdateByVex("B01_MDM.WSR_WSRouteLink", dtLink);
                        }

                    }

                    //判断路由表中是否已经有WSID的信息

                    DataTable dtState = new DataTable();
                    dtState.Columns.Add("state");
                    dtState.Columns.Add("updatetime");
                    dtState.Columns.Add("WSID");

                    string strState = "已下发";

                    dtState.Rows.Add(new object[] { strState, strUpdateTime, strWSID });

                    conn.TableKeyList.Clear();
                    conn.TableKeyList.Add("WSID");
                    bResult = conn.UpdateByVex("[B01_MDM].[WS0E_WSExtDoc]", dtState);

                    //更新全文检索的数据
                    UpdateFullText(strWSID, conn);


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
                throw;

            }
        }


        public static void UpdateFullText(string pstrWSID, Dbconn pconn)
        {
            string strSQL = @"
                        DECLARE @cols NVARCHAR(MAX)
                        SET @cols = ''
                        SELECT  @cols = @cols + 'convert(varchar(1000),isnull(' + name
                                + ',''''),21)+'' ''+'
                        FROM    syscolumns
                        WHERE   ( id = ( SELECT id
                                         FROM   sysobjects
                                         WHERE  ( name = 'WS0E_WSExtDoc' )
                                       ) )

                        SELECT  @cols as A

                ";

            string strInfoColumns = pconn.GetDataTableFirstValue(strSQL).ToString();
            strSQL = strInfoColumns.Substring(0, strInfoColumns.Length - 1);
            strSQL = "SELECT " + strSQL + "  FROM [B01_MDM].[WS0E_WSExtDoc] WHERE WSID=@Param0";
            string strValue = pconn.GetDataTableFirstValue(strSQL, new string[] { pstrWSID }).ToString();

            strSQL = @"
                        DECLARE @cols NVARCHAR(MAX)
                        SET @cols = ''
                        SELECT  @cols = @cols + 'convert(varchar(1000),isnull(' + name
                                + ',''''),21)+'' ''+'
                        FROM    syscolumns
                        WHERE   ( id = ( SELECT id
                                         FROM   sysobjects
                                         WHERE  ( name = 'WS0M_WSMethodDoc' )
                                       ) )

                        SELECT  @cols as A

                ";


            string strFunctionColumns = pconn.GetDataTableFirstValue(strSQL).ToString();

            strSQL = "SELECT " + strFunctionColumns.Substring(0, strFunctionColumns.Length - 1) + " AS A  FROM [B01_MDM].[WS0M_WSMethodDoc] WHERE WSID=@Param0";


            DataTable dt = pconn.GetDataTable(strSQL, new string[] { pstrWSID });
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                strValue += " " + dt.Rows[i]["A"].ToString();
            }

            strSQL = " SELECT 1 AS A FROM [B05_RPT].[WS0V_WSMethodView] WHERE WSID=@Param0";
            if (pconn.GetDataTableRowCount(strSQL, new string[] { pstrWSID }) == 1)
            {
                pconn.ExcuteQuerryByTran("UPDATE [B05_RPT].[WS0V_WSMethodView] SET fulltext=@Param0 WHERE WSID=@PARAM1", new string[] { strValue, pstrWSID });
            }
            else
            {
                pconn.ExcuteQuerryByTran("INSERT INTO [B05_RPT].[WS0V_WSMethodView](fulltext,WSID)Values(@Param0,@PARAM1)", new string[] { strValue, pstrWSID });
            }
        }
    }

}