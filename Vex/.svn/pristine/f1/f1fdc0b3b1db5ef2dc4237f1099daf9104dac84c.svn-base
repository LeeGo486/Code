using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：PE_OA_OZ_Organization
/// 类说明：组织架构API
/// 创建人：DLY 
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_OZ_Organization : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        Dbconn conn = new Dbconn("PE_OA");

        #region 构造函数
        public PE_OA_OZ_Organization()
        {
            this.m_SessionCheck = true;
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
                
                DataSet ds = new DataSet();
                 

                if (strType == "GetORGTree")
                {
                    ds = GetORGTreeByID(conn, strType); 

                }
                else if (strType == "GetDeptsByEmpID")
                {
                    ds = GetDeptsByEmpID(conn, strType);
                }
                else if (strType == "GetOrgsByZHGLBEmpID")
                {
                    ds = GetOrgsByZHGLBEmpID(conn, strType);
                }
                else if (strType == "GetOrgs")
                {
                    ds = GetOrgs(conn, strType);
                }
                else if (strType == "NewDept" || strType == "UpdDept" || strType == "UpdDept1"  || strType == "DelDept")
                {
                    ds = SetDeptInfo(conn, strType);
                } 
                return ds; 

            }
            catch
            {
                throw;
            } 
        } 
        #endregion

        #region 根据faterid 获取组织机构树
        /// <summary>
        /// 根据faterid 获取组织机构树
        /// </summary>
        /// <returns></returns>
        public DataSet GetORGTreeByID(Dbconn conn, String strType)
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
            strSQL = @" SELECT [OZ1_OrgCode], [OZ1_OrgName], [OZ1_FatherId]
                        , [OZ1_OrgType], [OZ1_ID], [OZ1_CONO], [OZ1_DIVI], [OZ1_FatherId] As [OZ1_FatherIdT]
                        , [OZ1_CostCenterCode], [OZ1_DepartmentManager]
                        , [OZ1_MDeptCode], [OZ1_ShopCode], [OZ1_OrgEnable]
                        , [OZ1_CostCenterEnable], [OZ1_BusdepartmentEnable]
                        , [OZ1_ShopEnable], [OZ1_State], [OZ1_ModelType], [OZ1_BMMoney] 
                        , [OZ1_Brand], [OZ1_Com], [OZ1_CostCenterCode1], [OZ1_BMPer]
                        , OZ1_Com1, OZ1_ComCode1, OZ1_ISBranch, OZ1_CostCenterCode2
                        FROM [F01_CERT].[OZ1_Organization] 
                            WHERE 1=1  AND OZ1_OrgType <> '业务线' " + strCons + strOrderBy;
            ds = conn.GetDataSet(strSQL);
            return ds;
        }
        #endregion


        #region 查询 组织机构 
        /// <summary>
        /// 查询 组织机构 
        /// </summary>
        /// <returns></returns>
        public DataSet GetOrgs(Dbconn conn, String strType)
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
            strSQL = @" SELECT * FROM [F01_CERT].[OZ1_Organization] 
                            WHERE 1=1 AND OZ1_OrgType <> '业务线' " + strCons + strOrderBy;
            ds = conn.GetDataSet(strSQL);
            return ds;
        }
        #endregion


        #region 根据人员编码 获取其所在部门
        /// <summary>
        /// 根据人员编码 获取其所在部门
        /// </summary>
        /// <returns></returns>
        public DataSet GetDeptsByEmpID(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strEmpID = dsXML.Tables["LIST"].Rows[0]["EmpID"].ToString(); 
            String strDate = dsXML.Tables["LIST"].Rows[0]["Date"].ToString(); 
            string[] strParam = new string[] { };
            strSQL = @" SELECT B.* FROM  F01_CERT.EO1_EmpOrgLink A , [F01_CERT].[OZ1_Organization] B
                        WHERE A.EO1_State = '启用' AND B.OZ1_OrgType <> '业务线' AND A.EO1_EE1_EmpCode = '" + strEmpID 
                  +"' AND A.EO1_BeginDt <= '" + strDate + "' AND A.EO1_EndDt >= '" + strDate + "' "
                  +" AND A.EO1_OZ1_OrgCode = B.OZ1_OrgCode  ";
            ds = conn.GetDataSet(strSQL);
            return ds;
        }
        #endregion


        #region 根据dept编码 获取dept信息
        /// <summary>
        /// 根据dept编码 获取dept信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetDeptByID(Dbconn conn, String strType)
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
            string[] strParam = new string[] {};
            strSQL = @" SELECT * FROM  [F01_CERT].[OZ1_Organization] 
                            WHERE OZ1_State='启用' AND  OZ1_OrgType <> '业务线' " + strCons;
            ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy); 
            return ds;
        }
        #endregion


        #region 根据人员编码 获取综合管理部负责人所负责公司code
        /// <summary>
        ///  根据人员编码 获取综合管理部负责人所负责公司code
        /// </summary>
        /// <returns></returns>
        public DataSet GetOrgsByZHGLBEmpID(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strEmpID = dsXML.Tables["LIST"].Rows[0]["EmpID"].ToString();
            String strDate = dsXML.Tables["LIST"].Rows[0]["Date"].ToString();
            string[] strParam = new string[] { };

            strSQL = @" SELECT OZ1_OrgCode FROM F01_CERT.OZ1_Organization WHERE OZ1_ID IN
                        ( SELECT CT1_FatherID FROM M01_CONF.CT0_CSYTAB WHERE CT1_FieldValues1 = 'QTPZ'  
				                        AND CT1_CodeName = '综合管理部' AND CT1_Code = '" + strEmpID
                       + "' AND CT1_State = '启用' ) ";
            ds = conn.GetDataSet(strSQL);
            return ds;
        }
        #endregion


        #region 新建或修改部门记录
        /// <summary>
        /// 新建或修改部门记录
        /// </summary>
        /// <returns></returns>
        public DataSet SetDeptInfo(Dbconn conn, String strType)
        {
            String strCode = "";
            DataSet ds_Return = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["oz1_id"].ToString(); 
            DataTable dt_List = dsXML.Tables["LIST"];
            if (strID == "")
            {
                throw new Exception("数据异常，缺少主键，请联系管理员！");
            }
            bool bResult = false;
            conn.BeginTransaction(); 
            if (strType == "NewDept") //新建部门
            { 
                bResult = conn.Insert("[F01_CERT].[OZ1_Organization] ", dt_List); 
            }
            else if (strType == "UpdDept") //修改部门
            { 
                bResult = conn.Update("[F01_CERT].[OZ1_Organization] ", dt_List, "oz1_id='" + strID + "'");
                
            }
            else if (strType == "UpdDept1") //修改部门
            {
                
                //添加更新主键，按照GUID更新
                ArrayList ListKey = new ArrayList();
                ListKey.Add("oz1_id");
                bResult = conn.Update("F01_CERT.OZ1_Organization", dt_List, ListKey);  
            }
            else if (strType == "DelDept") //删除部门
            {
                for (int k = 0; k < dt_List.Rows.Count; k++)
                {
                    string strID1 = dt_List.Rows[k]["oz1_id"].ToString();
                    bResult = conn.Delete("F01_CERT.OZ1_Organization", "oz1_id=" + "'" + strID1 + "'");
                }
            }
            conn.CommitTransaction();
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
        
        
    }     
}