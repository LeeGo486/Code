using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;

namespace HZY.COM.WS.NPaiaWXSite
{
    /// 类名：ViewRepository
    /// 类说明：NPaia的形象后台类
    /// 创建人：ZillionStar-Gavin
    /// 创建日期：2015-4-7
    /// WSID: TODO
    public class ViewRepository : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public ViewRepository()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("NPaia");
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
                DataTable dtEditResult = new dsCommon.dtResultDataTable();
                DataSet dsReturn = new DataSet();
                DataSet dsRequest = Common.Common.GetDSByExcelXML(m_request.Tables[0].Rows[0]["XML"].ToString());
                DataTable dtOptype = dsRequest.Tables["OPTYPE"];

                for (int i = 0; i < dtOptype.Rows.Count; i++)
                {
                    //验证
                    if (dsRequest.Tables[i + 1].Columns.Count > 0)
                    {
                        if (dsRequest.Tables[i + 1].Rows.Count == 0)
                        {
                            throw new Exception("参数不正确！");
                        }
                    }

                    if (dtOptype.Rows[0][0].ToString().ToUpper() == "GET".ToUpper()) //查询恩派雅库存量
                    {
                        dsReturn = GetList(dsRequest.Tables[i + 1]);
                    }
                    else if (dtOptype.Rows[i][0].ToString().ToUpper() == "EDIT")
                    {
                        //编辑操作
                        bool bResult = Save(dsRequest.Tables[i + 1]);
                        if (bResult)
                        {
                            dtEditResult.Rows.Add(true, "修改成功");
                        }
                        else
                        {
                            dtEditResult.Rows.Add(false, "修改失败");
                        }
                        dsReturn.Tables.Add(dtEditResult);
                    }
                    else if (dtOptype.Rows[i][0].ToString().ToUpper() == "CHANGESTATUS")
                    {
                        //编辑操作
                        bool bResult = ChangeStatus(dsRequest.Tables[i + 1]);
                        if (bResult)
                        {
                            dtEditResult.Rows.Add(true, "修改成功");
                        }
                        else
                        {
                            dtEditResult.Rows.Add(false, "修改失败");
                        }
                        dsReturn.Tables.Add(dtEditResult);
                    }
                    else if (dtOptype.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        //删除操作
                        bool bResult = Delete(dsRequest.Tables[i + 1]);
                        if (bResult)
                        {
                            dtEditResult.Rows.Add(true, "删除成功");
                        }
                        else
                        {
                            dtEditResult.Rows.Add(false, "删除失败");

                        }
                        dsReturn.Tables.Add(dtEditResult);
                    }
                    else
                    {
                        dtEditResult.Rows.Add(false, "操作失败");
                        dsReturn.Tables.Add(dtEditResult);
                    }
                }

                return dsReturn;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region  内部函数
        protected virtual DataSet GetList(DataTable pDataTable)
        {
            m_hzyPageInfo.Sort = "CreateTime";
            m_hzyPageInfo.Order = "DESC";
            string strSql = @"
                SELECT a.[VID]
                        ,b.TID as TID
                        ,b.Year as Year
                        ,b.ThemeCode as ThemeCode
	                    ,b.ThemeName as ThemeName
                        ,a.[Code]
                        ,a.[Name]
                        ,a.[Image]
                        ,a.[BigImage]
                        ,a.[Status]
                        ,a.[Description]
                        ,a.[CreateUser]
                        ,a.[CreateTime]
                        ,a.[UpdateUser]
                        ,a.[UpdateTime]
                    FROM [dbo].[NPaia_View] a
                    inner JOIN [dbo].NPaia_Theme b ON a.ThemeID=b.TID " + m_hzyPageInfo.Where;
            return conn.GetDataSetForPageList(strSql, new string[0], m_hzyPageInfo);
        }

