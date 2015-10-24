//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Data;
//using System.Text;
//using System.Collections;

//using HZY.COM;
//using HZY.COM.Common;
//using HZY.COM.Common.DBAccess;
//using HZY.COM.WS.DataSets;

///// 类名：Tag_Apply
///// 类说明：对Tag_Apply(吊牌打印申请)的CRUD,为Easyui专用
///// 创建人：刘洪
///// 创建日期：2014-03-11 
///// 修改人：2014-03-17
///// 修改日期：
//namespace HZY.COM.WS.StoreBusinessSystem
//{

//    public class Tag_Apply : HZYLogicBase, ILogicGetData
//    {
//        public Tag_Apply()
//        {
//            this.m_SessionCheck = true;
//        }

//        private Dbconn conn = new Dbconn("HZY_Mat");
//        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
//        DateTime timeNow = DateTime.Now;
//        public DataSet GetData()
//        {
//            try
//            {
//                DataSet ds = new DataSet();
//                DataSet ds_Return = new DataSet();
//                DataTable resultTable = new DataTable();
//                DataSet dsDetail = new DataSet();

//                string strXML = "";

//                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
//                ds = Common.Common.GetDSByExcelXML(strXML);
//                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
//                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CHECKTOTAL")
//                    {
//                        int prad_total = Convert.ToInt32(ds.Tables["list"].Rows[0]["prad_total"]);
//                        string where = m_request.Tables[0].Rows[0]["where"].ToString();

//                        //dateadd(ms,-3,DATEADD(mm, DATEDIFF(m,0,getdate())+1, 0))本月最后一天
//                        //dateadd(dd,-day(getdate())+1,getdate())本月第一天
//                        string strWhere = "1=1 and " + where + "and PRA_RgDt between dateadd(dd,-day(getdate())+1,getdate()) and dateadd(ms,-3,DATEADD(mm, DATEDIFF(m,0,getdate())+1, 0))";

//                        string strSQL = @"
//                             SELECT isnull(sum(PRAD_Total),0) +" + prad_total + @" AS PRAD_Total
//                                   FROM tag.PRAD_TagApplyDetail B
//                             WHERE B.PRA_Guid IN (SELECT A.PRA_Guid FROM tag.PRA_TagApply A        
//                            WHERE  " + strWhere +　")";


//                        string resultTotal = conn.GetDataTableFirstValue(strSQL).ToString();
//                        resultTable.Columns.Add("resultTotal");
//                        resultTable.Rows.Add(new object[] { resultTotal });
//                        ds_Return.Tables.Add(resultTable);
//                    }
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "INSERT")
//                    {
//                        string strXMLDetail = ds.Tables["list"].Rows[0]["detail"].ToString();
//                        dsDetail = Common.Common.GetDSByExcelXML(strXMLDetail);
//                        ds.Tables["list"].Columns.Remove("detail");
//                        ds.Tables["list"].Columns.Add("pra_guid");
//                        ds.Tables["list"].Columns.Add("pra_status");
//                        ds.Tables["list"].Columns.Add("pra_createtime");
//                        dsDetail.Tables["list"].Columns.Add("pra_guid");
//                        dsDetail.Tables["list"].Columns.Add("prad_guid");
                        
//                        System.Guid guid = System.Guid.NewGuid(); //Guid 类型
//                        string praGUID = System.Guid.NewGuid().ToString(); //直接返回字符串类型
//                        ds.Tables["list"].Rows[0]["pra_guid"] = praGUID;
//                        ds.Tables["list"].Rows[0]["pra_status"]= "0";
//                        ds.Tables["list"].Rows[0]["pra_createtime"] = timeNow;
//                        for (int j = 0; j <= dsDetail.Tables["list"].Rows.Count-1; j++)
//                        {
//                            string pradGUID = System.Guid.NewGuid().ToString();
//                            dsDetail.Tables["list"].Rows[j]["prad_guid"] = pradGUID;
//                            dsDetail.Tables["list"].Rows[j]["pra_guid"] = praGUID;
//                        }
                        
//                        bool bResult = false;

//                        conn.LockTableList.Add("Tag.PRA_TagApply");// 锁表
//                        conn.LockTableList.Add("Tag.PRAD_TagApplyDetail");
//                        conn.BeginTransaction(); // 开启事务

//                        bResult = conn.Insert("Tag.PRA_TagApply", ds.Tables["List"]);
//                        bResult = conn.Insert("Tag.PRAD_TagApplyDetail", dsDetail.Tables["List"]);
//                        conn.CommitTransaction();

//                        if (bResult)
//                        {
//                            dt_EditResult.Rows.Add(new object[] { true, "申请成功" });
//                        }
//                        else
//                        {
//                            dt_EditResult.Rows.Add(new object[] { false, "申请失败" });

