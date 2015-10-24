using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Text;
using System.Collections;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;

/// 类名：GL_ERP_Defective
/// 类说明：对GL_ERP_Defective(降级品的增删查)的CRUD,为Easyui专用
/// 创建人：刘洪
/// 创建日期：2014-06-18 
/// 修改人：
/// 修改日期：
/// 修改内容：
/// 


namespace HZY.COM.WS.Hawk
{
    /// <summary>
    /// 对GL_ERP_Claim(索赔的增删改查)的CRUD,为Easyui专用
    /// </summary>
    /// 
    public class Defective : HZYLogicBase, ILogicGetData
    {
        #region 构造函数

        public Defective()
        {
            this.m_SessionCheck = true;
        }

        #endregion

        #region 内部变量

        private Dbconn conn = new Dbconn("Hawk");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime now = DateTime.Now;
        private DataTable dt_DefList = new dsCommon.dtResultDataTable();
        private DataSet m_RequestXML = new DataSet();
        private DataSet m_ReturnData = new DataSet();
        //private string m_User = this.hzyMessage.User_Name;

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
                //接收XML的内容
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                m_RequestXML = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = m_RequestXML.Tables["OPTYPE"];
                dt_DefList = m_RequestXML.Tables["List"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GET".ToUpper())//取降级品主界面Datagrid的数据.
                {
                    Get();
                }
                else
                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "OnExpandRow".ToUpper())//取降级品主界面展开的数据
                    {
                        GetOnExpandRow();
                    }
                    else
                        if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSearch".ToUpper())//查询按钮的方法
                        {
                            GetSearch();
                        }
                        else
                            if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetSKC".ToUpper()) //申请界面数据加载
                            {
                                GetSKC();
                            }
                            else
                                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "SetDefective".ToUpper()) //保存申请的数据
                                {
                                    SetDefective();
                                }
                                else
                                    if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetPrintSearch".ToUpper()) //降级品打印数据的查询
                                    {
                                        GetPrintSearch();
                                    };
                return m_ReturnData;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            };
        }

        #endregion

        #region 内部函数

        #region 取降级品的主界面的DataGrid数据

        /// <summary>
        /// 取索赔管理主界面Datagrid的数据
        /// </summary>
        /// 
        private void Get()
        {
            string strSQL = @"
                        SELECT [DD1_ST1_StyleCode]
                              ,[DD1_ST2_Color]
                              ,[DD1_Sources]
                              ,[SIZE1]
                              ,[SIZE2]
                              ,[SIZE3]
                              ,[SIZE4]
                              ,[SIZE5]
                              ,[SIZE6]
                              ,[SIZE7]
                              ,[SIZE8]
                              ,[SIZE9]
                              ,[SIZEF]
                              ,(isNULL([SIZE1],0)+isNULL([SIZE2],0)+isNULL([SIZE3],0)+isNULL([SIZE4],0)+isNULL([SIZE5],0)+isNULL([SIZE6],0)+isNULL([SIZE7],0)+isNULL([SIZE8],0)+isNULL([SIZE9],0)+isNULL([SIZEF],0)) sumQty
                              ,[DD1_DemoteReason]
                              ,[DD1_RgDt]
                              ,[DD1_RgUser]
                        FROM [dbo].[View_DefectiveHead]
                        WHERE (DD1_RgDt BETWEEN DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0) AND GETDATE())";
            m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }

        #endregion

        #region 取降级品主界面的展开数据

        /// <summary>
        /// 取索赔主界面的展开数据
        /// </summary>
        /// 
        private void GetOnExpandRow()
        {
            string strDDStyCode = dt_DefList.Rows[0]["StyleCode"].ToString();    //款号
            string strDDColor = dt_DefList.Rows[0]["Color"].ToString();   //颜色
            string strDDSour = dt_DefList.Rows[0]["Sources"].ToString();    //来源
            string strDDRgdt = dt_DefList.Rows[0]["RgDt"].ToString();   //创建时间

            string strSQL = @"
                        SELECT [DD1_ST1_StyleCode]
                              ,[DD1_ST2_SKCCode]
                              ,[DD1_ST2_Color]
                              ,[DD1_ST3_Size]
                              ,[DD1_DemoteBarcode]
                        FROM [B03_TRANS].[DD1_Demotion]
                        WHERE [DD1_ST1_StyleCode] = '" + strDDStyCode + "' AND [DD1_ST2_Color] = '" + strDDColor + @"'
                        AND [DD1_Sources] = '" + strDDSour + "' AND [DD1_RgDt] = '" + strDDRgdt + "'";
            m_ReturnData = conn.GetDataSet(strSQL);
            return;
        }

        #endregion

        #region 搜索查询的方法

        /// <summary>
        /// 取索赔主界面的查询数据
        /// </summary>
        /// 
        private void GetSearch()
        {
            string strStyCode = dt_DefList.Rows[0]["Style"].ToString();     //款号
            string strRgUser = dt_DefList.Rows[0]["RgUser"].ToString();     //申请人
            string strSour = dt_DefList.Rows[0]["Sour"].ToString();    //来源
            string strStatDay = dt_DefList.Rows[0]["datStatDay"].ToString();//开始时间
            string strdEndDay = dt_DefList.Rows[0]["datEndDay"].ToString(); //结束时间
            string strSQL = @"
                        SELECT [DD1_ST1_StyleCode]
                              ,[DD1_ST2_Color]
                              ,[DD1_Sources]
                              ,[SIZE1]
                              ,[SIZE2]
                              ,[SIZE3]
                              ,[SIZE4]
                              ,[SIZE5]
                              ,[SIZE6]
                              ,[SIZE7]
                              ,[SIZE8]
                              ,[SIZE9]
                              ,[SIZEF]
                              ,(isNULL([SIZE1],0)+isNULL([SIZE2],0)+isNULL([SIZE3],0)+isNULL([SIZE4],0)+isNULL([SIZE5],0)+isNULL([SIZE6],0)+isNULL([SIZE7],0)+isNULL([SIZE8],0)+isNULL([SIZE9],0)+isNULL([SIZEF],0)) sumQty
                              ,[DD1_DemoteReason]
                              ,[DD1_RgDt]
                              ,[DD1_RgUser]
                        FROM [dbo].[View_DefectiveHead]
                        WHERE 1=1";
            if (strStyCode != "")
            {
                strSQL += " AND DD1_ST1_StyleCode LIKE '%" + strStyCode + "%'";
            };
            if (strRgUser != "")
            {
                strSQL += " AND DD1_RgUser = '" + strRgUser + "'";
            };
            if (strSour != "")
            {
                strSQL += " AND DD1_Sources = '" + strSour + "'";
            };
            if (strStatDay != "")
            {
                strSQL += " AND DD1_RgDt BETWEEN CONVERT(varchar(100),'" + strStatDay + @"', 121) + ' 00:00:00.000'
                            AND CONVERT(varchar(100), '" + strdEndDay + "', 121) + ' 23:59:59.000'";
            };
            m_ReturnData = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
            return;
        }

        #endregion

        #region 申请界面查询款号的方法（GetSKC）
        /// <summary>
        /// 查询款号的方法，从[ST2_StyleColor]表中取数据
        /// </summary>
        /// <param0>参数0，用于存放查询条件的SKC</param0>
        private void GetSKC()
        {
            string strStyle = dt_DefList.Rows[0]["StyleCode"].ToString();      //款号

            string getSizeGroupSQL = "SELECT ST2_SizeGroup FROM [B01_MDM].[ST2_StyleColor] WHERE [ST2_ST1_StyleCode]  LIKE '%" + strStyle + "%'";

            string strSizeGroup = conn.GetDataTableFirstValue(getSizeGroupSQL).ToString();

            string strGetSizeSQL = @"
                    SELECT [CT1_KeyID]
                          ,[CT1_KeyName]
                          ,[CT1_OptionsValues]
                          ,[CT1_Options]
                    FROM [M01_CONF].[CT0_CSYTAB]
                    WHERE CT1_Code = 'SIDE' AND 
                    CT1_FatherID = (SELECT CT1_ID FROM [M01_CONF].[CT0_CSYTAB] WHERE CT1_KeyID = '"+strSizeGroup+"' )";


            DataTable dtGetSize = conn.GetDataTable(strGetSizeSQL);
            dtGetSize.TableName = "GetSize";

            string strSQL = @"
                        SELECT [ST2_ST1_StyleCode]
                              ,[ST2_SKCCode]
                              ,[ST2_Color]
                              ,[ST2_State]
                              ,[ST2_SizeGroup]
                        FROM [B01_MDM].[ST2_StyleColor]
                        WHERE [ST2_State] = '20' AND [ST2_SupperierColor] NOT IN ('G','V')  AND [ST2_ST1_StyleCode]  LIKE '%" + strStyle + "%'";
            DataTable dtData = conn.GetDataTable(strSQL);
            dtData.TableName = "Data";

            m_ReturnData.Tables.Add(dtGetSize.Copy());
            m_ReturnData.Tables.Add(dtData.Copy()); 
        }
        #endregion

        #region 降级品数据处理 (处理并抛出)
        /// <summary>
        /// 用于向数据库存储数据（新增或修改）。
        /// </summary>
        /// <param0>款号</param0>
        /// <param1>颜色</param1>
        /// <param2>尺码</param2>
        /// <param3>来源</param3>
        /// <returns>
        /// 返回成功或者失败
        /// </returns>
        private void SetDefective()
        {
            //尺码与数量
            string strSize = "";
            string strNum = "";

            DataSet dsNewDs = CretaeTable();

            DataSet dsReceive = new DataSet();

            for (int i = 0; i < dt_DefList.Rows.Count; i++)
            {
                int j = 0;
                string strDemoteBarG = "";  //“供应商”最大条码
                string strDemoteBarV = "";  //“店铺”的最大条码

                string strStyle = dt_DefList.Rows[i]["st2_st1_stylecode"].ToString();    //StyleCode
                string strColor = dt_DefList.Rows[i]["st2_color"].ToString();       //颜色
                string strSour = dt_DefList.Rows[i]["dd1_sources"].ToString();      //来源
                string strSKC = dt_DefList.Rows[i]["st2_skccode"].ToString();       //SKC
                string strDemRec = dt_DefList.Rows[i]["dd1_demotereason"].ToString();       //降级品原因 
                string strSizeGrp = dt_DefList.Rows[i]["st2_sizegroup"].ToString(); //尺码组

                //删除列，剩余尺码信息
                dt_DefList.Columns.Remove("st2_st1_stylecode");
                dt_DefList.Columns.Remove("st2_color");
                dt_DefList.Columns.Remove("dd1_sources");
                dt_DefList.Columns.Remove("st2_skccode");
                dt_DefList.Columns.Remove("dd1_demotereason");
                dt_DefList.Columns.Remove("st2_sizegroup");


//                string strGetSizeSQL = @"
//                    SELECT [CT1_KeyID]
//                    FROM [M01_CONF].[CT0_CSYTAB]
//                    WHERE CT1_Code = 'SIDE' AND 
//                    CT1_FatherID = (SELECT CT1_ID FROM [M01_CONF].[CT0_CSYTAB] WHERE CT1_KeyID = '" + strSizeGrp + "' )";
//                DataTable dtGetSize = conn.GetDataTable(strGetSizeSQL);

                int colNums = dt_DefList.Columns.Count;

                for (int icol = 0; icol < colNums; icol++) { 
                    string strSizeQ = dt_DefList.Rows[i][icol].ToString();
                    string colName = dt_DefList.Columns[icol].ColumnName;
                    if (strSizeQ != "")
                    {
                        strSize = colName.Substring(colName.Length - 1, 1); strNum = strSizeQ;

                        DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                        dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                        dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                        if (strSour == "供应商")
                        {
                            j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                            strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                        }
                        else
                        {
                            j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                            strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                        };
                    };

                };
                
                
                
                //尺码de数量
                //string strSizeQ1 = dt_DefList.Rows[i]["size1"].ToString();
                //string strSizeQ2 = dt_DefList.Rows[i]["size2"].ToString();
                //string strSizeQ3 = dt_DefList.Rows[i]["size3"].ToString();
                //string strSizeQ4 = dt_DefList.Rows[i]["size4"].ToString();
                //string strSizeQ5 = dt_DefList.Rows[i]["size5"].ToString();
                //string strSizeQ6 = dt_DefList.Rows[i]["size6"].ToString();
                //string strSizeQ7 = dt_DefList.Rows[i]["size7"].ToString();
                //string strSizeQ8 = dt_DefList.Rows[i]["size8"].ToString();
                //string strSizeQ9 = dt_DefList.Rows[i]["size9"].ToString();
                //string strSizeQF = dt_DefList.Rows[i]["sizeF"].ToString();

                //if (strSizeQ1 != "")
                //{
                //    strSize = "1"; strNum = strSizeQ1;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQ2 != "")
                //{
                //    strSize = "2"; strNum = strSizeQ2;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);


                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQ3 != "")
                //{
                //    strSize = "3"; strNum = strSizeQ3;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQ4 != "")
                //{
                //    strSize = "4"; strNum = strSizeQ4;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQ5 != "")
                //{
                //    strSize = "5"; strNum = strSizeQ5;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQ6 != "")
                //{
                //    strSize = "6"; strNum = strSizeQ6;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQ7 != "")
                //{
                //    strSize = "7"; strNum = strSizeQ7;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQ8 != "")
                //{
                //    strSize = "8"; strNum = strSizeQ8;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQ9 != "")
                //{
                //    strSize = "9"; strNum = strSizeQ9;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
                //if (strSizeQF != "")
                //{
                //    strSize = "F"; strNum = strSizeQF;

                //    DataRow drDe = dsNewDs.Tables["dtDe"].NewRow();
                //    dsNewDs.Tables["dtDe"].Rows.Add(drDe);

                //    dsNewDs = BulidDs(strStyle, strSKC, strColor, strSize, strNum, strSour, strDemRec, strDemoteBarG, strDemoteBarV, dsNewDs);

                //    if (strSour == "供应商")
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarG = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    }
                //    else
                //    {
                //        j = dsNewDs.Tables["dtDe"].Rows.Count - 1;
                //        strDemoteBarV = dsNewDs.Tables["dtDe"].Rows[j]["DD1_DemoteBarcode"].ToString();
                //    };
                //};
            };
            NewDefData(dsNewDs); //抛给新建保存方法
        }
        #endregion

        #region 降级品数据保存(新建)
        /// <summary>
        /// 保存申请的降级品数据
        /// </summary>
        /// <param name="pdtInsert">需要处理的datatable</param>
        private void NewDefData(DataSet pdtInsert)
        {

            bool bResult = false;
            if (pdtInsert.Tables.Count == 4)
            {
                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("[B03_TRANS].[DD1_Demotion]", pdtInsert.Tables["dtDe"]);
                bResult = conn.Insert("[B01_MDM].[ST1_Style]", pdtInsert.Tables["dtStyle"]);
                bResult = conn.Insert("[B01_MDM].[ST2_StyleColor]", pdtInsert.Tables["dtSC"]);
                bResult = conn.Insert("[B01_MDM].[ST3_StyleColorSize]", pdtInsert.Tables["dtSCZ"]);
            }
            else if (pdtInsert.Tables.Count == 2)
            {
                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("[B03_TRANS].[DD1_Demotion]", pdtInsert.Tables["dtDe"]);
                bResult = conn.Insert("[B01_MDM].[ST3_StyleColorSize]", pdtInsert.Tables["dtSCZ"]);
            }
            else if (pdtInsert.Tables.Count == 1)
            {
                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("[B03_TRANS].[DD1_Demotion]", pdtInsert.Tables["dtDe"]);
            }
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "申请成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "申请失败" });
            };
            conn.CommitTransaction();
            m_ReturnData.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 降级品SKU
        /// <summary>
        /// 用于生成降级品SKU
        /// </summary>
        /// <param name="pstrStyleCode">款号</param>
        /// <param name="pstrColor">颜色</param>
        /// <param name="pstrSize">尺码</param>
        /// <param name="pstrSources">来源</param>
        /// <returns>返回一个降级品SKU</returns>
        private Hashtable CreateSKU(string pstrStyleCode, string pstrColor, string pstrSize, string pstrSources)
        {
            Hashtable hashReturn = new Hashtable();
            string strDemoteSKU;
            string strDemoteStyle;
            string strDemoteSKC;

            if (pstrSources == "供应商")
            {
                strDemoteSKU = pstrStyleCode + "G" + pstrColor + pstrSize;
                strDemoteStyle = pstrStyleCode + "G";
                strDemoteSKC = pstrStyleCode + "G" + pstrColor;
            }
            else
            {
                strDemoteSKU = pstrStyleCode + "V" + pstrColor + pstrSize;
                strDemoteStyle = pstrStyleCode + "V";
                strDemoteSKC = pstrStyleCode + "V" + pstrColor;
            };

            hashReturn.Add("DemoteSKU", strDemoteSKU);
            hashReturn.Add("DemoteStyle", strDemoteStyle);
            hashReturn.Add("DemoteSKC", strDemoteSKC);

            return hashReturn;
        }
        #endregion

        #region 降级品条码
        /// <summary>
        /// 
        /// </summary>
        /// <param name="pstrStyleCode">款号</param>
        /// <param name="pstrSources">来源</param>
        /// <param name="pstrBar">最大条码</param>
        /// <returns></returns>
        private string CreateBarCode(string pstrStyleCode, string pstrSources, string pstrBar)
        {
            string strBarCode = "";
            int iLenth = pstrStyleCode.Length;  //款号长度
            if (pstrSources == "供应商" && pstrBar == "")
            {
                if (iLenth == 11)
                {
                    strBarCode = pstrStyleCode.Substring(0, 11) + "G01";
                }
                else
                {
                    strBarCode = pstrStyleCode.Substring(0, 9) + "G01";
                };
            }
            else if (pstrSources == "供应商" && pstrBar != "")
            {
                int iMaxNum = int.Parse(pstrBar.Substring(pstrBar.Length - 2));
                iMaxNum += 1;
                if (iMaxNum < 10)
                {
                    if (iLenth == 11)
                    {
                        strBarCode = pstrStyleCode.Substring(0, 11) + "G0" + iMaxNum.ToString();
                    }
                    else
                    {
                        strBarCode = pstrStyleCode.Substring(0, 9) + "G0" + iMaxNum.ToString();
                    };
                }
                else
                {
                    if (iLenth == 11)
                    {
                        strBarCode = pstrStyleCode.Substring(0, 11) + "G" + iMaxNum.ToString();
                    }
                    else
                    {
                        strBarCode = pstrStyleCode.Substring(0, 9) + "G" + iMaxNum.ToString();
                    };
                }
            }
            else if (pstrSources == "店铺" && pstrBar == "")
            {
                if (iLenth == 11)
                {
                    strBarCode = pstrStyleCode.Substring(0, 11) + "V01";
                }
                else
                {
                    strBarCode = pstrStyleCode.Substring(0, 9) + "V01";
                };

            }
            else if (pstrSources == "店铺" && pstrBar != "")
            {
                int iMaxNum = int.Parse(pstrBar.Substring(pstrBar.Length - 2));
                iMaxNum += 1;
                if (iMaxNum < 10)
                {
                    if (iLenth == 11)
                    {
                        strBarCode = pstrStyleCode.Substring(0, 11) + "V0" + iMaxNum.ToString();
                    }
                    else
                    {
                        strBarCode = pstrStyleCode.Substring(0, 9) + "V0" + iMaxNum.ToString();
                    };
                }
                else
                {
                    if (iLenth == 11)
                    {
                        strBarCode = pstrStyleCode.Substring(0, 11) + "V" + iMaxNum.ToString();
                    }
                    else
                    {
                        strBarCode = pstrStyleCode.Substring(0, 9) + "V" + iMaxNum.ToString();
                    };
                }
            };
            return strBarCode;
        }
        #endregion

        #region 降级品的DataTable + 款式表
        /// <summary>
        /// 用于创建降级品所需要的Ds
        /// </summary>
        /// <returns></returns>
        private DataSet CretaeTable()
        {

            DataSet dsReturn = new DataSet(); //返回用的表
            DataTable dtDe = new DataTable(); //新创建降级品Dt
            DataTable dtSCZ = new DataTable(); //StyleColorSize的Dt
            DataTable dtStyle = new DataTable(); //Style
            DataTable dtSC = new DataTable(); //StyleColor

            //添加字段
            dtDe.Columns.Add("DD1_ID");
            dtDe.Columns.Add("DD1_CONO");
            dtDe.Columns.Add("DD1_DIVI");
            dtDe.Columns.Add("DD1_ST1_StyleCode");
            dtDe.Columns.Add("DD1_ST2_SKCCode");
            dtDe.Columns.Add("DD1_ST2_Color");
            dtDe.Columns.Add("DD1_ST3_Size");
            dtDe.Columns.Add("DD1_Number");
            dtDe.Columns.Add("DD1_Sources");
            dtDe.Columns.Add("DD1_DemoteReason");
            dtDe.Columns.Add("DD1_DemoteSKU");
            dtDe.Columns.Add("DD1_DemoteBarcode");
            dtDe.Columns.Add("DD1_RgDt");
            dtDe.Columns.Add("DD1_RgUser");
            dtDe.Columns.Add("DD1_LmDt");
            dtDe.Columns.Add("DD1_LmUser");


            dtStyle.Columns.Add("ST1_ID");
            dtStyle.Columns.Add("ST1_CONO");
            dtStyle.Columns.Add("ST1_DIVI");
            dtStyle.Columns.Add("ST1_StyleCode");
            dtStyle.Columns.Add("ST1_SupplierCode");
            dtStyle.Columns.Add("ST1_BR1_BrandCode");
            dtStyle.Columns.Add("ST1_SupperierStyle");
            dtStyle.Columns.Add("ST1_Years");
            dtStyle.Columns.Add("ST1_Season");
            dtStyle.Columns.Add("ST1_ComModity");
            dtStyle.Columns.Add("ST1_Unit");
            dtStyle.Columns.Add("ST1_Category");
            dtStyle.Columns.Add("ST1_LargeClass");
            dtStyle.Columns.Add("ST1_SmallClass");
            dtStyle.Columns.Add("ST1_Grade");
            dtStyle.Columns.Add("ST1_Currency");
            dtStyle.Columns.Add("ST1_Provenance");
            dtStyle.Columns.Add("ST1_Ingredients");
            dtStyle.Columns.Add("ST1_Standard");
            dtStyle.Columns.Add("ST1_SafeTechnology");
            dtStyle.Columns.Add("ST1_IsPrint");
            dtStyle.Columns.Add("ST1_State");
            dtStyle.Columns.Add("ST1_Attr01");
            dtStyle.Columns.Add("ST1_Attr02");
            dtStyle.Columns.Add("ST1_Attr03");
            dtStyle.Columns.Add("ST1_Attr04");
            dtStyle.Columns.Add("ST1_Attr05");
            dtStyle.Columns.Add("ST1_RgDt");
            dtStyle.Columns.Add("ST1_RgUser");
            dtStyle.Columns.Add("ST1_LmDt");
            dtStyle.Columns.Add("ST1_LmUser");

            dtSC.Columns.Add("ST2_ID");
            dtSC.Columns.Add("ST2_CONO");
            dtSC.Columns.Add("ST2_DIVI");
            dtSC.Columns.Add("ST2_ST1_StyleCode");
            dtSC.Columns.Add("ST2_SKCCode");
            dtSC.Columns.Add("ST2_Color");
            dtSC.Columns.Add("ST2_ColorGroup");
            dtSC.Columns.Add("ST2_SizeGroup");
            dtSC.Columns.Add("ST2_SupperierColor");
            dtSC.Columns.Add("ST2_SupperierSKC");
            dtSC.Columns.Add("ST2_PurchasePrice");
            dtSC.Columns.Add("ST2_SalePrice");
            dtSC.Columns.Add("ST2_RefSalePrice");
            dtSC.Columns.Add("ST2_ImagePath");
            dtSC.Columns.Add("ST2_State");
            dtSC.Columns.Add("ST2_RgDt");
            dtSC.Columns.Add("ST2_RgUser");
            dtSC.Columns.Add("ST2_LmDt");
            dtSC.Columns.Add("ST2_LmUser");

            dtSCZ.Columns.Add("ST3_ID");
            dtSCZ.Columns.Add("ST3_CONO");
            dtSCZ.Columns.Add("ST3_DIVI");
            dtSCZ.Columns.Add("ST3_ST1_StyleCode");
            dtSCZ.Columns.Add("ST3_ST2_SKCCode");
            dtSCZ.Columns.Add("ST3_SKUCode");
            dtSCZ.Columns.Add("ST3_Size");
            dtSCZ.Columns.Add("ST3_SupperierSize");
            dtSCZ.Columns.Add("ST3_State");
            dtSCZ.Columns.Add("ST3_RgDt");
            dtSCZ.Columns.Add("ST3_RgUser");
            dtSCZ.Columns.Add("ST3_LmDt");
            dtSCZ.Columns.Add("ST3_LmUser");


            //给Dt取名字
            dtDe.TableName = "dtDe";
            dtSCZ.TableName = "dtSCZ";
            dtSC.TableName = "dtSC";
            dtStyle.TableName = "dtStyle";

            dsReturn.Tables.Add(dtDe);
            dsReturn.Tables.Add(dtSCZ);
            dsReturn.Tables.Add(dtStyle);
            dsReturn.Tables.Add(dtSC);

            return dsReturn;
        }
        #endregion

        #region 制造需要的数据
        /// <summary>
        /// 用于将各尺码的数据写入新的Ds中
        /// </summary>
        /// <param name="pstrStyCode">StyleCode</param>
        /// <param name="pstrSKCCode">SKC</param>
        /// <param name="pstrColor">颜色</param>
        /// <param name="pstrSize">尺码</param>
        /// <param name="pstrNum">数量</param>
        /// <param name="pstrDemBarG">项目代号G</param>
        /// <param name="pstrDemBarV">项目代码V</param>
        /// <param name="pstrSou">来源</param>
        /// <param name="pstrDemRea">降级原因</param>
        /// <param name="pdsBulidDs">新的Ds</param>
        /// <returns>将插入数据的Ds返回给SetDefective方法</returns>
        private DataSet BulidDs(string pstrStyCode
                            , string pstrSKCCode
                            , string pstrColor
                            , string pstrSize
                            , string pstrNum
                            , string pstrSou
                            , string pstrDemRea
                            , string pstrDemBarG
                            , string pstrDemBarV
                            , DataSet pdsBulidDs
            )
        {
            string strSQL0 = @"
                        SELECT [DD1_DemoteSKU]
                        FROM [B03_TRANS].[DD1_Demotion]
                        WHERE [DD1_ST1_StyleCode] = '" + pstrStyCode + "' AND [DD1_ST2_Color] = '" + pstrColor + @"' 
                        AND [DD1_ST3_Size] = '" + pstrSize + "' AND [DD1_Sources] = '" + pstrSou + "'";

            string strSQL1 = @"
                        SELECT [DD1_DemoteBarcode]
                        FROM [B03_TRANS].[DD1_Demotion]
                        WHERE [DD1_ST1_StyleCode] = '" + pstrStyCode + "' AND [DD1_ST2_Color] = '" + pstrColor + @"' 
                        AND [DD1_ST3_Size] = '" + pstrSize + "' AND [DD1_Sources] = '" + pstrSou + "'";

            string strSQL2 = @"
                        SELECT MAX([DD1_DemoteBarcode])
                        FROM [B03_TRANS].[DD1_Demotion]
                        WHERE [DD1_ST2_SKCCode] = '" + pstrSKCCode + "'AND [DD1_Sources] = '" + pstrSou + "'";

            //降级品SKU
            string strDemoteSKU = conn.GetDataTableFirstValue(strSQL0).ToString();
            //降级条码
            string strDemoteBar = conn.GetDataTableFirstValue(strSQL1).ToString();
            //最大降级条码
            string strMaxDemBar = conn.GetDataTableFirstValue(strSQL2).ToString();
            //接收SKU，SKC，Style
            Hashtable hashTb = new Hashtable();

            //降级品SKC，Style,流水码
            string strDemoteSKC;
            string strDemoteStyle;
            string strNum = "";


            if (pstrSou == "供应商")
            {
                if (strDemoteBar == "" && strMaxDemBar == "" && pstrDemBarG == "")
                {
                    strDemoteBar = CreateBarCode(pstrStyCode, pstrSou, pstrDemBarG);      //根据计算获取降级项目代号
                    strNum = strDemoteBar.Substring(strDemoteBar.Length - 2);       //流水码 
                }
                else if (strDemoteBar == "" && strMaxDemBar != "" && pstrDemBarG == "")
                {
                    pstrDemBarG = strMaxDemBar;
                    strDemoteBar = CreateBarCode(pstrStyCode, pstrSou, pstrDemBarG);
                    strNum = strDemoteBar.Substring(strDemoteBar.Length - 2);       //流水码 
                }
                else if (strDemoteBar == "" && strMaxDemBar == "" && pstrDemBarG != "")
                {
                    strDemoteBar = CreateBarCode(pstrStyCode, pstrSou, pstrDemBarG);
                    strNum = strDemoteBar.Substring(strDemoteBar.Length - 2);       //流水码 
                }
                else if (strDemoteBar == "" && strMaxDemBar != "" && pstrDemBarG != "")
                {
                    strDemoteBar = CreateBarCode(pstrStyCode, pstrSou, pstrDemBarG);
                    strNum = strDemoteBar.Substring(strDemoteBar.Length - 2);       //流水码 
                };
                hashTb = CreateSKU(pstrStyCode, pstrColor, pstrSize, pstrSou);  //根据计算获取降级SKU

                strDemoteSKU = hashTb["DemoteSKU"].ToString();
                strDemoteSKC = hashTb["DemoteSKC"].ToString();
                strDemoteStyle = hashTb["DemoteStyle"].ToString();
            }
            else
            {
                if (strDemoteBar == "" && strMaxDemBar == "" && pstrDemBarV == "")
                {
                    strDemoteBar = CreateBarCode(pstrStyCode, pstrSou, pstrDemBarV);      //根据计算获取降级项目代号
                }
                else if (strDemoteBar == "" && strMaxDemBar != "" && pstrDemBarV == "")
                {
                    pstrDemBarG = strMaxDemBar;
                    strDemoteBar = CreateBarCode(pstrStyCode, pstrSou, pstrDemBarV);
                }
                else if (strDemoteBar == "" && strMaxDemBar == "" && pstrDemBarV != "")
                {
                    strDemoteBar = CreateBarCode(pstrStyCode, pstrSou, pstrDemBarV);
                }
                else if (strDemoteBar == "" && strMaxDemBar != "" && pstrDemBarV != "")
                {
                    strDemoteBar = CreateBarCode(pstrStyCode, pstrSou, pstrDemBarV);
                };
                hashTb = CreateSKU(pstrStyCode, pstrColor, pstrSize, pstrSou);  //根据计算获取降级SKU

                strDemoteSKU = hashTb["DemoteSKU"].ToString();
                strDemoteSKC = hashTb["DemoteSKC"].ToString();
                strDemoteStyle = hashTb["DemoteStyle"].ToString();
            };
            //取当前的行数
            int iNum = pdsBulidDs.Tables["dtDe"].Rows.Count - 1;

            //GUID(降级品)
            string strGUID = System.Guid.NewGuid().ToString();
            //GUID(StyleColorSize)
            string strGUIDscu = System.Guid.NewGuid().ToString();
            //GUID(SKC)
            string strGUIDskc = System.Guid.NewGuid().ToString();
            //GUID(Style)
            string strGUIDstyle = System.Guid.NewGuid().ToString();
            //判断商品表是否有值
            Hashtable Geths = GetGoods(strDemoteStyle, strDemoteSKC, strDemoteSKU);

            //存储数据库中已有的商品数据
            DataSet dsReceive = new DataSet();

            if (Geths["style"].ToString() == "0" && Geths["SKC"].ToString() == "0" && Geths["SKU"].ToString() == "0")
            {

                DataRow drSCZ = pdsBulidDs.Tables["dtSCZ"].NewRow();
                pdsBulidDs.Tables["dtSCZ"].Rows.Add(drSCZ);

                //取供应商款号
                string strSupplierCode = "";

                //取StyleCode长度
                int iStyleLength = strDemoteStyle.Length;
                if (iStyleLength == 11)
                {
                    strSupplierCode = strDemoteStyle.Substring(0, iStyleLength - 2);
                }
                else
                {
                    strSupplierCode = strDemoteStyle.Substring(0, iStyleLength - 1);
                }

                //Style表行数
                int iStyleNum = pdsBulidDs.Tables["dtStyle"].Rows.Count;
                //SKC表行数
                int iSKC = pdsBulidDs.Tables["dtSC"].Rows.Count;

                //如果style表空
                if (iStyleNum == 0)
                {
                    dsReceive = dsData(pstrStyCode, pstrSKCCode); //取SKC，Style表的数据

                    DataRow drStyle = pdsBulidDs.Tables["dtStyle"].NewRow();

                    drStyle = dsReceive.Tables["dtStyle"].Rows[0];

                    pdsBulidDs.Tables["dtStyle"].ImportRow(drStyle);

                    //赋值
                    pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_ID"] = strGUIDstyle;
                    pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_StyleCode"] = strDemoteStyle;
                    pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_SupperierStyle"] = strSupplierCode; //供应商款号
                    pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_Grade"] = "降级品";
                    pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_RgDt"] = now;
                    pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_RgUser"] = this.hzyMessage.User_Name;
                    pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_LmDt"] = now;
                    pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_LmUser"] = this.hzyMessage.User_Name;
                };

                if (iStyleNum != 0)
                {
                    dsReceive = dsData(pstrStyCode, pstrSKCCode); //取SKC，Style表的数据

                    for (int i = 0; i < iStyleNum; i++)
                    {

                        string strStyle = pdsBulidDs.Tables["dtStyle"].Rows[i]["ST1_StyleCode"].ToString();

                        if (strStyle != strDemoteStyle && i != iStyleNum - 1)
                        {
                            continue;
                        }
                        else if (strStyle != strDemoteStyle && i == iStyleNum - 1)
                        {
                            DataRow drStyle = pdsBulidDs.Tables["dtStyle"].NewRow();
                            drStyle = dsReceive.Tables["dtStyle"].Rows[0];

                            pdsBulidDs.Tables["dtStyle"].ImportRow(drStyle);

                            //赋值
                            pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_ID"] = strGUIDstyle;
                            pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_StyleCode"] = strDemoteStyle;
                            pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_SupperierStyle"] = strSupplierCode; //供应商款号
                            pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_Grade"] = "降级品";
                            pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_RgDt"] = now;
                            pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_RgUser"] = this.hzyMessage.User_Name;
                            pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_LmDt"] = now;
                            pdsBulidDs.Tables["dtStyle"].Rows[pdsBulidDs.Tables["dtStyle"].Rows.Count - 1]["ST1_LmUser"] = this.hzyMessage.User_Name;
                        }
                        else
                        {
                            break;
                        };
                    };
                };

                if (iSKC == 0)
                {
                    dsReceive = dsData(pstrStyCode, pstrSKCCode); //取SKC，Style表的数据

                    DataRow drSC = pdsBulidDs.Tables["dtSC"].NewRow();
                    drSC = dsReceive.Tables["dtSC"].Rows[0];

                    pdsBulidDs.Tables["dtSC"].ImportRow(drSC);//追加数据

                    //赋值
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_ID"] = strGUIDskc;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_ST1_StyleCode"] = strDemoteStyle;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SKCCode"] = strDemoteSKC;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_RgDt"] = now;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_RgUser"] = this.hzyMessage.User_Name;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_LmDt"] = now;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_LmUser"] = this.hzyMessage.User_Name;

                    if (pstrSou == "供应商")
                    {
                        pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SupperierColor"] = "G";
                    }
                    else
                    {
                        pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SupperierColor"] = "V";
                    }
                };

                if (iSKC != 0)
                {
                    dsReceive = dsData(pstrStyCode, pstrSKCCode); //取SKC，Style表的数据

                    for (int i = 0; i < iSKC; i++)
                    {
                        string strSKC = pdsBulidDs.Tables["dtSC"].Rows[i]["ST2_SKCCode"].ToString();
                        if (strSKC != strDemoteSKC && i != iSKC - 1)
                        {
                            continue;
                        }
                        else if (strSKC != strDemoteSKC && i == iSKC - 1)
                        {
                            DataRow drSC = pdsBulidDs.Tables["dtSC"].NewRow();
                            drSC = dsReceive.Tables["dtSC"].Rows[0];

                            pdsBulidDs.Tables["dtSC"].ImportRow(drSC);//追加一行

                            //赋值
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_ID"] = strGUIDskc;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_ST1_StyleCode"] = strDemoteStyle;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SKCCode"] = strDemoteSKC;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_RgDt"] = now;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_RgUser"] = this.hzyMessage.User_Name;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_LmDt"] = now;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_LmUser"] = this.hzyMessage.User_Name;

                            if (pstrSou == "供应商")
                            {
                                pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SupperierColor"] = "G";
                            }
                            else
                            {
                                pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SupperierColor"] = "V";
                            }
                        }
                        else
                        {
                            break;
                        };
                    };
                };

                //赋值
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ID"] = strGUID;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_CONO"] = "GL";
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DIVI"] = "D01";
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST1_StyleCode"] = pstrStyCode;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST2_SKCCode"] = pstrSKCCode;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST2_Color"] = pstrColor;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST3_Size"] = pstrSize;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_Number"] = pstrNum;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_Sources"] = pstrSou;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteReason"] = pstrDemRea;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteSKU"] = strDemoteSKU;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteBarcode"] = strDemoteBar;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_RgDt"] = now;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_RgUser"] = this.hzyMessage.User_Name;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_LmDt"] = now;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_LmUser"] = this.hzyMessage.User_Name;

                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ID"] = strGUIDscu;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_CONO"] = "GL";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_DIVI"] = "D01";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ST1_StyleCode"] = strDemoteStyle;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ST2_SKCCode"] = strDemoteSKC;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_SKUCode"] = strDemoteSKU;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_Size"] = pstrSize;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_SupperierSize"] = strNum;       //流水码 
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_State"] = "20";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_RgDt"] = now;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_RgUser"] = this.hzyMessage.User_Name;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_LmDt"] = now;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_LmUser"] = this.hzyMessage.User_Name;
            }
            else if (Geths["style"].ToString() != "0" && Geths["SKC"].ToString() == "0" && Geths["SKU"].ToString() == "0")
            {
                DataRow drSCZ = pdsBulidDs.Tables["dtSCZ"].NewRow();
                pdsBulidDs.Tables["dtSCZ"].Rows.Add(drSCZ);

                int iSKC = pdsBulidDs.Tables["dtSC"].Rows.Count;
                if (iSKC == 0)
                {
                    dsReceive = dsData(pstrStyCode, pstrSKCCode); //取SKC，Style表的数据

                    DataRow drSC = pdsBulidDs.Tables["dtSC"].NewRow();
                    drSC = dsReceive.Tables["dtSC"].Rows[0];

                    pdsBulidDs.Tables["dtSC"].ImportRow(drSC);//追加数据

                    //赋值
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_ID"] = strGUIDskc;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_ST1_StyleCode"] = strDemoteStyle;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SKCCode"] = strDemoteSKC;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_RgDt"] = now;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_RgUser"] = this.hzyMessage.User_Name;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_LmDt"] = now;
                    pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_LmUser"] = this.hzyMessage.User_Name;

                    if (pstrSou == "供应商")
                    {
                        pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SupperierColor"] = "G";
                    }
                    else
                    {
                        pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SupperierColor"] = "V";
                    }
                };
                if (iSKC != 0)
                {
                    dsReceive = dsData(pstrStyCode, pstrSKCCode); //取SKC，Style表的数据

                    for (int i = 0; i < iSKC; i++)
                    {
                        string strSKC = pdsBulidDs.Tables["dtSC"].Rows[i]["ST2_SKCCode"].ToString();
                        if (strSKC != strDemoteSKC && i != iSKC - 1)
                        {
                            continue;
                        }
                        else if (strSKC != strDemoteSKC && i == iSKC - 1)
                        {
                            DataRow drSC = pdsBulidDs.Tables["dtSC"].NewRow();
                            drSC = dsReceive.Tables["dtSC"].Rows[0];

                            pdsBulidDs.Tables["dtSC"].ImportRow(drSC);//追加一行

                            //赋值
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_ID"] = strGUIDskc;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_ST1_StyleCode"] = strDemoteStyle;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SKCCode"] = strDemoteSKC;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_RgDt"] = now;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_RgUser"] = this.hzyMessage.User_Name;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_LmDt"] = now;
                            pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_LmUser"] = this.hzyMessage.User_Name;

                            if (pstrSou == "供应商")
                            {
                                pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SupperierColor"] = "G";
                            }
                            else
                            {
                                pdsBulidDs.Tables["dtSC"].Rows[pdsBulidDs.Tables["dtSC"].Rows.Count - 1]["ST2_SupperierColor"] = "V";
                            }
                        }
                        else
                        {
                            break;
                        };
                    };
                };
                //赋值
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ID"] = strGUID;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_CONO"] = "GL";
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DIVI"] = "D01";
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST1_StyleCode"] = pstrStyCode;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST2_SKCCode"] = pstrSKCCode;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST2_Color"] = pstrColor;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST3_Size"] = pstrSize;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_Number"] = pstrNum;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_Sources"] = pstrSou;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteReason"] = pstrDemRea;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteSKU"] = strDemoteSKU;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteBarcode"] = strDemoteBar;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_RgDt"] = now;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_RgUser"] = this.hzyMessage.User_Name;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_LmDt"] = now;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_LmUser"] = this.hzyMessage.User_Name;

                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ID"] = strGUIDscu;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_CONO"] = "GL";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_DIVI"] = "D01";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ST1_StyleCode"] = strDemoteStyle;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ST2_SKCCode"] = strDemoteSKC;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_SKUCode"] = strDemoteSKU;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_Size"] = pstrSize;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_SupperierSize"] = strNum;       //流水码 
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_State"] = "20";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_RgDt"] = now;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_RgUser"] = this.hzyMessage.User_Name;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_LmDt"] = now;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_LmUser"] = this.hzyMessage.User_Name;
            }
            else if (Geths["style"].ToString() != "0" && Geths["SKC"].ToString() != "0" && Geths["SKU"].ToString() == "0")
            {
                DataRow drSCZ = pdsBulidDs.Tables["dtSCZ"].NewRow();
                pdsBulidDs.Tables["dtSCZ"].Rows.Add(drSCZ);
                //赋值
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ID"] = strGUID;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_CONO"] = "GL";
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DIVI"] = "D01";
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST1_StyleCode"] = pstrStyCode;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST2_SKCCode"] = pstrSKCCode;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST2_Color"] = pstrColor;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST3_Size"] = pstrSize;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_Number"] = pstrNum;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_Sources"] = pstrSou;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteReason"] = pstrDemRea;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteSKU"] = strDemoteSKU;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteBarcode"] = strDemoteBar;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_RgDt"] = now;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_RgUser"] = this.hzyMessage.User_Name;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_LmDt"] = now;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_LmUser"] = this.hzyMessage.User_Name;

                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ID"] = strGUIDscu;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_CONO"] = "GL";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_DIVI"] = "D01";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ST1_StyleCode"] = strDemoteStyle;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_ST2_SKCCode"] = strDemoteSKC;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_SKUCode"] = strDemoteSKU;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_Size"] = pstrSize;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_SupperierSize"] = strNum;       //流水码 
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_State"] = "20";
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_RgDt"] = now;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_RgUser"] = this.hzyMessage.User_Name;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_LmDt"] = now;
                pdsBulidDs.Tables["dtSCZ"].Rows[pdsBulidDs.Tables["dtSCZ"].Rows.Count - 1]["ST3_LmUser"] = this.hzyMessage.User_Name;

            }
            else if (Geths["style"].ToString() != "0" && Geths["SKC"].ToString() != "0" && Geths["SKU"].ToString() != "0")
            {
                //赋值
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ID"] = strGUID;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_CONO"] = "GL";
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DIVI"] = "D01";
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST1_StyleCode"] = pstrStyCode;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST2_SKCCode"] = pstrSKCCode;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST2_Color"] = pstrColor;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_ST3_Size"] = pstrSize;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_Number"] = pstrNum;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_Sources"] = pstrSou;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteReason"] = pstrDemRea;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteSKU"] = strDemoteSKU;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_DemoteBarcode"] = strDemoteBar;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_RgDt"] = now;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_RgUser"] = this.hzyMessage.User_Name;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_LmDt"] = now;
                pdsBulidDs.Tables["dtDe"].Rows[iNum]["DD1_LmUser"] = this.hzyMessage.User_Name;

            }
            return pdsBulidDs;
        }
        #endregion

        #region 吊牌打印查询
        /// <summary>
        /// 用于吊牌打印查询
        /// </summary>
        private void GetPrintSearch()
        {
            string strSKU = dt_DefList.Rows[0]["PriStyCode"].ToString();
            string strSour = dt_DefList.Rows[0]["Radio"].ToString();
            string strSKC = "";
            int iLenth = strSKU.Length;
            if (iLenth == 11)
            {
                strSKC = strSKU.Substring(0, 10);        //SKC
            }
            else
            {
                strSKC = strSKU.Substring(0, 9);        //SKC
            }
            string strSize = strSKU.Substring(strSKU.Length - 1);   //尺码

            string strSQL = @"
                        SELECT [DD1_DemoteSKU]
                              ,[DD1_DemoteBarcode]
                        FROM [B03_TRANS].[DD1_Demotion]
                        WHERE [DD1_ST2_SKCCode] = '" + strSKC + "'AND [DD1_ST3_Size] = '" + strSize + "' AND [DD1_Sources] = '" + strSour + "'";
            m_ReturnData = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 取Style，StyleColor表的数据
        private DataSet dsData(string pstrStyle, string pstrSC)
        {

            DataSet dsReturn = new DataSet();
            DataTable dtStyle = new DataTable();
            DataTable dtSC = new DataTable();

            string strSqlStyle = @"
                                SELECT [ST1_ID]
                                    ,[ST1_CONO]
                                    ,[ST1_DIVI]
                                    ,[ST1_StyleCode]
                                    ,[ST1_SupplierCode]
                                    ,[ST1_BR1_BrandCode]
                                    ,[ST1_SupperierStyle]
                                    ,[ST1_Years]
                                    ,[ST1_Season]
                                    ,[ST1_ComModity]
                                    ,[ST1_Unit]
                                    ,[ST1_Category]
                                    ,[ST1_LargeClass]
                                    ,[ST1_SmallClass]
                                    ,[ST1_Grade]
                                    ,[ST1_Currency]
                                    ,[ST1_Provenance]
                                    ,[ST1_Ingredients]
                                    ,[ST1_Standard]
                                    ,[ST1_SafeTechnology]
                                    ,[ST1_IsPrint]
                                    ,[ST1_State]
                                    ,[ST1_Attr01]
                                    ,[ST1_Attr02]
                                    ,[ST1_Attr03]
                                    ,[ST1_Attr04]
                                    ,[ST1_Attr05]
                                    ,[ST1_RgDt]
                                    ,[ST1_RgUser]
                                    ,[ST1_LmDt]
                                    ,[ST1_LmUser]
                                    FROM [B01_MDM].[ST1_Style]
                                    WHERE [ST1_StyleCode] = '" + pstrStyle + "'";

            string strSqlSC = @"
                                    SELECT [ST2_ID]
                                          ,[ST2_CONO]
                                          ,[ST2_DIVI]
                                          ,[ST2_ST1_StyleCode]
                                          ,[ST2_SKCCode]
                                          ,[ST2_Color]
                                          ,[ST2_ColorGroup]
                                          ,[ST2_SizeGroup]
                                          ,[ST2_SupperierColor]
                                          ,[ST2_SupperierSKC]
                                          ,[ST2_PurchasePrice]
                                          ,[ST2_SalePrice]
                                          ,[ST2_RefSalePrice]
                                          ,[ST2_ImagePath]
                                          ,[ST2_State]
                                          ,[ST2_RgDt]
                                          ,[ST2_RgUser]
                                          ,[ST2_LmDt]
                                          ,[ST2_LmUser]
                                      FROM [B01_MDM].[ST2_StyleColor]
                                      WHERE [ST2_SKCCode] = '" + pstrSC + "'";

            DataTable dtTable1 = conn.GetDataTable(strSqlStyle);
            DataTable dtTable2 = conn.GetDataTable(strSqlSC);

            dtStyle = dtTable1.Copy();
            dtSC = dtTable2.Copy();

            dtStyle.TableName = "dtStyle";
            dtSC.TableName = "dtSC";

            dsReturn.Tables.Add(dtStyle);
            dsReturn.Tables.Add(dtSC);

            return dsReturn;
        }
        #endregion

        #region 判断商品表是否存在数据
        private Hashtable GetGoods(string pstrStyle, string pstrSKC, string pstrSKU)
        {
            Hashtable hashRetrun = new Hashtable();
            string strSqlStyle = "";
            string strSqlSKC = "";
            string strSqlSKU = "";

            strSqlStyle = @"
                        SELECT [ST1_ID]
                        FROM [B01_MDM].[ST1_Style]
                        WHERE [ST1_StyleCode] = '" + pstrStyle + "'";
            strSqlSKC = @"
                        SELECT [ST2_ID]
                        FROM [B01_MDM].[ST2_StyleColor]
                        WHERE [ST2_SKCCode] = '" + pstrSKC + "'";
            strSqlSKU = @"
                        SELECT [ST3_ID]
                        FROM [B01_MDM].[ST3_StyleColorSize]
                        WHERE [ST3_SKUCode] = '" + pstrSKU + "'";

            int iStyle = conn.GetDataTableRowCount(strSqlStyle);
            int iSKC = conn.GetDataTableRowCount(strSqlSKC);
            int iSKU = conn.GetDataTableRowCount(strSqlSKU);

            hashRetrun.Add("style", iStyle);
            hashRetrun.Add("SKC", iSKC);
            hashRetrun.Add("SKU", iSKU);

            return hashRetrun;
        }
        #endregion

        #endregion
    };
}