        protected virtual bool Save(DataTable pDataTable)
        {
            try
            {
                string viewId = pDataTable.Rows[0]["viewid"].ToString();  //获取参数TaskID

                ArrayList listTable = new ArrayList();
                listTable.Add("NPaia_View");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表NPaia_View
                string strWhere = string.Empty;

                //创建DataTable，用于传参
                DataTable dtAdd = new DataTable();
                dtAdd.Columns.Add("VID");
                dtAdd.Columns.Add("ThemeID");
                dtAdd.Columns.Add("Code");
                dtAdd.Columns.Add("Name");
                dtAdd.Columns.Add("Image");
                dtAdd.Columns.Add("BigImage");
                dtAdd.Columns.Add("Status");
                dtAdd.Columns.Add("Description");
                dtAdd.Columns.Add("CreateUser");
                dtAdd.Columns.Add("CreateTime");
                dtAdd.Columns.Add("UpdateUser");
                dtAdd.Columns.Add("UpdateTime");

                DataRow dr = dtAdd.NewRow();
                //循环DataTabel的列
                for (int i = 0; i < dtAdd.Columns.Count - 4; i++)
                {
                    if (dtAdd.Columns[i].ColumnName == "VID")
                    {
                        continue;
                    }
                    else
                    {
                        dr[i] = pDataTable.Rows[0][dtAdd.Columns[i].ColumnName].ToString();   //对DataTabel中的每列设置值
                    }
                }
                dtAdd.Rows.Add(dr);

                if (string.IsNullOrEmpty(viewId)) //如果为空，说明是插入数据
                {
                    //生成形象编号
                    string strSql = @"SELECT TOP 1 Code
                          FROM [dbo].[NPaia_View]
                          where [Code] like '_" + DateTime.Now.Year + "%' ORDER BY Code DESC";
                    string newCode = string.Empty;
                    string maxCode = conn.GetDataTableFirstValue(strSql) as string;
                    if (maxCode == null)
                    {
                        newCode = string.Format("L{0}{1}", DateTime.Now.Year, "001");
                    }
                    else
                    {
                        //string strMaxCode = maxCode as string;
                        int behondCode = int.Parse(maxCode.Substring(maxCode.Length - 3)) + 1;
                        newCode = string.Format("L{0}{1}", DateTime.Now.Year, behondCode.ToString().PadLeft(3, '0'));
                    }
                    dtAdd.Rows[0]["Code"] = newCode;
                    

                    dtAdd.Rows[0]["VID"] = Guid.NewGuid();
                    dtAdd.Rows[0]["CreateTime"] = DateTime.Now; //设置创建时间
                    dtAdd.Rows[0]["CreateUser"] = hzyMessage.User_Name; //设置创建者
                    dtAdd.Rows[0]["UpdateTime"] = DateTime.Now; //设置更新时间
                    dtAdd.Rows[0]["UpdateUser"] = hzyMessage.User_Name; //设置更新者
                    conn.Insert("NPaia_View", dtAdd); //插入数据
                }
                else
                {
                    //更新
                    dtAdd.Columns.Remove("CreateUser");    //删除CreateUser列，更新不需要
                    dtAdd.Columns.Remove("CreateTime");    //删除CreateTime列，更新不需要
                    dtAdd.Columns.Remove("VID");
                    dtAdd.Rows[0]["UpdateTime"] = DateTime.Now;    //将更新时间设为当前时间
                    dtAdd.Rows[0]["UpdateUser"] = hzyMessage.User_Name;    //设置更新者

                    strWhere = " VID = '" + viewId + "'";   //设置更新条件
                    conn.Update("NPaia_View", dtAdd, strWhere); //更新数据
                }
                conn.CommitTransaction();   //提交事务
                return true;
            }
            catch (Exception e)
            {
                conn.RollbackTransaction(); //回滚
                throw;
            }
        }

        protected virtual bool ChangeStatus(DataTable pDataTable)
        {
            try
            {
                string viewIds = pDataTable.Rows[0]["VIDS"].ToString();  //获取参数VIDS
                string statuses = pDataTable.Rows[0]["Statuses"].ToString();  //获取参数状态
                string[] vids = viewIds.Split(',');

                ArrayList listTable = new ArrayList();
                listTable.Add("NPaia_View");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表NPaia_View

                //创建DataTable，用于传参
                DataTable dtAdd = new DataTable();
                dtAdd.Columns.Add("Status");
                dtAdd.Columns.Add("UpdateUser");
                dtAdd.Columns.Add("UpdateTime");
                
                for (int i = 0; i < vids.Length; i++)
                {
                    DataRow dr = dtAdd.NewRow();
                    dr["Status"] = statuses;
                    dr["UpdateTime"] = DateTime.Now;    //将更新时间设为当前时间
                    dr["UpdateUser"] = hzyMessage.User_Name;    //设置更新者
                    dtAdd.Rows.Add(dr);

                    string strWhere = " VID = '" + vids[i] + "'";   //设置更新条件
                    conn.Update("NPaia_View", dtAdd, strWhere); //更新数据
                }

              
                conn.CommitTransaction();   //提交事务
                return true;
            }
            catch (Exception e)
            {
                conn.RollbackTransaction(); //回滚
                throw;
            }
        }
        protected virtual bool Delete(DataTable pDataTable)
        {
            try
            {
                string strViewId = pDataTable.Rows[0]["vid"].ToString();    //获取参数Param_ID

                string strSql = @"
                        SELECT  *
                        FROM [dbo].[NPaia_View_Style] WHERE ViewID= '" + strViewId + "'";
                int count = conn.GetDataTableRowCount(strSql);
                if (count > 0)
                {
                    throw new Exception("该形象下已有款式不能删除！");
                }

                ArrayList listTable = new ArrayList();
                listTable.Add("NPaia_View");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表NPaia_View

                string strWhere = " VID = '" + strViewId + "'";  //创建where语句
                conn.Delete("NPaia_View", strWhere);    //删除参数

                conn.CommitTransaction();   //提交事务
                return true;
            }
            catch (Exception e)
            {
                conn.RollbackTransaction(); //回滚
                throw;
            }
        }

        #endregion
    }
}
