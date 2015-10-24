using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;
using System.Data;
using System.Text;
using System.Web.Services;
using System.Collections;


using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;


//WSID:3a9cf88e-fc42-485d-9dff-96c35a8a1750

namespace HZY.COM.WS.SPWX
{
    internal class SPWX : HZYLogicBase, ILogicGetData
    {

        DataSet ds, ds_Return;
        DataTable dtList, dtOPType,dt_Return;
        DateTime timeNow;
        private static object syncRoot = new Object();
        private static volatile DBHandle dbhle;
        bool bRst;
        object[] objVal;

        enum SParam
        {
            InputFormat = 0,
            OutputFormat = 1,
            OutputContentType = 2,
            ConditionStr = 3
        };

        public SPWX()
        {
            base.m_SessionCheck = true;

            this.ds = new DataSet();
            this.ds_Return = new DataSet();
            this.dt_Return = new DataTable();
            this.dt_Return.Columns.Add("result");
            this.dt_Return.Columns.Add("message");
            this.dtList = new DataTable();
            this.timeNow = DateTime.Now;
            this.bRst = false;
        }


        public DataSet GetData()
        {
            try
            {
                string strXML 
                    = base.m_request.Tables[0]
                    .Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);
                
                this.dtOPType = ds.Tables["OPTYPE"];
                this.dtList = ds.Tables["List"];

                string optype = this.dtOPType.Rows[0][0]
                    .ToString().ToUpper();

                switch (optype)
                {
                    //Depot
                    case "GETDEPOTINFO": GetDepotInfo();        break;  //店铺信息
                    case "GETSALESMAN": GetSalesman();          break;  //导购信息
                    case "GETURGENTLEVE": GetUrgentLeve();      break;  //紧急程度
                    case "GETVIPINFO": GetVipInfo();            break;  //客户信息
                    case "GETEXPRESSINFO": GetExpressInfo();    break;  //快递信息
                    case "GETSKUCHECK": GetSKUCheck();          break;  //检验款号
                    case "CRTNEWWX": CrtNewWX();                break;  //新维修单
                    case "GETDATAGRID": GetDataGrid("");        break;  //列表数据
                    case "SCREENDATAGRID": ScreenDataGrid();    break;  //查询维修
                    case "GETWXDETAILINFO": GetWXDetailInfo();  break;  //获取明细
                    case "GETHISTORY": GetHistory();            break;  //获取流程

                    //HWA
                    case "CHECKEXPNO": CheckExpNo();            break;  //快递单号
                    case "GETQUESTION": GetQuestion();          break;  //获取问题
                    case "GETDEPARTMENT": GetDepartment();      break;  //责任部门
                    case "GETDEGRADE": GetDegrade();            break;  //退仓结果 
                    case "GETMAINTAINWAY": GetMaintainway();    break;  //维修方式
                    case "GETPAY": GetPay();                    break;  //是否付费
                    case "NEWFIXJUDGE": NewFixJudge();          break;  //新建维修
                    case "GETDAYMONEY": GetDayMoney();          break;  //费用耗时
                    case "GETWXINFO": GetWXInfo();              break;  //维修单信息（HWA）
                    case "GETWXLIST": SearchWXDg();             break;  //DataGrid
                    case "GETFININFO": GetFinInfo();            break;  //完成信息
                    case "SAVEFIN": SaveFin();                  break;  //维修完成
                    case "GETSUPPLIER": GetSupplier();          break;  //取供应商
                    case "UPDATEFIX": UpdateFix();              break;  //更新维修单
                    case "SAVEEXP": SaveExp();                  break;  //存快递单

                };

                return this.ds_Return;
            }
            catch (Exception)
            {
                
                throw;
            } 
            
        }

        #region 方法

        //Depot

        #region 获取店铺信息
        private void GetDepotInfo()
        {
            
            DataTable dtDepot = new DataTable();//店铺表
            DataTable dtWX = new DataTable();   //维修表
            string ColumnsName = "";
            string Depotid = "";
            string select = @"SELECT [j_dq]
                              ,[j_depotid]
                              ,[j_name]
                              ,[j_form]
                              ,[m_shoptel]
                              ,[m_shopadmin]
                              ,[m_shopadminmob]
                              ,[m_supervisor]
                              ,[m_supervisormob]
                              ,[品牌简称]	
                              ,[m_salesmannum]
                              ,[g_address]
                              ,[j_merchantid]
                              ,[j_com]
                              ,[j_brand]
                          FROM [dbo].[V_L0013_BASE] WITH(NOLOCK)
                          WHERE [j_depotid] = @Param0";
            if (this.dtList.Rows.Count > 0)
            {
                if (this.dtList.Columns.Count > 0)
                {
                    ColumnsName = this.dtList.Columns[0].ColumnName;
                    if (ColumnsName.ToUpper() == "DEPOTID")
                    {
                        Depotid
                            = this.dtList.Rows[0][0].ToString();
                    }
                    else
                    {
                        Depotid
                            = base.m_hzyMessage.User_Name_CN.Split('_')[0].ToString();
                    };
                }
                else 
                {
                    Depotid
                        = base.m_hzyMessage.User_Name_CN.Split('_')[0].ToString();
                };
            }
            else {
                Depotid
                    = base.m_hzyMessage.User_Name_CN.Split('_')[0].ToString();
            };
            
            DBHandle had = new DBHandle("MDM_Market2");

            dtDepot = had.GetData(select, new object[] { Depotid });
            
            //增加维修仓信息
            dtDepot.Columns.Add("j_wxid");//维修仓编号
            dtDepot.Columns.Add("j_wxname");//维修仓名称
            dtDepot.Columns.Add("j_wxaddress");//维修仓地址
            dtDepot.Columns.Add("j_wxadmin");//维修对接人
            dtDepot.Columns.Add("m_wxshoptel");//维修电话

            string brand = dtDepot.Rows[0]["品牌简称"].ToString();
            //获取维修信息
            dtWX = GetWX();
            for (int i = 0; i < dtWX.Rows.Count; i++)
            {
                string wxID = dtWX.Rows[i]["j_depotid"].ToString();
                wxID = wxID.Substring(0, 1);

                if (wxID == brand)
                {
                    dtDepot.Rows[0]["j_wxid"] 
                        = dtWX.Rows[i]["j_depotid"].ToString();
                    dtDepot.Rows[0]["j_wxname"] 
                        = dtWX.Rows[i]["j_name"].ToString();
                    dtDepot.Rows[0]["j_wxaddress"] 
                        = dtWX.Rows[i]["g_address"].ToString();
                    dtDepot.Rows[0]["j_wxadmin"] 
                        = dtWX.Rows[i]["m_shopadmin"].ToString();
                    dtDepot.Rows[0]["m_wxshoptel"]
                        = dtWX.Rows[i]["m_shoptel"].ToString();
                    break;
                }
                else 
                {
                    continue;
                };
            };

            this.ds_Return.Tables.Add(dtDepot);
        }
        #endregion

