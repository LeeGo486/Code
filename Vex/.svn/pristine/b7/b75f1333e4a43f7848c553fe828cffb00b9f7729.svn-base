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

/// 类名：Mat_Type
/// 类说明：对Mat_Type(设备类型)进行操作,为Easyui专用
/// 创建人：刘洪 
/// 创建日期：2014-02-25 
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.StoreBusinessSystem
{

    public class Mat_Type : HZYLogicBase, ILogicGetData
    {
        public Mat_Type() 
        {
            this.m_SessionCheck = true;
        }
        private Dbconn conn = new Dbconn("HZY_Mat");
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
                string strOPTYPE = dt_OPTYPE.Rows[0][0].ToString().ToUpper();

                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (strOPTYPE == "GET")
                    {
                        
                        string strSQL = @"
                             SELECT 
                                   [typeid],
                                   [typename],
                                   [parentid],
                                   [chk_sure],
                                   case when chk_sure='1' then '是' else '否' end as chk_sureName,
                                   CONVERT(varchar(100), [chk_date], 23) as [chk_date],
                                   [chk_name],
                                   CONVERT(varchar(100), [createtime], 23) as [createtime],
                                   [crname],
                                   CONVERT(varchar(100), [updatetime], 23) as [updatetime],
                                   [comment]
                            FROM   [mat].[mat_Type]    
                            WHERE  1=1 " + m_hzyPageInfo.Where;

                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                    }
                    //新增
                    else if (strOPTYPE == "INSERT")
                    {
                        bool bResult = false;
                        string strUsername = this.hzyMessage.User_Name_CN;
                        string strTypename = ds.Tables["list"].Rows[0]["typename"].ToString();
                       
                        ds.Tables["list"].Rows[0]["crname"] = strUsername;
                        //检查实体表中该种类是否存在
                        int nCodeCount = conn.GetDataTableRowCount("SELECT 1 AS A FROM mat.mat_type WHERE typename = '" + strTypename + "'");

                        if (nCodeCount != 0)
                        {
                            throw new Exception("该种类已存在，请检查！");
                        }

                        conn.LockTableList.Add("mat.mat_type");// 锁表
                        conn.BeginTransaction(); // 开启事务

                        bResult = conn.Insert("mat.mat_type", ds.Tables["List"]);
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "新增成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "新增失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    else if (strOPTYPE == "DELETE")
                    {
                        bool bResult = false;
                        string strType = ds.Tables["list"].Rows[0]["type"].ToString();
                        string strTypeid = ds.Tables["list"].Rows[0]["typeid"].ToString();
                        string strChk_Sure = ds.Tables["list"].Rows[0]["chk_sure"].ToString();

                        //检查实体表中该种类是否存在
                        if (strType == "BigDel")
                        {
                            conn.LockTableList.Add("mat.mat_type");// 锁表
                            conn.BeginTransaction(); // 开启事务

                            int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM mat.mat_type WHERE typeid = '" + strTypeid + "'");
                            if (nCodeCount == 0)
                            {
                                throw new Exception("种类不存在，请检查！");
                            };
                            //判断Bill表中是否已经使用Type中的数据，如果使用不能删除。
                            int strCheck_typeid = conn.GetDataTableRowCount("SELECT typeid FROM mat.mat_bill WHERE typeid IN (SELECT typeid FROM mat.mat_type WHERE parentid = " + strTypeid + ")");
                            if (strCheck_typeid != 0)
                            {
                                throw new Exception("业务数据已使用该种类，无法删除！");
                            };   
                            
                            //检查实体表中该类是否审核,优先判断后台，然后再判断前台值与后台是否匹配
                            string strChk_SureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_type WHERE typeid = '" + strTypeid + "'").ToString();
                            if (strChk_SureOld == "0")
                            {
                                if (strChk_Sure != strChk_SureOld)
                                {
                                    throw new Exception("种类状态异常，请刷新！");
                                }
                            }
                            else
                            {
                                throw new Exception("种类状态异常，请刷新！");
                            }

                            bResult = conn.Delete("mat.mat_type", "typeid=" + strTypeid);
                            bResult = conn.Delete("mat.mat_type", "parentid=" + strTypeid);
                            conn.CommitTransaction();
                        }
                        else if (strType == "SmallDel") {
                            conn.LockTableList.Add("mat.mat_type");// 锁表
                            conn.BeginTransaction(); // 开启事务

                            int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM mat.mat_type WHERE typeid = '" + strTypeid + "'");
                            if (nCodeCount == 0)
                            {
                                throw new Exception("种类不存在，请检查！");
                            }
                            //判断Bill表中是否已经使用Type中的数据，如果使用不能删除。
                            int strCheck_typeid = conn.GetDataTableRowCount("SELECT * FROM mat.mat_bill WHERE typeid = " + strTypeid );
                            if (strCheck_typeid != 0)
                            {
                                throw new Exception("业务数据已使用该种类，无法删除！");
                            }; 

                            //检查实体表中该类是否审核,优先判断后台，然后再判断前台值与后台是否匹配
                            string strChk_SureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_type WHERE typeid = '" + strTypeid + "'").ToString();
                            if (strChk_SureOld == "0")
                            {
                                if (strChk_Sure != strChk_SureOld)
                                {
                                    throw new Exception("种类状态异常，请刷新！");
                                }
                            }
                            else
                            {
                                throw new Exception("种类状态异常，请刷新！");
                            }

                            bResult = conn.Delete("mat.mat_type", "typeid=" + strTypeid);
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
                    else if (strOPTYPE == "UPDATE")
                    {
                        bool bResult = false;
                        string strTypeid = ds.Tables["list"].Rows[0]["typeid"].ToString();
                        string strChk_Sure = ds.Tables["list"].Rows[0]["chk_sure"].ToString();
                        string strType = ds.Tables["list"].Rows[0]["type"].ToString();
                        string strUsername = hzyMessage.User_Name_CN;
                        ds.Tables["list"].Rows[0]["chk_date"] = timeNow;
                        ds.Tables["list"].Rows[0]["chk_name"] = strUsername;

                        //判断UPDATE的状态类型
                        //审核 当type="yes"时代表审核,type="no"时代表反审核
                        if (strType == "yes")
                        {
                            //检查种类是否存在
                            int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM mat.mat_type WHERE typeid = '" + strTypeid + "'");
                            //检查前后台状态,优先判断后台状态,然后判断前台与后台状态是否一致.
                            if (nCodeCount == 0)
                            {
                                throw new Exception("该种类不存在，请检查！");
                            }

                            //改造表格
                            ds.Tables["list"].Columns.Remove("typeid"); //删除无需更新的列
                            ds.Tables["list"].Columns.Remove("type");
                            ds.Tables["list"].Rows[0]["chk_sure"] = 1;
                            ds.Tables["list"].Rows[0]["chk_name"] = strUsername;


                            conn.LockTableList.Add("mat.mat_type");// 锁表
                            conn.BeginTransaction(); // 开启事务

                            string strChk_SureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_type WHERE typeid = '" + strTypeid + "'").ToString();

                            if (strChk_SureOld == "0")
                            {
                                if (strChk_Sure != strChk_SureOld)
                                {
                                    throw new Exception("种类状态异常，请刷新！");
                                }
                            }
                            else
                            {
                                throw new Exception("种类状态异常，请刷新！");
                            }

                            bResult = conn.Update("mat.mat_type", ds.Tables["List"], "typeid=" + strTypeid);
                            bResult = conn.Update("mat.mat_type", ds.Tables["List"], "parentid=" + strTypeid);

                            conn.CommitTransaction();
                            if (bResult)
                            {
                                dt_EditResult.Rows.Add(new object[] { true, "审核成功" });
                            }
                            else
                            {
                                dt_EditResult.Rows.Add(new object[] { false, "审核失败" });
                            }
                            ds_Return.Tables.Add(dt_EditResult);
                        }
                        else if (strType == "no")
                        {
                            //检查种类是否存在
                            int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM mat.mat_type WHERE typeid = '" + strTypeid + "'");
                            if (nCodeCount == 0)
                            {
                                throw new Exception("该种类不存在，请检查！");
                            }

                            //改造表格
                            ds.Tables["list"].Columns.Remove("typeid"); //删除无需更新的列
                            ds.Tables["list"].Columns.Remove("type");
                            ds.Tables["list"].Rows[0]["chk_sure"] = 0;
                            ds.Tables["list"].Rows[0]["chk_name"] = strUsername;

                            conn.LockTableList.Add("mat.mat_type");// 锁表
                            conn.BeginTransaction(); // 开启事务

                            string strChk_SureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_type WHERE typeid = '" + strTypeid + "'").ToString();
                            if (strChk_SureOld == "1")
                            {
                                if (strChk_Sure != strChk_SureOld)
                                {
                                    throw new Exception("种类状态异常，请刷新！");
                                }
                            }
                            else
                            {
                                throw new Exception("种类状态异常，请刷新！");
                            }

                            bResult = conn.Update("mat.mat_type", ds.Tables["List"], "typeid=" + strTypeid);
                            bResult = conn.Update("mat.mat_type", ds.Tables["List"], "parentid=" + strTypeid);
                            conn.CommitTransaction();

                            if (bResult)
                            {
                                dt_EditResult.Rows.Add(new object[] { true, "反审核成功" });
                            }
                            else
                            {
                                dt_EditResult.Rows.Add(new object[] { false, "反审核失败" });
                            }
                            ds_Return.Tables.Add(dt_EditResult);

                        }
                        else if (strType == "data") //如果type是type则代表为更新品类数据
                        {
                            string strTypename = ds.Tables["list"].Rows[0]["typename"].ToString();
                            //检查品类是否存在
                            int nCodeCount = conn.GetDataTableRowCount("SELECT * FROM mat.mat_type WHERE typeid != '" + strTypeid + "' AND typename = '" + strTypename + "'");
                            //检查前后台状态,优先判断后台状态,然后判断前台与后台状态是否一致.
                            if (nCodeCount != 0)
                            {
                                throw new Exception("该品类已存在，请检查！");
                            }

                            //改造表格
                            ds.Tables["list"].Columns.Remove("typeid"); //删除无需更新的列
                            ds.Tables["list"].Columns.Remove("type");
                            ds.Tables["list"].Columns.Remove("chk_date");
                            ds.Tables["list"].Columns.Remove("chk_name");
                            ds.Tables["list"].Columns.Remove("chk_sure");
                            ds.Tables["list"].Columns.Remove("parentid");
                            conn.LockTableList.Add("mat.mat_type");// 锁表
                            conn.BeginTransaction(); // 开启事务

                            string strChk_SureOld = conn.GetDataTableFirstValue("SELECT chk_sure FROM mat.mat_type WHERE typeid = '" + strTypeid + "'").ToString();

                            if (strChk_SureOld == "1")
                            {
                                throw new Exception("种类状态异常，请刷新！");
                            }

                            bResult = conn.Update("mat.mat_type", ds.Tables["List"], "typeid=" + strTypeid);
                            conn.CommitTransaction();
 
                            if (bResult)
                            {
                                dt_EditResult.Rows.Add(new object[] { true, "更新成功" });
                            }
                            else
                            {
                                dt_EditResult.Rows.Add(new object[] { false, "更新失败" });
                            }
                            ds_Return.Tables.Add(dt_EditResult);
                        }
                    }
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
