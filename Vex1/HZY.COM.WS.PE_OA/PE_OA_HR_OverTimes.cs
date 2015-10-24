using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;
using System.IO;
using System.Configuration;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using HZY.COM.FTP;

 



/// 类名：PE_HR_OverTimes
/// 类说明：HR店铺加班申请及人员管理
/// 创建人：DLY
/// 创建日期：2014-12-25
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_HR_OverTimes : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        #region 构造函数
        public PE_OA_HR_OverTimes()
        {
            this.m_SessionCheck = false;
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        #endregion

        #region GetData
        public DataSet GetData()
        {
            try
            {
                string strType = m_request.Tables[0].Rows[0]["type"].ToString();            
                Dbconn conn = new Dbconn("PE_OA");
                DataSet ds = new DataSet();

                if (strType == "GetHs" || strType == "GetDs"
                    || strType == "GetAs" || strType == "GetAc" || strType == "GetPerRecord"
                    || strType == "GetPerTurnRecord" || strType == "GetPerDimissRecord"
                    || strType == "GetSYSConfig")
                {
                    ds = GetRows(conn, strType);
                }
                else if (strType == "SaveH")
                {
                    ds = SaveRows(conn, strType);
                }
                else if (strType == "SaveD")
                {
                    ds = SaveRows1(conn, strType);
                }
                else if (strType == "SaveA")
                {
                    ds = SaveRows3(conn, strType);
                }
                else if (strType == "SavePer")
                {
                    ds = SaveRows4(conn, strType);
                }
                else if (strType == "SavePerTurn")
                {
                    ds = SaveRows5(conn, strType);
                }
                else if (strType == "SavePerDimiss")
                {
                    ds = SaveRows6(conn, strType);
                }
                else if (strType == "setPhotToSave")
                {
                    ds = setPhotToSave(conn, strType);
                }
                else if (strType == "UpdSysCfg") // 大区经理配置调整
                {
                    ds = UpdSysCfg(conn, strType);
                }
                else if (strType == "GetOTHZInfo") // 加班申请汇总
                {
                    ds = GetOTHZInfo(conn, strType);
                } 
                
                return ds;
            }
            catch
            {
                throw;
            } 
        }
        #endregion

        #region 内部函数

        #region 根据条件获取数据集 条件-分页-排序 求和等
        /// <summary>
        /// 根据条件获取数据集 条件-分页-排序 求和等
        /// </summary>
        /// <returns></returns>
        public DataSet GetRows(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            string[] strParam = new string[] { };
            if (strType == "GetHs") // 加班主
            {
                strSQL = @" SELECT *
                          FROM B02_BILL.HR1_OverTimeApply WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetDs") // 加班主从
            {
                strSQL = @" SELECT *
                          FROM B02_BILL.HR2_OverTimeRecode WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetAs") // 任务
            {
                strSQL = @" SELECT *
                          FROM B02_BILL.HR3_Approve WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetAc") // 根据员工号获取用户角色
            {
                strSQL = @" SELECT *
                          FROM B02_BILL.HR4_Authority WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetPerRecord") // 人员信息记录
            {
                strSQL = @" SELECT *
                          FROM B02_BILL.HR5_EMPLOYEE WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetPerTurnRecord") // 人员调转记录
            {
                strSQL = @" SELECT *
                          FROM B02_BILL.HR7_STAFFRECORD WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetPerDimissRecord") // 人员离职记录
            {
                strSQL = @" SELECT *
                          FROM B02_BILL.HR8_DIMISSION WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }
            else if (strType == "GetSYSConfig") // 人员离职记录
            {
                strSQL = @" SELECT *
                          FROM B02_BILL.HR9_SYSConfig WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            }

            return ds;
        }
        #endregion


        #region 新建或修改加班主记录
        /// <summary>
        /// 新建或修改加班主记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRows(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    //如果包含bg3_lmdt，就循环移除
                    if (dt_List1.Columns.Contains("hr1_lmdt"))
                    {
                        dt_List1.Columns.Remove("hr1_lmdt");
                    }
                    bResult = conn.Insert("B02_BILL.HR1_OverTimeApply", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("hr1_id");
                    bResult = conn.Update("B02_BILL.HR1_OverTimeApply", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["hr1_id"].ToString();
                        bResult = conn.Delete("B02_BILL.HR1_OverTimeApply", "hr1_id=" + "'" + strID1 + "'");
                    }
                }
            }
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion

        #region 新建或修改加班从记录
        /// <summary>
        /// 新建或修改加班从记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRows1(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    //如果包含bg3_lmdt，就循环移除
                    if (dt_List1.Columns.Contains("hr2_lmdt"))
                    {
                        dt_List1.Columns.Remove("hr2_lmdt");
                    }
                    bResult = conn.Insert("B02_BILL.HR2_OverTimeRecode", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("hr2_id");
                    bResult = conn.Update("B02_BILL.HR2_OverTimeRecode", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["hr2_id"].ToString();
                        bResult = conn.Delete("B02_BILL.HR2_OverTimeRecode", "hr2_id=" + "'" + strID1 + "'");
                    }
                }
            }
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion

        #region 新建或修改待办任务记录
        /// <summary>
        /// 新建或修改待办任务记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRows3(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    //如果包含bg3_lmdt，就循环移除
                    if (dt_List1.Columns.Contains("hr3_lmdt"))
                    {
                        dt_List1.Columns.Remove("hr3_lmdt");
                    }
                    bResult = conn.Insert("B02_BILL.HR3_Approve", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("hr3_id"); 
                    bResult = conn.Update("B02_BILL.HR3_Approve", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["hr3_id"].ToString();
                        bResult = conn.Delete("B02_BILL.HR3_Approve", "hr3_id=" + "'" + strID1 + "'");
                    }
                }
            }
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion
         
        #region 新建或修改人员记录
        /// <summary>
        /// 新建或修改人员记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRows4(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    if (dt_List1.Rows[0]["c_oid"].ToString() == "")
                    {
                        String strOID = getUniqueKey(conn);
                        if (strOID == "")
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "获取 UNIQUE_KEY失败！" }); 
                            ds_Return.Tables.Add(dt_EditResult);
                            return ds_Return; 
                        }
                        dt_List1.Rows[0]["c_oid"] = strOID;
                        dt_List1.Rows[0]["c_employeeid"] = strOID;
                    }
                    if (dt_List1.Rows[0]["c_oid_indiaccount"].ToString() == "")
                    {
                        String strOID = getUniqueKey(conn);
                        if (strOID == "")
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "获取 UNIQUE_KEY失败！" });
                            ds_Return.Tables.Add(dt_EditResult);
                            return ds_Return;
                        }
                        dt_List1.Rows[0]["c_oid_indiaccount"] = strOID; 
                    } 

                    bResult = conn.Insert("B02_BILL.HR5_EMPLOYEE", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    if (dt_List2.Rows[0]["c_oid_indiaccount"].ToString() == "")
                    {
                        String strOID = getUniqueKey(conn);
                        if (strOID == "")
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "获取 UNIQUE_KEY失败！" });
                            ds_Return.Tables.Add(dt_EditResult);
                            return ds_Return;
                        }
                        dt_List2.Rows[0]["c_oid_indiaccount"] = strOID;
                    }
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("hr5_id");
                    bResult = conn.Update("B02_BILL.HR5_EMPLOYEE", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["hr5_id"].ToString();
                        bResult = conn.Delete("B02_BILL.HR5_EMPLOYEE", "hr5_id=" + "'" + strID1 + "'");
                    }
                }
            }
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion

        #region 新建或修改人员调转记录
        /// <summary>
        /// 新建或修改人员调转记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRows5(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    if (dt_List1.Rows[0]["c_oid_staffrecord"].ToString() == "")
                    {
                        String strOID = getUniqueKey(conn);
                        if (strOID == "")
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "获取 UNIQUE_KEY失败！" });
                            ds_Return.Tables.Add(dt_EditResult);
                            return ds_Return;
                        }
                        dt_List1.Rows[0]["c_oid_staffrecord"] = strOID; 
                    }
                    bResult = conn.Insert("B02_BILL.HR7_STAFFRECORD", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("hr7_id");
                    bResult = conn.Update("B02_BILL.HR7_STAFFRECORD", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["hr7_id"].ToString();
                        bResult = conn.Delete("B02_BILL.HR7_STAFFRECORD", "hr7_id=" + "'" + strID1 + "'");
                    }
                }
            }
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion 

        #region 新建或修改人员离职记录
        /// <summary>
        /// 新建或修改人员离职记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRows6(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            DataTable dtOptypes = dsXML.Tables["OPTYPE"];
            bool bResult = true;
            conn.BeginTransaction();
            for (int i = 0; i < dtOptypes.Rows.Count; i++)
            {
                //如果包含rowindex，就循环移除
                if (dsXML.Tables[i + 1].Columns.Contains("rowindex"))
                {
                    dsXML.Tables[i + 1].Columns.Remove("rowindex");
                }
                //如果子表解析出来的XML，类型有insert，做新增
                if (dtOptypes.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DataTable dt_List1 = dsXML.Tables[i + 1];
                    if (dt_List1.Rows[0]["c_oid_dimission"].ToString() == "")
                    {
                        String strOID = getUniqueKey(conn);
                        if (strOID == "")
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "获取 UNIQUE_KEY失败！" });
                            ds_Return.Tables.Add(dt_EditResult);
                            return ds_Return;
                        }
                        dt_List1.Rows[0]["c_oid_dimission"] = strOID;
                    }
                    bResult = conn.Insert("B02_BILL.HR8_DIMISSION", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("hr8_id");
                    bResult = conn.Update("B02_BILL.HR8_DIMISSION", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["hr8_id"].ToString();
                        bResult = conn.Delete("B02_BILL.HR8_DIMISSION", "hr8_id=" + "'" + strID1 + "'");
                    }
                }
            }
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功！" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion 
         
        #region 将传入的图片转换成二进制代码
        /// <summary>
        /// 将传入的图片转换成二进制代码
        /// </summary>
        /// <returns></returns> 
        private Byte[] setPhotoByte(string photoPath)
        { 
            FileStream file; 
            if (photoPath != null)
            { 
                string str = photoPath;//保存传入的路径
                //将传入路径下的图片以文件方式打开
                file = new FileStream(str, FileMode.Open, FileAccess.Read);//以只读方式打开传入路劲下的图片
                Byte[] byteSQLData = new byte[file.Length];
                file.Read(byteSQLData, 0, byteSQLData.Length);//完整的将文件中的数据读入到创建的byte数据中

               
                file.Close(); 
                return byteSQLData; 
            }
            return null;
        }
        #endregion 

        #region 上传图片并保存到数据库中
        /// <summary>
        /// 上传图片并保存到数据库中
        /// </summary>
        /// <returns></returns> 
        private DataSet setPhotToSave(Dbconn conn, String strType)
        { 
            DataSet ds_Return = new DataSet();
            String remoteHost = ConfigurationSettings.AppSettings["remoteHostHR"].ToString();
            String remotePath = "";
            String remoteUser = ConfigurationSettings.AppSettings["remoteUserHR"].ToString();
            String remotePass = ConfigurationSettings.AppSettings["remotePassHR"].ToString() + "i";
            String remoteDir = ConfigurationSettings.AppSettings["remotePathHR"].ToString();
            int remotePort = 21;  
            int i = 0;

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPhotoPath = dsXML.Tables["LIST"].Rows[0]["photoPath"].ToString();
            string strPhotoID = dsXML.Tables["LIST"].Rows[0]["photoID"].ToString();
            string strActor = dsXML.Tables["LIST"].Rows[0]["actor"].ToString();
            string strActorID = dsXML.Tables["LIST"].Rows[0]["actorid"].ToString();
            string strUpType = dsXML.Tables["LIST"].Rows[0]["upType"].ToString();

            if (strPhotoPath == null || strPhotoPath=="")
            {
                dt_EditResult.Rows.Add(new object[] { false, "文件不能为空！" }); 
                ds_Return.Tables.Add(dt_EditResult);
                return ds_Return;  
            }


            //获取 UNIQUE_KEY
            if (strUpType == "new")
            {
                strPhotoID = getUniqueKey(conn);
                if (strPhotoID == "")
                {
                    dt_EditResult.Rows.Add(new object[] { false, "获取 UNIQUE_KEY失败！" }); 
                    ds_Return.Tables.Add(dt_EditResult);
                    return ds_Return; 
                }
            }

             

            //获取原始文件名
            string filename = strPhotoPath.Substring(strPhotoPath.LastIndexOf("\\") + 1
                , strPhotoPath.Length - strPhotoPath.LastIndexOf("\\") - 1);

            filename = filename.Substring(0, filename.LastIndexOf("-"))
                     + filename.Substring(filename.LastIndexOf("."), filename.Length - filename.LastIndexOf(".")); 
          
            //图片另存为.jpg
            string newfile = strPhotoPath.Substring(0, strPhotoPath.LastIndexOf("\\")+1) + strPhotoID + ".jpg";
            System.IO.File.Copy(strPhotoPath, newfile, true);  
            //上传文件
            var ftcc = new FTP.FTPClient(remoteHost, remotePath, remoteUser, remotePass, remotePort);
            ftcc.Connect();
            ftcc.ChDir(remoteDir);   // 切换到ftp对应目录下的文件夹路径
            ftcc.Put(newfile);  
            //删除图片另存为.jpg 
            System.IO.File.Delete(newfile); 
            
            //保存到数据库
            Byte[] byteSQLData = setPhotoByte(strPhotoPath);
            string strSQL2 = @" insert into B02_BILL.HR6_Blob (hr6_id, hr6_belongid, hr6_filename, hr6_content, hr6_type) 
                                    values( @Param0, @Param1, @Param2, @Param3, @Param4 ) ";
            i = conn.ExcuteQuerryByTran(strSQL2, new object[] { strPhotoID, "0", filename, byteSQLData, "0" }); 
           

            if (i==1)
            {
                dt_EditResult.Rows.Add(new object[] { true, strPhotoID });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "上传失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;  
        } 
        #endregion
         
        #region  获取 UNIQUE_KEY
        /// <summary>
        /// 获取 UNIQUE_KEY
        /// </summary>
        /// <returns></returns>
        public string getUniqueKey(Dbconn conn)
        {
            DataSet ds = new DataSet();
            string code = "";
            String strXMLC = "【操作类型,GET】【DIVI,D01】【CONO,HWA】【主分类编码,HR】【关键字,HR】";
            ds = conn.GetDataSetBySP("[SRV_MDM].[BillCode]", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            if (ds.Tables != null)
            {
                code = ds.Tables[0].Rows[0]["billcode"].ToString();;
            } 
            return code;

        }
        #endregion


        #region  大区经理配置调整
        /// <summary>
        /// 大区经理配置调整
        /// </summary>
        /// <returns></returns>
        public DataSet UpdSysCfg(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet(); 

            //获取条件值 
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strID = dsXML.Tables["LIST"].Rows[0]["id"].ToString();
            String strUnitID = dsXML.Tables["LIST"].Rows[0]["unitid"].ToString();
            String strUnitName = dsXML.Tables["LIST"].Rows[0]["unitname"].ToString();
            string strPerCode = dsXML.Tables["LIST"].Rows[0]["percode"].ToString();
            string strPerName = dsXML.Tables["LIST"].Rows[0]["pername"].ToString();
            string strPerCode1 = dsXML.Tables["LIST"].Rows[0]["percode1"].ToString();
            string strPerName1 = dsXML.Tables["LIST"].Rows[0]["pername1"].ToString();
            string strActor = dsXML.Tables["LIST"].Rows[0]["actor"].ToString();

            String strXMLC = "【操作类型,SET】【实体,大区经理配置】【CONO,】【DIVI,】"
                           + "【《W》OID," + strID + "】"
                           + "【《W》部门ID," + strUnitID + "】【《W》部门名称," + strUnitName + "】"
                           + "【《W》员工号," + strPerCode + "】【《W》姓名," + strPerName + "】"
                           + "【《W》员工号CS," + strPerCode1 + "】【《W》城市经理," + strPerName1 + "】"
                           + "【《W》操作人," + strActor + "】" 
                           + "【返回内容, 主表列表】";

            ds = conn.GetDataSetBySP("[API_HR].[SysCfg]", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;

        }
        #endregion


        #region  加班申请汇总
        /// <summary>
        /// 加班申请汇总
        /// </summary>
        /// <returns></returns>
        public DataSet GetOTHZInfo(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();

            //获取条件值 
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOrgID = dsXML.Tables["LIST"].Rows[0]["orgid"].ToString();
            String strMonth = dsXML.Tables["LIST"].Rows[0]["month"].ToString();

            String strXMLC = "【操作类型,GET】【实体, 加班申请汇总】【CONO,】【DIVI,】" 
                           + "【《W》OrgID," + strOrgID + "】【《W》月份," + strMonth + "】" 
                           + "【返回内容, 主表列表】";

            ds = conn.GetDataSetBySP("[API_HR].[SysCfg]", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;

        }
        #endregion
         
        #endregion

    }    
}