        #region 获取导购员信息
        private void GetSalesman()
        {
            string DepotId 
                = base.m_hzyMessage.User_Name_CN.ToString();
            DepotId = DepotId.Split('_')[0];

            string select 
                = @"SELECT [employeeid]
                        ,[names]
                        ,[telephone]
                    FROM [dbo].[j_employee] WITH(NOLOCK)
                    WHERE valid = 0 AND depotid = @Param0";

            DBHandle DBH = new DBHandle("F22GP");

            DataTable dt 
                = DBH.GetData(select, new object[] { DepotId });

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 获取维修仓
        private DataTable GetWX()
        { 
            string select = @"SELECT j_depotid
	                               ,j_name
	                               ,g_address
	                               ,m_shopadmin
                                   ,m_shoptel
                              FROM [dbo].[V_L0013_BASE] WITH(NOLOCK)
                              WHERE j_name LIKE '%品检维修%'";

            DBHandle dbl = new DBHandle("MDM_Market2");

            DataTable dt = dbl.GetData(select, new object[] { });

            return dt;

        }
        #endregion

        #region 获取紧急程度
        private void GetUrgentLeve() 
        {
            string select 
                = @"SELECT [Value]
                          ,[Name]
                    FROM [dbo].[SPWX_Dict] WITH(NOLOCK)
                    WHERE [Type] = 'Level' 
                    AND [Status] = 0";
            DBHandle dba = new DBHandle("SPWX");

            DataTable dt 
                = dba.GetData(select, new object[] { });

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 获取Vip信息
        private void GetVipInfo()
        {
            string VipId 
                = this.dtList.Rows[0]["VipId"].ToString();

            VipId = FilterSpecial(VipId);   //过滤特殊符号
            
            string select = @"SELECT vipname
                                ,mobtel 
                              FROM vip_user WITH(NOLOCK)
                              WHERE vipcode = @Param0";
            DBHandle dba = new DBHandle("F22GP");

            DataTable dt 
                = dba.GetData(select, new object[] { VipId });

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 获取快递信息

        private void GetExpressInfo()
        { 
            string select = @"SELECT [Value]
                                    ,[Name]
                              FROM [dbo].[SPWX_Dict] WHIT(NOLOCK)
                              WHERE [Type]  = 'Express' 
                              AND [Status] = '0'";
            DBHandle DBH = new DBHandle("SPWX");

            DataTable dt = DBH.GetData(select, new object[] { });

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 获取DataGrid信息
        private void GetDataGrid(string Screen)
        {
            DataTable dt = new DataTable();

            string DepotId 
                = base.m_hzyMessage.User_Name_CN.Split('_')[0];
            string where = "";

            //bool b = Convert.ToChar(DepotId.Substring(0, 1)) <= 'Z';

            if (Screen.Length == 0)
            {
                where = "WHERE T1.[DepotId] = @Param0 ";
            }
            else
            {
                where = "WHERE T1.[DepotId] = @Param0 ";
                where += " AND (T1.[WXNo] = @Param1 OR T1.[SKU] = @Param2) ";
            }
            
            

            string select = @"SELECT T1.[ID]
                              ,[WXNo],[DepotId]
                              ,[DepotName],[DepotPhone]
                              ,[DepotTye],[DepotArea]
                              ,[RespName],[RespPhone]
                              ,[StaffNo],[StaffName]
                              ,[StaffPhone],[SKU]
                              ,[BackDate],[Question]
                              ,[VIPID],[VIPName]
                              ,[VIPPhone],[SellDate]
                              ,[Collect]
                              ,[UrgentLevel]
                              ,T4.[Name] AS [ULName]
                              ,[Express]
                              ,T3.[Name] AS [ExpressName]
                              ,[ExpressNo],[SendAddress]
                              ,[TakeAddress],[TakeMan]
                              ,[TakeManPhone],T1.[Remark]
                              ,T1.[Status]
                              ,T2.[Name] AS [StatusName]
                              ,T1.[WxStatus]
                              ,T5.[Name] AS [WXStName]
                              ,T1.[CreateTime],T1.[ModifyTime]
                              ,[CreateUser],[ModifyUser]
                            FROM [dbo].[SPWX_Main] T1 WITH(NOLOCK)
                                ,[dbo].[SPWX_Dict] T2 WITH(NOLOCK)
                                ,[dbo].[SPWX_Dict] T3 WITH(NOLOCK)  
                                ,[dbo].[SPWX_Dict] T4 WITH(NOLOCK) 
                                ,[dbo].[SPWX_Dict] T5 WITH(NOLOCK) ";
            select += where;
            select += @" AND T1.[Status] = T2.[Value] AND T2.[Type] = 'Status' AND T2.[Status] = 0 
                         AND T1.[Express] = T3.[Value] AND T3.[Type] = 'Express' AND T3.[Status] = 0
                         AND T1.[UrgentLevel] = T4.[Value] AND T4.[Type] = 'Level' AND T4.[Status] = 0
                         AND T1.[WxStatus] = T5.[Value] AND T5.[Type] = 'WXType' AND T5.[Status] = 0
                         ORDER BY T1.[WXNo] Desc";
            DBHandle dbh = new DBHandle("SPWX");

            if (Screen.Length == 0)//店铺无条件查询
            {
                dt = dbh.GetData(select, new object[] { DepotId });
            }
            else if (Screen.Length > 0)//店铺有条件查询
            {
                dt = dbh.GetData(select, new object[] { DepotId, Screen, Screen });
            };
            

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 检验款式信息

        private void GetSKUCheck()
        { 
            string VipId 
                = this.dtList.Rows[0]["VipId"].ToString();
            string SKU
                = this.dtList.Rows[0]["SKU"].ToString();
            string DepotId
                = base.m_hzyMessage.User_Name_CN.Split('_')[0];

            DataTable dtChk = new DataTable();
            DataTable dtRst = new DataTable();

                dtRst.Columns.Add("Result");
                dtRst.Columns.Add("Msg");
                dtRst.Columns.Add("Date");

            //数据清洗
            VipId = FilterSpecial(VipId);
            SKU = FilterSpecial(SKU);
            bool b = Convert.ToChar(DepotId.Substring(0, 1)) <= 'Z';


            if (b)
            {
                DBHandle DBH = new DBHandle("CUSF22");
                //调用存储过程
                dtChk = DBH.GetDataBySP(
                    "dbo.SP_AftermarketRepairs_Check",
                    new object[3] { "clothingid", "depotid", "vipcode" },
                    new object[3] { SKU, DepotId, VipId });
                if (dtChk != null)
                {
                    if (dtChk.Rows.Count > 0)
                    {
                        string result = dtChk.Rows[0]["Result"].ToString();
                        string[] strRst = result.Split(',');

                        //account strRst:
                        //strRst[0] = 0,无经营权,strRst[0] = 1,有经营权
                        //strRst[1] = 0,顾客未购买,strRst[1] = 1,顾客有购买

                        //logic：
                        //1.判断strRst[0]=0,直接返回结果
                        //2.strRst[0] = 1,继续判断顾客
                        //3.strRst[1] = 0,返回无购买记录
                        //4.strRst[1] = 1,返回购买记录

                        if (Int32.Parse(strRst[0]) == 0)
                        {
                            DataRow dr = dtRst.NewRow();
                            dtRst.Rows[0]["Result"] = false;
                            dtRst.Rows[0]["Msg"] = "此登陆帐号，无该品牌经营权。请更换相应帐号!";
                            dtRst.Rows[0]["Date"] = "";
                        }
                        else
                        {
                            if (Int32.Parse(strRst[1]) == 0)
                            {
                                DataRow dr = dtRst.NewRow();
                                dr["Result"] = false;
                                dr["Msg"] = "该顾客未购买此款衣服，请确认款号是否正确!";
                                dr["Date"] = "";
                                dtRst.Rows.Add(dr);
                            }
                            else
                            {
                                DataRow dr = dtRst.NewRow();
                                dr["Result"] = true;
                                dr["Msg"] = "验证通过，可以维修.";
                                dr["Date"] = dtChk.Rows[0]["sure_date"];
                                dtRst.Rows.Add(dr);
                            };
                        };
                    }
                    else
                    {
                        DataRow dr = dtRst.NewRow();
                        dr["Result"] = false;
                        dr["Msg"] = "验证失败，请再次尝试!";
                        dr["Date"] = "";
                        dtRst.Rows.Add(dr);
                    };
                }
                else
                {
                    DataRow dr = dtRst.NewRow();
                    dr["Result"] = false;
                    dr["Msg"] = "验证失败，请再次尝试!";
                    dr["Date"] = "";
                    dtRst.Rows.Add(dr);
                };
            }
            else
            {
                DataRow dr = dtRst.NewRow();
                dr["Result"] = false;
                dr["Msg"] = "只有店铺才可以使用此功能!";
                dr["Date"] = "";
                dtRst.Rows.Add(dr);
            };
            

            this.ds_Return.Tables.Add(dtRst);
        }
        #endregion

        #region 创建新维修单

        private void CrtNewWX()
        {
            DBHandle dbh = new DBHandle("SPWX");

            DataRow drRow = this.dt_Return.NewRow();

            DataTable dtCp = this.dtList.Copy();


            dtCp.Rows[0]["ExpressNo"]
                = dtCp.Rows[0]["ExpressNo"].ToString().ToUpper();


            DataTable dtHist = dbh.GetData(
                "SELECT TOP 0 * FROM [dbo].[SPWX_Hist] WITH(NOLOCK)", 
                new object[] { });

            DataRow dr = dtHist.NewRow();

            dtCp.Columns.Add("WXNo");
            dtCp.Columns.Add("Status");
            dtCp.Columns.Add("BackDate");
            dtCp.Columns.Add("WxStatus");
            dtCp.Columns.Add("CreateUser");
            dtCp.Columns.Add("ModifyUser");

            int iMax = getMaxWXNo();

            if (iMax != 0)
            {
                dtCp.Rows[0]["WXNo"] = iMax.ToString();
                dtCp.Rows[0]["Status"] = "16";
                dtCp.Rows[0]["BackDate"] = this.timeNow;
                dtCp.Rows[0]["CreateUser"] = base.m_hzyMessage.User_Name;
                dtCp.Rows[0]["ModifyUser"] = base.m_hzyMessage.User_Name;
                if (dtCp.Columns.Contains("VIPID"))
                {
                    dtCp.Rows[0]["WxStatus"] = "client";
                }
                else
                {
                    dtCp.Rows[0]["WxStatus"] = "unsell";
                };

                //历史记录
                dr["WXNo"] = iMax.ToString();
                dr["BeforeStatus"] = "15";
                dr["AfterStatus"] = "16";
                dr["Content"] = "操作内容:创建维修单,并发货.";
                dr["ModifyUser"] = base.m_hzyMessage.User_Name;

                dtHist.Rows.Add(dr);
                
                dtCp.TableName = "[dbo].[SPWX_Main]";
                dtHist.TableName = "[dbo].[SPWX_Hist]";

                DataSet ds = new DataSet();

                ds.Tables.Add(dtCp);
                ds.Tables.Add(dtHist);
                this.bRst = dbh.UpdateDB("ID", ds);

                

                if (this.bRst)
                {
                    drRow["result"] = true;
                    drRow["message"] = "提交成功";
                }
                else
                {
                    drRow["result"] = false;
                    drRow["message"] = "提交失败";
                };
            }
            else 
            {
                drRow["result"] = false;
                drRow["message"] = "提交失败";
            };

            this.dt_Return.Rows.Add(drRow);

            this.ds_Return.Tables.Add(this.dt_Return);
            
        }
        #endregion

        #region 查询维修单
        private void ScreenDataGrid()
        {
            string screen 
                = this.dtList.Rows[0][0].ToString();

            screen = FilterSpecial(screen);
            GetDataGrid(screen);
        }
        #endregion

        #region 获取维修单明细
        private void GetWXDetailInfo()
        {
            string WXNO 
                = this.dtList.Rows[0][0].ToString();
            //过滤非法字符
            WXNO = FilterSpecial(WXNO);

            string select = @"SELECT * FROM 
                              [dbo].[SPWX_Main] WITH(NOLOCK)
                              WHERE [WXNo] = @Param0 ";
            
            DataTable dt = new DataTable();

            DBHandle dbh = new DBHandle("SPWX");

            dt = dbh.GetData(select, new object[] { WXNO });

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 获取流程信息
        private void GetHistory()
        {
            string WXNo 
                = this.dtList.Rows[0][0].ToString();
            WXNo = FilterSpecial(WXNo);

            string select = @"SELECT DISTINCT 
                                   [WXNo]
                                  ,[AfterStatus]
                                  ,T2.[Name] AS [StatusName]
                                  ,CONVERT(VARCHAR(200),T1.[ModifyTime],23) AS [ModifyTime]
                                  ,[ModifyUser]
                              FROM [dbo].[SPWX_Hist] T1
                              LEFT JOIN [dbo].[SPWX_Dict] T2
                              ON T1.[AfterStatus] = T2.[Value]
                              WHERE T1.WXNo = @Param0 ";
            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt = dbh.GetData(select, new object[] { WXNo });

            string html = "";

            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i != dt.Rows.Count - 1)
                        {
                            html += "<li><div class=\"status\">";
                            html += dt.Rows[i]["StatusName"].ToString();
                            html += "</div><div class=\"statusDate\">";
                            html += dt.Rows[i]["ModifyTime"].ToString();
                            html += "</div></li>";
                        }
                        else if (i == dt.Rows.Count - 1)
                        {
                            html += "<li style=\"background-image:none\"><div class=\"status\">";
                            html += dt.Rows[i]["StatusName"].ToString();
                            html += "</div><div class=\"statusDate\">";
                            html += dt.Rows[i]["ModifyTime"].ToString();
                            html += "</div></li>";
                            break;
                        };
                        
                    };
                };
            };

            DataRow drRow = this.dt_Return.NewRow();
            drRow["result"] = true;
            drRow["message"] = html;

            this.dt_Return.Rows.Add(drRow);
            this.ds_Return.Tables.Add(this.dt_Return);
        }

        #endregion


        //HWA

        #region 检查快递单号

        private void CheckExpNo()
        {
            string ExpNo 
                = this.dtList.Rows[0]["ExpNo"].ToString();
            ExpNo = FilterSpecial(ExpNo);
            ExpNo = ExpNo.ToUpper();

            string DepotId
                = base.m_hzyMessage.User_Name_CN.Split('_')[0];
            string select = "";

            bool b = Convert.ToChar(DepotId.Substring(0, 1)) <= 'Z';

            if (b)
            {
                select = @"SELECT T1.[ID]
                            ,T1.[WXNo]
                            ,T1.[Status]
                            ,T1.[ModifyTime]
                            ,T1.[ModifyUser]
                        FROM [dbo].[SPWX_Main] T1
                        LEFT JOIN [dbo].[SPWX_Headquarters] T2
                        ON T1.[WXNo] = T2.[WXNo]
                        WHERE T1.[Status] = 45 AND T1.[DepotId] = '" 
                        + DepotId + "' AND T2.[ExpNo] = @Param0";
            }
            else
            {
                 select = @"SELECT [ID]
                            ,[WXNo]
                            ,[Status]
                            ,[ModifyTime]
                            ,[ModifyUser]
                        FROM [dbo].[SPWX_Main]
                        WHERE [Status] = '16' 
                        AND [ExpressNo] = @Param0";
            };

            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt = dbh.GetData(select, new object[] { ExpNo });

            if (dt.Rows.Count > 0)
            {
                DataTable dtHist 
                    = dbh.GetTabHead("[dbo].[SPWX_Hist]");
                

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    //交易表
                    DataRow drHist = dtHist.NewRow();

                    drHist["WXNo"] 
                        = dt.Rows[i]["WXNo"].ToString();
                    drHist["BeforeStatus"] 
                        = dt.Rows[i]["Status"].ToString();
                    if (b)
                    {
                        drHist["AfterStatus"] = "50";
                        drHist["Content"] = "操作内容:店铺已经收货";
                    }
                    else
                    {
                        drHist["AfterStatus"] = "20";
                        drHist["Content"] = "操作内容:维修单已经收货";
                    };
                        
                    drHist["ModifyTime"] = this.timeNow;
                    drHist["ModifyUser"] 
                        = base.m_hzyMessage.User_Name;

                    dtHist.Rows.Add(drHist);

                    //主表
                    if (b)
                    {
                        dt.Rows[i]["Status"] = "50";
                    }
                    else
                    {
                        dt.Rows[i]["Status"] = "20";
                    };
                    
                    dt.Rows[i]["ModifyTime"] = this.timeNow;
                    dt.Rows[i]["ModifyUser"] 
                        = base.m_hzyMessage.User_Name;
                };
                dt.TableName = "[dbo].[SPWX_Main]";
                dtHist.TableName = "[dbo].[SPWX_Hist]";

                DataSet ds = new DataSet();
                ds.Tables.Add(dt);
                ds.Tables.Add(dtHist);

                this.bRst = dbh.UpdateDB("ID", ds);
                
            };

            DataRow drRow = this.dt_Return.NewRow();

            if (this.bRst)
            //if (dt.Rows.Count >0)
            {
                drRow["result"] = true;
                drRow["message"] = "成功";
            }
            else
            {
                drRow["result"] = false;
                drRow["message"] = "失败";
            };

            this.dt_Return.Rows.Add(drRow);

            this.ds_Return.Tables.Add(this.dt_Return);

        }
        #endregion

        #region 获取问题点

        private void GetQuestion() 
        { 
            string type 
                = this.dtList.Rows[0][0].ToString();

            type = FilterSpecial(type);

            string select = @"SELECT [Value]
                                  ,[Name]
                              FROM [dbo].[SPWX_WXDict]
                              WHERE [FartherVal] = @Param0";

            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt = dbh.GetData(select, new object[] { type });

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 获取责任部门
        private void GetDepartment()
        {
            string select = @"SELECT [Value]
                                  ,[Name]
                              FROM [SPWX_SYSTEM].[dbo].[SPWX_Dict]
                              WHERE [Type] = 'blame' AND [Status] = 0";
            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt = dbh.GetData(select, new object[] { });

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 处理结果
        private void GetDegrade()
        {
            string select = @"SELECT [Value]
                                    ,[Name]
                              FROM [dbo].[SPWX_Dict]
                              WHERE [Type] = 'degrade' AND [Status] = 0";
            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt = dbh.GetData(select, new object[] { });

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 内修外修
        private void GetMaintainway()
        {
            string select = @"SELECT [Value]
                                    ,[Name]
                              FROM [dbo].[SPWX_Dict]
                              WHERE [Type] = 'maintainway' AND [Status] = 0";
            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt = dbh.GetData(select, new object[] { });

            this.ds_Return.Tables.Add(dt);

        }
        #endregion

        #region 是否维修

        private void GetPay() {
            string select = @"SELECT [Value]
                                    ,[Name]
                              FROM [dbo].[SPWX_Dict] WITH(NOLOCK)
                              WHERE [Type] = 'charge' AND [Status] = 0";
            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt = dbh.GetData(select, new object[] { });

            ds_Return.Tables.Add(dt);

        }
        #endregion

        #region 新建维修单
        private void NewFixJudge()
        {
            DataRow drRow = this.dt_Return.NewRow();
            //获取维修单号
            string wxno 
                = this.dtList.Rows[0]["WXNo"].ToString();
            string warehouse
                = this.dtList.Rows[0]["Warehouse"].ToString();

            wxno = FilterSpecial(wxno);
            warehouse = FilterSpecial(warehouse);

            string selectMain
                = @"SELECT [ID] 
                        ,[WXNo]
                        ,[DepotId]
                        ,[CreateUser]
                        ,[SKU]
                        ,[Status]
                        ,[ModifyTime]
                        ,[ModifyUser]
                    FROM [dbo].[SPWX_Main] WITH(NOLOCK)
                    WHERE [Status] = '20' AND [WXNo] = @Param0 ";

            //创建连接对象
            DBHandle dbh = new DBHandle("SPWX");
            
            //获取主表状态
            DataTable dtMain 
                = dbh.GetData(selectMain,new object[]{wxno});

            //判断有无初判数据
            if (dtMain.Rows.Count > 0)
            {
                //获取交易表表头
                DataTable dtHist = dbh.GetTabHead("[dbo].[SPWX_Hist]");

                DataRow dr = dtHist.NewRow();
                dr["WXNo"] = wxno;
                dr["BeforeStatus"] = dtMain.Rows[0]["Status"].ToString();
                dr["AfterStatus"] = "25";
                dr["Content"] = "操作内容:完成初判";
                dr["ModifyUser"] = base.m_hzyMessage.User_Name;

                dtHist.Rows.Add(dr);
                //修改主表状态,修改人
                dtMain.Rows[0]["Status"] = "25";
                dtMain.Rows[0]["ModifyUser"] = base.m_hzyMessage.User_Name;
                dtMain.Rows[0]["ModifyTime"] = timeNow.ToString();

                //获取维修价格和时间
                string value
                    = this.dtList.Rows[0]["FirstPhen"].ToString();
                value = FilterSpecial(value);

                DataTable dtMD = GetMoneyDay(value);

                //新插入表
                this.dtList.Columns.Add("CreateUser");
                this.dtList.Columns.Add("ModifyUser");


                this.dtList.Rows[0]["FixNeedTime"]
                    = dtMD.Rows[0]["Day"].ToString();
                this.dtList.Rows[0]["FixNeedMoney"]
                    = dtMD.Rows[0]["Money"].ToString();
                this.dtList.Rows[0]["CreateUser"]
                        = base.m_hzyMessage.User_Name;
                this.dtList.Rows[0]["ModifyUser"]
                        = base.m_hzyMessage.User_Name;

                //调用退仓单

                if (warehouse.Length > 0)
                {
                    string DepotId = dtMain.Rows[0]["DepotId"].ToString();
                    string CreateUser = dtMain.Rows[0]["CreateUser"].ToString();
                    string sku = dtMain.Rows[0]["SKU"].ToString();
                    string sendUser = base.m_hzyMessage.User_Name;

                    DBHandle dbhGP = new DBHandle("F22GP");

                    object[] paramObj = new object[4];

                    object[] paramVal = new object[4];

                    paramObj[0] = SParam.InputFormat;
                    paramObj[1] = SParam.OutputFormat;
                    paramObj[2] = SParam.OutputContentType;
                    paramObj[3] = SParam.ConditionStr;

                    paramVal[0] = "AML";
                    paramVal[1] = "DB";
                    paramVal[2] = "RS";
                    paramVal[3] = @"【操作类型,NEW】【实体,发货】
                        【新增内容,发货店铺ID,收货店铺ID,装箱号,款号,款式编号,颜色,尺码,退货数量,成本,
                            原价,现价,结算价,折扣,登记人,发货操作员,收货操作员】
                        【条件内容,《N》发货店铺ID,《N》收货店铺ID,《N》装箱号,《N》款号,《N》款式编号,
                            《N》颜色,《N》尺码,《N》退货数量,《N》成本,《N》原价,《N》现价,《N》结算价,《N》折扣,
                            《N》登记人,《N》发货操作员,《N》收货操作员 】
                        【《N》维修单号," + wxno + "】【《N》发货店铺ID," + DepotId + "】【《N》收货店铺ID," + DepotId + @"】
                        【《N》装箱号," + sendUser + "】【《N》款号," + sku + @"】【《N》款式编号,】【《N》颜色,】
                        【《N》尺码,】【《N》退货数量,1】【《N》成本,0】【《N》原价,0】【《N》现价,0】【《N》结算价,0】
                        【《N》折扣,0】【《N》登记人," + sendUser + "】【《N》发货操作员," + sendUser + "】【《N》收货操作员,】";
                    DataTable dtRtn
                        = dbhGP.GetDataBySP("[API_Bill].[Thd_Info]", paramObj, paramVal);

                    if (dtRtn != null)
                    {
                        if (dtRtn.Rows.Count > 0)
                        {
                            string result = dtRtn.Rows[0]["FLAG"].ToString();

                            if (result.ToUpper() == "TRUE")
                            {
                                string returnNo = dtRtn.Rows[0]["outindentid"].ToString();
                                this.dtList.Columns.Add("ReturnNo");
                                this.dtList.Rows[0]["ReturnNo"] = returnNo;
                                //调用收货的过程
                                paramVal[3] = @"【操作类型,NEW】【实体,收货】
                                    【新增内容,退货单号,发货店铺ID,收货店铺ID,装箱号,款号,款式编号,颜色,尺码,退货数量,成本,
                                        原价,现价,结算价,折扣,登记人,发货操作员,收货操作员】
                                    【条件内容,《N》退货单号,《N》发货店铺ID,《N》收货店铺ID,《N》装箱号,《N》款号,《N》款式编号,
                                        《N》颜色,《N》尺码,《N》退货数量,《N》成本,《N》原价,《N》现价,《N》结算价,《N》折扣,《N》登记人,
                                        《N》发货操作员,《N》收货操作员 】【《N》退货单号," + returnNo + "】【《N》发货店铺ID," + DepotId + @"】
                                        【《N》收货店铺ID," + DepotId + "】【《N》装箱号," + sendUser + "】【《N》款号," + sku + @"】【《N》款式编号,】
                                        【《N》颜色,】【《N》尺码,】【《N》退货数量,1】【《N》成本,0】【《N》原价,0】【《N》现价,0】
                                        【《N》结算价,0】【《N》折扣,0】【《N》登记人," + CreateUser + "】【《N》发货操作员,】【《N》收货操作员," + sendUser + "】";
                                DataTable dtClt
                                    = dbhGP.GetDataBySP("[API_Bill].[Thd_Info]", paramObj, paramVal);
                                if (dtClt != null)
                                {
                                    if (dtClt.Rows.Count > 0)
                                    {
                                        if (dtClt.Rows[0]["FLAG"].ToString().ToUpper() == "TRUE")
                                        {
                                            DataTable dtHead = this.dtList.Copy();
                                            dtHead.TableName = "[dbo].[SPWX_Headquarters]";
                                            dtMain.TableName = "[dbo].[SPWX_Main]";
                                            dtHist.TableName = "[dbo].[SPWX_Hist]";

                                            DataSet ds = new DataSet();
                                            ds.Tables.Add(dtHead);
                                            ds.Tables.Add(dtMain);
                                            ds.Tables.Add(dtHist);

                                            this.bRst = dbh.UpdateDB("ID", ds);

                                            if (this.bRst)
                                            {
                                                drRow["result"] = true;
                                                drRow["message"] = "提交成功";
                                            }
                                            else
                                            {
                                                drRow["result"] = false;
                                                drRow["message"] = "提交失败";
                                            };
                                        }
                                        else
                                        {
                                            string msg = dtRtn.Rows[0]["message"].ToString();
                                            drRow["result"] = false;
                                            drRow["message"] = msg;
                                        };
                                    }
                                    else
                                    {
                                        drRow["result"] = false;
                                        drRow["message"] = "收货单生成失败，请联系信息管理部。";
                                    };
                                }
                                else
                                {
                                    drRow["result"] = false;
                                    drRow["message"] = "收货单生成失败，请联系信息管理部。";
                                };

                            }
                            else
                            {
                                string msg = dtRtn.Rows[0]["message"].ToString();
                                drRow["result"] = false;
                                drRow["message"] = msg;
                            };
                        }
                        else
                        {
                            drRow["result"] = false;
                            drRow["message"] = "退货单生成失败，请联系信息管理部。";
                        };
                    }
                    else
                    {
                        drRow["result"] = false;
                        drRow["message"] = "退货单生成失败，请联系信息管理部。";
                    };
                }
                else
                {
                    DataTable dtHead = this.dtList.Copy();
                    dtHead.TableName = "[dbo].[SPWX_Headquarters]";
                    dtMain.TableName = "[dbo].[SPWX_Main]";
                    dtHist.TableName = "[dbo].[SPWX_Hist]";

                    DataSet ds = new DataSet();
                    ds.Tables.Add(dtHead);
                    ds.Tables.Add(dtMain);
                    ds.Tables.Add(dtHist);

                    this.bRst = dbh.UpdateDB("ID", ds);

                    if (this.bRst)
                    {
                        drRow["result"] = true;
                        drRow["message"] = "提交成功";
                    }
                    else
                    {
                        drRow["result"] = false;
                        drRow["message"] = "提交失败";
                    };
                };
            }
            else 
            {
                drRow["result"] = false;
                drRow["message"] = "在初判表中已经无法找到该维修单号，请确认。";
            };
            
            this.dt_Return.Rows.Add(drRow);

            this.ds_Return.Tables.Add(this.dt_Return);
        }
        #endregion

        #region 获取维修单信息
        /// <summary>
        /// 这里需要适应单条（搜索）与多条（datagrid）
        /// </summary>
        private void GetWXInfo() 
        {
            DataTable dt = new DataTable();

            string where = " WHERE 1=1 ";

            if (this.dtList.Rows.Count > 0)
            {
                this.objVal = new object[this.dtList.Columns.Count];

                for(int i = 0; i<this.dtList.Columns.Count;i++)
                {
                    where += " AND T1." + this.dtList.Columns[i].ColumnName;
                    where += " = @Param" + i;

                    this.objVal[i] = FilterSpecial(this.dtList.Rows[0][i].ToString());
                };
            };
            
            string select = @"SELECT T1.[ID]
                              ,[WXNo],[DepotId]
                              ,[DepotName],[DepotPhone]
                              ,[DepotTye],[DepotArea]
                              ,[RespName],[RespPhone]
                              ,[StaffNo],[StaffName]
                              ,[StaffPhone],[SKU]
                              ,[BackDate],[Question]
                              ,[VIPID],[VIPName]
                              ,[VIPPhone],[SellDate]
                              ,[Collect],[UrgentLevel]
                              ,T4.[Name] AS [ULName]
                              ,[Express]
                              ,T3.[Name] AS [ExpressName]
                              ,[ExpressNo],[SendAddress]
                              ,[TakeAddress],[TakeMan]
                              ,[TakeManPhone],T1.[Remark]
                              ,T1.[Status]
                              ,T2.[Name] AS [StatusName]
                              ,T1.[WxStatus]
                              ,T5.[Name] AS [WXStName]
                              ,T1.[CreateTime],T1.[ModifyTime]
                              ,[CreateUser],[ModifyUser]
                            FROM [dbo].[SPWX_Main] T1 WITH(NOLOCK)
                                ,[dbo].[SPWX_Dict] T2 WITH(NOLOCK)
                                ,[dbo].[SPWX_Dict] T3 WITH(NOLOCK)  
                                ,[dbo].[SPWX_Dict] T4 WITH(NOLOCK) 
                                ,[dbo].[SPWX_Dict] T5 WITH(NOLOCK) ";
            select += where;
            select += @" AND T1.[Status] = T2.[Value] AND T2.[Type] = 'Status' AND T2.[Status] = 0 
                         AND T1.[Express] = T3.[Value] AND T3.[Type] = 'Express' AND T3.[Status] = 0
                         AND T1.[UrgentLevel] = T4.[Value] AND T4.[Type] = 'Level' AND T4.[Status] = 0
                         AND T1.[WxStatus] = T5.[Value] AND T5.[Type] = 'WXType' AND T5.[Status] = 0
                         ORDER BY T1.[WXNo] Desc";
            DBHandle dbh = new DBHandle("SPWX");

            dt = dbh.GetData(select, this.objVal);
            dt.TableName = "WxInfo";

            if (dt.Rows.Count == 1)
            {
                string sku = dt.Rows[0]["SKU"].ToString();

                DataTable dtSup = GetSupplierInfo(sku);
                dtSup.TableName = "SuppInfo";
                
                this.ds_Return.Tables.Add(dt);
                this.ds_Return.Tables.Add(dtSup);
            }
            else 
            {
                this.ds_Return.Tables.Add(dt);
            }
            
           
            
        }
        #endregion

        #region 获取维修时间和费用

        private void GetDayMoney()
        {
            string value = this.dtList.Rows[0][0].ToString();

            value = FilterSpecial(value);

            DataTable dt = GetMoneyDay(value);

            ds_Return.Tables.Add(dt);

        }
        #endregion

        #region 获取维修费用和成本(This is Joke ^_^)

        private DataTable GetMoneyDay(string value)
        {

            string select = @"SELECT T2.[Value] AS [Money]
                                    ,T3.[Value] AS [Day]
                              FROM [dbo].[SPWX_WXDict] T1
                              LEFT JOIN [dbo].[SPWX_WXDict] T2
                              ON T1.HowMuch = T2.[Lev] AND T2.[Type] = 'money'
                              LEFT JOIN  [dbo].[SPWX_WXDict] T3
                              ON T1.[Day] = T3.[Lev] AND T3.[Type] = 'day'
                              WHERE T1.[Value] = @Param0";
            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt 
                = dbh.GetData(select, new object[] { value });

            return dt;
        }
        #endregion

        #region 获取供应商
        private DataTable GetSupplierInfo(string SKU)
        {
            string sku = SKU;
            sku = FilterSpecial(sku);

            DBHandle dbh = new DBHandle("F22GP");

            object[] paramObj = new object[4];

            object[] paramVal = new object[4];

            paramObj[0] = SParam.InputFormat;
            paramObj[1] = SParam.OutputFormat;
            paramObj[2] = SParam.OutputContentType;
            paramObj[3] = SParam.ConditionStr;

            paramVal[0] = "AML";
            paramVal[1] = "DB";
            paramVal[2] = "RS";
            paramVal[3] = "【操作类型,GET】【实体,J_Supplier】"
                +"【返回内容,供应商ID,供应商简称，供应商全称】"
                +"【条件内容,《W》款号】【《W》款号,"+sku+"】";

            //used "[API_Product].[GetProdInfo]" sp in 200.120.
            DataTable dt 
                = dbh.GetDataBySP("[API_Product].[GetProdInfo]", paramObj, paramVal);

            return dt;
        }
        #endregion

        #region 获取维修单DataGrid
        private void GetWXListDg(string where,object[] o)
        {
            string select = @"SELECT T1.[Id]
                          ,T2.[WXNo]
                          ,T2.[SKU]
                          ,T2.[Status]
                          ,T15.[Name] AS [StatusName]
                          ,T2.[WxStatus]
                          ,T14.[Name] AS [WXSTName]
                          ,T2.[WarehouseNo]
                          ,T2.[WarehouseName]
                          ,T2.[Remark]
                          ,T2.[RespName]
                          ,T2.[RespPhone]
                          ,T2.[StaffName]
                          ,T2.[StaffPhone]
                          ,T2.[DepotArea]
                          ,T2.[DepotName]
                          ,T2.[DepotPhone]
                          ,T2.[DepotId]
                          ,T2.[UrgentLevel]
                          ,T20.[Remark] AS ULName
                          ,T2.[VIPID]
                          ,T2.[VIPName]
                          ,T2.[VIPPhone]
                          ,T2.[Express]
                          ,T2.[SendAddress]
                          ,T2.[TakeAddress]
                          ,T17.[Name] AS [DpExpName]
                          ,T2.[ExpressNo] AS [DpExpNo]
                          ,T2.[TakeMan]
                          ,T2.[TakeManPhone]
                          ,T1.[ExpName]
                          ,T21.[Name] AS [ZBExpName]
                          ,T1.[ExpNo] AS [ZBExpNo]
                          ,CASE T2.[Collect] WHEN 'yes' THEN '愿意'
                           WHEN 'no' THEN '不愿意' END AS [Collect]
                          ,CONVERT(varchar, T2.[BackDate], 23) AS [BackDate]
                          ,T2.[Question]
                          ,[SupplierId]
                          ,[SupplierName]
                          ,[FirstOrigin]
                          ,T16.[Name] AS [FOName]
                          ,[FirstQust]
                          ,T4.[Name] AS [FQName]
                          ,[FirstPhen]
                          ,T5.[Name] AS [FPName]
                          ,[SecondOrigin]
                          ,T6.[Name] AS [SOName]
                          ,[SecondQust]
                          ,T7.[Name] AS [SQName]
                          ,[SecondPhen]
                          ,T8.[Name] AS [SPName]
                          ,[FirstDecide]
                          ,[SecondDecide]
                          ,[ThirdDecide]
                          ,[FixLength]
                          ,[SecFixLen]
                          ,[SecFixPlace]
                          ,[FixPlace]
                          ,[SealNo]
                          ,[aaa]
                          ,[DecideRst]
                          ,T9.[Name] AS [DRName]
                          ,[Department]
                          ,T10.[Name] AS [DMName]
                          ,[Warehouse]
                          ,T11.[Name] AS [WHName]
                          ,[ReturnNo]
                          ,[FixType]
                          ,T12.[Name] AS [FTName]
                          ,[Cost]
                          ,T13.[Name] AS [CTName]
                          ,ISNULL([FixNeedTime],'无') AS [FixNeedTime]
                          ,ISNULL([FixNeedMoney],'无') AS [FixNeedMoney]
                          ,T1.[FinishMan]
                          ,T18.[Name] AS [FinManName]
                          ,T1.[IsFinish]
                          ,CONVERT(varchar(100), T1.[FinishDate], 23) AS [FinishDate]
                          ,T1.[FinishPoint]
                          ,T19.[Name] AS [FinPntName]
                          ,T1.[FinishMoney]
                      FROM [dbo].[SPWX_Main] T2 WITH(NOLOCK)
                      LEFT JOIN [dbo].[SPWX_Headquarters] T1 WITH(NOLOCK) 
                      ON T1.WXNo = T2.WXno
                      LEFT JOIN [dbo].[SPWX_WXDict] T3 WITH(NOLOCK)
                      ON T1.FirstPhen = T3.Value AND T3.[Type] = 'nature'
                      LEFT JOIN [dbo].[SPWX_WXDict] T4 WITH(NOLOCK)
                      ON T1.FirstQust = T4.Value AND T4.[Type] = 'origin'
                      LEFT JOIN [dbo].[SPWX_WXDict] T5 WITH(NOLOCK)
                      ON T1.FirstPhen = T5.Value AND T5.[Type] = 'phenomenon'
                      LEFT JOIN [dbo].[SPWX_WXDict] T6 WITH(NOLOCK)
                      ON T1.SecondOrigin = T6.Value AND T6.[Type] = 'nature'
                      LEFT JOIN [dbo].[SPWX_WXDict] T7 WITH(NOLOCK)
                      ON T1.SecondQust = T7.Value AND T7.[Type] = 'origin'
                      LEFT JOIN [dbo].[SPWX_WXDict] T8 WITH(NOLOCK)
                      ON T1.SecondPhen = T8.Value AND T8.[Type] = 'phenomenon'
                      LEFT JOIN [dbo].[SPWX_Dict] T9 WITH(NOLOCK)
                      ON T1.DecideRst = T9.Value AND T9.[Type] = 'result'
                      LEFT JOIN [dbo].[SPWX_Dict] T10 WITH(NOLOCK)
                      ON T1.Department = T10.Value AND T10.[Type] = 'blame'
                      LEFT JOIN [dbo].[SPWX_Dict] T11 WITH(NOLOCK)
                      ON T1.Warehouse = T10.Value AND T11.[Type] = 'degrade'
                      LEFT JOIN [dbo].[SPWX_Dict] T12 WITH(NOLOCK)
                      ON T1.FixType = T12.Value AND T12.[Type] = 'maintainway'
                      LEFT JOIN [dbo].[SPWX_Dict] T13 WITH(NOLOCK)
                      ON T1.Cost = T13.Value AND T13.[Type] = 'charge'
                      LEFT JOIN [dbo].[SPWX_Dict] T14 WITH(NOLOCK)
                      ON T2.WXStatus = T14.Value AND T14.[Type] = 'WXType'
                      LEFT JOIN [dbo].[SPWX_Dict] T15 WITH(NOLOCK)
                      ON T2.[Status] = T15.Value AND T15.[Type] = 'Status'
                      LEFT JOIN [dbo].[SPWX_WXDict] T16 WITH(NOLOCK)
                      ON T1.FirstOrigin = T16.Value AND T16.[Type] = 'nature' 
                      LEFT JOIN [dbo].[SPWX_Dict] T17 WITH(NOLOCK)
                      ON T2.[Express] = T17.Value AND T17.[Type] = 'Express'
                      LEFT JOIN [dbo].[SPWX_Dict] T18 WITH(NOLOCK)
                      ON T1.[FinishMan] = T18.Value AND T18.[Type] = 'FinMan'
                      LEFT JOIN [dbo].[SPWX_WXDict] T19 WITH(NOLOCK)
                      ON T1.[FinishPoint] = T19.Value AND T19.[Type] = 'finish'
                      LEFT JOIN [dbo].[SPWX_Dict] T20 WITH(NOLOCK)
                      ON T2.[UrgentLevel] = T20.Value AND T20.[Type] = 'Level' 
                      LEFT JOIN [dbo].[SPWX_Dict] T21 WITH(NOLOCK)
                      ON T1.[ExpName] = T21.Value AND T21.[Type] = 'Express' ";

            select += where;
            select += " ORDER BY T1.[ModifyTime] DESC";

            DBHandle dbh = new DBHandle("SPWX");

            DataTable dt = dbh.GetData(select, o);

            this.ds_Return.Tables.Add(dt);

        }
        #endregion

        #region 查询维修单DataGrid
        private void SearchWXDg()
        { 
            int rows = this.dtList.Rows.Count;

            string where = " WHERE 1=1 AND T2.[Status] > 20 ";

            if (rows > 0)
            {
                this.objVal = new object[this.dtList.Columns.Count];
                for (int i = 0; i < this.dtList.Columns.Count; i++)
                {
                    if (this.dtList.Columns[i].ColumnName == "Wxno")
                    {
                        where += " AND T2." + this.dtList.Columns[i].ColumnName;
                        where += " = @Param" + i;
                    }
                    else if (this.dtList.Columns[i].ColumnName == "DepotName")
                    {
                        where += " AND T2." + this.dtList.Columns[i].ColumnName;
                        where += " LIKE '%' + @Param" + i + " + '%'";
                    }


                    this.objVal[i]
                        = FilterSpecial(this.dtList.Rows[0][i].ToString());
                };
            }
            else 
            {
                this.objVal = new object[0];
            };

            GetWXListDg(where, this.objVal);
        }
        #endregion

        #region 获取完成信息
        private void GetFinInfo() 
        {
            string IsFin = 
                        @"SELECT [Value]
                                ,[Name]
                        FROM [dbo].[SPWX_Dict]
                        WHERE [Type] = 'finRst' AND [Status] = '0'";
            string FinMan =
                        @"SELECT [Value]
                                ,[Name]
                            FROM [dbo].[SPWX_Dict]
                            WHERE [Type] = 'FinMan' AND [Status] = '0'";
            string FinPntMon =
                        @"SELECT T1.[Value] AS Point
                                ,T1.[Name] AS PointName
                                ,T2.[Name] AS MoneyName
                            FROM [dbo].[SPWX_WXDict] T1
                            LEFT JOIN [dbo].[SPWX_WXDict] T2
                            ON T1.HowMuch = T2.Lev AND T2.[Type] = 'money'
                            WHERE T1.[Type] = 'finish'";
            string ExpCom =
                        @"SELECT [Value]
                                ,[Name]
                            FROM [dbo].[SPWX_Dict]
                            WHERE [Type] = 'Express' AND [Status] = 0";
            DBHandle dbh = new DBHandle("SPWX");

            DataTable dtIsFin = dbh.GetData(IsFin, new object[0]);
            DataTable dtFinMan = dbh.GetData(FinMan, new object[0]);
            DataTable dtPntMon = dbh.GetData(FinPntMon, new object[0]);
            DataTable dtExpCom = dbh.GetData(ExpCom, new object[0]);

            dtIsFin.TableName = "dtIsFin";
            dtFinMan.TableName = "dtFinMan";
            dtPntMon.TableName = "dtPntMon";
            dtExpCom.TableName = "dtExpCom";

            this.ds_Return.Tables.Add(dtIsFin);
            this.ds_Return.Tables.Add(dtFinMan);
            this.ds_Return.Tables.Add(dtPntMon);
            this.ds_Return.Tables.Add(dtExpCom);
        }
        #endregion

        #region 维修完成保存
        /// <summary>
        /// logic:
        /// 1.Update 'finish' field in table [dbo].[SPWX_Headquarters].
        /// 2.Update 'status' field in table [dbo].[SPWX_Main].
        /// 3.Insert history in [dbo.SPWX_Hist] Table.
        /// </summary>
        private void SaveFin()
        {

            DataRow drRow = this.dt_Return.NewRow();

            string beforeStatus = "";

            string wxno 
                = this.dtList.Rows[0]["Wxno"].ToString();

            string Headquarters = @"
                            SELECT [Id]
                                  ,[IsFinish]
                                  ,[FinishMan]
                                  ,[FinishDate]
                                  ,[FinishPoint]
                                  ,[FinishMoney]
                                  ,[ModifyUser]
                                  ,[ModifyTime]
                              FROM [dbo].[SPWX_Headquarters] WHIT(NOLOCK)
                              WHERE [WXNo] = @Param0";
            string Main = @"
                            SELECT [ID]
                                  ,[Status]
                                  ,[ModifyTime]
                                  ,[ModifyUser]
                              FROM [dbo].[SPWX_Main] WHIT(NOLOCK)
                              WHERE [WXNo] = @Param0";
            string Hist = @"
                            SELECT TOP 0 * FROM [dbo].[SPWX_Hist] WITH(NOLOCK)";

            try
            {
                DBHandle dbh = new DBHandle("SPWX");

                DataTable dtUp
                    = dbh.GetData(Headquarters, new object[1] { wxno });

                DataTable dtMain
                    = dbh.GetData(Main, new object[1] { wxno });

                DataTable dtHist
                    = dbh.GetData(Hist, new object[0]);


                //这里防止对象未初始化.
                if (dtUp != null && dtMain != null && dtHist != null)
                {
                    if (dtUp.Rows.Count > 0)
                    {
                        string date = this.dtList.Rows[0]["FinishDate"].ToString();
                        DateTime datetime = DateTime.Parse(date);
                        
                        dtUp.Rows[0]["IsFinish"]
                            = FilterSpecial(this.dtList.Rows[0]["IsFinish"].ToString());
                        dtUp.Rows[0]["FinishMan"]
                            = FilterSpecial(this.dtList.Rows[0]["FinishMan"].ToString());

                        dtUp.Rows[0]["FinishDate"]= datetime;
                        
                        dtUp.Rows[0]["FinishPoint"]
                            = FilterSpecial(this.dtList.Rows[0]["FinishPoint"].ToString());
                        dtUp.Rows[0]["FinishMoney"]
                            = FilterSpecial(this.dtList.Rows[0]["FinishMoney"].ToString());

                        dtUp.Rows[0]["ModifyUser"] = base.m_hzyMessage.User_Name;
                        dtUp.Rows[0]["ModifyTime"] = this.timeNow;
                    };

                    if (dtMain.Rows.Count > 0)
                    {
                        beforeStatus = dtMain.Rows[0]["Status"].ToString();
                        dtMain.Rows[0]["Status"] = "40";
                        dtMain.Rows[0]["ModifyTime"] = this.timeNow;
                        dtMain.Rows[0]["ModifyUser"] = base.m_hzyMessage.User_Name;
                    };

                    DataRow dr = dtHist.NewRow();

                    dr["Wxno"] = wxno;
                    dr["BeforeStatus"] = beforeStatus;
                    dr["AfterStatus"] = "40";
                    dr["Content"] = "维修单已经维修完成，结果为:"
                        + FilterSpecial(this.dtList.Rows[0]["IsFinish"].ToString());
                    dr["ModifyUser"] = base.m_hzyMessage.User_Name;

                    dtHist.Rows.Add(dr);

                    if (dtUp.Rows.Count > 0 && dtMain.Rows.Count > 0)
                    {
                        dtUp.TableName = "[dbo].[SPWX_Headquarters]";
                        dtMain.TableName = "[dbo].[SPWX_Main]";
                        dtHist.TableName = "[dbo].[SPWX_Hist]";

                        DataSet ds = new DataSet();

                        ds.Tables.Add(dtUp);
                        ds.Tables.Add(dtMain);
                        ds.Tables.Add(dtHist);

                        this.bRst = dbh.UpdateDB("ID", ds);

                        if (this.bRst)
                        {
                            drRow["result"] = true;
                            drRow["message"] = "提交成功";
                        }
                        else
                        {
                            drRow["result"] = false;
                            drRow["message"] = "提交失败";
                        };

                        this.dt_Return.Rows.Add(drRow);

                        this.ds_Return.Tables.Add(this.dt_Return);

                    };
                };
            }
            catch (Exception ex)
            {
                drRow["result"] = false;
                drRow["message"] = ex.Message;

                this.dt_Return.Rows.Add(drRow);

                this.ds_Return.Tables.Add(this.dt_Return);

            };

        }
        #endregion

        #region 获取供应商前台
        private void GetSupplier()
        {
            string sku
                = this.dtList.Rows[0]["SKU"].ToString();
            DataTable dt = GetSupplierInfo(sku);

            this.ds_Return.Tables.Add(dt);
        }
        #endregion

        #region 更新维修单
        private void UpdateFix()
        {
            string wxno 
                = this.dtList.Rows[0]["wxno"].ToString();
            string beforeSta = "";

            try
            {
                DBHandle dbh = new DBHandle("SPWX");

                string Headp = @"
                        SELECT * FROM 
                        [dbo].[SPWX_Headquarters] WITH(NOLOCK)
                        WHERE [WXNo] = @Param0";
                string Main = @"
                        SELECT [ID]
                              ,[Status]
                              ,[ModifyTime]
                              ,[ModifyUser]
                        FROM [dbo].[SPWX_Main] WITH(NOLOCK)
                        WHERE [WXNo] = @Param0";
                string Hist = @"
                        SELECT TOP 0 * FROM 
                        [dbo].[SPWX_Hist] WITH(NOLOCK)";

                DataTable dtHp
                    = dbh.GetData(Headp, new object[1] { wxno });
                DataTable dtMain
                    = dbh.GetData(Main, new object[1] { wxno });
                DataTable dtHi
                    = dbh.GetData(Hist, new object[0]);

                if (dtHp != null && dtMain != null && dtHi != null)
                {

                    if (dtHp.Rows.Count > 0)
                    {
                        dtHp.Rows[0]["FirstOrigin"] = this.dtList.Rows[0]["FirstOrigin"];
                        dtHp.Rows[0]["FirstQust"] = this.dtList.Rows[0]["FirstQust"];
                        dtHp.Rows[0]["FirstPhen"] = this.dtList.Rows[0]["FirstPhen"];
                        dtHp.Rows[0]["SecondOrigin"] = this.dtList.Rows[0]["SecondOrigin"];
                        dtHp.Rows[0]["SecondQust"] = this.dtList.Rows[0]["SecondQust"];
                        dtHp.Rows[0]["SecondPhen"] = this.dtList.Rows[0]["SecondPhen"];
                        dtHp.Rows[0]["FirstDecide"] = this.dtList.Rows[0]["FirstDecide"];
                        dtHp.Rows[0]["SecondDecide"] = this.dtList.Rows[0]["SecondDecide"];
                        dtHp.Rows[0]["ThirdDecide"] = this.dtList.Rows[0]["ThirdDecide"];
                        dtHp.Rows[0]["FixLength"] = this.dtList.Rows[0]["FixLength"];
                        //dtHp.Rows[0]["FixPlace"] = this.dtList.Rows[0]["FixPlace"];
                        dtHp.Rows[0]["SecFixLen"] = this.dtList.Rows[0]["SecFixLen"];
                        //dtHp.Rows[0]["SecFixPlace"] = this.dtList.Rows[0]["SecFixPlace"];
                        dtHp.Rows[0]["ModifyUser"] = base.m_hzyMessage.User_Name;
                        dtHp.Rows[0]["ModifyTime"] = timeNow;
                    };

                    if (dtMain.Rows.Count > 0)
                    {
                        dtMain.Rows[0]["ModifyTime"] = timeNow;
                        dtMain.Rows[0]["ModifyUser"] = base.m_hzyMessage.User_Name;

                        beforeSta = dtMain.Rows[0]["Status"].ToString();
                    };

                    DataRow dr = dtHi.NewRow();

                    dr["WXNo"] = wxno;
                    dr["BeforeStatus"] = beforeSta;
                    dr["AfterStatus"] = beforeSta;
                    dr["Content"] = "进行了维修再判定操作";
                    dr["ModifyTime"] = timeNow;
                    dr["ModifyUser"] = base.m_hzyMessage.User_Name;

                    dtHi.Rows.Add(dr);

                    if (dtHp.Rows.Count > 0
                        && dtHi.Rows.Count > 0
                        && dtMain.Rows.Count > 0)
                    {
                        dtHp.TableName = "[dbo].[SPWX_Headquarters]";
                        dtMain.TableName = "[dbo].[SPWX_Main]";
                        dtHi.TableName = "[dbo].[SPWX_Hist]";

                        DataSet ds = new DataSet();

                        ds.Tables.Add(dtHp);
                        ds.Tables.Add(dtMain);
                        ds.Tables.Add(dtHi);
                        this.bRst = dbh.UpdateDB("ID", ds);
                    };
                };

                DataRow drRow = this.dt_Return.NewRow();

                if (this.bRst)
                {
                    drRow["result"] = true;
                    drRow["message"] = "提交成功";
                }
                else{
                    drRow["result"] = false;
                    drRow["message"] = "提交失败";
                };

                this.dt_Return.Rows.Add(drRow);

                this.ds_Return.Tables.Add(this.dt_Return);
               
            }
            catch (Exception ex)
            {
                DataRow drRow = this.dt_Return.NewRow();
                drRow["result"] = false;
                drRow["message"] = ex.Message;

                this.dt_Return.Rows.Add(drRow);
                this.ds_Return.Tables.Add(this.dt_Return);
            };
        }
        #endregion

        #region 存快递单
        private void SaveExp()
        {
            DataRow drRow = this.dt_Return.NewRow();
            DataTable dt = this.dtList.Copy();

            string wxno = "";
            
            int count = dt.Rows.Count;

            object[] o = new object[count];

            for (int i = 0; i < count; i++)
            { 
                if(i !=count-1)
                {
                    wxno += "@Param" + i + ",";
                    
                }
                else if (i == count - 1)
                {
                    wxno += "@Param" + i;
                   
                };
                o[i] = dt.Rows[i]["Wxno"].ToString();
            };

            string headp = @"
                    SELECT [Id]
                          ,[ExpName]
                          ,[ExpNo]
                          ,[ModifyUser]
                          ,[ModifyTime]
                      FROM [dbo].[SPWX_Headquarters] WITH(NOLOCK)
                      WHERE WXNO in (" + wxno + ")";
            string main = @"
                    SELECT [ID]
                        ,[Wxno]
                        ,[Status]
                        ,[ModifyTime]
                        ,[ModifyUser]
                    FROM [dbo].[SPWX_Main] WITH(NOLOCK)
                    WHERE ([Status] = 40 or [Status] = 26) 
                    AND WXNO IN ("+wxno+")";
            string hist = @"
                    SELECT TOP 0 * FROM [dbo].[SPWX_Hist] WITH(NOLOCK)";
            try
            {
                DBHandle dbh = new DBHandle("SPWX");

                DataTable dtHp = dbh.GetData(headp, o);
                DataTable dtMa = dbh.GetData(main, o);
                DataTable dtHi = dbh.GetData(hist, new object[0]);


                if (dtHi != null && dtHp != null && dtMa != null)
                {
                    //
                    if(dtHp.Rows.Count == dt.Rows.Count)
                    {
                        for (int i = 0; i < dtHp.Rows.Count; i++)
                        {
                            dtHp.Rows[i]["ExpName"] = dt.Rows[i]["ExpName"];
                            dtHp.Rows[i]["ExpNo"] = dt.Rows[i]["ExpNo"].ToString().ToUpper();
                            dtHp.Rows[i]["ModifyUser"] = base.hzyMessage.User_Name;
                            dtHp.Rows[i]["ModifyTime"] = timeNow;
                        };
                    };

                    //
                    if (dtMa.Rows.Count == dt.Rows.Count)
                    {
                        for (int i = 0; i < dtMa.Rows.Count; i++)
                        {
                            DataRow dr = dtHi.NewRow();

                            dr["WXNo"] = dtMa.Rows[i]["Wxno"];
                            dr["BeforeStatus"] = dtMa.Rows[i]["Status"];
                            dr["AfterStatus"] = "45";
                            dr["Content"] = "总部已经发货";
                            dr["ModifyTime"] = timeNow;
                            dr["ModifyUser"] = base.hzyMessage.User_Name;

                            dtHi.Rows.Add(dr);

                            dtMa.Rows[i]["Status"] = "45";
                            dtMa.Rows[i]["ModifyUser"] = base.hzyMessage.User_Name;
                            dtMa.Rows[i]["ModifyTime"] = timeNow;
                        };
                    };

                    dtHp.TableName = "[dbo].[SPWX_Headquarters]";
                    dtMa.TableName = "[dbo].[SPWX_Main]";
                    dtHi.TableName = "[dbo].[SPWX_Hist]";

                    DataSet ds = new DataSet();
                    ds.Tables.Add(dtHp);
                    ds.Tables.Add(dtMa);
                    ds.Tables.Add(dtHi);

                    this.bRst = dbh.UpdateDB("ID", ds);
                    

                    if (this.bRst)
                    {
                        drRow["result"] = true;
                        drRow["message"] = "提交成功";
                    }
                    else
                    {
                        drRow["result"] = false;
                        drRow["message"] = "提交失败";
                    };
                };
            }
            catch (Exception ex)
            {
                drRow["result"] = false;
                drRow["message"] = ex.Message;
                this.dt_Return.Rows.Add(drRow);
                this.ds_Return.Tables.Add(this.dt_Return);
                throw;
            };

            this.dt_Return.Rows.Add(drRow);

            this.ds_Return.Tables.Add(this.dt_Return);
        }
        #endregion

        //Public

        #region 清洗特殊字符

        /// <summary>
        /// 过滤特殊字符
        /// 如果字符串为空，直接返回。
        /// </summary>
        /// <param name="str">需要过滤的字符串</param>
        /// <returns>过滤好的字符串</returns>
        private string FilterSpecial(string str)
        {
            if (str == "")
            {
                return str;
            }
            else
            {
                str = str.Replace("select", "");
                str = str.Replace("delete", "");
                str = str.Replace("drop", "");
                str = str.Replace("insert", "");
                str = str.Replace("update", "");
                str = str.Replace("'", "");
                str = str.Replace("<", "");
                str = str.Replace(">", "");
                str = str.Replace("%", "");
                str = str.Replace("''", "");
                str = str.Replace("\"\"", "");
                str = str.Replace(",", "");
                str = str.Replace(".", "");
                str = str.Replace(">=", "");
                str = str.Replace("=<", "");
                str = str.Replace("-", "");
                str = str.Replace("_", "");
                str = str.Replace(";", "");
                str = str.Replace("||", "");
                str = str.Replace("[", "");
                str = str.Replace("]", "");
                str = str.Replace("&", "");
                str = str.Replace("#", "");
                str = str.Replace("/", "");
                str = str.Replace("-", "");
                str = str.Replace("|", "");
                str = str.Replace("?", "");
                str = str.Replace(">?", "");
                str = str.Replace("?<", "");
                str = str.Replace(" ", "");

                return str;
            }
        }

        #endregion

        /// <summary>
        /// 这是获取维修单号的唯一方法，防止出现同时取最大号的情况
        /// 使用的技术叫做: Double check Lock
        /// </summary>
        /// <returns>快递单号,如果是0则表示生成失败</returns>
        #region 获取最大维修单号
        private static int getMaxWXNo()
        {
            int iRst = 0;

            if (dbhle == null)
            {
                lock (syncRoot)
                {
                    if (dbhle == null)
                    {
                        dbhle = new DBHandle("SPWX");

                        string select = @"SELECT [ID],[Value] 
                              FROM [dbo].[SPWX_Dict]
                              WHERE Type = 'MaxWxNo'";

                        DataTable dtMax = dbhle.GetData(select, new object[0]);
                        int iMax = Int32.Parse(dtMax.Rows[0][1].ToString());

                        iRst = ++iMax;

                        dtMax.Rows[0][1] = iRst.ToString();

                        bool b = dbhle.Update("[dbo].[SPWX_Dict]", "ID", dtMax);

                        if (!b)
                        {
                            iRst = 0;
                        };
                    };
                    dbhle = null;
                };
            };

            return iRst;

        }
        #endregion
        

        #endregion
    }
}
