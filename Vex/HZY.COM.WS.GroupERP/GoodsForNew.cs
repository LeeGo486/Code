using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using HZY.COM;
using HZY.COM.Common;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;
using HZY.COM.Common.DBAccess;
using System.Data;
using System.Collections;
using System.Data.OleDb;

namespace HZY.COM.WS.GroupERP
{
    class GoodsForNew : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public GoodsForNew()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn conn = new Dbconn(),
            lx_conn = new Dbconn("F22LX"), //斓绣
            rs_conn = new Dbconn("F22RS"),//斓居
            gl_conn = new Dbconn("F22GL");//雅斓;
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
                conn = new Dbconn(m_hzyMessage.Env_SN);
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GoodsInfo".ToUpper())//商品信息查询无分页带模糊查询
                {
                    filter = m_request.Tables[0].Rows[0]["q"].ToString(); // 实时条件，用于下拉框查询数据
                    GetGoodsInfo(filter);
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GoodsInfoForPageList".ToUpper())//商品信息查询有分页
                {
                    GoodsInfoForPageList();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDITGoods".ToUpper())//商品新增修改操作
                {
                    EDITGoods();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "AddSKU".ToUpper()) //生成SKU
                {
                    AddSKU();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "deleteSKU".ToUpper())
                {
                    deleteSKU();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetGoodsFromExcel".ToUpper())
                {
                    GetGoodsFromExcel();
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
                                          WHERE     t3.ST1_SupplierCode = SP1_SupplierCode AND t3.ST1_DIVI=SP1_DIVI
                                        ) SP1_Name ,--SUK表供应商名称
                                        ( SELECT    BR1_Name
                                          FROM      [B01_MDM].[BR1_Brand]
                                          WHERE     t3.ST1_BR1_BrandCode = BR1_BrandCode AND BR1_DIVI=t3.ST1_DIVI
                                        ) BR1_BrandName ,--品牌名称SKU表
		                                t3.ST1_SupperierStyle,--SKU供应商款号
		                                t1.ST2_SupperierColor,--SKC表供应商颜色
		                                t1.ST2_SupperierSKC,--SKC表供应商KSC
		                                t2.ST3_ST1_StyleCode ,--款号表 款号
		                                t1.ST2_Color,--KSC表颜色
		                                (SELECT CT1_KeyName FROM [M01_CONF].[CT0_CSYTAB]
		                                WHERE t1.ST2_Color = CT1_KeyID  AND CT1_Code= 'COLO' AND CT1_DIVI=t1.ST2_DIVI) CT1_KeyName ,
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
                                FROM    [B01_MDM].[ST2_StyleColor] WITH(NOLOCK) t1
                                        LEFT JOIN [B01_MDM].ST3_StyleColorSize WITH(NOLOCK) t2 ON t1.ST2_SKCCode = t2.ST3_ST2_SKCCode AND t1.ST2_DIVI=t2.ST3_DIVI
                                        LEFT JOIN [B01_MDM].[ST1_Style] WITH(NOLOCK) t3 ON t1.ST2_ST1_StyleCode  = t3.ST1_StyleCode AND t1.ST2_DIVI=t3.ST1_DIVI AND
                                        SP1_Name LIKE '%" + pstrQ + "%' Order by ST1_LmDt AND ST1_DIVI='" + m_hzyMessage.Env_SN + "' AND ST1_Years>='2016'" + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSet(strSQL, new string[0]);
        }

        #endregion

        #region 商品信息查询(有分页)
        /// <summary>
        /// 商品信息查询(有分页)
        /// </summary>
        private void GoodsInfoForPageList()
        {
            string strWhere = "";
            if (ds.Tables["list"].Columns.Contains("ST2_SKCCode"))
            {
                strWhere = " AND ST2_SKCCode='" + ds.Tables["list"].Rows[0]["ST2_SKCCode"].ToString() + "' ";
            }
            string strSQL = @"
                              SELECT  * FROM    ( SELECT    t1.ST2_ImagePath ,--图片路径取SKC表
                                                                t1.ST2_ID ,--SKC表GUID
                                                                t3.ST1_SupplierCode ,--SKU表供应商编号
                                                                ( SELECT    SP1_Name
                                                                  FROM      [B01_MDM].[SP1_Supplier] WITH(NOLOCK)
                                                                  WHERE     t3.ST1_SupplierCode = SP1_SupplierCode AND t3.ST1_DIVI=SP1_DIVI
                                                                ) SP1_Name ,--SUK表供应商名称
                                                                ( SELECT    BR1_Name
                                                                  FROM      [B01_MDM].[BR1_Brand] WITH(NOLOCK)
                                                                  WHERE     t3.ST1_BR1_BrandCode = BR1_BrandCode AND BR1_DIVI=t3.ST1_DIVI
                                                                ) BR1_BrandName ,--品牌名称SKU表
                                                                t3.ST1_BR1_BrandCode ,
                                                                t3.ST1_ComModity , --款号品名
                                                                t3.ST1_SupperierStyle ,--SKU供应商款号
                                                                t1.ST2_SupperierColor ,--SKC表供应商颜色
                                                                t1.ST2_SupperierSKC ,--SKC表供应商KSC
                                                                t1.ST2_ST1_StyleCode ,--SKC 款号
                                                                t1.ST2_Color ,--KSC表颜色
                                                                ( SELECT    CT1_KeyName
                                                                  FROM      [M01_CONF].[CT0_CSYTAB] WITH(NOLOCK)
                                                                  WHERE     t1.ST2_Color = CT1_KeyID
                                                                            AND CT1_Code = 'COLO' AND CT1_DIVI=t1.ST2_DIVI
                                                                ) CT1_KeyName ,
                                                                t1.ST2_SKCCode , --skc颜色名称
                                                                t3.ST1_Unit , --款号表单位
                                                                ( SELECT    CT1_KeyName
                                                                  FROM      [M01_CONF].[CT0_CSYTAB] WITH(NOLOCK)
                                                                  WHERE     t3.ST1_Unit = CT1_KeyID
                                                                    AND CT1_Code = 'UNIT' AND CT1_DIVI=t3.ST1_DIVI
                                                                ) ST1_UnitName ,--单位名称
                                                                t3.ST1_Currency , -- 款号币种
                                                                t3.ST1_ID ,--款号GUID
                                                                t1.ST2_SizeGroup , -- KSC尺码组
                                                                t1.ST2_PurchasePrice ,--SKC表采购价格
                                                                t1.ST2_SalePrice ,--SKC表采购吊牌价
                                                                t1.ST2_RefSalePrice,--参考吊牌价
                                                                t3.ST1_Years ,--款号表年份
                                                                t3.ST1_Season ,--款号表季节
                                                                t3.ST1_Category ,--款号表品类                                                                
                                                                t3.ST1_LargeClass ,--款号表大类
                                                                ( SELECT CT1_KeyName
																  FROM [M01_CONF].[CT0_CSYTAB] WITH(NOLOCK)
																  WHERE  CT1_FatherID=(SELECT CT1_ID FROM [M01_CONF].[CT0_CSYTAB] WITH(NOLOCK) WHERE CT1_KeyName=t3.ST1_Category
																  AND CT1_Code='ITCL' AND CT1_DIVI=t3.ST1_DIVI AND LEN(CT1_KeyID)=2 ) AND CT1_OptionsValues=t3.ST1_LargeClass
																 ) ST1_LargeClassName,
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
                                                                t3.ST1_Series,
                                                                t3.ST1_StyleLine,
                                                                t3.ST1_Usedmethod,
                                                                t3.ST1_Attention,
                                                                t3.ST1_PermitNo,
                                                                t3.ST1_Fragrance,
                                                                t3.ST1_Netweight,
                                                                t3.ST1_ProductDate,
                                                                t3.ST1_Expiration,
                                                                t3.ST1_ProductLine,
                                                                t3.ST1_FabricComponent,
                                                                t1.ST2_LmDt ,
                                                                t1.ST2_LmUser ,
                                                                CONVERT(NVARCHAR(100),t1.ST2_RgDt,23) ST2_RgDt ,
                                                                t1.ST2_RgUser ,
                                                                t1.ST2_State ,
                                                                CASE WHEN ISNULL(t1.st2_upload, '0') = '0' THEN '未导入'
                                                                     WHEN t1.st2_upload = '1' THEN '执行成功'
                                                                     WHEN t1.st2_upload = '9' THEN '失败'
                                                                END st2_upload
                                                      FROM      [B01_MDM].[ST2_StyleColor] t1 WITH(NOLOCK)
                                                                LEFT JOIN [B01_MDM].[ST1_Style] t3 WITH(NOLOCK) ON t1.ST2_ST1_StyleCode = t3.ST1_StyleCode AND t1.ST2_DIVI=t3.ST1_DIVI WHERE t1.ST2_DIVI='"
                + m_hzyMessage.Env_SN + "') T8888 WHERE ST1_Years>='2016' " + strWhere + m_hzyPageInfo.Where;
            ds_Return = conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 商品新增修改操作
        /// <summary>
        /// 商品新增修改操作
        /// </summary>
        private void EDITGoods()
        {
            string strBrand = "";

            string strST1 = ds.Tables["LIST"].Rows[0]["st1_id"].ToString().Trim();//取款式GUID
            string strST2 = ds.Tables["LIST"].Rows[0]["st2_id"].ToString().Trim();//取SKCGUID
            string strSKC = ds.Tables["LIST"].Rows[0]["ST2_SKCCode"].ToString();    //SKC
            string strStyCode = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString(); //StyleCode
            string strSizeGroup = ds.Tables["list"].Rows[0]["st2_sizegroup"].ToString(); //尺码组
            string strSupplierStyle = ds.Tables["list"].Rows[0]["st1_supperierstyle"].ToString(); //供应商款号
            strBrand = strStyCode.Substring(0, 2);

            //查询ST1表
            string strSQL1 = @"
                                SELECT COUNT(1) FROM [B01_MDM].[ST1_Style]
                                WHERE [ST1_StyleCode] = '" + strStyCode + "' AND ST1_DIVI='" + m_hzyMessage.Env_SN + "'";
            int st1_count = Convert.ToInt32(conn.GetDataTableFirstValue(strSQL1));

            //查询ST2表
            string strSQL2 = @"
                   SELECT COUNT(1) FROM [B01_MDM].[ST2_StyleColor]
                   WHERE [ST2_SKCCode] = '" + strSKC + "' AND ST2_DIVI='" + m_hzyMessage.Env_SN + "'";
            int st2_count = Convert.ToInt32(conn.GetDataTableFirstValue(strSQL2));



            if (st1_count == 0 && st2_count == 0) //新增
            {
                DataSet dsCreatDS = CreatTab();            //创建具有表头的DataSet
                ds.Tables["list"].Columns.Remove("st1_id");//移除GUID字段
                ds.Tables["list"].Columns.Remove("st2_id");//移除GUID字段
                strST1 = dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ID"].ToString();//该变量存新建style表的guid
                strST2 = dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ID"].ToString();//该变量存新建styleColor表的guid

                //给Style表赋值
                dsCreatDS.Tables["dtST1"].Columns.Add("ST1_RgDt");
                dsCreatDS.Tables["dtST1"].Columns.Add("ST1_RgUser");
                dsCreatDS.Tables["dtST1"].Columns.Add("ST1_UptNo");
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupplierCode"] = ds.Tables["list"].Rows[0]["st1_suppliercode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_BrandID"] = strBrand;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_DIVI"] = m_hzyMessage.Env_SN;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Series"] = ds.Tables["list"].Rows[0]["ST1_Series"].ToString();   //系列跟风格线字段修改成ST1_Series,ST1_StyleLine
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_StyleLine"] = ds.Tables["list"].Rows[0]["ST1_StyleLine"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupperierStyle"] = ds.Tables["list"].Rows[0]["st1_supperierstyle"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Years"] = ds.Tables["list"].Rows[0]["st1_years"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ComModity"] = ds.Tables["list"].Rows[0]["st1_commodity"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Unit"] = ds.Tables["list"].Rows[0]["st1_unit"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Category"] = ds.Tables["list"].Rows[0]["st1_category"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LargeClass"] = ds.Tables["list"].Rows[0]["ST1_largeclass"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SmallClass"] = ds.Tables["list"].Rows[0]["ST1_SmallClass"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Grade"] = ds.Tables["list"].Rows[0]["ST1_Grade"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Currency"] = ds.Tables["list"].Rows[0]["ST1_Currency"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Provenance"] = ds.Tables["list"].Rows[0]["ST1_Provenance"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Standard"] = ds.Tables["list"].Rows[0]["ST1_Standard"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SafeTechnology"] = ds.Tables["list"].Rows[0]["ST1_SafeTechnology"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_BR1_BrandCode"] = ds.Tables["list"].Rows[0]["ST1_BR1_BrandCode"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_RgDt"] = timeNow;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_RgUser"] = this.hzyMessage.User_Name;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmDt"] = timeNow;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmUser"] = this.hzyMessage.User_Name;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_UptNo"] = "0";
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Season"] = ds.Tables["list"].Rows[0]["ST1_Season"].ToString(); //雅斓添加季节
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Usedmethod"] = ds.Tables["list"].Rows[0]["ST1_Usedmethod"].ToString();   //添加使用方法
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attention"] = ds.Tables["list"].Rows[0]["ST1_Attention"].ToString();     //注意事项
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_PermitNo"] = ds.Tables["list"].Rows[0]["ST1_PermitNo"].ToString();       //批准文号
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Fragrance"] = ds.Tables["list"].Rows[0]["ST1_Fragrance"].ToString();     //香味
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Netweight"] = ds.Tables["list"].Rows[0]["ST1_Netweight"].ToString();     //净含量
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ProductDate"] = ds.Tables["list"].Rows[0]["ST1_ProductDate"].ToString(); //生产日期
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Expiration"] = ds.Tables["list"].Rows[0]["ST1_Expiration"].ToString();   //保质期
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_FabricComponent"] = ds.Tables["list"].Rows[0]["ST1_FabricComponent"].ToString();   //面料成分
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ProductLine"] = ds.Tables["list"].Rows[0]["ST1_ProductLine"].ToString();   //面料成分


                //给StyleColor表赋值
                dsCreatDS.Tables["dtST2"].Columns.Add("ST2_UptNo");
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SKCCode"] = ds.Tables["list"].Rows[0]["ST2_SKCCode"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Color"] = ds.Tables["list"].Rows[0]["ST2_Color"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SizeGroup"] = ds.Tables["list"].Rows[0]["ST2_SizeGroup"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierColor"] = ds.Tables["list"].Rows[0]["ST2_SupperierColor"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierSKC"] = ds.Tables["list"].Rows[0]["ST2_SupperierSKC"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_PurchasePrice"] = ds.Tables["list"].Rows[0]["ST2_PurchasePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Ingredients"] = ds.Tables["list"].Rows[0]["ST2_Ingredients"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ImagePath"] = ds.Tables["list"].Rows[0]["ST2_ImagePath"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SalePrice"] = ds.Tables["list"].Rows[0]["ST2_SalePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_DIVI"] = m_hzyMessage.Env_SN;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RgDt"] = timeNow;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RgUser"] = this.hzyMessage.User_Name;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_LmDt"] = timeNow;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_LmUser"] = this.hzyMessage.User_Name;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_UpLoad"] = "0";
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_UptNo"] = "0";
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RefSalePrice"] = ds.Tables["list"].Rows[0]["ST2_RefSalePrice"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ColorGroup"] = "C-A";


                bool bResult;

                conn.BeginTransaction(); // 开启事务
                bResult = conn.Insert("B01_MDM.ST1_Style", dsCreatDS.Tables["dtST1"]); //增加style数据
                if (bResult)
                {
                    bResult = conn.Insert("B01_MDM.ST2_StyleColor", dsCreatDS.Tables["dtST2"]);//增加styleColor数据
                }
                if (bResult)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "新增成功" });
                    dt_EditResult.Rows.Add(new object[] { "ST1_ID", strST1 });
                    dt_EditResult.Rows.Add(new object[] { "ST2_ID", strST2 });
                    conn.CommitTransaction();   //提交事务
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "新增失败" });
                    conn.RollbackTransaction();
                }
            }
            else if (st1_count != 0 && st2_count == 0) //只新增ST2_StyleColor表，修改style表
            {
                //俞佳伟 2015-07-16 控制相同款号 吊牌价必须相同
                string sqlSalePrice = @"
                   SELECT AVG(ISNULL(ST2_SalePrice,0)) FROM [B01_MDM].[ST2_StyleColor] WITH(NOLOCK)
                   WHERE ST2_ST1_StyleCode = '" + strStyCode + "' AND ST2_DIVI='" + m_hzyMessage.Env_SN + "'";
                decimal decSalePrice = Convert.ToDecimal(conn.GetDataTableFirstValue(sqlSalePrice).ToString());
                if (decSalePrice == Convert.ToDecimal(ds.Tables["list"].Rows[0]["ST2_SalePrice"].ToString()))
                {
                    DataSet dsCreatDS = CreatTab();            //创建具有表头的DataSet
                    ds.Tables["list"].Columns.Remove("st2_id");//移除GUID字段

                    //该变量存新建styleColor表的guid
                    strST2 = dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ID"].ToString();

                    //修改Style表
                    //删除不能修改的字段
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_BrandID");
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_ProductLine");
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_SupplierCode");
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_Season");
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_Years");
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_Category");
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_LargeClass");
                    if (m_hzyMessage.Env_SN != "GL")
                    {
                        dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_SmallClass");
                    }
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_FabricComponent");
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_BR1_BrandCode");
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_StyleCode");


                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ID"] = strST1;
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Series"] = ds.Tables["list"].Rows[0]["ST1_Series"].ToString();   //系列跟风格线字段修改成ST1_Series,ST1_StyleLine
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_StyleLine"] = ds.Tables["list"].Rows[0]["ST1_StyleLine"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupperierStyle"] = ds.Tables["list"].Rows[0]["st1_supperierstyle"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ComModity"] = ds.Tables["list"].Rows[0]["st1_commodity"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Unit"] = ds.Tables["list"].Rows[0]["st1_unit"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Grade"] = ds.Tables["list"].Rows[0]["ST1_Grade"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Currency"] = ds.Tables["list"].Rows[0]["ST1_Currency"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Provenance"] = ds.Tables["list"].Rows[0]["ST1_Provenance"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Standard"] = ds.Tables["list"].Rows[0]["ST1_Standard"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SafeTechnology"] = ds.Tables["list"].Rows[0]["ST1_SafeTechnology"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmDt"] = timeNow;
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmUser"] = this.hzyMessage.User_Name;
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_DIVI"] = m_hzyMessage.Env_SN;
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Usedmethod"] = ds.Tables["list"].Rows[0]["ST1_Usedmethod"].ToString();   //添加使用方法
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attention"] = ds.Tables["list"].Rows[0]["ST1_Attention"].ToString(); //注意事项
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_PermitNo"] = ds.Tables["list"].Rows[0]["ST1_PermitNo"].ToString(); //批准文号
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Fragrance"] = ds.Tables["list"].Rows[0]["ST1_Fragrance"].ToString(); //香味
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Netweight"] = ds.Tables["list"].Rows[0]["ST1_Netweight"].ToString(); //净含量
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ProductDate"] = ds.Tables["list"].Rows[0]["ST1_ProductDate"].ToString(); //生产日期
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Expiration"] = ds.Tables["list"].Rows[0]["ST1_Expiration"].ToString(); //保质期
                    if (m_hzyMessage.Env_SN == "GL")
                    {
                        dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SmallClass"] = ds.Tables["list"].Rows[0]["ST1_SmallClass"].ToString(); //小类
                    }

                    //给StyleColor表赋值
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ST1_StyleCode"] = ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SKCCode"] = ds.Tables["list"].Rows[0]["ST2_SKCCode"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Color"] = ds.Tables["list"].Rows[0]["ST2_Color"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SizeGroup"] = ds.Tables["list"].Rows[0]["ST2_SizeGroup"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierColor"] = ds.Tables["list"].Rows[0]["ST2_SupperierColor"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SupperierSKC"] = ds.Tables["list"].Rows[0]["ST2_SupperierSKC"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_PurchasePrice"] = ds.Tables["list"].Rows[0]["ST2_PurchasePrice"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_SalePrice"] = ds.Tables["list"].Rows[0]["ST2_SalePrice"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Ingredients"] = ds.Tables["list"].Rows[0]["ST2_Ingredients"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ImagePath"] = ds.Tables["list"].Rows[0]["ST2_ImagePath"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RgDt"] = timeNow;
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RgUser"] = this.hzyMessage.User_Name;
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_LmDt"] = timeNow;
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_LmUser"] = this.hzyMessage.User_Name;
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_DIVI"] = m_hzyMessage.Env_SN;
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ColorGroup"] = "C-A";
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_UpLoad"] = "0";
                    dsCreatDS.Tables["dtST2"].Columns.Add("ST2_UptNo");
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_UptNo"] = "0";
                    dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RefSalePrice"] = ds.Tables["list"].Rows[0]["ST2_RefSalePrice"].ToString();

                    bool bResult;
                    ArrayList listKey = new ArrayList();
                    listKey.Add("ST1_ID");

                    conn.BeginTransaction(); // 开启事务
                    bResult = conn.Insert("B01_MDM.ST2_StyleColor", dsCreatDS.Tables["dtST2"]);//增加styleColor数据
                    if (bResult)
                    {
                        bResult = conn.Update("B01_MDM.ST1_Style", dsCreatDS.Tables["dtST1"], listKey);//修改style数据
                    }
                    if (bResult)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "新增成功" });
                        dt_EditResult.Rows.Add(new object[] { "ST1_ID", strST1 });
                        dt_EditResult.Rows.Add(new object[] { "ST2_ID", strST2 });
                        conn.CommitTransaction();   //提交事务
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { false, "新增失败" });
                        conn.RollbackTransaction();
                    }
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "相同款号,吊牌价必须相同" });
                }

            }
            else if (st1_count != 0 && st2_count != 0)  //修改
            {
                //俞佳伟 2015-07-21 控制相同款号 吊牌价必须相同
                //                string sqlSalePrice = @"
                //                   SELECT  COUNT(ST2_SalePrice) NCOUNT, AVG(ST2_SalePrice) ST2_SalePrice FROM [B01_MDM].[ST2_StyleColor] WITH(NOLOCK)
                //                   WHERE ST2_ST1_StyleCode = '" + strStyCode + "' AND ST2_DIVI='" + m_hzyMessage.Env_SN + "'";
                //                DataTable DTSalePrice = conn.GetDataTable(sqlSalePrice);
                //                if (Convert.ToInt32(DTSalePrice.Rows[0]["NCOUNT"].ToString()) == 1)
                //                {

                DataSet dsCreatDS = CreatTab();            //创建具有表头的DataSet
                //修改Style表
                //删除不能修改的字段
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_BrandID");
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_ProductLine");
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_SupplierCode");
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_Season");
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_Years");
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_Category");
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_LargeClass");
                if (m_hzyMessage.Env_SN != "GL")
                {
                    dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_SmallClass");
                }
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_FabricComponent");
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_BR1_BrandCode");
                dsCreatDS.Tables["dtST1"].Columns.Remove("ST1_StyleCode");

                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ID"] = strST1;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SupperierStyle"] = ds.Tables["list"].Rows[0]["st1_supperierstyle"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Series"] = ds.Tables["list"].Rows[0]["ST1_Series"].ToString();   //系列跟风格线字段修改成ST1_Series,ST1_StyleLine
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_StyleLine"] = ds.Tables["list"].Rows[0]["ST1_StyleLine"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ComModity"] = ds.Tables["list"].Rows[0]["ST1_ComModity"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Unit"] = ds.Tables["list"].Rows[0]["ST1_Unit"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Grade"] = ds.Tables["list"].Rows[0]["ST1_Grade"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Currency"] = ds.Tables["list"].Rows[0]["ST1_Currency"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Provenance"] = ds.Tables["list"].Rows[0]["ST1_Provenance"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Standard"] = ds.Tables["list"].Rows[0]["ST1_Standard"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SafeTechnology"] = ds.Tables["list"].Rows[0]["ST1_SafeTechnology"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmDt"] = timeNow;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_LmUser"] = this.hzyMessage.User_Name;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_DIVI"] = m_hzyMessage.Env_SN;
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Usedmethod"] = ds.Tables["list"].Rows[0]["ST1_Usedmethod"].ToString();   //添加使用方法
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Attention"] = ds.Tables["list"].Rows[0]["ST1_Attention"].ToString();     //注意事项
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_PermitNo"] = ds.Tables["list"].Rows[0]["ST1_PermitNo"].ToString();       //批准文号
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Fragrance"] = ds.Tables["list"].Rows[0]["ST1_Fragrance"].ToString();     //香味
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Netweight"] = ds.Tables["list"].Rows[0]["ST1_Netweight"].ToString();     //净含量
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_ProductDate"] = ds.Tables["list"].Rows[0]["ST1_ProductDate"].ToString(); //生产日期
                dsCreatDS.Tables["dtST1"].Rows[0]["ST1_Expiration"] = ds.Tables["list"].Rows[0]["ST1_Expiration"].ToString();   //保质期
                if (m_hzyMessage.Env_SN == "GL")
                {
                    dsCreatDS.Tables["dtST1"].Rows[0]["ST1_SmallClass"] = ds.Tables["list"].Rows[0]["ST1_SmallClass"].ToString(); //小类
                }

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
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_Ingredients"] = ds.Tables["list"].Rows[0]["ST2_Ingredients"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ImagePath"] = ds.Tables["list"].Rows[0]["ST2_ImagePath"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_State"] = ds.Tables["list"].Rows[0]["ST1_State"].ToString();
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_UpLoad"] = "0";
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_LmDt"] = timeNow;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_LmUser"] = this.hzyMessage.User_Name;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_DIVI"] = m_hzyMessage.Env_SN;
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_ColorGroup"] = "C-A";
                dsCreatDS.Tables["dtST2"].Columns.Remove("ST2_RgDt"); //更新的时候 删除创建人和创建时间字段
                dsCreatDS.Tables["dtST2"].Columns.Remove("ST2_RgUser");
                dsCreatDS.Tables["dtST2"].Rows[0]["ST2_RefSalePrice"] = ds.Tables["list"].Rows[0]["ST2_RefSalePrice"].ToString();

                bool bResult;
                conn.BeginTransaction(); // 开启事务
                ArrayList listKey = new ArrayList();
                listKey.Add("ST1_ID");
                bResult = conn.Update("B01_MDM.ST1_Style", dsCreatDS.Tables["dtST1"], listKey);//修改style数据
                if (bResult)
                {
                    //更新SKU表状态
                    string strUPT = @"UPDATE B01_MDM.ST3_StyleColorSize SET ST3_State='" + ds.Tables["list"].Rows[0]["ST1_State"].ToString()
                        + "' WHERE ST3_ST2_SKCCode='" + ds.Tables["list"].Rows[0]["ST2_SKCCode"].ToString() + "' AND ST3_DIVI='" + m_hzyMessage.Env_SN + "'";
                    conn.Excute(strUPT);

                    listKey.Remove("ST1_ID");
                    listKey.Add("ST2_ID");
                    bResult = conn.Update("B01_MDM.ST2_StyleColor", dsCreatDS.Tables["dtST2"], listKey);//增加styleColor数据
                }

                if (bResult)
                {

                    dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                    dt_EditResult.Rows.Add(new object[] { "ST1_ID", ds.Tables["list"].Rows[0]["ST1_ID"].ToString() });
                    dt_EditResult.Rows.Add(new object[] { "ST2_ID", ds.Tables["list"].Rows[0]["ST2_ID"].ToString() });
                    conn.CommitTransaction();   //提交事务

                    //2015-07-23 更新同款的吊牌价
                    string strUPT2 = @"UPDATE B01_MDM.ST2_StyleColor SET ST2_SalePrice=" + Convert.ToDecimal(ds.Tables["list"].Rows[0]["ST2_SalePrice"].ToString())
                        + " WHERE ST2_ST1_StyleCode='" + ds.Tables["list"].Rows[0]["ST2_ST1_StyleCode"].ToString() + "' AND ST2_DIVI='" + m_hzyMessage.Env_SN + "'";
                    conn.Excute(strUPT2);
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                    conn.RollbackTransaction();
                }
                //}
                //else
                //{
                //    dt_EditResult.Rows.Add(new object[] { false, "相同款号,吊牌价必须相同"  });
                //}
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
            dtST1.Columns.Add("ST1_Standard");
            dtST1.Columns.Add("ST1_Series"); //系列
            dtST1.Columns.Add("ST1_Attr02");
            dtST1.Columns.Add("ST1_SafeTechnology");
            dtST1.Columns.Add("ST1_IsPrint");
            dtST1.Columns.Add("ST1_State");
            dtST1.Columns.Add("ST1_LmDt");
            dtST1.Columns.Add("ST1_LmUser");
            dtST1.Columns.Add("ST1_StyleLine");
            dtST1.Columns.Add("ST1_Usedmethod");    //添加使用方法
            dtST1.Columns.Add("ST1_Attention");     //注意事项
            dtST1.Columns.Add("ST1_PermitNo");      //批准文号
            dtST1.Columns.Add("ST1_Fragrance");     //香味
            dtST1.Columns.Add("ST1_Netweight");     //净含量
            dtST1.Columns.Add("ST1_ProductDate");   //生产日期
            dtST1.Columns.Add("ST1_Expiration");    //保质期
            dtST1.Columns.Add("ST1_BrandID");
            dtST1.Columns.Add("ST1_FabricComponent"); //面料成分
            dtST1.Columns.Add("ST1_ProductLine"); //产品线
            //赋值
            dtST1.Rows[0]["ST1_ID"] = strGUID;
            dtST1.Rows[0]["ST1_CONO"] = "HYFG";
            dtST1.Rows[0]["ST1_IsPrint"] = 0;

            //StyleColor表
            dtST2.Columns.Add("ST2_ID");
            dtST2.Columns.Add("ST2_CONO");
            dtST2.Columns.Add("ST2_DIVI");
            dtST2.Columns.Add("ST2_ST1_StyleCode");
            dtST2.Columns.Add("ST2_SKCCode");
            dtST2.Columns.Add("ST2_Color");
            dtST2.Columns.Add("ST2_ColorGroup");
            dtST2.Columns.Add("ST2_SizeGroup");
            dtST2.Columns.Add("ST2_SupperierColor");
            dtST2.Columns.Add("ST2_SupperierSKC");
            dtST2.Columns.Add("ST2_PurchasePrice");
            dtST2.Columns.Add("ST2_SalePrice");
            dtST2.Columns.Add("ST2_RefSalePrice");
            dtST2.Columns.Add("ST2_Ingredients");
            dtST2.Columns.Add("ST2_ImagePath");
            dtST2.Columns.Add("ST2_State");
            dtST2.Columns.Add("ST2_RgDt");
            dtST2.Columns.Add("ST2_RgUser");
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
            dtST2.Rows[0]["ST2_CONO"] = "HYFG";
            //dtST2.Rows[0]["ST2_DIVI"] = strEVN;
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

        #region 生成SKU
        private void AddSKU()
        {
            bool bResult = true;
            string strEVN = m_hzyMessage.Env_SN;
            DataTable dtInsert = new DataTable(); //新增SKU表数据
            DataTable dtUpdate = new DataTable(); //修改SKU表数据
            DataTable dtST2 = new DataTable(); //2015-7-6 修改sku的时候  重置st2_upload=0

            dtInsert.Columns.Add("ST3_CONO");
            dtInsert.Columns.Add("ST3_DIVI");
            dtInsert.Columns.Add("ST3_ST1_StyleCode");
            dtInsert.Columns.Add("ST3_ST2_SKCCode");
            dtInsert.Columns.Add("ST3_SKUCode");
            dtInsert.Columns.Add("ST3_Size");
            dtInsert.Columns.Add("ST3_SupperierSize");
            dtInsert.Columns.Add("ST3_Spec");
            dtInsert.Columns.Add("ST3_State");
            dtInsert.Columns.Add("ST3_RgDt");
            dtInsert.Columns.Add("ST3_RgUser");
            dtInsert.Columns.Add("ST3_LmDt");
            dtInsert.Columns.Add("ST3_LmUser");


            dtUpdate.Columns.Add("ST3_ID");
            dtUpdate.Columns.Add("ST3_SupperierSize");
            dtUpdate.Columns.Add("ST3_Spec");
            dtUpdate.Columns.Add("ST3_LmUser");
            dtUpdate.Columns.Add("ST3_LmDt");

            dtST2.Columns.Add("ST2_CONO");
            dtST2.Columns.Add("ST2_DIVI");
            dtST2.Columns.Add("ST2_SKCCode");
            dtST2.Columns.Add("ST2_UpLoad");

            string strCheckSql = @"SELECT COUNT(oldclothingid) FROM [dbo].[j_clothing] WITH(NOLOCK) WHERE oldclothingid='";

            for (int i = 0; i < ds.Tables["list"].Rows.Count; i++)
            {
                if (ds.Tables["list"].Rows[i]["st3_id"].ToString() != "") //修改SKU表数据      
                {
                    DataRow upRow = dtUpdate.NewRow();
                    dtUpdate.Rows.Add(upRow);
                    dtUpdate.Rows[dtUpdate.Rows.Count - 1]["ST3_ID"] = ds.Tables["list"].Rows[i]["st3_id"].ToString();
                    dtUpdate.Rows[dtUpdate.Rows.Count - 1]["ST3_SupperierSize"] = ds.Tables["list"].Rows[i]["st3_supperiersize"].ToString();
                    dtUpdate.Rows[dtUpdate.Rows.Count - 1]["ST3_Spec"] = ds.Tables["list"].Rows[i]["st3_spec"].ToString();
                    dtUpdate.Rows[dtUpdate.Rows.Count - 1]["ST3_LmUser"] = ds.Tables["list"].Rows[i]["st3_lmuser"].ToString();
                    dtUpdate.Rows[dtUpdate.Rows.Count - 1]["ST3_LmDt"] = DateTime.Now;

                    DataRow drST2 = dtST2.NewRow();
                    drST2["ST2_CONO"] = "HYFG";
                    drST2["ST2_DIVI"] = strEVN;
                    //drST2["ST2_ST1_StyleCode"] = ds.Tables["list"].Rows[i]["st3_st1_stylecode"].ToString();
                    drST2["ST2_SKCCode"] = ds.Tables["list"].Rows[i]["st3_st2_skccode"].ToString();
                    drST2["ST2_UpLoad"] = "0";
                    dtST2.Rows.Add(drST2);
                }
                else  //新增SKU表数据
                {
                    string strCheck = "";
                    int nCount = 0;
                    if (strEVN.ToUpper() == "GL")
                    {
                        strCheck = strCheckSql + ds.Tables["list"].Rows[i]["st2_supperierskc"].ToString() + ds.Tables["list"].Rows[i]["st3_supperiersize"].ToString() + "'";
                        nCount = Convert.ToInt32(gl_conn.GetDataTableFirstValue(strCheck).ToString());
                    }
                    else if (strEVN.ToUpper() == "LX")
                    {
                        strCheck = strCheckSql + ds.Tables["list"].Rows[i]["st3_st2_skccode"].ToString() + ds.Tables["list"].Rows[i]["st3_size"].ToString() + "'";
                        nCount = Convert.ToInt32(lx_conn.GetDataTableFirstValue(strCheck).ToString());
                    }
                    else
                    {
                        strCheck = strCheckSql + ds.Tables["list"].Rows[i]["st3_st2_skccode"].ToString() + ds.Tables["list"].Rows[i]["st3_size"].ToString() + "'";
                        nCount = Convert.ToInt32(rs_conn.GetDataTableFirstValue(strCheck).ToString());
                    }
                    if (nCount == 0)
                    {
                        DataRow inRow = dtInsert.NewRow();
                        dtInsert.Rows.Add(inRow);
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_CONO"] = "HYFG";
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_DIVI"] = strEVN;
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_ST1_StyleCode"] = ds.Tables["list"].Rows[i]["st3_st1_stylecode"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_Size"] = ds.Tables["list"].Rows[i]["st3_size"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_SupperierSize"] = ds.Tables["list"].Rows[i]["st3_supperiersize"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_ST2_SKCCode"] = ds.Tables["list"].Rows[i]["st3_st2_skccode"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_SKUCode"] = ds.Tables["list"].Rows[i]["st3_st2_skccode"].ToString() + ds.Tables["list"].Rows[i]["st3_size"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_Spec"] = ds.Tables["list"].Rows[i]["st3_spec"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_State"] = ds.Tables["list"].Rows[i]["st3_state"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_RgUser"] = ds.Tables["list"].Rows[i]["st3_rguser"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_RgDt"] = DateTime.Now;
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_LmUser"] = ds.Tables["list"].Rows[i]["st3_rguser"].ToString();
                        dtInsert.Rows[dtInsert.Rows.Count - 1]["ST3_LmDt"] = DateTime.Now;
                    }
                    else
                    {
                        bResult = false;
                        break;
                    }
                }
            }
            if (bResult)
            {
                conn.BeginTransaction();
                bool bResultUP = true;
                bool bResultIN = true;
                if (dtUpdate.Rows.Count > 0 && dtUpdate.Rows[0]["ST3_ID"].ToString() != "")
                {
                    ArrayList listKey = new ArrayList();
                    listKey.Add("ST3_ID");
                    bResultUP = conn.Update("B01_MDM.ST3_StyleColorSize", dtUpdate, listKey);
                    //2015-7-6 yjw 更新st3表时  更新st2_upload=0
                    if (bResultUP)
                    {
                        ArrayList listST2 = new ArrayList();
                        listST2.Add("ST2_CONO");
                        listST2.Add("ST2_DIVI");
                        //listST2.Add("ST2_ST1_StyleCode");
                        listST2.Add("ST2_SKCCode");
                        bResultUP = conn.Update("B01_MDM.ST2_StyleColor", dtST2, listST2);
                    }
                }
                if (dtInsert.Rows.Count > 0 && dtInsert.Rows[0]["ST3_ST2_SKCCode"].ToString() != "")
                {
                    bResultIN = conn.Insert("B01_MDM.ST3_StyleColorSize", dtInsert);
                }

                if (bResultUP == true && bResultIN == true)
                {
                    dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                    conn.CommitTransaction();
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "修改失败" });
                    conn.RollbackTransaction();
                }
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "操作失败,供应商SKC已存在" });
            }

            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 删除SKU
        private void deleteSKU()
        {
            string strReturn = "";
            bool bResult = false;
            //获取SKU,验证采购单中是否存在.如果存在,不能删除;否则，则伪删除(状态字段为99)
            string strSQL = @"
                                SELECT COUNT(PO2_ID) 
                                FROM [Hawk].[B02_BILL].[PO2_PODetail] 
                                WHERE [PO2_PD1_ProductCode]='";
            DataTable dltDT = new DataTable();
            dltDT.Columns.Add("ST3_ID");
            dltDT.Columns.Add("ST3_State");

            for (int i = 0; i < ds.Tables["list"].Rows.Count; i++)
            {
                string strSKU = ds.Tables["list"].Rows[i]["st3_skucode"].ToString();
                int intCount = Convert.ToInt32(conn.GetDataTableFirstValue(strSQL + strSKU + "'").ToString());
                if (intCount == 0)  //采购单中没有此SKU
                {
                    DataRow dltRow = dltDT.NewRow();
                    dltDT.Rows.Add(dltRow);
                    dltDT.Rows[dltDT.Rows.Count - 1]["ST3_ID"] = ds.Tables["list"].Rows[i]["st3_id"].ToString();
                    //dltDT.Rows[dltDT.Rows.Count - 1]["ST3_State"] = "99";

                }
                else
                {
                    strReturn = strReturn + "," + strSKU;
                }
            }
            if (strReturn == "")
            {
                ArrayList aList = new ArrayList();
                aList.Add("ST3_ID");
                conn.BeginTransaction();
                bResult = conn.Delete("B01_MDM.ST3_StyleColorSize", dltDT, aList);
                conn.CommitTransaction();
            }
            else
            {
                bResult = false;
            }
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "删除成功" });
            }
            else
            {
                if (strReturn != "")
                {
                    dt_EditResult.Rows.Add(new object[] { false, "以下SKU：\n" + strReturn + "\n 已经生成采购单，不能删除" });
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "删除出现异常" });
                }
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 从EXCEL中批量导入商品信息,
        private void GetGoodsFromExcel()
        {
            DataTable excelTable = m_RequestBak.Tables[0];

            if (excelTable.Rows.Count > 0)
            {
                DataTable brandTable = GetDataTableFromDatabase("SELECT BR1_BrandCode FROM B01_MDM.BR1_Brand WITH(NOLOCK) WHERE BR1_State='20' AND BR1_DIVI='" + m_hzyMessage.Env_SN + "' ");
                DataTable supplierTable = GetDataTableFromDatabase("SELECT SP1_SupplierCode FROM B01_MDM.SP1_Supplier WITH(NOLOCK) WHERE SP1_State='20' AND SP1_DIVI='" + m_hzyMessage.Env_SN + "'");
                DataTable yearsTable = GetDataTableFromDatabase("SELECT CT1_KeyID,CT1_KeyName FROM M01_CONF.CT0_CSYTAB WITH(NOLOCK) WHERE CT1_CodeName='年份' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "'");
                DataTable seasonTable = GetDataTableFromDatabase("SELECT CT1_OptionsValues FROM M01_CONF.CT0_CSYTAB WHERE CT1_CodeName='季节' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "' ");
                DataTable categroyTable = GetDataTableFromDatabase("SELECT CT1_OptionsValues,CT1_Options FROM M01_CONF.CT0_CSYTAB WHERE CT1_CodeName='品类' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "'");
                DataTable largeclassTable = new DataTable();
                DataTable smallclassTable = new DataTable();
                if (m_hzyMessage.Env_SN == "GL")
                {
                    //雅斓 大类关联到款式类别
                    string strLarge_GL = @"SELECT A.CT1_OptionsValues,A.CT1_Options,B.CT1_OptionsValues CT1_KeyID,B.CT1_Options CT1_KeyName
                                            FROM M01_CONF.CT0_CSYTAB A WITH(NOLOCK) 
                                            JOIN M01_CONF.CT0_CSYTAB B WITH(NOLOCK) ON A.CT1_FatherID=B.CT1_ID AND B.CT1_Code='ITCL' AND A.CT1_Code='ITGR' 
                                            WHERE A.CT1_DIVI ='GL' AND A.CT1_State='20' AND B.CT1_State='20'";
                    largeclassTable = GetDataTableFromDatabase(strLarge_GL);

                    //雅斓  小类关联到大类 2015-07-28 小类不验证
                    //                    string strSmall_GL = @"SELECT A.CT1_OptionsValues,A.CT1_Options,B.CT1_OptionsValues CT1_KeyID,B.CT1_Options CT1_KeyName
                    //                                            FROM M01_CONF.CT0_CSYTAB A WITH(NOLOCK) 
                    //                                            JOIN M01_CONF.CT0_CSYTAB B WITH(NOLOCK) ON A.CT1_FatherID=B.CT1_ID AND B.CT1_Code='ITGR' AND A.CT1_Code='ITGL'
                    //                                            WHERE A.CT1_DIVI='GL' AND A.CT1_State='20' AND B.CT1_State='20'";
                    //                    smallclassTable = GetDataTableFromDatabase(strSmall_GL);
                }
                else //斓绣、斓居   小类关联到产品线
                {
                    largeclassTable = GetDataTableFromDatabase("SELECT CT1_OptionsValues FROM M01_CONF.CT0_CSYTAB WITH(NOLOCK) WHERE CT1_CodeName='大类' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "'");

                    string strSmall_RSLX = @"SELECT A.CT1_OptionsValues,A.CT1_Options,B.CT1_OptionsValues CT1_KeyID,B.CT1_Options CT1_KeyName
                                            FROM M01_CONF.CT0_CSYTAB A WITH(NOLOCK) 
                                            JOIN M01_CONF.CT0_CSYTAB B WITH(NOLOCK) ON A.CT1_FatherID=B.CT1_ID AND B.CT1_Code='PROL' AND A.CT1_Code='ITGL' 
                                            WHERE A.CT1_DIVI = '" + m_hzyMessage.Env_SN + "' AND A.CT1_State='20' AND B.CT1_State='20'";
                    smallclassTable = GetDataTableFromDatabase(strSmall_RSLX);
                }
                DataTable sizeTable = GetDataTableFromDatabase(@"SELECT A.CT1_OptionsValues SIZEGROUP,B.CT1_OptionsValues SIZE FROM M01_CONF.CT0_CSYTAB A WITH(NOLOCK)
                                                        LEFT JOIN M01_CONF.CT0_CSYTAB B WITH(NOLOCK) ON B.CT1_FatherID=A.CT1_ID
                                                        WHERE A.CT1_State='20' AND B.CT1_State='20' AND B.CT1_CodeName='尺码' AND A.CT1_DIVI='" + m_hzyMessage.Env_SN + "'");
                DataTable productLineTable = GetDataTableFromDatabase(@"SELECT CT1_OptionsValues FROM M01_CONF.CT0_CSYTAB WITH(NOLOCK) WHERE CT1_CodeName='产品线' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "'");
                DataTable fabriccomponentTable = GetDataTableFromDatabase(@"SELECT CT1_OptionsValues FROM M01_CONF.CT0_CSYTAB WITH(NOLOCK) WHERE CT1_CodeName='面料成分' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "'");
                DataTable materialTable = GetDataTableFromDatabase(@"SELECT CT1_OptionsValues FROM M01_CONF.CT0_CSYTAB WITH(NOLOCK) WHERE CT1_CodeName='面料块数' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "'");
                DataTable colorTable = GetDataTableFromDatabase(@"SELECT CT1_OptionsValues FROM M01_CONF.CT0_CSYTAB WITH(NOLOCK) WHERE CT1_CodeName='颜色' AND CT1_State='20' AND CT1_DIVI='" + m_hzyMessage.Env_SN + "'");

                DataTable st1Table = CreateTable("ST1_Style");
                DataTable st2Table = CreateTable("ST2_StyleColor");
                DataTable st3Table = CreateTable("ST3_StyleColorSize");
                DataTable errorLogTable = CreateTable("SI1_StyleInsert");

                //获取[SI1_StyleInsert] 最大编码
                string strGetMaxCode = @" SELECT RIGHT('00000000'+CONVERT(varchar(8),MAX(SI1_NO+1)),8) FROM [Hawk].[B01_MDM].[SI1_StyleInsert] WITH(NOLOCK)";
                string strMaxCode = conn.GetDataTableFirstValue(strGetMaxCode).ToString();

                for (int i = 0; i < excelTable.Rows.Count; i++)
                {
                    string strDIVI = ToDBC(excelTable.Rows[i]["事业体"].ToString().ToUpper());
                    string brandCode = ToDBC(excelTable.Rows[i]["品牌编码"].ToString().Trim()); //品牌
                    string supplierCode = ToDBC(excelTable.Rows[i]["供应商编号"].ToString().Trim()); //供应商
                    string yearName = ToDBC(excelTable.Rows[i]["年份"].ToString().Trim()); //年份
                    string categroyCode = ToDBC(excelTable.Rows[i]["类别"].ToString().Trim());//品类
                    string largeclassCode = ToDBC(excelTable.Rows[i]["品类编码"].ToString().Trim());//大类
                    string smallclassCode = ToDBC(excelTable.Rows[i]["小类"].ToString().Trim()); //小类
                    string materialCode = ToDBC(excelTable.Rows[i]["面料块数"].ToString().Trim()); //面料块数
                    string fabriccomponentCode = ToDBC(excelTable.Rows[i]["面料成分"].ToString().Trim());//面料成分
                    string colorCode = ToDBC(excelTable.Rows[i]["颜色"].ToString().Trim());//颜色
                    string productLineCode = ToDBC(excelTable.Rows[i]["产品线"].ToString().Trim()); //产品线
                    string sizeCode = ToDBC(excelTable.Rows[i]["尺码"].ToString().Trim());//尺码
                    string sizeGroupCode = ToDBC(excelTable.Rows[i]["尺码组"].ToString().Trim());//尺码组

                    string strError = "/";
                    bool result = true;

                    //检查必填字段是否有效
                    //0.excel 表中的事业体 不等于 登入人不插数据
                    if (strDIVI != m_hzyMessage.Env_SN)
                    {
                        result = false;
                        strError += "表中事业体与系统登录环境不同,无权导入";
                    }
                    else
                    {
                        //1.检查品牌
                        Result rltBrand = CheckData("品牌编码", brandCode, brandTable, "BR1_BrandCode='" + brandCode + "'");
                        if (!rltBrand.result)
                        {
                            result = false;
                            strError += "/" + rltBrand.message;
                        }
                        //2.检查供应商
                        Result rltSupplier = CheckData("供应商编号", supplierCode, supplierTable, "SP1_SupplierCode='" + supplierCode + "'");
                        if (!rltSupplier.result)
                        {
                            result = false;
                            strError += "/" + rltSupplier.message;
                        }
                        //3.检查年份
                        Result rltYear = CheckData("年份", yearName, yearsTable, "CT1_KeyName='" + yearName + "'");
                        if (!rltYear.result)
                        {
                            result = false;
                            strError += "/" + rltYear.message;
                        }
                        //4.检查季节
                        string seasonCode = excelTable.Rows[i]["季节"].ToString().Trim();
                        Result rltSeason = CheckData("季节", seasonCode, seasonTable, "CT1_OptionsValues='" + seasonCode + "'");
                        if (!rltSeason.result)
                        {
                            result = false;
                            strError += "/" + rltSeason.message;
                        }
                        //5.检查品类
                        Result rltCategroy = CheckData("类别", categroyCode, categroyTable, "CT1_OptionsValues='" + categroyCode + "'");
                        if (!rltBrand.result)
                        {
                            result = false;
                            strError += "/" + rltBrand.message;
                        }
                        //6.检查大类
                        Result rltLargeClass = CheckData("品类编码", largeclassCode, largeclassTable, "CT1_OptionsValues='" + largeclassCode + "'");
                        if (!rltLargeClass.result)
                        {
                            result = false;
                            strError += "/" + rltLargeClass.message;
                        }
                        //7.检查小类  雅斓小类关联到大类  斓绣、斓居关联到产品线
                        string strSmallJoin = "";
                        Result rltSmallClass;
                        if (m_hzyMessage.Env_SN == "GL")
                        {
                            strSmallJoin = largeclassCode;
                            rltSmallClass.value = "";
                        }
                        else
                        {
                            strSmallJoin = productLineCode;
                            rltSmallClass = CheckData("小类", smallclassCode, smallclassTable, "CT1_Options='" + smallclassCode + "' AND CT1_KeyID='" + strSmallJoin + "'");
                            if (!rltSmallClass.result)
                            {
                                result = false;
                                strError += "/" + rltSmallClass.message;
                            }
                        }

                        //8.检查面料块数
                        Result rltMaterial = CheckData("面料块数", materialCode, materialTable, "CT1_OptionsValues='" + materialCode + "'");
                        if (!rltMaterial.result)
                        {
                            result = false;
                            strError += "/" + rltMaterial.message;
                        }
                        //9.检查面料成分
                        Result rltFabriccomponent = CheckData("面料成分", fabriccomponentCode, fabriccomponentTable, "CT1_OptionsValues='" + fabriccomponentCode + "'");
                        if (!rltFabriccomponent.result)
                        {
                            result = false;
                            strError += "/" + rltFabriccomponent.message;
                        }
                        //10.检查颜色
                        Result rltColor = CheckData("颜色", colorCode, colorTable, "CT1_OptionsValues='" + colorCode + "'");
                        if (!rltColor.result)
                        {
                            result = false;
                            strError += "/" + rltColor.message;
                        }
                        //11.检查产品线
                        Result rltProductLine = CheckData("产品线", productLineCode, productLineTable, "CT1_OptionsValues='" + productLineCode + "'");
                        if (!rltProductLine.result)
                        {
                            result = false;
                            strError += "/" + rltProductLine.message;
                        }
                        //12.检查尺码
                        Result rltSize = CheckData("尺码", sizeCode, sizeTable, "SIZEGROUP='" + sizeGroupCode + "' AND SIZE='" + sizeCode + "'");
                        if (!rltSize.result)
                        {
                            result = false;
                            strError += "/" + rltSize.message;
                        }
                        //13.检查采购价、吊牌价、参考吊牌价
                        decimal decPurchasePrice = isNumber(excelTable.Rows[i]["采购价"].ToString().Trim());
                        decimal decSalePrice = isNumber(excelTable.Rows[i]["吊牌价"].ToString().Trim());
                        decimal decRefSalePrice = 0;

                        if (decPurchasePrice <= 0)
                        {
                            strError += "/" + "采购价不是有效的数字";
                            result = false;
                        }
                        if (decSalePrice <= 0)
                        {
                            strError += "/" + "吊牌价不是有效的数字";
                            result = false;
                        }
                        if (m_hzyMessage.Env_SN == "GL")
                        {
                            decRefSalePrice = decPurchasePrice * Convert.ToDecimal((1 + 0.17) * (1 + 0.16) * (1 + 0.05) * 3);
                        }
                        if (excelTable.Rows[i]["生产日期"].ToString().Trim() == "0001/1/1 0:00:00")
                        {
                            excelTable.Rows[i]["生产日期"] = DBNull.Value;
                        }

                        //必填字段 检查都正确  插入ST1 ST2 ST3
                        if (result)
                        {
                            //生成款号
                            string strStyleCode = "";
                            if (m_hzyMessage.Env_SN == "GL")
                            {
                                strStyleCode = "A" + productLineCode + rltYear.value + seasonCode + fabriccomponentCode + largeclassCode;
                            }
                            else if (m_hzyMessage.Env_SN == "LX")
                            {
                                strStyleCode = "L" + productLineCode + rltYear.value + seasonCode + fabriccomponentCode + "C" + rltSmallClass.value;
                            }
                            else
                            {
                                strStyleCode = "R" + productLineCode + rltYear.value + seasonCode + fabriccomponentCode + "C" + rltSmallClass.value;
                            }
                            string strStyleCodeMax = AutoKeyCode.GetMaxKeyCode("获取SKC最大号2", strStyleCode, m_hzyMessage.Env_SN, "", conn);
                            strStyleCodeMax += materialCode;

                            //根据供应商款号和款号 获取最大码
                            //插ST1表
                            DataRow drST1 = st1Table.NewRow();
                            drST1["ST1_CONO"] = "HYFG";
                            drST1["ST1_DIVI"] = strDIVI;
                            drST1["ST1_SupplierCode"] = supplierCode;
                            drST1["ST1_BR1_BrandCode"] = brandCode;
                            drST1["ST1_BrandID"] = excelTable.Rows[i]["Brandid"].ToString().Trim();
                            drST1["ST1_SupperierStyle"] = excelTable.Rows[i]["供应商款号"].ToString().Trim();
                            drST1["ST1_Years"] = yearName;
                            drST1["ST1_Season"] = seasonCode;
                            drST1["ST1_ComModity"] = excelTable.Rows[i]["品名"].ToString().Trim();
                            drST1["ST1_Unit"] = excelTable.Rows[i]["单位"].ToString().Trim();
                            drST1["ST1_Category"] = categroyCode;
                            drST1["ST1_LargeClass"] = largeclassCode;
                            drST1["ST1_SmallClass"] = smallclassCode;
                            drST1["ST1_Grade"] = "合格品";
                            drST1["ST1_Currency"] = excelTable.Rows[i]["结算币种"].ToString().Trim();
                            drST1["ST1_Provenance"] = excelTable.Rows[i]["原产地"].ToString().Trim();
                            //drST1["ST1_Ingredients"] = excelTable.Rows[i]["成份"].ToString().Trim();
                            drST1["ST1_Standard"] = excelTable.Rows[i]["执行标准"].ToString().Trim();
                            drST1["ST1_SafeTechnology"] = excelTable.Rows[i]["安全技术类别"].ToString().Trim();
                            drST1["ST1_IsPrint"] = "0";
                            drST1["ST1_State"] = "20";
                            drST1["ST1_RgDt"] = timeNow;
                            drST1["ST1_RgUser"] = m_hzyMessage.User_Name;
                            drST1["ST1_LmDt"] = timeNow;
                            drST1["ST1_LmUser"] = m_hzyMessage.User_Name;
                            drST1["ST1_UptNo"] = "0";
                            //drST1["ST1_GBCode"] = excelTable.Rows[i]["供应商编号"].ToString().Trim();
                            drST1["ST1_Series"] = excelTable.Rows[i]["系列"].ToString().Trim();
                            drST1["ST1_StyleLine"] = excelTable.Rows[i]["风格线"].ToString().Trim();
                            drST1["ST1_Usedmethod"] = excelTable.Rows[i]["使用方法"].ToString().Trim();
                            drST1["ST1_Attention"] = excelTable.Rows[i]["注意事项"].ToString().Trim();
                            drST1["ST1_PermitNo"] = excelTable.Rows[i]["批准文号"].ToString().Trim();
                            drST1["ST1_Fragrance"] = excelTable.Rows[i]["香味"].ToString().Trim();
                            drST1["ST1_Netweight"] = excelTable.Rows[i]["净含量"].ToString().Trim();
                            drST1["ST1_ProductDate"] = excelTable.Rows[i]["生产日期"].ToString().Trim();
                            drST1["ST1_Expiration"] = excelTable.Rows[i]["保质期"].ToString().Trim();
                            //drST1["ST1_Total"] = excelTable.Rows[i]["供应商编号"].ToString().Trim();
                            //drST1["ST1_Company"] = excelTable.Rows[i]["供应商编号"].ToString().Trim();
                            drST1["ST1_ProductLine"] = productLineCode;
                            drST1["ST1_FabricComponent"] = fabriccomponentCode;

                            if (st1Table.Select("ST1_StyleCode='" + strStyleCodeMax + "'").Length == 0)
                            {
                                drST1["ST1_StyleCode"] = strStyleCodeMax;
                                st1Table.Rows.Add(drST1);
                            }
                            else if (st1Table.Select("ST1_StyleCode='" + strStyleCodeMax + "' AND ST1_SupperierStyle='" + excelTable.Rows[i]["供应商款号"].ToString().Trim() + "'").Length == 0)
                            {
                                string maxCode = st1Table.Rows[st1Table.Rows.Count - 1]["ST1_StyleCode"].ToString();
                                if (strDIVI == "GL")
                                {
                                    strStyleCodeMax = maxCode.Substring(0, 6) + (Convert.ToInt32(maxCode.Substring(6, 3)) + 1).ToString("000");
                                }
                                else
                                {
                                    strStyleCodeMax = maxCode.Substring(0, 7) + (Convert.ToInt32(maxCode.Substring(7, 2)) + 1).ToString("00");
                                }
                                strStyleCodeMax += materialCode;
                                drST1["ST1_StyleCode"] = strStyleCodeMax;
                                st1Table.Rows.Add(drST1);
                            }
                            else
                            {
                                //存在相同款号和相同供应商款号  不插ST1表
                            }

                            //插st2 表
                            if (st2Table.Select("ST2_SKCCode='" + strStyleCodeMax + colorCode + "'").Length == 0)
                            {
                                DataRow drST2 = st2Table.NewRow();
                                drST2["ST2_CONO"] = "HYFG";
                                drST2["ST2_DIVI"] = strDIVI;
                                drST2["ST2_ST1_StyleCode"] = strStyleCodeMax;
                                drST2["ST2_SKCCode"] = strStyleCodeMax + colorCode;
                                drST2["ST2_Color"] = colorCode;
                                drST2["ST2_ColorGroup"] = "C-A";
                                drST2["ST2_SizeGroup"] = ToDBC(excelTable.Rows[i]["尺码组"].ToString().Trim());
                                drST2["ST2_SupperierColor"] = ToDBC(excelTable.Rows[i]["供应商颜色"].ToString().Trim());
                                drST2["ST2_SupperierSKC"] = ToDBC(excelTable.Rows[i]["供应商SKC=款号+颜色"].ToString().Trim());
                                drST2["ST2_PurchasePrice"] = decPurchasePrice;
                                drST2["ST2_SalePrice"] = decSalePrice;
                                drST2["ST2_RefSalePrice"] = decRefSalePrice;
                                drST2["ST2_Ingredients"] = excelTable.Rows[i]["成份"].ToString().Trim();
                                drST2["ST2_ImagePath"] = "";
                                drST2["ST2_State"] = "20";
                                drST2["ST2_RgDt"] = timeNow;
                                drST2["ST2_RgUser"] = m_hzyMessage.User_Name;
                                drST2["ST2_LmDt"] = timeNow;
                                drST2["ST2_LmUser"] = m_hzyMessage.User_Name;
                                drST2["ST2_UptNo"] = "0";
                                drST2["ST2_UpLoad"] = "1";

                                st2Table.Rows.Add(drST2);
                            }
                            else
                            {
                                //存在相同SKC 不插ST2表
                            }
                            //插ST3表
                            if (st3Table.Select("ST3_SKUCode='" + strStyleCodeMax + colorCode + sizeCode + "'").Length == 0)
                            {
                                DataRow drST3 = st3Table.NewRow();
                                drST3["ST3_CONO"] = "HYFG";
                                drST3["ST3_DIVI"] = strDIVI;
                                drST3["ST3_ST1_StyleCode"] = strStyleCodeMax;
                                drST3["ST3_ST2_SKCCode"] = strStyleCodeMax + colorCode;
                                drST3["ST3_SKUCode"] = strStyleCodeMax + colorCode + sizeCode;
                                drST3["ST3_Size"] = sizeCode;
                                drST3["ST3_SupperierSize"] = ToDBC(excelTable.Rows[i]["供应商尺码"].ToString().Trim());
                                drST3["ST3_State"] = "20";
                                drST3["ST3_RgDt"] = timeNow;
                                drST3["ST3_RgUser"] = m_hzyMessage.Env_SN;
                                drST3["ST3_LmDt"] = timeNow;
                                drST3["ST3_LmUser"] = m_hzyMessage.Env_SN;
                                drST3["ST3_UptNo"] = "0";
                                drST3["ST3_Upload"] = "1";

                                st3Table.Rows.Add(drST3);
                            }
                            else
                            {
                                //存在相同SKU 不插ST3表
                            }
                        }
                        else  //插入SI1_StyleInsert
                        {
                            DataRow errorLogDR = errorLogTable.NewRow();
                            errorLogDR["SI1_NO"] = strMaxCode;
                            errorLogDR["SI1_Cono"] = excelTable.Rows[i]["环境"].ToString().Trim();
                            errorLogDR["SI1_Divi"] = excelTable.Rows[i]["事业体"].ToString().Trim();
                            errorLogDR["SI1_States"] = "20";
                            errorLogDR["SI1_RgUser"] = m_hzyMessage.User_Name;
                            errorLogDR["SI1_Rgdt"] = timeNow;
                            errorLogDR["SI1_BrandCode"] = brandCode;
                            errorLogDR["SI1_SupplierCode"] = ToDBC(excelTable.Rows[i]["供应商编号"].ToString().Trim()); ;
                            errorLogDR["SI1_Years"] = excelTable.Rows[i]["年份"].ToString().Trim();
                            errorLogDR["SI1_Season"] = excelTable.Rows[i]["季节"].ToString().Trim();
                            errorLogDR["SI1_SupperierStyle"] = excelTable.Rows[i]["供应商款号"].ToString().Trim();
                            errorLogDR["SI1_SupperierColor"] = ToDBC(excelTable.Rows[i]["供应商颜色"].ToString().Trim());
                            errorLogDR["SI1_SupperierSize"] = ToDBC(excelTable.Rows[i]["供应商尺码"].ToString().Trim());
                            errorLogDR["SI1_SupperierSKC"] = excelTable.Rows[i]["供应商SKC=款号+颜色"].ToString().Trim();
                            errorLogDR["SI1_Ingredients"] = excelTable.Rows[i]["成份"].ToString().Trim();
                            errorLogDR["SI1_ComM0dity"] = excelTable.Rows[i]["品名"].ToString().Trim();
                            errorLogDR["SI1_Category"] = excelTable.Rows[i]["类别"].ToString().Trim();
                            errorLogDR["SI1_LargeClass"] = excelTable.Rows[i]["品类编码"].ToString().Trim();
                            errorLogDR["SI1_SmallClass"] = excelTable.Rows[i]["小类"].ToString().Trim();
                            errorLogDR["SI1_Currency"] = excelTable.Rows[i]["结算币种"].ToString().Trim();
                            errorLogDR["SI1_PurchasePrice"] = excelTable.Rows[i]["采购价"].ToString().Trim();
                            errorLogDR["SI1_SalePrice"] = excelTable.Rows[i]["吊牌价"].ToString().Trim();
                            if (m_hzyMessage.Env_SN == "GL")
                            {
                                errorLogDR["SI1_RefSalePrice"] = decRefSalePrice;
                            }
                            errorLogDR["SI1_Unit"] = excelTable.Rows[i]["单位"].ToString().Trim();
                            errorLogDR["SI1_Provenance"] = excelTable.Rows[i]["原产地"].ToString().Trim();
                            errorLogDR["SI1_Color"] = colorCode;
                            errorLogDR["SI1_Size"] = excelTable.Rows[i]["尺码"].ToString().Trim();
                            errorLogDR["SI1_SizeGroup"] = excelTable.Rows[i]["尺码组"].ToString().Trim();
                            errorLogDR["SI1_Standard"] = excelTable.Rows[i]["执行标准"].ToString().Trim();
                            errorLogDR["SI1_SafeTechnology"] = excelTable.Rows[i]["安全技术类别"].ToString().Trim();
                            errorLogDR["SI1_Head"] = excelTable.Rows[i]["采购价"].ToString().Trim();
                            errorLogDR["SI1_Remark"] = strError;
                            errorLogDR["SI1_InsertStates"] = "失败";
                            errorLogDR["SI1_Series"] = excelTable.Rows[i]["系列"].ToString().Trim();
                            errorLogDR["SI1_StyleLine"] = excelTable.Rows[i]["风格线"].ToString().Trim();
                            errorLogDR["SI1_Usedmethod"] = excelTable.Rows[i]["使用方法"].ToString().Trim();
                            errorLogDR["SI1_Attention"] = excelTable.Rows[i]["注意事项"].ToString().Trim();
                            errorLogDR["SI1_PermitNo"] = excelTable.Rows[i]["批准文号"].ToString().Trim();
                            errorLogDR["SI1_Fragrance"] = excelTable.Rows[i]["采购价"].ToString().Trim();
                            errorLogDR["SI1_Netweight"] = excelTable.Rows[i]["净含量"].ToString().Trim();
                            errorLogDR["SI1_ProductDate"] = excelTable.Rows[i]["生产日期"].ToString().Trim();
                            errorLogDR["SI1_Expiration"] = excelTable.Rows[i]["保质期"].ToString().Trim();
                            errorLogDR["SI1_BrandID"] = excelTable.Rows[i]["Brandid"].ToString().Trim();
                            errorLogDR["SI1_ProductLine"] = excelTable.Rows[i]["产品线"].ToString().Trim();
                            errorLogDR["SI1_FabricComponent"] = excelTable.Rows[i]["面料成分"].ToString().Trim();
                            errorLogDR["SI1_FabricNumber"] = excelTable.Rows[i]["面料块数"].ToString().Trim();

                            errorLogTable.Rows.Add(errorLogDR);
                        }
                    }
                }
                bool bResult = true;
                conn.BeginTransaction();
                if (st1Table.Rows.Count > 0 && bResult)
                {
                    bResult = conn.Insert("B01_MDM.ST1_Style", st1Table);
                }
                if (st2Table.Rows.Count > 0 && bResult)
                {
                    bResult = conn.Insert("B01_MDM.ST2_StyleColor", st2Table);
                }
                if (st3Table.Rows.Count > 0 && bResult)
                {
                    bResult = conn.Insert("B01_MDM.ST3_StyleColorSize", st3Table);
                }
                if (errorLogTable.Rows.Count > 0 && bResult)
                {
                    bResult = conn.Insert("B01_MDM.SI1_StyleInsert", errorLogTable);
                }


                //操作结果判断
                if (bResult)
                {
                    if (errorLogTable.Rows.Count == 0)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "数据导入成功" });
                    }
                    else if (errorLogTable.Rows.Count > 0 && errorLogTable.Rows.Count < excelTable.Rows.Count)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, errorLogTable.Rows.Count + "条数据导入失败" });
                    }
                    else
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "数据无法导入,请检查..." });
                    }
                    conn.CommitTransaction();
                }
                else
                {
                    dt_EditResult.Rows.Add(new object[] { false, "数据导入失败" });
                    conn.RollbackTransaction();
                }
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "无数据可导入" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }

        #endregion

        #region GetDataTableFromDatabase 从数据库中获取数据
        /// <summary>
        /// GetDataTableFromDatabase 从数据库中获取数据
        /// </summary>
        /// <param name="strSQL">SQL</param>
        /// <returns>DataTable</returns>
        private DataTable GetDataTableFromDatabase(string strSQL)
        {
            DataTable dt = conn.GetDataTable(strSQL);
            return dt;
        }
        #endregion

        #region 检查必填字段是否为空 && 基础数据是否正确
        private Result CheckData(string dataName, string strData, DataTable table, string strWhere)
        {
            Result rlt;
            if (strData == "")
            {
                rlt.result = false;
                rlt.message = dataName + "不允许为空";
                rlt.value = "";
            }
            else
            {
                DataRow[] rows = table.Select(strWhere);
                if (rows.Length == 0)
                {
                    rlt.result = false;
                    rlt.message = dataName + "基础数据不存在";
                    rlt.value = "";
                }
                else
                {
                    rlt.result = true;
                    rlt.message = "";
                    rlt.value = rows[0][0].ToString();
                }
            }
            return rlt;
        }
        #endregion

        #region 检查输入字符串是否为有效的数字
        /// <summary>
        /// 检查输入字符串是否为有效的数字
        /// </summary>
        /// <param name="strValue">输入字符串</param>
        /// <returns>0:表示不是一个有效的数字</returns>
        private decimal isNumber(string strValue)
        {
            decimal number = 0;
            try
            {
                number = Convert.ToDecimal(strValue);
            }
            catch (Exception ex)
            {
                number = 0;
            }
            return number;
        }

        #endregion

        public struct Result
        {
            public bool result;
            public string message;
            public string value;
        }

        private DataTable CreateTable(string tableName)
        {
            DataTable dt = new DataTable();
            if (tableName == "SI1_StyleInsert")
            {
                dt.Columns.Add("SI1_NO");
                dt.Columns.Add("SI1_Cono");
                dt.Columns.Add("SI1_Divi");
                dt.Columns.Add("SI1_States");
                dt.Columns.Add("SI1_RgUser");
                dt.Columns.Add("SI1_Rgdt");
                dt.Columns.Add("SI1_BrandCode");
                dt.Columns.Add("SI1_SupplierCode");
                dt.Columns.Add("SI1_Years");
                dt.Columns.Add("SI1_Season");
                dt.Columns.Add("SI1_SupperierStyle");
                dt.Columns.Add("SI1_SupperierColor");
                dt.Columns.Add("SI1_SupperierSize");
                dt.Columns.Add("SI1_SupperierSKC");
                dt.Columns.Add("SI1_Ingredients");
                dt.Columns.Add("SI1_ComM0dity");
                dt.Columns.Add("SI1_Category");
                dt.Columns.Add("SI1_LargeClass");
                dt.Columns.Add("SI1_SmallClass");
                dt.Columns.Add("SI1_Currency");
                dt.Columns.Add("SI1_PurchasePrice");
                dt.Columns.Add("SI1_SalePrice");
                dt.Columns.Add("SI1_RefSalePrice");
                dt.Columns.Add("SI1_Unit");
                dt.Columns.Add("SI1_Provenance");
                dt.Columns.Add("SI1_Color");
                dt.Columns.Add("SI1_Size");
                dt.Columns.Add("SI1_SizeGroup");
                dt.Columns.Add("SI1_Standard");
                dt.Columns.Add("SI1_SafeTechnology");
                dt.Columns.Add("SI1_Head");
                dt.Columns.Add("SI1_Remark");
                dt.Columns.Add("SI1_InsertStates");
                dt.Columns.Add("SI1_Series");
                dt.Columns.Add("SI1_StyleLine");
                dt.Columns.Add("SI1_Usedmethod");
                dt.Columns.Add("SI1_Attention");
                dt.Columns.Add("SI1_PermitNo");
                dt.Columns.Add("SI1_Fragrance");
                dt.Columns.Add("SI1_Netweight");
                dt.Columns.Add("SI1_ProductDate");
                dt.Columns.Add("SI1_Expiration");
                dt.Columns.Add("SI1_BrandID");
                dt.Columns.Add("SI1_ProductLine");
                dt.Columns.Add("SI1_FabricComponent");
                dt.Columns.Add("SI1_FabricNumber");
            }
            else if (tableName == "ST1_Style")
            {
                dt.Columns.Add("ST1_CONO");
                dt.Columns.Add("ST1_DIVI");
                dt.Columns.Add("ST1_StyleCode");
                dt.Columns.Add("ST1_SupplierCode");
                dt.Columns.Add("ST1_BR1_BrandCode");
                dt.Columns.Add("ST1_BrandID");
                dt.Columns.Add("ST1_SupperierStyle");
                dt.Columns.Add("ST1_Years");
                dt.Columns.Add("ST1_Season");
                dt.Columns.Add("ST1_ComModity");
                dt.Columns.Add("ST1_Unit");
                dt.Columns.Add("ST1_Category");
                dt.Columns.Add("ST1_LargeClass");
                dt.Columns.Add("ST1_SmallClass");
                dt.Columns.Add("ST1_Grade");
                dt.Columns.Add("ST1_Currency");
                dt.Columns.Add("ST1_Provenance");
                //dt.Columns.Add("ST1_Ingredients");
                dt.Columns.Add("ST1_Standard");
                dt.Columns.Add("ST1_SafeTechnology");
                dt.Columns.Add("ST1_IsPrint");
                dt.Columns.Add("ST1_State");
                //dt.Columns.Add("ST1_Attr01");
                //dt.Columns.Add("ST1_Attr02");
                //dt.Columns.Add("ST1_Attr03");
                //dt.Columns.Add("ST1_Attr04");
                //dt.Columns.Add("ST1_Attr05");
                dt.Columns.Add("ST1_RgDt");
                dt.Columns.Add("ST1_RgUser");
                dt.Columns.Add("ST1_LmDt");
                dt.Columns.Add("ST1_LmUser");
                dt.Columns.Add("ST1_UptNo");
                //dt.Columns.Add("ST1_GBCode");
                dt.Columns.Add("ST1_Series");
                dt.Columns.Add("ST1_StyleLine");
                dt.Columns.Add("ST1_Usedmethod");
                dt.Columns.Add("ST1_Attention");
                dt.Columns.Add("ST1_PermitNo");
                dt.Columns.Add("ST1_Fragrance");
                dt.Columns.Add("ST1_Netweight");
                dt.Columns.Add("ST1_ProductDate");
                dt.Columns.Add("ST1_Expiration");
                //dt.Columns.Add("ST1_Total");
                //dt.Columns.Add("ST1_Company");
                dt.Columns.Add("ST1_ProductLine");
                dt.Columns.Add("ST1_FabricComponent");
            }
            else if (tableName == "ST2_StyleColor")
            {
                dt.Columns.Add("ST2_CONO");
                dt.Columns.Add("ST2_DIVI");
                dt.Columns.Add("ST2_ST1_StyleCode");
                dt.Columns.Add("ST2_SKCCode");
                dt.Columns.Add("ST2_Color");
                dt.Columns.Add("ST2_ColorGroup");
                dt.Columns.Add("ST2_SizeGroup");
                dt.Columns.Add("ST2_SupperierColor");
                dt.Columns.Add("ST2_SupperierSKC");
                dt.Columns.Add("ST2_PurchasePrice");
                dt.Columns.Add("ST2_SalePrice");
                dt.Columns.Add("ST2_RefSalePrice");
                dt.Columns.Add("ST2_Ingredients");
                dt.Columns.Add("ST2_ImagePath");
                dt.Columns.Add("ST2_State");
                dt.Columns.Add("ST2_RgDt");
                dt.Columns.Add("ST2_RgUser");
                dt.Columns.Add("ST2_LmDt");
                dt.Columns.Add("ST2_LmUser");
                dt.Columns.Add("ST2_UptNo");
                dt.Columns.Add("ST2_UpLoad");
            }
            else if (tableName == "ST3_StyleColorSize")
            {
                dt.Columns.Add("ST3_CONO");
                dt.Columns.Add("ST3_DIVI");
                dt.Columns.Add("ST3_ST1_StyleCode");
                dt.Columns.Add("ST3_ST2_SKCCode");
                dt.Columns.Add("ST3_SKUCode");
                dt.Columns.Add("ST3_Size");
                dt.Columns.Add("ST3_SupperierSize");
                dt.Columns.Add("ST3_State");
                dt.Columns.Add("ST3_RgDt");
                dt.Columns.Add("ST3_RgUser");
                dt.Columns.Add("ST3_LmDt");
                dt.Columns.Add("ST3_LmUser");
                dt.Columns.Add("ST3_UptNo");
                dt.Columns.Add("ST3_Upload");
                //dt.Columns.Add("ST3_Check");
                //dt.Columns.Add("ST3_Spec");
            }
            return dt;
        }

        #region 全角转半角(控制EXCEL批量导入商品全角字符进入数据库)
        public static string ToDBC(string input)
        {
            char[] c = input.ToCharArray();
            for (int i = 0; i < c.Length; i++)
            {
                if (c[i] == 12288)
                {
                    c[i] = (char)32;
                    continue;
                }
                if (c[i] > 65280 && c[i] < 65375)
                    c[i] = (char)(c[i] - 65248);
            }
            return new string(c);
        }
        #endregion


        #endregion
    }
}
