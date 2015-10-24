using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：NGoods
/// 类说明：恩派雅商品维护后台类
/// 创建人：刘洪
/// 创建日期：2014-09-19
/// WSID:50156559-98fe-4ea4-b5bb-3e42f2de0cb5
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.NPaiaWXSite
{

    public class NGoods : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public NGoods()
        {
            this.m_SessionCheck = false;

        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("NPaia");
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

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetStyleSKU".ToUpper())      //获取款式信息
                {
                    GetStyleSKU();
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddStyleSKU".ToUpper())      //新建款式信息
                {
                    //AddStyleSKU();
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
                SELECT CL.[clothingid]
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
                WHERE ST.brandid = 'X' " + m_hzyPageInfo.Where;
            m_dsRequturn = connGP.GetDataSetForPageList(strSQL,new string[0], m_hzyPageInfo);
        }
        #region 获取款式信息
        #endregion
        #endregion
    }

}