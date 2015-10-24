using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类说明：GL通用查询接口 获取款式 按照区域查询店铺 
/// 创建人：郭琦琦
/// 创建日期：2015-06-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.GLWXSite
{

    public class Commom : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Commom()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("GLWXSite");
        private Dbconn connGP = new Dbconn("F22GP");

        DataSet ds = new DataSet();
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_dsRequturn = new DataSet();

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
                DateTime time = DateTime.Now;

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                string strOptype = dt_OPTYPE.Rows[0][0].ToString().ToUpper();

                if (strOptype == "GetStyleSKU".ToUpper())      //获取款式信息
                {
                    GetStyleSKU();
                }
                else if (strOptype == "GetTheme".ToUpper())//获取所有品牌
                {
                    GetTheme();
                }


                return m_dsRequturn;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion


        #region  内部函数

        private void GetStyleSKU()
        {
            string strSQL = @"
                SELECT top 1000
                       CL.[clothingid]
                      ,CL.[styleid]
                      ,CO.[c_name]
                      ,CL.[sizeid]
                      ,CL.[oldclothingid]
                      ,ST.[s_name]
                      ,ST.[sizegrpid]
                      ,ST.[s_use]
                      ,ST.[J_cost]
                      ,ST.[J_price]
                      ,ST.[pj_price]
                      ,ST.[x_price]
                      ,ST.[px_price]
                      ,ST.[brandid]
                      ,ST.[st_year]
                      ,ST.[st_month]
                      ,ST.[st_picture]
                      ,ST.[st_dl]
                      ,ST.[st_xl]
                      ,ST.[comment]
                      ,ST.[freeze]
                      ,ST.[sizetitleid]
                      ,ST.[st_bd]
                      ,ST.[supplierid]
                      ,ST.[FNoVipDis]
                      ,ST.[style_no]
                      ,ST.[IsFromC130]
                      ,ST.[Modify_Date]
                FROM [dbo].[j_clothing] CL WITH(NOLOCK)
                LEFT JOIN [dbo].[J_style] ST ON CL.styleid = ST.styleid
                LEFT JOIN [dbo].[j_color] CO ON CO.colorid = CL.colorid
                WHERE 1=1 " + m_hzyPageInfo.Where;
            m_dsRequturn = connGP.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }

        /// <summary>
        /// 获取所有品牌
        /// </summary>
        private void GetTheme()
        {
            string strSQL = @" SELECT [Year]
                                  ,[ThemeCode]
                                  ,[ThemeName]
                              FROM [dbo].[GL_Theme] where 1=1 " + m_hzyPageInfo.Where;
            m_dsRequturn = conn.GetDataSet(strSQL);
        }

        #endregion
    }

}