//                        }
//                        ds_Return.Tables.Add(dt_EditResult);
//                    }
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
//                    {
//                        string strSQL = @"
//                             SELECT
//                                   [pra_guid],
//                                   [pra_depotname],
//                                   [pra_employeename],
//                                   [pra_phone],
//                                   [pra_total],
//                                   [pra_status],
//                                   [pra_remark],
//                                   [pra_picpath],
//                                   case when pra_status='1' then '已处理' else '未处理' end as [pra_statusname],
//                                   CONVERT(varchar(100), [pra_createtime], 23) as [pra_createtime],
//                                   CONVERT(varchar(100), [pra_updatetime], 23) as [pra_updatetime]
//                            FROM   [StroeBusinissSystem].[tag].[PRA_TagApply]    
//                            WHERE  1=1 " + m_hzyPageInfo.Where;

//                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
//                    }
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GSDATA0")//店铺查询吊牌按钮(GS是Get Search的简写)
//                    {
//                        string styleid = ds.Tables["list"].Rows[0]["prad_styleid"].ToString();
//                        string status = ds.Tables["list"].Rows[0]["pra_status"].ToString();
//                        string depotid = ds.Tables["list"].Rows[0]["pra_depotid"].ToString();
//                        string strwhere = @"
//                               EXISTS (SELECT 1 FROM [StroeBusinissSystem].[tag].[PRAD_TagApplyDetail] b WHERE
//                               a.PRA_Guid = b.PRA_Guid AND a.pra_createtime BETWEEN
//                               dateadd(dd,-day(getdate())+1,getdate()) 
//                               AND dateadd(ms,-3,DATEADD(mm, DATEDIFF(m,0,getdate())+1, 0))
//                               AND a.PRA_status =" + status;
//                        if (styleid != "")
//                        {
//                            strwhere = strwhere + " and b.prad_styleid = '" + styleid + "')";
//                        };
//                        if (depotid != "")
//                        {
//                            strwhere = strwhere + " and a.pra_depotid = '" + depotid + "')";
//                        };
//                        if (styleid == "" && depotid == "") {
//                            strwhere = strwhere + ")";
//                        };
//                        var strSQL = @"
//                        SELECT
//                              [pra_guid],
//                              [pra_company],
//                              [pra_channelType],
//                              [pra_depotname],
//                              [pra_employeename],
//                              [pra_phone],
//                              [pra_total],
//                              [pra_status],
//                              [pra_remark],
//                              [pra_picpath],
//                              case when pra_status='1' then '已处理' else '未处理' end as [pra_statusname],
//                              CONVERT(varchar(100), [pra_createtime], 23) as [pra_createtime],
//                              CONVERT(varchar(100), [pra_updatetime], 23) as [pra_updatetime]
//                        FROM   [StroeBusinissSystem].[tag].[PRA_TagApply] a
//                        WHERE " + strwhere;
//                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
//                        }
//                    //初始化combobox下拉数据以FC(first-class)开头。
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "FCCOMPANY")
//                    {
//                        var strSQL = @"
//                        SELECT
//                              DISTINCT([pra_company])
//                        FROM  [StroeBusinissSystem].[tag].[PRA_TagApply]";
//                        ds_Return = conn.GetDataSet(strSQL);
//                    }
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "FCCHANNELTYPE")
//                    {
//                        var strSQL = @"
//                        SELECT
//                              DISTINCT([pra_channeltype])
//                        FROM  [StroeBusinissSystem].[tag].[PRA_TagApply]";
//                        ds_Return = conn.GetDataSet(strSQL);                      
//                    }
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "FCDEPOTNAME")
//                    {
//                        var strSQL = @"
//                        SELECT
//                              DISTINCT [pra_Depotid],[pra_depotname]
//                        FROM  [StroeBusinissSystem].[tag].[PRA_TagApply]";
//                        ds_Return = conn.GetDataSet(strSQL);
//                    }
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "FCGET")
//                    {
//                        string strSQL = @"
//                             SELECT
//                                   [pra_guid],
//                                   [pra_company],
//                                   [pra_channeltype],
//                                   [pra_depotname],
//                                   [pra_employeename],
//                                   [pra_phone],
//                                   [pra_total],
//                                   [pra_status],
//                                   [pra_remark],
//                                   [pra_picpath],
//                                   case when pra_status='1' then '已处理' else '未处理' end as [pra_statusname],
//                                   CONVERT(varchar(100), [pra_createtime], 23) as [pra_createtime],
//                                   CONVERT(varchar(100), [pra_updatetime], 23) as [pra_updatetime]
//                            FROM   [StroeBusinissSystem].[tag].[PRA_TagApply]    
//                            WHERE  1=1 AND [pra_status] = 0 " + m_hzyPageInfo.Where;

