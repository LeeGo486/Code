using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;



namespace HZY.COM.WS.GLWXSite
{
    /// 类名：BrandRepository
    /// 类说明：GL的品牌台类
    /// 创建人：Cookie
    /// 创建日期：2015-05-11
    public class ThemeRepository : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public ThemeRepository()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("GLWXSite");
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

                    if (dtOptype.Rows[0][0].ToString().ToUpper() == "GET")
                    {
                        dsReturn = GetList(dsRequest.Tables[i + 1]);
                    }
                    else if (dtOptype.Rows[0][0].ToString().ToUpper() == "GETALL")
                    {
                        dsReturn = GetAllList(dsRequest.Tables[i + 1]);
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
                FROM [dbo].[GL_Theme] Where 1=1 " + m_hzyPageInfo.Where;
            return conn.GetDataSetForPageList(strSql, new string[0], m_hzyPageInfo);
        }

        protected virtual DataSet GetAllList(DataTable pDataTable)
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
                FROM [dbo].[GL_Theme] ORDER BY ThemeOrder DESC";
            return conn.GetDataSet(strSql);
        }

        protected virtual bool Save(DataTable pDataTable)
        {
            try
            {
                string themeId = pDataTable.Rows[0]["tid"].ToString();  //获取参数TaskID

                ArrayList listTable = new ArrayList();
                listTable.Add("GL_Theme");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表WS_Scheduling
                string strWhere = string.Empty;

                //创建DataTable，用于传参
                DataTable dtAdd = new DataTable();
                dtAdd.Columns.Add("TID");
                dtAdd.Columns.Add("Year");
                dtAdd.Columns.Add("ThemeCode");
                dtAdd.Columns.Add("ThemeName"); 
                dtAdd.Columns.Add("ThemeOrder");
                dtAdd.Columns.Add("ThemeState");
                dtAdd.Columns.Add("CreateUser");
                dtAdd.Columns.Add("CreateTime");
                dtAdd.Columns.Add("UpdateUser");
                dtAdd.Columns.Add("UpdateTime");

                DataRow dr = dtAdd.NewRow();
                //循环DataTabel的列
                for (int i = 0; i < dtAdd.Columns.Count - 4; i++)
                {
                    if (dtAdd.Columns[i].ColumnName == "TID")
                    {
                        continue;
                    }
                    else
                    {
                        dr[i] = pDataTable.Rows[0][dtAdd.Columns[i].ColumnName].ToString();   //对DataTabel中的每列设置值
                    }
                }
                dtAdd.Rows.Add(dr);

                if (string.IsNullOrEmpty(themeId)) //如果为空，说明是插入数据
                {
                    //生成形象编号
                    string strSql = @"SELECT TOP 1 ThemeCode
                          FROM [dbo].[GL_Theme]
                          where [ThemeCode] like '_" + DateTime.Now.Year + "%' ORDER BY ThemeCode DESC";
                    string newCode = string.Empty;
                    string maxCode = conn.GetDataTableFirstValue(strSql) as string;
                    if (maxCode == null)
                    {
                        newCode = string.Format("T{0}{1}", DateTime.Now.Year, "001");
                    }
                    else
                    {
                        int behondCode = int.Parse(maxCode.Substring(maxCode.Length - 3)) + 1;
                        newCode = string.Format("T{0}{1}", DateTime.Now.Year, behondCode.ToString().PadLeft(3, '0'));
                    }
                    dtAdd.Rows[0]["ThemeCode"] = newCode;

                    dtAdd.Rows[0]["TID"] = Guid.NewGuid();
                    dtAdd.Rows[0]["CreateTime"] = DateTime.Now; //设置创建时间
                    dtAdd.Rows[0]["CreateUser"] = hzyMessage.User_Name; //设置创建者
                    dtAdd.Rows[0]["UpdateTime"] = DateTime.Now; //设置更新时间
                    dtAdd.Rows[0]["UpdateUser"] = hzyMessage.User_Name; //设置更新者
                    conn.Insert("GL_Theme", dtAdd); //插入数据
                }
                else
                {
                    //更新
                    dtAdd.Columns.Remove("CreateUser");    //删除CreateUser列，更新不需要
                    dtAdd.Columns.Remove("CreateTime");    //删除CreateTime列，更新不需要
                    dtAdd.Columns.Remove("TID");
                    dtAdd.Rows[0]["UpdateTime"] = DateTime.Now;    //将更新时间设为当前时间
                    dtAdd.Rows[0]["UpdateUser"] = hzyMessage.User_Name;    //设置更新者

                    strWhere = " TID = '" + themeId + "'";   //设置更新条件
                    conn.Update("GL_Theme", dtAdd, strWhere); //更新数据
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
                string strThemeId = pDataTable.Rows[0]["tid"].ToString();    //获取参数Param_ID

                string strSql = @"
                        SELECT  *
                        FROM [dbo].[STYL_Style] WHERE styl_type= '" + strThemeId + "'";
                int count = conn.GetDataTableRowCount(strSql);
                if (count > 0)
                {
                    throw new Exception("该主题下已有商品不能删除！");
                }

                ArrayList listTable = new ArrayList();
                listTable.Add("GL_Theme");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表NPaia_Theme

                string strWhere = " TID = '" + strThemeId + "'";  //创建where语句
                conn.Delete("GL_Theme", strWhere);    //删除参数

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