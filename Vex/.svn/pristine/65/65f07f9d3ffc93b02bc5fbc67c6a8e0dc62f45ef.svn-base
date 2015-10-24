using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Collections;

//using System.IO;
//using NPOI.HSSF.UserModel;
//using NPOI.SS.UserModel;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：PE_OA_FA_POApply
/// 类说明：固定资产申购单
/// 创建人：DLY
/// 创建日期：2014-05-08
/// 修改人：
/// 修改日期：

namespace HZY.COM.WS.PE_OA
{
    public class PE_OA_FA_POApply : LogicBase, ILogicGetData
    {

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        #region 构造函数
        public PE_OA_FA_POApply()
        {
            this.m_SessionCheck = true;
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        #endregion

        #region GetData
        public DataSet GetData()
        {
            try
            {
                string strType = m_request.Tables[0].Rows[0]["type"].ToString();
                Dbconn conn = new Dbconn("PE_OA");
                DataSet ds = new DataSet();
                if (strType == "New" || strType == "Upd")
                {
                    ds = SetPOApply(conn, strType);
                }
                else if (strType == "GetH" || strType == "GetD" || strType == "GetD1")
                {
                    ds = GetPOApply(conn, strType);
                }
                //获取当前所有的申购单信息
                else if (strType == "GetPO")
                {
                    ds = GetPOApplyDetails(conn, strType);
                }
                //固定资产报销勾对
                else if (strType == "SetPO")
                {
                    ds = SetPOApplySubmit(conn, strType);
                }
                //固定资产报销导出Excel
                else if (strType == "ToExcel")
                {
                    //ds = SaveToFile(conn, strType);
                }
                else if (strType == "GetHs")
                {
                    ds = GetPOApplyList(conn, strType);
                }
                else if (strType == "FlowOut")
                {
                    ds = ActFlowOut(conn, strType);
                }
                else if (strType == "LinkCCAS")
                {
                    ds = LinkCCAS(conn, strType);
                }
                return ds;

            }
            catch
            {
                throw;
            }
        }
        #endregion

        #region 新建或修改申购单
        /// <summary>
        /// 新建或修改申购单
        /// </summary>
        /// <returns></returns>
        public DataSet SetPOApply(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            string strXML1 = m_request.Tables[0].Rows[0]["XML1"].ToString();
            //获取申购单主表数据
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strOPType = dsXML.Tables["OPTYPE"].Rows[0][0].ToString().ToUpper();
            String strID = dsXML.Tables["LIST"].Rows[0]["ID"].ToString();
            String strTaskID = dsXML.Tables["LIST"].Rows[0]["TaskID"].ToString();
            String strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            String strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
            /*
            String strPOApplyCode = dsXML.Tables["LIST"].Rows[0]["POApplyCode"].ToString();
            String strGenusCompanyCode = dsXML.Tables["LIST"].Rows[0]["GenusCompanyCode"].ToString();
            String strGenusCompanyName = dsXML.Tables["LIST"].Rows[0]["GenusCompanyName"].ToString();
            String strProjectCode = dsXML.Tables["LIST"].Rows[0]["ProjectCode"].ToString();
            String strAdvancedCode = dsXML.Tables["LIST"].Rows[0]["AdvancedCode"].ToString();
            String strState = dsXML.Tables["LIST"].Rows[0]["State"].ToString();
            String strApplyUser = dsXML.Tables["LIST"].Rows[0]["ApplyUser"].ToString();
            String strApplyDt = dsXML.Tables["LIST"].Rows[0]["ApplyDt"].ToString();
            String strDeptID = dsXML.Tables["LIST"].Rows[0]["DeptID"].ToString();
            String strDeptName = dsXML.Tables["LIST"].Rows[0]["DeptName"].ToString();
            String strAssetsType = dsXML.Tables["LIST"].Rows[0]["AssetsType"].ToString();
            String strEmployeeId = dsXML.Tables["LIST"].Rows[0]["EmployeeId"].ToString();
            String strCenterCode = dsXML.Tables["LIST"].Rows[0]["CenterCode"].ToString();
            String strCenterName = dsXML.Tables["LIST"].Rows[0]["CenterName"].ToString();
            String strBudgetType = dsXML.Tables["LIST"].Rows[0]["BudgetType"].ToString();
            String strApplyAmount = dsXML.Tables["LIST"].Rows[0]["ApplyAmount"].ToString();
            String strConfirmAmount = dsXML.Tables["LIST"].Rows[0]["ConfirmAmount"].ToString();
            String strComment = dsXML.Tables["LIST"].Rows[0]["Comment"].ToString();
            */

            String strXMLC = "【操作类型,SAVE】【实体,单据保存】"
                           + "【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【TableXML," + strXML + "】"
                           + "【TableXMLsub," + strXML1 + "】"
                           + "【Type," + strType + "】【Actor," + strActor + "】【ID," + strID + "】"
                           + "【TaskID," + strTaskID + "】"
                           + "【返回内容, id,单据号,流程id】";

            ds = conn.GetDataSetBySP("API_FA.POApply", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
        }
        #endregion

        #region  根据POApplyCode获取单据信息
        /// <summary>
        /// 根据POApplyCode获取单据信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetPOApply(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();
            string strPOApplyCode = dsXML.Tables["LIST"].Rows[0]["POApplyCode"].ToString();

            if (strPOApplyCode == "")
            {
                return ds;
            }

            if (strType == "GetH")
            {
                strSQL = @" SELECT * FROM B02_BILL.FA1_POApplyHead  WHERE FA1_POApplyCode = '"
                       + strPOApplyCode + "'";
                ds = conn.GetDataSet(strSQL);
            }
            else if (strType == "GetD")
            {
                strSQL = @"SELECT FA2_ID AS id, FA2_CONO AS CONO, FA2_DIVI AS DIVI, FA2_POApplyCode AS POApplyCode, 
                         FA2_Seq AS Seq, FA2_LargeClassCode AS LargeClassCode, FA2_LargeClassName AS LargeClassName, 
                         FA2_SmallClassCode AS SmallClassCode, FA2_SmallClassName AS SmallClassName, 
                         FA2_AssetsName AS AssetsName, FA2_BrandCode AS BrandCode, FA2_Model AS Model, 
                         FA2_ApplyPrice AS ApplyPrice, FA2_SurePrice AS SurePrice, 
                         FA2_UserName AS UserName, FA2_UserCode AS UserCode, FA2_Number AS Number, 
                         FA2_IsAdjust AS IsAdjust, FA2_PlanPrice  AS PlanPrice, 
                         FA2_IsPurchase AS IsPurchase, FA2_PlanUse AS PlanUse, FA2_CCASFid AS CCASFid, 
                         FA2_HasCCAS AS HasCCAS, FA2_Comment AS Comment, 
                         FA2_FilePath AS FilePath, FA2_RgDt AS RgDt, FA2_RgUser AS RgUser, 
                         FA2_LmDt AS LmDt, FA2_LmUser AS LmUser, FA2_UptNo AS UptNo
                         FROM B02_BILL.FA1_POApplyDetail  WHERE FA2_POApplyCode = '"
                       + strPOApplyCode + "'";
                ds = conn.GetDataSet(strSQL);
            }
            else if (strType == "GetD1")
            {
                strSQL = @"SELECT * FROM B02_BILL.FA1_POApplyDetail  WHERE FA2_POApplyCode = '"
                       + strPOApplyCode + "'";
                ds = conn.GetDataSet(strSQL);
            }
            return ds;
        }
        #endregion

        #region  获取符合条件的申购单信息
        /// <summary>
        /// 获取符合条件的申购单信息
        /// </summary>
        /// <param name="conn"></param>
        /// <param name="strType"></param>
        /// <returns></returns>
        public DataSet GetPOApplyDetails(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
            string[] strParam = new string[] { };

            strSQL = @" SELECT *
                          FROM B02_BILL.V_FA1_POApplyDetail WHERE 1=1 " + strCons;
            ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);

            return ds;
        }
        #endregion

