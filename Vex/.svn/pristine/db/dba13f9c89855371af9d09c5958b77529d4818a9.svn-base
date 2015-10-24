using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WSSrc
/// 类说明：对WSSrc的CRUD
/// 创建人：马卫清
/// 创建日期：2014-03-28
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{
    /// <summary>
    /// 对WSSrc的CRUD,为Easyui专用
    /// </summary>
    public class WSSrc : HZYLogicBase, ILogicGetData
    {
        public WSSrc()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("WSRR");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 对WSRR的CRUD,为Easyui专用
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
                string strRouteCode = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                strRouteCode = m_request.Tables[0].Rows[0]["WSRRRouteCode"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                if (strRouteCode == "")
                {
                    throw new Exception("传入的WSRRRouteCode不正确！");
                }

                DataTable dtOPTYPE = ds.Tables["OPTYPE"];
                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (dtOPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        string strSQL = @"
                             SELECT [WSSrcID] ,
                                    [WSID] ,
                                    [ServicePath] ,
                                    [WSName] ,
                                    [WSType] ,
                                    [WSHelp] ,
                                    [WSHost] ,
                                    [WSURL] ,
                                    [WSState] ,
                                    [WSVision] ,
                                    [WSMethod] ,
                                    CASE ISNULL(NeedLogin, 0)
                                      WHEN 1 THEN '必须'
                                      ELSE ''
                                    END AS needlogin ,
                                    ISNULL(needlogin, 0) AS needloginint ,
                                    [WSUnicode] ,
                                     REPLACE(REPLACE(REPLACE([CallSample], CHAR(9), '    '), CHAR(13), 'ㄧ'),
                                                                                    CHAR(10), 'ㄧ') [CallSample] ,
                                    IsVex,
                                    IsDemo,
                                    --[CallSample],
                                    [CreateTime] ,
                                    [CreateUser] ,
                                    Convert(Varchar(100),UpdateTime,21) UpdateTime,
                                    [UpdateUser]
                              FROM [B01_MDM].[WS1_WS" + strRouteCode + @"Head] T1 WITH(NOLOCK)
                              WHERE  1=1 " + m_hzyPageInfo.Where;

                       // WHERE   FREETEXT ( WS_Name, @Param0 )

                        
                        dsReturn = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);

                    }
                    else if (dtOPTYPE.Rows[i][0].ToString().ToUpper() == "GETIMPORT")
                    {
                        string strSQL = @"
                             SELECT [WSSrcID] ,
                                    [WSID] ,
                                    [ServicePath] ,
                                    [WSName] ,
                                    [WSType] ,
                                    [WSHelp] ,
                                    [WSHost] ,
                                    [WSURL] ,
                                    [WSState] ,
                                    [WSVision] ,
                                    [WSMethod] ,
                                    CASE ISNULL(NeedLogin, 0)
                                      WHEN 1 THEN '必须'
                                      ELSE ''
                                    END AS needlogin ,
                                    ISNULL(needlogin, 0) AS needloginint ,
                                    [WSUnicode] ,
                                    IsVex,
                                    [CreateTime] ,
                                    [CreateUser] ,
                                    Convert(Varchar(100),UpdateTime,21) UpdateTime,
                                    [UpdateUser]
                              FROM [B01_MDM].[WS1_WS" + strRouteCode + @"Head] t1 WITH(NOLOCK)
                                WHERE WSState='运行中' AND  EXISTS ( SELECT 1
                                                    FROM   [B01_MDM].[WS0E_WSExtDoc]
                                                    WHERE  WS0E_WSExtDoc.WSID = t1.WSID
                                                        AND WS0E_WSExtDoc.state = '已测试' )
                                   
                              " + m_hzyPageInfo.Where;


                        dsReturn = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);

                    }
                    else if (dtOPTYPE.Rows[i][0].ToString().ToUpper() == "GETIMPORTVEX")
                    {
                        string strSQL = @"
                             SELECT [WSSrcID] ,
                                    [WSID] ,
                                    [ServicePath] ,
                                    [WSName] ,
                                    [WSType] ,
                                    [WSHelp] ,
                                    [WSHost] ,
                                    [WSURL] ,
                                    [WSState] ,
                                    [WSVision] ,
                                    [WSMethod] ,
                                    CASE ISNULL(NeedLogin, 0)
                                      WHEN 1 THEN '必须'
                                      ELSE ''
                                    END AS needlogin ,
                                    ISNULL(needlogin, 0) AS needloginint ,
                                    [WSUnicode] ,
                                    IsVex,
                                    [CreateTime] ,
                                    [CreateUser] ,
                                    Convert(Varchar(100),UpdateTime,21) UpdateTime,
                                    [UpdateUser]
                              FROM [B01_MDM].[WS1_WS" + strRouteCode + @"Head] t1 WITH(NOLOCK)
                                WHERE WSState='运行中' 
                                AND IsVex='是'
                              " + m_hzyPageInfo.Where;

                        dsReturn = conn.GetDataSetForPageList(strSQL, m_hzyPageInfo);

                    }
                    else if (dtOPTYPE.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        string strTableName = "[B01_MDM].[WS1_WS" + strRouteCode + @"Head]";
                        ArrayList listTable = new ArrayList();

                        listTable.Add(strTableName);
                        listTable.Add("[B01_MDM].[WS1_WS" + strRouteCode + @"Head]");
                        listTable.Add("[B01_MDM].[WS0_WSMainDoc]");
                        listTable.Add("B01_MDM.WSR_WSRouteLink");
                        conn.BeginTransaction();
                        conn.TableLock(listTable);

                        DataTable dtList = ds.Tables["List"];

                        UpdateWSSrc(dtList, strTableName, strRouteCode);

                        conn.CommitTransaction();
                        dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                        dsReturn.Tables.Add(dt_EditResult);
                    }
                    else if (dtOPTYPE.Rows[i][0].ToString().ToUpper() == "ImportRouteVex".ToUpper())
                    {
                        string strTableName = "[B01_MDM].[WS1_WS" + strRouteCode + @"Head]";
                        DataTable dtList = ds.Tables["List"];
                        string strImportRouteCode = ds.Tables["List"].Rows[0]["ImportRouteCode"].ToString();
                        string strWSSrcList = ds.Tables["List"].Rows[0]["WSSrcIDList"].ToString();
                        string strWSHost = ds.Tables["List"].Rows[0]["WShost"].ToString();


                        ArrayList listTable = new ArrayList();

                        listTable.Add(strTableName);
                        listTable.Add("[B01_MDM].[WS1_WS" + strRouteCode + @"Head]");
                        listTable.Add("[B01_MDM].[WS1_WS" + strImportRouteCode + @"Head]");
                        listTable.Add("[B01_MDM].[WS0_WSMainDoc]");
                        listTable.Add("B01_MDM.WSR_WSRouteLink");
                        conn.BeginTransaction();
                        conn.TableLock(listTable);

                        string[] strWSSrcListData = strWSSrcList.Split(',');
                        for (int row = 0; row < strWSSrcListData.Length; row++)
                        {
                            string strWSSrcIDImport = strWSSrcListData[row];
                            if (strWSSrcIDImport == "")
                            {
                                continue;
                            }

                            string strWSSRCID = Guid.NewGuid().ToString();
                            DataTable dtSrc = conn.GetDataTable(@"
                                                                    SELECT  '" + strWSSRCID + @"' AS WSSrcID
                                                                            ,[WSID]
                                                                            ,[ServicePath]
                                                                            ,[WSName]
                                                                            ,[WSType]
                                                                            ,[WSHelp]
                                                                            ,'" + strWSHost + @"' as [WSHost]
                                                                            ,[WSURL]
                                                                            ,[WSState]
                                                                            ,[WSVision]
                                                                            ,[WSMethod]
                                                                            ,[NeedLogin]
                                                                            ,[WSUnicode]
                                                                            ,[CallSample]
                                                                            ,[IsVex]
                                                                            ,[CreateTime]
                                                                            ,[CreateUser]
                                                                            ,[UpdateTime]
                                                                            ,[UpdateUser]
                                                                        FROM  [B01_MDM].[WS1_WS" + strImportRouteCode + @"Head] 
                                                                        WHERE WSSrcID=@Param0", new string[] { strWSSrcIDImport });
                            if (dtSrc.Rows.Count != 1)
                            {
                                throw new Exception("传入的参数有误！");
                            }

                            string strWSID = dtSrc.Rows[0]["WSID"].ToString();
                            string strWSState = dtSrc.Rows[0]["WSState"].ToString();

                            DataTable dtSrcOld = conn.GetDataTable("SELECT WSSrcID,UpdateTime FROM " + strTableName + " WHERE WSID=@Param0 AND WSState='运行中'", new string[] { strWSID });
                            if (dtSrcOld.Rows.Count > 0)
                            {
                                DeleteDataAndBackup(strTableName, strRouteCode, dtSrcOld);
                            }
                            conn.InsertByVex(strTableName, dtSrc);

                            DataTable dtParam = conn.GetDataTable(@"
                                                                    SELECT 
                                                                          '" + strWSSRCID + @"' [WSSrcID]
                                                                          ,WSID
                                                                          ,[ParamIndex]
                                                                          ,[ParamContent]
                                                                          ,[ParamName]
                                                                          ,[ParamType]
                                                                          ,[ParamMustFlag]
                                                                          ,[DefaultValue]
                                                                          ,[CreateTime]
                                                                          ,[CreateUser]
                                                                          ,[UpdateTime]
                                                                          ,[UpdateUser]
                                                                        FROM  [B01_MDM].[WS2_WS" + strImportRouteCode + @"Detail]
                                                                        WHERE WSSrcID=@Param0", new string[] { strWSSrcIDImport });
                            conn.InsertByVex("[B01_MDM].[WS2_WS" + strRouteCode + @"Detail]", dtParam);

                            UpdateLinkInfo(strWSID, strRouteCode, strWSState, "1", strWSSRCID);
                        }

                        conn.CommitTransaction();
                        dt_EditResult.Rows.Add(new object[] { true, "导入成功" });
                        dsReturn.Tables.Add(dt_EditResult);
                    }
                    else if (dtOPTYPE.Rows[i][0].ToString().ToUpper() == "ImportRoute".ToUpper()) //导入
                    {
                        string strTableName = "[B01_MDM].[WS1_WS" + strRouteCode + @"Head]";
                        ArrayList listTable = new ArrayList();

                        listTable.Add(strTableName);
                        listTable.Add("[B01_MDM].[WS1_WS" + strRouteCode + @"Head]");
                        listTable.Add("[B01_MDM].[WS0_WSMainDoc]");
                        listTable.Add("B01_MDM.WSR_WSRouteLink");
                        conn.BeginTransaction();
                        conn.TableLock(listTable);

                        DataTable dtList = ds.Tables["List"];
                        string strParamXML = ds.Tables["List"].Rows[0]["ParamDetail"].ToString();
                        dtList.Columns.Remove("ParamDetail");

                        string strWSSrcID = UpdateWSSrc(dtList, strTableName, strRouteCode);

                        DataSet dsParam = Common.Common.GetDSByExcelXML(strParamXML);

                        if (dsParam.Tables.Contains("List"))
                        {
                            for (int iParam = 0; iParam < dsParam.Tables["List"].Rows.Count; iParam++)
                            {
                                dsParam.Tables["List"].Rows[iParam]["WSSrcID"] = strWSSrcID;
                                dsParam.Tables["List"].Rows[iParam]["ParamID"] = "";
                                dsParam.Tables["List"].Rows[iParam]["ParamMustFlag"] = dsParam.Tables["List"].Rows[iParam]["ParamMustFlagInt"];

                            }

                            dsParam.Tables["list"].Columns.Remove("ParamMustFlagInt");
                            dsParam.Tables["list"].Columns.Remove("RowIndex");
                            dsParam.Tables["list"].Columns.Remove("WSID");

                            WSSrcParam cls = new WSSrcParam();
                            cls.m_CallByDll = true;
                            cls.hzyMessage = this.hzyMessage;
                            cls.m_ds = dsParam;
                            cls.conn = conn;
                            cls.m_RouteCode = strRouteCode;
                            cls.GetData();

                        }

                        conn.CommitTransaction();
                        dt_EditResult.Rows.Add(new object[] { true, "导入成功" });
                        dsReturn.Tables.Add(dt_EditResult);
                    }
                    else if (dtOPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        DataTable dtList = ds.Tables["List"];

                        string strWSSrcID = dtList.Rows[0]["WSSrcID"].ToString();
                        if (strWSSrcID == "")
                        {
                            throw new Exception("传入的参数有误 ");
                        }

                        string strTableName = "[B01_MDM].[WS1_WS" + strRouteCode + @"Head]";
                        ArrayList listTable = new ArrayList();
                        listTable.Add(strTableName);
                        listTable.Add("[B01_MDM].[WS1_WS" + strRouteCode + @"Head]");
                        listTable.Add("[B01_MDM].[WS2_WS" + strRouteCode + @"Detail]");
                        listTable.Add("[M03_GOVERN].[WS1_WSHisHead]");
                        listTable.Add("[M03_GOVERN].[WS2_WSHisDetail]");
                        conn.BeginTransaction();
                        conn.TableLock(listTable);

                        //判断这个WSSrcID是否被当前的路由所使用
                        int nCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM B01_MDM.WSR_WSRouteLink WHERE WSSrcID=@PARAM0", new string[] { strWSSrcID });
                        if (nCount > 0)
                        {
                            throw new Exception("该资源被对应的路由绑定着，不能删除！");
                        }

                        DeleteDataAndBackup(strTableName, strRouteCode, dtList);

                        conn.CommitTransaction();

                        dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                        dsReturn.Tables.Add(dt_EditResult);
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                        dsReturn.Tables.Add(dt_EditResult);

                    }
                }
                return dsReturn;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;

            }
        }

        private void DeleteDataAndBackup(string strTableName, string strRouteCode, DataTable dtList)
        {
            string strWSSrcID = dtList.Rows[0]["WSSrcID"].ToString();
            //将主表的信息插入到His表
            DataTable dtWS = conn.GetDataTable(@" 
                                                        SELECT [WSSrcID]
                                                                ,@Param1 [RouteCode]
                                                                ,[WSID]
                                                                ,[ServicePath]
                                                                ,[WSName]
                                                                ,[WSType]
                                                                ,[WSHelp]
                                                                ,[WSHost]
                                                                ,[WSURL]
                                                                ,[WSState]
                                                                ,[WSVision]
                                                                ,[WSMethod]
                                                                ,[NeedLogin]
                                                                ,[WSUnicode]
                                                                ,IsVex
                                                                ,CallSample
                                                                ,[CreateTime] CreateTimeOLD
                                                                ,[CreateUser] CreateUserOLD
                                                                ,[UpdateTime] UpdateTimeOLD
                                                                ,[UpdateUser] UpdateUserOLD
                                                            FROM " + strTableName + @"
                                                            WHERE WSSrcID=@param0

                                                    ", new string[] { strWSSrcID, strRouteCode });

            conn.InsertByVex("[M03_GOVERN].[WS1_WSHisHead]", dtWS);

            //将明细表的信息插入到His表
            DataTable dtWSParam = conn.GetDataTable(@" 
                                                        SELECT [ParamID]
                                                              ,@Param1 [RouteCode]
                                                              ,[WSSrcID]
                                                              ,[WSID]
                                                              ,[ParamIndex]
                                                              ,[ParamContent]
                                                              ,[ParamName]
                                                              ,[ParamType]
                                                              ,[ParamMustFlag]
                                                              ,[DefaultValue]
                                                              ,[CreateTime] CreateTimeOLD
                                                              ,[CreateUser] CreateUserOLD
                                                              ,[UpdateTime] UpdateTimeOLD
                                                              ,[UpdateUser] UpdateUserOLD
                                                            FROM [B01_MDM].[WS2_WS" + strRouteCode + @"Detail] 
                                                            WHERE WSSrcID=@param0

                                                    ", new string[] { strWSSrcID, strRouteCode });

            if (dtWSParam.Rows.Count > 0)
            {
                conn.InsertByVex("[M03_GOVERN].[WS2_WSHisDetail]", dtWSParam);
            }

            //删除主表
            conn.TableKeyList.Clear();
            conn.TableKeyList.Add("WSSrcID");
            conn.DeleteByVex(strTableName, dtList);

            //删除明细表
            if (dtWSParam.Rows.Count > 0)
            {
                dtList.Rows[0]["Updatetime"] = DateTime.Now.AddDays(1);
                conn.DeleteByVex("[B01_MDM].[WS2_WS" + strRouteCode + @"Detail]", dtList);
            }
        }

        private string UpdateWSSrc(DataTable dtList, string strTableName, string strRouteCode)
        {
            string strWSSrcID = dtList.Rows[0]["WSSrcID"].ToString();
            string strServicePath = dtList.Rows[0]["ServicePath"].ToString();
            string strWSName = dtList.Rows[0]["WSName"].ToString();
            string strWSID = dtList.Rows[0]["WSID"].ToString();
            string strWSSrcIDCopy = dtList.Rows[0]["WSSrcIDCopy"].ToString(); //被拷贝的对象
            bool bIsNew = false;

            if (strServicePath == "" || strWSName == "")
            {
                throw new Exception("传入的参数有误！");
            }

            if (strWSSrcID == "")
            {
                strWSSrcID = Guid.NewGuid().ToString();
                bIsNew = true;

                //获取WSID
                strWSID = conn.GetDataTableFirstValue("SELECT WSID FROM [B01_MDM].[WS0_WSMainDoc] WHERE ServicePath=@Param0 AND WSName=@Param1", new string[2] { strServicePath, strWSName }).ToString();

                //如果WSService表不存在，那么插入新数据
                if (strWSID == "")
                {
                    strWSID = Guid.NewGuid().ToString();

                    DataTable dtWSService = new DataTable();
                    dtWSService.Columns.Add("WSID");
                    dtWSService.Columns.Add("ServicePath");
                    dtWSService.Columns.Add("WSName");
                    dtWSService.Rows.Add(new object[] { strWSID, strServicePath, strWSName });
                    conn.InsertByVex("[B01_MDM].[WS0_WSMainDoc]", dtWSService);
                }

                //复制
                if (strWSSrcIDCopy != "")
                {
                    DataTable dtParam = conn.GetDataTable(@"

                                                                        SELECT NEWID() AS ParamID
                                                                              ,@Param0 AS WSSrcID
                                                                              ,@Param1 AS WSID
                                                                              ,[ParamIndex]
                                                                              ,[ParamContent]
                                                                              ,[ParamName]
                                                                              ,[ParamType]
                                                                              ,[ParamMustFlag]
                                                                              ,[DefaultValue]
                                                                              ,[CreateTime]
                                                                              ,[CreateUser]
                                                                              ,[UpdateTime]
                                                                              ,[UpdateUser]
                                                                          FROM [B01_MDM].[WS2_WS" + strRouteCode + @"Detail] 
                                                                          WHERE WSSrcID=@param2", new string[] { strWSSrcID, strWSID, strWSSrcIDCopy });

                    if (dtParam.Rows.Count > 0)
                    {
                        conn.TableKeyList.Clear();
                        conn.TableKeyList.Add("ParamID");
                        conn.InsertByVex("[B01_MDM].[WS2_WS" + strRouteCode + @"Detail]", dtParam);
                    }
                }
            }
            else
            {
                //核对WSID是否正确
                string strWSIDTemp = conn.GetDataTableFirstValue("SELECT WSID FROM [B01_MDM].[WS0_WSMainDoc] WHERE ServicePath=@Param0 AND WSName=@Param1", new string[2] { strServicePath, strWSName }).ToString();
                if (strWSIDTemp == "" || strWSIDTemp.ToUpper() != strWSID.ToUpper())
                {
                    throw new Exception("传入的参数有误！");
                }
            }

            string strWSState = dtList.Rows[0]["WSState"].ToString().Trim();
            string strStartService = "";

            if (dtList.Columns.Contains("StartService"))
            {
                strStartService = dtList.Rows[0]["StartService"].ToString();
                dtList.Columns.Remove("StartService");
            }

            UpdateLinkInfo(strWSID, strRouteCode, strWSState, strStartService, strWSSrcID);

            if (dtList.Rows[0]["WSState"].ToString().Trim() == "运行中")
            {
                //判断该WSID是否已经有在运行的了
                int nCount = Convert.ToInt32(conn.GetDataTableFirstValue("SELECT Count(1) as C FROM " + strTableName + " WHERE WSID=@Param0 AND WSSrcID!=@Param1 AND WSState='运行中'", new string[2] { strWSID, strWSSrcID }));
                if (nCount > 0)
                {
                    throw new Exception("该服务在本路由下已经其他的接口在运行了，不能重复运行，请修改状态后重试！");
                }

            }


            dtList.Columns.Remove("WSSrcIDCopy");

            if (bIsNew) //添加
            {
                dtList.Rows[0]["WSSrcID"] = strWSSrcID;
                dtList.Rows[0]["WSID"] = strWSID;
                conn.InsertByVex(strTableName, dtList);
            }
            else
            {
                conn.TableKeyList.Clear();
                conn.TableKeyList.Add("WSSrcID");
                conn.UpdateByVex(strTableName, dtList);
            }

            return strWSSrcID;
        }

        private void UpdateLinkInfo(string strWSID, string strRouteCode, string strWSState, string strStartService, string strWSSrcID)
        {
            DataTable dtLink = conn.GetDataTable("SELECT [LinkID] ,[RouteCode],[WSID],[WSSrcID],[state],UpdateTime FROM B01_MDM.WSR_WSRouteLink WHERE WSID=@Param0 AND RouteCode=@Param1", new string[2] { strWSID, strRouteCode });


            if (strWSState == "运行中")
            {

                //将对应的WSApplayRouteLink的状态改成已启用
                //没有数据，需要插入
                if (dtLink.Rows.Count == 0)
                {
                    DataRow dr = dtLink.NewRow();
                    dr["LinkID"] = Guid.NewGuid().ToString();
                    dr["RouteCode"] = strRouteCode;
                    dr["WSID"] = strWSID;
                    dr["WSSrcID"] = strWSSrcID;
                    dr["state"] = "已启用";
                    dtLink.Rows.Add(dr);

                    conn.InsertByVex("B01_MDM.WSR_WSRouteLink", dtLink);
                }
                else
                {
                    //如果有数据，并且路由指向的是本服务资源的话，需要将状态修改为已启用
                    if (strStartService != "")
                    {
                        if (strStartService.ToUpper() == "ON" ||
                            strStartService.ToUpper() == "TRUE" ||
                            strStartService.ToUpper() == "1")
                        {
                            dtLink.Rows[0]["WSSrcID"] = strWSSrcID;
                            dtLink.Rows[0]["state"] = "已启用";

                            conn.TableKeyList.Clear();
                            conn.TableKeyList.Add("LinkID");
                            conn.UpdateByVex("B01_MDM.WSR_WSRouteLink", dtLink);
                        }

                    }
                }

            }
            else
            {
                //修改WSApplayRouteLink的表信息
                //没有数据，需要插入
                if (dtLink.Rows.Count == 0)
                {
                    DataRow dr = dtLink.NewRow();
                    dr["LinkID"] = Guid.NewGuid().ToString();
                    dr["RouteCode"] = strRouteCode;
                    dr["WSID"] = strWSID;
                    dr["WSSrcID"] = strWSSrcID;
                    dr["state"] = "已禁用";
                    dtLink.Rows.Add(dr);

                    conn.InsertByVex("B01_MDM.WSR_WSRouteLink", dtLink);
                }
                else
                {
                    //如果有数据，并且路由指向的是本服务资源的话，需要将状态修改为已禁用
                    if (strStartService != "")
                    {
                        if (strStartService.ToUpper() == "ON" ||
                            strStartService.ToUpper() == "TRUE" ||
                            strStartService.ToUpper() == "1")
                        {
                            if (dtLink.Rows[0]["WSSrcID"].ToString() == strWSSrcID)
                            {
                                dtLink.Rows[0]["state"] = "已禁用";

                                conn.TableKeyList.Clear();
                                conn.TableKeyList.Add("LinkID");
                                conn.UpdateByVex("B01_MDM.WSR_WSRouteLink", dtLink);
                            }
                        }

                    }
                }

            }
        }
    }

}