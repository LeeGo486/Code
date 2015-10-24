using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Web.Services;
using System.Collections;

using HZY.COM.Common;
using HZY.COM.Common.DBAccess;
using HZY.COM.WS.DataSets;
using HZY.COM.Common.Base;


/// 类名：MDM2_Organization_CostCenter_Edit
/// 类说明：编辑成本中心信息
/// 创建人：郭琦琦 
/// 创建日期：2014-08-26
/// 修改人：
/// 修改日期：
namespace HZY.COM.WS.MDM2
{
    /// <summary>
    /// 编辑成本中心信息
    /// </summary>
    public class MDM2_Organization_CostCenter_Edit : LogicBase, ILogicGetData
    {
        public MDM2_Organization_CostCenter_Edit()
        {
            this.m_SessionCheck = false;
        }

        private DataTable dt_EditResult = new dsCommon.dtResultDataTable();

        /// <summary>
        /// 编辑成本中心信息
        /// </summary>
        /// <returns></returns>
        public DataSet GetData()
        {
            Dbconn conn = new Dbconn("MDM_Master2");

            try
            {
                DataSet ds_Return = new DataSet();
                DataSet dsRequest = new DataSet();

                string strXML = "";

                strXML = m_request.Tables[0].Rows[0]["XML"].ToString();

                if (strXML == "")
                {
                    throw new Exception("提交的XML为空！");
                }


                DataSet dsXML = Common.Common.GetDSByExcelXML(strXML);
                DataTable dt_OPTYPE = dsXML.Tables["OPTYPE"];
                string strMDM_Class = "0019";

                conn.LockTableList.Add("MDM_0019_B");
                conn.LockTableList.Add("MDM_0019_E");
                conn.BeginTransaction();

                //获取所有属性
                MDM2_GetEntityPropertyList cls = new MDM2_GetEntityPropertyList();
                cls.hzyMessage = this.hzyMessage;
                cls.MainEntity = strMDM_Class;

                DataTable dtPorperty = cls.GetData().Tables[0];

                for (int i = 0; i < dt_OPTYPE.Rows.Count; i++)
                {
                    DataTable dt_List = dsXML.Tables[Common.Common.GetListTableName(i)];
                    if (dt_OPTYPE.Rows[i][0].ToString().ToUpper() == "UPDATE")
                    {
                            string strBody_id = "";
                            strBody_id = dt_List.Rows[0]["body_ID"].ToString();

                            for (int k = 0; k < dt_List.Columns.Count; k++)
                            {
                                string strColumnName = "成本中心ID";
                                if (dtPorperty.Select("Property_Name='" + "成本中心ID" + "'").Length == 0)
                                {
                                    continue;
                                }
                               
                                MDM2_EntityPropertyValue_Edit clsProperty = new MDM2_EntityPropertyValue_Edit();
                                clsProperty.Conn = conn;
                                clsProperty.hzyMessage = hzyMessage;
                                clsProperty.MDMClass = strMDM_Class;
                                clsProperty.ExpressionName = "CN";
                                clsProperty.PropertyName = strColumnName;
                                clsProperty.BodyID = strBody_id;
                                clsProperty.PropertyValue = dt_List.Rows[0]["成本中心ID"].ToString();
                                if (clsProperty.Execute() == false)
                                {
                                    throw new Exception("修改失败，" + clsProperty.Message);
                                }
                            }
                    }
                    else
                    {
                        throw new Exception("提交了错误的操作类型");
                    }
                }

                dt_EditResult.Rows.Add(new object[] { true, "操作成功" });
                ds_Return.Tables.Add(dt_EditResult);
                conn.CommitTransaction();

                return ds_Return;
            }
            catch
            {
                conn.RollbackTransaction();
                throw;

            }
        }
    }

}