        #region  固定资产报销勾对
        /// <summary>
        /// 固定资产报销勾对
        /// </summary>
        /// <param name="conn"></param>
        /// <param name="strType"></param>
        /// <returns></returns>
        public DataSet SetPOApplySubmit(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet(); ;

            //获取条件值 
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);

            String strActor = dsXML.Tables["LIST"].Rows[0]["Actor"].ToString();
            string strSubmitID = dsXML.Tables["LIST"].Rows[0]["SubmitID"].ToString();

            String strXMLC = "【操作类型,SAVE】【实体,报销财务勾对】【CONO,】【DIVI,】"
                           + "【《W》操作人, " + strActor + "】"
                           + "【《W》勾对记录, " + strSubmitID + "】"
                           + "【条件内容,】"
                           + "【返回内容,主表列表】";

            ds = conn.GetDataSetBySP("[API_FA].[POApply]", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;

        }
        #endregion

        //        #region 固定资产报销导出Excel
        //        /// <summary>
        //        /// 导出excel文件
        //        /// </summary>
        //        public  HSSFWorkbook RenderToExcel(DataTable table, HSSFWorkbook workbook, ISheet sheet)
        //        {
        //            // MemoryStream ms = new MemoryStream();

        //            IRow headerRow = sheet.CreateRow(0);

