using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;

/// 类名：Supplier
/// 类说明：对Supplier(供应商的增删改查)的CRUD,为Easyui专用
/// 创建人：郭琦琦
/// 创建日期：2014-05-21 
/// 修改人：
/// 修改日期：
/// 修改内容：
namespace HZY.COM.WS.GroupERP
{
    public class Supplier : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Supplier()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;//创建时间
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();

        #endregion

        #region GetData

        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                string filter = "";
                //string strZT = "";
                m_conn = new Dbconn(m_hzyMessage.Env_SN);
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                filter = m_request.Tables[0].Rows[0]["q"].ToString(); // 实时条件，用于下拉框查询数据
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                //if (ds.Tables["list"].Columns.Contains("zt"))
                //{
                //    strZT = ds.Tables["list"].Rows[0]["zt"].ToString();
                //}
                //else
                //{
                //    strZT = "LX";  //2015-01-04修改  在上线的时候这里改成抛出异常！！！！
                //}

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SupplierInfo".ToUpper())      //供应商信息查询无分页
                {
                    Get(filter);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SupplierInfoForPageList".ToUpper())      //供应商信息查询有分页
                {
                    SupplierInfoForPageList();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT".ToUpper())//供应商新增修改操作
                {
                    EDIT();
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 供应商信息查询(无分页)
        /// <summary>
        /// 供应商信息查询(无分页)
        /// </summary>
        private void Get(string pstrfilter)
        {
            //m_hzyPageInfo.Order = "SP1_SupplierCode";
            string strSQL = @"
                                SELECT [SP1_ID]
                                    ,[SP1_CONO]
                                    ,[SP1_DIVI]
                                    ,[SP1_SupplierCode]
                                    ,[SP1_Name]
                                    ,[SP1_Desp]
                                    ,[SP1_RegionCode]
                                    ,[SP1_RegionName]
                                    ,[SP1_TypeCode]
                                    ,[SP1_TypeName]
                                    ,[SP1_State]
                                    ,[SP1_SupplyTax]
                                    ,[SP1_Contacts]
                                    ,[SP1_ContactTel]
                                    ,[SP1_Address]
                                    ,[SP1_BankName]
                                    ,[SP1_BankAddress]
                                    ,[SP1_BankAccount]
                                    ,[SP1_BankSWIFTID]
                                    ,[SP1_RgDt]
                                    ,[SP1_RgUser]
                                    ,[SP1_LmDt]
                                    ,[SP1_LmUser]
                                    ,[SP1_UptNo]  
                            FROM [B01_MDM].[SP1_Supplier]
                            WHERE  1=1 AND SP1_DIVI='" + m_hzyMessage.Env_SN + "' AND (SP1_Desp LIKE '%" + pstrfilter + "%' OR SP1_Name LIKE '%" + pstrfilter + "%') "+ m_hzyPageInfo.Where +" Order by SP1_SupplierCode ";  
            ds_Return = m_conn.GetDataSet(strSQL, new string[0]);
        }
        #endregion

        #region 供应商信息查询(有分页)
        /// <summary>
        /// 供应商信息查询(有分页)
        /// </summary>
        private void SupplierInfoForPageList()
        {
            string strSQL = @"
                            SELECT SP1_ID ,
                                SP1_CONO ,
                                SP1_DIVI ,
                                SP1_SupplierCode ,
                                SP1_Name ,
                                SP1_Desp ,
                                SP1_RegionCode ,
                                SP1_RegionName ,
                                SP1_TypeCode ,
                                SP1_TypeName ,
                                SP1_State ,
                                SP1_SupplyTax ,
                                SP1_Contacts ,
                                SP1_ContactTel ,
                                SP1_Address ,
                                SP1_BankName ,
                                SP1_BankAddress ,
                                SP1_BankAccount ,
                                SP1_BankSWIFTID ,
                                SP1_FeatureName ,
                                SP1_FeatureCode ,
                                SP1_RgDt ,
                                SP1_RgUser ,
                                SP1_LmDt ,
                                SP1_LmUser ,
                                SP1_UptNo  
                        FROM [B01_MDM].[SP1_Supplier]
                        WHERE  1=1 AND SP1_DIVI='" + m_hzyMessage.Env_SN + "' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 供应商新增修改操作
        /// <summary>
        /// 供应商新增修改操作
        /// </summary>
        private void EDIT()
        {
            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strSP1_SupplierCode = ds.Tables["list"].Rows[0]["sp1_suppliercode"].ToString();//获取供应商编号
            bool bResult = false;
            m_conn.LockTableList.Add("[B01_MDM].[SP1_Supplier]");
            m_conn.BeginTransaction();

            //判断前台穿过来的供应商编号在数据库存不存在,如果存在就更新,如果不存在就修改
            int nCountYN = m_conn.GetDataTableRowCount("SELECT * FROM [B01_MDM].[SP1_Supplier] WHERE SP1_SupplierCode='" + strSP1_SupplierCode + "' AND SP1_DIVI='" + m_hzyMessage.Env_SN + "'");

            if (ds.Tables["list"].Columns.Contains("company"))
            {
                ds.Tables["list"].Columns.Remove("company");
            }

            if (nCountYN == 0)
            {
                string strSp1_Name = ds.Tables["list"].Rows[0]["sp1_name"].ToString();//获取供应商简称
                string strSp1_Desp = ds.Tables["list"].Rows[0]["sp1_desp"].ToString();//获取供应商全称
                string strSP1_RegionCode = ds.Tables["list"].Rows[0]["sp1_regioncode"].ToString();//获取供应商类型（国内国外）编码
                string strSP1_FeatureCode = ds.Tables["list"].Rows[0]["sp1_featurecode"].ToString();//获取供应特征编码
                string strSP1_TypeCode = ds.Tables["list"].Rows[0]["sp1_typecode"].ToString();//获取供应分类
                //string strDIVI = ds.Tables["list"].Rows[0]["sp1_divi"].ToString();//环境

                //判断供应商简称或者全称存在就不给修改
                int nCount = m_conn.GetDataTableRowCount("SELECT * FROM [B01_MDM].[SP1_Supplier] WHERE (sp1_name='" + strSp1_Name + "' or SP1_Desp ='" + strSp1_Desp + "') AND SP1_DIVI='" + m_hzyMessage.Env_SN + "'");

                if (nCount != 0)
                {
                    throw new Exception("新增加的供应商：" + strSp1_Name + "已经存在，信息错误！");
                }

                //构建新表
                ds.Tables["list"].Columns.Add("SP1_ID");
                ds.Tables["list"].Columns.Add("SP1_RgDt");
                ds.Tables["list"].Columns.Add("SP1_RgUser");
                ds.Tables["list"].Columns.Add("SP1_LmDt");
                ds.Tables["list"].Columns.Add("SP1_LmUser");
                ds.Tables["list"].Columns.Add("SP1_DIVI");
                //ds.Tables["list"].Columns.Add("SP1_CONO");
                if (ds.Tables["list"].Columns.Contains("zt"))
                {
                    ds.Tables["list"].Columns.Remove("zt");
                }


                ds.Tables["List"].Rows[0]["SP1_ID"] = System.Guid.NewGuid().ToString();
                ds.Tables["List"].Rows[0]["SP1_RgDt"] = timeNow;
                ds.Tables["List"].Rows[0]["SP1_RgUser"] = hzyMessage.User_Name;
                ds.Tables["List"].Rows[0]["SP1_LmDt"] = timeNow;
                ds.Tables["List"].Rows[0]["SP1_LmUser"] = hzyMessage.User_Name;
                ds.Tables["list"].Rows[0]["SP1_DIVI"] = m_hzyMessage.Env_SN;

                bResult = m_conn.Insert("[B01_MDM].[SP1_Supplier]", ds.Tables["list"]);
            }
            else
            {
                //ds.Tables["list"].Columns.Remove("sp1_divi");
                if (ds.Tables["list"].Columns.Contains("zt"))
                {
                    ds.Tables["list"].Columns.Remove("zt");
                    ds.Tables["list"].Columns.Remove("sp1_cono");
                }

                ds.Tables["list"].Columns.Remove("sp1_suppliercode");
                ds.Tables["list"].Columns.Add("SP1_LmDt");
                ds.Tables["list"].Columns.Add("SP1_LmUser");
                ds.Tables["List"].Rows[0]["SP1_LmDt"] = timeNow;
                ds.Tables["List"].Rows[0]["SP1_LmUser"] = hzyMessage.User_Name;
                bResult = m_conn.Update("[B01_MDM].[SP1_Supplier]", ds.Tables["list"], "sp1_suppliercode='" + strSP1_SupplierCode + "' AND SP1_DIVI='" + m_hzyMessage.Env_SN + "'");
            }
            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, strSP1_SupplierCode });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "失败" });

            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion
    }
}
