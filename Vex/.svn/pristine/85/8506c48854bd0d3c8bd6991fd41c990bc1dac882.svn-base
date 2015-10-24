using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;

/// 类名：GL_ERP_sizeGroup
/// 类说明：对GL_ERP_sizeGroup(索赔的增删改查)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2014-11-11 
/// 修改人：
/// 修改日期：
/// 修改内容：69815f4f-1e7e-4dfb-ba33-709213405ee4
/// 

namespace HZY.COM.WS.GL_ERP2
{
    /// <summary>
    /// 对GL_ERP_sizeGroup(尺码/尺码组的增删改查)的CRUD,为Easyui专用
    /// </summary>
    /// 
    public class sizeGroup : HZYLogicBase, ILogicGetData
    {
        #region 构造函数

            public sizeGroup()
            {
                this.m_SessionCheck = true;
                }

        #endregion

        #region 内部变量

            private Dbconn conn = new Dbconn("GL_ERP");
            private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
            DateTime timeNow = DateTime.Now;
            private DataTable dt_List = new dsCommon.dtResultDataTable();
            private DataSet m_RequestXML = new DataSet();
            private DataSet m_ReturnData = new DataSet();

        #endregion

        #region GetData 主入口
            /// <summary>
            /// VEX框架的主入口
            /// </summary>
            /// <returns></returns>
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
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET".ToUpper())//取主界面Datagrid的数据.
                    {
                        Get("");
                    };
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Search".ToUpper())//查询的方法
                    {
                        Search();
                    };
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "saveGroup".ToUpper())//保存尺码组的方法
                    {
                        saveGroup();
                    };
                    
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "saveSize".ToUpper()) //保存尺码的方法
                    {
                        saveSize();
                    };
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "sizeList".ToUpper()) //尺码列表
                    {
                        sizeList();
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

        #region 内部函数

            #region 加载数据

            private void Get(string where) { 

                conn.BeginTransaction();
                string strSQL = @"
                    --尺码组
                    SELECT [CT1_ID] AS GroupID
                            ,[CT1_KeyID] AS GroupCode
                            ,[CT1_KeyName] AS GroupName
                            ,[CT1_OptionsValues] AS GroupOV
                            ,[CT1_Options] AS GroupO
                            ,[CT1_State] AS GroupState
                            ,[CT1_LmDt] AS GroupLmDt
	                        INTO #Temp1
                    FROM [M01_CONF].[CT0_CSYTAB]
                    WHERE CT1_CodeName = '尺码组'

                    --尺码
                    SELECT [CT1_ID] AS SizeID
                          ,[CT1_KeyID] AS SizeCode
                          ,[CT1_KeyName] AS SizeName
                          ,[CT1_OptionsValues] AS SizeOV
                          ,[CT1_Options] AS SizeO
                          ,[CT1_State] AS SizeState
                          ,[CT1_FatherID]
                          ,[CT1_LmDt] AS SizeLmDt
                          INTO #Temp2
                    FROM [M01_CONF].[CT0_CSYTAB]
                    WHERE CT1_CodeName = '尺码'

                    --成品数据
                    SELECT GroupID
                    ,SizeID
                    ,GroupCode
                    ,GroupName
                    ,SizeCode
                    ,SizeName
                    ,SizeOV
                    ,SizeO
                    ,GroupState
                    ,SizeState AS [State]
                    ,CASE WHEN SizeLmDt IS NULL THEN GroupLmDt ELSE SizeLmDt END AS [LmDt]
                    INTO #DATA
                    FROM #Temp1 t2
                    Left JOIN #Temp2 t1 on t2.groupid = t1.[CT1_FatherID]";

                conn.ExcuteQuerryByTran(strSQL,new string[]{});

                string SQL = @"
                    SELECT GroupID
                        ,SizeID
                        ,GroupCode
                        ,GroupName
                        ,SizeCode
                        ,SizeName
                        ,SizeOV
                        ,SizeO
                        ,GroupState
                        ,State
                        ,LmDt
                    FROM #DATA WHERE 1=1 " + where + m_hzyPageInfo.Where;
                m_ReturnData = conn.GetDataSetForPageList(SQL, new string[0], m_hzyPageInfo);

                conn.CommitTransaction();

            }

            #endregion

            #region 查询数据
            private void Search() {
                string strWhere = "";

                string strGroup = dt_List.Rows[0]["Group"].ToString();
                string strSize = dt_List.Rows[0]["Size"].ToString();
                string strOv = dt_List.Rows[0]["ov"].ToString();

                if (strGroup != "") { strWhere += " AND GroupCode = '" + strGroup + "'"; };

                if (strSize != "") { strWhere += " AND SizeCode = '" + strSize + "'"; };

                if (strOv != "") { strWhere += " AND SizeOV = '" + strOv + "'"; };

                Get(strWhere);

            }
            #endregion

            #region 保存尺码组
            private void saveGroup() {
                string strID = dt_List.Rows[0]["CT1_ID"].ToString();
                //string strState = dt_List.Rows[0]["CT1_State"].ToString();

                string GUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

                ArrayList listKey = new ArrayList();
                //ArrayList listKey1 = new ArrayList();
                

                //尺码表
                DataTable dt = new DataTable();

                if (strID == ""){
                    dt_List.Rows[0]["CT1_ID"] = GUID;
                    dt_List.Rows[0]["CT1_RgDt"] = timeNow;
                    dt_List.Rows[0]["CT1_RgUser"] = m_hzyMessage.User_Name;
                    dt_List.Rows[0]["CT1_LmDt"] = timeNow;
                    dt_List.Rows[0]["CT1_LmUser"] = m_hzyMessage.User_Name;
                }
                else {

                    listKey.Add("CT1_ID");

                    dt_List.Rows[0]["CT1_LmDt"] = timeNow;
                    dt_List.Rows[0]["CT1_LmUser"] = m_hzyMessage.User_Name;
                    dt_List.Rows[0]["CT1_UptNo"] = 1;

                    //if (strState == "99"){ //尺码组状态为99，刷尺码状态
                    //    listKey1.Add("CT1_FatherID");

                    //    dt.Columns.Add("CT1_State");
                    //    dt.Columns.Add("CT1_FatherID");
                    //    dt.Columns.Add("CT1_LmDt");
                    //    dt.Columns.Add("CT1_LmUser");
                    //    dt.Columns.Add("CT1_UptNo");

                    //    DataRow dr = dt.NewRow();

                    //    dt.Rows.Add(dr);

                    //    dt.Rows[0]["CT1_State"] = dt_List.Rows[0]["CT1_State"].ToString();
                    //    dt.Rows[0]["CT1_FatherID"] = strID;
                    //    dt.Rows[0]["CT1_LmDt"] = timeNow;
                    //    dt.Rows[0]["CT1_LmUser"] = m_hzyMessage.User_Name;
                    //    dt.Rows[0]["CT1_UptNo"] = "1";

                };

                bool bResult;

                conn.LockTableList.Add("M01_CONF.CT0_CSYTAB");

                conn.BeginTransaction(); // 开启事务

                if (dt_List.Rows[0]["CT1_ID"].ToString() == GUID)
                {
                    bResult = conn.Insert("M01_CONF.CT0_CSYTAB", dt_List);
                }
                else {
                    bResult = conn.Update("M01_CONF.CT0_CSYTAB", dt_List, listKey);
                    //conn.Update("M01_CONF.CT0_CSYTAB", dt, listKey1);   //尺码表状态更新 
                };

                conn.CommitTransaction();

                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "操作失败" });
                };
                m_ReturnData.Tables.Add(dt_EditResult);
            }
        #endregion

            #region 保存尺码
            private void saveSize() {

                string strID = dt_List.Rows[0]["CT1_ID"].ToString();

                int count = dt_List.Rows.Count;

                ArrayList listKey = new ArrayList();

                if (strID == "")
                {
                    for (int i = 0; i < count; i++)
                    {
                        string GUID = System.Guid.NewGuid().ToString();
                        dt_List.Rows[i]["CT1_ID"] = GUID;
                        dt_List.Rows[i]["CT1_RgDt"] = timeNow;
                        dt_List.Rows[i]["CT1_RgUser"] = m_hzyMessage.User_Name;
                        dt_List.Rows[i]["CT1_LmDt"] = timeNow;
                        dt_List.Rows[i]["CT1_LmUser"] = m_hzyMessage.User_Name;
                    };
                }
                else {
                    listKey.Add("CT1_ID");
                    for (int i = 0; i < count; i++)
                    {
                        dt_List.Rows[i]["CT1_LmDt"] = timeNow;
                        dt_List.Rows[i]["CT1_LmUser"] = m_hzyMessage.User_Name;
                    };
                };

                bool bResult;

                conn.LockTableList.Add("M01_CONF.CT0_CSYTAB");

                conn.BeginTransaction(); // 开启事务

                if (strID == "")
                {
                    bResult = conn.Insert("M01_CONF.CT0_CSYTAB", dt_List);
                }
                else
                {
                    bResult = conn.Update("M01_CONF.CT0_CSYTAB", dt_List, listKey);
                };

                conn.CommitTransaction();

                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "操作失败" });
                };

                m_ReturnData.Tables.Add(dt_EditResult);

            }
        #endregion

            #region 尺码列表
                private void sizeList() {
                    string strFatherId = dt_List.Rows[0]["fatherid"].ToString();

                    string strSQL = @"
                            SELECT  [CT1_ID]
                                  ,[CT1_KeyID] AS sizecode
                                  ,[CT1_KeyName] AS sizename
                                  ,[CT1_OptionsValues] AS sizeov
                                  ,[CT1_Options] AS sizeo
                                  ,[CT1_State] AS state
                                  ,[CT1_FatherID]
                                  ,[CT1_LmDt]
                                  ,[CT1_LmUser]
                            FROM [M01_CONF].[CT0_CSYTAB]
                            WHERE CT1_CodeName = '尺码' AND CT1_FatherID = '" + strFatherId + "'";
                    m_ReturnData = conn.GetDataSet(strSQL);
                }
            #endregion


        #endregion
    };
}