        //             //标题
        //            foreach (DataColumn column in table.Columns)
        //                headerRow.CreateCell(column.Ordinal).SetCellValue(column.Caption);  //获取标题名字，若为定义，则为字段名


        //            //数据
        //            int rowIndex = 1;

        //            //设置单元格格式
        //            ICellStyle style = workbook.CreateCellStyle();
        //            IDataFormat format = workbook.CreateDataFormat();   
        //            foreach (DataRow row in table.Rows)
        //            {
        //                IRow RowData = sheet.CreateRow(rowIndex);

        //                int i = 0;
        //                foreach (DataColumn column in table.Columns)
        //                {
        //                    try
        //                    {
        //                        //RowData.CreateCell(column.Ordinal).SetCellValue(row[column].ToString());
        //                        ICell newCell = RowData.CreateCell(i);

        //                        string drValue = row[column].ToString();

        //                        switch (column.DataType.ToString())     //定义单元格数据类型
        //                        {
        //                            case "System.Guid":
        //                            case "System.String"://字符串类型     
        //                                newCell.SetCellValue(drValue);
        //                                break;
        //                            case "System.DateTime"://日期类型
        //                                DateTime dateV;
        //                                DateTime.TryParse(drValue, out dateV);
        //                                newCell.SetCellValue(dateV);
        //                                style.DataFormat = format.GetFormat("yyyy/mm/dd hh:mm:ss");
        //                                newCell.CellStyle = style;
        //                                break;
        //                            case "System.Boolean"://布尔型     
        //                                bool boolV = false;
        //                                bool.TryParse(drValue, out boolV);
        //                                newCell.SetCellValue(boolV);
        //                                break;
        //                            case "System.Int16"://整型     
        //                            case "System.Int32":
        //                            case "System.Int64":
        //                            case "System.Byte":
        //                                if (drValue != "")
        //                                {
        //                                    int intV = 0;
        //                                    int.TryParse(drValue, out intV);
        //                                    newCell.SetCellValue(intV);
        //                                }
        //                                else
        //                                {
        //                                    newCell.SetCellValue(drValue);
        //                                }
        //                                break;
        //                            case "System.Decimal"://浮点型     
        //                            case "System.Double":
        //                                if (drValue != "")
        //                                {
        //                                    double doubV = 0;
        //                                    Double.TryParse(drValue, out doubV);
        //                                    newCell.SetCellValue(doubV);
        //                                }
        //                                else
        //                                {
        //                                    newCell.SetCellValue(drValue);
        //                                }
        //                                break;
        //                            case "System.DBNull"://空值处理     
        //                                newCell.SetCellValue("");
        //                                break;
        //                            default:
        //                                newCell.SetCellValue(drValue);
        //                                break;
        //                        }
        //                        i++;        //累积单元格数
        //                    }
        //                    catch
        //                    {
        //                        throw;
        //                    }
        //                }

        //                rowIndex++;     //计算行数
        //            }

