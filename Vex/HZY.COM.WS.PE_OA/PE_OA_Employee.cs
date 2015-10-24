using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：PE_OA_Employee
/// 类说明：人员信息
/// 创建人：DLY
/// 创建日期：2014-05-14
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_Employee : LogicBase, ILogicGetData
    {
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        public PE_OA_Employee()
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
                Dbconn conn = new Dbconn("PE_OA");
                DataSet ds = new DataSet();

                if (strType == "GetEpmsByDeptID")
                {
                    ds = GetEpmsByDeptID(strXML, conn);
                }
                else if (strType == "GetEmpsByCons")
                {
                    ds = GetEmpsByCons(conn, strType);
                }
                else if (strType == "Save")
                {
                    ds = SaveRows(conn, strType);

                }
                else if (strType == "GetEpmLinkDepts")
                {
                    ds = GetEpmLinkDepts(conn, strType);
                }
                else if (strType == "SaveRowLinks")
                {
                    ds = SaveRowLinks(conn, strType);

                }
                return ds;
            }
            catch
            {
                throw;
            } 
        }

        #region 根据条件获取人员数据集
        /// <summary>
        /// 根据条件获取人员数据集
        /// </summary>
        /// <returns></returns>
        public DataSet GetEpmsByDeptID(string strXML, Dbconn conn)
        {
            DataSet ds = new DataSet();
            //获取条件值
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strDeptID = dsXML.Tables["LIST"].Rows[0]["DeptID"].ToString();
            String strState = dsXML.Tables["LIST"].Rows[0]["State"].ToString();
            String strDate = dsXML.Tables["LIST"].Rows[0]["Date"].ToString(); 
            String strFieldType = dsXML.Tables["LIST"].Rows[0]["FieldType"].ToString(); 
            
            if(strDeptID=="")
            {
                return ds ;
            }
            try
            {
                string strField = " * ";
                if(strFieldType == "1"){
                    strField = " B.EE1_EmpCode, B.EE1_EmpName ";
                }else if(strFieldType == "2"){
                    strField = " B.EE1_EmpCode, B.EE1_EmpName, B.EE1_Telephone, B.EE1_MobilePhone ";
                } 

                //拼接查询语句
                string strSQL = "SELECT " + strField 
                              + @"FROM F01_CERT.EO1_EmpOrgLink A, F01_CERT.EE1_Employee B
                                WHERE A.EO1_OZ1_OrgCode = '" + strDeptID + "' "; //部门
                if (strState != "") //状态
                {
                    strSQL = strSQL + " AND A.EO1_State = '" + strState + "' "; 
                }
                if (strDate != "")  //日期
                {
                    strSQL = strSQL + " AND A.EO1_BeginDt <= '" + strDate + "' AND A.EO1_EndDt >= '" + strDate + "' ";
                }
                strSQL = strSQL + " AND A.EO1_EE1_EmpCode = B.EE1_EmpCode  ";     
                ds = conn.GetDataSet(strSQL);

            }
            catch
            {
                throw;
            }

            return ds;

        } 
       #endregion

        #region 根据条件获取人员数据集
        /// <summary>
        /// 根据条件获取人员数据集
        /// </summary>
        /// <returns></returns>
        public DataSet GetEmpsByCons(Dbconn conn, String strType)
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
            strSQL = @"  SELECT * FROM [F01_CERT].[EE1_Employee] 
                            WHERE 1=1 " + strCons;
            ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            return ds;
        }
        #endregion

        #region 新建或修改人员记录
        /// <summary>
        /// 新建或修改记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRows(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            //string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
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
                    if (dt_List1.Columns.Contains("ee1_lmdt"))
                    {
                        dt_List1.Columns.Remove("ee1_lmdt");
                    }
                    bResult = conn.Insert("F01_CERT.EE1_Employee", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("ee1_id");
                    bResult = conn.Update("F01_CERT.EE1_Employee", dt_List2, ListKey);
                }
                ////如果类型包含，DELETE，解析成表，做DELETE
                //else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                //{
                //    DataTable dt_List3 = dsXML.Tables[i + 1];
                //}
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


        #region 根据EMPCode获取关联部门数据集
        /// <summary>
        /// 根据EMPCode获取关联部门数据集
        /// </summary>
        /// <returns></returns>
        public DataSet GetEpmLinkDepts(Dbconn conn, String strType)
        { 
            //获取条件值
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
            strSQL = @"  SELECT A.EO1_ID, B.OZ1_OrgCode, B.OZ1_OrgName, A.EO1_State FROM F01_CERT.EO1_EmpOrgLink A
                            JOIN  F01_CERT.OZ1_Organization B  ON A.EO1_OZ1_OrgCode = B.OZ1_OrgCode " + strCons;
            ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);
            return ds; 

        }
        #endregion

        #region 新建或修改人员关联部门记录
        /// <summary>
        /// 新建或修改记录
        /// </summary>
        /// <returns></returns>
        public DataSet SaveRowLinks(Dbconn conn, String strType)
        {
            DataSet ds_Return = new DataSet();
            //string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
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
                    if (dt_List1.Columns.Contains("eo1_lmdt"))
                    {
                        dt_List1.Columns.Remove("eo1_lmdt");
                    }
                    bResult = conn.Insert("F01_CERT.EO1_EmpOrgLink", dt_List1);
                }
                //如果类型包含，update，解析成表，做update
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    DataTable dt_List2 = dsXML.Tables[i + 1];
                    //添加更新主键，按照GUID更新
                    ArrayList ListKey = new ArrayList();
                    ListKey.Add("eo1_id");
                    bResult = conn.Update("F01_CERT.EO1_EmpOrgLink", dt_List2, ListKey);
                }
                //如果类型包含，DELETE，解析成表，做DELETE
                else if (dtOptypes.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    DataTable dt_List3 = dsXML.Tables[i + 1];
                    for (int k = 0; k < dt_List3.Rows.Count; k++)
                    {
                        string strID1 = dt_List3.Rows[k]["eo1_id"].ToString();
                        bResult = conn.Delete("F01_CERT.EO1_EmpOrgLink", "eo1_id=" + "'" + strID1 + "'");
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
    }
}