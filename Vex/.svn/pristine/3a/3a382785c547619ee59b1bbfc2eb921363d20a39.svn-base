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

/// 类名：Goods
/// 类说明：对Goods(商品的增删改查)的CRUD,为Easyui专用
/// 创建人：郭琦琦
/// 创建日期：2014-06-03 
/// 修改人：刘洪
/// 修改日期：2014-10-09
/// 修改内容：增加产品线字段
/// 
/// 修改人:刘洪
/// 修改日期:2014-11-15
/// 修改内容:修改自动生成SKU的逻辑

namespace HZY.COM.WS.GL_ERP2
{
    public class Goods : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Goods()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn conn = new Dbconn("GL_ERP");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataTable resultTable = new DataTable();

        #endregion

        #region GetData
        /// <summary>
        /// VEX框架的主入口
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                string strXML = "";//初始化XML
                string filter = "";//初始化模糊查询条件
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GoodsInfo".ToUpper())//商品信息查询无分页带模糊查询
                {
                    filter = m_request.Tables[0].Rows[0]["q"].ToString(); // 实时条件，用于下拉框查询数据
                    GetGoodsInfo(filter);
                }
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GoodsInfoForPageList".ToUpper())//商品信息查询有分页
                {
                    GoodsInfoForPageList();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDITGoods".ToUpper())//商品新增修改操作
                {
                    EDITGoods();
                }
                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region 商品信息查询(无分页)带模糊
        /// <summary>
        /// 商品信息查询(无分页)带模糊
        /// </summary>
        private void GetGoodsInfo(string pstrQ)
        {
            string strSQL = @"
                                SELECT  t1.ST2_ImagePath ,--图片路径取SKC表
                                        t1.ST2_ID ,--SKC表GUID
                                        t3.ST1_SupplierCode ,--SKU表供应商编号
                                        ( SELECT    SP1_Name
                                          FROM      [B01_MDM].[SP1_Supplier]
                                          WHERE     t3.ST1_SupplierCode = SP1_SupplierCode
                                        ) SP1_Name ,--SUK表供应商名称
                                        ( SELECT    BR1_Name
                                          FROM      [B01_MDM].[BR1_Brand]
                                          WHERE     t3.ST1_BR1_BrandCode = BR1_BrandCode
                                        ) BR1_BrandName ,--品牌名称SKU表
		                                t3.ST1_SupperierStyle,--SKU供应商款号
		                                t1.ST2_SupperierColor,--SKC表供应商颜色
		                                t1.ST2_SupperierSKC,--SKC表供应商KSC
		                                t2.ST3_ST1_StyleCode ,--款号表 款号
		                                t1.ST2_Color,--KSC表颜色
		                                (SELECT CT1_KeyName FROM [M01_CONF].[CT0_CSYTAB]
		                                WHERE t1.ST2_Color = CT1_KeyID  AND CT1_Code= 'COLO') CT1_KeyName ,
		                                t1.ST2_SKCCode, --skc颜色名称
		                                t3.ST1_Unit , --款号表单位
		                                t1.ST2_PurchasePrice,--SKC表采购价格
		                                t1.ST2_SalePrice,--SKC表采购吊牌价
		                                t3.ST1_Years,--款号表年份
	                                    t3.ST1_Season,--款号表季节
		                                t3.ST1_Category,--款号表品类
		                                t3.ST1_LargeClass,--款号表大类
                                        t3.ST1_SmallClass,--款号表小类
		                                t3.ST1_Provenance, --款号表产地
                                        t1.ST2_Ingredients,  --款号成分
		                                t3.ST1_Grade ,--款号等级
		                                t3.ST1_Standard,--款号执行标准
		                                t3.ST1_SafeTechnology,--款号安全技术类别
		                                t3.ST1_IsPrint,--款号是否打印
                                        t3.ST1_State,--款号状态
		                                t3.ST1_LmDt,--款号更新时间
		                                t3.ST1_LmUser,--款号更新人
                                        t1.ST2_LmDt,
                                        t1.ST2_LmUser
                                FROM    [B01_MDM].[ST2_StyleColor] t1
                                        LEFT JOIN [B01_MDM].ST3_StyleColorSize t2 ON t1.ST2_SKCCode = t2.ST3_ST2_SKCCode
                                        LEFT JOIN [B01_MDM].[ST1_Style] t3 ON t1.ST2_ST1_StyleCode  = t3.ST1_StyleCode AND 
                                  SP1_Name LIKE '%" + pstrQ + "%' OR SP1_Name LIKE '%" + pstrQ + "%'  Order by ST1_LmDt " + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSet(strSQL, new string[0]);
        }

        #endregion

        #region 商品信息查询(有分页)
        /// <summary>
        /// 商品信息查询(有分页)
        /// </summary>
        private void GoodsInfoForPageList()
        {
            //m_hzyPageInfo.Sort = " ST2_LmDt ";
            //m_hzyPageInfo.Order = " DESC ";
            string strSQL = @"
                              SELECT  *
                                            FROM    ( SELECT    t1.ST2_ImagePath ,--图片路径取SKC表
                                                                t1.ST2_ID ,--SKC表GUID
                                                                t3.ST1_SupplierCode ,--SKU表供应商编号
                                                                ( SELECT    SP1_Name
                                                                  FROM      [B01_MDM].[SP1_Supplier]
                                                                  WHERE     t3.ST1_SupplierCode = SP1_SupplierCode
                                                                ) SP1_Name ,--SUK表供应商名称
                                                                ( SELECT    BR1_Name
                                                                  FROM      [B01_MDM].[BR1_Brand]
                                                                  WHERE     t3.ST1_BR1_BrandCode = BR1_BrandCode
                                                                ) BR1_BrandName ,--品牌名称SKU表
                                                                t3.ST1_BR1_BrandCode ,
                                                                t3.ST1_ComModity , --款号品名
                                                                t3.ST1_SupperierStyle ,--SKU供应商款号
                                                                t1.ST2_SupperierColor ,--SKC表供应商颜色
                                                                t1.ST2_SupperierSKC ,--SKC表供应商KSC
                                                                t1.ST2_ST1_StyleCode ,--SKC 款号
                                                                t1.ST2_Color ,--KSC表颜色
                                                                ( SELECT    CT1_KeyName
                                                                  FROM      [M01_CONF].[CT0_CSYTAB]
                                                                  WHERE     t1.ST2_Color = CT1_KeyID
                                                                            AND CT1_Code = 'COLO'
                                                                ) CT1_KeyName ,
                                                                t1.ST2_SKCCode , --skc颜色名称
                                                                t3.ST1_Unit , --款号表单位
                                                                ( SELECT    CT1_KeyName
                                                                  FROM      [M01_CONF].[CT0_CSYTAB]
                                                                  WHERE     t3.ST1_Unit = CT1_KeyID
                                                                    AND CT1_Code = 'UNIT'
                                                                ) ST1_UnitName ,--单位名称
                                                                t3.ST1_Currency , -- 款号币种
                                                                t3.ST1_ID ,--款号GUID
                                                                t1.ST2_SizeGroup , -- KSC尺码组
                                                                t1.ST2_PurchasePrice ,--SKC表采购价格
                                                                t1.ST2_SalePrice ,--SKC表采购吊牌价
                                                                t3.ST1_Years ,--款号表年份
                                                                t3.ST1_Season ,--款号表季节
                                                                t3.ST1_Category ,--款号表品类
                                                                t3.ST1_LargeClass ,--款号表大类
                                                                t3.ST1_SmallClass ,--款号表小类
                                                                t3.ST1_Provenance , --款号表产地
                                                                t1.ST2_Ingredients ,  --款号成分
                                                                t3.ST1_Grade ,--款号等级
                                                                t3.ST1_Standard ,--款号执行标准
                                                                t3.ST1_SafeTechnology ,--款号安全技术类别
                                                                t3.ST1_IsPrint ,--款号是否打印
                                                                t3.ST1_State ,--款号状态
                                                                t3.ST1_LmDt ,--款号更新时间
                                                                t3.ST1_LmUser ,--款号更新人
                                                                t3.st1_attr01,
                                                                t3.st1_attr02,
                                                                t3.st1_attr04,
                                                                t1.ST2_LmDt ,
                                                                t1.ST2_LmUser ,
                                                                CONVERT(NVARCHAR(100),t1.ST2_RgDt,23) ST2_RgDt ,
                                                                t1.ST2_RgUser ,
                                                                t1.ST2_State ,
                                                                CASE WHEN ISNULL(t1.st2_upload, '0') = '0' THEN '未导入'
                                                                     WHEN t1.st2_upload = '1' THEN '执行成功'
                                                                     WHEN t1.st2_upload = '9' THEN '失败'
                                                                END st2_upload
                                                      FROM      [B01_MDM].[ST2_StyleColor] t1
                                                                LEFT JOIN [B01_MDM].[ST1_Style] t3 ON t1.ST2_ST1_StyleCode = t3.ST1_StyleCode
                                                    ) T8888
                                            WHERE   1 = 1 " + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 商品新增修改操作
        /// <summary>
        /// 商品新增修改操作
        /// </summary>
        private void EDITGoods()
        {
            string strST1 = ds.Tables["LIST"].Rows[0]["st1_id"].ToString();//取款式GUID
            string strST2 = ds.Tables["LIST"].Rows[0]["st2_id"].ToString();//取SKCGUID
            string strSKC = ds.Tables["LIST"].Rows[0]["ST2_SKCCode"].ToString();    //SKC
            string strStyCode = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString(); //StyleCode
            string strSizeGroup = ds.Tables["list"].Rows[0]["st2_sizegroup"].ToString(); //尺码组

            string strSQL = @"
                   SELECT COUNT(1) FROM [B01_MDM].[ST2_StyleColor]
                   WHERE [ST2_SKCCode] = '" + strSKC + "'";
            int iCount = Convert.ToInt32(conn.GetDataTableFirstValue(strSQL));

            if (strST1 == "" && strST2 == "") //新增
            {
                if (iCount != 0)
                {
                    dt_EditResult.Rows.Add(new object[] { false, "失败,所建款式已存在" });
                    ds_Return.Tables.Add(dt_EditResult);
                    return;
                };

                DataSet dsCreatDS = CreatTab();            //创建具有表头的DataSet
                ds.Tables["list"].Columns.Remove("st1_id");//移除GUID字段
                ds.Tables["list"].Columns.Remove("st2_id");//移除GUID字段
                strST1 = dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ID"].ToString();//该变量存新建style表的guid
                strST2 = dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ID"].ToString();//该变量存新建styleColor表的guid

                //给Style表赋值
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupplierCode"] = ds.Tables["list"].Rows[0]["st1_suppliercode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr01"] = ds.Tables["list"].Rows[0]["ST1_Attr01"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr02"] = ds.Tables["list"].Rows[0]["ST1_Attr02"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr03"] = ds.Tables["list"].Rows[0]["ST1_Attr03"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr04"] = ds.Tables["list"].Rows[0]["ST1_Attr04"].ToString();//增加织法
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupperierStyle"] = ds.Tables["list"].Rows[0]["st1_supperierstyle"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Years"] = ds.Tables["list"].Rows[0]["st1_years"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Season"] = ds.Tables["list"].Rows[0]["st1_season"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ComModity"] = ds.Tables["list"].Rows[0]["st1_commodity"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Unit"] = ds.Tables["list"].Rows[0]["st1_unit"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Category"] = ds.Tables["list"].Rows[0]["st1_category"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LargeClass"] = ds.Tables["list"].Rows[0]["ST1_largeclass"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SmallClass"] = ds.Tables["list"].Rows[0]["ST1_SmallClass"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Grade"] = ds.Tables["list"].Rows[0]["ST1_Grade"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Currency"] = ds.Tables["list"].Rows[0]["ST1_Currency"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Provenance"] = ds.Tables["list"].Rows[0]["ST1_Provenance"].ToString();
                //dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Ingredients"] = ds.Tables["list"].Rows[0]["ST1_Ingredients"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Standard"] = ds.Tables["list"].Rows[0]["ST1_Standard"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SafeTechnology"] = ds.Tables["list"].Rows[0]["ST1_SafeTechnology"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_BR1_BrandCode"] = ds.Tables["list"].Rows[0]["ST1_BR1_BrandCode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST1"].Columns.Add("ST1_RgDt");
                dsCreatDS.Tables["dtST1"].Columns.Add("ST1_RgUser");
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_RgDt"] = timeNow;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_RgUser"] = this.hzyMessage.User_Name;

                //给StyleColor表赋值
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SKCCode"] = ds.Tables["list"].Rows[0]["ST2_SKCCode"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Color"] = ds.Tables["list"].Rows[0]["ST2_Color"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SizeGroup"] = ds.Tables["list"].Rows[0]["ST2_SizeGroup"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierColor"] = ds.Tables["list"].Rows[0]["ST2_SupperierColor"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierSKC"] = ds.Tables["list"].Rows[0]["ST2_SupperierSKC"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_PurchasePrice"] = ds.Tables["list"].Rows[0]["ST2_PurchasePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SalePrice"] = ds.Tables["list"].Rows[0]["ST2_SalePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RefSalePrice"] = ds.Tables["list"].Rows[0]["ST2_RefSalePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ImagePath"] = ds.Tables["list"].Rows[0]["ST2_ImagePath"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Ingredients"] = ds.Tables["list"].Rows[0]["ST2_Ingredients"].ToString();  //成分字段从style表移到stylecolor表
                dsCreatDS.Tables["dtST2"].Columns.Add("ST2_RgDt");
                dsCreatDS.Tables["dtST2"].Columns.Add("ST2_RgUser");
                dsCreatDS.Tables["dtST2"].Columns.Add("ST2_ColorGroup");

                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ColorGroup"] = "C-A";
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_UpLoad"] = "0";
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RgDt"] = timeNow;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RgUser"] = this.hzyMessage.User_Name;

                bool bResult;
                conn.LockTableList.Add("B01_MDM.ST2_StyleColor");// 锁表
                conn.LockTableList.Add("B01_MDM.ST1_Style");

                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("B01_MDM.ST1_Style", dsCreatDS.Tables["dtST1"]); //增加style数据
                bResult = conn.Insert("B01_MDM.ST2_StyleColor", dsCreatDS.Tables["dtST2"]);//增加styleColor数据
                bResult = AutoSKU(strStyCode, strSKC, strSizeGroup, dsCreatDS.Tables["dtST3"]);    //增加SKU表数据
                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "新增成功" });
                    dt_EditResult.Rows.Add(new object[] { "ST1_ID", strST1 });
                    dt_EditResult.Rows.Add(new object[] { "ST2_ID", strST2 });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "新增失败" });
                }
                conn.CommitTransaction();   //提交事务

            }
            else if (strST2 != "" && iCount == 0) //只新增ST2_StyleColor表，修改style表
            {
                DataSet dsCreatDS = CreatTab();            //创建具有表头的DataSet
                ds.Tables["list"].Columns.Remove("st2_id");//移除GUID字段

                //该变量存新建styleColor表的guid
                strST2 = dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ID"].ToString();

                //Style表
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ID"] = strST1;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupplierCode"] = ds.Tables["list"].Rows[0]["st1_suppliercode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr01"] = ds.Tables["list"].Rows[0]["ST1_Attr01"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr02"] = ds.Tables["list"].Rows[0]["ST1_Attr02"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr03"] = ds.Tables["list"].Rows[0]["ST1_Attr03"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr04"] = ds.Tables["list"].Rows[0]["ST1_Attr04"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupperierStyle"] = ds.Tables["list"].Rows[0]["st1_supperierstyle"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_BR1_BrandCode"] = ds.Tables["list"].Rows[0]["ST1_BR1_BrandCode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Years"] = ds.Tables["list"].Rows[0]["st1_years"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Season"] = ds.Tables["list"].Rows[0]["st1_season"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ComModity"] = ds.Tables["list"].Rows[0]["st1_commodity"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Unit"] = ds.Tables["list"].Rows[0]["st1_unit"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Category"] = ds.Tables["list"].Rows[0]["st1_category"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LargeClass"] = ds.Tables["list"].Rows[0]["ST1_largeclass"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SmallClass"] = ds.Tables["list"].Rows[0]["ST1_SmallClass"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Grade"] = ds.Tables["list"].Rows[0]["ST1_Grade"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Currency"] = ds.Tables["list"].Rows[0]["ST1_Currency"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Provenance"] = ds.Tables["list"].Rows[0]["ST1_Provenance"].ToString();
                //dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Ingredients"] = ds.Tables["list"].Rows[0]["ST1_Ingredients"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Standard"] = ds.Tables["list"].Rows[0]["ST1_Standard"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SafeTechnology"] = ds.Tables["list"].Rows[0]["ST1_SafeTechnology"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmDt"] = timeNow;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmUser"] = this.hzyMessage.User_Name;

                //给StyleColor表赋值
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SKCCode"] = ds.Tables["list"].Rows[0]["ST2_SKCCode"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Color"] = ds.Tables["list"].Rows[0]["ST2_Color"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SizeGroup"] = ds.Tables["list"].Rows[0]["ST2_SizeGroup"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierColor"] = ds.Tables["list"].Rows[0]["ST2_SupperierColor"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierSKC"] = ds.Tables["list"].Rows[0]["ST2_SupperierSKC"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_PurchasePrice"] = ds.Tables["list"].Rows[0]["ST2_PurchasePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SalePrice"] = ds.Tables["list"].Rows[0]["ST2_SalePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RefSalePrice"] = ds.Tables["list"].Rows[0]["ST2_RefSalePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ImagePath"] = ds.Tables["list"].Rows[0]["ST2_ImagePath"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtSt2"].Rows[0]["ST2_Ingredients"] = ds.Tables["list"].Rows[0]["ST2_Ingredients"].ToString(); //成分移到StyleColor表
                dsCreatDS.Tables["dtST2"].Columns.Add("ST2_RgDt");
                dsCreatDS.Tables["dtST2"].Columns.Add("ST2_RgUser");
                dsCreatDS.Tables["dtST2"].Columns.Add("ST2_ColorGroup");
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ColorGroup"] = "C-A";
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_UpLoad"] = "0";
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RgDt"] = timeNow;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RgUser"] = this.hzyMessage.User_Name;

                bool bResult;
                ArrayList listKey = new ArrayList();
                listKey.Add("ST1_ID");

                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("B01_MDM.ST2_StyleColor", dsCreatDS.Tables["dtST2"]);//增加styleColor数据
                bResult = AutoSKU(strStyCode, strSKC, strSizeGroup, dsCreatDS.Tables["dtST3"]);    //增加SKU表数据
                bResult = conn.Update("B01_MDM.ST1_Style", dsCreatDS.Tables["dtST1"], listKey);//修改style数据
                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "新增成功" });
                    dt_EditResult.Rows.Add(new object[] { "ST1_ID", strST1 });
                    dt_EditResult.Rows.Add(new object[] { "ST2_ID", strST2 });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "新增失败" });
                }
                conn.CommitTransaction();   //提交事务
            }
            else if (strST2 != "" && iCount != 0)  //修改
            {
                //Style表
                DataSet dsCreatDS = CreatTab();            //创建具有表头的DataSet
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ID"] = strST1;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupplierCode"] = ds.Tables["list"].Rows[0]["st1_suppliercode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupperierStyle"] = ds.Tables["list"].Rows[0]["st1_supperierstyle"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_BR1_BrandCode"] = ds.Tables["list"].Rows[0]["ST1_BR1_BrandCode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr01"] = ds.Tables["list"].Rows[0]["ST1_Attr01"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr02"] = ds.Tables["list"].Rows[0]["ST1_Attr02"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr03"] = ds.Tables["list"].Rows[0]["ST1_Attr03"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attr04"] = ds.Tables["list"].Rows[0]["ST1_Attr04"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Years"] = ds.Tables["list"].Rows[0]["st1_years"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Season"] = ds.Tables["list"].Rows[0]["st1_season"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ComModity"] = ds.Tables["list"].Rows[0]["st1_commodity"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Unit"] = ds.Tables["list"].Rows[0]["st1_unit"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Category"] = ds.Tables["list"].Rows[0]["st1_category"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LargeClass"] = ds.Tables["list"].Rows[0]["ST1_largeclass"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SmallClass"] = ds.Tables["list"].Rows[0]["ST1_SmallClass"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Grade"] = ds.Tables["list"].Rows[0]["ST1_Grade"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Currency"] = ds.Tables["list"].Rows[0]["ST1_Currency"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Provenance"] = ds.Tables["list"].Rows[0]["ST1_Provenance"].ToString();
                //dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Ingredients"] = ds.Tables["list"].Rows[0]["ST1_Ingredients"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Standard"] = ds.Tables["list"].Rows[0]["ST1_Standard"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SafeTechnology"] = ds.Tables["list"].Rows[0]["ST1_SafeTechnology"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmDt"] = timeNow;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmUser"] = this.hzyMessage.User_Name;

                //给StyleColor表赋值
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ID"] = strST2;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SKCCode"] = ds.Tables["list"].Rows[0]["ST2_SKCCode"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Color"] = ds.Tables["list"].Rows[0]["ST2_Color"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SizeGroup"] = ds.Tables["list"].Rows[0]["ST2_SizeGroup"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierColor"] = ds.Tables["list"].Rows[0]["ST2_SupperierColor"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierSKC"] = ds.Tables["list"].Rows[0]["ST2_SupperierSKC"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_PurchasePrice"] = ds.Tables["list"].Rows[0]["ST2_PurchasePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SalePrice"] = ds.Tables["list"].Rows[0]["ST2_SalePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RefSalePrice"] = ds.Tables["list"].Rows[0]["ST2_RefSalePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ImagePath"] = ds.Tables["list"].Rows[0]["ST2_ImagePath"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Ingredients"] = ds.Tables["list"].Rows[0]["ST2_Ingredients"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_UpLoad"] = "0";
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_LmDt"] = timeNow;

                dsCreatDS.Tables["dtST2"].Columns.Add("ST2_ColorGroup");
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ColorGroup"] = "C-A";

                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_LmUser"] = this.hzyMessage.User_Name;

                bool bResult;
                conn.LockTableList.Add("B01_MDM.ST2_StyleColor");// 锁表
                conn.LockTableList.Add("B01_MDM.ST1_Style");

                conn.BeginTransaction(); // 开启事务
                ArrayList listKey = new ArrayList();
                listKey.Add("ST1_ID");
                bResult = conn.Update("B01_MDM.ST1_Style", dsCreatDS.Tables["dtST1"], listKey);//修改style数据

                listKey.Remove("ST1_ID");
                listKey.Add("ST2_ID");
                bResult = conn.Update("B01_MDM.ST2_StyleColor", dsCreatDS.Tables["dtST2"], listKey);//增加styleColor数据
                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                    dt_EditResult.Rows.Add(new object[] { "ST1_ID", ds.Tables["list"].Rows[0]["ST1_ID"].ToString() });
                    dt_EditResult.Rows.Add(new object[] { "ST2_ID", ds.Tables["list"].Rows[0]["ST2_ID"].ToString() });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                }
                conn.CommitTransaction();   //提交事务

            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 创建需要的DataSet

        private DataSet CreatTab()
        {
            DataSet dsReturn = new DataSet();

            DataTable dtST1 = new DataTable();  //Style
            DataTable dtST2 = new DataTable();  //StyleColor
            DataTable dtST3 = new DataTable();  //StyleColorSize
            DataRow drST1 = dtST1.NewRow();
            DataRow drST2 = dtST2.NewRow();
            dtST1.Rows.Add(drST1);
            dtST2.Rows.Add(drST2);

            System.Guid guid = System.Guid.NewGuid();               //Guid 类型
            string strGUID = System.Guid.NewGuid().ToString();      //直接返回字符串类型

            //style表
            dtST1.Columns.Add("ST1_ID");
            dtST1.Columns.Add("ST1_CONO");
            dtST1.Columns.Add("ST1_DIVI");
            dtST1.Columns.Add("ST1_StyleCode");
            dtST1.Columns.Add("ST1_SupplierCode");
            dtST1.Columns.Add("ST1_BR1_BrandCode");
            dtST1.Columns.Add("ST1_SupperierStyle");
            dtST1.Columns.Add("ST1_Years");
            dtST1.Columns.Add("ST1_Season");
            dtST1.Columns.Add("ST1_ComModity");
            dtST1.Columns.Add("ST1_Unit");
            dtST1.Columns.Add("ST1_Category");
            dtST1.Columns.Add("ST1_LargeClass");
            dtST1.Columns.Add("ST1_SmallClass");
            dtST1.Columns.Add("ST1_Grade");
            dtST1.Columns.Add("ST1_Currency");
            dtST1.Columns.Add("ST1_Provenance");
            //dtST1.Columns.Add("ST1_Ingredients");
            dtST1.Columns.Add("ST1_Standard");
            dtST1.Columns.Add("ST1_Attr01");
            dtST1.Columns.Add("ST1_Attr02");
            dtST1.Columns.Add("ST1_Attr03");
            dtST1.Columns.Add("ST1_Attr04");
            dtST1.Columns.Add("ST1_SafeTechnology");
            //dtST1.Columns.Add("ST1_IsPrint");
            dtST1.Columns.Add("ST1_State");
            dtST1.Columns.Add("ST1_LmDt");
            dtST1.Columns.Add("ST1_LmUser");
            //赋值
            dtST1.Rows[0]["ST1_ID"] = strGUID;
            dtST1.Rows[0]["ST1_CONO"] = "GL";
            dtST1.Rows[0]["ST1_DIVI"] = "D01";



            //StyleColor表
            dtST2.Columns.Add("ST2_ID");
            dtST2.Columns.Add("ST2_CONO");
            dtST2.Columns.Add("ST2_DIVI");
            dtST2.Columns.Add("ST2_ST1_StyleCode");
            dtST2.Columns.Add("ST2_SKCCode");
            dtST2.Columns.Add("ST2_Color");
            dtST2.Columns.Add("ST2_Ingredients");
            //dtST2.Columns.Add("ST2_ColorGroup");
            dtST2.Columns.Add("ST2_SizeGroup");
            dtST2.Columns.Add("ST2_SupperierColor");
            dtST2.Columns.Add("ST2_SupperierSKC");
            dtST2.Columns.Add("ST2_PurchasePrice");
            dtST2.Columns.Add("ST2_SalePrice");
            dtST2.Columns.Add("ST2_RefSalePrice");
            dtST2.Columns.Add("ST2_ImagePath");
            dtST2.Columns.Add("ST2_State");
            //dtST2.Columns.Add("ST2_RgDt");
            //dtST2.Columns.Add("ST2_RgUser");
            dtST2.Columns.Add("ST2_LmDt");
            dtST2.Columns.Add("ST2_LmUser");
            dtST2.Columns.Add("ST2_UpLoad");

            //StyleCodeSize
            dtST3.Columns.Add("ST3_ID");
            dtST3.Columns.Add("ST3_CONO");
            dtST3.Columns.Add("ST3_DIVI");
            dtST3.Columns.Add("ST3_ST1_StyleCode");
            dtST3.Columns.Add("ST3_ST2_SKCCode");
            dtST3.Columns.Add("ST3_SupperierSize");
            dtST3.Columns.Add("ST3_SKUCode");
            dtST3.Columns.Add("ST3_Size");
            dtST3.Columns.Add("ST3_State");
            dtST3.Columns.Add("ST3_RgDt");
            dtST3.Columns.Add("ST3_RgUser");
            dtST3.Columns.Add("ST3_LmDt");
            dtST3.Columns.Add("ST3_LmUser");
            //赋值
            strGUID = System.Guid.NewGuid().ToString();
            dtST2.Rows[0]["ST2_ID"] = strGUID;
            dtST2.Rows[0]["ST2_CONO"] = "GL";
            dtST2.Rows[0]["ST2_DIVI"] = "D01";
            //将创建的表添加到DataSet中，并返回给Handle。
            dtST3.TableName = "dtST3";
            dtST2.TableName = "dtST2";
            dtST1.TableName = "dtST1";

            //将Dt添加到Ds中
            dsReturn.Tables.Add(dtST3);
            dsReturn.Tables.Add(dtST2);
            dsReturn.Tables.Add(dtST1);

            return dsReturn;
        }
        #endregion

        #region 根据尺码自动生成SKU
        /// <summary>
        /// 用于保存自动生成SKU（1-F码）
        /// </summary>
        /// <param name="pstrStyCode">StyleCode</param>
        /// <param name="pstrSKC">SKC</param>
        /// <param nmae="pstrSizeType">尺码组(等尺码组有后在使用该参数)</param>
        /// <param name="pstrDt">SKU表</param>
        /// <returns>返回创建成功或者失败的bool</returns>
        private bool AutoSKU(string pstrStyCode, string pstrSKC, string pstrSizeType, DataTable pstrDt)
        {

            string strSQL = @"SELECT [CT1_ID]
                                            ,[CT1_State]
                                        FROM [M01_CONF].[CT0_CSYTAB]
                                    WHERE CT1_CodeName = '尺码组' AND CT1_KeyID = '" + pstrSizeType + "'";

            DataTable dtGroup = conn.GetDataTable(strSQL);

            //尺码组状态
            string strGroupState = dtGroup.Rows[0]["CT1_State"].ToString();

            //获取父ID
            string strFatherID = dtGroup.Rows[0]["CT1_ID"].ToString();

            if (strGroupState == "90")
            {
                return true;
            };

            //获取尺码//2015-02-10 王薇需求，将[CT1_KeyID]改成[CT1_OptionsValues] 修改人：俞佳伟
            string strSizeSQL = @"SELECT [CT1_OptionsValues] --[CT1_KeyID] 
                                          FROM [M01_CONF].[CT0_CSYTAB]
                                          WHERE CT1_CodeName = '尺码' AND CT1_State = '20' AND CT1_FatherID = '" + strFatherID + "'";

            DataTable dtSize = conn.GetDataTable(strSizeSQL);

            //获取尺码组的数量
            int sizeCount = dtSize.Rows.Count;

            if (sizeCount == 0)
            {
                return true;
            }
            bool bResult;

            for (int i = 0; i < sizeCount; i++)
            {
                //创建新行
                DataRow drDe = pstrDt.NewRow();
                pstrDt.Rows.Add(drDe);

                //生成GUID
                string strGUID = System.Guid.NewGuid().ToString();
                //生成尺码
                //string strSize = dtSize.Rows[i]["CT1_KeyID"].ToString();
                
                string strSize = dtSize.Rows[i]["CT1_OptionsValues"].ToString();//2015-02-10 王薇需求，将[CT1_KeyID]改成[CT1_OptionsValues] 修改人：俞佳伟

                pstrDt.Rows[i]["ST3_SKUCode"] = pstrSKC + strSize;
                pstrDt.Rows[i]["ST3_Size"] = strSize;
                pstrDt.Rows[i]["ST3_SupperierSize"] = "GYS0" + strSize;

                //赋值
                pstrDt.Rows[i]["ST3_ID"] = strGUID;
                pstrDt.Rows[i]["ST3_CONO"] = "GL";
                pstrDt.Rows[i]["ST3_DIVI"] = "D01";
                pstrDt.Rows[i]["ST3_ST1_StyleCode"] = pstrStyCode;
                pstrDt.Rows[i]["ST3_ST2_SKCCode"] = pstrSKC;
                pstrDt.Rows[i]["ST3_State"] = "20";
                pstrDt.Rows[i]["ST3_RgDt"] = timeNow;
                pstrDt.Rows[i]["ST3_RgUser"] = this.hzyMessage.User_Name;
                pstrDt.Rows[i]["ST3_LmDt"] = timeNow;
                pstrDt.Rows[i]["ST3_LmUser"] = this.hzyMessage.User_Name;

            };
            // 锁表
            conn.LockTableList.Add("[B01_MDM].[ST3_StyleColorSize]");
            bResult = conn.Insert("[B01_MDM].[ST3_StyleColorSize]", pstrDt); //增加SKU表数据
            return bResult;
        }
        #endregion
        #endregion
    }
}