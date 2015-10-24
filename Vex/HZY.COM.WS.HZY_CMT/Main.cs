using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;
using System.Web;
using System.Data.SqlClient;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.ST1005A;

/// 类名：Main
/// 类说明：对CMT_Main(任务管理)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2014-07-09
/// 修改人：
/// 修改日期： 
/// 修改内容：
/// 

namespace HZY.COM.WS.HZY_CMT
{
    public class Main : HZYLogicBase, ILogicGetData
    {
        #region 构造函数

        public Main()
        {
            this.m_SessionCheck = true;
        }

        #endregion

        #region 内部变量

        private Dbconn conn = new Dbconn("HZY_CMT");
        private Dbconn connMDM = new Dbconn("MDM");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime now = DateTime.Now;
        private DataTable dt_MainList = new dsCommon.dtResultDataTable();
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
                dt_MainList = m_RequestXML.Tables["List"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET".ToUpper())//任务主界面Datagrid
                {
                    Get("");
                }
                else
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "TaskType".ToUpper())//任务类型
                    {
                        TaskType();
                    }
                    else
                        if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DeliverType".ToUpper())//分发策略
                        {
                            DeliverType();
                        }
                        else
                            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Insert".ToUpper()) //保存任务
                            {
                                Insert();
                            }
                            else
                                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Excel".ToUpper()) //保存申请的数据
                                {
                                    Excel();
                                }
                                else
                                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSearch".ToUpper()) //主界面查询
                                    {
                                        GetSearch();
                                    }
                                    else
                                        if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Update".ToUpper()) //发布任务
                                        {
                                            Update();
                                        }
                                        else
                                            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AnalyseGet1".ToUpper()) //分析1
                                            {
                                                AnalyseGet1("");
                                            }
                                            else
                                                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AnalyseGet2".ToUpper()) //分析2
                                                {
                                                    AnalyseGet2();
                                                }
                                                else
                                                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AnGet2ToAnGet1".ToUpper()) //分析2到分析1
                                                    {
                                                        AnGet2ToAnGet1();
                                                    }
                                                    else
                                                        if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "BatchNo".ToUpper())//获取CRM批次号
                                                        {
                                                            BatchNo();
                                                        }
                                                        else 
                                                            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCompany".ToUpper())//获取公司
                                                            {
                                                                m_ReturnData = GetCompany();
                                                            }
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

            #region DataGrid

                private void Get(string pstrWhere){
                    
                    //任务ID
                    string strTaskWhere = "";
                    //特定用户权限
                    string strParticularTaskID = ParticularTaskID();
                    if (strParticularTaskID == "")
                    {
                        strTaskWhere = privilege();
                    }
                    else {
                        strTaskWhere = strParticularTaskID;
                    }

                    string strSQL = @"
                                SELECT DISTINCT
                                       [TK1_ID]
                                      ,[Code]
                                      ,[JobName]
                                      ,[TaskType]
                                      ,[Desp]
                                      ,[ValidateState]
                                      ,[ValidateFrom]
                                      ,[ValidateTo]
                                      ,[CustomerNum]
                                      ,[BespeakNum]
                                      ,[Batch]
                                      ,[Rgdt]
                                      ,[RgUser]
                                      ,[LmDt]
                                      ,[LmUser]
                                FROM [dbo].[View_JobMain] WITH (NOLOCK) WHERE 1=1" + strTaskWhere + pstrWhere;
                m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            }
                 
            #endregion

            #region 任务类型
            /// <summary>
                /// 用于返回任务类型的code，name
                /// </summary>
                private void TaskType()
                {
                    string strSQL = @"
                            SELECT [ID]
                                  ,[Name]
                            FROM [M02_BPM].[TKT_TaskType]";
                    m_ReturnData = conn.GetDataSet(strSQL);
                }
                #endregion

            #region 分发策略
            /// <summary>
            /// 分发策略下拉框
            /// </summary>
            private void DeliverType()
            {
                string strSQL = @"
                        SELECT [ID]
                              ,[Name]
                        FROM M01_CONF.DIST_DistributeStrategy
                        WHERE Strategy='手工'";
                m_ReturnData = conn.GetDataSet(strSQL);
            }
            #endregion

            #region 保存任务
            /// <summary>
            /// 保存各种类型的任务，调用不同的方法
            /// (1.EXCEL,2.CRM,3.DAT)
            /// </summary>
            private void Insert()
            {
                if (dt_MainList.Rows[0]["InType"].ToString() == "1")
                {
                    ExcelSave();
                }
                else
                    if (dt_MainList.Rows[0]["InType"].ToString() == "2")
                    {
                        CRMSave();
                    }
                    else
                        if (dt_MainList.Rows[0]["InType"].ToString() == "3")
                        {
                            DATSave();
                        }
                        else
                        {
                            return;
                        }
            }
            #endregion

