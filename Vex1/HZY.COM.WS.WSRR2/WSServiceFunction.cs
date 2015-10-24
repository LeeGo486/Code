using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：WSServiceFunction
/// 类说明：对WSServiceFunction的CRUD
/// 创建人：马卫清
/// 创建日期：2014-04-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{

    public class WSServiceFunction : HZYLogicBase, ILogicGetData
    {
        public WSServiceFunction()
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
                    string strWSID = ds.Tables["LIst"].Rows[0]["WSID"].ToString();

                    string strSQL = @"
                                    SELECT  [WSSeaviceFunctionID] ,
                                            [WSID] ,
                                            [FunctionName] ,
                                            REPLACE(REPLACE(REPLACE(FunctionContent, CHAR(9), '    '), CHAR(13), 'ㄧ'),
                                                    CHAR(10), 'ㄧ') FunctionContent ,
                                            REPLACE(REPLACE(REPLACE(InputFormat, CHAR(9), '    '), CHAR(13), 'ㄧ'),
                                                    CHAR(10), 'ㄧ') InputFormat ,
                                            REPLACE(REPLACE(REPLACE(ReturnFormat, CHAR(9), '    '), CHAR(13), 'ㄧ'),
                                                    CHAR(10), 'ㄧ') ReturnFormat ,
                                            REPLACE(REPLACE(REPLACE([LogicContent], CHAR(9), '    '), CHAR(13),
                                                            'ㄧ'), CHAR(10), 'ㄧ') [LogicContent] ,
                                            [CreateTime] ,
                                            [CreateUser] ,
                                            CONVERT(VARCHAR(100), updatetime, 21) AS updatetime ,
                                            [UpdateUser]
                                    FROM    [B01_MDM].[WS0M_WSMethodDoc]

                                    WHERE WSID=@Param0 " + m_hzyPageInfo.Where;


                    dsReturn = conn.GetDataSetForPageList(strSQL, new string[] { strWSID }, m_hzyPageInfo);

                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT")
                {
                    bool bResult = false;
                    conn.LockTableList.Add("[B01_MDM].[WS0M_WSMethodDoc]");
                    conn.BeginTransaction();
                    string strWSSeaviceFunctionID = ds.Tables["list"].Rows[0]["WSSeaviceFunctionID"].ToString();
                    string strWSID = ds.Tables["list"].Rows[0]["WSID"].ToString();

                    if (strWSID == "")
                    {
                        throw new Exception("传入的参数有误！");
                    }

                    //添加数据
                    if (strWSSeaviceFunctionID == "")
                    {

                        string strFunctionName = ds.Tables["List"].Rows[0]["FunctionName"].ToString();

                        //判断服务路径和服务名称是否已经存在
                        if (conn.GetDataTableRowCount("SELECT top 50 1 AS A FROM [B01_MDM].[WS0M_WSMethodDoc] WHERE WSID=@Param0 AND FunctionName=@Param1", new string[] { strWSID, strFunctionName }) > 0)
                        {
                            throw new Exception("该方法已经存在，请检查！");
                        }

                        ds.Tables["list"].Columns.Remove("WSSeaviceFunctionID");
                        bResult = conn.InsertByVex("[B01_MDM].[WS0M_WSMethodDoc]", ds.Tables["List"]);
                    }
                    else//修改数据
                    {
                        string strFunctionName = ds.Tables["List"].Rows[0]["FunctionName"].ToString();


                        //判断服务路径和服务名称是否已经存在
                        if (conn.GetDataTableRowCount(@"SELECT top 50 1 AS A FROM [B01_MDM].[WS0M_WSMethodDoc] WHERE WSID=@Param0 AND FunctionName=@Param1 
                                                AND WSSeaviceFunctionID!=@Param2", new string[] { strWSID, strFunctionName, strWSSeaviceFunctionID }) > 0)
                        {
                            throw new Exception("该方法已经存在，请检查！");
                        }

                        conn.TableKeyList.Add("WSSeaviceFunctionID");
                        bResult = conn.UpdateByVex("[B01_MDM].[WS0M_WSMethodDoc]", ds.Tables["List"]);
                    }
                    //更新全文检索的数据
                    WSServiceInfo.UpdateFullText(strWSID, conn);

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
                    conn.LockTableList.Add("[B01_MDM].[WS0M_WSMethodDoc]");
                    conn.BeginTransaction();
                    string strWSSeaviceFunctionID = ds.Tables["list"].Rows[0]["WSSeaviceFunctionID"].ToString();


                    conn.TableKeyList.Add("WSSeaviceFunctionID");

                    string strWSID = conn.GetDataTableFirstValue("SELECT WSID FROM  [B01_MDM].[WS0M_WSMethodDoc] WHERE WSSeaviceFunctionID=@Param0", new string[] { strWSSeaviceFunctionID }).ToString();

                    bResult = conn.DeleteByVex("[B01_MDM].[WS0M_WSMethodDoc]", ds.Tables["list"]);

                    //更新全文检索的数据
                    WSServiceInfo.UpdateFullText(strWSID, conn);

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
    }

}