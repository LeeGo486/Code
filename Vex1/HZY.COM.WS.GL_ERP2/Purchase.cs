using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;
using System.Web;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;

// 类名：Purchase
// 类说明：雅斓ERP采购单
// 创建人： 郭琦琦
// 创建日期：2014-04-09
// 修改人：
// 修改日期：
namespace HZY.COM.WS.GL_ERP2
{
    public class Purchase : HZYLogicBase, ILogicGetData
    {

        #region 构造函数
        public Purchase()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量
        private Dbconn m_conn = new Dbconn("GL_ERP");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        string mMaxPurchaseCode = "";

        #endregion

        #region GetData
        /// <summary>
        /// VEX主函数入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET")//取采购单主表信息
                {
                    GET();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETPODETIL")//获取采购单子表数据
                {
                    GETPODETIL();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDIT")//采购单，采购子表，新增修改删除操作。
                {
                    EDIT();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "APO".ToUpper())//如果前台传过来的表里面第一行第一列为APO，对到货计划操作
                {
                    APO();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETSTYLE")//按照供应商编号和品牌取款号
                {
                    GETSTYLE();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GETAPOLIST")//取到货计划子表
                {
                    GETAPOLIST();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DELETEPOHEAD")//删除到货计划
                {
                    DELETEPOHEAD();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ENDPOHEAD") //采购主表完结
                {
                    ENDPOHEAD();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EXAMINEPODETAIL")//采购子表审批（批量）
                {
                    EXAMINEPODETAIL();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "BACKEXAMINEPODETAIL")//采购子表反审批
                {
                    BACKEXAMINEPODETAIL();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ENDPODTETAIL")//采购主表完结
                {
                    ENDPODTETAIL();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ENDAPODTETAIL")//到货计划子表完结
                {
                    ENDAPODTETAIL();
                }
                return ds_Return;
            }
            catch
            {
                m_conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region GET 取采购单主表信息
        /// <summary>
        /// 取采购单主表信息
        /// </summary>
        private void GET()
        {
            //供采购单主表筛选条件用。
            string strSeason = "";
            string strYear = "";
            //如果传过来列包含pd1_season，pd1_years，取他们的值，如果不包含不赋值
            if (ds.Tables["list"].Columns.Contains("pd1_season"))
            {
                strSeason = ds.Tables["list"].Rows[0]["pd1_season"].ToString();
            }
            if (ds.Tables["list"].Columns.Contains("pd1_years"))
            {
                strYear = ds.Tables["list"].Rows[0]["pd1_years"].ToString();
            }
            //定义SQL查询条件
            string strSQL = @"
                                    SELECT*FROM (SELECT  t1.PO1_ID ,
                                                        t1.PO1_CONO ,
                                                        t1.PO1_DIVI ,
                                                        t1.PO1_POCode ,
                                                        t1.PO1_POTypeCode ,
                                                        t1.PO1_POTypeName ,
                                                        t1.PO1_SPPOCode ,
                                                        t1.PO1_HState ,
                                                        t1.PO1_LState ,
                                                        t1.PO1_PC1_ContractCode ,
                                                        t1.PO1_BR1_BrandCode ,
                                                        t1.PO1_SupplierCode ,
                                                        t2.SP1_RegionName ,
                                                        CONVERT(VARCHAR(100),  t1.PO1_PlanDeliveryDate, 23) AS PO1_PlanDeliveryDate,
                                                        t1.PO1_PZNumber ,
                                                        t1.PO1_OCurrencySums ,
                                                        t1.PO1_DCurrencySums ,
                                                        t1.PO1_Currency ,
                                                        t1.PO1_ExchangeRate ,
                                                        t1.PO1_SupplyTax ,
                                                        t1.PO1_TranSportRatio ,
                                                        t1.PO1_PaymentTypeName ,
                                                        t1.PO1_PaymentChannelName ,
                                                        t1.PO1_IncreaseRatio ,
                                                        t1.PO1_TariffRatio ,
                                                        t1.PO1_RgDt,
                                                        t1.PO1_RgUser ,
                                                        CONVERT(VARCHAR(100),  t1.PO1_LmDt, 23) AS PO1_LmDt,
                                                        t1.PO1_LmUser ,
                                                        t1.PO1_UptNo,
		                                                t2.SP1_Name,
		                                                t3.BR1_Name,
                                                        t1.PO1_SourcePOCode 
                                                FROM [B02_BILL].[PO1_POHead] t1
                                                LEFT JOIN B01_MDM.SP1_Supplier t2  ON t1.PO1_SupplierCode =t2.SP1_SupplierCode
                                                LEFT JOIN B01_MDM.BR1_Brand t3 ON t1.PO1_BR1_BrandCode = t3.BR1_BrandCode ) t9
                                           where 1=1 and PO1_LState <> '99'  " + m_hzyPageInfo.Where;
            //如果前台传过来季节或者年份，传到数据库SQL语句添加条件
            if (strSeason != "")
            {
                strSQL += " AND EXISTS (SELECT 1  FROM [B01_MDM].ST1_Style WHERE ST1_Season=@param0 )";
            }

            if (strYear != "")
            {
                strSQL += " AND EXISTS (SELECT 1  FROM [B01_MDM].ST1_Style WHERE ST1_Years=@param1 )";
            }
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] { strSeason, strYear }, m_hzyPageInfo);
        }

        #endregion

        #region GETPODETIL 获取采购单子表数据
        /// <summary>
        /// 获取采购单子表数据
        /// </summary>
        private void GETPODETIL()
        {
            string strSQL = @"
                                     SELECT t3.ST2_SizeGroup ,
                                            t2.ST3_ST2_SKCCode ,
                                            t2.ST3_Size ,
                                            t1.PO2_ID ,
                                            t1.PO2_CONO ,
                                            t1.PO2_DIVI ,
                                            t1.PO2_POCode ,
                                            t1.PO2_LISeq ,
                                            t1.PO2_LSSeq ,
                                            t1.PO2_State ,
                                            t1.PO2_PD1_SupperierStyle ,
                                            t1.PO2_PD1_SupperierColor ,
                                            t1.PO2_PD1_SupperierSize ,
                                            t1.PO2_PD1_ProductCode ,
                                            t1.PO2_Number ,
                                            t1.PO2_Unit ,
                                            t1.PO2_PurchaseCurrency ,
                                            t1.PO2_OCurrencyPrice ,
                                            t1.PO2_DCurrencyPrice ,
                                            t1.PO2_OCurrencyAmount ,
                                            t1.PO2_DCurrencyAmount ,
                                            t1.PO2_PlanDeliveryDate ,
                                            t1.PO2_RgDt ,
                                            t1.PO2_RgUser ,
                                            t1.PO2_LmDt ,
                                            t1.PO2_LmUser ,
                                            t1.PO2_UptNo ,
                                            t3.ST2_Color ,
                                            t3.ST2_ST1_StyleCode ,
                                            t4.CT1_KeyName ,
                                            t3.ST2_ImagePath
                                        FROM   [B02_BILL].[PO2_PODetail] t1
                                            LEFT JOIN [B01_MDM].[ST3_StyleColorSize] t2 ON t1.PO2_PD1_ProductCode = t2.ST3_SKUCode
                                            LEFT JOIN [B01_MDM].[ST2_StyleColor] t3 ON t2.ST3_ST2_SKCCode = t3.ST2_SKCCode
                                            LEFT JOIN [M01_CONF].[CT0_CSYTAB] t4 ON t3.ST2_Color = t4.CT1_KeyID
                                        WHERE  1 = 1
                                            AND t4.CT1_Code = 'COLO' " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }

        #endregion

        #region EDIT 采购单，采购子表，新增修改删除操作。
        /// <summary>
        /// 采购单，采购子表，新增修改删除操作。
        /// </summary>
        private void EDIT()
        {
            //采购单主表操作
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PO1_POHead]");

            string strPO1_POCode = ds.Tables["list"].Rows[0]["PO1_POCode"].ToString();//取采购单采购编号
            string strpo1_sourcepocode = ds.Tables["list"].Rows[0]["po1_sourcepocode"].ToString();//关联上货计划

            ds.Tables["list"].Columns.Remove("PO1_POCode");//移除采购单号列
            string strGuid = System.Guid.NewGuid().ToString();//创建GUID
            string strTypeName = ds.Tables["list"].Rows[0]["PO1_POTypeName"].ToString();//获取采购单类型（自动生成编号）
            string strPO2_PODetailXML = ds.Tables["list"].Rows[0]["PoDetail"].ToString();//取采购单子表XML
            ds.Tables["list"].Columns.Remove("PoDetail");//移除PoDetail列（前台XML嵌套进来的，包含子表XML的列）
            DateTime timeNow = DateTime.Now;//取本地当前时间。
            CheckNumColumnValue(ds);//判断传过来 的列是否为空，如果为空，附上NULL。
            m_conn.BeginTransaction();//开启事务
            //如果采购单单号为空，作为新增，添加新采购单。
            if (strPO1_POCode == "")
            {
                //重组准备插入主表的数据
                ds.Tables["list"].Columns.Add("PO1_RgDt");
                ds.Tables["list"].Columns.Add("PO1_RgUser");
                ds.Tables["List"].Rows[0]["PO1_RgUser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["PO1_RgDt"] = timeNow;
                ds.Tables["list"].Columns.Add("PO1_LmDt");
                ds.Tables["list"].Columns.Add("PO1_LmUser");
                ds.Tables["List"].Rows[0]["PO1_LmUser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["PO1_LmDt"] = timeNow;
                ds.Tables["list"].Columns.Add("PO1_CONO");
                ds.Tables["list"].Columns.Add("PO1_DIVI");
                ds.Tables["List"].Rows[0]["PO1_CONO"] = "GL";
                ds.Tables["List"].Rows[0]["PO1_DIVI"] = "D01";
                ds.Tables["list"].Columns.Add("PO1_POCode");
                ds.Tables["list"].Columns.Add("PO1_ID");
                ds.Tables["List"].Rows[0]["PO1_ID"] = strGuid;
                //取采购单最大号（按照类型）
                mMaxPurchaseCode = AutoKeyCode.GetMaxKeyCode(strTypeName, "", "", "", m_conn);
                ds.Tables["List"].Rows[0]["PO1_POCode"] = mMaxPurchaseCode;//把最大号付给PO1_POCode
                strPO1_POCode = mMaxPurchaseCode;
                bResult = m_conn.Insert("[B02_BILL].[PO1_POHead]", ds.Tables["List"]);//插入
            }
            //如果有采购单就修改
            else
            {
                ds.Tables["list"].Columns.Add("PO1_LmDt");
                ds.Tables["list"].Columns.Add("PO1_LmUser");
                ds.Tables["List"].Rows[0]["PO1_LmUser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["PO1_LmDt"] = timeNow;
                bResult = m_conn.Update("[B02_BILL].[PO1_POHead]", ds.Tables["List"], "PO1_POCode=" + strPO1_POCode);
            }

            //如果传过来的XML里面strPO2_PODetailXML不为空执行采购单子表增删改查
            if (strPO2_PODetailXML != "")
            {
                DataSet dsDetail = Common.Common.GetDSByExcelXML(strPO2_PODetailXML);//解析子表XML
                DataTable dtPoDetailOptype = dsDetail.Tables["OPTYPE"];
                DataTable dtPoDetailList = dsDetail.Tables["list"];

                //复制表为子表增加，修改，删除用
                DataSet dtPoDetailListForInsert = dsDetail.Copy();
                DataSet dtPoDetailListForUpdate = dsDetail.Copy();
                DataSet dtPoDetailListForDelete = dsDetail.Copy();
                //循环XML strPO2_PODetailXML 解析出来的数据表
                for (int i = 0; i < dtPoDetailList.Rows.Count; i++)
                {
                    //SKU操作
                    string strSt3_Size = dtPoDetailList.Rows[i]["st3_size"].ToString();//获取尺码

                    string strST2_ImagePath = dtPoDetailList.Rows[i]["st2_imagepath"].ToString();//获取图片路径
                    string strSt3_St2_Skccode = dtPoDetailList.Rows[i]["st3_st2_skccode"].ToString();//获取SKC
                    string strSKUCode = strSt3_St2_Skccode + strSt3_Size;//尺码加SKC组成SKU
                    string strStyleCode = strSt3_St2_Skccode.Substring(0, 10);//SKC截取前10未作为款号
                    string strPo2_Pd1_Supperiersize = dtPoDetailList.Rows[i]["po2_pd1_supperiersize"].ToString();//获取供应商尺码

                    //构成SKU表
                    DataTable dtSKUTable = new DataTable();
                    dtSKUTable.Columns.Add("ST3_CONO");
                    dtSKUTable.Columns.Add("ST3_DIVI");
                    dtSKUTable.Columns.Add("ST3_SKUCode");
                    dtSKUTable.Columns.Add("ST3_ST2_SKCCode");
                    dtSKUTable.Columns.Add("ST3_ST1_StyleCode");
                    dtSKUTable.Columns.Add("ST3_Size");
                    dtSKUTable.Columns.Add("ST3_State");
                    dtSKUTable.Columns.Add("ST3_RgDt");
                    dtSKUTable.Columns.Add("ST3_RgUser");
                    dtSKUTable.Columns.Add("ST3_LmDt");
                    dtSKUTable.Columns.Add("ST3_LmUser");
                    dtSKUTable.Columns.Add("ST3_SupperierSize");
                    //构成插入SKU行,附上值dr为，新表的行
                    DataRow dr = dtSKUTable.NewRow();
                    dr["ST3_CONO"] = "GL";
                    dr["ST3_DIVI"] = "D01";
                    dr["ST3_SKUCode"] = strSKUCode;
                    dr["ST3_ST2_SKCCode"] = strSt3_St2_Skccode;
                    dr["ST3_ST1_StyleCode"] = strStyleCode;
                    dr["ST3_Size"] = strSt3_Size;
                    dr["ST3_State"] = "20";
                    dr["ST3_RgDt"] = timeNow;
                    dr["ST3_RgUser"] = hzyMessage.User_Name_CN;
                    dr["ST3_LmDt"] = timeNow;
                    dr["ST3_LmUser"] = hzyMessage.User_Name_CN;
                    dr["ST3_SupperierSize"] = strPo2_Pd1_Supperiersize;
                    dtSKUTable.Rows.Add(dr);
                    //通过采购子表组成的SKU 去SKU表判断是否存在
                    int nSKUCode = m_conn.GetDataTableRowCount("  SELECT *  FROM [B01_MDM].[ST3_StyleColorSize]  WHERE ST3_SKUCode = '" + strSKUCode + "'");
                    //nSKUCode = 0 SKU不存在，新增，反之按照SKU修改
                    if (nSKUCode == 0)
                    {
                        bResult = m_conn.Insert("[B01_MDM].[ST3_StyleColorSize]", dtSKUTable);
                    }
                    else
                    {
                        bResult = m_conn.Update("[B01_MDM].[ST3_StyleColorSize]", dtSKUTable, "ST3_SKUCode='" + strSKUCode + "'");
                    }
                }

                for (int i = 0; i < dtPoDetailOptype.Rows.Count; i++)
                {
                    //如果子表解析出来的XML，类型有insert，做新增
                    if (dtPoDetailOptype.Rows[i][0].ToString().ToUpper() == "INSERT")
                    {
                        //如果包含rowindex，就循环移除
                        if (dtPoDetailListForInsert.Tables[i + 1].Columns.Contains("rowindex"))
                        {
                            dtPoDetailListForInsert.Tables[i + 1].Columns.Remove("rowindex");
                        }
                        m_conn.LockTableList.Add("[B02_BILL].[PO2_PODetail]");

                        string strPO2_POCode = dtPoDetailListForInsert.Tables[i + 1].Rows[0]["PO2_POCode"].ToString();
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Remove("st2_imagepath");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Remove("st2_sizegroup");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Add("PO2_RgDt");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Add("PO2_RgUser");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Add("po2_lmuser");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Add("po2_lmdt");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Add("po2_cono");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Add("po2_divi");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Add("PO2_PD1_ProductCode");
                        dtPoDetailListForInsert.Tables[i + 1].Columns.Add("PO2_ID");
                        DataSet dtOrderPoDetailListForInsert = dtPoDetailListForInsert.Clone();
                        DataRow[] dr = dtPoDetailListForInsert.Tables[i + 1].Select("1=1", " st3_st2_skccode,st3_size   ");

                        for (int temp = 0; temp < dr.Length; temp++)
                        {
                            dtOrderPoDetailListForInsert.Tables["List"].ImportRow(dr[temp]);
                        }
                        for (int k = 0; k < dtOrderPoDetailListForInsert.Tables["List"].Rows.Count; k++)
                        {
                            //判断列值是否为空，放默认值
                            CheckNumColumnValue(dtOrderPoDetailListForInsert);
                            string strPOSt3_Size = dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["st3_size"].ToString();//取子表尺码值
                            string strPOst3_St2_SkcCode = dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["st3_st2_skccode"].ToString();//取子表SKC值
                            string strPOSKUCode = strPOst3_St2_SkcCode + strPOSt3_Size;//组成SKU
                            string strGuidDetil = System.Guid.NewGuid().ToString();//构建GUID
                            dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["PO2_PD1_ProductCode"] = strPOSKUCode;//赋值
                            dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["PO2_ID"] = strGuidDetil;//赋值
                            dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["PO2_RgUser"] = hzyMessage.User_Name_CN;
                            dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["po2_lmuser"] = hzyMessage.User_Name_CN;
                            dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["po2_lmdt"] = timeNow;
                            dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["PO2_RgDt"] = timeNow;
                            dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["po2_cono"] = "GL";
                            dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["po2_divi"] = "D01";
                            //判断采购单子表是否存在单号，如果不存在，采购单最大号附给采购子表。
                            if (strPO2_POCode == "")
                            {
                                dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["PO2_POCode"] = mMaxPurchaseCode;
                            }
                            else
                            {
                                dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["PO2_POCode"] = strPO2_POCode;
                            }
                        }
                        dtOrderPoDetailListForInsert.Tables["List"].Columns.Remove("st3_size");
                        dtOrderPoDetailListForInsert.Tables["List"].Columns.Remove("st3_st2_skccode");
                        //循环新增子行
                        for (int k = 0; k < dtOrderPoDetailListForInsert.Tables["List"].Rows.Count; k++)
                        {
                            string strPPO2_POCode = dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["PO2_POCode"].ToString();

                            string zi = dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["po2_liseq"].ToString();
                            if (zi == "")
                            {
                                dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["po2_liseq"] = AutoKeyCode.GetMaxKeyCode("新增项次", strPPO2_POCode, "", "", m_conn);
                            }
                            DataTable dtTemp = dtOrderPoDetailListForInsert.Tables["List"].Clone();
                            dtTemp.ImportRow(dtOrderPoDetailListForInsert.Tables["List"].Rows[k]);
                            bResult = m_conn.Insert("[B02_BILL].[PO2_PODetail]", dtTemp);

                            //郭琦琦
                            string ccc = dtOrderPoDetailListForInsert.Tables["List"].Rows[k]["PO2_PD1_ProductCode"].ToString();
                            string strSQL2 = @"UPDATE [B02_BILL].[CO2_CustomerOrderDetail] SET State =35  WHERE MARA_Code  ='" + ccc + "' and CO1_Code ='" + strpo1_sourcepocode + "' and seq ='" + zi + "' and State <=35";
                            m_conn.ExcuteQuerryByTran(strSQL2, new object[] { });

                        }
                    }
                    //如果类型包含，update，解析成表，做update
                    else if (dtPoDetailOptype.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                        //如果包含rowindex就移除
                        if (dtPoDetailListForInsert.Tables[i + 1].Columns.Contains("rowindex"))
                        {
                            dtPoDetailListForInsert.Tables[i + 1].Columns.Remove("rowindex");
                        }
                        m_conn.LockTableList.Add("[B02_BILL].[PO2_PODetail]");
                        string strPO2_ID = dtPoDetailListForUpdate.Tables[i + 1].Rows[0]["po2_id"].ToString();//获取子表GUID
                        dtPoDetailListForUpdate.Tables[i + 1].Columns.Remove("st2_imagepath");

                        //循环XML解析出来的表，更新采购子表
                        for (int k = 0; k < dtPoDetailListForUpdate.Tables[i + 1].Rows.Count; k++)
                        {
                            string strSt3_sSize = dtPoDetailListForUpdate.Tables[i + 1].Rows[k]["st3_size"].ToString();
                            string strSt3_St2_SkcCode = dtPoDetailListForUpdate.Tables[i + 1].Rows[k]["st3_st2_skccode"].ToString();
                            string UpdatePODetailSKU = strSt3_St2_SkcCode + strSt3_sSize;
                            dtPoDetailListForUpdate.Tables[i + 1].Rows[k]["po2_lmuser"] = hzyMessage.User_Name_CN;
                            dtPoDetailListForUpdate.Tables[i + 1].Rows[k]["po2_lmdt"] = timeNow;
                            dtPoDetailListForUpdate.Tables[i + 1].Rows[k]["PO2_PD1_ProductCode"] = UpdatePODetailSKU;
                            CheckNumColumnValue(dtPoDetailListForUpdate);//检查列是否为空，如果为空赋值NULL
                        }
                        //构建update表
                        dtPoDetailListForUpdate.Tables[i + 1].Columns.Remove("st3_size");
                        dtPoDetailListForUpdate.Tables[i + 1].Columns.Remove("st3_st2_skccode");
                        dtPoDetailListForUpdate.Tables[i + 1].Columns.Remove("st2_sizegroup");
                        dtPoDetailListForUpdate.Tables[i + 1].Columns.Remove("rowindex");
                        dtPoDetailListForUpdate.Tables[i + 1].Columns.Remove("st2_color");
                        dtPoDetailListForUpdate.Tables[i + 1].Columns.Remove("st2_st1_stylecode");
                        dtPoDetailListForUpdate.Tables[i + 1].Columns.Remove("ct1_keyname");
                        //添加更新主键，按照GUID更新
                        ArrayList ListKey = new ArrayList();
                        ListKey.Add("po2_id");
                        bResult = m_conn.Update("[B02_BILL].[PO2_PODetail]", dtPoDetailListForUpdate.Tables[i + 1], ListKey);
                    }
                    //如果包含，delete，循环删除
                    else if (dtPoDetailOptype.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        m_conn.LockTableList.Add("[B02_BILL].[PO2_PODetail]");
                        for (int k = 0; k < dtPoDetailListForDelete.Tables[i + 1].Rows.Count; k++)
                        {
                            string strPO2_ID = dtPoDetailListForDelete.Tables[i + 1].Rows[k]["po2_id"].ToString();
                            bResult = m_conn.Delete("[B02_BILL].[PO2_PODetail]", "PO2_ID=" + "'" + strPO2_ID + "'");

                            if (strpo1_sourcepocode != "")
                            {
                                //郭琦琦
                                string aaaa = dtPoDetailListForDelete.Tables[i + 1].Rows[k]["po2_liseq"].ToString();
                                string bbbb = dtPoDetailListForUpdate.Tables[i + 1].Rows[k]["PO2_PD1_ProductCode"].ToString();
                                string cccc = dtPoDetailListForDelete.Tables[i + 1].Rows[k]["po2_id"].ToString();
                                string dddd = dtPoDetailListForDelete.Tables[i + 1].Rows[k]["po2_id"].ToString();
                                string eeee = dtPoDetailListForDelete.Tables[i + 1].Rows[k]["po2_pocode"].ToString();

                                string strYesNo = m_conn.GetDataTableFirstValue(" SELECT * FROM  dbo.View_Po  WHERE   1=1 and po2_pocode = '" + strPO1_POCode + "'and PO2_PD1_ProductCode = '" + bbbb + "'and PO2_LISeq='" + aaaa + "'and PO1_SourcePOCode = '" + strpo1_sourcepocode + "'").ToString();
                                if (strYesNo == "")
                                {
                                    string strSQL2 = @"UPDATE [B02_BILL].[CO2_CustomerOrderDetail] SET State =15  WHERE MARA_Code  ='" + bbbb + "' and CO1_Code ='" + strpo1_sourcepocode + "' and seq ='" + aaaa + "' and State <=35";
                                    m_conn.ExcuteQuerryByTran(strSQL2, new object[] { });
                                }

                            }



                        }
                    }
                }
            }
            string strzuigao = m_conn.GetDataTableFirstValue("SELECT MAX(State) State FROM [B02_BILL].[CO2_CustomerOrderDetail] WHERE CO1_Code = '" + strpo1_sourcepocode + "'").ToString();
            string strzuidi = m_conn.GetDataTableFirstValue("SELECT min(State) State FROM [B02_BILL].[CO2_CustomerOrderDetail] WHERE CO1_Code = '" + strpo1_sourcepocode + "'").ToString();
            string strSQL3 = @"UPDATE [B02_BILL].CO1_CustomerOrderHead  SET  MinState = '" + strzuidi + "' ,MaxState= '" + strzuigao + "' WHERE code = '" + strpo1_sourcepocode + "'";
            m_conn.ExcuteQuerryByTran(strSQL3, new object[] { });

            m_conn.CommitTransaction();//提交事务
            if (bResult)
            {
                //返回SQL执行结果，把单号作为返回值返回给前台，供前台刷新界面显示采购单号
                if (strPO1_POCode == "")
                {
                    dt_EditResult.Rows.Add(new object[] { true, mMaxPurchaseCode });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { true, strPO1_POCode });
                }
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "提交失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region APO 如果前台传过来的表里面第一行第一列为APO，对到货计划操作
        /// <summary>
        /// 如果前台传过来的表里面第一行第一列为APO，对到货计划操作
        /// </summary>
        private void APO()
        {
            string strAPOXML = ds.Tables["list"].Rows[0]["apo"].ToString();
            //解析XML 
            DataSet dsAPO = Common.Common.GetDSByExcelXML(strAPOXML);
            DataTable dtAPOOptype = dsAPO.Tables["OPTYPE"];
            string strSQLD = "";
            for (int i = 0; i < dtAPOOptype.Rows.Count; i++)
            {
                if (dtAPOOptype.Rows[i][0].ToString().ToUpper() == "INSERT")
                {
                    DateTime timeNow = DateTime.Now;//取当前时间
                    m_conn.BeginTransaction();//开启事务
                    string strAP1_AplandtHeadTime = dsAPO.Tables[i + 1].Rows[0]["ap1_aplandt"].ToString();
                    //调取生成到货计划编号类，按照条件取最大号。
                    string mMaxAP1_APO = AutoKeyCode.GetMaxKeyCode("新增到货计划编号", strAP1_AplandtHeadTime, "", "", m_conn);
                    //生成GUID
                    string strID = Guid.NewGuid().ToString();
                    string strAp1_PO1_PurchaseCode = "";
                    decimal nAP1_APlanNumber = 0;
                    //循环插入到货计划子表
                    for (int l = 0; l < dsAPO.Tables[i + 1].Rows.Count; l++)
                    {
                        strAp1_PO1_PurchaseCode = dsAPO.Tables[i + 1].Rows[l]["ap1_po1_purchasecode"].ToString();//获取采购单号
                        string strIDDetail = Guid.NewGuid().ToString();//获取guid
                        string strAp1_AplanNumber = dsAPO.Tables[i + 1].Rows[l]["ap1_aplannumber"].ToString();//获取到货计划数量
                        nAP1_APlanNumber += Convert.ToDecimal(strAp1_AplanNumber);//累加到货计划
                        string strAp1_Aplandt = dsAPO.Tables[i + 1].Rows[l]["ap1_aplandt"].ToString();//取到货计划时间
                        string strAp2_LinNmber = dsAPO.Tables[i + 1].Rows[l]["ap2_linumber"].ToString();//取子项次
                        string strAP2_LSNumber = dsAPO.Tables[i + 1].Rows[l]["AP2_LSNumber"].ToString();
                        string strSt3_St2_SkcCode = dsAPO.Tables[i + 1].Rows[l]["st3_st2_skccode"].ToString();//SKC
                        string strSt3_Size = dsAPO.Tables[i + 1].Rows[l]["st3_size"].ToString();//取尺码
                        string strSKU = strSt3_St2_SkcCode + strSt3_Size;//取SKU
                        string strAp2_State = dsAPO.Tables[i + 1].Rows[l]["ap2_state"].ToString();//取到货计划状态
                        strSQLD = @"
                                INSERT  INTO [B02_BILL].[AP2_APODetail]
                                                        ( [AP2_ID] ,
                                                          AP2_CONO ,
                                                          AP2_DIVI ,
                                                          AP2_APCode ,
                                                          AP2_LINumber ,
                                                          AP2_LSNumber ,
                                                          AP2_PD1_ProductCode ,
                                                          AP2_APlanNumber ,
                                                          AP2_State ,
                                                          AP2_APlanDt,
                                                          AP2_RgDt,
										                  AP2_RgUser,
										                  AP2_LmDt,
										                  AP2_LmUser
                                                        )
                                                        ( SELECT    @Param0 AP2_ID ,
                                                                    'GL' AP2_CONO ,
                                                                    'D01' AP2_DIVI ,
                                                                    @Param1 AP2_APCode ,
                                                                    @Param2 AP2_LINumber ,
                                                                    @Param3 AP2_LSNumber ,
                                                                    @Param4 AP2_PD1_ProductCode ,
                                                                    @Param5 AP2_APlanNumber ,
                                                                    @Param6 AP2_State ,
                                                                    @Param7 AP2_APlanDt,
                                                                    @Param8  AP2_RgDt,
										                            @Param9   AP2_RgUser,
										                            @Param10   AP2_LmDt,
										                            @Param11   AP2_LmUser
                                                        )
                                                         ";
                        //数据库直接执行SQLinsert
                        m_conn.ExcuteQuerryByTran(strSQLD, new string[] { 
                                    strIDDetail,mMaxAP1_APO.ToString(),strAp2_LinNmber,strAP2_LSNumber,strSKU,strAp1_AplanNumber,
                                strAp2_State,strAp1_Aplandt,timeNow.ToString(),hzyMessage.User_Name_CN,
                                timeNow.ToString(),hzyMessage.User_Name_CN});
                    }
                    //插入到货计划主表，构建新表
                    DataTable dtAPOhead = new DataTable();
                    dtAPOhead.Columns.Add("AP1_ID");
                    dtAPOhead.Columns.Add("AP1_CONO");
                    dtAPOhead.Columns.Add("AP1_DIVI");
                    dtAPOhead.Columns.Add("AP1_APCode");//到货计划编号
                    dtAPOhead.Columns.Add("AP1_PO1_PurchaseCode");//采购单编号
                    dtAPOhead.Columns.Add("AP1_APlanNumber");//本次计划到货数量
                    dtAPOhead.Columns.Add("AP1_APlanDt");//计划到货日期
                    dtAPOhead.Columns.Add("AP1_RgDt");
                    dtAPOhead.Columns.Add("AP1_RgUser");
                    dtAPOhead.Columns.Add("AP1_LmDt");
                    dtAPOhead.Columns.Add("AP1_LmUser");
                    dtAPOhead.Columns.Add("AP1_HState");//最高状态
                    dtAPOhead.Columns.Add("AP1_LState");//最低状态
                    //构建新行
                    DataRow drAPOhead = dtAPOhead.NewRow();
                    drAPOhead["AP1_ID"] = strID;
                    drAPOhead["AP1_CONO"] = "GL";
                    drAPOhead["AP1_DIVI"] = "D01";
                    drAPOhead["AP1_APCode"] = mMaxAP1_APO;
                    drAPOhead["AP1_PO1_PurchaseCode"] = strAp1_PO1_PurchaseCode;
                    drAPOhead["AP1_APlanNumber"] = nAP1_APlanNumber;
                    drAPOhead["AP1_APlanDt"] = strAP1_AplandtHeadTime;
                    drAPOhead["AP1_RgDt"] = timeNow;
                    drAPOhead["AP1_RgUser"] = hzyMessage.User_Name_CN;
                    drAPOhead["AP1_LmDt"] = timeNow;
                    drAPOhead["AP1_LmUser"] = hzyMessage.User_Name_CN;
                    drAPOhead["AP1_HState"] = "15";
                    drAPOhead["AP1_LState"] = "15";
                    //新行插入新表
                    dtAPOhead.Rows.Add(drAPOhead);
                    m_conn.Insert("[B02_BILL].[AP1_APOHead]", dtAPOhead);
                    m_conn.CommitTransaction();
                }
                else if (dtAPOOptype.Rows[i][0].ToString().ToUpper() == "UPDATE")
                {
                    m_conn.BeginTransaction();
                    //decimal nAP1_APlanNumberUpdate = 0;
                    DateTime timeNow = DateTime.Now;
                    string strAp1_ApCode = dsAPO.Tables[i + 1].Rows[0]["ap2_apcode"].ToString();//取到货计划单号

                    for (int l = 0; l < dsAPO.Tables[i + 1].Rows.Count; l++)
                    {
                        //构建新增表，行，按照GUID更新
                        DataTable dsAP2_list = new DataTable();
                        dsAP2_list.Columns.Add("ap2_aplannumber");
                        dsAP2_list.Columns.Add("ap2_aplandt");
                        dsAP2_list.Columns.Add("ap2_lmdt");
                        dsAP2_list.Columns.Add("ap2_lmuser");
                        string strAP2_ID = dsAPO.Tables[i + 1].Rows[l]["ap2_id"].ToString();
                        string strAP2_Aplandt = dsAPO.Tables[i + 1].Rows[l]["ap1_aplandt"].ToString();
                        string strAP2_AplanNumber = dsAPO.Tables[i + 1].Rows[l]["ap2_aplannumber"].ToString();
                        DataRow drAPOH = dsAP2_list.NewRow();
                        drAPOH["ap2_aplannumber"] = strAP2_AplanNumber;
                        drAPOH["ap2_aplandt"] = strAP2_Aplandt;
                        drAPOH["ap2_lmdt"] = timeNow;
                        drAPOH["ap2_lmuser"] = hzyMessage.User_Name_CN;
                        dsAP2_list.Rows.Add(drAPOH);
                        m_conn.Update("[B02_BILL].[AP2_APODetail]", dsAP2_list, "AP2_ID=" + "'" + strAP2_ID + "'");
                    }
                    //取到按照货计划子表单号取计划数量总和
                    string strSumAPODAPlanNumber = m_conn.GetDataTableFirstValue("SELECT    SUM(AP2_APlanNumber)FROM      [B02_BILL].AP2_APODetail WHERE  AP2_APCode =" + "'" + strAp1_ApCode + "'").ToString();
                    //更新到货主表
                    DataTable dsAP1_List = new DataTable();
                    dsAP1_List.Columns.Add("ap1_aplannumber");
                    dsAP1_List.Columns.Add("ap1_lmdt");
                    dsAP1_List.Columns.Add("ap1_lmuser");
                    DataRow dr = dsAP1_List.NewRow();
                    dr["ap1_aplannumber"] = strSumAPODAPlanNumber;
                    dr["ap1_lmdt"] = timeNow;
                    dr["ap1_lmuser"] = hzyMessage.User_Name_CN;
                    dsAP1_List.Rows.Add(dr);
                    m_conn.Update("[B02_BILL].[AP1_APOHead]", dsAP1_List, "ap1_apcode=" + "'" + strAp1_ApCode + "'");
                    m_conn.CommitTransaction();
                }
                else if (dtAPOOptype.Rows[i][0].ToString().ToUpper() == "DELETE")
                {
                    for (int l = 0; l < dsAPO.Tables[i + 1].Rows.Count; l++)
                    {
                        DateTime timeNow = DateTime.Now;
                        m_conn.BeginTransaction();
                        DataTable dsAP1_List = new DataTable();
                        DataTable dsAP2_List = new DataTable();
                        dsAP1_List.Columns.Add("ap1_apcode");
                        dsAP1_List.Columns.Add("ap1_aplannumber");
                        dsAP2_List.Columns.Add("ap2_id");
                        string strAPCode = dsAPO.Tables[i + 1].Rows[l]["ap2_apcode"].ToString();
                        string strAP2_Id = dsAPO.Tables[i + 1].Rows[l]["ap2_id"].ToString();
                        string strAP1_AplanNumber = dsAPO.Tables[i + 1].Rows[l]["ap2_aplannumber"].ToString();

                        //删除到货计划子表
                        DataRow drAPODetail = dsAP2_List.NewRow();
                        drAPODetail["ap2_id"] = strAP2_Id;
                        dsAP2_List.Rows.Add(drAPODetail);
                        m_conn.Delete("[B02_BILL].[AP2_APODetail]", "ap2_id=" + "'" + strAP2_Id + "'");

                        //检查子表数据是不是存在，如果不存在，就删除主表，如果存在，求和更新主表
                        string strRowCount = m_conn.GetDataTableRowCount(" SELECT    * FROM      [B02_BILL].AP2_APODetail WHERE  AP2_APCode =" + "'" + strAPCode + "'").ToString();
                        //行数为0，到货计划子表 删除到货计划主表
                        if (strRowCount == "0")
                        {
                            m_conn.Delete("[B02_BILL].[AP1_APOHead]", "AP1_APCode=" + "'" + strAPCode + "'");
                        }
                        else
                        {
                            //取到货计划子表到货计划数量总和
                            string strSumAPODAPlanNumber = m_conn.GetDataTableFirstValue("SELECT    SUM(AP2_APlanNumber)FROM      [B02_BILL].AP2_APODetail WHERE  AP2_APCode =" + "'" + strAPCode + "'").ToString();
                            //更新到货计划主表
                            DataRow drAPOHead = dsAP1_List.NewRow();
                            drAPOHead["ap1_apcode"] = strAPCode;
                            drAPOHead["ap1_aplannumber"] = strSumAPODAPlanNumber;
                            dsAP1_List.Rows.Add(drAPOHead);
                            m_conn.Update("[B02_BILL].[AP1_APOHead]", dsAP1_List, "ap1_apcode=" + "'" + strAPCode + "'");
                        }
                    }
                    m_conn.CommitTransaction();
                }
            }
            dt_EditResult.Rows.Add(new object[] { true, "成功" });
            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region GETSTYLE 按照供应商编号和品牌取款号
        /// <summary>
        /// 按照供应商编号和品牌取款号
        /// </summary>
        private void GETSTYLE()
        {
            //取款式信息，重写分页信息
            m_hzyPageInfo.Page = 1;
            m_hzyPageInfo.PageRowCount = 100000;
            string strSQL = @"
                                         SELECT   *  FROM  (
                                         SELECT  
                                                    t2.ST2_State ,
                                                    t2.ST2_ImagePath ,
                                                    t2.ST2_PurchasePrice ,
                                                    t2.ST2_PurchasePrice AS PO1_OCurrencySums ,
                                                    t1.ST1_SupperierStyle ,
                                                    t2.ST2_SupperierColor ,
                                                    t2.ST2_ST1_StyleCode ,
                                                    t2.ST2_ID ,
                                                    t2.ST2_CONO ,
                                                    t2.ST2_DIVI ,
                                                    t2.ST2_SKCCode ,
                                                    t2.ST2_Color ,
                                                    t2.ST2_SizeGroup ,
                                                    t2.ST2_SupperierSKC ,
                                                    t2.ST2_SalePrice ,
                                                    t2.ST2_RefSalePrice ,
                                                    t2.ST2_RgDt ,
                                                    t2.ST2_RgUser ,
                                                    t2.ST2_LmDt ,
                                                    t2.ST2_LmUser ,
                                                    t2.ST2_UptNo,
		                                            t1.ST1_Season,
		                                            t1.ST1_Years,
                                                     t1.ST1_BR1_BrandCode,
		                                             t1.ST1_SupplierCode,
												     t4.BR1_Name
                                            FROM    [B01_MDM].[ST2_StyleColor] t2
                                                    LEFT JOIN [B01_MDM].[ST1_Style] t1 ON t1.ST1_StyleCode = t2.ST2_ST1_StyleCode 
												    LEFT JOIN [B01_MDM].[BR1_Brand] t4 ON t4.BR1_BrandCode = t1.ST1_BR1_BrandCode)t3
                                               where 1=1 
                                                " + m_hzyPageInfo.Where;
            //ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }

        #endregion

        #region GETAPOLIST 取到货计划子表
        /// <summary>
        /// 取到货计划子表
        /// </summary>
        private void GETAPOLIST()
        {
            string strPoCode = ds.Tables["list"].Rows[0]["purchasecode"].ToString();
            string strSQL = @"
                                    SELECT  PO2_POCode,PO2_LISeq,PO2_LSSeq,PO2_PD1_ProductCode,PO2_Number,PO2_State
                                    INTO #TEMP_PO
                                    FROM B02_BILL.PO2_PODetail WHERE PO2_POCode=@Param0 AND PO2_CONO='GL' AND PO2_DIVI='D01'

                                    
                                   SELECT A.AP2_APCode,AP2_LINumber,AP2_LSNumber,AP2_APlanNumber,AP2_PD1_ProductCode,B.AP1_APlanDt
									,AP1_RgDt,AP1_RgUser,B.AP1_PO1_PurchaseCode,A.AP2_ID
                                    INTO #temp_AP
                                    FROM B02_BILL.AP2_APODetail A,  B02_BILL.AP1_APOHead B
                                    WHERE A.AP2_CONO=B.AP1_CONO AND A.AP2_DIVI=B.AP1_DIVI AND A.AP2_APCode=B.AP1_APCode
                                    AND B.AP1_PO1_PurchaseCode=@Param0
                                    AND AP1_CONO='GL' AND AP1_DIVI='D01'

                                    SELECT B.RP2_LINumber,B.RP2_LSNumber,SUM(B.RP2_Number) RPNumberSUMS
                                    INTO #TEMP_RP
                                    FROM B02_BILL.RP1_POReceiptHead A,B02_BILL.RP2_POReceiptDetail B
                                    WHERE A.RP1_CONO=B.RP2_CONO AND A.RP1_DIVI=B.RP2_DIVI 
                                    AND A.RP1_ReceiptCode=B.RP2_ReceiptCode
                                    AND A.RP1_AP1_APCode IN(
                                    SELECT DISTINCT AP2_APCode
                                    FROM #temp_AP
                                    ) AND B.RP2_State='90' --AND A.RP1_State='90'
                                    GROUP BY B.RP2_LINumber,B.RP2_LSNumber

                                    SELECT A.*,E.ST3_ST1_StyleCode,E.ST3_Size,(po2_number - APlanNumberSums) differences,f.ST1_SupperierStyle,
                                           G.ST2_SupperierColor,E.ST3_SupperierSize,
                                    REPLACE(E.ST3_ST2_SKCCode,E.ST3_ST1_StyleCode,'') COLORID,B.APlanNumberSums,ISNULL(C.RPNumberSUMS,0) RPNumberSUMS,D.PO2_Number
                                    FROM #temp_AP A
                                    LEFT JOIN (

                                    SELECT AP2_LINumber,AP2_LSNumber,SUM(AP2_APlanNumber) APlanNumberSums
                                    FROM #temp_AP
                                    GROUP BY AP2_LINumber,AP2_LSNumber
                                    ) B ON A.AP2_LINumber=B.AP2_LINumber AND A.AP2_LSNumber=B.AP2_LSNumber
                                    LEFT JOIN #TEMP_RP C ON A.AP2_LINumber=C.RP2_LINumber AND A.AP2_LSNumber=C.RP2_LSNumber
                                    LEFT JOIN #TEMP_PO D ON PO2_LISeq=A.AP2_LINumber AND PO2_LSSeq=A.AP2_LSNumber
                                    LEFT JOIN B01_MDM.ST3_StyleColorSize E ON A.AP2_PD1_ProductCode=E.ST3_SKUCode
                                    LEFT JOIN B01_MDM.ST1_Style F ON f.ST1_StyleCode = E.ST3_ST1_StyleCode
                                    LEFT JOIN B01_MDM.ST2_StyleColor G ON g.ST2_SKCCode = E.ST3_ST2_SKCCode
											ORDER BY A.AP2_APCode,A.AP2_PD1_ProductCode,E.ST3_Size
											";
            ds_Return = m_conn.GetDataSet(strSQL, new string[] { strPoCode });
            //ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[] { strPoCode }, m_hzyPageInfo);
        }

        #endregion

        #region DELETEPOHEAD 删除到货计划
        /// <summary>
        /// 删除到货计划
        /// </summary>
        private void DELETEPOHEAD()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PO1_POHead]");

            string strPO1_POCode = ds.Tables["list"].Rows[0]["PO1_POCode"].ToString();
            DateTime timeNow = DateTime.Now;
            DataTable dtDeletePOHead = new DataTable();
            dtDeletePOHead.Columns.Add("PO1_HState");
            dtDeletePOHead.Columns.Add("PO1_LState");
            dtDeletePOHead.Columns.Add("PO1_POCode");

            dtDeletePOHead.Columns.Add("PO1_LmDt");
            dtDeletePOHead.Columns.Add("PO1_LmUser");
            //构建新行，删除默认最高和最低都为99
            DataRow dr = dtDeletePOHead.NewRow();
            dr["PO1_HState"] = "99";
            dr["PO1_LState"] = "99";
            dr["PO1_POCode"] = strPO1_POCode;
            dr["PO1_LmDt"] = timeNow;
            dr["PO1_LmUser"] = hzyMessage.User_Name_CN;
            dtDeletePOHead.Rows.Add(dr);
            m_conn.BeginTransaction();
            bResult = m_conn.Update("[B02_BILL].[PO1_POHead]", dtDeletePOHead, "PO1_POCode=" + strPO1_POCode);
            m_conn.CommitTransaction();
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

        #region ENDPOHEAD 采购主表完结
        /// <summary>
        /// 采购主表完结
        /// </summary>
        private void ENDPOHEAD()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PO1_POHead]");
            m_conn.LockTableList.Add("[B02_BILL].[PO2_PODetail]");
            DateTime timeNow = DateTime.Now;
            string strPO1_POCode = ds.Tables["list"].Rows[0]["PO1_POCode"].ToString();//取采购单号
            //构建采购单主表完结信息表，和子表完结信息表，主表完结，子表相应全部完结
            DataTable dtEndPohead = new DataTable();
            dtEndPohead.Columns.Add("PO1_HState");
            dtEndPohead.Columns.Add("PO1_LState");
            dtEndPohead.Columns.Add("PO1_POCode");
            dtEndPohead.Columns.Add("PO1_LmDt");
            dtEndPohead.Columns.Add("PO1_LmUser");
            DataRow dr = dtEndPohead.NewRow();
            dr["PO1_HState"] = "75";
            dr["PO1_LState"] = "75";
            dr["PO1_POCode"] = strPO1_POCode;
            dr["PO1_LmDt"] = timeNow;
            dr["PO1_LmUser"] = hzyMessage.User_Name_CN;
            dtEndPohead.Rows.Add(dr);

            DataTable dtEndPoDetail = new DataTable();
            dtEndPoDetail.Columns.Add("PO2_State");
            dtEndPoDetail.Columns.Add("PO2_POCode");
            dtEndPoDetail.Columns.Add("PO2_LmDt");
            dtEndPoDetail.Columns.Add("PO2_LmUser");
            DataRow drDetail = dtEndPoDetail.NewRow();
            drDetail["PO2_State"] = "75";
            drDetail["PO2_POCode"] = strPO1_POCode;
            drDetail["PO2_LmDt"] = timeNow;
            drDetail["PO2_LmUser"] = hzyMessage.User_Name_CN;
            dtEndPoDetail.Rows.Add(drDetail);

            m_conn.BeginTransaction();
            bResult = m_conn.Update("[B02_BILL].[PO1_POHead]", dtEndPohead, "PO1_POCode=" + strPO1_POCode);
            bResult = m_conn.Update("[B02_BILL].[PO2_PODetail]", dtEndPoDetail, "PO2_POCode=" + strPO1_POCode);
            m_conn.CommitTransaction();

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "完结成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "完结失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region EXAMINEPODETAIL 采购子表审批（批量）
        /// <summary>
        /// 采购子表审批（批量）
        /// </summary>
        private void EXAMINEPODETAIL()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PO2_PODetail]");
            DateTime timeNow = DateTime.Now;
            m_conn.BeginTransaction();
            //循环传过来需要审核的数据，单行循环审批
            for (int l = 0; l < ds.Tables["list"].Rows.Count; l++)
            {
                string strPO2_State = ds.Tables["list"].Rows[l]["po2_state"].ToString();
                string strPO2_ID = ds.Tables["list"].Rows[l]["po2_id"].ToString();

                DataTable dtExpaminePodetail = new DataTable();
                dtExpaminePodetail.Columns.Add("po2_id");
                dtExpaminePodetail.Columns.Add("po2_state");
                dtExpaminePodetail.Columns.Add("PO2_LmDt");
                dtExpaminePodetail.Columns.Add("PO2_LmUser");

                DataRow dr = dtExpaminePodetail.NewRow();
                dr["po2_id"] = strPO2_ID;
                dr["po2_state"] = "35";
                dr["PO2_LmDt"] = timeNow;
                dr["PO2_LmUser"] = hzyMessage.User_Name_CN;
                dtExpaminePodetail.Rows.Add(dr);
                bResult = m_conn.Update("[B02_BILL].[PO2_PODetail]", dtExpaminePodetail, "po2_id=" + "'" + strPO2_ID + "'");
            }

            //采购子表状态更改之后刷新主表最大最小状态
            string strPO2_POCode = ds.Tables["list"].Rows[0]["PO2_POCode"].ToString();
            string strMaxState = m_conn.GetDataTableFirstValue("SELECT  MAX(PO2_State) MAX FROM  [B02_BILL].[PO2_PODetail] WHERE   PO2_POCode =" + "'" + strPO2_POCode + "'").ToString();
            string strMinState = m_conn.GetDataTableFirstValue("SELECT  MIN(PO2_State) MIN FROM  [B02_BILL].[PO2_PODetail] WHERE   PO2_POCode =" + "'" + strPO2_POCode + "'").ToString();
            DataTable dtUpdatePohead = new DataTable();
            dtUpdatePohead.Columns.Add("PO1_HState");
            dtUpdatePohead.Columns.Add("PO1_LState");
            DataRow drPOH = dtUpdatePohead.NewRow();
            drPOH["PO1_HState"] = strMaxState;
            drPOH["PO1_LState"] = strMinState;
            dtUpdatePohead.Rows.Add(drPOH);
            bResult = m_conn.Update("[B02_BILL].[PO1_POHead]", dtUpdatePohead, "PO1_POCode=" + "'" + strPO2_POCode + "'");
            m_conn.CommitTransaction();

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
        #endregion

        #region BACKEXAMINEPODETAIL 采购子表反审批
        /// <summary>
        /// 采购子表反审批
        /// </summary>
        private void BACKEXAMINEPODETAIL()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PO2_PODetail]");
            DateTime timeNow = DateTime.Now;
            m_conn.BeginTransaction();

            for (int l = 0; l < ds.Tables["list"].Rows.Count; l++)
            {
                string strPO2_ID = ds.Tables["list"].Rows[l]["po2_id"].ToString();
                DataTable dtExpaminePodetail = new DataTable();
                dtExpaminePodetail.Columns.Add("po2_id");
                dtExpaminePodetail.Columns.Add("po2_state");
                dtExpaminePodetail.Columns.Add("PO2_LmDt");
                dtExpaminePodetail.Columns.Add("PO2_LmUser");

                DataRow dr = dtExpaminePodetail.NewRow();
                dr["po2_id"] = strPO2_ID;
                dr["po2_state"] = "15";
                dr["PO2_LmDt"] = timeNow;
                dr["PO2_LmUser"] = hzyMessage.User_Name_CN;
                dtExpaminePodetail.Rows.Add(dr);
                bResult = m_conn.Update("[B02_BILL].[PO2_PODetail]", dtExpaminePodetail, "po2_id=" + "'" + strPO2_ID + "'");
            }

            //采购子表状态更改之后刷新主表最大最小状态
            string strPO2_POCode = ds.Tables["list"].Rows[0]["PO2_POCode"].ToString();
            string strMaxState = m_conn.GetDataTableFirstValue("SELECT  MAX(PO2_State) MAX FROM  [B02_BILL].[PO2_PODetail] WHERE   PO2_POCode =" + "'" + strPO2_POCode + "'").ToString();
            string strMinState = m_conn.GetDataTableFirstValue("SELECT  MIN(PO2_State) MIN FROM  [B02_BILL].[PO2_PODetail] WHERE   PO2_POCode =" + "'" + strPO2_POCode + "'").ToString();
            DataTable dtUpdatePohead = new DataTable();
            dtUpdatePohead.Columns.Add("PO1_HState");
            dtUpdatePohead.Columns.Add("PO1_LState");
            DataRow dr2 = dtUpdatePohead.NewRow();
            dr2["PO1_HState"] = strMaxState;
            dr2["PO1_LState"] = strMinState;
            dtUpdatePohead.Rows.Add(dr2);
            bResult = m_conn.Update("[B02_BILL].[PO1_POHead]", dtUpdatePohead, "PO1_POCode=" + "'" + strPO2_POCode + "'");

            m_conn.CommitTransaction();

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "反审批成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "反审批失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region ENDPODTETAIL 采购主表完结
        /// <summary>
        /// 采购主表完结
        /// </summary>
        private void ENDPODTETAIL()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[PO2_PODetail]");
            DateTime timeNow = DateTime.Now;

            m_conn.BeginTransaction();

            for (int l = 0; l < ds.Tables["list"].Rows.Count; l++)
            {
                string strpo2_id = ds.Tables["list"].Rows[l]["po2_id"].ToString();
                DataTable dtEndPodetail = new DataTable();
                dtEndPodetail.Columns.Add("po2_id");
                dtEndPodetail.Columns.Add("po2_state");
                dtEndPodetail.Columns.Add("PO2_LmDt");
                dtEndPodetail.Columns.Add("PO2_LmUser");

                DataRow dr = dtEndPodetail.NewRow();
                dr["po2_id"] = strpo2_id;
                dr["po2_state"] = "75";
                dr["PO2_LmDt"] = timeNow;
                dr["PO2_LmUser"] = hzyMessage.User_Name_CN;
                dtEndPodetail.Rows.Add(dr);
                bResult = m_conn.Update("[B02_BILL].[PO2_PODetail]", dtEndPodetail, "po2_id=" + "'" + strpo2_id + "'");

                //开始yjw 完结到货计划子表
                string strap2_sku = ds.Tables["list"].Rows[l]["po2_pd1_productcode"].ToString();
                DataTable dtEndAPOdetail = new DataTable();
                dtEndAPOdetail.Columns.Add("ap2_pd1_productcode");
                dtEndAPOdetail.Columns.Add("ap2_state");
                dtEndAPOdetail.Columns.Add("AP2_LmDt");
                dtEndAPOdetail.Columns.Add("AP2_LmUser");

                DataRow dr1 = dtEndAPOdetail.NewRow();
                dr1["ap2_pd1_productcode"] = strap2_sku;
                dr1["ap2_state"] = "75";
                dr1["AP2_LmDt"] = timeNow;
                dr1["AP2_LmUser"] = hzyMessage.User_Name_CN;
                dtEndAPOdetail.Rows.Add(dr1);
                bResult = m_conn.Update("[B02_BILL].[AP2_APODetail]", dtEndAPOdetail, "ap2_pd1_productcode='" + strap2_sku + "'");
                //结束
            }

            //采购子表状态更改之后刷新主表最大最小状态
            string strPO2_POCode = ds.Tables["list"].Rows[0]["PO2_POCode"].ToString();
            string strMaxState = m_conn.GetDataTableFirstValue("SELECT  MAX(PO2_State) MAX FROM  [B02_BILL].[PO2_PODetail] WHERE   PO2_POCode =" + "'" + strPO2_POCode + "'").ToString();
            string strMinState = m_conn.GetDataTableFirstValue("SELECT  MIN(PO2_State) MIN FROM  [B02_BILL].[PO2_PODetail] WHERE   PO2_POCode =" + "'" + strPO2_POCode + "'").ToString();
            DataTable dtUpdatePohead = new DataTable();
            dtUpdatePohead.Columns.Add("PO1_HState");
            dtUpdatePohead.Columns.Add("PO1_LState");
            DataRow drPOHeadState = dtUpdatePohead.NewRow();
            drPOHeadState["PO1_HState"] = strMaxState;
            drPOHeadState["PO1_LState"] = strMinState;
            dtUpdatePohead.Rows.Add(drPOHeadState);
            bResult = m_conn.Update("[B02_BILL].[PO1_POHead]", dtUpdatePohead, "PO1_POCode=" + "'" + strPO2_POCode + "'");

            //yjw 到货计划子表状态更新完之后刷新主表中的最大最小状态
            string strAP2_SKU = ds.Tables["list"].Rows[0]["po2_pd1_productcode"].ToString();
            string strSQL = @"select AP2_APCode AP1_APCode,MAX(ap2_state) AP1_HState,MIN(ap2_state) AP1_LState from [B02_BILL].[AP2_APODetail] 
                                where AP2_APCode in(
		                                        select AP2_APCode from [B02_BILL].[AP2_APODetail] 
		                                        where AP2_PD1_ProductCode='" + strAP2_SKU + "') group by AP2_APCode";

            DataTable dtStateTable = m_conn.GetDataTable(strSQL);
            ArrayList alist = new ArrayList();
            alist.Add("AP1_APCode");
            bResult = m_conn.Update("[B02_BILL].[AP1_APOHead]", dtStateTable, alist);

            m_conn.CommitTransaction();

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "完结成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "完结失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region ENDAPODTETAIL 到货计划子表完结
        /// <summary>
        /// 到货计划子表完结
        /// </summary>
        private void ENDAPODTETAIL()
        {
            bool bResult = false;
            m_conn.LockTableList.Add("[B02_BILL].[AP2_APODetail]");
            DateTime timeNow = DateTime.Now;

            m_conn.BeginTransaction();

            for (int l = 0; l < ds.Tables["list"].Rows.Count; l++)
            {
                string strPo2_Id = ds.Tables["list"].Rows[l]["AP2_ID"].ToString();
                DataTable dtEndApodetail = new DataTable();
                dtEndApodetail.Columns.Add("AP2_ID");
                dtEndApodetail.Columns.Add("AP2_State");
                dtEndApodetail.Columns.Add("AP2_LmDt");
                dtEndApodetail.Columns.Add("AP2_LmUser");

                DataRow dr = dtEndApodetail.NewRow();
                dr["AP2_ID"] = strPo2_Id;
                dr["AP2_State"] = "75";
                dr["AP2_LmDt"] = timeNow;
                dr["AP2_LmUser"] = hzyMessage.User_Name_CN;
                dtEndApodetail.Rows.Add(dr);
                bResult = m_conn.Update("[B02_BILL].[AP2_APODetail]", dtEndApodetail, "AP2_ID=" + "'" + strPo2_Id + "'");
            }
            m_conn.CommitTransaction();

            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "完结成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "完结失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region CheckNumColumnValue检查列值，如果为空，附上默认值
        /// <summary>
        /// 检查列值，如果为空，附上默认值
        /// </summary>
        /// <param name="pds"></param>
        private void CheckNumColumnValue(DataSet pds)
        {
            if (pds.Tables["list"].Columns.Contains("PO1_PZNumber") && pds.Tables["list"].Rows[0]["PO1_PZNumber"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["PO1_PZNumber"] = DBNull.Value;
            }
            if (pds.Tables["list"].Columns.Contains("PO1_SupplyTax") && pds.Tables["list"].Rows[0]["PO1_SupplyTax"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["PO1_SupplyTax"] = DBNull.Value;
            }
            if (pds.Tables["list"].Columns.Contains("PO1_OCurrencySums") && pds.Tables["list"].Rows[0]["PO1_OCurrencySums"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["PO1_OCurrencySums"] = DBNull.Value;
            }
            if (pds.Tables["list"].Columns.Contains("PO1_DCurrencySums") && pds.Tables["list"].Rows[0]["PO1_DCurrencySums"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["PO1_DCurrencySums"] = DBNull.Value;
            }
            if (pds.Tables["list"].Columns.Contains("PO1_ExchangeRate") && pds.Tables["list"].Rows[0]["PO1_ExchangeRate"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["PO1_ExchangeRate"] = DBNull.Value;
            }
            if (pds.Tables["list"].Columns.Contains("PO1_TranSportRatio") && pds.Tables["list"].Rows[0]["PO1_TranSportRatio"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["PO1_TranSportRatio"] = DBNull.Value;
            }
            if (pds.Tables["list"].Columns.Contains("PO1_IncreaseRatio") && pds.Tables["list"].Rows[0]["PO1_IncreaseRatio"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["PO1_IncreaseRatio"] = DBNull.Value;
            }
            if (pds.Tables["list"].Columns.Contains("PO1_TariffRatio") && pds.Tables["list"].Rows[0]["PO1_TariffRatio"].ToString() == "")
            {
                pds.Tables["list"].Rows[0]["PO1_TariffRatio"] = DBNull.Value;
            }

            for (int l = 0; l < pds.Tables["list"].Rows.Count; l++)
            {
                if (pds.Tables["list"].Columns.Contains("po2_pd1_supperiersize") && pds.Tables["list"].Rows[l]["po2_pd1_supperiersize"].ToString() == "")
                {
                    pds.Tables["list"].Rows[l]["po2_pd1_supperiersize"] = DBNull.Value;
                }
                if (pds.Tables["list"].Columns.Contains("po2_number") && pds.Tables["list"].Rows[l]["po2_number"].ToString() == "")
                {
                    pds.Tables["list"].Rows[l]["po2_number"] = DBNull.Value;
                }
                if (pds.Tables["list"].Columns.Contains("po2_unit") && pds.Tables["list"].Rows[l]["po2_unit"].ToString() == "")
                {
                    pds.Tables["list"].Rows[l]["po2_unit"] = DBNull.Value;
                }
                if (pds.Tables["list"].Columns.Contains("po2_plandeliverydate") && pds.Tables["list"].Rows[l]["po2_plandeliverydate"].ToString() == "")
                {
                    pds.Tables["list"].Rows[l]["po2_plandeliverydate"] = DBNull.Value;
                }
                if (pds.Tables["list"].Columns.Contains("po2_purchasecurrency") && pds.Tables["list"].Rows[l]["po2_purchasecurrency"].ToString() == "")
                {
                    pds.Tables["list"].Rows[l]["po2_purchasecurrency"] = DBNull.Value;
                }

            }
        }
        #endregion

        #endregion
    }
}
