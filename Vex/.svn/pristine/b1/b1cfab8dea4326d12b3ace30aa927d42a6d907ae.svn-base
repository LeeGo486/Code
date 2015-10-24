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

/// 类名：FLEXPLMProduct
/// 类说明：PLMAS-产品-日款式上传于分配信息报表
/// 创建人：马卫清
/// 创建日期：2014-04-21
/// 修改人： 刘洪
/// 修改日期： 2014-10-28
/// 修改内容: 将内部函数 与GetData剥离开，规范化代码并添加新内容。
///


namespace HZY.COM.WS.PLMAS
{

    public class FLEXPLMProduct : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public FLEXPLMProduct()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn conn;

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        DataSet ds = new DataSet();

        DataSet ds_Return = new DataSet();

        DataTable dtList = new DataTable();

        DateTime timeNow = DateTime.Now;

        #endregion




        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                dtList = ds.Tables["List"];

                var strzt = dtList.Rows[0]["zt"].ToString();//获取帐套

                conn = new Dbconn("PLM_AS_" + strzt);


                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET".ToUpper())
                {
                    GET();
                };
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetMaterial".ToUpper())     //获取材料关联数据SearchDg
                {
                    GetMaterial(strzt);
                };
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SearchDg".ToUpper())     //获取材料查询数据
                {
                    SearchDg();
                };
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "materialSave".ToUpper())     //材料关联保存
                {
                    materialSave();
                };
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "materialUpdate".ToUpper())     //材料关联删除
                {
                    materialUpdate();
                };
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "sureSample".ToUpper())
                {
                    sureSample();
                }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }



        #region  内部函数

        //---刘洪剥离出来的方法（代码内容未修改，只迁移位置）
        #region Get
        private void GET()
        {
            string strBeginCreateDate = "";
            string strEndCreateDate = "";
            string strDesigner = "";
            string strDesignerID = "";
            string strBrand = "";
            string strPlmSeason = "";
            m_hzyPageInfo.Order = " DESC ";
            m_hzyPageInfo.Sort = " Designer ";

            //不进行分页
            m_hzyPageInfo.PageRowCount = 0;

            //获取权限
            string strUserPost = conn.GetDataTableFirstValue(@"
																		SELECT  UserPost
																		FROM    Userinfo
																		WHERE   username = @Param0
																		", new string[] { m_hzyMessage.User_Name }).ToString();


            string strSQL = @"
								SELECT 
									t3.Designer  ,
									t3.DesignImageSmall  ,
									t3.DesignImageBig,
									t3.DesignerId  ,
									t3.Category  ,
									t3.BoDuan  ,
									t3.BoDuanSeries  ,
									t3.ProductType  ,
									t3.OrderSeason ,
									t3.Part  ,
									t3.CreateDate ,
									t3.ProductName,
                                    t3.PlmSeason,
                                    t3.Brand,
                                    t3.SelectSample,
							        ISNULL(t9.Stat,'') Stat
                                    FROM [FLEXPLMProduct] t3
                                    LEFT JOIN dbo.PMINFO t9 ON t9.ProductName = t3.ProductName
							        WHERE 1=1 ";

            strBrand = dtList.Rows[0]["Brand"].ToString();


            strSQL += @" AND t3.Brand = '" + strBrand + "' ";

            //设计号
            if (dtList.Rows.Count > 0 && dtList.Columns.Contains("DesignerId"))
            {
                strDesignerID = dtList.Rows[0]["DesignerId"].ToString();
                if (strDesignerID != "")
                {
                    strSQL += " AND DesignerID= '" + strDesignerID + "'";

                }

            };
            //开始时间
            if (dtList.Rows.Count > 0 && dtList.Columns.Contains("BeginDate"))
            {
                strBeginCreateDate = dtList.Rows[0]["BeginDate"].ToString();
                if (strBeginCreateDate != "")
                {
                    strSQL += " AND CONVERT(varchar(10),CreateDate,21)>= CONVERT(varchar(10), '" + strBeginCreateDate + "',21)";
                }
            };

            //结束时间 
            if (dtList.Rows.Count > 0 && dtList.Columns.Contains("EndDate"))
            {
                strEndCreateDate = dtList.Rows[0]["EndDate"].ToString();
                if (strEndCreateDate != "")
                {
                    strSQL += " AND CONVERT(varchar(10),CreateDate,21)<= CONVERT(varchar(10), '" + strEndCreateDate + "',21)";
                }
            };

            //季节
            if (dtList.Rows.Count > 0 && dtList.Columns.Contains("PlmSeason"))
            {
                strPlmSeason = dtList.Rows[0]["PlmSeason"].ToString();
                if (strPlmSeason != "")
                {
                    strSQL += " AND t3.PlmSeason = '"+strPlmSeason+"' ";
                }
            };

            //设计师
            if (dtList.Rows.Count > 0 && dtList.Columns.Contains("Designer"))
            {
                strDesigner = dtList.Rows[0]["Designer"].ToString();

                strDesigner = "'" + strDesigner.Replace(",", "','") + "'";
                if (strDesigner != "")
                {
                    strSQL += " AND (Designer in (" + strDesigner + ")) ";
                }

            }
            else //如果没有传入，默认为能够看的所有数据
            {

                if (strUserPost == "管理员")
                {
                    strSQL += @" AND (Designer in (  SELECT  UserNameC
									FROM    Userinfo
									WHERE   UserPost = '设计师')";
                }
                else if (strUserPost == "版师助理")
                {
                    strSQL += @" AND (Designer in (  SELECT  UserNameC
								FROM    Userinfo
								WHERE   OwnedBrand IN (
								SELECT OwnedBrand FROM Userinfo
								WHERE username= '" + m_hzyMessage.User_Name + @"'
								))";
                }
                else
                {
                    strSQL += @" AND (Designer in (  SELECT  UserNameC
								FROM    Userinfo
								WHERE username= '" + m_hzyMessage.User_Name + "'))";
                }

            };

            if (strUserPost == "设计师"){
                string strBrandPowerSQL = @"SELECT DISTINCT CBSTKY FROM pbinfo 
                                                    WHERE cbstco = '" + strUserPost + @"' 
                                                    AND CBTX40 = '" + m_hzyMessage.User_Name_CN + "'";

                string strLinkUserIdSQL = @"SELECT Linkuserid FROM USERINFO 
                                                            WHERE username = '" + m_hzyMessage.User_Name + "'";

                DataTable dtBrandPower = conn.GetDataTable(strBrandPowerSQL);
                string strLinkUserId = conn.GetDataTableFirstValue(strLinkUserIdSQL).ToString();

                //判断品牌权限
                int iPowerNum = dtBrandPower.Rows.Count;

                if (iPowerNum > 0)
                {
                    do
                    {
                        int i = iPowerNum - 1;
                        string strBrandDiff = dtBrandPower.Rows[i]["CBSTKY"].ToString();
                        if (strBrandDiff == strBrand)
                        {
                            break;
                        };
                        if (i == 0) {
                            strSQL += " AND 1<>1 ";
                        };
                        iPowerNum--;
                    } while (iPowerNum > 0);
                }
                else {
                    strSQL += @" AND 1<>1 ";
                };

                //判断LinkID
                if (strLinkUserId == "ALL") { 

                }
                else if (strLinkUserId == "" || strLinkUserId == "NULL")
                {
                    strSQL += " AND t3.Designer = '" + m_hzyMessage.User_Name_CN + "' ";
                }
                else {
                    strLinkUserId = strLinkUserId.Replace("/", "','");
                    strSQL += @"UNION
                                SELECT  t3.Designer ,
                                        t3.DesignImageSmall ,
                                        t3.DesignImageBig ,
                                        t3.DesignerId ,
                                        t3.Category ,
                                        t3.BoDuan ,
                                        t3.BoDuanSeries ,
                                        t3.ProductType ,
                                        t3.OrderSeason ,
                                        t3.Part ,
                                        t3.CreateDate ,
                                        t3.ProductName ,
                                        t3.SelectSample,
                                        ISNULL(t9.Stat, '') Stat
                                FROM    [FLEXPLMProduct] t3
                                        LEFT JOIN dbo.PMINFO t9 ON t9.ProductName = t3.ProductName
                                WHERE   1 = 1
                                        AND CONVERT(VARCHAR(10), CreateDate, 21) >= CONVERT(VARCHAR(10), @param0, 21)
                                        AND CONVERT(VARCHAR(10), CreateDate, 21) <= CONVERT(VARCHAR(10), @param1, 21) ";
                    strSQL += @" AND Designer IN ('"+strLinkUserId+"')";
                }
                //-------------------------旧逻辑
//                if (dtList.Rows.Count > 0 && dtList.Columns.Contains("Designer"))
//                {
//                    if (dtList.Rows[0]["Designer"].ToString() == "")
//                    {
//                        strSQL += @"
//							OR EXISTS  (		
//							 SELECT 1
//							 FROM   dbo.WsUserPower t1
//									LEFT JOIN dbo.userinfo t2 ON t1.UserID = t2.username
//							 WHERE  (t2.LinkUserId LIKE '%" + m_hzyMessage.User_Name + @"%'
//									AND t2.UserNameC IS NOT NULL 
//									AND t3.PlmSeason = t1.Season
//                                    AND t1.StyleSeries = t3.BoDuanSeries
//									AND t3.Designer = t2.UserNameC)";
//                    }
//                    else
//                    {
//                        strSQL += @"
//							AND EXISTS  (
//			
//							 SELECT 1
//							 FROM   dbo.WsUserPower t1
//									LEFT JOIN dbo.userinfo t2 ON t1.UserID = t2.username
//							 WHERE  (t2.LinkUserId LIKE '%" + m_hzyMessage.User_Name + @"%'
//									AND t2.UserNameC IS NOT NULL 
//									AND t3.PlmSeason = t1.Season
//                                    AND t1.StyleSeries = t3.BoDuanSeries
//									AND t3.Designer = t2.UserNameC)
//									)  )
//                                       
//					";
//                        string UserNameC1 = conn.GetDataTableFirstValue(@"SELECT  UserNameC FROM Userinfo 
//                                                                        WHERE   username = @Param0
//                                                                        ", new string[] { m_hzyMessage.User_Name }).ToString();
//                        if (strDesigner.IndexOf(UserNameC1) > -1)
//                        {
//                            strSQL += @"UNION
//                                SELECT  t3.Designer ,
//                                        t3.DesignImageSmall ,
//                                        t3.DesignImageBig ,
//                                        t3.DesignerId ,
//                                        t3.Category ,
//                                        t3.BoDuan ,
//                                        t3.BoDuanSeries ,
//                                        t3.ProductType ,
//                                        t3.OrderSeason ,
//                                        t3.Part ,
//                                        t3.CreateDate ,
//                                        t3.ProductName ,
//                                        ISNULL(t9.Stat, '') Stat
//                                FROM    [FLEXPLMProduct] t3
//                                        LEFT JOIN dbo.PMINFO t9 ON t9.ProductName = t3.ProductName
//                                WHERE   1 = 1
//                                        AND CONVERT(VARCHAR(10), CreateDate, 21) >= CONVERT(VARCHAR(10), @param0, 21)
//                                        AND CONVERT(VARCHAR(10), CreateDate, 21) <= CONVERT(VARCHAR(10), @param1, 21)
//                                        AND ( Designer in  (  SELECT  UserNameC FROM    Userinfo WHERE username=@param4)  )";
//                        }
//                        else
//                        {

//                        }
//                    }
//                }
//                else
//                {
//                    strSQL += @"
//							or EXISTS  (
//			
//							 SELECT 1
//							 FROM   dbo.WsUserPower t1
//									LEFT JOIN dbo.userinfo t2 ON t1.UserID = t2.username
//							 WHERE  (t2.LinkUserId LIKE '%" + m_hzyMessage.User_Name + @"%'
//									AND t2.UserNameC IS NOT NULL 
//									AND t3.PlmSeason = t1.Season
//                                    AND t1.StyleSeries = t3.BoDuanSeries
//									AND t3.Designer = t2.UserNameC)
//									)  )
//					";
//                }
                //-------------------
            }
            else
            {
                strSQL += @"
							OR 1<>1)  ";
            }




            ds_Return = conn.GetDataSetForPageList(strSQL, new string[] {}, m_hzyPageInfo);

            for (int i = 0; i < ds_Return.Tables[0].Rows.Count; i++)
            {
                ds_Return.Tables[0].Rows[i]["DesignImageBig"] = Microsoft.JScript.GlobalObject.escape(ds_Return.Tables[0].Rows[i]["DesignImageBig"]);
                ds_Return.Tables[0].Rows[i]["DesignImageSmall"] = Microsoft.JScript.GlobalObject.escape(ds_Return.Tables[0].Rows[i]["DesignImageSmall"]);
            }

        }
        #endregion

        //---刘洪(LeeGo)添加的代码

        #region 取关联材料列表
        private void GetMaterial(string zt)
        {
            string strProductName = dtList.Rows[0]["ProductName"].ToString();
            int cono = 0;

            if (zt == "EP") {
                cono = 100;
            }
            else if (zt == "DL") {
                cono = 200;
            }
            string strSQL = @"
                        SELECT [DFRCID]
                              ,[DFPRID]
                              ,[DFPRNO]
                              ,[DFDSPE]
                              ,[DFITNO]
                              ,[DFCLID]
                              ,[DFSTQT]
                              ,[MLSTQT] --mitloc库存
                              ,[MMITDS] --mittra成分
                              ,[DFREMK]
                              ,[DFSTAT]
                              ,[DFMFAT]
                              ,CASE WHEN [DFMFAT] = '1' THEN '主面料'
                                    WHEN [DFMFAT] = '2' THEN '普通面料'
                                    WHEN [DFMFAT] = '3' THEN '里布'
                                    WHEN [DFMFAT] = '4' THEN '辅料'
                               ELSE '其他' END AS [DFMFATNAME]
                              ,[DFCRDT]
                              ,CONVERT(varchar(100), [DFCRPE], 23) AS [DFCRPE]
                        FROM [dbo].[PDFINFO] 
                        LEFT JOIN [B01_MDM].[MITMAS] ON [dbo].[PDFINFO].DFITNO = [B01_MDM].[MITMAS].MMITNO AND [B01_MDM].[MITMAS].MMCONO = '" +cono+ @"'
                        LEFT JOIN [dbo].[M3MITLOC] ON [dbo].[PDFINFO].DFITNO = [dbo].[M3MITLOC].MLITNO
                        WHERE DFSTAT = '1' AND [DFPRNO] = '" + strProductName + "'";

            ds_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 材料查询dg
        private void SearchDg()
        {
            string strCONO = "";

            //编号
            string strITNO = dtList.Rows[0]["ITNO"].ToString();
            //物料类型
            string strITGR = dtList.Rows[0]["ITGR"].ToString();
            //帐套
            string strzt = dtList.Rows[0]["zt"].ToString();

            //判断环境
            if (strzt == "EP")
            {
                strCONO = "100";
            }
            if (strzt == "DL")
            {
                strCONO = "200";
            };

            string strSQL = "";

            //MITMAS
            int checkCodeInMITMAS = conn.GetDataTableRowCount("SELECT 1 FROM [B01_MDM].[MITMAS] WHERE MMITNO LIKE '%"+strITNO+"%'");

            if (checkCodeInMITMAS > 0)
            {
                strSQL = @"
                SELECT DISTINCT 
                     MITMAS.MMITNO
                    ,ISNULL(M3MITLOC.MLSTQT,0) MLSTQT
                    ,M3MITLOC.MLWHSL
                    ,CASE WHEN M3MITLOC.MLSTQT IS NULL THEN M3MITTRA.MTACRF END MTACRF
                    ,CASE WHEN M3MITLOC.MLSTQT IS NULL THEN MAX(CONVERT(varchar(100),M3MITTRA.MTRGDT,23)+CONVERT(varchar(100),M3MITTRA.MTRGTM,23)) END MTRGDT
                FROM B01_MDM.MITMAS
                LEFT JOIN M3MITTRA ON M3MITTRA.MTITNO = MITMAS.MMITNO
                LEFT JOIN M3MITLOC ON M3MITTRA.MTITNO = M3MITLOC.MLITNO
                WHERE MMSTAT = '20' AND [MMCONO] = '" + strCONO + "' AND [MMCHCD] = 3 AND [MMITGR] = '" + strITGR + "' AND [MMITNO] LIKE '%" + strITNO + @"%'
                GROUP BY  MITMAS.MMITNO,M3MITTRA.MTITNO,M3MITLOC.MLITNO,M3MITLOC.MLSTQT,M3MITTRA.MTACRF,M3MITLOC.MLWHSL";

                DataTable dt = new DataTable();
                dt = conn.GetDataTable(strSQL);
                dt.TableName = "Table";
                int rowCount = dt.Rows.Count;
                

                if (rowCount > 1) {
                    for (int i = 0; i < rowCount; i++) {
                        string diffITNO = dt.Rows[i]["MMITNO"].ToString();
                        string diffRGDT = dt.Rows[i]["MTRGDT"].ToString();
                        for (int j = 0; j < rowCount; j++) {
                            string itno = dt.Rows[j]["MMITNO"].ToString();
                            if (itno == diffITNO && diffRGDT != "")
                            {
                                string rgdt = dt.Rows[j]["MTRGDT"].ToString();

                                if (Int64.Parse(rgdt) < Int64.Parse(diffRGDT))
                                {
                                    dt.Rows.RemoveAt(j);
                                    rowCount--;
                                    continue;
                                }
                                else if (Int64.Parse(rgdt) == Int64.Parse(diffRGDT))
                                {
                                    continue;
                                }
                                else if (Int64.Parse(rgdt) > Int64.Parse(diffRGDT))
                                {
                                    diffRGDT = rgdt.ToString();
                                };

                            };
                        };
                    };
                };

                ds_Return.Tables.Add(dt.Copy());
                //m_hzyPageInfo.PageRowCount = 500000;

                DataTable dtRow = ds_Return.Tables.Add("PageRowCount");
                dtRow.Columns.Add("AllRowCount");
                DataRow drRow = dtRow.NewRow();
                dtRow.TableName = "PageRowCount";
                dtRow.Rows.Add(drRow);

                dtRow.Rows[0][0] = dt.Rows.Count;

                

                //ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            }
            else if (checkCodeInMITMAS == 0)
            {
                //int getCodeLength = strITNO.Length;

                //string getCheckCode = "";
                //if (getCodeLength > 9){
                //    getCheckCode = strITNO.Substring(0, 9);
                //}else {
                //    getCheckCode = strITNO;
                //};

                //PLM-颜色
                int checkCodeInPSMCINF = conn.GetDataTableRowCount("SELECT 1 FROM [dbo].[PSMCINF] WHERE SCM3NO LIKE '%" + strITNO + "%'");

                if (checkCodeInPSMCINF > 0) {
                    strSQL = @"SELECT 
                                  [SCM3NO] AS [MMITNO]
                                  ,0 AS [MLSTQT]
                                  ,'' AS [MTACRF]
                                  ,'' AS [MTRGDT]
                              FROM [dbo].[PSMCINF]
                              WHERE SCM3NO LIKE '%" + strITNO + "%'";
                };
                if (checkCodeInPSMCINF == 0) {
                    //PLM-尺码
                    int checkCodeInPSMSINF = conn.GetDataTableRowCount("SELECT 1 FROM [dbo].[PSMSINF] WHERE SSM3NO LIKE '%" + strITNO + "%'");

                    if (checkCodeInPSMSINF > 0)
                    {
                        strSQL = @"SELECT 
                                  [SSM3NO] AS [MMITNO]
                                  ,0 AS [MLSTQT]
                                  ,'' AS [MTACRF]
                                  ,'' AS [MTRGDT]
                              FROM [dbo].[PSMSINF]
                              WHERE SSM3NO LIKE '%" + strITNO + "%'";
                    }
                    else {
                        strSQL = @"SELECT 
                                  '' AS [MMITNO]
                                  ,'' AS [MLSTQT]
                                  ,'' AS [MTACRF]
                                  ,'' AS [MTRGDT]
                              FROM [dbo].[PSMSINF]
                              WHERE 1 <> 1";
                    };
                };
                m_hzyPageInfo.PageRowCount = 500000;
                ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            };

            

        }
        #endregion

        #region 材料保存
        private void materialSave()
        {
            //删除帐套行
            dtList.Rows.RemoveAt(0);
            dtList.Columns.Remove("zt");

            DataTable dt = new DataTable();

            string strDFPRNO = dtList.Rows[0]["DFPRNO"].ToString();
            string strDFMFAT = dtList.Rows[0]["DFMFAT"].ToString();
            string strDFITNO = dtList.Rows[0]["DFITNO"].ToString();

            //创建时间,创建人
            dtList.Rows[0]["DFCRDT"] = timeNow;
            dtList.Rows[0]["DFCRPE"] = m_hzyMessage.User_Name_CN;

            //判断表中是否有主力面料
            if (strDFMFAT == "1")
            {
                string strSQL = @"
                        SELECT [DFRCID]
                              ,[DFMFAT]
                        FROM [PLMAss].[dbo].[PDFINFO]
                        WHERE DFMFAT = '1' AND [DFPRNO] = '" + strDFPRNO + "'";
                dt = conn.GetDataTable(strSQL);
            };

            //判断是否已存在该物料
            string strCheck = @"
                        SELECT 1
                        FROM [dbo].[PDFINFO]
                        WHERE DFSTAT <> '9' AND DFPRNO = '" + strDFPRNO + "' AND DFITNO = '" + strDFITNO + "'";
            int i = conn.GetDataTableRowCount(strCheck);

            //判断存在相同物料
            if (i > 0)
            {
                dt_EditResult.Rows.Add(new object[] { false, "该物已存在" });
                ds_Return.Tables.Add(dt_EditResult);
                return;
            };

            //主力面料——>普通面料
            if (dt.Rows.Count > 0)
            {
                dt.Rows[0]["DFMFAT"] = "2";
            };

            bool bResult = false;

            ArrayList listKey = new ArrayList();
            listKey.Add("DFRCID");

            conn.BeginTransaction(); // 开启事务

            if (dt.Rows.Count > 0)
            {
               bResult = conn.Update("[dbo].[PDFINFO]", dt, listKey);
            }
            
                bResult = conn.Insert("[dbo].[PDFINFO]", dtList);

            

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

        #region 删除材料
        private void materialUpdate()
        {

            //删除帐套行
            dtList.Rows.RemoveAt(0);
            dtList.Columns.Remove("zt");

            bool bResult = false;

            ArrayList listKey = new ArrayList();
            listKey.Add("DFRCID");

            conn.BeginTransaction(); // 开启事务

            bResult = conn.Update("[dbo].[PDFINFO]", dtList, listKey);

            conn.CommitTransaction();

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
        #endregion

        #region 样衣确认
        private void sureSample() {

            bool bResult = false;
            //样衣号
            string SetSample 
                = this.dtList.Rows[0]["YYNo"].ToString();
            //款号
            string ProductName 
                = this.dtList.Rows[0]["productname"].ToString();
            DataTable upDateDt = new DataTable();

            upDateDt.Columns.Add("SelectSample");
            upDateDt.Columns.Add("ProductName");

            DataRow dr = upDateDt.NewRow();

            upDateDt.Rows.Add(dr);

            upDateDt.Rows[0]["SelectSample"] = SetSample;
            upDateDt.Rows[0]["ProductName"] = ProductName;

            ArrayList listKey = new ArrayList();
            listKey.Add("ProductName");

            conn.BeginTransaction(); // 开启事务


            bResult = conn.Update("[dbo].[FLEXPLMProduct]", upDateDt, listKey);

            if (bResult) {
                dtList.Columns["zt"].ColumnName = "DIVI";
                dtList.Columns["YYNo"].ColumnName = "SelectSample";
                dtList.Columns["Season"].ColumnName = "PlmSeason";

                dtList.Columns.Add("CreateUser");

                dtList.Rows[0]["CreateUser"] = m_hzyMessage.User_Name;

                bResult = conn.Insert("[dbo].[SampleHistory]", dtList);
            }


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

        #endregion
    }
}
