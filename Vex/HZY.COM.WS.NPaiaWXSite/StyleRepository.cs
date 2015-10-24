using System;
using System.Collections;
using System.Data;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;

namespace HZY.COM.WS.NPaiaWXSite
{
    /// 类名：StyleRepository
    /// 类说明：NPaia的款式后台类
    /// 创建人：ZillionStar-Gavin
    /// 创建日期：2015-4-7
    /// WSID: TODO
    public class StyleRepository : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public StyleRepository()
        {
            this.m_SessionCheck = false;
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
                    else if (dtOptype.Rows[0][0].ToString().ToUpper() == "GETSTYLE".ToUpper()) //查询恩派雅库存量
                    {
                        dsReturn = GetStyleList(dsRequest.Tables[i + 1]);
                    }
                    else if (dtOptype.Rows[0][0].ToString().ToUpper() == "GETSTYLEBYTHEME".ToUpper())
                    {
                        dsReturn = GetStyleByTheme();
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
            m_hzyPageInfo.Sort = "UpdateTime";
            m_hzyPageInfo.Order = "DESC";
            string viewId = pDataTable.Rows[0]["view_id"].ToString();  //获取参数TaskID
            string strSql = @"
                SELECT 
                   [SID]
                  ,[StyleID]
				  ,b.[STYL_Year]
				  ,b.[STYL_Code]
				  ,b.[STYL_Name]
                  ,[ViewID]
                  ,[CreateUser]
                  ,[CreateTime]
                  ,[UpdateUser]
                  ,[UpdateTime]
				  FROM [dbo].[NPaia_View_Style] a
				  left join B01_MDM.STYL_Style b on a.StyleID=b.STYL_ID WHERE VIEWID='" + viewId + "'" + m_hzyPageInfo.Where; ;
            return conn.GetDataSetForPageList(strSql, new string[0], m_hzyPageInfo);
        }

        protected virtual DataSet GetStyleList(DataTable pDataTable)
        {
            //string viewId = pDataTable.Rows[0]["view_id"].ToString();  //获取参数TaskID
            string strSql = @"
                    SELECT  
                           [STYL_Id] 
                          ,[STYL_Code]
                          ,[STYL_Name]
                          ,[STYL_Desp]
                          ,[STYL_Year]                          
                      FROM [B01_MDM].[STYL_Style]";
            return conn.GetDataSet(strSql);
        }

        protected virtual DataSet GetStyleByTheme()
        {
            string strSql = @"
                    SELECT
                          B.[VID]
                          ,B.[Name] 
                          ,B.[Image]
                          ,B.[BigImage]
                          ,C.[StyleID]
                          ,D.[STYL_Code]
                          ,D.[STYL_Name]
                          ,D.[STYL_Price]      
                          ,C.[CreateTime]                   
                      FROM [dbo].[NPaia_Theme] A
                      LEFT JOIN [dbo].[NPaia_View] B ON A.TID=B.ThemeID
                      LEFT JOIN [dbo].[NPaia_View_Style] C ON B.VID = C.ViewID
                      LEFT JOIN [B01_MDM].[STYL_Style] D ON C.StyleID=D.STYL_ID
                      WHERE 1=1 " + m_hzyPageInfo.Where;
            return conn.GetDataSet(strSql);
        }

        protected virtual bool Save(DataTable pDataTable)
        {
            try
            {
                string sid = pDataTable.Rows[0]["sid"].ToString();  //获取参数StyleID
                string viewId = pDataTable.Rows[0]["viewid"].ToString();  //获取参数ViewID
                string styleId = pDataTable.Rows[0]["styleid"].ToString();  //获取参数ViewID

                ArrayList listTable = new ArrayList();
                listTable.Add("NPaia_View_Style");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表NPaia_Style
                string strWhere = string.Empty;

                //创建DataTable，用于传参
                DataTable dtAdd = new DataTable();
                dtAdd.Columns.Add("SID");
                dtAdd.Columns.Add("StyleID");
                dtAdd.Columns.Add("ViewID");
                dtAdd.Columns.Add("CreateUser");
                dtAdd.Columns.Add("CreateTime");
                dtAdd.Columns.Add("UpdateUser");
                dtAdd.Columns.Add("UpdateTime");

                DataRow dr = dtAdd.NewRow();
                //循环DataTabel的列
                for (int i = 0; i < dtAdd.Columns.Count - 4; i++)
                {
                    if (dtAdd.Columns[i].ColumnName == "SID")
                    {
                        continue;
                    }
                    else
                    {
                        dr[i] = pDataTable.Rows[0][dtAdd.Columns[i].ColumnName].ToString();   //对DataTabel中的每列设置值
                    }
                }
                dtAdd.Rows.Add(dr);

                //验证是否存在
                string strSql = @"
                        SELECT  *
                        FROM [dbo].[NPaia_View_Style] WHERE ViewID= '" + viewId + "' AND StyleID='" + styleId + "'";
                int count = conn.GetDataTableRowCount(strSql);
                if (count > 0)
                {
                    throw new Exception("该款式已存在！");
                }

                if (string.IsNullOrEmpty(sid)) //如果为空，说明是插入数据
                {
                    dtAdd.Rows[0]["SID"] = Guid.NewGuid();
                    dtAdd.Rows[0]["CreateTime"] = DateTime.Now; //设置创建时间
                    dtAdd.Rows[0]["CreateUser"] = hzyMessage.User_Name; //设置创建者
                    dtAdd.Rows[0]["UpdateTime"] = DateTime.Now; //设置更新时间
                    dtAdd.Rows[0]["UpdateUser"] = hzyMessage.User_Name; //设置更新者
                    conn.Insert("NPaia_View_Style", dtAdd); //插入数据
                }
                else
                {
                    //更新
                    dtAdd.Columns.Remove("CreateUser");    //删除CreateUser列，更新不需要
                    dtAdd.Columns.Remove("CreateTime");    //删除CreateTime列，更新不需要
                    dtAdd.Columns.Remove("SID");
                    dtAdd.Rows[0]["UpdateTime"] = DateTime.Now;    //将更新时间设为当前时间
                    dtAdd.Rows[0]["UpdateUser"] = hzyMessage.User_Name;    //设置更新者

                    strWhere = " SID = '" + sid + "'";   //设置更新条件
                    conn.Update("NPaia_View_Style", dtAdd, strWhere); //更新数据
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
                string strStyleId = pDataTable.Rows[0]["sid"].ToString();    //获取参数Param_ID

                ArrayList listTable = new ArrayList();
                listTable.Add("NPaia_View_Style");
                conn.BeginTransaction();    //开启事务
                conn.TableLock(listTable);  //锁表NPaia_Style

                string strWhere = " SID = '" + strStyleId + "'";  //创建where语句
                conn.Delete("NPaia_View_Style", strWhere);    //删除参数

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
