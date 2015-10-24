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

/// 类名：System_Person_Authority
/// 类说明：对System_Person_Authority的CRUD,为Easyui专用
/// 创建人：郭琦琦
/// 创建日期：2014-06-20
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.EPAcount
{
    public class System_Person_Authority : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public System_Person_Authority()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("VexSSO");
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
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET".ToUpper()) //控制人员权限分配
                {
                    GET();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETENV".ToUpper())//获取人员权限环境
                {
                    GETENV();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT".ToUpper())//修改
                {
                    EDIT();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DELETE".ToUpper())//删除
                {
                    DELETE();
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

        #region 控制人员权限分配(有分页)
        /// <summary>
        /// 控制人员权限分配(有分页)
        /// </summary>
        private void GET()
        {
            string strSQL = @"
                              SELECT [ID]
                                      ,[Person]
                                      ,[Env]
                                  FROM [dbo].[MDM_System_Person_Authority]
                                WHERE  1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 获取环境(有分页)
        /// <summary>
        /// 获取环境(有分页)
        /// </summary>
        private void GETENV()
        {
                string    strSQL = @"
                                SELECT 
                                         t1.[Env_ID]
                                        ,t1.[Env_Name]
                                        ,t1.[Company_ID]
                                        ,t2.Company_Name
                                        ,t1.[System_ID]
                                        ,t3.[System_Name]
                                        ,t3.[System_SN]
                                        ,t1.[Env_SN]
                                        ,t1.[SSO_Login_URL]
                                        ,t1.[Login_URL]
                                        ,t1.[Createtime]
                                        ,t1.[Updatetime]
                                 ,Convert(bigint,t1.[Timestamps]) Timestamps
                                FROM [dbo].[MDM_System_Env] t1 WITH(NOLOCK)
                                LEFT JOIN dbo.MDM_Company t2 WITH(NOLOCK) ON t1.company_id=t2.Company_ID
                                LEFT JOIN dbo.MDM_System t3 WITH(NOLOCK) ON t1.System_ID=t3.System_ID
                                WHERE  1=1 AND Env_ID IN (select env  from [dbo].[MDM_System_Person_Authority] WHERE person = @Param0)" + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[]{hzyMessage.User_Name_CN }, m_hzyPageInfo);
        }
        #endregion

        #region 新增修改操作
        /// <summary>
        /// 新增修改操作
        /// </summary>
        private void EDIT()
        {
            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strID = ds.Tables["list"].Rows[0]["id"].ToString();//获取供应商编号
            string strPerson = ds.Tables["list"].Rows[0]["person"].ToString();//获取供应商编号

            bool bResult = false;
            m_conn.LockTableList.Add("MDM_System_Person_Authority");
            m_conn.BeginTransaction();
            if (strID == "系统自动生成")
            {
                ////判断人是否已经存在
                //int nCount = m_conn.GetDataTableRowCount("SELECT * FROM MDM_System_Person_Authority WHERE Person='" + strPerson + "'");

                //if (nCount != 0)
                //{
                //    throw new Exception("新增加的人：" + strPerson + "已经存在，信息错误！");
                //}
                ds.Tables["list"].Columns.Remove("ID");
                bResult = m_conn.Insert("MDM_System_Person_Authority", ds.Tables["list"]);
            }
            else
            {
                ////判断人是否已经存在
                //int nCount = m_conn.GetDataTableRowCount("SELECT * FROM MDM_System_Person_Authority WHERE id != '" + strID + "'"+" and  Person='" + strPerson + "'");
                //if (nCount != 0)
                //{
                //    throw new Exception("修改的：" + strPerson + "已经存在，信息错误！");
                //}
                ds.Tables["list"].Columns.Remove("ID");
                bResult = m_conn.Update("MDM_System_Person_Authority", ds.Tables["list"], "ID='" + strID + "'");
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

        #region 删除
        /// <summary>
        /// 删除
        /// </summary>
        private void DELETE()
        {
            string strID = ds.Tables["list"].Rows[0]["id"].ToString();//获取供应商编号
            bool bResult = false;
            m_conn.BeginTransaction();
            bResult = m_conn.Delete("MDM_System_Person_Authority", "id=" + strID);
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