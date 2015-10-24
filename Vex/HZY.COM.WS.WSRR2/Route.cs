using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using HZY.COM.Common.Base;

/// 类名：Route
/// 类说明：对WSRR路由的CRUD
/// 创建人：马卫清
/// 创建日期：2014-03-26 
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.WSRR2
{

    public class Route : HZYLogicBase, ILogicGetData
    {
        public Route()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("WSRR");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

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
                                    RouteCode,
                                    Mark ,
                                    convert(varchar(30),CreateTime,21) CreateTime ,
                                    CreateUser ,
                                    convert(varchar(30),UpdateTime,21) UpdateTime ,
                                    UpdateUser	
                            FROM    B01_MDM.RT0_Routes 
                            WHERE  1=1  " + m_hzyPageInfo.Where;

                    ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETCOMBOXPROD")
                {

                    string strSQL = @"
                            SELECT      RouteID ,
                                        RouteCode ,
                                        Name 
                            FROM    B01_MDM.RT0_Routes 
                             WHERE  RouteType='正式'";

                    ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETCOMBOXTEST")
                {

                    string strSQL = @"
                            SELECT   RouteID ,
                                    RouteCode ,
                                    Name 
                            FROM    B01_MDM.RT0_Routes 
                            WHERE  RouteType='开发'";

                    ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ALL")
                {

                    string strSQL = @"
                            SELECT   RouteID ,
                                    RouteCode ,
                                    Name,
                                    ServerPath
                            FROM    B01_MDM.RT0_Routes ";

                    ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT")
                {
                    bool bResult = false;
                    string strUsername = this.hzyMessage.User_Name_CN;

                    string strRouteID = ds.Tables["list"].Rows[0]["RouteID"].ToString();
                    string strName = ds.Tables["list"].Rows[0]["Name"].ToString();
                    string strRouteCode = ds.Tables["list"].Rows[0]["RouteCode"].ToString();

                    if (strRouteCode.ToUpper() == "MGR")
                    {
                        throw new Exception("路由代码不能这MGR");
                    }

                    conn.LockTableList.Add("B01_MDM.RT0_Routes");// 锁表
                    conn.BeginTransaction(); // 开启事务
                    conn.HZYMessage = this.hzyMessage;

                    //修改
                    if (strRouteID != "")
                    {
                        //检查数据是否已经存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM B01_MDM.RT0_Routes WHERE RouteID !=@param0 AND Name =@Param1", new string[2] { strRouteID, strName });
                        if (nCodeCount > 0)
                        {
                            throw new Exception("该路由已存在，请检查！");
                        }

                        nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM B01_MDM.RT0_Routes WHERE RouteID !=@param0 AND RouteCode =@Param1", new string[2] { strRouteID, strRouteCode });
                        if (nCodeCount > 0)
                        {
                            throw new Exception("该路由代码已存在，请检查！");
                        }

                        conn.TableKeyList.Add("RouteID");
                        bResult = conn.UpdateByVex("B01_MDM.RT0_Routes", ds.Tables["list"]);
                        conn.CommitTransaction();

                    }
                    else //添加
                    {
                        ds.Tables["list"].Columns.Remove("RouteID");
                        //检查数据是否已经存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM B01_MDM.RT0_Routes WHERE  Name=@Param0", new string[1] { strName });
                        if (nCodeCount > 0)
                        {
                            throw new Exception("该路由已存在，请检查！");
                        }

                        nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM B01_MDM.RT0_Routes WHERE  RouteCode=@Param0", new string[1] { strRouteCode });
                        if (nCodeCount > 0)
                        {
                            throw new Exception("该路由代码已存在，请检查！");
                        }

                        bResult = conn.InsertByVex("B01_MDM.RT0_Routes", ds.Tables["list"]);
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

                    conn.LockTableList.Add("B01_MDM.RT0_Routes");// 锁表
                    conn.LockTableList.Add("B01_MDM.WSR_WSRouteLink");// 锁表
                    conn.BeginTransaction(); // 开启事务
                    conn.HZYMessage = this.hzyMessage;

                    //修改
                    if (strRouteID != "")
                    {
                        string strRouteCode = conn.GetDataTableFirstValue("SELECT RouteCode FROM B01_MDM.RT0_Routes WHERE RouteID=@Param0", new string[] { strRouteID }).ToString();
                        if (strRouteCode == "")
                        {
                            throw new Exception("传入的参数有误！");
                        }

                        //检查数据是否已经存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM B01_MDM.WSR_WSRouteLink WHERE RouteCode =@param0", new string[1] { strRouteCode });
                        if (nCodeCount > 0)
                        {
                            throw new Exception("该路由已经被使用，不能删除！");
                        }

                        conn.TableKeyList.Add("RouteID");
                        bResult = conn.DeleteByVex("B01_MDM.RT0_Routes", ds.Tables["list"]);
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
