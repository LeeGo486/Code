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

/// 类名：BR1_Brand
/// 类说明：对BR1_Brand(品牌的增删改查)的CRUD,为Easyui专用
/// 创建人：郭琦琦
/// 创建日期：2014-05-22 
/// 修改人：刘洪
/// 修改日期：2014-11-08
/// 修改内容：注释所有供应商字段

namespace HZY.COM.WS.GL_ERP2
{
    public class Brand : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Brand()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("GL_ERP");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                string filter = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "BrandInfo".ToUpper())      //品牌信息查询无分页带模糊查询
                {
                    filter = m_request.Tables[0].Rows[0]["q"].ToString(); // 实时条件，用于下拉框查询数据
                    Get(filter);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "BrandInfoForPageList".ToUpper()) //供应商信息查询有分页
                {
                    BrandInfoForPageList();
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

        #region 品牌信息查询(无分页)带模糊
        /// <summary>
        /// 品牌信息查询(无分页)带模糊
        /// </summary>
        private void Get(string pstrQ)
        {
            string strSQL = @"
                                SELECT  BR1_ID ,
                                        BR1_CONO ,
                                        BR1_DIVI ,
                                        BR1_BrandCode ,
                                        BR1_Name ,
                                        BR1_Desp ,
                                        --BR1_SupplierCode ,
                                        BR1_Country ,
                                        BR1_StyleName ,
                                        BR1_CustomerGroup ,
                                        BR1_State ,
                                        BR1_RgDt ,
                                        BR1_RgUser ,
                                        BR1_LmDt ,
                                        BR1_LmUser ,
                                        BR1_UptNo
                                  FROM [B01_MDM].[BR1_Brand]
                                  WHERE  1=1 AND 
                                  BR1_Desp LIKE '%" + pstrQ + "%' OR SP1_Name LIKE '%" + pstrQ + "%'  Order by BR1_BrandCode " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSet(strSQL, new string[0]);
        }

        #endregion

        #region 品牌信息查询(有分页)
        /// <summary>
        /// 品牌信息查询(有分页)
        /// </summary>
        private void BrandInfoForPageList()
        {
            string strSQL = @"
                              SELECT  BR1_ID ,
                                        BR1_CONO ,
                                        BR1_DIVI ,
                                        BR1_BrandCode ,
                                        BR1_Name ,
                                        BR1_Desp ,
                                        --BR1_SupplierCode ,    --注释
                                        BR1_Country ,
                                        BR1_StyleName ,
                                        BR1_CustomerGroup ,
                                        BR1_State ,
                                        BR1_RgDt ,
                                        BR1_RgUser ,
                                        BR1_LmDt ,
                                        BR1_LmUser ,
                                        BR1_UptNo
                                        -- ,t.SP1_Name --注释
                                FROM    [B01_MDM].[BR1_Brand]
                                --LEFT JOIN [B01_MDM].[SP1_Supplier] t ON BR1_SupplierCode = t.SP1_SupplierCode
                                WHERE  1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 品牌新增修改操作
        /// <summary>
        /// 品牌新增修改操作
        /// </summary>
        private void EDIT()
        {
            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strBR1_BrandCode = ds.Tables["list"].Rows[0]["br1_brandcode"].ToString();//获取供应商编号
            string strBR1_Name = ds.Tables["list"].Rows[0]["br1_name"].ToString();//获取供应商简称
            string strBR1_Desp = ds.Tables["list"].Rows[0]["br1_desp"].ToString();//获取供应商全称
            bool bResult = false;
            m_conn.LockTableList.Add("[B01_MDM].[BR1_Brand]");
            m_conn.BeginTransaction();
            if (strBR1_BrandCode == "系统自动生成")
            {

                //判断品牌简称或者全称存在就不给修改
                int nCount = m_conn.GetDataTableRowCount("SELECT * FROM [B01_MDM].[BR1_Brand] WHERE BR1_Name='" + strBR1_Name + "' or BR1_Desp ='" + strBR1_Desp + "'");

                if (nCount != 0)
                {
                    throw new Exception("新增加的品牌：" + strBR1_Name + "或者" + strBR1_Desp + "已经存在，信息错误！");
                }
                //传入参数，生成最大号
                //string MaxPurchaseCode = AutoKeyCode.GetMaxKeyCode("新增品牌", "", "", "", m_conn);

                DataSet dsMaxPurchaseCode = m_conn.GetDataSetBySP("Get_MaxBrandCode", new string[0], new string[0]);
                string MaxPurchaseCode = dsMaxPurchaseCode.Tables[0].Rows[0]["maxcode"].ToString();
                ds.Tables["list"].Columns.Add("BR1_ID");
                ds.Tables["list"].Columns.Add("BR1_DIVI");
                ds.Tables["list"].Columns.Add("BR1_CONO");
                ds.Tables["list"].Columns.Add("BR1_RgDt");
                ds.Tables["list"].Columns.Add("BR1_RgUser");
                ds.Tables["list"].Columns.Add("BR1_LmDt");
                ds.Tables["list"].Columns.Add("BR1_LmUser");
                //注释LeeGo//ds.Tables["list"].Columns.Remove("br1_suppliername");
                ds.Tables["List"].Rows[0]["BR1_ID"] = System.Guid.NewGuid().ToString();
                ds.Tables["List"].Rows[0]["BR1_DIVI"] = "D01";
                ds.Tables["List"].Rows[0]["BR1_CONO"] = "GL";
                ds.Tables["List"].Rows[0]["BR1_RgDt"] = timeNow;
                ds.Tables["List"].Rows[0]["BR1_RgUser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["BR1_LmDt"] = timeNow;
                ds.Tables["List"].Rows[0]["BR1_LmUser"] = hzyMessage.User_Name_CN;
                ds.Tables["list"].Rows[0]["br1_brandcode"] = MaxPurchaseCode;
                bResult = m_conn.Insert("[B01_MDM].[BR1_Brand]", ds.Tables["list"]);
            }
            else
            {
                //注释LeeGo//dds.Tables["list"].Columns.Remove("br1_suppliername");
                ds.Tables["list"].Columns.Remove("br1_brandcode");
                ds.Tables["list"].Columns.Add("BR1_LmDt");
                ds.Tables["list"].Columns.Add("BR1_LmUser");
                ds.Tables["List"].Rows[0]["BR1_LmDt"] = timeNow;
                ds.Tables["List"].Rows[0]["BR1_LmUser"] = hzyMessage.User_Name_CN;
                bResult = m_conn.Update("[B01_MDM].[BR1_Brand]", ds.Tables["list"], "br1_brandcode='" + strBR1_BrandCode + "'");
            }
            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "成功" });
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