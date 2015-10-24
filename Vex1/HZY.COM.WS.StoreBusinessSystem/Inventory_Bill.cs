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
using HZY.COM.ST1005A;
using HZY.COM.Common.Base;


/// 类名：Inventory_Bill
/// 类说明：对Inventory_Bill盘点差异管控
/// 创建人：郭琦琦 
/// 创建日期：2014-03-07
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.StoreBusinessSystem
{
    public class Inventory_Bill : HZYLogicBase, ILogicGetData
    {
        public Inventory_Bill()
        {
            this.m_SessionCheck = true;
        }

        private Dbconn conn_GP = new Dbconn("F22GP");
        private Dbconn conn_Inventory = new Dbconn("HZY_Mat");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataSet ds_ReturnGP = new DataSet();
                DataSet ds_ReturnInventory = new DataSet();
                string StrUser_Name = hzyMessage.User_Name;


                //根据用户登录信息取到权限信息
                MDM_System_User_Authorization_GetListBySession_ID cls = new MDM_System_User_Authorization_GetListBySession_ID();
                cls.hzyMessage = this.hzyMessage;
                DataSet dsAUZ = cls.GetData();

                string strComList = "";

                if (dsAUZ.Tables[0].Rows.Count < 1)
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


                    if (strComList == "")
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
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETINVENTORY")
                    {
                        string strSQL_GP = @"
                                            SELECT  
                                                    '' Inventory_Diff_ID,
                                                    a.inventoryid ,
                                                    a.depotid ,
                                                    b.d_dq ,
                                                    b.d_name ,
                                                    a.zcnums,
                                                    a.zcsums,
                                                    CONVERT(VARCHAR(100), a.setdate, 21) AS setdate,
                                                    CONVERT(VARCHAR(100), a.sure_date, 21) AS sure_date,
                                                    '未申请' as state,
                                                        ''as Return_Sums,
                                                    '' as updatetime
                                            FROM    d_Inventory a
                                                    INNER JOIN j_depot b ON a.depotid = b.depotid
                                                     " + m_hzyPageInfo.Where;
                        string strWhereTmp = "AND (a.depotid LIKE '" + strComList.Replace(",", "%'   OR a.depotid LIKE '") + "%')";
                        ds_ReturnGP = conn_GP.GetDataSet(strSQL_GP + strWhereTmp);


                        string strSQL_Inventory = @"
                                            SELECT   
                                                    [Inventory_Diff_ID]
                                                    ,[Inventoryid]
                                                    ,[Depotid]
                                                    ,[Depotname]
                                                    ,[AreaName]
                                                    ,[Nums]
                                                    ,[Sums]
                                                    ,[Return_Sums],
                                                     CONVERT(VARCHAR(100), Setdate, 21) AS Setdate,
                                                     CONVERT(VARCHAR(100), sure_date, 21) AS sure_date
                                                    ,[sure_date]
                                                    ,[State]
                                                    ,[CreateTime]
                                                    ,[UpdateTime]
                                                    ,[Timestamps]
                                            FROM    [inventory].[Inventory_Diff]
                                            WHERE   Inventory_Diff_ID IN (
                                                    SELECT  Inventory_Diff_ID
                                                    FROM    ( SELECT    ROW_NUMBER() OVER ( PARTITION BY Inventoryid ORDER BY CreateTime DESC ) AS a ,
                                                                        Inventory_Diff_ID
                                                                FROM      [inventory].[Inventory_Diff]
                                                            ) f
                                                    WHERE   a = 1 ) 
                                                    " + m_hzyPageInfo.Where;
                        ds_ReturnInventory = conn_Inventory.GetDataSet(strSQL_Inventory);

                        for (int g = 0; g < ds_ReturnInventory.Tables[0].Rows.Count; g++)
                        {
                            string strState = ds_ReturnInventory.Tables[0].Rows[g]["State"].ToString();
                            string strInventoryid = ds_ReturnInventory.Tables[0].Rows[g]["Inventoryid"].ToString();
                            string strReturn_sums = ds_ReturnInventory.Tables[0].Rows[g]["Return_Sums"].ToString();

                            string strInventory_Diff_ID = ds_ReturnInventory.Tables[0].Rows[g]["Inventory_Diff_ID"].ToString();
                            string strNums = ds_ReturnInventory.Tables[0].Rows[g]["Nums"].ToString();
                            string strSums = ds_ReturnInventory.Tables[0].Rows[g]["Sums"].ToString();
                            string strUpdatedate = ds_ReturnInventory.Tables[0].Rows[g]["updatetime"].ToString();

                            DataRow[] drGP = ds_ReturnGP.Tables[0].Select("inventoryid = " + "'" + strInventoryid + "'");

                            if (drGP.Length == 0)
                            {
                                //throw new Exception("没有查询到该店铺盘亏数据！");
                            }
                            else
                            {
                                drGP[0]["return_sums"] = strReturn_sums;
                                drGP[0]["state"] = strState;
                                drGP[0]["inventory_diff_id"] = strInventory_Diff_ID;
                                drGP[0]["zcnums"] = strNums;
                                drGP[0]["zcsums"] = strSums;
                                drGP[0]["updatetime"] = strUpdatedate;
                            }

                        }
                    }
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETSPINFO")
                    {
                        string strSQL_SP = @"
                                            SELECT  *
                                                    FROM    ( SELECT    ROW_NUMBER() OVER ( PARTITION BY t2.Inventoryid ORDER BY t2.CreateTime DESC ) AS a ,
                                                                        t1.Inventory_Diff_ID ,
                                                                        t1.Inventoryid ,
                                                                        t1.Depotid ,
                                                                        t1.Depotname ,
                                                                        t1.AreaName ,
                                                                        t1.Nums ,
                                                                        t1.Sums ,
                                                                        t1.Return_Sums ,
                                                                        CONVERT(VARCHAR(100), t1.Setdate, 23) AS Setdate,
                                                                        CONVERT(VARCHAR(100), t1.sure_date, 23) AS sure_date,
                                                                        t1.State ,
                                                                        t1.Content ,
                                                                        CONVERT(VARCHAR(100), t2.Amountreceived, 23) AS Amountreceived,
                                                                        CONVERT(VARCHAR(100), t2.Amount_Of_Remittance, 23) AS Amount_Of_Remittance,
																		t2.Serialnumber,
																		t2.Method,
                                                                        CONVERT(VARCHAR(100), t2.Received_Time, 23) AS Received_Time,
                                                                        t2.Img,
                                                                        t2.Filepath,
                                                                        t2.Bankoutlets,
                                                                        CONVERT(VARCHAR(100), t2.Remittance_Time, 23) AS Remittance_Time,
                                                                        t2.CreateTime ,
                                                                        t2.CreateUser ,
                                                                        t2.UpdateTime ,
                                                                        t2.UpdateUser ,
                                                                        t2.timestamps
                                                                FROM      [inventory].[Inventory_Diff] t1
                                                                        LEFT JOIN [inventory].[Inventory_Diff_State] t2 ON t2.Inventory_Diff_ID = t1.Inventory_Diff_ID
                                                                WHERE     EXISTS ( SELECT 1
                                                                                    FROM   [inventory].[Inventort_Authority] t3
                                                                                    WHERE  ( Branch_POS = @param0
                                                                                            OR Financial_POS = @param0
                                                                                            OR General_POS = @param0
                                                                                        )
                                                                                        AND t1.AreaName = t3.AreaName
                                                                                        AND t3.Store_prefix = LEFT([Depotid], 1) )
                                                            ) t4
                                                    WHERE   a = 1
                                                     " + m_hzyPageInfo.Where;
                        ds_ReturnGP = conn_Inventory.GetDataSet(strSQL_SP, new string[1] { StrUser_Name });
                    }

                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                    {
                        bool bResult = false;
                        conn_Inventory.LockTableList.Add("[inventory].[Inventory_Diff]");
                        conn_Inventory.LockTableList.Add("[inventory].[Inventory_Diff_State]");
                        string strGuid = System.Guid.NewGuid().ToString();
                        string strInventory_Diff_ID = ds.Tables["list"].Rows[0]["inventory_diff_id"].ToString();
                        string strstate = ds.Tables["list"].Rows[0]["state"].ToString();


                        //小翅膀提醒参数抽取
                        string pstrDepotname = ds.Tables["list"].Rows[0]["depotname"].ToString();
                        string pstrUser_Name = GetUserName(hzyMessage.User_Name_CN);
                        string pstrDepotid = ds.Tables["list"].Rows[0]["depotid"].ToString();
                        string pstrAreaName = ds.Tables["list"].Rows[0]["areaname"].ToString();
                        string pstrInventoryID = ds.Tables["list"].Rows[0]["inventoryid"].ToString();
                        string pstrState = ds.Tables["list"].Rows[0]["state"].ToString();


                        DataTable dt_Inventory_Diff = ds.Tables["list"].Copy();
                        DataTable dt_Inventory_Diff_State = ds.Tables["list"].Copy();

                        DateTime timeNow = DateTime.Now;

                        dt_Inventory_Diff.Columns.Add("CreateTime");
                        dt_Inventory_Diff.Rows[0]["CreateTime"] = timeNow;

                        dt_Inventory_Diff.Columns.Add("UpdateTime");
                        dt_Inventory_Diff.Rows[0]["UpdateTime"] = timeNow;

                        dt_Inventory_Diff.Columns.Remove("filepath");
                        dt_Inventory_Diff.Rows[0]["Inventory_Diff_ID"] = strGuid;

                        dt_Inventory_Diff_State.Columns.Add("CreateTime");
                        dt_Inventory_Diff_State.Rows[0]["CreateTime"] = timeNow;

                        dt_Inventory_Diff_State.Columns.Add("UpdateTime");
                        dt_Inventory_Diff_State.Rows[0]["UpdateTime"] = timeNow;

                        dt_Inventory_Diff_State.Rows[0]["Inventory_Diff_ID"] = strGuid;
                        dt_Inventory_Diff_State.Columns.Add("CreateUser");
                        dt_Inventory_Diff_State.Columns.Add("UpdateUser");
                        dt_Inventory_Diff_State.Rows[0]["UpdateUser"] = GetUserName(hzyMessage.User_Name_CN);
                        dt_Inventory_Diff_State.Rows[0]["CreateUser"] = GetUserName(hzyMessage.User_Name_CN);
                        dt_Inventory_Diff_State.Columns.Remove("setdate");
                        dt_Inventory_Diff_State.Columns.Remove("depotid");
                        dt_Inventory_Diff_State.Columns.Remove("return_sums");
                        dt_Inventory_Diff_State.Columns.Remove("areaname");
                        dt_Inventory_Diff_State.Columns.Remove("depotname");
                        dt_Inventory_Diff_State.Columns.Remove("nums");
                        dt_Inventory_Diff_State.Columns.Remove("sure_date");
                        dt_Inventory_Diff_State.Columns.Remove("sums");

                        conn_Inventory.BeginTransaction();


                        if (strstate == "待财务汇款确认")
                        {
                            DateTime timeNow1 = DateTime.Now;
                            dt_Inventory_Diff.Columns.Add("UpdateTime");
                            dt_Inventory_Diff.Rows[0]["UpdateTime"] = timeNow1;
                            dt_Inventory_Diff.Columns.Remove("setdate");
                            dt_Inventory_Diff.Columns.Remove("createtime");
                            dt_Inventory_Diff.Columns.Remove("depotid");
                            dt_Inventory_Diff.Columns.Remove("return_sums");
                            dt_Inventory_Diff.Columns.Remove("areaname");
                            dt_Inventory_Diff.Columns.Remove("depotname");
                            dt_Inventory_Diff.Columns.Remove("nums");
                            dt_Inventory_Diff.Columns.Remove("sure_date");
                            dt_Inventory_Diff.Columns.Remove("sums");
                            dt_Inventory_Diff.Columns.Remove("content");
                            dt_Inventory_Diff.Columns.Remove("inventory_diff_id");
                            dt_Inventory_Diff.Columns.Remove("Inventoryid");
                            bResult = conn_Inventory.Update("[inventory].[Inventory_Diff]", dt_Inventory_Diff, "inventory_diff_id=" + "'" + strInventory_Diff_ID + "'");
                        }
                        else
                        {
                            bResult = conn_Inventory.Insert("[inventory].[Inventory_Diff]", dt_Inventory_Diff);
                            bResult = conn_Inventory.Insert("[inventory].[Inventory_Diff_State]", dt_Inventory_Diff_State);
                        }

                        AM_Message_Send.SendMessage_Submit_inventory(pstrDepotname, pstrUser_Name, pstrDepotid, pstrAreaName, pstrInventoryID, pstrState);

                        conn_Inventory.CommitTransaction();



                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

                        }
                        ds_ReturnGP.Tables.Add(dt_EditResult);
                    }
                    //分公司，销售总部提交
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERTBRANCH")
                    {
                        bool bResult = false;
                        conn_Inventory.LockTableList.Add("[inventory].[Inventory_Diff]");
                        conn_Inventory.LockTableList.Add("[inventory].[Inventory_Diff_State]");
                        //string strGuid = System.Guid.NewGuid().ToString();


                        //更新主表（通过GUID，修改状态和修改时间)
                        DataTable dt_Inventory_Diff = ds.Tables["list"].Copy();
                        string strInventory_Diff_ID = ds.Tables["list"].Rows[0]["inventory_diff_id"].ToString();
                        //小翅膀提醒参数抽取
                        string pstrDepotname = ds.Tables["list"].Rows[0]["depotname"].ToString();
                        string pstrUser_Name = GetUserName(hzyMessage.User_Name_CN);
                        string pstrDepotid = ds.Tables["list"].Rows[0]["depotid"].ToString();
                        string pstrAreaName = ds.Tables["list"].Rows[0]["areaname"].ToString();
                        string pstrInventoryID = ds.Tables["list"].Rows[0]["inventoryid"].ToString();
                        string pstrState = ds.Tables["list"].Rows[0]["state"].ToString();




                        DateTime timeNow = DateTime.Now;
                        dt_Inventory_Diff.Columns.Add("UpdateTime");
                        dt_Inventory_Diff.Rows[0]["UpdateTime"] = timeNow;
                        dt_Inventory_Diff.Columns.Remove("setdate");
                        dt_Inventory_Diff.Columns.Remove("depotid");
                        dt_Inventory_Diff.Columns.Remove("return_sums");
                        dt_Inventory_Diff.Columns.Remove("areaname");
                        dt_Inventory_Diff.Columns.Remove("depotname");
                        dt_Inventory_Diff.Columns.Remove("nums");
                        dt_Inventory_Diff.Columns.Remove("sure_date");
                        dt_Inventory_Diff.Columns.Remove("sums");
                        dt_Inventory_Diff.Columns.Remove("content");
                        dt_Inventory_Diff.Columns.Remove("inventory_diff_id");
                        //dt_Inventory_Diff.Columns.Remove("Inventoryid");
                        dt_Inventory_Diff.Columns.Remove("filepath");

                        DataTable dt_Inventory_Diff_State = ds.Tables["list"].Copy();
                        dt_Inventory_Diff_State.Columns.Add("CreateTime");
                        dt_Inventory_Diff_State.Rows[0]["CreateTime"] = timeNow;

                        dt_Inventory_Diff_State.Columns.Add("UpdateTime");
                        dt_Inventory_Diff_State.Rows[0]["UpdateTime"] = timeNow;

                        dt_Inventory_Diff_State.Columns.Add("CreateUser");
                        dt_Inventory_Diff_State.Columns.Add("UpdateUser");
                        dt_Inventory_Diff_State.Rows[0]["UpdateUser"] = GetUserName(hzyMessage.User_Name_CN);
                        dt_Inventory_Diff_State.Rows[0]["CreateUser"] = GetUserName(hzyMessage.User_Name_CN);
                        dt_Inventory_Diff_State.Columns.Remove("setdate");
                        dt_Inventory_Diff_State.Columns.Remove("depotid");
                        dt_Inventory_Diff_State.Columns.Remove("return_sums");
                        dt_Inventory_Diff_State.Columns.Remove("areaname");
                        dt_Inventory_Diff_State.Columns.Remove("depotname");
                        dt_Inventory_Diff_State.Columns.Remove("nums");
                        dt_Inventory_Diff_State.Columns.Remove("sure_date");
                        dt_Inventory_Diff_State.Columns.Remove("sums");

                        conn_Inventory.BeginTransaction();

                        conn_Inventory.TableKeyList.Clear();
                        conn_Inventory.TableKeyList.Add("inventoryid");
                        bResult = conn_Inventory.Update("[inventory].[Inventory_Diff]", dt_Inventory_Diff, conn_Inventory.TableKeyList);
                        bResult = conn_Inventory.Insert("[inventory].[Inventory_Diff_State]", dt_Inventory_Diff_State);

                        AM_Message_Send.SendMessage_Submit_inventory(pstrDepotname, pstrUser_Name, pstrDepotid, pstrAreaName, pstrInventoryID, pstrState);

                        conn_Inventory.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

                        }
                        ds_ReturnGP.Tables.Add(dt_EditResult);
                    }

                    //店铺汇款
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERTREMITTANCE")
                    {
                        bool bResult = false;
                        conn_Inventory.LockTableList.Add("[inventory].[Inventory_Diff]");
                        conn_Inventory.LockTableList.Add("[inventory].[Inventory_Diff_State]");

                        //更新主表（通过GUID，修改状态和修改时间)
                        DataTable dt_Inventory_Diff = ds.Tables["list"].Copy();
                        DateTime timeNow = DateTime.Now;
                        //小翅膀提醒参数抽取
                        string pstrDepotname = ds.Tables["list"].Rows[0]["depotname"].ToString();
                        string pstrUser_Name = GetUserName(hzyMessage.User_Name_CN);
                        string pstrDepotid = ds.Tables["list"].Rows[0]["depotid"].ToString();
                        string pstrAreaName = ds.Tables["list"].Rows[0]["areaname"].ToString();
                        string pstrInventoryID = ds.Tables["list"].Rows[0]["inventoryid"].ToString();
                        string pstrState = ds.Tables["list"].Rows[0]["state"].ToString();
                        string strInventory_Diff_ID = ds.Tables["list"].Rows[0]["inventory_diff_id"].ToString();
                        dt_Inventory_Diff.Columns.Add("UpdateTime");
                        dt_Inventory_Diff.Rows[0]["UpdateTime"] = timeNow;

                        dt_Inventory_Diff.Columns.Remove("setdate");
                        dt_Inventory_Diff.Columns.Remove("depotid");
                        dt_Inventory_Diff.Columns.Remove("return_sums");
                        dt_Inventory_Diff.Columns.Remove("areaname");
                        dt_Inventory_Diff.Columns.Remove("depotname");
                        dt_Inventory_Diff.Columns.Remove("nums");
                        dt_Inventory_Diff.Columns.Remove("sure_date");
                        dt_Inventory_Diff.Columns.Remove("sums");
                        dt_Inventory_Diff.Columns.Remove("inventory_diff_id");
                        dt_Inventory_Diff.Columns.Remove("method");
                        //dt_Inventory_Diff.Columns.Remove("inventoryid");
                        dt_Inventory_Diff.Columns.Remove("serialnumber");
                        dt_Inventory_Diff.Columns.Remove("amount_of_remittance");
                        dt_Inventory_Diff.Columns.Remove("img");
                        dt_Inventory_Diff.Columns.Remove("bankoutlets");
                        dt_Inventory_Diff.Columns.Remove("remittance_time");


                        DataTable dt_Inventory_Diff_State = ds.Tables["list"].Copy();
                        dt_Inventory_Diff_State.Columns.Add("CreateTime");
                        dt_Inventory_Diff_State.Rows[0]["CreateTime"] = timeNow;

                        dt_Inventory_Diff_State.Columns.Add("UpdateTime");
                        dt_Inventory_Diff_State.Rows[0]["UpdateTime"] = timeNow;

                        dt_Inventory_Diff_State.Columns.Add("CreateUser");
                        dt_Inventory_Diff_State.Columns.Add("UpdateUser");
                        dt_Inventory_Diff_State.Rows[0]["UpdateUser"] = GetUserName(hzyMessage.User_Name_CN);
                        dt_Inventory_Diff_State.Rows[0]["CreateUser"] = GetUserName(hzyMessage.User_Name_CN);
                        dt_Inventory_Diff_State.Columns.Remove("setdate");
                        dt_Inventory_Diff_State.Columns.Remove("depotid");
                        dt_Inventory_Diff_State.Columns.Remove("return_sums");
                        dt_Inventory_Diff_State.Columns.Remove("areaname");
                        dt_Inventory_Diff_State.Columns.Remove("depotname");
                        dt_Inventory_Diff_State.Columns.Remove("nums");
                        dt_Inventory_Diff_State.Columns.Remove("sure_date");
                        dt_Inventory_Diff_State.Columns.Remove("sums");
                        //return new DataSet();

                        conn_Inventory.BeginTransaction();

                        conn_Inventory.TableKeyList.Clear();
                        conn_Inventory.TableKeyList.Add("inventoryid");
                        bResult = conn_Inventory.Update("[inventory].[Inventory_Diff]", dt_Inventory_Diff, conn_Inventory.TableKeyList);

                        //bResult = conn_Inventory.Update("[inventory].[Inventory_Diff]", dt_Inventory_Diff, "inventory_diff_id=" + "'" + strInventory_Diff_ID + "'");
                        bResult = conn_Inventory.Insert("[inventory].[Inventory_Diff_State]", dt_Inventory_Diff_State);
                        AM_Message_Send.SendMessage_Submit_inventory(pstrDepotname, pstrUser_Name, pstrDepotid, pstrAreaName, pstrInventoryID, pstrState);
                        conn_Inventory.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

                        }
                        ds_ReturnGP.Tables.Add(dt_EditResult);
                    }

                    //财务审批确认
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERTFINANCIAL")
                    {
                        bool bResult = false;
                        conn_Inventory.LockTableList.Add("[inventory].[Inventory_Diff]");
                        conn_Inventory.LockTableList.Add("[inventory].[Inventory_Diff_State]");
                        //更新主表（通过GUID，修改状态和修改时间)
                        DataTable dt_Inventory_Diff = ds.Tables["list"].Copy();
                        string strInventory_Diff_ID = ds.Tables["list"].Rows[0]["inventory_diff_id"].ToString();
                        //小翅膀提醒参数抽取
                        string pstrDepotname = ds.Tables["list"].Rows[0]["depotname"].ToString();
                        string pstrUser_Name = hzyMessage.User_Name_CN;
                        string pstrDepotid = ds.Tables["list"].Rows[0]["depotid"].ToString();
                        string pstrAreaName = ds.Tables["list"].Rows[0]["areaname"].ToString();
                        string pstrInventoryID = ds.Tables["list"].Rows[0]["inventoryid"].ToString();
                        string pstrState = ds.Tables["list"].Rows[0]["state"].ToString();
                        DateTime timeNow = DateTime.Now;


                        dt_Inventory_Diff.Columns.Add("UpdateTime");
                        dt_Inventory_Diff.Rows[0]["UpdateTime"] = timeNow;
                        dt_Inventory_Diff.Columns.Remove("setdate");
                        dt_Inventory_Diff.Columns.Remove("depotid");
                        dt_Inventory_Diff.Columns.Remove("return_sums");
                        dt_Inventory_Diff.Columns.Remove("areaname");
                        dt_Inventory_Diff.Columns.Remove("depotname");
                        dt_Inventory_Diff.Columns.Remove("nums");
                        dt_Inventory_Diff.Columns.Remove("sure_date");
                        dt_Inventory_Diff.Columns.Remove("sums");
                        dt_Inventory_Diff.Columns.Remove("inventory_diff_id");
                        dt_Inventory_Diff.Columns.Remove("method");
                        //dt_Inventory_Diff.Columns.Remove("inventoryid");
                        dt_Inventory_Diff.Columns.Remove("serialnumber");
                        dt_Inventory_Diff.Columns.Remove("amountreceived");
                        dt_Inventory_Diff.Columns.Remove("content");
                        dt_Inventory_Diff.Columns.Remove("amount_of_remittance");
                        dt_Inventory_Diff.Columns.Remove("filepath");
                        dt_Inventory_Diff.Columns.Remove("received_time");


                        dt_Inventory_Diff.Columns.Remove("img");
                        dt_Inventory_Diff.Columns.Remove("bankoutlets");
                        dt_Inventory_Diff.Columns.Remove("remittance_time");


                        DataTable dt_Inventory_Diff_State = ds.Tables["list"].Copy();
                        dt_Inventory_Diff_State.Columns.Add("CreateTime");
                        dt_Inventory_Diff_State.Rows[0]["CreateTime"] = timeNow;

                        dt_Inventory_Diff_State.Columns.Add("UpdateTime");
                        dt_Inventory_Diff_State.Rows[0]["UpdateTime"] = timeNow;

                        dt_Inventory_Diff_State.Columns.Add("CreateUser");
                        dt_Inventory_Diff_State.Columns.Add("UpdateUser");
                        dt_Inventory_Diff_State.Rows[0]["UpdateUser"] = GetUserName(hzyMessage.User_Name_CN);
                        dt_Inventory_Diff_State.Rows[0]["CreateUser"] = GetUserName(hzyMessage.User_Name_CN);
                        dt_Inventory_Diff_State.Columns.Remove("setdate");
                        dt_Inventory_Diff_State.Columns.Remove("depotid");
                        dt_Inventory_Diff_State.Columns.Remove("return_sums");
                        dt_Inventory_Diff_State.Columns.Remove("areaname");
                        dt_Inventory_Diff_State.Columns.Remove("depotname");
                        dt_Inventory_Diff_State.Columns.Remove("nums");
                        dt_Inventory_Diff_State.Columns.Remove("sure_date");
                        dt_Inventory_Diff_State.Columns.Remove("sums");
                        //return new DataSet();

                        conn_Inventory.BeginTransaction();


                        conn_Inventory.TableKeyList.Clear();
                        conn_Inventory.TableKeyList.Add("inventoryid");
                        bResult = conn_Inventory.Update("[inventory].[Inventory_Diff]", dt_Inventory_Diff, conn_Inventory.TableKeyList);

                        //bResult = conn_Inventory.Update("[inventory].[Inventory_Diff]", dt_Inventory_Diff, "inventory_diff_id=" + "'" + strInventory_Diff_ID + "'");

                        bResult = conn_Inventory.Insert("[inventory].[Inventory_Diff_State]", dt_Inventory_Diff_State);
                        AM_Message_Send.SendMessage_Submit_inventory(pstrDepotname, pstrUser_Name, pstrDepotid, pstrAreaName, pstrInventoryID, pstrState);
                        conn_Inventory.CommitTransaction();

                        if (bResult)
                        {
                            dt_EditResult.Rows.Add(new object[] { true, "提交成功" });
                        }
                        else
                        {
                            dt_EditResult.Rows.Add(new object[] { false, "提交失败" });

                        }
                        ds_ReturnGP.Tables.Add(dt_EditResult);
                    }


                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETINFODETAIL")
                    {
                        string strSQL_SP = @"
                                            SELECT  *
                                                    FROM    ( SELECT    t1.Inventoryid ,
                                                                        t1.Amount_Of_Remittance ,
                                                                        t1.amountreceived ,
                                                                        t1.Serialnumber ,
                                                                        t1.Method ,
                                                                        t1.State ,
                                                                        CONVERT(VARCHAR(100), t1.remittance_time, 23) AS remittance_time,
                                                                        CONVERT(VARCHAR(100), t1.received_time, 23) AS received_time,
                                                                        t1.CreateTime ,
                                                                        t1.CreateUser ,
                                                                        t1.UpdateTime ,
                                                                        t1.UpdateUser ,
                                                                        t1.timestamps ,
                                                                        t2.Depotid ,
                                                                        t2.Depotname ,
                                                                        t2.AreaName ,
                                                                        t2.Nums ,
                                                                        t2.Sums ,
                                                                        t2.Return_Sums ,
                                                                        t1.Content ,
                                                                        t2.Setdate ,
                                                                        t2.sure_date
                                                              FROM      [inventory].[Inventory_Diff_State] t1
                                                                        LEFT JOIN [inventory].[Inventory_Diff] t2 ON t1.Inventory_Diff_ID = t2.Inventory_Diff_ID
                                                            ) t3
                                                    WHERE   1 = 1 " + m_hzyPageInfo.Where;
                        ds_ReturnGP = conn_Inventory.GetDataSetForPageList(strSQL_SP, new string[0], m_hzyPageInfo);
                    }

                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GETLOSSTABLE")
                    {
                        string strWhere = "";
                        string beginDate = ds.Tables["list"].Rows[0]["begindate"].ToString();
                        string endDate = ds.Tables["list"].Rows[0]["endDate"].ToString();
                        if (beginDate.Trim() != "")
                        {
                            strWhere = strWhere + " and setDate >='" + beginDate.Trim() + "'";
                        }
                        if (endDate.Trim() != "")
                        {
                            strWhere = strWhere + " and setDate <='" + endDate.Trim() + "'";
                        }
                        string strSQL = @"  SELECT * FROM (  
                                                            SELECT  t1.Inventoryid,t1.AreaName,t2.d_dd,t1.Depotid,t1.Depotname,
		                                                            t1.Nums,t1.Sums,t1.Return_Sums,
                                                                    convert(varchar(10),t1.Setdate,20) Setdate ,
                                                                    convert(varchar(100),sure_date,20) sure_date,
                                                                    t1.State,
                                                                    t1.CreateTime
                                                            FROM    [inventory].[Inventory_Diff] t1 ,
                                                                    [GP].[F22GP].[dbo].[j_depot] t2
                                                            WHERE   t1.Depotid = t2.depotid

                                                            UNION ALL 

                                                            SELECT  a.Inventoryid ,
                                                                    b.d_dq AreaName,
                                                                    b.d_dd,
                                                                    a.depotid ,
                                                                    b.d_name Depotname,
                                                                    a.zcnums Nums,
                                                                    a.zcsums Sums,
		                                                            null AS Return_Sums ,
                                                                    CONVERT(VARCHAR(10), a.setdate, 20) AS setdate ,
                                                                    convert(varchar(100),a.sure_date,20) sure_date,
                                                                    '未申请' AS state ,
                                                                    null AS CreateTime
                                                            FROM    [GP].[F22GP].dbo.d_Inventory a
                                                                    INNER JOIN [GP].[F22GP].dbo.j_depot b ON a.depotid = b.depotid
		                                                            WHERE not exists   
		                                                             (	SELECT Inventoryid
			                                                            FROM [inventory].[Inventory_Diff] c where a.Inventoryid=c.Inventoryid)
                                                                        AND b.m_type = 11 and d_dq not in ('雅斓大区','总部仓')
                                                                       AND SUBSTRING(b.depotid, 1, 1) NOT in ('D','J','Y','N','G')
                                                    ) TT Where 1=1 AND Nums<>0 " + strWhere + m_hzyPageInfo.Where;
                        ds_ReturnGP = conn_Inventory.GetDataSetForPageList(strSQL, m_hzyPageInfo);
                    }
                }
                return ds_ReturnGP;
            }
            catch
            {
                conn_Inventory.RollbackTransaction();
                throw;
            }
        }


        private string GetUserName(string pstrUserNameCN)
        {
            string strReturn = pstrUserNameCN;
            if (Convert.ToChar(pstrUserNameCN.Substring(0, 1)) < 'Z')
            {
                strReturn = pstrUserNameCN.Substring(9);
            }
            return strReturn;
        }
    }
}