            #region 保存EXCEL类型的任务
                private void ExcelSave()
            {

                DataSet dsBasic = CreateTable();

                string strCode = AutoCode("任务编码");
                string strBatch = dt_MainList.Rows[0]["Batch"].ToString();//前台传
                string strJobId = dsBasic.Tables["dtTH"].Rows[0]["ID"].ToString();

                //TaskHead
                dsBasic.Tables["dtTH"].Rows[0]["TKT_ID"] = dt_MainList.Rows[0]["JobType"];
                dsBasic.Tables["dtTH"].Rows[0]["Code"] = strCode;
                dsBasic.Tables["dtTH"].Rows[0]["Name"] = dt_MainList.Rows[0]["JobName"];
                dsBasic.Tables["dtTH"].Rows[0]["Desp"] = dt_MainList.Rows[0]["Remark"];
                dsBasic.Tables["dtTH"].Rows[0]["Dist_ID"] = dt_MainList.Rows[0]["Deliver"];
                dsBasic.Tables["dtTH"].Rows[0]["ValidateState"] = "未审核";
                dsBasic.Tables["dtTH"].Rows[0]["ImportPath"] = dt_MainList.Rows[0]["Route"];
                dsBasic.Tables["dtTH"].Rows[0]["ValidateFrom"] = dt_MainList.Rows[0]["Start"];
                dsBasic.Tables["dtTH"].Rows[0]["ValidateTo"] = dt_MainList.Rows[0]["End"];
                dsBasic.Tables["dtTH"].Rows[0]["Batch"] = strBatch;
                dsBasic.Tables["dtTH"].Rows[0]["Rgdt"] = now;
                dsBasic.Tables["dtTH"].Rows[0]["RgUser"] = this.hzyMessage.User_Name_CN;
                dsBasic.Tables["dtTH"].Rows[0]["LmDt"] = now;
                dsBasic.Tables["dtTH"].Rows[0]["LmUser"] = this.hzyMessage.User_Name;

                //TaskSchedule
                dsBasic.Tables["dtTS"].Rows[0]["TK1_ID"] = strJobId;
                dsBasic.Tables["dtTS"].Rows[0]["BatchNo"] = strBatch;
                dsBasic.Tables["dtTS"].Rows[0]["Dist_ID"] = dt_MainList.Rows[0]["Deliver"];
                dsBasic.Tables["dtTS"].Rows[0]["State"] = "已导入";
                dsBasic.Tables["dtTS"].Rows[0]["Rgdt"] = now;
                dsBasic.Tables["dtTS"].Rows[0]["RgUser"] = this.hzyMessage.User_Name_CN;
                dsBasic.Tables["dtTS"].Rows[0]["LmDt"] = now;
                dsBasic.Tables["dtTS"].Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;

                bool bResult;

                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("[M02_BPM].[TK1_TaskHead]", dsBasic.Tables["dtTH"]);
                bResult = conn.Insert("[M02_BPM].[TK3_TaskSchedule]", dsBasic.Tables["dtTS"]);
                conn.CommitTransaction();//提交事务

                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "上传成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "上传失败" });
                }
                m_ReturnData.Tables.Add(dt_EditResult);

            }
            #endregion

            #region 保存CRM类型的任务
            private void CRMSave()
            {
                DataSet dsBasic = CreateTable();

                string strCode = AutoCode("任务编码");
                string strJobId = dsBasic.Tables["dtTH"].Rows[0]["ID"].ToString();

                //TaskHead
                dsBasic.Tables["dtTH"].Rows[0]["TKT_ID"] = dt_MainList.Rows[0]["JobType"];
                dsBasic.Tables["dtTH"].Rows[0]["Code"] = strCode;
                dsBasic.Tables["dtTH"].Rows[0]["Dist_ID"] = dt_MainList.Rows[0]["Deliver"];
                dsBasic.Tables["dtTH"].Rows[0]["Name"] = dt_MainList.Rows[0]["JobName"];
                dsBasic.Tables["dtTH"].Rows[0]["Desp"] = dt_MainList.Rows[0]["Remark"];
                dsBasic.Tables["dtTH"].Rows[0]["ValidateState"] = "未审核";
                dsBasic.Tables["dtTH"].Rows[0]["ValidateFrom"] = dt_MainList.Rows[0]["Start"];
                dsBasic.Tables["dtTH"].Rows[0]["ValidateTo"] = dt_MainList.Rows[0]["End"];
                dsBasic.Tables["dtTH"].Rows[0]["Batch"] = dt_MainList.Rows[0]["Num"];
                dsBasic.Tables["dtTH"].Rows[0]["Rgdt"] = now;
                dsBasic.Tables["dtTH"].Rows[0]["RgUser"] = this.hzyMessage.User_Name_CN;
                dsBasic.Tables["dtTH"].Rows[0]["LmDt"] = now;
                dsBasic.Tables["dtTH"].Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;

                //TaskSchedule
                dsBasic.Tables["dtTS"].Rows[0]["TK1_ID"] = strJobId;
                dsBasic.Tables["dtTS"].Rows[0]["BatchNo"] = dt_MainList.Rows[0]["Num"];
                dsBasic.Tables["dtTS"].Rows[0]["State"] = "未处理";
                dsBasic.Tables["dtTS"].Rows[0]["Dist_ID"] = dt_MainList.Rows[0]["Deliver"];
                dsBasic.Tables["dtTS"].Rows[0]["Rgdt"] = now;
                dsBasic.Tables["dtTS"].Rows[0]["RgUser"] = this.hzyMessage.User_Name_CN;
                dsBasic.Tables["dtTS"].Rows[0]["LmDt"] = now;
                dsBasic.Tables["dtTS"].Rows[0]["LmUser"] = this.hzyMessage.User_Name_CN;

                bool bResult;

                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("[M02_BPM].[TK1_TaskHead]", dsBasic.Tables["dtTH"]);
                bResult = conn.Insert("[M02_BPM].[TK3_TaskSchedule]", dsBasic.Tables["dtTS"]);
                conn.CommitTransaction();//提交事务

                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "上传成功" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "上传失败" });
                }
                m_ReturnData.Tables.Add(dt_EditResult);

            }
            #endregion

            #region 保存DAT类型的任务
            private void DATSave()
            {

            }
            #endregion

            #region 保存需要的表
            /// <summary>
            /// 创建Ds，包括TK1_TaskHead，TK4_TaskSchedule
            /// </summary>
            /// <returns>返回Ds，里面有三张Dt</returns>
            private DataSet CreateTable()
            {
                DataSet dsReturn = new DataSet(); //返回用的表

                DataTable dtTH = new DataTable(); //表头
                DataTable dtTS = new DataTable(); //队列

                DataRow drTH = dtTH.NewRow();
                DataRow drTS = dtTS.NewRow();

                dtTH.Rows.Add(drTH);
                dtTS.Rows.Add(drTS);

                System.Guid guid = System.Guid.NewGuid();               //Guid 类型
                string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型


                //表头
                dtTH.Columns.Add("ID");
                dtTH.Columns.Add("M01P_ID");
                dtTH.Columns.Add("M02C_ID");
                dtTH.Columns.Add("TKT_ID");
                dtTH.Columns.Add("DIST_ID");
                dtTH.Columns.Add("Code");
                dtTH.Columns.Add("Name");
                dtTH.Columns.Add("Desp");
                dtTH.Columns.Add("ValidateState");
                dtTH.Columns.Add("ValidateFrom");
                dtTH.Columns.Add("ValidateTo");
                dtTH.Columns.Add("ImportPath");
                dtTH.Columns.Add("ImportChannel");
                dtTH.Columns.Add("Batch");
                dtTH.Columns.Add("Rgdt");
                dtTH.Columns.Add("RgUser");
                dtTH.Columns.Add("LmDt");
                dtTH.Columns.Add("LmUser");

                //表头赋值
                dtTH.Rows[0]["ID"] = strGUID;
                dtTH.Rows[0]["M01P_ID"] = "ADDDFF05-08AF-4E51-89EB-3C7185DD7050";
                dtTH.Rows[0]["M02C_ID"] = "D55D3D5A-57A3-4A97-87F2-1CC3DAF98C8E";

                //队列表
                dtTS.Columns.Add("ID");
                dtTS.Columns.Add("M01P_ID");
                dtTS.Columns.Add("M02C_ID");
                dtTS.Columns.Add("TK1_ID");
                dtTS.Columns.Add("Dist_ID");
                dtTS.Columns.Add("BatchNo");
                dtTS.Columns.Add("State");
                dtTS.Columns.Add("Rgdt");
                dtTS.Columns.Add("RgUser");
                dtTS.Columns.Add("LmDt");
                dtTS.Columns.Add("LmUser");

                //队列表赋值
                string strGUIDTs = System.Guid.NewGuid().ToString();
                dtTS.Rows[0]["ID"] = strGUIDTs;
                dtTS.Rows[0]["M01P_ID"] = "ADDDFF05-08AF-4E51-89EB-3C7185DD7050";
                dtTS.Rows[0]["M02C_ID"] = "D55D3D5A-57A3-4A97-87F2-1CC3DAF98C8E";


                //表取名
                dtTH.TableName = "dtTH";
                dtTS.TableName = "dtTS";

                dsReturn.Tables.Add(dtTH);
                dsReturn.Tables.Add(dtTS);
                return dsReturn;
            }
            #endregion

            #region 自动编码
            /// <summary>
            /// 根据不同的类型，生成TaskHead表需要的最大编号
            /// </summary>
            /// <param name="pstrType">类型：任务编码，批次号</param>
            /// <returns>返回一个String</returns>

            private string AutoCode(string pstrType){
                string strReturn = "";

                if (pstrType == "Excel")
                {
                    string strSQL = @"
                        SELECT MAX([BatchNo]) BatchNo 
                        FROM [M02_BPM].[TK4_TaskScheduleData]
                        WHERE [BatchNo] LIKE 'E%'";

                    string strMaxCode = conn.GetDataTableFirstValue(strSQL).ToString();
                    if (strMaxCode != "")
                    {
                        //去掉第一位
                        strMaxCode = strMaxCode.Remove(0, 1);

                        int iNum = Convert.ToInt32(strMaxCode);
                        iNum++;
                        strReturn = "E" + iNum.ToString("00000");
                    }
                    else
                    {
                        strReturn = "E00001";
                    };
                }
                else {
                    string strSQL = @"
                        SELECT MAX([Code])
                        FROM [CMT].[M02_BPM].[TK1_TaskHead]";
                    string strMaxCode = conn.GetDataTableFirstValue(strSQL).ToString();
                    if (strMaxCode != "")
                    {
                        //去掉第一位
                        strMaxCode = strMaxCode.Remove(0, 1);

                        int iNum = Convert.ToInt32(strMaxCode);
                        iNum++;
                        strReturn = "T" + iNum.ToString("000000");
                    }
                    else
                    {
                        strReturn = "T000001";
                    };

                }

                return strReturn;
            }

            #endregion

            #region Excel数据导入
            /// <summary>
            /// 将Excel导入后，存入[TK5_TaskExcelData]
            /// </summary>
                private void Excel()
            {
                DataTable dtInput = m_RequestBak.Tables[0];
                dtInput.Columns[0].ColumnName = "CUS1_MobileNum";
                dtInput.Columns[1].ColumnName = "ReservationDate";

                string strMaxCode = AutoCode("Excel"); //最大批次号

                //增加字段
                dtInput.Columns.Add("ID");
                dtInput.Columns.Add("M01P_ID");
                dtInput.Columns.Add("M02C_ID");
                dtInput.Columns.Add("BatchNo");
                dtInput.Columns.Add("HasDate");
                dtInput.Columns.Add("State");
                dtInput.Columns.Add("Rgdt");
                dtInput.Columns.Add("RgUser");
                dtInput.Columns.Add("LmDt");
                dtInput.Columns.Add("LmUser");

                dtInput.TableName = "dtInput";
                
                //取dt行数
                int iNum = dtInput.Rows.Count;

                for (int i = 0; i < iNum; i++) {
                    System.Guid guid = System.Guid.NewGuid();               //Guid 类型
                    string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

                    //赋值
                    dtInput.Rows[i]["ID"] = strGUID;
                    dtInput.Rows[i]["M01P_ID"] = "ADDDFF05-08AF-4E51-89EB-3C7185DD7050";
                    dtInput.Rows[i]["M02C_ID"] = "D55D3D5A-57A3-4A97-87F2-1CC3DAF98C8E";
                    dtInput.Rows[i]["BatchNo"] = strMaxCode;
                    dtInput.Rows[i]["State"] = "未处理";
                    dtInput.Rows[i]["Rgdt"] = now;
                    dtInput.Rows[i]["RgUser"] = this.hzyMessage.User_Name_CN;
                    dtInput.Rows[i]["LmDt"] = now;
                    dtInput.Rows[i]["LmUser"] = this.hzyMessage.User_Name_CN;

                    string strRD = dtInput.Rows[i]["ReservationDate"].ToString();
                    if (strRD == ""){
                        dtInput.Rows[i]["HasDate"] = "0";
                    }else{
                        dtInput.Rows[i]["HasDate"] = "1";
                    };
                }

                
                    

                using (SqlBulkCopy bulkCopy = new SqlBulkCopy(conn.ToString()))
                {
                    bulkCopy.DestinationTableName =
                        "[M02_BPM].[TK5_TaskExcelData]";

                    try
                    {
                        conn.BeginTransaction(); // 开启事务
                        // Write from the source to the destination.
                        bulkCopy.WriteToServer(dtInput);
                        conn.CommitTransaction();//提交事务
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }


                //conn.BeginTransaction(); // 开启事务
                //bResult = conn.Insert("[M02_BPM].[TK5_TaskExcelData]", dtInput);
                //conn.CommitTransaction();//提交事务
                bool bResult = false;
                if (bResult)
                {
                    DataSet dsReturn = conn.GetDataSetBySP("[SRV_MDM].[BatchDataCheck]", new string[4] { "@InputFormat", "@OutputFormat", "@OutputContentType", "@ConditionStr" },
                        new string[4] { "AML", "DB", "RS", "【操作类型,GET】【CONO,ADDDFF05-08AF-4E51-89EB-3C7185DD7050】【DIVI,D55D3D5A-57A3-4A97-87F2-1CC3DAF98C8E】【批次号," + strMaxCode + "】" });
                    
                    string strRetrun = dsReturn.Tables[0].Rows[0]["MSG"].ToString();
                    string strBatchInf = dsReturn.Tables[0].Rows[0]["BatchInf"].ToString();
                    string strErrorMsg = "";
                    if (strRetrun == "成功！")
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "上传成功" });
                        dt_EditResult.Rows.Add(new object[] { true, strBatchInf });
                    }
                    else {
                        dt_EditResult.Rows.Add(new object[] { false, "上传失败" });

                        DataSet dsError = Common.Common.GetDSByExcelXML(strBatchInf);
                        for (int i = 0; i < dsError.Tables["list"].Rows.Count; i++)
                        {
                            strErrorMsg += "电话号码:" + dsError.Tables["list"].Rows[i]["CUS1_MobileNum"]+"-";
                            strErrorMsg += dsError.Tables["list"].Rows[i]["MSG"]+"；";
                        }
                        dt_EditResult.Rows.Add(new object[] { false, strErrorMsg });
                    };
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "上传失败" });
                }
                m_ReturnData.Tables.Add(dt_EditResult);
            }
            #endregion

            #region 主界面查询

                private void GetSearch() {
                    string strWhere = "";
                    //预约类型
                    string strTKT_ID = dt_MainList.Rows[0]["MainType"].ToString();
                    //任务名称
                    string strName = dt_MainList.Rows[0]["MainName"].ToString();
                    //任务状态
                    string strStatus = dt_MainList.Rows[0]["MainState"].ToString();
                    //开始时间
                    string strStart = dt_MainList.Rows[0]["MainStart"].ToString();
                    //结束时间
                    string strEnd = dt_MainList.Rows[0]["MainEnd"].ToString();

                    if (strTKT_ID != "") {
                        strWhere += " AND [TKT_ID] = '" + strTKT_ID + "'";
                    };
                    if(strName != ""){
                        strWhere += " AND [JobName] LIKE '%" + strName + "%'";
                    };
                    if(strStatus != ""){
                        strWhere += " AND [ValidateState] = '" + strStatus + "'";
                    };
                    if (strStart != "" && strEnd != "")
                    {
                        strWhere += " AND [Rgdt] >= cast('" + strStart + "' as datetime) AND [Rgdt] <= cast('" + strEnd + "' as datetime)";
                    };

                    Get(strWhere);//调用Get方法
                }

            #endregion

            #region 发布任务
                    private void Update()
                    {
                        string strID = dt_MainList.Rows[0]["ID"].ToString();

                        string strSQLCheck = @"
                                SELECT [ID]
                                FROM [M02_BPM].[TK1_TaskHead]
                                WHERE [ID] = '" + strID + "'";

                        string strCheck = conn.GetDataTableFirstValue(strSQLCheck).ToString();

                        bool bResult = false;

                        if (strCheck != "")
                        {

                            dt_MainList.Columns.Add("ValidateState");
                            dt_MainList.Rows[0]["ValidateState"] = "进行中";

                            ArrayList listKey = new ArrayList();
                            listKey.Add("ID");

                            conn.BeginTransaction(); // 开启事务
                            bResult = conn.Update("[M02_BPM].[TK1_TaskHead]", dt_MainList, listKey);
                            conn.CommitTransaction();//提交事务
                        }
                        else
                        {
                            bResult = false;
                        };

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "发布成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "发布失败" });
                        }
                        m_ReturnData.Tables.Add(dt_EditResult);
                    }
            #endregion

            #region 分析1
                private void AnalyseGet1(string pstrWhere) {

                    
                    //店铺范围
                    string strDepoitWhere = "";
                    
                    //特定用户范围
                    string strParticularUser = ParticularUser();

                    if (strParticularUser == "")
                    {
                        //取分公司范围
                        strDepoitWhere = GetDepoit();
                    }
                    else {
                        strDepoitWhere = strParticularUser;
                    }

                    //任务ID
                    string strID = dt_MainList.Rows[0]["ID"].ToString();

                    string strSQL = @"
                            SELECT [ID]
                                ,[TK1_ID]
                                ,[JobName]
                                ,[CompanyName]
                                ,[Depotid]
                                ,[DeptName]
                                ,[CUS1_ID]
                                ,[CustomerName]
                                ,[CustomerManager]
                                ,[MobileNum]
                                ,[VIPCard]
                                ,[Birthday]
                                ,[Status]
                                ,[SubmitTime]
                                ,[Fruit]
                                ,[InvitationDate]
                                ,[Reason]
                                ,[RecentConsumptionDate]
                                ,[RecentConsumptionAmount]
                        FROM [dbo].[View_Analyse1]
                        WHERE [TK1_ID] = '" + strID + "' " + strDepoitWhere + pstrWhere;
                        m_ReturnData = conn.GetDataSetForPageList(strSQL,new string[0],m_hzyPageInfo);
                    }
            #endregion

            #region 分析2
                private void AnalyseGet2() {
                    string strTaskID = dt_MainList.Rows[0]["ID"].ToString();
                    string strBegin = dt_MainList.Rows[0]["Begin"].ToString();
                    string strEnd = dt_MainList.Rows[0]["End"].ToString();

                    //特定用户范围
                    string strDepoitWhere = "";
                    string strParticularUser = ParticularUser();

                    if (strParticularUser == "")
                    {
                        //取分公司范围
                        strDepoitWhere = GetDepoit();
                    }
                    else
                    {
                        strDepoitWhere = strParticularUser;
                    }

                    //获取当月时间
                    if (strBegin == "")
                    {
                        int iyearS = now.Year -1;
                        int iyearE = now.Year +1;
                        strBegin = iyearS.ToString() + "-01-01";
                        strEnd = iyearE.ToString() + "-12-31";
                    };

                    //--计划
                    conn.BeginTransaction();

                    string strAnalyse2 = @"
                       --计划
                       SELECT T1.TK1_ID,T1.Depotid,COUNT(T1.CUS1_ID) AS PLANum INTO #PLAN
			           FROM M02_BPM.TK2_TaskDetail AS T1 WITH (NOLOCK) 
			           GROUP BY T1.TK1_ID ,T1.Depotid
                        
                       --店铺临时
                        SELECT DISTINCT
                            Depotid ,
                            CompanyName ,
                            deptName
                        INTO   #tempdepot
                        FROM   B01_MDM.CUS1_CustomerDoc T2 
                        
                       --店铺
			           SELECT DISTINCT T1.TK1_ID,T1.Depotid,PLANum,T2.CompanyName,T2.DeptName INTO #DEPOIT
			           FROM #PLAN T1 WITH (NOLOCK) 
			           JOIN #tempdepot T2 ON T1.Depotid = T2.Depotid
                        
                       --预约
                       SELECT T1.TK1_ID ,T1.Depotid ,COUNT(T1.CUS1_ID) AS [OK] INTO #OK
			           FROM M02_BPM.TK2_TaskDetail AS T1 WITH (NOLOCK) 
			           WHERE [Status]='已预约'
			           GROUP BY T1.TK1_ID,T1.Depotid
                    
                    
                       	--应邀
                       SELECT TK1_ID,Depotid,COUNT(InvitationDate) AS [Success] INTO #Success
			           FROM M02_BPM.TK2_TaskDetail  WITH (NOLOCK) 
			           WHERE [Status]='已预约' AND InvitationDate IS NOT NULL
                       AND InvitationDate >= '" + strBegin + "' AND InvitationDate <= '" + strEnd + @"' 
			           GROUP BY TK1_ID ,Depotid

                        --最终数据
                       SELECT DISTINCT T1.TK1_ID,T1.CompanyName,T1.DeptName,T1.Depotid,T1.PLANum,ISNULL(T2.OK,0) AS OK,ISNULL(T3.Success,0) AS Success,
                       CAST(CONVERT(DECIMAL(38,2),((CONVERT(DECIMAL(38,2),ISNULL(T3.Success,0))/T2.OK) *100))AS VARCHAR(10)) + '%' AS Ratio INTO #All
                       FROM #DEPOIT T1 WITH (NOLOCK)
                       LEFT JOIN #OK T2 ON T1.TK1_ID = T2.TK1_ID AND T1.Depotid = T2.Depotid
                       LEFT JOIN #Success T3 ON T1.TK1_ID = T3.TK1_ID AND T1.Depotid = T3.Depotid";

                    conn.ExcuteQuerryByTran(strAnalyse2, new string[] { });
                    string strSQL = @"
                                SELECT [TK1_ID]
                                      ,[Depotid]
                                      ,[CompanyName]
                                      ,[DeptName]
                                      ,[PLANum]
                                      ,[OK]
                                      ,[Success]
                                      ,[Ratio]
                                  FROM [#All]
                                  WHERE 1=1 AND TK1_ID = '" + strTaskID + "' " + strDepoitWhere;          
                    m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
            #endregion

            #region 分析2到分析1

            private void AnGet2ToAnGet1()
            {
                string strDepotID = dt_MainList.Rows[0]["DepotId"].ToString();
                string strSQL = " AND Depotid='" + strDepotID + "'";
                AnalyseGet1(strSQL);
            }

            #endregion

            #region 批次号检查

                private void BatchNo() {
            string strBNo = dt_MainList.Rows[0]["BatchNo"].ToString();

            string strSQL = @"
                SELECT [BatchNo]
                FROM [M02_BPM].[TK3_TaskSchedule]
                WHERE [BatchNo] = '" + strBNo + "'";

            string strResult = conn.GetDataTableFirstValue(strSQL).ToString();

            if (strResult != ""){
                dt_EditResult.Rows.Add(new object[] { true, "批次号已存在" });
            }
            else{
                dt_EditResult.Rows.Add(new object[] { true, "无数据" });
            };

            m_ReturnData.Tables.Add(dt_EditResult);
        }

            #endregion

            #region 获取数据权限

                #region 获取公司

                private DataSet GetCompany()
                {

                    //string strID = dt_MainList.Rows[0]["ID"].ToString();

                    DataSet dsReturn = new DataSet();

                    //测试环境的Env_ID = 154
                    //DataSet dsCompany = connMDM.GetDataSetBySP("GetCompany", new string[2] { "@Param1", "@Param2" }, new string[2] { "154", hzyMessage.User_Name });
                    //正式环境的Env_ID = 104
                    DataSet dsCompany = connMDM.GetDataSetBySP("GetCompany", new string[2] { "@Param1", "@Param2" }, new string[2] { "104", hzyMessage.User_Name });
                    //SQL条件
                    string strCompany = " AND Name IN (";

                    for (int i = 0; i <= dsCompany.Tables[0].Rows.Count - 1; i++)
                    {

                        //获取公司名（中文）
                        string strAuthName = dsCompany.Tables[0].Rows[i]["Authorization_Name"].ToString();

                        if (strAuthName != "" && i < dsCompany.Tables[0].Rows.Count - 1)
                        {
                            strCompany += "'" + strAuthName + "',";
                        }
                        else if (strAuthName != "" && i == dsCompany.Tables[0].Rows.Count - 1)
                        {
                            strCompany += "'" + strAuthName + "')";
                        }
                        else if (strAuthName == "" && i < dsCompany.Tables[0].Rows.Count - 1)
                        {
                            break;
                        }
                        else if (strAuthName == "" && i == dsCompany.Tables[0].Rows.Count - 1)
                        {
                            strCompany = "";
                        };
                    };


                    string strSQL = @"
                           SELECT [Code]
                            FROM [CMT].[M01_CONF].[M03_Branch] WITH (NOLOCK)
                            WHERE 1=1 " + strCompany;
                    return dsReturn = conn.GetDataSet(strSQL);

                }

                #endregion

                #region 获取店铺首字母
                    private string GetDepoit()
                {
                    //权限
                    string strWhere = " AND 1=1 ";
                    DataSet dsCompany = GetCompany();

                    for (int i = 0; i <= dsCompany.Tables[0].Rows.Count - 1; i++)
                    {
                        string strCode = dsCompany.Tables[0].Rows[i]["Code"].ToString();
                        if (strCode != "" && i == 0)
                        {
                            strWhere += " AND LEFT(Depotid,1) IN ('" + strCode + "')";
                        }
                        else if (strCode != "" && i < dsCompany.Tables[0].Rows.Count - 1)
                        {
                            strWhere += "'" + strCode + "', ";
                        }
                        else if (strCode != "" && i == dsCompany.Tables[0].Rows.Count - 1)
                        {
                            strWhere += "'" + strCode + "')";
                        }

                    };
                    return strWhere;
                }
                #endregion

                #region  根据权限获取任务ID
                    private string privilege()
                    {
                        //权限
                        string strWhere = "1=1 ";
                        DataSet dsCompany = GetCompany();

                        for (int i = 0; i <= dsCompany.Tables[0].Rows.Count - 1; i++)
                        {
                            string strCode = dsCompany.Tables[0].Rows[i]["Code"].ToString();
                            int iNum = dsCompany.Tables[0].Rows.Count - 1;
                            if (strCode != "" && i == 0 && i== iNum)
                            {
                                strWhere += " AND LEFT(Depotid,1) IN ('" + strCode + "')";
                                break;
                            }
                            else if (strCode != "" && i == 0 && i < iNum) {
                                strWhere += " AND LEFT(Depotid,1) IN ('" + strCode + "', ";
                            }
                            else if (strCode != "" && i != 0 && i < iNum)
                            {
                                strWhere += "'" + strCode + "', ";
                            }
                            else if (strCode != "" && i!=0  && i == iNum)
                            {
                                strWhere += "'" + strCode + "')";
                            }

                        };

                        string strTK1 = @"
                            SELECT DISTINCT [TK1_ID] 
                            FROM [M02_BPM].[TK2_TaskDetail] WHERE " + strWhere;
                        //获取明细表中的任务ID

                        DataTable dtTaskID = conn.GetDataTable(strTK1);

                        //取TaskHead头的ID

                        string strTaskWhere = " AND TK1_ID IN (";

                        if (dtTaskID.Rows.Count != 0)
                        {
                            for (int j = 0; j <= dtTaskID.Rows.Count - 1; j++)
                            {
                                string strTaskID = dtTaskID.Rows[j]["TK1_ID"].ToString();
                                if (strTaskID != "" && j < dtTaskID.Rows.Count - 1)
                                {
                                    strTaskWhere += "'" + strTaskID + "',";
                                }
                                else if (strTaskID != "" && j == dtTaskID.Rows.Count - 1)
                                {
                                    strTaskWhere += "'" + strTaskID + "')";
                                };
                            };
                        }
                        else
                        {
                            strTaskWhere = " AND 1=1";
                        };
                        return strTaskWhere;
                    }
                #endregion
                
                #region 根据督导获取任务ID
                    private string ParticularTaskID() {
                        string strReturn = "";
                            
                        //根据督导获取店铺编号
                        string strWhere = ParticularUser();

                        if (strWhere != "")
                        {
                            string strSQL = @"
                            SELECT DISTINCT [TK1_ID] 
                            FROM [M02_BPM].[TK2_TaskDetail] WHERE 1=1 " + strWhere;
                            //-----
                            //获取明细表中的任务ID

                            DataTable dtTaskID = conn.GetDataTable(strSQL);

                            //取TaskHead头的ID

                            string strTaskWhere = " AND TK1_ID IN (";

                            if (dtTaskID.Rows.Count != 0)
                            {
                                for (int j = 0; j <= dtTaskID.Rows.Count - 1; j++)
                                {
                                    string strTaskID = dtTaskID.Rows[j]["TK1_ID"].ToString();
                                    if (strTaskID != "" && j < dtTaskID.Rows.Count - 1)
                                    {
                                        strTaskWhere += "'" + strTaskID + "',";
                                    }
                                    else if (strTaskID != "" && j == dtTaskID.Rows.Count - 1)
                                    {
                                        strTaskWhere += "'" + strTaskID + "')";
                                    };
                                };
                                strReturn = strTaskWhere;
                            }
                        }
                        else {
                            strReturn = "";
                        };
                        return strReturn;
                    }
                #endregion

                #region 根据督导获取店铺编号
                    private string ParticularUser() {
                        string strReturn = "";

                        string strSQL = @"
                                SELECT [Depotid]
                                FROM [M01_CONF].[M04_Privilege]
                                WHERE [Login_ID] ='" + hzyMessage.User_Name + "'";
                        DataSet dsBox = conn.GetDataSet(strSQL);

                        int iCount = dsBox.Tables[0].Rows.Count;
                        if (iCount == 0)
                        {
                            strReturn = "";
                        }
                        else {
                            for (int i = 0; i<= iCount-1;i++){
                                string strDepotid = dsBox.Tables[0].Rows[i]["Depotid"].ToString();
                                if (i == 0 && i < iCount - 1){
                                    strReturn += " AND [Depotid] IN ('" + strDepotid + " ','";
                                }
                                else if (i == 0 && i < iCount - 1){
                                    strReturn += " AND [Depotid] IN ('" + strDepotid + " ')";
                                }
                                else if (i > 0 && i < iCount - 1) {
                                    strReturn += strDepotid + "','";
                                }
                                else if (i == iCount - 1) {
                                    strReturn += strDepotid + "')";
                                };
                            };
                        };
                        return strReturn;
                    }
                #endregion

            #endregion


            #region GetConnectionString

                private static string GetConnectionString()
                // To avoid storing the sourceConnection string in your code, 
                // you can retrieve it from a configuration file. 
                {
                    return "Data Source=(172.16.200.130); " +
                        " Integrated Security=true;" +
                        "Initial Catalog=cmt;";
                }
            #endregion



        #endregion

                    public string strConn { get; set; }
    }
}