//                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
//                    }
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GSDATA1")//吊牌处理查询按钮方法(GS是Get Search的简写)
//                    {
//                        string styleid = ds.Tables["list"].Rows[0]["prad_styleid"].ToString();
//                        string status = ds.Tables["list"].Rows[0]["pra_status"].ToString();
//                        string company = ds.Tables["list"].Rows[0]["pra_company"].ToString();
//                        string channeltype = ds.Tables["list"].Rows[0]["pra_channeltype"].ToString();
//                        string depotid = ds.Tables["list"].Rows[0]["pra_depotid"].ToString();
//                        string strwhere = "1=1";

//                        //下面拼接查询限制条件
//                        if (status != "") {
//                            strwhere = strwhere + " AND a.pra_status = " + status;
//                        }
//                        if (company != "")
//                        {
//                            strwhere = strwhere + " AND a.pra_company = '" + company + "'";
//                        }
//                        if (channeltype !="")
//                        {
//                            strwhere = strwhere + " AND a.pra_channeltype = '" + channeltype + "'";
//                        }
//                        if (depotid != "")
//                        {
//                            strwhere = strwhere + " AND a.pra_depotid = '" + depotid + "'";
//                        }
//                        if (styleid != "")
//                        {
//                            string strwhere1 = @"
//                               AND EXISTS (SELECT 1 FROM [StroeBusinissSystem].[tag].[PRAD_TagApplyDetail] b WHERE
//                               a.PRA_Guid = b.PRA_Guid AND b.PRAD_styleid = '" + styleid + "')";
//                            strwhere = strwhere + strwhere1;
//                        }
                        
//                        var strSQL = @"
//                        SELECT
//                              [pra_guid],
//                              [pra_company],
//                              [pra_channelType],
//                              [pra_depotname],
//                              [pra_employeename],
//                              [pra_phone],
//                              [pra_total],
//                              [pra_status],
//                              [pra_remark],
//                              [pra_picpath],
//                              case when pra_status='1' then '已处理' else '未处理' end as [pra_statusname],
//                              CONVERT(varchar(100), [pra_createtime], 23) as [pra_createtime],
//                              CONVERT(varchar(100), [pra_updatetime], 23) as [pra_updatetime]
//                        FROM   [StroeBusinissSystem].[tag].[PRA_TagApply] a
//                        WHERE " + strwhere;
//                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
//                    } else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "UPDATE")
//                    {
//                        bool bResult = false;
//                            ds.Tables["list"].Columns.Remove("pra_company");
//                            ds.Tables["list"].Columns.Remove("pra_channeltype");
//                            ds.Tables["list"].Columns.Remove("pra_depotname");
//                            ds.Tables["list"].Columns.Remove("pra_employeename");
//                            ds.Tables["list"].Columns.Remove("pra_statusname");
//                            ds.Tables["list"].Columns.Remove("pra_phone");
//                            ds.Tables["list"].Columns.Remove("pra_total");
//                            ds.Tables["list"].Columns.Remove("pra_createtime");
//                            ds.Tables["list"].Columns.Remove("rowindex");

//                            for (int i = 0; i <= ds.Tables["list"].Rows.Count - 1; i++) {
//                                ds.Tables["list"].Rows[i]["pra_updatetime"] = timeNow;
//                                ds.Tables["list"].Rows[i]["pra_status"] = "1";
//                            }
//                            ArrayList listKey = new ArrayList();
//                            listKey.Add("pra_guid");
                            
//                            conn.LockTableList.Add("tag.PRA_TagApply");// 锁表
//                            conn.BeginTransaction(); // 开启事务
//                            bResult = conn.Update("tag.PRA_TagApply", ds.Tables["List"], listKey);
//                            conn.CommitTransaction();
                        
//                            if (bResult)
//                            {
//                                dt_EditResult.Rows.Add(new object[] { true, "成功" });
//                            }
//                            else
//                            {
//                                dt_EditResult.Rows.Add(new object[] { false, "失败" });

//                            }
//                            ds_Return.Tables.Add(dt_EditResult);
//                    }
//                    else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "FCGETDETAIL")
//                    {
//                        string where = m_request.Tables[0].Rows[0]["where"].ToString();
//                        string strWhere = @"
//                                EXISTS(
//                                SELECT * FROM Tag.PRA_TagApply b 
//                                WHERE a.PRA_Guid = b.PRA_Guid AND b." + where + ")";
//                        var strSQL = @"
//                        SELECT
//                              [PRAD_StyleID],
//                              [PRAD_Total]
//                        FROM   [StroeBusinissSystem].[tag].[PRAD_TagApplyDetail] a
//                        WHERE " + strWhere;
//                        ds_Return = conn.GetDataSet(strSQL);
//                    }
                
//                return ds_Return;
//            }
//            catch
//            {
//                conn.RollbackTransaction();
//                throw;
//            }
//        }
//    }
//}
