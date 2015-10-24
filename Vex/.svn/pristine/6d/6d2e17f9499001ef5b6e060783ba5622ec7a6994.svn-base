using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.Common.Base;
using HZY.COM.WS.DataSets;


/// 类名：MDM_Lib_ExdPropertyList_GetListByEnitity
/// 类说明：获取MDM实体的属性列表
/// 创建人：马卫清
/// 创建日期：2013-09-10
/// 修改人：
/// 修改日期：
namespace HZY.COM.MDM
{
    /// <summary>
    /// 获取MDM实体的属性列表
    /// </summary>
    public class MDM_Lib_ExdPropertyList_GetListByEnitity : LogicBase, ILogicGetData
    {
        public MDM_Lib_ExdPropertyList_GetListByEnitity()
        {
            this.m_SessionCheck = true;

        }

        private Dbconn conn = new Dbconn("MDM_Master");

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();
        int m_Page = 1;
        int m_Rows = 20;
        /// <summary>
        /// 获取MDM实体的属性列表
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            try
            {
                DataSet ds = new DataSet();
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();


                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                conn.LockTableList.Add("Lib_ExdPropertyList");
                conn.LockTableList.Add("Lib_MDM_Config");
                conn.TableLock();
                conn.BeginTransaction();

                ds = Common.Common.GetDSByExcelXML(strXML);

                DataTable dt_OPTYPE = ds.Tables["OPTYPE"];
                bool bEdit = false;
                for (int i = 0; i < ds.Tables["OPTYPE"].Rows.Count; i++)
                {
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "GET")
                    {
                        if (m_request.Tables[0].Columns.Contains("page"))
                        {
                            m_Page = Convert.ToInt32(m_request.Tables[0].Rows[0]["page"]);
                        }

                        if (m_request.Tables[0].Columns.Contains("pagerows"))
                        {
                            m_Rows = Convert.ToInt32(m_request.Tables[0].Rows[0]["pagerows"]);
                        }

                        DataSet dsTemp = Get(ds.Tables[i + 1]).Copy();
                        for (int j = 0; j < dsTemp.Tables.Count; j++)
                        {
                            ds_Return.Tables.Add(dsTemp.Tables[j].Copy());
                            
                        }
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "INSERT")
                    {
                        bEdit = true;

                        Insert(ds.Tables[i + 1]);
                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                        bEdit = true;
                        Update(ds.Tables[i + 1]);

                    }
                    else if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "DELETE")
                    {
                        bEdit = true;
                        Delete(ds.Tables[i + 1]);
                    }
                }

