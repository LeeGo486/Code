using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using HZY.COM.WS.DataSets;
using System.Collections;

namespace HZY.COM.WS.DLWXSite
{

    /// 类名：Notice 
    /// 类说明：获取DL公告
    /// 创建人：Cookie
    /// 创建日期：2015-07-05
    /// 修改人：
    /// 修改日期：
    class Notice : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Notice()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("DLWXWZ");
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
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetNotice".ToUpper())      //获取数据(GetNotic)
                {
                    GetNotice(ds);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UpdateNotice".ToUpper())      //更新新闻
                {
                    UpdateNotice(ds);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DeleteNotice".ToUpper())      //删除新闻
                {
                    DeleteNotice(ds);
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


        #region  获取公告VEX
        /// <summary>
        /// 获取公告
        /// </summary>
        private void GetNotice(DataSet pdsXML)
        {

            string strSQL = @"
                               SELECT * FROM dbo.DL_Notice  
                               WHERE 1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion


        #region  update公告
        /// <summary>
        /// update公告
        /// </summary>
        private void UpdateNotice(DataSet pdsXML)
        {

            string strid = ds.Tables["list"].Rows[0]["id"].ToString();//id

            m_conn.BeginTransaction(); // 开启事务
            bool bResult = false;

            if (strid == "" || strid == null)
            {
                pdsXML.Tables["list"].Columns.Remove("id");
                pdsXML.Tables["list"].Columns.Add("updatename");
                pdsXML.Tables["list"].Columns.Add("updatedate");
                pdsXML.Tables["list"].Columns.Add("createname");
                pdsXML.Tables["list"].Columns.Add("creatrdate");
                pdsXML.Tables["List"].Rows[0]["updatename"] = hzyMessage.User_Name;
                pdsXML.Tables["List"].Rows[0]["updatedate"] = timeNow;
                pdsXML.Tables["List"].Rows[0]["createname"] = hzyMessage.User_Name;;
                pdsXML.Tables["List"].Rows[0]["creatrdate"] = timeNow;
                bResult = m_conn.Insert("DL_Notice", pdsXML.Tables["List"]);
            }
            else
            {
                pdsXML.Tables["list"].Columns.Add("updatename");
                pdsXML.Tables["list"].Columns.Add("updatedate");
                pdsXML.Tables["List"].Rows[0]["updatename"] = hzyMessage.User_Name;;
                pdsXML.Tables["List"].Rows[0]["updatedate"] = timeNow;

                ArrayList listKey = new ArrayList();
                listKey.Add("id");
                bResult = m_conn.Update("DL_Notice", pdsXML.Tables["List"], listKey);
            }
            m_conn.CommitTransaction();   //提交事务
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region  delete
        /// <summary>
        /// delete公告
        /// </summary>
        private void DeleteNotice(DataSet pdsXML)
        {

            m_conn.BeginTransaction(); // 开启事务
            bool bResult = false;

            string strid = ds.Tables["list"].Rows[0]["id"].ToString();//id
            bResult = m_conn.Delete("DL_Notice", "id=" + "'" + strid + "'");

            m_conn.CommitTransaction();   //提交事务
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "删除成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "删除失败" });

            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #endregion
    }
}
