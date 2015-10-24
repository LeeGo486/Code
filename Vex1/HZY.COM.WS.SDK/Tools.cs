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

/// 类名：Tools
/// 类说明：对Tools的CRUD,为Easyui专用
/// 创建人：郭琦琦
/// 创建日期：2014-05-26 
/// 修改人：
/// 修改日期：
/// 修改内容：

namespace HZY.COM.WS.SDK
{
    public class Tools : HZYLogicBase, ILogicGetData
    {
        #region 构造函数
        public Tools()
        {
            this.m_SessionCheck = true;
        }
        #endregion

        #region 内部变量

        private Dbconn m_conn = new Dbconn("HZYSDK1");
        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        DateTime timeNow = DateTime.Now;//取当前时间
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
                string strXML = "";
                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();
                ds = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ToolsInfo".ToUpper())//加载Tool主表数据
                {
                    Get();
                }
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "ToolsEdit".ToUpper())//更新Tool主表数据按照需求取消
                //{
                //    EDIT();
                //}
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "GetDetail".ToUpper())//加载Tool子表数据
                {
                    GetDetail();
                }
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "EDITDetail".ToUpper())//更新Tool子表数据
                {
                    EDITDetail();
                }
                //else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DeleteHead".ToUpper())//删除Tool主表按照需求取消
                //{
                //    DeleteHead();
                //}
                else if (dt_OPTYPE.Rows[0][0].ToString().ToUpper() == "DeleteDetail".ToUpper())//删除Tool子表
                {
                    DeleteDetail();
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

        #region 加载Tool主表数据
        /// <summary>
        /// 加载Tool主表数据
        /// </summary>
        private void Get()
        {
            string strSQL = @"
                        SELECT  t1.* ,
                                ( SELECT TOP 1
                                            t2.PCF_DownLoadURL
                                  FROM      [B01_MDM].PCF_ProductClientFiles t2
                                  WHERE     t1.PDC_ID = t2.PCF_PDC_ID
                                  ORDER BY  PCF_LmDt DESC
                                ) PCF_DownLoadURL
                        FROM    [B01_MDM].PDC_ProductClients t1 
                                WHERE  1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 加载Tool子表数据
        /// <summary>
        /// 加载Tool子表数据
        /// </summary>
        private void GetDetail()
        {
               string strSQL = @"
                                SELECT [PCF_ID]
                                      ,[PCF_PDC_ID]
                                      ,[PCF_Name]
                                      ,[PCF_Version]
                                      ,replace(replace(REPLACE( PCF_Desp,CHAR(9),'    '),char(13),'ㄧ'),char(10),'ㄧ')  [PCF_Desp]
                                      ,[PCF_FileSize]
                                      ,[PCF_DownLoadURL]
                                      ,[PCF_Rgdt]
                                      ,[PCF_RgUser]
                                      ,[PCF_LmDt]
                                      ,[PCF_LmUser]
                                      ,[PCF_UptNo]
                                  FROM [SDK].[B01_MDM].[PCF_ProductClientFiles]
                                  WHERE  1=1 " + m_hzyPageInfo.Where;
            ds_Return = m_conn.GetDataSetForPageList(strSQL, new string[0], m_hzyPageInfo);
        }
        #endregion

        #region 更新Tool主表数据 总监需求取消
        /// <summary>
        /// 更新Tool主表数据
        /// </summary>
        private void EDIT()
        {
            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strTS0_ProductsID = ds.Tables["list"].Rows[0]["ts0_productsid"].ToString();//取工具ID
            string strTS0_Name = ds.Tables["list"].Rows[0]["ts0_name"].ToString();//获取工具名称
            bool bResult = false;
            m_conn.LockTableList.Add("[B01_MDM].[TS0_ToolsHead]");//锁表
            m_conn.BeginTransaction();//开启事务

            if (strTS0_ProductsID == "系统自动生成")//如果工具ID是空，做新增。
            {
                //判断工具名称在数据库是否存在
                int nToolsHeadCount = m_conn.GetDataTableRowCount(@"SELECT * FROM [B01_MDM].[TS0_ToolsHead] WHERE  ts0_name= '" + strTS0_Name + "'");

                if (nToolsHeadCount != 0)//如果nToolsHeadCount = 0 说明存在，返回，如果不为0，不存在，新增
                {
                    throw new Exception("工具名称：" + strTS0_Name + "已经存在，请修改之后再操作！");
                }
                ds.Tables["List"].Rows[0]["ts0_productsid"] = System.Guid.NewGuid().ToString();//后台创建GUID
                //构建新增表
                ds.Tables["list"].Columns.Add("TS0_LmDt");
                ds.Tables["list"].Columns.Add("TS0_LmUser");
                ds.Tables["list"].Columns.Add("TS0_RgDt");
                ds.Tables["list"].Columns.Add("TS0_RgUser");
                ds.Tables["List"].Rows[0]["TS0_RgDt"] = timeNow;
                ds.Tables["List"].Rows[0]["TS0_RgUser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["TS0_LmUser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["TS0_LmDt"] = timeNow;
                bResult = m_conn.Insert("[B01_MDM].[TS0_ToolsHead]", ds.Tables["list"]);
            }
            else
            {
                //判断工具名称在数据库是否存在
                int nToolsHeadCount = m_conn.GetDataTableRowCount(@"SELECT * FROM [B01_MDM].[TS0_ToolsHead] WHERE ts0_productsid != '" + strTS0_ProductsID + "'" + " and ts0_name=" + "'" + strTS0_Name + "'");

                if (nToolsHeadCount != 0)//如果nToolsHeadCount = 0 说明存在，返回，如果不为0，不存在，修改
                {
                    throw new Exception("工具名称：" + strTS0_Name + "已经存在，请修改之后再操作！");
                }
                ds.Tables["list"].Columns.Remove("ts0_productsid");//移除主键
                ds.Tables["list"].Columns.Add("TS0_LmDt");
                ds.Tables["list"].Columns.Add("TS0_LmUser");
                ds.Tables["List"].Rows[0]["TS0_LmDt"] = timeNow;
                ds.Tables["List"].Rows[0]["TS0_LmUser"] = hzyMessage.User_Name_CN;
                bResult = m_conn.Update("[B01_MDM].[TS0_ToolsHead]", ds.Tables["list"], "ts0_productsid='" + strTS0_ProductsID + "'");
            }
            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 更新Tool子表数据
        /// <summary>
        ///更新Tool子表数据
        /// </summary>
        private void EDITDetail()
        {
            DateTime timeNow = DateTime.Now;//取本地当前时间。
            string strPcf_Id = ds.Tables["list"].Rows[0]["pcf_id"].ToString();//取子表GUID
            string strPCF_Version = ds.Tables["list"].Rows[0]["pcf_version"].ToString();//取版本号
            string strPCF_PDC_ID = ds.Tables["list"].Rows[0]["pcf_pdc_id"].ToString();//取产品ID
            bool bResult = false;
            m_conn.LockTableList.Add("[B01_MDM].[PCF_ProductClientFiles]");
            m_conn.BeginTransaction();
            if (strPcf_Id == "系统自动生成" || strPcf_Id == "")//如果GUID为空，新增
            {
                //判断版本号在数据库是否已经存在
                int nToolsDetailCount = m_conn.GetDataTableRowCount(@"SELECT * FROM [B01_MDM].[PCF_ProductClientFiles] WHERE  PCF_Version=" + "'" + strPCF_Version + "'" + " and PCF_PDC_ID=" + "'" + strPCF_PDC_ID + "'");

                if (nToolsDetailCount != 0)//如果不为0，存在， 返回。
                {
                    throw new Exception("版本号：" + strPCF_Version + "已经存在，请修改之后再操作！");
                }
                //构建新增数据
                ds.Tables["list"].Columns.Add("PCF_Rgdt");
                ds.Tables["list"].Columns.Add("PCF_RgUser");
                ds.Tables["list"].Columns.Add("PCF_LmDt");
                ds.Tables["list"].Columns.Add("PCF_LmUser");
                ds.Tables["List"].Rows[0]["PCF_ID"] = System.Guid.NewGuid().ToString();
                ds.Tables["List"].Rows[0]["PCF_LmDt"] = timeNow;
                ds.Tables["List"].Rows[0]["PCF_LmUser"] = hzyMessage.User_Name_CN;
                ds.Tables["List"].Rows[0]["PCF_Rgdt"] = timeNow;
                ds.Tables["List"].Rows[0]["PCF_RgUser"] = hzyMessage.User_Name_CN;
                bResult = m_conn.Insert("[B01_MDM].[PCF_ProductClientFiles]", ds.Tables["list"]);
            }
            else
            {
                //判断版本号在数据库是否已经存在
                int nToolsDetailCount = m_conn.GetDataTableRowCount(@"SELECT * FROM [B01_MDM].[PCF_ProductClientFiles] WHERE PCF_ID != '" + strPcf_Id + "'" + " and PCF_Version=" + "'" + strPCF_Version + "'" + " and PCF_PDC_ID=" + "'" + strPCF_PDC_ID + "'");

                if (nToolsDetailCount != 0)//如果不为0，存在， 返回。
                {
                    throw new Exception("版本号：" + strPCF_Version + "已经存在，请修改之后再操作！");
                }
                //构建修改表
                ds.Tables["list"].Columns.Remove("pcf_id");
                ds.Tables["list"].Columns.Add("PCF_LmDt");
                ds.Tables["list"].Columns.Add("PCF_LmUser");
                ds.Tables["List"].Rows[0]["PCF_LmDt"] = timeNow;
                ds.Tables["List"].Rows[0]["PCF_LmUser"] = hzyMessage.User_Name_CN;
                bResult = m_conn.Update("[B01_MDM].[PCF_ProductClientFiles]", ds.Tables["list"], "PCF_ID='" + strPcf_Id + "'");
            }
            m_conn.CommitTransaction();
            if (bResult)
            {
                dt_EditResult.Rows.Add(new object[] { true, "成功" });
            }
            else
            {
                dt_EditResult.Rows.Add(new object[] { false, "失败" });
            }
            ds_Return.Tables.Add(dt_EditResult);
        }
        #endregion

        #region 删除Tool主表  总监需求取消
        /// <summary>
        ///删除Tool主表
        /// </summary>
        private void DeleteHead()
        {
            string strTS0_ProductsID = ds.Tables["list"].Rows[0]["ts0_productsid"].ToString();//取工具GUID
            bool bResult = false;
            m_conn.LockTableList.Add("[B01_MDM].[TS0_ToolsHead]");
            m_conn.BeginTransaction();

            //检查改工具是否有子表。
            int nToolDetail = m_conn.GetDataTableRowCount("  SELECT *  FROM [B01_MDM].[TS1_ToolsDetail]  WHERE TS1_ProductsID = '" + strTS0_ProductsID + "'");

            if (nToolDetail == 0) //如果没有，删除
            {
                bResult = m_conn.Delete("[B01_MDM].[TS0_ToolsHead]", "TS0_ProductsID='" + strTS0_ProductsID + "'");
            }
            else
            {
                throw new Exception("请先删除明细。");
            }
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

        #region 删除Tool子表
        /// <summary>
        ///删除Tool子表
        /// </summary>
        private void DeleteDetail()
        {
            string strPcf_Id = ds.Tables["list"].Rows[0]["pcf_id"].ToString();//取子表GUID
            bool bResult = false;
            m_conn.LockTableList.Add("[B01_MDM].[PCF_ProductClientFiles]");
            m_conn.BeginTransaction();

            bResult = m_conn.Delete("[B01_MDM].[PCF_ProductClientFiles]", "Pcf_Id='" + strPcf_Id + "'");

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

        #endregion
    }
}