                if (bEdit)
                {
                    if (dt_EditResult.Rows.Count == 0)
                    {
                        dt_EditResult.Rows.Add(new object[] { true, "修改成功" });
                        conn.CommitTransaction();
                    }
                    else
                    {
                        //期间发生错误，需要回滚
                        conn.RollbackTransaction();
                    }
                    ds_Return.Tables.Add(dt_EditResult.Copy());
                }

                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;

            }
        }

        #region Get 获取数据
        /// <summary>
        /// 获取数据
        /// </summary>
        /// <param name="dtRequest"></param>
        /// <returns></returns>
        private DataSet Get(DataTable dtRequest)
        {
            string strEnitityCode = dtRequest.Rows[0]["实体编号"].ToString();

            if (strEnitityCode == "")
            {
                throw new Exception("实体编号不能为空！");
            }



            DataSet ds = conn.GetDataSetForPageList(@"
                    
                    SELECT  t2.MDM_Content 实体名称 ,
		                    t2.MDM_Entity 实体编号 ,
                            t1.Property_ID 属性编号,        
                            t1.Property_Name 属性名称,
                            t1.Property_Field 字段名称,
                            t1.Value_Field 字段类型,
                            t1.Remark 备注,
                            t1.Timestamps
                    FROM    [MDM_Master].[dbo].[Lib_ExdPropertyList] t1 With(nolock)
                            LEFT JOIN dbo.Lib_MDM_Config t2 With(nolock) ON t1.Class_Name = t2.MDM_Entity
                    WHERE t2.MDM_Entity =@param0 
                ", new string[1] { strEnitityCode }, m_Page, m_Rows, " 属性编号 ");
            return ds;
        }
        #endregion

        #region Delete 删除数据
        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="dtRequest"></param>
        /// <returns></returns>
        private void Delete(DataTable dtRequest)
        {
            string strEnitityCode = dtRequest.Rows[0]["实体编号"].ToString();

            if (strEnitityCode == "")
            {
                throw new Exception("实体编号不能为空！");
            }

            for (int i = 0; i < dtRequest.Rows.Count; i++)
            {
                string str属性编号 = dtRequest.Rows[i]["属性编号"].ToString();

                string[] strParam = new string[1];
                strParam[0] = "@property_ID";

                string[] strValue = new string[1];
                strValue[0] = str属性编号;
                DataSet dstemp = conn.GetDataSetBySP("SP_Delete_Property", strParam, strValue);
                if (dstemp.Tables.Count > 0 && dstemp.Tables[0].Rows.Count > 0)
                {
                    dt_EditResult.Rows.Add(new object[] { false, dstemp.Tables[0].Rows[0][0].ToString() });
                }
            }

        }
        #endregion

        #region Insert 插入数据
        /// <summary>
        /// 插入数据
        /// </summary>
        /// <param name="dtRequest"></param>
        /// <returns></returns>
        private void Insert(DataTable dtRequest)
        {
            //DataTable dt = new DataTable(); 

            for (int i = 0; i < dtRequest.Rows.Count; i++)
            {
                string str实体编号 = dtRequest.Rows[i]["实体编号"].ToString();
                string str属性名称 = dtRequest.Rows[i]["属性名称"].ToString();
                string str字段名称 = dtRequest.Rows[i]["字段名称"].ToString();
                string str字段类型 = dtRequest.Rows[i]["字段类型"].ToString();
                string str备注 = dtRequest.Rows[i]["备注"].ToString();

                if (str实体编号 == "")
                {
                    throw new Exception("实体编号不能为空！");
                }

                CheckValues(str属性名称, str字段类型, str字段类型);

                string[] strParam = new string[6];
                strParam[0] = "@ClassName";
                strParam[1] = "@Property_Name";
                strParam[2] = "@Property_Field";
                strParam[3] = "@Value_Field";
                strParam[4] = "@ColumnIndex";
                strParam[5] = "@Remark";

                string[] strValue = new string[6];
                strValue[0] = str实体编号;
                strValue[1] = str属性名称;
                strValue[2] = str字段名称;
                strValue[3] = str字段类型;
                strValue[4] = "1";
                strValue[5] = str备注;
                DataSet dstemp = conn.GetDataSetBySP("SP_Create_Property", strParam, strValue);
                if (dstemp.Tables.Count > 0 && dstemp.Tables[0].Rows.Count > 0)
                {
                    dt_EditResult.Rows.Add(new object[] { false, dstemp.Tables[0].Rows[0][0].ToString() });
                }
            }

            //return dt;
        }
        #endregion

        #region Update 更新数据
        /// <summary>
        /// 更新数据
        /// </summary>
        /// <param name="dtRequest"></param>
        /// <returns></returns>
        private void Update(DataTable dtRequest)
        {

            for (int i = 0; i < dtRequest.Rows.Count; i++)
            {
                string str属性编号 = dtRequest.Rows[i]["属性编号"].ToString();
                string str属性名称 = dtRequest.Rows[i]["属性名称"].ToString();
                string str字段名称 = dtRequest.Rows[i]["字段名称"].ToString();
                string str字段类型 = dtRequest.Rows[i]["字段类型"].ToString();
                string str备注 = dtRequest.Rows[i]["备注"].ToString();

                if (str属性编号 == "")
                {
                    throw new Exception("属性编号不能为空！");
                }

                CheckValues(str属性名称, str字段类型, str字段类型);

                string[] strParam = new string[6];
                strParam[0] = "@property_ID";
                strParam[1] = "@Property_Name";
                strParam[2] = "@Property_Field";
                strParam[3] = "@Value_Field";
                strParam[4] = "@ColumnIndex";
                strParam[5] = "@Remark";

                string[] strValue = new string[6];
                strValue[0] = str属性编号;
                strValue[1] = str属性名称;
                strValue[2] = str字段名称;
                strValue[3] = str字段类型;
                strValue[4] = "1";
                strValue[5] = str备注;
                DataSet dstemp = conn.GetDataSetBySP("SP_Update_Property", strParam, strValue);
                if (dstemp.Tables.Count > 0 && dstemp.Tables[0].Rows.Count > 0)
                {
                    dt_EditResult.Rows.Add(new object[] { false, dstemp.Tables[0].Rows[0][0].ToString() });
                }

            }

        }
        #endregion

        #region CheckValues
        private void CheckValues(string str属性名称, string str字段名称, string str字段类型)
        {
            if (str属性名称 == "")
            {
                throw new Exception("属性名称不能为空！");
            }

            if (str字段名称 == "")
            {
                throw new Exception("字段名称不能为空！");
            }

            if (str字段类型 == "")
            {
                throw new Exception("字段类型不能为空！");
            }
        }
        #endregion
    }

}