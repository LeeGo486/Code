using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;
using System.Data;
using System.Text;

using HZY.COM;
using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using System.Collections;
using HZY.COM.Common.Base;

/// 类名：pbinfo
/// 类说明：PLMAS-产品-配置信息数据获取
/// 创建人：马卫清
/// 创建日期：2014-04-21
/// 修改人：马卫清
/// 修改日期：20140609
/// 修改内容：
/// 修改人：郭琦琦
/// 修改日期：20140703
/// 修改内容：增加获取特性选项(三层BOM下拉)
/// wsid:d763e76a-f7e0-4fbc-a2f2-9a9956ecccb9
namespace HZY.COM.WS.PLMAS
{

    public class pbinfo : HZYLogicBase, ILogicGetData
    {

        #region 构造函数
        public pbinfo()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region  全局变量
        private Dbconn conn;
        private Dbconn m_ConnErpAss = new Dbconn("ERPASS");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        DataSet m_Return = new DataSet();
        DataSet ds = new DataSet();
        #endregion

        #region GetData
        public DataSet GetData()
        {
            try
            {


                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dtOPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                var strzt = dtList.Rows[0]["zt"].ToString();//获取帐套

                conn = new Dbconn("PLM_AS_" + strzt);


                if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GET")
                {
                    //获取pbinfo里面的CBSTCO类型数据
                    Get(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETGROUP")
                {
                    //获取版师分组数据
                    GetGroup(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETOWNEDGROUP")
                {
                    //获取自己所属的版师分组
                    GetOwnedGroup(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetBrand".ToUpper())
                {
                    //获取品牌信息
                    GetBrand(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetPattern".ToUpper())
                {
                    //获取版师列表根据用户所在的品牌
                    GetPattern(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetPDReview".ToUpper())
                {
                    //获取图稿评审人
                    GetPDReview(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetOwnedBrand".ToUpper())
                {
                    //根据USERINFO表OwnedBrand字段判断品牌
                    GetOwnedBrand(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetDesigner".ToUpper())
                {
                    //根据USERINFO表OwnedBrand字段判断品牌
                    GetDesigner(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetCGSource".ToUpper())
                {
                    //获取采购来源配置
                    GetCGSource(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetBOM".ToUpper())
                {
                    //获取BOM操作权限
                    GetBOM(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetGX".ToUpper())
                {
                    //获取工序
                    GetGX(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetOptn".ToUpper())
                {
                    //获取特性选项(三层BOM下拉)
                    GetOptn(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetVerification".ToUpper())
                {
                    //获取特性选项(三层BOM下拉)(限定)
                    GetVerification(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetVerificationReplace".ToUpper())
                {
                    //获取特性选项(三层BOM下拉)(替代)
                    GetVerificationReplace(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetVerificationReplaceForTX".ToUpper())
                {
                    //获取特性选项(三层BOM下拉)(替代)
                    GetVerificationReplaceForTX(dtList);
                }

                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetVerificationReplaceForWLTX".ToUpper())
                {
                    //获取物料特性选项(三层BOM下拉)(替代)
                    GetVerificationReplaceForWLTX(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetVerificationReplaceForWLTXSub".ToUpper())
                {
                    //获取物料特性选项(三层BOM下拉)(替代)子表
                    GetVerificationReplaceForWLTXSub(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetVerificationReplaceForCYTXSub".ToUpper())
                {
                    //获取成衣特性选项(三层BOM下拉)(替代)子表
                    GetVerificationReplaceForCYTXSub(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "VerificationDelete".ToUpper())
                {
                    //设计师分配的时候是否能删除
                    VerificationDelete(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "UserPost".ToUpper())
                {
                    //是否管理员
                    UserPost(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "limitedftid".ToUpper())
                {
                    //限定特性组
                    limitedftid(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "getgroupxz".ToUpper())
                {
                    //打板成功率报表更改之后获取小组
                    getgroupxz(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GZLPLZX".ToUpper())
                {
                    //工作流批量执行小工具
                    GZLPLZX(dtList);
                }

                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETZYR".ToUpper())
                {
                    //获取制样人
                    GETZYR(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETCATEGORY".ToUpper())
                {
                    //获取品类
                    GetCategory(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETOUTOPERATION".ToUpper())
                {
                    //获取外发工序
                    GetOutOperation(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GETSAMPLEGROUP".ToUpper())
                {
                    //获取产品图层排序
                    GetSampleGroup(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetSortingGroup".ToUpper())
                {
                    //获取产品图层排序
                    GetSortingGroup(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetExecutive".ToUpper())
                {
                    //获取工作流节点执行人
                    GetExecutive(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetSubCategory".ToUpper())
                {
                    //获取工作流节点执行人
                    GetSubCategory(dtList);
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetSeasonToCombobox".ToUpper())
                {
                    GetSeasonToCombobox();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetBrandLineDiff".ToUpper()) //加载品牌产品线对照数据
                {
                    GetBrandLineDiff();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetFlexPLMSeason".ToUpper()) //加载FlexPLM季节数据接口
                {
                    GetFlexPLMSeason();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetBrandProductLine".ToUpper())
                {
                    GetBrandProductLine();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetBoDuanSeries".ToUpper())
                {
                    GetBoDuanSeries();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetExhibitGoodsDate".ToUpper())
                {
                    GetExhibitGoodsDate();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetProductPlan".ToUpper())
                {
                    GetProductPlan();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetUser".ToUpper())
                {
                    GetUser();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetProductPlanDataForTree".ToUpper())
                {
                    GetProductPlanDataForTree();
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetXiMaiApplication".ToUpper())
                {
                    GetXiMaiApplication(dtList);//洗唛申请人
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetStyleSeason".ToUpper())
                {
                    GetStyleSeason();  //获取款式季节
                }
                else if (dtOPTYPE.Rows[0][0].ToString().ToUpper() == "GetDetailDataForVODPCSR".ToUpper())
                {
                    GetDetailDataForVODPCSR();  //获取版师打版明细
                }
                return m_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;
            }
        }
        #endregion

        #region 内部函数

        #region Get 获取pbinfo里面的CBSTCO类型数据
        /// <summary> 
        /// 获取pbinfo里面的CBSTCO类型数据
        /// </summary>
        /// <param name="pdt"></param>
        private void Get(DataTable pdt)
        {
            string strCBSTCO = pdt.Rows[0]["CBSTCO"].ToString();

            if (strCBSTCO == "")
            {
                throw new Exception("传入的参数有误！");
            }

            string strSQL = @"
                                SELECT PLMKey,CBTX40 FROM pbinfo
                                WHERE CBSTCO=@Param0
                                                  ";
            m_Return = conn.GetDataSet(strSQL, new string[] { strCBSTCO });
        }
        #endregion

        #region GetGroup 获取版师分组数据
        /// <summary>
        /// 获取版师分组数据
        /// </summary>
        /// <param name="pdt"></param>
        private void GetGroup(DataTable pdt)
        {
            string strCBSTCO = pdt.Rows[0]["CBSTCO"].ToString();

            if (strCBSTCO == "")
            {
                throw new Exception("传入的参数有误！");
            }

            string strSQL = @"
                                SELECT  CBSTID,CBSTKY,CBTX40 FROM pbinfo
                                WHERE CBSTCO=@Param0
                ";

            if (strCBSTCO == "版师分组")
            {
                string strUserPost = conn.GetDataTableFirstValue(@"
                                                                        SELECT  UserPost
                                                                        FROM    Userinfo
                                                                        WHERE   username = @Param0
                                                                        ", new string[] { m_hzyMessage.User_Name }).ToString();

                if (strUserPost == "管理员")
                {
                }
                else if (strUserPost == "设计师" || strUserPost == "版师助理" || strUserPost == "版师")
                {
                    strSQL += @" AND CBSTKY IN (
                                SELECT OwnedBrand FROM Userinfo
                                WHERE username=@param1
                                )";
                }
                else
                {
                    strSQL += @" AND 1!=1";
                }

            }
            m_Return = conn.GetDataSet(strSQL, new string[] { strCBSTCO, m_hzyMessage.User_Name });
        }
        #endregion

        #region GetOwnedGroup 获取自己所属的版师分组
        /// <summary>
        /// 获取自己所属的版师分组
        /// </summary>
        /// <param name="pdt"></param>
        private void GetOwnedGroup(DataTable pdt)
        {
            string strSQL = @"
                                 SELECT OwnedGroup
                                 FROM   Userinfo
                                WHERE username=@param0 ";
            m_Return = conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion

        #region GetBrand 获取品牌信息
        /// <summary>
        /// 获取品牌信息
        /// </summary>
        /// <param name="pdt"></param>
        private void GetBrand(DataTable pdt)
        {
            string strSQL = @"SELECT DISTINCT CBTX40,CBTX40 FROM PBINFO WHERE CBSTCO='品牌产品线对照' AND CBSTAT = 1";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion

        #region GetPattern 获取版师列表根据用户所在的品牌
        /// <summary>
        /// 获取版师列表根据用户所在的品牌
        /// </summary>
        /// <param name="pdt"></param>
        private void GetPattern(DataTable pdt)
        {
            string strBrand = pdt.Rows[0]["Brand"].ToString();

            if (strBrand.Length > 0)
            {
                strBrand = strBrand.Replace("/", "','");
            }
            //            string  strSQL = @"
            //                        SELECT CBTX40 AS UserNameC
            //                        FROM dbo.PBINFO T1
            //                        WHERE CBSTCO = '版师'
            //                        AND EXISTS ( 
            //                            SELECT 1 FROM dbo.USERINFO T2
            //                            WHERE  T1.CBTX15 = '" + strBrand + @"'
            //                            AND T2.username = @Param0 
            //                            )";
            string strSQL = @"
                        SELECT T2.OwnedCode
                             , T1.CBTX40 AS UserNameC
                        FROM dbo.PBINFO T1
                        LEFT JOIN USERINFO T2 ON T1.CBTX40 = T2.UserNameC
                        WHERE CBSTCO = '版师'
                        AND EXISTS ( 
                            SELECT 1 FROM dbo.USERINFO T3
                            WHERE  T1.CBTX15 = ( SELECT    CBTX40
                                          FROM      PBINFO
                                          WHERE     CBSTCO = '品牌产品线对照'
                                                    AND CBSTAT = 1
                                                    AND CBTX15 = '" + strBrand + @"'
                                        )
                            )";
            m_Return = conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion

        #region GetPDReview 获取图稿评审人
        /// <summary> 
        /// 获取图稿评审人
        /// </summary>
        /// <param name="pdt"></param>
        private void GetPDReview(DataTable pdt)
        {
            string DESERI;
            string tmpWhere = "";
            string strDEBRAN = pdt.Rows[0]["DEBRAN"].ToString();

            if (pdt.Columns.Contains("DESERI"))
            {
                DESERI = pdt.Rows[0]["DESERI"].ToString();
                tmpWhere = " AND DESERI = '" + DESERI + "'";
            }
            if (strDEBRAN == "")
            {
                throw new Exception("传入的参数有误！");
            }

            string strSQL = @"
                             SELECT DESERI ,
                                    DERWPE
                             FROM   dbo.PDReview
                             WHERE  DEBRAN =  @Param0 ";
            m_Return = conn.GetDataSet(strSQL + tmpWhere, new string[] { strDEBRAN });
        }
        #endregion

        #region GetOwnedBrand 根据USERINFO表OwnedBrand字段判断品牌
        /// <summary>
        /// 根据USERINFO表OwnedBrand字段判断品牌
        /// </summary>
        /// <param name="pdt"></param>
        private void GetOwnedBrand(DataTable pdt)
        {
            string strUserName = hzyMessage.User_Name,
                   strSQL = @"SELECT OwnedBrand FROM Userinfo WHERE username='" + strUserName + "'",
                   strOwnerBnd = conn.GetDataTableFirstValue(strSQL).ToString(),
                   pattern = @"(^\w+)/";
            if (strOwnerBnd.Length > 0)
            {
                foreach (Match match in Regex.Matches(strOwnerBnd, pattern, RegexOptions.IgnoreCase))
                    strOwnerBnd = match.Groups[1].Value;
            }

            dt_EditResult.Rows.Add(new object[] { true, strOwnerBnd });

            m_Return.Tables.Add(dt_EditResult);

        }
        #endregion

        #region GetDesigner 根据USERINFO表抽取板师
        /// <summary>
        /// 根据USERINFO表抽取板师
        /// </summary>
        /// <param name="pdt"></param>
        private void GetDesigner(DataTable pdt)
        {
            string strOwnBrand = ds.Tables["list"].Rows[0]["OwnBrand"].ToString();

            string strSQL = @"SELECT DISTINCT username,CBTX40 
                                FROM PBINFO WITH(NOLOCK)
                                LEFT JOIN dbo.USERINFO WITH(NOLOCK) ON CBTX40=UserNameC AND CBSTCO='设计师' 
                                WHERE CBSTCO='设计师'  AND CBSTKY = '" + strOwnBrand + "'";
            //
            //                              SELECT  usernamec usernamec1,usernamec
            //                              FROM    dbo.USERINFO
            //                              WHERE   UserPost like '版师%'
            //                                        AND OwnedBrand IN ( SELECT  OwnedBrand
            //                                                            FROM    USERINFO
            //                                                            WHERE   username = @param0
            //                                                                    )";
            m_Return = conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion

        #region GetCGSource 获取采购来源配置
        /// <summary> 
        /// 获取采购来源配置
        /// </summary>
        /// <param name="pdt"></param>
        private void GetCGSource(DataTable pdt)
        {
            string strPLMKey = pdt.Rows[0]["PLMKey"].ToString();

            if (strPLMKey == "")
            {
                throw new Exception("传入的参数有误！");
            }

            string strSQL = @"
                            SELECT CBTX40,CBTX15 FROM dbo.PBINFO
                            WHERE cbstco='采购来源配置'
                            AND PLMKey = (select CBTX40 from PBINFO where CBSTCO='品牌产品线对照' and CBTX15 = @Param0)
                            AND CBSTKY='自主研发'    ";
            m_Return = conn.GetDataSet(strSQL, new string[] { strPLMKey });
        }
        #endregion

        #region GetBOM 获取BOM权限
        /// <summary> 
        /// 获取BOM权限
        /// </summary>
        /// <param name="pdt"></param>
        private void GetBOM(DataTable pdt)
        {
            string strSQL = @"
                            SELECT  COUNT(*) num
                            FROM    USERINFO
                            WHERE   UserPost = '产品结构组'
                                    AND username = @param0  ";
            m_Return = conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion

        #region 获取工序
        /// <summary> 
        /// 获取工序
        /// </summary>
        /// <param name="pdt"></param>
        private void GetGX(DataTable pdt)
        {
            string strSQL = @"
                            SELECT  CBSTKY CBSTKY1 ,CBSTKY ,cbtx40 FROM dbo.PBINFO 
                                    WHERE CBSTCO = '工序'  ";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion

        #region 获取特性选项(三层BOM下拉)
        /// <summary> 
        /// 获取特性选项(三层BOM下拉)
        /// </summary>
        /// <param name="pdt"></param>
        private void GetOptn(DataTable pdt)
        {
            string strSQL = @"
                             SELECT CBSTKY CBSTKY1,CBSTKY  FROM dbo.PBINFO
                                    WHERE CBSTCO = '面辅料颜色'  ";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion

        #region 验证M3编号是否有权限限定
        /// <summary> 
        /// 获取特性选项(验证M3编号是否有权限限定)
        /// </summary>
        /// <param name="pdt"></param>
        private void GetVerification(DataTable pdt)
        {
            var strE14IMS045BA = pdt.Rows[0]["MM1_ITNO"].ToString();
            var strPM1_PRNO = pdt.Rows[0]["PM1_PRNO"].ToString();
            string strSQL = @"
                            SELECT  COUNT(*) isoron
                            FROM    [B01_MDM].[MITMAS]
                            WHERE   MMITNO =@Param0
                                    AND MMCHCD = '3'
                                    AND EXISTS ( SELECT 1
                                                    FROM   B01_MDM.PM1_MPDMAT
                                                    WHERE  PM1_PRNO =@Param1 ) ";
            m_Return = conn.GetDataSet(strSQL, new string[] { strE14IMS045BA, strPM1_PRNO });
        }
        #endregion

        #region 验证M3编号是否有权限替代
        /// <summary> 
        /// 获取特性选项(验证M3编号是否有权限限定替代)
        /// </summary>
        /// <param name="pdt"></param>
        private void GetVerificationReplace(DataTable pdt)
        {
            var strMM1_ITNO = pdt.Rows[0]["MM1_ITNO"].ToString();
            var strPM1_PRNO = pdt.Rows[0]["PM1_PRNO"].ToString();
            string strSQL = @"
                            SELECT  COUNT(*) isoron
                            FROM    [B01_MDM].[MITMAS]
                            WHERE   MMITNO =@Param0
                                    AND MMCHCD = '2'
                                    AND EXISTS ( SELECT 1
                                                    FROM   B01_MDM.PM1_MPDMAT
                                                    WHERE  PM1_PRNO =@Param1 ) ";
            m_Return = conn.GetDataSet(strSQL, new string[] { strMM1_ITNO, strPM1_PRNO });
        }
        #endregion

        #region 验证M3编号是否有权限替代
        /// <summary> 
        /// 获取特性选项(验证M3编号是否有权限限定替代)成衣特性
        /// </summary>
        /// <param name="pdt"></param>
        private void GetVerificationReplaceForTX(DataTable pdt)
        {
            var strOrderSeason = pdt.Rows[0]["OrderSeason"].ToString();
            var strMeasurementsId = pdt.Rows[0]["MeasurementsId"].ToString();
            var strCBSTKY = pdt.Rows[0]["CBSTKY"].ToString();

            string strBrand = conn.GetDataTableFirstValue(" SELECT  Brand  FROM    FLEXPLMProduct WHERE  OrderSeason =" + "'" + strOrderSeason + "'  and MeasurementsId ='" + strMeasurementsId + "'").ToString();
            string strCategory = conn.GetDataTableFirstValue(" SELECT  Category  FROM    FLEXPLMProduct WHERE  OrderSeason =" + "'" + strOrderSeason + "'  and MeasurementsId ='" + strMeasurementsId + "'").ToString();
            strCategory = strCategory.Substring(2);
            string strSQL = @"
                            SELECT  PLMKey
                            FROM    PBINFO a
                            WHERE   a.CBSTCO LIKE '%特性%'
                                    AND a.CBSTKY = '" + strCBSTKY + @"'
                                    AND CBSTCO LIKE '%" + strBrand + "%' AND  CBTX40 LIKE '%" + strCategory + "%'";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion

        #region  获取物料特性选项(三层BOM下拉)(替代)
        /// <summary> 
        ///  //获取物料特性选项(三层BOM下拉)(替代)
        /// </summary>
        /// <param name="pdt"></param>
        private void GetVerificationReplaceForWLTX(DataTable pdt)
        {
            var strHUSTYN = pdt.Rows[0]["hustyn"].ToString();
            string strSQL = @"
                                    SELECT  PEFGRP,HUFTID
                                    FROM    B01_MDM.MMODFE
                                            LEFT JOIN B01_MDM.MPDFHE ON HUFTID = PEFTID
                                    WHERE   HUSTYN = @Param0 
                            ";
            m_Return = conn.GetDataSet(strSQL, new string[] { strHUSTYN });
        }

        #endregion

        #region  获取物料特性选项(三层BOM下拉)(替代)子表
        /// <summary> 
        ///  //获取物料特性选项(三层BOM下拉)(替代)子表
        /// </summary>
        /// <param name="pdt"></param>
        private void GetVerificationReplaceForWLTXSub(DataTable pdt)
        {
            var dyyyno = pdt.Rows[0]["dyyyno"].ToString();
            var strhm1_mseq = pdt.Rows[0]["hm1_mseq"].ToString();
            var strhmftiy = pdt.Rows[0]["hmftiy"].ToString();
            var strhmitno = pdt.Rows[0]["hmitno"].ToString();
            var strhmftiyqx = strhmftiy.Substring(0, 1).ToUpper();//权限S或者Y

            //select hm1_mopt from B01_MDM.HM1_MSUBTO where HM1_MSEQ=25 and HM1_YYNO='NRO5037-2'

            string strHMOPTX = conn.GetDataTableFirstValue(@"
            SELECT  hm1_mopt FROM    B01_MDM.HM1_MSUBTO WHERE   HM1_MSEQ = '" + strhm1_mseq + "' AND HM1_YYNO = '" + dyyyno + "'").ToString();
            var strZuoHou = "";
            if (strHMOPTX != "")
            {
                strZuoHou = strHMOPTX.Substring(strHMOPTX.Length - 1, 1).ToUpper();

            }
            else
            {
                strZuoHou = strZuoHou.ToUpper();
            }
            //如果返回是空的,则返回所有数据,如果不是空的返回特定数据

            string strSQL = "";

            if (strhmftiyqx == "S")
            {
                if (strZuoHou == "" || strZuoHou == "X")
                {
                    strSQL = @"
                            SELECT  DISTINCT  hmoptx,hmoptx hmoptx1
                                FROM    B01_MDM.MITMAH
                                WHERE   hmftix =@Param0 
                                        AND hmitno LIKE '%" + strhmitno + "%' ORDER BY hmoptx ";
                }

                else
                {
                    strSQL = @"
                            SELECT  DISTINCT  hmoptx,hmoptx hmoptx1
                                FROM    B01_MDM.MITMAH
                                WHERE   hmftix =@Param0 
                                            AND hmitno LIKE '%" + strhmitno + "%' AND HMOPTY  = '" + strHMOPTX + "'  ORDER BY hmoptx ";
                }
            }
            else
            {
                if (strZuoHou == "" || strZuoHou == "Y")
                {
                    strSQL = @"
                            SELECT DISTINCT hmopty,hmopty hmopty1
                            FROM    B01_MDM.MITMAH
                            WHERE   hmftiy =@Param0 
                                    AND hmitno LIKE '%" + strhmitno + "%' ORDER BY hmopty ";
                }
                else
                {
                    strSQL = @"
                            SELECT  DISTINCT
                                    hmopty ,
                                    hmopty hmopty1
                            FROM    B01_MDM.MITMAH
                            WHERE   HMFTIY = @Param0
                                    AND hmitno LIKE '%" + strhmitno + "%' AND HMOPTX  = '" + strHMOPTX + "'  ORDER BY hmopty ";
                }
            }

            m_Return = conn.GetDataSet(strSQL, new string[] { strhmftiy });
        }
        #endregion

        #region    获取成衣特性选项(三层BOM下拉)(替代)子表
        /// <summary> 
        ///    //获取成衣特性选项(三层BOM下拉)(替代)子表
        /// </summary>
        /// <param name="pdt"></param>
        private void GetVerificationReplaceForCYTXSub(DataTable pdt)
        {
            var strDYYYNO = pdt.Rows[0]["dyyyno"].ToString();
            string strSQL = @"
                            SELECT  LEFT(DYCOLORName, 1) + 'AY' DYCOLORName
                            FROM    pdyinf
                            WHERE   DYYYNO =@Param0
                                    ";
            m_Return = conn.GetDataSet(strSQL, new string[] { strDYYYNO });
        }
        #endregion

        #region    设计师分配的时候是否能删除
        /// <summary> 
        ///    //设计师分配的时候是否能删除
        /// </summary>
        /// <param name="pdt"></param>
        private void VerificationDelete(DataTable pdt)
        {
            var strorderseason = pdt.Rows[0]["orderseason"].ToString();
            var strdesignerid = pdt.Rows[0]["designerid"].ToString();
            string strSQL = @"
                            SELECT  stat
                            FROM    dbo.PMINFO a
                            WHERE   EXISTS ( SELECT 1
                                                FROM   dbo.FLEXPLMProduct
                                                WHERE  DesignerId = @Param0
                                                    AND OrderSeason =@Param1
                                                    AND a.ProductName = ProductName )
                                    ";
            m_Return = conn.GetDataSet(strSQL, new string[] { strdesignerid, strorderseason });
        }
        #endregion


        #region    是否管理员
        /// <summary> 
        ///    //是否管理员
        /// </summary>
        /// <param name="pdt"></param>
        private void UserPost(DataTable pdt)
        {

            string strSQL = @"
                    SELECT  UserPost
                    FROM    Userinfo
                    WHERE   username = @Param0
                                    ";
            m_Return = conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion


        #region    限定特性组
        /// <summary> 
        ///    //限定特性组
        /// </summary>
        /// <param name="pdt"></param>
        private void limitedftid(DataTable pdt)
        {
            var strMeasurementsidJ = pdt.Rows[0]["MeasurementsidJ"].ToString();

            string strSQL = @"
                    SELECT  PLMKey 
                    FROM    PBINFO
                    WHERE   CBSTCO = 'EP品类特性对应'
                            AND CBSTKY = 'Y'
                            AND CBTX40 = ( SELECT   SUBSTRING(Category, 3, 4)
                                           FROM     FLEXPLMProduct
                                           WHERE    MeasurementsId = @Param0
                                         )
                                    ";
            m_Return = conn.GetDataSet(strSQL, new string[] { strMeasurementsidJ });
        }
        #endregion

        #region    //打板成功率报表更改之后获取小组
        /// <summary> 
        ///打板成功率报表更改之后获取小组
        /// </summary>
        /// <param name="pdt"></param>
        private void getgroupxz(DataTable pdt)
        {
            string strSQL = @"
                   SELECT CBSTKY,CBTX15 ,CBRCID FROM dbo.PBINFO
                          WHERE CBSTCO = '版师分组'";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion

        #region    //批量操作
        /// <summary> 
        ///批量操作
        /// </summary>
        /// <param name="pdt"></param>
        private void GZLPLZX(DataTable pdt)
        {
            string strSQL = @"
                 select top 200 FLEXPLMProduct.ProductName ,CGSource,dyfactory,Brand ,Designer,muser FROM FLEXPLMProduct left join PMINFO on FLEXPLMProduct.ProductName=PMINFO.ProductName
where RecDate<>'' and DeliverDate<>'' and CurWfName in('创建版型和缝制工艺并上载CAD文件')
and Year='2015'  AND  Brand = 'E.Prosper'";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion


        #region    //获取制样人
        /// <summary> 
        ///    //获取制样人
        /// </summary>
        /// <param name="pdt"></param>
        private void GETZYR(DataTable pdt)
        {
            var strBrand = pdt.Rows[0]["Brand"].ToString();
            string strSQL = @"
                            SELECT CBRCID
                                  ,CBTX40
                            FROM dbo.PBINFO t1
                            WHERE CBSTCO = '制样人'
                            AND EXISTS ( 
                                        SELECT 1 FROM dbo.USERINFO t2
                                        WHERE  t1.CBTX15 = '" + strBrand + @"'
                                        AND t2.username = @Param0 
                                        )";
            m_Return = conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion

        #region //获取品类
        /// <summary>
        ///     获取品类
        /// </summary>
        /// <param name="pdt"></param>
        private void GetCategory(DataTable pdt)
        {
            string strSQL = @"
                            SELECT CBTX15 + '.' + CBTX40 AS CATEGORY
                                FROM PBINFO 
                                WHERE CBSTCO='品类' AND CBTX15 IS NOT NULL 
                                ORDER BY CBSTID ";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion


        #region //确认样跟踪表获取外发工序
        /// <summary>
        /// 获取确认样跟踪表外发工序
        /// </summary>
        /// <param name="pdt"></param>
        private void GetOutOperation(DataTable pdt)
        {
            string strSQL = @"
                            SELECT CBTX40 
                            FROM PBINFO 
                            WHERE CBSTCO='确认样跟踪表外发工序'";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion

        #region //获取确认样跟踪表小组
        /// <summary>
        /// 获取确认样跟踪表小组
        /// </summary>
        /// <param name="pdt"></param>
        private void GetSampleGroup(DataTable pdt)
        {
            string strSQL = @"
                            SELECT CBTX40 
                            FROM PBINFO 
                            WHERE CBSTCO='确认样跟踪表小组'";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion

        #region //获取产品图层排序
        /// <summary>
        /// 获取产品图层排序
        /// </summary>
        /// <param name="pdt"></param>
        private void GetSortingGroup(DataTable pdt)
        {
            string strSQL = @"
                            SELECT*FROM (SELECT  CBSTCO ,
                                        CBSTID ,
                                        CBTX40 CBSTKY ,
                                        CBTX15
                                FROM    dbo.PBINFO
                                WHERE   CBSTCO IN ( '设计师' )

                                UNION ALL 
                                SELECT CBSTCO ,
                                        CBSTID ,
                                        CBSTKY  ,
                                        CBTX15
                                FROM    dbo.PBINFO
                                WHERE   CBSTCO IN (  '系列' )
                                ) t1 
                                ORDER BY t1.CBSTID
 ";
            m_Return = conn.GetDataSet(strSQL, new string[] { });
        }
        #endregion

        #region GetOwnedBrand
        private ArrayList GetOwnedBrand()
        {
            ArrayList OBrand_List = new ArrayList();

            string strUserName = hzyMessage.User_Name,
                   strSQL = @"SELECT OwnedBrand FROM Userinfo WHERE username='" + strUserName + "'",
                   strOwnerBnd = conn.GetDataTableFirstValue(strSQL).ToString(),
                   pattern = @"(\w+)/";
            if (strOwnerBnd.Length > 0)
            {
                foreach (Match match in Regex.Matches(strOwnerBnd, pattern, RegexOptions.IgnoreCase))
                    strOwnerBnd = match.Groups[1].Value;
            }

            return OBrand_List;
        }
        #endregion

        #region GetPattern 获取工作流节点执行人
        /// <summary>
        /// 获取工作流节点执行人
        /// </summary>
        /// <param name="pdt"></param>
        private void GetExecutive(DataTable pdt)
        {
            string strBrand = pdt.Rows[0]["Brand"].ToString();

            if (strBrand.Length > 0)
            {
                strBrand = strBrand.Replace("/", "','");
            }
            string strSQL = @"
                            SELECT  CBTX40
                            FROM    PBINFO
                            WHERE   CBTX15 = ( SELECT   CBTX40
                                               FROM     PBINFO
                                               WHERE    CBSTCO = '品牌产品线对照'
                                                        AND CBSTAT = 1
                                                        AND CBTX15 = '" + strBrand + @"'
                                             )
                                    AND CBSTCO = '版型任务指派人'
                                    AND CBSTAT = 1
                        ";
            m_Return = conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion

        #region GetSubCategory 获取子品类下拉列表
        /// <summary>
        /// 获取子品类下拉列表
        /// </summary>
        /// <param name="pdt"></param>
        private void GetSubCategory(DataTable pdt)
        {
            string CBTX15 = pdt.Rows[0]["CBTX15"].ToString();

            string strSQL = @"
                            SELECT  CBSTKY ,
                                    PLMKey ,
                                    CBTX40 ,
                                    CBTX15
                            FROM    PBINFO
                            WHERE   CBSTCO = '子品类'
                                    AND CBSTAT = 1
                                    AND CBTX15 = '" + CBTX15 + "'";
            m_Return = conn.GetDataSet(strSQL, new string[] { hzyMessage.User_Name });
        }
        #endregion

        #region 加载FlexPLM季节数据接口
        private void GetFlexPLMSeason()
        {
            string strSQL = @"SELECT CBSTKY
                                    ,PLMKey
                                    ,CBTX15
                                    ,CBTX40 
                              FROM PBINFO 
                              WHERE CBSTCO = 'FlexPLM季节' AND CBSTAT = 1 AND CBTX15>2015 " + m_hzyPageInfo.Where;
            m_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 加载品牌产品线对照数据
        private void GetBrandLineDiff()
        {
            string strSQL = @"SELECT CBSTKY
                                    ,PLMKey
                                    ,CBTX15
                                    ,CBTX40
                              FROM PBINFO WHERE CBSTCO = '品牌产品线对照' AND CBSTAT = 1 " + m_hzyPageInfo.Where;
            m_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取订货会季节下拉数据
        private void GetSeasonToCombobox()
        {
            string strSQL = @"SELECT CBTX40 FROM PBINFO WHERE CBSTCO='FlexPLM季节' 
                              AND CBSTAT=1 AND CBTX15 > 2015 AND CBSTKY IN 
                                (SELECT DISTINCT CBTX40 FROM PBINFO WHERE CBSTCO = '品牌产品线对照' AND CBSTAT = 1)";
            m_Return = conn.GetDataSet(strSQL);

        }
        #endregion

        #region 加载品牌产品线数据调
        private void GetBrandProductLine()
        {
            string strSQL = @"select distinct CBTX40,CBTX40 FROM PBINFO where CBSTCO='品牌' and CBSTAT=1";
            m_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 加载系列数据
        private void GetBoDuanSeries()
        {
            string strSQL = @"select distinct BoDuanSeries from FLEXPLMProduct where 1=1 " + m_hzyPageInfo.Where;
            m_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 加载上货日期数据
        private void GetExhibitGoodsDate()
        {
            string strSQL = @"select distinct Convert(varchar(10),BoDuan,120) BoDuan from FLEXPLMProduct where 1=1 " + m_hzyPageInfo.Where;
            m_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 加载商品企划数据
        private void GetProductPlan()
        {
            string strSQL = @" SELECT 
                                    Brand,
                                    Season,
                                    BoDuan ,
                                    StyleSeries ,
                                    Category ,
                                    PlaceHolderID ,
                                    DisplaySubCategory ,
                                    CostMultiplyingpower ,
                                    TargetCost ,
                                    PlanedRetailedPrice ,
                                    PlanedFabricCost ,
                                    A.UserID,
                                    UserNameC
                            FROM WsUserPower A WITH(NOLOCK)
                            LEFT JOIN dbo.USERINFO B WITH(NOLOCK) ON A.UserID=username
                            WHERE   PowerID = 'ProductLevel'
                                    AND StyleSeries NOT LIKE '%企划%' " + m_hzyPageInfo.Where;
            m_Return = conn.GetDataSet(strSQL);
        }

        #endregion

        #region
        private void GetProductPlanDataForTree()
        {
            string strSql = @"                                 
                                SELECT DISTINCT childName childNameID, childName,fatherName fatherNameID,fatherName FROM (
	                                SELECT '波段' childName,'-1' fatherName		                               
	                                FROM    WsUserPower WITH(NOLOCK)
	                                WHERE   PowerID = 'ProductLevel' AND StyleSeries NOT LIKE '%企划%'  
	                                UNION  
	                                SELECT BoDuan childName,'波段' fatherName		                               
	                                FROM    WsUserPower WITH(NOLOCK)
	                                WHERE   PowerID = 'ProductLevel' AND StyleSeries NOT LIKE '%企划%' " + m_hzyPageInfo.Where + @"
	                                UNION  
	                                SELECT StyleSeries  childName,BoDuan fatherName 		                                       
	                                FROM    WsUserPower WITH(NOLOCK)
	                                WHERE   PowerID = 'ProductLevel' AND StyleSeries NOT LIKE '%企划%' " + m_hzyPageInfo.Where + @"
	                                UNION 
	                                SELECT Category childName,StyleSeries fatherName 		                                
	                                FROM    WsUserPower WITH(NOLOCK)
	                                WHERE   PowerID = 'ProductLevel' AND StyleSeries NOT LIKE '%企划%' " + m_hzyPageInfo.Where + @") T 
	                                WHERE childName IS NOT NULL";
            m_Return = conn.GetDataSet(strSql);
        }
        #endregion

        #region 获取责任设计师
        private void GetUser()
        {
            string strSQL = @"  SELECT DISTINCT username,CBTX40 
                                FROM PBINFO WITH(NOLOCK)
                                LEFT JOIN dbo.USERINFO WITH(NOLOCK) ON CBTX40=UserNameC AND CBSTCO='设计师' 
                                WHERE CBSTCO='设计师' " + m_hzyPageInfo.Where;
            m_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取洗唛申请人
        private void GetXiMaiApplication(DataTable dt)
        {

            string strBrand
                = dt.Rows[0]["CBCRPE"].ToString();

            string strSQL
                = @"SELECT CBSTKY,CBCRPE FROM pbinfo WHERE CBSTCO = '洗唛申请人'
                    AND CBCRPE = '" + strBrand + "'";

            m_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取款式季节
        private void GetStyleSeason()
        {
            string strSQL = @"SELECT CBTX40 FROM dbo.PBINFO WHERE CBSTCO='款式季节' " + m_hzyPageInfo.Where;
            m_Return = conn.GetDataSet(strSQL);
        }
        #endregion

        #region 获取版师打版明细数据
        private void GetDetailDataForVODPCSR()
        {
            string strMUser = ds.Tables["list"].Rows[0]["MUser"].ToString();
            string strBrand = ds.Tables["list"].Rows[0]["Brand"].ToString();
            string strPlmSeason = ds.Tables["list"].Rows[0]["PlmSeason"].ToString();
            string strBeginDate = ds.Tables["list"].Rows[0]["BeginDate"].ToString();
            string strEndDate = ds.Tables["list"].Rows[0]["EndDate"].ToString();

            string strWhere = " AND Muser='" + strMUser + "' AND Brand IN('" + strBrand + "')";
            if (strPlmSeason.Trim().Length > 0)
            {
                strWhere += " AND PlmSeason like '%" + strPlmSeason + "%'";
            }
            else
            {
                strWhere += " AND DeliverDate>'" + strBeginDate + "' AND DeliverDate<'" + strEndDate + "'";
            }

            string strSql = @"  SELECT  ProductType , MeasurementsId , Category , Designer
                                FROM    FLEXPLMProduct WITH(NOLOCK)
                                    LEFT JOIN PMINFO WITH(NOLOCK) 
                                        ON FLEXPLMProduct.ProductName = PMINFO.ProductName 
                                WHERE 1=1 " + strWhere + m_hzyPageInfo.Where + " ORDER BY ProductType,Category";
            m_Return = conn.GetDataSet(strSql);
        }

        #endregion

        #endregion
    }
}
