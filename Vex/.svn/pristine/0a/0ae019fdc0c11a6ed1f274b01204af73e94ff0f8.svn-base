using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类说明：DL通用查询接口 获取款式 按照区域查询店铺 
/// 创建人：郭琦琦
/// 创建日期：2015-05-11
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.DLWXSite
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
        private Dbconn conn = new Dbconn("DLWX");
        private Dbconn connGP = new Dbconn("F22GP");
        private Dbconn m_Conn = new Dbconn("DLWXWZ");

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
                else if (strOptype == "GetTmemeWX".ToUpper())      //获取主题
                {
                    GetTmemeWX();
                }
                else if (strOptype == "GetNotice".ToUpper())      //获取通知公告
                {
                    GetNotice();
                }
                else if (strOptype == "GetVIPPrivilege".ToUpper())      //获取vip特权
                {
                    GetVIPPrivilege();
                }
                return m_dsRequturn;
            }
            catch
            {
                m_Conn.RollbackTransaction();
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
        /// 获取主题
        /// </summary>
        private void GetTmemeWX()
        {
            string strSql = @"
                SELECT  [TID]
                    ,[Year]
                    ,[ThemeCode]
                    ,[ThemeName]
                    ,[CreateUser]
                    ,[CreateTime]
                    ,[UpdateUser]
                    ,[ThemeOrder]
                    ,[ThemeState]
                    ,[UpdateTime]
                FROM [dbo].[DL_Theme] 
                Where ThemeState = 1 ORDER BY ThemeOrder DESC";
            m_dsRequturn = m_Conn.GetDataSet(strSql);
        }

        #region  获取公告
        /// <summary>
        /// 获取公告
        /// </summary>
        private void GetNotice()
        {

            string strSQL = @"
                                SELECT  top 5 id ,
                                 noticetitle ,
                                 noticecontent ,
                                 type ,
                                 state ,
                                 sortcode ,
                                 imagepath ,
                                 updatename ,
                                 CONVERT(VARCHAR(10),updatedate,120)  updatedate ,
                                 createname ,
                                CONVERT(VARCHAR(10),creatrdate,120)  creatrdate
		                        FROM dbo.DL_Notice  WHERE   state = 1 ORDER BY sortcode DESC ";
            m_dsRequturn = m_Conn.GetDataSet(strSQL);
        }
        #endregion

        #region  获取特权
        /// <summary>
        /// 获取特权
        /// </summary>
        private void GetVIPPrivilege()
        {

            string strSQL = @"
                                 SELECT TOP 5 * FROM   dbo.dl_VIPPrivilege ";
            m_dsRequturn = m_Conn.GetDataSet(strSQL);
        }
        #endregion

        #endregion
    }

}