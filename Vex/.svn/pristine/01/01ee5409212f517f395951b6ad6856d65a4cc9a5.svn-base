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
using System.Text.RegularExpressions;

/// 类名：GL_ERP_Plan
/// 类说明：对GL_ERP_Plan(上货计划的增删改查)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2014-08-20
/// 修改人：
/// 修改日期：
/// 

namespace HZY.COM.WS.Hawk
{
    public class Plan : HZYLogicBase, ILogicGetData
    {
        #region 构造函数

        public Plan()
        {
            this.m_SessionCheck = true;
        }

        #endregion

        #region 内部变量
        private Dbconn conn = new Dbconn("Hawk");
        private DataTable dtEditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet();
        DataSet dsReturn = new DataSet();
        DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        #endregion

        #region GetData 主入口
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {

                string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "cmbGetCUS".ToUpper())        //下拉获取客户代码
                {
                    cmbGetCUS();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "cmbGetSupplier".ToUpper())     //下拉框获取供应商
                {
                    cmbGetSupplier();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "getSKUData".ToUpper()) //获取SKU数据
                {
                    GetSKUData();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SaveHead".ToUpper())   //保存表头
                {
                    SaveHead();
                    dsReturn.Tables.Add(dt_EditResult);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SaveALL".ToUpper())//保存明细
                {
                    SaveALL();
                    dsReturn.Tables.Add(dt_EditResult);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "Get".ToUpper())//所有数据
                {
                    GetAll();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCOHead".ToUpper())//主界面数据
                {
                    GetCOHead("");
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "CoSearch".ToUpper())//主界面查询
                {
                    CoSearch();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "PlanDetail".ToUpper())//下单明细
                {
                    PlanDetail();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetCreateDate".ToUpper())//获取创建界面的表体数据
                {
                    GetCreateDate();
                };
                return dsReturn;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 获取所有数据
        private void GetAll()
        {
            string strWhere = "";
            string strSQL = @"
                        SELECT [COID]
                              ,[Code]
                              ,[CUS1_Code]
                              ,[Seq]
                              ,[SubSeq]
                              ,[MARA_ID]
                              ,[MARA_Code]
                              ,[DeliveryDate]
                              ,[MinState]
                              ,[MaxState]
                              ,[SumNumber]
                              ,[SKUNumber]
                              ,[Unit]
                              ,[Price]
                              ,[COAmount]
                              ,[SKUAmount]
                              ,[Currency]
                              ,[ST2_ImagePath]
                              ,[ST2_SupperierColor]
                              ,[ST2_SizeGroup]
                              ,[ST2_SKCCode]
                              ,[ST1_SupperierStyle]
                              ,[Rgdt]
                              ,[RgUser]
                              ,[LmDt]
                              ,[LmUser]
                          FROM [dbo].[View_ALLData] WHERE 1=1 " + strWhere + m_hzyPageInfo;

            dsReturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 获取表头数据
        private void GetCOHead(string pstrWhere)
        {
            string strSQL = @"
                            SELECT Distinct [COID]
                                  ,[Code]
                                  ,[Name]
                                  ,[CUS1_Code]
                                  ,[DeliveryDate]
                                  ,[MinState]
                                  ,[MaxState]
                                  ,[SumNumber]
                                  ,[POSumNumber]
                                  ,[RESumNumber]
                                  ,[COAmount]
                                  ,[Currency]
                                  ,[Rgdt]
                                  ,[RgUser]
                                  ,[LmDt]
                                  ,[LmUser]
                              FROM [dbo].[View_MainData] WHERE 1=1 " + pstrWhere;
            dsReturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 查询CO
        private void CoSearch()
        {
            //获取条件
            string strPN = ds.Tables[1].Rows[0]["planNo"].ToString();
            string strDateS = ds.Tables[1].Rows[0]["MSDate"].ToString();
            string strDateE = ds.Tables[1].Rows[0]["MEDate"].ToString();
            string strCode = ds.Tables[1].Rows[0]["Code"].ToString();
            string strWhere = "";

            if (strPN != "")
            {
                strWhere += "AND [Code] = '" + strPN + "' ";
            };
            if (strDateS != "")
            {
                strWhere += "AND [DeliveryDate] BETWEEN '" + strDateS + "' AND '" + strDateE + "' ";
            };
            if (strCode != "")
            {
                strWhere += "AND [CUS1_Code] = '" + strCode + "'";
            };
            GetCOHead(strWhere);

        }
        #endregion

        #region 下拉获取年份
        /// <summary>
        /// 下拉框获取年份
        /// </summary>
        private void cmbGetCUS()
        {
            string strSQL = @"
                            SELECT [ID]
                                    ,[Code]
                                    ,[Name]
                            FROM [B01_MDM].[CUS1_CustomerDoc]";
            dsReturn = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 下拉框获取供应商
        private void cmbGetSupplier()
        {
            string strSQL = @"
                            SELECT DISTINCT
	                            [SP1_SupplierCode]
	                           ,[SP1_Name]     
                            FROM [B01_MDM].[SP1_Supplier]";
            dsReturn = conn.GetDataSet(strSQL);
        }
        #endregion

        #region SKU主数据
        private void GetSKUData()
        {
            //年份范围
            string strYearStart = ds.Tables["List"].Rows[0]["YearStart"].ToString();
            string strYearEnd = ds.Tables["List"].Rows[0]["YearEnd"].ToString();
            //季节
            string strSeason = ds.Tables["List"].Rows[0]["Season"].ToString();
            //供应商
            string strSupplierCode = ds.Tables["List"].Rows[0]["Supplier"].ToString();
            //品牌
            string strBrandCode = ds.Tables["List"].Rows[0]["Brand"].ToString();
            //品类
            string strCategory = ds.Tables["List"].Rows[0]["Gen"].ToString();
            //大类
            string strLargeClass = ds.Tables["List"].Rows[0]["GenBig"].ToString();
            //小类
            string strSmallClass = ds.Tables["List"].Rows[0]["GenSmall"].ToString();

            string strWhere = " 1=1 ";
            if (strYearStart != "")
            {
                strWhere += "AND [ST1_Years] BETWEEN '" + strYearStart + "' AND '" + strYearEnd + "' ";
            };
            if (strSupplierCode != "")
            {
                strWhere += "AND [ST1_SupplierCode] = '" + strSupplierCode + "' ";
            };
            if (strBrandCode != "")
            {
                strWhere += "AND [ST1_BR1_BrandCode] = '" + strBrandCode + "' ";
            };
            if (strCategory != "")
            {
                strWhere += "AND [ST1_Category] = '" + strCategory + "' ";
            };
            if (strLargeClass != "")
            {
                strWhere += "AND [ST1_LargeClass] = '" + strLargeClass + "' ";
            };
            if (strSmallClass != "")
            {
                strWhere += "AND [ST1_SmallClass] = '" + strSmallClass + "'";
            };

            string strSQL = @"
                    SELECT [ST3_ID]
                          ,[ST3_SKUCode]
                          ,[ST2_ImagePath]
                          ,[ST1_Unit] 
                          ,[ST2_SalePrice]
                          ,[ST1_Currency]
                    FROM [dbo].[View_SKUData]
                    WHERE " + strWhere;
            dsReturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 新建表头
        private DataTable SaveHead()
        {
            DataSet dsContainer = CreateTable();
            string strPlanDate = ds.Tables["LIST"].Rows[0]["CDate"].ToString();
            string strRgur = this.hzyMessage.User_Name_CN;
            //去掉日期中的"-"
            strPlanDate = Regex.Replace(strPlanDate, "-+", "");
            //if (strPlanDate.Length == 7)
            //{
            //    string strYear = strPlanDate.Substring(2, 2);
            //    string strMonthDay = strPlanDate.Substring(4, 4);
            //    strPlanDate = strYear + "0" + strMonthDay;
            //}
            //else {
            strPlanDate = strPlanDate.Substring(2, 6);
            //}

            string strCoMax = AutoKeyCode.GetMaxKeyCode("新增上货编号", strPlanDate, "", "", conn);

            //赋值
            dsContainer.Tables["dtCOH"].Rows[0]["Code"] = strCoMax;    //上货计划编号
            dsContainer.Tables["dtCOH"].Rows[0]["CUS1_ID"] = ds.Tables["LIST"].Rows[0]["Code"]; //客户编号
            dsContainer.Tables["dtCOH"].Rows[0]["CUS1_Code"] = ds.Tables["LIST"].Rows[0]["Code"]; //客户编号
            dsContainer.Tables["dtCOH"].Rows[0]["DeliveryDate"] = ds.Tables["LIST"].Rows[0]["CDate"]; //出货日期
            dsContainer.Tables["dtCOH"].Rows[0]["MinState"] = "90";
            dsContainer.Tables["dtCOH"].Rows[0]["MaxState"] = "90";
            dsContainer.Tables["dtCOH"].Rows[0]["Rgdt"] = timeNow;
            dsContainer.Tables["dtCOH"].Rows[0]["RgUser"] = strRgur;
            dsContainer.Tables["dtCOH"].Rows[0]["LmDt"] = timeNow;
            dsContainer.Tables["dtCOH"].Rows[0]["LmUser"] = strRgur;
            dsContainer.Tables["dtCOH"].Rows[0]["UptNo"] = "0";

            bool bResult = false;
            conn.LockTableList.Add("B02_BILL.CO1_CustomerOrderHead");// 锁表
            conn.BeginTransaction(); // 开启事务
            bResult = conn.Insert("B02_BILL.CO1_CustomerOrderHead", dsContainer.Tables["dtCOH"]);
            conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功" });
                dt_EditResult.Rows.Add(new object[] { "Cocode", strCoMax });
                dt_EditResult.Rows.Add(new object[] { "code", ds.Tables["LIST"].Rows[0]["Code"] });
                dt_EditResult.Rows.Add(new object[] { "headid", dsContainer.Tables["dtCOH"].Rows[0]["ID"] });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "" });
            };
            return dt_EditResult;

        }
        #endregion

        #region 保存
        private DataTable SaveALL()
        {
            DataTable dtReturn = new DataTable();

            DataSet dsBox = CreateTable();

            string strXML = ds.Tables["LIST"].Rows[0]["Detail"].ToString();
            DataSet dsDetail = Common.Common.GetDSByExcelXML(strXML);
            string strRgur = this.hzyMessage.User_Name_CN;
            string strWhere = "ID IN (";

            int intRowsCount = 0;

            if (dsDetail.Tables.Count > 1)
            {
                intRowsCount = dsDetail.Tables["LIST"].Rows.Count;
            };

            //出货日期
            string strDate = ds.Tables["LIST"].Rows[0]["CDate"].ToString();

            //更新子表的出货日期
            dsBox.Tables["dtCODuD"].Rows[0]["CO1_Code"] = ds.Tables["LIST"].Rows[0]["PlanNo"].ToString();
            dsBox.Tables["dtCODuD"].Rows[0]["DeliveryDate"] = strDate;
            dsBox.Tables["dtCODuD"].Rows[0]["LmUser"] = strRgur;
            dsBox.Tables["dtCODuD"].Rows[0]["Lmdt"] = timeNow;

            //取创建人与创建时间
            string strSQL = @"
                        SELECT [Rgdt]
                              ,[RgUser]
                              ,[CUS1_ID]
                              ,[CUS1_Code]
                        FROM [B02_BILL].[CO1_CustomerOrderHead]
                        WHERE ID = '" + ds.Tables["LIST"].Rows[0]["ID"].ToString() + "'";
            DataTable dtRg = conn.GetDataTable(strSQL);



            //赋值
            dsBox.Tables["dtCOH"].Rows[0]["ID"] = ds.Tables["LIST"].Rows[0]["ID"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["Code"] = ds.Tables["LIST"].Rows[0]["PlanNo"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["DeliveryDate"] = strDate;
            dsBox.Tables["dtCOH"].Rows[0]["MinState"] = ds.Tables["LIST"].Rows[0]["LowStatus"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["MaxState"] = ds.Tables["LIST"].Rows[0]["HighStatus"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["Amount"] = ds.Tables["LIST"].Rows[0]["PlanAmount"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["Currency"] = ds.Tables["LIST"].Rows[0]["Currency"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["Rgdt"] = dtRg.Rows[0]["Rgdt"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["RgUser"] = dtRg.Rows[0]["RgUser"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["CUS1_ID"] = dtRg.Rows[0]["CUS1_ID"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["CUS1_Code"] = dtRg.Rows[0]["CUS1_Code"].ToString();
            dsBox.Tables["dtCOH"].Rows[0]["LmDt"] = timeNow;
            dsBox.Tables["dtCOH"].Rows[0]["LmUser"] = strRgur;
            dsBox.Tables["dtCOH"].Rows[0]["UptNo"] = "0";

            //GUID
            System.Guid guid = System.Guid.NewGuid();               //Guid 类型

            if (intRowsCount != 0)
            {
                for (int i = 0; i <= intRowsCount - 1; i++)
                {

                    string strTag = dsDetail.Tables["LIST"].Rows[i]["rowtag"].ToString(); //操作类型
                    string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

                    //数量
                    int intNumber = Convert.ToInt32(dsDetail.Tables["LIST"].Rows[i]["number"].ToString());
                    //吊牌价
                    string strPrice = dsDetail.Tables["LIST"].Rows[i]["Price"].ToString();
                    int intLength = strPrice.Length;
                    strPrice = strPrice.Substring(0, intLength - 7);//去掉后四位0
                    int intPrice = Convert.ToInt32(strPrice);
                    //金额
                    int intAmount = intNumber * intPrice;

                    //新增
                    if (strTag == "new")
                    {
                        //增加新行
                        DataRow drCODi = dsBox.Tables["dtCODi"].NewRow();
                        dsBox.Tables["dtCODi"].Rows.Add(drCODi);

                        int rowsCount = dsBox.Tables["dtCODi"].Rows.Count;
                        rowsCount = rowsCount - 1;
                        //赋值
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["ID"] = strGUID;
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["M01P_ID"] = "HWA";
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["M02C_ID"] = "D01";
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["CO1_ID"] = ds.Tables["LIST"].Rows[0]["ID"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["Seq"] = dsDetail.Tables["LIST"].Rows[i]["Seq"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["SubSeq"] = dsDetail.Tables["LIST"].Rows[i]["SubSeq"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["MARA_ID"] = dsDetail.Tables["LIST"].Rows[i]["mara_id"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["MARA_Code"] = dsDetail.Tables["LIST"].Rows[i]["mara_code"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["DeliveryDate"] = dsDetail.Tables["LIST"].Rows[i]["deliverydate"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["M01P_Code"] = "95";
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["M02C_Code"] = "9501";
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["CO1_Code"] = ds.Tables["LIST"].Rows[0]["PlanNo"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["State"] = "15";
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["Number"] = intNumber;
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["Unit"] = dsDetail.Tables["LIST"].Rows[i]["unit"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["Price"] = intPrice;
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["Amount"] = intAmount;
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["Currency"] = dsDetail.Tables["LIST"].Rows[i]["currency"].ToString();
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["Rgdt"] = timeNow;
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["RgUser"] = strRgur;
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["LmDt"] = timeNow;
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["LmUser"] = strRgur;
                        dsBox.Tables["dtCODi"].Rows[rowsCount]["UptNo"] = "0";
                    }
                    //编辑
                    else if (strTag == "edit")
                    {
                        //增加新行
                        DataRow drCODu = dsBox.Tables["dtCODu"].NewRow();
                        dsBox.Tables["dtCODu"].Rows.Add(drCODu);

                        int rowsCount = dsBox.Tables["dtCODu"].Rows.Count;
                        rowsCount = rowsCount - 1;
                        //赋值
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["ID"] = dsDetail.Tables["LIST"].Rows[i]["id"].ToString();
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["Number"] = intNumber;
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["DeliveryDate"] = strDate;
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["State"] = dsDetail.Tables["LIST"].Rows[i]["State"].ToString();
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["Unit"] = dsDetail.Tables["LIST"].Rows[i]["Unit"].ToString();
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["Price"] = intPrice;
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["Amount"] = intAmount;
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["Currency"] = dsDetail.Tables["LIST"].Rows[i]["Currency"].ToString();
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["LmUser"] = strRgur;
                        dsBox.Tables["dtCODu"].Rows[rowsCount]["LmDt"] = timeNow;
                    }
                    //删除
                    else
                    {
                        //增加新行
                        DataRow drCODd = dsBox.Tables["dtCODd"].NewRow();
                        dsBox.Tables["dtCODd"].Rows.Add(drCODd);

                        int rowsCount = dsBox.Tables["dtCODd"].Rows.Count;
                        rowsCount = rowsCount - 1;

                        if (i < intRowsCount - 1)
                        {
                            //赋值
                            strWhere += " '" + dsDetail.Tables["LIST"].Rows[i]["id"].ToString() + "',";
                        }
                        else
                        {
                            strWhere += " '" + dsDetail.Tables["LIST"].Rows[i]["id"].ToString() + "'";
                        }

                    };
                    if (i == intRowsCount - 1)
                    {
                        strWhere += ")";
                    }
                };
            };


            ArrayList listKeyCOD = new ArrayList();
            ArrayList listKeyCOH = new ArrayList();
            ArrayList listKeyCODuD = new ArrayList();

            listKeyCOD.Add("ID");
            listKeyCOH.Add("ID");
            listKeyCODuD.Add("CO1_Code");

            int intCODiCount = dsBox.Tables["dtCODi"].Rows.Count;
            int intCODuCount = dsBox.Tables["dtCODu"].Rows.Count;
            int intCODdCount = dsBox.Tables["dtCODd"].Rows.Count;
            int intCODuDCount = dsBox.Tables["dtCODuD"].Rows.Count;

            bool bResult = false;

            conn.LockTableList.Add("B02_BILL.CO1_CustomerOrderHead");// 锁表
            conn.LockTableList.Add("B02_BILL.CO2_CustomerOrderDetail");

            conn.BeginTransaction(); // 开启事务
            bResult = conn.Update("B02_BILL.CO1_CustomerOrderHead", dsBox.Tables["dtCOH"], listKeyCOH);
            if (intCODiCount > 0)
            {
                bResult = conn.Insert("B02_BILL.CO2_CustomerOrderDetail", dsBox.Tables["dtCODi"]);
            }
            if (intCODuCount > 0)
            {
                bResult = conn.Update("B02_BILL.CO2_CustomerOrderDetail", dsBox.Tables["dtCODu"], listKeyCOD);
            }
            if (intCODdCount > 0)
            {
                bResult = conn.Delete("B02_BILL.CO2_CustomerOrderDetail", strWhere);
            }
            if (intCODuDCount > 0)
            {
                bResult = conn.Update("B02_BILL.CO2_CustomerOrderDetail", dsBox.Tables["dtCODuD"], listKeyCODuD);
            }
            conn.CommitTransaction(); //提交事务
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "保存成功" });
                dt_EditResult.Rows.Add(new object[] { "Cocode", dsBox.Tables["dtCOH"].Rows[0]["Code"] });
                dt_EditResult.Rows.Add(new object[] { "code", ds.Tables["LIST"].Rows[0]["Code"] });
                dt_EditResult.Rows.Add(new object[] { "headid", ds.Tables["LIST"].Rows[0]["ID"] });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "" });
            };

            return dtReturn;
        }
        #endregion

        #region 创建需要的DataTable
        private DataSet CreateTable()
        {

            DataSet dsReturnNew = new DataSet();

            DataTable dtCOH = new DataTable();     //客户主表 
            DataTable dtCODi = new DataTable(); //明细表insert
            DataTable dtCODu = new DataTable(); //明细表update
            DataTable dtCODd = new DataTable(); //明细表delete
            DataTable dtCODuD = new DataTable(); //明细表update货期

            DataRow drCOH = dtCOH.NewRow();
            dtCOH.Rows.Add(drCOH);

            DataRow drCODuD = dtCODuD.NewRow();
            dtCODuD.Rows.Add(drCODuD);


            //GUID
            System.Guid guid = System.Guid.NewGuid();               //Guid 类型
            string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

            dtCOH.Columns.Add("ID");
            dtCOH.Columns.Add("M01P_ID");
            dtCOH.Columns.Add("M02C_ID");
            dtCOH.Columns.Add("ORB1_ID");
            dtCOH.Columns.Add("Code");
            dtCOH.Columns.Add("CUS1_ID");
            dtCOH.Columns.Add("DeliveryDate");
            dtCOH.Columns.Add("MinState");
            dtCOH.Columns.Add("MaxState");
            dtCOH.Columns.Add("M01P_Code");
            dtCOH.Columns.Add("M02C_Code");
            dtCOH.Columns.Add("ORB1_Code");
            dtCOH.Columns.Add("CUS1_Code");
            dtCOH.Columns.Add("SALR_Code");
            dtCOH.Columns.Add("Amount");
            dtCOH.Columns.Add("SALR_ID");
            dtCOH.Columns.Add("Currency");
            dtCOH.Columns.Add("Rgdt");
            dtCOH.Columns.Add("RgUser");
            dtCOH.Columns.Add("LmDt");
            dtCOH.Columns.Add("LmUser");
            dtCOH.Columns.Add("UptNo");

            dtCODi.Columns.Add("ID");
            dtCODi.Columns.Add("M01P_ID");
            dtCODi.Columns.Add("M02C_ID");
            dtCODi.Columns.Add("CO1_ID");
            dtCODi.Columns.Add("Seq");
            dtCODi.Columns.Add("SubSeq");
            dtCODi.Columns.Add("MARA_ID");
            dtCODi.Columns.Add("MARA_Code");
            dtCODi.Columns.Add("DeliveryDate");
            dtCODi.Columns.Add("M01P_Code");
            dtCODi.Columns.Add("M02C_Code");
            dtCODi.Columns.Add("CO1_Code");
            dtCODi.Columns.Add("State");
            dtCODi.Columns.Add("Number");
            dtCODi.Columns.Add("Unit");
            dtCODi.Columns.Add("Price");
            dtCODi.Columns.Add("Amount");
            dtCODi.Columns.Add("Currency");
            dtCODi.Columns.Add("Rgdt");
            dtCODi.Columns.Add("RgUser");
            dtCODi.Columns.Add("LmDt");
            dtCODi.Columns.Add("LmUser");
            dtCODi.Columns.Add("UptNo");

            dtCODu.Columns.Add("ID");
            dtCODu.Columns.Add("DeliveryDate");
            dtCODu.Columns.Add("State");
            dtCODu.Columns.Add("Number");
            dtCODu.Columns.Add("Unit");
            dtCODu.Columns.Add("Price");
            dtCODu.Columns.Add("Amount");
            dtCODu.Columns.Add("Currency");
            dtCODu.Columns.Add("LmDt");
            dtCODu.Columns.Add("LmUser");

            dtCODd.Columns.Add("ID");

            dtCODuD.Columns.Add("DeliveryDate");
            dtCODuD.Columns.Add("CO1_Code");
            dtCODuD.Columns.Add("LmDt");
            dtCODuD.Columns.Add("LmUser");

            //赋值
            dtCOH.Rows[0]["ID"] = strGUID;
            dtCOH.Rows[0]["M01P_ID"] = "HWA";
            dtCOH.Rows[0]["M02C_ID"] = "D01";
            dtCOH.Rows[0]["ORB1_ID"] = "CO";

            dtCOH.TableName = "dtCOH";
            dtCODi.TableName = "dtCODi";
            dtCODu.TableName = "dtCODu";
            dtCODd.TableName = "dtCODd";
            dtCODuD.TableName = "dtCODuD";

            dsReturnNew.Tables.Add(dtCOH);
            dsReturnNew.Tables.Add(dtCODi);
            dsReturnNew.Tables.Add(dtCODu);
            dsReturnNew.Tables.Add(dtCODd);
            dsReturnNew.Tables.Add(dtCODuD);

            return dsReturnNew;
        }
        #endregion

        #region 获取创建窗口的表体
        private void GetCreateDate()
        {
            string strPlanNo = ds.Tables["LIST"].Rows[0]["PlanNo"].ToString();
            string strSQL = @"
                                SELECT DISTINCT [ID]
                                    ,[Seq]
                                    ,[SubSeq]
                                    ,[MARA_ID]
                                    ,[MARA_Code]
                                    ,[ST2_ImagePath]
                                    ,[Number]
                                    ,[Unit]
                                    ,[Price]
                                    ,[State]
                                    ,[Currency]
                                    ,[DeliveryDate]
                                FROM [dbo].[View_CreateData] WITH(NOLOCK)
                                WHERE [CO1_Code] = '" + strPlanNo + "'";
            dsReturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 下单明细
        private void PlanDetail()
        {
            string strCOCode = ds.Tables["LIST"].Rows[0]["COCode"].ToString();
            string strSQL = @"
                            SELECT [COSeq]
                                  ,[COSubSeq]
                                  ,[MARA_Code]
                                  ,[CO1_Code]
                                  ,[ST2_ImagePath]
                                  ,[CONumber]
                                  ,[COPONumber]
                                  ,[CORENumber]
                                  ,[PO2_POCode]
                                  ,[POSeq]
                                  ,[POSubSeq]
                                  ,[PONumber]
                                  ,[PORENumber]
                            FROM [dbo].[View_PlanDetail] 
                            WHERE 1=1 AND CO1_Code = '" + strCOCode + "'";
            dsReturn = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #endregion

        #region 属性
        public string RegionCode { get; set; }
        #endregion

        public Dbconn m_conn { get; set; }
    }
}
