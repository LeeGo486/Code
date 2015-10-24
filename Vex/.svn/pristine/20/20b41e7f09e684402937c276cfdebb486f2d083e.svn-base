using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;

/// 类名：Route
/// 类说明：对WSRR路由的CRUD
/// 创建人：马卫清
/// 创建日期：2014-03-26 
/// 修改人：
/// 修改日期：
namespace HZY.COM.WSRR
{

    public class Route : HZYLogicBase, ILogicGetData
    {
        public Route()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("WSRR_Manager");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
                {

                    string strSQL = @"
                            SELECT   RouteID ,
                                    Name ,
                                    ServerPath ,
                                    RouteType ,
                                    dbservercfg,
                                    Mark ,
                                    convert(varchar(30),CreateTime,21) CreateTime ,
                                    CreateUser ,
                                    convert(varchar(30),UpdateTime,21) UpdateTime ,
                                    UpdateUser	
                            FROM    dbo.Route 
                            WHERE  1=1  " + m_hzyPageInfo.Where;

                    ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETCOMBOXPROD")
                {

                    string strSQL = @"
                            SELECT   RouteID ,
                                    Name 
                            FROM    dbo.Route 
                             WHERE  RouteType='正式'";

                    ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETCOMBOXTEST")
                {

                    string strSQL = @"
                            SELECT   RouteID ,
                                    Name 
                            FROM    dbo.Route 
                            WHERE  RouteType='开发'";

                    ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT")
                {
                    bool bResult = false;
                    string strUsername = this.hzyMessage.User_Name_CN;

                    string strRouteID = ds.Tables["list"].Rows[0]["RouteID"].ToString();
                    string strName = ds.Tables["list"].Rows[0]["Name"].ToString();

                    conn.LockTableList.Add("Route");// 锁表
                    conn.BeginTransaction(); // 开启事务
                    conn.HZYMessage = this.hzyMessage;

                    //修改
                    if (strRouteID != "")
                    {
                        //检查数据是否已经存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM Route WHERE RouteID !=@param0 AND Name =@Param1", new string[2] { strRouteID, strName });
                        if (nCodeCount > 0)
                        {
                            throw new Exception("该路由已存在，请检查！");
                        }
                        conn.TableKeyList.Add("RouteID");
                        bResult = conn.UpdateByVex("Route", ds.Tables["list"]);
                        conn.CommitTransaction();

                    }
                    else //添加
                    {
                        ds.Tables["list"].Columns.Remove("RouteID");
                        //检查数据是否已经存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM Route WHERE  Name=@Param0", new string[1] { strName });
                        if (nCodeCount > 0)
                        {
                            throw new Exception("该路由已存在，请检查！");
                        }
                        bResult = conn.InsertByVex("Route", ds.Tables["list"]);
                        conn.CommitTransaction();

                    }

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
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DELETE")
                {
                    bool bResult = false;

                    string strRouteID = ds.Tables["list"].Rows[0]["RouteID"].ToString();

                    conn.LockTableList.Add("Route");// 锁表
                    conn.LockTableList.Add("WSApplayRouteLink");// 锁表
                    conn.BeginTransaction(); // 开启事务
                    conn.HZYMessage = this.hzyMessage;

                    //修改
                    if (strRouteID != "")
                    {
                        //检查数据是否已经存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM WSApplayRouteLink WHERE LinkID !=@param0", new string[1] { strRouteID });
                        if (nCodeCount > 0)
                        {
                            throw new Exception("该路由已经被使用，不能删除！");
                        }

                        conn.TableKeyList.Add("RouteID");
                        bResult = conn.DeleteByVex("Route", ds.Tables["list"]);
                        conn.CommitTransaction();

                    }


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



                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
    }
}
