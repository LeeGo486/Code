using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;
  
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：PE_OA_BaseData
/// 类说明：基础信息数据管理
/// 创建人：DLY
/// 创建日期：2014-05-04
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_BaseData : LogicBase, ILogicGetData
    {
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        Dbconn conn = new Dbconn("PE_OA");
        public PE_OA_BaseData()
        {
            this.m_SessionCheck = true;
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        public DataSet GetData()
        {
            try
            {
                string strType = m_request.Tables[0].Rows[0]["type"].ToString();
                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                DataSet ds = null;
                if (strType == "gbd1")
                {
                    ds = GetBaseDate(strType, conn);
                }
                else if (strType == "gbd2")
                {
                    ds = GetBaseDate1(strXML, conn, strType); //用层级查询 
                }
                else if (strType == "gbd3")
                {
                    ds = GetBaseDate3(strXML, conn, strType); 
                }
                else if (strType == "gbd12")
                {
                    ds = GetBaseDate12(strXML, conn); //自定义查询 
                }
                else if (strType == "gbd13")
                {
                    ds = GetBaseDate13(conn, strType); //自定义查询 分页
                }
                else if (strType == "SaveRows")
                {
                    ds = SaveRows(conn, strType); //自定义查询 分页
                }
                else if (strType == "NewFATypeDL" || strType == "NewFATypeXL" || strType == "UpdFAType")
                {
                    ds = SetFATypes(conn, strType); //新建或修改固定资产类别记录
                }
                else if (strType == "NewBMType" || strType == "UpdBMType")
                {
                    ds = SetBMTypes(conn, strType); //新建或修改预算科目类别记录
                }
                else if (strType == "gbckxm")
                {
                    ds = GetCKXMs(conn, strType); //获取参考项目
                }
                return ds;

            }
            catch
            {
                throw;
            }
        }

        #region 根据类别Code获取基础数据集（启用中）
        /// <summary>
        /// 根据类别Code获取基础数据集（启用中）
        /// </summary>
        /// <returns></returns>
        public DataSet GetBaseDate(string strType, Dbconn conn)
        {
            DataSet ds = null;
            string strCONO = m_request.Tables[0].Rows[0]["CONO"].ToString();
            string strDIVI = m_request.Tables[0].Rows[0]["DIVI"].ToString();
            string strCode = m_request.Tables[0].Rows[0]["code"].ToString();
            try
            {
                string strSQL = "";
                strSQL = @" SELECT CT1_ID AS id, CT1_Code AS code , CT1_CodeName AS CodeName 
                        FROM  M01_CONF.CT0_CSYTAB 
                        WHERE CT1_FatherID = (SELECT TOP 1 CT1_ID  FROM M01_CONF.CT0_CSYTAB WHERE CT1_State = '启用' 
                            AND CT1_Code = '" + strCode + "') ";
                if (strType == "gbd1")
                {
                    strSQL = strSQL + " AND CT1_State = '启用' ";

                }
                ds = conn.GetDataSet(strSQL);

            }
            catch
            {
                throw;
            }

            return ds;

        }
        #endregion

        #region 根据类别XML获取基础数据集1（启用中）
        /// <summary>
        /// 根据类别XML获取基础数据集（启用中）
        /// </summary>
        /// <returns></returns>
        public DataSet GetBaseDate1(string strXML, Dbconn conn, string strType)
        {
            DataSet ds = new DataSet();


            //获取条件值
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
            string strLevel = dsXML.Tables["LIST"].Rows[0]["Level"].ToString();
            string strState = dsXML.Tables["LIST"].Rows[0]["State"].ToString();
            string strOrder = dsXML.Tables["LIST"].Rows[0]["Order"].ToString();

            if (strLevel == "")
            {
                return ds;
            }

            string strFid = "cb111111-2222-3333-4444-555555555555";
            string strCode = "";
            string strSQL = "";
            for (int i = 0; i <= int.Parse(strLevel); i++)
            {
                strSQL = @" SELECT CT1_ID AS id, CT1_Code AS code , CT1_CodeName AS CodeName, CT1_FieldValues1 "
                          + @" FROM M01_CONF.CT0_CSYTAB WHERE 1=1 "
                          + " AND  ISNULL(CONVERT(VARCHAR(50),CT1_FatherID),'') = '" + strFid
                          + "' AND CT1_CONO = '" + strCONO
                          + "' AND  CT1_DIVI = '" + strDIVI + "'";
                if (i < int.Parse(strLevel))
                {
                    strCode = dsXML.Tables["LIST"].Rows[0]["Code" + i].ToString();
                    strSQL = strSQL + " AND CT1_Code = '" + strCode + "'"; ;
                }
                if (strState != "")
                {
                    strSQL = strSQL + " AND  CT1_State = '启用' ";
                }
                if (strOrder != "" && i == int.Parse(strLevel))
                {
                    strSQL = strSQL + " ORDER BY " + strOrder;
                }
                ds = conn.GetDataSet(strSQL);
                if (ds.Tables == null)
                {
                    return ds;
                }
                strFid = ds.Tables[0].Rows[0]["id"].ToString();
            }

            return ds;
        }
        #endregion

        #region 根据类别XML获取基础数据集3（启用中）
        /// <summary>
        /// 根据类别XML获取基础数据集（启用中）
        /// </summary>
        /// <returns></returns>
        public DataSet GetBaseDate3(string strXML, Dbconn conn, string strType)
        {
            DataSet ds = new DataSet();


            //获取条件值
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
            string strLevel = dsXML.Tables["LIST"].Rows[0]["Level"].ToString();
            string strState = dsXML.Tables["LIST"].Rows[0]["State"].ToString();
            string strOrder = dsXML.Tables["LIST"].Rows[0]["Order"].ToString();

            if (strLevel == "")
            {
                return ds;
            }

            string strFid = "cb111111-2222-3333-4444-555555555555";
            string strCode = "";
            string strSQL = "";
            for (int i = 0; i <= int.Parse(strLevel); i++)
            {
                if (i == int.Parse(strLevel))
                {
                    if (strType == "gbd3")
                    {
                        strSQL = @"SELECT * ";
                    }
                }
                else
                {
                    strSQL = @"SELECT CT1_ID  ";
                }


                strSQL = strSQL + @" FROM M01_CONF.CT0_CSYTAB WHERE 1=1 "
                          + " AND  ISNULL(CONVERT(VARCHAR(50),CT1_FatherID),'') = '" + strFid
                          + "' AND CT1_CONO = '" + strCONO
                          + "' AND  CT1_DIVI = '" + strDIVI + "'";
                if (i < int.Parse(strLevel))
                {
                    strCode = dsXML.Tables["LIST"].Rows[0]["Code" + i].ToString();
                    strSQL = strSQL + " AND CT1_Code = '" + strCode + "'"; ;
                }
                if (strState != "")
                {
                    strSQL = strSQL + " AND  CT1_State = '启用' ";
                }
                if (strOrder != "" && i == int.Parse(strLevel))
                {
                    strSQL = strSQL + " ORDER BY " + strOrder;
                }
                ds = conn.GetDataSet(strSQL);
                if (ds.Tables == null)
                {
                    return ds;
                }
                strFid = ds.Tables[0].Rows[0]["CT1_ID"].ToString();
            }

            return ds;
        }
        #endregion

        #region 根据类别XML获取基础数据集 含最底层的条件过滤
        /// <summary>
        /// 根据类别XML获取基础数据集 含最底层的条件过滤
        /// </summary>
        /// <returns></returns>
        public DataSet GetBaseDate4(string strXML, Dbconn conn, string strType)
        {
            DataSet ds = new DataSet();


            //获取条件值
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
            string strLevel = dsXML.Tables["LIST"].Rows[0]["Level"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrder = dsXML.Tables["LIST"].Rows[0]["Order"].ToString();

            if (strLevel == "")
            {
                return ds;
            }

            string strFid = "cb111111-2222-3333-4444-555555555555";
            string strCode = "";
            string strSQL = "";
            for (int i = 0; i <= int.Parse(strLevel); i++)
            {
                strSQL = @" SELECT *  FROM M01_CONF.CT0_CSYTAB WHERE 1=1 "
                          + " AND  ISNULL(CONVERT(VARCHAR(50),CT1_FatherID),'') = '" + strFid
                          + "' AND CT1_CONO = '" + strCONO
                          + "' AND  CT1_DIVI = '" + strDIVI + "'";
                if (i < int.Parse(strLevel))
                {
                    strCode = dsXML.Tables["LIST"].Rows[0]["Code" + i].ToString();
                    strSQL = strSQL + " AND CT1_Code = '" + strCode + "'";
                    strSQL = strSQL + " AND  CT1_State = '启用' ";
                }
                else
                {
                    strSQL = strSQL + strCons;
                    strSQL = strSQL + strOrder;
                }
                ds = conn.GetDataSet(strSQL);
                if (ds.Tables == null)
                {
                    return ds;
                }
                strFid = ds.Tables[0].Rows[0]["CT1_ID"].ToString();
            }

            return ds;
        }
        #endregion 

        #region 根据CONO，DIVI，CT1_Code，CT1_FatherID查询记录
        /// <summary>
        /// 根据CONO，DIVI，CT1_Code，CT1_FatherID查询记录
        /// </summary>
        /// <returns></returns>
        public DataSet GetBaseDate11(Dbconn conn, string strCONO, string strDIVI, string strCode, string strFatherID)
        {
            DataSet ds1 = new DataSet();
            if (strCONO == "" || strDIVI == "" || strCode == "")
            {
                return ds1;
            }

            String strSQL = @" SELECT * FROM M01_CONF.CT0_CSYTAB WHERE 1=1 "
                          + " AND  CT1_CONO = '" + strCONO
                          + "' AND CT1_DIVI = '" + strDIVI
                          + "' AND CT1_Code = '" + strCode + "'";
            if (strFatherID == "")
            {
                strSQL = strSQL + "' AND  ISNULL(CONVERT(VARCHAR(50),CT1_FatherID),'') = '" + strFatherID + "'";
            }
            else
            {
                strSQL = strSQL + "' AND  CT1_FatherID  = '" + strFatherID + "'";
            }
            ds1 = conn.GetDataSet(strSQL);
            return ds1;
        }
        #endregion 


        #region 根据自定义条件查询记录并排序
        /// <summary>
        /// 根据自定义条件查询记录并排序
        /// </summary>
        /// <returns></returns>
        public DataSet GetBaseDate12(string strXML, Dbconn conn)
        {
            DataSet ds1 = new DataSet();
            //获取条件值
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            String strSQL = @" SELECT * FROM M01_CONF.CT0_CSYTAB WHERE 1=1 "
                          + strCons + strOrderBy;
            ds1 = conn.GetDataSet(strSQL);
            return ds1;
        }
        #endregion  


        #region 根据条件-分页-排序 
        /// <summary>
        /// 根据条件-分页-排序 
        /// </summary>
        /// <returns></returns>
        public DataSet GetBaseDate13(Dbconn conn, String strType)
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
            if (strType == "gbd13")
            {
                strSQL = @" SELECT * FROM M01_CONF.CT0_CSYTAB WHERE 1=1 " + strCons;
                ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            } 
            return ds;
        }
        #endregion


        #region 新建或修改记录(批量)
        /// <summary>
        /// 新建或修改记录
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
                    if (dt_List1.Columns.Contains("ct1_lmdt"))
                    {
                        dt_List1.Columns.Remove("ct1_lmdt");
                    }
                    bResult = conn.Insert("M01_CONF.CT0_CSYTAB", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("ct1_id");
                    bResult = conn.Update("M01_CONF.CT0_CSYTAB", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["ct1_id"].ToString();
                        bResult = conn.Delete("M01_CONF.CT0_CSYTAB", "ct1_id=" + "'" + strID1 + "'");
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


        #region 新建或修改固定资产类别记录 (特殊编码)
        /// <summary>
        /// 新建或修改固定资产类别记录
        /// </summary>
        /// <returns></returns>
        public DataSet SetFATypes(Dbconn conn, String strType)
        {
            String strCode = "";
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString(); 
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["ct1_id"].ToString();
            String strFatherID = dsXML.Tables["LIST"].Rows[0]["ct1_fatherid"].ToString();
            DataTable dt_List = dsXML.Tables["LIST"];
            if (strID == "")
            {
                throw new Exception("数据异常，缺少主键，请联系管理员！");
            } 
            bool bResult = false;
            if (strType == "NewFATypeDL") //新建大类
            {
                String strSQL1 = @" SELECT MAX(CT1_Code) AS code "
                          + @" FROM M01_CONF.CT0_CSYTAB WHERE 1=1 "
                          + " AND  ISNULL(CONVERT(VARCHAR(50),CT1_FatherID),'') = '" + strFatherID
                          + "'";
                DataSet ds1 = conn.GetDataSet(strSQL1);
                if (ds1.Tables == null)
                {
                    dsXML.Tables["LIST"].Rows[0]["ct1_code"] = "01";
                }
                else
                {
                    dsXML.Tables["LIST"].Rows[0]["ct1_code"] = int.Parse(ds1.Tables[0].Rows[0]["code"].ToString()) + 1;
                    if (int.Parse(ds1.Tables[0].Rows[0]["code"].ToString()) < 9)
                    {
                        dsXML.Tables["LIST"].Rows[0]["ct1_code"] = "0" + dsXML.Tables["LIST"].Rows[0]["ct1_code"].ToString();
                    } 
                } 
                conn.BeginTransaction();
                bResult = conn.Insert("M01_CONF.CT0_CSYTAB", dt_List);
                conn.CommitTransaction();
            }
            else if (strType == "NewFATypeXL") //新建小类
            {
                String strSQL1 = @" SELECT MAX(CT1_Code) AS code "
                          + @" FROM M01_CONF.CT0_CSYTAB WHERE 1=1 "
                          + " AND  ISNULL(CONVERT(VARCHAR(50),CT1_FatherID),'') = '" + strFatherID
                          + "'";
                DataSet ds1 = conn.GetDataSet(strSQL1);
                if (ds1.Tables == null)
                {
                    return ds_Return;
                }
                else
                {
                    if (ds1.Tables[0].Rows[0]["code"].ToString() == "")
                    {
                        String strSQL2 = @" SELECT CT1_Code "
                                                  + @" FROM M01_CONF.CT0_CSYTAB WHERE 1=1 "
                                                  + " AND  ISNULL(CONVERT(VARCHAR(50),CT1_ID),'') = '" + strFatherID
                                                  + "'";
                        DataSet ds2 = conn.GetDataSet(strSQL2);
                        dsXML.Tables["LIST"].Rows[0]["ct1_code"] = ds2.Tables[0].Rows[0]["CT1_Code"].ToString() + "001";
                    }
                    else
                    {
                        dsXML.Tables["LIST"].Rows[0]["ct1_code"] = int.Parse(ds1.Tables[0].Rows[0]["code"].ToString()) + 1;
                        if (int.Parse(ds1.Tables[0].Rows[0]["code"].ToString()) < 9999)
                        {
                            dsXML.Tables["LIST"].Rows[0]["ct1_code"] = "0" + dsXML.Tables["LIST"].Rows[0]["ct1_code"].ToString();
                        } 
                    } 
                } 
                //dt_List.Columns.Add("CT1_RgUser");
                //dt_List.Rows[0]["CT1_RgUser"] = strActor;
                conn.BeginTransaction();
                bResult = conn.Insert("M01_CONF.CT0_CSYTAB", dt_List);
                conn.CommitTransaction();
            }
            else if (strType == "UpdFAType") //修改大小类
            {
                conn.BeginTransaction();
                bResult = conn.Update("M01_CONF.CT0_CSYTAB", dt_List, "ct1_id='" + strID + "'");
                conn.CommitTransaction();
            } 


            strCode = dsXML.Tables["LIST"].Rows[0]["ct1_code"].ToString(); 
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, strCode });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion(其他类别数据操作公用)


        #region 新建或修改预算科目类别记录 (其他类别数据操作公用)
        /// <summary>
        /// 新建或修改预算科目类别记录
        /// </summary>
        /// <returns></returns>
        public DataSet SetBMTypes(Dbconn conn, String strType)
        {
            String strCode = "";
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString(); 
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["ct1_id"].ToString();
            //String strFatherID = dsXML.Tables["LIST"].Rows[0]["ct1_fatherid"].ToString();
            DataTable dt_List = dsXML.Tables["LIST"];
            if (strID == "")
            {
                throw new Exception("数据异常，缺少主键，请联系管理员！");
            } 
            bool bResult = false;
            if (strType == "NewBMType") //新建大小类
            { 
                conn.BeginTransaction();
                bResult = conn.Insert("M01_CONF.CT0_CSYTAB", dt_List);
                conn.CommitTransaction();
            } 
            else if (strType == "UpdBMType") //修改大小类
            {
                conn.BeginTransaction();
                bResult = conn.Update("M01_CONF.CT0_CSYTAB", dt_List, "ct1_id='" + strID + "'");
                conn.CommitTransaction();
            } 
             
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, strCode });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "保存失败！" });

            }
            ds_Return.Tables.Add(dt_EditResult);
            return ds_Return;
        }
        #endregion 

         
        #region 获取参考项目
        /// <summary>
        /// 获取参考项目
        /// </summary>
        /// <returns></returns>
        public DataSet GetCKXMs(Dbconn conn, String strType)
        {
            DataSet ds1 = new DataSet();
            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString(); 
            string[] strParam = new string[] { };
            String strSQL = @" SELECT DISTINCT B.OZ1_Brand+'-'+A.CT1_Code+'-'+A.CT1_CodeName AS XMID, 
                                A.CT1_Code, A.CT1_CodeName, B.OZ1_Brand FROM
                                ( SELECT CT1_Code, CT1_CodeName, CT1_FatherID 
                                    FROM [PE_OA].[M01_CONF].[CT0_CSYTAB]
                                    WHERE [CT1_FieldValues1] = 'XM' ) A
                                JOIN F01_CERT.OZ1_Organization B
                                ON A.[CT1_FatherID] = B.OZ1_id WHERE 1=1 "
                          + strCons ; 
            ds1 = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy); 
            return ds1;
        }
        #endregion  

    } 
}