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
using System.Web;
using System.Data;
using HZY.COM.ST1005A;
using HZY.COM.Common.Base;


/// 类名：Mat_Bill
/// 类说明：对Mat_Bill(报修单+权限控制)的CRUD,为Easyui专用
/// 创建人：郭琦琦 
/// 创建日期：2014-02-24 
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.StoreBusinessSystem
{

    public class Mat_Bill : HZYLogicBase, ILogicGetData
    {
        public Mat_Bill()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn = new Dbconn("HZY_Mat");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();


                //根据用户登录信息取到权限信息
                MDM_System_User_Authorization_GetListBySession_ID cls = new MDM_System_User_Authorization_GetListBySession_ID();
                cls.hzyMessage = this.hzyMessage;
                DataSet dsAUZ = cls.GetData();
                    
                string strComList = "";
                
                if (dsAUZ.Tables[0].Rows.Count > 0)
                {
                    DataRow[] listAuzCom = dsAUZ.Tables[0].Select("Authorization_Name" + " like'%COM%'");
                    for (int k = 0; k < listAuzCom.Length; k++)
                    {
                        if (k > 0)
                        {
                            strComList += ",";
                        }
                        string strCom = listAuzCom[k]["Authorization_Name"].ToString();
                        strComList += strCom.Substring(strCom.Length - 1);
                    }
                }
                else //店铺
                {
                    strComList = hzyMessage.User_Name_CN.Substring(0, 1);
                    if (Convert.ToChar(strComList.ToUpper()) > 'Z' || hzyMessage.User_Name_CN.Length < 8)
                    {
                        strComList = "";
                    }
                    else
                    {
                        strComList = hzyMessage.User_Name_CN.Substring(0, 8);
                    }
                    if (strComList== "")
                    {
                        throw new Exception("你没有权限，请联系管理员！");
                    }
                }
               

                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];


                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    #region GET
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        string strSQL = @"
                                    SELECT * FROM (
                                       SELECT  CASE WHEN LEFT(t1.depotid, 1) = 'N' THEN '纳卉'
                                                     WHEN LEFT(t1.depotid, 1) = 'A' THEN '华中'
                                                     WHEN LEFT(t1.depotid, 1) = 'Z' THEN '郑州'
                                                     WHEN LEFT(t1.depotid, 1) = 'K' THEN '诺珂'
                                                     WHEN LEFT(t1.depotid, 1) = 'D' THEN '贝爱'
                                                     WHEN LEFT(t1.depotid, 1) = 'E' THEN '雅莹'
                                                     WHEN LEFT(t1.depotid, 1) = 'X' THEN '新疆'
                                                     WHEN LEFT(t1.depotid, 1) = 'W' THEN '维姬'
                                                     WHEN LEFT(t1.depotid, 1) = 'J' THEN '卓莱雅'
                                                     WHEN LEFT(t1.depotid, 1) = 'M' THEN '西南'
                                                     WHEN LEFT(t1.depotid, 1) = 'L' THEN '华南'
                                                     WHEN LEFT(t1.depotid, 1) = 'H' THEN '泓雅'
                                                     WHEN LEFT(t1.depotid, 1) = 'G' THEN '雅斓'
                                                     WHEN LEFT(t1.depotid, 1) = 'F' THEN '东北'
                                                END AS 公司 ,
                                                t4.typename 大类名称 ,
                                                t2.name 维修商 ,
                                                t3.parentid ,
                                                t3.typename 小类名称 ,
                                                t2.linkman orglinkman,
                                                t2.tel orgtel,
                                                t1.billid ,
                                                t1.depotid ,
                                                t1.depotName ,
                                                t1.j_form,
                                                t1.typeid ,
                                                t1.content ,
                                                t1.img ,
                                                t1.chk_sure ,
                                                CONVERT(VARCHAR(100), t1.chk_date, 23) AS chk_date ,
                                                t1.chk_name ,
                                                CONVERT(VARCHAR(100), t1.fb_date, 23) AS fb_date ,
                                                t1.fb_name ,
                                                t1.fb_comment ,
                                                t1.fb_content ,
                                                CONVERT(VARCHAR(100), t1.schemaenddate, 23) AS schemaenddate ,
                                                t1.isquality ,
                                                t1.ischangeschema ,
                                                t1.changecause ,
                                                t1.orgid ,
                                                CASE t1.state
                                                  WHEN 0 THEN '未上报'
                                                  WHEN 1 THEN '已上报'
                                                  WHEN 2 THEN '已跟进'
                                                  WHEN 3 THEN '已退回'
                                                  WHEN 4 THEN '施工超期'
                                                  WHEN 5 THEN '完成'
                                                  WHEN 6 THEN '已更改'
                                                  WHEN 7 THEN '处理超期'
                                                END AS state ,
                                                t1.end_crdate ,
                                                CONVERT(VARCHAR(100), t1.enddate, 23) AS enddate ,
                                                t1.endday ,
                                                t1.opinion ,
                                                t1.comment ,
                                                t1.linkman ,
                                                t1.linkTel ,
                                                t1.end_crname ,
                                                t1.Cost_sure ,
                                                t1.Cost_crname ,
                                                t1.Cost_crdate ,
                                                t1.createtime ,
                                                t1.crname ,
                                                t1.updatetime
                                        FROM    [mat].[mat_bill] t1
                                                LEFT JOIN mat.mat_org t2 ON t1.orgid = t2.orgid
                                                LEFT JOIN mat.mat_type t3 ON t1.typeid = t3.typeid
                                                LEFT JOIN mat.mat_type t4 ON t3.parentid = t4.typeid
                                    ) t1
                                    WHERE 1=1 " + m_hzyPageInfo.Where;
                        string strWhereTmp = "AND (t1.depotid LIKE '" + strComList.Replace(",", "%'   OR t1.depotid LIKE '") + "%')";

                        ds_Return = conn.GetDataSetForPageList(strSQL+strWhereTmp, new string[0], m_hzyPageInfo);
                    }
                    #endregion

                    #region INSERT
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                    {


                        if (Convert.ToChar(hzyMessage.User_Name_CN.Substring(0, 1).ToUpper()) > 'Z')
                        {
                            int nAuzCount = dsAUZ.Tables[0].Select("Authorization_Name='MAT_MENU_总部维修跟进' OR Authorization_Name='admin'").Length;

                            if (nAuzCount < 1)
                            {
                                throw new Exception("你没有权限，请联系管理员！");
                            }
                        }
                        DataTable dt_List = ds.Tables["List"];

                        string strDepotid = dt_List.Rows[0]["depotid"].ToString();
                        if (strDepotid == "")
                        {
                            throw new Exception("数据异常，缺少店铺编号，请联系管理员！");
                        }
                        string strDepotid_Sub = strDepotid.Substring(0,1);
                        bool bCom =  strComList.Contains(strDepotid_Sub);
                        if (!bCom)
                        {
                            throw new Exception("你没有权限，请联系管理员！");
                        }

                        bool bResult = false;
                        ArrayList listColumn = new ArrayList();
                        listColumn.Add("depotid");
                        listColumn.Add("depotname");
                        listColumn.Add("typeid");
                        listColumn.Add("content");
                        listColumn.Add("img");
                        listColumn.Add("comment");
                        listColumn.Add("linkman");
                        listColumn.Add("linkTel");
                        listColumn.Add("j_form");


                        dt_List.Columns.Remove("parentid");
                        DataTable dt_Data = new DataTable();

                        for (int k = 0; k < listColumn.Count; k++)
                        {
                            dt_Data.Columns.Add(listColumn[k].ToString());
                        }

                        for (int k = 0; k < dt_List.Rows.Count; k++)
                        {


                            DataRow dr = dt_Data.NewRow();
                            for (int l = 0; l < listColumn.Count; l++)
                            {
                                if (k == 0 && !dt_List.Columns.Contains(listColumn[l].ToString()))
                                {
                                    throw new Exception(listColumn[l].ToString() + "列不能为空");
                                }
                                dr[listColumn[l].ToString()] = dt_List.Rows[k][listColumn[l].ToString()].ToString();

                            }
                            dt_Data.Rows.Add(dr);

                            dt_Data.Columns.Add("crname");
                            dt_Data.Columns.Add("createtime");
                            dt_Data.Columns.Add("state");
                            dt_Data.Rows[0]["crname"] = hzyMessage.User_Name_CN;
                            dt_Data.Rows[0]["state"] = "0";
                        }
                        conn.LockTableList.Add("[mat].[mat_bill]");
                        conn.BeginTransaction();
                        bResult = conn.Insert("[mat].[mat_bill]", dt_Data);
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "保存成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "保存失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);

                    }
                    #endregion

                    #region UPDATE_SUBMIT 上报

                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE_SUBMIT")
                    {
                        if (Convert.ToChar(hzyMessage.User_Name_CN.Substring(0, 1).ToUpper()) > 'Z')
                        {
                            int nAuzCount = dsAUZ.Tables[0].Select("Authorization_Name='MAT_MENU_总部维修跟进' OR Authorization_Name='admin'").Length;

                            if (nAuzCount < 1)
                            {
                                throw new Exception("你没有权限，请联系管理员！");
                            }
                        }
                        DataTable dt_List = ds.Tables["List"];
                        string strBillid = dt_List.Rows[0]["billid"].ToString();
                        string strDepotid = dt_List.Rows[0]["depotid"].ToString();
                        if (strDepotid =="")
                        {
                            throw new Exception("数据异常，缺少店铺编号，请联系管理员！");
                        }
                        string strDepotid_Sub = strDepotid.Substring(0, 1);
                        bool bCom = strComList.Contains(strDepotid_Sub);
                        if (!bCom)
                        {
                            throw new Exception("你没有权限，请联系管理员！");
                        }

                        DateTime timeNow = DateTime.Now;
                        dt_List.Rows[0]["chk_date"] = timeNow;
                        dt_List.Columns.Remove("billid");
                        dt_List.Columns.Remove("depotid");
                        dt_List.Columns.Add("chk_name");
                        dt_List.Rows[0]["chk_name"] = hzyMessage.User_Name_CN;

                        bool bResult = false;
                        conn.LockTableList.Add("[mat].[mat_bill]");
                        conn.BeginTransaction();

                        bResult = conn.Update("[mat].[mat_bill]", dt_List, "billid=" + strBillid);

                        conn.CommitTransaction();



                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "上报成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "上报失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);

                    }
                    #endregion

                    #region REPLY_UPDATE
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "REPLY_UPDATE")
                    {
                        int nAuzCount = dsAUZ.Tables[0].Select("Authorization_Name='MAT_MENU_总部维修处理' OR Authorization_Name='admin'").Length;

                        if (nAuzCount < 1)
                        {
                            throw new Exception("你没有权限，请联系管理员！");
                        }

                        DataTable dt_List = ds.Tables["List"];
                        string strDepotid = dt_List.Rows[0]["depotid"].ToString();
                        if (strDepotid == "")
                        {
                            throw new Exception("数据异常，缺少店铺编号，请联系管理员！");
                        }
                        string strDepotid_Sub = strDepotid.Substring(0, 1);
                        bool bCom = strComList.Contains(strDepotid_Sub);
                        if (!bCom)
                        {
                            throw new Exception("你没有权限，请联系管理员！");
                        }

                        string strBillid = dt_List.Rows[0]["billid"].ToString();
                        DateTime timeNow = DateTime.Now;
                        dt_List.Rows[0]["fb_date"] = timeNow;
                        dt_List.Rows[0]["fb_name"] = hzyMessage.User_Name_CN;


                        string strSchemaenddate = dt_List.Rows[0]["schemaenddate"].ToString();
                        if (strSchemaenddate == "")
                        {
                            dt_List.Columns.Remove("schemaenddate");
                        }

                        dt_List.Columns.Remove("billid");
                        dt_List.Columns.Remove("depotid");

                        bool bResult = false;
                        conn.LockTableList.Add("[mat].[mat_bill]");
                        conn.BeginTransaction();
                        bResult = conn.Update("[mat].[mat_bill]", dt_List, "billid=" + strBillid);
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "单据" + strBillid + "回复成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "回复失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);

                    }
                    #endregion

                    #region CHANGE_UPDATE

                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "CHANGE_UPDATE")
                    {

                        int nAuzCount = dsAUZ.Tables[0].Select("Authorization_Name='MAT_MENU_总部维修处理' OR Authorization_Name='admin'").Length;

                        if (nAuzCount < 1)
                        {
                            throw new Exception("你没有权限，请联系管理员！");
                        }

                        DataTable dt_List = ds.Tables["List"];
                        string strDepotid = dt_List.Rows[0]["depotid"].ToString();
                        if (strDepotid == "")
                        {
                            throw new Exception("数据异常，缺少店铺编号，请联系管理员！");
                        }
                        string strDepotid_Sub = strDepotid.Substring(0, 1);
                        bool bCom = strComList.Contains(strDepotid_Sub);
                        if (!bCom)
                        {
                            throw new Exception("你没有权限，请联系管理员！");
                        }

                        bool bResult = false;
                        conn.LockTableList.Add("[mat].[mat_bill]");
                        conn.LockTableList.Add("[mat].[mat_billsub]");
                        conn.BeginTransaction();

                        DataTable dt_List_for_insert = ds.Tables["List"];
                        DataTable dt_List_for_update = ds.Tables["List"];

                        //insert
                        DataTable dt_List_insert = new DataTable();
                        dt_List_insert.Columns.Add("schemaenddate");
                        dt_List_insert.Columns.Add("billid");
                        dt_List_insert.Columns.Add("changecause");
                        dt_List_insert.Columns.Add("createtime");
                        dt_List_insert.Columns.Add("updatetime");

                        for (int j = 0; j < dt_List_for_insert.Rows.Count; j++)
                        {
                            string strSchemaenddate = dt_List_for_insert.Rows[j]["schemaenddate_change"].ToString();
                            string strBillid_insert = dt_List_for_insert.Rows[j]["billid"].ToString();
                            string strChangecause = dt_List_for_insert.Rows[j]["changecause"].ToString();

                            dt_List_insert.Rows.Add(new object[] { strSchemaenddate, strBillid_insert, strChangecause, "", "" });
                        }
                        bResult = conn.Insert("[mat].[mat_billsub]", dt_List_insert);


                        //update
                        string strBillid = dt_List_for_update.Rows[0]["billid"].ToString();
                        string strSchemaenddate_Update = dt_List_for_update.Rows[0]["schemaenddate_change"].ToString();


                        dt_List_for_update.Columns.Add("schemaenddate");
                        dt_List_for_update.Rows[0]["schemaenddate"] = strSchemaenddate_Update;
                        dt_List_for_update.Columns.Remove("billid");
                        dt_List_for_update.Columns.Remove("schemaenddate_change");
                        dt_List_for_update.Columns.Add("ischangeschema");
                        dt_List_for_update.Rows[0]["ischangeschema"] = "是";
                        dt_List_for_update.Columns.Remove("depotid");




                        bResult = conn.Update("[mat].[mat_bill]", dt_List_for_update, "billid=" + strBillid);

                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "单据" + strBillid + "更改计划成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "更改计划失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);

                    }
                    #endregion

                    #region SAVE_UPDATE
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "SAVE_UPDATE")
                    {


                        if (Convert.ToChar(hzyMessage.User_Name_CN.Substring(0, 1).ToUpper()) > 'Z')
                        {
                            int nAuzCount = dsAUZ.Tables[0].Select("Authorization_Name='MAT_MENU_总部维修跟进' OR Authorization_Name='admin'").Length;

                            if (nAuzCount < 1)
                            {
                                throw new Exception("你没有权限，请联系管理员！");
                            }
                        }
                        DataTable dt_List = ds.Tables["List"];
                        string strDepotid = dt_List.Rows[0]["depotid"].ToString();
                        if (strDepotid == "")
                        {
                            throw new Exception("数据异常，缺少店铺编号，请联系管理员！");
                        }
                        string strDepotid_Sub = strDepotid.Substring(0, 1);
                        bool bCom = strComList.Contains(strDepotid_Sub);
                        if (!bCom)
                        {
                            throw new Exception("你没有权限，请联系管理员！");
                        }

                        string strBillid = dt_List.Rows[0]["billid"].ToString();
                        DateTime timeNow = DateTime.Now;

                        dt_List.Columns.Remove("depotid");
                        dt_List.Columns.Remove("billid");
                        dt_List.Columns.Add("end_crdate");
                        dt_List.Columns.Add("end_crname");
                        dt_List.Rows[0]["end_crdate"] = timeNow;
                        dt_List.Rows[0]["end_crname"] = hzyMessage.User_Name_CN;

                        bool bResult = false;
                        conn.LockTableList.Add("[mat].[mat_bill]");
                        conn.BeginTransaction();


                        bResult = conn.Update("[mat].[mat_bill]", dt_List, "billid=" + strBillid);

                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "单据" + strBillid + "确认完成" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "确认失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);

                    }
                    #endregion

                    #region DELETE
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        if (Convert.ToChar(hzyMessage.User_Name_CN.Substring(0, 1).ToUpper()) >'Z')
                        {
                            int nAuzCount = dsAUZ.Tables[0].Select("Authorization_Name='MAT_MENU_总部维修跟进' OR Authorization_Name='admin'").Length;

                            if (nAuzCount < 1)
                            {
                                throw new Exception("你没有权限，请联系管理员！");
                            }
                        }
                        DataTable dt_List = ds.Tables["List"];

                        string strDepotid = dt_List.Rows[0]["depotid"].ToString();
                        if (strDepotid == "")
                        {
                            throw new Exception("数据异常，缺少店铺编号，请联系管理员！");
                        }
                        string strDepotid_Sub = strDepotid.Substring(0, 1);
                        bool bCom = strComList.Contains(strDepotid_Sub);
                        if (!bCom)
                        {
                            throw new Exception("你没有权限，请联系管理员！");
                        }

                        bool bResult = false;
                        conn.LockTableList.Add("[mat].[mat_bill]");
                        conn.BeginTransaction();


                        string strState = dt_List.Rows[0]["state"].ToString();
                        string strBillid = dt_List.Rows[0]["billid"].ToString();

                        //if (strState != "未上报" && strState != "已上报")
                        //{
                        //    throw new Exception("你删除的数据不属于未上报信息！");
                        //}
                        if (strState != "未上报" && strState != "已上报")
                        {
                            throw new Exception("只能删除未上报或者已上报单据！");
                        }

                        dt_List.Columns.Remove("billid");
                        dt_List.Columns.Remove("depotid");

                        bResult = conn.Delete("[mat].[mat_bill]", "billid=" + strBillid);

                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "单据" + strBillid + "删除成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "单据" + strBillid + "删除失败" });

                        }
                        ds_Return.Tables.Add(dt_EditResult);

                    }
                    #endregion

                    #region INFO_UPDATE
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INFO_UPDATE")
                    {
                        DataTable dt_List = ds.Tables["List"];
                        bool bResult = false;

                        string strlinkman_edit = dt_List.Rows[0]["linkman_edit"].ToString();
                        string strlinktel_edit = dt_List.Rows[0]["linkman_edit"].ToString();
                        string strcomment_edit = dt_List.Rows[0]["linkman_edit"].ToString();


                        dt_List.Columns.Remove("linkman_edit");
                        dt_List.Columns.Remove("linktel_edit");
                        dt_List.Columns.Remove("comment_edit");
                        dt_List.Columns.Add("linkman");
                        dt_List.Rows[0]["linkman"] = strlinkman_edit;
                        dt_List.Columns.Add("linktel");
                        dt_List.Rows[0]["linktel"] = strlinktel_edit;
                        dt_List.Columns.Add("comment");
                        dt_List.Rows[0]["comment"] = strcomment_edit;
                        conn.BeginTransaction();

                        string strBillid = dt_List.Rows[0]["billid"].ToString();
                        dt_List.Columns.Remove("billid");
                        bResult = conn.Update("[mat].[mat_bill]", dt_List, "billid=" + strBillid);
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    #endregion

                    #region RETURE_UPDATE
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "RETURE_UPDATE")
                    {
                        DataTable dt_List = ds.Tables["List"];
                        bool bResult = false;

                        string strorgid_reture = dt_List.Rows[0]["orgid_reture"].ToString();
                        string strisquality_reture = dt_List.Rows[0]["isquality_reture"].ToString();
                        string strfb_content_reture = dt_List.Rows[0]["fb_content_reture"].ToString();
                        string strfb_comment_reture = dt_List.Rows[0]["fb_comment_reture"].ToString();


                        dt_List.Columns.Remove("orgid_reture");
                        dt_List.Columns.Remove("isquality_reture");
                        dt_List.Columns.Remove("fb_content_reture");
                        dt_List.Columns.Remove("fb_comment_reture");
                        dt_List.Columns.Add("orgid");
                        dt_List.Rows[0]["orgid"] = strorgid_reture;
                        dt_List.Columns.Add("isquality");
                        dt_List.Rows[0]["isquality"] = strisquality_reture;
                        dt_List.Columns.Add("fb_content");
                        dt_List.Rows[0]["fb_content"] = strfb_content_reture;
                        dt_List.Columns.Add("fb_comment");
                        dt_List.Rows[0]["fb_comment"] = strfb_comment_reture;


                        conn.BeginTransaction();

                        string strBillid = dt_List.Rows[0]["billid"].ToString();
                        dt_List.Columns.Remove("billid");
                        bResult = conn.Update("[mat].[mat_bill]", dt_List, "billid=" + strBillid);
                        conn.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                        }
                        ds_Return.Tables.Add(dt_EditResult);
                    }
                    #endregion

                    #region RETURE_DETAIL
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "RETURE_DETAIL")
                    {
                        string strSQL = @"
                                    SELECT [billSubid]
                                          ,[billid]
                                          ,[changecause]
                                           ,CONVERT(VARCHAR(100), schemaenddate, 23) AS schemaenddate
                                          ,[createtime]
                                          ,[updatetime]
                                      FROM [mat].[mat_billsub]
                                    WHERE 1=1 " + m_hzyPageInfo.Where;

                        ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
                    }
                    #endregion
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
