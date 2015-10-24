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

/// 类名：HZY.COM.WS.StoreBusinessSystem_3S
/// 类说明：店铺工资条
/// 创建人：郭琦琦
/// 创建日期：2014-10-08 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.StoreBusinessSystem_3S
{
    public class EHRForShopPay : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public EHRForShopPay()
        {
            this.m_SessionCheck = false;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("ShopPAY");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DataSet ds = new DataSet();
        DataSet ds_Return = new DataSet();
        DataSet ds_Return_mdm = new DataSet();

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
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                DataTable dtList = ds.Tables["List"];

                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EHRForShopPay".ToUpper())//店铺薪资条
                {
                    Get(dtList);
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

        #region 薪资
        /// <summary>
        /// 薪资
        /// </summary>
        private void Get(DataTable pdt)
        {

            DataSet ds_ReturnTemp = new DataSet();

            string str身份证号 = pdt.Rows[0]["IdentityCard"].ToString();
            
            string Where = " 1=1 ";

            string str月 = pdt.Rows[0]["month"].ToString();
            string str年 = pdt.Rows[0]["year"].ToString();

            if (str月 == "" || str月 == null && str年 == "" || str年 == null)
            {
                Where = " ORDER BY 年份 desc, 月份 desc ";
            }
            else
            {
                Where = " AND 年份 = '" + str年 + "' AND 月份='" + str月 + "'";
            }

            string strEHRSQL = @"SELECT TOP 1
                                    [ID] ,
                                    [年份] ,
                                    [月份] ,
                                    [部门] ,
                                    [姓名] ,
                                    [工号] ,
                                    [岗位] ,
                                    [身份证号] ,
                                    CASE WHEN 岗位津贴 = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), 岗位津贴), '0')
                                    END 岗位津贴 ,
                                    CASE WHEN 地区津贴 = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), 地区津贴), '0')
                                    END 地区津贴 ,
                                    CASE WHEN [固定加班] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [固定加班]), '0')
                                    END [固定加班] ,
                                    CASE WHEN [学历补贴] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [学历补贴]), '0')
                                    END [学历补贴] ,
                                    CASE WHEN [年度绩效工资] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [年度绩效工资]), '0')
                                    END [年度绩效工资] ,
                                    CASE WHEN [实际完成] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [实际完成]), '0')
                                    END [实际完成] ,
                                    CASE WHEN [个人销售提成] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [个人销售提成]), '0')
                                    END [个人销售提成] ,
                                    CASE WHEN [月度绩效工资] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [月度绩效工资]), '0')
                                    END [月度绩效工资] ,
                                    CASE WHEN [超时加班] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [超时加班]), '0')
                                    END [超时加班] ,
                                    CASE WHEN [节日加班] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [节日加班]), '0')
                                    END [节日加班] ,
                                    CASE WHEN [高单奖] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [高单奖]), '0')
                                    END [高单奖] ,
                                    CASE WHEN [其他项目] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [其他项目]), '0')
                                    END [其他项目] ,
                                    CASE WHEN [应发合计] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [应发合计]), '0')
                                    END [应发合计] ,
                                    CASE WHEN [代扣养老金] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [代扣养老金]), '0')
                                    END [代扣养老金] ,
                                    CASE WHEN [代扣失业金] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [代扣失业金]), '0')
                                    END [代扣失业金] ,
                                    CASE WHEN [代扣医疗] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [代扣医疗]), '0')
                                    END [代扣医疗] ,
                                    CASE WHEN [代扣公积金] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [代扣公积金]), '0')
                                    END [代扣公积金] ,
                                    CASE WHEN [个人所得税] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [个人所得税]), '0')
                                    END [个人所得税] ,
                                    CASE WHEN [互助金] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [互助金]), '0')
                                    END [互助金] ,
                                    CASE WHEN [社保补扣] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [社保补扣]), '0')
                                    END [社保补扣] ,
                                    CASE WHEN [餐贴账扣] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [餐贴账扣]), '0')
                                    END [餐贴账扣] ,
                                    CASE WHEN [其他扣款] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(20, 2), [其他扣款]), '0')
                                    END [其他扣款] ,
                                    实发金额,
                                    CASE WHEN [实发金额] = '' THEN '0.00'
                                         ELSE ISNULL(CONVERT(DECIMAL(38, 2), [实发金额]), '0')
                                    END [实发金额] ,
                                    [CreateName] ,
                                    [CreateDate]
                            FROM    [dbo].[EHRForShopPay]
                                 WHERE   身份证号 = '" + str身份证号 + "'";
            ds_ReturnTemp = m_conn.GetDataSet(strEHRSQL + Where, new string[] { });
            ds_Return = ds_ReturnTemp;
        }
        #endregion



        //        #region 月
        //        /// <summary>
        //        /// 月
        //        /// </summary>
        //        private void GetMonth(DataTable pdt)
        //        {
        //            string strSQL = @"SELECT TOP 5  年份,月份 FROM dbo.EHRForShopPay
        //                              GROUP BY  年份, 月份 
        //                              ORDER BY 年份 desc, 月份 desc";
        //            ds_Return = m_conn.GetDataSet(strSQL, new string[] { });

        //        }
        //        #endregion

        #endregion
    }
}