        //            //SUM
        //            //IRow Row = sheet.CreateRow(rowIndex);
        //            //ICell cel1 = Row.CreateCell(0);
        //            //ICell cel2 = Row.CreateCell(1);
        //            //ICell cel3 = Row.CreateCell(2);
        //            //ICell cel4 = Row.CreateCell(3);
        //            //cel3.SetCellValue("总收入：");
        //            //string str = "D" + (table.Rows.Count + 1).ToString();
        //            //cel4.CellFormula = "sum(D2," + str.ToString() + ")";

        //            //workbook.Write(ms);
        //            //ms.Flush();
        //            //ms.Position = 0;


        //            //return ms;
        //            return workbook;

        //        }

        //        /// <summary>
        //        /// 保存excel文件
        //        /// </summary>
        //        public  DataSet SaveToFile(Dbconn conn, String strType)
        //        {
        //            DataSet ds_Return = new DataSet();
        //            //获取条件值
        //            DataSet ds = new DataSet();
        //            String strSQL = "";

        //            //获取条件值
        //            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
        //            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
        //            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
        //            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
        //            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
        //            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();
        //            string[] strParam = new string[] { };

        //            strSQL = @" SELECT FA2_LargeClassName,FA2_SmallClassName,FA2_AssetsName,
        //                        FA2_BrandCode,FA2_Model,FA2_Number,FA2_ApplyPrice,FA2_SurePrice,FA2_UserName,
        //                        FA2_POApplyCode,FA1_ApplyUser,FA1_DeptName,FA1_CenterCode,FA2_EState,FA2_GDDt,FA2_GDUser
        //                          FROM B02_BILL.V_FA1_POApplyDetail WHERE 1=1 " + strCons;
        //            ds = conn.GetDataSetForPageList(strSQL, strParam, int.Parse(strPage), int.Parse(strNum), strOrderBy);

        //            //如果包含rowindex，就循环移除
        //            if (ds.Tables[0].Columns.Contains("ROWINDEX"))
        //            {
        //                ds.Tables[0].Columns.Remove("ROWINDEX");
        //            }

        //            ds.Tables[0].Columns["FA2_LargeClassName"].Caption = "大类名称";
        //            ds.Tables[0].Columns["FA2_SmallClassName"].Caption = "小类名称";
        //            ds.Tables[0].Columns["FA2_AssetsName"].Caption = "资产名称";
        //            ds.Tables[0].Columns["FA2_BrandCode"].Caption = "品牌";
        //            ds.Tables[0].Columns["FA2_Model"].Caption = "规格/型号";
        //            ds.Tables[0].Columns["FA2_Number"].Caption = "数量";
        //            ds.Tables[0].Columns["FA2_ApplyPrice"].Caption = "申请价格";
        //            ds.Tables[0].Columns["FA2_SurePrice"].Caption = "确认价格";
        //            ds.Tables[0].Columns["FA2_UserName"].Caption = "使用人";
        //            ds.Tables[0].Columns["FA2_POApplyCode"].Caption = "申购单号";
        //            ds.Tables[0].Columns["FA1_ApplyUser"].Caption = "申请人";
        //            ds.Tables[0].Columns["FA1_DeptName"].Caption = "部门名称";
        //            ds.Tables[0].Columns["FA1_CenterCode"].Caption = "成本中心";
        //            ds.Tables[0].Columns["FA2_EState"].Caption = "状态";
        //            ds.Tables[0].Columns["FA2_GDDt"].Caption = "勾对日期";
        //            ds.Tables[0].Columns["FA2_GDUser"].Caption = "勾对人";

        //            string strFileName = dsXML.Tables["LIST"].Rows[0]["FileName"].ToString();
        //            strFileName = string.Concat(strFileName, ".xls");

        //            HSSFWorkbook hssfworkbook = new HSSFWorkbook();
        //            ISheet sheet1 = hssfworkbook.CreateSheet("Sheet1");
        //            //hssfworkbook.CreateSheet("Sheet1");
        //            hssfworkbook.CreateSheet("Sheet2");
        //            hssfworkbook.CreateSheet("Sheet3");
        //            //FileStream file = new FileStream(@"E:/test.xls", FileMode.Create);
        //            //hssfworkbook.Write(file);
        //            //file.Close();
        //            //MemoryStream ms=RenderToExcel(table,hssfworkbook,sheet1);
        //            hssfworkbook = RenderToExcel(ds.Tables[0], hssfworkbook, sheet1);
        //            using (FileStream fs = new FileStream(strFileName, FileMode.Create, FileAccess.Write))
        //            {
        //                //byte[] data = ms.ToArray();

        //                //fs.Write(data, 0, data.Length);
        //                hssfworkbook.Write(fs);     //HSSFWorkbook实例写入文件
        //                //fs.Flush();

        //                //data = null;
        //                fs.Close();
        //            }
        //            ds_Return.Tables.Add("Result");
        //            ds_Return.Tables["Result"].Columns.Add("Filename",typeof(System.String));
        //            DataRow row = ds_Return.Tables["Result"].NewRow();
        //            row["Filename"] = strFileName;
        //            ds_Return.Tables[0].Rows.Add(row);
        //            return ds_Return;
        //        }
        //        #endregion

        #region  根据条件获取申购单主表数据集 条件-分页-排序等
        /// <summary>
        /// 根据条件获取申购单主表数据集 条件-分页-排序等
        /// </summary>
        /// <returns></returns>
        public DataSet GetPOApplyList(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strPage = dsXML.Tables["LIST"].Rows[0]["Page"].ToString();
            string strNum = dsXML.Tables["LIST"].Rows[0]["Num"].ToString();
            string strCons = dsXML.Tables["LIST"].Rows[0]["Cons"].ToString();
            string strOrderBy = dsXML.Tables["LIST"].Rows[0]["OrderBy"].ToString();

            String strXMLC = "【操作类型,GET】【实体,单据查询】【CONO,】【DIVI,】"
                           + "【《W》页码," + strPage + "】【《W》记录数," + strNum + "】"
                           + "【《W》查询条件," + strCons + "】"
                           + "【排序方式," + strOrderBy + "】"
                           + "【Type," + strType + "】"
                           + "【返回内容, 主表列表】";

            ds = conn.GetDataSetBySP("API_FA.POApply", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
        }
        #endregion

        #region  流程流转
        /// <summary>
        /// 流程流转
        /// </summary>
        /// <returns></returns>
        public DataSet ActFlowOut(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值 
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            String strID = dsXML.Tables["LIST"].Rows[0]["ID"].ToString();
            String strTaskID = dsXML.Tables["LIST"].Rows[0]["TaskID"].ToString();
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();

            String strXMLC = "【操作类型,FlowOut】【实体,单据流转】【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【Actor," + strActor + "】【ID," + strID + "】"
                           + "【TableXML," + strXML + "】"
                           + "【返回内容, 主表列表】";

            ds = conn.GetDataSetBySP("API_FA.POApply", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;

        }
        #endregion


        #region 明细关联或替换鉴定单
        /// <summary>
        /// 明细关联或替换鉴定单
        /// </summary>
        /// <returns></returns>
        public DataSet LinkCCAS(Dbconn conn, String strType)
        {
            DataSet ds = new DataSet();
            String strSQL = "";

            //获取条件值 
            string strActor = m_request.Tables[0].Rows[0]["actor"].ToString();
            string strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
            DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
            string strCONO = dsXML.Tables["LIST"].Rows[0]["CONO"].ToString();
            string strDIVI = dsXML.Tables["LIST"].Rows[0]["DIVI"].ToString();

            String strXMLC = "【操作类型,LinkCCAS】【实体,关联鉴定单】【CONO," + strCONO + "】【DIVI," + strDIVI + "】"
                           + "【Actor," + strActor + "】"
                           + "【TableXML," + strXML + "】"
                           + "【返回内容, 执行结果】";

            ds = conn.GetDataSetBySP("API_FA.POApply", new string[4] { "@InputFormat", "@OutputFormat"
                    , "@OutputContentType", "@ConditionStr" }
                   , new string[4] { "AML", "DB", "RS", strXMLC });
            return ds;
        }
        #endregion

    }
}